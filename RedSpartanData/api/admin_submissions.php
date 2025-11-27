<?php
/**
 * Admin Submissions API
 * Handles admin viewing and management of user report submissions
 */

// Disable error display and log errors instead
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL);

// Start session FIRST before any output
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Set headers (but only if this isn't an export request)
$action = $_GET['action'] ?? '';
if ($action !== 'export') {
    header('Content-Type: application/json');
}
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../includes/functions.php';

// Ensure session cookie is sent with requests
ini_set('session.cookie_httponly', 1);
ini_set('session.use_only_cookies', 1);

class AdminSubmissionsAPI {
    private $db;
    
    public function __construct() {
        try {
            $this->db = getDB();
        } catch (Exception $e) {
            $this->sendError('Database connection failed', 500);
        }
    }

    /**
     * Delete a specific row from target table (admin only)
     */
    public function deleteRow() {
        $admin = $this->checkAdminAuth();

        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->sendError('Method not allowed', 405);
        }

        $input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
        $tableName = $input['table_name'] ?? null;
        $rowId = isset($input['row_id']) ? (int)$input['row_id'] : 0;
        
        if (!$tableName || $rowId <= 0) {
            $this->sendError('Table name and row ID are required');
        }

        try {
            $this->db->beginTransaction();

            // Check if target table exists
            $tableCheck = $this->db->query("SHOW TABLES LIKE '$tableName'");
            if ($tableCheck->rowCount() === 0) {
                $this->db->rollBack();
                $this->sendError("Target table '$tableName' does not exist", 404);
            }

            // Verify the row exists
            $checkStmt = $this->db->prepare("SELECT id FROM `$tableName` WHERE id = ? FOR UPDATE");
            $checkStmt->execute([$rowId]);
            $row = $checkStmt->fetch(PDO::FETCH_ASSOC);
            
            if (!$row) {
                $this->db->rollBack();
                $this->sendError('Row not found', 404);
            }

            // Delete the specific row
            $delStmt = $this->db->prepare("DELETE FROM `$tableName` WHERE id = ?");
            $delStmt->execute([$rowId]);

            if ($delStmt->rowCount() === 0) {
                $this->db->rollBack();
                $this->sendError('Failed to delete row', 500);
            }

            $this->db->commit();
            error_log("✓ Deleted row ID $rowId from table $tableName");
            $this->sendSuccess([ 'message' => 'Row deleted successfully', 'row_id' => $rowId, 'table' => $tableName ]);
        } catch (Exception $e) {
            if ($this->db->inTransaction()) $this->db->rollBack();
            error_log('Delete row error: ' . $e->getMessage());
            $this->sendError('Failed to delete row: ' . $e->getMessage(), 500);
        }
    }

    /**
     * Delete a submission and its data (admin only)
     */
    public function deleteSubmission() {
        $admin = $this->checkAdminAuth();

        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->sendError('Method not allowed', 405);
        }

        $input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
        $submissionId = isset($input['submission_id']) ? (int)$input['submission_id'] : 0;
        if ($submissionId <= 0) {
            $this->sendError('Submission ID required');
        }

        try {
            $this->db->beginTransaction();

            // Check what columns exist in report_submissions table
            $columnsResult = $this->db->query("DESCRIBE report_submissions");
            $columns = $columnsResult->fetchAll(PDO::FETCH_COLUMN);
            
            // Determine which columns to select based on what exists
            $selectFields = ['id'];
            
            // Add campus if it exists
            if (in_array('campus', $columns)) {
                $selectFields[] = 'campus';
            }
            
            // Add table_name or report_type (depending on what exists)
            if (in_array('table_name', $columns)) {
                $selectFields[] = 'table_name';
            } elseif (in_array('report_type', $columns)) {
                $selectFields[] = 'report_type as table_name';
            }
            
            // Get submission_date and office for matching
            $submissionDateCol = in_array('submission_date', $columns) ? 'submission_date' : 
                                (in_array('submitted_at', $columns) ? 'submitted_at' : 'created_at');
            $officeCol = in_array('office', $columns) ? 'office' : 'NULL';
            
            $selectFields[] = $submissionDateCol;
            if ($officeCol !== 'NULL') {
                $selectFields[] = $officeCol;
            }
            
            // Verify the submission exists and, for campus admins, belongs to an accessible campus
            $sql = "SELECT " . implode(', ', $selectFields) . " FROM report_submissions WHERE id = ? FOR UPDATE";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$submissionId]);
            $submission = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!$submission) {
                $this->db->rollBack();
                $this->sendError('Submission not found', 404);
            }

            // If not super admin, enforce campus scope (only if campus column exists)
            $role = strtolower(trim($admin['role'] ?? ''));
            if ($role !== 'super_admin' && in_array('campus', $columns)) {
                $accessible = $this->getAccessibleCampuses($admin['campus'] ?? '');
                if (!empty($accessible)) {
                    $subCampus = trim((string)($submission['campus'] ?? ''));
                    if ($subCampus !== '' && !in_array($subCampus, $accessible, true)) {
                        $this->db->rollBack();
                        $this->sendError('Forbidden: submission not within your campus scope', 403);
                    }
                }
            }

            // Delete from target table (e.g., admissiondata, enrollmentdata) FIRST
            $tableName = $submission['table_name'] ?? null;
            $submissionDate = $submission[$submissionDateCol] ?? $submission['submission_date'] ?? $submission['created_at'] ?? null;
            $submissionCampus = $submission['campus'] ?? null;
            $submissionOffice = $submission['office'] ?? null;
            
            // Try to get the exact batch_id from report_submission_data (if available)
            // All rows in the same submission have the same batch_id
            $exactBatchId = null;
            try {
                $batchCheck = $this->db->prepare("SELECT row_data FROM report_submission_data WHERE submission_id = ? LIMIT 1");
                $batchCheck->execute([$submissionId]);
                $batchRow = $batchCheck->fetch(PDO::FETCH_ASSOC);
                if ($batchRow) {
                    $decoded = json_decode($batchRow['row_data'], true);
                    if ($decoded && isset($decoded['batch_id'])) {
                        $exactBatchId = $decoded['batch_id'];
                        error_log("Found exact batch_id from report_submission_data: $exactBatchId");
                    } elseif ($decoded && isset($decoded['Batch ID'])) {
                        $exactBatchId = $decoded['Batch ID'];
                        error_log("Found exact batch_id from report_submission_data (Batch ID): $exactBatchId");
                    }
                }
            } catch (Exception $e) {
                error_log("Could not fetch batch_id from report_submission_data: " . $e->getMessage());
            }
            
            if ($tableName && $tableName !== 'unknown') {
                try {
                    // Check if target table exists
                    $tableCheck = $this->db->query("SHOW TABLES LIKE '$tableName'");
                    if ($tableCheck->rowCount() > 0) {
                        // Get columns in the target table
                        $columnsCheck = $this->db->query("SHOW COLUMNS FROM `$tableName`");
                        $targetColumns = [];
                        while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
                            $targetColumns[] = $col['Field'];
                        }
                        
                        // Build DELETE query for target table
                        $whereConditions = [];
                        $whereParams = [];
                        
                        // Priority 1: Check if submission_id column exists (direct link)
                        if (in_array('submission_id', $targetColumns)) {
                            $whereConditions[] = "submission_id = ?";
                            $whereParams[] = $submissionId;
                            error_log("Deleting from target table $tableName using submission_id: $submissionId");
                        } else {
                            // Priority 2: Match by exact batch_id if we have it
                            if (in_array('batch_id', $targetColumns) && $exactBatchId) {
                                // Use exact batch_id for precise matching (all rows from same submission have same batch_id)
                                $whereConditions[] = "batch_id = ?";
                                $whereParams[] = $exactBatchId;
                                error_log("Deleting from target table $tableName using exact batch_id: $exactBatchId");
                            } elseif (in_array('batch_id', $targetColumns) && $submissionDate) {
                                // Fallback: Match by batch_id pattern if we don't have exact batch_id
                                // All records in the same submission have the same batch_id (format: YmdHis_uniqid_office)
                                $datePattern = date('YmdHis', strtotime($submissionDate));
                                
                                // Match by date prefix AND office if office matches
                                // This ensures we get ALL records from the same submission batch
                                if ($submissionOffice) {
                                    // More specific: match by date prefix and office suffix
                                    $whereConditions[] = "(batch_id LIKE ? AND batch_id LIKE ?)";
                                    $whereParams[] = $datePattern . '%';
                                    $whereParams[] = '%_' . $submissionOffice;
                                    error_log("Deleting from target table $tableName using batch_id pattern: $datePattern% and office: $submissionOffice");
                                } else {
                                    // Fallback: just match by date prefix (should still work)
                                    $whereConditions[] = "batch_id LIKE ?";
                                    $whereParams[] = $datePattern . '%';
                                    error_log("Deleting from target table $tableName using batch_id pattern: " . $datePattern . '%');
                                }
                            }
                            
                            // Priority 3: Match by submission date (within 2 minutes window) as additional filter
                            if ($submissionDate && !$exactBatchId) {
                                $dateCol = null;
                                if (in_array('submitted_at', $targetColumns)) {
                                    $dateCol = 'submitted_at';
                                } elseif (in_array('submission_date', $targetColumns)) {
                                    $dateCol = 'submission_date';
                                } elseif (in_array('created_at', $targetColumns)) {
                                    $dateCol = 'created_at';
                                }
                                
                                if ($dateCol) {
                                    $submissionTimestamp = strtotime($submissionDate);
                                    $startDate = date('Y-m-d H:i:s', $submissionTimestamp - 120);
                                    $endDate = date('Y-m-d H:i:s', $submissionTimestamp + 120);
                                    $whereConditions[] = "$dateCol BETWEEN ? AND ?";
                                    $whereParams[] = $startDate;
                                    $whereParams[] = $endDate;
                                }
                            }
                            
                            // Additional filters to narrow down results
                            if ($submissionCampus && in_array('campus', $targetColumns)) {
                                $whereConditions[] = "campus = ?";
                                $whereParams[] = $submissionCampus;
                            }
                            
                            if ($submissionOffice && in_array('office', $targetColumns)) {
                                $whereConditions[] = "office = ?";
                                $whereParams[] = $submissionOffice;
                            }
                        }
                        
                        if (!empty($whereConditions)) {
                            $whereClause = implode(' AND ', $whereConditions);
                            $deleteQuery = "DELETE FROM `$tableName` WHERE $whereClause";
                            
                            error_log("Deleting from target table $tableName with query: $deleteQuery");
                            error_log("Params: " . print_r($whereParams, true));
                            
                            $delTargetStmt = $this->db->prepare($deleteQuery);
                            $delTargetStmt->execute($whereParams);
                            $deletedRows = $delTargetStmt->rowCount();
                            
                            error_log("✓ Deleted $deletedRows rows from target table $tableName");
                        } else {
                            error_log("Warning: No matching conditions found to delete from target table $tableName");
                        }
                    } else {
                        error_log("Target table $tableName does not exist, skipping deletion from target table");
                    }
                } catch (Exception $e) {
                    error_log("Error deleting from target table $tableName: " . $e->getMessage());
                    // Continue with deletion from report_submission_data even if target table deletion fails
                }
            }

            // Delete child data rows from report_submission_data (backup table)
            $delData = $this->db->prepare("DELETE FROM report_submission_data WHERE submission_id = ?");
            $delData->execute([$submissionId]);
            $deletedBackupRows = $delData->rowCount();
            error_log("Deleted $deletedBackupRows rows from report_submission_data");

            // Delete the submission record
            $delSub = $this->db->prepare("DELETE FROM report_submissions WHERE id = ?");
            $delSub->execute([$submissionId]);

            if ($delSub->rowCount() === 0) {
                $this->db->rollBack();
                $this->sendError('Failed to delete submission', 500);
            }

            $this->db->commit();
            $this->sendSuccess([ 'message' => 'Submission deleted', 'id' => $submissionId ]);
        } catch (Exception $e) {
            if ($this->db->inTransaction()) $this->db->rollBack();
            error_log('Delete submission error: ' . $e->getMessage());
            $this->sendError('Failed to delete submission: ' . $e->getMessage(), 500);
        }
    }

    /**
     * Check admin authentication and get admin info
     */
    private function checkAdminAuth() {
        // Check if user is logged in
        if (!isset($_SESSION['user_id'])) {
            error_log('No user_id in session');
            $this->sendError('Not logged in', 401);
        }
        
        $userId = $_SESSION['user_id'];
        // Check multiple possible session variable names for role
        $userRole = $_SESSION['user_role'] ?? $_SESSION['role'] ?? null;
        
        // Get user info from database
        $stmt = $this->db->prepare("
            SELECT id, name, username, role, campus, office, status
            FROM users 
            WHERE id = ? AND status = 'active'
        ");
        $stmt->execute([$userId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$user) {
            error_log('User not found. User ID: ' . $userId);
            $this->sendError('User not found', 401);
        }
        
        // Verify user has admin role (check both session and database)
        $dbRole = strtolower(trim($user['role'] ?? ''));
        $sessionRole = $userRole ? strtolower(trim($userRole)) : '';
        
        // Check for admin roles (case-insensitive, with variations)
        $isAdmin = in_array($dbRole, ['admin', 'super_admin', 'administrator']) || 
                   in_array($sessionRole, ['admin', 'super_admin', 'administrator']);
        
        if (!$isAdmin) {
            error_log('SECURITY: Unauthorized access attempt blocked. User ID: ' . $userId . ', DB Role: "' . $dbRole . '", Session Role: "' . $sessionRole . '"');
            error_log('Session data: user_id=' . ($_SESSION['user_id'] ?? 'not set') . ', user_role=' . ($_SESSION['user_role'] ?? 'not set') . ', role=' . ($_SESSION['role'] ?? 'not set'));
            $this->sendError('Unauthorized access - Admin only. Your role: ' . ($dbRole ?: 'not set') . '. Only users with admin, super_admin, or administrator roles can access this feature.', 401);
        }
        
        // Double-check: Verify user is still active (defense in depth)
        if (strtolower($user['status'] ?? '') !== 'active') {
            error_log('SECURITY: Inactive user attempted access. User ID: ' . $userId);
            $this->sendError('Account is not active', 403);
        }
        
        return $user;
    }

    /**
     * Get accessible campuses for an admin based on their campus
     * Returns array of campus names the admin can access
     */
    private function getAccessibleCampuses($adminCampus) {
        if (!$adminCampus) {
            return [];
        }

        $campus = trim($adminCampus);
        
        // Pablo Borbon admin can access: Pablo Borbon, Rosario, San Juan, Lemery
        if ($campus === 'Pablo Borbon') {
            return ['Pablo Borbon', 'Rosario', 'San Juan', 'Lemery'];
        }
        
        // Alangilan admin can access: Alangilan, Lobo, Balayan, Mabini
        if ($campus === 'Alangilan') {
            return ['Alangilan', 'Lobo', 'Balayan', 'Mabini'];
        }
        
        // Solo campuses: Lipa, Malvar, Nasugbu - just their own campus
        if (in_array($campus, ['Lipa', 'Malvar', 'Nasugbu'])) {
            return [$campus];
        }
        
        // Default: return own campus only
        return [$campus];
    }

    /**
     * List all submissions (filtered by campus for regular admins)
     */
    public function listSubmissions() {
        $admin = $this->checkAdminAuth();
        
        // Add debugging
        error_log('Listing submissions for admin: ' . ($admin['username'] ?? $admin['name']) . ', campus: ' . ($admin['campus'] ?? 'N/A') . ', role: ' . ($admin['role'] ?? 'N/A'));
        
        // Super admins can see all submissions, regular admins only see their campus
        if ($admin['role'] === 'super_admin') {
            $sql = "
                SELECT 
                    rs.id,
                    rs.table_name,
                    rs.campus,
                    rs.office,
                    rs.description,
                    rs.submission_date,
                    rs.status,
                    u.name as user_name,
                    u.username as user_email,
                    COUNT(rsd.id) as record_count
                FROM report_submissions rs
                LEFT JOIN report_submission_data rsd ON rs.id = rsd.submission_id
                LEFT JOIN users u ON rs.user_id = u.id
                GROUP BY rs.id
                ORDER BY rs.submission_date DESC
            ";
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
        } else {
            // Regular admin - filter by accessible campuses
            $accessibleCampuses = $this->getAccessibleCampuses($admin['campus']);
            
            if (empty($accessibleCampuses)) {
                // No accessible campuses, return empty
                $this->sendSuccess([
                    'submissions' => [],
                    'admin_campus' => $admin['campus'],
                    'admin_role' => $admin['role']
                ]);
                return;
            }
            
            // Build placeholders for IN clause
            $placeholders = implode(',', array_fill(0, count($accessibleCampuses), '?'));
            
            $sql = "
                SELECT 
                    rs.id,
                    rs.table_name,
                    rs.campus,
                    rs.office,
                    rs.description,
                    rs.submission_date,
                    rs.status,
                    u.name as user_name,
                    u.username as user_email,
                    COUNT(rsd.id) as record_count
                FROM report_submissions rs
                LEFT JOIN report_submission_data rsd ON rs.id = rsd.submission_id
                LEFT JOIN users u ON rs.user_id = u.id
                WHERE rs.campus IN ($placeholders) OR rs.campus IS NULL
                GROUP BY rs.id
                ORDER BY rs.submission_date DESC
            ";
            $stmt = $this->db->prepare($sql);
            $stmt->execute($accessibleCampuses);
        }
        
        $submissions = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        error_log('Found submissions: ' . count($submissions));

        $this->sendSuccess([
            'submissions' => $submissions,
            'admin_campus' => $admin['campus'],
            'admin_role' => $admin['role']
        ]);
    }

    /**
     * Get all report submissions
     */
    public function getSubmissions() {
        $this->checkAdminAuth();

        try {
            // Check what columns exist in report_submissions table
            $columnsResult = $this->db->query("DESCRIBE report_submissions");
            $columns = $columnsResult->fetchAll(PDO::FETCH_COLUMN);
            
            // Determine which columns to use
            $userIdCol = in_array('user_id', $columns) ? 'rs.user_id' : (in_array('submitted_by', $columns) ? 'rs.submitted_by' : 'NULL');
            $tableNameCol = in_array('table_name', $columns) ? 'rs.table_name' : (in_array('report_type', $columns) ? 'rs.report_type' : 'NULL');
            $campusCol = in_array('campus', $columns) ? 'rs.campus' : 'NULL';
            $officeCol = in_array('office', $columns) ? 'rs.office' : 'NULL';
            $descCol = in_array('description', $columns) ? 'rs.description' : 'NULL';
            $submissionDateCol = in_array('submission_date', $columns) ? 'rs.submission_date' : (in_array('submitted_at', $columns) ? 'rs.submitted_at' : 'rs.created_at');
            $statusCol = in_array('status', $columns) ? 'rs.status' : "'pending'";
            
            $sql = "SELECT 
                        rs.id,
                        $tableNameCol as table_name,
                        $campusCol as campus,
                        $officeCol as office,
                        $descCol as description,
                        $submissionDateCol as submission_date,
                        $statusCol as status,
                        $userIdCol as user_id,
                        COALESCE(u.name, 'Unknown User') as user_name,
                        COALESCE(u.username, 'N/A') as user_email,
                        COUNT(rsd.id) as record_count
                    FROM report_submissions rs
                    LEFT JOIN users u ON $userIdCol = u.id
                    LEFT JOIN report_submission_data rsd ON rs.id = rsd.submission_id
                    GROUP BY rs.id
                    ORDER BY $submissionDateCol DESC";
            
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $submissions = $stmt->fetchAll(PDO::FETCH_ASSOC);

            error_log("Fetched " . count($submissions) . " submissions");
            error_log("User ID column used: $userIdCol");
            if (count($submissions) > 0) {
                error_log("Sample submission user_id: " . ($submissions[0]['user_id'] ?? 'NULL'));
                error_log("Sample submission user_name: " . ($submissions[0]['user_name'] ?? 'NULL'));
            }

            $this->sendSuccess($submissions);

        } catch (Exception $e) {
            error_log("Get submissions error: " . $e->getMessage());
            $this->sendError('Failed to fetch submissions: ' . $e->getMessage());
        }
    }

    /**
     * Get specific submission details with data
     */
    public function getSubmissionDetails() {
        $this->checkAdminAuth();

        $submissionId = $_GET['submission_id'] ?? null;
        
        if (!$submissionId) {
            $this->sendError('Submission ID required');
        }

        try {
            // Check columns
            $columnsResult = $this->db->query("DESCRIBE report_submissions");
            $columns = $columnsResult->fetchAll(PDO::FETCH_COLUMN);
            $userIdCol = in_array('user_id', $columns) ? 'rs.user_id' : (in_array('submitted_by', $columns) ? 'rs.submitted_by' : 'NULL');
            
            // Get submission info
            $sql = "SELECT 
                        rs.*,
                        COALESCE(u.name, 'Unknown User') as user_name,
                        COALESCE(u.username, 'N/A') as user_email
                    FROM report_submissions rs
                    LEFT JOIN users u ON $userIdCol = u.id
                    WHERE rs.id = ?";
            
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$submissionId]);
            $submission = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$submission) {
                $this->sendError('Submission not found', 404);
            }

            // Get table name and submission metadata
            $tableName = $submission['table_name'] ?? $submission['report_type'] ?? 'unknown';
            $submissionDate = $submission['submission_date'] ?? $submission['submitted_at'] ?? $submission['created_at'] ?? null;
            $submissionCampus = $submission['campus'] ?? null;
            $submissionOffice = $submission['office'] ?? null;
            
            // Fetch data from the actual report table (NOT from report_submission_data)
            $dataRows = [];
            
            if ($tableName && $tableName !== 'unknown') {
                try {
                    // Check if target table exists
                    $tableCheck = $this->db->query("SHOW TABLES LIKE '$tableName'");
                    if ($tableCheck->rowCount() > 0) {
                        // Get columns in the target table
                        $columnsCheck = $this->db->query("SHOW COLUMNS FROM `$tableName`");
                        $targetColumns = [];
                        while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
                            $targetColumns[] = $col['Field'];
                        }
                        
                        // Build query to fetch rows from target table
                        $whereConditions = [];
                        $whereParams = [];
                        
                        // Priority 1: Check if submission_id column exists (direct link)
                        if (in_array('submission_id', $targetColumns)) {
                            $whereConditions[] = "submission_id = ?";
                            $whereParams[] = $submissionId;
                        } else {
                            // Priority 2: Match by batch_id if it exists
                            if (in_array('batch_id', $targetColumns) && $submissionDate) {
                                $datePattern = date('YmdHis', strtotime($submissionDate));
                                $whereConditions[] = "batch_id LIKE ?";
                                $whereParams[] = $datePattern . '%';
                            }
                            
                            // Priority 3: Match by submission date (within 2 minutes window)
                            if ($submissionDate) {
                                $dateCol = null;
                                if (in_array('submitted_at', $targetColumns)) {
                                    $dateCol = 'submitted_at';
                                } elseif (in_array('submission_date', $targetColumns)) {
                                    $dateCol = 'submission_date';
                                } elseif (in_array('created_at', $targetColumns)) {
                                    $dateCol = 'created_at';
                                }
                                
                                if ($dateCol) {
                                    $submissionTimestamp = strtotime($submissionDate);
                                    $startDate = date('Y-m-d H:i:s', $submissionTimestamp - 120);
                                    $endDate = date('Y-m-d H:i:s', $submissionTimestamp + 120);
                                    $whereConditions[] = "$dateCol BETWEEN ? AND ?";
                                    $whereParams[] = $startDate;
                                    $whereParams[] = $endDate;
                                }
                            }
                            
                            // Additional filters to narrow down results
                            if ($submissionCampus && in_array('campus', $targetColumns)) {
                                $whereConditions[] = "campus = ?";
                                $whereParams[] = $submissionCampus;
                            }
                            
                            if ($submissionOffice && in_array('office', $targetColumns)) {
                                $whereConditions[] = "office = ?";
                                $whereParams[] = $submissionOffice;
                            }
                        }
                        
                        if (!empty($whereConditions)) {
                            $whereClause = implode(' AND ', $whereConditions);
                            $targetQuery = "SELECT * FROM `$tableName` WHERE $whereClause ORDER BY id ASC";
                            
                            $targetStmt = $this->db->prepare($targetQuery);
                            $targetStmt->execute($whereParams);
                            $dataRows = $targetStmt->fetchAll(PDO::FETCH_ASSOC);
                            
                            error_log("✓ Fetched " . count($dataRows) . " rows from target table $tableName for submission $submissionId");
                        } else {
                            error_log("No matching conditions found for target table $tableName - submission data may have been deleted");
                            // Return empty data if no matches found (data was deleted)
                            $dataRows = [];
                        }
                    } else {
                        error_log("Target table $tableName does not exist for submission $submissionId");
                        // Return empty data if target table doesn't exist
                        $dataRows = [];
                    }
                } catch (Exception $e) {
                    error_log("Error fetching from target table $tableName: " . $e->getMessage());
                    // Return empty data on error (don't fall back to report_submission_data)
                    $dataRows = [];
                }
            } else {
                error_log("Table name is unknown for submission $submissionId");
                // Return empty data if table name is unknown
                $dataRows = [];
            }
            
            // DO NOT fall back to report_submission_data - only use data from target tables
            // This ensures deleted data doesn't appear
            
            $submission['data'] = $dataRows;

            error_log("Fetched submission details for ID: $submissionId with " . count($dataRows) . " data rows from target table");

            $this->sendSuccess($submission);

        } catch (Exception $e) {
            error_log("Get submission details error: " . $e->getMessage());
            $this->sendError('Failed to fetch submission details: ' . $e->getMessage());
        }
    }

    /**
     * Export submission to CSV
     */
    public function exportSubmission() {
        // Allow anyone logged in to export - no role restriction
        // Just check if user is logged in
        if (!isset($_SESSION['user_id'])) {
            $this->sendError('Not logged in', 401);
        }
        
        $userId = $_SESSION['user_id'];
        
        // Get user info for logging (optional)
        try {
            $stmt = $this->db->prepare("SELECT id, name, username, role FROM users WHERE id = ?");
            $stmt->execute([$userId]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            
            // Log export attempt (for auditing purposes)
            if ($user) {
                error_log("Export attempt by user ID: " . ($user['id'] ?? 'unknown') . ", Role: " . ($user['role'] ?? 'unknown') . ", Username: " . ($user['username'] ?? $user['name'] ?? 'unknown'));
            }
        } catch (Exception $e) {
            // Log error but don't block export
            error_log("Error fetching user info for export: " . $e->getMessage());
        }

        $submissionId = $_GET['submission_id'] ?? null;
        
        if (!$submissionId) {
            $this->sendError('Submission ID required');
        }

        try {
            // Check which columns exist in report_submissions table
            $columnsResult = $this->db->query("DESCRIBE report_submissions");
            $columns = $columnsResult->fetchAll(PDO::FETCH_COLUMN);
            
            // Determine which columns to use
            $userIdCol = in_array('user_id', $columns) ? 'rs.user_id' : (in_array('submitted_by', $columns) ? 'rs.submitted_by' : 'NULL');
            $tableNameCol = in_array('table_name', $columns) ? 'rs.table_name' : (in_array('report_type', $columns) ? 'rs.report_type' : 'NULL');
            $campusCol = in_array('campus', $columns) ? 'rs.campus' : 'NULL';
            $officeCol = in_array('office', $columns) ? 'rs.office' : 'NULL';
            $descCol = in_array('description', $columns) ? 'rs.description' : 'NULL';
            $submissionDateCol = in_array('submission_date', $columns) ? 'rs.submission_date' : (in_array('submitted_at', $columns) ? 'rs.submitted_at' : 'rs.created_at');
            
            // Get submission info
            $sql = "SELECT 
                        rs.id,
                        rs.status,
                        COALESCE(u.name, 'Unknown User') as user_name,
                        COALESCE(u.username, 'N/A') as user_email,
                        $tableNameCol as table_name,
                        $campusCol as campus,
                        $officeCol as office,
                        $descCol as description,
                        $submissionDateCol as submission_date
                    FROM report_submissions rs
                    LEFT JOIN users u ON $userIdCol = u.id
                    WHERE rs.id = ?";
            
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$submissionId]);
            $submission = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$submission) {
                $this->sendError('Submission not found', 404);
            }

            // Get table name and submission metadata
            $tableName = $submission['table_name'] ?? 'unknown';
            $submissionDate = $submission['submission_date'] ?? null;
            $submissionCampus = $submission['campus'] ?? null;
            $submissionOffice = $submission['office'] ?? null;
            
            // Fetch data from the actual report table (NOT from report_submission_data)
            $dataRows = [];
            
            if ($tableName && $tableName !== 'unknown') {
                try {
                    // Check if target table exists
                    $tableCheck = $this->db->query("SHOW TABLES LIKE '$tableName'");
                    if ($tableCheck->rowCount() > 0) {
                        // Get columns in the target table
                        $columnsCheck = $this->db->query("SHOW COLUMNS FROM `$tableName`");
                        $targetColumns = [];
                        while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
                            $targetColumns[] = $col['Field'];
                        }
                        
                        // Build query to fetch rows from target table
                        $whereConditions = [];
                        $whereParams = [];
                        
                        // Priority 1: Check if submission_id column exists
                        if (in_array('submission_id', $targetColumns)) {
                            $whereConditions[] = "submission_id = ?";
                            $whereParams[] = $submissionId;
                        } else {
                            // Priority 2: Match by batch_id
                            if (in_array('batch_id', $targetColumns) && $submissionDate) {
                                $datePattern = date('YmdHis', strtotime($submissionDate));
                                $whereConditions[] = "batch_id LIKE ?";
                                $whereParams[] = $datePattern . '%';
                            }
                            
                            // Priority 3: Match by submission date
                            if ($submissionDate) {
                                $dateCol = null;
                                if (in_array('submitted_at', $targetColumns)) {
                                    $dateCol = 'submitted_at';
                                } elseif (in_array('submission_date', $targetColumns)) {
                                    $dateCol = 'submission_date';
                                } elseif (in_array('created_at', $targetColumns)) {
                                    $dateCol = 'created_at';
                                }
                                
                                if ($dateCol) {
                                    $submissionTimestamp = strtotime($submissionDate);
                                    $startDate = date('Y-m-d H:i:s', $submissionTimestamp - 120);
                                    $endDate = date('Y-m-d H:i:s', $submissionTimestamp + 120);
                                    $whereConditions[] = "$dateCol BETWEEN ? AND ?";
                                    $whereParams[] = $startDate;
                                    $whereParams[] = $endDate;
                                }
                            }
                            
                            // Additional filters
                            if ($submissionCampus && in_array('campus', $targetColumns)) {
                                $whereConditions[] = "campus = ?";
                                $whereParams[] = $submissionCampus;
                            }
                            
                            if ($submissionOffice && in_array('office', $targetColumns)) {
                                $whereConditions[] = "office = ?";
                                $whereParams[] = $submissionOffice;
                            }
                        }
                        
                        if (!empty($whereConditions)) {
                            $whereClause = implode(' AND ', $whereConditions);
                            $targetQuery = "SELECT * FROM `$tableName` WHERE $whereClause ORDER BY id ASC";
                            
                            $targetStmt = $this->db->prepare($targetQuery);
                            $targetStmt->execute($whereParams);
                            $dataRows = $targetStmt->fetchAll(PDO::FETCH_ASSOC);
                        }
                    }
                } catch (Exception $e) {
                    error_log("Error fetching from target table $tableName for export: " . $e->getMessage());
                }
            }
            
            // DO NOT fall back to report_submission_data - only export data from target tables
            if (empty($dataRows)) {
                $this->sendError('No data found for this submission (data may have been deleted from target table)');
            }

            // Prepare CSV filename - handle missing submission_date gracefully
            $datePart = isset($submission['submission_date']) && $submission['submission_date'] 
                ? date('Y-m-d', strtotime($submission['submission_date'])) 
                : date('Y-m-d');
            $filename = ($submission['table_name'] ?? 'report') . '_' . ($submission['campus'] ?? 'unknown') . '_' . $datePart . '.csv';
            
            // Clear any previous headers and set CSV headers
            header_remove('Content-Type'); // Remove JSON header set at top of file
            header('Content-Type: text/csv; charset=utf-8');
            header('Content-Disposition: attachment; filename="' . $filename . '"');
            header('Cache-Control: no-cache, must-revalidate');
            header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');

            // Output UTF-8 BOM for Excel compatibility
            echo "\xEF\xBB\xBF";

            $output = fopen('php://output', 'w');

            // Add metadata header
            fputcsv($output, ['Report Information']);
            fputcsv($output, ['Table Name', $submission['table_name'] ?? 'N/A']);
            fputcsv($output, ['Campus', $submission['campus'] ?? 'N/A']);
            fputcsv($output, ['Office', $submission['office'] ?? 'N/A']);
            fputcsv($output, ['Submitted By', $submission['user_name'] . ' (' . $submission['user_email'] . ')']);
            fputcsv($output, ['Submission Date', $submission['submission_date'] ?? 'N/A']);
            fputcsv($output, ['Description', $submission['description'] ?? 'N/A']);
            fputcsv($output, []);
            fputcsv($output, ['Data Records']);

            // Get column headers from first row (dataRows now contains actual database rows, not JSON)
            if (!empty($dataRows) && is_array($dataRows[0])) {
                // Filter out metadata columns for CSV output
                $columnsToHide = ['id', 'batch_id', 'submission_id', 'submitted_by', 'submitted_at', 'created_at', 'updated_at'];
                $firstRow = $dataRows[0];
                $headers = [];
                $headerOrder = [];
                
                // Determine header order (prioritize common report columns)
                $commonOrder = ['Campus', 'Semester', 'Academic Year', 'Academic_year', 'Category', 'Program', 'Male', 'Female'];
                foreach ($commonOrder as $col) {
                    foreach (array_keys($firstRow) as $key) {
                        if (strcasecmp($key, $col) === 0 && !in_array(strtolower($key), array_map('strtolower', $columnsToHide))) {
                            if (!in_array($key, $headerOrder)) {
                                $headerOrder[] = $key;
                            }
                        }
                    }
                }
                
                // Add remaining columns
                foreach (array_keys($firstRow) as $key) {
                    if (!in_array(strtolower($key), array_map('strtolower', $columnsToHide)) && !in_array($key, $headerOrder)) {
                        $headerOrder[] = $key;
                    }
                }
                
                fputcsv($output, $headerOrder);

                // Add data rows
                foreach ($dataRows as $row) {
                    $rowValues = [];
                    foreach ($headerOrder as $header) {
                        $rowValues[] = $row[$header] ?? '';
                    }
                    fputcsv($output, $rowValues);
                }
            }

            fclose($output);
            exit();

        } catch (Exception $e) {
            error_log("Export submission error: " . $e->getMessage());
            error_log("Stack trace: " . $e->getTraceAsString());
            
            // Don't send JSON error if headers are already sent
            if (!headers_sent()) {
                $this->sendError('Failed to export submission: ' . $e->getMessage());
            } else {
                // Headers already sent, output error message
                echo "Error: Failed to export submission. Please check server logs for details.";
            }
        }
    }

    /**
     * Update submission status
     */
    public function updateStatus() {
        $this->checkAdminAuth();

        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->sendError('Method not allowed', 405);
        }

        $input = json_decode(file_get_contents('php://input'), true);
        
        if (!$input || !isset($input['submission_id']) || !isset($input['status'])) {
            $this->sendError('Missing required fields: submission_id and status');
        }

        $submissionId = $input['submission_id'];
        $status = $input['status'];

        if (!in_array($status, ['pending', 'approved', 'rejected'])) {
            $this->sendError('Invalid status. Must be: pending, approved, or rejected');
        }

        try {
            $sql = "UPDATE report_submissions SET status = ?, reviewed_date = NOW() WHERE id = ?";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$status, $submissionId]);

            if ($stmt->rowCount() === 0) {
                $this->sendError('Submission not found', 404);
            }

            $this->sendSuccess(['message' => 'Status updated successfully']);

        } catch (Exception $e) {
            error_log("Update status error: " . $e->getMessage());
            $this->sendError('Failed to update status');
        }
    }

    /**
     * Send success response
     */
    private function sendSuccess($data) {
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'data' => $data
        ]);
        exit();
    }

    /**
     * Send error response
     */
    private function sendError($message, $code = 400) {
        // Clear any previous output
        if (ob_get_level()) {
            ob_clean();
        }
        
        // Set JSON headers if not already set for export
        $action = $_GET['action'] ?? '';
        if ($action !== 'export') {
            header('Content-Type: application/json');
        }
        
        http_response_code($code);
        
        // For export actions, if we're sending an error, it should be JSON
        if ($action === 'export') {
            header('Content-Type: application/json');
        }
        
        echo json_encode([
            'success' => false,
            'error' => $message
        ]);
        exit();
    }
}

// Start output buffering to catch any unwanted output
ob_start();

// Handle API requests
try {
    $api = new AdminSubmissionsAPI();
    $action = $_GET['action'] ?? '';

    switch ($action) {
        case 'list':
            ob_end_clean(); // Clear buffer before API call
            $api->getSubmissions();
            break;
        case 'details':
            ob_end_clean();
            $api->getSubmissionDetails();
            break;
        case 'export':
            ob_end_clean();
            $api->exportSubmission();
            break;
        case 'update_status':
            ob_end_clean();
            $api->updateStatus();
            break;
        case 'delete':
            ob_end_clean();
            $api->deleteSubmission();
            break;
        case 'delete_row':
            ob_end_clean();
            $api->deleteRow();
            break;
        default:
            ob_end_clean();
            $api->sendError('Invalid action specified', 400);
    }
} catch (Exception $e) {
    ob_end_clean(); // Clear any output
    error_log("Admin submissions API error: " . $e->getMessage());
    error_log("Stack trace: " . $e->getTraceAsString());
    
    // Send JSON error
    header('Content-Type: application/json');
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'Server error: ' . $e->getMessage()
    ]);
    exit();
} catch (Error $e) {
    ob_end_clean(); // Clear any output
    error_log("Admin submissions API fatal error: " . $e->getMessage());
    error_log("Stack trace: " . $e->getTraceAsString());
    
    // Send JSON error
    header('Content-Type: application/json');
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'Fatal error: ' . $e->getMessage()
    ]);
    exit();
}
?>

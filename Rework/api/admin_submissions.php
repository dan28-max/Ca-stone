<?php
/**
 * Admin Submissions API
 * Handles admin viewing and management of user report submissions
 */

header('Content-Type: application/json');
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

// Start session
session_start();

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
     * Check admin authentication and get admin info
     */
    private function checkAdminAuth() {
        // For testing - return default admin with campus
        if (!isset($_SESSION['user_id'])) {
            $_SESSION['user_id'] = 1;
            $_SESSION['user_role'] = 'admin';
        }
        
        // Get admin user info including campus
        $stmt = $this->db->prepare("
            SELECT id, name, email, role, campus, office
            FROM users 
            WHERE id = ? AND role IN ('admin', 'super_admin') AND status = 'active'
        ");
        $stmt->execute([$_SESSION['user_id']]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$user) {
            $this->sendError('Unauthorized access - Admin only', 401);
        }
        
        return $user;
    }

    /**
     * List all submissions (filtered by campus for regular admins)
     */
    public function listSubmissions() {
        $admin = $this->checkAdminAuth();
        
        // Add debugging
        error_log('Listing submissions for admin: ' . $admin['email'] . ', campus: ' . $admin['campus'] . ', role: ' . $admin['role']);
        
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
                    u.email as user_email,
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
            // Regular admin - filter by campus
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
                    u.email as user_email,
                    COUNT(rsd.id) as record_count
                FROM report_submissions rs
                LEFT JOIN report_submission_data rsd ON rs.id = rsd.submission_id
                LEFT JOIN users u ON rs.user_id = u.id
                WHERE rs.campus = ? OR rs.campus IS NULL
                GROUP BY rs.id
                ORDER BY rs.submission_date DESC
            ";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$admin['campus']]);
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
            $sql = "SELECT 
                        rs.id,
                        rs.table_name,
                        rs.campus,
                        rs.office,
                        rs.description,
                        rs.submission_date,
                        rs.status,
                        u.name as user_name,
                        u.email as user_email,
                        COUNT(rsd.id) as record_count
                    FROM report_submissions rs
                    JOIN users u ON rs.user_id = u.id
                    LEFT JOIN report_submission_data rsd ON rs.id = rsd.submission_id
                    GROUP BY rs.id
                    ORDER BY rs.submission_date DESC";
            
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $submissions = $stmt->fetchAll();

            $this->sendSuccess($submissions);

        } catch (Exception $e) {
            error_log("Get submissions error: " . $e->getMessage());
            $this->sendError('Failed to fetch submissions');
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
            // Get submission info
            $sql = "SELECT 
                        rs.*,
                        u.name as user_name,
                        u.email as user_email
                    FROM report_submissions rs
                    JOIN users u ON rs.user_id = u.id
                    WHERE rs.id = ?";
            
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$submissionId]);
            $submission = $stmt->fetch();

            if (!$submission) {
                $this->sendError('Submission not found', 404);
            }

            // Get submission data
            $sql = "SELECT row_data FROM report_submission_data WHERE submission_id = ? ORDER BY id";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$submissionId]);
            $dataRows = $stmt->fetchAll();

            $submission['data'] = array_map(function($row) {
                return json_decode($row['row_data'], true);
            }, $dataRows);

            $this->sendSuccess($submission);

        } catch (Exception $e) {
            error_log("Get submission details error: " . $e->getMessage());
            $this->sendError('Failed to fetch submission details');
        }
    }

    /**
     * Export submission to CSV
     */
    public function exportSubmission() {
        $this->checkAdminAuth();

        $submissionId = $_GET['submission_id'] ?? null;
        
        if (!$submissionId) {
            $this->sendError('Submission ID required');
        }

        try {
            // Get submission info
            $sql = "SELECT 
                        rs.*,
                        u.name as user_name,
                        u.email as user_email
                    FROM report_submissions rs
                    JOIN users u ON rs.user_id = u.id
                    WHERE rs.id = ?";
            
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$submissionId]);
            $submission = $stmt->fetch();

            if (!$submission) {
                $this->sendError('Submission not found', 404);
            }

            // Get submission data
            $sql = "SELECT row_data FROM report_submission_data WHERE submission_id = ? ORDER BY id";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$submissionId]);
            $dataRows = $stmt->fetchAll();

            if (empty($dataRows)) {
                $this->sendError('No data found for this submission');
            }

            // Prepare CSV
            $filename = $submission['table_name'] . '_' . $submission['campus'] . '_' . date('Y-m-d', strtotime($submission['submission_date'])) . '.csv';
            
            header('Content-Type: text/csv');
            header('Content-Disposition: attachment; filename="' . $filename . '"');
            header('Cache-Control: no-cache, must-revalidate');
            header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');

            $output = fopen('php://output', 'w');

            // Add metadata header
            fputcsv($output, ['Report Information']);
            fputcsv($output, ['Table Name', $submission['table_name']]);
            fputcsv($output, ['Campus', $submission['campus']]);
            fputcsv($output, ['Office', $submission['office']]);
            fputcsv($output, ['Submitted By', $submission['user_name'] . ' (' . $submission['user_email'] . ')']);
            fputcsv($output, ['Submission Date', $submission['submission_date']]);
            fputcsv($output, ['Description', $submission['description']]);
            fputcsv($output, []);
            fputcsv($output, ['Data Records']);

            // Get column headers from first row
            $firstRow = json_decode($dataRows[0]['row_data'], true);
            if ($firstRow && is_array($firstRow)) {
                fputcsv($output, array_keys($firstRow));

                // Add data rows
                foreach ($dataRows as $row) {
                    $rowData = json_decode($row['row_data'], true);
                    if ($rowData && is_array($rowData)) {
                        fputcsv($output, array_values($rowData));
                    }
                }
            }

            fclose($output);
            exit();

        } catch (Exception $e) {
            error_log("Export submission error: " . $e->getMessage());
            $this->sendError('Failed to export submission');
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
        http_response_code($code);
        echo json_encode([
            'success' => false,
            'error' => $message
        ]);
        exit();
    }
}

// Handle API requests
$api = new AdminSubmissionsAPI();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'list':
        $api->getSubmissions();
        break;
    case 'details':
        $api->getSubmissionDetails();
        break;
    case 'export':
        $api->exportSubmission();
        break;
    case 'update_status':
        $api->updateStatus();
        break;
    default:
        $api->sendError('Invalid action specified', 400);
}
?>

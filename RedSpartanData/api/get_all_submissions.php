<?php
/**
 * Get All Submissions API
 * Fetches all report submissions from report_submissions table
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    require_once __DIR__ . '/../config/database.php';
    require_once __DIR__ . '/../includes/functions.php';
    
    $database = new Database();
    $db = $database->getConnection();
    if (session_status() === PHP_SESSION_NONE) { session_start(); }
    $sessionCampus = isset($_SESSION['user_campus']) ? trim((string)$_SESSION['user_campus']) : '';
    
    // Check if report_submissions table exists
    $checkTable = $db->query("SHOW TABLES LIKE 'report_submissions'");
    if ($checkTable->rowCount() === 0) {
        throw new Exception('report_submissions table does not exist. Please run the database setup.');
    }
    
    // Get columns from report_submissions table dynamically
    $columnsCheck = $db->query("SHOW COLUMNS FROM report_submissions");
    $existingColumns = [];
    while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
        $existingColumns[] = $col['Field'];
    }
    
    error_log("report_submissions columns for fetching: " . implode(', ', $existingColumns));
    
    // Build SELECT based on available columns
    $selectFields = ['rs.id', 'rs.status'];
    
    // Add table identifier
    if (in_array('table_name', $existingColumns)) {
        $selectFields[] = 'rs.table_name';
    } elseif (in_array('report_type', $existingColumns)) {
        $selectFields[] = 'rs.report_type as table_name';
    }
    
    // Add timestamp
    if (in_array('submission_date', $existingColumns)) {
        $selectFields[] = 'rs.submission_date as submitted_at';
    } elseif (in_array('submitted_at', $existingColumns)) {
        $selectFields[] = 'rs.submitted_at';
    }
    
    // Add optional fields
    if (in_array('campus', $existingColumns)) {
        $selectFields[] = 'rs.campus';
    }
    if (in_array('office', $existingColumns)) {
        $selectFields[] = 'rs.office';
    }
    if (in_array('description', $existingColumns)) {
        $selectFields[] = 'rs.description';
    }
    // Calculate record_count from target tables (e.g., admissiondata, enrollmentdata) for accuracy
    // This ensures counts reflect actual data, not backup table
    // We'll calculate this after fetching submissions using subqueries per submission
    
    // Handle user reference
    $userJoin = '';
    if (in_array('user_id', $existingColumns)) {
        $selectFields[] = 'rs.user_id';
        $selectFields[] = 'u.name as user_name';
        $selectFields[] = 'u.username as submitted_by';
        $userJoin = 'LEFT JOIN users u ON rs.user_id = u.id';
    } elseif (in_array('submitted_by', $existingColumns)) {
        $selectFields[] = 'rs.submitted_by';
        $selectFields[] = 'u.name as user_name';
        $userJoin = 'LEFT JOIN users u ON rs.submitted_by = u.id';
    }
    
    // Temporarily set record_count to 0 - we'll calculate from target tables below
    $selectFields[] = "0 as record_count";
    
    // UNIFIED APPROACH: Get ALL submissions from ALL report types, ALL sessions, ALL months in ONE unified view
    // NO filtering by table_name - ALL reports (admissiondata, enrollmentdata, graduatesdata, etc.) appear together
    // NO filtering by session or month - ALL reports from ALL periods appear together
    // NO grouping by table_name, session, or month - all reports mixed together in one unified table
    // NO WHERE clause filtering by date/month/session - ALL reports regardless of when submitted
    
    // Determine which date column exists for ORDER BY (only for sorting, NOT for filtering or separation)
    $orderByColumn = 'rs.id';
    if (in_array('submitted_at', $existingColumns)) {
        $orderByColumn = 'rs.submitted_at';
    } elseif (in_array('submission_date', $existingColumns)) {
        $orderByColumn = 'rs.submission_date';
    } elseif (in_array('created_at', $existingColumns)) {
        $orderByColumn = 'rs.created_at';
    }
    
    // Get ALL submissions - NO date/month/session filtering
    // ALL reports from ALL sessions and ALL months in ONE unified table
    $query = "SELECT " . implode(', ', $selectFields) . "
              FROM report_submissions rs
              $userJoin
              GROUP BY rs.id
              ORDER BY $orderByColumn DESC, rs.id DESC";
    
    error_log("Fetching ALL submissions from ALL report types, ALL sessions, ALL months (unified view) with query: $query");
    
    $stmt = $db->query($query);
    $submissions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Calculate actual record_count from target tables (not from report_submission_data)
    // This ensures counts are accurate even after row deletions
    foreach ($submissions as &$submission) {
        $tableName = $submission['table_name'] ?? null;
        $submissionId = $submission['id'] ?? 0;
        
        if ($tableName && $submissionId > 0) {
            try {
                // Normalize table name to match actual database table names
                $tableNameMap = [
                    'admission data' => 'admissiondata',
                    'enrollment data' => 'enrollmentdata',
                    'graduates data' => 'graduatesdata',
                    'budget expenditure' => 'budgetexpenditure',
                    'campus population' => 'campuspopulation',
                    'distance traveled' => 'distancetraveled',
                    'electricity consumption' => 'electricityconsumption',
                    'flight accommodation' => 'flightaccommodation',
                    'food waste' => 'foodwaste',
                    'fuel consumption' => 'fuelconsumption',
                    'leave privilege' => 'leaveprivilege',
                    'library visitor' => 'libraryvisitor',
                    'solid waste' => 'solidwaste',
                    'treated wastewater' => 'treatedwastewater',
                    'water consumption' => 'waterconsumption'
                ];
                
                $originalTableName = $tableName;
                $normalizedTableName = strtolower(trim($tableName));
                if (isset($tableNameMap[$normalizedTableName])) {
                    $tableName = $tableNameMap[$normalizedTableName];
                } else {
                    // If not in map, try to normalize by removing spaces and converting to lowercase
                    $tableName = strtolower(str_replace(' ', '', $tableName));
                }
                
                if ($originalTableName !== $tableName) {
                    error_log("Normalized table name from '$originalTableName' to '$tableName' for submission $submissionId");
                }
                
                // Check if target table exists
                $tableCheck = $db->query("SHOW TABLES LIKE '$tableName'");
                if ($tableCheck->rowCount() > 0) {
                    // Get batch_id directly from report_submissions table using submission ID
                    // This is the correct way - match by submission ID, not by guessing batch_id
                    $submissionBatchId = null;
                    try {
                        $batchIdCheck = $db->query("SHOW COLUMNS FROM report_submissions LIKE 'batch_id'");
                        if ($batchIdCheck->rowCount() > 0) {
                            $batchIdStmt = $db->prepare("SELECT batch_id FROM report_submissions WHERE id = ?");
                            $batchIdStmt->execute([$submissionId]);
                            $batchIdResult = $batchIdStmt->fetch(PDO::FETCH_ASSOC);
                            if ($batchIdResult && !empty($batchIdResult['batch_id'])) {
                                $submissionBatchId = $batchIdResult['batch_id'];
                            }
                        }
                    } catch (Exception $e) {
                        error_log("Error fetching batch_id from report_submissions for submission $submissionId: " . $e->getMessage());
                    }
                    
                    // Get columns in the target table
                    $columnsCheck = $db->query("SHOW COLUMNS FROM `$tableName`");
                    $targetColumns = [];
                    while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
                        $targetColumns[] = $col['Field'];
                    }
                    
                    // Build query to count rows from target table
                    $whereConditions = [];
                    $whereParams = [];
                    
                    // Priority 1: Check if submission_id column exists (direct link)
                    if (in_array('submission_id', $targetColumns)) {
                        $whereConditions[] = "submission_id = ?";
                        $whereParams[] = $submissionId;
                    } elseif ($submissionBatchId && in_array('batch_id', $targetColumns)) {
                        // Priority 2: Use batch_id from report_submissions table (matched by submission ID)
                        // This is the correct way - we get batch_id from submission record, not by guessing
                        // Use case-insensitive matching in case office name casing differs
                        $whereConditions[] = "LOWER(batch_id) = LOWER(?)";
                        $whereParams[] = $submissionBatchId;
                    } else {
                        // Do NOT use report_submission_data - only count from main data tables
                        error_log("Cannot count records - no batch_id and no submission_id column for submission $submissionId");
                        $submission['record_count'] = 0;
                        continue;
                    }
                    
                    if (!empty($whereConditions)) {
                        $whereClause = implode(' AND ', $whereConditions);
                        $countQuery = "SELECT COUNT(*) as cnt FROM `$tableName` WHERE $whereClause";
                        
                        error_log("Counting records for submission $submissionId: $countQuery with params: " . print_r($whereParams, true));
                        
                        $countStmt = $db->prepare($countQuery);
                        $countStmt->execute($whereParams);
                        $countResult = $countStmt->fetch(PDO::FETCH_ASSOC);
                        $submission['record_count'] = (int)($countResult['cnt'] ?? 0);
                        
                        error_log("Submission $submissionId: Found {$submission['record_count']} records in table $tableName");
                    } else {
                        // No matching conditions, use 0 (data may have been deleted)
                        error_log("WARNING: No matching conditions for submission $submissionId in table $tableName - batch_id: " . ($submissionBatchId ?? 'NULL') . ", has submission_id column: " . (in_array('submission_id', $targetColumns) ? 'YES' : 'NO'));
                        $submission['record_count'] = 0;
                    }
                } else {
                    // Target table doesn't exist - count is 0 (data was never created or table was removed)
                    error_log("WARNING: Target table '$tableName' does not exist for submission $submissionId");
                    $submission['record_count'] = 0;
                }
            } catch (Exception $e) {
                error_log("ERROR counting records for submission $submissionId from table $tableName: " . $e->getMessage());
                error_log("Stack trace: " . $e->getTraceAsString());
                // Fallback to 0 if error
                $submission['record_count'] = 0;
            }
        } else {
            error_log("WARNING: Missing table name or submission ID for submission: " . print_r($submission, true));
            $submission['record_count'] = 0;
        }
    }
    unset($submission); // Break reference
    
    // Apply campus filtering if user is not super admin
    // NOTE: Still showing ALL report types, ALL sessions, ALL months together - only filtering by campus
    // NO filtering by date, month, or session - ALL reports appear together regardless of when submitted
    if (session_status() === PHP_SESSION_NONE) { session_start(); }
    
    // Get user role from session (check multiple possible keys)
    $userRole = $_SESSION['user_role'] ?? $_SESSION['role'] ?? '';
    $userCampus = $sessionCampus ?? '';
    
    // Also check if user is in Main Campus (treated as super admin)
    $isMainCampus = strcasecmp(trim($userCampus ?? ''), 'Main Campus') === 0;
    
    // Check if user is super admin (check role or Main Campus)
    $isSuperAdmin = strtolower(trim($userRole)) === 'super_admin' || $isMainCampus;
    
    error_log("User role: $userRole, Campus: $userCampus, Is Super Admin: " . ($isSuperAdmin ? 'YES' : 'NO'));
    
    // Filter by all accessible campuses if user is not super admin
    if (!$isSuperAdmin && !empty($userCampus)) {
        // Use dynamic campus hierarchy (with defaults) to determine accessible campuses
        if (function_exists('getAccessibleCampusesForAdmin')) {
            $campusList = getAccessibleCampusesForAdmin($userCampus);
        } else {
            $campusList = [$userCampus];
        }

        $accessible = array_map(function($c) { return strtolower(trim($c)); }, $campusList);
        $submissions = array_values(array_filter($submissions, function($submission) use ($accessible) {
            $submissionCampus = strtolower(trim($submission['campus'] ?? ''));
            return in_array($submissionCampus, $accessible, true);
        }));
        error_log("Filtered submissions by accessible campuses '" . implode(', ', $accessible) . "': " . count($submissions) . " submissions");
    } else {
        error_log("Super Admin - Returning ALL submissions from ALL campuses: " . count($submissions) . " submissions");
    }
    
    // Log all submissions before filtering
    $totalBeforeFilter = count($submissions);
    $zeroRecordCount = 0;
    foreach ($submissions as $sub) {
        if (($sub['record_count'] ?? 0) === 0) {
            $zeroRecordCount++;
            error_log("Submission {$sub['id']} has 0 records - table: {$sub['table_name']}, batch_id check needed");
        }
    }
    error_log("Total submissions: $totalBeforeFilter, Submissions with 0 records: $zeroRecordCount");
    
    // Filter out submissions with 0 records (where all data was deleted by admin)
    // BUT: Only filter if we're confident the count is accurate (not due to missing batch_id or table name mismatch)
    $submissions = array_filter($submissions, function($sub) {
        return ($sub['record_count'] ?? 0) > 0;
    });
    
    // Re-index array after filtering
    $submissions = array_values($submissions);
    
    error_log("After filtering: " . count($submissions) . " submissions remain");
    
    // Log all unique report types found to verify all types are included
    // ALL reports from ALL sessions and ALL months appear together in one unified view
    $uniqueReportTypes = array_unique(array_column($submissions, 'table_name'));
    error_log("Returning " . count($submissions) . " unified submissions from " . count($uniqueReportTypes) . " report types (ALL sessions, ALL months): " . implode(', ', $uniqueReportTypes));
    
    echo json_encode([
        'success' => true,
        'data' => $submissions,
        'count' => count($submissions)
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}

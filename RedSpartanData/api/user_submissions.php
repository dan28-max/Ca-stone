<?php
/**
 * User Submissions API
 * Handles fetching user's submission history
 */

// Start output buffering to catch any unexpected output
ob_start();

// Start session first before any output
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Enable error logging but don't display errors (prevents HTML output breaking JSON)
error_reporting(E_ALL);
ini_set('display_errors', 0); // Don't display errors - log them instead
ini_set('log_errors', 1);

// Set headers
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');

// Handle preflight requests
if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    // Include database configuration
    require_once __DIR__ . '/../config/database.php';
    require_once __DIR__ . '/../includes/functions.php';
    
    // Check if user is logged in
    if (!isset($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'Unauthorized. Please log in.']);
        exit();
    }
} catch (Exception $e) {
    error_log("Error in user_submissions.php initialization: " . $e->getMessage());
    error_log("Stack trace: " . $e->getTraceAsString());
    http_response_code(500);
    echo json_encode([
        'success' => false, 
        'message' => 'Server error: ' . $e->getMessage(),
        'file' => $e->getFile(),
        'line' => $e->getLine(),
        'trace' => $e->getTraceAsString()
    ]);
    exit();
}

try {
    // Clear any output that might have been generated
    ob_clean();
    
    $action = $_GET['action'] ?? 'get_submissions';

    switch ($action) {
        case 'get_submissions':
            getUserSubmissions();
            break;
        case 'details':
            getSubmissionDetails();
            break;
        case 'get_all_reports':
        case 'combine_all':
            getAllUserReports();
            break;
        default:
            getUserSubmissions();
            break;
    }
} catch (Exception $e) {
    ob_clean(); // Clear any output
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error: ' . $e->getMessage()]);
} catch (Error $e) {
    ob_clean(); // Clear any output
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error: ' . $e->getMessage()]);
}

/**
 * Get submission history for the current user
 */
function getUserSubmissions() {
    $pdo = getDB();
    
    try {
        $userId = $_SESSION['user_id'];
        
        // Check if report_submissions table exists
        $tableCheckSql = "SHOW TABLES LIKE 'report_submissions'";
        $tableCheckStmt = $pdo->query($tableCheckSql);
        
        if ($tableCheckStmt->rowCount() === 0) {
            // Table doesn't exist, return empty array
            echo json_encode([
                'success' => true,
                'submissions' => [],
                'message' => 'No submissions table found'
            ]);
            return;
        }
        
        // Get user's submission history with record count from submission_data
        // CRITICAL: Filter by user_id to ensure users only see their own submissions
        
        // First, check what columns exist in report_submissions table
        $columnsResult = $pdo->query("DESCRIBE report_submissions");
        $columns = $columnsResult->fetchAll(PDO::FETCH_COLUMN);
        
        // Log available columns for debugging
        error_log("Available columns in report_submissions: " . implode(", ", $columns));
        
        // Determine which columns to use
        $userIdCol = in_array('user_id', $columns) ? 'rs.user_id' : (in_array('submitted_by', $columns) ? 'rs.submitted_by' : 'rs.id');
        $tableNameCol = in_array('table_name', $columns) ? 'rs.table_name' : (in_array('report_type', $columns) ? 'rs.report_type' : 'NULL');
        $officeCol = in_array('office', $columns) ? 'rs.office' : 'NULL';
        $campusCol = in_array('campus', $columns) ? 'rs.campus' : 'NULL';
        $statusCol = in_array('status', $columns) ? 'rs.status' : "'pending'";
        $descCol = in_array('description', $columns) ? 'rs.description' : 'NULL';
        $reviewedCol = in_array('reviewed_date', $columns) ? 'rs.reviewed_date' : (in_array('reviewed_at', $columns) ? 'rs.reviewed_at' : 'NULL');
        $submissionDateCol = in_array('submission_date', $columns) ? 'rs.submission_date' : (in_array('submitted_at', $columns) ? 'rs.submitted_at' : (in_array('created_at', $columns) ? 'rs.created_at' : 'NOW()'));
        
        error_log("Using user_id column: $userIdCol");
        
        // Try with report_submission_data join first
        try {
            $sql = "SELECT 
                        rs.id,
                        $tableNameCol as table_name,
                        $officeCol as office,
                        $campusCol as campus,
                        $submissionDateCol as submission_date,
                        $statusCol as status,
                        $descCol as description,
                        $reviewedCol as reviewed_date,
                        u.name as submitted_by_name,
                        COUNT(rsd.id) as record_count
                    FROM report_submissions rs
                    LEFT JOIN users u ON $userIdCol = u.id
                    LEFT JOIN report_submission_data rsd ON rs.id = rsd.submission_id
                    WHERE $userIdCol = ?
                    GROUP BY rs.id
                    ORDER BY $submissionDateCol DESC";
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$userId]);
            $submissions = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            // If report_submission_data table doesn't exist, query without it
            error_log("report_submission_data table not found, querying without it: " . $e->getMessage());
            
            $sql = "SELECT 
                        rs.id,
                        $tableNameCol as table_name,
                        $officeCol as office,
                        $campusCol as campus,
                        $submissionDateCol as submission_date,
                        $statusCol as status,
                        $descCol as description,
                        $reviewedCol as reviewed_date,
                        u.name as submitted_by_name,
                        0 as record_count
                    FROM report_submissions rs
                    LEFT JOIN users u ON $userIdCol = u.id
                    WHERE $userIdCol = ?
                    ORDER BY $submissionDateCol DESC";
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$userId]);
            $submissions = $stmt->fetchAll(PDO::FETCH_ASSOC);
        }
        
        // Recalculate record_count from actual target tables (not from report_submission_data)
        // This ensures we get the current count even if admin deleted some data
        foreach ($submissions as &$submission) {
            $submissionId = $submission['id'];
            $tableName = $submission['table_name'] ?? 'Unknown Report';
            $recordCount = 0;
            
            if ($tableName && $tableName !== 'Unknown Report') {
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
                    $tableCheck = $pdo->query("SHOW TABLES LIKE '$tableName'");
                    if ($tableCheck->rowCount() > 0) {
                        // Get batch_id directly from report_submissions table using submission ID
                        // This is the correct way - match by submission ID, not by guessing batch_id
                        $submissionBatchId = null;
                        try {
                            $batchIdCheck = $pdo->query("SHOW COLUMNS FROM report_submissions LIKE 'batch_id'");
                            if ($batchIdCheck->rowCount() > 0) {
                                $batchIdStmt = $pdo->prepare("SELECT batch_id FROM report_submissions WHERE id = ?");
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
                        $columnsCheck = $pdo->query("SHOW COLUMNS FROM `$tableName`");
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
                            $recordCount = 0;
                        }
                        
                        if (!empty($whereConditions)) {
                            $whereClause = implode(' AND ', $whereConditions);
                            $countQuery = "SELECT COUNT(*) as count FROM `$tableName` WHERE $whereClause";
                            
                            error_log("Counting records for submission $submissionId: $countQuery with params: " . print_r($whereParams, true));
                            
                            $countStmt = $pdo->prepare($countQuery);
                            $countStmt->execute($whereParams);
                            $countResult = $countStmt->fetch(PDO::FETCH_ASSOC);
                            $recordCount = (int)($countResult['count'] ?? 0);
                            
                            error_log("Submission $submissionId: Found $recordCount records in table $tableName");
                        } else {
                            error_log("WARNING: No matching conditions for submission $submissionId in table $tableName - batch_id: " . ($submissionBatchId ?? 'NULL') . ", has submission_id column: " . (in_array('submission_id', $targetColumns) ? 'YES' : 'NO'));
                        }
                    } else {
                        error_log("WARNING: Target table '$tableName' does not exist for submission $submissionId");
                    }
                } catch (PDOException $e) {
                    error_log("ERROR counting records from target table $tableName for submission $submissionId: " . $e->getMessage());
                    error_log("Stack trace: " . $e->getTraceAsString());
                    $recordCount = 0;
                }
            } else {
                error_log("WARNING: Missing or invalid table name for submission $submissionId: " . ($tableName ?? 'NULL'));
            }
            
            // Update the record count with actual count from target table
            $submission['record_count'] = $recordCount;
        }
        unset($submission); // Break reference
        
        // Log all submissions before filtering
        $totalBeforeFilter = count($submissions);
        $zeroRecordCount = 0;
        foreach ($submissions as $sub) {
            if (($sub['record_count'] ?? 0) === 0) {
                $zeroRecordCount++;
                error_log("User submission {$sub['id']} has 0 records - table: {$sub['table_name']}, batch_id check needed");
            }
        }
        error_log("Total user submissions: $totalBeforeFilter, Submissions with 0 records: $zeroRecordCount");
        
        // Filter out submissions with 0 records (where all data was deleted by admin)
        $submissions = array_filter($submissions, function($sub) {
            return ($sub['record_count'] ?? 0) > 0;
        });
        
        // Re-index array after filtering
        $submissions = array_values($submissions);
        
        error_log("After filtering: " . count($submissions) . " user submissions remain");
        
        // Format dates for display
        foreach ($submissions as &$submission) {
            if (isset($submission['submission_date'])) {
                $date = new DateTime($submission['submission_date']);
                $submission['submitted_at'] = $submission['submission_date'];
                $submission['submitted_at_formatted'] = $date->format('M d, Y h:i A');
            }
            if (isset($submission['reviewed_date']) && $submission['reviewed_date']) {
                $date = new DateTime($submission['reviewed_date']);
                $submission['reviewed_at_formatted'] = $date->format('M d, Y h:i A');
            }
        }
        
        echo json_encode([
            'success' => true,
            'submissions' => $submissions
        ]);
        
    } catch (PDOException $e) {
        error_log("Error fetching user submissions: " . $e->getMessage());
        error_log("Stack trace: " . $e->getTraceAsString());
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => 'Database error: ' . $e->getMessage(),
            'error' => $e->getMessage(),
            'code' => $e->getCode(),
            'file' => $e->getFile(),
            'line' => $e->getLine()
        ]);
    } catch (Exception $e) {
        error_log("Unexpected error in getUserSubmissions: " . $e->getMessage());
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => 'Error: ' . $e->getMessage(),
            'file' => $e->getFile(),
            'line' => $e->getLine()
        ]);
    }
}

/**
 * Get detailed submission data including all rows
 */
function getSubmissionDetails() {
    $pdo = getDB();
    
    try {
        $userId = $_SESSION['user_id'];
        $submissionId = $_GET['submission_id'] ?? null;
        
        if (!$submissionId) {
            http_response_code(400);
            echo json_encode(['success' => false, 'error' => 'Submission ID required']);
            return;
        }
        
        // Check columns in report_submissions table
        $columnsResult = $pdo->query("DESCRIBE report_submissions");
        $columns = $columnsResult->fetchAll(PDO::FETCH_COLUMN);
        $userIdCol = in_array('user_id', $columns) ? 'rs.user_id' : (in_array('submitted_by', $columns) ? 'rs.submitted_by' : 'rs.id');
        
        // Get submission info - ensure it belongs to the current user
        $sql = "SELECT 
                    rs.*,
                    u.name as submitted_by_name,
                    u.username as submitted_by_username
                FROM report_submissions rs
                LEFT JOIN users u ON $userIdCol = u.id
                WHERE rs.id = ? AND $userIdCol = ?";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$submissionId, $userId]);
        $submission = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$submission) {
            http_response_code(404);
            echo json_encode(['success' => false, 'error' => 'Submission not found or access denied']);
            return;
        }
        
        // Get submission data rows
        $dataSql = "SELECT row_data FROM report_submission_data WHERE submission_id = ? ORDER BY id";
        $dataStmt = $pdo->prepare($dataSql);
        $dataStmt->execute([$submissionId]);
        $dataRows = $dataStmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Decode JSON data from each row
        $submission['data'] = array_map(function($row) {
            return json_decode($row['row_data'], true);
        }, $dataRows);
        
        echo json_encode([
            'success' => true,
            'data' => $submission
        ]);
        
    } catch (PDOException $e) {
        error_log("Error fetching submission details: " . $e->getMessage());
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'error' => 'Database error: ' . $e->getMessage()
        ]);
    }
}

/**
 * Get all reports combined from all user submissions
 * Fetches all submissions and combines all their report data into a single response
 */
function getAllUserReports() {
    $pdo = getDB();
    
    try {
        $userId = $_SESSION['user_id'];
        
        // Get optional table_name filter from request
        $tableNameFilter = $_GET['table_name'] ?? null;
        
        // Check if report_submissions table exists
        $tableCheckSql = "SHOW TABLES LIKE 'report_submissions'";
        $tableCheckStmt = $pdo->query($tableCheckSql);
        
        if ($tableCheckStmt->rowCount() === 0) {
            // Table doesn't exist, return empty array
            echo json_encode([
                'success' => true,
                'combined_reports' => [],
                'submission_count' => 0,
                'total_records' => 0,
                'message' => 'No submissions table found'
            ]);
            return;
        }
        
        // First, check what columns exist in report_submissions table
        $columnsResult = $pdo->query("DESCRIBE report_submissions");
        $columns = $columnsResult->fetchAll(PDO::FETCH_COLUMN);
        
        // Determine which columns to use
        $userIdCol = in_array('user_id', $columns) ? 'rs.user_id' : (in_array('submitted_by', $columns) ? 'rs.submitted_by' : 'rs.id');
        $tableNameCol = in_array('table_name', $columns) ? 'rs.table_name' : (in_array('report_type', $columns) ? 'rs.report_type' : 'NULL');
        $officeCol = in_array('office', $columns) ? 'rs.office' : 'NULL';
        $campusCol = in_array('campus', $columns) ? 'rs.campus' : 'NULL';
        $statusCol = in_array('status', $columns) ? 'rs.status' : "'pending'";
        $descCol = in_array('description', $columns) ? 'rs.description' : 'NULL';
        $reviewedCol = in_array('reviewed_date', $columns) ? 'rs.reviewed_date' : (in_array('reviewed_at', $columns) ? 'rs.reviewed_at' : 'NULL');
        $submissionDateCol = in_array('submission_date', $columns) ? 'rs.submission_date' : (in_array('submitted_at', $columns) ? 'rs.submitted_at' : (in_array('created_at', $columns) ? 'rs.created_at' : 'NOW()'));
        
        // Build WHERE clause - filter by user_id and optionally by table_name
        $whereClause = "$userIdCol = ?";
        $params = [$userId];
        
        if ($tableNameFilter) {
            // Filter by specific report type/table name
            $whereClause .= " AND ($tableNameCol = ? OR $tableNameCol LIKE ?)";
            $params[] = $tableNameFilter;
            $params[] = "%$tableNameFilter%";
        }
        
        // Get submissions for the user (optionally filtered by table_name)
        $sql = "SELECT 
                    rs.id,
                    $tableNameCol as table_name,
                    $officeCol as office,
                    $campusCol as campus,
                    $submissionDateCol as submission_date,
                    $statusCol as status,
                    $descCol as description,
                    $reviewedCol as reviewed_date,
                    u.name as submitted_by_name
                FROM report_submissions rs
                LEFT JOIN users u ON $userIdCol = u.id
                WHERE $whereClause
                ORDER BY $submissionDateCol DESC";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        $submissions = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Combine all reports from all submissions
        // Fetch data from the actual report tables (admissiondata, enrollmentdata, etc.) NOT from report_submission_data
        $combinedReports = [];
        $submissionCount = count($submissions);
        $totalRecords = 0;
        
        foreach ($submissions as $submission) {
            $submissionId = $submission['id'];
            $tableName = $submission['table_name'] ?? $submission['report_type'] ?? 'Unknown Report';
            
            // Get batch_id directly from report_submissions table using submission ID
            // This is the correct way - match by submission ID, not by guessing batch_id
            $submissionBatchId = null;
            try {
                $batchIdCheck = $pdo->query("SHOW COLUMNS FROM report_submissions LIKE 'batch_id'");
                if ($batchIdCheck->rowCount() > 0) {
                    $batchIdStmt = $pdo->prepare("SELECT batch_id FROM report_submissions WHERE id = ?");
                    $batchIdStmt->execute([$submissionId]);
                    $batchIdResult = $batchIdStmt->fetch(PDO::FETCH_ASSOC);
                    if ($batchIdResult && !empty($batchIdResult['batch_id'])) {
                        $submissionBatchId = $batchIdResult['batch_id'];
                    }
                }
            } catch (Exception $e) {
                error_log("Error fetching batch_id from report_submissions for submission $submissionId: " . $e->getMessage());
            }
            
            // Try to fetch from the actual target table first (e.g., admissiondata, enrollmentdata)
            $dataRows = [];
            $fetchedFromTarget = false;
            
            if ($tableName && $tableName !== 'Unknown Report') {
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
                        error_log("Normalized table name from '$originalTableName' to '$tableName' for submission $submissionId in getAllUserReports");
                    }
                    
                    // Check if target table exists
                    $tableCheck = $pdo->query("SHOW TABLES LIKE '$tableName'");
                    if ($tableCheck->rowCount() > 0) {
                        // Get columns in the target table
                        $columnsCheck = $pdo->query("SHOW COLUMNS FROM `$tableName`");
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
                        } elseif ($submissionBatchId && in_array('batch_id', $targetColumns)) {
                            // Priority 2: Use batch_id from report_submissions table (matched by submission ID)
                            // This is the correct way - we get batch_id from submission record, not by guessing
                            // Use case-insensitive matching in case office name casing differs
                            $whereConditions[] = "LOWER(batch_id) = LOWER(?)";
                            $whereParams[] = $submissionBatchId;
                        } else {
                            // Fallback: Cannot match in target table, will try report_submission_data below
                            error_log("No batch_id found in submission record and no submission_id column in target table for submission $submissionId - will try report_submission_data");
                            $dataRows = [];
                            $fetchedFromTarget = false;
                        }
                        
                        if (!empty($whereConditions)) {
                            $whereClause = implode(' AND ', $whereConditions);
                            $targetQuery = "SELECT * FROM `$tableName` WHERE $whereClause ORDER BY id ASC";
                            
                            $targetStmt = $pdo->prepare($targetQuery);
                            $targetStmt->execute($whereParams);
                            $dataRows = $targetStmt->fetchAll(PDO::FETCH_ASSOC);
                            $fetchedFromTarget = true;
                            
                            error_log("Fetched " . count($dataRows) . " rows from target table $tableName for submission $submissionId");
                        }
                    }
                } catch (PDOException $e) {
                    error_log("Error fetching from target table $tableName for submission $submissionId: " . $e->getMessage());
                }
            }
            
            // Do NOT use report_submission_data - only fetch from main data tables
            if (!$fetchedFromTarget || empty($dataRows)) {
                error_log("Could not fetch from target table $tableName for submission $submissionId - returning empty data");
                $dataRows = [];
            }
            
            // Add submission metadata to each row
            foreach ($dataRows as $reportData) {
                if (is_array($reportData) && !empty($reportData)) {
                    // Extract submission metadata
                    $submissionDate = $submission['submission_date'] ?? $submission['submitted_at'] ?? $submission['created_at'] ?? null;
                    $submissionOffice = $submission['office'] ?? null;
                    $submissionCampus = $submission['campus'] ?? null;
                    
                    // Add submission metadata to each row
                    $reportData['__submission_id'] = $submissionId;
                    $reportData['__table_name'] = $tableName;
                    $reportData['__submission_date'] = $submissionDate;
                    $reportData['__office'] = $submissionOffice;
                    $reportData['__campus'] = $submissionCampus;
                    $reportData['__status'] = $submission['status'] ?? null;
                    
                    $combinedReports[] = $reportData;
                    $totalRecords++;
                }
            }
        }
        
        // Format dates in submissions metadata
        foreach ($submissions as &$submission) {
            if (isset($submission['submission_date'])) {
                $date = new DateTime($submission['submission_date']);
                $submission['submitted_at'] = $submission['submission_date'];
                $submission['submitted_at_formatted'] = $date->format('M d, Y h:i A');
            }
            if (isset($submission['reviewed_date']) && $submission['reviewed_date']) {
                $date = new DateTime($submission['reviewed_date']);
                $submission['reviewed_at_formatted'] = $date->format('M d, Y h:i A');
            }
        }
        
        echo json_encode([
            'success' => true,
            'combined_reports' => $combinedReports,
            'submissions' => $submissions,
            'submission_count' => $submissionCount,
            'total_records' => $totalRecords
        ]);
        
    } catch (PDOException $e) {
        error_log("Error fetching all user reports: " . $e->getMessage());
        error_log("Stack trace: " . $e->getTraceAsString());
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => 'Database error: ' . $e->getMessage(),
            'error' => $e->getMessage(),
            'code' => $e->getCode(),
            'file' => $e->getFile(),
            'line' => $e->getLine()
        ]);
    } catch (Exception $e) {
        error_log("Unexpected error in getAllUserReports: " . $e->getMessage());
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => 'Error: ' . $e->getMessage(),
            'file' => $e->getFile(),
            'line' => $e->getLine()
        ]);
    }
}
?>

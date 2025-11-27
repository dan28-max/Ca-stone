<?php
/**
 * Report Submission API
 * Handles user report submissions and stores them for admin review
 */

// Disable display of errors - only log them
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL);

// Start output buffering to catch any unwanted output
ob_start();

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

class ReportSubmissionAPI {
    private $db;
    
    public function __construct() {
        try {
            $this->db = getDB();
            if (!$this->db) {
                throw new Exception('Database connection returned null');
            }
        } catch (Exception $e) {
            error_log("Database connection error in constructor: " . $e->getMessage());
            // Don't call sendError here - it might fail if class isn't ready
            // Store error and handle in the method that needs DB
            $this->db = null;
        } catch (Error $e) {
            error_log("Fatal database connection error in constructor: " . $e->getMessage());
            $this->db = null;
        }
    }

    /**
     * Attempt to find an existing table by normalizing and using aliases.
     */
    private function findExistingTable($tableName) {
        try {
            $tables = [];
            $stmt = $this->db->query("SHOW TABLES");
            while ($row = $stmt->fetch(PDO::FETCH_NUM)) {
                $tables[] = $row[0];
            }
            if (empty($tables)) return null;
            $norm = function($s) {
                $s = strtolower(trim($s));
                $s = preg_replace('/\\btable\\b/', '', $s);
                $s = str_replace([' ', '_', '-', '`'], '', $s);
                return $s;
            };
            $aliases = [
                'admissiondata' => ['admissiondata','admissionsdata'],
                'enrollmentdata' => ['enrollmentdata','enrolmentdata'],
                'graduatesdata' => ['graduatesdata','graduate'],
                'employee' => ['employee','employeedata'],
                'leaveprivilege' => ['leaveprivilege','leaveprivileges'],
                'libraryvisitor' => ['libraryvisitor','libraryvisitors'],
                'pwd' => ['pwd','pwddata'],
                'waterconsumption' => ['waterconsumption','waterusage'],
                'treatedwastewater' => ['treatedwastewater','wastewatertreated'],
                'electricityconsumption' => ['electricityconsumption','powerconsumption','electricconsumption'],
                'solidwaste' => ['solidwaste','waste'],
                'campuspopulation' => ['campuspopulation','population'],
                'foodwaste' => ['foodwaste'],
                'fuelconsumption' => ['fuelconsumption'],
                'distancetraveled' => ['distancetraveled','distancetravelled'],
                'budgetexpenditure' => ['budgetexpenditure','budgetexpenses','expenditure'],
                'flightaccommodation' => ['flightaccommodation','flightaccommodations']
            ];
            $targetKey = $norm($tableName);
            foreach ($tables as $t) { if ($norm($t) === $targetKey) return $t; }
            foreach ($tables as $t) {
                $k = $norm($t);
                foreach ($aliases as $canon => $syns) {
                    if (in_array($targetKey, $syns, true) && $k === $canon) return $t;
                }
            }
            foreach ($tables as $t) {
                $k = $norm($t);
                if (strpos($k, $targetKey) !== false || strpos($targetKey, $k) !== false) return $t;
            }
            return null;
        } catch (Exception $e) {
            error_log('findExistingTable error: ' . $e->getMessage());
            return null;
        }
    }
    
    /**
     * Check if database is available
     */
    private function checkDatabase() {
        if (!$this->db) {
            $this->sendError('Database connection failed', 500);
            return false;
        }
        return true;
    }

    /**
     * Submit report data
     */
    public function submitReport() {
        // Check database connection first
        if (!$this->checkDatabase()) {
            return; // sendError already called
        }
        
        // Check authentication - allow fallback for testing
        $userId = $_SESSION['user_id'] ?? null;
        
        // Get user data from session first
        $user = [
            'id' => $userId ?? 1,
            'name' => $_SESSION['username'] ?? 'Test User',
            'email' => $_SESSION['user_email'] ?? '',
            'role' => $_SESSION['user_role'] ?? 'user',
            'campus' => $_SESSION['user_campus'] ?? '',
            'office' => $_SESSION['user_office'] ?? ''
        ];
        
        // Fallback: Get office from URL parameters if not in session
        if (empty($user['office'])) {
            $user['office'] = $_GET['office'] ?? '';
        }
        
        // Fallback: Get campus from URL parameters if not in session
        if (empty($user['campus'])) {
            $user['campus'] = $_GET['campus'] ?? '';
        }
        
        // Verify user has office assigned
        if (empty($user['office'])) {
            error_log('No office found in session or URL parameters');
            error_log('Session data: ' . print_r($_SESSION, true));
            error_log('GET parameters: ' . print_r($_GET, true));
            $this->sendError('No office assigned to your account', 400);
        }
        
        error_log('User data for submission: ' . print_r($user, true));

        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->sendError('Method not allowed', 405);
        }

        $rawInput = file_get_contents('php://input');
        $input = json_decode($rawInput, true);
        
        // Add debugging
        error_log('Raw input: ' . $rawInput);
        error_log('Parsed input: ' . print_r($input, true));
        error_log('JSON decode error: ' . json_last_error_msg());
        
        if (!$input) {
            $this->sendError('Invalid JSON input: ' . json_last_error_msg());
        }

        // Validate required fields
        if (!isset($input['tableName']) || !isset($input['data'])) {
            $this->sendError('Missing required fields: tableName and data');
        }

        $tableName = $input['tableName'];
        $data = $input['data'];
        $description = $input['description'] ?? '';

        if (empty($data) || !is_array($data)) {
            $this->sendError('No data provided or invalid data format');
        }

        try {
            $this->db->beginTransaction();

            // Insert into the intended target table first (critical path)
            error_log("About to insert into target table: $tableName");
            $batchId = $this->insertIntoTargetTable($tableName, $data, $user);
            error_log("Successfully inserted into target table with batch_id: $batchId");

            // Create submission tracking record and keep a JSON copy as audit trail
            $submissionId = null;
            try {
                $input['batch_id'] = $batchId;
                $submissionId = $this->createSubmission($user, $tableName, $description, $input);
                $this->storeSubmissionData($submissionId, $data);
                error_log("Successfully created submission tracking record");
            } catch (Exception $e) {
                error_log("Could not create submission tracking (non-critical): " . $e->getMessage());
            }

            $this->db->commit();
            error_log("Transaction committed successfully");

            // Update table_assignments status to 'completed' after successful submission
            // 1) Strongest: if task_id is provided, complete that exact assignment row
            try {
                $taskId = $_GET['task_id'] ?? ($input['task_id'] ?? null);
                if ($taskId && is_numeric($taskId)) {
                    $updById = $this->db->prepare("UPDATE table_assignments SET status='completed', updated_at=NOW() WHERE id = ?");
                    $updById->execute([$taskId]);
                    error_log("Completed assignment by id: $taskId (rows: " . $updById->rowCount() . ")");
                }
            } catch (Exception $e) {
                error_log("Failed to complete assignment by id: " . $e->getMessage());
            }

            // 2) Fallback: complete by table + office/campus variants
            // Match by both office name and office+campus combination to handle all assignment formats
            try {
                $userOffice = trim($user['office'] ?? '');
                $userCampus = trim($user['campus'] ?? '');
                $officeCampusCombo = !empty($userCampus) ? trim($userOffice . ' ' . $userCampus) : $userOffice;
                
                // Try to match by office+campus combo first, then by office name
                $updateStmt = $this->db->prepare("
                    UPDATE table_assignments 
                    SET status = 'completed' 
                    WHERE table_name = ? 
                    AND status = 'active'
                    AND (
                        LOWER(TRIM(assigned_office)) = LOWER(?)
                        OR LOWER(TRIM(assigned_office)) = LOWER(?)
                    )
                ");
                $updateStmt->execute([$tableName, $officeCampusCombo, $userOffice]);
                $updated = $updateStmt->rowCount();
                error_log("Updated $updated table_assignments to completed for table: $tableName, office: $userOffice, campus: $userCampus");
            } catch (Exception $e) {
                error_log("Failed to update table_assignments status: " . $e->getMessage());
            }
            
            // Log activity
            $this->logActivity($user['id'], 'report_submission', "Submitted report: " . $this->formatTableName($tableName) . " (" . count($data) . " records)");
            
            $this->sendSuccess([
                'submission_id' => $submissionId ?? 'direct',
                'message' => 'Report submitted successfully',
                'records_count' => count($data),
                'table' => $tableName
            ]);

        } catch (Exception $e) {
            $this->db->rollBack();
            error_log("Report submission error: " . $e->getMessage());
            $this->sendError('Failed to submit report: ' . $e->getMessage());
        }
    }

    /**
     * Create submission record
     */
    private function createSubmission($user, $tableName, $description, $input = []) {
        // Check which columns exist in report_submissions table
        $columnsCheck = $this->db->query("SHOW COLUMNS FROM report_submissions");
        $existingColumns = [];
        while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
            $existingColumns[] = $col['Field'];
        }
        
        error_log("report_submissions columns: " . implode(', ', $existingColumns));
        
        // Build INSERT query based on existing columns
        $columns = [];
        $values = [];
        $placeholders = [];
        
        // Try to find the assignment_id if the column exists
        $assignmentId = null;
        if (in_array('assignment_id', $existingColumns)) {
            // First check if task_id was provided in URL or input
            $taskId = $_GET['task_id'] ?? ($input['task_id'] ?? null);
            
            // Try to find or create a matching report_assignments record
            try {
                // Check if report_assignments table exists
                $tableCheck = $this->db->query("SHOW TABLES LIKE 'report_assignments'");
                if ($tableCheck->rowCount() > 0) {
                    // Get columns in report_assignments table
                    $raColumnsCheck = $this->db->query("SHOW COLUMNS FROM report_assignments");
                    $raColumns = [];
                    while ($col = $raColumnsCheck->fetch(PDO::FETCH_ASSOC)) {
                        $raColumns[] = $col['Field'];
                    }
                    error_log("report_assignments columns: " . implode(', ', $raColumns));
                    
                    // Build search query based on available columns
                    $searchCol = in_array('report_type', $raColumns) ? 'report_type' : 
                                (in_array('table_name', $raColumns) ? 'table_name' : null);
                    $officeCol = in_array('assigned_office', $raColumns) ? 'assigned_office' : 
                                (in_array('office', $raColumns) ? 'office' : null);
                    
                    if ($searchCol && $officeCol) {
                        // Look for existing report_assignment
                        $assignStmt = $this->db->prepare("
                            SELECT id FROM report_assignments 
                            WHERE $searchCol = ? AND LOWER($officeCol) = LOWER(?)
                            LIMIT 1
                        ");
                        $assignStmt->execute([$tableName, $user['office']]);
                        $assignment = $assignStmt->fetch(PDO::FETCH_ASSOC);
                        
                        if ($assignment) {
                            $assignmentId = $assignment['id'];
                            error_log("Found report_assignments id: $assignmentId for table: $tableName, office: {$user['office']}");
                        } else {
                            // Create a new report_assignment record
                            error_log("Creating new report_assignments record for table: $tableName, office: {$user['office']}");
                            
                            // Build INSERT based on available columns
                            $insertCols = [$searchCol, $officeCol];
                            $insertVals = [$tableName, $user['office']];
                            $insertPlaceholders = ['?', '?'];
                            
                            if (in_array('assigned_date', $raColumns)) {
                                $insertCols[] = 'assigned_date';
                                $insertPlaceholders[] = 'NOW()';
                            } elseif (in_array('created_at', $raColumns)) {
                                $insertCols[] = 'created_at';
                                $insertPlaceholders[] = 'NOW()';
                            }
                            
                            if (in_array('status', $raColumns)) {
                                $insertCols[] = 'status';
                                $insertVals[] = 'active';
                                $insertPlaceholders[] = '?';
                            }
                            
                            $createSql = "INSERT INTO report_assignments (" . implode(', ', $insertCols) . ") 
                                         VALUES (" . implode(', ', $insertPlaceholders) . ")";
                            error_log("Creating report_assignment with SQL: $createSql");
                            
                            $createStmt = $this->db->prepare($createSql);
                            $createStmt->execute($insertVals);
                            $assignmentId = $this->db->lastInsertId();
                            error_log("Created report_assignments id: $assignmentId");
                        }
                    } else {
                        error_log("report_assignments table missing required columns (report_type/table_name and assigned_office/office)");
                    }
                } else {
                    error_log("report_assignments table does not exist");
                }
            } catch (Exception $e) {
                error_log("Error handling report_assignments: " . $e->getMessage());
                error_log("Stack trace: " . $e->getTraceAsString());
            }
            
            // Add assignment_id - use NULL if we couldn't get a valid one
            if ($assignmentId) {
                $columns[] = 'assignment_id';
                $values[] = $assignmentId;
                $placeholders[] = '?';
                error_log("Using assignment_id: $assignmentId");
            } else {
                // Set to NULL explicitly since column is now nullable
                $columns[] = 'assignment_id';
                $values[] = null;
                $placeholders[] = '?';
                error_log("Setting assignment_id to NULL (no valid assignment found)");
            }
        }
        
        // Add table_name or report_type
        if (in_array('table_name', $existingColumns)) {
            $columns[] = 'table_name';
            $values[] = $tableName;
            $placeholders[] = '?';
        } elseif (in_array('report_type', $existingColumns)) {
            $columns[] = 'report_type';
            $values[] = $tableName;
            $placeholders[] = '?';
        }
        
        // Add campus if exists
        if (in_array('campus', $existingColumns)) {
            $columns[] = 'campus';
            $values[] = $user['campus'];
            $placeholders[] = '?';
        }
        
        // Add office if exists
        if (in_array('office', $existingColumns)) {
            $columns[] = 'office';
            $values[] = $user['office'];
            $placeholders[] = '?';
        }
        
        // Add batch_id if column exists - this is needed to match records in target tables
        // The batch_id is created in insertIntoTargetTable() and passed here
        if (in_array('batch_id', $existingColumns) && isset($input['batch_id'])) {
            $columns[] = 'batch_id';
            $values[] = $input['batch_id'];
            $placeholders[] = '?';
        }
        
        // Add description if exists
        if (in_array('description', $existingColumns)) {
            $columns[] = 'description';
            $values[] = $description;
            $placeholders[] = '?';
        }
        
        // Add status if exists
        if (in_array('status', $existingColumns)) {
            $columns[] = 'status';
            $values[] = 'pending';
            $placeholders[] = '?';
        }
        
        // Add user_id or submitted_by if column exists
        if (in_array('user_id', $existingColumns)) {
            $columns[] = 'user_id';
            $values[] = $user['id'];
            $placeholders[] = '?';
        } elseif (in_array('submitted_by', $existingColumns)) {
            $columns[] = 'submitted_by';
            $values[] = $user['id'];
            $placeholders[] = '?';
        }
        
        // Add submission_date or submitted_at if they exist
        if (in_array('submission_date', $existingColumns)) {
            $columns[] = 'submission_date';
            $placeholders[] = 'NOW()';
        } elseif (in_array('submitted_at', $existingColumns)) {
            $columns[] = 'submitted_at';
            $placeholders[] = 'NOW()';
        } elseif (in_array('created_at', $existingColumns)) {
            $columns[] = 'created_at';
            $placeholders[] = 'NOW()';
        }
        
        if (empty($columns)) {
            throw new Exception("No valid columns found in report_submissions table");
        }
        
        $sql = "INSERT INTO report_submissions 
                (" . implode(', ', $columns) . ") 
                VALUES (" . implode(', ', $placeholders) . ")";
        
        error_log("Creating submission with SQL: $sql");
        error_log("Values: " . print_r($values, true));
        
        $stmt = $this->db->prepare($sql);
        $stmt->execute($values);

        $submissionId = $this->db->lastInsertId();
        
        // Automatically deactivate the table assignment after successful submission
        $this->deactivateTableAssignment($tableName, $user['office']);
        
        return $submissionId;
    }

    /**
     * Store submission data rows
     */
    private function storeSubmissionData($submissionId, $data) {
        $sql = "INSERT INTO report_submission_data (submission_id, row_data) VALUES (?, ?)";
        $stmt = $this->db->prepare($sql);

        // Get user campus from session
        $userCampus = $_SESSION['user_campus'] ?? '';
        
        // If campus is empty, try to get from user record
        if (empty($userCampus)) {
            try {
                $userId = $_SESSION['user_id'] ?? null;
                if ($userId) {
                    $userStmt = $this->db->prepare("SELECT campus FROM users WHERE id = ?");
                    $userStmt->execute([$userId]);
                    $userInfo = $userStmt->fetch(PDO::FETCH_ASSOC);
                    if ($userInfo && !empty($userInfo['campus'])) {
                        $userCampus = $userInfo['campus'];
                    }
                }
            } catch (Exception $e) {
                error_log("Error fetching user campus: " . $e->getMessage());
            }
        }

        foreach ($data as $row) {
            // Ensure campus field is set in each row data
            // Check for various possible campus field names (case-insensitive)
            $campusSet = false;
            foreach ($row as $key => $value) {
                if (strtolower($key) === 'campus' && !empty(trim($value))) {
                    $campusSet = true;
                    break;
                }
            }
            
            // If campus is not set or empty, auto-fill with user's campus
            if (!$campusSet && !empty($userCampus)) {
                // Try to set campus field (case-insensitive key search)
                $campusKey = null;
                foreach (array_keys($row) as $key) {
                    if (strtolower($key) === 'campus') {
                        $campusKey = $key;
                        break;
                    }
                }
                
                if ($campusKey) {
                    // Update existing campus field
                    $row[$campusKey] = $userCampus;
                } else {
                    // Add campus field if it doesn't exist
                    $row['Campus'] = $userCampus;
                }
                
                error_log("Auto-filled campus field with user campus: $userCampus");
            }
            
            $stmt->execute([$submissionId, json_encode($row)]);
        }
    }

    /**
     * Insert data directly into the target table
     */
    private function insertIntoTargetTable($tableName, $data, $user) {
        error_log("=== Starting insertIntoTargetTable for table: $tableName ===");
        error_log("Data to insert: " . print_r($data, true));
        error_log("User info: " . print_r($user, true));
        
        // Resolve table name
        $resolved = $this->findExistingTable($tableName);
        if (!$resolved) {
            $errorMsg = "Target table '$tableName' does not exist (after normalization attempts)";
            error_log($errorMsg);
            throw new Exception($errorMsg);
        }
        if ($resolved !== $tableName) {
            error_log("Resolved table name '$tableName' -> '$resolved'");
            $tableName = $resolved;
        }

        // Get columns
        $columnsCheck = $this->db->query("SHOW COLUMNS FROM `$tableName`");
        $tableColumns = [];
        while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
            $tableColumns[] = $col['Field'];
        }
        error_log("Target table '$tableName' columns: " . implode(', ', $tableColumns));

        // Unique batch id
        $uniqueBatchId = date('YmdHis') . '_' . uniqid() . '_' . ($user['office'] ?? '');

        foreach ($data as $row) {
            $columns = [];
            $placeholders = [];
            $values = [];
            // Column name mapping: display names -> database column names
            $columnNameMapping = [
                'Price/m^3' => 'price_per_m3',
                'price/m^3' => 'price_per_m3',
                'Price/m3' => 'price_per_m3',
                'price/m3' => 'price_per_m3',
                'Quantity (m^3)' => 'quantity_m3',
                'quantity (m^3)' => 'quantity_m3',
                'Quantity (m3)' => 'quantity_m3',
                'quantity (m3)' => 'quantity_m3',
                'Price/kWh' => 'price_per_kwh',
                'price/kwh' => 'price_per_kwh',
                'Prev Reading' => 'prev_reading',
                'prev reading' => 'prev_reading',
                'Current Reading' => 'current_reading',
                'current reading' => 'current_reading',
                'Total Amount' => 'total_amount',
                'total amount' => 'total_amount',
                'Visit Date' => 'visit_date',
                'visit date' => 'visit_date',
                'Total Visitors' => 'total_visitors',
                'total visitors' => 'total_visitors',
                'Graduate/Undergrad' => 'graduate_undergrad',
                'Program/Course' => 'program_course',
                'Category/Total No. of Applicants' => 'category',
                'Date Generated' => 'date_generated',
                'Data Generated' => 'date_generated',  // Employee form uses "Data Generated"
                'date generated' => 'date_generated',
                'Faculty Rank' => 'faculty_rank',
                'Faculty Rank/Designation' => 'faculty_rank',  // Employee form uses "Faculty Rank/Designation"
                'faculty rank' => 'faculty_rank',
                'faculty rank/designation' => 'faculty_rank',
                'Employee Status' => 'status',  // Employee form uses "Employee Status"
                'employee status' => 'status',
                'Status' => 'status',
                'status' => 'status',
                'Employment Status' => 'status',  // Alternative form field name
                'Date Hired' => 'date_hired',
                'date hired' => 'date_hired',
                'Leave Type' => 'leave_type',
                'Employee Name' => 'employee_name',
                'Duration Days' => 'duration_days',
                'Equivalent Pay' => 'equivalent_pay',
                'Academic Year' => 'academic_year',
                'Degree Level' => 'degree_level',
                'Subject Area' => 'subject_area',
                'Waste Type' => 'waste_type',
                'Treated Volume' => 'treated_volume',
                'Reused Volume' => 'reused_volume',
                'Effluent Volume' => 'effluent_volume',
                'Actual Consumption' => 'actual_consumption',
                'Total Consumption' => 'total_consumption'
            ];
            
            // PWD table mappings - now uses correct column names
            if (strtolower($tableName) === 'pwd') {
                // Direct mapping to correct database column names
                $columnNameMapping['Type of Disability'] = 'type_of_disability';
                $columnNameMapping['type of disability'] = 'type_of_disability';
                $columnNameMapping['No. of PWD Students'] = 'no_of_pwd_students';
                $columnNameMapping['no. of pwd students'] = 'no_of_pwd_students';
                $columnNameMapping['No. of PWD Employees'] = 'no_of_pwd_employees';
                $columnNameMapping['no. of pwd employees'] = 'no_of_pwd_employees';
            }
            
            // Flight Accommodation table mappings
            if (strtolower($tableName) === 'flightaccommodation') {
                // Map form field names to database column names
                $columnNameMapping['Office/Department'] = 'department';
                $columnNameMapping['office/department'] = 'department';
                $columnNameMapping['Name of Traveller'] = 'traveler';
                $columnNameMapping['name of traveller'] = 'traveler';
                $columnNameMapping['Event Name/Purpose of Travel'] = 'purpose';
                $columnNameMapping['event name/purpose of travel'] = 'purpose';
                $columnNameMapping['Travel Date (mm/dd/yyyy)'] = 'travel_date';
                $columnNameMapping['travel date (mm/dd/yyyy)'] = 'travel_date';
                $columnNameMapping['travel date'] = 'travel_date';
                $columnNameMapping['Domestic/International'] = 'domestic_international';
                $columnNameMapping['domestic/international'] = 'domestic_international';
                $columnNameMapping['Origin Info or IATA code'] = 'origin_info';
                $columnNameMapping['origin info or iata code'] = 'origin_info';
                $columnNameMapping['Destination Info or IATA code'] = 'destination_info';
                $columnNameMapping['destination info or iata code'] = 'destination_info';
                $columnNameMapping['Class'] = 'class';
                $columnNameMapping['class'] = 'class';
                $columnNameMapping['One Way/Round Trip'] = 'trip_type';
                $columnNameMapping['one way/round trip'] = 'trip_type';
                $columnNameMapping['kg CO2e'] = 'kg_co2e';
                $columnNameMapping['kg co2e'] = 'kg_co2e';
                $columnNameMapping['tCO2e'] = 'tco2e';
                $columnNameMapping['tco2e'] = 'tco2e';
            }
            
            foreach ($row as $key => $value) {
                $matched = false;
                
                // First, check direct mapping
                $dbColumnName = $columnNameMapping[$key] ?? null;
                if ($dbColumnName && in_array($dbColumnName, $tableColumns)) {
                    $columns[] = "`$dbColumnName`";
                    $placeholders[] = '?';
                    
                    // Debug: Log price, quantity, PWD values specifically
                    if ($dbColumnName === 'price_per_m3' || $dbColumnName === 'quantity_m3' || 
                        $dbColumnName === 'type_of_disability' ||
                        $dbColumnName === 'no_of_pwd_students' || $dbColumnName === 'no_of_pwd_employees') {
                        error_log("DEBUG: Column '$key' -> '$dbColumnName', Value: '$value' (Type: " . gettype($value) . ", Empty: " . (empty($value) ? 'YES' : 'NO') . ")");
                    }
                    
                    $values[] = $value;
                    $matched = true;
                    error_log("Matched column '$key' -> '$dbColumnName' via mapping with value: '$value'");
                } else {
                    // Try normalization matching (existing logic)
                    $normalizedKey = strtolower(str_replace([' ', '_', '(', ')', '/', '^', '.', '-'], '', $key));
                    foreach ($tableColumns as $tableCol) {
                        $normalizedTableCol = strtolower(str_replace(['_', ' ', '(', ')', '/', '^', '.', '-'], '', $tableCol));
                        if ($normalizedKey === $normalizedTableCol || strtolower($key) === strtolower($tableCol)) {
                            $columns[] = "`$tableCol`";
                            $placeholders[] = '?';
                            $values[] = $value;
                            $matched = true;
                            error_log("Matched column '$key' -> '$tableCol' via normalization");
                            break;
                        }
                    }
                }
                
                if (!$matched) {
                    error_log("WARNING: Could not match column '$key' to any table column. Available columns: " . implode(', ', $tableColumns));
                }
            }

            $columnNames = array_map(function($c) { return str_replace('`','',$c); }, $columns);
            if (in_array('campus', $tableColumns) && !in_array('campus', $columnNames)) {
                $columns[] = '`campus`';
                $placeholders[] = '?';
                $values[] = $user['campus'] ?? '';
            }
            if (in_array('office', $tableColumns) && !in_array('office', $columnNames)) {
                $columns[] = '`office`';
                $placeholders[] = '?';
                $values[] = $user['office'] ?? '';
            }
            if (in_array('batch_id', $tableColumns) && !in_array('batch_id', $columnNames)) {
                $columns[] = '`batch_id`';
                $placeholders[] = '?';
                $values[] = $uniqueBatchId;
            }
            if (in_array('submitted_by', $tableColumns) && !in_array('submitted_by', $columnNames)) {
                $columns[] = '`submitted_by`';
                $placeholders[] = '?';
                $values[] = ($user['name'] ?? $user['email'] ?? 'Unknown');
            }
            if (in_array('submitted_at', $tableColumns) && !in_array('submitted_at', $columnNames)) {
                $columns[] = '`submitted_at`';
                $placeholders[] = 'NOW()';
            }
            if (in_array('created_at', $tableColumns)) {
                $columns[] = '`created_at`';
                $placeholders[] = 'NOW()';
            }
            if (in_array('updated_at', $tableColumns)) {
                $columns[] = '`updated_at`';
                $placeholders[] = 'NOW()';
            }

            if (empty($columns)) {
                throw new Exception("No matching columns found for row data in table '$tableName'");
            }

            $sql = "INSERT INTO `$tableName` (" . implode(', ', $columns) . ") VALUES (" . implode(', ', $placeholders) . ")";
            error_log("Inserting into $tableName: $sql");
            error_log("Values: " . print_r($values, true));
            $stmt = $this->db->prepare($sql);
            $stmt->execute($values);
        }

        return $uniqueBatchId;
    }

    /**
     * Deactivate table assignment after user submission
     */
    private function deactivateTableAssignment($tableName, $office) {
        try {
            // Build a resilient match that handles:
            // - Plain office (e.g., "EMU")
            // - Office + campus (e.g., "EMU San Juan")
            // - Strings with the word "Office" included and extra spaces/casing
            $userCampus = $_SESSION['user_campus'] ?? '';
            $officeCampusCombo = trim($office . ' ' . $userCampus);

            $sql = "UPDATE table_assignments 
                    SET status = 'completed', updated_at = NOW() 
                    WHERE table_name = ?
                      AND status = 'active'
                      AND (
                          LOWER(TRIM(assigned_office)) = LOWER(TRIM(?))
                          OR LOWER(TRIM(assigned_office)) = LOWER(TRIM(?))
                          OR LOWER(TRIM(REPLACE(assigned_office, 'office', ''))) = LOWER(TRIM(REPLACE(?, 'office', '')))
                      )";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$tableName, $office, $officeCampusCombo, $office]);
            
            error_log("Deactivated assignment for table: $tableName, office variants matched: '{$office}' | '{$officeCampusCombo}'");
        } catch (Exception $e) {
            error_log("Failed to deactivate assignment: " . $e->getMessage());
        }
    }

    /**
     * Log user activity
     */
    private function logActivity($userId, $action, $description) {
        try {
            // Check if activity_logs table exists first
            $stmt = $this->db->query("SHOW TABLES LIKE 'activity_logs'");
            if ($stmt->rowCount() == 0) {
                error_log("Activity logs table does not exist, skipping logging");
                return;
            }
            
            $stmt = $this->db->prepare("
                INSERT INTO activity_logs (user_id, action, description, ip_address, user_agent) 
                VALUES (?, ?, ?, ?, ?)
            ");
            $stmt->execute([
                $userId,
                $action,
                $description,
                $_SERVER['REMOTE_ADDR'] ?? '',
                $_SERVER['HTTP_USER_AGENT'] ?? ''
            ]);
        } catch (PDOException $e) {
            error_log("Activity log error: " . $e->getMessage());
            // Don't throw the error, just log it
        }
    }

    /**
     * Send success response
     */
    private function sendSuccess($data) {
        // Clear any output that might have been sent
        ob_clean();
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'data' => $data
        ]);
        exit();
    }

    /**
     * Format table name for display
     */
    private function formatTableName($tableName) {
        $reportNames = [
            'admissiondata' => 'Admission Data',
            'enrollmentdata' => 'Enrollment Data',
            'graduatesdata' => 'Graduates Data',
            'employee' => 'Employee Data',
            'leaveprivilege' => 'Leave Privilege',
            'libraryvisitor' => 'Library Visitor',
            'pwd' => 'PWD',
            'pwddata' => 'PWD Data',
            'waterconsumption' => 'Water Consumption',
            'treatedwastewater' => 'Treated Waste Water',
            'electricityconsumption' => 'Electricity Consumption',
            'solidwaste' => 'Solid Waste',
            'campuspopulation' => 'Campus Population',
            'foodwaste' => 'Food Waste',
            'fuelconsumption' => 'Fuel Consumption',
            'distancetraveled' => 'Distance Traveled',
            'budgetexpenditure' => 'Budget Expenditure',
            'flightaccommodation' => 'Flight Accommodation'
        ];
        
        $tableNameLower = strtolower(trim($tableName));
        
        if (isset($reportNames[$tableNameLower])) {
            return $reportNames[$tableNameLower];
        }
        
        // Fallback: Convert snake_case or camelCase to Title Case
        $formatted = preg_replace('/([a-z])([A-Z])/', '$1 $2', $tableName);
        $formatted = str_replace('_', ' ', $formatted);
        $formatted = ucwords(strtolower($formatted));
        return $formatted ?: $tableName;
    }

    /**
     * Send error response
     */
    private function sendError($message, $code = 400) {
        // Clear any output that might have been sent
        ob_clean();
        error_log("API Error: $message (Code: $code)");
        http_response_code($code);
        echo json_encode(['success' => false, 'error' => $message]);
        exit();
    }
}

// Handle API requests
try {
    // Create API instance - check if constructor succeeded
    $api = null;
    try {
        $api = new ReportSubmissionAPI();
    } catch (Throwable $e) {
        ob_clean();
        error_log("Failed to create ReportSubmissionAPI instance: " . $e->getMessage());
        error_log("File: " . $e->getFile() . ", Line: " . $e->getLine());
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'error' => 'Failed to initialize API: ' . $e->getMessage()
        ]);
        exit();
    }
    
    if (!$api) {
        ob_clean();
        error_log("ReportSubmissionAPI instance is null");
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'error' => 'Failed to initialize API'
        ]);
        exit();
    }
    
    $action = $_GET['action'] ?? 'submit';

    switch ($action) {
        case 'submit':
            $api->submitReport();
            break;
        default:
            $api->sendError('Invalid action specified', 400);
    }
} catch (Exception $e) {
    // Catch any unexpected errors and return JSON
    ob_clean();
    $errorMessage = $e->getMessage();
    $errorFile = $e->getFile();
    $errorLine = $e->getLine();
    $errorTrace = $e->getTraceAsString();
    
    error_log("Unexpected error in submit_report.php: $errorMessage");
    error_log("File: $errorFile, Line: $errorLine");
    error_log("Stack trace: $errorTrace");
    
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'An unexpected error occurred. Please check server logs for details.',
        'debug_info' => [
            'message' => $errorMessage,
            'file' => basename($errorFile),
            'line' => $errorLine
        ]
    ]);
    exit();
} catch (Error $e) {
    // Catch fatal errors too
    ob_clean();
    $errorMessage = $e->getMessage();
    $errorFile = $e->getFile();
    $errorLine = $e->getLine();
    $errorTrace = $e->getTraceAsString();
    
    error_log("Fatal error in submit_report.php: $errorMessage");
    error_log("File: $errorFile, Line: $errorLine");
    error_log("Stack trace: $errorTrace");
    
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'A fatal error occurred. Please check server logs for details.',
        'debug_info' => [
            'message' => $errorMessage,
            'file' => basename($errorFile),
            'line' => $errorLine
        ]
    ]);
    exit();
}
?>

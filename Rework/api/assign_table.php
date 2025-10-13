<?php
/**
 * Table Assignment API
 * Handles assigning empty table structures to offices for user data entry
 */

// Clean output buffer and set headers first
ob_clean();
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Suppress error display to prevent HTML output
error_reporting(E_ALL);
ini_set('display_errors', 0);
ini_set('log_errors', 1);

// Handle preflight requests
if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    // Include database configuration
    require_once __DIR__ . '/../config/database.php';
    require_once __DIR__ . '/../includes/functions.php';

    // Temporarily disable authentication for testing
    session_start();
    
    // Set default session values for testing
    if (!isset($_SESSION['user_id'])) {
        $_SESSION['user_id'] = 602; // Default admin ID
        $_SESSION['user_role'] = 'admin';
        $_SESSION['session_id'] = 'test_session_' . time();
    }
    
    $pdo = getDB();
    error_log("Admin assignment API accessed by user: " . $_SESSION['user_id']);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error: ' . $e->getMessage()]);
    exit();
}

// Table structures mapping
$tableStructures = [
    'admissiondata' => ["Campus", "Semester", "Academic Year", "Category", "Program", "Male", "Female"],
    'enrollmentdata' => ["Campus", "Academic Year", "Semester", "College", "Graduate/Undergrad", "Program/Course", "Male", "Female"],
    'graduatesdata' => ["Campus", "Academic Year", "Semester", "Degree Level", "Subject Area", "Course", "Category/Total No. of Applicants", "Male", "Female"],
    'employee' => ["Campus", "Date Generated", "Category", "Faculty Rank", "Sex", "Status", "Date Hired"],
    'leaveprivilege' => ["Campus", "Leave Type", "Employee Name", "Duration Days", "Equivalent Pay"],
    'libraryvisitor' => ["Campus", "Visit Date", "Category", "Sex", "Total Visitors"],
    'pwd' => ["Campus", "Year", "No. of PWD Students", "No. of PWD Employees", "Type of Disability", "Sex"],
    'waterconsumption' => ["Campus", "Date", "Category", "Prev Reading", "Current Reading", "Quantity (m^3)", "Total Amount", "Price/m^3", "Month", "Year", "Remarks"],
    'treatedwastewater' => ["Campus", "Date", "Treated Volume", "Reused Volume", "Effluent Volume"],
    'electricityconsumption' => ["Campus", "Category", "Month", "Year", "Prev Reading", "Current Reading", "Actual Consumption", "Multiplier", "Total Consumption", "Total Amount", "Price/kWh", "Remarks"],
    'solidwaste' => ["Campus", "Month", "Year", "Waste Type", "Quantity", "Remarks"],
    'campuspopulation' => ["Campus", "Year", "Students", "IS Students", "Employees", "Canteen", "Construction", "Total"],
    'foodwaste' => ["Campus", "Date", "Quantity (kg)", "Remarks"],
    'fuelconsumption' => ["Campus", "Date", "Driver", "Vehicle", "Plate No", "Fuel Type", "Description", "Transaction No", "Odometer", "Qty", "Total Amount"],
    'distancetraveled' => ["Campus", "Travel Date", "Plate No", "Vehicle", "Fuel Type", "Start Mileage", "End Mileage", "Total KM"],
    'budgetexpenditure' => ["Campus", "Year", "Particulars", "Category", "Budget Allocation", "Actual Expenditure", "Utilization Rate"],
    'flightaccommodation' => ["Campus", "Department", "Year", "Traveler", "Purpose", "From", "To", "Country", "Type", "Rooms", "Nights"]
];

if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        // Get JSON input
        $rawInput = file_get_contents('php://input');
        error_log("Received assignment request: " . $rawInput);
        
        $input = json_decode($rawInput, true);
        
        if (!$input) {
            error_log("Failed to decode JSON: " . json_last_error_msg());
            throw new Exception('Invalid JSON input: ' . json_last_error_msg());
        }
        
        error_log("Decoded input: " . print_r($input, true));

        // Check if this is a batch assignment (multiple reports and offices)
        if (isset($input['reports']) && isset($input['offices'])) {
            // Batch assignment
            $reports = $input['reports'];
            $offices = $input['offices'];
            
            if (!is_array($reports) || !is_array($offices)) {
                throw new Exception('Reports and offices must be arrays');
            }
            
            if (empty($reports) || empty($offices)) {
                throw new Exception('Please select at least one report and one office');
            }
            
            $successCount = 0;
            $errors = [];
            
            // Assign each report to each office
            foreach ($reports as $reportTable) {
                // Validate report table
                if (!array_key_exists($reportTable, $tableStructures)) {
                    $errors[] = "Invalid report table: {$reportTable}";
                    continue;
                }
                
                foreach ($offices as $officeId) {
                    // Determine if officeId is a user ID (integer) or office name (string)
                    if (is_numeric($officeId)) {
                        // Get office details from user ID
                        $officeStmt = $pdo->prepare("SELECT office, campus FROM users WHERE id = ? LIMIT 1");
                        $officeStmt->execute([$officeId]);
                        $officeData = $officeStmt->fetch(PDO::FETCH_ASSOC);
                        
                        if (!$officeData) {
                            $errors[] = "Office not found: ID {$officeId}";
                            continue;
                        }
                        
                        $assignedOffice = $officeData['office'];
                    } else {
                        // Use office name directly
                        $assignedOffice = $officeId;
                    }
                    
                    // Check if already assigned
                    if (isTableAlreadyAssigned($reportTable, $assignedOffice)) {
                        // Reactivate existing assignment
                        $reactivateStmt = $pdo->prepare("UPDATE table_assignments SET status = 'active', assigned_date = NOW(), assigned_by = ? WHERE table_name = ? AND assigned_office = ?");
                        $reactivateStmt->execute([$_SESSION['user_id'], $reportTable, $assignedOffice]);
                        $successCount++;
                    } else {
                        // Create new assignment
                        if (createTableAssignment($reportTable, $assignedOffice, '', $_SESSION['user_id'])) {
                            // Try to log activity, but don't fail if it errors
                            try {
                                logActivity('table_assignment', "Assigned {$reportTable} table to {$assignedOffice}", $_SESSION['user_id']);
                            } catch (Exception $e) {
                                error_log("Activity logging failed: " . $e->getMessage());
                            }
                            $successCount++;
                        } else {
                            $errors[] = "Failed to assign {$reportTable} to {$assignedOffice}";
                        }
                    }
                }
            }
            
            $response = [
                'success' => $successCount > 0,
                'message' => "Successfully assigned {$successCount} report(s)",
                'assigned_count' => $successCount
            ];
            
            if (!empty($errors)) {
                $response['errors'] = $errors;
            }
            
            echo json_encode($response);
            exit();
        }
        
        // Single assignment (legacy support)
        if (!isset($input['reportTable']) || !isset($input['assignedOffice'])) {
            throw new Exception('Missing required fields: reportTable and assignedOffice');
        }

        $reportTable = $input['reportTable'];
        $assignedOffice = $input['assignedOffice'];
        $description = $input['description'] ?? '';

        // Validate report table
        if (!array_key_exists($reportTable, $tableStructures)) {
            throw new Exception('Invalid report table selected');
        }

        // Check if table is already assigned to this office with active status
        if (isTableAlreadyAssigned($reportTable, $assignedOffice)) {
            // Instead of blocking, reactivate the existing assignment
            $reactivateStmt = $pdo->prepare("UPDATE table_assignments SET status = 'active', assigned_date = NOW(), assigned_by = ? WHERE table_name = ? AND assigned_office = ?");
            $reactivateStmt->execute([$_SESSION['user_id'], $reportTable, $assignedOffice]);
            
            echo json_encode([
                'success' => true,
                'message' => 'Table assignment reactivated successfully',
                'data' => [
                    'table' => $reportTable,
                    'office' => $assignedOffice,
                    'columns' => $tableStructures[$reportTable]
                ]
            ]);
            exit();
        }

        // Create table assignment
        $result = createTableAssignment($reportTable, $assignedOffice, $description, $_SESSION['user_id']);

        if ($result) {
            // Try to log the assignment activity
            try {
                logActivity('table_assignment', "Assigned {$reportTable} table to {$assignedOffice}", $_SESSION['user_id']);
            } catch (Exception $e) {
                error_log("Activity logging failed: " . $e->getMessage());
            }
            
            echo json_encode([
                'success' => true,
                'message' => 'Table assigned successfully',
                'data' => [
                    'table' => $reportTable,
                    'office' => $assignedOffice,
                    'columns' => $tableStructures[$reportTable]
                ]
            ]);
        } else {
            throw new Exception('Failed to assign table');
        }

    } catch (Exception $e) {
        http_response_code(400);
        echo json_encode([
            'success' => false,
            'message' => $e->getMessage(),
            'error' => $e->getMessage()
        ]);
    } catch (Error $e) {
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => 'Server error: ' . $e->getMessage(),
            'error' => $e->getMessage()
        ]);
    }
} else {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
}

/**
 * Check if table is already assigned to office
 */
function isTableAlreadyAssigned($tableName, $office) {
    $pdo = getDB();
    
    try {
        $sql = "SELECT COUNT(*) FROM table_assignments 
                WHERE table_name = :table_name 
                AND assigned_office = :office 
                AND status = 'active'";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'table_name' => $tableName,
            'office' => $office
        ]);
        
        return $stmt->fetchColumn() > 0;
    } catch (PDOException $e) {
        error_log("Error checking table assignment: " . $e->getMessage());
        return false;
    }
}

/**
 * Create table assignment
 */
function createTableAssignment($tableName, $assignedOffice, $description, $assignedBy) {
    $pdo = getDB();
    
    try {
        $pdo->beginTransaction();

        // Insert into table_assignments
        $sql = "INSERT INTO table_assignments (table_name, assigned_office, description, assigned_by, assigned_date, status) 
                VALUES (:table_name, :assigned_office, :description, :assigned_by, NOW(), 'active')";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'table_name' => $tableName,
            'assigned_office' => $assignedOffice,
            'description' => $description,
            'assigned_by' => $assignedBy
        ]);

        $pdo->commit();
        return true;

    } catch (PDOException $e) {
        $pdo->rollBack();
        error_log("Table assignment error: " . $e->getMessage());
        return false;
    }
}

?>


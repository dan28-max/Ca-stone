<?php
/**
 * Get Import Tables API
 * Returns list of tables that the current user can import data to
 */

session_start();

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'error' => 'Unauthorized. Please log in.']);
    exit();
}

try {
    require_once __DIR__ . '/../config/database.php';
    require_once __DIR__ . '/../includes/functions.php';
    
    $pdo = getDB();
    $userId = $_SESSION['user_id'];
    
    // Get user's office and campus
    $userInfo = getUserOfficeAndCampus($userId);
    if (!$userInfo || !$userInfo['office']) {
        echo json_encode([
            'success' => true,
            'tables' => []
        ]);
        exit();
    }
    
    $userOffice = $userInfo['office'];
    $userCampus = $userInfo['campus'] ?? '';
    
    // Build office+campus combination
    $officeCampusCombo = trim($userOffice . ' ' . $userCampus);
    
    // Get distinct table names from table_assignments for this user's office
    $tables = [];
    
    // Query 1: Get tables from table_assignments
    try {
        $sql = "SELECT DISTINCT table_name 
                FROM table_assignments 
                WHERE status = 'active' 
                AND (
                    LOWER(TRIM(assigned_office)) = LOWER(:officeCampusCombo)
                    OR LOWER(TRIM(assigned_office)) = LOWER(:office)
                )";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'officeCampusCombo' => $officeCampusCombo,
            'office' => $userOffice
        ]);
        $assignedTables = $stmt->fetchAll(PDO::FETCH_COLUMN);
        
        foreach ($assignedTables as $table) {
            if ($table && !in_array(strtolower($table), array_map('strtolower', $tables))) {
                $tables[] = $table;
            }
        }
    } catch (Exception $e) {
        error_log('Error fetching from table_assignments: ' . $e->getMessage());
    }
    
    // Query 2: Also check get_allowed_reports logic (office mapping)
    $officeReports = [
        "Registrar" => ["enrollmentdata", "graduatesdata"],
        "HRMO" => ["employee", "leaveprivilege"],
        "Library" => ["libraryvisitor"],
        "Library Services" => ["libraryvisitor"],
        "Health Services" => ["pwd"],
        "EMU" => ["waterconsumption", "treatedwastewater", "electricityconsumption", "solidwaste"],
        "RGO" => ["campuspopulation", "foodwaste"],
        "GSO" => ["fuelconsumption", "distancetraveled"],
        "TAO" => ["admissiondata"],
        "Budget Office" => ["budgetexpenditure"],
        "All" => ["flightaccommodation"]
    ];
    
    // Check if user's office has predefined reports
    if (isset($officeReports[$userOffice])) {
        foreach ($officeReports[$userOffice] as $table) {
            if (!in_array(strtolower($table), array_map('strtolower', $tables))) {
                $tables[] = $table;
            }
        }
    }
    
    // Remove duplicates and sort
    $tables = array_unique($tables);
    sort($tables);
    
    echo json_encode([
        'success' => true,
        'tables' => array_values($tables),
        'debug' => [
            'user_id' => $userId,
            'office' => $userOffice,
            'campus' => $userCampus,
            'officeCampusCombo' => $officeCampusCombo,
            'count' => count($tables)
        ]
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}


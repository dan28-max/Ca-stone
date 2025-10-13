<?php
/**
 * Get Offices API
 * Returns the list of all available offices grouped by campus
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    // Include database configuration
    require_once __DIR__ . '/../config/database.php';
    
    // Get database connection
    $database = new Database();
    $db = $database->getConnection();
    
    // Get distinct offices from users table with user IDs
    $query = "SELECT id, campus, office 
              FROM users 
              WHERE office IS NOT NULL AND office != '' 
              GROUP BY campus, office
              ORDER BY campus, office";
    
    $stmt = $db->prepare($query);
    $stmt->execute();
    
    $offices = [];
    
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $offices[] = [
            'id' => (int)$row['id'],
            'campus' => $row['campus'],
            'office_name' => $row['office']
        ];
    }
    
    // If no offices found in database, return default list with office names as IDs
    if (empty($offices)) {
        $offices = [
            ['id' => 'Registrar Office', 'campus' => 'Alangilan', 'office_name' => 'Registrar Office'],
            ['id' => 'Accounting Office', 'campus' => 'Alangilan', 'office_name' => 'Accounting Office'],
            ['id' => 'Admissions Office', 'campus' => 'Alangilan', 'office_name' => 'Admissions Office'],
            ['id' => 'Human Resources', 'campus' => 'Alangilan', 'office_name' => 'Human Resources'],
            ['id' => 'Library', 'campus' => 'Alangilan', 'office_name' => 'Library'],
            ['id' => 'Registrar Office', 'campus' => 'Pablo Borbon', 'office_name' => 'Registrar Office'],
            ['id' => 'Accounting Office', 'campus' => 'Pablo Borbon', 'office_name' => 'Accounting Office'],
            ['id' => 'Registrar Office', 'campus' => 'Lipa', 'office_name' => 'Registrar Office'],
            ['id' => 'Accounting Office', 'campus' => 'Lipa', 'office_name' => 'Accounting Office'],
            ['id' => 'Registrar Office', 'campus' => 'Nasugbu', 'office_name' => 'Registrar Office'],
            ['id' => 'Registrar Office', 'campus' => 'Balayan', 'office_name' => 'Registrar Office'],
            ['id' => 'Registrar Office', 'campus' => 'Malvar', 'office_name' => 'Registrar Office'],
            ['id' => 'Registrar Office', 'campus' => 'Lemery', 'office_name' => 'Registrar Office'],
            ['id' => 'Registrar Office', 'campus' => 'Lobo', 'office_name' => 'Registrar Office'],
            ['id' => 'Registrar Office', 'campus' => 'Mabini', 'office_name' => 'Registrar Office'],
            ['id' => 'Registrar Office', 'campus' => 'Rosario', 'office_name' => 'Registrar Office'],
            ['id' => 'Registrar Office', 'campus' => 'San Juan', 'office_name' => 'Registrar Office']
        ];
    }
    
    echo json_encode([
        'success' => true,
        'offices' => $offices
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'Server error: ' . $e->getMessage()
    ]);
}

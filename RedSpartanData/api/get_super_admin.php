<?php
/**
 * Get Super Admin Contact Information API
 * Returns contact information for super admin users
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
    
    // Start session if not already started
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }

    // Check if user is logged in
    if (!isset($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode([
            'success' => false,
            'message' => 'User not authenticated. Please log in.'
        ]);
        exit();
    }

    // Get database connection
    $db = getDB();
    
    if (!$db) {
        throw new Exception('Failed to connect to database');
    }

    // Get super admin users (role = 'super_admin' or campus = 'Main Campus')
    $query = "SELECT id, name, email, username, office, campus, role 
              FROM users 
              WHERE (role = 'super_admin' OR campus = 'Main Campus' OR campus = 'Main')
              AND status = 'active'
              ORDER BY name ASC
              LIMIT 5";
    
    $stmt = $db->prepare($query);
    $stmt->execute();
    $superAdmins = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Format the response
    $formattedAdmins = [];
    foreach ($superAdmins as $admin) {
        $formattedAdmins[] = [
            'id' => $admin['id'],
            'name' => $admin['name'] ?? 'Super Admin',
            'email' => $admin['email'] ?? $admin['username'] ?? 'N/A',
            'office' => $admin['office'] ?? 'N/A',
            'campus' => $admin['campus'] ?? 'Main Campus',
            'role' => $admin['role'] ?? 'super_admin'
        ];
    }
    
    echo json_encode([
        'success' => true,
        'data' => $formattedAdmins
    ]);
    
} catch (PDOException $e) {
    error_log("Database error in get_super_admin.php: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error occurred'
    ]);
} catch (Exception $e) {
    error_log("Error in get_super_admin.php: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Error fetching super admin information'
    ]);
}
?>


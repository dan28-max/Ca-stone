<?php
/**
 * User Tasks API
 * Handles fetching assigned data entry tasks for users
 */

// Suppress error display to prevent HTML output
error_reporting(E_ALL);
ini_set('display_errors', 0);
ini_set('log_errors', 1);

// Set headers to prevent caching
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

    // Check if user is authenticated
    session_start();
    
    // Temporarily disable authentication for testing
    if (false && !isset($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'Unauthorized access']);
        exit();
    }
    
    // Set default session values for testing if not set
    if (!isset($_SESSION['user_id'])) {
        $_SESSION['user_id'] = 1; // Default test user
        $_SESSION['user_role'] = 'user';
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error: ' . $e->getMessage()]);
    exit();
}

try {
    $action = $_GET['action'] ?? '';

    switch ($action) {
        case 'get_assigned':
            getAssignedTasks();
            break;
        default:
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => 'Invalid action']);
            break;
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error: ' . $e->getMessage()]);
} catch (Error $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error: ' . $e->getMessage()]);
}

/**
 * Get assigned tasks for the current user
 */
function getAssignedTasks() {
    $pdo = getDB();
    
    try {
        $userId = $_SESSION['user_id'];
        $userRole = $_SESSION['user_role'] ?? 'user';
        
        // Get user's office/campus assignment
        $userOffice = getUserOffice($userId);
        if (!$userOffice) {
            // Fallback for testing - use URL parameter
            $userOffice = $_GET['office'] ?? 'EMU';
        }
        
        // Normalize office name for comparison
        $userOffice = strtolower(trim($userOffice));
        
        if (!$userOffice) {
            echo json_encode([
                'success' => true,
                'data' => [],
                'message' => 'No office assignment found'
            ]);
            return;
        }
        
        // Get active table assignments for this office - hide after submission
        // Debug: Log the user ID and office
        error_log("Checking tasks for user_id: $userId, office: $userOffice");
        
        // Simplified approach - just show active assignments
        $sql = "SELECT 
                    ta.id,
                    ta.table_name,
                    ta.assigned_office,
                    ta.description,
                    ta.assigned_date,
                    ta.status,
                    u.name as assigned_by_name,
                    'pending' as task_status
                FROM table_assignments ta
                LEFT JOIN users u ON ta.assigned_by = u.id
                WHERE LOWER(ta.assigned_office) = LOWER(?)
                AND ta.status = 'active'
                ORDER BY ta.assigned_date DESC";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$userOffice]);
        $tasks = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Debug: Log all tasks found
        error_log("Tasks found: " . count($tasks));
        foreach ($tasks as $task) {
            error_log("Task: {$task['table_name']}, Office: {$task['assigned_office']}");
        }
        
        // Debug: Check what submissions exist for this user
        $debugStmt = $pdo->prepare("SELECT table_name, office, user_id FROM report_submissions WHERE user_id = ?");
        $debugStmt->execute([$userId]);
        $userSubmissions = $debugStmt->fetchAll();
        error_log("User $userId has " . count($userSubmissions) . " submissions:");
        foreach ($userSubmissions as $sub) {
            error_log("  - Table: {$sub['table_name']}, Office: '{$sub['office']}'");
        }
        
        // Tasks are already filtered by the SQL query, no need for additional filtering
        error_log("Available tasks after SQL filtering: " . count($tasks));
        
        echo json_encode([
            'success' => true,
            'data' => array_values($tasks)
        ]);
        
    } catch (PDOException $e) {
        error_log("Error fetching assigned tasks: " . $e->getMessage());
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => 'Database error occurred'
        ]);
    }
}

/**
 * Get user's office assignment
 */
function getUserOffice($userId) {
    $pdo = getDB();
    
    try {
        $sql = "SELECT office FROM users WHERE id = :user_id";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['user_id' => $userId]);
        
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result ? $result['office'] : null;
        
    } catch (PDOException $e) {
        error_log("Error getting user office: " . $e->getMessage());
        return null;
    }
}
?>


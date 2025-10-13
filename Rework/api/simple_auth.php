<?php
/**
 * Simple Authentication API for Spartan Data
 * Username-based authentication (no email)
 */

// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

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

// Start session
session_start();

// Get database connection
try {
    $db = getDB();
} catch (Exception $e) {
    sendError('Database connection failed: ' . $e->getMessage(), 500);
}

// Handle API requests
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'login':
        handleLogin($db);
        break;
    case 'logout':
        handleLogout();
        break;
    case 'check':
        checkAuth();
        break;
    default:
        sendError('Invalid action specified', 400);
}

/**
 * Handle login request
 */
function handleLogin($db) {
    // Only accept POST requests
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        sendError('Method not allowed', 405);
    }

    try {
        // Get and parse input
        $rawInput = file_get_contents('php://input');
        error_log("Raw input: " . $rawInput);
        
        $input = json_decode($rawInput, true);
        
        if (!$input) {
            error_log("Failed to parse JSON input, trying POST");
            $input = $_POST;
        }

        // Extract credentials
        $username = isset($input['username']) ? trim($input['username']) : '';
        $password = $input['password'] ?? '';
        
        error_log("Login attempt for username: $username");

        // Validate input
        if (empty($username) || empty($password)) {
            sendError('Username and password are required');
        }

        // Get user from database
        $stmt = $db->prepare("
            SELECT id, username, password, name, role, campus, office, status, last_login 
            FROM users 
            WHERE username = ?
        ");
        $stmt->execute([$username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            error_log("User not found: $username");
            sendError('Invalid credentials or account not found');
        }

        // Verify password
        if (!password_verify($password, $user['password'])) {
            error_log("Invalid password for user: $username");
            sendError('Invalid credentials');
        }

        // Update last login
        $stmt = $db->prepare("UPDATE users SET last_login = NOW() WHERE id = ?");
        $stmt->execute([$user['id']]);
        
        // Prepare user data for response (remove sensitive data)
        $userData = [
            'id' => $user['id'],
            'username' => $user['username'],
            'name' => $user['name'],
            'role' => $user['role'],
            'campus' => $user['campus'],
            'office' => $user['office']
        ];
        
        // Set session variables
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['username'] = $user['username'];
        $_SESSION['role'] = $user['role'];
        
        // Send success response
        sendResponse([
            'user' => $userData
        ]);
    } catch (Exception $e) {
        error_log("Login exception: " . $e->getMessage());
        sendError("Login failed: " . $e->getMessage());
    }
}

/**
 * Handle logout request
 */
function handleLogout() {
    // Clear session
    session_unset();
    session_destroy();
    
    sendResponse(['message' => 'Logged out successfully']);
}

/**
 * Check if user is authenticated
 */
function checkAuth() {
    if (isset($_SESSION['user_id'])) {
        sendResponse([
            'authenticated' => true,
            'user_id' => $_SESSION['user_id'],
            'username' => $_SESSION['username'] ?? '',
            'role' => $_SESSION['role'] ?? ''
        ]);
    } else {
        sendResponse([
            'authenticated' => false
        ]);
    }
}

/**
 * Send error response
 */
function sendError($message, $code = 400) {
    http_response_code($code);
    echo json_encode([
        'success' => false,
        'error' => $message
    ]);
    exit();
}

/**
 * Send success response
 */
function sendResponse($data) {
    echo json_encode([
        'success' => true,
        'data' => $data
    ]);
    exit();
}
?>
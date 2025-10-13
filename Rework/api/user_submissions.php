<?php
/**
 * User Submissions API
 * Handles fetching user's submission history
 */

// Start session first before any output
session_start();

// Suppress error display to prevent HTML output
error_reporting(E_ALL);
ini_set('display_errors', 0);
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
    
    // Temporarily disable authentication for testing
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
    $action = $_GET['action'] ?? 'get_submissions';

    switch ($action) {
        case 'get_submissions':
            getUserSubmissions();
            break;
        default:
            getUserSubmissions();
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
        $sql = "SELECT 
                    rs.id,
                    rs.table_name,
                    rs.office,
                    rs.campus,
                    rs.submission_date,
                    rs.status,
                    rs.description,
                    rs.reviewed_date,
                    u.name as submitted_by_name,
                    COUNT(rsd.id) as record_count
                FROM report_submissions rs
                LEFT JOIN users u ON rs.user_id = u.id
                LEFT JOIN report_submission_data rsd ON rs.id = rsd.submission_id
                WHERE rs.user_id = ?
                GROUP BY rs.id
                ORDER BY rs.submission_date DESC";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$userId]);
        $submissions = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
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
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => 'Database error occurred',
            'error' => $e->getMessage()
        ]);
    }
}
?>

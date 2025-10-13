<?php
/**
 * Report Submission API
 * Handles user report submissions and stores them for admin review
 */

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
        } catch (Exception $e) {
            $this->sendError('Database connection failed', 500);
        }
    }

    /**
     * Submit report data
     */
    public function submitReport() {
        // Skip authentication for testing
        // if (!isset($_SESSION['user_id']) || !isset($_SESSION['session_id'])) {
        //     $this->sendError('Not authenticated', 401);
        // }

        // Get office from URL parameter to match the user's current context
        $currentOffice = $_GET['office'] ?? 'emu';
        
        // Mock user data for testing - match the office format from assignments
        $user = [
            'id' => 1,
            'name' => 'Test User',
            'email' => 'test@example.com',
            'role' => 'user',
            'campus' => 'Main Campus',
            'office' => strtolower(trim($currentOffice))
        ];

        // Verify session in database (commented out for testing)
        // $stmt = $this->db->prepare("
        //     SELECT u.id, u.email, u.name, u.role, u.campus, u.office 
        //     FROM users u
        //     JOIN user_sessions s ON u.id = s.user_id
        //     WHERE s.session_id = ? AND s.expires_at > NOW() AND u.status = 'active'
        // ");
        // $stmt->execute([$_SESSION['session_id']]);
        // $user = $stmt->fetch();
        
        // if (!$user) {
        //     session_destroy();
        //     $this->sendError('Session expired or invalid', 401);
        // }

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

            // Create submission record
            $submissionId = $this->createSubmission($user, $tableName, $description);
            
            // Store the data rows
            $this->storeSubmissionData($submissionId, $data);

            $this->db->commit();

            // Update table_assignments status to 'inactive' after successful submission
            try {
                $updateStmt = $this->db->prepare("UPDATE table_assignments SET status = 'inactive' WHERE table_name = ? AND LOWER(assigned_office) = LOWER(?) AND status = 'active'");
                $updateStmt->execute([$tableName, $user['office']]);
                error_log("Updated table_assignments status to inactive for table: $tableName, office: " . $user['office']);
            } catch (Exception $e) {
                error_log("Failed to update table_assignments status: " . $e->getMessage());
            }
            
            // Log activity (optional - may fail if table doesn't exist)
            try {
                $activityStmt = $this->db->prepare("INSERT INTO user_activities (user_id, activity_type, description, timestamp) VALUES (?, 'report_submission', ?, NOW())");
                $activityStmt->execute([$user['id'], "Submitted report for table: $tableName"]);
            } catch (Exception $e) {
                error_log("Activity logging failed (non-critical): " . $e->getMessage());
            }
            
            $this->sendSuccess([
                'submission_id' => $submissionId,
                'message' => 'Report submitted successfully',
                'records_count' => count($data)
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
    private function createSubmission($user, $tableName, $description) {
        $sql = "INSERT INTO report_submissions 
                (user_id, table_name, campus, office, description, submission_date, status) 
                VALUES (?, ?, ?, ?, ?, NOW(), 'pending')";
        
        $stmt = $this->db->prepare($sql);
        $stmt->execute([
            $user['id'],
            $tableName,
            $user['campus'],
            $user['office'],
            $description
        ]);

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

        foreach ($data as $row) {
            $stmt->execute([$submissionId, json_encode($row)]);
        }
    }

    /**
     * Deactivate table assignment after user submission
     */
    private function deactivateTableAssignment($tableName, $office) {
        try {
            $sql = "UPDATE table_assignments 
                    SET status = 'completed', updated_at = NOW() 
                    WHERE table_name = ? AND assigned_office = ? AND status = 'active'";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$tableName, $office]);
            
            error_log("Deactivated assignment for table: $tableName, office: $office");
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
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'data' => $data
        ]);
        exit();
    }

    /**
     * Send error response
     */
    private function sendError($message, $code = 400) {
        error_log("API Error: $message (Code: $code)");
        http_response_code($code);
        echo json_encode(['success' => false, 'error' => $message]);
        exit();
    }
}

// Handle API requests
$api = new ReportSubmissionAPI();
$action = $_GET['action'] ?? 'submit';

switch ($action) {
    case 'submit':
        $api->submitReport();
        break;
    default:
        $api->sendError('Invalid action specified', 400);
}
?>

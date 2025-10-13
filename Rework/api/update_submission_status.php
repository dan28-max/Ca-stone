<?php
/**
 * Update Submission Status API
 * Updates the status of a submission (approve/reject)
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    require_once __DIR__ . '/../config/database.php';
    
    $input = json_decode(file_get_contents('php://input'), true);
    
    $submissionId = $input['submission_id'] ?? '';
    $batchId = $input['batch_id'] ?? '';
    $status = $input['status'] ?? '';
    
    // Extract submission ID from batch_id if needed
    if (empty($submissionId) && !empty($batchId)) {
        if (strpos($batchId, 'submission_') === 0) {
            $submissionId = str_replace('submission_', '', $batchId);
        }
    }
    
    if (empty($submissionId)) {
        throw new Exception('Submission ID is required');
    }
    
    if (!in_array($status, ['approved', 'rejected', 'pending'])) {
        throw new Exception('Invalid status. Must be: approved, rejected, or pending');
    }
    
    $database = new Database();
    $db = $database->getConnection();
    
    // Update submission status
    $query = "UPDATE report_submissions 
              SET status = :status, 
                  reviewed_date = NOW() 
              WHERE id = :id";
    
    $stmt = $db->prepare($query);
    $stmt->execute([
        'status' => $status,
        'id' => $submissionId
    ]);
    
    if ($stmt->rowCount() > 0) {
        echo json_encode([
            'success' => true,
            'message' => "Submission {$status} successfully",
            'submission_id' => $submissionId,
            'status' => $status
        ]);
    } else {
        throw new Exception('Submission not found or status unchanged');
    }
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}

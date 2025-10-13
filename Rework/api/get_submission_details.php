<?php
/**
 * Get Submission Details API
 * Fetches detailed records for a specific submission from report_submission_data
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

try {
    require_once __DIR__ . '/../config/database.php';
    
    $submissionId = $_GET['submission_id'] ?? '';
    $batchId = $_GET['batch_id'] ?? '';
    
    // Extract submission ID from batch_id if needed
    if (empty($submissionId) && !empty($batchId)) {
        if (strpos($batchId, 'submission_') === 0) {
            $submissionId = str_replace('submission_', '', $batchId);
        }
    }
    
    if (empty($submissionId)) {
        throw new Exception('Submission ID is required');
    }
    
    $database = new Database();
    $db = $database->getConnection();
    
    // Get submission details
    $query = "SELECT * FROM report_submissions WHERE id = :id";
    $stmt = $db->prepare($query);
    $stmt->execute(['id' => $submissionId]);
    $submission = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$submission) {
        throw new Exception('Submission not found');
    }
    
    // Get submission data
    $dataQuery = "SELECT row_data FROM report_submission_data WHERE submission_id = :submission_id ORDER BY id ASC";
    $dataStmt = $db->prepare($dataQuery);
    $dataStmt->execute(['submission_id' => $submissionId]);
    $rows = $dataStmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Decode JSON data
    $data = [];
    foreach ($rows as $row) {
        $data[] = json_decode($row['row_data'], true);
    }
    
    echo json_encode([
        'success' => true,
        'data' => $data,
        'submission' => $submission,
        'table' => $submission['table_name'],
        'submission_id' => $submissionId
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}

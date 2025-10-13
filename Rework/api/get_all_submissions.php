<?php
/**
 * Get All Submissions API
 * Fetches all report submissions from report_submissions table
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    require_once __DIR__ . '/../config/database.php';
    
    $database = new Database();
    $db = $database->getConnection();
    
    // Check if report_submissions table exists
    $checkTable = $db->query("SHOW TABLES LIKE 'report_submissions'");
    if ($checkTable->rowCount() === 0) {
        throw new Exception('report_submissions table does not exist. Please run the database setup.');
    }
    
    // Fetch all submissions with user details and record count
    $query = "SELECT 
                rs.id,
                rs.table_name,
                rs.campus,
                rs.office,
                rs.user_id,
                rs.description,
                rs.submission_date as submitted_at,
                rs.status,
                u.name as user_name,
                u.email as submitted_by,
                COALESCE(
                    (SELECT COUNT(*) FROM report_submission_data rsd WHERE rsd.submission_id = rs.id),
                    0
                ) as record_count
              FROM report_submissions rs
              LEFT JOIN users u ON rs.user_id = u.id
              ORDER BY rs.submission_date DESC";
    
    $stmt = $db->query($query);
    $submissions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Add batch_id for compatibility (use submission id as batch identifier)
    foreach ($submissions as &$submission) {
        $submission['batch_id'] = 'submission_' . $submission['id'];
    }
    
    echo json_encode([
        'success' => true,
        'data' => $submissions,
        'count' => count($submissions)
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}

<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(200); exit(); }

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../includes/functions.php';

function json_error($msg, $code = 400) {
    http_response_code($code);
    echo json_encode(['success' => false, 'error' => $msg]);
    exit();
}

try {
    $db = getDB();
    if ($db instanceof PDO) {
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    json_error('DB connection failed');
}

// Ensure table exists with new_password_hash field
$db->exec("CREATE TABLE IF NOT EXISTS password_reset_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    username VARCHAR(255) NOT NULL,
    new_password_hash VARCHAR(255) NOT NULL,
    status ENUM('pending','approved','rejected') DEFAULT 'pending',
    reason VARCHAR(500) NULL,
    requested_ip VARCHAR(64) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX (username), INDEX (status)
) ENGINE=InnoDB");

$input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
$username = trim((string)($input['username'] ?? ''));
$newPassword = (string)($input['new_password'] ?? '');
$confirmPassword = (string)($input['confirm_password'] ?? '');

if ($username === '' || $newPassword === '' || $confirmPassword === '') {
    json_error('Username and passwords are required');
}
if ($newPassword !== $confirmPassword) {
    json_error('Passwords do not match');
}
// Basic password policy (adjust as needed)
if (strlen($newPassword) < 6) {
    json_error('Password must be at least 6 characters');
}

// Find user
$stmt = $db->prepare('SELECT id, username FROM users WHERE username = ? LIMIT 1');
$stmt->execute([$username]);
$user = $stmt->fetch();
if (!$user) {
    // Avoid user enumeration: generic error
    json_error('If the account exists, a request has been submitted.', 200);
}

// Rate limit: max 3 pending per username in last 1 hour
$rate = $db->prepare("SELECT COUNT(*) AS c FROM password_reset_requests WHERE username=? AND status='pending' AND created_at > (NOW() - INTERVAL 1 HOUR)");
$rate->execute([$username]);
$count = (int)($rate->fetch()['c'] ?? 0);
if ($count >= 3) {
    json_error('Too many requests. Try again later.', 429);
}

$hash = password_hash($newPassword, PASSWORD_DEFAULT);

try {
    $db->beginTransaction();
    $ins = $db->prepare('INSERT INTO password_reset_requests (user_id, username, new_password_hash, status, requested_ip) VALUES (?,?,?,?,?)');
    $ins->execute([$user['id'], $user['username'], $hash, 'pending', $_SERVER['REMOTE_ADDR'] ?? null]);
    logActivity('password_reset_requested', 'User requested password change pending admin approval: '.$user['username'], $user['id']);
    $db->commit();
    echo json_encode(['success' => true, 'message' => 'Request submitted. Admin approval required.']);
} catch (Exception $e) {
    if ($db->inTransaction()) $db->rollBack();
    json_error('Failed to submit request', 500);
}

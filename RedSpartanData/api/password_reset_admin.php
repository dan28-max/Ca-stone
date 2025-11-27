<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(200); exit(); }

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../includes/functions.php';

function json_error($msg, $code = 400, $extra = []) {
    http_response_code($code);
    echo json_encode(array_merge(['success' => false, 'error' => $msg], $extra));
    exit();
}

try {
    $db = getDB();
    if ($db instanceof PDO) {
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    json_error('DB connection failed', 500);
}

// Ensure table exists (with new_password_hash)
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

$action = $_GET['action'] ?? $_POST['action'] ?? '';

function require_admin() {
    if (session_status() === PHP_SESSION_NONE) session_start();
    if (!isset($_SESSION['user_id'])) json_error('Unauthorized', 401);
    $admin = getCurrentUser();
    $role = $admin['role'] ?? ($_SESSION['role'] ?? null);
    if (!$role || !in_array($role, ['admin','super_admin'])) json_error('Forbidden', 403);
    return $admin;
}

switch ($action) {
    case 'list_pending': {
        require_admin();
        $stmt = $db->query("SELECT id, username, status, created_at FROM password_reset_requests WHERE status='pending' ORDER BY created_at DESC");
        $rows = $stmt->fetchAll();
        echo json_encode(['success' => true, 'requests' => $rows]);
        break;
    }
    case 'approve': {
        $admin = require_admin();
        $input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
        $requestId = (int)($input['request_id'] ?? 0);
        if ($requestId <= 0) json_error('Invalid request id');
        try {
            $db->beginTransaction();
            $stmt = $db->prepare("SELECT * FROM password_reset_requests WHERE id=? FOR UPDATE");
            $stmt->execute([$requestId]);
            $req = $stmt->fetch();
            if (!$req) { $db->rollBack(); json_error('Request not found', 404); }
            if ($req['status'] !== 'pending') { $db->rollBack(); json_error('Request already processed', 409); }

            // Ensure user exists
            $userId = $req['user_id'];
            if (!$userId) {
                $s2 = $db->prepare("SELECT id FROM users WHERE username=? LIMIT 1");
                $s2->execute([$req['username']]);
                $u = $s2->fetch();
                if (!$u) { $db->rollBack(); json_error('User not found', 404); }
                $userId = $u['id'];
            }

            // Apply the requested new password hash
            $hash = $req['new_password_hash'];
            $updated = false;
            try {
                $upd = $db->prepare("UPDATE users SET password=? WHERE id=?");
                $upd->execute([$hash, $userId]);
                $updated = true;
            } catch (Exception $e) {
                try {
                    $upd2 = $db->prepare("UPDATE users SET password_hash=? WHERE id=?");
                    $upd2->execute([$hash, $userId]);
                    $updated = true;
                } catch (Exception $e2) {
                    throw new Exception('Password column not found (tried password and password_hash)');
                }
            }

            $upreq = $db->prepare("UPDATE password_reset_requests SET status='approved', updated_at=NOW() WHERE id=?");
            $upreq->execute([$requestId]);
            logActivity('password_reset_approved', 'Admin approved password change for '.$req['username'].' (by admin id '.$admin['id'].')', $userId);

            $db->commit();
            echo json_encode(['success' => true, 'message' => 'Password updated']);
        } catch (Exception $e) {
            if ($db->inTransaction()) $db->rollBack();
            json_error('Approval failed', 500, ['detail' => $e->getMessage()]);
        }
        break;
    }
    case 'reject': {
        $admin = require_admin();
        $input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
        $requestId = (int)($input['request_id'] ?? 0);
        $reason = trim((string)($input['reason'] ?? ''));
        if ($requestId <= 0) json_error('Invalid request id');
        try {
            $db->beginTransaction();
            $stmt = $db->prepare("SELECT * FROM password_reset_requests WHERE id=? FOR UPDATE");
            $stmt->execute([$requestId]);
            $req = $stmt->fetch();
            if (!$req) { $db->rollBack(); json_error('Request not found', 404); }
            if ($req['status'] !== 'pending') { $db->rollBack(); json_error('Request already processed', 409); }

            $upreq = $db->prepare("UPDATE password_reset_requests SET status='rejected', reason=?, updated_at=NOW() WHERE id=?");
            $upreq->execute([$reason ?: null, $requestId]);
            logActivity('password_reset_rejected', 'Admin rejected password change for '.$req['username'].' (by admin id '.$admin['id'].')'.($reason?(' Reason: '.$reason):''), $req['user_id'] ?? null);

            $db->commit();
            echo json_encode(['success' => true, 'message' => 'Request rejected']);
        } catch (Exception $e) {
            if ($db->inTransaction()) $db->rollBack();
            json_error('Reject failed', 500, ['detail' => $e->getMessage()]);
        }
        break;
    }
    default:
        json_error('Invalid action', 400);
}

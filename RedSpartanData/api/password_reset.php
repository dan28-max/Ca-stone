<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(200); exit(); }

http_response_code(410);
echo json_encode(['success' => false, 'error' => 'Password reset feature is disabled']);
exit();

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../includes/functions.php';

try {
    $db = getDB();
    if ($db instanceof PDO) {
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'DB connection error', 'detail' => $e->getMessage()]);
    exit();
}

// Ensure table exists (id, username, user_id nullable, status pending/approved/rejected, created_at, updated_at)
try {
    $db->exec("CREATE TABLE IF NOT EXISTS password_reset_requests (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NULL,
        username VARCHAR(255) NOT NULL,
        status ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
        requested_by_ip VARCHAR(100) NULL,
        requested_user_agent TEXT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
        INDEX (username), INDEX (status)
    ) ENGINE=InnoDB");
} catch (Exception $e) { /* ignore */ }

$action = $_GET['action'] ?? '';
try {
    switch ($action) {
        case 'request':
            handleRequest($db);
            break;
        case 'list_pending':
            handleListPending($db);
            break;
        case 'approve':
            handleApprove($db);
            break;
        default:
            echo json_encode(['success' => false, 'error' => 'Invalid action']);
    }
} catch (Throwable $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Server error', 'detail' => $e->getMessage()]);
}

function handleRequest($db) {
    $input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
    $username = trim($input['username'] ?? '');
    if ($username === '') {
        echo json_encode(['success' => false, 'error' => 'Username is required']);
        return;
    }
    try {
        // Find user id if exists
        $uid = null;
        $stmt = $db->prepare("SELECT id FROM users WHERE username = ? LIMIT 1");
        $stmt->execute([$username]);
        $row = $stmt->fetch();
        if ($row) { $uid = $row['id']; }

        // Insert request
        $ins = $db->prepare("INSERT INTO password_reset_requests (user_id, username, requested_by_ip, requested_user_agent) VALUES (?,?,?,?)");
        $ins->execute([$uid, $username, $_SERVER['REMOTE_ADDR'] ?? '', $_SERVER['HTTP_USER_AGENT'] ?? '']);

        // Activity log
        logActivity('password_reset_requested', 'Password reset requested for username: '.$username, $uid);

        echo json_encode(['success' => true, 'message' => 'Reset request submitted. An admin will review it.']);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'error' => 'Failed to create request', 'detail' => $e->getMessage()]);
    }
}

function handleListPending($db) {
    // Require admin role
    if (session_status() === PHP_SESSION_NONE) session_start();
    if (!isset($_SESSION['user_id'])) { http_response_code(401); echo json_encode(['success'=>false,'error'=>'Unauthorized']); return; }
    try {
        $role = $_SESSION['role'] ?? null;
        if (!$role) {
            $u = getCurrentUser();
            $role = $u['role'] ?? null;
        }
        if (!in_array($role, ['admin','super_admin'])) { http_response_code(403); echo json_encode(['success'=>false,'error'=>'Forbidden']); return; }
        $rows = $db->query("SELECT * FROM password_reset_requests WHERE status='pending' ORDER BY created_at DESC LIMIT 200")->fetchAll();
        echo json_encode(['success'=>true,'requests'=>$rows]);
    } catch (Exception $e) { http_response_code(500); echo json_encode(['success'=>false,'error'=>'Failed to list','detail'=>$e->getMessage()]); }
}

function handleApprove($db) {
    // Require admin role
    if (session_status() === PHP_SESSION_NONE) session_start();
    if (!isset($_SESSION['user_id'])) { http_response_code(401); echo json_encode(['success'=>false,'error'=>'Unauthorized']); return; }
    $admin = getCurrentUser();
    $role = $admin['role'] ?? ($_SESSION['role'] ?? null);
    if (!$role || !in_array($role, ['admin','super_admin'])) { http_response_code(403); echo json_encode(['success'=>false,'error'=>'Forbidden']); return; }

    $input = json_decode(file_get_contents('php://input'), true) ?: $_POST;
    $requestId = intval($input['request_id'] ?? 0);
    if ($requestId <= 0) { echo json_encode(['success'=>false,'error'=>'Invalid request']); return; }

    // Retry once on "MySQL server has gone away" (2006)
    $attempt = 0;
    while ($attempt < 2) {
        try {
            $db->beginTransaction();
            // Get request
            $stmt = $db->prepare("SELECT * FROM password_reset_requests WHERE id=? FOR UPDATE");
            $stmt->execute([$requestId]);
            $req = $stmt->fetch();
            if (!$req || $req['status'] !== 'pending') { $db->rollBack(); echo json_encode(['success'=>false,'error'=>'Request not found or already processed']); return; }

            // Find user by username if user_id is null
            $userId = $req['user_id'];
            if (!$userId) {
                $s2 = $db->prepare("SELECT id FROM users WHERE username=? LIMIT 1");
                $s2->execute([$req['username']]);
                $u = $s2->fetch();
                if (!$u) { $db->rollBack(); echo json_encode(['success'=>false,'error'=>'User not found']); return; }
                $userId = $u['id'];
            }

            // Reset password to default 'Password#123'
            $defaultPassword = 'Password#123';
            $newHash = password_hash($defaultPassword, PASSWORD_DEFAULT);
            // Try updating common column names gracefully
            $updated = false;
            try {
                $upd = $db->prepare("UPDATE users SET password=? WHERE id=?");
                $upd->execute([$newHash, $userId]);
                $updated = $upd->rowCount() >= 0; // success if no error thrown
            } catch (Exception $e) {
                // fallback to password_hash column name
                try {
                    $upd2 = $db->prepare("UPDATE users SET password_hash=? WHERE id=?");
                    $upd2->execute([$newHash, $userId]);
                    $updated = $upd2->rowCount() >= 0;
                } catch (Exception $e2) {
                    throw new Exception('Password column not found (tried password and password_hash).');
                }
            }

            // Mark request approved
            $upreq = $db->prepare("UPDATE password_reset_requests SET status='approved', updated_at=NOW() WHERE id=?");
            $upreq->execute([$requestId]);

            // Log activities
            logActivity('password_reset_approved', 'Password reset to default by admin id '.$admin['id'].' for username: '.$req['username'], $userId);

            $db->commit();
            echo json_encode(['success'=>true,'message'=>'Password reset to default']);
            return;
        } catch (Exception $e) {
            if ($db->inTransaction()) $db->rollBack();
            $msg = $e->getMessage();
            $isGone = (strpos($msg, '2006') !== false) || (stripos($msg, 'has gone away') !== false);
            if ($isGone && $attempt === 0) {
                // Reconnect and retry once
                try {
                    $db = getDB();
                    if ($db instanceof PDO) {
                        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
                    }
                } catch (Exception $re) {
                    http_response_code(500);
                    echo json_encode(['success'=>false,'error'=>'DB reconnect failed','detail'=>$re->getMessage()]);
                    return;
                }
                $attempt++;
                continue; // retry loop
            }
            http_response_code(500);
            echo json_encode(['success'=>false,'error'=>'Failed to approve reset','detail'=>$e->getMessage()]);
            return;
        }
    }
}

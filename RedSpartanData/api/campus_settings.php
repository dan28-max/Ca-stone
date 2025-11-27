<?php
/**
 * Campus Settings API
 *
 * Allows SUPER ADMINS to manage the list of campuses and their optional parent campus.
 * Data is stored in the system_settings table under the key "campus_hierarchy".
 *
 * Example stored value (JSON):
 * {
 *   "campuses": [
 *     { "name": "Pablo Borbon", "parent": null },
 *     { "name": "Rosario", "parent": "Pablo Borbon" }
 *   ]
 * }
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../includes/functions.php';

/**
 * Check if current user is super admin (role = super_admin or campus = Main Campus)
 */
function cs_is_super_admin(): bool {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }

    if (empty($_SESSION['user_id'])) {
        return false;
    }

    try {
        $db = getDB();
        if (!$db) {
            return false;
        }

        $stmt = $db->prepare("SELECT role, campus FROM users WHERE id = ? AND status = 'active'");
        $stmt->execute([$_SESSION['user_id']]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            return false;
        }

        $role = strtolower(trim((string)$user['role']));
        $campus = trim((string)$user['campus']);

        return $role === 'super_admin' || strcasecmp($campus, 'Main Campus') === 0 || strcasecmp($campus, 'Main') === 0;
    } catch (Exception $e) {
        error_log('Campus settings super admin check error: ' . $e->getMessage());
        return false;
    }
}

/**
 * Get current campus hierarchy from system_settings.
 * If not set, return sensible defaults that match existing hardcoded access rules.
 */
function cs_get_campus_hierarchy(): array {
    $settings = getSystemSettings();

    if (!empty($settings['campus_hierarchy'])) {
        $decoded = json_decode($settings['campus_hierarchy'], true);
        if (is_array($decoded) && isset($decoded['campuses']) && is_array($decoded['campuses'])) {
            return $decoded;
        }
    }

    // Default configuration (mirrors existing access rules)
    $default = [
        'campuses' => [
            // Main parents
            [ 'name' => 'Pablo Borbon', 'parent' => null ],
            [ 'name' => 'Alangilan', 'parent' => null ],
            [ 'name' => 'Lipa', 'parent' => null ],
            [ 'name' => 'Malvar', 'parent' => null ],
            [ 'name' => 'Nasugbu', 'parent' => null ],
            // Children grouped under parents (for access rules)
            [ 'name' => 'Rosario', 'parent' => 'Pablo Borbon' ],
            [ 'name' => 'San Juan', 'parent' => 'Pablo Borbon' ],
            [ 'name' => 'Lemery', 'parent' => 'Pablo Borbon' ],
            [ 'name' => 'Lobo', 'parent' => 'Alangilan' ],
            [ 'name' => 'Balayan', 'parent' => 'Alangilan' ],
            [ 'name' => 'Mabini', 'parent' => 'Alangilan' ],
        ],
    ];

    return $default;
}

/**
 * Normalize campuses array from client.
 */
function cs_normalize_campuses($campusesRaw): array {
    $result = [];
    if (!is_array($campusesRaw)) {
        return $result;
    }

    foreach ($campusesRaw as $item) {
        if (!is_array($item)) {
            continue;
        }
        $name = isset($item['name']) ? trim((string)$item['name']) : '';
        if ($name === '') {
            continue;
        }
        $parent = isset($item['parent']) && $item['parent'] !== '' ? trim((string)$item['parent']) : null;
        $result[] = [
            'name' => $name,
            'parent' => $parent,
        ];
    }

    return $result;
}

try {
    $method = $_SERVER['REQUEST_METHOD'];

    if ($method === 'GET') {
        // Anyone logged in can read; campus access logic will still enforce visibility elsewhere
        $data = cs_get_campus_hierarchy();
        echo json_encode([
            'success' => true,
            'data' => $data,
        ]);
        exit();
    }

    if ($method === 'POST') {
        if (!cs_is_super_admin()) {
            http_response_code(403);
            echo json_encode([
                'success' => false,
                'message' => 'Only super admins can update campus settings.',
            ]);
            exit();
        }

        $payload = json_decode(file_get_contents('php://input'), true);
        if (!is_array($payload)) {
            $payload = $_POST;
        }

        $campusesRaw = $payload['campuses'] ?? null;
        $campuses = cs_normalize_campuses($campusesRaw);

        if (empty($campuses)) {
            http_response_code(400);
            echo json_encode([
                'success' => false,
                'message' => 'Campuses array is required and cannot be empty.',
            ]);
            exit();
        }

        $data = [ 'campuses' => $campuses ];
        $saved = updateSystemSetting('campus_hierarchy', json_encode($data));

        if (!$saved) {
            throw new Exception('Failed to update campus hierarchy in system settings');
        }

        echo json_encode([
            'success' => true,
            'message' => 'Campus settings updated successfully.',
            'data' => $data,
        ]);
        exit();
    }

    http_response_code(405);
    echo json_encode([
        'success' => false,
        'message' => 'Method not allowed',
    ]);
} catch (Exception $e) {
    error_log('Campus settings API error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Server error while handling campus settings.',
    ]);
}



<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

// Temporarily bypass authentication for development
// In production, implement proper authentication

require_once '../config/database.php';

class UsersAPI {
    private $conn;
    
    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }
    
    public function handleRequest() {
        $action = $_GET['action'] ?? '';
        
        switch ($action) {
            case 'list':
                $this->listUsers();
                break;
            case 'create':
                $this->createUser();
                break;
            case 'update':
                $this->updateUser();
                break;
            case 'delete':
                $this->deleteUser();
                break;
            case 'get':
                $this->getUser();
                break;
            default:
                echo json_encode(['success' => false, 'error' => 'Invalid action']);
        }
    }
    
    private function listUsers() {
        try {
            $query = "SELECT id, username, name, email, role, status, campus, office, 
                      created_at, last_login 
                      FROM users 
                      ORDER BY created_at DESC";
            
            $stmt = $this->conn->prepare($query);
            $stmt->execute();
            
            $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            echo json_encode([
                'success' => true,
                'users' => $users
            ]);
        } catch (Exception $e) {
            echo json_encode([
                'success' => false,
                'error' => 'Failed to load users: ' . $e->getMessage()
            ]);
        }
    }
    
    private function getUser() {
        try {
            $userId = $_GET['id'] ?? null;
            
            if (!$userId) {
                echo json_encode(['success' => false, 'error' => 'User ID required']);
                return;
            }
            
            $query = "SELECT id, username, name, email, role, status, campus, office 
                      FROM users WHERE id = :id";
            
            $stmt = $this->conn->prepare($query);
            $stmt->bindParam(':id', $userId);
            $stmt->execute();
            
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($user) {
                echo json_encode([
                    'success' => true,
                    'user' => $user
                ]);
            } else {
                echo json_encode(['success' => false, 'error' => 'User not found']);
            }
        } catch (Exception $e) {
            echo json_encode([
                'success' => false,
                'error' => 'Failed to get user: ' . $e->getMessage()
            ]);
        }
    }
    
    private function createUser() {
        try {
            $data = json_decode(file_get_contents('php://input'), true);
            
            // Validate required fields
            if (empty($data['name']) || empty($data['username']) || empty($data['password'])) {
                echo json_encode(['success' => false, 'error' => 'Name, username, and password are required']);
                return;
            }
            
            // Check if username already exists
            $checkQuery = "SELECT id FROM users WHERE username = :username";
            $checkStmt = $this->conn->prepare($checkQuery);
            $checkStmt->bindParam(':username', $data['username']);
            $checkStmt->execute();
            
            if ($checkStmt->fetch()) {
                echo json_encode(['success' => false, 'error' => 'Username already exists']);
                return;
            }
            
            // Hash password
            $hashedPassword = password_hash($data['password'], PASSWORD_DEFAULT);
            
            // Insert user
            $query = "INSERT INTO users (username, name, email, password, role, status, campus, office, created_at) 
                      VALUES (:username, :name, :email, :password, :role, :status, :campus, :office, NOW())";
            
            $stmt = $this->conn->prepare($query);
            $stmt->bindParam(':username', $data['username']);
            $stmt->bindParam(':name', $data['name']);
            $stmt->bindParam(':email', $data['email']);
            $stmt->bindParam(':password', $hashedPassword);
            $stmt->bindParam(':role', $data['role']);
            $stmt->bindParam(':status', $data['status']);
            $stmt->bindParam(':campus', $data['campus']);
            $stmt->bindParam(':office', $data['office']);
            
            if ($stmt->execute()) {
                echo json_encode([
                    'success' => true,
                    'message' => 'User created successfully',
                    'user_id' => $this->conn->lastInsertId()
                ]);
            } else {
                echo json_encode(['success' => false, 'error' => 'Failed to create user']);
            }
        } catch (Exception $e) {
            echo json_encode([
                'success' => false,
                'error' => 'Failed to create user: ' . $e->getMessage()
            ]);
        }
    }
    
    private function updateUser() {
        try {
            $data = json_decode(file_get_contents('php://input'), true);
            
            if (empty($data['id'])) {
                echo json_encode(['success' => false, 'error' => 'User ID required']);
                return;
            }
            
            // Build update query dynamically based on provided fields
            $updateFields = [];
            $params = [':id' => $data['id']];
            
            if (isset($data['username'])) {
                // Check if new username is unique
                $checkQuery = "SELECT id FROM users WHERE username = :username AND id != :id";
                $checkStmt = $this->conn->prepare($checkQuery);
                $checkStmt->bindParam(':username', $data['username']);
                $checkStmt->bindParam(':id', $data['id']);
                $checkStmt->execute();
                if ($checkStmt->fetch()) {
                    echo json_encode(['success' => false, 'error' => 'Username already exists']);
                    return;
                }
                $updateFields[] = "username = :username";
                $params[':username'] = $data['username'];
            }
            if (isset($data['name'])) {
                $updateFields[] = "name = :name";
                $params[':name'] = $data['name'];
            }
            if (isset($data['email'])) {
                $updateFields[] = "email = :email";
                $params[':email'] = $data['email'];
            }
            if (isset($data['role'])) {
                $updateFields[] = "role = :role";
                $params[':role'] = $data['role'];
            }
            if (isset($data['status'])) {
                $updateFields[] = "status = :status";
                $params[':status'] = $data['status'];
            }
            if (isset($data['campus'])) {
                $updateFields[] = "campus = :campus";
                $params[':campus'] = $data['campus'];
            }
            if (isset($data['office'])) {
                $updateFields[] = "office = :office";
                $params[':office'] = $data['office'];
            }
            if (!empty($data['password'])) {
                $updateFields[] = "password = :password";
                $params[':password'] = password_hash($data['password'], PASSWORD_DEFAULT);
            }
            
            if (empty($updateFields)) {
                echo json_encode(['success' => false, 'error' => 'No fields to update']);
                return;
            }
            
            $query = "UPDATE users SET " . implode(', ', $updateFields) . " WHERE id = :id";
            $stmt = $this->conn->prepare($query);
            
            foreach ($params as $key => $value) {
                $stmt->bindValue($key, $value);
            }
            
            if ($stmt->execute()) {
                echo json_encode([
                    'success' => true,
                    'message' => 'User updated successfully'
                ]);
            } else {
                echo json_encode(['success' => false, 'error' => 'Failed to update user']);
            }
        } catch (Exception $e) {
            echo json_encode([
                'success' => false,
                'error' => 'Failed to update user: ' . $e->getMessage()
            ]);
        }
    }
    
    private function deleteUser() {
        try {
            $data = json_decode(file_get_contents('php://input'), true);
            
            if (empty($data['id'])) {
                echo json_encode(['success' => false, 'error' => 'User ID required']);
                return;
            }
            
            // Don't allow deleting the last admin
            $checkQuery = "SELECT COUNT(*) as admin_count FROM users WHERE role = 'admin' AND status = 'active'";
            $checkStmt = $this->conn->prepare($checkQuery);
            $checkStmt->execute();
            $result = $checkStmt->fetch(PDO::FETCH_ASSOC);
            
            if ($result['admin_count'] <= 1) {
                $userQuery = "SELECT role FROM users WHERE id = :id";
                $userStmt = $this->conn->prepare($userQuery);
                $userStmt->bindParam(':id', $data['id']);
                $userStmt->execute();
                $user = $userStmt->fetch(PDO::FETCH_ASSOC);
                
                if ($user && $user['role'] === 'admin') {
                    echo json_encode(['success' => false, 'error' => 'Cannot delete the last admin user']);
                    return;
                }
            }
            
            $query = "DELETE FROM users WHERE id = :id";
            $stmt = $this->conn->prepare($query);
            $stmt->bindParam(':id', $data['id']);
            
            if ($stmt->execute()) {
                echo json_encode([
                    'success' => true,
                    'message' => 'User deleted successfully'
                ]);
            } else {
                echo json_encode(['success' => false, 'error' => 'Failed to delete user']);
            }
        } catch (Exception $e) {
            echo json_encode([
                'success' => false,
                'error' => 'Failed to delete user: ' . $e->getMessage()
            ]);
        }
    }
}

$api = new UsersAPI();
$api->handleRequest();

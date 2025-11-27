<?php
/**
 * Database Configuration for Spartan Data
 * XAMPP MySQL Configuration
 */

// Set timezone to Philippines (Asia/Manila)
date_default_timezone_set('Asia/Manila');

class Database {
    private $host = 'srv1367.hstgr.io';
    private $db_name = 'u296244758_spartan_data';
    private $username = 'u296244758_spartan_data';
    private $password = 'Dan#Sept282002';
    private $charset = 'utf8mb4';
    private $port = 3306;
    public $conn;

    /**
     * Get database connection
     */
    public function getConnection() {
        $this->conn = null;

        try {
            // Try with server hostname first (Hostinger)
            $dsn = "mysql:host=" . $this->host . ";port=" . $this->port . ";dbname=" . $this->db_name . ";charset=" . $this->charset;
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
                PDO::ATTR_TIMEOUT => 5,
            ];

            $this->conn = new PDO($dsn, $this->username, $this->password, $options);
        } catch(PDOException $exception) {
            // If server hostname fails, try localhost (some Hostinger setups use this)
            if (strpos($exception->getMessage(), 'Unknown host') !== false || strpos($exception->getMessage(), 'Connection refused') !== false) {
                try {
                    error_log("First connection attempt failed, trying localhost...");
                    $dsn = "mysql:host=localhost;port=" . $this->port . ";dbname=" . $this->db_name . ";charset=" . $this->charset;
                    $this->conn = new PDO($dsn, $this->username, $this->password, $options);
                    error_log("Successfully connected using localhost");
                } catch(PDOException $e2) {
                    error_log("Connection error (localhost): " . $e2->getMessage());
                    error_log("Original error (server hostname): " . $exception->getMessage());
                    throw new Exception("Database connection failed: " . $exception->getMessage());
                }
            } else {
                error_log("Connection error: " . $exception->getMessage());
                error_log("Error Code: " . $exception->getCode());
                throw new Exception("Database connection failed: " . $exception->getMessage());
            }
        }

        return $this->conn;
    }

    /**
     * Test database connection
     */
    public function testConnection() {
        try {
            $conn = $this->getConnection();
            return $conn !== null;
        } catch(Exception $e) {
            return false;
        }
    }
}

// Global database instance with connection pooling
// Use static variables within function to ensure reuse across requests
function getDB() {
    static $connection = null;
    static $lastCheck = 0;
    
    // Reuse existing connection if it's still valid
    if ($connection !== null) {
        try {
            // Only check connection every 5 seconds to avoid overhead
            $now = time();
            if ($now - $lastCheck < 5) {
                return $connection;
            }
            
            // Quick ping to verify connection is alive (using a lightweight query)
            $connection->query('SELECT 1');
            $lastCheck = $now;
            return $connection;
        } catch (PDOException $e) {
            // Connection is dead, reset it
            $connection = null;
            error_log("Connection dead, will create new one: " . $e->getMessage());
        }
    }
    
    // Create new connection only if needed
    try {
        $database = new Database();
        $connection = $database->getConnection();
        $lastCheck = time();
        
        // Set persistent connection option to help reduce connection count
        $connection->setAttribute(PDO::ATTR_PERSISTENT, false); // Hostinger might not support persistent
        
        return $connection;
    } catch (Exception $e) {
        error_log("Failed to create database connection: " . $e->getMessage());
        throw $e;
    }
}

// Function to close database connection (call when done)
function closeDB() {
    // Static variable cleanup - note: this only affects current request
    // For persistent connections, we rely on PHP's garbage collection
}

// Database configuration constants
define('DB_HOST', 'localhost');
define('DB_NAME', 'spartan_data');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_CHARSET', 'utf8mb4');
?>


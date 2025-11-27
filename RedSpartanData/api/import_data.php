<?php
/**
 * Import Data API
 * Handles importing data from CSV/Excel files to database tables
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

session_start();

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'error' => 'Unauthorized. Please log in.']);
    exit();
}

try {
    require_once __DIR__ . '/../config/database.php';
    
    $database = new Database();
    $db = $database->getConnection();
    
    // Get parameters
    $tableName = $_POST['table_name'] ?? '';
    $skipHeaderRow = isset($_POST['skip_header_row']) && $_POST['skip_header_row'] === '1';
    $validateData = isset($_POST['validate_data']) && $_POST['validate_data'] === '1';
    
    if (empty($tableName)) {
        throw new Exception('Table name is required');
    }
    
    // Validate table name (security check)
    $allowedTables = [
        'admissiondata', 'enrollmentdata', 'graduatesdata', 'employee',
        'leaveprivilege', 'libraryvisitor', 'pwd', 'waterconsumption',
        'treatedwastewater', 'electricityconsumption', 'solidwaste',
        'campuspopulation', 'foodwaste', 'fuelconsumption',
        'distancetraveled', 'budgetexpenditure', 'flightaccommodation'
    ];
    
    if (!in_array(strtolower($tableName), $allowedTables)) {
        throw new Exception('Invalid table name');
    }
    
    // Check file upload
    if (!isset($_FILES['file']) || $_FILES['file']['error'] !== UPLOAD_ERR_OK) {
        throw new Exception('No file uploaded or upload error occurred');
    }
    
    $file = $_FILES['file'];
    $fileName = $file['name'];
    $fileTmpPath = $file['tmp_name'];
    $fileSize = $file['size'];
    $fileType = $file['type'];
    
    // Validate file size (10MB max)
    $maxSize = 10 * 1024 * 1024; // 10MB
    if ($fileSize > $maxSize) {
        throw new Exception('File size exceeds 10MB limit');
    }
    
    // Validate file type
    $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
    $allowedExtensions = ['csv', 'xlsx', 'xls'];
    
    if (!in_array($fileExtension, $allowedExtensions)) {
        throw new Exception('Invalid file type. Only CSV and Excel files are allowed');
    }
    
    // Get user info for logging
    $userId = $_SESSION['user_id'];
    $userName = $_SESSION['name'] ?? $_SESSION['username'] ?? 'Unknown';
    $userCampus = $_SESSION['campus'] ?? '';
    $userOffice = $_SESSION['office'] ?? '';
    
    // Read file based on extension
    $data = [];
    
    if ($fileExtension === 'csv') {
        // Read CSV file
        $handle = fopen($fileTmpPath, 'r');
        if ($handle === false) {
            throw new Exception('Failed to open CSV file');
        }
        
        $rowIndex = 0;
        while (($row = fgetcsv($handle)) !== false) {
            if ($rowIndex === 0 && $skipHeaderRow) {
                $rowIndex++;
                continue; // Skip header row
            }
            $data[] = $row;
            $rowIndex++;
        }
        fclose($handle);
        
        // Get headers from first row if not skipped
        $headers = [];
        if (!$skipHeaderRow && !empty($data)) {
            $headers = array_shift($data);
        } else {
            // Get column names from database table
            $stmt = $db->query("DESCRIBE `{$tableName}`");
            $columns = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $headers = array_column($columns, 'Field');
        }
        
    } else {
        // Excel file - require PhpSpreadsheet library
        // For now, return error if Excel is not supported
        throw new Exception('Excel file import is not yet supported. Please convert to CSV format.');
    }
    
    if (empty($data)) {
        throw new Exception('No data found in file');
    }
    
    // Get table structure
    $stmt = $db->query("DESCRIBE `{$tableName}`");
    $tableColumns = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $columnNames = array_column($tableColumns, 'Field');
    
    // Map CSV headers to table columns (case-insensitive)
    $columnMap = [];
    foreach ($headers as $index => $header) {
        $headerLower = strtolower(trim($header));
        foreach ($columnNames as $colName) {
            if (strtolower($colName) === $headerLower) {
                $columnMap[$index] = $colName;
                break;
            }
        }
    }
    
    if (empty($columnMap)) {
        throw new Exception('No matching columns found between file and table. Please check your file headers.');
    }
    
    // Import data
    $importedRows = 0;
    $skippedRows = 0;
    $errors = [];
    
    $db->beginTransaction();
    
    try {
        foreach ($data as $rowIndex => $row) {
            if (empty($row) || (count($row) === 1 && empty(trim($row[0])))) {
                $skippedRows++;
                continue; // Skip empty rows
            }
            
            $insertData = [];
            $insertColumns = [];
            $placeholders = [];
            
            foreach ($columnMap as $csvIndex => $dbColumn) {
                $value = isset($row[$csvIndex]) ? trim($row[$csvIndex]) : '';
                
                // Validate data if enabled
                if ($validateData) {
                    // Check if column is required (NOT NULL and no default)
                    $columnInfo = null;
                    foreach ($tableColumns as $col) {
                        if ($col['Field'] === $dbColumn) {
                            $columnInfo = $col;
                            break;
                        }
                    }
                    
                    if ($columnInfo && $columnInfo['Null'] === 'NO' && $columnInfo['Default'] === null && empty($value)) {
                        $skippedRows++;
                        $errors[] = "Row " . ($rowIndex + 1) . ": Required column '{$dbColumn}' is empty";
                        continue 2; // Skip this row
                    }
                }
                
                $insertColumns[] = "`{$dbColumn}`";
                $placeholders[] = '?';
                $insertData[] = empty($value) ? null : $value;
            }
            
            if (empty($insertColumns)) {
                $skippedRows++;
                continue;
            }
            
            // Build INSERT query
            $sql = "INSERT INTO `{$tableName}` (" . implode(', ', $insertColumns) . ") VALUES (" . implode(', ', $placeholders) . ")";
            
            try {
                $stmt = $db->prepare($sql);
                $stmt->execute($insertData);
                $importedRows++;
            } catch (PDOException $e) {
                $skippedRows++;
                $errors[] = "Row " . ($rowIndex + 1) . ": " . $e->getMessage();
            }
        }
        
        $db->commit();
        
        // Log import activity
        try {
            $logStmt = $db->prepare("INSERT INTO activity_logs (user_id, action, details, ip_address, created_at) VALUES (?, ?, ?, ?, NOW())");
            $logDetails = "Imported {$importedRows} rows to {$tableName} from file: {$fileName}";
            $logStmt->execute([
                $userId,
                'data_import',
                $logDetails,
                $_SERVER['REMOTE_ADDR'] ?? 'unknown'
            ]);
        } catch (Exception $e) {
            // Log error but don't fail the import
            error_log('Failed to log import activity: ' . $e->getMessage());
        }
        
        echo json_encode([
            'success' => true,
            'message' => 'Data imported successfully',
            'imported_rows' => $importedRows,
            'skipped_rows' => $skippedRows,
            'total_rows' => count($data),
            'errors' => array_slice($errors, 0, 10) // Return first 10 errors
        ]);
        
    } catch (Exception $e) {
        $db->rollBack();
        throw $e;
    }
    
} catch (Exception $e) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}


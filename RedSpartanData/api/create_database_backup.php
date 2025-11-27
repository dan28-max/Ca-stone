<?php
/**
 * Create Database Backup API
 * Exports all tables from the database in the requested format
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
    
    // Get export format from query parameter
    $format = $_GET['format'] ?? 'csv';
    
    // Get all tables in the database
    $tablesQuery = "SHOW TABLES";
    $stmt = $db->query($tablesQuery);
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    if (empty($tables)) {
        throw new Exception('No tables found in database');
    }
    
    $backupData = [];
    $allData = [];
    
    // Export each table
    foreach ($tables as $table) {
        try {
            // Get table structure
            $structureQuery = "DESCRIBE `{$table}`";
            $structureStmt = $db->query($structureQuery);
            $columns = $structureStmt->fetchAll(PDO::FETCH_ASSOC);
            
            // Get all data from table
            $dataQuery = "SELECT * FROM `{$table}`";
            $dataStmt = $db->query($dataQuery);
            $rows = $dataStmt->fetchAll(PDO::FETCH_ASSOC);
            
            $backupData[$table] = [
                'structure' => $columns,
                'data' => $rows,
                'row_count' => count($rows)
            ];
            
            // For CSV/Excel format, also store flat data
            if (in_array($format, ['csv', 'excel'])) {
                foreach ($rows as $row) {
                    $row['_table_name'] = $table;
                    $allData[] = $row;
                }
            }
        } catch (Exception $e) {
            error_log("Error exporting table {$table}: " . $e->getMessage());
            // Continue with other tables
        }
    }
    
    // Get database name
    $dbNameQuery = "SELECT DATABASE() as db_name";
    $dbNameStmt = $db->query($dbNameQuery);
    $dbNameRow = $dbNameStmt->fetch(PDO::FETCH_ASSOC);
    $dbName = $dbNameRow['db_name'] ?? 'spartan_data';
    
    // Prepare response based on format
    switch (strtolower($format)) {
        case 'json':
            $output = json_encode([
                'database' => $dbName,
                'exported_at' => date('Y-m-d H:i:s'),
                'total_tables' => count($tables),
                'tables' => $backupData
            ], JSON_PRETTY_PRINT);
            header('Content-Type: application/json');
            header('Content-Disposition: attachment; filename="database_backup_' . date('Y-m-d_His') . '.json"');
            echo $output;
            break;
            
        case 'csv':
        case 'excel':
            // Create CSV with all data
            $csv = '';
            
            // Get all unique column names across all tables
            $allColumns = ['_table_name'];
            foreach ($backupData as $table => $tableData) {
                foreach ($tableData['data'] as $row) {
                    foreach (array_keys($row) as $col) {
                        if (!in_array($col, $allColumns)) {
                            $allColumns[] = $col;
                        }
                    }
                }
            }
            
            // CSV Header
            $csv .= implode(',', array_map(function($col) {
                return '"' . str_replace('"', '""', $col) . '"';
            }, $allColumns)) . "\n";
            
            // CSV Data
            foreach ($backupData as $table => $tableData) {
                foreach ($tableData['data'] as $row) {
                    $values = [];
                    foreach ($allColumns as $col) {
                        $value = isset($row[$col]) ? $row[$col] : '';
                        $value = str_replace('"', '""', $value);
                        $values[] = '"' . $value . '"';
                    }
                    $csv .= implode(',', $values) . "\n";
                }
            }
            
            $extension = $format === 'excel' ? 'xlsx' : 'csv';
            header('Content-Type: text/csv');
            header('Content-Disposition: attachment; filename="database_backup_' . date('Y-m-d_His') . '.' . $extension . '"');
            echo $csv;
            break;
            
        case 'sql':
            // Generate SQL dump
            $sql = "-- Spartan Database Backup\n";
            $sql .= "-- Generated: " . date('Y-m-d H:i:s') . "\n";
            $sql .= "-- Total Tables: " . count($tables) . "\n\n";
            
            foreach ($backupData as $table => $tableData) {
                $sql .= "\n-- Table: {$table}\n";
                $sql .= "DROP TABLE IF EXISTS `{$table}`;\n";
                
                // Create table structure
                $createTableQuery = "SHOW CREATE TABLE `{$table}`";
                $createStmt = $db->query($createTableQuery);
                $createRow = $createStmt->fetch(PDO::FETCH_ASSOC);
                if (isset($createRow['Create Table'])) {
                    $sql .= $createRow['Create Table'] . ";\n\n";
                }
                
                // Insert data
                if (!empty($tableData['data'])) {
                    $columns = array_keys($tableData['data'][0]);
                    $sql .= "INSERT INTO `{$table}` (`" . implode('`, `', $columns) . "`) VALUES\n";
                    
                    $valueRows = [];
                    foreach ($tableData['data'] as $row) {
                        $values = [];
                        foreach ($columns as $col) {
                            $value = $row[$col] ?? 'NULL';
                            if ($value === null || $value === '') {
                                $values[] = 'NULL';
                            } else {
                                $value = $db->quote($value);
                                $values[] = $value;
                            }
                        }
                        $valueRows[] = "(" . implode(', ', $values) . ")";
                    }
                    
                    $sql .= implode(",\n", $valueRows) . ";\n\n";
                }
            }
            
            header('Content-Type: application/sql');
            header('Content-Disposition: attachment; filename="database_backup_' . date('Y-m-d_His') . '.sql"');
            echo $sql;
            break;
            
        default:
            throw new Exception('Invalid format. Supported: csv, excel, json, sql');
    }
    
    exit();
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}


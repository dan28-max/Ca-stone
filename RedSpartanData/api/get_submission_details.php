<?php
/**
 * Get Submission Details API
 * Fetches detailed records for a specific submission from report_submission_data
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

try {
    error_log("=== get_submission_details.php called ===");
    require_once __DIR__ . '/../config/database.php';
    
    $submissionId = $_GET['submission_id'] ?? '';
    
    error_log("Submission ID: $submissionId");
    
    if (empty($submissionId)) {
        throw new Exception('Submission ID is required');
    }
    
    $database = new Database();
    $db = $database->getConnection();
    
    // Get submission details
    $query = "SELECT * FROM report_submissions WHERE id = :id";
    error_log("Query: $query with id=$submissionId");
    $stmt = $db->prepare($query);
    $stmt->execute(['id' => $submissionId]);
    $submission = $stmt->fetch(PDO::FETCH_ASSOC);
    
    error_log("Submission found: " . ($submission ? 'YES' : 'NO'));
    if ($submission) {
        error_log("Submission data: " . print_r($submission, true));
    }
    
    if (!$submission) {
        throw new Exception('Submission not found');
    }
    
    // Get table name from submission
    $tableName = $submission['table_name'] ?? $submission['report_type'] ?? 'unknown';
    
    // Normalize table name to ensure it matches the actual database table name
    // Common mappings: "Admission Data" -> "admissiondata", "Enrollment Data" -> "enrollmentdata", etc.
    $tableNameMap = [
        'admission data' => 'admissiondata',
        'enrollment data' => 'enrollmentdata',
        'graduates data' => 'graduatesdata',
        'budget expenditure' => 'budgetexpenditure',
        'campus population' => 'campuspopulation',
        'distance traveled' => 'distancetraveled',
        'electricity consumption' => 'electricityconsumption',
        'flight accommodation' => 'flightaccommodation',
        'food waste' => 'foodwaste',
        'fuel consumption' => 'fuelconsumption',
        'leave privilege' => 'leaveprivilege',
        'library visitor' => 'libraryvisitor',
        'solid waste' => 'solidwaste',
        'treated wastewater' => 'treatedwastewater',
        'water consumption' => 'waterconsumption'
    ];
    
    $originalTableName = $tableName;
    $normalizedTableName = strtolower(trim($tableName));
    if (isset($tableNameMap[$normalizedTableName])) {
        $tableName = $tableNameMap[$normalizedTableName];
        error_log("Normalized table name from '$originalTableName' to '$tableName'");
    } else {
        // If not in map, try to normalize by removing spaces and converting to lowercase
        $tableName = strtolower(str_replace(' ', '', $tableName));
    }
    
    // Get batch_id directly from submission record (matched by submission ID)
    $submissionBatchId = $submission['batch_id'] ?? null;
    
    error_log("=== Fetching data for submission $submissionId ===");
    error_log("Table name from submission: " . ($submission['table_name'] ?? $submission['report_type'] ?? 'N/A'));
    error_log("Normalized table name: $tableName");
    error_log("Batch ID from submission: " . ($submissionBatchId ?? 'NULL'));
    error_log("Will query main data table: $tableName");
    
    // If batch_id is missing, try to get it from the target table by matching records
    // This handles old submissions that don't have batch_id stored
    if (!$submissionBatchId && $tableName && $tableName !== 'unknown') {
        error_log("Batch_id missing in submission record - attempting to find it from target table");
        try {
            $tableCheck = $db->query("SHOW TABLES LIKE '$tableName'");
            if ($tableCheck->rowCount() > 0) {
                // Try to find batch_id by matching submission date and campus
                $submissionDate = $submission['submission_date'] ?? $submission['submitted_at'] ?? $submission['created_at'] ?? null;
                $submissionCampus = $submission['campus'] ?? null;
                
                if ($submissionDate) {
                    $datePattern = date('YmdHis', strtotime($submissionDate));
                    $columnsCheck = $db->query("SHOW COLUMNS FROM `$tableName`");
                    $targetColumns = [];
                    while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
                        $targetColumns[] = $col['Field'];
                    }
                    
                    if (in_array('batch_id', $targetColumns)) {
                        $findBatchQuery = "SELECT DISTINCT batch_id FROM `$tableName` WHERE batch_id LIKE ?";
                        $findBatchParams = [$datePattern . '%'];
                        
                        if ($submissionCampus && in_array('campus', $targetColumns)) {
                            $findBatchQuery .= " AND campus = ?";
                            $findBatchParams[] = $submissionCampus;
                        }
                        
                        $findBatchQuery .= " LIMIT 1";
                        $findBatchStmt = $db->prepare($findBatchQuery);
                        $findBatchStmt->execute($findBatchParams);
                        $foundBatch = $findBatchStmt->fetch(PDO::FETCH_ASSOC);
                        
                        if ($foundBatch && !empty($foundBatch['batch_id'])) {
                            $submissionBatchId = $foundBatch['batch_id'];
                            error_log("Found batch_id from target table: $submissionBatchId");
                            // Update report_submissions with the found batch_id for future queries
                            try {
                                $updateBatchStmt = $db->prepare("UPDATE report_submissions SET batch_id = ? WHERE id = ?");
                                $updateBatchStmt->execute([$submissionBatchId, $submissionId]);
                                error_log("Updated report_submissions with batch_id for submission $submissionId");
                            } catch (Exception $e) {
                                error_log("Could not update batch_id in report_submissions: " . $e->getMessage());
                            }
                        }
                    }
                }
            }
        } catch (Exception $e) {
            error_log("Error trying to find batch_id from target table: " . $e->getMessage());
        }
    }
    
    // Fetch data from the actual report table (not report_submission_data)
    $data = [];
    
    if ($tableName && $tableName !== 'unknown') {
        try {
            // Check if target table exists
            $tableCheck = $db->query("SHOW TABLES LIKE '$tableName'");
            if ($tableCheck->rowCount() > 0) {
                error_log("Fetching data from target table: $tableName for submission_id: $submissionId");
                
                // Get columns in the target table
                $columnsCheck = $db->query("SHOW COLUMNS FROM `$tableName`");
                $targetColumns = [];
                while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
                    $targetColumns[] = $col['Field'];
                }
                
                // Build query to fetch rows from target table
                // Priority 1: Check if submission_id column exists (direct link)
                $whereConditions = [];
                $whereParams = [];
                
                if (in_array('submission_id', $targetColumns)) {
                    // Direct link - best way to match
                    $whereConditions[] = "submission_id = ?";
                    $whereParams[] = $submissionId;
                    error_log("Using submission_id column for direct match");
                } elseif ($submissionBatchId && in_array('batch_id', $targetColumns)) {
                    // Priority 2: Use batch_id from report_submissions table (matched by submission ID)
                    // This is the correct way - we get batch_id from submission record, not by guessing
                    // Use case-insensitive matching in case office name casing differs
                    $whereConditions[] = "LOWER(batch_id) = LOWER(?)";
                    $whereParams[] = $submissionBatchId;
                    error_log("Using batch_id from submission record (case-insensitive): " . $submissionBatchId);
                } else {
                    error_log("ERROR: No batch_id found in submission record and no submission_id column in target table");
                    error_log("Cannot fetch from main data table - returning empty data");
                    // Do NOT use report_submission_data - only fetch from main data tables
                    $data = [];
                }
                
                if (!empty($whereConditions)) {
                    $whereClause = implode(' AND ', $whereConditions);
                    $targetQuery = "SELECT * FROM `$tableName` WHERE $whereClause ORDER BY id ASC";
                    
                    error_log("Querying target table $tableName: $targetQuery");
                    error_log("Params: " . print_r($whereParams, true));
                    
                    $targetStmt = $db->prepare($targetQuery);
                    $targetStmt->execute($whereParams);
                    $data = $targetStmt->fetchAll(PDO::FETCH_ASSOC);
                    
                    error_log("✓ Successfully fetched " . count($data) . " rows from target table $tableName");
                    
                    // If we got 0 rows, log it - do NOT fall back to report_submission_data
                    // The main data table is the source of truth
                    if (empty($data)) {
                        error_log("WARNING: No rows found in target table $tableName with batch_id: " . ($submissionBatchId ?? 'N/A') . " - This may indicate data was deleted or batch_id mismatch");
                    }
                } else {
                    error_log("ERROR: No matching conditions found to query target table $tableName");
                    error_log("Submission batch_id: " . ($submissionBatchId ?? 'N/A'));
                    error_log("Target table has submission_id column: " . (in_array('submission_id', $targetColumns) ? 'YES' : 'NO'));
                    error_log("Target table has batch_id column: " . (in_array('batch_id', $targetColumns) ? 'YES' : 'NO'));
                    // Do NOT use report_submission_data - only fetch from main data tables
                    $data = [];
                }
            } else {
                error_log("ERROR: Target table $tableName does not exist for submission $submissionId");
                // Do NOT use report_submission_data - only fetch from main data tables
                $data = [];
            }
        } catch (Exception $e) {
            error_log("ERROR fetching from target table $tableName: " . $e->getMessage());
            error_log("Stack trace: " . $e->getTraceAsString());
            // Do NOT fall back to report_submission_data - only fetch from main data tables
            $data = [];
        }
    } else {
        error_log("ERROR: Table name is unknown for submission $submissionId");
        // Do NOT use report_submission_data - only fetch from main data tables
        $data = [];
    }
    
    // Keep id field for deletion purposes, but hide other metadata columns from display
    // Note: 'id' is kept in the data for row deletion functionality
    // Hide internal system columns that users don't need to see
    $columnsToHide = ['batch_id', 'submitted_by', 'submitted_at', 'created_at', 'updated_at'];
    
    // Return data with original database column names (not display names)
    // This ensures consistency and prevents duplicate columns
    // The frontend will handle formatting/display names
    $filteredData = [];
    foreach ($data as $row) {
        // Keep all fields including 'id' - frontend will handle column visibility
        // We only filter out truly internal metadata fields
        $filteredRow = [];
        $columnsToHideLower = array_map('strtolower', $columnsToHide);
        foreach ($row as $key => $value) {
            if (!in_array(strtolower($key), $columnsToHideLower)) {
                // Keep original database column names - don't map to display names
                // This prevents duplicate columns and ensures data consistency
                $filteredRow[$key] = $value;
            }
        }
        // CRITICAL: Ensure 'id' field is always present (explicitly check and add if missing)
        if (!isset($filteredRow['id']) && isset($row['id'])) {
            $filteredRow['id'] = $row['id'];
        }
        $filteredData[] = $filteredRow;
    }
    
    // Debug: Log first row to verify 'id' is present and check price/quantity values
    if (count($filteredData) > 0) {
        error_log("First row data keys: " . implode(', ', array_keys($filteredData[0])));
        error_log("First row has 'id': " . (isset($filteredData[0]['id']) ? 'YES - ' . $filteredData[0]['id'] : 'NO'));
        
        // Debug price and quantity values specifically
        if (isset($filteredData[0]['Price/m^3'])) {
            error_log("Price/m^3 value: " . $filteredData[0]['Price/m^3']);
        } elseif (isset($filteredData[0]['price_per_m3'])) {
            error_log("price_per_m3 value (unmapped): " . $filteredData[0]['price_per_m3']);
        }
        
        if (isset($filteredData[0]['Quantity (m^3)'])) {
            error_log("Quantity (m^3) value: " . $filteredData[0]['Quantity (m^3)']);
        } elseif (isset($filteredData[0]['quantity_m3'])) {
            error_log("quantity_m3 value (unmapped): " . $filteredData[0]['quantity_m3']);
        }
        
        // Log raw database row to see what we're getting
        if (count($data) > 0) {
            error_log("Raw database row keys: " . implode(', ', array_keys($data[0])));
            if (isset($data[0]['price_per_m3'])) {
                error_log("Raw price_per_m3 from DB: " . $data[0]['price_per_m3']);
            }
            if (isset($data[0]['quantity_m3'])) {
                error_log("Raw quantity_m3 from DB: " . $data[0]['quantity_m3']);
            }
        }
    }
    
    // ALL data from this submission appears together - no separation by session or month
    echo json_encode([
        'success' => true,
        'data' => $filteredData,
        'submission' => $submission,
        'table' => $tableName,
        'submission_id' => $submissionId
    ]);
    
} catch (Exception $e) {
    error_log("ERROR in get_submission_details.php: " . $e->getMessage());
    error_log("Stack trace: " . $e->getTraceAsString());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}

<?php
/**
 * User Calendar API
 * Handles fetching calendar events (deadlines, tasks) for the user
 */

// Start session first before any output
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Enable error display for debugging (set to 1 for debugging, 0 in production)
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);

// Set headers
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');

// Handle preflight requests
if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    // Include database configuration and functions
    require_once __DIR__ . '/../config/database.php';
    require_once __DIR__ . '/../includes/functions.php';
    
    // Check if user is logged in
    if (!isset($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'Unauthorized. Please log in.']);
        exit();
    }

    $userId = $_SESSION['user_id'];
    $pdo = getDB();
    $action = $_GET['action'] ?? 'get_events';

    switch ($action) {
        case 'get_events':
            getCalendarEvents($pdo, $userId);
            break;
        default:
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => 'Invalid action']);
            break;
    }
} catch (Exception $e) {
    error_log("Error in user_calendar.php: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Server error: ' . $e->getMessage()]);
}

/**
 * Get calendar events for the user
 */
function getCalendarEvents($pdo, $userId) {
    $events = []; // Initialize outside try-catch to ensure it's always available
    try {
        
        // Get user info including campus
        $userStmt = $pdo->prepare("SELECT office, campus FROM users WHERE id = :user_id");
        $userStmt->execute(['user_id' => $userId]);
        $user = $userStmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$user || empty($user['office'])) {
            echo json_encode([
                'success' => true,
                'data' => []
            ]);
            return;
        }
        
        $userOffice = trim($user['office']);
        $userCampus = trim($user['campus'] ?? '');
        $officeCampusCombo = trim($userOffice . ' ' . $userCampus);
        
        // 1. Get tasks with deadlines from table_assignments - SIMPLIFIED DIRECT APPROACH
        $tasks = []; // Initialize tasks array
        $testTasks = []; // Initialize test tasks array
        
        // SIMPLE DIRECT QUERY - bypass all the complex logic
        try {
            $simpleQuery = "
                SELECT 
                    ta.id,
                    ta.table_name,
                    ta.deadline,
                    ta.priority,
                    ta.status,
                    ta.description,
                    ta.assigned_office
                FROM table_assignments ta
                WHERE ta.status = 'active'
                AND ta.deadline IS NOT NULL
                AND ta.deadline != ''
                AND ta.deadline != '0000-00-00'
                AND (
                    LOWER(TRIM(ta.assigned_office)) = LOWER(:officeCampusCombo)
                    OR LOWER(TRIM(ta.assigned_office)) = LOWER(:office)
                    OR ta.assigned_office LIKE :officeLike
                )
                ORDER BY ta.deadline ASC
            ";
            
            $simpleStmt = $pdo->prepare($simpleQuery);
            $simpleStmt->execute([
                'officeCampusCombo' => $officeCampusCombo,
                'office' => $userOffice,
                'officeLike' => '%' . $userOffice . '%'
            ]);
            
            $tasks = $simpleStmt->fetchAll(PDO::FETCH_ASSOC);
            error_log("Calendar API: SIMPLE QUERY found " . count($tasks) . " tasks");
            
            // NOW DIRECTLY CREATE EVENTS FROM TASKS
            if (count($tasks) > 0) {
                error_log("Calendar API: Creating events directly from " . count($tasks) . " tasks");
                
                // Get completed tasks
                $completedTasks = [];
                try {
                    $subStmt = $pdo->prepare("
                        SELECT DISTINCT table_name 
                        FROM report_submissions 
                        WHERE user_id = :user_id 
                        AND office = :office
                        AND status IN ('approved', 'pending')
                    ");
                    $subStmt->execute([
                        'user_id' => $userId,
                        'office' => $userOffice
                    ]);
                    $completedTasks = array_column($subStmt->fetchAll(PDO::FETCH_ASSOC), 'table_name');
                } catch (Exception $e) {
                    error_log("Calendar API: Error getting completed tasks: " . $e->getMessage());
                }
                
                // Process each task into an event
                foreach ($tasks as $task) {
                    try {
                        $deadlineDate = $task['deadline'];
                        
                        // Format date
                        if (strpos($deadlineDate, ' ') !== false) {
                            $deadlineDate = explode(' ', $deadlineDate)[0];
                        }
                        $dateObj = new DateTime($deadlineDate);
                        $deadlineDate = $dateObj->format('Y-m-d');
                        
                        // Get event type
                        $isCompleted = in_array($task['table_name'], $completedTasks);
                        $eventType = 'upcoming';
                        if ($isCompleted) {
                            $eventType = 'completed';
                        } else {
                            $deadlineDateTime = new DateTime($deadlineDate);
                            $today = new DateTime();
                            $today->setTime(0, 0, 0);
                            $deadlineDateTime->setTime(0, 0, 0);
                            $diff = $today->diff($deadlineDateTime);
                            $daysLeft = (int)$diff->format('%r%a');
                            
                            if ($daysLeft < 0) {
                                $eventType = 'overdue';
                            } else if ($daysLeft <= 7) {
                                $eventType = 'due-soon';
                            }
                        }
                        
                        // Get report name
                        $reportName = getReportDisplayName($task['table_name']);
                        
                        // Create event
                        $event = [
                            'id' => 'task_' . $task['id'],
                            'title' => $reportName,
                            'date' => $deadlineDate,
                            'type' => $eventType,
                            'priority' => $task['priority'] ?? 'medium',
                            'table_name' => $task['table_name'],
                            'description' => $task['description'] ?? ''
                        ];
                        
                        $events[] = $event;
                        error_log("Calendar API: DIRECTLY created event: " . json_encode($event));
                    } catch (Exception $e) {
                        error_log("Calendar API: Error processing task " . $task['id'] . ": " . $e->getMessage());
                    }
                }
                
                error_log("Calendar API: DIRECTLY created " . count($events) . " events from " . count($tasks) . " tasks");
            }
        } catch (Exception $e) {
            error_log("Calendar API: Error in simple query: " . $e->getMessage());
        }
        
        // OLD COMPLEX CODE - keeping for fallback but simplified approach above should work
        try {
            $assignmentsTableExists = $pdo->query("SHOW TABLES LIKE 'table_assignments'")->fetch();
            if ($assignmentsTableExists && count($events) === 0) {
                // Check if deadline column exists
                $columnsCheck = $pdo->query("SHOW COLUMNS FROM table_assignments");
                $existingColumns = [];
                while ($col = $columnsCheck->fetch(PDO::FETCH_ASSOC)) {
                    $existingColumns[] = $col['Field'];
                }
                
                $hasDeadline = in_array('deadline', $existingColumns);
                $hasHasDeadline = in_array('has_deadline', $existingColumns);
                
                if ($hasDeadline) {
                    // Check if assigned_by column exists for campus filtering
                    $hasAssignedBy = in_array('assigned_by', $existingColumns);
                    
                    // Build WHERE conditions
                    $whereConditions = ["ta.status = 'active'"];
                    $whereConditions[] = "ta.deadline IS NOT NULL";
                    $whereConditions[] = "ta.deadline != ''";
                    $whereConditions[] = "ta.deadline != '0000-00-00'";
                    
                    // Include tasks with deadlines - be lenient with has_deadline flag
                    // Show any task with a valid deadline date, regardless of has_deadline flag
                    // This ensures tasks with deadlines set are always shown
                    if ($hasHasDeadline) {
                        // Don't filter by has_deadline - if there's a deadline date, show it
                        // This allows tasks to show even if admin forgot to check the "Set Deadline" checkbox
                    }
                    
                    // Office/campus filtering - try multiple matching strategies
                    $officeConditions = [];
                    $params = [];
                    
                    if ($hasAssignedBy) {
                        // Try multiple office matching patterns:
                        // 1. Exact match with office+campus combo
                        // 2. Office only match with campus check
                        // 3. Office match (in case campus wasn't included in assigned_office)
                        // 4. Partial match (office name contained in assigned_office)
                        $officeConditions[] = "(LOWER(TRIM(ta.assigned_office)) = LOWER(:officeCampusCombo) 
                            OR (LOWER(TRIM(ta.assigned_office)) = LOWER(:office) AND u.campus = :campus AND u.campus IS NOT NULL)
                            OR LOWER(TRIM(ta.assigned_office)) = LOWER(:office)
                            OR LOWER(ta.assigned_office) LIKE LOWER(:officeLike))";
                        $params['officeCampusCombo'] = $officeCampusCombo;
                        $params['office'] = $userOffice;
                        $params['campus'] = $userCampus;
                        $params['officeLike'] = '%' . $userOffice . '%';
                    } else {
                        // Try both exact match and partial match
                        $officeConditions[] = "(LOWER(TRIM(ta.assigned_office)) = LOWER(:office) OR LOWER(ta.assigned_office) LIKE LOWER(:officeLike))";
                        $params['office'] = $userOffice;
                        $params['officeLike'] = '%' . $userOffice . '%';
                    }
                    
                    $whereConditions[] = "(" . implode(" OR ", $officeConditions) . ")";
                    
                    $whereClause = implode(" AND ", $whereConditions);
                    
                    // Log the query for debugging
                    error_log("Calendar API Query: " . $whereClause);
                    error_log("Calendar API Params: " . json_encode($params));
                    error_log("Calendar API - Office: $userOffice, Campus: $userCampus, Combo: $officeCampusCombo");
                    
                    // Use a simpler, more direct query that should definitely work
                    // Since we know the exact format is "Resource Generation Lipa", match it directly
                    $simpleWhere = "ta.status = 'active' 
                        AND ta.deadline IS NOT NULL 
                        AND ta.deadline != '' 
                        AND ta.deadline != '0000-00-00'
                        AND (
                            LOWER(TRIM(ta.assigned_office)) = LOWER(:officeCampusCombo) 
                            OR LOWER(TRIM(ta.assigned_office)) = LOWER(:office)
                            OR LOWER(ta.assigned_office) LIKE LOWER(:officeLike)
                        )";
                    
                    $taskStmt = $pdo->prepare("
                        SELECT 
                            ta.id,
                            ta.table_name,
                            ta.deadline,
                            ta.priority,
                            ta.status,
                            ta.description,
                            ta.assigned_office
                        FROM table_assignments ta
                        WHERE $simpleWhere
                        ORDER BY ta.deadline ASC
                    ");
                    
                    $executeParams = [
                        'officeCampusCombo' => $officeCampusCombo,
                        'office' => $userOffice,
                        'officeLike' => '%' . $userOffice . '%'
                    ];
                    
                    error_log("Calendar API: Executing query with params: " . json_encode($executeParams));
                    
                    $execResult = $taskStmt->execute($executeParams);
                    
                    if (!$execResult) {
                        $errorInfo = $taskStmt->errorInfo();
                        error_log("Calendar API: Query execution failed - " . json_encode($errorInfo));
                        $tasks = [];
                    } else {
                        $tasks = $taskStmt->fetchAll(PDO::FETCH_ASSOC);
                        error_log("Calendar API: Direct query found " . count($tasks) . " tasks");
                        
                        if (count($tasks) > 0) {
                            error_log("Calendar API: First task - office: " . $tasks[0]['assigned_office'] . ", deadline: " . $tasks[0]['deadline']);
                            error_log("Calendar API: All task offices: " . json_encode(array_column($tasks, 'assigned_office')));
                        } else {
                            // Try a test query to see what's actually in the database
                            $testStmt = $pdo->query("
                                SELECT assigned_office, deadline, table_name 
                                FROM table_assignments 
                                WHERE status = 'active' 
                                AND deadline IS NOT NULL 
                                AND deadline != '' 
                                AND deadline != '0000-00-00'
                                LIMIT 5
                            ");
                            $testTasks = $testStmt->fetchAll(PDO::FETCH_ASSOC);
                            error_log("Calendar API: Test query (no office filter) found " . count($testTasks) . " tasks");
                            if (count($testTasks) > 0) {
                                error_log("Calendar API: Test tasks offices: " . json_encode(array_column($testTasks, 'assigned_office')));
                            }
                        }
                    }
                    
                    // Debug logging
                    error_log("Calendar API: Found " . count($tasks) . " tasks with deadlines for user $userId (office: $userOffice, campus: $userCampus)");
                    if (count($tasks) > 0) {
                        error_log("Calendar API: First task deadline: " . $tasks[0]['deadline']);
                        error_log("Calendar API: First task assigned_office: " . ($tasks[0]['assigned_office'] ?? 'N/A'));
                    } else {
                        // If no tasks found, let's check what assigned_office values actually exist
                        try {
                            $debugOfficeStmt = $pdo->prepare("
                                SELECT DISTINCT assigned_office, COUNT(*) as count 
                                FROM table_assignments 
                                WHERE status = 'active' 
                                AND deadline IS NOT NULL 
                                AND deadline != '' 
                                AND deadline != '0000-00-00'
                                GROUP BY assigned_office
                                LIMIT 10
                            ");
                            $debugOfficeStmt->execute();
                            $officeValues = $debugOfficeStmt->fetchAll(PDO::FETCH_ASSOC);
                            error_log("Calendar API: Available assigned_office values with deadlines: " . json_encode($officeValues));
                            
                            // Also check what the user's office values look like
                            error_log("Calendar API: User office: '$userOffice', Campus: '$userCampus', Combo: '$officeCampusCombo'");
                        } catch (Exception $e) {
                            error_log("Calendar API: Error checking office values: " . $e->getMessage());
                        }
                    }
                    
                    // Check which tasks are completed
                    $submissionsTableExists = $pdo->query("SHOW TABLES LIKE 'report_submissions'")->fetch();
                    $completedTasks = [];
                    
                    if ($submissionsTableExists) {
                        $subStmt = $pdo->prepare("
                            SELECT DISTINCT table_name 
                            FROM report_submissions 
                            WHERE user_id = :user_id 
                            AND office = :office
                            AND status IN ('approved', 'pending')
                        ");
                        $subStmt->execute([
                            'user_id' => $userId,
                            'office' => $userOffice
                        ]);
                        $completedTasks = array_column($subStmt->fetchAll(PDO::FETCH_ASSOC), 'table_name');
                    }
                    
                    error_log("Calendar API: Processing " . count($tasks) . " tasks into events");
                    error_log("Calendar API: Events array before loop: " . count($events));
                    error_log("Calendar API: Tasks array: " . json_encode(array_slice($tasks, 0, 1))); // Log first task
                    
                    if (count($tasks) === 0) {
                        error_log("Calendar API: WARNING - No tasks to process!");
                    } else {
                        error_log("Calendar API: About to enter foreach loop with " . count($tasks) . " tasks");
                    }
                    
                    $loopIterations = 0;
                    foreach ($tasks as $task) {
                        $loopIterations++;
                        error_log("Calendar API: Loop iteration $loopIterations");
                        error_log("Calendar API: Processing task - ID: " . $task['id'] . ", Table: " . $task['table_name'] . ", Deadline: " . $task['deadline']);
                        
                        $reportName = getReportDisplayName($task['table_name']);
                        $isCompleted = in_array($task['table_name'], $completedTasks);
                        
                        // Format deadline date as YYYY-MM-DD to avoid timezone issues
                        $deadlineDate = $task['deadline'];
                        if ($deadlineDate) {
                            // If it's a datetime, extract just the date part
                            if (strpos($deadlineDate, ' ') !== false) {
                                $deadlineDate = explode(' ', $deadlineDate)[0];
                            }
                            // Ensure it's in YYYY-MM-DD format
                            try {
                                $dateObj = new DateTime($deadlineDate);
                                $deadlineDate = $dateObj->format('Y-m-d');
                            } catch (Exception $e) {
                                error_log("Calendar API: Error formatting date '$deadlineDate': " . $e->getMessage());
                                continue; // Skip this task if date is invalid
                            }
                        } else {
                            error_log("Calendar API: Task " . $task['id'] . " has no deadline, skipping");
                            continue;
                        }
                        
                        try {
                            $eventType = getEventType($deadlineDate, $isCompleted);
                        } catch (Exception $e) {
                            error_log("Calendar API: Error getting event type for deadline '$deadlineDate': " . $e->getMessage());
                            $eventType = 'upcoming'; // Default to upcoming if there's an error
                        }
                        
                        $event = [
                            'id' => 'task_' . $task['id'],
                            'title' => $reportName,
                            'date' => $deadlineDate,
                            'type' => $eventType,
                            'priority' => $task['priority'] ?? 'medium',
                            'table_name' => $task['table_name'],
                            'description' => $task['description'] ?? ''
                        ];
                        
                        $events[] = $event;
                        error_log("Calendar API: Created event - " . json_encode($event));
                        error_log("Calendar API: Events array now has " . count($events) . " events");
                    }
                    
                    error_log("Calendar API: Loop completed. Iterations: $loopIterations, Events created: " . count($events));
                    error_log("Calendar API: Total events created: " . count($events));
                    if (count($events) > 0) {
                        error_log("Calendar API: Events array after loop: " . json_encode($events));
                    } else {
                        error_log("Calendar API: WARNING - Loop ran $loopIterations times but created 0 events!");
                    }
                    
                    // Make sure events are actually in the array
                    if (count($events) === 0 && count($tasks) > 0) {
                        error_log("Calendar API: WARNING - Tasks found but no events created! Tasks count: " . count($tasks));
                        error_log("Calendar API: Sample task data: " . json_encode($tasks[0] ?? []));
                    }
                }
            }
        } catch (Exception $e) {
            error_log("Error fetching assignments: " . $e->getMessage());
            // Continue without assignments
        }
        
        // 2. Get submission dates (optional - for tracking when reports were submitted)
        try {
            $submissionsTableExists = $pdo->query("SHOW TABLES LIKE 'report_submissions'")->fetch();
            if ($submissionsTableExists) {
                $subStmt = $pdo->prepare("
                    SELECT 
                        id,
                        table_name,
                        submission_date,
                        status
                    FROM report_submissions 
                    WHERE user_id = :user_id 
                    AND office = :office
                    AND submission_date >= DATE_SUB(NOW(), INTERVAL 3 MONTH)
                    ORDER BY submission_date DESC
                    LIMIT 20
                ");
                
                $subStmt->execute([
                    'user_id' => $userId,
                    'office' => $userOffice
                ]);
                
                $submissions = $subStmt->fetchAll(PDO::FETCH_ASSOC);
                
                foreach ($submissions as $submission) {
                    $reportName = getReportDisplayName($submission['table_name']);
                    
                    $events[] = [
                        'id' => 'submission_' . $submission['id'],
                        'title' => $reportName . ' - Submitted',
                        'date' => $submission['submission_date'],
                        'type' => $submission['status'] === 'approved' ? 'completed' : 'pending',
                        'priority' => 'low',
                        'table_name' => $submission['table_name'],
                        'description' => 'Report submitted on ' . date('F j, Y', strtotime($submission['submission_date']))
                    ];
                }
            }
        } catch (Exception $e) {
            error_log("Error fetching submissions: " . $e->getMessage());
            // Continue without submissions
        }
        
        // Debug logging
        error_log("Calendar API: Returning " . count($events) . " total events for user $userId");
        
        // Additional debug: Check what tasks exist for this user
        try {
            // First, get all unique assigned_office values to see what format they're in
            $officeFormatStmt = $pdo->query("
                SELECT DISTINCT assigned_office 
                FROM table_assignments 
                WHERE status = 'active' 
                AND deadline IS NOT NULL 
                AND deadline != '' 
                AND deadline != '0000-00-00'
                LIMIT 20
            ");
            $allOfficeFormats = $officeFormatStmt->fetchAll(PDO::FETCH_COLUMN);
            
            $debugStmt = $pdo->prepare("
                SELECT COUNT(*) as total, 
                       SUM(CASE WHEN deadline IS NOT NULL AND deadline != '' AND deadline != '0000-00-00' THEN 1 ELSE 0 END) as with_deadline,
                       SUM(CASE WHEN has_deadline = 1 THEN 1 ELSE 0 END) as has_deadline_flag
                FROM table_assignments ta
                WHERE ta.status = 'active'
                AND (
                    LOWER(TRIM(ta.assigned_office)) = LOWER(:officeCampusCombo)
                    OR LOWER(TRIM(ta.assigned_office)) = LOWER(:office)
                    OR LOWER(ta.assigned_office) LIKE LOWER(:officeLike)
                )
            ");
            $debugStmt->execute([
                'officeCampusCombo' => $officeCampusCombo,
                'office' => $userOffice,
                'officeLike' => '%' . $userOffice . '%'
            ]);
            $debugInfo = $debugStmt->fetch(PDO::FETCH_ASSOC);
            $debugInfo['all_office_formats'] = $allOfficeFormats;
            $debugInfo['user_office'] = $userOffice;
            $debugInfo['user_campus'] = $userCampus;
            $debugInfo['office_campus_combo'] = $officeCampusCombo;
        } catch (Exception $e) {
            $debugInfo = ['error' => $e->getMessage()];
        }
        
        // Get query execution info for debugging
        $queryDebug = [];
        if (isset($tasks)) {
            $queryDebug['tasks_found'] = count($tasks);
            if (count($tasks) > 0) {
                $queryDebug['sample_task'] = [
                    'office' => $tasks[0]['assigned_office'] ?? 'N/A',
                    'deadline' => $tasks[0]['deadline'] ?? 'N/A',
                    'table_name' => $tasks[0]['table_name'] ?? 'N/A'
                ];
            }
        }
        if (isset($testTasks)) {
            $queryDebug['test_query_tasks'] = count($testTasks);
            $queryDebug['test_offices'] = array_column($testTasks, 'assigned_office');
        }
        $queryDebug['events_array_count'] = count($events);
        $queryDebug['events_sample'] = count($events) > 0 ? $events[0] : null;
        
        // Final check - make sure events are in the response
        error_log("Calendar API: Final check - events count: " . count($events));
        if (count($events) > 0) {
            error_log("Calendar API: First event in final check: " . json_encode($events[0]));
        }
        
        echo json_encode([
            'success' => true,
            'data' => $events,
            'debug' => [
                'user_office' => $userOffice,
                'user_campus' => $userCampus,
                'office_campus_combo' => $officeCampusCombo,
                'events_count' => count($events),
                'tasks_debug' => $debugInfo ?? null,
                'query_debug' => $queryDebug
            ]
        ]);
    } catch (Exception $e) {
        error_log("Error fetching calendar events: " . $e->getMessage());
        error_log("Stack trace: " . $e->getTraceAsString());
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => 'Error fetching calendar events: ' . $e->getMessage()
        ]);
    }
}

/**
 * Get event type based on deadline
 */
function getEventType($deadline, $isCompleted = false) {
    if ($isCompleted) {
        return 'completed';
    }
    
    $deadlineDate = new DateTime($deadline);
    $today = new DateTime();
    $today->setTime(0, 0, 0);
    $deadlineDate->setTime(0, 0, 0);
    
    $diff = $today->diff($deadlineDate);
    $daysLeft = (int)$diff->format('%r%a');
    
    if ($daysLeft < 0) {
        return 'overdue';
    } else if ($daysLeft <= 7) {
        return 'due-soon';
    } else {
        return 'upcoming';
    }
}

/**
 * Get display name for report table
 */
function getReportDisplayName($tableName) {
    $reportNames = [
        'admissiondata' => 'Admission Data',
        'enrollmentdata' => 'Enrollment Data',
        'graduatesdata' => 'Graduates Data',
        'employee' => 'Employee Data',
        'leaveprivilege' => 'Leave Privilege',
        'libraryvisitor' => 'Library Visitor',
        'pwd' => 'PWD',
        'waterconsumption' => 'Water Consumption',
        'treatedwastewater' => 'Treated Waste Water',
        'electricityconsumption' => 'Electricity Consumption',
        'solidwaste' => 'Solid Waste',
        'campuspopulation' => 'Campus Population',
        'foodwaste' => 'Food Waste',
        'fuelconsumption' => 'Fuel Consumption',
        'distancetraveled' => 'Distance Traveled',
        'budgetexpenditure' => 'Budget Expenditure',
        'flightaccommodation' => 'Flight Accommodation'
    ];
    
    $tableNameLower = strtolower($tableName);
    
    if (isset($reportNames[$tableNameLower])) {
        return $reportNames[$tableNameLower];
    }
    
    return ucwords(str_replace(['_', '-'], ' ', $tableName));
}
?>


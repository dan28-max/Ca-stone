-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 27, 2025 at 03:52 PM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u296244758_spartan_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admissiondata`
--

CREATE TABLE `admissiondata` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `semester` varchar(50) DEFAULT NULL,
  `academic_year` varchar(20) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `program` varchar(200) DEFAULT NULL,
  `male` int(11) DEFAULT 0,
  `female` int(11) DEFAULT 0,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admissiondata`
--

INSERT INTO `admissiondata` (`id`, `campus`, `semester`, `academic_year`, `category`, `program`, `male`, `female`, `batch_id`, `submitted_by`, `submitted_at`, `created_at`, `updated_at`) VALUES
(52, 'Lobo', 'First Semester', '2025-2026', 'Total no. of applicants', 'BSIT', 3232, 32, '20251117135312_691ab84844e83_RESOURCE GENERATION', 0, '2025-11-17 05:53:12', '2025-11-17 05:53:12', '2025-11-17 05:53:12'),
(53, 'Lima', 'First Semester', '2025-2026', 'Total no. of applicants', 'CICS', 12, 12, '20251126223606_69271056ad202_REGISTRATION SERVICES', 0, '2025-11-26 14:36:06', '2025-11-26 14:36:06', '2025-11-26 14:36:06');

-- --------------------------------------------------------

--
-- Table structure for table `budgetexpenditure`
--

CREATE TABLE `budgetexpenditure` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `year` varchar(10) DEFAULT NULL,
  `particulars` text DEFAULT NULL,
  `category` varchar(200) DEFAULT NULL,
  `budget_allocation` decimal(15,2) DEFAULT 0.00,
  `actual_expenditure` decimal(15,2) DEFAULT 0.00,
  `utilization_rate` decimal(5,2) DEFAULT 0.00,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `campuspopulation`
--

CREATE TABLE `campuspopulation` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `year` varchar(10) NOT NULL,
  `students` int(11) DEFAULT 0,
  `is_students` int(11) DEFAULT 0,
  `employees` int(11) DEFAULT 0,
  `canteen` int(11) DEFAULT 0,
  `construction` int(11) DEFAULT 0,
  `total` int(11) DEFAULT 0,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_stats`
--

CREATE TABLE `dashboard_stats` (
  `id` int(11) NOT NULL,
  `stat_name` varchar(255) NOT NULL,
  `stat_value` varchar(255) NOT NULL,
  `stat_type` enum('number','percentage','text') DEFAULT 'number',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `data_submissions`
--

CREATE TABLE `data_submissions` (
  `id` int(11) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `assigned_office` varchar(100) NOT NULL,
  `submitted_by` int(11) NOT NULL,
  `submission_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`submission_data`)),
  `record_count` int(11) DEFAULT 0,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `review_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `distancetraveled`
--

CREATE TABLE `distancetraveled` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `travel_date` date DEFAULT NULL,
  `plate_no` varchar(50) DEFAULT NULL,
  `vehicle` varchar(100) DEFAULT NULL,
  `fuel_type` varchar(50) DEFAULT NULL,
  `start_mileage` decimal(10,2) DEFAULT 0.00,
  `end_mileage` decimal(10,2) DEFAULT 0.00,
  `total_km` decimal(10,2) DEFAULT 0.00,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drafts`
--

CREATE TABLE `drafts` (
  `id` int(11) NOT NULL,
  `report_type` varchar(255) NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `office` varchar(100) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `electricityconsumption`
--

CREATE TABLE `electricityconsumption` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `month` varchar(20) DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL,
  `prev_reading` decimal(10,2) DEFAULT 0.00,
  `current_reading` decimal(10,2) DEFAULT 0.00,
  `actual_consumption` decimal(10,2) DEFAULT 0.00,
  `multiplier` decimal(10,2) DEFAULT 1.00,
  `total_consumption` decimal(10,2) DEFAULT 0.00,
  `total_amount` decimal(10,2) DEFAULT 0.00,
  `price_per_kwh` decimal(10,2) DEFAULT 0.00,
  `remarks` text DEFAULT NULL,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `date_generated` date DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `faculty_rank` varchar(100) DEFAULT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `date_hired` date DEFAULT NULL,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `campus`, `date_generated`, `category`, `faculty_rank`, `sex`, `status`, `date_hired`, `batch_id`, `submitted_by`, `submitted_at`, `created_at`, `updated_at`) VALUES
(40, 'Lipa', '2025-11-17', 'Teaching', 'Teaching', 'Male', 'Hired', '2025-11-17', '20251117134724_691ab6ec86549_HUMAN RESOURCE MANAGEMENT', 0, '2025-11-17 05:47:24', '2025-11-17 05:47:24', '2025-11-17 05:47:24');

-- --------------------------------------------------------

--
-- Table structure for table `enrollmentdata`
--

CREATE TABLE `enrollmentdata` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `academic_year` varchar(20) DEFAULT NULL,
  `semester` varchar(50) DEFAULT NULL,
  `college` varchar(200) DEFAULT NULL,
  `graduate_undergrad` varchar(50) DEFAULT NULL,
  `program_course` varchar(200) DEFAULT NULL,
  `male` int(11) DEFAULT 0,
  `female` int(11) DEFAULT 0,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flightaccommodation`
--

CREATE TABLE `flightaccommodation` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `department` varchar(200) DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL,
  `travel_date` date DEFAULT NULL,
  `domestic_international` varchar(50) DEFAULT NULL,
  `traveler` varchar(255) DEFAULT NULL,
  `purpose` text DEFAULT NULL,
  `origin_info` varchar(200) DEFAULT NULL,
  `destination_info` varchar(200) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `trip_type` varchar(50) DEFAULT NULL,
  `kg_co2e` decimal(10,2) DEFAULT 0.00,
  `tco2e` decimal(10,2) DEFAULT 0.00,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `foodwaste`
--

CREATE TABLE `foodwaste` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `date` date DEFAULT NULL,
  `quantity_kg` decimal(10,2) DEFAULT 0.00,
  `remarks` text DEFAULT NULL,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fuelconsumption`
--

CREATE TABLE `fuelconsumption` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `date` date DEFAULT NULL,
  `driver` varchar(255) DEFAULT NULL,
  `vehicle` varchar(100) DEFAULT NULL,
  `plate_no` varchar(50) DEFAULT NULL,
  `fuel_type` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `transaction_no` varchar(100) DEFAULT NULL,
  `odometer` decimal(10,2) DEFAULT 0.00,
  `qty` decimal(10,2) DEFAULT 0.00,
  `total_amount` decimal(10,2) DEFAULT 0.00,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `graduatesdata`
--

CREATE TABLE `graduatesdata` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `academic_year` varchar(20) DEFAULT NULL,
  `semester` varchar(50) DEFAULT NULL,
  `degree_level` varchar(100) DEFAULT NULL,
  `subject_area` varchar(200) DEFAULT NULL,
  `course` varchar(200) DEFAULT NULL,
  `category` varchar(200) DEFAULT NULL,
  `male` int(11) DEFAULT 0,
  `female` int(11) DEFAULT 0,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leaveprivilege`
--

CREATE TABLE `leaveprivilege` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `leave_type` varchar(100) DEFAULT NULL,
  `employee_name` varchar(255) DEFAULT NULL,
  `duration_days` int(11) DEFAULT 0,
  `equivalent_pay` decimal(10,2) DEFAULT 0.00,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `libraryvisitor`
--

CREATE TABLE `libraryvisitor` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `visit_date` date DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `total_visitors` int(11) DEFAULT 0,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_requests`
--

CREATE TABLE `password_reset_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `requested_by_ip` varchar(100) DEFAULT NULL,
  `requested_user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_requests`
--

INSERT INTO `password_reset_requests` (`id`, `user_id`, `username`, `status`, `requested_by_ip`, `requested_user_agent`, `created_at`, `updated_at`) VALUES
(1, 106, 'lipa-rgo-ofc', 'pending', '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-10 23:42:41', NULL),
(2, 106, 'lipa-rgo-ofc', 'pending', '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 03:20:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pwd`
--

CREATE TABLE `pwd` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `year` varchar(10) DEFAULT NULL,
  `type_of_disability` varchar(200) DEFAULT NULL,
  `no_of_pwd_students` int(11) DEFAULT 0,
  `no_of_pwd_employees` int(11) DEFAULT 0,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_assignments`
--

CREATE TABLE `report_assignments` (
  `id` int(11) NOT NULL,
  `report_type` varchar(255) NOT NULL,
  `assigned_office` varchar(100) NOT NULL,
  `assigned_campus` varchar(100) NOT NULL,
  `assigned_by` int(11) NOT NULL,
  `assigned_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('active','completed','cancelled') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_submissions`
--

CREATE TABLE `report_submissions` (
  `id` int(11) NOT NULL,
  `assignment_id` int(11) DEFAULT NULL,
  `report_type` varchar(255) NOT NULL,
  `campus` varchar(100) DEFAULT NULL,
  `office` varchar(100) DEFAULT NULL,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submission_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`submission_data`)),
  `record_count` int(11) DEFAULT 0,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `review_notes` text DEFAULT NULL,
  `reviewed_date` datetime DEFAULT NULL COMMENT 'Timestamp when the submission was approved or rejected'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report_submissions`
--

INSERT INTO `report_submissions` (`id`, `assignment_id`, `report_type`, `campus`, `office`, `batch_id`, `submitted_by`, `submission_data`, `record_count`, `status`, `submitted_at`, `reviewed_by`, `reviewed_at`, `review_notes`, `reviewed_date`) VALUES
(322, NULL, 'employee', 'Lipa', 'HUMAN RESOURCE MANAGEMENT', '20251117134724_691ab6ec86549_HUMAN RESOURCE MANAGEMENT', 80, NULL, 0, 'pending', '2025-11-17 05:47:24', NULL, NULL, NULL, NULL),
(323, NULL, 'admissiondata', 'Lobo', 'RESOURCE GENERATION', '20251117135312_691ab84844e83_RESOURCE GENERATION', 130, NULL, 0, 'pending', '2025-11-17 05:53:12', NULL, NULL, NULL, NULL),
(324, NULL, 'waterconsumption', 'Lobo', 'RESOURCE GENERATION', '20251117135815_691ab97770332_RESOURCE GENERATION', 130, NULL, 0, 'pending', '2025-11-17 05:58:15', NULL, NULL, NULL, NULL),
(325, NULL, 'waterconsumption', 'Mabini', 'RESOURCE GENERATION', '20251117140041_691aba09dcbb0_RESOURCE GENERATION', 391, NULL, 0, 'pending', '2025-11-17 06:00:41', NULL, NULL, NULL, NULL),
(326, NULL, 'waterconsumption', 'Balayan', 'RESOURCE GENERATION', '20251117140217_691aba69a8fbf_RESOURCE GENERATION', 315, NULL, 0, 'pending', '2025-11-17 06:02:17', NULL, NULL, NULL, NULL),
(327, NULL, 'admissiondata', 'Lima', 'REGISTRATION SERVICES', '20251126223606_69271056ad202_REGISTRATION SERVICES', 472, NULL, 0, 'pending', '2025-11-26 14:36:06', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `report_submission_data`
--

CREATE TABLE `report_submission_data` (
  `id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL,
  `row_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`row_data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report_submission_data`
--

INSERT INTO `report_submission_data` (`id`, `submission_id`, `row_data`, `created_at`) VALUES
(322, 322, '{\"Campus\":\"Lipa\",\"Data Generated\":\"2025-11-17\",\"Category\":\"Teaching\",\"Faculty Rank\\/Designation\":\"Teaching\",\"Sex\":\"Male\",\"Employee Status\":\"Hired\",\"Date Hired\":\"2025-11-17\"}', '2025-11-17 05:47:24'),
(323, 323, '{\"Campus\":\"Lobo\",\"Semester\":\"First Semester\",\"Academic Year\":\"2025-2026\",\"Category\":\"Total no. of applicants\",\"Program\":\"BSIT\",\"Male\":\"3232\",\"Female\":\"32\"}', '2025-11-17 05:53:12'),
(324, 324, '{\"Campus\":\"Lobo\",\"Date\":\"2025-11-13\",\"Category\":\"Deep Well\",\"Prev Reading\":\"1001\",\"Current Reading\":\"1200\",\"Quantity (m^3)\":\"199.00\",\"Total Amount\":\"5970.00\",\"Price\\/m^3\":\"30\",\"Month\":\"January\",\"Year\":\"2023\",\"Remarks\":\"None\"}', '2025-11-17 05:58:15'),
(325, 325, '{\"Campus\":\"Mabini\",\"Date\":\"2025-11-17\",\"Category\":\"Deep Well\",\"Prev Reading\":\"1000\",\"Current Reading\":\"200\",\"Quantity (m^3)\":\"800.00\",\"Total Amount\":\"25600.00\",\"Price\\/m^3\":\"32\",\"Month\":\"January\",\"Year\":\"2023\",\"Remarks\":\"None\"}', '2025-11-17 06:00:41'),
(326, 326, '{\"Campus\":\"Balayan\",\"Date\":\"2025-11-17\",\"Category\":\"Deep Well\",\"Prev Reading\":\"2000\",\"Current Reading\":\"1800\",\"Quantity (m^3)\":\"200.00\",\"Total Amount\":\"6400.00\",\"Price\\/m^3\":\"32\",\"Month\":\"January\",\"Year\":\"2023\",\"Remarks\":\"None\"}', '2025-11-17 06:02:17'),
(327, 327, '{\"Campus\":\"Lima\",\"Semester\":\"First Semester\",\"Academic Year\":\"2025-2026\",\"Category\":\"Total no. of applicants\",\"Program\":\"CICS\",\"Male\":\"12\",\"Female\":\"12\"}', '2025-11-26 14:36:06');

-- --------------------------------------------------------

--
-- Table structure for table `solidwaste`
--

CREATE TABLE `solidwaste` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `month` varchar(20) DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL,
  `waste_type` varchar(100) DEFAULT NULL,
  `quantity` decimal(10,2) DEFAULT 0.00,
  `remarks` text DEFAULT NULL,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(255) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `description`, `created_at`, `updated_at`) VALUES
(1, 'system_name', 'Spartan Data', 'Name of the system', '2025-10-09 18:08:53', '2025-10-09 18:08:53'),
(2, 'theme_color', 'white_red', 'Current theme colors', '2025-10-09 18:08:53', '2025-10-09 18:08:53'),
(3, 'session_timeout', '3600', 'Session timeout in seconds', '2025-10-09 18:08:53', '2025-10-09 18:08:53'),
(4, 'max_login_attempts', '5', 'Maximum login attempts before lockout', '2025-10-09 18:08:53', '2025-10-09 18:08:53'),
(5, 'maintenance_mode', '0', 'System maintenance mode (0=off, 1=on)', '2025-10-09 18:08:53', '2025-10-09 18:08:53'),
(6, 'campus_hierarchy', '{\"campuses\":[{\"name\":\"Pablo Borbon\",\"parent\":null},{\"name\":\"Alangilan\",\"parent\":null},{\"name\":\"Lipa\",\"parent\":null},{\"name\":\"Malvar\",\"parent\":null},{\"name\":\"Nasugbu\",\"parent\":null},{\"name\":\"Rosario\",\"parent\":\"Pablo Borbon\"},{\"name\":\"San Juan\",\"parent\":\"Pablo Borbon\"},{\"name\":\"Lemery\",\"parent\":\"Pablo Borbon\"},{\"name\":\"Lobo\",\"parent\":\"Alangilan\"},{\"name\":\"Balayan\",\"parent\":\"Alangilan\"},{\"name\":\"Mabini\",\"parent\":\"Alangilan\"},{\"name\":\"Lima\",\"parent\":\"Alangilan\"}]}', NULL, '2025-11-26 14:22:48', '2025-11-26 14:22:48');

-- --------------------------------------------------------

--
-- Table structure for table `table_assignments`
--

CREATE TABLE `table_assignments` (
  `id` int(11) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `assigned_office` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `has_deadline` tinyint(1) DEFAULT 0,
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `notes` text DEFAULT NULL,
  `assigned_by` int(11) NOT NULL,
  `assigned_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('active','completed','cancelled') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `table_assignments`
--

INSERT INTO `table_assignments` (`id`, `table_name`, `assigned_office`, `description`, `deadline`, `has_deadline`, `priority`, `notes`, `assigned_by`, `assigned_date`, `status`, `created_at`, `updated_at`) VALUES
(514, 'employee', 'Human Resource Management Lipa', '', NULL, 0, 'low', '', 41, '2025-11-17 05:46:13', 'completed', '2025-11-17 05:46:13', '2025-11-17 05:47:24'),
(515, 'admissiondata', 'Resource Generation Lobo', '', '2025-11-19', 1, 'low', '', 1, '2025-11-17 05:52:18', 'completed', '2025-11-17 05:52:18', '2025-11-17 05:53:12'),
(516, 'waterconsumption', 'Resource Generation Lobo', '', '2025-11-19', 1, 'low', '', 1, '2025-11-17 05:57:11', 'completed', '2025-11-17 05:57:11', '2025-11-17 05:58:15'),
(517, 'waterconsumption', 'Resource Generation Balayan', '', '2025-11-19', 1, 'low', '', 1, '2025-11-17 05:57:11', 'completed', '2025-11-17 05:57:11', '2025-11-17 06:02:17'),
(518, 'waterconsumption', 'Resource Generation Mabini', '', '2025-11-19', 1, 'low', '', 1, '2025-11-17 05:57:11', 'completed', '2025-11-17 05:57:11', '2025-11-17 06:00:41'),
(519, 'admissiondata', 'OJT Lobo', '', '2025-11-22', 1, 'low', '', 83, '2025-11-22 08:06:38', 'active', '2025-11-22 08:06:38', '2025-11-22 08:06:38'),
(520, 'admissiondata', 'Registration Services Lima', '', NULL, 0, 'low', '', 471, '2025-11-26 14:35:10', 'completed', '2025-11-26 14:35:10', '2025-11-26 14:36:06');

-- --------------------------------------------------------

--
-- Table structure for table `treatedwastewater`
--

CREATE TABLE `treatedwastewater` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `date` date DEFAULT NULL,
  `treated_volume` decimal(10,2) DEFAULT 0.00,
  `reused_volume` decimal(10,2) DEFAULT 0.00,
  `effluent_volume` decimal(10,2) DEFAULT 0.00,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL COMMENT 'Primary and only login identifier',
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` enum('super_admin','admin','user') NOT NULL DEFAULT 'user',
  `campus` varchar(100) DEFAULT NULL COMMENT 'Campus assignment',
  `office` varchar(100) DEFAULT NULL COMMENT 'Office assignment',
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `role`, `campus`, `office`, `status`, `created_at`, `updated_at`, `last_login`, `remember_token`) VALUES
(1, 'superadmin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Super Administrator', 'super_admin', 'Main Campus', 'Administration', 'active', '2025-10-09 18:08:53', '2025-11-27 14:10:51', '2025-11-27 14:10:51', NULL),
(41, 'lipa-admin-acc', '$2y$10$5vAm12FJNpm3oLQ.kwoNrOHn7BTY0slbGehCqcUamkfQNhTxns6Ai', 'lipa-admin-acc', 'admin', 'Lipa', '', 'active', '2025-11-08 03:10:50', '2025-11-17 05:44:43', '2025-11-17 05:44:43', NULL),
(42, 'lipa-rgtr-ofc', '$2y$10$MmcuXwEkgd7uhAWgSz826OZB8u73Kc4BcHD588iu9SP.t8PVl6Mg2', 'lipa-rgtr-ofc', 'user', 'Lipa', 'Registrar Office', 'active', '2025-11-08 03:13:56', '2025-11-14 05:14:07', '2025-11-14 05:14:07', NULL),
(43, 'lipa-acct-ofc', '$2y$10$dJ6r3MDOy0v26N262DhWlufijTUK8WVMJOmSWV7EGbmpnQW7oAksi', 'lipa-acct-ofc', 'user', 'Lipa', 'Accounting Office', 'active', '2025-11-08 03:16:21', '2025-11-08 03:16:21', NULL, NULL),
(45, 'lipa-ia-ofc', '$2y$10$1XuAC9EmiMoOhbOIMr.T7uP/Fpf5aM4tFJXg/AGmlBLjUT0W5z4/i', 'lipa-ia-ofc', 'user', 'Lipa', 'Internal Audit', 'active', '2025-11-08 03:19:38', '2025-11-08 03:19:38', NULL, NULL),
(46, 'lipa-qam-ofc', '$2y$10$uhGAyacpDUzv3mWVpxNzteyTmk1n5Qnz9rqMkRvZshAG4gF1V9PDa', 'lipa-qam-ofc', 'user', 'Lipa', 'Quality Assurance Management', 'active', '2025-11-08 03:21:52', '2025-11-08 03:21:52', NULL, NULL),
(48, 'lipa-pdc-ofc', '$2y$10$mtjXU/B/doiCNw/Q2L8VHOaS1gr3.lRL2xIk5hLAvV.cWHk5eoUvO', 'lipa-pdc-ofc', 'user', 'Lipa', 'Planning and Development', 'active', '2025-11-08 03:42:32', '2025-11-08 03:42:32', NULL, NULL),
(49, 'lipa-ea-ofc', '$2y$10$Js0hHJ7SVeElnQJLR9p4Hu2t8J1aYc3dq6xalymc0fqxiLT84A/3G', 'lipa-ea-ofc', 'user', 'Lipa', 'External Affairs', 'active', '2025-11-08 03:43:59', '2025-11-08 03:43:59', NULL, NULL),
(51, 'lipa-ict-ofc', '$2y$10$XXXhEFfXizDyEkw1eJmdcO5sRjAOP6ni0j2CgVb476CFbahyZi55i', 'lipa-ict-ofc', 'user', 'Lipa', 'ICT Services', 'active', '2025-11-08 03:49:33', '2025-11-08 03:49:33', NULL, NULL),
(54, 'lipa-cas-ofc', '$2y$10$jdK40EWmbKQHKXt1kmFxZOcNeh2uDtnd3nf.pCYiU2gE/7azGmU6S', 'lipa-cas-ofc', 'user', 'Lipa', 'College of Arts and Sciences', 'active', '2025-11-08 03:53:39', '2025-11-08 03:53:39', NULL, NULL),
(55, 'lipa-cabe-ofc', '$2y$10$9Lkg/jbAEzo2Awgc0QkOB.oBtu7Pbuiy3WGh4CAR85ocLCyDz275C', 'lipa-cabe-ofc', 'user', 'Lipa', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 03:54:40', '2025-11-08 03:54:40', NULL, NULL),
(56, 'lipa-cics-ofc', '$2y$10$a6pj0qQajA5IlMZyq0JtDuLi1TFH/TvF0PSHqVnaoj.mR6HlOiouq', 'lipa-cics-ofc', 'user', 'Lipa', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 03:56:09', '2025-11-08 03:56:09', NULL, NULL),
(57, 'lipa-cet-ofc', '$2y$10$eEqBrBUlrqUWwyp2Qt4ww.eaOlMZu4BoId5MPvkpfIGzFNm.BqaHK', 'lipa-cet-ofc', 'user', 'Lipa', 'College of Engineering Technology', 'active', '2025-11-08 03:56:57', '2025-11-08 03:56:57', NULL, NULL),
(58, 'lipa-cte-ofc', '$2y$10$MVcrfhupDjhWS.Z.75y4ke3VOt4naZInkCA/.yYwc0KXh6yK0r0s2', 'lipa-cte-ofc', 'user', 'Lipa', 'College of Teacher Education', 'active', '2025-11-08 03:58:42', '2025-11-08 03:58:42', NULL, NULL),
(59, 'lipa-ce-ofc', '$2y$10$FL4TWdfhoi4GRqchN4um..KFTWP1r.86QEcC4u5NqKDOTVTxagAji', 'lipa-ce-ofc', 'user', 'Lipa', 'College of Engineering', 'active', '2025-11-08 03:59:42', '2025-11-08 03:59:42', NULL, NULL),
(60, 'lipa-ca-ofc', '$2y$10$7oDmBx0afmq0TzM8Ct0hUu8cI.1vJkPk2TzsLXz/MT69.l8KU2J5O', 'lipa-ca-ofc', 'user', 'Lipa', 'Culture and Arts', 'active', '2025-11-08 04:00:34', '2025-11-08 04:00:34', NULL, NULL),
(61, 'lipa-ta-ofc', '$2y$10$Uy.gCZP.nxluC4w8esJMi.NEktQkCvwb5aS76RnGFLQa9S0lRJW12', 'lipa-ta-ofc', 'user', 'Lipa', 'Testing and Admission', 'active', '2025-11-08 04:03:47', '2025-11-08 04:03:47', NULL, NULL),
(62, 'lipa-sfa-ofc', '$2y$10$vZFcCkaDefW8U/3thp5NT.VVdJJjJ9ZGWs1/XXIIRDB/ecDPyMmRq', 'lipa-sfa-ofc', 'user', 'Lipa', 'Scholarship and Financial Assistance', 'active', '2025-11-08 04:12:29', '2025-11-08 04:12:29', NULL, NULL),
(63, 'lipa-gc-ofc', '$2y$10$h/f2oMMRXkBslClL3MlZDuhHQ.G4nXcAes/9/2k/Jf3Dovi7ITX.y', 'lipa-gc-ofc', 'user', 'Lipa', 'Guidance and Counseling', 'active', '2025-11-08 04:14:41', '2025-11-08 04:14:41', NULL, NULL),
(65, 'lipa-soa-ofc', '$2y$10$uMvIVXMby7jowypWORJGteXHD54IKj2iD/X/3TyJQbZs8LXk0OBJC', 'lipa-soa-ofc', 'user', 'Lipa', 'Student Organization and Activities', 'active', '2025-11-08 04:17:23', '2025-11-08 04:17:23', NULL, NULL),
(66, 'lipa-sd-ofc', '$2y$10$W5kINzUA5FJLkGZCMxNjfubQEA5bbeyW5gMhZ7W4urmst/ZWruCFq', 'lipa-sd-ofc', 'user', 'Lipa', 'Student Discipline', 'active', '2025-11-08 04:18:00', '2025-11-08 04:18:00', NULL, NULL),
(67, 'lipa-sad-ofc', '$2y$10$Y7eYfcWi..ycIXP.22Z2X.13ZBXTsV7F2AcWSx0dqlacImPmX/3OS', 'lipa-sad-ofc', 'user', 'Lipa', 'Sports and Development', 'active', '2025-11-08 04:24:42', '2025-11-08 04:24:42', NULL, NULL),
(68, 'lipa-ojt-ofc', '$2y$10$sadaCxGt/xV3yQQ8E3mRd.G9kwJtkfpkPlx/MBikORzjjw/Zs3.eG', 'lipa-ojt-ofc', 'user', 'Lipa', 'OJT', 'active', '2025-11-08 04:25:56', '2025-11-08 04:25:56', NULL, NULL),
(69, 'lipa-nstp-ofc', '$2y$10$V8W0Hn9fDs.DnXOF3vMkne2W5iWCwPkjgm47kDAb/HsoIcAYvUhSi', 'lipa-nstp-ofc', 'user', 'Lipa', 'National Service Training Program', 'active', '2025-11-08 04:27:07', '2025-11-08 04:27:07', NULL, NULL),
(70, 'lipa-rm-ofc', '$2y$10$sw3vMwB2tRjaOHPvM7r7QeiTdyCzc3kSloO0RnDbfKbHv4NCshJ92', 'lipa-rm-ofc', 'user', 'Lipa', 'Records Management', 'active', '2025-11-08 04:29:28', '2025-11-08 04:29:28', NULL, NULL),
(71, 'lipa-pcr-ofc', '$2y$10$6CK2Fv3DE64VnfAM2ibt9ODDCCvyH8FdiTugRaoqrhMnTsXdV448a', 'lipa-pcr-ofc', 'user', 'Lipa', 'Procurement', 'active', '2025-11-08 04:33:42', '2025-11-08 04:33:42', NULL, NULL),
(72, 'lipa-bdgt-ofc', '$2y$10$A6YeFdrzEYvJExBwDhweu.lSstAaB4H8zZFfQynzhQgNqz1ULwbgq', 'lipa-bdgt-ofc', 'user', 'Lipa', 'Budget office', 'active', '2025-11-08 04:35:03', '2025-11-08 04:35:03', NULL, NULL),
(73, 'lipa-cd-ofc', '$2y$10$kiSAIHdVS4hGs2MdBKjtMu3TZm21YBJd4v31oG0T6dCCXQ4HB7YwW', 'lipa-cd-ofc', 'user', 'Lipa', 'Cashiering/Disbursing', 'active', '2025-11-08 04:37:47', '2025-11-08 04:37:47', NULL, NULL),
(74, 'lipa-pfm-ofc', '$2y$10$CfTQEpXq3dGPahhF7kwhEukXd2u6ui6.oaq75Wf9TAPJTv4TIa6ce', 'lipa-pfm-ofc', 'user', 'Lipa', 'Project Facilities and Management', 'active', '2025-11-08 04:40:50', '2025-11-14 04:47:34', '2025-11-14 04:47:34', NULL),
(75, 'lipa-emu-ofc', '$2y$10$j0CWpmG.pKMYCKQiEKVFC.StSwMxur2XIY2qca10rt9wYcNjqQUIW', 'lipa-emu-ofc', 'user', 'Lipa', 'Environment Management Unit', 'active', '2025-11-08 05:35:31', '2025-11-08 05:35:31', NULL, NULL),
(76, 'lipa-psm-ofc', '$2y$10$yhp2xEF0m0iTVH.TdQCNKunCqX9yX0kVxkr9D51zp5TFPNJWU5t7e', 'lipa-psm-ofc', 'user', 'Lipa', 'Property and Supply Management', 'active', '2025-11-08 05:36:38', '2025-11-08 05:36:38', NULL, NULL),
(77, 'lipa-gso-ofc', '$2y$10$gq.vjX.NVA/RQswTyGEuE.i53WL6wEgdTT57GVoPSGtanSRvlOc8q', 'lipa-gso-ofc', 'user', 'Lipa', 'General Services', 'active', '2025-11-08 05:37:52', '2025-11-11 02:21:00', '2025-11-11 02:21:00', NULL),
(78, 'lipa-ext-ofc', '$2y$10$Rgi4Qyng.tKp24vPwEavZunvYjoHEAuaegacn/UKbgTTs7jA6BSRa', 'lipa-ext-ofc', 'user', 'Lipa', 'Extension', 'active', '2025-11-08 05:39:03', '2025-11-08 05:39:03', NULL, NULL),
(79, 'lipa-rsch-ofc', '$2y$10$ChBbsxmWLnNcqtA1l8uEj.9YJ//IuynlN.5BtLaIQdZ9xY08w5O0G', 'lipa-rsch-ofc', 'user', 'Lipa', 'Research', 'active', '2025-11-08 05:40:43', '2025-11-08 05:40:43', NULL, NULL),
(80, 'lipa-hrmo-ofc', '$2y$10$xRKvDNFDvA7K78L5VULbhO3YqgEY1cizpaGTj5y5SLOTg1/./leQG', 'lipa-hrmo-ofc', 'user', 'Lipa', 'Human Resource Management', 'active', '2025-11-08 05:42:39', '2025-11-17 05:46:43', '2025-11-17 05:46:43', NULL),
(81, 'lipa-hs-ofc', '$2y$10$lCoQ5HYQ23gVpWX5LoCEX.6BxDlIHDy18U80qPdVbsIARbJtiQqCO', 'lipa-hs-ofc', 'user', 'Lipa', 'Health Services', 'active', '2025-11-08 05:44:34', '2025-11-08 05:44:34', NULL, NULL),
(82, 'san-juan-admin-acc', '$2y$10$sjJxePIaAGm5RU8.3lpQJOEhEXzu5rirgwOtrJ1K45ryNkNUhwfGi', 'san-juan-admin-acc', 'admin', 'San Juan', '', 'active', '2025-11-08 05:53:00', '2025-11-16 13:50:43', '2025-11-16 13:50:43', NULL),
(83, 'lobo-admin-acc', '$2y$10$OCDf5xssCF/dOIu8iunqcuIJrlfuqgbyrej3YePJ3ALusfUJcKlj.', 'lobo-admin-acc', 'admin', 'Lobo', '', 'active', '2025-11-08 05:54:23', '2025-11-22 08:05:29', '2025-11-22 08:05:29', NULL),
(84, 'sj-rgtr-ofc', '$2y$10$8iuJDSQ2j65GPtl1cBUq5uRIyB.NVwSIVrf2B/.VyZ.lEon43xSQK', 'sj-rgtr-ofc', 'user', 'San Juan', 'Registrar Office', 'active', '2025-11-08 05:59:50', '2025-11-08 05:59:50', NULL, NULL),
(86, 'sj-ia-ofc', '$2y$10$wBbrmbZPivJbU0XmzfPx4uNn91jEAMwtqxzco3ndOP0A.Yrof9xUC', 'sj-ia-ofc', 'user', 'San Juan', 'Internal Audit', 'active', '2025-11-08 06:07:23', '2025-11-08 06:07:23', NULL, NULL),
(87, 'sj-qam-ofc', '$2y$10$tZpzX2nhqTNbX3DiTfHtYufxEMTtLkB7HDZGIxxBWfD.P5ccKtjEK', 'sj-qam-ofc', 'user', 'San Juan', 'Quality Assurance Management', 'active', '2025-11-08 06:08:31', '2025-11-08 06:08:31', NULL, NULL),
(88, 'sj-pdc-ofc', '$2y$10$DopP1m9d/5rUl.JMqKJIH.YPA1Y1cu1YYdMY8VtZb7RSJjGVIo552', 'sj-pdc-ofc', 'user', 'San Juan', 'Planning and Development', 'active', '2025-11-08 06:14:57', '2025-11-08 06:14:57', NULL, NULL),
(89, 'sj-ea-ofc', '$2y$10$r/YaxxkrZJAQ1o49Riuzc.UKQKe4CqvJEn2Bwv4Zzm9GTBeQfj.6i', 'sj-ea-ofc', 'user', 'San Juan', 'External Affairs', 'active', '2025-11-08 06:16:44', '2025-11-08 06:16:44', NULL, NULL),
(90, 'sj-rgo-ofc', '$2y$10$UsYWjJ7AKAWCe8I.Ld5Nye6xi53Bak/PlmOAwONMJZ1ZKW7ELGxK2', 'sj-rgo-ofc', 'user', 'San Juan', 'Resource Generation', 'active', '2025-11-08 06:17:44', '2025-11-17 03:41:04', '2025-11-17 03:41:04', NULL),
(91, 'sj-ict-ofc', '$2y$10$zG/PCKv7Iy15uU6BOjk3iuYmp9/XSP8scuzpV7IZmiOgU3tP/qzEO', 'sj-ict-ofc', 'user', 'San Juan', 'ICT Services', 'active', '2025-11-08 06:41:42', '2025-11-08 06:41:42', NULL, NULL),
(92, 'sj-cas-ofc', '$2y$10$qX7gropPdN7bj7S6lYyloe9/D93efD4OrkOd4L/faxN6AVLzE7Nke', 'sj-cas-ofc', 'user', 'San Juan', 'College of Arts and Sciences', 'active', '2025-11-08 06:43:07', '2025-11-08 06:43:07', NULL, NULL),
(93, 'sj-cabe-ofc', '$2y$10$xXQef/Rc1vpyQdzPmc.JoeFancKfwxCzq1rXxE1XuAFzGjGjTNuCS', 'sj-cabe-ofc', 'user', 'San Juan', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 06:44:04', '2025-11-14 08:46:42', '2025-11-14 08:46:42', NULL),
(94, 'sj-cics-ofc', '$2y$10$3UAoZxMBPyWlx9LAEkOy9.lcFnT/wlbZ13BYyZzQ7qXpVIW5O6oTe', 'sj-cics-ofc', 'user', 'San Juan', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 06:45:00', '2025-11-08 06:45:00', NULL, NULL),
(95, 'sj-cet-ofc', '$2y$10$Frx3laKlIgScN.t52V6paugvlwgs5DVowZCi7yhspI/dT1SpKWoD.', 'sj-cet-ofc', 'user', 'San Juan', 'College of Engineering Technology', 'active', '2025-11-08 06:46:08', '2025-11-08 06:46:08', NULL, NULL),
(96, 'sj-cte-ofc', '$2y$10$OBKMhsYUjS7qRzSDtw27Auw4j92S1H9/57AuueS1Az4H5.hDIiRLS', 'sj-cte-ofc', 'user', 'San Juan', 'College of Teacher Education', 'active', '2025-11-08 06:47:58', '2025-11-08 06:47:58', NULL, NULL),
(97, 'sj-ce-ofc', '$2y$10$eIiykSTba0MxW6bzB2oPCOV7Q58RJWZKHg.GblZRcZsBWgKsQtuMS', 'sj-ce-ofc', 'user', 'San Juan', 'College of Engineering', 'active', '2025-11-08 06:49:27', '2025-11-08 06:49:27', NULL, NULL),
(98, 'sj-ca-ofc', '$2y$10$GhTosOuOFkx6.Ku8SuZEtOzwEQfH2cQl6N5I8otrU5Rs7S0likZ5m', 'sj-ca-ofc', 'user', 'San Juan', 'Culture and Arts', 'active', '2025-11-08 06:50:29', '2025-11-08 06:50:29', NULL, NULL),
(99, 'sj-tao-ofc', '$2y$10$h7ae3oLQWMED4bIH2JQYruFp9Ny//oOQjD8B9iHBq5Mrgu2Ydb3wu', 'sj-tao-ofc', 'user', 'San Juan', 'Testing and Admission', 'active', '2025-11-08 06:51:31', '2025-11-08 06:51:31', NULL, NULL),
(100, 'sj-rs-ofc', '$2y$10$LIBjc4b9xuEFRXhqJOaOkOngn51iusisPn2gj70DE0XOSIbyBGG8O', 'sj-rs-ofc', 'user', 'San Juan', 'Registration Services', 'active', '2025-11-08 06:52:44', '2025-11-08 06:52:44', NULL, NULL),
(101, 'sj-sfa-ofc', '$2y$10$6HcmCPNd6LveSFWcVYjAIeJMfVylqcMMg2V3RexLJ8yBSNaF8jO02', 'sj-sfa-ofc', 'user', 'San Juan', 'Scholarship and Financial Assistance', 'active', '2025-11-08 06:54:21', '2025-11-08 06:54:21', NULL, NULL),
(102, 'sj-gc-ofc', '$2y$10$Szq3HudcxGEGGscjYkQzv.FgmK5ETN94zCL0niPDj.Vn6XE4LLhqW', 'sj-gc-ofc', 'user', 'San Juan', 'Guidance and Counseling', 'active', '2025-11-08 06:56:54', '2025-11-08 06:56:54', NULL, NULL),
(103, 'sj-soa-ofc', '$2y$10$HhLCdrnlwcL6JgjVynYNB.DWZQTzAR6PkkllBApN31/Rdo9ZK3yRS', 'sj-soa-ofc', 'user', 'San Juan', 'Student Organization and Activities', 'active', '2025-11-08 06:58:11', '2025-11-08 06:58:11', NULL, NULL),
(104, 'sj-sd-ofc', '$2y$10$mCMbiD1HJzQoAh7duTDVvOKIoxK1oC8q3uLeZ6tvgkgFeCJ5BsxGO', 'sj-sd-ofc', 'user', 'San Juan', 'Student Discipline', 'active', '2025-11-08 06:59:22', '2025-11-08 06:59:22', NULL, NULL),
(105, 'sj-sad-ofc', '$2y$10$MyT6z6extnhi8QuGdE5RiOrjSb1/tQTypPMB4/4dg.b1cSfzdVHeO', 'sj-sad-ofc', 'user', 'San Juan', 'Sports and Development', 'active', '2025-11-08 07:01:51', '2025-11-08 07:01:51', NULL, NULL),
(106, 'lipa-rgo-ofc', '$2y$10$ytykBDfBCDjwXuOBoWBt5e13q6dUMxQxFfi6X4aMnTwnLh35ix3O6', 'lipa-rgo-ofc', 'user', 'Lipa', 'Resource Generation', 'active', '2025-11-08 07:01:53', '2025-11-27 15:29:39', '2025-11-27 15:29:39', NULL),
(107, 'sj-ojt-ofc', '$2y$10$C2c4L66XCFRAhhPHEeT.vO7nWREJkGa79wKq6dYXuQDFK533avVcK', 'sj-ojt-ofc', 'user', 'San Juan', 'OJT', 'active', '2025-11-08 07:02:53', '2025-11-08 09:24:36', '2025-11-08 09:24:36', NULL),
(108, 'sj-nstp-ofc', '$2y$10$2MhppgyC0jJw/U99MzkjWurZ/cOYgKp7JuPTn/z37qwZ0ItgqeCAi', 'sj-nstp-ofc', 'user', 'San Juan', 'National Service Training Program', 'active', '2025-11-08 07:03:46', '2025-11-08 07:03:46', NULL, NULL),
(109, 'sj-hrmo-ofc', '$2y$10$MzCtdNlCUJnR50IZpteBGOkXNj9GKL6g1UHCo02jtvyzJaRq0EUKq', 'sj-hrmo-ofc', 'user', 'San Juan', 'Human Resource Management', 'active', '2025-11-08 07:05:30', '2025-11-08 07:05:30', NULL, NULL),
(110, 'sj-rm-ofc', '$2y$10$PMH2h1dc2oiUh76AUiXLi.OvyTQYIx7lqXw479xOnf.b9Ccpm/eFu', 'sj-rm-ofc', 'user', 'San Juan', 'Records Management', 'active', '2025-11-08 07:06:36', '2025-11-08 07:06:36', NULL, NULL),
(111, 'sj-pcr-ofc', '$2y$10$s.KvzmY0DpFIUW34CPZ3m.XLulZUAzp9Y5/QTpBRsHkHf/p6dkpVO', 'sj-pcr-ofc', 'user', 'San Juan', 'Procurement', 'active', '2025-11-08 07:08:04', '2025-11-08 07:08:04', NULL, NULL),
(113, 'sj-cd-ofc', '$2y$10$clomQuRYxfbySvl4m.wMH.LKQuMA604b6gj2pzjucAa98.vHHYOLu', 'sj-cd-ofc', 'user', 'San Juan', 'Cashiering/Disbursing', 'active', '2025-11-08 07:10:40', '2025-11-08 07:10:40', NULL, NULL),
(114, 'sj-acct-ofc', '$2y$10$TPvdylvpqN2cXQ8nNRM.HOHS1Xr9Po5O7HOmMfA6rSM9t/lOqZ2fq', 'sj-acct-ofc', 'user', 'San Juan', 'Accounting Office', 'active', '2025-11-08 07:12:55', '2025-11-08 14:26:07', '2025-11-08 14:26:07', NULL),
(115, 'sj-bdgt-ofc', '$2y$10$fTA2Z6P0YIhFm9u.4Q9PX.lcsqX6UxVwjIAVIbsoBiRCRVME0eQm6', 'sj-bdgt-ofc', 'user', 'San Juan', 'Budget office', 'active', '2025-11-08 07:37:20', '2025-11-08 07:37:20', NULL, NULL),
(116, 'sj-pfm-ofc', '$2y$10$CF1MoAX84UG0mKdTbEj5pOEMxszMvh02HvLwHGD5gGK7KS3./wPoy', 'sj-pfm-ofc', 'user', 'San Juan', 'Project Facilities and Management', 'active', '2025-11-08 07:41:48', '2025-11-08 07:41:48', NULL, NULL),
(117, 'sj-emu-ofc', '$2y$10$1HevSzNROCpTXIOktz2Pqu55AOShw4xKW0KBd97g4PyhqWWbn4Ddi', 'sj-emu-ofc', 'user', 'San Juan', 'Environment Management Unit', 'active', '2025-11-08 07:42:46', '2025-11-08 07:42:46', NULL, NULL),
(118, 'sj-psm-ofc', '$2y$10$PSqaF9ximeXxdVYRd5AI5O/eYkBOtnR96TgI1kXVDsJ2z2r6q2loW', 'sj-psm-ofc', 'user', 'San Juan', 'Property and Supply Management', 'active', '2025-11-08 07:43:46', '2025-11-08 07:43:46', NULL, NULL),
(119, 'sj-gso-ofc', '$2y$10$.f1vXGdaPAHPmT5YPWminOiZrBxig8rD.AXkexnJMoyRMIOYu5tCa', 'sj-gso-ofc', 'user', 'San Juan', 'General Services', 'active', '2025-11-08 07:45:14', '2025-11-08 07:45:14', NULL, NULL),
(120, 'sj-ext-ofc', '$2y$10$gM/teukiEyiY4EW5RwkGwuiYkSBQ4ANyYgGC9MwJSFo4fECcVg3Qi', 'sj-ext-ofc', 'user', 'San Juan', 'Extension', 'active', '2025-11-08 07:46:37', '2025-11-08 07:46:37', NULL, NULL),
(121, 'sj-rsch-ofc', '$2y$10$zqpkdO3/rGT598aZEhPsbuLcCOwR2ZINPtNPnwaG9.Tt4NRdGc/Re', 'sj-rsch-ofc', 'user', 'San Juan', 'Research', 'active', '2025-11-08 07:48:12', '2025-11-08 07:48:12', NULL, NULL),
(122, 'sj-hs-ofc', '$2y$10$WeCBLAHO/4ZCV2UJEMOpiO/AIBFRvUgwm.DxCUzcWlKZe7mqLV6Zy', 'sj-hs-ofc', 'user', 'San Juan', 'Health Services', 'active', '2025-11-08 07:49:07', '2025-11-08 07:49:07', NULL, NULL),
(123, 'lobo-rgtr-ofc', '$2y$10$nZMCvLlNqE6VMnFQ7jvR8OMFoddzzAE..BHvWqPOUfCcLKsACX.US', 'lobo-rgtr-ofc', 'user', 'Lobo', 'Registrar Office', 'active', '2025-11-08 08:01:25', '2025-11-08 09:28:00', '2025-11-08 09:28:00', NULL),
(124, 'lobo-acct-ofc', '$2y$10$sr1UOAWQOf1cGPuB52QAR.XynC6gefSLPLLr5GPOv5.IPmVVBhzE2', 'lobo-acct-ofc', 'user', 'Lobo', 'Accounting Office', 'active', '2025-11-08 08:02:33', '2025-11-17 00:16:30', '2025-11-17 00:16:30', NULL),
(126, 'lobo-ia-ofc', '$2y$10$EckzpVRKG248RaS/QuRzE.1FoNnIiaIUbn2LVSvR0Pos9QytYvDvG', 'lobo-ia-ofc', 'user', 'Lobo', 'Internal Audit', 'active', '2025-11-08 08:04:08', '2025-11-08 11:59:24', '2025-11-08 11:59:24', NULL),
(127, 'lobo-Qam-ofc', '$2y$10$PLAAmDTDycGQ/KTWZO7kcud/UeAjhEvh7mHF2N2M1h.Qkjc/u.pla', 'lobo-Qam-ofc', 'user', 'Lobo', 'Quality Assurance Management', 'active', '2025-11-08 08:05:04', '2025-11-08 12:00:05', '2025-11-08 12:00:05', NULL),
(128, 'lobo-pdc-ofc', '$2y$10$Kxj7uKc4N0XkD8zKQZfzFOX4hI6Uvo8Td4CHUXQooq/QvgkPkQiWq', 'lobo-pdc-ofc', 'user', 'Lobo', 'Planning and Development', 'active', '2025-11-08 08:05:30', '2025-11-08 12:05:47', '2025-11-08 12:05:47', NULL),
(129, 'lobo-ea-ofc', '$2y$10$m.nxBw6EVChk0h17vZHvv.xLfjyw2J7nq23xjmozVvntSs5QNcc0e', 'lobo-ea-ofc', 'user', 'Lobo', 'External Affairs', 'active', '2025-11-08 08:05:48', '2025-11-08 12:07:58', NULL, NULL),
(130, 'lobo-rgo-ofc', '$2y$10$FZU3TrXtin5YHBhNHRoz6eNwDxEkr0YJ8pjIx/fAple8YtjitgSgi', 'lobo-rgo-ofc', 'user', 'Lobo', 'Resource Generation', 'active', '2025-11-08 08:06:19', '2025-11-17 05:52:51', '2025-11-17 05:52:51', NULL),
(131, 'lobo-ict-ofc', '$2y$10$JxK9FBWV9XejouF/nz09SehmFbvB8CV0L66Baf1CpA6R9GIBPiyQ2', 'lobo-ict-ofc', 'user', 'Lobo', 'ICT Services', 'active', '2025-11-08 08:07:26', '2025-11-09 04:19:41', '2025-11-09 04:19:41', NULL),
(132, 'lobo-cas-ofc', '$2y$10$FdRtdVYf7kuYwzMwTU9ArelxcwtEwVLxUkunHZLPCLO/reywsZhgq', 'lobo-cas-ofc', 'user', 'Lobo', 'College of Arts and Sciences', 'active', '2025-11-08 08:07:55', '2025-11-09 04:19:57', '2025-11-09 04:19:57', NULL),
(133, 'lobo-cabe-ofc', '$2y$10$gXPCRAkDjUK5Nh.b7wgaXeraveDBt4k2nltFHy84i7wN6lRPEOcCG', 'lobo-cabe-ofc', 'user', 'Lobo', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 08:09:01', '2025-11-11 01:47:57', '2025-11-11 01:47:57', NULL),
(134, 'lobo-cics-ofc', '$2y$10$4k54ZeNU8.GYnyYDV51SUOlU1z4sLb2uD4Njcf3y7W86aroWpiSjW', 'lobo-cics-ofc', 'user', 'Lobo', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 08:09:44', '2025-11-11 01:48:24', '2025-11-11 01:48:24', NULL),
(135, 'lobo-cet-ofc', '$2y$10$1gGngCNdK32UXbvM8LYdSO2jbejM9hazabU/7Lmcrus.dPO73VMrW', 'lobo-cet-ofc', 'user', 'Lobo', 'College of Engineering Technology', 'active', '2025-11-08 08:10:04', '2025-11-09 04:23:03', '2025-11-09 04:23:03', NULL),
(136, 'lobo-cte-ofc', '$2y$10$VKdPOPfWIXV21iY.ZMUYc.PGHt18iLYRS/mHiqKT9/WmihewUk53C', 'lobo-cte-ofc', 'user', 'Lobo', 'College of Teacher Education', 'active', '2025-11-08 08:10:20', '2025-11-09 04:23:29', '2025-11-09 04:23:29', NULL),
(137, 'lobo-ce-ofc', '$2y$10$hf/NHSuZ4v8MCII5nvHOqOXnu359plDjCOchaZnEXEkCZC6B.x/qO', 'lobo-ce-ofc', 'user', 'Lobo', 'College of Engineering', 'active', '2025-11-08 08:11:03', '2025-11-09 04:25:17', '2025-11-09 04:25:17', NULL),
(138, 'lobo-ca-ofc', '$2y$10$SF0AU6oy3oqvl.f0.pVWuONMzs/OAQMU7W.2nJrzxEoko7/x2tOgy', 'lobo-ca-ofc', 'user', 'Lobo', 'Culture and Arts', 'active', '2025-11-08 08:11:22', '2025-11-09 04:31:16', '2025-11-09 04:31:16', NULL),
(139, 'lobo-ta-ofc', '$2y$10$RwwZFEf20alD6rFkr9vMuebrJEwXGI8IYLYyTR6Idi.7KFcsXoXSW', 'lobo-ta-ofc', 'user', 'Lobo', 'Testing and Admission', 'active', '2025-11-08 08:11:45', '2025-11-09 04:31:55', '2025-11-09 04:31:55', NULL),
(140, 'lobo-sfa-ofc', '$2y$10$0WD/Ei250CnlnbIcJmb.AOypLzx2LqQmuF2WfFE663vFE/BWHipv.', 'lobo-sfa-ofc', 'user', 'Lobo', 'Scholarship and Financial Assistance', 'active', '2025-11-08 08:14:06', '2025-11-09 04:27:11', NULL, NULL),
(141, 'lobo-gc-ofc', '$2y$10$nFtp3mWHSkhkZ/ZXnfyuJeAk7du/LH9xm4u000gMeVcVj3e8bUQPS', 'lobo-gc-ofc', 'user', 'Lobo', 'Guidance and Counseling', 'active', '2025-11-08 08:14:31', '2025-11-09 04:27:26', NULL, NULL),
(142, 'lobo-rs-ofc', '$2y$10$bnPoh5kckhCuYponXTn0ZOEMlCFQQXfOk7iT0hurqugFQvBWogMDK', 'lobo-rs-ofc', 'user', 'Lobo', 'Registration Services', 'active', '2025-11-08 08:16:36', '2025-11-15 16:05:33', NULL, NULL),
(143, 'lobo-soa-ofc', '$2y$10$eJNyL8QcGYsmgqch9aUuSuvt6pYQylwaTLDepq27J3Ou//0xO3zca', 'lobo-soa-ofc', 'user', 'Lobo', 'Student Organization and Activities', 'active', '2025-11-08 08:17:04', '2025-11-09 04:29:17', NULL, NULL),
(144, 'lobo-sd-ofc', '$2y$10$lXTr06nd7X9wtSK0RCmSQuTbDjA6bpvVIhiA5oSK2uuAY34X26Cpi', 'lobo-sd-ofc', 'user', 'Lobo', 'Student Discipline', 'active', '2025-11-08 08:17:38', '2025-11-09 04:28:58', NULL, NULL),
(145, 'lobo-sad-ofc', '$2y$10$Pr43d4arFgOlAj97aawZYe5zsVd5BhGKGXaqbEaGz5bnoxmUZKjGa', 'lobo-sad-ofc', 'user', 'Lobo', 'Sports and Development', 'active', '2025-11-08 08:17:56', '2025-11-09 04:29:44', NULL, NULL),
(146, 'lobo-ojt-ofc', '$2y$10$ReuKYYKs9CVsg7V6wwIabOIi/t4uCPaPSA/9uD0jjOW4upDk2XYIe', 'lobo-ojt-ofc', 'user', 'Lobo', 'OJT', 'active', '2025-11-08 08:18:09', '2025-11-22 08:07:11', '2025-11-22 08:07:11', NULL),
(147, 'lobo-nstp-ofc', '$2y$10$CwUEOOvgJ4xhp2NufqG9auP6rbrDnOqoM0LzA55f6gT8.8aVt6Z9G', 'lobo-nstp-ofc', 'user', 'Lobo', 'National Service Training Program', 'active', '2025-11-08 08:18:31', '2025-11-09 04:30:14', NULL, NULL),
(148, 'lobo-rm-ofc', '$2y$10$gzn1nSKUmuudCPdbQblK.OCfDdtlgwKAabnP8IeoJtKy.TTF5kavG', 'lobo-rm-ofc', 'user', 'Lobo', 'Records Management', 'active', '2025-11-08 08:18:53', '2025-11-09 04:30:27', NULL, NULL),
(149, 'lobo-pcr-ofc', '$2y$10$bWWqNqzbREPhgve70zKx7eKxJmYASwuOQSXal0PsN2LXXzepNKLsm', 'lobo-pcr-ofc', 'user', 'Lobo', 'Procurement', 'active', '2025-11-08 08:19:09', '2025-11-09 04:30:42', NULL, NULL),
(150, 'lobo-bdgt-ofc', '$2y$10$zTQuaH6oIfbVi4AheCxffeZTLGKRQVJzWiZCbUe2J4FkEIuVx0/2q', 'lobo-bdgt-ofc', 'user', 'Lobo', 'Budget office', 'active', '2025-11-08 08:19:24', '2025-11-09 04:31:02', NULL, NULL),
(151, 'lobo-cd-ofc', '$2y$10$dLH6MHZxn9MHzWWExRbbvumqC0aT6xxK3yGzbBaKCDL.cDujWe6Va', 'lobo-cd-ofc', 'user', 'Lobo', 'Cashiering/Disbursing', 'active', '2025-11-08 08:19:47', '2025-11-09 04:32:18', NULL, NULL),
(152, 'lobo-emu-ofc', '$2y$10$ZRqna79Nl3ke6rPN3Jrur.ByBAJWBYll8JfNm3mBFnT5btouuN3oi', 'lobo-emu-ofc', 'user', 'Lobo', 'Environment Management Unit', 'active', '2025-11-08 08:20:11', '2025-11-12 10:39:39', '2025-11-12 10:39:39', NULL),
(153, 'lobo-psm-ofc', '$2y$10$uWszkR0aKmxzsCKWvwmKgO81Xpj8aQcP/xUnJucKSY6wnjTw8JMO2', 'lobo-psm-ofc', 'user', 'Lobo', 'Property and Supply Management', 'active', '2025-11-08 08:20:35', '2025-11-09 04:32:45', NULL, NULL),
(154, 'lobo-gso-ofc', '$2y$10$QZR84XCWCzKVM7SFw6B83ussDZGihO4ulMyqJp1Zxh1egZXxRDdKS', 'lobo-gso-ofc', 'user', 'Lobo', 'General Services', 'active', '2025-11-08 08:21:36', '2025-11-09 04:33:04', NULL, NULL),
(155, 'lobo-ext-ofc', '$2y$10$K7IRpA54H9epj455/UpMIOKUe3PrG1RjPJxbbZupVlAPx5L.mG7Zy', 'lobo-ext-ofc', 'user', 'Lobo', 'Extension', 'active', '2025-11-08 08:22:02', '2025-11-09 04:33:20', NULL, NULL),
(156, 'lobo-rsch-ofc', '$2y$10$KgnOU3mA9RD/VdzBnk0jxulz2aBWGZOpoq0joyCiYBi0.31oN9uxW', 'lobo-rsch-ofc', 'user', 'Lobo', 'Research', 'active', '2025-11-08 08:22:18', '2025-11-09 04:33:59', NULL, NULL),
(157, 'lobo-hrmo-ofc', '$2y$10$VaMq12dvJQHhk6K0O25x7O.lL874OS2ae/P.87NOMxLjyWUlSTm8q', 'lobo-hrmo-ofc', 'user', 'Lobo', 'Human Resource Management', 'active', '2025-11-08 08:22:50', '2025-11-09 04:34:23', NULL, NULL),
(158, 'lobo-hs-ofc', '$2y$10$K6yy.YWCytQfiucsXBS81uBmn5yWez9mNf5K0ofZPp0IDRGBYwIee', 'lobo-hs-ofc', 'user', 'Lobo', 'Health Services', 'active', '2025-11-08 08:23:05', '2025-11-12 10:36:42', '2025-11-09 04:35:17', NULL),
(159, 'alangilan-admin-acc', '$2y$10$abzV/iKwDb8o1DovGn1v7uxcbttLI4684r1Jrisz1vpvi9XQeROhm', 'alangilan-admin-acc', 'admin', 'Alangilan', '', 'active', '2025-11-08 08:25:00', '2025-11-26 14:37:50', '2025-11-26 14:37:50', NULL),
(160, 'alngln-rgtr-ofc', '$2y$10$aSyV/Wo9rbDGEpi0IazkWuZ3EOZ3.anjatk8tSRIN131h1WRUq0Z.', 'alngln-rgtr-ofc', 'user', 'Alangilan', 'Registrar Office', 'active', '2025-11-08 08:35:28', '2025-11-08 08:35:28', NULL, NULL),
(161, 'alangilan-acct-ofc', '$2y$10$hKqKppfkVyUW24/WqL9LUecFeVlz04IuS501PW6YeG7D1fjZhgeq.', 'alangilan-acct-ofc', 'user', 'Alangilan', 'Accounting Office', 'active', '2025-11-08 08:38:08', '2025-11-08 08:38:08', NULL, NULL),
(162, 'alngln-ia-ofc', '$2y$10$bbn8T5LSabm9W4VjBFLCrucOsydh0yI0ERurPZQ7CnL969PbY.kr2', 'alngln-ia-ofc', 'user', 'Alangilan', 'Internal Audit', 'active', '2025-11-08 08:47:40', '2025-11-08 08:47:40', NULL, NULL),
(163, 'alngln-qam-ofc', '$2y$10$vg6IPvYmnRrkZpZzD0Liu.lOiF4gQq5vMpwTuYStrduPJdO/PPso.', 'alngln-qam-ofc', 'user', 'Alangilan', 'Quality Assurance Management', 'active', '2025-11-08 08:48:14', '2025-11-08 08:48:14', NULL, NULL),
(164, 'alngln-pdc-ofc', '$2y$10$Bl1ULp08J61h0QLLA1Vl/Og1MyyuS3eM9wxm7VqXiyLOl82X.OndO', 'alngln-pdc-ofc', 'user', 'Alangilan', 'Planning and Development', 'active', '2025-11-08 08:48:54', '2025-11-08 08:48:54', NULL, NULL),
(165, 'alngln-ea-ofc', '$2y$10$klJCK32zTup4Kqbq55V91uwebfBRsvbxHsnlVwHjWmt0Osb3ewiPu', 'alngln-ea-ofc', 'user', 'Alangilan', 'External Affairs', 'active', '2025-11-08 08:49:28', '2025-11-08 08:49:28', NULL, NULL),
(166, 'alngln-rgo-ofc', '$2y$10$yzg3j/lsZAhzUNHIb9NV6u2mGlw8/5A74FWZ4WviUl9dakiWtxHky', 'alngln-rgo-ofc', 'user', 'Alangilan', 'Resource Generation', 'active', '2025-11-08 08:49:59', '2025-11-09 04:10:24', '2025-11-09 04:10:24', NULL),
(167, 'alngln-ict-ofc', '$2y$10$1o0U99whXl3bOtmY3hFs3eSMRi0vcC4wTE7uvn8eI3F3g4NUv5wby', 'alngln-ict-ofc', 'user', 'Alangilan', 'ICT Services', 'active', '2025-11-08 08:50:35', '2025-11-08 08:50:35', NULL, NULL),
(168, 'alngln-cas-ofc', '$2y$10$tf4iaDV3KpHnjNRpX.jOluRxBvajR8tVDa5e6jcEAx/CBL4F8B0HG', 'alngln-cas-ofc', 'user', 'Alangilan', 'College of Arts and Sciences', 'active', '2025-11-08 08:52:00', '2025-11-08 08:52:00', NULL, NULL),
(169, 'alngln-cabe-ofc', '$2y$10$4G9GVzPND2xnR0eVJPJxwO0B59Jynyy4Cg2XdC3Za2wXiljNhFVuS', 'alngln-cabe-ofc', 'user', 'Alangilan', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 08:52:27', '2025-11-08 08:52:27', NULL, NULL),
(170, 'alngln-cics-ofc', '$2y$10$eD8onIxVNp2UqDTWvPT.oevkwmjy8yabMcR4KjAoNa.Qg1bh4P/Y2', 'alngln-cics-ofc', 'user', 'Alangilan', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 08:52:54', '2025-11-08 08:52:54', NULL, NULL),
(171, 'alngln-cet-ofc', '$2y$10$8hi/kbxPLW9VZV23cDZvKOkAciQCyT0vjbuXCLY5.Y.2rNOATEoUG', 'alngln-cet-ofc', 'user', 'Alangilan', 'College of Engineering Technology', 'active', '2025-11-08 08:53:29', '2025-11-08 08:53:29', NULL, NULL),
(172, 'alngln-cte-ofc', '$2y$10$lQJPjmOWuVuufWEszT59MOOKH/Vk7bXk2hNbVqf7lg7F53E/5G2p2', 'alngln-cte-ofc', 'user', 'Alangilan', 'College of Teacher Education', 'active', '2025-11-08 08:53:55', '2025-11-08 08:53:55', NULL, NULL),
(173, 'alngln-ce-ofc', '$2y$10$bxdFHaV9XRX.k6faabOt4.ndvU3g7P0a0h8EIsxZupFm3ZM01RWxi', 'alngln-ce-ofc', 'user', 'Alangilan', 'College of Engineering', 'active', '2025-11-08 08:54:19', '2025-11-08 08:54:19', NULL, NULL),
(174, 'alngln-ca-ofc', '$2y$10$CkIoM3rhRJvgQ98b8g6Xa.kp6aW3ch6vINICoqg3XQEQl9S.Dr1Xq', 'alngln-ca-ofc', 'user', 'Alangilan', 'Culture and Arts', 'active', '2025-11-08 08:54:40', '2025-11-08 08:54:40', NULL, NULL),
(175, 'alngln-tao-ofc', '$2y$10$f/ypmzxhxf/t9U6IM9BLn.nAmp.yYAgTcITS2EQs5z2G0lpJnfGUC', 'alngln-tao-ofc', 'user', 'Alangilan', 'Testing and Admission', 'active', '2025-11-08 08:55:02', '2025-11-08 08:55:02', NULL, NULL),
(176, 'alngln-rs-ofc', '$2y$10$VGRdq.5n4M5lehOGIXn4rufkUF1OJ8xpxxO8t1jadV24S2tsKSHjW', 'alngln-rs-ofc', 'user', 'Alangilan', 'Registration Services', 'active', '2025-11-08 08:55:40', '2025-11-08 08:55:40', NULL, NULL),
(177, 'alngln-sfa-ofc', '$2y$10$HbNy.jiQ8iYrQXhSTqvDa.rdfQTCcERqMFnB6NFRxfSE7b6rgtv1q', 'alngln-sfa-ofc', 'user', 'Alangilan', 'Scholarship and Financial Assistance', 'active', '2025-11-08 08:56:12', '2025-11-08 08:56:12', NULL, NULL),
(178, 'alngln-gc-ofc', '$2y$10$n62ePuuexcVBmnUYkc7Ff.2.3JNuWcMXAGUy/lP2dWptKgvgtTcfG', 'alngln-gc-ofc', 'user', 'Alangilan', 'Guidance and Counseling', 'active', '2025-11-08 08:56:39', '2025-11-08 08:56:39', NULL, NULL),
(179, 'alngln-soa-ofc', '$2y$10$OPgL7QZQyuPPZJGnhtoQhep/fJZFwXO15bLK8s0SU4.NGfOFlxPmu', 'alngln-soa-ofc', 'user', 'Alangilan', 'Student Organization and Activities', 'active', '2025-11-08 08:57:16', '2025-11-08 08:57:16', NULL, NULL),
(180, 'alngln-sd-ofc', '$2y$10$e8nCFm5xiOdN6br3h1MPzem4fN1qT7QMuwTN6jcaVlKyiU5tpdl5i', 'alngln-sd-ofc', 'user', 'Alangilan', 'Student Discipline', 'active', '2025-11-08 08:57:41', '2025-11-08 08:57:41', NULL, NULL),
(181, 'alngln-sad-ofc', '$2y$10$KKRypPDEV4zw6M83maKeE.e8dcV7UGYD6V881jPdykZp9L2xROura', 'alngln-sad-ofc', 'user', 'Alangilan', 'Sports and Development', 'active', '2025-11-08 08:58:20', '2025-11-08 08:58:20', NULL, NULL),
(182, 'alngln-ojt-ofc', '$2y$10$fJx0j0QZiEuq5kJ9k77xJuOtNxFAcF/5WhHiTeegPGasgCHfK0.RK', 'alngln-ojt-ofc', 'user', 'Alangilan', 'OJT', 'active', '2025-11-08 08:58:40', '2025-11-08 08:58:40', NULL, NULL),
(183, 'alngln-nstp-ofc', '$2y$10$JUBV8FENKIHgr4Fw0mrYb.t52W8xJtT8iSOx5MDYZ5h7gWIpX9c3S', 'alngln-nstp-ofc', 'user', 'Alangilan', 'National Service Training Program', 'active', '2025-11-08 08:59:05', '2025-11-08 08:59:05', NULL, NULL),
(184, 'alngln-hrmo-ofc', '$2y$10$dKTDbNBFdI0OUw7RuslIeOqC2ZVAdwOvbSUJ1wL4R/liq4WZAA1pm', 'alngln-hrmo-ofc', 'user', 'Alangilan', 'Human Resource Management', 'active', '2025-11-08 08:59:34', '2025-11-08 08:59:34', NULL, NULL),
(185, 'alngln-rm-ofc', '$2y$10$GOhiNg3vPVb2IXjpSdYWC.5NXUjPmI2v7cyHdnhAXelOgsfILM9gG', 'alngln-rm-ofc', 'user', 'Alangilan', 'Records Management', 'active', '2025-11-08 09:00:10', '2025-11-08 09:00:10', NULL, NULL),
(186, 'alngln-pcr-ofc', '$2y$10$2YwvsU9ROwyScn/dbcREv.re.XDjEyICrSSUoyTIm.eaQaXlwmnEO', 'alngln-pcr-ofc', 'user', 'Alangilan', 'Procurement', 'active', '2025-11-08 09:00:56', '2025-11-08 09:00:56', NULL, NULL),
(187, 'alngln-bdgt-ofc', '$2y$10$HhmnrhFN039PUpysnrrtmu5B1WLQnXIg9tgCCXO5/aIGDFnmFz1lu', 'alngln-bdgt-ofc', 'user', 'Alangilan', 'Budget office', 'active', '2025-11-08 09:01:37', '2025-11-08 09:01:37', NULL, NULL),
(188, 'alngln-cd-ofc', '$2y$10$lHxuADrJ52afbfqNNKoL4.6zQ54nc9t50pWR3Jzz/SPn.dq6dwU2a', 'alngln-cd-ofc', 'user', 'Alangilan', 'Cashiering/Disbursing', 'active', '2025-11-08 09:02:31', '2025-11-08 09:02:31', NULL, NULL),
(189, 'alngln-pfm-ofc', '$2y$10$6dlVHHut9EBo0i7kO63yaOe.R7M8Yz0T.l1KY.IAFivftfZfg/gV6', 'alngln-pfm-ofc', 'user', 'Alangilan', 'Project Facilities and Management', 'active', '2025-11-08 09:03:25', '2025-11-08 09:03:25', NULL, NULL),
(190, 'alngln-emu-ofc', '$2y$10$LNGPqedbpJUpI/9ntHHydecUsic0icE7uTSuR1xFTgL1Q7IbJWB7y', 'alngln-emu-ofc', 'user', 'Alangilan', 'Environment Management Unit', 'active', '2025-11-08 09:03:53', '2025-11-08 09:03:53', NULL, NULL),
(191, 'alngln-psm-ofc', '$2y$10$rd4R0cDvwmWGD7cDeT4QZuVzOyTqU0IZzOGWTyvb3qdJ9Ui0paImC', 'alngln-psm-ofc', 'user', 'Alangilan', 'Property and Supply Management', 'active', '2025-11-08 09:04:20', '2025-11-08 09:04:20', NULL, NULL),
(192, 'alngln-gso-ofc', '$2y$10$gzl7drSty7T.THayGHNhSebKm6QBi2xhKGHDXZSoVtCq7QP0Frpa.', 'alngln-gso-ofc', 'user', 'Alangilan', 'General Services', 'active', '2025-11-08 09:04:47', '2025-11-08 09:04:47', NULL, NULL),
(193, 'alngln-ext-ofc', '$2y$10$KCM7XUsZNZDV3vJQpHr7ouh2fEMSykFCuzkMdqi/FqnWDr50naP1y', 'alngln-ext-ofc', 'user', 'Alangilan', 'Extension', 'active', '2025-11-08 09:05:10', '2025-11-08 09:05:10', NULL, NULL),
(194, 'alngln-rsch-ofc', '$2y$10$MlZi6cTTmlsaZ.fon80fTeI/AbMNAkjdjBluS/wnluw31RyvHdOPi', 'alngln-rsch-ofc', 'user', 'Alangilan', 'Research', 'active', '2025-11-08 09:06:17', '2025-11-08 09:06:17', NULL, NULL),
(195, 'alngln-hs-ofc', '$2y$10$MOfTKhudl5/vvXOSVQrmwedqckeXes33JoUKZ7Ta90o/ORArPTAlG', 'alngln-hs-ofc', 'user', 'Alangilan', 'Health Services', 'active', '2025-11-08 09:06:41', '2025-11-08 09:06:41', NULL, NULL),
(196, 'pablo-borbon-admin-acc', '$2y$10$GnQoY8ngIITVr1QWWN3Jj.IyrYH2oBN.uJ1ex/c0LbvBupvbzeolG', 'pablo-borbon-admin-acc', 'admin', 'Pablo Borbon', '', 'active', '2025-11-08 09:15:27', '2025-11-17 03:42:22', '2025-11-17 03:42:22', NULL),
(197, 'pb-rgtr-ofc', '$2y$10$U3NmdyPEdggracUezHApcOS2cfC9oGwArk0aHAVpz6PmCOPhvQL6O', 'pb-rgtr-ofc', 'user', 'Pablo Borbon', 'Registrar Office', 'active', '2025-11-08 09:37:39', '2025-11-08 09:37:39', NULL, NULL),
(198, 'pb-ia-ofc', '$2y$10$eHYQWcsPtZccBOQbEfts3.Ktx1Gf2VOmhexy4yFVWahRUeqPUp0/K', 'pb-ia-ofc', 'user', 'Pablo Borbon', 'Internal Audit', 'active', '2025-11-08 09:38:21', '2025-11-08 09:38:21', NULL, NULL),
(199, 'pb-qam-ofc', '$2y$10$M0VQhXYM/s9OiWdIqY/ViOnMEhrPkP5Cfz3lrEk8U7sTN7mySpxFC', 'pb-qam-ofc', 'user', 'Pablo Borbon', 'Quality Assurance Management', 'active', '2025-11-08 09:38:52', '2025-11-08 09:38:52', NULL, NULL),
(200, 'pb-pdc-ofc', '$2y$10$zKdVy.lhA6TDsp4KZDUUQuuqgwc4eZQhPwxRn4Eeq17ml3jV2p4ze', 'pb-pdc-ofc', 'user', 'Pablo Borbon', 'Planning and Development', 'active', '2025-11-08 09:39:52', '2025-11-08 09:39:52', NULL, NULL),
(201, 'pb-ea-ofc', '$2y$10$XjgeJTuBEUIOM5RcK.q3/uyPatkMMQNce/Ju/rWrMUiYM.dD79k/G', 'pb-ea-ofc', 'user', 'Pablo Borbon', 'External Affairs', 'active', '2025-11-08 09:40:30', '2025-11-08 09:40:30', NULL, NULL),
(202, 'pb-rgo-ofc', '$2y$10$FOGbJs0d78ErorVNGzyPKu6OQ.iVCrUeb.MYQBeTQ8KLKRR4kC4pu', 'pb-rgo-ofc', 'user', 'Pablo Borbon', 'Resource Generation', 'active', '2025-11-08 09:41:00', '2025-11-17 03:35:37', '2025-11-17 03:35:37', NULL),
(203, 'pb-ict-ofc', '$2y$10$MypZjVkISjc5x5QrsA7UZu7v3hvtQgQIpuk9BajMf.ElxEFH47sCO', 'pb-ict-ofc', 'user', 'Pablo Borbon', 'ICT Services', 'active', '2025-11-08 09:41:26', '2025-11-08 09:41:26', NULL, NULL),
(204, 'pb-cas-ofc', '$2y$10$sYbbSBTf6xENxTwKbd9C6Oguv3UJkEZGBVlCL2VbbcB3fDUiWxHWy', 'pb-cas-ofc', 'user', 'Pablo Borbon', 'College of Arts and Sciences', 'active', '2025-11-08 09:41:54', '2025-11-08 09:41:54', NULL, NULL),
(205, 'pb-cabe-ofc', '$2y$10$59fdZzOQuw3AzClYRihLpeZ2KxyRvhwE2uw8mU54KyN3MjWWqWH9K', 'pb-cabe-ofc', 'user', 'Pablo Borbon', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 09:43:09', '2025-11-08 09:43:09', NULL, NULL),
(206, 'pb-cics-ofc', '$2y$10$tSrOaGuoGcHUR2U1E8bpg.5r1DJPAKmHvNzSioQw2TcCcmeU2c2dG', 'pb-cics-ofc', 'user', 'Pablo Borbon', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 09:43:34', '2025-11-08 09:43:34', NULL, NULL),
(207, 'pb-cet-ofc', '$2y$10$uWqTL0D56XuX/nJNCvs/0uhwwIkdGAIxdnirEvX2VMzUR3QyQwjRm', 'pb-cet-ofc', 'user', 'Pablo Borbon', 'College of Engineering Technology', 'active', '2025-11-08 09:44:06', '2025-11-08 09:44:06', NULL, NULL),
(208, 'pb-cte-ofc', '$2y$10$GH3oL77MkGx2EegPQimBMOlEi8dVZpjzenZiqFZrDPGeEQu51E7m6', 'pb-cte-ofc', 'user', 'Pablo Borbon', 'College of Teacher Education', 'active', '2025-11-08 09:44:31', '2025-11-08 09:44:31', NULL, NULL),
(209, 'pb-ce-ofc', '$2y$10$VPXFQXqB9pMlZm8syU2QNOS8VTc7bLIj2HHJxY8w60glvRG20.JXG', 'pb-ce-ofc', 'user', 'Pablo Borbon', 'College of Engineering', 'active', '2025-11-08 09:44:56', '2025-11-08 09:44:56', NULL, NULL),
(210, 'pb-ca-ofc', '$2y$10$2DXy7KtulPzjLdHG4cX3me.1t.sUPfnBZH3/e/bXcxXFbtNCPevsu', 'pb-ca-ofc', 'user', 'Pablo Borbon', 'Culture and Arts', 'active', '2025-11-08 09:45:21', '2025-11-08 09:45:21', NULL, NULL),
(211, 'pb-tao-ofc', '$2y$10$gXEuYEBpOYV9J/xD/RAtou.yeDNyk.iNNSpx6qEH6JYNINNtCHIA6', 'pb-tao-ofc', 'user', 'Pablo Borbon', 'Testing and Admission', 'active', '2025-11-08 09:45:52', '2025-11-08 09:45:52', NULL, NULL),
(212, 'pb-rs-ofc', '$2y$10$ePB3yDG9iF1MJ0dj40BW8em/IGoDULKZkF1/TmjUdUlQ4JnnoVSwS', 'pb-rs-ofc', 'user', 'Pablo Borbon', 'Registration Services', 'active', '2025-11-08 09:46:20', '2025-11-08 09:46:20', NULL, NULL),
(213, 'pb-sfa-ofc', '$2y$10$5B4zUb2WHloRtXWjDUswqu0w.mmTf1PfsaL45EjYtf6TKL863VUFe', 'pb-sfa-ofc', 'user', 'Pablo Borbon', 'Scholarship and Financial Assistance', 'active', '2025-11-08 09:46:57', '2025-11-08 09:46:57', NULL, NULL),
(214, 'pb-gc-ofc', '$2y$10$c5fCPIzWizmcR586F3TC1OMB6sw1CT9H/gWr7ZD8M8Bb7lTr/CrZC', 'pb-gc-ofc', 'user', 'Pablo Borbon', 'Guidance and Counseling', 'active', '2025-11-08 09:47:23', '2025-11-08 09:47:23', NULL, NULL),
(215, 'pb-soa-ofc', '$2y$10$/FYPMcQdelOt7i1LLsI.b.5frAcTRgH4Mwmn/VNbLu1ZLybpJyNCu', 'pb-soa-ofc', 'user', 'Pablo Borbon', 'Student Organization and Activities', 'active', '2025-11-08 09:47:56', '2025-11-08 09:47:56', NULL, NULL),
(216, 'pb-sd-ofc', '$2y$10$dAofuhSeNSRQVl.nh9wDzuX2aBfymL367uX5Qc2LBZFbRVByQo22W', 'pb-sd-ofc', 'user', 'Pablo Borbon', 'Student Discipline', 'active', '2025-11-08 09:48:24', '2025-11-08 09:48:24', NULL, NULL),
(217, 'pb-sad-ofc', '$2y$10$xMJ2tZTV09/BCehNM384eud8Erq.PrUzPgh1RwTSULfgbR8FOCLJS', 'pb-sad-ofc', 'user', 'Pablo Borbon', 'Sports and Development', 'active', '2025-11-08 09:48:50', '2025-11-08 09:48:50', NULL, NULL),
(218, 'pb-ojt-ofc', '$2y$10$lcwem6U6aFPp/Pr/65A7O.ieyh5sE4a3PpzmVOoBLXxpvA9jDfNXq', 'pb-ojt-ofc', 'user', 'Pablo Borbon', 'OJT', 'active', '2025-11-08 09:49:29', '2025-11-08 09:49:29', NULL, NULL),
(219, 'pb-nstp-ofc', '$2y$10$iWRt5S59.0gOyyz/RELwaebkCrdXOjLUHR7V017SJsorFjCW3yBaK', 'pb-nstp-ofc', 'user', 'Pablo Borbon', 'National Service Training Program', 'active', '2025-11-08 09:49:56', '2025-11-08 09:49:56', NULL, NULL),
(220, 'pb-hrmo-ofc', '$2y$10$r2PXYKR5S8Q4OoflyszGleQN0bez1vB9s5pHWH/AXLlUZXiBOglge', 'pb-hrmo-ofc', 'user', 'Pablo Borbon', 'Human Resource Management', 'active', '2025-11-08 09:50:21', '2025-11-08 09:50:21', NULL, NULL),
(221, 'pb-rm-ofc', '$2y$10$O.VaKlYQbKM1dEVCIQfp1.h1ruawCMnvrQ3dVueAmfqSli2s9Josy', 'pb-rm-ofc', 'user', 'Pablo Borbon', 'Records Management', 'active', '2025-11-08 09:50:45', '2025-11-08 09:50:45', NULL, NULL),
(222, 'pb-pcr-ofc', '$2y$10$4SJcwU1V2wvmTZ2OTsV8fu4ojd7RbQ9t7rhjaicZxd9OhWOTD2qBq', 'pb-pcr-ofc', 'user', 'Pablo Borbon', 'Procurement', 'active', '2025-11-08 09:51:41', '2025-11-08 09:51:41', NULL, NULL),
(223, 'pb-bdgt-ofc', '$2y$10$5uMm73oDV89KbMpxajsah.YTiL1n0h0fHayOpQgFcnEMpIRwS1bB6', 'pb-bdgt-ofc', 'user', 'Pablo Borbon', 'Budget office', 'active', '2025-11-08 09:52:13', '2025-11-08 09:52:13', NULL, NULL),
(224, 'pb-cd-ofc', '$2y$10$iAWnG7tsQbXmirBTm3g3P.kDITkB/ZuJKJqqkUy1okIP7rC237wby', 'pb-cd-ofc', 'user', 'Pablo Borbon', 'Cashiering/Disbursing', 'active', '2025-11-08 09:52:44', '2025-11-08 09:52:44', NULL, NULL),
(225, 'pb-acct-ofc', '$2y$10$sNI0gMS0s5c5V9wpnlKP2eT0IAeaYKFR5SO1p84LnxXDxWHuATLQq', 'pb-acct-ofc', 'user', 'Pablo Borbon', 'Accounting Office', 'active', '2025-11-08 09:53:11', '2025-11-08 14:32:01', '2025-11-08 14:32:01', NULL),
(226, 'pb-pfm-ofc', '$2y$10$i.uS3qCEAq2IIfVZt2Dj3u/ZY1OFLet3RT2Il6lKzdOvdZqKUwmru', 'pb-pfm-ofc', 'user', 'Pablo Borbon', 'Project Facilities and Management', 'active', '2025-11-08 09:53:59', '2025-11-08 09:53:59', NULL, NULL),
(227, 'pb-emu-ofc', '$2y$10$p/LUKpIeBKdBZXMqXGVokeNYutTmk0cOmdtUeH8zn/MkMEjP9pSuq', 'pb-emu-ofc', 'user', 'Pablo Borbon', 'Environment Management Unit', 'active', '2025-11-08 09:54:24', '2025-11-08 09:54:24', NULL, NULL),
(228, 'pb-psm-ofc', '$2y$10$ZByqAhstiGl.lrZCNXejouRJ/CFJ4hM5k6u045WAwRoSzP.FextTu', 'pb-psm-ofc', 'user', 'Pablo Borbon', 'Property and Supply Management', 'active', '2025-11-08 09:54:51', '2025-11-08 09:54:51', NULL, NULL),
(229, 'pb-gso-ofc', '$2y$10$/ykWYbvAxM1gLUejFxhgEuZeI7zPT3v7/sggR2VwKG7qWzj9/INji', 'pb-gso-ofc', 'user', 'Pablo Borbon', 'General Services', 'active', '2025-11-08 09:55:14', '2025-11-08 09:55:14', NULL, NULL),
(230, 'pb-ext-ofc', '$2y$10$8G.cGWsSYjs9shQv72tiNeVoc5lbxl389OFgt8omQW.TOgtkPlCq2', 'pb-ext-ofc', 'user', 'Pablo Borbon', 'Extension', 'active', '2025-11-08 09:55:44', '2025-11-08 09:55:44', NULL, NULL),
(231, 'pb-rsch-ofc', '$2y$10$E.bZxCWeeutyFvSHUOuhxOLTGaftnsppAWyvaII3vzn8sP8KpE8C6', 'pb-rsch-ofc', 'user', 'Pablo Borbon', 'Research', 'active', '2025-11-08 09:56:17', '2025-11-08 09:56:17', NULL, NULL),
(232, 'pb-hs-ofc', '$2y$10$7ogWZ9D/6gTCqxIAFXLhJOWcjJl4PHG4b1Q7R7/qQ2d5nFTszAAwa', 'pb-hs-ofc', 'user', 'Pablo Borbon', 'Health Services', 'active', '2025-11-08 09:56:45', '2025-11-08 09:56:45', NULL, NULL),
(233, 'nasugbu-admin-acc', '$2y$10$.K0AmBY.jVamQ7LgvSVyTODCxIAzvTSTXliZw3l1htKZWuKxBI8VK', 'nasugbu-admin-acc', 'admin', 'Nasugbu', '', 'active', '2025-11-08 10:06:23', '2025-11-08 10:07:03', '2025-11-08 10:07:03', NULL),
(234, 'nsb-rgtr-ofc', '$2y$10$VcplfCqxFN6Rrax.2TUpOOycJ2EtAnQbqW7W4jgRjVZGnnr1fBBI.', 'nsb-rgtr-ofc', 'user', 'Nasugbu', 'Registrar Office', 'active', '2025-11-08 10:07:39', '2025-11-08 10:07:39', NULL, NULL),
(235, 'nsb-acct-ofc', '$2y$10$yGC5tUGTSNXkk9kIekpl6eiC4.p4CWhudaajUMkvkjvsGb4yasCcO', 'nsb-acct-ofc', 'user', 'Nasugbu', 'Accounting Office', 'active', '2025-11-08 10:08:14', '2025-11-08 13:55:16', NULL, NULL),
(236, 'nsb-ia-ofc', '$2y$10$79fo1X2U8fGORxcVL3EFNOum6YVovyRpux/g358Ej/knFCuuCWdKa', 'nsb-ia-ofc', 'user', 'Nasugbu', 'Internal Audit', 'active', '2025-11-08 10:08:48', '2025-11-08 10:08:48', NULL, NULL),
(237, 'nsb-qam-ofc', '$2y$10$7lKzTKbjzLUeenid.ebl2eW8w/BqVJhcHGNVfZGxZXkPlVzZBpcZ.', 'nsb-qam-ofc', 'user', 'Nasugbu', 'Quality Assurance Management', 'active', '2025-11-08 10:09:20', '2025-11-08 10:09:20', NULL, NULL),
(238, 'nsb-pdc-ofc', '$2y$10$5CsA6FPXPpmjCvoaDy0f6ubPxLGamSVwBaoNJKc2X0C2RmCY7QtsK', 'nsb-pdc-ofc', 'user', 'Nasugbu', 'Planning and Development', 'active', '2025-11-08 10:09:44', '2025-11-08 10:09:44', NULL, NULL),
(239, 'nsb-ea-ofc', '$2y$10$UwRhphMb14O5vn9uVFK36ed7Ilvb8CpAcBnmkRWkxVpTIBmFZztxO', 'nsb-ea-ofc', 'user', 'Nasugbu', 'External Affairs', 'active', '2025-11-08 10:10:38', '2025-11-08 10:10:38', NULL, NULL),
(240, 'nsb-rgo-ofc', '$2y$10$tJ0f0Ry8//VTU6G6QHDsw.8gfnlVrS45lRb1rh6cghznm8WS1aqJK', 'nsb-rgo-ofc', 'user', 'Nasugbu', 'Resource Generation', 'active', '2025-11-08 10:11:07', '2025-11-08 10:11:07', NULL, NULL),
(241, 'nsb-ict-ofc', '$2y$10$Wq9xT8ws0O6DrkDUH3Wd..1EFRoNqan3WMC4i4tJUJzxWdMacbUIK', 'nsb-ict-ofc', 'user', 'Nasugbu', 'ICT Services', 'active', '2025-11-08 10:11:28', '2025-11-08 10:11:28', NULL, NULL),
(242, 'nsb-cas-ofc', '$2y$10$mRuxrsn2R6kTSChFoVy4pOJ7eEL6/Sxh/mJlRg5H.8fbh1CbWO9MK', 'nsb-cas-ofc', 'user', 'Nasugbu', 'College of Arts and Sciences', 'active', '2025-11-08 10:11:56', '2025-11-08 10:11:56', NULL, NULL),
(243, 'nsb-cabe-ofc', '$2y$10$5IzX3DrdLIYSvaHfNgeK2.nKB3Zr9yRYy.FwxjO2OxFOb1cJIUjfS', 'nsb-cabe-ofc', 'user', 'Nasugbu', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 10:12:19', '2025-11-08 10:12:19', NULL, NULL),
(244, 'nsb-cics-ofc', '$2y$10$y.dBp5lGN4Tk9LWNEptToeYrT7Ji0HzhOhpzKgPIbb5jlaJt6.QIy', 'nsb-cics-ofc', 'user', 'Nasugbu', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 10:12:51', '2025-11-08 10:12:51', NULL, NULL),
(245, 'nsb-cet-ofc', '$2y$10$hKqJ29QFPkim6z.6h3lAc.sPuhksECuJgqIo7PH/44axSug5XXeFO', 'nsb-cet-ofc', 'user', 'Nasugbu', 'College of Engineering Technology', 'active', '2025-11-08 10:13:13', '2025-11-08 10:13:13', NULL, NULL),
(246, 'nsb-cte-ofc', '$2y$10$ruApesGOPgIHsNWC44x2d.kAfww1jEOGfhNBKLB8SD49KBQArKuKu', 'nsb-cte-ofc', 'user', 'Nasugbu', 'College of Teacher Education', 'active', '2025-11-08 10:13:41', '2025-11-08 10:13:41', NULL, NULL),
(247, 'nsb-ce-ofc', '$2y$10$ZWEVkJySVhXeHLTLKnwNDOzjjcHX8wJBvP0zwc6IUIHkg3z4NEY5S', 'nsb-ce-ofc', 'user', 'Nasugbu', 'College of Engineering', 'active', '2025-11-08 10:14:09', '2025-11-08 10:14:09', NULL, NULL),
(248, 'nsb-ca-ofc', '$2y$10$ZbV2gu/WvMis0wPF9b9pQeH63ZAQvFlOHdHFE8pndjknZrKVIWI2C', 'nsb-ca-ofc', 'user', 'Nasugbu', 'Culture and Arts', 'active', '2025-11-08 10:14:33', '2025-11-08 10:14:33', NULL, NULL),
(249, 'nsb-tao-ofc', '$2y$10$hcIDu7RfmiigxUYHWsl/H.R1ouQnmUP1VTXW4XaKTLAlJYm.NbT.m', 'nsb-tao-ofc', 'user', 'Nasugbu', 'Testing and Admission', 'active', '2025-11-08 10:15:10', '2025-11-08 10:15:10', NULL, NULL),
(250, 'nsb-rs-ofc', '$2y$10$J5bqgFisMKf9u2I/nAhqSOqviL./2PG5hTq0h5E4KevaDo0U4TaYu', 'nsb-rs-ofc', 'user', 'Nasugbu', 'Registration Services', 'active', '2025-11-08 10:15:42', '2025-11-08 10:15:42', NULL, NULL),
(251, 'nsb-sfa-ofc', '$2y$10$T2DjF66ckOYRtpNoqYbnPOSK5q7bJ6jth6fa.WB1RM4fw1zqWLJ.y', 'nsb-sfa-ofc', 'user', 'Nasugbu', 'Scholarship and Financial Assistance', 'active', '2025-11-08 10:16:06', '2025-11-08 10:16:06', NULL, NULL),
(252, 'nsb-gc-ofc', '$2y$10$4GP.0WzoSdQsKmBrW1d..ON86xl8n7nul1mLI7oFO/vXU8hO8wpYu', 'nsb-gc-ofc', 'user', 'Nasugbu', 'Guidance and Counseling', 'active', '2025-11-08 10:16:27', '2025-11-08 10:16:27', NULL, NULL),
(253, 'nsb-soa-ofc', '$2y$10$COY7XMGTLHfISAFkT4NFievXpvkAIGrLEXNfKIPeNRXh/uqWpFJmS', 'nsb-soa-ofc', 'user', 'Nasugbu', 'Student Organization and Activities', 'active', '2025-11-08 10:16:47', '2025-11-08 10:16:47', NULL, NULL),
(254, 'nsb-sd-ofc', '$2y$10$lK4OYnckYsH0sXG8pA1w2uElpJ4VdEq2dSvJJCki1gcI6viIk2h9.', 'nsb-sd-ofc', 'user', 'Nasugbu', 'Student Discipline', 'active', '2025-11-08 10:17:12', '2025-11-08 10:17:12', NULL, NULL),
(255, 'nsb-sad-ofc', '$2y$10$eagJYGyzTDsBDeqQvhP6KuQ1Sx9cEHlRcBUciRD8OQRwlFDFsdRiu', 'nsb-sad-ofc', 'user', 'Nasugbu', 'Sports and Development', 'active', '2025-11-08 10:17:35', '2025-11-08 10:17:35', NULL, NULL),
(256, 'nsb-ojt-ofc', '$2y$10$UknkDTQxiAGV.7TUhsW0dOX/h9gPAyiMgkqLZCJlu7yuFgOj7.dnK', 'nsb-ojt-ofc', 'user', 'Nasugbu', 'OJT', 'active', '2025-11-08 10:17:56', '2025-11-08 10:17:56', NULL, NULL),
(257, 'nsb-nstp-ofc', '$2y$10$C.8HwVThf8sEZRX23pG9hO0sEox4feYUu.qeFFhHAt830zeYBzv3q', 'nsb-nstp-ofc', 'user', 'Nasugbu', 'National Service Training Program', 'active', '2025-11-08 10:18:22', '2025-11-08 10:18:22', NULL, NULL),
(258, 'nsb-hrmo-ofc', '$2y$10$pnCxPaeChEcFGcua3Hc9oeZgQ69QyXTKK2sZa3ZkrIb5wSZDg.LWi', 'nsb-hrmo-ofc', 'user', 'Nasugbu', 'Human Resource Management', 'active', '2025-11-08 10:18:47', '2025-11-08 10:18:47', NULL, NULL),
(259, 'nsb-rm-ofc', '$2y$10$uAXKXGY1gGy4jiV.z1FtF.ECmRCVFph1csCDMcHkIdEwk1YVCilOG', 'nsb-rm-ofc', 'user', 'Nasugbu', 'Records Management', 'active', '2025-11-08 10:19:28', '2025-11-08 10:19:28', NULL, NULL),
(260, 'nsb-pcr-ofc', '$2y$10$Dhi5RmwSLyzAUclfK80jM.UYxaMp2sIX.K.pzMcWzo7F9RZk.sIYi', 'nsb-pcr-ofc', 'user', 'Nasugbu', 'Procurement', 'active', '2025-11-08 10:19:51', '2025-11-08 10:19:51', NULL, NULL),
(261, 'nsb-bdgt-ofc', '$2y$10$ruBxw5LpIP7qzBNjCtj.xeXkulKIA6yd5R3S7mdKuInF8N6Q4GUkC', 'nsb-bdgt-ofc', 'user', 'Nasugbu', 'Budget office', 'active', '2025-11-08 10:20:15', '2025-11-08 10:20:15', NULL, NULL),
(262, 'nsb-cd-ofc', '$2y$10$ztcruhN.4srN.8gTaRgWP.YOFk5VyMrRorejvHt5hxFNk.L/Gwa0.', 'nsb-cd-ofc', 'user', 'Nasugbu', 'Cashiering/Disbursing', 'active', '2025-11-08 10:20:50', '2025-11-08 10:20:50', NULL, NULL),
(263, 'nsb-pfm-ofc', '$2y$10$fRCTyC1N0fRJSLFz5EfeHOT7ZRAbZC3IN5yPEj7rwYencXscfuFFS', 'nsb-pfm-ofc', 'user', 'Nasugbu', 'Project Facilities and Management', 'active', '2025-11-08 10:21:16', '2025-11-08 10:21:16', NULL, NULL),
(264, 'nsb-emu-ofc', '$2y$10$qf0QdsgzRiHC3riy4jrtU.uiuCuck6rbfl4YCa645Me.OG3gmr5Ly', 'nsb-emu-ofc', 'user', 'Nasugbu', 'Environment Management Unit', 'active', '2025-11-08 10:21:40', '2025-11-08 10:21:40', NULL, NULL),
(265, 'nsb-psm-ofc', '$2y$10$O8JrFW4RZmepsnHQGsB5/OTK3/8eB26U8KLTf9Ylr8lKBu3Z179U6', 'nsb-psm-ofc', 'user', 'Nasugbu', 'Property and Supply Management', 'active', '2025-11-08 10:22:08', '2025-11-08 10:22:08', NULL, NULL),
(266, 'nsb-gso-ofc', '$2y$10$K6Bmbk0Sedx4icyBIL.avODy9VJOPt7pBbs3Xnx0wWF4Kdb..LxBW', 'nsb-gso-ofc', 'user', 'Nasugbu', 'General Services', 'active', '2025-11-08 10:22:37', '2025-11-08 10:22:37', NULL, NULL),
(267, 'nsb-ext-ofc', '$2y$10$/1jtC4WxKwZT7R/Mxw42qeTYyurmgX.QojopnGj/v4xs8UvEWJDQa', 'nsb-ext-ofc', 'user', 'Nasugbu', 'Extension', 'active', '2025-11-08 10:23:01', '2025-11-08 10:23:01', NULL, NULL),
(268, 'nsb-rsch-ofc', '$2y$10$uA4j5U5u9WkS1DqddMzUjuBmfHepQe5xlxHzUzq9Smi/qb1ZUDRpu', 'nsb-rsch-ofc', 'user', 'Nasugbu', 'Research', 'active', '2025-11-08 10:23:25', '2025-11-08 10:23:25', NULL, NULL),
(269, 'nsb-hs-ofc', '$2y$10$DQlJfdOjcFDOi5qtuZjDcOh318AfbWBk5ppZTuyQcE404iZo8G7ba', 'nsb-hs-ofc', 'user', 'Nasugbu', 'Health Services', 'active', '2025-11-08 10:23:49', '2025-11-08 10:23:49', NULL, NULL),
(270, 'malvar-admin-acc', '$2y$10$6JXnoT7IUmfEu7V6EdSxkOqf1hmddgLbUzXo6PklcCLG9DqbGj7Pi', 'malvar-admin-acc', 'admin', 'Malvar', '', 'active', '2025-11-08 10:33:58', '2025-11-08 10:39:41', '2025-11-08 10:39:41', NULL),
(271, 'malvar-rgtr-ofc', '$2y$10$iXQV2555rXhpiXjuJ/Phg.QE7pnfLu4bj8m/HynXRRH3JWelnO0xu', 'malvar-rgtr-ofc', 'user', 'Malvar', 'Registrar Office', 'active', '2025-11-08 10:41:33', '2025-11-08 11:17:54', '2025-11-08 11:17:54', NULL),
(272, 'malvar-acct-ofc', '$2y$10$nxqDCEoD05Yzt6N..AKh5eJtLeYiIYliKvhQY7iwbYksXluxZ09Hi', 'malvar-acct-ofc', 'user', 'Malvar', 'Accounting Office', 'active', '2025-11-08 10:45:24', '2025-11-08 13:55:06', NULL, NULL),
(273, 'malvar-ia-ofc', '$2y$10$3EXQx58fwnq9nHmvOScmaO1dft0Fpx6XjDn5N4yle6mGvT2DdjeNW', 'malvar-ia-ofc', 'user', 'Malvar', 'Internal Audit', 'active', '2025-11-08 10:52:24', '2025-11-08 10:52:24', NULL, NULL),
(274, 'malvar-qam-ofc', '$2y$10$qdw912.w0ucWCV8uJCVj/.AhPoFCpS4p.DZPr8o69KdNUsb/KrY.K', 'malvar-qam-ofc', 'user', 'Malvar', 'Quality Assurance Management', 'active', '2025-11-08 10:52:45', '2025-11-08 10:52:45', NULL, NULL),
(275, 'malvar-pdc-ofc', '$2y$10$HJ.jS.HnHa7h5wGnUG2/sePIgEHq9YFvYLnZsvKL/LRsp2tvhWH4e', 'malvar-pdc-ofc', 'user', 'Malvar', 'Planning and Development', 'active', '2025-11-08 10:53:09', '2025-11-08 10:53:09', NULL, NULL),
(276, 'malvar-ea-ofc', '$2y$10$p9H8fmrDDqumhz4CFGPAE.TbN/Jq7Tev/TbSB7pLRmUZQvWjBLNqO', 'malvar-ea-ofc', 'user', 'Malvar', 'External Affairs', 'active', '2025-11-08 10:53:33', '2025-11-08 10:53:33', NULL, NULL),
(277, 'malvar-rgo-ofc', '$2y$10$wV/TTDSyZ9sYp3pHO.Gnre/pP01DXqlWUSFjJ0r6KXzaHN/NnbfCK', 'malvar-rgo-ofc', 'user', 'Malvar', 'Resource Generation', 'active', '2025-11-08 10:54:05', '2025-11-08 10:54:05', NULL, NULL),
(278, 'malvar-ict-ofc', '$2y$10$LtBH5xzJQx4fpjXM3stq0OuFgSPlKstVpeujCGy2DMqFNuWVtMnNK', 'malvar-ict-ofc', 'user', 'Malvar', 'ICT Services', 'active', '2025-11-08 10:54:27', '2025-11-08 10:54:27', NULL, NULL);
INSERT INTO `users` (`id`, `username`, `password`, `name`, `role`, `campus`, `office`, `status`, `created_at`, `updated_at`, `last_login`, `remember_token`) VALUES
(279, 'malvar-cas-ofc', '$2y$10$JpVygOjKoLQKa44q/8jE1uNwGQnuYgSfeZcpCklIsuyWIAu7cdINC', 'malvar-cas-ofc', 'user', 'Malvar', 'College of Arts and Sciences', 'active', '2025-11-08 10:54:50', '2025-11-08 10:54:50', NULL, NULL),
(280, 'malvar-cabe-ofc', '$2y$10$EQqOfCRgOsbL38pdIy/RqOMCrIwAq7FfPBP2YtN9QD.ie6A2juAfm', 'malvar-cabe-ofc', 'user', 'Malvar', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 10:55:06', '2025-11-08 10:55:06', NULL, NULL),
(281, 'malvar-cics-ofc', '$2y$10$WShfOwb2cJIjCG9SxccEAORcmx4p.2gs3wR2GCXR1C5eOi/F.xd06', 'malvar-cics-ofc', 'user', 'Malvar', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 10:55:28', '2025-11-08 10:55:28', NULL, NULL),
(282, 'malvar-cet-ofc', '$2y$10$BhcEr/1ScrL7UWL224zVquFEA6R1xcvDKLkTngLckRJbXPmJCBEU2', 'malvar-cet-ofc', 'user', 'Malvar', 'College of Engineering Technology', 'active', '2025-11-08 10:55:48', '2025-11-08 10:55:48', NULL, NULL),
(283, 'malvar-cte-ofc', '$2y$10$NnafiGmOv.zLUXDf7EYD4uhccxYs33d17ycUD7qQ8TOJGWHYDLKWu', 'malvar-cte-ofc', 'user', 'Malvar', 'College of Teacher Education', 'active', '2025-11-08 10:56:12', '2025-11-08 10:56:12', NULL, NULL),
(284, 'malvar-ce-ofc', '$2y$10$jHfTGxvTZSMIM6S.ZTgrEe1EKDWnUfavCsrQorjJFOzY1nLU8nWki', 'malvar-ce-ofc', 'user', 'Malvar', 'College of Engineering', 'active', '2025-11-08 10:56:32', '2025-11-08 10:56:32', NULL, NULL),
(285, 'malvar-ca-ofc', '$2y$10$dhhAQJYpk5gvajcG9JODKuQ4nyXF/BmIuGbA8MeNJO/GD6ReKN9f2', 'malvar-ca-ofc', 'user', 'Malvar', 'Culture and Arts', 'active', '2025-11-08 10:56:55', '2025-11-08 10:56:55', NULL, NULL),
(286, 'malvar-tao-ofc', '$2y$10$IPRVpfeawlkuADYr3YH9T.B6Z6bCzOcmBReqNcxUFBHgJBD/YA2Wi', 'malvar-tao-ofc', 'user', 'Malvar', 'Testing and Admission', 'active', '2025-11-08 10:57:12', '2025-11-08 10:57:12', NULL, NULL),
(287, 'malvar-rs-ofc', '$2y$10$XF0xtrJ8BVIM.xSBMRhgcePdpSATvIWEX5Z9TlzXik4b8t2vk4ESa', 'malvar-rs-ofc', 'user', 'Malvar', 'Registration Services', 'active', '2025-11-08 10:57:26', '2025-11-08 10:57:26', NULL, NULL),
(288, 'malvar-sfa-ofc', '$2y$10$Aa6G7dKDOtCf.1A2NdfCPukk/fp9QnAkJqHQDQBgmZXQ7Mq/cBobC', 'malvar-sfa-ofc', 'user', 'Malvar', 'Scholarship and Financial Assistance', 'active', '2025-11-08 10:57:47', '2025-11-08 10:57:47', NULL, NULL),
(289, 'malvar-gc-ofc', '$2y$10$PCDGw4gh5Hzu..R6zPRxxOQWu8WlEbmGvb01jhLd2NaLXWsgKrIl6', 'malvar-gc-ofc', 'user', 'Malvar', 'Guidance and Counseling', 'active', '2025-11-08 10:58:11', '2025-11-08 10:58:11', NULL, NULL),
(290, 'malvar-soa-ofc', '$2y$10$03PW64VsF7KJSRoy0jT7beqOeU0sdZ9kGQRwFJvlMBbEm.emCGjDy', 'malvar-soa-ofc', 'user', 'Malvar', 'Student Organization and Activities', 'active', '2025-11-08 10:58:30', '2025-11-08 10:58:30', NULL, NULL),
(291, 'malvar-sd-ofc', '$2y$10$fqKr0qN/PLLh49wGroVQO.zY0xp4dV3pzU8OCENGT9sBXvf3cTSaW', 'malvar-sd-ofc', 'user', 'Malvar', 'Student Discipline', 'active', '2025-11-08 10:58:50', '2025-11-08 10:58:50', NULL, NULL),
(292, 'malvar-sad-ofc', '$2y$10$4JftJ3rfiICcqxRNO40y1e56KSFrj1jSYHrtyWmHF/3QtQG74SG4K', 'malvar-sad-ofc', 'user', 'Malvar', 'Sports and Development', 'active', '2025-11-08 10:59:07', '2025-11-08 10:59:07', NULL, NULL),
(293, 'malvar-ojt-ofc', '$2y$10$Se81heCbcaOH8XGkssrTSOwqZS9vR7BiZjW58rMJGNr4uV9u8WDoG', 'malvar-ojt-ofc', 'user', 'Malvar', 'OJT', 'active', '2025-11-08 10:59:21', '2025-11-08 10:59:21', NULL, NULL),
(294, 'malvar-nstp-ofc', '$2y$10$7dewDPE5jwma7VNGdjbN2OoILoiAIRas0drOq98m9DkzJ3X.C3YN6', 'malvar-nstp-ofc', 'user', 'Malvar', 'National Service Training Program', 'active', '2025-11-08 10:59:40', '2025-11-08 10:59:40', NULL, NULL),
(295, 'malvar-hrmo-ofc', '$2y$10$ySepiVNO0GS5BLIyi8wMW.rOzker2ZCDdyo9ir4iCPo8HVWQWqTW2', 'malvar-hrmo-ofc', 'user', 'Malvar', 'Human Resource Management', 'active', '2025-11-08 10:59:55', '2025-11-08 10:59:55', NULL, NULL),
(296, 'malvar-rm-ofc', '$2y$10$kBrvkfOZXtgQigbLdZJD0uCrA9jTYpoxIoOKY2XLZBvQQgwyHHeBe', 'malvar-rm-ofc', 'user', 'Malvar', 'Records Management', 'active', '2025-11-08 11:00:13', '2025-11-08 11:00:13', NULL, NULL),
(297, 'malvar-pcr-ofc', '$2y$10$0yKxnP7EO3ToEZSj7IVQc.QvQKJU0pEPBx5LxD727xl2kht497bX6', 'malvar-pcr-ofc', 'user', 'Malvar', 'Procurement', 'active', '2025-11-08 11:00:31', '2025-11-08 11:00:31', NULL, NULL),
(298, 'malvar-bdgt-ofc', '$2y$10$0OXHD2adUmjLb.KLKi8q0OuuILNicZNW58gzzwrSJKXl6CFU.tdKO', 'malvar-bdgt-ofc', 'user', 'Malvar', 'Budget office', 'active', '2025-11-08 11:00:47', '2025-11-08 11:05:27', NULL, NULL),
(299, 'malvar-cd-ofc', '$2y$10$nGxRCFkRLKreXbAleRCasOq5wVWMc9hCFWT.ClLvc9WHza5ZeNt.y', 'malvar-cd-ofc', 'user', 'Malvar', 'Cashiering/Disbursing', 'active', '2025-11-08 11:01:06', '2025-11-08 11:01:06', NULL, NULL),
(300, 'malvar-pfm-ofc', '$2y$10$hxal.jhF6srzFShtOhYUF.g9vVsdJQ9MglA8alM.2HwI73Thv9etW', 'malvar-pfm-ofc', 'user', 'Malvar', 'Project Facilities and Management', 'active', '2025-11-08 11:01:33', '2025-11-08 11:01:33', NULL, NULL),
(301, 'malvar-emu-ofc', '$2y$10$WWAXihPB1c0Y5yNaNbAI0.oRFi5XO12jNw8cOsdLYOtUxmUtBwFRe', 'malvar-emu-ofc', 'user', 'Malvar', 'Environment Management Unit', 'active', '2025-11-08 11:01:52', '2025-11-08 11:01:52', NULL, NULL),
(302, 'malvar-psm-ofc', '$2y$10$WPNSxDuv/qSgBtdIRVHiFuHSnznWuoCOzsted43hHd0K0tgN7znqu', 'malvar-psm-ofc', 'user', 'Malvar', 'Property and Supply Management', 'active', '2025-11-08 11:02:49', '2025-11-08 11:02:49', NULL, NULL),
(303, 'malvar-gso-ofc', '$2y$10$6fGTV8SL3i3YgLKaN03ONusNFBluU2aJiKEtUnVohUU.Sm251j9X.', 'malvar-gso-ofc', 'user', 'Malvar', 'General Services', 'active', '2025-11-08 11:03:39', '2025-11-08 11:03:39', NULL, NULL),
(304, 'malvar-ext-ofc', '$2y$10$ESnlnEDQGGp2mK5UcfdJF.HeS3res/ha.2P3G2FIFp7F3cGDX0gA6', 'malvar-ext-ofc', 'user', 'Malvar', 'Extension', 'active', '2025-11-08 11:03:57', '2025-11-08 11:03:57', NULL, NULL),
(305, 'malvar-hs-ofc', '$2y$10$Uo7cVaxGBhza6HwZbUuK4ue2OMDjkyLG8iVA3Dq62w75PWKmjgzTC', 'malvar-hs-ofc', 'user', 'Malvar', 'Health Services', 'active', '2025-11-08 11:04:30', '2025-11-08 11:10:00', NULL, NULL),
(306, 'malvar-rsch-ofc', '$2y$10$UNmSHj9JOrDNqdhXgB/cmOEFhX/Tf8OgC0Iswu46I2.CEvRVYuNWm', 'malvar-rsch-ofc', 'user', 'Malvar', 'Research', 'active', '2025-11-08 11:13:05', '2025-11-08 11:13:05', NULL, NULL),
(307, 'balayan-admin-acc', '$2y$10$n/fcYJ4ggodc4N2KB5MVjujUQ0XZHyuF5FsDVhCnsahEFg2KKK.0u', 'balayan-admin-acc', 'admin', 'Balayan', '', 'active', '2025-11-08 11:15:27', '2025-11-08 11:16:37', '2025-11-08 11:16:37', NULL),
(308, 'lemery-admin-acc', '$2y$10$yKYwaW207gGLdySJk6ZzZedobI/OybLmGNOKmY5K3Ob1QvYNeE4Iq', 'lemery-admin-acc', 'admin', 'Lemery', '', 'active', '2025-11-08 11:21:18', '2025-11-09 03:39:20', '2025-11-09 03:39:20', NULL),
(309, 'balayan-rgtr-ofc', '$2y$10$ApWUKwWGZTLfLRWnuXCcQeTafzJSsX.orD.6O6P.l5FNibSlyDlzK', 'balayan-rgtr-ofc', 'user', 'Balayan', 'Registrar Office', 'active', '2025-11-08 11:23:47', '2025-11-08 12:13:09', '2025-11-08 12:13:09', NULL),
(310, 'balayan-acct-ofc', '$2y$10$UwV.MYDMAgoweZVkdYpgI.xfTv4PkZXA5RcFT86OVFIiFsanZKUha', 'balayan-acct-ofc', 'user', 'Balayan', 'Accounting Office', 'active', '2025-11-08 11:24:54', '2025-11-08 13:54:55', NULL, NULL),
(311, 'balayan-ia-ofc', '$2y$10$h1b1ftFyodG3ucWJG0dVje6YhmiENbGG2M5etP603lDjY9RMP/nhu', 'balayan-ia-ofc', 'user', 'Balayan', 'Internal Audit', 'active', '2025-11-08 11:25:10', '2025-11-08 11:25:10', NULL, NULL),
(312, 'balayan-qam-ofc', '$2y$10$PtSixvq85H5YbuEcZFOBieh29PPkalU7LmIALoUvJoRlR5pN0iOf2', 'balayan-qam-ofc', 'user', 'Balayan', 'Quality Assurance Management', 'active', '2025-11-08 11:25:34', '2025-11-08 11:25:34', NULL, NULL),
(313, 'balayan-pdc-ofc', '$2y$10$uPaGQWZ5JgR6DXgw1oWYfucbz.yhtPSvNycnv0d.EblfPSKXxgqe6', 'balayan-pdc-ofc', 'user', 'Balayan', 'Planning and Development', 'active', '2025-11-08 11:26:01', '2025-11-08 11:26:01', NULL, NULL),
(314, 'balayan-ea-ofc', '$2y$10$N2mb9SIk7dicz1RbnUl03OZyAc3pnNb2JQ0kiKeJRbLRJUBzJ8CVe', 'balayan-ea-ofc', 'user', 'Balayan', 'External Affairs', 'active', '2025-11-08 11:26:18', '2025-11-08 11:26:18', NULL, NULL),
(315, 'balayan-rgo-ofc', '$2y$10$8Zy.WPNW2Zoo3QhdxvxGbOB2triIwSP91HbTEuNDr43enFjGBU8Ku', 'balayan-rgo-ofc', 'user', 'Balayan', 'Resource Generation', 'active', '2025-11-08 11:26:37', '2025-11-17 06:01:46', '2025-11-17 06:01:46', NULL),
(316, 'balayan-ict-ofc', '$2y$10$euc8EhDqRldJIurw/wLvT.IELDR8l7SCvfsCSTFyO5GIM.QMiuGhO', 'balayan-ict-ofc', 'user', 'Balayan', 'ICT Services', 'active', '2025-11-08 11:26:55', '2025-11-08 11:26:55', NULL, NULL),
(317, 'balayan-cas-ofc', '$2y$10$Eu5Unun/vk7sTCOWzz0wDu/W1Ct2vQmNbjNHu3LudBRlu0tIbDdHu', 'balayan-cas-ofc', 'user', 'Balayan', 'College of Arts and Sciences', 'active', '2025-11-08 11:27:26', '2025-11-08 11:27:26', NULL, NULL),
(318, 'balayan-cabe-ofc', '$2y$10$KkKE/6J/uR.35LqlqP6/r.MtYEUcYRpYKaoboyDc2jH.WI0t8exJm', 'balayan-cabe-ofc', 'user', 'Balayan', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 11:27:40', '2025-11-08 11:27:40', NULL, NULL),
(319, 'balayan-cics-ofc', '$2y$10$UETaXUZ8asi/hp1i3gkor.2Yk4g4KzgKn4kChR2Kz2UL7acTOU8mS', 'balayan-cics-ofc', 'user', 'Balayan', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 11:28:53', '2025-11-08 11:28:53', NULL, NULL),
(320, 'balayan-cet-ofc', '$2y$10$PZveW5y0w6tvOgl8nr.UDO3agX7Z5EcE9Q5Apc96Gt4ifS4OuUSUS', 'balayan-cet-ofc', 'user', 'Balayan', 'College of Engineering Technology', 'active', '2025-11-08 11:29:07', '2025-11-08 11:29:07', NULL, NULL),
(321, 'balayan-cte-ofc', '$2y$10$IuDAV6N0L2kBEjW/C5uw.O3VDBY0qXgtgHzDCHnAgni4qA1TXX5OG', 'balayan-cte-ofc', 'user', 'Balayan', 'College of Teacher Education', 'active', '2025-11-08 11:29:26', '2025-11-08 11:29:26', NULL, NULL),
(322, 'balayan-ce-ofc', '$2y$10$XQhTuuUceE6vaEwvY5Gt4el9RdPNSa.aMCZP4hKPO8R8LtlH6fwSK', 'balayan-ce-ofc', 'user', 'Balayan', 'College of Engineering', 'active', '2025-11-08 11:29:44', '2025-11-08 11:29:44', NULL, NULL),
(323, 'balayan-ca-ofc', '$2y$10$X40wuK/VWHJ3Q875xLeTr.JWMqHSStS08H1I0D4cnwDZl./eGxVOy', 'balayan-ca-ofc', 'user', 'Balayan', 'Culture and Arts', 'active', '2025-11-08 11:29:55', '2025-11-08 11:30:36', NULL, NULL),
(324, 'balayan-tao-ofc', '$2y$10$Ast330EnBLfbnYxy7eayFeccR8FmUX/sevEmeMmaH6A7jer68PnuW', 'balayan-tao-ofc', 'user', 'Balayan', 'Testing and Admission', 'active', '2025-11-08 11:30:57', '2025-11-08 11:30:57', NULL, NULL),
(325, 'balayan-rs-ofc', '$2y$10$AwhKpskz3l.JvsXpsk7je.oCw6lTsyPHFPlh4uL47VeK1UJpFXGOW', 'balayan-rs-ofc', 'user', 'Balayan', 'Registration Services', 'active', '2025-11-08 11:31:23', '2025-11-08 11:31:23', NULL, NULL),
(326, 'balayan-sfa-ofc', '$2y$10$Xea/WEaWnes8CQmJHXIOVuO4thTDAPpK13hILLjzxWz5uHkd.O/E2', 'balayan-sfa-ofc', 'user', 'Balayan', 'Scholarship and Financial Assistance', 'active', '2025-11-08 11:32:33', '2025-11-08 11:32:33', NULL, NULL),
(327, 'balayan-gc-ofc', '$2y$10$onpyBYJG//odvxG4TGt3fOKOKHKKgWF4xt6gffc3an1coO54dQgJ2', 'balayan-gc-ofc', 'user', 'Balayan', 'Guidance and Counseling', 'active', '2025-11-08 11:35:19', '2025-11-08 11:35:19', NULL, NULL),
(328, 'balayan-soa-ofc', '$2y$10$GXGpqdciJwktdQ89mp/75.Zl56jNmD5ugjwVq1J6/RoJtjqMAB4qG', 'balayan-soa-ofc', 'user', 'Balayan', 'Student Organization and Activities', 'active', '2025-11-08 11:35:43', '2025-11-08 11:35:43', NULL, NULL),
(329, 'balayan-sd-ofc', '$2y$10$JG6D.0.YsZWVnk0apw6Q7OutkFozcTfa.9P9yNCbgZg12TK1aCphS', 'balayan-sd-ofc', 'user', 'Balayan', 'Student Discipline', 'active', '2025-11-08 11:36:16', '2025-11-08 11:36:16', NULL, NULL),
(330, 'balayan-sad-ofc', '$2y$10$K2YpCFoxvZ1WmEEgpEv/SutOgd3PBkfbdRgdOM.SMvE2JM9I8zn8m', 'balayan-sad-ofc', 'user', 'Balayan', 'Sports and Development', 'active', '2025-11-08 11:36:49', '2025-11-08 11:36:49', NULL, NULL),
(331, 'balayan-ojt-ofc', '$2y$10$AmBIrt76VT0Pwb9xpD5Zo.mxkHV9czR6j9sqDoe8ohN.XzIvcZFnq', 'balayan-ojt-ofc', 'user', 'Balayan', 'OJT', 'active', '2025-11-08 11:37:05', '2025-11-08 11:37:05', NULL, NULL),
(332, 'balayan-nstp-ofc', '$2y$10$nDm3I6g.l7iItkhy7ByS2epwZKz.1ENQj03Ny2zbYxWo/Bdndq38O', 'balayan-nstp-ofc', 'user', 'Balayan', 'National Service Training Program', 'active', '2025-11-08 11:38:44', '2025-11-08 12:13:53', '2025-11-08 12:13:53', NULL),
(333, 'balayan-hrmo-ofc', '$2y$10$opCDxGMEewkDif9XLNAQ..c49Mi0cAa8UuRMwDBCEJbkUrqZ2/M/m', 'balayan-hrmo-ofc', 'user', 'Balayan', 'Human Resource Management', 'active', '2025-11-08 11:39:01', '2025-11-08 11:39:01', NULL, NULL),
(334, 'balayan-rm-ofc', '$2y$10$5hH.h7NuyNjeAgvB/7X2beu.AixdYhGYfx0zJIPrrzSHaBgp3p6sG', 'balayan-rm-ofc', 'user', 'Balayan', 'Records Management', 'active', '2025-11-08 11:39:22', '2025-11-08 11:39:22', NULL, NULL),
(335, 'balayan-pcr-ofc', '$2y$10$fTjE3dI8XXr2mCRYRxZJMehNihCptGNR4PXbXqB/YtVus8g6E/Ynm', 'balayan-pcr-ofc', 'user', 'Balayan', 'Procurement', 'active', '2025-11-08 11:39:53', '2025-11-08 11:39:53', NULL, NULL),
(336, 'balayan-bdgt-ofc', '$2y$10$eDcul4iIQ7hY9AXm27oUJusZUsOmWcnKldhhLg5fScJUtkEgP/EJm', 'balayan-bdgt-ofc', 'user', 'Balayan', 'Budget office', 'active', '2025-11-08 11:40:21', '2025-11-08 11:40:21', NULL, NULL),
(337, 'balayan-cd-ofc', '$2y$10$Kswap8sORMkIVjcFXqKYJuZizUTc7q9woT4AsUA.KsLZstUBse54e', 'balayan-cd-ofc', 'user', 'Balayan', 'Cashiering/Disbursing', 'active', '2025-11-08 11:40:35', '2025-11-08 11:40:35', NULL, NULL),
(338, 'balayan-pfm-ofc', '$2y$10$0Tn6PmuhUrfcN8KyPPgIheIRf88SOgA9aDxCyiObhCki.WXofooDS', 'balayan-pfm-ofc', 'user', 'Balayan', 'Project Facilities and Management', 'active', '2025-11-08 11:40:50', '2025-11-08 11:40:50', NULL, NULL),
(339, 'balayan-emu-ofc', '$2y$10$9damDz8XKqPmkMQMHJriR.4In00YXS08LLCnzZ/Fnf2siZUCkrKta', 'balayan-emu-ofc', 'user', 'Balayan', 'Environment Management Unit', 'active', '2025-11-08 11:41:10', '2025-11-08 11:41:10', NULL, NULL),
(340, 'balayan-psm-ofc', '$2y$10$1PppZvdbLPwKWEGKfUQzN.pGIIwkK58Dw98tHRcOKVyHkPgyeGEh2', 'balayan-psm-ofc', 'user', 'Balayan', 'Property and Supply Management', 'active', '2025-11-08 11:41:31', '2025-11-08 11:41:31', NULL, NULL),
(341, 'balayan-gso-ofc', '$2y$10$0J.hfNhTlus6RYUE7oquLu/ua9EKf.Cn118Cgthsrx5j0r7RCSgTK', 'balayan-gso-ofc', 'user', 'Balayan', 'General Services', 'active', '2025-11-08 11:41:47', '2025-11-08 11:41:47', NULL, NULL),
(342, 'balayan-ext-ofc', '$2y$10$OGiVkZmNrt/1qpl2TA1XyOM0b7hMkaHVzQfWhVJhqSIi8mwM13Fpa', 'balayan-ext-ofc', 'user', 'Balayan', 'Extension', 'active', '2025-11-08 11:42:13', '2025-11-08 11:42:13', NULL, NULL),
(343, 'balayan-rsch-ofc', '$2y$10$nFqFaSCdj9Qs/rBO88gIuuZVUcDYeQueLR9ogd0W0i77pL/me9hMi', 'balayan-rsch-ofc', 'user', 'Balayan', 'Research', 'active', '2025-11-08 11:42:51', '2025-11-08 11:42:51', NULL, NULL),
(344, 'balayan-hs-ofc', '$2y$10$.X2U7ErYArLdtsyD76kXkOnx7z31Lm4F3NwNxdnllWir4a4gi7Hiq', 'balayan-hs-ofc', 'user', 'Balayan', 'Health Services', 'active', '2025-11-08 11:43:16', '2025-11-08 11:43:16', NULL, NULL),
(345, 'lemery-rgtr-ofc', '$2y$10$vOuWgCKUDJl9JOaoIEdq3eCDOC9eqgrUF.xzmZPwS.J0wx367.RQS', 'lemery-rgtr-ofc', 'user', 'Lemery', 'Registrar Office', 'active', '2025-11-08 11:50:25', '2025-11-08 11:50:25', NULL, NULL),
(346, 'lemery-acct-ofc', '$2y$10$Ldk.JWFZhRTw6fc8Q5UoSu4Sfjg0S595nHhNewNIGWAkQj7qW/Pw2', 'lemery-acct-ofc', 'user', 'Lemery', 'Accounting Office', 'active', '2025-11-08 11:50:38', '2025-11-08 14:27:56', '2025-11-08 14:27:56', NULL),
(347, 'lemery-ia-ofc', '$2y$10$o2oPCiBCCdjcOwQEyo2YLO.W/TkjfkLgnBUpWDtNdmHysTtqNt/M2', 'lemery-ia-ofc', 'user', 'Lemery', 'Internal Audit', 'active', '2025-11-08 11:51:31', '2025-11-08 11:51:31', NULL, NULL),
(348, 'lemery-qam-ofc', '$2y$10$CJGVgq/H/dhNOosnf/u.yOXspyVEbAbYkBhycgGWRpYW9bwjkGXSW', 'lemery-qam-ofc', 'user', 'Lemery', 'Quality Assurance Management', 'active', '2025-11-08 11:51:46', '2025-11-08 11:51:46', NULL, NULL),
(349, 'lemery-pdc-ofc', '$2y$10$R1XnBHKpfEpBOGTxLohGSOjsoFJDlObzYjlz2QcyOeQ93bk98GZ9.', 'lemery-pdc-ofc', 'user', 'Lemery', 'Planning and Development', 'active', '2025-11-08 11:51:58', '2025-11-08 11:51:58', NULL, NULL),
(350, 'lemery-ea-ofc', '$2y$10$wUHpO17aU8IQLIVHyKFKQOEpr09c4KgjyfaRWRSQoR5dhzwvHlPmS', 'lemery-ea-ofc', 'user', 'Lemery', 'External Affairs', 'active', '2025-11-08 11:52:22', '2025-11-08 11:52:22', NULL, NULL),
(351, 'lemery-rgo-ofc', '$2y$10$jxXd8ZlL4EPl0svQqkGwZuW2hSxnXRTvaIWBpnQALVmWTHodpKBKq', 'lemery-rgo-ofc', 'user', 'Lemery', 'Resource Generation', 'active', '2025-11-08 11:55:32', '2025-11-09 03:05:44', '2025-11-09 03:05:44', NULL),
(352, 'lemery-ict-ofc', '$2y$10$Pa2ss6NCebdNLE0JWr6ADuoCgad91Q7dtRUWh8zRqYvjQs043FbtS', 'lemery-ict-ofc', 'user', 'Lemery', 'ICT Services', 'active', '2025-11-08 11:55:49', '2025-11-08 11:55:49', NULL, NULL),
(353, 'lemery-cas-ofc', '$2y$10$2yf6SbN8FwJPeL1PciIa2.VjiKx.zYYsBsyaRqLmrCleWLa6AvaCq', 'lemery-cas-ofc', 'user', 'Lemery', 'College of Arts and Sciences', 'active', '2025-11-08 11:56:19', '2025-11-08 11:56:19', NULL, NULL),
(354, 'lemery-cabe-ofc', '$2y$10$VA.75scyHPgDifg.MJ/TzORI.AMJkWiMVWILBHKPFC4meWKOLEDpa', 'lemery-cabe-ofc', 'user', 'Lemery', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 11:56:47', '2025-11-08 11:56:47', NULL, NULL),
(355, 'lemery-cics-ofc', '$2y$10$zW/XjqC9DfsFSy9ysNjHR.FRJRJ52jvBtVy4KgBSYfz8vUFgb10ru', 'lemery-cics-ofc', 'user', 'Lemery', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 11:57:04', '2025-11-08 11:57:04', NULL, NULL),
(356, 'lemery-cet-ofc', '$2y$10$u3mf4z54uWZ4HnMjNBWZIOGcmb4GkwKHl1rnTjZM9085Zoht1QQ0m', 'lemery-cet-ofc', 'user', 'Lemery', 'College of Engineering Technology', 'active', '2025-11-08 11:57:22', '2025-11-08 11:57:22', NULL, NULL),
(357, 'lemery-cte-ofc', '$2y$10$t6JLdq358zkshzU.Gky7EOtjXdO/URgycnlxXIvD0iBnf6eikJxq.', 'lemery-cte-ofc', 'user', 'Lemery', 'College of Teacher Education', 'active', '2025-11-08 11:57:37', '2025-11-08 11:57:37', NULL, NULL),
(358, 'lemery-ce-ofc', '$2y$10$.r/h5a4dXrjGEypPkG64vuKJGKT3HLFgnbkg23ugANJaPUiNSOnYO', 'lemery-ce-ofc', 'user', 'Lemery', 'College of Engineering', 'active', '2025-11-08 11:58:09', '2025-11-08 11:58:45', NULL, NULL),
(359, 'lemery-ca-ofc', '$2y$10$o3F34FkKQu1k.lqgbwBM4.CbngGIDrdHTd5iihKSPy8Z4VAdS/g/S', 'lemery-ca-ofc', 'user', 'Lemery', 'Culture and Arts', 'active', '2025-11-08 11:58:34', '2025-11-08 11:58:34', NULL, NULL),
(360, 'lemery-tao-ofc', '$2y$10$ZUL0jbZLgxU7XqktbB2B7OjfbwnzAvwhHV9irlCuPsxHBW1T.mZtG', 'lemery-tao-ofc', 'user', 'Lemery', 'Testing and Admission', 'active', '2025-11-08 11:59:22', '2025-11-08 11:59:22', NULL, NULL),
(361, 'lemery-rs-ofc', '$2y$10$1dhNlFpmQOG8eQm0lIybqOCLp9appKcUcAKokghxEDXJfLorbCmQO', 'lemery-rs-ofc', 'user', 'Lemery', 'Registration Services', 'active', '2025-11-08 11:59:46', '2025-11-08 11:59:46', NULL, NULL),
(362, 'lemery-sfa-ofc', '$2y$10$e2OF.BFABE7kEbVCOPOJk.SgCVwF6OHPO3eSzV7lk2.Y56eRXXwTW', 'lemery-sfa-ofc', 'user', 'Lemery', 'Scholarship and Financial Assistance', 'active', '2025-11-08 12:00:12', '2025-11-08 12:02:19', NULL, NULL),
(363, 'lemery-gc-ofc', '$2y$10$hYrBADUtPIxF0fJ4AEYp7.JKtxd2tQFh6QUsYT6PrHwKJeWhIjD72', 'lemery-gc-ofc', 'user', 'Lemery', 'Guidance and Counseling', 'active', '2025-11-08 12:00:56', '2025-11-08 12:02:06', NULL, NULL),
(364, 'lemery-soa-ofc', '$2y$10$wxDqdlKbVGmI/tLH9gWMhecNH0QLuMR2lkm.2Co1FaQmTe145CgKu', 'lemery-soa-ofc', 'user', 'Lemery', 'Student Organization and Activities', 'active', '2025-11-08 12:02:42', '2025-11-08 12:02:42', NULL, NULL),
(365, 'mabini-admin-acc', '$2y$10$shPmNF7G8tBWifSB8CbyF.u4prJ.lwT7HOq8..kleHjFHChW6rxM2', 'mabini-admin-acc', 'admin', 'Mabini', '', 'active', '2025-11-08 12:02:52', '2025-11-09 03:45:34', '2025-11-09 03:45:34', NULL),
(366, 'lemery-sd-ofc', '$2y$10$hnfe0f5/.yKcqrXeB.diaeDHCqvjRYlt2/farYJlYmq3eBJuqAOo2', 'lemery-sd-ofc', 'user', 'Lemery', 'Student Discipline', 'active', '2025-11-08 12:03:30', '2025-11-08 12:03:30', NULL, NULL),
(367, 'lemery-sad-ofc', '$2y$10$pgmB5G88LW0ySbBq8i00RuEsFO6xIyFF1chB56kD/j9voDALZwqAq', 'lemery-sad-ofc', 'user', 'Lemery', 'Sports and Development', 'active', '2025-11-08 12:04:09', '2025-11-08 12:04:09', NULL, NULL),
(368, 'lemery-ojt-ofc', '$2y$10$4MoLbjcDIGOTGd4/xz7SEeq83ktgcvAq3JRI5eISn8QIqf74yLNe6', 'lemery-ojt-ofc', 'user', 'Lemery', 'OJT', 'active', '2025-11-08 12:04:25', '2025-11-08 12:04:25', NULL, NULL),
(369, 'mabini-rgtr-ofc', '$2y$10$cNX4DD7SLD6xUS1a4ZMbk.rUs21abWRKR3x6XFpUGdIm/VYTryqtG', 'mabini-rgtr-ofc', 'user', 'Mabini', 'Registrar Office', 'active', '2025-11-08 12:04:46', '2025-11-08 12:04:46', NULL, NULL),
(370, 'lemery-nstp-ofc', '$2y$10$P/yaRUgrlARNj2M3wyp9Cu5ms.8qi3K1NVZYMwZ2.DsPbYEjsUque', 'lemery-nstp-ofc', 'user', 'Lemery', 'National Service Training Program', 'active', '2025-11-08 12:05:10', '2025-11-08 12:05:10', NULL, NULL),
(371, 'mabini-acct-ofc', '$2y$10$OiIFVoA2Z7QQTdEKFR9SYec4xUxg4VxPkDNblpvLeMZoCS4Kfkv82', 'mabini-acct-ofc', 'user', 'Mabini', 'Accounting Office', 'active', '2025-11-08 12:05:22', '2025-11-08 13:54:13', NULL, NULL),
(372, 'lemery-hrmo-ofc', '$2y$10$gGjyIJEa2OJOuWv.MtKa1eXPZHj2FyvWdhnLUM5XWQqLrR0D3dxCy', 'lemery-hrmo-ofc', 'user', 'Lemery', 'Human Resource Management', 'active', '2025-11-08 12:05:26', '2025-11-08 12:05:26', NULL, NULL),
(373, 'lemery-rm-ofc', '$2y$10$VYOqQrxPMevGbq4sPc.0xOEUPSY9KjgWh9G9utLEOiVL8pK4ilJSm', 'lemery-rm-ofc', 'user', 'Lemery', 'Records Management', 'active', '2025-11-08 12:05:54', '2025-11-08 12:05:54', NULL, NULL),
(374, 'lemery-pcr-ofc', '$2y$10$jWJ3knJTCdYmhNzc1.euW.IAercOm9MGqF.RVH3bm8GEyV3YuxkEK', 'lemery-pcr-ofc', 'user', 'Lemery', 'Procurement', 'active', '2025-11-08 12:06:22', '2025-11-08 12:06:22', NULL, NULL),
(375, 'lemery-bdgt-ofc', '$2y$10$9MlnSGbqLq2h/nlAecrdP.8Zp00T54LYOi5I/s0V.Pj7cIAUIgRwa', 'lemery-bdgt-ofc', 'user', 'Lemery', 'Budget office', 'active', '2025-11-08 12:06:45', '2025-11-08 12:06:45', NULL, NULL),
(376, 'lemery-cd-ofc', '$2y$10$4lOXs6FilCQgDYG6tJBJb.YDYIoOjKeyJ1IGqfEYXH5Tp2Wzx.Dq.', 'lemery-cd-ofc', 'user', 'Lemery', 'Cashiering/Disbursing', 'active', '2025-11-08 12:07:11', '2025-11-08 12:07:11', NULL, NULL),
(377, 'lemery-pfm-ofc', '$2y$10$o5pI72721OoqdzaSgOVjuuqLtphDxOgJLGfXQbaL/Kn.7zUaB87fG', 'lemery-pfm-ofc', 'user', 'Lemery', 'Project Facilities and Management', 'active', '2025-11-08 12:07:32', '2025-11-08 12:07:32', NULL, NULL),
(378, 'lemery-emu-ofc', '$2y$10$faMOE4yxIOQwwFkKQtv8v.Rn0tX9fBfahHvRzsXu0cphae5zPdhHm', 'lemery-emu-ofc', 'user', 'Lemery', 'Environment Management Unit', 'active', '2025-11-08 12:07:57', '2025-11-08 12:07:57', NULL, NULL),
(379, 'lemery-psm-ofc', '$2y$10$q1fyiSBm6F4o8T7EpgGe2eozQdcRhO8sc0XV7mhoh8/rKpXvkeYpu', 'lemery-psm-ofc', 'user', 'Lemery', 'Property and Supply Management', 'active', '2025-11-08 12:08:17', '2025-11-08 12:08:17', NULL, NULL),
(380, 'lemery-gso-ofc', '$2y$10$F1giUWqAOr3PwA2qzRIJHu7qdyV71WmuGMT2K0XmaQF1u7g53Z.XK', 'lemery-gso-ofc', 'user', 'Lemery', 'General Services', 'active', '2025-11-08 12:08:36', '2025-11-08 12:08:36', NULL, NULL),
(381, 'lemery-ext-ofc', '$2y$10$8uVKRN6GBnRg5JvHrbiH/.kghTt.RuIod7bRaKnD6mj/ZKImV0q9O', 'lemery-ext-ofc', 'user', 'Lemery', 'Extension', 'active', '2025-11-08 12:08:56', '2025-11-08 12:08:56', NULL, NULL),
(382, 'lemery-rsch-ofc', '$2y$10$JxhUqkcynZ/vARerKKaEhO2dJ/6v.QpTwWz2IOX/8WZRyRLTgmY4a', 'lemery-rsch-ofc', 'user', 'Lemery', 'Research', 'active', '2025-11-08 12:09:10', '2025-11-08 12:09:10', NULL, NULL),
(383, 'lemery-hs-ofc', '$2y$10$MRGVlpghq5MtCwa2wCd6iuhK7DB8jLpkR2kXIDO7/WwPi13AORWRW', 'lemery-hs-ofc', 'user', 'Lemery', 'Health Services', 'active', '2025-11-08 12:09:30', '2025-11-08 12:09:30', NULL, NULL),
(384, 'rosario-admin-acc', '$2y$10$KO0bqiBwYaUOQ3rwN1TRo.75dUy686gGNjgi/GIBJMtDwtmttD0PG', 'rosario-admin-acc', 'admin', 'Rosario', '', 'active', '2025-11-08 12:09:34', '2025-11-15 13:50:24', '2025-11-15 13:50:24', NULL),
(385, 'mabini-ia-ofc', '$2y$10$7LshD/SZ3EevXXkJGvcqveDXG.9q6oQQ96zDi4HVrR3fod23XHfoO', 'mabini-ia-ofc', 'user', 'Mabini', 'Internal Audit', 'active', '2025-11-08 12:11:01', '2025-11-08 12:11:01', NULL, NULL),
(386, 'mabini-qam-ofc', '$2y$10$cgSZjGYhRCaIKtzXFbKGeu/vdcKkxbUpymlgM.H8AIbianb4Q5PIC', 'mabini-qam-ofc', 'user', 'Mabini', 'Quality Assurance Management', 'active', '2025-11-08 12:11:30', '2025-11-08 12:11:30', NULL, NULL),
(387, 'mabini-pdc-ofc', '$2y$10$A3RACSJYsEvs7pw4jA1dz.vARDD7er.V47KQAAYuiA67BWnI4vNTa', 'mabini-pdc-ofc', 'user', 'Mabini', 'Planning and Development', 'active', '2025-11-08 12:12:14', '2025-11-08 12:12:14', NULL, NULL),
(388, 'mabini-ea-ofc', '$2y$10$ZxNesF67DvE2YwIRaD1Fq.aKRm5JRk/bx0lU8Oq2yu4woTAbmVPA6', 'mabini-ea-ofc', 'user', 'Mabini', 'External Affairs', 'active', '2025-11-08 12:12:38', '2025-11-08 12:12:38', NULL, NULL),
(391, 'mabini-rgo-ofc', '$2y$10$LtlF8n4cFtiZYcImrHeetO3h.cZlSSQyz4ETTnEs/S0AktG1yglFu', 'mabini-rgo-ofc', 'user', 'Mabini', 'Resource Generation', 'active', '2025-11-08 12:13:02', '2025-11-17 06:00:06', '2025-11-17 06:00:06', NULL),
(392, 'mabini-ict-ofc', '$2y$10$5IM/koR.2SVRWtOHGkcuROX/v.bXbFTaIVNJuW5MGDaJxJeWo9kXK', 'mabini-ict-ofc', 'user', 'Mabini', 'ICT Services', 'active', '2025-11-08 12:13:25', '2025-11-08 12:13:25', NULL, NULL),
(393, 'mabini-cas-ofc', '$2y$10$47SB5aJnxicvwoV/8adLuO1hDPkG/v9ts/tfH6wu2Sj6PDOLm0Pe.', 'mabini-cas-ofc', 'user', 'Mabini', 'College of Arts and Sciences', 'active', '2025-11-08 12:13:59', '2025-11-08 12:13:59', NULL, NULL),
(394, 'rosario-rgtr-ofc', '$2y$10$qXAmsDISDmbhpFIFudoCbeFGJIWN/t6t3BKSPeLaSsK3Ntjs.UQV.', 'rosario-rgtr-ofc', 'user', 'Rosario', 'Registrar Office', 'active', '2025-11-08 12:14:16', '2025-11-11 01:51:38', '2025-11-11 01:51:38', NULL),
(395, 'mabini-cabe-ofc', '$2y$10$.ihU7GEf/vwHx6hw58QxpuglndugLNA1ZYm7hy/NbhVN./l6jzHfa', 'mabini-cabe-ofc', 'user', 'Mabini', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 12:14:30', '2025-11-08 12:14:30', NULL, NULL),
(396, 'rosario-acct-ofc', '$2y$10$/Wz7TLfD7focQnUX/fCiC.AX/SlUjoND8fpmJF4z12Ao9qP1IzS0G', 'rosario-acct-ofc', 'user', 'Rosario', 'Accounting Office', 'active', '2025-11-08 12:14:32', '2025-11-08 14:29:51', '2025-11-08 14:29:51', NULL),
(397, 'rosario-ia-ofc', '$2y$10$wWlF1SEDkOyjmpToEKPvG.U4YwIx0O85ZnHChw2Xg5eDcJQrss9sO', 'rosario-ia-ofc', 'user', 'Rosario', 'Internal Audit', 'active', '2025-11-08 12:14:47', '2025-11-08 12:14:47', NULL, NULL),
(398, 'mabini-cics-ofc', '$2y$10$0KmiqiGkx8xE3hVaJp.RP.519GpsTmmm2ccy1sj1G7dMKzsnsMty2', 'mabini-cics-ofc', 'user', 'Mabini', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 12:14:57', '2025-11-08 12:14:57', NULL, NULL),
(399, 'rosario-qam-ofc', '$2y$10$ifdEIBmxJ.nFTDJBM2.1B.n8mAJYKsOh.Aq95PROeR1X6LqMSpCIC', 'rosario-qam-ofc', 'user', 'Rosario', 'Quality Assurance Management', 'active', '2025-11-08 12:15:04', '2025-11-08 12:15:04', NULL, NULL),
(400, 'mabini-cet-ofc', '$2y$10$vXxtv9aCd1dJXj3NcBkpCuhrp9hPPyE.5ZG7DyIv4BvyjRxTpsTXa', 'mabini-cet-ofc', 'user', 'Mabini', 'College of Engineering Technology', 'active', '2025-11-08 12:15:21', '2025-11-08 12:15:21', NULL, NULL),
(401, 'rosario-pdc-ofc', '$2y$10$Ec0VV8zFD1eLTvo9rqx3reO.d0NVBBhXvtjr4Lx8ii75HJSzq47jK', 'rosario-pdc-ofc', 'user', 'Rosario', 'Planning and Development', 'active', '2025-11-08 12:15:24', '2025-11-08 12:15:24', NULL, NULL),
(402, 'rosario-ea-ofc', '$2y$10$xKwx0BCCLMRzYbEJ/j95teALOkdOQ.kpMKzPexbjAHzj58jr9nNau', 'rosario-ea-ofc', 'user', 'Rosario', 'External Affairs', 'active', '2025-11-08 12:15:39', '2025-11-08 12:15:39', NULL, NULL),
(403, 'mabini-cte-ofc', '$2y$10$l5eAZ18JSOhP/V3ng3dtRON9GUC40tGIfJVxdhl3baUeR7/FehnO6', 'mabini-cte-ofc', 'user', 'Mabini', 'College of Teacher Education', 'active', '2025-11-08 12:15:42', '2025-11-08 12:15:42', NULL, NULL),
(404, 'rosario-rgo-ofc', '$2y$10$m99f6.BVEBuPjC.yAa8EAOfIWWwJy2a0741dfWlTCxjQQ8kbapoE2', 'rosario-rgo-ofc', 'user', 'Rosario', 'Resource Generation', 'active', '2025-11-08 12:16:00', '2025-11-08 12:16:00', NULL, NULL),
(405, 'mabini-ce-ofc', '$2y$10$l1mcNPIadrP50zxiOHwyBub9oUYrav3qSjo2cHeGQSK/xXEHQkA4S', 'mabini-ce-ofc', 'user', 'Mabini', 'College of Engineering', 'active', '2025-11-08 12:16:05', '2025-11-08 12:16:05', NULL, NULL),
(406, 'rosario-ict-ofc', '$2y$10$3B036kZKuS6w7eAO3BX.GOOlEFpwTbXxy2fzgDLvwMM/rV58isO1S', 'rosario-ict-ofc', 'user', 'Rosario', 'ICT Services', 'active', '2025-11-08 12:16:13', '2025-11-08 12:16:13', NULL, NULL),
(407, 'mabini-ca-ofc', '$2y$10$Kk3r0WrsDRPcQGKiixMgYOav1mGn4CtoRPcvCxd5.pkIpeGee6Guq', 'mabini-ca-ofc', 'user', 'Mabini', 'Culture and Arts', 'active', '2025-11-08 12:16:33', '2025-11-08 12:16:33', NULL, NULL),
(408, 'rosario-cas-ofc', '$2y$10$9ttZjk2ryUdJNfIrgDqdmOW/8fradNu0KakCYRn4eLgsWtKHEDmoO', 'rosario-cas-ofc', 'user', 'Rosario', 'College of Arts and Sciences', 'active', '2025-11-08 12:16:33', '2025-11-08 12:16:33', NULL, NULL),
(409, 'rosario-cabe-ofc', '$2y$10$SvR/vH5kVtzNXAziu1xDiepFv29SvMKdduUa3RL.Ksz7WLcodoA0u', 'rosario-cabe-ofc', 'user', 'Rosario', 'College of Accountancy, Business and Economics', 'active', '2025-11-08 12:16:53', '2025-11-08 12:16:53', NULL, NULL),
(410, 'mabini-tao-ofc', '$2y$10$Bd5.ufWQMt9KGwoAwveBZ.34xjVDppnK94xZDTNnUr0XD29Pfdcui', 'mabini-tao-ofc', 'user', 'Mabini', 'Testing and Admission', 'active', '2025-11-08 12:16:57', '2025-11-08 12:16:57', NULL, NULL),
(411, 'rosario-cics-ofc', '$2y$10$d5ICGvbVvo2pcOwWg64FO.qQPA2oZ7FlbKFBXSO7gW2p1xpSqvnpy', 'rosario-cics-ofc', 'user', 'Rosario', 'College of Informatics and Computing Sciences', 'active', '2025-11-08 12:17:10', '2025-11-08 12:17:10', NULL, NULL),
(412, 'mabini-rs-ofc', '$2y$10$h3Njn4yEVXjBkSsBo9W9dOpfM3jf/1B2m6QlZkz3bNipZZkVQP9OK', 'mabini-rs-ofc', 'user', 'Mabini', 'Registration Services', 'active', '2025-11-08 12:17:21', '2025-11-08 12:17:21', NULL, NULL),
(413, 'rosario-cet-ofc', '$2y$10$3nOcfmjno3J33/3nCoXfvulhShxFc4HRPV4x6hfwHLO7Hh7QjMUY.', 'rosario-cet-ofc', 'user', 'Rosario', 'College of Engineering Technology', 'active', '2025-11-08 12:17:25', '2025-11-08 12:17:25', NULL, NULL),
(414, 'mabini-sfa-ofc', '$2y$10$0j6C5slxAXbRR76qmZYWAeF0eVZUxtYsRNmG8gaMzTnKLPgChgC2e', 'mabini-sfa-ofc', 'user', 'Mabini', 'Scholarship and Financial Assistance', 'active', '2025-11-08 12:18:01', '2025-11-08 12:18:01', NULL, NULL),
(415, 'mabini-gc-ofc', '$2y$10$enS6HZ32oHc.vAGHtL3gWOJ5xrw0KvCy9fBbViLXS2.22uN90869G', 'mabini-gc-ofc', 'user', 'Mabini', 'Guidance and Counseling', 'active', '2025-11-08 12:18:30', '2025-11-08 12:18:30', NULL, NULL),
(416, 'mabini-soa-ofc', '$2y$10$E./1u892.MjKuZHV9Qh7E.t0vg2Ld3N.rWZVu/UlwMUJkFsGTRt4S', 'mabini-soa-ofc', 'user', 'Mabini', 'Student Organization and Activities', 'active', '2025-11-08 12:18:58', '2025-11-08 12:18:58', NULL, NULL),
(417, 'rosario-cte-ofc', '$2y$10$4M5WJseKVbAKjnucL.GANO6tHnCPsoTSmfOY44HY79UXFx5Ew/wXe', 'rosario-cte-ofc', 'user', 'Rosario', 'College of Teacher Education', 'active', '2025-11-08 12:19:21', '2025-11-08 12:19:21', NULL, NULL),
(418, 'mabini-sd-ofc', '$2y$10$jt7/UB/BDkEuEGVSjypROurbE9pICCjcp01lz0CR/lTvgfBUV8HIO', 'mabini-sd-ofc', 'user', 'Mabini', 'Student Discipline', 'active', '2025-11-08 12:19:31', '2025-11-08 12:19:31', NULL, NULL),
(419, 'rosario-ce-ofc', '$2y$10$Gcxy8fiLKXxo9J.UCqCNxebP3xz2nFPdf6ayujbYjIRWHJ/wVEUYC', 'rosario-ce-ofc', 'user', 'Rosario', 'College of Engineering', 'active', '2025-11-08 12:19:39', '2025-11-08 12:19:39', NULL, NULL),
(420, 'mabini-sad-ofc', '$2y$10$PKpJdhZK9CvciwMXCVWQwePmnHPuOUAS1ETSRRpiPtLi2OpQjrJ7W', 'mabini-sad-ofc', 'user', 'Mabini', 'Sports and Development', 'active', '2025-11-08 12:49:56', '2025-11-08 12:49:56', NULL, NULL),
(421, 'mabini-ojt-ofc', '$2y$10$NvJnxTWm39wx3HPHKAkgT.Kn4RT9Eux0.TasgvK1dFzhTaDqCMdju', 'mabini-ojt-ofc', 'user', 'Mabini', 'OJT', 'active', '2025-11-08 12:50:22', '2025-11-08 12:50:22', NULL, NULL),
(422, 'mabini-nstp-ofc', '$2y$10$v./6DTVwSzd2qT1sKzmrpOVxpT2UswjSbFYNtBzAqLFJ74wpEx922', 'mabini-nstp-ofc', 'user', 'Mabini', 'National Service Training Program', 'active', '2025-11-08 12:50:47', '2025-11-08 12:50:47', NULL, NULL),
(423, 'mabini-hrmo-ofc', '$2y$10$.7Gvz065QpxClBZV0J1LbOBD4NtaKSTpvtkaiZnlIp7phUy7qs0yS', 'mabini-hrmo-ofc', 'user', 'Mabini', 'Human Resource Management', 'active', '2025-11-08 12:51:07', '2025-11-08 12:51:07', NULL, NULL),
(424, 'mabini-rm-ofc', '$2y$10$fi1yK/b3brEjR8my.njqg..8.Wo/lBwSllUFBHXHbVc8rz1J/m1Zy', 'mabini-rm-ofc', 'user', 'Mabini', 'Records Management', 'active', '2025-11-08 12:51:30', '2025-11-08 12:51:30', NULL, NULL),
(425, 'mabini-pcr-ofc', '$2y$10$j11PRk.MTSohOOb7Qx2d.u3V0vgM.NMBCyrOEXaBzK6XbITbjLc1C', 'mabini-pcr-ofc', 'user', 'Mabini', 'Procurement', 'active', '2025-11-08 12:51:55', '2025-11-08 12:51:55', NULL, NULL),
(426, 'mabini-bdgt-ofc', '$2y$10$qbYEnrHI/Nhpz143M0dGTOWBgMpB.doY4StmRuSFNwqrhgPtkDlfK', 'mabini-bdgt-ofc', 'user', 'Mabini', 'Budget office', 'active', '2025-11-08 12:52:22', '2025-11-08 12:52:22', NULL, NULL),
(427, 'mabini-cd-ofc', '$2y$10$aN7UtVa9OuvgkdIhQTCZXuCU8.dMtmQYR5.xC/nwVdqL04zEkUzv.', 'mabini-cd-ofc', 'user', 'Mabini', 'Cashiering/Disbursing', 'active', '2025-11-08 12:52:47', '2025-11-08 12:52:47', NULL, NULL),
(428, 'mabini-pfm-ofc', '$2y$10$9Z14sdjBCvqFjyliHeCn2eUvy1FElFv8hvPwWl8LEX7pSMrFf9CjW', 'mabini-pfm-ofc', 'user', 'Mabini', 'Project Facilities and Management', 'active', '2025-11-08 12:53:13', '2025-11-08 12:53:13', NULL, NULL),
(429, 'mabini-emu-ofc', '$2y$10$IrvZHZsehV3d/aGoUu/roumPAkRUxSvB4dhHN0974GwLCh5/7xmmS', 'mabini-emu-ofc', 'user', 'Mabini', 'Environment Management Unit', 'active', '2025-11-08 12:53:37', '2025-11-08 12:53:37', NULL, NULL),
(430, 'mabini-psm-ofc', '$2y$10$hXHMVS0uvm9cCjvOIdUjBexxqXW8n98yrycf9KHJN5moZsr.thrIi', 'mabini-psm-ofc', 'user', 'Mabini', 'Property and Supply Management', 'active', '2025-11-08 12:54:04', '2025-11-08 12:54:04', NULL, NULL),
(431, 'mabini-gso-ofc', '$2y$10$7u/056qYPIWLghwrTz2jreY9bX/EvTz3wTuBUZFopxMnJKG7zrDfi', 'mabini-gso-ofc', 'user', 'Mabini', 'General Services', 'active', '2025-11-08 12:54:31', '2025-11-08 12:54:31', NULL, NULL),
(432, 'mabini-ext-ofc', '$2y$10$nPHYXYtlevWC7FtPRhrzqOs5Qy5dCZYclyIk30utd5xL13turrl7K', 'mabini-ext-ofc', 'user', 'Mabini', 'Extension', 'active', '2025-11-08 12:54:56', '2025-11-08 12:54:56', NULL, NULL),
(433, 'mabini-rsch-ofc', '$2y$10$JorZcRJ7klRwdOT6T8j1OuSy74CtL/1rKWizMTeXMFjWDIWBw5bZO', 'mabini-rsch-ofc', 'user', 'Mabini', 'Research', 'active', '2025-11-08 12:55:31', '2025-11-08 12:55:31', NULL, NULL),
(434, 'mabini-hs-ofc', '$2y$10$Hk2ySVfxosPLHdUuosOwneFoK6dpq0wRkiH2138pUnA0iR/irpSTq', 'mabini-hs-ofc', 'user', 'Mabini', 'Health Services', 'active', '2025-11-08 12:55:55', '2025-11-08 12:55:55', NULL, NULL),
(435, 'rosario-ca-ofc', '$2y$10$E4tEN7sv.XM8NcpdC7rGXOI8T/b0Pet/jED55MIy9aihhapfYJ9iu', 'rosario-ca-ofc', 'user', 'Rosario', 'Culture and Arts', 'active', '2025-11-08 13:36:58', '2025-11-08 13:36:58', NULL, NULL),
(436, 'rosario-tao-ofc', '$2y$10$Ow0SAFMuAwSO3lljuXGJkue9CqsqwLDXm2K5OA4ogpQigQ.Q59eSO', 'rosario-tao-ofc', 'user', 'Rosario', 'Testing and Admission', 'active', '2025-11-08 13:37:26', '2025-11-08 13:37:26', NULL, NULL),
(437, 'rosario-rs-ofc', '$2y$10$SBPOxHB7BNWxvbxapU/6YOjYo5e/Oghb4LVdsoItaBP8MWqcgcQji', 'rosario-rs-ofc', 'user', 'Rosario', 'Registration Services', 'active', '2025-11-08 13:37:45', '2025-11-08 13:37:45', NULL, NULL),
(438, 'rosario-sfa-ofc', '$2y$10$gAPpbou/g0y8kbNpUVbnO.we7kXF1MNtAbDnL84QW3seuoJDI0lqG', 'rosario-sfa-ofc', 'user', 'Rosario', 'Scholarship and Financial Assistance', 'active', '2025-11-08 13:37:59', '2025-11-08 13:37:59', NULL, NULL),
(439, 'rosario-gc-ofc', '$2y$10$rHm8s3s7EwDeqGaZGcPpfunt/yDcXWCiC.EvxNCukV1ES4K6Y1HMu', 'rosario-gc-ofc', 'user', 'Rosario', 'Guidance and Counseling', 'active', '2025-11-08 13:38:11', '2025-11-08 13:38:11', NULL, NULL),
(440, 'rosario-soa-ofc', '$2y$10$w0m6I0QWho1eow4nGIIfMeDDvi5lP3DCsxgTSoM1m7B5FLVysRyFC', 'rosario-soa-ofc', 'user', 'Rosario', 'Student Organization and Activities', 'active', '2025-11-08 13:38:33', '2025-11-08 13:38:33', NULL, NULL),
(441, 'rosario-sd-ofc', '$2y$10$SOTsdUknUz4zD71mH2.mcugDw.kiD2YhuHSIBouz3VKEYzrQJ/FEm', 'rosario-sd-ofc', 'user', 'Rosario', 'Student Discipline', 'active', '2025-11-08 13:38:44', '2025-11-08 13:38:44', NULL, NULL),
(442, 'rosario-sad-ofc', '$2y$10$ZQIeA6rwkoXrsB2uAg5E2uCPmFz3AvyhUMOjUyxulF6dPq7fzqNae', 'rosario-sad-ofc', 'user', 'Rosario', 'Sports and Development', 'active', '2025-11-08 13:39:02', '2025-11-08 13:39:02', NULL, NULL),
(443, 'rosario-ojt-ofc', '$2y$10$JJMEvW7h9/mGozgiB7N50e7Dq.IhvJ5NrscYLaqnNLwmmCPfKNH0a', 'rosario-ojt-ofc', 'user', 'Rosario', 'OJT', 'active', '2025-11-08 13:39:17', '2025-11-08 13:39:17', NULL, NULL),
(444, 'rosario-nstp-ofc', '$2y$10$J7uWqWI4APi3EM0vNz.rCOWz983N/tUV2o75lF.Kdrl1ypPmeWpka', 'rosario-nstp-ofc', 'user', 'Rosario', 'National Service Training Program', 'active', '2025-11-08 13:39:30', '2025-11-08 13:39:30', NULL, NULL),
(445, 'rosario-hrmo-ofc', '$2y$10$UfEl2l62ZwegNlHUFscgB.kTc7tE6kdeec69LlQqVbZFpvXxsVK8O', 'rosario-hrmo-ofc', 'user', 'Rosario', 'Human Resource Management', 'active', '2025-11-08 13:39:47', '2025-11-08 13:39:47', NULL, NULL),
(446, 'rosario-rm-ofc', '$2y$10$2Rp2IIFmFREb8DjgFx9RF.RewasJSJgJfoOfJNgmdRvvObhoYl2fW', 'rosario-rm-ofc', 'user', 'Rosario', 'Records Management', 'active', '2025-11-08 13:40:11', '2025-11-08 13:40:11', NULL, NULL),
(447, 'rosario-pcr-ofc', '$2y$10$p5nn.NqgprUeS5p7q3zo0.WBrZxoV5a.DkTmcJiGADq.oKgV16bUG', 'rosario-pcr-ofc', 'user', 'Rosario', 'Procurement', 'active', '2025-11-08 13:40:32', '2025-11-08 13:40:32', NULL, NULL),
(448, 'rosario-bdgt-ofc', '$2y$10$sMNyHcE09VHWTnXR9Aw40OJrfGdvR5q.piQzqk8wUhCCkQpUT5L4m', 'rosario-bdgt-ofc', 'user', 'Rosario', 'Budget office', 'active', '2025-11-08 13:40:59', '2025-11-08 13:40:59', NULL, NULL),
(449, 'rosario-cd-ofc', '$2y$10$JrGQpE9DlC0KDQ3LpEwROeC/3Hb0oBtREpclnLNwMRMDNO2Ucodki', 'rosario-cd-ofc', 'user', 'Rosario', 'Cashiering/Disbursing', 'active', '2025-11-08 13:41:16', '2025-11-08 13:41:16', NULL, NULL),
(450, 'rosario-pfm-ofc', '$2y$10$rqXKN.k3LHx7BsRrm2eRKefcQTQyGG.xB5P83.huyzRovkaabRWtG', 'rosario-pfm-ofc', 'user', 'Rosario', 'Project Facilities and Management', 'active', '2025-11-08 13:41:35', '2025-11-08 13:41:35', NULL, NULL),
(451, 'rosario-emu-ofc', '$2y$10$DnR/R9RgZZlWps1Zpw5oYu.RxyTUe3pg4igBWdshc8lKDH6jKXgFe', 'rosario-emu-ofc', 'user', 'Rosario', 'Environment Management Unit', 'active', '2025-11-08 13:41:54', '2025-11-08 13:41:54', NULL, NULL),
(452, 'rosario-psm-ofc', '$2y$10$CQFtN5dD6G1oDTJSXup4z.IBsU6PP0xViwGSwJIpspvIjXHkGIXFC', 'rosario-psm-ofc', 'user', 'Rosario', 'Property and Supply Management', 'active', '2025-11-08 13:42:09', '2025-11-08 13:42:09', NULL, NULL),
(453, 'rosario-gso-ofc', '$2y$10$/WbXbZmjhZD3wbqK/BDQR.kbltheQpJMRFWYoeWIiZ/..eSfZkqqy', 'rosario-gso-ofc', 'user', 'Rosario', 'General Services', 'active', '2025-11-08 13:42:27', '2025-11-08 13:42:27', NULL, NULL),
(454, 'rosario-ext-ofc', '$2y$10$r6jteFIdFMYJvqGNgSg/0u5pwC0rEiIMk9T/fm9C9qvAGWuS.Yti6', 'rosario-ext-ofc', 'user', 'Rosario', 'Extension', 'active', '2025-11-08 13:42:44', '2025-11-08 13:42:44', NULL, NULL),
(455, 'rosario-rsch-ofc', '$2y$10$8Sa0TeQB/1m/82OQlozGF.pyKA8L08AYrVZpECC9XeDN8hdl6W.M.', 'rosario-rsch-ofc', 'user', 'Rosario', 'Research', 'active', '2025-11-08 13:42:58', '2025-11-08 13:42:58', NULL, NULL),
(456, 'rosario-hs-ofc', '$2y$10$aNtlp2fKDyPZwHws.P7FEe8RlU3wghPeZF4GST6DmIFi/diIWTUVq', 'rosario-hs-ofc', 'user', 'Rosario', 'Health Services', 'active', '2025-11-08 13:43:15', '2025-11-08 13:48:28', '2025-11-08 13:48:28', NULL),
(457, 'super-admin', '$2y$10$xY.Y5A9tKhAdxIIMO3ObZOkIKuRA2c1Og1ebYcuFuAivo2YclJg7G', 'super-admin', 'super_admin', 'Main Campus', '', 'active', '2025-11-08 14:01:26', '2025-11-19 02:58:47', '2025-11-19 02:58:47', NULL),
(458, 'lobo-pfm-ofc', '$2y$10$C3xN9IB/ljllE/WxwiO86e1op2HP12mj2KEOER4Lcr5B4h69RYEF6', 'lobo-pfm-ofc', 'user', 'Lobo', 'Project Facilities and Management', 'active', '2025-11-14 08:59:16', '2025-11-14 08:59:33', NULL, NULL),
(459, 'lipa-rs-ofc', '$2y$10$2YeqP0KbeF0Z3jknlRrS1u5ZbqJyvOR21zy5nyxSIi5o0U3j0l7b6', 'lipa-rs-ofc', 'user', 'Lipa', 'Registration Services', 'active', '2025-11-15 16:09:38', '2025-11-15 16:09:38', NULL, NULL),
(460, 'lipa-ls-ofc', '$2y$10$j7bJFlJSLBHP8KpwKYKqPuL1ucz/Xj8l8OjGTp/KGLSBlHH5Oec3S', 'lipa-ls-ofc', 'user', 'Lipa', 'Library Services', 'active', '2025-11-15 16:15:56', '2025-11-15 16:15:56', NULL, NULL),
(461, 'alngln-ls-ofc', '$2y$10$F0CaYLKn/JIeoqSupTNjpONF18dPblnifQ5zVUWxwjT5TIrEkOlom', 'alngln-ls-ofc', 'user', 'Alangilan', 'Library Services', 'active', '2025-11-15 16:17:34', '2025-11-15 16:17:34', NULL, NULL),
(462, 'pb-ls-ofc', '$2y$10$tK9cRojM.kBtD1tJ/dbhTeh0WHMJzCTYO718kjYjC6bEm8DCQmBD6', 'pb-ls-ofc', 'user', 'Pablo Borbon', 'Library Services', 'active', '2025-11-15 16:18:52', '2025-11-15 16:18:52', NULL, NULL),
(463, 'nsb-ls-ofc', '$2y$10$PGFmt5fO/71wNfZsIkfIw.6PrhBrrG1jF9AIYzrGlY3pvEyTN4RBq', 'nsb-ls-ofc', 'user', 'Nasugbu', 'Library Services', 'active', '2025-11-15 16:20:30', '2025-11-15 16:20:30', NULL, NULL),
(464, 'balayan-ls-ofc', '$2y$10$OadoRM4vTShgTBbWUiprueLs5gkwJWZGR3H9on0Mzb0NnkZ2z8ynS', 'balayan-ls-ofc', 'user', 'Balayan', 'Library Services', 'active', '2025-11-15 16:22:01', '2025-11-15 16:22:01', NULL, NULL),
(465, 'malvar-ls-ofc', '$2y$10$ENbo/cKEK4c6tNhS9onw9uqthlNbeNvZza7QXS/u49BiOjwi4KAMy', 'malvar-ls-ofc', 'user', 'Malvar', 'Library Services', 'active', '2025-11-15 16:23:26', '2025-11-15 16:23:26', NULL, NULL),
(466, 'lemery-ls-ofc', '$2y$10$D7eR5qlLKWT0wMOI3JK6Uu7J808tySJcqk/4Ck4zl4gWcCgDdIobC', 'lemery-ls-ofc', 'user', 'Lemery', 'Library Services', 'active', '2025-11-15 16:24:58', '2025-11-15 16:33:29', '2025-11-15 16:33:29', NULL),
(467, 'lobo-ls-ofc', '$2y$10$3/N08vTLORo5IT8sQ05K1OSkYxe64BfQ.FOQ3k0TLB4eqRGAyMPuO', 'lobo-ls-ofc', 'user', 'Lobo', 'Library Services', 'active', '2025-11-15 16:26:34', '2025-11-15 16:26:34', NULL, NULL),
(468, 'mabini-ls-ofc', '$2y$10$yXSuN44HHqWtsWcyjAbb0uyngV4mo0coeSbB58kFTB67JQMVL5hba', 'mabini-ls-ofc', 'user', 'Mabini', 'Library Services', 'active', '2025-11-15 16:28:28', '2025-11-15 16:28:28', NULL, NULL),
(469, 'rosario-ls-ofc', '$2y$10$kWnwjBgBPhJIpyAy8crbreQTGwILCef07M1ObB.JucVI8XmcgekfS', 'rosario-ls-ofc', 'user', 'Rosario', 'Library Services', 'active', '2025-11-15 16:29:31', '2025-11-15 16:29:31', NULL, NULL),
(470, 'sj-ls-ofc', '$2y$10$OXqAh22npHMbteosQlfrwOUu.nvBPWh89WRMtfubfYXudbFkj6L7u', 'sj-ls-ofc', 'user', 'San Juan', 'Library Services', 'active', '2025-11-15 16:30:56', '2025-11-15 16:30:56', NULL, NULL),
(471, 'lima-admin-acc', '$2y$10$xFMBxxLyn8q0KfPDWkY7fuV95TxKET9.dT8J2iNmv8pCzKDHHHmVi', 'lima-admin-acc', 'admin', 'Lima', '', 'active', '2025-11-26 14:29:24', '2025-11-27 14:14:18', '2025-11-27 14:14:18', NULL),
(472, 'lima-rgtr-ofc', '$2y$10$TTD40sfti6XUYoVpKS9Jfuzi0xzB8hJPnhphdHPg2nhuUL/LDceom', 'lima-rgtr-ofc', 'user', 'Lima', 'Registration Services', 'active', '2025-11-26 14:34:23', '2025-11-26 14:35:49', '2025-11-26 14:35:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `waterconsumption`
--

CREATE TABLE `waterconsumption` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `date` date DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `prev_reading` decimal(10,2) DEFAULT 0.00,
  `current_reading` decimal(10,2) DEFAULT 0.00,
  `quantity_m3` decimal(10,2) DEFAULT 0.00,
  `total_amount` decimal(10,2) DEFAULT 0.00,
  `price_per_m3` decimal(10,2) DEFAULT 0.00,
  `month` varchar(20) DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `batch_id` varchar(100) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `waterconsumption`
--

INSERT INTO `waterconsumption` (`id`, `campus`, `date`, `category`, `prev_reading`, `current_reading`, `quantity_m3`, `total_amount`, `price_per_m3`, `month`, `year`, `remarks`, `batch_id`, `submitted_by`, `submitted_at`, `created_at`, `updated_at`) VALUES
(20, 'Lobo', '2025-11-13', 'Deep Well', 1001.00, 1200.00, 199.00, 5970.00, 30.00, 'January', '2023', 'None', '20251117135815_691ab97770332_RESOURCE GENERATION', 0, '2025-11-17 05:58:15', '2025-11-17 05:58:15', '2025-11-17 05:58:15'),
(21, 'Mabini', '2025-11-17', 'Deep Well', 1000.00, 200.00, 800.00, 25600.00, 32.00, 'January', '2023', 'None', '20251117140041_691aba09dcbb0_RESOURCE GENERATION', 0, '2025-11-17 06:00:41', '2025-11-17 06:00:41', '2025-11-17 06:00:41'),
(22, 'Balayan', '2025-11-17', 'Deep Well', 2000.00, 1800.00, 200.00, 6400.00, 32.00, 'January', '2023', 'None', '20251117140217_691aba69a8fbf_RESOURCE GENERATION', 0, '2025-11-17 06:02:17', '2025-11-17 06:02:17', '2025-11-17 06:02:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `admissiondata`
--
ALTER TABLE `admissiondata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `budgetexpenditure`
--
ALTER TABLE `budgetexpenditure`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `campuspopulation`
--
ALTER TABLE `campuspopulation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `dashboard_stats`
--
ALTER TABLE `dashboard_stats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_submissions`
--
ALTER TABLE `data_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`),
  ADD KEY `reviewed_by` (`reviewed_by`),
  ADD KEY `idx_office` (`assigned_office`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `distancetraveled`
--
ALTER TABLE `distancetraveled`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `drafts`
--
ALTER TABLE `drafts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `electricityconsumption`
--
ALTER TABLE `electricityconsumption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `enrollmentdata`
--
ALTER TABLE `enrollmentdata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `flightaccommodation`
--
ALTER TABLE `flightaccommodation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `foodwaste`
--
ALTER TABLE `foodwaste`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `fuelconsumption`
--
ALTER TABLE `fuelconsumption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `graduatesdata`
--
ALTER TABLE `graduatesdata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `leaveprivilege`
--
ALTER TABLE `leaveprivilege`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `libraryvisitor`
--
ALTER TABLE `libraryvisitor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `pwd`
--
ALTER TABLE `pwd`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `report_assignments`
--
ALTER TABLE `report_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_by` (`assigned_by`);

--
-- Indexes for table `report_submissions`
--
ALTER TABLE `report_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_id` (`assignment_id`),
  ADD KEY `submitted_by` (`submitted_by`),
  ADD KEY `reviewed_by` (`reviewed_by`);

--
-- Indexes for table `report_submission_data`
--
ALTER TABLE `report_submission_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_id` (`submission_id`);

--
-- Indexes for table `solidwaste`
--
ALTER TABLE `solidwaste`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `table_assignments`
--
ALTER TABLE `table_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_by` (`assigned_by`),
  ADD KEY `idx_office` (`assigned_office`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_deadline` (`deadline`),
  ADD KEY `idx_priority` (`priority`),
  ADD KEY `idx_has_deadline` (`has_deadline`);

--
-- Indexes for table `treatedwastewater`
--
ALTER TABLE `treatedwastewater`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_office` (`office`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_id` (`session_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Indexes for table `waterconsumption`
--
ALTER TABLE `waterconsumption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_campus` (`campus`),
  ADD KEY `idx_batch` (`batch_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1689;

--
-- AUTO_INCREMENT for table `admissiondata`
--
ALTER TABLE `admissiondata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `budgetexpenditure`
--
ALTER TABLE `budgetexpenditure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `campuspopulation`
--
ALTER TABLE `campuspopulation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `dashboard_stats`
--
ALTER TABLE `dashboard_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `data_submissions`
--
ALTER TABLE `data_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `distancetraveled`
--
ALTER TABLE `distancetraveled`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `drafts`
--
ALTER TABLE `drafts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `electricityconsumption`
--
ALTER TABLE `electricityconsumption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `enrollmentdata`
--
ALTER TABLE `enrollmentdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `flightaccommodation`
--
ALTER TABLE `flightaccommodation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `foodwaste`
--
ALTER TABLE `foodwaste`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `fuelconsumption`
--
ALTER TABLE `fuelconsumption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `graduatesdata`
--
ALTER TABLE `graduatesdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `leaveprivilege`
--
ALTER TABLE `leaveprivilege`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `libraryvisitor`
--
ALTER TABLE `libraryvisitor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pwd`
--
ALTER TABLE `pwd`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `report_assignments`
--
ALTER TABLE `report_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=317;

--
-- AUTO_INCREMENT for table `report_submissions`
--
ALTER TABLE `report_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=328;

--
-- AUTO_INCREMENT for table `report_submission_data`
--
ALTER TABLE `report_submission_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=328;

--
-- AUTO_INCREMENT for table `solidwaste`
--
ALTER TABLE `solidwaste`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `table_assignments`
--
ALTER TABLE `table_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=521;

--
-- AUTO_INCREMENT for table `treatedwastewater`
--
ALTER TABLE `treatedwastewater`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=473;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `waterconsumption`
--
ALTER TABLE `waterconsumption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `data_submissions`
--
ALTER TABLE `data_submissions`
  ADD CONSTRAINT `data_submissions_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `data_submissions_ibfk_2` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `drafts`
--
ALTER TABLE `drafts`
  ADD CONSTRAINT `drafts_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `report_assignments`
--
ALTER TABLE `report_assignments`
  ADD CONSTRAINT `report_assignments_ibfk_1` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `report_submissions`
--
ALTER TABLE `report_submissions`
  ADD CONSTRAINT `report_submissions_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `report_assignments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `report_submissions_ibfk_2` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `report_submissions_ibfk_3` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `report_submission_data`
--
ALTER TABLE `report_submission_data`
  ADD CONSTRAINT `report_submission_data_ibfk_1` FOREIGN KEY (`submission_id`) REFERENCES `report_submissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `table_assignments`
--
ALTER TABLE `table_assignments`
  ADD CONSTRAINT `table_assignments_ibfk_1` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

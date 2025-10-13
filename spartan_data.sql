-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 13, 2025 at 09:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spartan_data`
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

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-09 18:23:52'),
(2, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-09 23:56:55'),
(3, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-10 00:00:31'),
(4, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-10 00:00:35'),
(5, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-10 00:04:04'),
(6, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-10 00:04:06'),
(7, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-10 00:04:06'),
(8, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-10 00:04:06'),
(9, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-10 00:04:07'),
(10, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 12:49:57'),
(11, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 12:52:25'),
(12, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 12:57:34'),
(13, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:01:43'),
(14, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:11:27'),
(15, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:11:28'),
(16, 13, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:11:48'),
(17, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:14:57'),
(18, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:00'),
(19, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:01'),
(20, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:01'),
(21, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:01'),
(22, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:02'),
(23, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:02'),
(24, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:02'),
(25, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:03'),
(26, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:03'),
(27, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:03'),
(28, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:15:03'),
(29, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:20:38'),
(30, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:26:10'),
(31, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:33:02'),
(32, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:35:44'),
(33, 2, 'login_failed', 'Invalid password', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-10 13:35:47');

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

--
-- Dumping data for table `dashboard_stats`
--

INSERT INTO `dashboard_stats` (`id`, `stat_name`, `stat_value`, `stat_type`, `updated_at`) VALUES
(1, 'total_users', '24', 'number', '2025-10-09 18:08:53'),
(2, 'data_records', '0', 'number', '2025-10-09 18:08:53'),
(3, 'growth_rate', '0', 'percentage', '2025-10-09 18:08:53'),
(4, 'security_score', '100', 'percentage', '2025-10-09 18:08:53'),
(5, 'system_uptime', '99.9', 'percentage', '2025-10-09 18:08:53'),
(6, 'response_time', '245', 'number', '2025-10-09 18:08:53');

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
  `traveler` varchar(255) DEFAULT NULL,
  `purpose` text DEFAULT NULL,
  `from_location` varchar(200) DEFAULT NULL,
  `to_location` varchar(200) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `rooms` int(11) DEFAULT 0,
  `nights` int(11) DEFAULT 0,
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
-- Table structure for table `pwd`
--

CREATE TABLE `pwd` (
  `id` int(11) NOT NULL,
  `campus` varchar(100) NOT NULL,
  `year` varchar(10) DEFAULT NULL,
  `disability_type` varchar(100) DEFAULT NULL,
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
  `assignment_id` int(11) NOT NULL,
  `report_type` varchar(255) NOT NULL,
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
(5, 'maintenance_mode', '0', 'System maintenance mode (0=off, 1=on)', '2025-10-09 18:08:53', '2025-10-09 18:08:53');

-- --------------------------------------------------------

--
-- Table structure for table `table_assignments`
--

CREATE TABLE `table_assignments` (
  `id` int(11) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `assigned_office` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `assigned_by` int(11) NOT NULL,
  `assigned_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('active','completed','cancelled') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'superadmin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Super Administrator', 'super_admin', 'Main Campus', 'Administration', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(2, 'admin-lipa', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Lipa Campus Admin', 'admin', 'Lipa', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(3, 'admin-pablo-borbon', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Pablo Borbon Campus Admin', 'admin', 'Pablo Borbon', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(4, 'admin-alangilan', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Alangilan Campus Admin', 'admin', 'Alangilan', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(5, 'admin-rosario', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Rosario Campus Admin', 'admin', 'Rosario', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(6, 'admin-san-juan', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'San Juan Campus Admin', 'admin', 'San Juan', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(7, 'admin-lemery', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Lemery Campus Admin', 'admin', 'Lemery', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(8, 'admin-lobo', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Lobo Campus Admin', 'admin', 'Lobo', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(9, 'admin-balayan', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Balayan Campus Admin', 'admin', 'Balayan', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(10, 'admin-mabini', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Mabini Campus Admin', 'admin', 'Mabini', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(11, 'admin-malvar', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Malvar Campus Admin', 'admin', 'Malvar', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(12, 'admin-nasugbu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Nasugbu Campus Admin', 'admin', 'Nasugbu', 'Campus Office', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(13, 'emu-lipa-sdo', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'EMU Office - Lipa SDO', 'user', 'Lipa', 'EMU', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(14, 'emu-san-juan', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'EMU Office - San Juan', 'user', 'San Juan', 'EMU', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(15, 'registrar-pablo-borbon', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Registrar - Pablo Borbon', 'user', 'Pablo Borbon', 'Registrar', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(16, 'registrar-lipa', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Registrar - Lipa', 'user', 'Lipa', 'Registrar', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(17, 'hrmo-alangilan', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'HRMO - Alangilan', 'user', 'Alangilan', 'HRMO', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(18, 'accounting-rosario', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Accounting - Rosario', 'user', 'Rosario', 'Accounting', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(19, 'library-lemery', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Library - Lemery', 'user', 'Lemery', 'Library', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(20, 'guidance-lobo', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Guidance - Lobo', 'user', 'Lobo', 'Guidance', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(21, 'cashier-balayan', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Cashier - Balayan', 'user', 'Balayan', 'Cashier', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(22, 'supply-mabini', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Supply Office - Mabini', 'user', 'Mabini', 'Supply', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(23, 'ict-malvar', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ICT Office - Malvar', 'user', 'Malvar', 'ICT', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL),
(24, 'research-nasugbu', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Research Office - Nasugbu', 'user', 'Nasugbu', 'Research', 'active', '2025-10-09 18:08:53', '2025-10-09 18:08:53', NULL, NULL);

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
  ADD KEY `idx_status` (`status`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `admissiondata`
--
ALTER TABLE `admissiondata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budgetexpenditure`
--
ALTER TABLE `budgetexpenditure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `campuspopulation`
--
ALTER TABLE `campuspopulation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `drafts`
--
ALTER TABLE `drafts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `electricityconsumption`
--
ALTER TABLE `electricityconsumption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `enrollmentdata`
--
ALTER TABLE `enrollmentdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flightaccommodation`
--
ALTER TABLE `flightaccommodation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `foodwaste`
--
ALTER TABLE `foodwaste`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fuelconsumption`
--
ALTER TABLE `fuelconsumption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `graduatesdata`
--
ALTER TABLE `graduatesdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leaveprivilege`
--
ALTER TABLE `leaveprivilege`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `libraryvisitor`
--
ALTER TABLE `libraryvisitor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pwd`
--
ALTER TABLE `pwd`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_assignments`
--
ALTER TABLE `report_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_submissions`
--
ALTER TABLE `report_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `solidwaste`
--
ALTER TABLE `solidwaste`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `table_assignments`
--
ALTER TABLE `table_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `treatedwastewater`
--
ALTER TABLE `treatedwastewater`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `waterconsumption`
--
ALTER TABLE `waterconsumption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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

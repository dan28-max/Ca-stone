-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 27, 2025 at 03:46 PM
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

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(170, 1, 'table_assignment', 'Assigned admissiondata table to RGO Lipa', NULL, '2001:4453:332:ea00:f0e7:55a0:adaa:77ea', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-04 15:24:02'),
(171, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:537:9522:99b3:921d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:36:19'),
(172, NULL, 'table_assignment', 'Assigned admissiondata table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(173, NULL, 'table_assignment', 'Assigned admissiondata table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(174, NULL, 'table_assignment', 'Assigned enrollmentdata table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(175, NULL, 'table_assignment', 'Assigned enrollmentdata table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(176, NULL, 'table_assignment', 'Assigned graduatesdata table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(177, NULL, 'table_assignment', 'Assigned graduatesdata table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(178, NULL, 'table_assignment', 'Assigned employee table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(179, NULL, 'table_assignment', 'Assigned employee table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(180, NULL, 'table_assignment', 'Assigned leaveprivilege table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(181, NULL, 'table_assignment', 'Assigned leaveprivilege table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(182, NULL, 'table_assignment', 'Assigned libraryvisitor table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(183, NULL, 'table_assignment', 'Assigned libraryvisitor table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(184, NULL, 'table_assignment', 'Assigned pwd table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(185, NULL, 'table_assignment', 'Assigned pwd table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(186, NULL, 'table_assignment', 'Assigned waterconsumption table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(187, NULL, 'table_assignment', 'Assigned waterconsumption table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(188, NULL, 'table_assignment', 'Assigned treatedwastewater table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(189, NULL, 'table_assignment', 'Assigned treatedwastewater table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(190, NULL, 'table_assignment', 'Assigned electricityconsumption table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(191, NULL, 'table_assignment', 'Assigned electricityconsumption table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:47'),
(192, NULL, 'table_assignment', 'Assigned solidwaste table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(193, NULL, 'table_assignment', 'Assigned solidwaste table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(194, NULL, 'table_assignment', 'Assigned campuspopulation table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(195, NULL, 'table_assignment', 'Assigned campuspopulation table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(196, NULL, 'table_assignment', 'Assigned foodwaste table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(197, NULL, 'table_assignment', 'Assigned foodwaste table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(198, NULL, 'table_assignment', 'Assigned fuelconsumption table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(199, NULL, 'table_assignment', 'Assigned fuelconsumption table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(200, NULL, 'table_assignment', 'Assigned distancetraveled table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(201, NULL, 'table_assignment', 'Assigned distancetraveled table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(202, NULL, 'table_assignment', 'Assigned budgetexpenditure table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(203, NULL, 'table_assignment', 'Assigned budgetexpenditure table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(204, NULL, 'table_assignment', 'Assigned flightaccommodation table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(205, NULL, 'table_assignment', 'Assigned flightaccommodation table to RGO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:41:48'),
(206, NULL, 'report_submission', 'Submitted report: Solid Waste (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:42:55'),
(207, NULL, 'report_submission', 'Submitted report: Food Waste (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:44:03'),
(208, NULL, 'user_updated', 'Updated user: lipa-gso (lipa-gso)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:44:38'),
(209, NULL, 'user_updated', 'Updated user: lipa-gso (lipa-gso)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:44:42'),
(210, NULL, 'user_updated', 'Updated user: lipa-gso (lipa-gso)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:44:48'),
(211, NULL, 'user_updated', 'Updated user: lipa-rgo (lipa-rgo)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:45:03'),
(212, NULL, 'report_submission', 'Submitted report: Fuel Consumption (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:45:10'),
(213, NULL, 'report_submission', 'Submitted report: Distance Traveled (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:46:23'),
(214, NULL, 'report_submission', 'Submitted report: Budget Expenditure (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:46:39'),
(215, NULL, 'report_submission', 'Submitted report: Flight Accommodation (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:47:21'),
(216, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:47:38'),
(217, NULL, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:48:14'),
(218, NULL, 'user_updated', 'Updated user: lipa-rgo (lipa-rgo)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:48:15'),
(219, NULL, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:49:06'),
(220, NULL, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:49:50'),
(221, NULL, 'user_updated', 'Updated user: lipa-rgo (lipa-rgo)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:50:01'),
(222, NULL, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:50:15'),
(223, NULL, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:50:42'),
(224, NULL, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 15:50:58'),
(225, NULL, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:19:57'),
(226, NULL, 'report_submission', 'Submitted report: Treated Waste Water (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:21:03'),
(227, NULL, 'report_submission', 'Submitted report: Electricity Consumption (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:21:23'),
(228, NULL, 'report_submission', 'Submitted report: Solid Waste (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:14'),
(229, NULL, 'report_submission', 'Submitted report: Food Waste (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:30'),
(230, NULL, 'report_submission', 'Submitted report: Fuel Consumption (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:52'),
(231, NULL, 'table_assignment', 'Assigned employee table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(232, NULL, 'table_assignment', 'Assigned employee table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(233, NULL, 'table_assignment', 'Assigned admissiondata table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(234, NULL, 'table_assignment', 'Assigned admissiondata table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(235, NULL, 'table_assignment', 'Assigned enrollmentdata table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(236, NULL, 'table_assignment', 'Assigned enrollmentdata table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(237, NULL, 'table_assignment', 'Assigned graduatesdata table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(238, NULL, 'table_assignment', 'Assigned graduatesdata table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(239, NULL, 'table_assignment', 'Assigned leaveprivilege table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(240, NULL, 'table_assignment', 'Assigned leaveprivilege table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(241, NULL, 'table_assignment', 'Assigned libraryvisitor table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(242, NULL, 'table_assignment', 'Assigned libraryvisitor table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(243, NULL, 'table_assignment', 'Assigned pwd table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(244, NULL, 'table_assignment', 'Assigned pwd table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(245, NULL, 'table_assignment', 'Assigned waterconsumption table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(246, NULL, 'table_assignment', 'Assigned waterconsumption table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(247, NULL, 'table_assignment', 'Assigned treatedwastewater table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(248, NULL, 'table_assignment', 'Assigned treatedwastewater table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(249, NULL, 'table_assignment', 'Assigned electricityconsumption table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(250, NULL, 'table_assignment', 'Assigned electricityconsumption table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(251, NULL, 'table_assignment', 'Assigned solidwaste table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(252, NULL, 'table_assignment', 'Assigned solidwaste table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(253, NULL, 'table_assignment', 'Assigned campuspopulation table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(254, NULL, 'table_assignment', 'Assigned campuspopulation table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(255, NULL, 'table_assignment', 'Assigned foodwaste table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(256, NULL, 'table_assignment', 'Assigned foodwaste table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(257, NULL, 'table_assignment', 'Assigned fuelconsumption table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(258, NULL, 'table_assignment', 'Assigned fuelconsumption table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(259, NULL, 'table_assignment', 'Assigned distancetraveled table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(260, NULL, 'table_assignment', 'Assigned distancetraveled table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(261, NULL, 'table_assignment', 'Assigned budgetexpenditure table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(262, NULL, 'table_assignment', 'Assigned budgetexpenditure table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(263, NULL, 'table_assignment', 'Assigned flightaccommodation table to GSO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(264, NULL, 'table_assignment', 'Assigned flightaccommodation table to RGO Lipa', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:23:58'),
(265, NULL, 'report_submission', 'Submitted report: Distance Traveled (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:24:13'),
(266, NULL, 'report_submission', 'Submitted report: Budget Expenditure (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:24:46'),
(267, NULL, 'report_submission', 'Submitted report: Flight Accommodation (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:26:17'),
(268, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:26:33'),
(269, NULL, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:26:53'),
(270, NULL, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:27:14'),
(271, NULL, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:27:28'),
(272, NULL, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:27:44'),
(273, NULL, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:28:07'),
(274, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:28:41'),
(275, NULL, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:28:59'),
(276, NULL, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:31:20'),
(277, NULL, 'report_submission', 'Submitted report: Treated Waste Water (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:31:49'),
(278, NULL, 'report_submission', 'Submitted report: Electricity Consumption (1 records)', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:32:03'),
(279, NULL, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:35:52'),
(280, NULL, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:36:36'),
(281, NULL, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:37:06'),
(282, NULL, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:37:27'),
(283, NULL, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2001:4455:8034:c00:a1a2:349d:be74:674', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:40:05'),
(284, 1, 'table_assignment', 'Assigned pwd table to GSO San Juan', NULL, '2405:8d40:4899:c6f8:b167:1037:e8e:4713', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 16:40:34'),
(285, NULL, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '2001:4453:332:ea00:537:9522:99b3:921d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 17:28:59'),
(286, 1, 'table_assignment', 'Assigned admissiondata table to RGO Lipa', NULL, '2001:4453:332:ea00:537:9522:99b3:921d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 18:04:30'),
(287, 1, 'table_assignment', 'Assigned enrollmentdata table to RGO Lipa', NULL, '2001:4453:332:ea00:537:9522:99b3:921d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 18:04:30'),
(288, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:537:9522:99b3:921d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-04 18:45:16'),
(289, 1, 'user_created', 'Created user: sdo-lobo (sdo-lobo) with role: user at campus: Lobo', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:19:05'),
(290, 1, 'user_created', 'Created user: lobo-admin (lobo-admin) with role: admin at campus: Lobo', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:27:08'),
(291, NULL, 'table_assignment', 'Assigned waterconsumption table to Sustainable Development Lobo', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:28:41'),
(292, NULL, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2001:4453:85:0:5d08:5c5d:70d4:1f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:29:33'),
(293, NULL, 'table_assignment', 'Assigned waterconsumption table to Sustainable Development Lobo', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:30:19'),
(294, NULL, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2001:4453:85:0:5d08:5c5d:70d4:1f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:31:22'),
(295, NULL, 'table_assignment', 'Assigned waterconsumption table to Sustainable Development Lobo', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:31:59'),
(296, NULL, 'report_submission', 'Submitted report: Water Consumption (3 records)', NULL, '2001:4453:85:0:5d08:5c5d:70d4:1f5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:38:18'),
(297, NULL, 'table_assignment', 'Assigned campuspopulation table to Sustainable Development Lobo', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:42:19'),
(298, NULL, 'table_assignment', 'Assigned flightaccommodation table to Sustainable Development Lobo', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-05 06:48:28'),
(299, 1, 'table_assignment', 'Assigned admissiondata table to RGO Lipa', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 13:32:05'),
(300, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 13:32:45'),
(301, 1, 'table_assignment', 'Assigned admissiondata table to RGO Lipa', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 13:33:33'),
(302, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 13:34:19'),
(303, 1, 'table_assignment', 'Assigned admissiondata table to RGO Lipa', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 13:44:12'),
(304, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 13:44:57'),
(305, NULL, 'table_assignment', 'Assigned admissiondata table to RGO Lipa', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 14:37:39'),
(306, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 14:38:21'),
(307, 1, 'table_assignment', 'Assigned admissiondata table to RGO Lipa', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 14:45:13'),
(308, 1, 'table_assignment', 'Assigned enrollmentdata table to RGO Lipa', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 15:29:10'),
(309, 1, 'table_assignment', 'Assigned graduatesdata table to RGO Lipa', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 15:46:38'),
(310, NULL, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 19:42:39'),
(311, NULL, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 19:42:58'),
(312, NULL, 'report_submission', 'Submitted report: Enrollment Data (2 records)', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 19:43:24'),
(313, 1, 'table_assignment', 'Assigned admissiondata table to RGO San Juan', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 19:56:47'),
(314, NULL, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 19:57:35'),
(315, NULL, 'table_assignment', 'Assigned enrollmentdata table to RGO Lipa', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 23:08:49'),
(316, NULL, 'report_submission', 'Submitted report: Enrollment Data (2 records)', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-05 23:10:57'),
(317, NULL, 'table_assignment', 'Assigned enrollmentdata table to RGO Lipa', NULL, '2001:4453:332:ea00:6568:1087:818b:41ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-06 01:20:29'),
(318, 1, 'user_created', 'Created user: lipa-admin-acc (lipa-admin-acc) with role: admin at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:10:50'),
(319, 41, 'user_created', 'Created user: lipa-rgtr-ofc (lipa-rgtr-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:13:56'),
(320, 41, 'user_created', 'Created user: lipa-acct-ofc (lipa-acct-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:16:21'),
(321, 41, 'user_created', 'Created user: lipa-ooc-ofc (lipa-ooc-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:18:29'),
(322, 41, 'user_created', 'Created user: lipa-ia-ofc (lipa-ia-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:19:38'),
(323, 41, 'user_created', 'Created user: lipa-qam-ofc (lipa-qam-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:21:52'),
(324, 41, 'user_created', 'Created user: lipa-voc-ofc (lipa-voc-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:31:06'),
(325, 41, 'user_created', 'Created user: lipa-pdc-ofc (lipa-pdc-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:42:32'),
(326, 41, 'user_created', 'Created user: lipa-ea-ofc (lipa-ea-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:43:59'),
(327, 41, 'user_created', 'Created user: lipa-rgo-ofc (lipa-rgo-ofc) with role: user at campus: Lipa', NULL, '49.149.137.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:48:29'),
(328, 41, 'user_created', 'Created user: lipa-ict-ofc (lipa-ict-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:49:33'),
(329, 41, 'user_created', 'Created user: lipa-vcaa-ofc (lipa-vcaa-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:51:05'),
(330, 41, 'user_created', 'Created user: lipa-vcaa-ofc (lipa-vcaa-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:52:26'),
(331, 41, 'user_created', 'Created user: lipa-cas-ofc (lipa-cas-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:53:39'),
(332, 41, 'user_created', 'Created user: lipa-cabe-ofc (lipa-cabe-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:54:40'),
(333, 41, 'user_created', 'Created user: lipa-cics-ofc (lipa-cics-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:56:09'),
(334, 41, 'user_created', 'Created user: lipa-cet-ofc (lipa-cet-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:56:57'),
(335, 41, 'user_created', 'Created user: lipa-cte-ofc (lipa-cte-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:58:42'),
(336, 41, 'user_created', 'Created user: lipa-ce-ofc (lipa-ce-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 03:59:42'),
(337, 41, 'user_created', 'Created user: lipa-ca-ofc (lipa-ca-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:00:34'),
(338, 41, 'user_created', 'Created user: lipa-ta-ofc (lipa-ta-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:03:47'),
(339, 41, 'user_created', 'Created user: lipa-sfa-ofc (lipa-sfa-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:12:29'),
(340, 41, 'user_created', 'Created user: lipa-gc-ofc (lipa-gc-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:14:41'),
(341, 41, 'user_created', 'Created user: lipa-ls-ofc (lipa-ls-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:16:28'),
(342, 41, 'user_created', 'Created user: lipa-soa-ofc (lipa-soa-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:17:23'),
(343, 41, 'user_created', 'Created user: lipa-sd-ofc (lipa-sd-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:18:00'),
(344, 41, 'user_created', 'Created user: lipa-sad-ofc (lipa-sad-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:24:42'),
(345, 41, 'user_created', 'Created user: lipa-ojt-ofc (lipa-ojt-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:25:56'),
(346, 41, 'user_created', 'Created user: lipa-nstp-ofc (lipa-nstp-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:27:07'),
(347, 41, 'user_created', 'Created user: lipa-rm-ofc (lipa-rm-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:29:28'),
(348, 41, 'user_created', 'Created user: lipa-pcr-ofc (lipa-pcr-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:33:42'),
(349, 41, 'user_created', 'Created user: lipa-bdgt-ofc (lipa-bdgt-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:35:03'),
(350, 41, 'user_created', 'Created user: lipa-cd-ofc (lipa-cd-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:37:47'),
(351, 41, 'user_created', 'Created user: lipa-pfm-ofc (lipa-pfm-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 04:40:50'),
(352, 41, 'user_created', 'Created user: lipa-emu-ofc (lipa-emu-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 05:35:31'),
(353, 41, 'user_created', 'Created user: lipa-psm-ofc (lipa-psm-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 05:36:38'),
(354, 41, 'user_created', 'Created user: lipa-gso-ofc (lipa-gso-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 05:37:52'),
(355, 41, 'user_created', 'Created user: lipa-ext-ofc (lipa-ext-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 05:39:03');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(356, 41, 'user_created', 'Created user: lipa-rsch-ofc (lipa-rsch-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 05:40:43'),
(357, 41, 'user_created', 'Created user: lipa-hrmo-ofc (lipa-hrmo-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 05:42:39'),
(358, 41, 'user_created', 'Created user: lipa-hs-ofc (lipa-hs-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 05:44:34'),
(359, 1, 'user_created', 'Created user: san-juna-admin-acc (san-juna-admin-acc) with role: admin at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 05:53:00'),
(360, 1, 'user_created', 'Created user: lobo-admin-acc (lobo-admin-acc) with role: admin at campus: Lobo', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 05:54:23'),
(361, NULL, 'user_updated', 'Updated user: san-juna-admin-acc (san-juna-admin-acc)', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 05:55:28'),
(362, NULL, 'user_deleted', 'Deleted user: lipa-vcaa-ofc (lipa-vcaa-ofc)', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 05:58:07'),
(363, NULL, 'user_deleted', 'Deleted user: lipa-voc-ofc (lipa-voc-ofc)', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 05:58:41'),
(364, 82, 'user_created', 'Created user: sj-rgtr-ofc (sj-rgtr-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 05:59:50'),
(365, 82, 'user_created', 'Created user: sj-ooc-ofc (sj-ooc-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:02:40'),
(366, NULL, 'user_deleted', 'Deleted user: sj-ooc-ofc (sj-ooc-ofc)', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:05:13'),
(367, 82, 'user_created', 'Created user: sj-ia-ofc (sj-ia-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:07:23'),
(368, 82, 'user_created', 'Created user: sj-qam-ofc (sj-qam-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:08:31'),
(369, 82, 'user_created', 'Created user: sj-pdc-ofc (sj-pdc-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:14:57'),
(370, 82, 'user_created', 'Created user: sj-ea-ofc (sj-ea-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:16:44'),
(371, 82, 'user_created', 'Created user: sj-rgo-ofc (sj-rgo-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:17:44'),
(372, 82, 'user_created', 'Created user: sj-ict-ofc (sj-ict-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:41:42'),
(373, 82, 'user_created', 'Created user: sj-cas-ofc (sj-cas-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:43:07'),
(374, 82, 'user_created', 'Created user: sj-cabe-ofc (sj-cabe-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:44:04'),
(375, 82, 'user_created', 'Created user: sj-cics-ofc (sj-cics-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:45:00'),
(376, 82, 'user_created', 'Created user: sj-cet-ofc (sj-cet-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:46:08'),
(377, 82, 'user_created', 'Created user: sj-cte-ofc (sj-cte-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:3985:8841:f07:14d2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:47:58'),
(378, 82, 'user_created', 'Created user: sj-ce-ofc (sj-ce-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:f13d:51d9:2ca1:cbdc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:49:27'),
(379, 82, 'user_created', 'Created user: sj-ca-ofc (sj-ca-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:f13d:51d9:2ca1:cbdc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:50:29'),
(380, 82, 'user_created', 'Created user: sj-tao-ofc (sj-tao-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:f13d:51d9:2ca1:cbdc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:51:31'),
(381, 82, 'user_created', 'Created user: sj-rs-ofc (sj-rs-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:6ddc:31fc:8717:830e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:52:44'),
(382, 82, 'user_created', 'Created user: sj-sfa-ofc (sj-sfa-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:6ddc:31fc:8717:830e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:54:21'),
(383, 82, 'user_created', 'Created user: sj-gc-ofc (sj-gc-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:6ddc:31fc:8717:830e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:56:54'),
(384, 82, 'user_created', 'Created user: sj-soa-ofc (sj-soa-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:6ddc:31fc:8717:830e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:58:11'),
(385, 82, 'user_created', 'Created user: sj-sd-ofc (sj-sd-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:6ddc:31fc:8717:830e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 06:59:22'),
(386, NULL, 'user_deleted', 'Deleted user: lipa-rgo-ofc (lipa-rgo-ofc)', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:01:17'),
(387, 82, 'user_created', 'Created user: sj-sad-ofc (sj-sad-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:6ddc:31fc:8717:830e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:01:51'),
(388, 41, 'user_created', 'Created user: lipa-rgo-ofc (lipa-rgo-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:01:53'),
(389, 41, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(390, 41, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(391, 41, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(392, 41, 'table_assignment', 'Assigned employee table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(393, 41, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(394, 41, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(395, 41, 'table_assignment', 'Assigned pwd table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(396, 41, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(397, 41, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(398, 41, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(399, 41, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(400, 41, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(401, 41, 'table_assignment', 'Assigned foodwaste table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(402, 41, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(403, 41, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(404, 41, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(405, 41, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:02:33'),
(406, 82, 'user_created', 'Created user: sj-ojt-ofc (sj-ojt-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:6ddc:31fc:8717:830e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:02:53'),
(407, 82, 'user_created', 'Created user: sj-nstp-ofc (sj-nstp-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:adb3:e5cd:9876:eea3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:03:46'),
(408, 106, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:04:02'),
(409, 82, 'user_created', 'Created user: sj-hrmo-ofc (sj-hrmo-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:4814:dcd3:12dc:9b4c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:05:30'),
(410, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:05:33'),
(411, 106, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 07:06:24'),
(412, 82, 'user_created', 'Created user: sj-rm-ofc (sj-rm-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:4814:dcd3:12dc:9b4c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:06:36'),
(413, 82, 'user_created', 'Created user: sj-pcr-ofc (sj-pcr-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:4814:dcd3:12dc:9b4c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:08:04'),
(414, 82, 'user_created', 'Created user: sj-bdgt-ofc (sj-bdgt-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:cc:4a58:414e:7f3d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:09:21'),
(415, 82, 'user_created', 'Created user: sj-cd-ofc (sj-cd-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:dd31:932b:651c:4dd2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:10:40'),
(416, 82, 'user_created', 'Created user: sj-acct-ofc (sj-acct-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:dd31:932b:651c:4dd2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:12:55'),
(417, NULL, 'user_deleted', 'Deleted user: sj-bdgt-ofc (sj-bdgt-ofc)', NULL, '2001:4453:332:ea00:dd31:932b:651c:4dd2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:35:57'),
(418, 82, 'user_created', 'Created user: sj-bdgt-ofc (sj-bdgt-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:dd31:932b:651c:4dd2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:37:20'),
(419, 82, 'user_created', 'Created user: sj-pfm-ofc (sj-pfm-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:a926:7b16:990b:5b8c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:41:48'),
(420, 82, 'user_created', 'Created user: sj-emu-ofc (sj-emu-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:a926:7b16:990b:5b8c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:42:46'),
(421, 82, 'user_created', 'Created user: sj-psm-ofc (sj-psm-ofc) with role: user at campus: San Juan', NULL, '49.149.137.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:43:46'),
(422, 82, 'user_created', 'Created user: sj-gso-ofc (sj-gso-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:a926:7b16:990b:5b8c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:45:14'),
(423, 82, 'user_created', 'Created user: sj-ext-ofc (sj-ext-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:a926:7b16:990b:5b8c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:46:37'),
(424, 82, 'user_created', 'Created user: sj-rsch-ofc (sj-rsch-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:a926:7b16:990b:5b8c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:48:12'),
(425, 82, 'user_created', 'Created user: sj-hs-ofc (sj-hs-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:a926:7b16:990b:5b8c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 07:49:07'),
(426, 83, 'user_created', 'Created user: lobo-rgtr-ofc (lobo-rgtr-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:01:25'),
(427, 83, 'user_created', 'Created user: lobo-acct-ofc (lobo-acct-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:02:33'),
(428, 83, 'user_created', 'Created user: lobo-ooc-ofc (lobo-ooc-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:03:07'),
(429, 83, 'user_created', 'Created user: lobo-ia-ofc (lobo-ia-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:04:08'),
(430, NULL, 'user_updated', 'Updated user: lobo-ia-ofc (lobo-ia-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:04:25'),
(431, NULL, 'user_updated', 'Updated user: lobo-ia-ofc (lobo-ia-ofc)', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:04:33'),
(432, 83, 'user_created', 'Created user: lobo-Qam-ofc (lobo-Qam-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:05:04'),
(433, 83, 'user_created', 'Created user: lobo-pdc-ofc (lobo-pdc-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:05:30'),
(434, 83, 'user_created', 'Created user: lobo-ea-ofc (lobo-ea-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:05:48'),
(435, 83, 'user_created', 'Created user: lobo-rgo-ofc (lobo-rgo-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:06:19'),
(436, 83, 'user_created', 'Created user: lobo-ict-ofc (lobo-ict-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:07:26'),
(437, 83, 'user_created', 'Created user: lobo-cas-ofc (lobo-cas-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:07:55'),
(438, NULL, 'user_updated', 'Updated user: lobo-acct-ofc (lobo-acct-ofc)', NULL, '2001:4453:332:ea00:3def:5d98:8874:bd3e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:08:45'),
(439, 83, 'user_created', 'Created user: lobo-cabe-ofc (lobo-cabe-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:09:01'),
(440, NULL, 'user_updated', 'Updated user: sj-acct-ofc (sj-acct-ofc)', NULL, '2001:4453:332:ea00:3def:5d98:8874:bd3e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:09:06'),
(441, 83, 'user_created', 'Created user: lobo-cics-ofc (lobo-cics-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:09:44'),
(442, 83, 'user_created', 'Created user: lobo-cet-ofc (lobo-cet-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:10:04'),
(443, 83, 'user_created', 'Created user: lobo-cte-ofc (lobo-cte-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:10:20'),
(444, 83, 'user_created', 'Created user: lobo-ce-ofc (lobo-ce-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:11:03'),
(445, 83, 'user_created', 'Created user: lobo-ca-ofc (lobo-ca-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:11:22'),
(446, 83, 'user_created', 'Created user: lobo-ta-ofc (lobo-ta-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:11:45'),
(447, 83, 'user_created', 'Created user: lobo-sfa-ofc (lobo-sfa-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:14:06'),
(448, 83, 'user_created', 'Created user: lobo-gc-ofc (lobo-gc-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:14:31'),
(449, 83, 'user_created', 'Created user: lobo-ls-ofc (lobo-ls-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:16:36'),
(450, 83, 'user_created', 'Created user: lobo-soa-ofc (lobo-soa-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:17:04'),
(451, 83, 'user_created', 'Created user: lobo-sd-ofc (lobo-sd-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:17:38'),
(452, 83, 'user_created', 'Created user: lobo-sad-ofc (lobo-sad-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:17:56'),
(453, 83, 'user_created', 'Created user: lobo-ojt-ofc (lobo-ojt-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:18:09'),
(454, 83, 'user_created', 'Created user: lobo-nstp-ofc (lobo-nstp-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:18:31'),
(455, 83, 'user_created', 'Created user: lobo-rm-ofc (lobo-rm-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:18:53'),
(456, 83, 'user_created', 'Created user: lobo-pcr-ofc (lobo-pcr-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:19:09'),
(457, 83, 'user_created', 'Created user: lobo-bdgt-ofc (lobo-bdgt-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:19:25'),
(458, 83, 'user_created', 'Created user: lobo-cd-ofc (lobo-cd-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:19:47'),
(459, 83, 'user_created', 'Created user: lobo-emu-ofc (lobo-emu-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:20:11'),
(460, 83, 'user_created', 'Created user: lobo-psm-ofc (lobo-psm-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:20:35'),
(461, 83, 'user_created', 'Created user: lobo-gso-ofc (lobo-gso-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:21:36'),
(462, 83, 'user_created', 'Created user: lobo-ext-ofc (lobo-ext-ofc) with role: user at campus: Lobo', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:22:02'),
(463, 83, 'user_created', 'Created user: lobo-rsch-ofc (lobo-rsch-ofc) with role: user at campus: Lobo', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:22:18'),
(464, NULL, 'user_updated', 'Updated user: lobo-rsch-ofc (lobo-rsch-ofc)', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:22:25'),
(465, 83, 'user_created', 'Created user: lobo-hrmo-ofc (lobo-hrmo-ofc) with role: user at campus: Lobo', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:22:50'),
(466, 83, 'user_created', 'Created user: lobo-hs-ofc (lobo-hs-ofc) with role: user at campus: Lobo', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:23:05'),
(467, 1, 'user_created', 'Created user: alangilan-admin-acc (alangilan-admin-acc) with role: admin at campus: Alangilan', NULL, '2001:4453:332:ea00:3def:5d98:8874:bd3e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:25:00'),
(468, 159, 'user_created', 'Created user: alngln-rgtr-ofc (alngln-rgtr-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:3def:5d98:8874:bd3e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:35:28'),
(469, 159, 'user_created', 'Created user: alangilan-acct-ofc (alangilan-acct-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:897f:1846:9642:6767', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:38:08'),
(470, 159, 'user_created', 'Created user: alngln-ia-ofc (alngln-ia-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:9484:9c91:d7a:1a9f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:47:40'),
(471, 159, 'user_created', 'Created user: alngln-qam-ofc (alngln-qam-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:9484:9c91:d7a:1a9f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:48:14'),
(472, 159, 'user_created', 'Created user: alngln-pdc-ofc (alngln-pdc-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:9484:9c91:d7a:1a9f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:48:54'),
(473, 159, 'user_created', 'Created user: alngln-ea-ofc (alngln-ea-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:49:28'),
(474, 159, 'user_created', 'Created user: alngln-rgo-ofc (alngln-rgo-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:49:59'),
(475, 159, 'user_created', 'Created user: alngln-ict-ofc (alngln-ict-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:50:35'),
(476, 159, 'user_created', 'Created user: alngln-cas-ofc (alngln-cas-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:52:00'),
(477, 159, 'user_created', 'Created user: alngln-cabe-ofc (alngln-cabe-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:52:27'),
(478, 159, 'user_created', 'Created user: alngln-cics-ofc (alngln-cics-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:52:54'),
(479, 159, 'user_created', 'Created user: alngln-cet-ofc (alngln-cet-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:53:29'),
(480, 159, 'user_created', 'Created user: alngln-cte-ofc (alngln-cte-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:53:55'),
(481, 159, 'user_created', 'Created user: alngln-ce-ofc (alngln-ce-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:54:19'),
(482, 159, 'user_created', 'Created user: alngln-ca-ofc (alngln-ca-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:54:40'),
(483, 159, 'user_created', 'Created user: alngln-tao-ofc (alngln-tao-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:55:02'),
(484, 159, 'user_created', 'Created user: alngln-rs-ofc (alngln-rs-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:55:40'),
(485, 159, 'user_created', 'Created user: alngln-sfa-ofc (alngln-sfa-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:56:12'),
(486, 159, 'user_created', 'Created user: alngln-gc-ofc (alngln-gc-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:56:39'),
(487, 159, 'user_created', 'Created user: alngln-soa-ofc (alngln-soa-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:57:16'),
(488, 159, 'user_created', 'Created user: alngln-sd-ofc (alngln-sd-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:57:41'),
(489, 159, 'user_created', 'Created user: alngln-sad-ofc (alngln-sad-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:58:20'),
(490, 159, 'user_created', 'Created user: alngln-ojt-ofc (alngln-ojt-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:58:40'),
(491, 159, 'user_created', 'Created user: alngln-nstp-ofc (alngln-nstp-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:59:05'),
(492, 159, 'user_created', 'Created user: alngln-hrmo-ofc (alngln-hrmo-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 08:59:34'),
(493, 159, 'user_created', 'Created user: alngln-rm-ofc (alngln-rm-ofc) with role: user at campus: Alangilan', NULL, '49.149.137.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:00:10'),
(494, 159, 'user_created', 'Created user: alngln-pcr-ofc (alngln-pcr-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:00:56'),
(495, 159, 'user_created', 'Created user: alngln-bdgt-ofc (alngln-bdgt-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:01:37'),
(496, 106, 'report_submission', 'Submitted report: Enrollment Data (2 records)', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 09:02:12'),
(497, 159, 'user_created', 'Created user: alngln-cd-ofc (alngln-cd-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:02:31'),
(498, 106, 'report_submission', 'Submitted report: Employee Data (2 records)', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 09:03:17'),
(499, 159, 'user_created', 'Created user: alngln-pfm-ofc (alngln-pfm-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:03:25'),
(500, 159, 'user_created', 'Created user: alngln-emu-ofc (alngln-emu-ofc) with role: user at campus: Alangilan', NULL, '49.149.137.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:03:53'),
(501, 159, 'user_created', 'Created user: alngln-psm-ofc (alngln-psm-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:04:20'),
(502, 159, 'user_created', 'Created user: alngln-gso-ofc (alngln-gso-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:04:47'),
(503, 159, 'user_created', 'Created user: alngln-ext-ofc (alngln-ext-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:05:10'),
(504, 159, 'user_created', 'Created user: alngln-rsch-ofc (alngln-rsch-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:06:17'),
(505, 159, 'user_created', 'Created user: alngln-hs-ofc (alngln-hs-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:c9d2:1579:34a4:c7e8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:06:41'),
(506, 1, 'user_created', 'Created user: pablo-borbon-admin-acc (pablo-borbon-admin-acc) with role: admin at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:15:27'),
(507, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lobo', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:17:57'),
(508, 1, 'table_assignment', 'Assigned admissiondata table to OJT San Juan', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:24:01'),
(509, 107, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:25:46'),
(510, NULL, 'user_updated', 'Updated user: lobo-rgtr-ofc (lobo-rgtr-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:27:36'),
(511, NULL, 'user_updated', 'Updated user: lobo-acct-ofc (lobo-acct-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:31:11'),
(512, 196, 'user_created', 'Created user: pb-rgtr-ofc (pb-rgtr-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:37:39'),
(513, 196, 'user_created', 'Created user: pb-ia-ofc (pb-ia-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:38:21'),
(514, 196, 'user_created', 'Created user: pb-qam-ofc (pb-qam-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:38:52'),
(515, 196, 'user_created', 'Created user: pb-pdc-ofc (pb-pdc-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:39:52'),
(516, 196, 'user_created', 'Created user: pb-ea-ofc (pb-ea-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:40:30'),
(517, 196, 'user_created', 'Created user: pb-rgo-ofc (pb-rgo-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:41:00'),
(518, 196, 'user_created', 'Created user: pb-ict-ofc (pb-ict-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:41:26'),
(519, 196, 'user_created', 'Created user: pb-cas-ofc (pb-cas-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:41:54'),
(520, 196, 'user_created', 'Created user: pb-cabe-ofc (pb-cabe-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:43:09'),
(521, 196, 'user_created', 'Created user: pb-cics-ofc (pb-cics-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:43:34'),
(522, 196, 'user_created', 'Created user: pb-cet-ofc (pb-cet-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:44:06'),
(523, 196, 'user_created', 'Created user: pb-cte-ofc (pb-cte-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:44:31'),
(524, 196, 'user_created', 'Created user: pb-ce-ofc (pb-ce-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:44:56'),
(525, 196, 'user_created', 'Created user: pb-ca-ofc (pb-ca-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:45:21'),
(526, 196, 'user_created', 'Created user: pb-tao-ofc (pb-tao-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:45:52'),
(527, 196, 'user_created', 'Created user: pb-rs-ofc (pb-rs-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:46:20'),
(528, 196, 'user_created', 'Created user: pb-sfa-ofc (pb-sfa-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:46:57'),
(529, 196, 'user_created', 'Created user: pb-gc-ofc (pb-gc-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:47:23');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(530, 196, 'user_created', 'Created user: pb-soa-ofc (pb-soa-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:47:56'),
(531, 196, 'user_created', 'Created user: pb-sd-ofc (pb-sd-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:48:24'),
(532, 196, 'user_created', 'Created user: pb-sad-ofc (pb-sad-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:48:50'),
(533, 196, 'user_created', 'Created user: pb-ojt-ofc (pb-ojt-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:49:29'),
(534, 196, 'user_created', 'Created user: pb-nstp-ofc (pb-nstp-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:49:56'),
(535, 196, 'user_created', 'Created user: pb-hrmo-ofc (pb-hrmo-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:50:21'),
(536, 196, 'user_created', 'Created user: pb-rm-ofc (pb-rm-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:50:45'),
(537, 196, 'user_created', 'Created user: pb-pcr-ofc (pb-pcr-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:51:41'),
(538, 196, 'user_created', 'Created user: pb-bdgt-ofc (pb-bdgt-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:52:13'),
(539, 196, 'user_created', 'Created user: pb-cd-ofc (pb-cd-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:52:44'),
(540, 196, 'user_created', 'Created user: pb-acct-ofc (pb-acct-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:53:11'),
(541, 196, 'user_created', 'Created user: pb-pfm-ofc (pb-pfm-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:53:59'),
(542, 196, 'user_created', 'Created user: pb-emu-ofc (pb-emu-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:54:24'),
(543, 196, 'user_created', 'Created user: pb-psm-ofc (pb-psm-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:54:51'),
(544, 196, 'user_created', 'Created user: pb-gso-ofc (pb-gso-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:55:14'),
(545, 196, 'user_created', 'Created user: pb-ext-ofc (pb-ext-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:55:44'),
(546, 196, 'user_created', 'Created user: pb-rsch-ofc (pb-rsch-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:56:17'),
(547, 196, 'user_created', 'Created user: pb-hs-ofc (pb-hs-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 09:56:45'),
(548, 1, 'user_created', 'Created user: nasugbu-admin-acc (nasugbu-admin-acc) with role: admin at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:06:23'),
(549, 233, 'user_created', 'Created user: nsb-rgtr-ofc (nsb-rgtr-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:07:39'),
(550, 233, 'user_created', 'Created user: nsb-acct-ofc (nsb-acct-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:08:14'),
(551, 233, 'user_created', 'Created user: nsb-ia-ofc (nsb-ia-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:08:48'),
(552, 233, 'user_created', 'Created user: nsb-qam-ofc (nsb-qam-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:09:20'),
(553, 233, 'user_created', 'Created user: nsb-pdc-ofc (nsb-pdc-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:09:44'),
(554, 233, 'user_created', 'Created user: nsb-ea-ofc (nsb-ea-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:10:38'),
(555, 233, 'user_created', 'Created user: nsb-rgo-ofc (nsb-rgo-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:11:07'),
(556, 233, 'user_created', 'Created user: nsb-ict-ofc (nsb-ict-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:11:28'),
(557, 233, 'user_created', 'Created user: nsb-cas-ofc (nsb-cas-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:11:56'),
(558, 233, 'user_created', 'Created user: nsb-cabe-ofc (nsb-cabe-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:12:19'),
(559, 233, 'user_created', 'Created user: nsb-cics-ofc (nsb-cics-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:12:51'),
(560, 233, 'user_created', 'Created user: nsb-cet-ofc (nsb-cet-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:13:13'),
(561, 233, 'user_created', 'Created user: nsb-cte-ofc (nsb-cte-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:13:41'),
(562, 233, 'user_created', 'Created user: nsb-ce-ofc (nsb-ce-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:14:09'),
(563, 233, 'user_created', 'Created user: nsb-ca-ofc (nsb-ca-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:14:33'),
(564, 233, 'user_created', 'Created user: nsb-tao-ofc (nsb-tao-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:15:10'),
(565, 233, 'user_created', 'Created user: nsb-rs-ofc (nsb-rs-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:15:42'),
(566, 233, 'user_created', 'Created user: nsb-sfa-ofc (nsb-sfa-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:16:06'),
(567, 233, 'user_created', 'Created user: nsb-gc-ofc (nsb-gc-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:16:27'),
(568, 233, 'user_created', 'Created user: nsb-soa-ofc (nsb-soa-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:16:47'),
(569, 233, 'user_created', 'Created user: nsb-sd-ofc (nsb-sd-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:17:12'),
(570, 233, 'user_created', 'Created user: nsb-sad-ofc (nsb-sad-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:17:35'),
(571, 233, 'user_created', 'Created user: nsb-ojt-ofc (nsb-ojt-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:17:56'),
(572, 233, 'user_created', 'Created user: nsb-nstp-ofc (nsb-nstp-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:18:22'),
(573, 233, 'user_created', 'Created user: nsb-hrmo-ofc (nsb-hrmo-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:18:47'),
(574, 233, 'user_created', 'Created user: nsb-rm-ofc (nsb-rm-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:19:28'),
(575, 233, 'user_created', 'Created user: nsb-pcr-ofc (nsb-pcr-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:19:51'),
(576, 233, 'user_created', 'Created user: nsb-bdgt-ofc (nsb-bdgt-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:20:15'),
(577, 233, 'user_created', 'Created user: nsb-cd-ofc (nsb-cd-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:20:50'),
(578, 233, 'user_created', 'Created user: nsb-pfm-ofc (nsb-pfm-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:21:16'),
(579, 233, 'user_created', 'Created user: nsb-emu-ofc (nsb-emu-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:21:40'),
(580, 233, 'user_created', 'Created user: nsb-psm-ofc (nsb-psm-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:22:08'),
(581, 233, 'user_created', 'Created user: nsb-gso-ofc (nsb-gso-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:22:37'),
(582, 233, 'user_created', 'Created user: nsb-ext-ofc (nsb-ext-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:23:01'),
(583, 233, 'user_created', 'Created user: nsb-rsch-ofc (nsb-rsch-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:23:25'),
(584, 233, 'user_created', 'Created user: nsb-hs-ofc (nsb-hs-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:23:49'),
(585, 1, 'user_created', 'Created user: malvar-admin-acc (malvar-admin-acc) with role: admin at campus: Malvar', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:33:58'),
(586, 270, 'user_created', 'Created user: malvar-rgtr-ofc (malvar-rgtr-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:41:33'),
(587, 270, 'user_created', 'Created user: malvar-acct-007 (malvar-acct-007) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:45:24'),
(588, NULL, 'user_updated', 'Updated user: malvar-acct-007 (malvar-acct-007)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:51:58'),
(589, 270, 'user_created', 'Created user: malvar-ia-ofc (malvar-ia-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:52:24'),
(590, 270, 'user_created', 'Created user: malvar-qam-ofc (malvar-qam-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:52:45'),
(591, 270, 'user_created', 'Created user: malvar-pdc-ofc (malvar-pdc-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:53:09'),
(592, 270, 'user_created', 'Created user: malvar-ea-ofc (malvar-ea-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:53:33'),
(593, 270, 'user_created', 'Created user: malvar-rgo-ofc (malvar-rgo-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:54:05'),
(594, 270, 'user_created', 'Created user: malvar-ict-ofc (malvar-ict-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:54:27'),
(595, 270, 'user_created', 'Created user: malvar-cas-ofc (malvar-cas-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:54:50'),
(596, 270, 'user_created', 'Created user: malvar-cabe-ofc (malvar-cabe-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:55:06'),
(597, 270, 'user_created', 'Created user: malvar-cics-ofc (malvar-cics-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:55:28'),
(598, 270, 'user_created', 'Created user: malvar-cet-ofc (malvar-cet-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:55:48'),
(599, 270, 'user_created', 'Created user: malvar-cte-ofc (malvar-cte-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:56:12'),
(600, 270, 'user_created', 'Created user: malvar-ce-ofc (malvar-ce-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:56:32'),
(601, 270, 'user_created', 'Created user: malvar-ca-ofc (malvar-ca-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:56:55'),
(602, 270, 'user_created', 'Created user: malvar-tao-ofc (malvar-tao-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:57:12'),
(603, 270, 'user_created', 'Created user: malvar-rs-ofc (malvar-rs-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:57:26'),
(604, 270, 'user_created', 'Created user: malvar-sfa-ofc (malvar-sfa-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:57:47'),
(605, 270, 'user_created', 'Created user: malvar-gc-ofc (malvar-gc-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:58:11'),
(606, 270, 'user_created', 'Created user: malvar-soa-ofc (malvar-soa-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:58:30'),
(607, 270, 'user_created', 'Created user: malvar-sd-ofc (malvar-sd-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:58:50'),
(608, 270, 'user_created', 'Created user: malvar-sad-ofc (malvar-sad-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:59:07'),
(609, 270, 'user_created', 'Created user: malvar-ojt-ofc (malvar-ojt-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:59:21'),
(610, 270, 'user_created', 'Created user: malvar-nstp-ofc (malvar-nstp-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:59:40'),
(611, 270, 'user_created', 'Created user: malvar-hrmo-ofc (malvar-hrmo-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 10:59:55'),
(612, 270, 'user_created', 'Created user: malvar-rm-ofc (malvar-rm-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:00:13'),
(613, 270, 'user_created', 'Created user: malvar-pcr-ofc (malvar-pcr-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:00:31'),
(614, 270, 'user_created', 'Created user: malvar-bdgt-ofc (malvar-bdgt-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:00:47'),
(615, 270, 'user_created', 'Created user: malvar-cd-ofc (malvar-cd-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:01:06'),
(616, 270, 'user_created', 'Created user: malvar-pfm-ofc (malvar-pfm-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:01:33'),
(617, 270, 'user_created', 'Created user: malvar-emu-ofc (malvar-emu-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:01:52'),
(618, 270, 'user_created', 'Created user: malvar-psm-ofc (malvar-psm-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:02:49'),
(619, 270, 'user_created', 'Created user: malvar-gso-ofc (malvar-gso-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:03:39'),
(620, 270, 'user_created', 'Created user: malvar-ext-ofc (malvar-ext-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:03:57'),
(621, 270, 'user_created', 'Created user: malvar-rsch-ofc (malvar-rsch-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:04:30'),
(622, NULL, 'user_updated', 'Updated user: malvar-bdgt-ofc (malvar-bdgt-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:05:27'),
(623, NULL, 'user_updated', 'Updated user: malvar-rsch-ofc (malvar-rsch-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:10:00'),
(624, 270, 'user_created', 'Created user: malvar-rsch-ofc (malvar-rsch-ofc) with role: user at campus: Malvar', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:13:05'),
(625, 1, 'user_created', 'Created user: balayan-admin-acc (balayan-admin-acc) with role: admin at campus: Balayan', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:15:27'),
(626, 1, 'user_created', 'Created user: lemery-admin-acc (lemery-admin-acc) with role: admin at campus: Lemery', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:21:18'),
(627, 307, 'user_created', 'Created user: balayan-rgtr-ofc (balayan-rgtr-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:23:47'),
(628, 307, 'user_created', 'Created user: balayan-acct-ofc (balayan-acct-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:24:54'),
(629, 307, 'user_created', 'Created user: balayan-ia-ofc (balayan-ia-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:25:10'),
(630, 307, 'user_created', 'Created user: balayan-qam-ofc (balayan-qam-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:25:34'),
(631, 307, 'user_created', 'Created user: balayan-pdc-ofc (balayan-pdc-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:26:01'),
(632, 307, 'user_created', 'Created user: balayan-ea-ofc (balayan-ea-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:26:18'),
(633, 307, 'user_created', 'Created user: balayan-rgo-ofc (balayan-rgo-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:26:37'),
(634, 307, 'user_created', 'Created user: balayan-ict-ofc (balayan-ict-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:26:55'),
(635, 307, 'user_created', 'Created user: balayan-cas-ofc (balayan-cas-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:27:26'),
(636, 307, 'user_created', 'Created user: balayan-cabe-ofc (balayan-cabe-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:27:40'),
(637, 307, 'user_created', 'Created user: balayan-cics-ofc (balayan-cics-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:28:53'),
(638, 307, 'user_created', 'Created user: balayan-cet-ofc (balayan-cet-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:29:07'),
(639, 307, 'user_created', 'Created user: balayan-cte-ofc (balayan-cte-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:29:26'),
(640, 307, 'user_created', 'Created user: balayan-ce-ofc (balayan-ce-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:29:44'),
(641, 307, 'user_created', 'Created user: balayan-ca-ofc (balayan-ca-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:29:55'),
(642, NULL, 'user_updated', 'Updated user: balayan-ca-ofc (balayan-ca-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:30:36'),
(643, 307, 'user_created', 'Created user: balayan-tao-ofc (balayan-tao-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:30:57'),
(644, 307, 'user_created', 'Created user: balayan-rs-ofc (balayan-rs-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:31:23'),
(645, 307, 'user_created', 'Created user: balayan-sfa-ofc (balayan-sfa-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:32:33'),
(646, 307, 'user_created', 'Created user: balayan-gc-ofc (balayan-gc-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:35:19'),
(647, 307, 'user_created', 'Created user: balayan-soa-ofc (balayan-soa-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:35:43'),
(648, 307, 'user_created', 'Created user: balayan-sd-ofc (balayan-sd-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:36:16'),
(649, 307, 'user_created', 'Created user: balayan-sad-ofc (balayan-sad-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:36:49'),
(650, 307, 'user_created', 'Created user: balayan-ojt-ofc (balayan-ojt-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:37:05'),
(651, 307, 'user_created', 'Created user: balayan-nstp-ofc (balayan-nstp-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:38:44'),
(652, 307, 'user_created', 'Created user: balayan-hrmo-ofc (balayan-hrmo-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:39:01'),
(653, 307, 'user_created', 'Created user: balayan-rm-ofc (balayan-rm-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:39:22'),
(654, 307, 'user_created', 'Created user: balayan-pcr-ofc (balayan-pcr-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:39:53'),
(655, 307, 'user_created', 'Created user: balayan-bdgt-ofc (balayan-bdgt-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:40:21'),
(656, 307, 'user_created', 'Created user: balayan-cd-ofc (balayan-cd-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:40:35'),
(657, 307, 'user_created', 'Created user: balayan-pfm-ofc (balayan-pfm-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:40:50'),
(658, 307, 'user_created', 'Created user: balayan-emu-ofc (balayan-emu-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:41:10'),
(659, 307, 'user_created', 'Created user: balayan-psm-ofc (balayan-psm-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:41:31'),
(660, 307, 'user_created', 'Created user: balayan-gso-ofc (balayan-gso-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:41:47'),
(661, 307, 'user_created', 'Created user: balayan-ext-ofc (balayan-ext-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:42:13'),
(662, 307, 'user_created', 'Created user: balayan-rsch-ofc (balayan-rsch-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:42:51'),
(663, 307, 'user_created', 'Created user: balayan-hs-ofc (balayan-hs-ofc) with role: user at campus: Balayan', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:43:16'),
(664, 308, 'user_created', 'Created user: lemery-rgtr-ofc (lemery-rgtr-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:50:25'),
(665, 308, 'user_created', 'Created user: lemery-acct-ofc (lemery-acct-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:50:38'),
(666, NULL, 'user_updated', 'Updated user: lemery-acct-ofc (lemery-acct-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:51:15'),
(667, 308, 'user_created', 'Created user: lemery-ia-ofc (lemery-ia-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:51:31'),
(668, 308, 'user_created', 'Created user: lemery-qam-ofc (lemery-qam-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:51:46'),
(669, 308, 'user_created', 'Created user: lemery-pdc-ofc (lemery-pdc-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:51:58'),
(670, 308, 'user_created', 'Created user: lemery-ea-ofc (lemery-ea-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:52:22'),
(671, 308, 'user_created', 'Created user: lemery-rgo-ofc (lemery-rgo-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:55:32'),
(672, 308, 'user_created', 'Created user: lemery-ict-ofc (lemery-ict-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:55:49'),
(673, 308, 'user_created', 'Created user: lemery-cas-ofc (lemery-cas-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:56:19'),
(674, 308, 'user_created', 'Created user: lemery-cabe-ofc (lemery-cabe-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:56:47'),
(675, 308, 'user_created', 'Created user: lemery-cics-ofc (lemery-cics-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:57:04'),
(676, 308, 'user_created', 'Created user: lemery-cet-ofc (lemery-cet-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:57:22'),
(677, 308, 'user_created', 'Created user: lemery-cte-ofc (lemery-cte-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:57:37'),
(678, 308, 'user_created', 'Created user: lemery-ce-ofc (lemery-ce-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:58:09'),
(679, 308, 'user_created', 'Created user: lemery-ca-ofc (lemery-ca-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:58:34'),
(680, NULL, 'user_updated', 'Updated user: lemery-ce-ofc (lemery-ce-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:58:45'),
(681, 308, 'user_created', 'Created user: lemery-tao-ofc (lemery-tao-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:59:22'),
(682, 308, 'user_created', 'Created user: lemery-rs-ofc (lemery-rs-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 11:59:46'),
(683, 308, 'user_created', 'Created user: lemery-sfa-ofc (lemery-sfa-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:00:12'),
(684, 308, 'user_created', 'Created user: lemery-gc-ofc (lemery-gc-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:00:56'),
(685, NULL, 'user_updated', 'Updated user: lemery-gc-ofc (lemery-gc-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:02:00'),
(686, NULL, 'user_updated', 'Updated user: lemery-gc-ofc (lemery-gc-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:02:06'),
(687, NULL, 'user_updated', 'Updated user: lemery-sfa-ofc (lemery-sfa-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:02:19'),
(688, 308, 'user_created', 'Created user: lemery-soa-ofc (lemery-soa-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:02:42'),
(689, 1, 'user_created', 'Created user: mabini-admin-acc (mabini-admin-acc) with role: admin at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:02:52'),
(690, 308, 'user_created', 'Created user: lemery-sd-ofc (lemery-sd-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:03:30'),
(691, 308, 'user_created', 'Created user: lemery-sad-ofc (lemery-sad-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:04:09'),
(692, 308, 'user_created', 'Created user: lemery-ojt-ofc (lemery-ojt-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:04:25'),
(693, 365, 'user_created', 'Created user: mabini-rgtr-ofc (mabini-rgtr-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:04:46'),
(694, 308, 'user_created', 'Created user: lemery-nstp-ofc (lemery-nstp-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:05:10'),
(695, 365, 'user_created', 'Created user: mabini-acct-ofc (mabini-acct-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:05:22'),
(696, 308, 'user_created', 'Created user: lemery-hrmo-ofc (lemery-hrmo-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:05:26'),
(697, NULL, 'user_updated', 'Updated user: lobo-pdc-ofc (lobo-pdc-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:05:33'),
(698, 308, 'user_created', 'Created user: lemery-rm-ofc (lemery-rm-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:05:54'),
(699, 308, 'user_created', 'Created user: lemery-pcr-ofc (lemery-pcr-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:06:22');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(700, 308, 'user_created', 'Created user: lemery-bdgt-ofc (lemery-bdgt-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:06:45'),
(701, 308, 'user_created', 'Created user: lemery-cd-ofc (lemery-cd-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:07:11'),
(702, 308, 'user_created', 'Created user: lemery-pfm-ofc (lemery-pfm-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:07:32'),
(703, 308, 'user_created', 'Created user: lemery-emu-ofc (lemery-emu-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:07:57'),
(704, NULL, 'user_updated', 'Updated user: lobo-ea-ofc (lobo-ea-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:07:58'),
(705, 308, 'user_created', 'Created user: lemery-psm-ofc (lemery-psm-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:08:17'),
(706, 308, 'user_created', 'Created user: lemery-gso-ofc (lemery-gso-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:08:36'),
(707, 308, 'user_created', 'Created user: lemery-ext-ofc (lemery-ext-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:08:56'),
(708, 308, 'user_created', 'Created user: lemery-rsch-ofc (lemery-rsch-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:09:10'),
(709, 308, 'user_created', 'Created user: lemery-hs-ofc (lemery-hs-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:09:30'),
(710, 1, 'user_created', 'Created user: rosario-admin-acc (rosario-admin-acc) with role: admin at campus: Rosario', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:09:34'),
(711, 365, 'user_created', 'Created user: mabini-ia-ofc (mabini-ia-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:11:01'),
(712, 365, 'user_created', 'Created user: mabini-qam-ofc (mabini-qam-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:11:30'),
(713, NULL, 'user_updated', 'Updated user: lobo-rgo-ofc (lobo-rgo-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:12:06'),
(714, 365, 'user_created', 'Created user: mabini-pdc-ofc (mabini-pdc-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:12:14'),
(715, 365, 'user_created', 'Created user: mabini-ea-ofc (mabini-ea-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:12:38'),
(716, 308, 'user_created', 'Created user: rosario-rgtr-ofc (rosario-rgtr-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:12:45'),
(717, 308, 'user_created', 'Created user: rosario-acct-ofc (rosario-acct-ofc) with role: user at campus: Lemery', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:12:58'),
(718, 365, 'user_created', 'Created user: mabini-rgo-ofc (mabini-rgo-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:13:02'),
(719, NULL, 'user_deleted', 'Deleted user: rosario-acct-ofc (rosario-acct-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:13:08'),
(720, NULL, 'user_deleted', 'Deleted user: rosario-rgtr-ofc (rosario-rgtr-ofc)', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:13:13'),
(721, 365, 'user_created', 'Created user: mabini-ict-ofc (mabini-ict-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:13:25'),
(722, 365, 'user_created', 'Created user: mabini-cas-ofc (mabini-cas-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:13:59'),
(723, 384, 'user_created', 'Created user: rosario-rgtr-ofc (rosario-rgtr-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:14:16'),
(724, 365, 'user_created', 'Created user: mabini-cabe-ofc (mabini-cabe-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:14:30'),
(725, 384, 'user_created', 'Created user: rosario-acct-ofc (rosario-acct-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:14:32'),
(726, 384, 'user_created', 'Created user: rosario-ia-ofc (rosario-ia-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:14:47'),
(727, 365, 'user_created', 'Created user: mabini-cics-ofc (mabini-cics-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:14:57'),
(728, 384, 'user_created', 'Created user: rosario-qam-ofc (rosario-qam-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:15:04'),
(729, 365, 'user_created', 'Created user: mabini-cet-ofc (mabini-cet-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:15:21'),
(730, 384, 'user_created', 'Created user: rosario-pdc-ofc (rosario-pdc-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:15:24'),
(731, 384, 'user_created', 'Created user: rosario-ea-ofc (rosario-ea-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:15:39'),
(732, 365, 'user_created', 'Created user: mabini-cte-ofc (mabini-cte-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:15:42'),
(733, 384, 'user_created', 'Created user: rosario-rgo-ofc (rosario-rgo-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:16:00'),
(734, 365, 'user_created', 'Created user: mabini-ce-ofc (mabini-ce-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:16:05'),
(735, 384, 'user_created', 'Created user: rosario-ict-ofc (rosario-ict-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:16:13'),
(736, 365, 'user_created', 'Created user: mabini-ca-ofc (mabini-ca-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:16:33'),
(737, 384, 'user_created', 'Created user: rosario-cas-ofc (rosario-cas-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:16:33'),
(738, 384, 'user_created', 'Created user: rosario-cabe-ofc (rosario-cabe-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:16:53'),
(739, 365, 'user_created', 'Created user: mabini-tao-ofc (mabini-tao-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:16:57'),
(740, NULL, 'user_updated', 'Updated user: lobo-ict-ofc (lobo-ict-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:17:05'),
(741, NULL, 'user_updated', 'Updated user: lobo-ict-ofc (lobo-ict-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:17:05'),
(742, 384, 'user_created', 'Created user: rosario-cics-ofc (rosario-cics-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:17:10'),
(743, 365, 'user_created', 'Created user: mabini-rs-ofc (mabini-rs-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:17:21'),
(744, NULL, 'user_updated', 'Updated user: lobo-cas-ofc (lobo-cas-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:17:23'),
(745, 384, 'user_created', 'Created user: rosario-cet-ofc (rosario-cet-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:17:25'),
(746, NULL, 'user_updated', 'Updated user: lobo-cabe-ofc (lobo-cabe-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:17:41'),
(747, NULL, 'user_updated', 'Updated user: lobo-cics-ofc (lobo-cics-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:17:58'),
(748, 365, 'user_created', 'Created user: mabini-sfa-ofc (mabini-sfa-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:18:01'),
(749, NULL, 'user_updated', 'Updated user: lobo-cet-ofc (lobo-cet-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:18:21'),
(750, 365, 'user_created', 'Created user: mabini-gc-ofc (mabini-gc-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:18:30'),
(751, 365, 'user_created', 'Created user: mabini-soa-ofc (mabini-soa-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:18:58'),
(752, NULL, 'user_updated', 'Updated user: lobo-cte-ofc (lobo-cte-ofc)', NULL, '2001:4455:8034:c00:8d68:c69d:e0ac:5220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:19:08'),
(753, 384, 'user_created', 'Created user: rosario-cte-ofc (rosario-cte-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:19:21'),
(754, 365, 'user_created', 'Created user: mabini-sd-ofc (mabini-sd-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:1522:bb17:ff37:f905', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:19:31'),
(755, 384, 'user_created', 'Created user: rosario-ce-ofc (rosario-ce-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:19:39'),
(756, 365, 'user_created', 'Created user: mabini-sad-ofc (mabini-sad-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:bd60:f496:e79f:f3c8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:49:56'),
(757, 365, 'user_created', 'Created user: mabini-ojt-ofc (mabini-ojt-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:80e1:ccb2:ff2:425e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:50:22'),
(758, 365, 'user_created', 'Created user: mabini-nstp-ofc (mabini-nstp-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:a897:e11c:3651:a3b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:50:47'),
(759, 365, 'user_created', 'Created user: mabini-hrmo-ofc (mabini-hrmo-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:a897:e11c:3651:a3b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:51:07'),
(760, 365, 'user_created', 'Created user: mabini-rm-ofc (mabini-rm-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:a897:e11c:3651:a3b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:51:30'),
(761, 365, 'user_created', 'Created user: mabini-pcr-ofc (mabini-pcr-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:a897:e11c:3651:a3b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:51:55'),
(762, 365, 'user_created', 'Created user: mabini-bdgt-ofc (mabini-bdgt-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:a897:e11c:3651:a3b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:52:22'),
(763, 365, 'user_created', 'Created user: mabini-cd-ofc (mabini-cd-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:a897:e11c:3651:a3b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:52:47'),
(764, 365, 'user_created', 'Created user: mabini-pfm-ofc (mabini-pfm-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:9174:891e:f89e:d158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:53:13'),
(765, 365, 'user_created', 'Created user: mabini-emu-ofc (mabini-emu-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:9174:891e:f89e:d158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:53:37'),
(766, 365, 'user_created', 'Created user: mabini-psm-ofc (mabini-psm-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:9174:891e:f89e:d158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:54:04'),
(767, 365, 'user_created', 'Created user: mabini-gso-ofc (mabini-gso-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:9174:891e:f89e:d158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:54:31'),
(768, 365, 'user_created', 'Created user: mabini-ext-ofc (mabini-ext-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:9174:891e:f89e:d158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:54:56'),
(769, 365, 'user_created', 'Created user: mabini-rsch-ofc (mabini-rsch-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:9174:891e:f89e:d158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:55:31'),
(770, 365, 'user_created', 'Created user: mabini-hs-ofc (mabini-hs-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:9174:891e:f89e:d158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 12:55:55'),
(771, 384, 'user_created', 'Created user: rosario-ca-ofc (rosario-ca-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:36:58'),
(772, 384, 'user_created', 'Created user: rosario-tao-ofc (rosario-tao-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:37:26'),
(773, 384, 'user_created', 'Created user: rosario-rs-ofc (rosario-rs-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:37:45'),
(774, 384, 'user_created', 'Created user: rosario-sfa-ofc (rosario-sfa-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:37:59'),
(775, 384, 'user_created', 'Created user: rosario-gc-ofc (rosario-gc-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:38:11'),
(776, 384, 'user_created', 'Created user: rosario-soa-ofc (rosario-soa-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:38:33'),
(777, 384, 'user_created', 'Created user: rosario-sd-ofc (rosario-sd-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:38:44'),
(778, 384, 'user_created', 'Created user: rosario-sad-ofc (rosario-sad-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:39:02'),
(779, 384, 'user_created', 'Created user: rosario-ojt-ofc (rosario-ojt-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:39:17'),
(780, 384, 'user_created', 'Created user: rosario-nstp-ofc (rosario-nstp-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:39:30'),
(781, 384, 'user_created', 'Created user: rosario-hrmo-ofc (rosario-hrmo-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:39:47'),
(782, 384, 'user_created', 'Created user: rosario-rm-ofc (rosario-rm-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:40:11'),
(783, 384, 'user_created', 'Created user: rosario-pcr-ofc (rosario-pcr-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:40:32'),
(784, 384, 'user_created', 'Created user: rosario-bdgt-ofc (rosario-bdgt-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:40:59'),
(785, 384, 'user_created', 'Created user: rosario-cd-ofc (rosario-cd-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:41:16'),
(786, 384, 'user_created', 'Created user: rosario-pfm-ofc (rosario-pfm-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:41:35'),
(787, 384, 'user_created', 'Created user: rosario-emu-ofc (rosario-emu-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:41:54'),
(788, 384, 'user_created', 'Created user: rosario-psm-ofc (rosario-psm-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:42:09'),
(789, 384, 'user_created', 'Created user: rosario-gso-ofc (rosario-gso-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:42:27'),
(790, 384, 'user_created', 'Created user: rosario-ext-ofc (rosario-ext-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:42:44'),
(791, 384, 'user_created', 'Created user: rosario-rsch-ofc (rosario-rsch-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:42:58'),
(792, 384, 'user_created', 'Created user: rosario-hs-ofc (rosario-hs-ofc) with role: user at campus: Rosario', NULL, '2405:8d40:4080:d7fc:9502:8401:3f95:6c52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:43:15'),
(793, NULL, 'user_updated', 'Updated user: lobo-bdgt-ofc (lobo-bdgt-ofc)', NULL, '2001:4453:332:ea00:3004:8211:5427:6cf6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-08 13:51:15'),
(794, NULL, 'user_updated', 'Updated user: rosario-acct-ofc (rosario-acct-ofc)', NULL, '2001:4453:332:ea00:d0f4:c16e:8e0d:242c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:53:15'),
(795, NULL, 'user_updated', 'Updated user: mabini-acct-ofc (mabini-acct-ofc)', NULL, '2001:4453:332:ea00:d0f4:c16e:8e0d:242c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:54:13'),
(796, NULL, 'user_updated', 'Updated user: lemery-acct-ofc (lemery-acct-ofc)', NULL, '2001:4453:332:ea00:d0f4:c16e:8e0d:242c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:54:35'),
(797, NULL, 'user_updated', 'Updated user: balayan-acct-ofc (balayan-acct-ofc)', NULL, '2001:4453:332:ea00:d0f4:c16e:8e0d:242c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:54:55'),
(798, NULL, 'user_updated', 'Updated user: malvar-acct-ofc (malvar-acct-ofc)', NULL, '2001:4453:332:ea00:d0f4:c16e:8e0d:242c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:55:06'),
(799, NULL, 'user_updated', 'Updated user: nsb-acct-ofc (nsb-acct-ofc)', NULL, '2001:4453:332:ea00:d0f4:c16e:8e0d:242c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 13:55:16'),
(800, 1, 'user_created', 'Created user: super-admin (super-admin) with role: super_admin at campus: Main Campus', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 14:01:26'),
(801, 1, 'table_assignment', 'Assigned admissiondata table to Accounting Office Lemery', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 14:24:03'),
(802, 1, 'table_assignment', 'Assigned admissiondata table to Accounting Office Pablo Borbon', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 14:24:03'),
(803, 1, 'table_assignment', 'Assigned admissiondata table to Accounting Office Rosario', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 14:24:03'),
(804, 1, 'table_assignment', 'Assigned admissiondata table to Accounting Office San Juan', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 14:24:03'),
(805, 114, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 14:26:34'),
(806, 346, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 14:28:23'),
(807, 396, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 14:30:29'),
(808, 225, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-08 14:32:29'),
(809, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:90b3:c48c:e5f8:3cb9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-09 02:58:21'),
(810, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Rosario', NULL, '2001:4453:332:ea00:90b3:c48c:e5f8:3cb9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-09 02:58:21'),
(811, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Pablo Borbon', NULL, '2001:4453:332:ea00:90b3:c48c:e5f8:3cb9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-09 02:58:21'),
(812, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lemery', NULL, '2001:4453:332:ea00:90b3:c48c:e5f8:3cb9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-09 02:58:21'),
(813, 90, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:90b3:c48c:e5f8:3cb9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-09 02:59:56'),
(814, 351, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:90b3:c48c:e5f8:3cb9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-09 03:11:19'),
(815, 202, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:90b3:c48c:e5f8:3cb9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-09 03:14:12'),
(816, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Alangilan', NULL, '2001:4453:332:ea00:6105:b2af:5770:da0e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 03:41:48'),
(817, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Mabini', NULL, '2001:4453:332:ea00:6105:b2af:5770:da0e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 03:41:48'),
(818, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Balayan', NULL, '2001:4453:332:ea00:6105:b2af:5770:da0e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 03:41:48'),
(819, 391, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 03:47:16'),
(820, 130, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:03:49'),
(821, 315, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:05:32'),
(822, 166, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:06:38'),
(823, 159, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Alangilan', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:08:56'),
(824, 159, 'table_assignment', 'Assigned foodwaste table to Resource Generation Alangilan', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:08:56'),
(825, 166, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:11:10'),
(826, 166, 'report_submission', 'Submitted report: Food Waste (1 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:11:38'),
(827, NULL, 'user_updated', 'Updated user: lobo-ict-ofc (lobo-ict-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:19:26'),
(828, NULL, 'user_updated', 'Updated user: lobo-ce-ofc (lobo-ce-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:24:46'),
(829, NULL, 'user_updated', 'Updated user: lobo-ca-ofc (lobo-ca-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:26:26'),
(830, NULL, 'user_updated', 'Updated user: lobo-ta-ofc (lobo-ta-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:26:40'),
(831, NULL, 'user_updated', 'Updated user: lobo-sfa-ofc (lobo-sfa-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:27:11'),
(832, NULL, 'user_updated', 'Updated user: lobo-gc-ofc (lobo-gc-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:27:26'),
(833, NULL, 'user_updated', 'Updated user: lobo-ls-ofc (lobo-ls-ofc)', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:27:48'),
(834, NULL, 'user_updated', 'Updated user: lobo-soa-ofc (lobo-soa-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:28:03'),
(835, NULL, 'user_updated', 'Updated user: lobo-sd-ofc (lobo-sd-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:28:58'),
(836, NULL, 'user_updated', 'Updated user: lobo-soa-ofc (lobo-soa-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:29:17'),
(837, NULL, 'user_updated', 'Updated user: lobo-sad-ofc (lobo-sad-ofc)', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:29:44'),
(838, NULL, 'user_updated', 'Updated user: lobo-ojt-ofc (lobo-ojt-ofc)', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:29:58'),
(839, NULL, 'user_updated', 'Updated user: lobo-nstp-ofc (lobo-nstp-ofc)', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:30:14'),
(840, NULL, 'user_updated', 'Updated user: lobo-rm-ofc (lobo-rm-ofc)', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:30:27'),
(841, NULL, 'user_updated', 'Updated user: lobo-pcr-ofc (lobo-pcr-ofc)', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:30:42'),
(842, NULL, 'user_updated', 'Updated user: lobo-bdgt-ofc (lobo-bdgt-ofc)', NULL, '180.195.77.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:31:02'),
(843, NULL, 'user_updated', 'Updated user: lobo-cd-ofc (lobo-cd-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:32:18'),
(844, NULL, 'user_updated', 'Updated user: lobo-emu-ofc (lobo-emu-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:32:32'),
(845, NULL, 'user_updated', 'Updated user: lobo-psm-ofc (lobo-psm-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:32:45'),
(846, NULL, 'user_updated', 'Updated user: lobo-gso-ofc (lobo-gso-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:33:04'),
(847, NULL, 'user_updated', 'Updated user: lobo-ext-ofc (lobo-ext-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:33:20'),
(848, NULL, 'user_updated', 'Updated user: lobo-rsch-ofc (lobo-rsch-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:33:59'),
(849, NULL, 'user_updated', 'Updated user: lobo-hrmo-ofc (lobo-hrmo-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:34:23'),
(850, NULL, 'user_updated', 'Updated user: lobo-hs-ofc (lobo-hs-ofc)', NULL, '2001:4455:8034:c00:34ee:1196:b4cb:eab5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-09 04:34:33'),
(851, 82, 'table_assignment', 'Assigned admissiondata table to Accounting Office San Juan', NULL, '2001:4453:332:ea00:7c96:90c:8bee:6cf0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', '2025-11-10 17:17:18'),
(852, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-10 23:19:11'),
(853, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-10 23:19:34'),
(854, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-10 23:41:28'),
(855, 106, 'password_reset_requested', 'Password reset requested for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-10 23:42:41'),
(856, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-10 23:43:02'),
(857, 41, 'login', 'User logged in', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-10 23:50:26'),
(858, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-10 23:55:46'),
(859, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 00:12:04'),
(860, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 00:22:08'),
(861, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:e86b:c61e:6a9e:526f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 00:22:28'),
(862, 83, 'login', 'User logged in', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:41:48'),
(863, 134, 'login', 'User logged in', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:45:12'),
(864, 134, 'logout', 'User logged out', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:45:47'),
(865, 83, 'login', 'User logged in', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:46:13'),
(866, 83, 'table_assignment', 'Assigned libraryvisitor table to College of Informatics and Computing Sciences Lobo', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:46:59'),
(867, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:47:11'),
(868, 134, 'login', 'User logged in', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:47:36'),
(869, 134, 'logout', 'User logged out', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:47:46'),
(870, 133, 'login', 'User logged in', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:47:57'),
(871, 133, 'logout', 'User logged out', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:48:04'),
(872, 134, 'login', 'User logged in', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:48:24'),
(873, 457, 'login', 'User logged in', NULL, '2405:8d40:4496:e7a9:7979:4d2f:6f91:4938', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:48:52'),
(874, 134, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:49:42'),
(875, 394, 'login', 'User logged in', NULL, '2405:8d40:4496:e7a9:7979:4d2f:6f91:4938', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:51:38'),
(876, 134, 'logout', 'User logged out', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:52:44'),
(877, 394, 'logout', 'User logged out', NULL, '2405:8d40:4496:e7a9:7979:4d2f:6f91:4938', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:53:15'),
(878, 83, 'login', 'User logged in', NULL, '2001:4455:8035:f300:3102:4c8d:7fa1:c4c6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 01:53:58'),
(879, 77, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:21:00'),
(880, 77, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:22:06'),
(881, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:22:30');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(882, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:23:53'),
(883, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:29:23'),
(884, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:29:31'),
(885, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:29:52'),
(886, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:43:17'),
(887, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:43:32'),
(888, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:43:52'),
(889, 106, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:47:58'),
(890, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 02:50:04'),
(891, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:04:16'),
(892, 1, 'table_assignment', 'Assigned admissiondata table to Accounting Office Alangilan', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:33:56'),
(893, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:34:45'),
(894, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:35:14'),
(895, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:36:45'),
(896, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:36:45'),
(897, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:37:26'),
(898, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c1d8:6589:6379:accf', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:37:57'),
(899, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:47:15'),
(900, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:47:34'),
(901, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:47:53'),
(902, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:47:58'),
(903, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:1a1:2fb5:e7:b82f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:50:44'),
(904, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:1a1:2fb5:e7:b82f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:51:11'),
(905, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:1a1:2fb5:e7:b82f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:51:45'),
(906, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 03:53:48'),
(907, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 04:11:06'),
(908, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 04:11:26'),
(909, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 04:29:00'),
(910, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 04:39:25'),
(911, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 04:49:50'),
(912, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 04:57:34'),
(913, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 04:57:56'),
(914, 106, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 04:58:19'),
(915, 106, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 05:03:32'),
(916, 106, 'report_submission', 'Submitted report: Solid Waste (2 records)', NULL, '2001:4453:332:ea00:7184:27ab:19e6:dcd3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 05:05:28'),
(917, 90, 'login', 'User logged in', NULL, '2001:4453:332:ea00:69fb:aef4:8c0b:7d6e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-11 05:22:23'),
(918, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 00:01:48'),
(919, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 03:19:26'),
(920, 106, 'password_reset_requested', 'Password reset requested for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 03:20:01'),
(921, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 03:20:17'),
(922, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 03:21:39'),
(923, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 03:22:02'),
(924, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:7c96:90c:8bee:6cf0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', '2025-11-12 03:24:14'),
(925, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 03:27:47'),
(926, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 03:27:55'),
(927, 106, 'password_reset_approved', 'Password reset to default by admin id  for username: lipa-rgo-ofc', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 03:35:56'),
(928, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:10:34'),
(929, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:11:49'),
(930, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:14:52'),
(931, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:15:10'),
(932, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:15:16'),
(933, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:23:12'),
(934, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:23:53'),
(935, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:24:10'),
(936, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:24:28'),
(937, 41, 'login_failed', 'Invalid password', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:24:40'),
(938, 41, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:24:50'),
(939, 41, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:53:02'),
(940, 41, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:53:15'),
(941, 41, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:53:28'),
(942, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 04:53:47'),
(943, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 05:18:48'),
(944, 41, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 05:19:13'),
(945, 41, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 06:31:06'),
(946, 41, 'login', 'User logged in', NULL, '2001:4453:332:ea00:a910:59a6:de70:73f4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 06:31:36'),
(947, 83, 'login', 'User logged in', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:35:13'),
(948, 83, 'table_assignment', 'Assigned graduatesdata table to Environment Management Unit Lobo', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:35:45'),
(949, NULL, 'user_updated', 'Updated user: lobo-hs-ofc (lobo-hs-ofc)', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:36:24'),
(950, NULL, 'user_updated', 'Updated user: lobo-hs-ofc (lobo-hs-ofc)', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:36:31'),
(951, NULL, 'user_updated', 'Updated user: lobo-hs-ofc (lobo-hs-ofc)', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:36:42'),
(952, 83, 'logout', 'User logged out', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:37:34'),
(953, 83, 'login', 'User logged in', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:37:50'),
(954, 83, 'logout', 'User logged out', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:38:22'),
(955, NULL, 'login_failed', 'Failed login: lobo-erm-ofc', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:38:35'),
(956, 83, 'login', 'User logged in', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:39:08'),
(957, 83, 'logout', 'User logged out', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:39:21'),
(958, 152, 'login', 'User logged in', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:39:39'),
(959, 152, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:40:23'),
(960, 152, 'logout', 'User logged out', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:43:21'),
(961, 83, 'login', 'User logged in', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:43:34'),
(962, 83, 'logout', 'User logged out', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:47:31'),
(963, 83, 'login', 'User logged in', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:47:43'),
(964, 83, 'table_assignment', 'Assigned flightaccommodation table to OJT Lobo', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:48:58'),
(965, 83, 'logout', 'User logged out', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:49:22'),
(966, 146, 'login_failed', 'Invalid password', NULL, '180.195.70.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:49:42'),
(967, 146, 'login', 'User logged in', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:49:57'),
(968, 146, 'report_submission', 'Submitted report: Flight Accommodation (1 records)', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:51:26'),
(969, 146, 'logout', 'User logged out', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:52:49'),
(970, 83, 'login', 'User logged in', NULL, '2001:4455:8035:f300:c5d2:5d82:9732:93ee', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 10:53:07'),
(971, 83, 'login', 'User logged in', NULL, '2001:4455:80b1:8700:59f0:5bf6:d5a5:225d', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 12:04:14'),
(972, 83, 'logout', 'User logged out', NULL, '2001:4455:80b1:8700:59f0:5bf6:d5a5:225d', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 12:04:59'),
(973, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 13:06:23'),
(974, 106, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 13:06:57'),
(975, 106, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 13:13:53'),
(976, 106, 'report_submission', 'Submitted report: Treated Waste Water (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 13:14:32'),
(977, 106, 'report_submission', 'Submitted report: Electricity Consumption (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 13:27:34'),
(978, 106, 'report_submission', 'Submitted report: Campus Population (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 13:33:15'),
(979, 106, 'report_submission', 'Submitted report: Food Waste (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 13:47:05'),
(980, 106, 'report_submission', 'Submitted report: Budget Expenditure (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 13:54:20'),
(981, 106, 'report_submission', 'Submitted report: Flight Accommodation (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:11:11'),
(982, 106, 'report_submission', 'Submitted report: Distance Traveled (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:13:30'),
(983, 106, 'report_submission', 'Submitted report: Fuel Consumption (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:24:50'),
(984, 106, 'report_submission', 'Submitted report: Fuel Consumption (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:25:31'),
(985, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:33:46'),
(986, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:33:58'),
(987, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(988, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(989, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(990, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(991, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(992, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(993, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(994, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(995, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(996, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(997, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(998, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(999, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(1000, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(1001, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(1002, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(1003, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:54'),
(1004, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:34:59'),
(1005, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:35:28'),
(1006, 106, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:35:51'),
(1007, 106, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:39:18'),
(1008, 106, 'report_submission', 'Submitted report: Graduates Data (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:44:37'),
(1009, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:45:25'),
(1010, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:45:39'),
(1011, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:46:06'),
(1012, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:46:25'),
(1013, 41, 'login', 'User logged in', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:47:26'),
(1014, 106, 'report_submission', 'Submitted report: Employee Data (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:55:03'),
(1015, 106, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 14:55:48'),
(1016, 106, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 15:03:58'),
(1017, 106, 'report_submission', 'Submitted report: Library Visitor (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 15:12:36'),
(1018, 106, 'report_submission', 'Submitted report: Water Consumption (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 15:19:56'),
(1019, 106, 'report_submission', 'Submitted report: Treated Waste Water (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 15:24:43'),
(1020, 106, 'report_submission', 'Submitted report: Electricity Consumption (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 15:36:25'),
(1021, 106, 'report_submission', 'Submitted report: Solid Waste (2 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 15:53:14'),
(1022, 106, 'report_submission', 'Submitted report: Campus Population (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:01:49'),
(1023, 106, 'report_submission', 'Submitted report: Food Waste (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:08:32'),
(1024, 106, 'report_submission', 'Submitted report: Fuel Consumption (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:09:22'),
(1025, 106, 'report_submission', 'Submitted report: Distance Traveled (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:17:13'),
(1026, 106, 'report_submission', 'Submitted report: Budget Expenditure (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:26:07'),
(1027, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:35:30'),
(1028, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:35:39'),
(1029, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1030, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1031, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1032, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1033, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1034, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1035, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1036, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1037, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1038, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1039, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1040, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1041, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1042, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1043, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1044, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:09'),
(1045, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:13'),
(1046, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:36:25'),
(1047, 106, 'report_submission', 'Submitted report: Flight Accommodation (1 records)', NULL, '2001:4453:332:ea00:19d0:7d2f:5564:8427', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-12 16:37:01'),
(1048, 1, 'login', 'User logged in', NULL, '216.247.84.215', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-13 11:14:16'),
(1049, 1, 'login', 'User logged in', NULL, '216.247.84.215', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-13 11:15:12'),
(1050, 106, 'login', 'User logged in', NULL, '216.247.84.215', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-13 11:17:34'),
(1051, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 03:41:44'),
(1052, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 03:43:36'),
(1053, 106, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 03:44:00'),
(1054, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 03:48:30'),
(1055, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 04:46:33'),
(1056, 74, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 04:47:34'),
(1057, 74, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 04:50:06'),
(1058, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 04:50:18'),
(1059, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:d8b8:6127:5143:ed7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 04:56:40'),
(1060, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 04:59:04'),
(1061, 1, 'table_assignment', 'Assigned enrollmentdata table to Registrar Office Lipa', NULL, '2001:4453:332:ea00:d8b8:6127:5143:ed7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 05:13:21'),
(1062, 42, 'login', 'User logged in', NULL, '2001:4453:332:ea00:d8b8:6127:5143:ed7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 05:14:07'),
(1063, 42, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2001:4453:332:ea00:d8b8:6127:5143:ed7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 05:16:55'),
(1064, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 05:43:27'),
(1065, 41, 'login', 'User logged in', NULL, '2001:4453:332:ea00:d8b8:6127:5143:ed7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '2025-11-14 05:46:19'),
(1066, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 06:15:23'),
(1067, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 06:15:31'),
(1068, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 06:48:22'),
(1069, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:bdfc:4451:981d:edf5', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_8 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/125.0.6422.145 Mobile/15E148 Safari/604.1', '2025-11-14 06:52:23'),
(1070, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:bdfc:4451:981d:edf5', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_8 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/125.0.6422.145 Mobile/15E148 Safari/604.1', '2025-11-14 06:52:41'),
(1071, NULL, 'user_updated', 'Updated user: lipa-hrmo-ofc (lipa-hrmo-ofc)', NULL, '2001:4453:332:ea00:d8b8:6127:5143:ed7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 07:13:46'),
(1072, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 07:51:42'),
(1073, 42, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c898:f15c:f79e:93d6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 08:46:17'),
(1074, 93, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c898:f15c:f79e:93d6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 08:46:42'),
(1075, NULL, 'user_deleted', 'Deleted user: lobo-ooc-ofc (lobo-ooc-ofc)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 08:55:00'),
(1076, NULL, 'user_deleted', 'Deleted user: lipa-ooc-ofc (lipa-ooc-ofc)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 08:55:25'),
(1077, 1, 'user_created', 'Created user: lobo-pfm-ofc (lobo-pfm-ofc) with role: user at campus: ', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 08:59:16'),
(1078, NULL, 'user_updated', 'Updated user: lobo-pfm-ofc (lobo-pfm-ofc)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 08:59:33'),
(1079, 93, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:00:06'),
(1080, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:00:27'),
(1081, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:00:58'),
(1082, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:04:13'),
(1083, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:05:03');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(1084, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:07:35'),
(1085, 106, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:08:20'),
(1086, 106, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:08:54'),
(1087, 106, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:09:31'),
(1088, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:64a8:2e61:cb3c:83cc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:11:50'),
(1089, 106, 'report_submission', 'Submitted report: Admission Data (2 records)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:12:39'),
(1090, 106, 'report_submission', 'Submitted report: PWD (2 records)', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:15:37'),
(1091, 41, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '2025-11-14 09:17:17'),
(1092, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 09:17:25'),
(1093, 106, 'report_submission', 'Submitted report: Solid Waste (2 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 11:56:16'),
(1094, 106, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:04:31'),
(1095, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:05:23'),
(1096, 106, 'report_submission', 'Submitted report: Library Visitor (2 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:05:57'),
(1097, 106, 'report_submission', 'Submitted report: Food Waste (3 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:40:39'),
(1098, 106, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:41:55'),
(1099, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:45:17'),
(1100, 106, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:46:07'),
(1101, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:53:36'),
(1102, 106, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:54:15'),
(1103, 106, 'report_submission', 'Submitted report: Treated Waste Water (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:54:43'),
(1104, 106, 'report_submission', 'Submitted report: Electricity Consumption (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:55:13'),
(1105, 106, 'report_submission', 'Submitted report: Campus Population (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:56:34'),
(1106, 106, 'report_submission', 'Submitted report: Fuel Consumption (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 12:59:02'),
(1107, 106, 'report_submission', 'Submitted report: Distance Traveled (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:00:08'),
(1108, 106, 'report_submission', 'Submitted report: Budget Expenditure (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:00:36'),
(1109, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1110, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1111, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1112, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1113, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1114, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1115, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1116, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1117, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1118, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1119, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1120, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1121, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1122, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1123, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1124, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1125, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:01:30'),
(1126, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:06:40'),
(1127, 106, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:07:03'),
(1128, 106, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:07:44'),
(1129, 106, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:08:07'),
(1130, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:11:04'),
(1131, 106, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:11:25'),
(1132, 106, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:12:03'),
(1133, 106, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:13:00'),
(1134, 106, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:13:42'),
(1135, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:19:18'),
(1136, 106, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:26:59'),
(1137, 106, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:27:42'),
(1138, 106, 'report_submission', 'Submitted report: Treated Waste Water (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:28:14'),
(1139, 106, 'report_submission', 'Submitted report: Electricity Consumption (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:28:51'),
(1140, 106, 'report_submission', 'Submitted report: Solid Waste (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:29:24'),
(1141, 106, 'report_submission', 'Submitted report: Food Waste (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:30:22'),
(1142, 106, 'report_submission', 'Submitted report: Fuel Consumption (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:31:53'),
(1143, 106, 'report_submission', 'Submitted report: Distance Traveled (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:32:48'),
(1144, 106, 'report_submission', 'Submitted report: Budget Expenditure (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:33:19'),
(1145, 106, 'report_submission', 'Submitted report: Flight Accommodation (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:34:10'),
(1146, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:35:36'),
(1147, 90, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:41:23'),
(1148, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:41:34'),
(1149, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1150, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1151, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1152, 1, 'table_assignment', 'Assigned employee table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1153, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1154, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1155, 1, 'table_assignment', 'Assigned pwd table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1156, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1157, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1158, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1159, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1160, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1161, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1162, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1163, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1164, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1165, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation San Juan', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 13:42:11'),
(1166, 106, 'report_submission', 'Submitted report: Flight Accommodation (1 records)', NULL, '2001:4453:332:ea00:a400:39df:f717:3e15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 14:01:35'),
(1167, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 14:07:37'),
(1168, 90, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c02:672a:f607:6ff5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-14 14:07:47'),
(1169, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 02:12:54'),
(1170, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 02:50:27'),
(1171, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 05:24:06'),
(1172, NULL, 'user_updated', 'Updated user: lipa-rgo-ofc (lipa-rgo-ofc)', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 06:45:58'),
(1173, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 06:46:16'),
(1174, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 06:46:43'),
(1175, NULL, 'user_updated', 'Updated user: lobo-pfm-ofc (lobo-pfm-ofc)', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 06:55:46'),
(1176, NULL, 'user_updated', 'Updated user: lobo-pfm-ofc (lobo-pfm-ofc)', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 07:08:27'),
(1177, 457, 'login', 'User logged in', NULL, '2001:4453:332:ea00:e099:65f9:3b58:9952', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 07:16:05'),
(1178, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 07:18:38'),
(1179, 457, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:e099:65f9:3b58:9952', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 07:19:28'),
(1180, 106, 'report_submission', 'Submitted report: Admission Data (3 records)', NULL, '2001:4453:332:ea00:c14b:c3b8:97ea:896b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 07:20:45'),
(1181, NULL, 'user_updated', 'Updated user: lipa-ls-ofc (lipa-ls-ofc)', NULL, '2001:4453:332:ea00:e099:65f9:3b58:9952', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 07:22:26'),
(1182, NULL, 'user_deleted', 'Deleted user: lipa-ls-ofc (lipa-ls-ofc)', NULL, '2001:4453:332:ea00:e099:65f9:3b58:9952', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 07:23:03'),
(1183, 457, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 08:48:49'),
(1184, 83, 'login', 'User logged in', NULL, '2001:4455:8027:9700:c16f:f1c1:6f39:c35a', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 09:39:27'),
(1185, 83, 'login', 'User logged in', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:05:31'),
(1186, 83, 'table_assignment', 'Assigned graduatesdata table to Accounting Office Lobo', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:06:40'),
(1187, 83, 'logout', 'User logged out', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:06:49'),
(1188, 83, 'login', 'User logged in', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:07:23'),
(1189, 83, 'logout', 'User logged out', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:08:14'),
(1190, 124, 'login_failed', 'Invalid password', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:08:41'),
(1191, 124, 'login_failed', 'Invalid password', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:09:03'),
(1192, 83, 'login', 'User logged in', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:09:34'),
(1193, NULL, 'user_updated', 'Updated user: lobo-acct-ofc (lobo-acct-ofc)', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:10:17'),
(1194, 83, 'logout', 'User logged out', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:10:23'),
(1195, 124, 'login', 'User logged in', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:10:48'),
(1196, 124, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:11:49'),
(1197, 124, 'logout', 'User logged out', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:12:05'),
(1198, 83, 'login', 'User logged in', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:12:23'),
(1199, 83, 'logout', 'User logged out', NULL, '180.195.77.153', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:14:59'),
(1200, 124, 'login', 'User logged in', NULL, '180.195.77.153', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:15:24'),
(1201, 124, 'logout', 'User logged out', NULL, '2001:4455:8035:4200:d4e6:f1e6:b6e0:9334', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:19:23'),
(1202, 83, 'login', 'User logged in', NULL, '180.195.77.153', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:22:06'),
(1203, 83, 'logout', 'User logged out', NULL, '180.195.77.153', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:22:37'),
(1204, 124, 'login_failed', 'Invalid password', NULL, '180.195.77.153', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:22:59'),
(1205, 124, 'login', 'User logged in', NULL, '180.195.77.153', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 10:23:20'),
(1206, 83, 'login', 'User logged in', NULL, '180.195.77.153', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1', '2025-11-15 11:02:30'),
(1207, 83, 'logout', 'User logged out', NULL, '180.195.77.153', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Mobile/15E148 Safari/604.1', '2025-11-15 11:02:48'),
(1208, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 11:49:41'),
(1209, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 11:57:48'),
(1210, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 11:58:50'),
(1211, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 12:03:22'),
(1212, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 12:07:24'),
(1213, 41, 'login', 'User logged in', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 12:13:19'),
(1214, 41, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 12:42:21'),
(1215, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 12:42:35'),
(1216, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 12:43:53'),
(1217, 384, 'login', 'User logged in', NULL, '2405:8d40:4c92:bed3:4111:d476:a58e:12d5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 13:50:24'),
(1218, 384, 'logout', 'User logged out', NULL, '2405:8d40:4c92:bed3:4111:d476:a58e:12d5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 13:51:32'),
(1219, 457, 'login', 'User logged in', NULL, '2405:8d40:4c92:bed3:4111:d476:a58e:12d5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 13:51:52'),
(1220, 106, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 14:16:47'),
(1221, 106, 'report_submission', 'Submitted report: Solid Waste (1 records)', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 14:31:47'),
(1222, 106, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 14:32:57'),
(1223, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 14:33:46'),
(1224, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 15:17:29'),
(1225, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 15:19:32'),
(1226, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 15:56:08'),
(1227, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 15:57:24'),
(1228, 106, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 15:59:13'),
(1229, NULL, 'user_updated', 'Updated user: lipa-rgo-ofc (lipa-rgo-ofc)', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:00:09'),
(1230, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:00:45'),
(1231, NULL, 'user_updated', 'Updated user: lobo-ls-ofc (lobo-ls-ofc)', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:05:33'),
(1232, 1, 'user_created', 'Created user: lipa-rs-ofc (lipa-rs-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:09:38'),
(1233, 106, 'report_submission', 'Submitted report: Campus Population (1 records)', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:12:33'),
(1234, 1, 'user_created', 'Created user: lipa-ls-ofc (lipa-ls-ofc) with role: user at campus: Lipa', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:15:56'),
(1235, 1, 'user_created', 'Created user: alngln-ls-ofc (alngln-ls-ofc) with role: user at campus: Alangilan', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:17:34'),
(1236, 1, 'user_created', 'Created user: pb-ls-ofc (pb-ls-ofc) with role: user at campus: Pablo Borbon', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:18:52'),
(1237, 1, 'user_created', 'Created user: nsb-ls-ofc (nsb-ls-ofc) with role: user at campus: Nasugbu', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:20:30'),
(1238, 1, 'user_created', 'Created user: balayan-ls-ofc (balayan-ls-ofc) with role: user at campus: Balayan', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:22:01'),
(1239, 1, 'user_created', 'Created user: malvar-ls-ofc (malvar-ls-ofc) with role: user at campus: Malvar', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:23:26'),
(1240, 1, 'user_created', 'Created user: lemery-ls-ofc (lemery-ls-ofc) with role: user at campus: Lemery', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:24:58'),
(1241, 1, 'user_created', 'Created user: lobo-ls-ofc (lobo-ls-ofc) with role: user at campus: Lobo', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:26:34'),
(1242, 1, 'user_created', 'Created user: mabini-ls-ofc (mabini-ls-ofc) with role: user at campus: Mabini', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:28:28'),
(1243, 1, 'user_created', 'Created user: rosario-ls-ofc (rosario-ls-ofc) with role: user at campus: Rosario', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:29:31'),
(1244, 1, 'user_created', 'Created user: sj-ls-ofc (sj-ls-ofc) with role: user at campus: San Juan', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:30:56'),
(1245, 466, 'login', 'User logged in', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:33:29'),
(1246, 466, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:24fe:b222:d78a:44b0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:33:39'),
(1247, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:58:14'),
(1248, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:b118:829b:332c:1b21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 16:59:05'),
(1249, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:5816:16d3:b24a:e0d6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 21:56:24'),
(1250, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:5816:16d3:b24a:e0d6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 23:06:15'),
(1251, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lipa', NULL, '2001:4453:332:ea00:5816:16d3:b24a:e0d6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 00:18:44'),
(1252, 83, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 02:12:46'),
(1253, 83, 'table_assignment', 'Assigned admissiondata table to Accounting Office Lobo', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 02:15:28'),
(1254, 83, 'logout', 'User logged out', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 02:15:33'),
(1255, 124, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 02:15:51'),
(1256, 83, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 02:19:01'),
(1257, 83, 'table_assignment', 'Assigned employee table to Accounting Office Lobo', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 02:19:24'),
(1258, 83, 'table_assignment', 'Assigned pwd table to Accounting Office Lobo', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 02:19:44'),
(1259, 83, 'logout', 'User logged out', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 02:19:46'),
(1260, 124, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 02:20:04'),
(1261, 457, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:d1e:c3f:970c:252d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 03:19:34'),
(1262, 457, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:d1e:c3f:970c:252d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 03:20:37'),
(1263, 41, 'login', 'User logged in', NULL, '136.158.79.152', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 05:52:34'),
(1264, 106, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 07:10:52'),
(1265, 106, 'data_import', NULL, 'Imported 2 rows to employee from file: Employee_Data_all_reports.csv', '209.35.170.61', NULL, '2025-11-16 07:21:10'),
(1266, 106, 'login', 'User logged in', NULL, '136.158.79.152', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 07:26:08'),
(1267, 106, 'logout', 'User logged out', NULL, '136.158.79.152', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 07:27:13'),
(1268, 106, 'data_import', NULL, 'Imported 2 rows to employee from file: Employee_Data_all_reports.csv', '209.35.170.61', NULL, '2025-11-16 07:46:41'),
(1269, 1, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 07:54:23'),
(1270, 106, 'data_import', NULL, 'Imported 2 rows to employee from file: Employee_Data_all_reports.csv', '209.35.170.61', NULL, '2025-11-16 07:57:35'),
(1271, 106, 'data_import', NULL, 'Imported 2 rows to employee from file: Employee_Data_all_reports.csv', '209.35.170.61', NULL, '2025-11-16 08:20:30'),
(1272, 106, 'data_import', NULL, 'Imported 2 rows to employee from file: Employee_Data_all_reports.csv', '209.35.170.61', NULL, '2025-11-16 09:11:02'),
(1273, 106, 'data_import', NULL, 'Imported 2 rows to employee from file: Employee_Data_all_reports.csv', '209.35.170.61', NULL, '2025-11-16 09:16:10'),
(1274, 106, 'data_import', NULL, 'Imported 2 rows to employee from file: Employee_Data_all_reports.csv', '209.35.170.61', NULL, '2025-11-16 09:28:18'),
(1275, 106, 'logout', 'User logged out', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 09:30:39'),
(1276, 106, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 09:30:59'),
(1277, 106, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 09:31:36'),
(1278, 106, 'logout', 'User logged out', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 10:21:22'),
(1279, 106, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 10:21:54'),
(1280, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 10:22:53'),
(1281, 1, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 10:23:32'),
(1282, 1, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 10:47:38'),
(1283, 106, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 10:48:28'),
(1284, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 10:49:08');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(1285, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 10:49:40'),
(1286, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:12:32'),
(1287, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:12:55'),
(1288, 83, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:44:27'),
(1289, 83, 'logout', 'User logged out', NULL, '180.195.79.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:45:41'),
(1290, 124, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:45:58'),
(1291, 124, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:47:28'),
(1292, 124, 'logout', 'User logged out', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:47:47'),
(1293, 83, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:47:58'),
(1294, 83, 'logout', 'User logged out', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:48:44'),
(1295, 124, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:49:08'),
(1296, 124, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:49:44'),
(1297, 124, 'logout', 'User logged out', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 11:50:13'),
(1298, 1, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:12:14'),
(1299, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1300, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1301, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1302, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1303, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1304, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1305, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1306, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1307, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1308, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1309, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1310, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1311, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1312, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1313, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1314, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1315, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Lipa', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:01'),
(1316, 106, 'report_submission', 'Submitted report: Admission Data (3 records)', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:13:59'),
(1317, 1, 'logout', 'User logged out', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:21:12'),
(1318, 1, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:21:41'),
(1319, 106, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:22:59'),
(1320, 106, 'report_submission', 'Submitted report: Library Visitor (5 records)', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:27:08'),
(1321, 106, 'report_submission', 'Submitted report: Employee Data (3 records)', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:38:04'),
(1322, 106, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:45:03'),
(1323, NULL, 'login_failed', 'Failed login: sj-admin-acc', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:50:02'),
(1324, NULL, 'login_failed', 'Failed login: sj-admin-acc', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:50:20'),
(1325, 90, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:50:41'),
(1326, 83, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:30af:df4d:5ca8:bb62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:51:29'),
(1327, 90, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:51:37'),
(1328, 82, 'login_failed', 'Invalid password', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:51:48'),
(1329, 82, 'login_failed', 'Invalid password', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:52:07'),
(1330, 82, 'login_failed', 'Invalid password', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:53:06'),
(1331, 82, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:53:15'),
(1332, 82, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:54:38'),
(1333, 82, 'login_failed', 'Invalid password', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:57:14'),
(1334, 82, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:57:22'),
(1335, 82, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:57:30'),
(1336, 82, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:58:28'),
(1337, 82, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 12:59:36'),
(1338, 82, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:00:11'),
(1339, 90, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:01:15'),
(1340, 1, 'logout', 'User logged out', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:26:09'),
(1341, 1, 'login', 'User logged in', NULL, '209.35.170.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:26:46'),
(1342, 90, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:31:10'),
(1343, 82, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:34:46'),
(1344, 82, 'table_assignment', 'Assigned admissiondata table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1345, 82, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1346, 82, 'table_assignment', 'Assigned graduatesdata table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1347, 82, 'table_assignment', 'Assigned employee table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1348, 82, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1349, 82, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1350, 82, 'table_assignment', 'Assigned pwd table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1351, 82, 'table_assignment', 'Assigned waterconsumption table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1352, 82, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1353, 82, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1354, 82, 'table_assignment', 'Assigned solidwaste table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1355, 82, 'table_assignment', 'Assigned campuspopulation table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1356, 82, 'table_assignment', 'Assigned foodwaste table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1357, 82, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1358, 82, 'table_assignment', 'Assigned distancetraveled table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1359, 82, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1360, 82, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation San Juan', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:16'),
(1361, 90, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:35:31'),
(1362, 90, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:36:04'),
(1363, 90, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:43:01'),
(1364, 90, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:43:42'),
(1365, 90, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:44:30'),
(1366, 90, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:45:10'),
(1367, 90, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:45:48'),
(1368, 90, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:47:01'),
(1369, 82, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:47:54'),
(1370, 82, 'login', 'User logged in', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:50:43'),
(1371, 82, 'table_assignment', 'Assigned admissiondata table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1372, 82, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1373, 82, 'table_assignment', 'Assigned graduatesdata table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1374, 82, 'table_assignment', 'Assigned employee table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1375, 82, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1376, 82, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1377, 82, 'table_assignment', 'Assigned pwd table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1378, 82, 'table_assignment', 'Assigned waterconsumption table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1379, 82, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1380, 82, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1381, 82, 'table_assignment', 'Assigned solidwaste table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1382, 82, 'table_assignment', 'Assigned campuspopulation table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1383, 82, 'table_assignment', 'Assigned foodwaste table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1384, 82, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1385, 82, 'table_assignment', 'Assigned distancetraveled table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1386, 82, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1387, 82, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation San Juan', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:05'),
(1388, 90, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:22'),
(1389, 90, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:51:52'),
(1390, 90, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:52:27'),
(1391, 90, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:52:58'),
(1392, 90, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:53:26'),
(1393, 90, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:53:52'),
(1394, 90, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:54:13'),
(1395, 90, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:54:46'),
(1396, 90, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:55:20'),
(1397, 90, 'report_submission', 'Submitted report: Treated Waste Water (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:55:43'),
(1398, 90, 'report_submission', 'Submitted report: Electricity Consumption (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:56:20'),
(1399, 90, 'report_submission', 'Submitted report: Solid Waste (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:56:55'),
(1400, 90, 'report_submission', 'Submitted report: Campus Population (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:57:30'),
(1401, 90, 'report_submission', 'Submitted report: Food Waste (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:57:58'),
(1402, 90, 'report_submission', 'Submitted report: Fuel Consumption (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:58:39'),
(1403, 90, 'report_submission', 'Submitted report: Distance Traveled (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:59:11'),
(1404, 90, 'report_submission', 'Submitted report: Budget Expenditure (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 13:59:43'),
(1405, 90, 'report_submission', 'Submitted report: Flight Accommodation (1 records)', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 14:00:31'),
(1406, 82, 'logout', 'User logged out', NULL, '131.226.104.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 14:01:14'),
(1407, 90, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 14:01:48'),
(1408, 90, 'login', 'User logged in', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 14:06:03'),
(1409, 90, 'logout', 'User logged out', NULL, '2405:8d40:4082:1464:447:b537:b370:eee4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 14:07:03'),
(1410, 1, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 14:42:34'),
(1411, 106, 'login_failed', 'Invalid password', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 14:44:40'),
(1412, 106, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 14:44:49'),
(1413, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1414, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1415, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1416, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1417, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1418, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1419, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1420, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1421, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1422, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1423, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1424, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1425, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1426, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1427, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1428, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1429, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Lipa', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:06:53'),
(1430, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:07:34'),
(1431, 106, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:10:28'),
(1432, 106, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:11:32'),
(1433, 106, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:12:20'),
(1434, 106, 'report_submission', 'Submitted report: Leave Privilege (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:12:53'),
(1435, 106, 'report_submission', 'Submitted report: Library Visitor (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:13:20'),
(1436, 106, 'report_submission', 'Submitted report: PWD (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:14:12'),
(1437, 106, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:17:01'),
(1438, 106, 'report_submission', 'Submitted report: Treated Waste Water (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:17:32'),
(1439, 106, 'report_submission', 'Submitted report: Electricity Consumption (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:19:00'),
(1440, 106, 'report_submission', 'Submitted report: Solid Waste (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:19:58'),
(1441, 106, 'report_submission', 'Submitted report: Campus Population (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:20:26'),
(1442, 106, 'report_submission', 'Submitted report: Food Waste (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:21:16'),
(1443, 106, 'report_submission', 'Submitted report: Fuel Consumption (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:23:32'),
(1444, 106, 'report_submission', 'Submitted report: Distance Traveled (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:24:12'),
(1445, 106, 'report_submission', 'Submitted report: Budget Expenditure (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:27:27'),
(1446, 106, 'report_submission', 'Submitted report: Flight Accommodation (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:29:57'),
(1447, 106, 'logout', 'User logged out', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:30:33'),
(1448, 130, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:09'),
(1449, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1450, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1451, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1452, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1453, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1454, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1455, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1456, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1457, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1458, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1459, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1460, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1461, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1462, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1463, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1464, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1465, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Lobo', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:31:46'),
(1466, 130, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:40:13'),
(1467, 130, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:47:01'),
(1468, 1, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 15:55:11'),
(1469, 1, 'login', 'User logged in', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 22:31:23'),
(1470, 1, 'logout', 'User logged out', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 22:34:53'),
(1471, 1, 'login', 'User logged in', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 22:35:08'),
(1472, 1, 'login', 'User logged in', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 22:35:28'),
(1473, 1, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 23:49:26'),
(1474, 196, 'login_failed', 'Invalid password', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 23:59:40'),
(1475, 196, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-16 23:59:56'),
(1476, 196, 'logout', 'User logged out', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:12:07'),
(1477, 106, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:12:28'),
(1478, 106, 'logout', 'User logged out', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:13:59'),
(1479, 1, 'logout', 'User logged out', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:14:09'),
(1480, 124, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:15:31'),
(1481, 124, 'logout', 'User logged out', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:16:16'),
(1482, 124, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:16:30'),
(1483, 124, 'logout', 'User logged out', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:16:50'),
(1484, 1, 'login_failed', 'Invalid password', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:57:48'),
(1485, 1, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 00:58:13'),
(1486, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1487, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1488, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1489, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(1490, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1491, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1492, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1493, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1494, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1495, 1, 'table_assignment', 'Assigned employee table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1496, 1, 'table_assignment', 'Assigned employee table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1497, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1498, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1499, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1500, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1501, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1502, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1503, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1504, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1505, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1506, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1507, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1508, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1509, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1510, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1511, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1512, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1513, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1514, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1515, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1516, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1517, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1518, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1519, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1520, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1521, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1522, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1523, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1524, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1525, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1526, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1527, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1528, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1529, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1530, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1531, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1532, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1533, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1534, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Pablo Borbon', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1535, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Rosario', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1536, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Lemery', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:04'),
(1537, 1, 'logout', 'User logged out', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:14'),
(1538, 202, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:01:49'),
(1539, 1, 'login', 'User logged in', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:02:57'),
(1540, 202, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '110.54.193.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:04:44'),
(1541, 202, 'report_submission', 'Submitted report: Enrollment Data (1 records)', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:09:42'),
(1542, 202, 'logout', 'User logged out', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:19:36'),
(1543, 130, 'login', 'User logged in', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:20:09'),
(1544, 130, 'report_submission', 'Submitted report: Graduates Data (1 records)', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:20:43'),
(1545, 130, 'login', 'User logged in', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:26:25'),
(1546, 130, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 01:26:55'),
(1547, 130, 'login', 'User logged in', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:00:12'),
(1548, 1, 'logout', 'User logged out', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:01:54'),
(1549, 106, 'login', 'User logged in', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:02:30'),
(1550, 130, 'logout', 'User logged out', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:03:09'),
(1551, 1, 'login', 'User logged in', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:03:44'),
(1552, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:04:15'),
(1553, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:04:52'),
(1554, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation San Juan', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:07:24'),
(1555, 106, 'logout', 'User logged out', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:07:31'),
(1556, 90, 'login', 'User logged in', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:07:58'),
(1557, 90, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:08:21'),
(1558, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:18:45'),
(1559, 90, 'logout', 'User logged out', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:18:59'),
(1560, 106, 'login_failed', 'Invalid password', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:19:16'),
(1561, 106, 'login', 'User logged in', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:19:25'),
(1562, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 02:19:54'),
(1563, 1, 'login', 'User logged in', NULL, '110.54.190.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:00:24'),
(1564, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1565, 1, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1566, 1, 'table_assignment', 'Assigned graduatesdata table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1567, 1, 'table_assignment', 'Assigned employee table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1568, 1, 'table_assignment', 'Assigned leaveprivilege table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1569, 1, 'table_assignment', 'Assigned libraryvisitor table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1570, 1, 'table_assignment', 'Assigned pwd table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1571, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1572, 1, 'table_assignment', 'Assigned treatedwastewater table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1573, 1, 'table_assignment', 'Assigned electricityconsumption table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1574, 1, 'table_assignment', 'Assigned solidwaste table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1575, 1, 'table_assignment', 'Assigned campuspopulation table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1576, 1, 'table_assignment', 'Assigned foodwaste table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1577, 1, 'table_assignment', 'Assigned fuelconsumption table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1578, 1, 'table_assignment', 'Assigned distancetraveled table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1579, 1, 'table_assignment', 'Assigned budgetexpenditure table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1580, 1, 'table_assignment', 'Assigned flightaccommodation table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:00'),
(1581, 106, 'login_failed', 'Invalid password', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:25'),
(1582, 106, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:38'),
(1583, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:26:55'),
(1584, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lipa', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:27:33'),
(1585, 106, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:27:58'),
(1586, 106, 'logout', 'User logged out', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:32:34'),
(1587, 1, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:32:52'),
(1588, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Pablo Borbon', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:34:41'),
(1589, 1, 'logout', 'User logged out', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:34:53'),
(1590, 202, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:35:37'),
(1591, 202, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:36:48'),
(1592, 202, 'logout', 'User logged out', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:37:46'),
(1593, 196, 'login_failed', 'Invalid password', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:38:46'),
(1594, 196, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:39:12'),
(1595, 196, 'logout', 'User logged out', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:39:56'),
(1596, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation San Juan', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:40:26'),
(1597, 90, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:41:04'),
(1598, 90, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:41:25'),
(1599, 90, 'logout', 'User logged out', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:41:48'),
(1600, 196, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:42:22'),
(1601, 196, 'logout', 'User logged out', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:42:40'),
(1602, 159, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:43:17'),
(1603, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lobo', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:44:56'),
(1604, 159, 'logout', 'User logged out', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:45:02'),
(1605, 83, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:45:47'),
(1606, 83, 'table_assignment', 'Assigned enrollmentdata table to Resource Generation Lobo', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:46:17'),
(1607, 83, 'logout', 'User logged out', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:46:22'),
(1608, 130, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:46:54'),
(1609, 130, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:47:49'),
(1610, 130, 'logout', 'User logged out', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:48:32'),
(1611, 159, 'login', 'User logged in', NULL, '2001:4453:85:0:416a:541b:ecaf:742f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 03:49:00'),
(1612, 1, 'logout', 'User logged out', NULL, '49.144.35.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 04:52:08'),
(1613, 159, 'logout', 'User logged out', NULL, '49.144.35.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 04:52:20'),
(1614, 41, 'login_failed', 'Invalid password', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:44:27'),
(1615, 41, 'login', 'User logged in', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:44:43'),
(1616, 41, 'table_assignment', 'Assigned employee table to Human Resource Management Lipa', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:46:13'),
(1617, 80, 'login', 'User logged in', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:46:43'),
(1618, 80, 'report_submission', 'Submitted report: Employee Data (1 records)', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:47:24'),
(1619, 41, 'logout', 'User logged out', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:49:42'),
(1620, 1, 'login', 'User logged in', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:50:10'),
(1621, 80, 'logout', 'User logged out', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:50:38'),
(1622, 1, 'table_assignment', 'Assigned admissiondata table to Resource Generation Lobo', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:52:18'),
(1623, 130, 'login_failed', 'Invalid password', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:52:44'),
(1624, 130, 'login', 'User logged in', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:52:51'),
(1625, 130, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:53:12'),
(1626, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Lobo', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:57:11'),
(1627, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Balayan', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:57:11'),
(1628, 1, 'table_assignment', 'Assigned waterconsumption table to Resource Generation Mabini', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:57:11'),
(1629, 130, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:58:15'),
(1630, 130, 'logout', 'User logged out', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:58:26'),
(1631, 391, 'login_failed', 'Invalid password', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:58:55'),
(1632, 391, 'login_failed', 'Invalid password', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:59:04'),
(1633, 391, 'login_failed', 'Invalid password', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:59:13'),
(1634, 391, 'login_failed', 'Invalid password', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 05:59:50'),
(1635, 391, 'login', 'User logged in', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 06:00:06'),
(1636, 391, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 06:00:41'),
(1637, 391, 'logout', 'User logged out', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 06:00:48'),
(1638, 315, 'login_failed', 'Invalid password', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 06:01:33'),
(1639, 315, 'login', 'User logged in', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 06:01:46'),
(1640, 315, 'report_submission', 'Submitted report: Water Consumption (1 records)', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 06:02:17'),
(1641, 315, 'logout', 'User logged out', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 06:02:26'),
(1642, 159, 'login', 'User logged in', NULL, '112.198.128.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 06:03:21'),
(1643, NULL, 'login_failed', 'Failed login: asdasdasdas', NULL, '136.239.183.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-18 08:31:42'),
(1644, 1, 'login_failed', 'Invalid password', NULL, '2405:8d40:4898:8d24:dc6f:c2c6:363b:1a3d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-18 08:41:24'),
(1645, 1, 'login', 'User logged in', NULL, '2405:8d40:4898:8d24:dc6f:c2c6:363b:1a3d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-18 08:41:34'),
(1646, 1, 'logout', 'User logged out', NULL, '2405:8d40:4898:8d24:dc6f:c2c6:363b:1a3d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-18 08:42:40'),
(1647, 457, 'login', 'User logged in', NULL, '113.19.108.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-19 02:58:47'),
(1648, 1, 'login', 'User logged in', NULL, '139.135.200.48', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_1_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/142.0.7444.148 Mobile/15E148 Safari/604.1', '2025-11-21 16:44:03'),
(1649, 1, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:8866:d47:6815:bf30', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 04:57:48'),
(1650, 1, 'logout', 'User logged out', NULL, '2001:4455:80c6:ce00:8866:d47:6815:bf30', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 04:58:35'),
(1651, NULL, 'login_failed', 'Failed login: superadamin', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:03:22'),
(1652, 1, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:03:46'),
(1653, 1, 'logout', 'User logged out', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:04:21'),
(1654, NULL, 'login_failed', 'Failed login: lobo-admin-ofc', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:04:59'),
(1655, NULL, 'login_failed', 'Failed login: lobo-admin-ofc', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:05:14'),
(1656, 83, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:05:29'),
(1657, 83, 'table_assignment', 'Assigned admissiondata table to OJT Lobo', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:06:38'),
(1658, 83, 'logout', 'User logged out', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:06:46'),
(1659, 146, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:07:11'),
(1660, 146, 'logout', 'User logged out', NULL, '2001:4455:80c6:ce00:dbca:b79d:6f9a:8ab4', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 08:07:59'),
(1661, 1, 'login', 'User logged in', NULL, '2001:4455:80c6:ce00:6560:4bdb:f9ec:bbc', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-23 04:04:08'),
(1662, 1, 'logout', 'User logged out', NULL, '180.195.79.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-23 04:06:02'),
(1663, 1, 'login', 'User logged in', NULL, '175.176.60.84', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-24 11:28:47'),
(1664, 1, 'logout', 'User logged out', NULL, '175.176.60.84', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-24 11:29:40'),
(1665, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 13:02:14'),
(1666, 1, 'user_created', 'Created user: lima-admin-acc (lima-admin-acc) with role: admin at campus: Lima', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:29:24'),
(1667, 1, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:30:16'),
(1668, NULL, 'login_failed', 'Failed login: Lima-admin-ofc', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:30:45'),
(1669, NULL, 'login_failed', 'Failed login: Lima-admin-ofc', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:30:51'),
(1670, NULL, 'login_failed', 'Failed login: lima-admin-ofc', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:30:59'),
(1671, 471, 'login', 'User logged in', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:32:10'),
(1672, 471, 'user_created', 'Created user: lima-rgtr-ofc (lima-rgtr-ofc) with role: user at campus: Lima', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:34:23'),
(1673, 471, 'table_assignment', 'Assigned admissiondata table to Registration Services Lima', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:35:10'),
(1674, 471, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:35:39'),
(1675, 472, 'login', 'User logged in', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:35:49'),
(1676, 472, 'report_submission', 'Submitted report: Admission Data (1 records)', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:36:06'),
(1677, 472, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:36:24'),
(1678, 159, 'login_failed', 'Invalid password', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:37:05'),
(1679, 159, 'login_failed', 'Invalid password', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:37:22'),
(1680, 159, 'login_failed', 'Invalid password', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:37:27'),
(1681, 159, 'login_failed', 'Invalid password', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:37:31'),
(1682, 159, 'login', 'User logged in', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:37:50'),
(1683, 159, 'logout', 'User logged out', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:46:10'),
(1684, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:2c6b:e992:79b5:e64b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 14:46:34'),
(1685, 1, 'login_failed', 'Invalid password', NULL, '2001:4453:332:ea00:2556:2da9:7678:b988', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-27 14:10:38'),
(1686, 1, 'login', 'User logged in', NULL, '2001:4453:332:ea00:2556:2da9:7678:b988', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-27 14:10:51'),
(1687, 471, 'login', 'User logged in', NULL, '2001:4453:332:ea00:2556:2da9:7678:b988', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-27 14:14:18'),
(1688, 106, 'login', 'User logged in', NULL, '2001:4453:332:ea00:2556:2da9:7678:b988', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-27 15:29:39');

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

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2026 at 12:00 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12
--
-- NOTE: `assignments` and `assignment_submissions` tables have been removed.
-- Dummy data added to: users, students, teachers, enrollments, payments,
--                      teacher_allocations, contact_queries, notices, materials.

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `classroom_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `user_id`) VALUES
(1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `class_packages`
--

CREATE TABLE `class_packages` (
  `class_id` int(11) NOT NULL,
  `class_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_packages`
--

INSERT INTO `class_packages` (`class_id`, `class_name`, `price`) VALUES
(4, 'Class 4', 1000.00),
(5, 'Class 5', 1100.00),
(6, 'Class 6', 1200.00),
(7, 'Class 7', 1300.00),
(8, 'Class 8', 1400.00),
(9, 'Class 9', 1500.00),
(10, 'Class 10', 1600.00);

-- --------------------------------------------------------

--
-- Table structure for table `class_subjects`
--

CREATE TABLE `class_subjects` (
  `class_subject_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_subjects`
--

INSERT INTO `class_subjects` (`class_subject_id`, `class_id`, `subject_id`) VALUES
(1, 4, 1),
(2, 4, 2),
(3, 4, 3),
(4, 4, 4),
(5, 5, 1),
(6, 5, 2),
(7, 5, 3),
(8, 5, 4),
(9, 6, 1),
(10, 6, 2),
(11, 6, 3),
(12, 6, 4),
(13, 7, 1),
(14, 7, 2),
(15, 7, 3),
(16, 7, 4),
(17, 8, 1),
(18, 8, 2),
(19, 8, 3),
(20, 8, 4),
(21, 9, 1),
(22, 9, 2),
(23, 9, 3),
(24, 9, 4),
(25, 10, 1),
(26, 10, 2),
(27, 10, 3),
(28, 10, 4);

-- --------------------------------------------------------

--
-- Table structure for table `contact_queries`
--

CREATE TABLE `contact_queries` (
  `query_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `subject` enum('Technical Support','Admission Inquiry','Payment & Billing','Feedback','Partnership') NOT NULL,
  `message` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_queries`
--

INSERT INTO `contact_queries` (`query_id`, `name`, `email`, `phone`, `subject`, `message`, `created_at`) VALUES
(2, 'Nischal Raj Joshi', 'joshinischal10@gmail.com', '9767965747', 'Payment & Billing', 'Can I pay with cash?', '2026-05-19 16:02:31'),
(3, 'Suman Thapa', 'suman.thapa@gmail.com', '9812200011', 'Admission Inquiry', 'I would like to know more about the admission process for Class 9. What documents are required and when does the new batch begin?', '2026-04-10 11:23:00'),
(4, 'Rita Shrestha', 'rita.shrestha@gmail.com', '9823300022', 'Technical Support', 'I am unable to log in to my student account. The system keeps showing invalid credentials even after a password reset. Please assist.', '2026-04-15 14:05:00'),
(5, 'Dinesh Basnet', 'dinesh.basnet@gmail.com', '9845500033', 'Feedback', 'The platform is very well designed and the teachers are excellent. Study materials are well organized and easy to follow. Keep up the great work!', '2026-04-22 09:47:00'),
(6, 'Kamala Pandey', 'kamala.pandey@gmail.com', '9867700044', 'Partnership', 'We are a local educational NGO interested in exploring a partnership with Pathshala to support underprivileged students in rural communities.', '2026-05-01 16:30:00'),
(7, 'Bikram Gurung', 'bikram.gurung@gmail.com', '9889900055', 'Payment & Billing', 'I completed a payment through eSewa two days ago but my enrollment status is still showing as pending. Please look into this as soon as possible.', '2026-05-10 10:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `enrolled_date` datetime DEFAULT current_timestamp(),
  `status` enum('active','pending') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--
-- student_id references: 5=Nischal, 6=John Doe, 8=ABC,
--                        9=Priya, 10=Aarav, 11=Sunita,
--                        12=Bikash, 13=Manisha, 14=Rohan, 15=Puja
--

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `class_id`, `enrolled_date`, `status`) VALUES
(1,  6,  10, '2026-05-20 17:24:27', 'active'),
(2,  5,  9,  '2026-02-01 10:30:00', 'active'),
(3,  8,  7,  '2026-02-15 11:00:00', 'pending'),
(4,  9,  8,  '2026-02-01 10:00:00', 'active'),
(5,  10, 9,  '2026-02-05 10:00:00', 'active'),
(6,  11, 7,  '2026-02-10 10:00:00', 'active'),
(7,  12, 6,  '2026-02-15 10:00:00', 'active'),
(8,  13, 10, '2026-02-20 10:00:00', 'active'),
(9,  14, 5,  '2026-03-01 10:00:00', 'active'),
(10, 15, 4,  '2026-03-05 10:00:00', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `material_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`material_id`, `class_id`, `teacher_id`, `title`, `file_path`, `uploaded_at`) VALUES
(5,  10, 1, 'ABC',                               'uploads/1779277339567_Gantt Chart.pdf',              '2026-05-20 17:27:19'),
(6,  10, 1, 'ABC',                               'uploads/1779277339567_Gantt Chart.pdf',              '2026-05-20 17:27:19'),
(7,  10, 1, 'XYZ',                               'uploads/1779277721225_ICJMR - Literature Matrix.pdf','2026-05-20 17:33:41'),
(8,  10, 1, 'XYZ',                               'uploads/1779277721225_ICJMR - Literature Matrix.pdf','2026-05-20 17:33:41'),
(9,  10, 1, 'fbaeyd',                            'uploads/1779277771414_32872187-MIT.pdf',             '2026-05-20 17:34:31'),
(10, 10, 1, 'fbaeyd',                            'uploads/1779277771414_32872187-MIT.pdf',             '2026-05-20 17:34:31'),
(11, 10, 1, 'tdrcg',                             'uploads/1779295673568_prisma.pdf',                   '2026-05-20 22:32:53'),
(12, 8,  4, 'English Grammar Notes - Unit 1',    'uploads/dummy_english_grammar_unit1.pdf',            '2026-04-01 09:00:00'),
(13, 9,  2, 'Science Ch.1 - Living Things',      'uploads/dummy_science_living_things.pdf',            '2026-04-05 10:00:00'),
(14, 7,  5, 'Nepali Vyakaran - Chapter 2',       'uploads/dummy_nepali_vyakaran_ch2.pdf',              '2026-04-10 11:00:00'),
(15, 10, 1, 'Mathematics Formula Sheet Cl.10',   'uploads/dummy_math_formulas_class10.pdf',            '2026-04-15 09:30:00'),
(16, 6,  4, 'English Reading Comprehension - Set A', 'uploads/dummy_english_reading_set_a.pdf',        '2026-04-20 10:30:00'),
(17, 5,  5, 'Nepali Nibandha Lekhan - Guide',    'uploads/dummy_nepali_nibandha_guide.pdf',            '2026-04-25 11:00:00'),
(18, 9,  2, 'Science Ch.2 - Matter and Atoms',   'uploads/dummy_science_matter_atoms.pdf',             '2026-05-03 10:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
  `notice_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notices`
--

INSERT INTO `notices` (`notice_id`, `class_id`, `teacher_id`, `title`, `content`, `created_at`) VALUES
(1,  10, 1, 'New Material Uploaded',      'You uploaded \"a\" for your classroom.',       '2026-05-20 14:25:50'),
(2,  9,  1, 'New Material Uploaded',      'You uploaded \"B\" for your classroom.',       '2026-05-20 14:26:49'),
(3,  10, 1, 'New Material Uploaded',      'You uploaded \"ABC\" for your classroom.',     '2026-05-20 17:27:19'),
(4,  10, 1, 'New Material Uploaded',      'You uploaded \"XYZ\" for your classroom.',     '2026-05-20 17:33:41'),
(5,  10, 1, 'New Material Uploaded',      'You uploaded \"fbaeyd\" for your classroom.',  '2026-05-20 17:34:31'),
(6,  9,  2, 'Mid-Term Examination Schedule', 'Dear Class 9 students, mid-term examinations will be held from June 10 to June 14. Please review all uploaded materials and prepare accordingly.', '2026-05-18 10:00:00'),
(7,  8,  4, 'Welcome to Class 8 - English', 'Welcome all enrolled students to Class 8. Your first English session begins June 1. Please check the materials section for the course outline and reading list.', '2026-05-19 09:00:00'),
(8,  7,  5, 'Public Holiday Notice',      'All classes will be suspended on May 29 in observance of the public holiday. Regular classes resume from June 1 onwards.', '2026-05-20 08:30:00'),
(9,  10, 4, 'New English Material Added', 'New English grammar reference notes have been added to the Class 10 materials section. Please review them before the next scheduled session.', '2026-05-20 12:00:00'),
(10, 6,  1, 'Unit Test Announcement',     'A unit test on Chapter 3 (Arithmetic) will be conducted next week for Class 6. Please revise all topics covered in the last two sessions.', '2026-05-21 08:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `enrollment_id` int(11) NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--
-- Covers all active enrollments. Enrollments 3 (pending) and 10 (pending) have no payment.
--

INSERT INTO `payments` (`payment_id`, `enrollment_id`, `amount_paid`, `payment_method`, `payment_date`) VALUES
(1, 1, 1600.00, 'Esewa',         '2026-05-20 17:24:27'),
(2, 2, 1500.00, 'Khalti',        '2026-02-01 10:35:00'),
(3, 4, 1400.00, 'eSewa',         '2026-02-01 10:05:00'),
(4, 5, 1500.00, 'Bank Transfer', '2026-02-05 10:30:00'),
(5, 6, 1300.00, 'Khalti',        '2026-02-10 10:20:00'),
(6, 7, 1200.00, 'eSewa',         '2026-02-15 10:10:00'),
(7, 8, 1600.00, 'Bank Transfer', '2026-02-20 10:15:00'),
(8, 9, 1100.00, 'eSewa',         '2026-03-01 10:25:00');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `user_id`) VALUES
(5,  8),
(6,  9),
(8,  13),
(9,  16),
(10, 17),
(11, 18),
(12, 19),
(13, 20),
(14, 21),
(15, 22);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`) VALUES
(5, 'Comp Sci'),
(2, 'English'),
(6, 'Kritaka'),
(4, 'Math'),
(1, 'Nepali'),
(3, 'Science');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `teacher_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `user_id`) VALUES
(1, 7),
(2, 11),
(3, 12),
(4, 14),
(5, 15);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_allocations`
--

CREATE TABLE `teacher_allocations` (
  `allocation_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `class_subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_allocations`
--
-- Teacher 1 (Nishan Paudel)  → Math     (subject_id 4)
-- Teacher 2 (Rabina Lama)    → Science  (subject_id 3)
-- Teacher 3 (Jack Doe)       → Math Cl.9 & Cl.10 (pre-existing, kept)
-- Teacher 4 (Arjun Thapa)    → English  (subject_id 2)
-- Teacher 5 (Sita Gurung)    → Nepali   (subject_id 1)
--

INSERT INTO `teacher_allocations` (`allocation_id`, `teacher_id`, `class_subject_id`) VALUES
-- Pre-existing
(1,  3, 24),
(2,  3, 28),
(6,  2, 3),
(7,  2, 7),
(8,  1, 24),
(9,  1, 28),
-- Teacher 1 (Nishan) - Math, Classes 4-8
(10, 1, 4),
(11, 1, 8),
(12, 1, 12),
(13, 1, 16),
(14, 1, 20),
-- Teacher 2 (Rabina) - Science, Classes 6-10
(15, 2, 11),
(16, 2, 15),
(17, 2, 19),
(18, 2, 23),
(19, 2, 27),
-- Teacher 4 (Arjun) - English, all Classes 4-10
(20, 4, 2),
(21, 4, 6),
(22, 4, 10),
(23, 4, 14),
(24, 4, 18),
(25, 4, 22),
(26, 4, 26),
-- Teacher 5 (Sita) - Nepali, all Classes 4-10
(27, 5, 1),
(28, 5, 5),
(29, 5, 9),
(30, 5, 13),
(31, 5, 17),
(32, 5, 21),
(33, 5, 25);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','teacher','student') NOT NULL,
  `is_approved` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--
-- Passwords are bcrypt hashes of 'Password@123' for all dummy accounts.
-- user_id 22 (Puja Bhandari) is is_approved=0 to represent a pending approval state.
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `phone_number`, `password_hash`, `role`, `is_approved`, `created_at`) VALUES
(6,  'System Admin',    'admin@pathshala.com',          '9800000000', '$2a$10$nruC.iHZ/PvJ2zmCLiu74OD7Uk58Ie8FeKbln.GPFLpz0nVSK.7Ya', 'admin',   1, '2026-05-19 07:59:19'),
(7,  'Nishan Paudel',   'nishan@pathshala.com',         '9812345678', '$2a$10$DRv0cRe3leauHfxB38fGk.IfW0TR5OefhxdgfBuChvAg0oUc2y9a2', 'teacher', 1, '2026-05-19 08:04:15'),
(8,  'Nischal Raj Joshi','joshinischal10@gmail.com',    '9767965747', '$2a$10$Cc56E/Ht9mer4ABkXaG.yuMtOCeLHEV514VOHWZ8bEwR6UgL2YJqG', 'student', 1, '2026-05-19 08:11:36'),
(9,  'John Doe',        'johndoe@gmail.com',            '9887654321', '$2a$10$y8ylbh5my68Iw2osdGQjeOVnAJqoecIVIAA1bEuTEkMod4Nuo18Eq', 'student', 1, '2026-05-19 23:54:34'),
(11, 'Rabina Lama',     'rabina@pathshala.com',         '9812378456', '$2a$10$4isyfJtxAmSgVBnsNlHm2uR4vY0HOy4QCkmIrjcebOzVZmRTAW2w.', 'teacher', 1, '2026-05-20 02:07:23'),
(12, 'Jack Doe',        'jack@pathshala.com',           '984567123',  '$2a$10$oOpOQDTh7ecEy8pbEgtwfeZ9MQ8Qg0DyB8jTqTwmW/NgYmV6M/PlC', 'teacher', 1, '2026-05-20 02:28:45'),
(13, 'ABC',             'abc@gmail.com',                '123456789',  '$2a$10$itS3TUKdPOC9bvUkBe2tMOOukef9pCEa9KWO72IsFVeAM6R2L0/kC', 'student', 1, '2026-05-20 12:56:10'),
(14, 'Arjun Thapa',     'arjun@pathshala.com',          '9851112201', '$2a$10$Wq5rN3mIqS4uTyZoBeDtFvH1kJiKbGfXyNzLqQsPuRoVmClAeBfDg', 'teacher', 1, '2026-01-15 09:00:00'),
(15, 'Sita Gurung',     'sita@pathshala.com',           '9851112202', '$2a$10$Xr6sO4nJrT5vUzApCfEuGwI2lKjLcHgYzOwMrRtQvSpWnDmBfCgEh', 'teacher', 1, '2026-01-16 09:00:00'),
(16, 'Priya Sharma',    'priya.sharma@gmail.com',       '9841000001', '$2a$10$Ys7tP5oKsU6wVaBqDgFvHxJ3mLkMdIhZaPiXnSsTrUwQxYoFoCgDh', 'student', 1, '2026-02-01 10:00:00'),
(17, 'Aarav Karki',     'aarav.karki@gmail.com',        '9841000002', '$2a$10$Zt8uQ6pLtV7xWbCrEhGwIyK4nMlNeJiAbQjYoTtSuRxVsZqGpFoEi', 'student', 1, '2026-02-05 10:00:00'),
(18, 'Sunita Rai',      'sunita.rai@gmail.com',         '9841000003', '$2a$10$Au9vR7qMuW8yXcDsFiHxJzL5oNmOfKjBcRkZpUuTvSyWtArHqGjFk', 'student', 1, '2026-02-10 10:00:00'),
(19, 'Bikash Magar',    'bikash.magar@gmail.com',       '9841000004', '$2a$10$BvaWS8rNvX9zYdEtGjIyKaM6pOnPgLkCdSlAqWvXuZwBsIrHkGlJm', 'student', 1, '2026-02-15 10:00:00'),
(20, 'Manisha Tamang',  'manisha.tamang@gmail.com',     '9841000005', '$2a$10$CwbXT9sOwY0aZeFuHkJzLbN7qPoQhMlDeUmBrXwYvAwBtJsIlHmKn', 'student', 1, '2026-02-20 10:00:00'),
(21, 'Rohan Adhikari',  'rohan.adhikari@gmail.com',     '9841000006', '$2a$10$DxcYU0tPxZ1bAfGvIlKaMcO8rQpRiNmEfVnCsYxZwBxCuKtJmInLo', 'student', 1, '2026-03-01 10:00:00'),
(22, 'Puja Bhandari',   'puja.bhandari@gmail.com',      '9841000007', '$2a$10$EydZV1uQyA2cBgHwJmLbNdP9sSqSjOnFgWoDtyZxYcZwDvKuJnKoMp', 'student', 0, '2026-03-05 10:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `class_packages`
--
ALTER TABLE `class_packages`
  ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `class_subjects`
--
ALTER TABLE `class_subjects`
  ADD PRIMARY KEY (`class_subject_id`),
  ADD KEY `fk_cs_class` (`class_id`),
  ADD KEY `fk_cs_subject` (`subject_id`);

--
-- Indexes for table `contact_queries`
--
ALTER TABLE `contact_queries`
  ADD PRIMARY KEY (`query_id`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD KEY `fk_enrol_student` (`student_id`),
  ADD KEY `fk_enrol_class` (`class_id`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`material_id`),
  ADD KEY `fk_mat_class` (`class_id`),
  ADD KEY `fk_mat_teacher` (`teacher_id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`notice_id`),
  ADD KEY `fk_not_class` (`class_id`),
  ADD KEY `fk_not_teacher` (`teacher_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_pay_enrol` (`enrollment_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD UNIQUE KEY `subject_name` (`subject_name`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `teacher_allocations`
--
ALTER TABLE `teacher_allocations`
  ADD PRIMARY KEY (`allocation_id`),
  ADD KEY `fk_alloc_teacher` (`teacher_id`),
  ADD KEY `fk_alloc_class_sub` (`class_subject_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- AUTO_INCREMENT for dumped tables
--

ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `class_packages`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `class_subjects`
  MODIFY `class_subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

ALTER TABLE `contact_queries`
  MODIFY `query_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `materials`
  MODIFY `material_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

ALTER TABLE `notices`
  MODIFY `notice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `teacher_allocations`
  MODIFY `allocation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

ALTER TABLE `admins`
  ADD CONSTRAINT `fk_admin_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

ALTER TABLE `class_subjects`
  ADD CONSTRAINT `fk_cs_class` FOREIGN KEY (`class_id`) REFERENCES `class_packages` (`class_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cs_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

ALTER TABLE `enrollments`
  ADD CONSTRAINT `fk_enrol_class` FOREIGN KEY (`class_id`) REFERENCES `class_packages` (`class_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_enrol_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

ALTER TABLE `materials`
  ADD CONSTRAINT `fk_mat_class` FOREIGN KEY (`class_id`) REFERENCES `class_packages` (`class_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_mat_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE;

ALTER TABLE `notices`
  ADD CONSTRAINT `fk_not_class` FOREIGN KEY (`class_id`) REFERENCES `class_packages` (`class_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_not_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE;

ALTER TABLE `payments`
  ADD CONSTRAINT `fk_pay_enrol` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`enrollment_id`) ON DELETE CASCADE;

ALTER TABLE `students`
  ADD CONSTRAINT `fk_student_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

ALTER TABLE `teachers`
  ADD CONSTRAINT `fk_teacher_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

ALTER TABLE `teacher_allocations`
  ADD CONSTRAINT `fk_alloc_class_sub` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`class_subject_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_alloc_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

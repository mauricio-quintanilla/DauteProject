-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 10, 2020 at 12:22 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dautedb2`
--

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `NIT` varchar(255) DEFAULT NULL UNIQUE,
  `company_name` varchar(255) DEFAULT NULL,
  `company_address` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `name`, `email`, `phone_number`, `NIT`, `company_name`, `company_address`,`user_id`) VALUES
(3, 'Ing. Fulanito Menganito', 'fulanito@holcim.com.sv', '7171-7171', '0611-061099-112-2', 'Holcim SA de CV', 'col no address av no adress 2266 #22 SS',-1),
(4, 'Menganita', 'menganita@itca.edu.sv', '2257-7777', '0614-142536-112-1', 'Itca fepade', 'col santa tecla santa tecla LL',-1),
(5, 'Zapatero', 'zapatero@adoc.com.sv', '2154-2154', '0614-362514-112-2', 'ADOC', 'col soyapango san salvador',-1),
(6, 'Muray Meza', 'murray@laconstancia.com.sv', '2222-8080', '0615-215487-212-2', 'La Constancia S.A de C.V', 'Avenida Independencia, #526, S.S.',-1);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `name`) VALUES
(5, 'Finanzas'),
(12, 'Sistemas Informaticos'),
(18, 'Cocina'),
(19, 'Mantenimiento'),
(20, 'Arquitectura'),
(21, 'Ingenieria');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `DUI` varchar(255) DEFAULT NULL UNIQUE,
  `NIT` varchar(255) DEFAULT NULL UNIQUE,
  `salary` double DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `first_name`, `last_name`, `dob`, `address`, `phone_number`, `DUI`, `NIT`, `salary`, `position_id`, `user_id`, `status`, `image`) VALUES
(1, 'Mauricio', 'Quintanilla', '2002-12-07', 'no address', '2257-7777', '01254758-9', '0611-121212-121-1', 666.66, 6, 1, 'Unavailable', 'nopic.png'),
(2, 'Melissa', 'Bonilla', '2002-12-10', 'no no no', '2257-7777', '11111111-5', '1548-595959', 700, 8, 5, 'Unavailable', 'nopic.png'),
(5, 'Luis', 'Bonilla', '2002-12-03', 'col luis bonilla', '2255-9966', '25414785-9', '2154-326598-987-4', 700, 2, 3, 'Unavailable', 'nopic.png'),
(7, 'Ismael', 'Castillo', '2000-12-02', 'isma place', '8754-8754', '69584758-9', '3625-144758-698-9', 700, 7, 4, 'Unavailable', 'nopic.png'),
(8, 'iris', 'carpio', '2002-12-24', 'iris', '98764', '987987987', '987987', 987, 7, 6, 'Unavailable', 'nopic.png'),
(10, 'Giovanni', 'Tzec', '2002-12-31', 'col itca', '6666-6666', '987654-654321', '6546798-654', 700, 9, 7, 'Unavailable', 'nopic.png'),
(14, 'Mauricio', 'Quintanilla', '2002-12-07', 'no address', '2257-7777', '01254758-3', '0611-121212-121-2', 666.66, 6, 1, 'Unavailable', 'nopic.png'),
(15, 'luis', 'merino', '2002-12-18', 'asamblea legislativa', '2154-8754', '01478523-9', '0616-458985-987-4', 500, 2, -1, 'Unavailable', 'nopic.png');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `inventory` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `rental_price` double DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `name`, `model`, `description`, `brand`, `stock`, `inventory`, `type`, `rental_price`, `image`) VALUES
(1, 'grua hidraulica', 'PK 9001 EH', 'Grua basculante Momento de carga: 77.5kNm max. alcance: 5.6m max: 1.047 - Carga util max.: 1.6t - unidad de longitud: max anchura del dispositivo: m', 'Palfinger', 8, 15, 1, 12, 'noeq.png'),
(3, 'tractor oruga', 'D65E-8', 'empuje transporte material sobre orugas /neumaticos /chasis rigido o articulado', 'Komatsu', 12, 20, 1, 6.25, 'noeq.png'),
(4, 'Bulldozer', 'D6T LGP', 'niveladora /topadora /movimiento de tierras, de excavacion', 'Caterpillar', 4, 8, 2, 19.66, 'noeq.png'),
(29, 'nomachine', 'nomodel', 'nodescr', 'nobrand', 65, 66, 2, 66, 'noeq.png');

-- --------------------------------------------------------

--
-- Table structure for table `in_use`
--

CREATE TABLE `in_use` (
  `id` int(11) NOT NULL,
  `equipment_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `in_pro_from` varchar(255) DEFAULT NULL,
  `in_pro_to` varchar(255) DEFAULT NULL,
  `equipment_quantity` int(11) DEFAULT NULL,
  `cost` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `in_use`
--

INSERT INTO `in_use` (`id`, `equipment_id`, `project_id`, `in_pro_from`, `in_pro_to`, `equipment_quantity`, `cost`) VALUES
(9, 1, 1, '2020-11-09', '2020-11-17', 7, 212),
(11, 3, 3, '2020-11-11', '2020-11-25', 6, 30),
(12, 4, 1, '2020-10-06', '2020-11-19', 3, 10),
(13, 29, 1, '2020-11-12', '2020-11-25', 1, 65),
(14, 3, 3, '2020-11-06', '2020-11-13', 1, 25),
(15, 1, 1, '2020-11-09', '2020-11-17', 7, 100),
(16, 3, 4, '2020-11-10', '2020-11-25', 1, 5),
(17, 4, 6, '2020-11-02', '2020-11-04', 1, 100);

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action_id` varchar(255) DEFAULT NULL,
  `on_field` varchar(255) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `user_id`, `action_id`, `on_field`, `date`, `description`) VALUES
(6, 1, 'created', 'Department', 'Thu, 05 Nov 2020 00:39:01', 'dpt name: Fontaneria'),
(7, 1, 'updated', 'Department', 'Thu, 05 Nov 2020 00:39:52', 'from: Fontanerias to Fontanerias'),
(8, 1, 'updated', 'Department', 'Thu, 05 Nov 2020 00:42:52', 'from: Fontanerias to Fontaneriyyaa'),
(9, 1, 'updated', 'Department', 'Thu, 05 Nov 2020 00:45:02', 'from: Fontaneriyyaa to Fontaneria'),
(10, 1, 'deleted', 'Department', 'Thu, 05 Nov 2020 00:45:19', 'dpt id: 28 name Fontaneria'),
(11, 1, 'updated', 'Department', 'Thu, 05 Nov 2020 01:34:55', 'from: Ingenierias to Ingenierias'),
(12, 1, 'updated', 'Department', 'Thu, 05 Nov 2020 01:36:23', 'from: Arquitectura to Arquitectura'),
(13, 1, 'updated', 'Department', 'Thu, 05 Nov 2020 01:53:21', 'from: Sistemas to Sistemas Informaticos'),
(14, 1, 'created', 'Position', 'Thu, 05 Nov 2020 02:29:59', 'position name: Zapaterodpt id: 21'),
(15, 1, 'updated', 'Position', 'Thu, 05 Nov 2020 02:30:14', 'from: Zapatero to Zapatero a tu zapato'),
(16, 1, 'updated', 'Position', 'Thu, 05 Nov 2020 02:30:14', 'from: 21 to 12'),
(17, 1, 'deleted', 'Positon', 'Thu, 05 Nov 2020 02:30:19', 'position name: Zapatero a tu zapatodpt id: 12'),
(18, 1, 'created', 'Role', 'Thu, 05 Nov 2020 03:30:25', 'Role name: no role'),
(19, 1, 'updated', 'Role', 'Thu, 05 Nov 2020 03:30:39', 'name from: no role to si role'),
(20, 1, 'deleted', 'Role', 'Thu, 05 Nov 2020 03:30:42', 'role id6 role name: si role'),
(21, 1, 'created', 'Department', 'Thu, 05 Nov 2020 22:26:32', 'dpt name: asdf'),
(22, 1, 'deleted', 'Department', 'Thu, 05 Nov 2020 22:26:39', 'dpt id: 29 name asdf'),
(23, 1, 'updated', 'Department', 'Mon, 09 Nov 2020 02:57:04', 'name from: Ingenierias to Ingenieria'),
(24, 1, 'created', 'Department', 'Mon, 09 Nov 2020 02:58:26', 'dpt name: 3321321'),
(25, 1, 'deleted', 'Department', 'Mon, 09 Nov 2020 02:58:37', 'dpt id: 30 name 3321321');

-- --------------------------------------------------------

--
-- Table structure for table `position`
--

CREATE TABLE `position` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `position`
--

INSERT INTO `position` (`id`, `name`, `department_id`) VALUES
(1, 'Contador', 5),
(2, 'Ingeniero', 12),
(6, 'Tecnico', 12),
(7, 'Arquitecto', 20),
(8, 'Chef', 18),
(9, 'Aseo', 19);

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `started_date` date DEFAULT NULL,
  `finish_date` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `lat` varchar(255) DEFAULT NULL,
  `lng` varchar(255) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `name`, `description`, `started_date`, `finish_date`, `address`, `lat`, `lng`, `client_id`, `status`) VALUES
(1, 'Ampliacion Itca', 'Construccion 5ta planta edificio b', '2020-11-02', '2020-11-27', 'santa tecla itca edif b', '13.674010189525355', '-89.27885055541992', 3, 'activo'),
(3, 'Edif Cholate', 'contruccion edificio chocolate 15 plantas ', '2020-12-16', '2021-01-13', 'chocolatelandia', '13.699270111105124', '-89.10703082495961', 4, 'no-iniciado'),
(4, 'Los jardines de babilonia', 'Jardines Flotantes de babilonia', '2020-11-11', '2020-11-30', 'babilonia', '30.730063767905886', '35.79234850044137', 3, 'no-iniciado'),
(5, 'Nueva Planta ADOC', 'construccion planta n5 ADOC', '2020-12-01', '2021-01-31', 'bosques de prusia soyapando', '13.719778133527141', '-89.19504056245091', 5, 'no-iniciado'),
(6, 'Construccion Molino Principal', 'Molino para Cereales 4.50 tons', '2020-11-02', '2020-11-08', 'av revolucion san salvador / planta 4 la constancia', '13.699068259084237', '-89.18061138295043', 6, 'finalizado');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(-1, 'unauthorized'),
(1, 'Administrator'),
(2, 'Management'),
(3, 'Workforce'),
(4, 'Accounting and Finance');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_name`, `email`, `password`, `role_id`) VALUES
(-1, 'nouser', 'noemail', 'nopassword', -1),
(1, 'mquintanilla2020', 'mauricio.quintanilla19@itca.edu.sv', '3b7060c3143628ce82b700a7fd8b7d1a5ce8323c', 1),
(3, 'lbonilla2020', 'luis.bonilla@itca.edu.sv', 'faea5242a00c52da62a0f00df168c199b7ab748d', 3),
(4, 'icastillo2020', 'ismael.castillo@itca.edu.sv', 'Itca.2020', 1),
(5, 'mbonilla2020', 'melissa.bonilla@itca.edu.sv', 'Itca.2020', 2),
(6, 'icarpio2020', 'iris.carpio@itca.edu.sv', '85f8bb615f91bafe856dff838e2955bb9119da60', 2),
(7, 'gTzec2020', 'giovanni.tzec@itca.edu.sv', 'Itca.2020', 3),
(9, 'no', 'noasdf@asdf.c', 'nullasdf', -1);

-- --------------------------------------------------------

--
-- Table structure for table `working_on_project`
--

CREATE TABLE `working_on_project` (
  `id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `in_pro_from` varchar(255) DEFAULT NULL,
  `in_pro_to` varchar(255) DEFAULT NULL,
  `cost` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `working_on_project`
--

INSERT INTO `working_on_project` (`id`, `project_id`, `employee_id`, `in_pro_from`, `in_pro_to`, `cost`) VALUES
(5, 1, 1, '2020-11-02', '2020-11-04', 700.5),
(9, 4, 5, '2002-12-01', '2002-12-26', 900),
(14, 3, 7, '2020-12-16', '2021-01-13', 200),
(15, 3, 8, '2020-12-16', '2021-01-14', 500),
(16, 5, 10, '2020-12-15', '2021-01-28', 500),
(17, 6, 15, '2020-11-02', '2020-11-08', 700);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `position_id` (`position_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `in_use`
--
ALTER TABLE `in_use`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `equipment_id` (`equipment_id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `working_on_project`
--
ALTER TABLE `working_on_project`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `in_use`
--
ALTER TABLE `in_use`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `position`
--
ALTER TABLE `position`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `working_on_project`
--
ALTER TABLE `working_on_project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);


--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`),
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `in_use`
--
ALTER TABLE `in_use`
  ADD CONSTRAINT `in_use_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  ADD CONSTRAINT `in_use_ibfk_2` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`);

--
-- Constraints for table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `position`
--
ALTER TABLE `position`
  ADD CONSTRAINT `position_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `project_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

--
-- Constraints for table `working_on_project`
--
ALTER TABLE `working_on_project`
  ADD CONSTRAINT `working_on_project_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  ADD CONSTRAINT `working_on_project_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

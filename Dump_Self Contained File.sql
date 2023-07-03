CREATE DATABASE  IF NOT EXISTS `expenses` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `expenses`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: expenses
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int NOT NULL,
  `groups_id` int NOT NULL,
  PRIMARY KEY (`id`,`users_id`,`groups_id`),
  KEY `fk_accounts_users_idx` (`users_id`),
  KEY `fk_accounts_groups1_idx` (`groups_id`),
  CONSTRAINT `fk_accounts_groups1` FOREIGN KEY (`groups_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `fk_accounts_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,1,1),(4,1,2),(5,1,3),(6,1,4),(7,1,5),(8,1,6),(3,2,4),(2,5,2),(9,6,6),(10,6,3),(11,6,1),(12,6,2),(13,7,3),(14,9,1),(15,9,2),(16,9,3),(17,10,1),(18,10,2),(19,10,4),(20,11,4),(21,12,1);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `groups_id` int NOT NULL,
  PRIMARY KEY (`id`,`groups_id`),
  KEY `fk_bills_groups1_idx` (`groups_id`),
  CONSTRAINT `fk_bills_groups1` FOREIGN KEY (`groups_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (1,5.05,'fancy dinner',1),(2,10.55,'Taxi',6),(3,50.55,'Tips to waiter',3),(4,100.00,'Car rent',1),(5,200.00,'Fly ticket',3),(6,50.00,'Museum',1),(7,23.05,'Equipment',6),(8,12.50,'Gloves',4),(9,12.50,'Water',1);
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Trip to Spain'),(2,'Going to Alps'),(3,'Dinner in Belgium'),(4,'Trip to Finland'),(5,'New Years Party'),(6,'Trip to London');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `reg_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Rebeka','rebeka@gmail.com','$2b$10$ZU7egR8FIhG9JGYfvjR/V.oYfjoymJi0YleorRhDAaayLpA9I7UvC','2023-06-26 19:27:47'),(2,'Alma Petrienė','alma@gmail.com','$2b$10$TwPuCEPazx/iYfezJFSNY.od7SbR.ScAyfUzeOxBN9R024rD.M14i','2023-06-27 08:44:29'),(3,'Rachele','rachele@gmail.com','$2b$10$WEQBJ6kgSqQqY3dMiVZK/eVYnI8.kIpBqL/JhRgirFL7MnZENKxIm','2023-06-27 10:24:05'),(4,'Paulius','paulius@gmail.com','$2b$10$PUExyMMWtGtPRqDsYD7P6eJlKch49zY9.QO6fRywvex5AF8rxU3ge','2023-06-27 10:24:40'),(5,'Antanas Jonaitis','antanas@gmail.com','$2b$10$.i67BcBzTz6RpBM5l4X.uen9laJZoXddLW1BYjUdCrRo.NmCiWg2C','2023-06-28 10:21:28'),(6,'Mantas','mantas@gmail.com','$2b$10$ZINAsNmU0W1d/VfK12vzjOOOPc9iyqgo/VIB0bGPogjxf3LCcOjX6','2023-06-29 11:38:58'),(7,'Ugnius','ugnius@gmail.com','$2b$10$55lHU2C0D743NfyiFhsZaOEeOykPjMqy46hh4Y8Mie47JFDufCa7e','2023-06-29 14:54:35'),(8,'ana','ana@gmail.com','$2b$10$A6ae4G5KIw.dSDuFOEklY.maFRVHyfQMhQgBewEvp59PMzsG7Wy3K','2023-06-29 15:17:57'),(9,'Petras','petras@gmail.com','$2b$10$D3F4BobOlQuXJvkkA51Pf.z.03d8gPjshcosDMCq/3WagNWXcw9.K','2023-06-29 15:30:11'),(10,'Andrius','andrius@gmail.com','$2b$10$9etEH6nOH9HqZb5ybjzIl.tRkbxSeWXwNB8flo4f2hLgv/Ph83sMm','2023-06-29 16:55:27'),(11,'Laima','laima@gmail.com','$2b$10$JH8I/nzU1rnC7cTjfcyj5.F1..lHK5JdKg2oriAp9hdMmy8.A9L4e','2023-07-03 07:38:54'),(12,'Rebeka','rebekakometa@gmail.com','$2b$10$x0bpIBrl3uvtuhar6UMj/OSXqofFxgz7YnzOxm/WqWDjgfJ8xp3ga','2023-07-03 07:40:58');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-03 10:51:32

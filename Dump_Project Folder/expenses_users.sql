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

-- Dump completed on 2023-07-03 10:54:22

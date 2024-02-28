-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: datosparabackup
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbconsigna`
--

DROP TABLE IF EXISTS `tbconsigna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbconsigna` (
  `id_consigna` int(11) NOT NULL,
  `consigna` varchar(50) DEFAULT NULL,
  `id_nombre` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_consigna`),
  KEY `fk_consigna` (`id_nombre`),
  CONSTRAINT `fk_consigna` FOREIGN KEY (`id_nombre`) REFERENCES `tbnombre` (`id_nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbconsigna`
--

LOCK TABLES `tbconsigna` WRITE;
/*!40000 ALTER TABLE `tbconsigna` DISABLE KEYS */;
INSERT INTO `tbconsigna` VALUES (1,'Lavar platos',4),(2,'Lavar platos',5),(3,'Lavar platos',1),(4,'Lavar platos',7);
/*!40000 ALTER TABLE `tbconsigna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbnombre`
--

DROP TABLE IF EXISTS `tbnombre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbnombre` (
  `id_nombre` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbnombre`
--

LOCK TABLES `tbnombre` WRITE;
/*!40000 ALTER TABLE `tbnombre` DISABLE KEYS */;
INSERT INTO `tbnombre` VALUES (1,'Josue'),(2,'Josue'),(3,'Josue'),(4,'Josue'),(5,'Josue'),(6,'Josue'),(7,'Josue'),(8,'Josue'),(9,'Josue'),(10,'Josue');
/*!40000 ALTER TABLE `tbnombre` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-27 21:46:24

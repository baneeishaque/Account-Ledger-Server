-- MySQL dump 10.13  Distrib 5.6.33-79.0, for Linux (x86_64)
--
-- Host: localhost    Database: vfmobo6d_account_ledger
-- ------------------------------------------------------
-- Server version	5.6.33-79.0-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuration` (
  `system_status` tinyint(4) NOT NULL,
  `version_code` int(11) NOT NULL,
  `version_name` double NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration`
--

LOCK TABLES `configuration` WRITE;
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` (`system_status`, `version_code`, `version_name`, `id`) VALUES (1,1,1,1);
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_date_time` datetime NOT NULL,
  `particulars` varchar(150) NOT NULL,
  `amount` decimal(11,0) NOT NULL,
  `insertion_date_time` datetime NOT NULL,
  `inserter_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` (`id`, `event_date_time`, `particulars`, `amount`, `insertion_date_time`, `inserter_id`) VALUES (1,'2018-01-24 16:00:00','Debit : Lunch - Tea + Ullivada x 2',24,'2018-01-25 01:12:51',1),(2,'2018-01-24 16:30:00','Debit : Achar',1,'2018-01-25 01:13:12',1),(3,'2018-01-24 19:00:00','Credit : From Mahin for Achar',5,'2018-01-25 01:13:48',1),(4,'2018-01-24 19:05:00','Debit : Achar x 5',5,'2018-01-25 01:14:12',1),(5,'2018-01-24 20:00:00','Debit : Tazhepalam - Ptu Auto Fair',10,'2018-01-25 01:14:36',1),(6,'2018-01-24 09:00:00','Credit : Initial Balance',3361,'2018-01-25 01:16:31',1),(7,'2018-01-24 20:30:00','Debit : To Mother from Semithatha Debit',1000,'2018-01-25 01:17:03',1),(8,'2018-01-25 10:00:00','Debit : To Mother for Oil, Thakkali',100,'2018-01-26 10:51:53',1),(9,'2018-01-25 16:00:00','Credit : Balance from mother on Oil, Thakkali purchase',50,'2018-01-26 10:52:33',1),(10,'2018-01-26 08:30:00','Debit : Missing',5,'2018-01-26 10:52:51',1),(11,'2018-01-26 09:30:00','Debit : Puthentheru to tirur bus fair',9,'2018-01-27 08:37:31',1),(12,'2018-01-26 09:00:00','Debit : TIRUR to PRISM bus fair',7,'2018-01-27 08:37:59',1),(13,'2018-01-26 14:00:00','Debit : Lunch : chapathi + chicken curry with ADIL & PRANAV',20,'2018-01-27 08:38:59',1),(14,'2018-01-27 10:00:00','Debit : Mother for gas',800,'2018-01-28 08:11:08',1),(15,'2018-01-27 10:05:00','Debit : Mubithatha credit',100,'2018-01-28 08:11:31',1),(16,'2018-01-28 08:00:00','Debit : Mother for SHAMSU PUTHENPURA SUHAIL KUTTIPPURAM marriage - from Semithatha debit',500,'2018-01-28 08:13:18',1),(17,'2018-01-28 15:30:00','Debit : PUTHENTHERU to tirur bus fair ',9,'2018-01-29 01:31:03',1),(18,'2018-01-28 15:40:00','Debit : TIRUR to POLY bus fair ',6,'2018-01-29 01:31:28',1),(19,'2018-01-28 15:45:00','Debit : Lunch tea + bonda X 2',24,'2018-01-29 01:31:58',1),(20,'2018-01-28 16:05:00','Debit : Achar',1,'2018-01-29 01:32:13',1),(21,'2018-01-28 22:00:00','Debit : THAZHEPALAM to puthentheru bus fair ',10,'2018-01-29 01:32:47',1),(24,'2018-02-01 00:00:00','Credit : from sharafu kaka lottery work - automation through WhatsApp : combination of LSK & Stright pattern',500,'2018-02-01 10:01:05',1),(25,'2018-02-01 00:00:00','Debit : Mother for puthentheru palli committee piriv (Nov - 40 + Dec - 40 + Jan - 60 + Feb - 60)',200,'2018-02-01 10:02:47',1),(26,'2018-02-01 00:00:00','Debit : PUTHENTHERU to tirur bus fair ',9,'2018-02-02 09:24:07',1),(27,'2018-02-01 00:00:00','Debit : TIRUR to PRISM bus fair ',7,'2018-02-02 09:24:26',1),(28,'2018-02-02 00:00:00','Debit : THAZHEPALAM to puthentheru bus fair ',10,'2018-02-02 09:24:53',1);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`) VALUES (1,'baneeishaque','9895204814');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'vfmobo6d_account_ledger'
--

--
-- Dumping routines for database 'vfmobo6d_account_ledger'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-05  4:50:32

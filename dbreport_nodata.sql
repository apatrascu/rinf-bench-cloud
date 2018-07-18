-- MySQL dump 10.16  Distrib 10.2.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: dbreport
-- ------------------------------------------------------
-- Server version	10.2.12-MariaDB-10.2.12+maria~xenial-log

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
-- Current Database: `dbreport`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dbreport` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dbreport`;

--
-- Table structure for table `flow`
--

DROP TABLE IF EXISTS `flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `runid` varchar(500) DEFAULT NULL,
  `flow_name` varchar(500) DEFAULT NULL,
  `running_node` varchar(500) DEFAULT NULL COMMENT 'The node from the cluster where the flow was deployed',
  `docker_image_link` varchar(500) DEFAULT NULL COMMENT 'The link to the Docker registry from where the flow was deployed',
  `ml_framework` varchar(500) DEFAULT NULL,
  `ml_framework_version` varchar(500) DEFAULT NULL,
  `ml_framework_compiler` varchar(500) DEFAULT NULL,
  `model` varchar(500) DEFAULT NULL,
  `dataset` varchar(500) DEFAULT NULL,
  `cpu` varchar(500) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL COMMENT 'Start time for a flow',
  `end_time` datetime DEFAULT NULL COMMENT 'End time for a flow',
  `throughput_value` varchar(500) DEFAULT NULL,
  `throughput_meaning` varchar(500) DEFAULT NULL,
  `hostname` varchar(500) DEFAULT NULL,
  `uid` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `runid_idx` (`runid`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'The name of the project. eg. "AIBench"',
  `project_id` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'aibench','1');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scenario`
--

DROP TABLE IF EXISTS `scenario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `runid` varchar(500) DEFAULT NULL,
  `project_id` varchar(500) DEFAULT NULL COMMENT 'points to the REVISION table, ID field',
  `version` varchar(500) DEFAULT NULL,
  `commitid` varchar(500) DEFAULT NULL,
  `running_configuration` longtext DEFAULT NULL,
  `scenario_name` varchar(500) DEFAULT NULL,
  `logs_location` varchar(500) DEFAULT 'NULL' COMMENT 'The location of the shared point where all the logs are stored',
  `start_time` datetime DEFAULT NULL COMMENT 'Start time for a scenario',
  `end_time` datetime DEFAULT NULL COMMENT 'End time for a scenario',
  PRIMARY KEY (`id`),
  KEY `runid_idx` (`runid`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_details`
--

DROP TABLE IF EXISTS `storage_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_details` (
  `id` int(11) NOT NULL,
  `metadata_id` int(11) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `runid` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_metadata`
--

DROP TABLE IF EXISTS `storage_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_path` varchar(500) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `hash` varchar(128) DEFAULT NULL,
  `files` longtext DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `runid` varchar(500) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `stylesheet` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admiN@gmail.com','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-24  2:00:52

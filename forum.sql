-- MySQL dump 10.13  Distrib 5.6.21, for osx10.10 (x86_64)
--
-- Host: localhost    Database: forum
-- ------------------------------------------------------
-- Server version	5.6.21

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'版主'),(1,'管理员');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,17),(2,1,19),(3,1,20),(4,1,21),(5,1,22),(6,1,23),(7,1,24),(8,1,26),(9,1,27),(10,1,29),(11,1,30),(12,2,26),(13,2,27),(14,2,29),(15,2,30);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add content type',3,'add_contenttype'),(8,'Can change content type',3,'change_contenttype'),(9,'Can delete content type',3,'delete_contenttype'),(10,'Can add session',4,'add_session'),(11,'Can change session',4,'change_session'),(12,'Can delete session',4,'delete_session'),(13,'Can add log entry',5,'add_logentry'),(14,'Can change log entry',5,'change_logentry'),(15,'Can delete log entry',5,'delete_logentry'),(16,'Can add user',6,'add_forumuser'),(17,'Can change user',6,'change_forumuser'),(18,'Can delete user',6,'delete_forumuser'),(19,'Can add plane',7,'add_plane'),(20,'Can change plane',7,'change_plane'),(21,'Can delete plane',7,'delete_plane'),(22,'Can add node',8,'add_node'),(23,'Can change node',8,'change_node'),(24,'Can delete node',8,'delete_node'),(25,'Can add topic',9,'add_topic'),(26,'Can change topic',9,'change_topic'),(27,'Can delete topic',9,'delete_topic'),(28,'Can add reply',10,'add_reply'),(29,'Can change reply',10,'change_reply'),(30,'Can delete reply',10,'delete_reply'),(31,'Can add favorite',11,'add_favorite'),(32,'Can change favorite',11,'change_favorite'),(33,'Can delete favorite',11,'delete_favorite'),(34,'Can add notification',12,'add_notification'),(35,'Can change notification',12,'change_notification'),(36,'Can delete notification',12,'delete_notification'),(37,'Can add transaction',13,'add_transaction'),(38,'Can change transaction',13,'change_transaction'),(39,'Can delete transaction',13,'delete_transaction'),(40,'Can add vote',14,'add_vote'),(41,'Can change vote',14,'change_vote'),(42,'Can delete vote',14,'delete_vote');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_6c68e238` FOREIGN KEY (`user_id`) REFERENCES `forum_forumuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'content type','contenttypes','contenttype'),(4,'session','sessions','session'),(5,'log entry','admin','logentry'),(6,'user','forum','forumuser'),(7,'plane','forum','plane'),(8,'node','forum','node'),(9,'topic','forum','topic'),(10,'reply','forum','reply'),(11,'favorite','forum','favorite'),(12,'notification','forum','notification'),(13,'transaction','forum','transaction'),(14,'vote','forum','vote');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_favorite`
--

DROP TABLE IF EXISTS `forum_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_user_id` int(11) DEFAULT NULL,
  `involved_type` int(11) DEFAULT NULL,
  `involved_topic_id` int(11) DEFAULT NULL,
  `involved_reply_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_favorite_7cdabad6` (`owner_user_id`),
  KEY `forum_favorite_a12f20f1` (`involved_topic_id`),
  KEY `forum_favorite_99093a1e` (`involved_reply_id`),
  CONSTRAINT `involved_reply_id_refs_id_db861f67` FOREIGN KEY (`involved_reply_id`) REFERENCES `forum_reply` (`id`),
  CONSTRAINT `involved_topic_id_refs_id_80406b01` FOREIGN KEY (`involved_topic_id`) REFERENCES `forum_topic` (`id`),
  CONSTRAINT `owner_user_id_refs_id_78db67eb` FOREIGN KEY (`owner_user_id`) REFERENCES `forum_forumuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_favorite`
--

LOCK TABLES `forum_favorite` WRITE;
/*!40000 ALTER TABLE `forum_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_forumuser`
--

DROP TABLE IF EXISTS `forum_forumuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_forumuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  `nickname` varchar(200) DEFAULT NULL,
  `avatar` varchar(200) DEFAULT NULL,
  `signature` varchar(500) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `website` varchar(200) DEFAULT NULL,
  `company` varchar(200) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `reputation` int(11) DEFAULT NULL,
  `self_intro` varchar(500) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `twitter` varchar(200) DEFAULT NULL,
  `github` varchar(200) DEFAULT NULL,
  `douban` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_forumuser`
--

LOCK TABLES `forum_forumuser` WRITE;
/*!40000 ALTER TABLE `forum_forumuser` DISABLE KEYS */;
INSERT INTO `forum_forumuser` VALUES (1,'pbkdf2_sha256$10000$MeGMPC6hD1Pr$EweuoezP/1zlWZnAzqQ6kzSEg72AvQIpFidEF7+yPGU=','2015-01-23 13:36:57',1,'admin','','','admin@forum.com',1,1,'2015-01-23 13:35:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `forum_forumuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_forumuser_groups`
--

DROP TABLE IF EXISTS `forum_forumuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_forumuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forumuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forumuser_id` (`forumuser_id`,`group_id`),
  KEY `forum_forumuser_groups_4728ad57` (`forumuser_id`),
  KEY `forum_forumuser_groups_5f412f9a` (`group_id`),
  CONSTRAINT `forumuser_id_refs_id_822c2557` FOREIGN KEY (`forumuser_id`) REFERENCES `forum_forumuser` (`id`),
  CONSTRAINT `group_id_refs_id_4e7ca183` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_forumuser_groups`
--

LOCK TABLES `forum_forumuser_groups` WRITE;
/*!40000 ALTER TABLE `forum_forumuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_forumuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_forumuser_user_permissions`
--

DROP TABLE IF EXISTS `forum_forumuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_forumuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forumuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forumuser_id` (`forumuser_id`,`permission_id`),
  KEY `forum_forumuser_user_permissions_4728ad57` (`forumuser_id`),
  KEY `forum_forumuser_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `forumuser_id_refs_id_69df7695` FOREIGN KEY (`forumuser_id`) REFERENCES `forum_forumuser` (`id`),
  CONSTRAINT `permission_id_refs_id_70e54fc3` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_forumuser_user_permissions`
--

LOCK TABLES `forum_forumuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `forum_forumuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_forumuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_node`
--

DROP TABLE IF EXISTS `forum_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `thumb` varchar(200) DEFAULT NULL,
  `introduction` varchar(500) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `plane_id` int(11) DEFAULT NULL,
  `topic_count` int(11) DEFAULT NULL,
  `custom_style` text,
  `limit_reputation` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_node_05110e07` (`plane_id`),
  CONSTRAINT `plane_id_refs_id_550721f0` FOREIGN KEY (`plane_id`) REFERENCES `forum_plane` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_node`
--

LOCK TABLES `forum_node` WRITE;
/*!40000 ALTER TABLE `forum_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_notification`
--

DROP TABLE IF EXISTS `forum_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `status` int(11) DEFAULT NULL,
  `involved_type` int(11) DEFAULT NULL,
  `involved_user_id` int(11) DEFAULT NULL,
  `involved_topic_id` int(11) DEFAULT NULL,
  `involved_reply_id` int(11) DEFAULT NULL,
  `trigger_user_id` int(11) DEFAULT NULL,
  `occurrence_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_notification_95fdbe29` (`involved_user_id`),
  KEY `forum_notification_a12f20f1` (`involved_topic_id`),
  KEY `forum_notification_99093a1e` (`involved_reply_id`),
  KEY `forum_notification_431bdeb9` (`trigger_user_id`),
  CONSTRAINT `involved_reply_id_refs_id_9bd6430b` FOREIGN KEY (`involved_reply_id`) REFERENCES `forum_reply` (`id`),
  CONSTRAINT `involved_topic_id_refs_id_702d1de8` FOREIGN KEY (`involved_topic_id`) REFERENCES `forum_topic` (`id`),
  CONSTRAINT `involved_user_id_refs_id_e2f3fda9` FOREIGN KEY (`involved_user_id`) REFERENCES `forum_forumuser` (`id`),
  CONSTRAINT `trigger_user_id_refs_id_e2f3fda9` FOREIGN KEY (`trigger_user_id`) REFERENCES `forum_forumuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_notification`
--

LOCK TABLES `forum_notification` WRITE;
/*!40000 ALTER TABLE `forum_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_plane`
--

DROP TABLE IF EXISTS `forum_plane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_plane` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_plane`
--

LOCK TABLES `forum_plane` WRITE;
/*!40000 ALTER TABLE `forum_plane` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_plane` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_reply`
--

DROP TABLE IF EXISTS `forum_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `content` text,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `up_vote` int(11) DEFAULT NULL,
  `down_vote` int(11) DEFAULT NULL,
  `last_touched` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_reply_76f18ad3` (`topic_id`),
  KEY `forum_reply_e969df21` (`author_id`),
  CONSTRAINT `author_id_refs_id_4945e1fe` FOREIGN KEY (`author_id`) REFERENCES `forum_forumuser` (`id`),
  CONSTRAINT `topic_id_refs_id_92c2aa5d` FOREIGN KEY (`topic_id`) REFERENCES `forum_topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_reply`
--

LOCK TABLES `forum_reply` WRITE;
/*!40000 ALTER TABLE `forum_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_topic`
--

DROP TABLE IF EXISTS `forum_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `content` text,
  `status` int(11) DEFAULT NULL,
  `hits` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `node_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `reply_count` int(11) DEFAULT NULL,
  `last_replied_by_id` int(11) DEFAULT NULL,
  `last_replied_time` datetime DEFAULT NULL,
  `up_vote` int(11) DEFAULT NULL,
  `down_vote` int(11) DEFAULT NULL,
  `last_touched` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_topic_e453c5c5` (`node_id`),
  KEY `forum_topic_e969df21` (`author_id`),
  KEY `forum_topic_67b51778` (`last_replied_by_id`),
  CONSTRAINT `author_id_refs_id_524c87d9` FOREIGN KEY (`author_id`) REFERENCES `forum_forumuser` (`id`),
  CONSTRAINT `last_replied_by_id_refs_id_524c87d9` FOREIGN KEY (`last_replied_by_id`) REFERENCES `forum_forumuser` (`id`),
  CONSTRAINT `node_id_refs_id_5d0660c1` FOREIGN KEY (`node_id`) REFERENCES `forum_node` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_topic`
--

LOCK TABLES `forum_topic` WRITE;
/*!40000 ALTER TABLE `forum_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_transaction`
--

DROP TABLE IF EXISTS `forum_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `reward` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `current_balance` int(11) DEFAULT NULL,
  `involved_user_id` int(11) DEFAULT NULL,
  `involved_topic_id` int(11) DEFAULT NULL,
  `involved_reply_id` int(11) DEFAULT NULL,
  `occurrence_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_transaction_6340c63c` (`user_id`),
  KEY `forum_transaction_95fdbe29` (`involved_user_id`),
  KEY `forum_transaction_a12f20f1` (`involved_topic_id`),
  KEY `forum_transaction_99093a1e` (`involved_reply_id`),
  CONSTRAINT `involved_reply_id_refs_id_4b659a2b` FOREIGN KEY (`involved_reply_id`) REFERENCES `forum_reply` (`id`),
  CONSTRAINT `involved_topic_id_refs_id_49e3102d` FOREIGN KEY (`involved_topic_id`) REFERENCES `forum_topic` (`id`),
  CONSTRAINT `involved_user_id_refs_id_b0c88a45` FOREIGN KEY (`involved_user_id`) REFERENCES `forum_forumuser` (`id`),
  CONSTRAINT `user_id_refs_id_b0c88a45` FOREIGN KEY (`user_id`) REFERENCES `forum_forumuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_transaction`
--

LOCK TABLES `forum_transaction` WRITE;
/*!40000 ALTER TABLE `forum_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_vote`
--

DROP TABLE IF EXISTS `forum_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT NULL,
  `involved_type` int(11) DEFAULT NULL,
  `involved_user_id` int(11) DEFAULT NULL,
  `involved_topic_id` int(11) DEFAULT NULL,
  `involved_reply_id` int(11) DEFAULT NULL,
  `trigger_user_id` int(11) DEFAULT NULL,
  `occurrence_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_vote_95fdbe29` (`involved_user_id`),
  KEY `forum_vote_a12f20f1` (`involved_topic_id`),
  KEY `forum_vote_99093a1e` (`involved_reply_id`),
  KEY `forum_vote_431bdeb9` (`trigger_user_id`),
  CONSTRAINT `involved_reply_id_refs_id_83742c71` FOREIGN KEY (`involved_reply_id`) REFERENCES `forum_reply` (`id`),
  CONSTRAINT `involved_topic_id_refs_id_db1cceb1` FOREIGN KEY (`involved_topic_id`) REFERENCES `forum_topic` (`id`),
  CONSTRAINT `involved_user_id_refs_id_7a43045b` FOREIGN KEY (`involved_user_id`) REFERENCES `forum_forumuser` (`id`),
  CONSTRAINT `trigger_user_id_refs_id_7a43045b` FOREIGN KEY (`trigger_user_id`) REFERENCES `forum_forumuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_vote`
--

LOCK TABLES `forum_vote` WRITE;
/*!40000 ALTER TABLE `forum_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_vote` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-01-23 21:41:47

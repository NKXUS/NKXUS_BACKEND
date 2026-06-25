-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: nkxus-restore
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
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_keys` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_keys_key_unique` (`key`),
  KEY `api_keys_user_id_foreign` (`user_id`),
  CONSTRAINT `api_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `smmusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_keys`
--

LOCK TABLES `api_keys` WRITE;
/*!40000 ALTER TABLE `api_keys` DISABLE KEYS */;
INSERT INTO `api_keys` VALUES (1,1,'ak_live_1a2b3c4d5e6f7890','2026-05-25 09:48:32','2026-05-25 09:48:32'),(2,2,'ak_live_2b3c4d5e6f7890a1','2026-05-25 09:48:32','2026-05-25 09:48:32'),(3,3,'ak_live_3c4d5e6f7890a1b2','2026-05-25 09:48:32','2026-05-25 09:48:32'),(4,4,'ak_live_4d5e6f7890a1b2c3','2026-05-25 09:48:32','2026-05-25 09:48:32'),(5,5,'ak_live_5e6f7890a1b2c3d4','2026-05-25 09:48:32','2026-05-25 09:48:32'),(6,1,'ak_test_6f7890a1b2c3d4e5','2026-05-25 09:48:32','2026-05-25 09:48:32'),(7,2,'ak_test_7890a1b2c3d4e5f6','2026-05-25 09:48:32','2026-05-25 09:48:32'),(8,3,'ak_test_890a1b2c3d4e5f67','2026-05-25 09:48:32','2026-05-25 09:48:32'),(9,4,'ak_test_90a1b2c3d4e5f678','2026-05-25 09:48:32','2026-05-25 09:48:32'),(10,5,'ak_test_0a1b2c3d4e5f6789','2026-05-25 09:48:32','2026-05-25 09:48:32');
/*!40000 ALTER TABLE `api_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `symbol` varchar(255) NOT NULL,
  `exchange_rate` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mass_orders`
--

DROP TABLE IF EXISTS `mass_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mass_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `raw_input` text NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mass_orders_user_id_foreign` (`user_id`),
  CONSTRAINT `mass_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `smmusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mass_orders`
--

LOCK TABLES `mass_orders` WRITE;
/*!40000 ALTER TABLE `mass_orders` DISABLE KEYS */;
INSERT INTO `mass_orders` VALUES (1,1,'1 | https://www.instagram.com/exampleuser | 100\n2 | https://www.youtube.com/watch?v=abc123 | 500\n3 | https://t.me/examplechannel | 1000','partial','2026-05-23 03:15:19','2026-05-26 06:47:53'),(2,1,'service_id: 101 | link: https://instagram.com/example_page | quantity: 500','pending','2026-05-23 08:49:45','2026-05-23 08:49:45'),(3,1,'service_id: 102 | link: https://youtube.com/watch?v=abc123xyz | quantity: 1000','processing','2026-05-23 08:49:45','2026-05-23 08:49:45'),(4,2,'service_id: 103 | link: https://facebook.com/examplepost | quantity: 250','completed','2026-05-23 08:49:45','2026-05-23 08:49:45'),(5,2,'service_id: 104 | link: https://tiktok.com/@demo/video/123456 | quantity: 750','pending','2026-05-23 08:49:45','2026-05-23 08:49:45'),(6,3,'service_id: 105 | link: https://twitter.com/demo/status/123456789 | quantity: 300','failed','2026-05-23 08:49:45','2026-05-23 08:49:45'),(7,3,'service_id: 106 | link: https://instagram.com/reel/demo123 | quantity: 1200','processing','2026-05-23 08:49:45','2026-05-23 08:49:45'),(8,4,'service_id: 107 | link: https://youtube.com/@demochannel | quantity: 2000','pending','2026-05-23 08:49:45','2026-05-23 08:49:45'),(9,4,'service_id: 108 | link: https://linkedin.com/company/demo-company | quantity: 150','completed','2026-05-23 08:49:45','2026-05-23 08:49:45'),(10,5,'service_id: 109 | link: https://telegram.me/demochannel | quantity: 500','pending','2026-05-23 08:49:45','2026-05-23 08:49:45'),(11,5,'service_id: 110 | link: https://pinterest.com/pin/123456789 | quantity: 350','cancelled','2026-05-23 08:49:45','2026-05-23 08:49:45'),(12,1,'service_id: 101 | link: https://instagram.com/example_page | quantity: 500','pending','2026-05-23 08:51:45','2026-05-23 08:51:45'),(13,1,'service_id: 102 | link: https://youtube.com/watch?v=abc123xyz | quantity: 1000','processing','2026-05-23 08:51:45','2026-05-23 08:51:45'),(14,2,'service_id: 103 | link: https://facebook.com/examplepost | quantity: 250','completed','2026-05-23 08:51:45','2026-05-23 08:51:45'),(15,2,'service_id: 104 | link: https://tiktok.com/@demo/video/123456 | quantity: 750','pending','2026-05-23 08:51:45','2026-05-23 08:51:45'),(16,3,'service_id: 105 | link: https://twitter.com/demo/status/123456789 | quantity: 300','failed','2026-05-23 08:51:45','2026-05-23 08:51:45'),(17,3,'service_id: 106 | link: https://instagram.com/reel/demo123 | quantity: 1200','processing','2026-05-23 08:51:45','2026-05-23 08:51:45'),(18,4,'service_id: 107 | link: https://youtube.com/@demochannel | quantity: 2000','pending','2026-05-23 08:51:45','2026-05-23 08:51:45'),(19,4,'service_id: 108 | link: https://linkedin.com/company/demo-company | quantity: 150','completed','2026-05-23 08:51:45','2026-05-23 08:51:45'),(20,5,'service_id: 109 | link: https://telegram.me/demochannel | quantity: 500','pending','2026-05-23 08:51:45','2026-05-23 08:51:45'),(21,5,'service_id: 110 | link: https://pinterest.com/pin/123456789 | quantity: 350','cancelled','2026-05-23 08:51:45','2026-05-23 08:51:45'),(22,16,'1 | https://www.instagram.com/exampleuser | 100\n2 | https://www.youtube.com/watch?v=abc123 | 500\n3 | https://t.me/examplechannel | 1000','completed','2026-05-23 03:24:02','2026-05-26 06:49:55'),(23,16,'sdoifjiosoidf','pending','2026-05-26 03:50:20','2026-05-26 03:50:20');
/*!40000 ALTER TABLE `mass_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_05_14_054103_create_smmusers_table',1),(5,'2026_05_14_054408_create_service_categories_table',1),(6,'2026_05_14_054429_create_services_table',1),(7,'2026_05_14_054448_create_orders_table',1),(8,'2026_05_14_054506_create_payments_table',1),(9,'2026_05_14_054522_create_mass_orders_table',1),(10,'2026_05_14_054538_create_support_tickets_table',1),(11,'2026_05_14_054555_create_referrals_table',1),(12,'2026_05_14_054614_create_payouts_table',1),(13,'2026_05_14_054629_create_service_updates_table',1),(14,'2026_05_14_054644_create_notification_preferences_table',1),(15,'2026_05_14_054712_create_api_keys_table',1),(16,'2026_05_14_054742_create_currencies_table',1),(17,'2026_05_14_054756_create_whats_app_widgets_table',1),(18,'2026_05_15_092053_add_phone_number_to_smmusers_table',1),(19,'2026_05_16_102704_add_email_to_support_tickets_table',1),(20,'2026_05_18_000000_add_api_token_to_smmusers_table',1),(21,'2026_05_18_010000_add_stats_to_referrals_table',1),(22,'2026_05_19_000000_add_referrer_id_to_smmusers_table',1),(23,'2026_05_25_000000_add_role_to_smmusers_table',2),(24,'2026_05_28_000000_add_google_auth_to_smmusers_table',3),(25,'2026_06_01_000000_add_profile_image_to_smmusers_table',3),(26,'2026_06_19_102844_create_personal_access_tokens_table',4),(27,'2026_06_19_104501_add_nkxus_fields_to_users_table',4);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_preferences`
--

DROP TABLE IF EXISTS `notification_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_preferences` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `email_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `telegram_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `telegram_connected` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_preferences_user_id_foreign` (`user_id`),
  CONSTRAINT `notification_preferences_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `smmusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_preferences`
--

LOCK TABLES `notification_preferences` WRITE;
/*!40000 ALTER TABLE `notification_preferences` DISABLE KEYS */;
INSERT INTO `notification_preferences` VALUES (1,1,'order_updates',1,0,0,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(2,1,'payment_updates',1,1,1,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(3,1,'service_updates',1,0,0,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(4,2,'order_updates',1,1,0,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(5,2,'payment_updates',0,1,1,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(6,2,'security_alerts',1,0,0,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(7,3,'order_updates',1,0,0,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(8,3,'payment_updates',1,1,1,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(9,3,'promotions',0,0,0,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(10,4,'service_updates',1,1,0,'2026-05-23 04:51:13','2026-05-23 04:51:13'),(11,1,'api_key_changed',1,1,0,'2026-05-22 23:50:54','2026-05-22 23:50:54'),(12,1,'new_message',1,1,0,'2026-05-22 23:50:54','2026-05-22 23:50:54'),(13,1,'api_key_changed',0,1,0,'2026-05-22 23:51:27','2026-05-22 23:51:27'),(14,1,'new_message',1,0,0,'2026-05-22 23:51:27','2026-05-22 23:51:27'),(15,1,'api_key_changed',0,1,1,'2026-05-22 23:51:45','2026-05-22 23:51:45'),(16,1,'new_message',1,0,1,'2026-05-22 23:51:45','2026-05-22 23:51:45'),(17,1,'api_key_changed',1,1,1,'2026-05-22 23:52:36','2026-05-22 23:52:36'),(18,1,'new_message',1,1,1,'2026-05-22 23:52:36','2026-05-22 23:52:36'),(19,16,'api_key_changed',1,1,0,'2026-05-22 23:57:23','2026-05-22 23:57:23'),(20,16,'new_message',1,1,0,'2026-05-22 23:57:24','2026-05-22 23:57:24');
/*!40000 ALTER TABLE `notification_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `service_id` bigint(20) unsigned NOT NULL,
  `link` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `charge` decimal(12,2) NOT NULL,
  `start_count` int(11) NOT NULL DEFAULT 0,
  `remains` int(11) NOT NULL DEFAULT 0,
  `status` enum('pending','in_progress','completed','partial','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rate_per_1000` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `orders_user_id_foreign` (`user_id`),
  KEY `orders_service_id_foreign` (`service_id`),
  CONSTRAINT `orders_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `smmusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,'https://www.instagram.com/example_profile/',1000,250.00,1200,0,'completed','2026-05-22 07:11:36','2026-05-26 01:48:24',0.00,0.00),(2,1,3,'https://www.instagram.com/p/ABC123xyz/',500,40.00,250,0,'completed','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(3,2,4,'https://www.instagram.com/reel/REEL123abc/',2000,240.00,1500,300,'in_progress','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(4,2,7,'https://www.youtube.com/watch?v=abc123xyz',1000,950.00,80,1000,'pending','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(5,3,8,'https://www.youtube.com/watch?v=demo456',5000,750.00,1200,2500,'in_progress','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(6,3,10,'https://www.youtube.com/shorts/short123',300,90.00,45,0,'completed','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(7,4,11,'https://www.facebook.com/examplepage',1000,350.00,500,1000,'pending','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(8,4,13,'https://www.tiktok.com/@exampleuser',2000,800.00,300,0,'completed','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(9,5,14,'https://www.tiktok.com/@exampleuser/video/123456789',10000,700.00,5000,4000,'in_progress','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(10,5,15,'https://t.me/examplechannel',1500,420.00,250,1500,'pending','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(11,1,16,'https://www.linkedin.com/company/example-company/',500,300.00,100,0,'completed','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(12,2,2,'https://www.instagram.com/another_profile/',1000,180.00,900,200,'partial','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(13,3,5,'https://www.instagram.com/stories/example/123456/',1000,60.00,400,1000,'pending','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(14,4,9,'https://www.youtube.com/watch?v=fast789',10000,2200.00,3000,7000,'in_progress','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(15,5,6,'https://www.instagram.com/p/photo789/',500,30.00,200,500,'cancelled','2026-05-22 07:11:36','2026-05-22 07:11:36',0.00,0.00),(16,1,10,'http/link',111,33.30,0,0,'pending','2026-05-22 02:34:51','2026-05-22 02:34:51',0.00,0.00),(17,1,7,'http/grf',22,20.90,0,0,'pending','2026-05-23 03:50:43','2026-05-23 03:50:43',0.00,0.00),(18,8,8,'http',11,1.65,0,0,'pending','2026-05-23 05:40:31','2026-05-23 05:40:31',0.00,0.00),(19,8,10,'aa',486,145.80,0,0,'pending','2026-05-23 05:42:32','2026-05-23 05:42:32',0.00,0.00),(20,8,1,'http',8400,2100.00,0,0,'completed','2026-05-23 05:51:43','2026-05-23 05:51:43',0.00,0.00),(21,9,4,'https',9999,1199.88,0,0,'completed','2026-05-23 06:27:18','2026-05-23 06:27:18',0.00,0.00),(22,14,7,'http/insta',10,9.50,0,0,'pending','2026-05-25 01:19:29','2026-05-25 01:19:29',0.00,0.00),(23,16,7,'https//youtube',8,7.60,0,0,'pending','2026-05-25 02:03:01','2026-05-25 02:03:01',0.00,0.00),(24,16,8,'http',109,16.35,0,0,'pending','2026-05-25 04:51:18','2026-05-25 04:51:18',0.00,0.00),(25,16,3,'http',10922,873.76,0,0,'pending','2026-05-25 04:52:15','2026-05-25 04:52:15',0.00,0.00),(26,16,1,'uiyghkyugyui',99,24.75,0,0,'pending','2026-05-25 23:38:14','2026-05-25 23:38:14',0.00,0.00),(27,16,9,'aa',2223,489.06,0,0,'pending','2026-05-26 00:57:57','2026-05-26 00:57:57',0.00,0.00),(28,16,16,'rrr',22,13.20,0,0,'pending','2026-05-26 01:01:12','2026-05-26 01:01:12',0.00,0.00),(29,16,7,'waw',108,102.60,0,0,'completed','2026-05-26 01:03:10','2026-05-26 03:20:01',0.00,0.00),(30,16,9,'sd',3233,711.26,0,0,'completed','2026-05-26 01:03:38','2026-05-26 03:17:43',0.00,0.00),(31,16,10,'ded',19,5.70,0,0,'pending','2026-05-26 01:04:08','2026-05-26 01:04:08',0.00,0.00),(32,16,10,'df',3313,993.90,0,0,'completed','2026-05-26 01:04:24','2026-05-26 02:00:51',0.00,0.00),(33,16,11,'kk',220,77.00,0,0,'completed','2026-05-26 01:12:47','2026-05-26 03:12:39',0.00,0.00),(34,16,6,'ghh',202,12.12,0,0,'completed','2026-05-26 01:14:36','2026-05-26 03:16:16',0.00,0.00),(35,16,4,'gfhtg',4246,509.52,0,0,'completed','2026-05-26 03:04:06','2026-05-26 03:05:46',0.00,0.00),(36,18,1,'qwFEAWFAS',998,249.50,0,0,'completed','2026-05-26 03:54:22','2026-05-26 03:55:21',0.00,0.00),(37,20,8,'ss',22222,3333.30,0,0,'completed','2026-05-26 04:24:27','2026-05-26 04:24:41',0.00,0.00),(38,16,1,'ss',2022,505.50,0,0,'cancelled','2026-05-26 04:37:48','2026-05-26 04:39:42',0.00,0.00),(39,16,3,'wd',220,17.60,0,0,'completed','2026-05-26 04:40:37','2026-05-26 04:40:37',0.00,0.00),(40,16,7,'ssw',8112,7706.40,0,0,'pending','2026-05-26 04:49:01','2026-05-26 04:49:34',0.00,0.00),(41,16,4,'ww',22212,2665.44,0,0,'completed','2026-05-26 05:07:19','2026-05-26 05:07:19',0.00,0.00),(42,16,15,'65r5676i',9997,2799.16,0,0,'completed','2026-05-26 05:41:55','2026-05-26 05:41:55',0.00,0.00),(43,16,10,'ewwe',3333,999.90,0,0,'completed','2026-05-26 06:21:13','2026-05-26 06:21:13',0.00,0.00),(44,16,7,'https',1925,1828.75,0,0,'completed','2026-05-27 00:38:01','2026-05-27 00:38:01',0.00,0.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
INSERT INTO `password_reset_tokens` VALUES ('akshayamaramm@gmail.com','$2y$12$yhP3QOox9jc4.5l7ROMT6Os5dv75eOeNzPlTqDsnT89/HcCVaCibO','2026-05-22 01:16:04');
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `method` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_user_id_foreign` (`user_id`),
  CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `smmusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,5000.00,'Paytm / PhonePe QR','1111111111','success','2026-05-25 00:23:37','2026-05-25 00:23:37'),(2,1,5000.00,'UPI Gateway','3333333333','pending','2026-05-25 00:26:04','2026-05-25 00:26:04'),(3,1,2500.00,'Crypto','3333333333','pending','2026-05-25 00:28:44','2026-05-25 00:28:44'),(4,1,1000.00,'UPI Gateway','7777777777','pending','2026-05-25 00:30:57','2026-05-25 00:30:57'),(5,1,1000.00,'UPI Gateway','3333333333','success','2026-05-25 00:33:27','2026-05-25 00:33:27'),(6,1,1000.00,'Crypto','9999999999','success','2026-05-25 00:34:32','2026-05-25 00:34:32'),(7,14,5000.00,'UPI Gateway','9999999999','success','2026-05-25 00:35:58','2026-05-25 00:35:58'),(8,14,2500.00,'Crypto','1111111111','success','2026-05-25 01:17:14','2026-05-25 01:17:14'),(9,16,2500.00,'Crypto','8888888888','success','2026-05-25 01:22:22','2026-05-25 01:22:22'),(10,16,1000.00,'Perfect Money','8888888888','success','2026-05-25 01:24:33','2026-05-25 01:24:33'),(11,16,2500.00,'Crypto','9999999999','success','2026-05-25 01:25:19','2026-05-25 01:25:19'),(12,16,2500.00,'Crypto','8888888888','success','2026-05-25 01:47:17','2026-05-25 01:47:17'),(13,16,2500.00,'Crypto','8888888888','success','2026-05-25 01:51:05','2026-05-25 01:51:05'),(14,16,2500.00,'UPI Gateway','6666666666','success','2026-05-25 01:51:45','2026-05-25 01:51:45'),(15,16,2500.00,'UPI Gateway','8888888888','success','2026-05-25 01:54:07','2026-05-25 01:54:07'),(16,16,2500.00,'UPI Gateway','2222222222','success','2026-05-25 04:55:53','2026-05-25 04:55:53'),(17,16,1000.00,'Paytm / PhonePe QR','1111111111','success','2026-05-25 06:43:53','2026-05-25 06:43:53'),(18,16,5000.00,'Paytm / PhonePe QR','9999999999','success','2026-05-25 06:44:13','2026-05-25 06:44:13'),(19,16,2500.00,'Paytm / PhonePe QR','8888888888','success','2026-05-25 06:44:26','2026-05-25 06:44:26'),(20,16,2500.00,'Paytm / PhonePe QR','0000000000','success','2026-05-25 06:44:48','2026-05-25 06:44:48'),(21,16,2500.00,'Paytm / PhonePe QR','2222222222','success','2026-05-25 06:45:12','2026-05-25 06:45:12'),(22,16,1000.00,'Paytm / PhonePe QR','2222222222','success','2026-05-25 06:45:33','2026-05-25 06:45:33'),(23,16,1000.00,'UPI Gateway','1111111111','success','2026-05-25 06:47:57','2026-05-25 06:47:57'),(24,16,100.00,'Paytm / PhonePe QR','9160442065','success','2026-05-25 23:36:29','2026-05-25 23:36:29'),(25,16,1000.00,'UPI Gateway','9160442065','success','2026-05-26 01:13:35','2026-05-26 01:59:31'),(26,16,1000.00,'UPI Gateway','9160442065','pending','2026-05-26 01:18:29','2026-05-26 02:03:54'),(27,16,1000.00,'Crypto','9160442065','success','2026-05-26 01:26:36','2026-05-26 02:57:39'),(28,16,2500.00,'Crypto','9160442065','partial','2026-05-26 01:27:05','2026-05-26 01:27:05'),(29,16,1000.00,'UPI Gateway','9160442065','success','2026-05-26 02:50:06','2026-05-26 02:50:37'),(30,16,1000.00,'Paytm / PhonePe QR','9160442065','success','2026-05-26 02:51:58','2026-05-26 03:22:36'),(31,16,2500.00,'Paytm / PhonePe QR','9160442065','partial','2026-05-26 03:03:12','2026-05-26 03:03:12'),(32,16,100.00,'Crypto','9160442065','success','2026-05-26 03:48:36','2026-05-26 03:49:36'),(33,18,2500.00,'Paytm / PhonePe QR','9160442065','success','2026-05-26 03:51:59','2026-05-26 03:53:35'),(34,20,2500.00,'Paytm / PhonePe QR','8765678765','success','2026-05-26 04:06:26','2026-05-26 04:08:12'),(35,20,2500.00,'Paytm / PhonePe QR','9898989876','success','2026-05-26 04:08:49','2026-05-26 04:10:07'),(36,20,1000.00,'Paytm / PhonePe QR','9876567867','success','2026-05-26 04:14:43','2026-05-26 04:22:49'),(37,16,2500.00,'Paytm / PhonePe QR','9160442065','cancelled','2026-05-26 04:41:31','2026-05-26 04:44:56'),(38,16,2500.00,'Paytm / PhonePe QR','9160442065','success','2026-05-26 05:04:42','2026-05-26 05:04:42'),(39,16,5000.00,'Paytm / PhonePe QR','9160442065','success','2026-05-26 05:06:04','2026-05-26 05:06:04'),(40,16,5000.00,'Paytm / PhonePe QR','9160442065','success','2026-05-26 05:07:44','2026-05-26 05:07:44'),(41,16,2500.00,'Paytm / PhonePe QR','9160442065','success','2026-05-26 05:13:15','2026-05-26 05:13:15'),(42,18,2500.00,'Paytm / PhonePe QR','2222222222','success','2026-05-26 05:14:02','2026-05-26 05:14:02'),(43,16,98.00,'Crypto','9160442065','success','2026-05-26 05:39:52','2026-05-26 05:39:52'),(44,16,2500.00,'Paytm / PhonePe QR','9160442065','pending','2026-05-26 06:02:23','2026-05-26 06:02:23'),(45,16,1000.00,'Paytm / PhonePe QR','9160442065','cancelled','2026-05-26 06:04:42','2026-05-26 06:15:39'),(46,21,5000.00,'Paytm / PhonePe QR','9160442065','approved','2026-05-26 06:30:01','2026-05-26 06:31:49'),(47,16,2500.00,'Paytm / PhonePe QR','9160442065','approved','2026-05-27 00:27:30','2026-05-27 00:27:45');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payouts`
--

DROP TABLE IF EXISTS `payouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payouts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `referral_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `status` varchar(255) NOT NULL,
  `payout_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payouts_referral_id_foreign` (`referral_id`),
  CONSTRAINT `payouts_referral_id_foreign` FOREIGN KEY (`referral_id`) REFERENCES `referrals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payouts`
--

LOCK TABLES `payouts` WRITE;
/*!40000 ALTER TABLE `payouts` DISABLE KEYS */;
INSERT INTO `payouts` VALUES (1,1,10.00,'success','2026-05-27','2026-05-27 00:30:31','2026-05-27 00:30:31'),(2,1,10.00,'success','2026-05-27','2026-05-27 00:34:32','2026-05-27 00:34:32');
/*!40000 ALTER TABLE `payouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',27,'nkxus-auth-token','d043cd3cc26dc221f6a1141740a740733caa266d1d39bdcb1a752fd045a1f58c','[\"*\"]',NULL,NULL,'2026-06-23 04:39:45','2026-06-23 04:39:45'),(2,'App\\Models\\User',27,'nkxus-auth-token','5eaaae6f68055156f9a4cdd810a7371cc557d38bcdad089679b329bab594c2a2','[\"*\"]',NULL,NULL,'2026-06-23 04:40:45','2026-06-23 04:40:45'),(3,'App\\Models\\User',28,'nkxus-auth-token','e18211c4dfc27e4628da3eeab7d4bb634bf725957f46a1256f612e0f10c8a155','[\"*\"]',NULL,NULL,'2026-06-23 05:53:29','2026-06-23 05:53:29'),(4,'App\\Models\\User',28,'nkxus-auth-token','c53a4c8f717908f86e8353067957835603f54142632e1d2258fb8b7083eb23ab','[\"*\"]',NULL,NULL,'2026-06-23 05:54:03','2026-06-23 05:54:03'),(5,'App\\Models\\User',28,'nkxus-auth-token','76a6c71b4ef400145fe4be246c8d84ad522d62af3e2e0c5a8c9528f4e5f9f969','[\"*\"]',NULL,NULL,'2026-06-23 06:00:10','2026-06-23 06:00:10'),(6,'App\\Models\\User',29,'nkxus-auth-token','29766c1613af82fe342ec0fc2543654edf659a8dd0b4fd80fa871e31cb9cf872','[\"*\"]',NULL,NULL,'2026-06-23 06:00:29','2026-06-23 06:00:29'),(7,'App\\Models\\User',29,'nkxus-auth-token','50fa5f8193101a921dcef674bd25e30aaf6214562804fb7244a8f7e6e9a929b6','[\"*\"]',NULL,NULL,'2026-06-23 06:00:56','2026-06-23 06:00:56'),(8,'App\\Models\\User',28,'nkxus-auth-token','a134e4a17ceb38b912af5877b0d58bcc692b42abfc7a1d9a8d79225bef45e5f2','[\"*\"]',NULL,NULL,'2026-06-23 06:03:35','2026-06-23 06:03:35'),(9,'App\\Models\\User',30,'nkxus-auth-token','9d54f04b68a396693f6ba887aec7aff4fe8c5513b63817f24a023997b7eb2e71','[\"*\"]',NULL,NULL,'2026-06-23 06:31:12','2026-06-23 06:31:12'),(10,'App\\Models\\User',28,'nkxus-auth-token','539861645f7cf77dbd82482cebaebe7951b32ab0a29409103cd49b054644e461','[\"*\"]',NULL,NULL,'2026-06-23 06:35:23','2026-06-23 06:35:23');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referrals`
--

DROP TABLE IF EXISTS `referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referrals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `referrer_id` bigint(20) unsigned NOT NULL,
  `referral_link` varchar(255) NOT NULL,
  `visits` int(10) unsigned NOT NULL DEFAULT 0,
  `registrations` int(10) unsigned NOT NULL DEFAULT 0,
  `referrals_count` int(10) unsigned NOT NULL DEFAULT 0,
  `commission_rate` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_earnings` decimal(12,2) NOT NULL DEFAULT 0.00,
  `available_earnings` decimal(12,2) NOT NULL DEFAULT 0.00,
  `min_payout` decimal(12,2) NOT NULL DEFAULT 0.00,
  `conversion_rate` decimal(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `referrals_referrer_id_foreign` (`referrer_id`),
  CONSTRAINT `referrals_referrer_id_foreign` FOREIGN KEY (`referrer_id`) REFERENCES `smmusers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referrals`
--

LOCK TABLES `referrals` WRITE;
/*!40000 ALTER TABLE `referrals` DISABLE KEYS */;
INSERT INTO `referrals` VALUES (1,1,'http://127.0.0.1:5501/signup.html?ref=1',4,4,4,3.00,2455.35,110.77,10.00,100.00,'2026-05-24 23:59:58','2026-05-27 00:38:01'),(2,14,'http://127.0.0.1:5501/signup.html?ref=14',0,0,0,3.00,0.00,0.00,10.00,0.00,'2026-05-25 00:28:29','2026-05-25 00:28:29'),(3,16,'http://127.0.0.1:5501/signup.html?ref=16',1,1,1,3.00,157.49,0.00,10.00,100.00,'2026-05-25 01:25:36','2026-05-26 05:14:02'),(4,17,'http://127.0.0.1:5501/signup.html?ref=17',0,0,0,3.00,0.00,0.00,10.00,0.00,'2026-05-25 01:29:34','2026-05-25 01:29:34'),(5,18,'http://127.0.0.1:5501/signup.html?ref=18',0,0,0,3.00,0.00,0.00,10.00,0.00,'2026-05-26 03:51:45','2026-05-26 03:51:45'),(6,19,'http://127.0.0.1:5501/signup.html?ref=19',0,0,0,3.00,0.00,0.00,10.00,0.00,'2026-05-26 04:02:41','2026-05-26 04:02:41'),(7,20,'http://127.0.0.1:5501/signup.html?ref=20',0,0,0,3.00,0.00,0.00,10.00,0.00,'2026-05-26 04:07:43','2026-05-26 04:07:43'),(8,21,'http://127.0.0.1:5501/signup.html?ref=21',0,0,0,3.00,0.00,0.00,10.00,0.00,'2026-05-26 06:34:05','2026-05-26 06:34:05');
/*!40000 ALTER TABLE `referrals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_categories`
--

DROP TABLE IF EXISTS `service_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `platform` varchar(255) NOT NULL,
  `icon_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_categories`
--

LOCK TABLES `service_categories` WRITE;
/*!40000 ALTER TABLE `service_categories` DISABLE KEYS */;
INSERT INTO `service_categories` VALUES (1,'Instagram Followers','Instagram','https://cdn-icons-png.flaticon.com/512/2111/2111463.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(2,'Instagram Likes','Instagram','https://cdn-icons-png.flaticon.com/512/2111/2111463.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(3,'Instagram Views','Instagram','https://cdn-icons-png.flaticon.com/512/2111/2111463.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(4,'YouTube Subscribers','YouTube','https://cdn-icons-png.flaticon.com/512/1384/1384060.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(5,'YouTube Views','YouTube','https://cdn-icons-png.flaticon.com/512/1384/1384060.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(6,'YouTube Likes','YouTube','https://cdn-icons-png.flaticon.com/512/1384/1384060.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(7,'Facebook Page Likes','Facebook','https://cdn-icons-png.flaticon.com/512/733/733547.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(8,'Facebook Followers','Facebook','https://cdn-icons-png.flaticon.com/512/733/733547.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(9,'TikTok Followers','TikTok','https://cdn-icons-png.flaticon.com/512/3046/3046121.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(10,'TikTok Views','TikTok','https://cdn-icons-png.flaticon.com/512/3046/3046121.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(11,'Telegram Members','Telegram','https://cdn-icons-png.flaticon.com/512/2111/2111646.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1),(12,'LinkedIn Followers','LinkedIn','https://cdn-icons-png.flaticon.com/512/145/145807.png','2026-05-22 07:02:45','2026-05-22 07:02:45',NULL,0,1);
/*!40000 ALTER TABLE `service_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_updates`
--

DROP TABLE IF EXISTS `service_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_updates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint(20) unsigned NOT NULL,
  `type` enum('new','rate_dec','rate_inc','enabled','disabled') NOT NULL,
  `old_rate` decimal(12,2) DEFAULT NULL,
  `new_rate` decimal(12,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_updates_service_id_foreign` (`service_id`),
  CONSTRAINT `service_updates_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_updates`
--

LOCK TABLES `service_updates` WRITE;
/*!40000 ALTER TABLE `service_updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate_per_1000` decimal(12,2) NOT NULL,
  `min_order` int(11) NOT NULL,
  `max_order` int(11) NOT NULL,
  `avg_time` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `platform` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `quality_type` varchar(50) DEFAULT NULL,
  `allowed_quantities` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `services_category_id_foreign` (`category_id`),
  CONSTRAINT `services_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `service_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,1,'Instagram Followers - Real Quality',250.00,100,10000,'1-3 hours','High quality Instagram followers service with stable delivery.','Instagram',1,1,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(2,1,'Instagram Followers - Indian Users',180.00,100,5000,'2-6 hours','Instagram followers from Indian audience suitable for profile growth.','Instagram',1,0,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(3,2,'Instagram Likes - Instant Start',80.00,50,20000,'0-1 hour','Fast Instagram likes service for posts, reels, and photos.','Instagram',1,1,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(4,2,'Instagram Likes - High Quality',120.00,50,10000,'1-2 hours','Premium quality Instagram likes with smooth delivery.','Instagram',1,0,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(5,3,'Instagram Reels Views',40.00,100,100000,'0-2 hours','Instagram reels views service with quick start and high capacity.','Instagram',1,1,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(6,3,'Instagram Story Views',60.00,100,50000,'1-3 hours','Story views service for Instagram stories and highlights.','Instagram',1,0,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(7,4,'YouTube Subscribers - Stable',950.00,100,5000,'1-3 days','YouTube subscribers service for channel growth and credibility.','YouTube',1,1,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(8,5,'YouTube Views - Regular',150.00,500,100000,'3-12 hours','YouTube video views service for normal videos and campaigns.','YouTube',1,0,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(9,5,'YouTube Views - Fast Delivery',220.00,1000,200000,'1-6 hours','Fast YouTube views service with large order support.','YouTube',1,1,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(10,6,'YouTube Likes',300.00,50,10000,'2-8 hours','YouTube likes service for videos, shorts, and channel content.','YouTube',1,0,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(11,7,'Facebook Page Likes',350.00,100,10000,'1-2 days','Facebook page likes service for business and creator pages.','Facebook',1,0,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(12,8,'Facebook Followers',300.00,100,15000,'1-3 days','Facebook followers service for personal profiles and pages.','Facebook',1,0,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(13,9,'TikTok Followers',400.00,100,20000,'2-12 hours','TikTok followers service for profile growth.','TikTok',1,1,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(14,10,'TikTok Views',70.00,1000,500000,'0-3 hours','TikTok video views service with fast delivery.','TikTok',1,1,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(15,11,'Telegram Members',280.00,100,50000,'1-6 hours','Telegram group and channel members service.','Telegram',1,0,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(16,12,'LinkedIn Followers',600.00,100,5000,'1-3 days','LinkedIn followers service for company pages and professional profiles.','LinkedIn',1,0,'2026-05-22 07:08:20','2026-05-22 07:08:20',NULL,NULL,NULL),(17,7,'ww',111.00,11,12,'1 hour','www','ww',1,0,'2026-05-26 00:44:18','2026-05-26 00:44:18',NULL,NULL,NULL);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smmusers`
--

DROP TABLE IF EXISTS `smmusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smmusers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `balance` decimal(12,2) NOT NULL DEFAULT 0.00,
  `api_key` varchar(255) DEFAULT NULL,
  `api_token` varchar(100) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `google_avatar` varchar(255) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'client',
  `referrer_id` bigint(20) unsigned DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT 'Asia/Kolkata',
  `currency` varchar(255) DEFAULT NULL,
  `two_fa_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `telegram_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `remember_token` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `smmusers_api_token_unique` (`api_token`),
  UNIQUE KEY `smmusers_google_id_unique` (`google_id`),
  KEY `smmusers_referrer_id_foreign` (`referrer_id`),
  CONSTRAINT `smmusers_referrer_id_foreign` FOREIGN KEY (`referrer_id`) REFERENCES `smmusers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smmusers`
--

LOCK TABLES `smmusers` WRITE;
/*!40000 ALTER TABLE `smmusers` DISABLE KEYS */;
INSERT INTO `smmusers` VALUES (1,'Akshaya','akshayamaramm@gmail.com','2323232323','$2y$12$exhBquC6pjlQlUr/AjZXRezR05uDic2islP5OHFWWpEqmEkafFI6O',2966.30,'GbHQedaMw3mB5aRVa9lK45SQSUSaaOhS8Rpr2g7DHyjoKYAb3qeaJEDR14aGt8QL9PBjN5nfMl1YiIxy','ek6auSmqTYjYqQEB0mMaVwxmWvZvkRsoUONmRz0sPnxWubRtLiyt52rAq3rHY8SsJqIIS4RzXOzzmx9C',NULL,NULL,'profile-images/user-1-z7BIy0A6ysU9.jpg','admin',NULL,'en','Asia/Kolkata','INR',0,'987654323','2026-05-22 01:03:09','2026-06-22 01:22:04',NULL,'active',NULL),(2,'rahul_smm','rahul@example.com','9876543210','$2y$12$exhBquC6pjlQlUr/AjZXRezR05uDic2islP5OHFWWpEqmEkafFI6O',500.00,'APIKEY_RAHUL_12345','TOKEN_RAHUL_1001',NULL,NULL,NULL,'client',NULL,'English','Asia/Kolkata','INR',0,'rahul_telegram','2026-05-22 06:55:29','2026-05-22 06:55:29',NULL,'active',NULL),(3,'priya_panel','priya@example.com','9123456780','$2y$12$exhBquC6pjlQlUr/AjZXRezR05uDic2islP5OHFWWpEqmEkafFI6O',1200.50,'APIKEY_PRIYA_12345','TOKEN_PRIYA_1002',NULL,NULL,NULL,'client',NULL,'English','Asia/Kolkata','INR',1,'priya_telegram','2026-05-22 06:55:29','2026-05-22 06:55:29',NULL,'active',NULL),(4,'amit_marketing','amit@example.com','9988776655','$2y$12$exhBquC6pjlQlUr/AjZXRezR05uDic2islP5OHFWWpEqmEkafFI6O',300.75,'APIKEY_AMIT_12345','TOKEN_AMIT_1003',NULL,NULL,NULL,'client',NULL,'Hindi','Asia/Kolkata','INR',0,'amit_telegram','2026-05-22 06:55:29','2026-05-22 06:55:29',NULL,'active',NULL),(5,'sneha_smm','sneha@example.com','9090909090','$2y$12$exhBquC6pjlQlUr/AjZXRezR05uDic2islP5OHFWWpEqmEkafFI6O',750.00,'APIKEY_SNEHA_12345','TOKEN_SNEHA_1004',NULL,NULL,NULL,'client',NULL,'English','Asia/Kolkata','INR',0,'sneha_telegram','2026-05-22 06:55:29','2026-05-22 06:55:29',NULL,'active',NULL),(6,'arjun_growth','arjun@example.com','8888888888','$2y$12$exhBquC6pjlQlUr/AjZXRezR05uDic2islP5OHFWWpEqmEkafFI6O',2000.00,'APIKEY_ARJUN_12345','TOKEN_ARJUN_1005',NULL,NULL,NULL,'client',NULL,'English','Asia/Kolkata','INR',1,'arjun_telegram','2026-05-22 06:55:29','2026-05-22 06:55:29',NULL,'active',NULL),(7,'asheesh','asheesh@gmail.com',NULL,'$2y$12$UKu97sltAYTCFAu60ardpexWXi/uiHPV89GYEHxWHAljjcXzLrCk6',0.00,'rIztXMsAcV7dA0tajfob1h4vXnzLWmbLDOBoCT2J9gEnwxfnywTSlIey2QWDLSRr17WKk5BwC5xKTZqX',NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-05-23 05:07:15','2026-05-23 05:07:15',NULL,'active',NULL),(8,'ssh','ssh@gmail.com',NULL,'$2y$12$E.bP4txC6oTEI4NzUDr0ceeL/iCfatIE8xPP5F9cHE1YbHPg5Y3mO',2900.00,'sEj1iFjkszFWuMTPyUWC94Kd2Ij4PKIEi0E6LsC1xFITsGngJqpNoGi6YZr5cnyQkXrTvIp8by8KfO5q',NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-05-23 05:33:09','2026-05-23 06:23:23',NULL,'active',NULL),(9,'sai','sai@gmail.com',NULL,'$2y$12$UyWSClLxbErssjStzRc6bOtzBQI5HkCjTtvr/0Ij0h2wPyTyTUKY6',3800.12,'gQkmLsWqMRKiso2JVmxRmWdHAis9TEHPfDeEs8zwv5jUjVwxU4fUnk7NtJhAjHGBAY3ZWYcYUPpFk9Zb','XvWseFcQ7dlcK8YYulTMiBnn5BLHxfhNSwyJS9bPrs65qLqwdWEtnxy72W4rufymd8aMCzTQKYLtyOqT',NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-05-23 06:24:06','2026-05-23 06:27:18',NULL,'active',NULL),(10,'Akki','akki@gmail.com',NULL,'$2y$12$UmHLrPGpJTfAEGFbwHyt2.auLr9h4ccL5vzUsVnGN50CAWNpUaMsm',0.00,'2v89DwvPIR6fKm4aEzZ6TAL8SYus2jy477oOb1yyaC0KpDS415UNDRJB0Zgsj51sKy1YFl85HfLJr25O',NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-05-24 23:32:05','2026-05-24 23:48:16',NULL,'active',NULL),(11,'chikki','chikki@gmail.com',NULL,'$2y$12$JOJcxO4CCMco3DkQPzwF9u/XS0NSuqcke3P3pxSCuEAfCygcghePS',0.00,'4d2WeiLgsnnJGr2t3ouDliSxHzSw1rrzCytEnBrtEGHwT8ykxOblZCFSQcLXCpS8rwC65MnH77hqYsvM',NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-05-24 23:39:09','2026-05-24 23:39:09',NULL,'active',NULL),(12,'sweety','sweety@gmail.com',NULL,'$2y$12$k1Ga4icuWjevxymcur9g8ezJXq5BMp/EGSqBMYlv6PSycLAiNOJNu',0.00,'hXFFLtK7UrM6Uv3fGjjpqtMFrX4E1esblYFKd673QPFGMPe70Slw6Mu3I5AuWaX51ktDbFtqkmu7VnwW',NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-05-24 23:48:42','2026-05-24 23:52:33',NULL,'active',NULL),(13,'prasanna','prasanna@gmial.com',NULL,'$2y$12$1nzfUPTMtJzGyhCPEVjK1uMDeCdJZNukvEvAH8mr5r3rhLzI.3o56',0.00,'Ztt0DvgwvtKjFrKeX1heD8MCMWmCIG5VnACDdVlvYPfWm8bhSJgiX7zLEXIrHwI6joi7wQtWtffQ3GEo',NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-05-24 23:53:14','2026-05-25 00:00:29',NULL,'active',NULL),(14,'anju','anju@gmail.com',NULL,'$2y$12$L2nd/Lory1Q/qZ66S2u.ker7bzQFulwL5su.wDWhdH4fx/ZJ0qama',7490.50,'Jv8YwgFxJt3XCYfquZkKRKZuyjcqUULtRYiyD8x3mT0QQf8Ltg6xsDownYjYaF4mcv97pMpqr6VtPgIy',NULL,NULL,NULL,NULL,'client',1,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-05-25 00:01:04','2026-05-26 00:54:24',NULL,'active',NULL),(15,'ww','ww@gmail.com','6666666666','$2y$12$P7WsFXoUom78uAsOKp0YmuIV/V/Izo7USEcbKi83rRzs9o7NHZ2.i',0.00,'lf6YtBjmXCh8Xx2bDPJYhw0OZPPuo8Y4ULK5tYgXmyQic9JTjs4WAKNuKZLjNZ178GwMSVmXJwDi7R5l',NULL,NULL,NULL,NULL,'client',NULL,'english','Asia/Kolkata','INR',0,NULL,'2026-05-25 00:42:14','2026-05-25 00:42:14',NULL,'active',NULL),(16,'bunty','bunty@gmail.com','9898989898','$2y$12$L2nd/Lory1Q/qZ66S2u.ker7bzQFulwL5su.wDWhdH4fx/ZJ0qama',41753.45,'BuI8fLEbHkKHXcBip56LgJZQreAUPsM2AET81OiMrKWcmidAkn98OL5rEvDkWLFpp8wr5cTAr2nXroq5','ieMVQKKfunF3Kiai3NAUCmBQljBJklRfrIRFC6CVyr5AoEw3PR8RnmPpuXm0cDsit5By0wPtXX2eUQeT',NULL,NULL,'profile-images/user-16-IIb9FpEAIM7U.jpg','client',1,'english','Asia/Kolkata','INR',0,NULL,'2026-05-25 01:20:23','2026-06-22 01:23:01',NULL,'active',NULL),(17,'bhavya','bhavya@gmail.com','6666666666','$2y$12$zdjh56b8wSatGjjARCrS0OOf/erd.98eSb9YxdkriBojo8uwiBCXK',0.00,'KXKaiMpYj4xs4KX1SQM1K9Jr4ILCNmZdqEU0ST9QIsCzKwupkagUV35CHRoU7LH1rWp5ynLn2XGb6qqN',NULL,NULL,NULL,NULL,'client',1,'english','Asia/Kolkata','INR',0,NULL,'2026-05-25 01:27:18','2026-05-25 02:01:36',NULL,'active',NULL),(18,'KANCHARAPU NAGENDRA','kancharapunagendra789@gmail.com','9160442966','$2y$12$EI3R39OsSrigY7fGsVSjdu.GF6R/4CMALZ9kDHVaURvPNzEdH/LEy',4750.50,'kLWgUq0J783XTClTK0It0mxMdaqioGecivLMG5bWVgn0sqeXjta3Zk448OTUnYb4noLeXvCKNHYKuZum','tQzkQsPqHaQqzl3qLJmfJaKDO2xNeT4AQ26619dIO0oi7vjdgYZD3ydZ8DZlg24cutJWNajeXcV8FvDN',NULL,NULL,NULL,'client',16,'english','Asia/Kolkata','INR',0,NULL,'2026-05-26 03:51:24','2026-05-26 05:14:02',NULL,'active',NULL),(19,'Nkxus Pvt ltd','nkxus.com@gmail.com','9160442065','$2y$12$UwQ1Y2Psy93HpUyFD4xUE.SAtR1WQiOqn/NfBb9c7ZNrppBFzsIqq',0.00,'7Rc0mp9mxkEOPdCZcMSAeJHayo33yMsx2KdxC9b3jjvdLdovSsMJQHUNKZHV86xKwwMuyyDy9A5I3P5H',NULL,NULL,NULL,NULL,'client',NULL,'english','Asia/Kolkata','INR',0,NULL,'2026-05-26 03:59:32','2026-05-26 04:03:52',NULL,'active',NULL),(20,'lohitha','lohitha@gmail.com','3232323232','$2y$12$o8VQwlxemLngM8kbHtLXiO6E9hONmsUbVZ1WjNUTcd1DEUi.coglS',2666.70,'2kZmeSjiKE7ll5fUVm1Y8O5DbMDaDGigY48BOchM1rft7XPIKthAy3t01fuNDBbCzxPtxWz4CK3OYUCN',NULL,NULL,NULL,NULL,'client',1,'english','Asia/Kolkata','INR',0,NULL,'2026-05-26 04:05:12','2026-05-26 04:36:24',NULL,'active',NULL),(21,'mohan','mohan@gmail.com','6666666666','$2y$12$l8kS3r3dEkxAClzxnPeZLONHLAiEBiwKVySEkLgafmku01RMZgiTm',5000.00,'wtZnWMCchAzr6Q6dCKlGdr2f55sXHhNsbgoTyuyK0q1LFd5f1XmnmLYnFiTPdsZn4Imi7T706cLugncW',NULL,NULL,NULL,NULL,'client',NULL,'english','Asia/Kolkata','INR',0,NULL,'2026-05-26 06:29:09','2026-05-26 06:35:40',NULL,'active',NULL),(22,'akshayaa','akshayamaramm222@gmail.com','2323232323','$2y$12$s57jCdWM6ErU1n6k1359Du95wpegp8lzEmS2P6IoBdcxRHJvUUUCC',0.00,'iKEqGcpTA1maTSBzHT1u52iWqCI1X1OOi5oNS5ofxOcgHOWWXlN8fuilcyPcDyAMBwNT6WaG5K9lNSDM',NULL,NULL,NULL,NULL,'client',NULL,'english','Asia/Kolkata','INR',0,NULL,'2026-06-22 01:12:41','2026-06-22 01:13:42',NULL,'active',NULL),(23,'ww2w','wwe@gmail.com','1112323232','$2y$12$CvAewmGDzH50Aat6ZGc5/uBu02lBClEwQl/JrFh.zfp6GZBHDJ0By',0.00,'cmZxAa6h84XvKU4LjHeNaWqKaGlKYYTq7dx1R8u8xxi81VXSZszHLPMrhevNVfjWmxQOz1dUJPLKzdxJ',NULL,NULL,NULL,NULL,'client',NULL,'english','Asia/Kolkata','INR',0,NULL,'2026-06-22 01:14:35','2026-06-22 01:15:12',NULL,'active',NULL),(24,NULL,'vijaytest@example.com',NULL,'$2y$12$rhrYOqFJ3PnapDoROJeJLeNqscJ4GlIqGmvbAHuTtaYef0OZpGIYi',0.00,NULL,NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,NULL,NULL,NULL,'active',NULL),(25,NULL,'vijaytest2@example.com',NULL,'$2y$12$ql7UYRqFzoXZozdEKdlUz.ZlYOqEvNBSg0uYgM0ZVHXKuQpJKNZZ2',0.00,NULL,NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-06-23 04:33:47','2026-06-23 04:33:47',NULL,'active',NULL),(26,NULL,'vijtest2@example.com',NULL,'$2y$12$WalFsErbXMYOz8u7R06oKO2YlEwr4hdFjRbgYn6j9B9fFhqApwYSS',0.00,NULL,NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-06-23 04:34:01','2026-06-23 04:34:01',NULL,'active',NULL),(27,NULL,'vijtest@example.com',NULL,'$2y$12$O.MQCQlLu5q4eOGxnaMhW.b7sS35yaHXPsU.AeJ43G5rW1eAGkHcC',0.00,NULL,NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-06-23 04:39:45','2026-06-23 04:39:45',NULL,'active',NULL),(28,NULL,'test1@gmail.com',NULL,'$2y$12$JEQZiFH0ZWWW4AMMf3..tuUB7JNXXHBSySXdEE3J3/Hyvly6vVODS',0.00,NULL,NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-06-23 05:53:29','2026-06-23 05:53:29',NULL,'active',NULL),(29,NULL,'naik@gmail.com',NULL,'$2y$12$YTci48ih6kkGmmLBOZrANOkae6kNXPr92sgoeb537ETLza2hi4LL.',0.00,NULL,NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-06-23 06:00:29','2026-06-23 06:00:29',NULL,'active',NULL),(30,NULL,'ash@gmail.com',NULL,'$2y$12$oCeZrs0T4.PNQRDEAbzwS.5NFHkqI7QR89xqplQnUrsoOf/MIlplu',0.00,NULL,NULL,NULL,NULL,NULL,'client',NULL,NULL,'Asia/Kolkata',NULL,0,NULL,'2026-06-23 06:31:10','2026-06-23 06:31:10',NULL,'active',NULL);
/*!40000 ALTER TABLE `smmusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_tickets`
--

DROP TABLE IF EXISTS `support_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support_tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `order_id` bigint(20) unsigned DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('open','pending','closed') NOT NULL DEFAULT 'open',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `support_tickets_user_id_foreign` (`user_id`),
  KEY `support_tickets_order_id_foreign` (`order_id`),
  CONSTRAINT `support_tickets_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_tickets`
--

LOCK TABLES `support_tickets` WRITE;
/*!40000 ALTER TABLE `support_tickets` DISABLE KEYS */;
INSERT INTO `support_tickets` VALUES (1,1,2,'Order Issue','Order issue','pending','2026-05-22 05:39:20','2026-05-22 05:39:20','akki@gmail.com','AKKI',''),(2,16,2,'Order Issue','aa','pending','2026-05-25 23:15:01','2026-05-25 23:15:01','aaa@gmail.com','aa',''),(3,16,3,'Order Issue','aa','pending','2026-05-26 00:23:06','2026-05-26 00:23:06','aaaqa@gmail.com','aqqq',''),(4,16,2,'Service Inquiry','aa','open','2026-05-26 00:27:28','2026-05-26 00:27:28','qq@gmail.com','qq',''),(5,23,2,'Order Support','fefe','open','2026-06-22 01:15:05','2026-06-22 01:15:05','wwe@gmail.com','ww2w',''),(6,NULL,NULL,'sadewdewdew','sadewdewdew','open',NULL,NULL,'nkxus.com@gmail.com','Nkxus Pvt ltd','Nkxus Pvt ltd');
/*!40000 ALTER TABLE `support_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `whats_app_widgets`
--

DROP TABLE IF EXISTS `whats_app_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whats_app_widgets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(255) NOT NULL,
  `greeting_message` text NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whats_app_widgets`
--

LOCK TABLES `whats_app_widgets` WRITE;
/*!40000 ALTER TABLE `whats_app_widgets` DISABLE KEYS */;
INSERT INTO `whats_app_widgets` VALUES (1,'8688383973','Hello! Welcome to NKXUS. How can we help you today?',1,'2026-05-23 08:40:01','2026-05-23 08:40:01');
/*!40000 ALTER TABLE `whats_app_widgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'nkxus-restore'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-24 14:23:29

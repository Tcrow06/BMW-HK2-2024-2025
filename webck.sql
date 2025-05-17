-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: webcuoiky
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  `owner_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrsmp0btl8wwx4rtfhcp3p5sjn` (`customer_id`),
  KEY `FKcovu1777gyuy4lgfawlxoaqnc` (`owner_id`),
  CONSTRAINT `FKcovu1777gyuy4lgfawlxoaqnc` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`id`),
  CONSTRAINT `FKrsmp0btl8wwx4rtfhcp3p5sjn` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'$2a$10$Y0Od5g8mDhqGs76JKclEl.en6PvtAuiYvVR2K.Rv5GiHchtdq.6EO','CUSTOMER','UNVERIFIED','adminn',4,NULL),(2,'$2a$10$PXzMO8ozBzFNVgASs8mAw.U4c1H8J59yvQt1HAYr5R1NMxca6MfC.','OWNER','ACTIVE','admin',NULL,1);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `commune` varchar(255) DEFAULT NULL,
  `concrete` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Thành phố Hồ Chí Minh','Phường Linh Trung','kaka','Thành phố Thủ Đức');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_discount`
--

DROP TABLE IF EXISTS `bill_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_discount` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `discount_percentage` int DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `is_outStanding` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `loyaltyPointsRequired` int DEFAULT NULL,
  `maximum_amount` double DEFAULT NULL,
  `minimum_invoice_amount` double DEFAULT NULL,
  `minimum_purchase_quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_discount`
--

LOCK TABLES `bill_discount` WRITE;
/*!40000 ALTER TABLE `bill_discount` DISABLE KEYS */;
INSERT INTO `bill_discount` VALUES (1,20,'2024-11-12 01:09:00.000000',_binary '\0','Khuyến mãi mùa đông băng giá','2024-11-10 12:59:00.000000','CVGHF',100,50,100,100),(2,50,'2024-11-12 01:09:00.000000',_binary '\0','Khuyến mãi mùa đông giá rét không có ai bên cạnh','2024-11-10 12:59:00.000000','CVGH9',200,100,100,100),(3,50,'2024-11-12 01:09:00.000000',_binary '\0','Khuyến mãi mùa đông giá rét không có ai bên cạnh','2024-11-10 12:59:00.000000','CVGH9',200,100,100,100),(4,50,'2024-11-12 01:09:00.000000',_binary '\0','Khuyến mãi mùa đông giá rét không có ai bên cạnh','2024-11-10 12:59:00.000000','CVGH9',200,100,100,100),(5,10,'2024-11-17 14:06:40.631538',_binary '','CẢM ƠN VÌ DA DEN','2024-11-09 23:41:00.000000','45GHN',0,100000,100000,100),(6,10,'2024-11-11 15:04:00.000000',_binary '','Khuyễn mãi một cuộc tình','2024-11-10 15:04:00.000000','CD564',100,100000,500000,100),(7,10,'2024-11-15 12:00:00.000000',_binary '','Khuyến mãi ngày 15/11','2024-11-15 01:00:00.000000','CPDHM',0,100000,0,NULL),(8,20,'2024-11-16 10:20:36.565210',_binary '','Khuyễn mãi cho rực rỡ','2024-11-16 22:32:00.000000','CGH45',100,100000,100000,NULL),(9,30,'2024-11-19 10:38:00.000000',_binary '','Cuộc đời quá đẹp','2024-11-18 10:38:00.000000','CFGD4',100,1000000,1000000,NULL),(10,10,'2024-11-29 15:09:00.000000',_binary '','Giảm giá cho các tình yêu','2024-11-17 13:09:00.000000','GHJFR',100,1000000,1000000,NULL),(11,20,'2024-11-26 12:34:00.000000',_binary '','Khuyến mãi cho các thiên tai ','2024-11-23 12:34:00.000000','GHJF8',100,100000,200000,NULL);
/*!40000 ALTER TABLE `bill_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1),(2),(3),(4);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int DEFAULT NULL,
  `cart_id` bigint DEFAULT NULL,
  `product_variant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd0kgpqj5w9tbf4isayegg0iru` (`cart_id`),
  KEY `FK72b56rf9kmqgc8ubw0yc3sc26` (`product_variant_id`),
  CONSTRAINT `FK72b56rf9kmqgc8ubw0yc3sc26` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variant` (`id`),
  CONSTRAINT `FKd0kgpqj5w9tbf4isayegg0iru` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (1,4,1,18),(2,2,1,19),(3,1,1,21),(4,1,2,51),(5,2,2,4),(6,2,2,15),(7,1,2,21),(8,1,2,10),(9,2,1,72);
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Clother','Clother'),(2,'Clother2','Clother2'),(3,'SHOE','Shoe'),(4,'JEWELRY','jewelry'),(5,'CLOCK','Clock'),(6,'Sunglasses','Sunglasses'),(7,'BAG','Bag');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `loyalty_point` int DEFAULT NULL,
  `cart_id` bigint DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKeocd7j6cc26f2weo7yys335ay` (`cart_id`),
  CONSTRAINT `FKeocd7j6cc26f2weo7yys335ay` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'22110282@student.hcmute.edu.vn','Pham Tien Anh',NULL,0,NULL,NULL),(2,'phama9162@gmail.com','Phạm Tiến Anh',NULL,0,1,NULL),(3,'khoaduytm10a1@gmail.com','Khoai 2004',NULL,0,2,'https://lh3.googleusercontent.com/a/ACg8ocLP-thQSkD3NH3YSrQzYvJ3AIVsArF5pTPAa3VM-Ecyjm346w=s96-c'),(4,'22110283@student.hcmute.edu.vn','Phạm Tiến Anh','0856230326',0,3,NULL),(5,'ptienanh19@gmail.com','Phạm Tiến Anh','0856230324',0,4,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_notification`
--

DROP TABLE IF EXISTS `customer_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_notification` (
  `customer_id` bigint NOT NULL,
  `notification_id` bigint NOT NULL,
  KEY `FKcuywieiv4bwj5ns0bykt8j22y` (`notification_id`),
  KEY `FKokhk8av7r97i2mha35jfjtxy4` (`customer_id`),
  CONSTRAINT `FKcuywieiv4bwj5ns0bykt8j22y` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`id`),
  CONSTRAINT `FKokhk8av7r97i2mha35jfjtxy4` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_notification`
--

LOCK TABLES `customer_notification` WRITE;
/*!40000 ALTER TABLE `customer_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `send_by` varchar(255) DEFAULT NULL,
  `customer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKje4s3qsi4cdg2camdxwad0bfx` (`customer_id`),
  CONSTRAINT `FKje4s3qsi4cdg2camdxwad0bfx` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shipping_fee` double DEFAULT NULL,
  `bill_discount_id` bigint DEFAULT NULL,
  `customer_id` bigint NOT NULL,
  `order_info_id` bigint DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9lxs94s2xt3bvdmarlx7ru6kp` (`bill_discount_id`),
  KEY `FK7vschkjn6ss3p1ttrt22asq6g` (`customer_id`),
  KEY `FK65y29ph7jks6ukgpmqm06b8og` (`order_info_id`),
  CONSTRAINT `FK65y29ph7jks6ukgpmqm06b8og` FOREIGN KEY (`order_info_id`) REFERENCES `order_info` (`id`),
  CONSTRAINT `FK7vschkjn6ss3p1ttrt22asq6g` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK9lxs94s2xt3bvdmarlx7ru6kp` FOREIGN KEY (`bill_discount_id`) REFERENCES `bill_discount` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int DEFAULT NULL,
  `order_id` bigint NOT NULL,
  `product_discount_id` bigint NOT NULL,
  `product_variant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlb8mofup9mi791hraxt9wlj5u` (`order_id`),
  KEY `FKsp8aldg1i7ds3ge23p3gewrq2` (`product_discount_id`),
  KEY `FKchv927jd9yic6fvp1t2esiji3` (`product_variant_id`),
  CONSTRAINT `FKchv927jd9yic6fvp1t2esiji3` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variant` (`id`),
  CONSTRAINT `FKlb8mofup9mi791hraxt9wlj5u` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  CONSTRAINT `FKsp8aldg1i7ds3ge23p3gewrq2` FOREIGN KEY (`product_discount_id`) REFERENCES `product_discount` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) DEFAULT NULL,
  `recipient` varchar(255) DEFAULT NULL,
  `address_id` bigint DEFAULT NULL,
  `customer_id` bigint NOT NULL,
  `is_default` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcypxtb62kv6rakqkjuapurib3` (`address_id`),
  KEY `FKj2bl2usmlwkpydm1xojjgm1kl` (`customer_id`),
  CONSTRAINT `FKcypxtb62kv6rakqkjuapurib3` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FKj2bl2usmlwkpydm1xojjgm1kl` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
INSERT INTO `order_info` VALUES (1,'0856230326','Phạm Tiến Anh',1,3,1);
/*!40000 ALTER TABLE `order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime(6) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKs7ls8v990ioraubs9aa8als2p` (`order_id`),
  CONSTRAINT `FKs7ls8v990ioraubs9aa8als2p` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner`
--

DROP TABLE IF EXISTS `owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owner` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `review_feedback_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjmtl4ule0fy62x6s7nqirc48m` (`review_feedback_id`),
  CONSTRAINT `FKjmtl4ule0fy62x6s7nqirc48m` FOREIGN KEY (`review_feedback_id`) REFERENCES `review_feedback` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner`
--

LOCK TABLES `owner` WRITE;
/*!40000 ALTER TABLE `owner` DISABLE KEYS */;
INSERT INTO `owner` VALUES (1,'ptienanh19@gmail.com','Phạm Tiến Anh','0856230324',NULL);
/*!40000 ALTER TABLE `owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `brand` varchar(255) DEFAULT NULL,
  `description` text,
  `highlight` bit(1) NOT NULL,
  `is_new` datetime(6) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `category_id` bigint NOT NULL,
  `product_discount_id` bigint DEFAULT NULL,
  `size_conversion_table_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1mtsbur82frn64de7balymq9s` (`category_id`),
  KEY `FK9jsb7tqhs8hrflm7a8nweuht6` (`product_discount_id`),
  CONSTRAINT `FK1mtsbur82frn64de7balymq9s` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK9jsb7tqhs8hrflm7a8nweuht6` FOREIGN KEY (`product_discount_id`) REFERENCES `product_discount` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'BOMBERVNnn','<p><strong>Một sản phẩm thời trang phổ biến và dễ phối là Áo khoác bomber. Đây là kiểu áo khoác ngắn, thường có phần eo và cổ tay bo thun, mang phong cách trẻ trung và năng động. Áo khoác bomber có thể phù hợp cho cả nam và nữ và thường được làm từ chất liệu nhẹ như vải dù, cotton hoặc da, có lớp lót giúp giữ ấm.</strong></p><p><strong>Bạn có thể phối áo khoác bomber với:</strong></p><ul><li><strong>Quần jeans hoặc quần jogger để tạo phong cách casual.</strong></li><li><strong>Áo thun đơn giản bên trong để giữ vẻ ngoài gọn gàng.</strong></li><li><strong>Giày thể thao hoặc boot cổ thấp để hoàn thiện set đồ năng động.</strong></li></ul><p><strong>Bạn muốn tìm hiểu thêm về loại áo này hoặc một sản phẩm khác không?</strong></p>',_binary '\0','2024-11-09 23:07:30.142331','Áo khoác BOMBER','SELLING',2,7,'db8fba1e-9c58-4692-87e8-5302143066d5'),(2,'BOMBERVN','<p><strong><em>Áo blazer oversize đang là xu hướng nổi bật, dễ phối đồ và phù hợp với cả phong cách công sở lẫn dạo phố. Màu sắc trung tính như đen, xám, hoặc beige sẽ giúp bạn dễ dàng kết hợp với nhiều trang phục khác nhau.</em></strong></p>',_binary '\0','2024-11-09 23:08:51.346869','Áo khoác Blazer Oversize','SELLING',1,11,NULL),(3,'JEANS','<p>Quần jeans baggy mang lại phong cách trẻ trung, thoải mái và năng động. Bạn có thể kết hợp cùng áo thun đơn giản hoặc áo sơ mi trắng để tạo nên phong cách hiện đại, thoải mái.</p>',_binary '\0','2024-11-09 23:09:33.320953','Quần Jeans Baggy','SELLING',1,15,NULL),(4,'SneakerVN','<p><strong>Chất liệu</strong>: Da tổng hợp, giúp giày bền, chống bám bẩn và dễ lau chùi.</p><p><strong>Đế giày</strong>: Cao su chống trơn trượt, độ bám tốt, phù hợp cho mọi địa hình.</p><p><strong>Kiểu dáng</strong>: Sneaker hiện đại, phù hợp với nhiều phong cách từ casual đến thể thao.</p><p><strong>Màu sắc</strong>: Trắng, thiết kế tối giản và tinh tế.</p><p><strong>Phù hợp với</strong>: Cả nam và nữ, dễ phối với quần jeans, quần shorts hay trang phục thể thao.</p>',_binary '\0','2024-11-10 11:29:10.957357','Giày Thể Thao Sneaker Nam Trắng','SELLING',3,17,NULL),(5,'18KVN','<p><strong>Mô tả:</strong> Dây chuyền vàng 18K tinh xảo, được thiết kế với phong cách thanh lịch và sang trọng. Mặt dây chuyền được đính đá quý cao cấp, tỏa sáng rực rỡ, mang đến vẻ đẹp nổi bật và cuốn hút cho người sở hữu. Phù hợp cho những buổi tiệc tùng, sự kiện đặc biệt, hoặc là món quà ý nghĩa dành tặng người thân yêu.</p><p><strong>Chất liệu:</strong> Vàng 18K, Đá Quý</p><p><strong>Chiều dài dây:</strong> 45 cm</p><p><strong>Kích thước mặt dây chuyền:</strong> 2 cm x 2 cm</p><p><strong>Màu sắc:</strong> Vàng sáng, Đá Quý trong suốt</p><p><strong>Giá:</strong> 2.500.000 VND</p><p><strong>Tính năng đặc biệt:</strong></p><ul><li>Thiết kế nhẹ nhàng, dễ dàng kết hợp với các trang phục khác nhau.</li><li>Đá quý chất lượng cao, đảm bảo độ sáng bóng lâu dài.</li><li>Dây chuyền có thể điều chỉnh độ dài tùy thích.</li></ul><p><strong>Hướng dẫn bảo quản:</strong></p><ul><li>Tránh tiếp xúc với hóa chất mạnh như nước hoa, xà phòng.</li><li>Lau sạch bằng vải mềm sau khi sử dụng để giữ độ sáng bóng.</li></ul><p><br></p>',_binary '\0','2024-11-10 14:18:44.052715','Dây Chuyền Vàng 18K Đính Đá Quý','SELLING',4,21,NULL),(6,'ROLEX','<ul><li><strong>Mô tả:</strong></li><li>Rolex Submariner là một trong những mẫu đồng hồ nổi tiếng nhất của Rolex, được biết đến với thiết kế thể thao, sang trọng và khả năng chịu nước vượt trội. Với vỏ thép không gỉ 904L và mặt kính sapphire chống xước, chiếc đồng hồ này có thể chịu được độ sâu lên tới 300m, lý tưởng cho các hoạt động lặn biển. Cùng với bộ máy tự động chính xác, Rolex Submariner không chỉ là một món phụ kiện thời trang mà còn là một biểu tượng của sự đẳng cấp và chất lượng vượt trội.</li><li><strong>Chất liệu vỏ:</strong> Thép không gỉ 904L, chắc chắn và bền bỉ</li><li><strong>Chất liệu dây đeo:</strong> Dây đeo Oyster, thép không gỉ 904L với khóa an toàn</li><li><strong>Mặt kính:</strong> Sapphire chống xước, có lớp phủ chống phản chiếu</li><li><strong>Độ chống nước:</strong> 300m (thích hợp cho lặn biển)</li><li><strong>Máy:</strong> Rolex Caliber 3135 (automatic)</li><li><strong>Giới tính:</strong> Nam</li><li><strong>Kích thước mặt đồng hồ:</strong> 40mm</li><li><strong>Màu sắc mặt số:</strong> Đen</li><li><strong>Giá:</strong> 155,000,000 VND (Giá tham khảo có thể thay đổi tùy vào từng cửa hàng và năm sản xuất)</li><li><strong>Tính năng đặc biệt:</strong></li><li class=\"ql-indent-1\"><strong>Khả năng chống nước 300m</strong> giúp đồng hồ trở thành sự lựa chọn hoàn hảo cho những người yêu thích lặn biển hoặc tham gia các hoạt động dưới nước.</li><li class=\"ql-indent-1\"><strong>Máy tự động Caliber 3135</strong> cung cấp độ chính xác cao và thời gian sử dụng lâu dài.</li><li class=\"ql-indent-1\"><strong>Vỏ thép không gỉ 904L</strong> cực kỳ bền bỉ, có khả năng chống ăn mòn tuyệt vời.</li><li class=\"ql-indent-1\"><strong>Thiết kế vĩnh cửu và sang trọng</strong>, dễ dàng kết hợp với các trang phục, từ công sở đến dạo phố.</li><li><strong>Hướng dẫn bảo quản:</strong></li><li class=\"ql-indent-1\">Hạn chế tiếp xúc với hóa chất mạnh như nước tẩy rửa hoặc mỹ phẩm để bảo vệ bề mặt của đồng hồ.</li><li class=\"ql-indent-1\">Tránh va đập mạnh, dù vỏ thép không gỉ rất bền nhưng vẫn cần sự chăm sóc khi sử dụng.</li><li class=\"ql-indent-1\">Sau khi tiếp xúc với nước biển, bạn nên lau đồng hồ sạch sẽ và bảo quản ở nơi khô ráo.</li></ul><p><br></p>',_binary '\0','2024-11-10 14:54:55.118402','Đồng Hồ Rolex Submariner 116610LN','SELLING',5,8,NULL),(7,'ROLEX','<ul><li><strong>Mô tả:</strong></li><li>Rolex Submariner là một trong những mẫu đồng hồ nổi tiếng nhất của Rolex, được biết đến với thiết kế thể thao, sang trọng và khả năng chịu nước vượt trội. Với vỏ thép không gỉ 904L và mặt kính sapphire chống xước, chiếc đồng hồ này có thể chịu được độ sâu lên tới 300m, lý tưởng cho các hoạt động lặn biển. Cùng với bộ máy tự động chính xác, Rolex Submariner không chỉ là một món phụ kiện thời trang mà còn là một biểu tượng của sự đẳng cấp và chất lượng vượt trội.</li><li><strong>Chất liệu vỏ:</strong> Thép không gỉ 904L, chắc chắn và bền bỉ</li><li><strong>Chất liệu dây đeo:</strong> Dây đeo Oyster, thép không gỉ 904L với khóa an toàn</li><li><strong>Mặt kính:</strong> Sapphire chống xước, có lớp phủ chống phản chiếu</li><li><strong>Độ chống nước:</strong> 300m (thích hợp cho lặn biển)</li><li><strong>Máy:</strong> Rolex Caliber 3135 (automatic)</li><li><strong>Giới tính:</strong> Nam</li><li><strong>Kích thước mặt đồng hồ:</strong> 40mm</li><li><strong>Màu sắc mặt số:</strong> Đen</li><li><strong>Giá:</strong> 155,000,000 VND (Giá tham khảo có thể thay đổi tùy vào từng cửa hàng và năm sản xuất)</li><li><strong>Tính năng đặc biệt:</strong></li><li class=\"ql-indent-1\"><strong>Khả năng chống nước 300m</strong> giúp đồng hồ trở thành sự lựa chọn hoàn hảo cho những người yêu thích lặn biển hoặc tham gia các hoạt động dưới nước.</li><li class=\"ql-indent-1\"><strong>Máy tự động Caliber 3135</strong> cung cấp độ chính xác cao và thời gian sử dụng lâu dài.</li><li class=\"ql-indent-1\"><strong>Vỏ thép không gỉ 904L</strong> cực kỳ bền bỉ, có khả năng chống ăn mòn tuyệt vời.</li><li class=\"ql-indent-1\"><strong>Thiết kế vĩnh cửu và sang trọng</strong>, dễ dàng kết hợp với các trang phục, từ công sở đến dạo phố.</li><li><strong>Hướng dẫn bảo quản:</strong></li><li class=\"ql-indent-1\">Hạn chế tiếp xúc với hóa chất mạnh như nước tẩy rửa hoặc mỹ phẩm để bảo vệ bề mặt của đồng hồ.</li><li class=\"ql-indent-1\">Tránh va đập mạnh, dù vỏ thép không gỉ rất bền nhưng vẫn cần sự chăm sóc khi sử dụng.</li><li class=\"ql-indent-1\">Sau khi tiếp xúc với nước biển, bạn nên lau đồng hồ sạch sẽ và bảo quản ở nơi khô ráo.</li></ul><p><br></p>',_binary '\0','2024-11-10 14:55:37.683223','Đồng Hồ Rolex Submariner 116610LN','STOP_SELLING',5,NULL,NULL),(8,'dsf','<p>dsfa</p>',_binary '\0','2024-11-10 17:48:02.772956','dsf','STOP_SELLING',3,NULL,NULL),(9,'HoodieUnisex','<p><strong>Mô tả sản phẩm:</strong></p><ul><li><strong>Chất liệu:</strong> Vải nỉ cotton cao cấp, mềm mịn, thoáng khí, giữ nhiệt tốt, phù hợp mặc vào mùa thu đông. Chất vải co giãn nhẹ giúp người mặc thoải mái trong mọi hoạt động.</li><li><strong>Thiết kế:</strong> Phom dáng rộng rãi (oversize), có mũ và túi kangaroo lớn phía trước. Đường may tỉ mỉ, đảm bảo độ bền. Độ dài hoodie ngang hông, dễ dàng phối với nhiều loại trang phục.</li><li><strong>Chi tiết:</strong> Thiết kế tối giản, có logo nhỏ hoặc slogan ý nghĩa in thêu ở ngực trái hoặc phần cánh tay. Màu sắc trung tính như đen, xám, trắng hoặc màu pastel như hồng nhạt, xanh mint để dễ phối đồ.</li><li><strong>Đối tượng:</strong> Thanh thiếu niên, người trẻ tuổi yêu thích phong cách thời trang tối giản nhưng vẫn năng động và cá tính.</li></ul><p><strong>Giá bán:</strong> Khoảng từ 400,000 - 600,000 VND tùy vào chất liệu và các chi tiết thiết kế.</p><p><strong>Điểm nổi bật của sản phẩm:</strong></p><ul><li><strong>Đa dạng phong cách:</strong> Hoodie unisex dễ phối với nhiều loại trang phục khác như quần jeans, quần jogger, hoặc chân váy.</li><li><strong>Phù hợp xu hướng:</strong> Phong cách tối giản ngày càng được ưa chuộng, đặc biệt là với giới trẻ muốn tìm kiếm phong cách tinh tế, đơn giản mà vẫn nổi bật.</li><li><strong>Tiện lợi và thoải mái:</strong> Hoodie là một trang phục tiện lợi, thoải mái và ấm áp, rất phù hợp cho những ngày se lạnh.</li></ul><p><br></p>',_binary '\0','2024-11-10 18:19:57.867816','Hoodie Unisex Phong Cách Tối Giản','SELLING',1,NULL,NULL),(10,'HoodieUnisex','<p><strong>Mô tả sản phẩm:</strong></p><ul><li><strong>Chất liệu:</strong> Vải nỉ cotton cao cấp, mềm mịn, thoáng khí, giữ nhiệt tốt, phù hợp mặc vào mùa thu đông. Chất vải co giãn nhẹ giúp người mặc thoải mái trong mọi hoạt động.</li><li><strong>Thiết kế:</strong> Phom dáng rộng rãi (oversize), có mũ và túi kangaroo lớn phía trước. Đường may tỉ mỉ, đảm bảo độ bền. Độ dài hoodie ngang hông, dễ dàng phối với nhiều loại trang phục.</li><li><strong>Chi tiết:</strong> Thiết kế tối giản, có logo nhỏ hoặc slogan ý nghĩa in thêu ở ngực trái hoặc phần cánh tay. Màu sắc trung tính như đen, xám, trắng hoặc màu pastel như hồng nhạt, xanh mint để dễ phối đồ.</li><li><strong>Đối tượng:</strong> Thanh thiếu niên, người trẻ tuổi yêu thích phong cách thời trang tối giản nhưng vẫn năng động và cá tính.</li></ul><p><strong>Giá bán:</strong> Khoảng từ 400,000 - 600,000 VND tùy vào chất liệu và các chi tiết thiết kế.</p><p><strong>Điểm nổi bật của sản phẩm:</strong></p><ul><li><strong>Đa dạng phong cách:</strong> Hoodie unisex dễ phối với nhiều loại trang phục khác như quần jeans, quần jogger, hoặc chân váy.</li><li><strong>Phù hợp xu hướng:</strong> Phong cách tối giản ngày càng được ưa chuộng, đặc biệt là với giới trẻ muốn tìm kiếm phong cách tinh tế, đơn giản mà vẫn nổi bật.</li><li><strong>Tiện lợi và thoải mái:</strong> Hoodie là một trang phục tiện lợi, thoải mái và ấm áp, rất phù hợp cho những ngày se lạnh.</li></ul><p><br></p>',_binary '\0','2024-11-10 18:24:30.573953','Hoodie Unisex Phong Cách Tối Giản kaka','STOP_SELLING',1,NULL,NULL),(11,'HoodieUnisex','<p><strong>Mô tả sản phẩm:</strong></p><ul><li><strong>Chất liệu:</strong> Vải nỉ cotton cao cấp, mềm mịn, thoáng khí, giữ nhiệt tốt, phù hợp mặc vào mùa thu đông. Chất vải co giãn nhẹ giúp người mặc thoải mái trong mọi hoạt động.</li><li><strong>Thiết kế:</strong> Phom dáng rộng rãi (oversize), có mũ và túi kangaroo lớn phía trước. Đường may tỉ mỉ, đảm bảo độ bền. Độ dài hoodie ngang hông, dễ dàng phối với nhiều loại trang phục.</li><li><strong>Chi tiết:</strong> Thiết kế tối giản, có logo nhỏ hoặc slogan ý nghĩa in thêu ở ngực trái hoặc phần cánh tay. Màu sắc trung tính như đen, xám, trắng hoặc màu pastel như hồng nhạt, xanh mint để dễ phối đồ.</li><li><strong>Đối tượng:</strong> Thanh thiếu niên, người trẻ tuổi yêu thích phong cách thời trang tối giản nhưng vẫn năng động và cá tính.</li></ul><p><strong>Giá bán:</strong> Khoảng từ 400,000 - 600,000 VND tùy vào chất liệu và các chi tiết thiết kế.</p><p><strong>Điểm nổi bật của sản phẩm:</strong></p><ul><li><strong>Đa dạng phong cách:</strong> Hoodie unisex dễ phối với nhiều loại trang phục khác như quần jeans, quần jogger, hoặc chân váy.</li><li><strong>Phù hợp xu hướng:</strong> Phong cách tối giản ngày càng được ưa chuộng, đặc biệt là với giới trẻ muốn tìm kiếm phong cách tinh tế, đơn giản mà vẫn nổi bật.</li><li><strong>Tiện lợi và thoải mái:</strong> Hoodie là một trang phục tiện lợi, thoải mái và ấm áp, rất phù hợp cho những ngày se lạnh.</li></ul><p><br></p>',_binary '\0','2024-11-10 18:24:30.603319','Hoodie Unisex Phong Cách Tối Giản kaka','STOP_SELLING',1,NULL,NULL),(12,'HoodieUnisex','<p><strong>Mô tả sản phẩm:</strong></p><ul><li><strong>Chất liệu:</strong> Vải nỉ cotton cao cấp, mềm mịn, thoáng khí, giữ nhiệt tốt, phù hợp mặc vào mùa thu đông. Chất vải co giãn nhẹ giúp người mặc thoải mái trong mọi hoạt động.</li><li><strong>Thiết kế:</strong> Phom dáng rộng rãi (oversize), có mũ và túi kangaroo lớn phía trước. Đường may tỉ mỉ, đảm bảo độ bền. Độ dài hoodie ngang hông, dễ dàng phối với nhiều loại trang phục.</li><li><strong>Chi tiết:</strong> Thiết kế tối giản, có logo nhỏ hoặc slogan ý nghĩa in thêu ở ngực trái hoặc phần cánh tay. Màu sắc trung tính như đen, xám, trắng hoặc màu pastel như hồng nhạt, xanh mint để dễ phối đồ.</li><li><strong>Đối tượng:</strong> Thanh thiếu niên, người trẻ tuổi yêu thích phong cách thời trang tối giản nhưng vẫn năng động và cá tính.</li></ul><p><strong>Giá bán:</strong> Khoảng từ 400,000 - 600,000 VND tùy vào chất liệu và các chi tiết thiết kế.</p><p><strong>Điểm nổi bật của sản phẩm:</strong></p><ul><li><strong>Đa dạng phong cách:</strong> Hoodie unisex dễ phối với nhiều loại trang phục khác như quần jeans, quần jogger, hoặc chân váy.</li><li><strong>Phù hợp xu hướng:</strong> Phong cách tối giản ngày càng được ưa chuộng, đặc biệt là với giới trẻ muốn tìm kiếm phong cách tinh tế, đơn giản mà vẫn nổi bật.</li><li><strong>Tiện lợi và thoải mái:</strong> Hoodie là một trang phục tiện lợi, thoải mái và ấm áp, rất phù hợp cho những ngày se lạnh.</li></ul><p><br></p>',_binary '\0','2024-11-10 18:24:33.038950','Hoodie Unisex Phong Cách Tối Giản kaka','SELLING',1,20,NULL),(13,'sfd','<p>sfa</p>',_binary '\0','2024-11-11 16:59:10.680592','dsfa','STOP_SELLING',2,NULL,NULL),(14,'sfd','<p>sfa</p>',_binary '\0','2024-11-11 17:01:15.618880','dsfa','STOP_SELLING',2,NULL,NULL),(15,'sfd','<p>sfa</p>',_binary '\0','2024-11-11 17:03:21.641302','dsfa','STOP_SELLING',2,NULL,NULL),(16,'Sơ Mi VN','<p><strong>Mô tả</strong>:</p><ul><li>Áo sơ mi oversized phong cách unisex phù hợp cho cả nam và nữ, thiết kế trẻ trung, hiện đại.</li><li>Chất liệu vải cotton mềm mại, thoáng mát, thích hợp cho cả mùa hè và mùa thu.</li><li>Áo có nhiều màu sắc như trắng, đen, xanh da trời, và xám để dễ phối đồ và phù hợp nhiều phong cách khác nhau.</li><li>Thiết kế form rộng với phần vai rủ giúp người mặc có cảm giác thoải mái và dễ chịu.</li><li>Cổ áo đứng, khuy cài phía trước, có thể phối với quần jeans hoặc quần short để tạo nên phong cách năng động hoặc lịch sự hơn.</li></ul><p><strong>Chi tiết sản phẩm</strong>:</p><ul><li><strong>Chất liệu</strong>: 100% Cotton</li><li><strong>Màu sắc</strong>: Trắng, Đen, Xanh Da Trời, Xám</li><li><strong>Kích thước</strong>: S, M, L, XL</li><li><strong>Giá</strong>: 300,000 - 500,000 VND tùy theo màu sắc và kích thước</li></ul><p><strong>Điểm nổi bật</strong>:</p><ul><li><strong>Dễ phối đồ</strong>: Có thể phối áo sơ mi với quần jeans, quần short hoặc chân váy để tạo phong cách riêng.</li><li><strong>Thời trang và tiện dụng</strong>: Thiết kế unisex và form oversized giúp sản phẩm phù hợp cho nhiều đối tượng, dễ dàng mặc trong nhiều dịp khác nhau từ đi chơi, dạo phố đến công sở.</li></ul><p>Sản phẩm này đang là xu hướng phổ biến trong thời trang giới trẻ, phù hợp với các bạn trẻ yêu thích phong cách thoải mái nhưng vẫn thời thượng.</p>',_binary '\0','2024-11-11 17:06:53.723253',' Áo sơ mi Oversized Unisex','SELLING',1,18,NULL),(17,'boy-pho-VN','<h3>1. <strong>Thiết kế</strong></h3><ul><li><strong>Phong cách</strong>: Áo phông lấy cảm hứng từ phong cách đường phố trẻ trung, năng động.</li><li><strong>Màu sắc</strong>: Sử dụng các gam màu cơ bản như đen, trắng, xám hoặc thêm chút màu sắc nổi bật (vàng, cam) để tạo điểm nhấn.</li><li><strong>Họa tiết</strong>: Họa tiết chữ, biểu tượng, hoặc hình ảnh in đơn giản nhưng có phong cách bụi bặm và phóng khoáng. Có thể là những câu slogan, hình graffiti, hoặc biểu tượng thành phố hiện đại.</li><li><strong>Form áo</strong>: Form áo oversize hoặc rộng rãi để tạo sự thoải mái, thích hợp khi kết hợp với quần baggy hoặc jeans rách.</li></ul><h3>2. <strong>Chất liệu</strong></h3><ul><li><strong>Cotton</strong>: Sử dụng 100% cotton để tạo sự thoải mái và thoáng mát khi mặc.</li><li><strong>Cotton pha polyester</strong>: Giúp áo bền, không nhăn và dễ dàng vệ sinh, giữ form tốt.</li></ul><h3>3. <strong>Công dụng</strong></h3><ul><li><strong>Dễ phối đồ</strong>: Phù hợp với quần jeans, quần jogger hoặc quần short, dễ dàng để mix đồ cho các dịp đi chơi, đi học, đi dạo phố.</li><li><strong>Phong cách linh hoạt</strong>: Dành cho nam giới yêu thích phong cách đường phố nhưng vẫn muốn có sự khác biệt.</li></ul><h3>4. <strong>Giá tham khảo</strong></h3><ul><li>Từ 200.000 - 400.000 VNĐ (tùy thuộc vào thương hiệu và chất liệu).</li></ul><h3>5. <strong>Slogan cho sản phẩm</strong></h3><ul><li>\"Chất ngầu, tự tin - Áo phông boy phố, cho những anh chàng cá tính!\"</li></ul><p>Sản phẩm này có thể được phát triển thêm với nhiều màu sắc và họa tiết đa dạng, đáp ứng nhu cầu phong cách thời trang đường phố của giới trẻ.</p>',_binary '\0','2024-11-11 19:22:07.308927','Áo phông phong cách ','SELLING',3,9,'45177d6b-e069-4696-a50e-4c2767de90cd'),(18,'Tailored Wool Coat','<h3><strong><em>Áo khoác dạ cổ điển (Tailored Wool Coat)</em></strong></h3><h4><em>Mô tả:</em></h4><p><em>Áo khoác dạ là món đồ không thể thiếu trong tủ đồ của một công quý. Được thiết kế với chất liệu dạ cao cấp, mềm mại và giữ nhiệt tốt, chiếc áo khoác này mang đến vẻ đẹp thanh lịch và sự thoải mái. Các chi tiết như cúc khảm ngọc trai, đường may tinh xảo và cổ áo cao sẽ giúp tạo ra vẻ ngoài sang trọng và quyền lực.</em></p><h4><em>Các yếu tố đặc trưng:</em></h4><ul><li><strong><em>Chất liệu:</em></strong><em> Dạ cao cấp, có thể là dạ merino wool hoặc cashmere, mang lại cảm giác mềm mại, ấm áp.</em></li><li><strong><em>Màu sắc:</em></strong><em> Màu đen, xanh navy, ghi xám hoặc màu be, giúp dễ dàng phối hợp với các trang phục khác.</em></li><li><strong><em>Kiểu dáng:</em></strong><em> Được thiết kế vừa vặn, với phần vai hơi nhô và eo ôm nhẹ nhàng, giúp tạo nên dáng vẻ quý phái và thanh thoát.</em></li><li><strong><em>Chi tiết:</em></strong><em> Cúc ngọc trai, tay áo xếp ly nhẹ, đường viền bằng chỉ mạ vàng, cổ áo cao, có thể được thêm chi tiết thêu hoa hoặc họa tiết trang trí cổ điển.</em></li><li><strong><em>Sử dụng:</em></strong><em> Phù hợp cho các buổi tiệc tối, sự kiện sang trọng, hoặc khi đi dạo trong thành phố trong những ngày se lạnh.</em></li></ul><h3><strong><em>Cách phối đồ:</em></strong></h3><ul><li><strong><em>Phối với:</em></strong><em> Một chiếc đầm cocktail dài tay, giày cao gót da mờ, và túi xách nhỏ bằng da thật.</em></li><li><strong><em>Phụ kiện:</em></strong><em> Mũ beret hoặc mũ fedora, găng tay da, và một chiếc khăn lụa nhẹ nhàng quấn quanh cổ để tăng thêm phần thanh lịch.</em></li></ul><p><em>Chiếc áo khoác này không chỉ là một món đồ bảo vệ cơ thể khỏi lạnh mà còn là một biểu tượng của sự quý phái và đẳng cấp, phù hợp với những người yêu thích vẻ đẹp cổ điển, sang trọng.</em></p>',_binary '\0','2024-11-12 14:15:21.937555','Áo khoác dạ cổ điển (Tailored Wool Coat)','SELLING',1,14,'fa38c6a5-d72f-48e1-a409-9d58fe7fdd3d'),(19,'Phạm','<p>dsafd</p>',_binary '\0','2024-11-17 11:08:30.149339','Phạm','SELLING',2,23,'b630e7ad-517c-4fb7-908d-971df2183d95'),(20,'Tieanh19','<h3><strong>Chi tiết sản phẩm</strong></h3><ul><li><strong>Chất liệu</strong>: 100% Cotton cao cấp, thoáng khí, thấm hút mồ hôi tốt, phù hợp cho mọi thời tiết.</li><li><strong>Thiết kế</strong>:</li><li class=\"ql-indent-1\">Form dáng: Unisex (phù hợp cả nam và nữ).</li><li class=\"ql-indent-1\">Màu sắc: Trắng tinh khôi, dễ phối đồ.</li><li class=\"ql-indent-1\">Cổ tròn, tay ngắn, đường may tỉ mỉ, bền đẹp.</li><li><strong>Ưu điểm</strong>:</li><li class=\"ql-indent-1\">Phong cách tối giản, phù hợp cho cả đi làm, đi chơi, và mặc nhà.</li><li class=\"ql-indent-1\">Có thể phối với quần jeans, quần short, hoặc váy đều đẹp.</li><li><strong>Size</strong>: S, M, L, XL (đa dạng cho mọi vóc dáng).</li></ul><h3><strong>Giá bán</strong></h3><ul><li><strong>Giá đề xuất</strong>: <em>150.000 - 200.000 VNĐ (tuỳ cửa hàng).</em></li></ul><p><br></p>',_binary '\0','2024-11-17 12:52:52.265567','Áo Thun Unisex Basic Trắng Trơn','SELLING',1,19,'100a1ca7-4db9-4271-a4e7-a0e7a05372d7'),(21,'Phạm','<p>fs</p>',_binary '\0','2024-11-17 14:59:25.286088','Phạm','STOP_SELLING',2,NULL,'ff546d29-b247-4e82-b950-d5f94297d671'),(22,'City Vibes','<h4><strong>Mô tả sản phẩm:</strong></h4><ul><li><strong>Chất liệu</strong>: 100% cotton cao cấp, mềm mại, thấm hút mồ hôi tốt, tạo cảm giác thoải mái khi mặc suốt cả ngày dài.</li><li><strong>Màu sắc</strong>: Trắng, đen, xám, xanh dương</li><li><strong>Kiểu dáng</strong>: Áo T-shirt unisex, thiết kế đơn giản, phù hợp cho cả nam và nữ.</li><li><strong>Họa tiết</strong>: In hình \"City Vibes\" với các họa tiết hiện đại, những đường phố, toà nhà và ánh đèn neon, thể hiện vẻ đẹp sống động của thành phố vào ban đêm.</li><li><strong>Size</strong>: S, M, L, XL, XXL (phù hợp với mọi dáng người)</li><li><strong>Sử dụng</strong>: Áo T-shirt này lý tưởng để mặc đi dạo phố, cà phê cùng bạn bè, hay tham gia các hoạt động thể thao nhẹ nhàng như đi bộ, chạy bộ, hay tập gym.</li></ul><h4><strong>Chi tiết thiết kế:</strong></h4><ul><li><strong>Phía trước</strong>: Họa tiết in mặt trước với chữ \"City Vibes\" và các hình ảnh minh họa như đường phố và ánh đèn neon, tạo cảm giác hiện đại, trẻ trung và năng động.</li><li><strong>Phía sau</strong>: Một logo nhỏ, tinh tế ở phía dưới cổ áo, giúp áo giữ được vẻ đơn giản nhưng vẫn không thiếu điểm nhấn.</li></ul><h4><strong>Ưu điểm sản phẩm</strong>:</h4><ul><li><strong>Thoải mái</strong>: Chất liệu cotton mềm mại, dễ chịu.</li><li><strong>Phong cách</strong>: Phù hợp với xu hướng thời trang đường phố hiện đại, dễ phối đồ với quần jeans, quần short, hoặc chân váy.</li><li><strong>Dễ dàng bảo quản</strong>: Giặt máy, không cần ủi.</li></ul><h4><strong>Giá bán</strong>: 299,000 VND</h4><p><br></p><h3><strong>Mô tả về mục đích sử dụng:</strong></h3><p>Áo T-shirt \"City Vibes\" không chỉ là một món đồ thời trang mà còn là tuyên ngôn cá nhân của những người yêu thích sự tự do và phong cách sống thành thị. Với thiết kế đơn giản nhưng nổi bật, sản phẩm này dễ dàng kết hợp với nhiều loại trang phục khác nhau, mang lại vẻ ngoài năng động và sành điệu.</p>',_binary '\0','2024-11-17 23:21:39.015015','Áo T-shirt Unisex City Vibes','SELLING',2,NULL,NULL),(23,'sominam','<ul><li><span style=\"color: var(--tw-prose-bold);\">Mô tả</span>: Áo sơ mi nam với thiết kế cổ điển, tay dài, phù hợp cho cả môi trường công sở và các dịp trang trọng. Chất liệu cotton thoáng mát, co giãn nhẹ giúp mang lại sự thoải mái.</li><li><span style=\"color: var(--tw-prose-bold);\">Chi tiết</span>:</li><li class=\"ql-indent-1\"><span style=\"color: var(--tw-prose-bold);\">Chất liệu</span>: 100% Cotton cao cấp</li><li class=\"ql-indent-1\"><span style=\"color: var(--tw-prose-bold);\">Màu sắc</span>: Trắng, đen, xanh navy, xám</li><li class=\"ql-indent-1\"><span style=\"color: var(--tw-prose-bold);\">Size</span>: S, M, L, XL</li><li><span style=\"color: var(--tw-prose-bold);\">Giá</span>: 500.000 VNĐ</li><li><span style=\"color: var(--tw-prose-bold);\">Phong cách</span>: Lịch lãm, dễ phối đồ cùng quần tây, quần jeans hoặc suit.</li></ul><p><br></p>',_binary '\0','2024-11-22 16:55:28.809857','Áo Polo cổ điển','SELLING',2,NULL,'0873eccb-a19b-4345-a7d0-567ec0d21532'),(24,'sunglasses','<h3>?️&nbsp;<strong style=\"color: inherit;\">Kính Mát Thời Trang</strong></h3><p>✨&nbsp;<span style=\"color: var(--tw-prose-bold);\">Phong cách</span>: Đẳng cấp và hiện đại.</p><p>?&nbsp;<span style=\"color: var(--tw-prose-bold);\">Thiết kế</span>: Gọng kim loại thanh mảnh, tròng kính phân cực chống tia UV.</p><p>?&nbsp;<span style=\"color: var(--tw-prose-bold);\">Phù hợp</span>: Hoàn hảo cho ngày nắng, du lịch, hoặc dạo phố.</p><p>❤️&nbsp;<span style=\"color: var(--tw-prose-bold);\">Ưu điểm</span>: Nhẹ nhàng, bảo vệ mắt tối đa, dễ phối với mọi trang phục.</p><h3>?&nbsp;<strong style=\"color: inherit;\">Kính Cận/Thời Trang Không Độ</strong></h3><p>?&nbsp;<span style=\"color: var(--tw-prose-bold);\">Chất liệu</span>: Gọng nhựa trong suốt, siêu nhẹ.</p><p>?&nbsp;<span style=\"color: var(--tw-prose-bold);\">Kiểu dáng</span>: Gọng vuông trẻ trung, hợp mọi khuôn mặt.</p><p>?&nbsp;<span style=\"color: var(--tw-prose-bold);\">Phong cách</span>: Lịch lãm cho công việc hoặc năng động khi đi chơi.</p><p>?&nbsp;<span style=\"color: var(--tw-prose-bold);\">Đặc biệt</span>: Có thể đặt tròng cận hoặc không độ theo nhu cầu.</p>',_binary '\0','2024-11-22 21:56:18.607985','Kính mát','SELLING',2,24,'4156249c-d911-4245-84f6-71d4fa1f1309'),(25,'Unisex','<h3>?&nbsp;<strong style=\"color: inherit;\">Kính Mát Unisex</strong></h3><p>?&nbsp;<span style=\"color: var(--tw-prose-bold);\">Phong cách</span>: Hiện đại và cá tính, phù hợp cho cả nam và nữ.</p><p>?&nbsp;<span style=\"color: var(--tw-prose-bold);\">Thiết kế</span>: Gọng vuông chắc chắn, tròng kính màu khói sang trọng.</p><p>☀️&nbsp;<span style=\"color: var(--tw-prose-bold);\">Chống tia UV400</span>: Bảo vệ đôi mắt tối ưu dưới ánh nắng.</p><p>?&nbsp;<span style=\"color: var(--tw-prose-bold);\">Ứng dụng</span>: Đi làm, đi du lịch, hay các buổi dạo phố cuối tuần.</p><p>?️&nbsp;<span style=\"color: var(--tw-prose-bold);\">Ưu đãi</span>: Giảm 20% trong tháng 11 này – đừng bỏ lỡ!</p><p>Bạn có muốn thêm chi tiết nào về sản phẩm này không? ?</p>',_binary '\0','2024-11-22 21:58:22.500675','Kính Mát Unisex','SELLING',6,NULL,'1bb60a5c-e2ac-4f3f-9165-f3bd72de6cb9'),(26,'sdfa','<p>sfasf</p>',_binary '\0','2024-11-22 22:34:37.831087','sdfa','STOP_SELLING',3,NULL,'61f9dfbf-dc06-4845-9ae0-c9dce9337dbc'),(27,'MYBAGVN','<h3><strong style=\"color: inherit;\">Mô tả chi tiết sản phẩm</strong></h3><p>Túi xách đa năng không chỉ là phụ kiện thời trang mà còn là người bạn đồng hành hoàn hảo cho những ai yêu thích sự tiện lợi, phong cách, và sự bền vững. Đây là dòng túi kết hợp giữa thiết kế hiện đại, tính thực tiễn và các công nghệ thông minh để đáp ứng nhu cầu sử dụng hàng ngày.</p><h3><strong style=\"color: inherit;\">Đặc điểm nổi bật</strong></h3><h4><strong style=\"color: inherit;\">1. Chất liệu cao cấp và thân thiện môi trường:</strong></h4><ul><li>Sử dụng&nbsp;<span style=\"color: var(--tw-prose-bold);\">da tái chế</span>&nbsp;hoặc&nbsp;<span style=\"color: var(--tw-prose-bold);\">vải canvas chống nước</span>&nbsp;với khả năng chống bụi và bền bỉ theo thời gian.</li><li>Lớp lót bên trong làm từ chất liệu mềm mại, chống trầy xước cho các thiết bị điện tử.</li><li>Đường may thủ công chắc chắn và chi tiết, đảm bảo độ bền cao.</li></ul><h4><strong style=\"color: inherit;\">2. Thiết kế thông minh và đa năng:</strong></h4><ul><li><span style=\"color: var(--tw-prose-bold);\">Ngăn chính rộng rãi:</span>&nbsp;Dễ dàng chứa các vật dụng lớn như sách, laptop (lên đến 15.6 inch), áo khoác mỏng hoặc tài liệu.</li><li><span style=\"color: var(--tw-prose-bold);\">Ngăn chống sốc riêng biệt:</span>&nbsp;Bảo vệ laptop hoặc tablet với lớp đệm êm ái.</li><li><span style=\"color: var(--tw-prose-bold);\">Ngăn phụ chuyên dụng:</span></li><li class=\"ql-indent-1\">Ngăn chứa sạc dự phòng tích hợp cổng USB bên ngoài, tiện lợi khi sạc thiết bị mà không cần mở túi.</li><li class=\"ql-indent-1\">Ngăn giữ nhiệt nhỏ để đựng bình nước hoặc cà phê, giúp duy trì nhiệt độ trong nhiều giờ.</li><li class=\"ql-indent-1\">Ngăn bí mật phía sau: Phù hợp cho ví, hộ chiếu, và đồ vật quan trọng, tránh bị trộm cắp.</li><li><span style=\"color: var(--tw-prose-bold);\">Quai đeo linh hoạt:</span>&nbsp;Dễ dàng chuyển đổi giữa túi xách tay, túi đeo chéo hoặc balo nhờ quai đeo có thể tháo rời và điều chỉnh.</li></ul><h4><strong style=\"color: inherit;\">3. Tính năng công nghệ hiện đại:</strong></h4><ul><li><span style=\"color: var(--tw-prose-bold);\">Tích hợp đèn LED bên trong:</span>&nbsp;Giúp bạn dễ dàng tìm đồ trong điều kiện thiếu sáng.</li><li><span style=\"color: var(--tw-prose-bold);\">Khóa số an toàn:</span>&nbsp;Bảo vệ đồ vật bên trong khỏi trộm cắp, đặc biệt khi đi du lịch hoặc di chuyển nơi công cộng.</li><li><span style=\"color: var(--tw-prose-bold);\">Chip định vị GPS (tùy chọn):</span>&nbsp;Cho phép theo dõi túi qua ứng dụng điện thoại, phù hợp cho người thường xuyên di chuyển.</li></ul><h4><strong style=\"color: inherit;\">4. Phong cách thiết kế:</strong></h4><ul><li><span style=\"color: var(--tw-prose-bold);\">Thời trang unisex:</span>&nbsp;Thiết kế tối giản nhưng hiện đại, phù hợp với cả nam và nữ.</li><li><span style=\"color: var(--tw-prose-bold);\">Màu sắc đa dạng:</span>&nbsp;Đen, xám, xanh navy, và nâu caramel, dễ dàng phối đồ với mọi phong cách.</li><li><span style=\"color: var(--tw-prose-bold);\">Dáng túi tinh tế:</span>&nbsp;Nhỏ gọn nhưng chứa được nhiều đồ, phù hợp từ văn phòng đến các chuyến đi ngắn ngày.</li></ul><h4><strong style=\"color: inherit;\">5. Đa dụng cho mọi hoàn cảnh:</strong></h4><ul><li><span style=\"color: var(--tw-prose-bold);\">Đi làm:</span>&nbsp;Gọn nhẹ nhưng đủ rộng để mang laptop, tài liệu, và các vật dụng cần thiết.</li><li><span style=\"color: var(--tw-prose-bold);\">Đi chơi:</span>&nbsp;Đủ phong cách và tiện lợi để mang theo khi đi dạo phố, cà phê hoặc hẹn hò.</li><li><span style=\"color: var(--tw-prose-bold);\">Đi du lịch:</span>&nbsp;Tích hợp ngăn thông minh cho hộ chiếu, vé máy bay, và đồ cá nhân.</li></ul><h3><strong style=\"color: inherit;\">Lợi ích nổi bật:</strong></h3><ul><li>Tiết kiệm thời gian với cách sắp xếp đồ dùng khoa học.</li><li>Phong cách thời trang hiện đại, phù hợp cho cả giới trẻ và người trưởng thành.</li><li>Giúp bảo vệ môi trường nhờ sử dụng chất liệu tái chế bền vững.</li></ul><p>Bạn có muốn thêm tính năng hoặc điều chỉnh thiết kế không? Tôi sẵn sàng hỗ trợ! ?</p>',_binary '\0','2024-11-23 08:47:36.227956','Túi xách đa năng cao cấp dành cho người hiện đại','SELLING',7,NULL,'4e4053bb-cf06-4028-99bd-2cc8c0323c95');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_discount`
--

DROP TABLE IF EXISTS `product_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_discount` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `discount_percentage` int DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `is_outStanding` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_discount`
--

LOCK TABLES `product_discount` WRITE;
/*!40000 ALTER TABLE `product_discount` DISABLE KEYS */;
INSERT INTO `product_discount` VALUES (1,10,'2024-11-30 12:00:00.000000',_binary '','Khuyến mãi nhanh áo khoác BOMBER','2024-11-01 12:59:00.000000'),(2,10,'2024-11-11 21:26:40.513877',_binary '','Khuyến mãi nhanh quần JEAN','2024-11-01 12:59:00.000000'),(3,20,'2024-11-30 12:00:00.000000',_binary '\0','Khuyến mãi nhanh Blazer Oversize','2024-11-01 12:59:00.000000'),(4,10,'2024-11-11 21:30:12.709741',_binary '','Khuyến mãi sốc cho Người yêu Sneker','2024-11-10 11:35:00.000000'),(5,20,'2024-11-30 11:35:00.000000',_binary '','Khuyến mãi sốc cho Người yêu Sneker','2024-11-10 11:35:00.000000'),(6,20,'2024-11-30 14:58:00.000000',_binary '','Khuyến mãi tháng 11 cho các con nợ Đồng Hồ','2024-11-01 14:58:00.000000'),(7,20,'2024-11-11 21:44:51.201074',_binary '\0','Khuyến mãi cho người yêu Bomber','2024-11-10 12:58:00.000000'),(8,20,'2024-11-22 13:16:46.122078',_binary '','Khuyến mãi tháng 11 cho các con nợ Đồng Hồ','2024-11-01 14:58:00.000000'),(9,16,'2024-11-30 20:32:00.000000',_binary '','Khuyến mãi cho boy phố','2024-11-01 20:31:00.000000'),(10,20,'2024-11-30 12:00:00.000000',_binary '\0','Khuyến mãi nhanh Blazer Oversize','2024-11-01 12:59:00.000000'),(11,20,'2024-11-11 21:43:13.379228',_binary '\0','Khuyến mãi nhanh Blazer Oversize','2024-11-01 12:59:00.000000'),(12,10,'2024-11-30 21:54:00.000000',_binary '','Yêu vàng thì bơi vào đây','2024-11-01 21:54:00.000000'),(13,20,'2024-11-30 14:16:00.000000',_binary '','Khuyến mãi cho những toiec 600 (không phải anh quý)','2024-11-01 14:16:00.000000'),(14,20,'2024-11-30 14:16:00.000000',_binary '\0','Khuyến mãi cho những toiec 600 (không phải anh quý)','2024-11-01 14:16:00.000000'),(15,20,'2024-11-30 15:34:00.000000',_binary '','Khuyến mãi nhanh Blazer Oversize','2024-11-16 15:34:00.000000'),(16,10,'2024-11-17 22:02:59.654903',_binary '','Yêu vàng thì bơi vào đây','2024-11-01 21:54:00.000000'),(17,10,'2024-11-30 16:06:00.000000',_binary '','Khuyến mãi nhanh Blazer Oversize','2024-11-01 16:06:00.000000'),(18,20,'2024-11-18 23:50:00.000000',_binary '','Giảm sâu cho áo nâu không lâu nữa đâu','2024-11-17 23:50:00.000000'),(19,20,'2024-11-30 14:03:00.000000',_binary '','Giảm giá cho các dân chơi  ','2024-11-16 14:03:00.000000'),(20,10,'2024-11-21 22:01:00.000000',_binary '','Khuyến mãi cho hoodie nâu','2024-11-19 22:01:00.000000'),(21,10,'2024-11-22 22:06:00.000000',_binary '','Giảm giá cho các đại gia','2024-11-17 01:06:00.000000'),(22,10,'2024-11-22 12:36:46.011159',_binary '','Khuyến mãi nhanh Blazer Oversize','2024-11-21 12:36:00.000000'),(23,20,'2024-11-30 13:01:00.000000',_binary '','Khuyến mãi nhanh Blazer Oversize Nếu ngày ấy','2024-11-25 13:01:00.000000'),(24,20,'2024-11-30 11:22:00.000000',_binary '','Đón tết vui','2024-11-01 11:22:00.000000');
/*!40000 ALTER TABLE `product_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_review`
--

DROP TABLE IF EXISTS `product_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `customer_id` bigint NOT NULL,
  `order_detail_id` bigint NOT NULL,
  `product_variant_id` bigint NOT NULL,
  `review_feedback_id` bigint DEFAULT NULL,
  `number_of_stars` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjuy6q5u495r6yy22fwv4mbtv9` (`customer_id`),
  KEY `FKfli4lg5b89qemkt6b0nbraiax` (`order_detail_id`),
  KEY `FK1v44xpjfd64s16qvbh4y1il9e` (`product_variant_id`),
  KEY `FKt88org0uncxkfucaespxusbgw` (`review_feedback_id`),
  CONSTRAINT `FK1v44xpjfd64s16qvbh4y1il9e` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variant` (`id`),
  CONSTRAINT `FKfli4lg5b89qemkt6b0nbraiax` FOREIGN KEY (`order_detail_id`) REFERENCES `order_detail` (`id`),
  CONSTRAINT `FKjuy6q5u495r6yy22fwv4mbtv9` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FKt88org0uncxkfucaespxusbgw` FOREIGN KEY (`review_feedback_id`) REFERENCES `review_feedback` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_review`
--

LOCK TABLES `product_review` WRITE;
/*!40000 ALTER TABLE `product_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variant`
--

DROP TABLE IF EXISTS `product_variant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `color` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `quantity` int DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgrbbs9t374m9gg43l6tq1xwdj` (`product_id`),
  CONSTRAINT `FKgrbbs9t374m9gg43l6tq1xwdj` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variant`
--

LOCK TABLES `product_variant` WRITE;
/*!40000 ALTER TABLE `product_variant` DISABLE KEYS */;
INSERT INTO `product_variant` VALUES (1,'ĐEN','hoodie2-black',123000,123,'XL','SELLING',1),(2,'ĐEN','hoodie2-black',122000,3123,'L','SELLING',1),(3,'TRẮNG','f77c9eac-38e3-463d-9211-ae1e963276d8',123,124,'L','SELLING',1),(4,'ĐEN','product-16',123000,123,'XL','SELLING',2),(5,'ĐEN','product-16',122000,3123,'L','SELLING',2),(6,'TRẮNG','product-16',123,123,'L','SELLING',2),(7,'ĐEN','jean',123000,123,'XL','SELLING',3),(8,'ĐEN','jean',122000,3123,'L','SELLING',3),(9,'TRẮNG','jean',123,123,'L','SELLING',3),(10,'Đen','shoe1',1200000,8,'32','SELLING',4),(11,'Đen','shoe1',1200000,100,'31','SELLING',4),(12,'Đen','shoe1',1200000,102,'30','SELLING',4),(13,'TRẮNG','shoe2',120000,100,'31','SELLING',4),(14,'TRẮNG','shoe2',120000,100,'30','SELLING',4),(15,'VÀNG','24K',2500000,26,'32','SELLING',5),(16,'VÀNG BẠC','ROLEX',155000000,30,'30','SELLING',6),(17,'VÀNG BẠC','ROLEX',155000000,31,'31','SELLING',6),(18,'VÀNG BẠC','ROLEX',155000000,30,'30','SELLING',7),(19,'VÀNG BẠC','ROLEX',155000000,31,'31','SELLING',7),(20,'XLDSF','a3fc57b7-f5f4-47ad-a390-ebbd4b33429d',123000,13,'DSF','SELLING',8),(21,'VÀNG','1f103893-7109-480f-aaa5-b95f5821dbe1',100000,5,'XL','SELLING',9),(22,'VÀNG','8d456a7c-32df-41ff-9ebc-f92f8bd2a806',100000,10,'L','SELLING',9),(23,'BE','31823fd1-ac1f-4eec-b8a6-0c4f9f833b3f',100000,10,'L','SELLING',9),(24,'VÀNG','55caf417-a97f-4c56-9936-09b118c8a13b',100000,5,'XL','SELLING',10),(25,'VÀNG','4d82bdc8-b1f9-418c-9da4-854d91beea5c',100000,5,'XL','SELLING',11),(26,'VÀNG','f68bfa4e-c813-48b8-aebd-66287dd698a0',100000,10,'L','SELLING',10),(27,'VÀNG','864994b1-7f13-4785-b743-cc6f72299cde',100000,10,'L','SELLING',11),(28,'BE','8d916d97-1c8e-4e42-80d6-1065e9cfd405',100000,10,'L','SELLING',10),(29,'BE','c55755e3-099f-43f2-8a9b-c48d75a46fc2',100000,10,'L','SELLING',11),(30,'VÀNG','c55755e3-099f-43f2-8a9b-c48d75a46fc2',100000,5,'XL','SELLING',12),(31,'VÀNG','f82350c3-7cd2-45f5-84d0-0775c65bb709',100000,10,'L','SELLING',12),(32,'BE','bc796148-9011-4e10-9af4-6846c16bf71e',100000,10,'L','SELLING',12),(33,'UNDEFINED','526cdaf5-4d67-4660-bd5b-8e9e897602e5',1,12,'XL','SELLING',13),(34,'UNDEFINED','f6c367c8-32d3-4564-9c99-10ce151681ce',1,13,'L','SELLING',13),(35,'UNDEFINED','77239c8c-3e2a-4efc-8fdc-8a25c7b1fc4e',1,12,'XL','SELLING',14),(36,'UNDEFINED','699e90aa-72c8-4248-b5df-29ff178f0714',1,13,'L','SELLING',14),(37,'UNDEFINED','889f2dc2-11ba-4581-abc4-d6d2c987aba2',1,12,'XL','SELLING',15),(38,'UNDEFINED','c63e88ca-6cb8-49db-bfa5-9c0697fb3100',1,13,'L','SELLING',15),(39,'XANH','0a0a9db8-cd9b-4072-a97f-2b0d41d94792',1123000,23,'XL','SELLING',16),(40,'XANH','973910f8-1b2a-4e47-9d26-c50d4fdf5fbe',1234500,23,'L','SELLING',16),(41,'XANH','f5444186-20ef-4f90-8b1c-7900c385272c',124000,12,'XXL','STOP_SELLING',16),(42,'NÂU','7ef4fb6b-fadd-479b-86f1-24ce69f5e346',123000,123,'XL','SELLING',16),(43,'NÂU','4043c725-6872-4a03-b736-997a27912c4c',123400,12,'L','SELLING',16),(44,'ĐEN','a50641ef-43ef-4a16-9cad-837778189b6a',100000,12,'XL','SELLING',17),(45,'ĐEN','0f2eb7fa-7de0-4b05-8a88-3a181a850fb7',100000,10,'L','SELLING',17),(46,'ĐEN','4bbfb463-04c4-4bbb-aab9-be8aa6b4940a',100000,12,'XXL','SELLING',17),(47,'XANH','39e153e1-066f-4fb6-a459-209547230d29',100000,123,'XXL','SELLING',17),(48,'XANH','a77e77fa-d51a-4fa0-9ae8-6a6fd85379af',123000,12,'L','SELLING',18),(49,'XANH','d49ba726-c947-4a9e-9d60-e497fd5a34bb',123450,13,'XL','SELLING',18),(50,'ĐEN','9c89ecd9-1b50-4c33-831d-8319097af8f8',120000,32,'L','SELLING',18),(51,'TRẮNG','f078ec1e-3e72-44b4-9f23-f8fa95d91a5a',124,123,'XL','SELLING',1),(52,'BE','5d5b2a8c-3cb6-4b3e-b68e-41ba57d3075e',120000,12,'XL','SELLING',1),(53,'PHẠM TIẾN ANH','5fac1680-314d-4149-92af-8f964a32d264',123,12,'123','SELLING',19),(54,'PHẠM TIẾN ANH','8cfbe451-f3ff-4fae-b7ee-b1aed439c1f2',123,12,'124','SELLING',19),(55,'TRẮNG','ac87d1c3-f61c-4b2c-ae4a-b89c500c8930',123000,32,'XL','SELLING',20),(56,'TRẮNG','3c8a292e-6295-40ca-a7f7-2c869c0164a3',123000,31,'L','SELLING',20),(57,'ĐỎ','6c6ce6ee-9ee0-4d9b-9568-68b3254e292d',122000,32,'XL','SELLING',20),(58,'ĐỎ','97d32953-1225-4314-a72f-7cc4e37809c3',123000,31,'L','SELLING',20),(59,'ĐỎ','575e31f7-fe4b-4b3b-b9e6-8f75cbc03b09',123000,30,'S','STOP_SELLING',20),(60,'ĐEN','1f445140-21e1-48fa-b650-009cfbeb1a9b',123000,32,'L','STOP_SELLING',20),(61,'ĐEN','69af0c15-6a94-421a-83c9-6e05235fa1b6',100000,123,'S','SELLING',20),(62,'FDGS','ed61de20-9828-4358-a590-b4182b45351c',12,12,'DFG','SELLING',21),(63,'XANH','e1dbd808-06c3-4be3-ba35-9f71b559e71b',123000,21,'L','SELLING',22),(64,'XANH','02279690-6a5d-46b2-afd5-4ce46859e5ca',123000,22,'XL','SELLING',22),(65,'TRẮNG','b4327048-121e-49de-9d16-727bd9758053',122000,123,'L','SELLING',22),(66,'L','321b2a9d-6bd7-4cdd-bcb6-75d51a00ed5a',123000,32,'XL','SELLING',23),(67,'XL','76ea0d08-7461-4a4a-825a-48a3c29de14b',123000,123,'L','SELLING',23),(68,'XL','cc0e18f0-b360-4a8d-a63d-1c15089f2255',123000,123,'XL','SELLING',23),(69,'ĐEN','3fdfe15f-aa22-475d-9119-2c722f147fce',123000,123,'31','SELLING',24),(70,'ĐEN','19a80512-48ea-4b6c-a7ec-3b008a4adf88',123000,123,'32','SELLING',24),(71,'HỒNG','0408de72-581d-4aa7-9b7c-98a0e6afab99',123000,32,'31','SELLING',25),(72,'BẠC','9ca10295-8cef-4dca-9b1d-edeef7a09d59',1235000,123,'32','SELLING',5),(73,'BẠC','634e9c99-f8bb-4912-86c5-2d620d83b34f',12345000,124,'31','STOP_SELLING',5),(74,'SDFA','9fbaad89-9af5-403c-8dc4-48568ee52afd',123000,121,'123','SELLING',26),(75,'ĐEN','fbd5596a-0a34-48b5-9342-401684dcef48',123000,123,'32','SELLING',27),(76,'ĐEN','cc8e9455-f9f6-4382-98e9-9f29708b6000',124000,123,'31','SELLING',27),(77,'NÂU','da3be251-8073-4216-86e8-0a79abbe2cc2',122000,12,'32','SELLING',27),(78,'NÂU','d69c2a0e-8dee-43c7-9302-66a209ca31cc',120000,14,'33','SELLING',27),(79,'NÂU',NULL,123456,13,'XXL','SELLING',16);
/*!40000 ALTER TABLE `product_variant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `return_order`
--

DROP TABLE IF EXISTS `return_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `return_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `status` int DEFAULT NULL,
  `order_detail_id` bigint DEFAULT NULL,
  `quantity_return` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKh0ypmvcld3yeotqdt1s8ohlj3` (`order_detail_id`),
  CONSTRAINT `FKh0ypmvcld3yeotqdt1s8ohlj3` FOREIGN KEY (`order_detail_id`) REFERENCES `order_detail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return_order`
--

LOCK TABLES `return_order` WRITE;
/*!40000 ALTER TABLE `return_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `return_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_feedback`
--

DROP TABLE IF EXISTS `review_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `review_feedback_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKagkrp6p4v4wvjddbo9dbjg2wp` (`review_feedback_id`),
  CONSTRAINT `FKagkrp6p4v4wvjddbo9dbjg2wp` FOREIGN KEY (`review_feedback_id`) REFERENCES `product_review` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_feedback`
--

LOCK TABLES `review_feedback` WRITE;
/*!40000 ALTER TABLE `review_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_history`
--

DROP TABLE IF EXISTS `search_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `customer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKl0jscpxtb111m8hcyh0t210u0` (`customer_id`),
  CONSTRAINT `FKl0jscpxtb111m8hcyh0t210u0` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_history`
--

LOCK TABLES `search_history` WRITE;
/*!40000 ALTER TABLE `search_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_account`
--

DROP TABLE IF EXISTS `social_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fbID` varchar(255) DEFAULT NULL,
  `ggID` varchar(255) DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKa9eb43evm6fecdpuetkn0a68g` (`customer_id`),
  CONSTRAINT `FKa9eb43evm6fecdpuetkn0a68g` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_account`
--

LOCK TABLES `social_account` WRITE;
/*!40000 ALTER TABLE `social_account` DISABLE KEYS */;
INSERT INTO `social_account` VALUES (1,NULL,'106198750219558280104',1,'ACTIVE'),(2,NULL,'102759276641493938127',2,'ACTIVE'),(3,NULL,'108172085800798105084',3,'ACTIVE');
/*!40000 ALTER TABLE `social_account` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-02 12:56:01

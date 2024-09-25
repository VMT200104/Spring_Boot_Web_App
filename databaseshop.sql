-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: database1
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3d704slv66tw6x5hmbm6p2x3u` (`product_id`),
  KEY `FK9x4wn098i53ikun1ynxet2ynj` (`user_id`),
  CONSTRAINT `FK3d704slv66tw6x5hmbm6p2x3u` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK9x4wn098i53ikun1ynxet2ynj` FOREIGN KEY (`user_id`) REFERENCES `user_dtls` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (2,2,3,2),(3,1,4,2);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_active` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (2,_binary '','Áo'),(3,_binary '','Giày'),(4,_binary '','Balo'),(5,_binary '','Quần');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_address`
--

DROP TABLE IF EXISTS `order_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `mobile_no` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_address`
--

LOCK TABLES `order_address` WRITE;
/*!40000 ALTER TABLE `order_address` DISABLE KEYS */;
INSERT INTO `order_address` VALUES (1,'Nguyễn thái sơn_phường 5_Gò vấp_Tphcm','tphcm','minhtan@gmail.com','Võ','Minh Tân','0123456789');
/*!40000 ALTER TABLE `order_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `stock` int NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (3,'Áo','vải Cotton thoáng mát,thấm hút nước,mềm mại co giãn tốt','aothun1.jpg',_binary '',280,12,'thun nam basic Old Sailor'),(4,'Áo','cotton mềm mại, thoáng mát, phù hợp cho mọi hoạt động hàng ngày.','shoes.jpg',_binary '',315,12,'Áo Thun Nam Basic'),(5,'Giày','Giày thể thao cổ điển, mang phong cách retro với đường nét thanh lịch và đơn giản','giay1.jpg',_binary '',1290,10,'Sneaker Nike Court Royale'),(6,'Giày','Giày thể thao hiện đại với thiết kế thấp, mang lại vẻ ngoài trẻ trung và năng động','giay2.jpg',_binary '',1690,5,'Sneaker Nike Ebernon Low Premium'),(7,'Balo','Sở hữu kiểu dáng trẻ trung và hiện đại, được phối màu đen–cam trendy tạo điểm nhấn, bắt mắt, thu hút mọi ánh nhìn','balo3.jpg',_binary '',399,16,'Balo Mini Alex'),(8,'Balo','gia công bằng chất liệu vải đảm bảo độ bền chắc theo thời gian, chế tác bằng đường may tỉ mỉ','balo4.jpg',_binary '',250,15,'BALO THỜI TRANG CỠ LỚN HARAS HR294'),(9,'Quần','Thiết kế kiểu dáng trẻ trung, năng động, phá cách','quan.jpg',_binary '',549,16,'Quần Tây Nam Ống Đứng Cao Cấp Công Sở'),(10,'Quần','thiết kế với chất liệu thoáng khí và co giãn để tạo sự thoải mái trong khi vận động','quan2.jpg',_binary '',315,13,'D19-Q2 ACTIVE SHORT');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_order`
--

DROP TABLE IF EXISTS `product_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_date` datetime(6) DEFAULT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `payment_type` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `order_address_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKqcdbxaeuc7c5gahwh0dutg04r` (`order_address_id`),
  KEY `FKh73acsd9s5wp6l0e55td6jr1m` (`product_id`),
  KEY `FK4f2ycr32kigtux5ag3tv0xu5m` (`user_id`),
  CONSTRAINT `FK4f2ycr32kigtux5ag3tv0xu5m` FOREIGN KEY (`user_id`) REFERENCES `user_dtls` (`id`),
  CONSTRAINT `FK8frxalwc79tpxo7hgqp3hsjck` FOREIGN KEY (`order_address_id`) REFERENCES `order_address` (`id`),
  CONSTRAINT `FKh73acsd9s5wp6l0e55td6jr1m` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_order`
--

LOCK TABLES `product_order` WRITE;
/*!40000 ALTER TABLE `product_order` DISABLE KEYS */;
INSERT INTO `product_order` VALUES (1,'2024-07-22 22:10:50.915000','cbb1023f-29aa-4031-a432-62674a7eb2e0','COD',280,1,1,3,2);
/*!40000 ALTER TABLE `product_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_dtls`
--

DROP TABLE IF EXISTS `user_dtls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_dtls` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dtls`
--

LOCK TABLES `user_dtls` WRITE;
/*!40000 ALTER TABLE `user_dtls` DISABLE KEYS */;
INSERT INTO `user_dtls` VALUES (1,'admin123@gmail.com','12354687979','Thanh Ngân','$2a$10$TLyoQcDFnm2HgNyEbjfc/.8uL492PUb6ocF1rcebqcXmxcbOG5Eiu','ROLE_ADMIN'),(2,'minhtan@gmail.com','0123456789','minh tân','$2a$10$o36Nn6H6wKauQeFAD7tLIeZeJeV26IIMEKYsUo.3kztNDoE/ofsIe','ROLE_USER');
/*!40000 ALTER TABLE `user_dtls` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-23 12:39:46

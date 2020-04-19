-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: accountingapp
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank` (
  `BANK_NUM` varchar(20) NOT NULL,
  `BANK_NAME` varchar(255) NOT NULL,
  `BANK_ADDRESS` varchar(255) NOT NULL,
  `BANK_POSTCODE` varchar(5) NOT NULL,
  `GL_ACC_NUM` int(11) NOT NULL DEFAULT '310',
  PRIMARY KEY (`BANK_NUM`),
  KEY `fk_BANK_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_BANK_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank`
--

LOCK TABLES `bank` WRITE;
/*!40000 ALTER TABLE `bank` DISABLE KEYS */;
INSERT INTO `bank` VALUES ('BANK-2','OCBC BANK','18, Jalan Tun Perak, City Centre, Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur','50050',310),('BANK-3','MAYBANK','C7, Jalan SS 15/4d, Ss 15, Subang Jaya, Selangor','47500',310);
/*!40000 ALTER TABLE `bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_payment`
--

DROP TABLE IF EXISTS `bank_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_payment` (
  `BANK_PAYMENT_NUM` varchar(20) NOT NULL,
  `BANK_NUM` varchar(20) NOT NULL,
  `CREDITOR_NUM` varchar(20) DEFAULT NULL,
  `BANK_PAYMENT_DATE` date NOT NULL,
  `BANK_PAYMENT_METHOD` varchar(45) DEFAULT NULL,
  `BANK_PAYMENT_TRANSACTION_ID` varchar(45) DEFAULT NULL,
  `BANK_PAYMENT_DESC` varchar(255) DEFAULT NULL,
  `BANK_PAYMENT_AMOUNT` decimal(10,2) NOT NULL,
  `GL_ACC_NUM` int(11) DEFAULT NULL,
  PRIMARY KEY (`BANK_PAYMENT_NUM`),
  KEY `fk_BANK_PAYMENT_BANK1_idx` (`BANK_NUM`),
  KEY `fk_BANK_PAYMENT_CREDITOR1_idx` (`CREDITOR_NUM`),
  KEY `fk_BANK_PAYMENT_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_BANK_PAYMENT_BANK1` FOREIGN KEY (`BANK_NUM`) REFERENCES `bank` (`BANK_NUM`),
  CONSTRAINT `fk_BANK_PAYMENT_CREDITOR1` FOREIGN KEY (`CREDITOR_NUM`) REFERENCES `creditor` (`CREDITOR_NUM`),
  CONSTRAINT `fk_BANK_PAYMENT_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_payment`
--

LOCK TABLES `bank_payment` WRITE;
/*!40000 ALTER TABLE `bank_payment` DISABLE KEYS */;
INSERT INTO `bank_payment` VALUES ('BP-1','BANK-3',NULL,'2020-01-07','CHEQUE','MAYBANK02383','PETTY CASH WITHDRAWAL FOR BBC1',500.00,320),('BP-2','BANK-2','CRED-1','2019-12-02','CHEQUE','OCBC0284',NULL,200.00,NULL),('BP-3','BANK-2','CRED-1','2020-04-07',NULL,'OCBC0288',NULL,200.00,NULL);
/*!40000 ALTER TABLE `bank_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_receipt`
--

DROP TABLE IF EXISTS `bank_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_receipt` (
  `BANK_RECEIPT_NUM` varchar(20) NOT NULL,
  `BANK_NUM` varchar(20) NOT NULL,
  `DEBTOR_NUM` varchar(20) DEFAULT NULL,
  `BANK_RECEIPT_DATE` date NOT NULL,
  `BANK_RECEIPT_METHOD` varchar(45) DEFAULT NULL,
  `BANK_RECEIPT_TRANSACTION_ID` varchar(45) DEFAULT NULL,
  `BANK_RECEIPT_DESC` varchar(255) DEFAULT NULL,
  `BANK_RECEIPT_AMOUNT` decimal(10,2) NOT NULL,
  `GL_ACC_NUM` int(11) DEFAULT NULL,
  PRIMARY KEY (`BANK_RECEIPT_NUM`),
  KEY `fk_BANK_RECEIPT_BANK1_idx` (`BANK_NUM`),
  KEY `fk_BANK_RECEIPT_DEBTOR1_idx` (`DEBTOR_NUM`),
  KEY `fk_BANK_RECEIPT_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_BANK_RECEIPT_BANK1` FOREIGN KEY (`BANK_NUM`) REFERENCES `bank` (`BANK_NUM`),
  CONSTRAINT `fk_BANK_RECEIPT_DEBTOR1` FOREIGN KEY (`DEBTOR_NUM`) REFERENCES `debtor` (`DEBTOR_NUM`),
  CONSTRAINT `fk_BANK_RECEIPT_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_receipt`
--

LOCK TABLES `bank_receipt` WRITE;
/*!40000 ALTER TABLE `bank_receipt` DISABLE KEYS */;
INSERT INTO `bank_receipt` VALUES ('BR-3','BANK-3',NULL,'2018-03-01','CHEQUE','MBB001','INITIAL CASH INFUSION FROM OWNER',500000.00,100),('BR-4','BANK-2','DEB-2','2019-03-01','CHEQUE','OCBC0282',NULL,275.00,NULL),('BR-5','BANK-2','DEB-2','2020-03-03',NULL,'OCBC0285',NULL,500.00,NULL),('BR-6','BANK-3','DEB-2','2020-04-05',NULL,'MBB0234',NULL,175.00,NULL),('BR-7','BANK-2','DEB-3','2020-04-05',NULL,'OCBC0301',NULL,150.00,NULL);
/*!40000 ALTER TABLE `bank_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_payment`
--

DROP TABLE IF EXISTS `cash_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_payment` (
  `CASH_PAYMENT_NUM` varchar(20) NOT NULL,
  `CREDITOR_NUM` varchar(20) DEFAULT NULL,
  `CASH_PAYMENT_DATE` date NOT NULL,
  `CASH_PAYMENT_METHOD` varchar(45) DEFAULT NULL,
  `CASH_PAYMENT_TRANSACTION_ID` varchar(45) DEFAULT NULL,
  `CASH_PAYMENT_DESC` varchar(255) DEFAULT NULL,
  `CASH_PAYMENT_AMOUNT` decimal(10,2) NOT NULL,
  `GL_ACC_NUM1` int(11) DEFAULT NULL,
  `GL_ACC_NUM2` int(11) NOT NULL DEFAULT '320',
  PRIMARY KEY (`CASH_PAYMENT_NUM`),
  KEY `fk_CASH_PAYMENT_CREDITOR1_idx` (`CREDITOR_NUM`),
  KEY `fk_CASH_PAYMENT_GL1_idx` (`GL_ACC_NUM1`),
  KEY `fk_CASH_PAYMENT_GL2_idx` (`GL_ACC_NUM2`),
  CONSTRAINT `fk_CASH_PAYMENT_CREDITOR1` FOREIGN KEY (`CREDITOR_NUM`) REFERENCES `creditor` (`CREDITOR_NUM`),
  CONSTRAINT `fk_CASH_PAYMENT_GL1` FOREIGN KEY (`GL_ACC_NUM1`) REFERENCES `gl` (`GL_ACC_NUM`),
  CONSTRAINT `fk_CASH_PAYMENT_GL2` FOREIGN KEY (`GL_ACC_NUM2`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_payment`
--

LOCK TABLES `cash_payment` WRITE;
/*!40000 ALTER TABLE `cash_payment` DISABLE KEYS */;
INSERT INTO `cash_payment` VALUES ('CP-1',NULL,'2020-01-01','CASH','INV501','KEDAI HOCK SENG ADVERT',500.00,901,320),('CP-2',NULL,'2020-01-04','CASH',NULL,NULL,300.00,210,320),('CP-3',NULL,'2020-04-02',NULL,NULL,NULL,500.00,210,320),('CP-4','CRED-3','2020-04-07',NULL,NULL,NULL,200.00,NULL,320);
/*!40000 ALTER TABLE `cash_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_receipt`
--

DROP TABLE IF EXISTS `cash_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cash_receipt` (
  `CASH_RECEIPT_NUM` varchar(20) NOT NULL,
  `DEBTOR_NUM` varchar(20) DEFAULT NULL,
  `CASH_RECEIPT_DATE` date NOT NULL,
  `CASH_RECEIPT_METHOD` varchar(45) DEFAULT NULL,
  `CASH_RECEIPT_TRANSACTION_ID` varchar(45) DEFAULT NULL,
  `CASH_RECEIPT_DESC` varchar(255) DEFAULT NULL,
  `CASH_RECEIPT_AMOUNT` decimal(10,2) NOT NULL,
  `GL_ACC_NUM1` int(11) DEFAULT NULL,
  `GL_ACC_NUM2` int(11) NOT NULL DEFAULT '320',
  PRIMARY KEY (`CASH_RECEIPT_NUM`),
  KEY `fk_CASH_RECEIPT_GL1_idx` (`GL_ACC_NUM1`),
  KEY `fk_CASH_RECEIPT_DEBTOR1_idx` (`DEBTOR_NUM`),
  KEY `fk_CASH_RECEIPT_GL2_idx` (`GL_ACC_NUM2`),
  CONSTRAINT `fk_CASH_RECEIPT_DEBTOR1` FOREIGN KEY (`DEBTOR_NUM`) REFERENCES `debtor` (`DEBTOR_NUM`),
  CONSTRAINT `fk_CASH_RECEIPT_GL1` FOREIGN KEY (`GL_ACC_NUM1`) REFERENCES `gl` (`GL_ACC_NUM`),
  CONSTRAINT `fk_CASH_RECEIPT_GL2` FOREIGN KEY (`GL_ACC_NUM2`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_receipt`
--

LOCK TABLES `cash_receipt` WRITE;
/*!40000 ALTER TABLE `cash_receipt` DISABLE KEYS */;
INSERT INTO `cash_receipt` VALUES ('CR-1',NULL,'2019-12-02','CASH',NULL,'CASH',1300.01,305,320),('CR-3','DEB-2','2020-03-04','CASH',NULL,'CASH',275.00,NULL,320),('CR-4','DEB-1','2020-03-03',NULL,NULL,NULL,300.00,NULL,320),('CR-5','DEB-3','2020-02-11',NULL,'CASH13',NULL,100.00,NULL,320);
/*!40000 ALTER TABLE `cash_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_note`
--

DROP TABLE IF EXISTS `credit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_note` (
  `CREDIT_NOTE_NUM` varchar(20) NOT NULL,
  `CREDIT_NOTE_DATE` date NOT NULL,
  `CREDIT_NOTE_DESC` varchar(255) DEFAULT NULL,
  `CREDIT_NOTE_CREDIT_TERM` enum('COD','30','45','60','90') NOT NULL,
  `DEBTOR_NUM` varchar(20) NOT NULL,
  `GL_ACC_NUM` int(11) NOT NULL,
  PRIMARY KEY (`CREDIT_NOTE_NUM`),
  KEY `fk_CREDIT_NOTE_DEBTOR1_idx` (`DEBTOR_NUM`),
  KEY `fk_CREDIT_NOTE_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_CREDIT_NOTE_DEBTOR1` FOREIGN KEY (`DEBTOR_NUM`) REFERENCES `debtor` (`DEBTOR_NUM`),
  CONSTRAINT `fk_CREDIT_NOTE_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_note`
--

LOCK TABLES `credit_note` WRITE;
/*!40000 ALTER TABLE `credit_note` DISABLE KEYS */;
INSERT INTO `credit_note` VALUES ('CN-1','2020-01-31','DISCOUNT','45','DEB-3',560),('CN-2','2020-03-03','Another discount','COD','DEB-2',550),('CN-3','2020-03-03',NULL,'60','DEB-3',550),('CN-4','2020-03-03',NULL,'60','DEB-1',560),('CN-5','2019-12-04',NULL,'60','DEB-1',560);
/*!40000 ALTER TABLE `credit_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_note_stock`
--

DROP TABLE IF EXISTS `credit_note_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_note_stock` (
  `CREDIT_NOTE_NUM` varchar(20) NOT NULL,
  `CREDIT_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `CREDIT_NOTE_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`CREDIT_NOTE_NUM`,`CREDIT_NOTELINE_LINENUMBER`,`STOCK_NUM`),
  KEY `fk_CREDIT_NOTE_STOCK_CREDIT_NOTELINE1_idx` (`CREDIT_NOTE_NUM`,`CREDIT_NOTELINE_LINENUMBER`),
  KEY `fk_CREDIT_NOTE_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_CREDIT_NOTE_STOCK_CREDIT_NOTELINE1` FOREIGN KEY (`CREDIT_NOTE_NUM`, `CREDIT_NOTELINE_LINENUMBER`) REFERENCES `credit_noteline` (`CREDIT_NOTE_NUM`, `CREDIT_NOTELINE_LINENUMBER`),
  CONSTRAINT `fk_CREDIT_NOTE_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_note_stock`
--

LOCK TABLES `credit_note_stock` WRITE;
/*!40000 ALTER TABLE `credit_note_stock` DISABLE KEYS */;
INSERT INTO `credit_note_stock` VALUES ('CN-3',1,'FBUM-1',6),('CN-3',2,'SPR-1',7);
/*!40000 ALTER TABLE `credit_note_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_noteline`
--

DROP TABLE IF EXISTS `credit_noteline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_noteline` (
  `CREDIT_NOTE_NUM` varchar(20) NOT NULL,
  `CREDIT_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `CREDIT_NOTELINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `CREDIT_NOTELINE_STOCK_DESC` varchar(50) NOT NULL,
  `CREDIT_NOTELINE_STOCK_PRICE` decimal(10,2) NOT NULL,
  `CREDIT_NOTELINE_STOCK_QTY` int(11) NOT NULL,
  `CREDIT_NOTELINE_DISCOUNT` decimal(10,2) NOT NULL,
  `CREDIT_NOTELINE_SUBTOTAL` decimal(10,2) GENERATED ALWAYS AS (((`CREDIT_NOTELINE_STOCK_PRICE` * `CREDIT_NOTELINE_STOCK_QTY`) - `CREDIT_NOTELINE_DISCOUNT`)) VIRTUAL,
  PRIMARY KEY (`CREDIT_NOTE_NUM`,`CREDIT_NOTELINE_LINENUMBER`),
  KEY `fk_CREDIT_NOTELINE_CREDIT_NOTE1_idx` (`CREDIT_NOTE_NUM`),
  CONSTRAINT `fk_CREDIT_NOTELINE_CREDIT_NOTE1` FOREIGN KEY (`CREDIT_NOTE_NUM`) REFERENCES `credit_note` (`CREDIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_noteline`
--

LOCK TABLES `credit_noteline` WRITE;
/*!40000 ALTER TABLE `credit_noteline` DISABLE KEYS */;
INSERT INTO `credit_noteline` (`CREDIT_NOTE_NUM`, `CREDIT_NOTELINE_LINENUMBER`, `CREDIT_NOTELINE_STOCK_NUM`, `CREDIT_NOTELINE_STOCK_DESC`, `CREDIT_NOTELINE_STOCK_PRICE`, `CREDIT_NOTELINE_STOCK_QTY`, `CREDIT_NOTELINE_DISCOUNT`) VALUES ('CN-1',1,NULL,'OVERALL DISCOUNT DUE TO MUPPETNESS',1050.00,1,0.00),('CN-2',1,NULL,'ANOTHER DISCOUNT',220.00,1,0.00),('CN-3',1,'FBUM-1','EXORA FRONT BUMPER',55.00,6,0.00),('CN-3',2,'SPR-1','SPOILER',25.00,7,0.00),('CN-4',1,NULL,'OVERALL DISCOUNT',200.00,1,0.00),('CN-5',1,NULL,'discount',500.00,1,0.00);
/*!40000 ALTER TABLE `credit_noteline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creditor`
--

DROP TABLE IF EXISTS `creditor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `creditor` (
  `CREDITOR_NUM` varchar(20) NOT NULL,
  `CREDITOR_NAME` varchar(255) NOT NULL,
  `CREDITOR_ADDRESS` varchar(255) NOT NULL,
  `CREDITOR_POSTCODE` varchar(5) NOT NULL,
  `CREDITOR_PHONE` varchar(15) NOT NULL,
  `CREDITOR_FAX` varchar(15) DEFAULT NULL,
  `CREDITOR_OTHER_DESC` varchar(255) DEFAULT NULL,
  `CREDITOR_CREDIT_TERM` enum('COD','30','45','60','90') DEFAULT NULL,
  `GL_ACC_NUM` int(11) NOT NULL DEFAULT '400',
  PRIMARY KEY (`CREDITOR_NUM`),
  KEY `fk_CREDITOR_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_CREDITOR_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creditor`
--

LOCK TABLES `creditor` WRITE;
/*!40000 ALTER TABLE `creditor` DISABLE KEYS */;
INSERT INTO `creditor` VALUES ('CRED-1','Mars Paint Marketing (M) Sdn Bhd','119, Jalan Kapar, Kawasan 18, Klang, Selangor','41400','03-3358 4561',NULL,NULL,'60',400),('CRED-2','Rotar Machinery Sdn Bhd','Jalan Pudu, WP, 227, Federal Territory of Kuala Lumpur','55100','03-2142 6590',NULL,NULL,'60',400),('CRED-3','Sime Kansai Paints Sdn Bhd','2, Solok Waja 2, Kawasan Perindustrian Bukit Raja, Klang, Selangor','41710','03-3343 4833',NULL,NULL,'60',400);
/*!40000 ALTER TABLE `creditor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debit_note`
--

DROP TABLE IF EXISTS `debit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debit_note` (
  `DEBIT_NOTE_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTE_DATE` date NOT NULL,
  `DEBIT_NOTE_DESC` varchar(255) DEFAULT NULL,
  `DEBIT_NOTE_CREDIT_TERM` enum('COD','30','45','60','90') NOT NULL,
  `DEBTOR_NUM` varchar(20) NOT NULL,
  `GL_ACC_NUM` int(11) NOT NULL,
  PRIMARY KEY (`DEBIT_NOTE_NUM`),
  KEY `fk_DEBIT_NOTE_GL1_idx` (`GL_ACC_NUM`),
  KEY `fk_DEBIT_NOTE_DEBTOR1_idx` (`DEBTOR_NUM`),
  CONSTRAINT `fk_DEBIT_NOTE_DEBTOR1` FOREIGN KEY (`DEBTOR_NUM`) REFERENCES `debtor` (`DEBTOR_NUM`),
  CONSTRAINT `fk_DEBIT_NOTE_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debit_note`
--

LOCK TABLES `debit_note` WRITE;
/*!40000 ALTER TABLE `debit_note` DISABLE KEYS */;
INSERT INTO `debit_note` VALUES ('DN-1','2020-03-03',NULL,'45','DEB-1',500),('DN-2','2020-04-01',NULL,'30','DEB-2',500),('DN-3','2020-04-01',NULL,'60','DEB-1',500);
/*!40000 ALTER TABLE `debit_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debit_note_bank_receipt`
--

DROP TABLE IF EXISTS `debit_note_bank_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debit_note_bank_receipt` (
  `BANK_RECEIPT_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTE_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTE_BANK_RECEIPT_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`DEBIT_NOTE_NUM`,`BANK_RECEIPT_NUM`),
  KEY `fk_DEBIT_NOTE_BANK_RECEIPT_DEBIT_NOTE1_idx` (`DEBIT_NOTE_NUM`),
  KEY `fk_DEBIT_NOTE_BANK_RECEIPT_BANK_RECEIPT1_idx` (`BANK_RECEIPT_NUM`),
  CONSTRAINT `fk_DEBIT_NOTE_BANK_RECEIPT_BANK_RECEIPT1` FOREIGN KEY (`BANK_RECEIPT_NUM`) REFERENCES `bank_receipt` (`BANK_RECEIPT_NUM`),
  CONSTRAINT `fk_DEBIT_NOTE_BANK_RECEIPT_DEBIT_NOTE1` FOREIGN KEY (`DEBIT_NOTE_NUM`) REFERENCES `debit_note` (`DEBIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debit_note_bank_receipt`
--

LOCK TABLES `debit_note_bank_receipt` WRITE;
/*!40000 ALTER TABLE `debit_note_bank_receipt` DISABLE KEYS */;
INSERT INTO `debit_note_bank_receipt` VALUES ('BR-6','DN-2',100.00);
/*!40000 ALTER TABLE `debit_note_bank_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debit_note_cash_receipt`
--

DROP TABLE IF EXISTS `debit_note_cash_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debit_note_cash_receipt` (
  `CASH_RECEIPT_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTE_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTE_CASH_RECEIPT_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`DEBIT_NOTE_NUM`,`CASH_RECEIPT_NUM`),
  KEY `fk_DEBIT_NOTE_CASH_RECEIPT_DEBIT_NOTE1_idx` (`DEBIT_NOTE_NUM`),
  KEY `fk_DEBIT_NOTE_CASH_RECEIPT_CASH_RECEIPT1_idx` (`CASH_RECEIPT_NUM`),
  CONSTRAINT `fk_DEBIT_NOTE_CASH_RECEIPT_CASH_RECEIPT1` FOREIGN KEY (`CASH_RECEIPT_NUM`) REFERENCES `cash_receipt` (`CASH_RECEIPT_NUM`),
  CONSTRAINT `fk_DEBIT_NOTE_CASH_RECEIPT_DEBIT_NOTE1` FOREIGN KEY (`DEBIT_NOTE_NUM`) REFERENCES `debit_note` (`DEBIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debit_note_cash_receipt`
--

LOCK TABLES `debit_note_cash_receipt` WRITE;
/*!40000 ALTER TABLE `debit_note_cash_receipt` DISABLE KEYS */;
/*!40000 ALTER TABLE `debit_note_cash_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debit_note_credit_note`
--

DROP TABLE IF EXISTS `debit_note_credit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debit_note_credit_note` (
  `CREDIT_NOTE_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTE_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTE_CREDIT_NOTE_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`DEBIT_NOTE_NUM`,`CREDIT_NOTE_NUM`),
  KEY `fk_DEBIT_NOTE_CREDIT_NOTE_DEBIT_NOTE1_idx` (`DEBIT_NOTE_NUM`),
  KEY `fk_DEBIT_NOTE_CREDIT_NOTE_CREDIT_NOTE1_idx` (`CREDIT_NOTE_NUM`),
  CONSTRAINT `fk_DEBIT_NOTE_CREDIT_NOTE_CREDIT_NOTE1` FOREIGN KEY (`CREDIT_NOTE_NUM`) REFERENCES `credit_note` (`CREDIT_NOTE_NUM`),
  CONSTRAINT `fk_DEBIT_NOTE_CREDIT_NOTE_DEBIT_NOTE1` FOREIGN KEY (`DEBIT_NOTE_NUM`) REFERENCES `debit_note` (`DEBIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debit_note_credit_note`
--

LOCK TABLES `debit_note_credit_note` WRITE;
/*!40000 ALTER TABLE `debit_note_credit_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `debit_note_credit_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debit_note_stock`
--

DROP TABLE IF EXISTS `debit_note_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debit_note_stock` (
  `DEBIT_NOTE_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTE_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`DEBIT_NOTE_NUM`,`DEBIT_NOTELINE_LINENUMBER`,`STOCK_NUM`),
  KEY `fk_DEBIT_NOTE_STOCK_DEBIT_NOTELINE1_idx` (`DEBIT_NOTE_NUM`,`DEBIT_NOTELINE_LINENUMBER`),
  KEY `fk_DEBIT_NOTE_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_DEBIT_NOTE_STOCK_DEBIT_NOTELINE1` FOREIGN KEY (`DEBIT_NOTE_NUM`, `DEBIT_NOTELINE_LINENUMBER`) REFERENCES `debit_noteline` (`DEBIT_NOTE_NUM`, `DEBIT_NOTELINE_LINENUMBER`),
  CONSTRAINT `fk_DEBIT_NOTE_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debit_note_stock`
--

LOCK TABLES `debit_note_stock` WRITE;
/*!40000 ALTER TABLE `debit_note_stock` DISABLE KEYS */;
INSERT INTO `debit_note_stock` VALUES ('DN-1',1,'FBUM-1',20),('DN-1',2,'FSKI-1',10);
/*!40000 ALTER TABLE `debit_note_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debit_noteline`
--

DROP TABLE IF EXISTS `debit_noteline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debit_noteline` (
  `DEBIT_NOTE_NUM` varchar(20) NOT NULL,
  `DEBIT_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `DEBIT_NOTELINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `DEBIT_NOTELINE_STOCK_DESC` varchar(50) NOT NULL,
  `DEBIT_NOTELINE_STOCK_PRICE` decimal(10,2) NOT NULL,
  `DEBIT_NOTELINE_STOCK_QTY` int(11) NOT NULL,
  `DEBIT_NOTELINE_DISCOUNT` decimal(10,2) NOT NULL,
  `DEBIT_NOTELINE_SUBTOTAL` decimal(10,2) GENERATED ALWAYS AS (((`DEBIT_NOTELINE_STOCK_PRICE` * `DEBIT_NOTELINE_STOCK_QTY`) - `DEBIT_NOTELINE_DISCOUNT`)) VIRTUAL,
  PRIMARY KEY (`DEBIT_NOTE_NUM`,`DEBIT_NOTELINE_LINENUMBER`),
  KEY `fk_DEBIT_NOTELINE_DEBIT_NOTE1_idx` (`DEBIT_NOTE_NUM`),
  CONSTRAINT `fk_DEBIT_NOTELINE_DEBIT_NOTE1` FOREIGN KEY (`DEBIT_NOTE_NUM`) REFERENCES `debit_note` (`DEBIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debit_noteline`
--

LOCK TABLES `debit_noteline` WRITE;
/*!40000 ALTER TABLE `debit_noteline` DISABLE KEYS */;
INSERT INTO `debit_noteline` (`DEBIT_NOTE_NUM`, `DEBIT_NOTELINE_LINENUMBER`, `DEBIT_NOTELINE_STOCK_NUM`, `DEBIT_NOTELINE_STOCK_DESC`, `DEBIT_NOTELINE_STOCK_PRICE`, `DEBIT_NOTELINE_STOCK_QTY`, `DEBIT_NOTELINE_DISCOUNT`) VALUES ('DN-1',1,'FBUM-1','EXORA FRONT BUMPER',55.12,20,0.00),('DN-1',2,'FSKI-1','EXORA FRONT SKIRT',35.00,10,0.00),('DN-2',1,NULL,'ADDITIONAL CHARGE',500.00,1,0.00);
/*!40000 ALTER TABLE `debit_noteline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debtor`
--

DROP TABLE IF EXISTS `debtor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debtor` (
  `DEBTOR_NUM` varchar(20) NOT NULL,
  `DEBTOR_NAME` varchar(255) NOT NULL,
  `DEBTOR_ADDRESS` varchar(255) NOT NULL,
  `DEBTOR_POSTCODE` varchar(5) NOT NULL,
  `DEBTOR_PHONE` varchar(15) NOT NULL,
  `DEBTOR_FAX` varchar(15) DEFAULT NULL,
  `DEBTOR_OTHER_DESC` varchar(255) DEFAULT NULL,
  `DEBTOR_CREDIT_TERM` enum('COD','30','45','60','90') NOT NULL,
  `GL_ACC_NUM` int(11) NOT NULL DEFAULT '300',
  PRIMARY KEY (`DEBTOR_NUM`),
  KEY `fk_DEBTOR_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_DEBTOR_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debtor`
--

LOCK TABLES `debtor` WRITE;
/*!40000 ALTER TABLE `debtor` DISABLE KEYS */;
INSERT INTO `debtor` VALUES ('DEB-1','Sipro Plastic Industries Sdn Bhd',' Lot 7, Jalan Bawang Putih 24/3 Section 24, Shah Alam, Selangor','40000','03-5541 8064',NULL,NULL,'60',300),('DEB-2','Teck See Plastic Sdn. Bhd.','Seksyen 15, Shah Alam, Selangor','40200','03-5510 3188',NULL,NULL,'30',300),('DEB-3','Proreka (M) Sdn. Bhd.','No. 17, Jalan Industri PBP 3, Taman Industri Pusat Bandar Puchong, Puchong, Selangor','47100','03-5882 2661',NULL,NULL,'60',300),('DEB-4','HICOM-Teck See Manufacturing Malaysia Sdn. Bhd.','Lot 75A & 76, Jalan Sementa 27/91, Section 27, Shah Alam, Shah Alam, Selangor','40000','03-5191 6077',NULL,NULL,'60',300),('DEB-5','Perodua Manufacturing Sdn Bhd','Lot 1896, Sungai Choh Mukim Serendah,Rawang,Selangor Darul Ehsan','48009','03-67338888',NULL,NULL,'60',300),('DEB-6','PROTON Holdings Berhad','HICOM Industrial Estate,Batu Tiga, Shah Alam,Selangor Darul Ehsan,','40000','603-5191 1055',NULL,NULL,'60',300);
/*!40000 ALTER TABLE `debtor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_order`
--

DROP TABLE IF EXISTS `delivery_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_order` (
  `DELIVERY_ORDER_NUM` varchar(20) NOT NULL,
  `DELIVERY_ORDER_DATE` date NOT NULL,
  `DELIVERY_ORDER_DESC` varchar(255) DEFAULT NULL,
  `DEBTOR_NUM` varchar(20) NOT NULL,
  PRIMARY KEY (`DELIVERY_ORDER_NUM`),
  KEY `fk_DELIVERY_ORDER_DEBTOR1_idx` (`DEBTOR_NUM`),
  CONSTRAINT `fk_DELIVERY_ORDER_DEBTOR1` FOREIGN KEY (`DEBTOR_NUM`) REFERENCES `debtor` (`DEBTOR_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_order`
--

LOCK TABLES `delivery_order` WRITE;
/*!40000 ALTER TABLE `delivery_order` DISABLE KEYS */;
INSERT INTO `delivery_order` VALUES ('DO-3','2020-04-07',NULL,'DEB-6');
/*!40000 ALTER TABLE `delivery_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_order_stock`
--

DROP TABLE IF EXISTS `delivery_order_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_order_stock` (
  `DELIVERY_ORDER_NUM` varchar(20) NOT NULL,
  `DELIVERY_ORDERLINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `DELIVERY_ORDER_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`DELIVERY_ORDER_NUM`,`DELIVERY_ORDERLINE_LINENUMBER`,`STOCK_NUM`),
  KEY `fk_DELIVERY_ORDER_STOCK_DELIVERY_ORDERLINE1_idx` (`DELIVERY_ORDER_NUM`,`DELIVERY_ORDERLINE_LINENUMBER`),
  KEY `fk_DELIVERY_ORDER_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_DELIVERY_ORDER_STOCK_DELIVERY_ORDERLINE1` FOREIGN KEY (`DELIVERY_ORDER_NUM`, `DELIVERY_ORDERLINE_LINENUMBER`) REFERENCES `delivery_orderline` (`DELIVERY_ORDER_NUM`, `DELIVERY_ORDERLINE_LINENUMBER`),
  CONSTRAINT `fk_DELIVERY_ORDER_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_order_stock`
--

LOCK TABLES `delivery_order_stock` WRITE;
/*!40000 ALTER TABLE `delivery_order_stock` DISABLE KEYS */;
INSERT INTO `delivery_order_stock` VALUES ('DO-3',1,'FBUM-1',13),('DO-3',2,'FSKI-1',5);
/*!40000 ALTER TABLE `delivery_order_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_orderline`
--

DROP TABLE IF EXISTS `delivery_orderline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_orderline` (
  `DELIVERY_ORDER_NUM` varchar(20) NOT NULL,
  `DELIVERY_ORDERLINE_LINENUMBER` int(11) NOT NULL,
  `DELIVERY_ORDERLINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `DELIVERY_ORDERLINE_STOCK_DESC` varchar(50) NOT NULL,
  `DELIVERY_ORDERLINE_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`DELIVERY_ORDER_NUM`,`DELIVERY_ORDERLINE_LINENUMBER`),
  KEY `fk_DELIVERY_ORDERLINE_DELIVERY_ORDER1_idx` (`DELIVERY_ORDER_NUM`),
  CONSTRAINT `fk_DELIVERY_ORDERLINE_DELIVERY_ORDER1` FOREIGN KEY (`DELIVERY_ORDER_NUM`) REFERENCES `delivery_order` (`DELIVERY_ORDER_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_orderline`
--

LOCK TABLES `delivery_orderline` WRITE;
/*!40000 ALTER TABLE `delivery_orderline` DISABLE KEYS */;
INSERT INTO `delivery_orderline` VALUES ('DO-3',1,'FBUM-1','EXORA FRONT BUMPER',13),('DO-3',2,'FSKI-1','EXORA FRONT SKIRT',5);
/*!40000 ALTER TABLE `delivery_orderline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_return`
--

DROP TABLE IF EXISTS `delivery_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_return` (
  `DELIVERY_RETURN_NUM` varchar(20) NOT NULL,
  `DELIVERY_RETURN_DATE` date NOT NULL,
  `DELIVERY_RETURN_DESC` varchar(255) DEFAULT NULL,
  `DEBTOR_NUM` varchar(20) NOT NULL,
  PRIMARY KEY (`DELIVERY_RETURN_NUM`),
  KEY `fk_DELIVERY_RETURN_DEBTOR1_idx` (`DEBTOR_NUM`),
  CONSTRAINT `fk_DELIVERY_RETURN_DEBTOR1` FOREIGN KEY (`DEBTOR_NUM`) REFERENCES `debtor` (`DEBTOR_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_return`
--

LOCK TABLES `delivery_return` WRITE;
/*!40000 ALTER TABLE `delivery_return` DISABLE KEYS */;
INSERT INTO `delivery_return` VALUES ('DR-1','2020-04-01',NULL,'DEB-1');
/*!40000 ALTER TABLE `delivery_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_return_stock`
--

DROP TABLE IF EXISTS `delivery_return_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_return_stock` (
  `DELIVERY_RETURN_NUM` varchar(20) NOT NULL,
  `DELIVERY_RETURNLINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `DELIVERY_RETURN_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`DELIVERY_RETURN_NUM`,`DELIVERY_RETURNLINE_LINENUMBER`,`STOCK_NUM`),
  KEY `fk_DELIVERY_RETURN_STOCK_DELIVERY_RETURNLINE1_idx` (`DELIVERY_RETURN_NUM`,`DELIVERY_RETURNLINE_LINENUMBER`),
  KEY `fk_DELIVERY_RETURN_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_DELIVERY_RETURN_STOCK_DELIVERY_RETURNLINE1` FOREIGN KEY (`DELIVERY_RETURN_NUM`, `DELIVERY_RETURNLINE_LINENUMBER`) REFERENCES `delivery_returnline` (`DELIVERY_RETURN_NUM`, `DELIVERY_RETURNLINE_LINENUMBER`),
  CONSTRAINT `fk_DELIVERY_RETURN_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_return_stock`
--

LOCK TABLES `delivery_return_stock` WRITE;
/*!40000 ALTER TABLE `delivery_return_stock` DISABLE KEYS */;
INSERT INTO `delivery_return_stock` VALUES ('DR-1',1,'FSKI-1',4),('DR-1',2,'FBUM-1',6);
/*!40000 ALTER TABLE `delivery_return_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_returnline`
--

DROP TABLE IF EXISTS `delivery_returnline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_returnline` (
  `DELIVERY_RETURN_NUM` varchar(20) NOT NULL,
  `DELIVERY_RETURNLINE_LINENUMBER` int(11) NOT NULL,
  `DELIVERY_RETURNLINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `DELIVERY_RETURNLINE_STOCK_DESC` varchar(50) NOT NULL,
  `DELIVERY_RETURNLINE_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`DELIVERY_RETURN_NUM`,`DELIVERY_RETURNLINE_LINENUMBER`),
  KEY `fk_DELIVERY_RETURNLINE_DELIVERY_RETURN1_idx` (`DELIVERY_RETURN_NUM`),
  CONSTRAINT `fk_DELIVERY_RETURNLINE_DELIVERY_RETURN1` FOREIGN KEY (`DELIVERY_RETURN_NUM`) REFERENCES `delivery_return` (`DELIVERY_RETURN_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_returnline`
--

LOCK TABLES `delivery_returnline` WRITE;
/*!40000 ALTER TABLE `delivery_returnline` DISABLE KEYS */;
INSERT INTO `delivery_returnline` VALUES ('DR-1',1,'FSKI-1','EXORA FRONT SKIRT',4),('DR-1',2,'FBUM-1','EXORA FRONT BUMPER',6);
/*!40000 ALTER TABLE `delivery_returnline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gl`
--

DROP TABLE IF EXISTS `gl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gl` (
  `GL_ACC_NUM` int(11) NOT NULL,
  `GL_DESC` varchar(45) NOT NULL,
  `GL_CATEGORY` varchar(45) NOT NULL,
  `GL_STATUS` varchar(25) NOT NULL,
  PRIMARY KEY (`GL_ACC_NUM`),
  KEY `GL_CATEGORY` (`GL_CATEGORY`),
  CONSTRAINT `gl_ibfk_1` FOREIGN KEY (`GL_CATEGORY`) REFERENCES `gl_category` (`GL_CATEGORY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gl`
--

LOCK TABLES `gl` WRITE;
/*!40000 ALTER TABLE `gl` DISABLE KEYS */;
INSERT INTO `gl` VALUES (100,'SHARE CAPITAL','EQUITY','NORMAL'),(150,'RESERVES','EQUITY','NORMAL'),(200,'FURNITURES AND FITTINGS','FIXED ASSETS','NORMAL'),(205,'ACCUM DEPRECIATION-FURNITURES AND FITTINGS','FIXED ASSETS','NORMAL'),(210,'OFFICE EQUIPMENTS','FIXED ASSETS','NORMAL'),(215,'ACCUM DEPRECIATION-OFFICE EQUIPMENTS','FIXED ASSETS','NORMAL'),(220,'MOTOR VEHICLES','FIXED ASSETS','NORMAL'),(225,'ACCUM DEPRECIATION-MOTOR VEHICLES','FIXED ASSETS','NORMAL'),(300,'DEBTOR','CURRENT ASSETS','SPECIAL'),(305,'OTHER DEBTOR','CURRENT ASSETS','NORMAL'),(310,'BANK','CURRENT ASSETS','SPECIAL'),(320,'CASH IN HAND','CURRENT ASSETS','DEFAULT'),(330,'STOCK','CURRENT ASSETS','NORMAL'),(340,'DEPOSIT AND PREPAYMENT','CURRENT ASSETS','NORMAL'),(400,'CREDITOR','CURRENT LIABILITIES','SPECIAL'),(405,'OTHER CREDITOR','CURRENT LIABILITIES','NORMAL'),(410,'ACCRUALS','CURRENT LIABILITIES','NORMAL'),(500,'SALES','SALES','NORMAL'),(510,'CASH SALES','SALES','NORMAL'),(550,'RETURN INWARDS','SALES ADJUSTMENTS','NORMAL'),(560,'DISCOUNTS ALLOWED','SALES ADJUSTMENTS','NORMAL'),(600,'OPENING STOCK','COST OF GOODS SOLD','NORMAL'),(610,'PURCHASES','COST OF GOODS SOLD','NORMAL'),(615,'PURCHASE RETURNS','COST OF GOODS SOLD','NORMAL'),(630,'CLOSING STOCK','COST OF GOODS SOLD','NORMAL'),(901,'ADVERTISEMENT','EXPENSES','NORMAL'),(902,'BANK CHARGES','EXPENSES','NORMAL'),(903,'DEPRECIATION OF FIXED ASSETS','EXPENSES','NORMAL'),(904,'SALARIES','EXPENSES','NORMAL'),(905,'TRAVELLING EXPENSES','EXPENSES','NORMAL'),(906,'UPKEEP OF MOTOR VEHICLES','EXPENSES','NORMAL'),(907,'WATER & ELECTRICITY','EXPENSES','NORMAL'),(908,'LOSS ON FOREIGN EXCHANGE','EXPENSES','NORMAL'),(909,'TELEPHONE CHARGES','EXPENSES','NORMAL'),(910,'PRINTING & STATIONERY','EXPENSES','NORMAL'),(911,'INTEREST EXPENSE','EXPENSES','NORMAL'),(912,'POSTAGES & STAMPS','EXPENSES','NORMAL'),(913,'COMMISSION & ALLOWANCES','EXPENSES','NORMAL'),(914,'OFFICE RENTAL','EXPENSES','NORMAL'),(915,'GENERAL EXPENSES','EXPENSES','NORMAL'),(950,'TAXATION','TAXATION','NORMAL');
/*!40000 ALTER TABLE `gl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gl_category`
--

DROP TABLE IF EXISTS `gl_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gl_category` (
  `GL_CATEGORY` varchar(255) NOT NULL,
  `GL_AREA` enum('PROFIT AND LOSS','BALANCE SHEET') NOT NULL,
  `GL_ORDER` int(11) NOT NULL,
  PRIMARY KEY (`GL_CATEGORY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gl_category`
--

LOCK TABLES `gl_category` WRITE;
/*!40000 ALTER TABLE `gl_category` DISABLE KEYS */;
INSERT INTO `gl_category` VALUES ('COST OF GOODS SOLD','PROFIT AND LOSS',11),('CURRENT ASSETS','BALANCE SHEET',3),('CURRENT LIABILITIES','BALANCE SHEET',4),('EQUITY','BALANCE SHEET',7),('EXPENSES','PROFIT AND LOSS',13),('FIXED ASSETS','BALANCE SHEET',1),('LONG TERM LIABILITIES','BALANCE SHEET',5),('OTHER ASSETS','BALANCE SHEET',2),('OTHER INCOME','PROFIT AND LOSS',12),('OTHER LIABILITIES','BALANCE SHEET',6),('SALES','PROFIT AND LOSS',9),('SALES ADJUSTMENTS','PROFIT AND LOSS',10),('TAXATION','PROFIT AND LOSS',14);
/*!40000 ALTER TABLE `gl_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_received_note`
--

DROP TABLE IF EXISTS `goods_received_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_received_note` (
  `GOODS_RECEIVED_NOTE_NUM` varchar(20) NOT NULL,
  `GOODS_RECEIVED_NOTE_DATE` date NOT NULL,
  `GOODS_RECEIVED_NOTE_DESC` varchar(255) DEFAULT NULL,
  `CREDITOR_NUM` varchar(20) NOT NULL,
  PRIMARY KEY (`GOODS_RECEIVED_NOTE_NUM`),
  KEY `fk_GOODS_RECEIVED_NOTE_CREDITOR1_idx` (`CREDITOR_NUM`),
  CONSTRAINT `fk_GOODS_RECEIVED_NOTE_CREDITOR1` FOREIGN KEY (`CREDITOR_NUM`) REFERENCES `creditor` (`CREDITOR_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_received_note`
--

LOCK TABLES `goods_received_note` WRITE;
/*!40000 ALTER TABLE `goods_received_note` DISABLE KEYS */;
INSERT INTO `goods_received_note` VALUES ('GRN-2','2020-04-07','123','CRED-2');
/*!40000 ALTER TABLE `goods_received_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_received_note_stock`
--

DROP TABLE IF EXISTS `goods_received_note_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_received_note_stock` (
  `GOODS_RECEIVED_NOTE_NUM` varchar(20) NOT NULL,
  `GOODS_RECEIVED_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `GOODS_RECEIVED_NOTE_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`GOODS_RECEIVED_NOTE_NUM`,`GOODS_RECEIVED_NOTELINE_LINENUMBER`,`STOCK_NUM`),
  KEY `fk_GOODS_RECEIVED_NOTE_STOCK_GOODS_RECEIVED_NOTELINE1_idx` (`GOODS_RECEIVED_NOTELINE_LINENUMBER`,`GOODS_RECEIVED_NOTE_NUM`),
  KEY `fk_GOODS_RECEIVED_NOTE_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_GOODS_RECEIVED_NOTE_STOCK_GOODS_RECEIVED_NOTELINE1` FOREIGN KEY (`GOODS_RECEIVED_NOTELINE_LINENUMBER`, `GOODS_RECEIVED_NOTE_NUM`) REFERENCES `goods_received_noteline` (`GOODS_RECEIVED_NOTELINE_LINENUMBER`, `GOODS_RECEIVED_NOTE_NUM`),
  CONSTRAINT `fk_GOODS_RECEIVED_NOTE_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_received_note_stock`
--

LOCK TABLES `goods_received_note_stock` WRITE;
/*!40000 ALTER TABLE `goods_received_note_stock` DISABLE KEYS */;
INSERT INTO `goods_received_note_stock` VALUES ('GRN-2',1,'FBUM-1',5),('GRN-2',2,'SPR-1',5);
/*!40000 ALTER TABLE `goods_received_note_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_received_noteline`
--

DROP TABLE IF EXISTS `goods_received_noteline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods_received_noteline` (
  `GOODS_RECEIVED_NOTE_NUM` varchar(20) NOT NULL,
  `GOODS_RECEIVED_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `GOODS_RECEIVED_NOTELINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `GOODS_RECEIVED_NOTELINE_STOCK_DESC` varchar(50) NOT NULL,
  `GOODS_RECEIVED_NOTELINE_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`GOODS_RECEIVED_NOTELINE_LINENUMBER`,`GOODS_RECEIVED_NOTE_NUM`),
  KEY `fk_GOODS_RECEIVED_NOTELINE_GOODS_RECEIVED_NOTE1_idx` (`GOODS_RECEIVED_NOTE_NUM`),
  CONSTRAINT `fk_GOODS_RECEIVED_NOTELINE_GOODS_RECEIVED_NOTE1` FOREIGN KEY (`GOODS_RECEIVED_NOTE_NUM`) REFERENCES `goods_received_note` (`GOODS_RECEIVED_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_received_noteline`
--

LOCK TABLES `goods_received_noteline` WRITE;
/*!40000 ALTER TABLE `goods_received_noteline` DISABLE KEYS */;
INSERT INTO `goods_received_noteline` VALUES ('GRN-2',1,'FBUM-1','EXORA FRONT BUMPER',5),('GRN-2',2,'SPR-1','SPOILER',5);
/*!40000 ALTER TABLE `goods_received_noteline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal`
--

DROP TABLE IF EXISTS `journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journal` (
  `JOURNAL_NUM` varchar(20) NOT NULL,
  `JOURNAL_DATE` date NOT NULL,
  `JOURNAL_DESC` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`JOURNAL_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal`
--

LOCK TABLES `journal` WRITE;
/*!40000 ALTER TABLE `journal` DISABLE KEYS */;
INSERT INTO `journal` VALUES ('JNL-1','2020-01-31',NULL),('JNL-2','2019-12-04',NULL);
/*!40000 ALTER TABLE `journal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journalline`
--

DROP TABLE IF EXISTS `journalline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journalline` (
  `JOURNAL_NUM` varchar(20) NOT NULL,
  `JOURNALLINE_LINENUMBER` int(11) NOT NULL,
  `GL_ACC_NUM` int(11) NOT NULL,
  `JOURNALLINE_GL_DESC` varchar(45) NOT NULL,
  `JOURNALLINE_DESC` varchar(255) DEFAULT NULL,
  `JOURNALLINE_DEBIT` decimal(10,2) DEFAULT NULL,
  `JOURNALLINE_CREDIT` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`JOURNALLINE_LINENUMBER`,`JOURNAL_NUM`),
  KEY `fk_JOURNALLINE_JOURNAL1_idx` (`JOURNAL_NUM`),
  KEY `fk_JOURNALLINE_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_JOURNALLINE_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`),
  CONSTRAINT `fk_JOURNALLINE_JOURNAL1` FOREIGN KEY (`JOURNAL_NUM`) REFERENCES `journal` (`JOURNAL_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journalline`
--

LOCK TABLES `journalline` WRITE;
/*!40000 ALTER TABLE `journalline` DISABLE KEYS */;
INSERT INTO `journalline` VALUES ('JNL-1',1,320,'CASH IN HAND',NULL,500.33,NULL),('JNL-2',1,205,'ACCUM DEPRECIATION-FURNITURES AND FITTINGS',NULL,NULL,300.00),('JNL-1',2,320,'CASH IN HAND',NULL,NULL,500.33),('JNL-2',2,903,'DEPRECIATION OF FIXED ASSETS',NULL,300.00,NULL);
/*!40000 ALTER TABLE `journalline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_credit_note`
--

DROP TABLE IF EXISTS `purchase_credit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_credit_note` (
  `PURCHASE_CREDIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_CREDIT_NOTE_DATE` date NOT NULL,
  `PURCHASE_CREDIT_NOTE_DESC` varchar(255) DEFAULT NULL,
  `PURCHASE_CREDIT_NOTE_CREDIT_TERM` enum('COD','30','45','60','90') NOT NULL,
  `CREDITOR_NUM` varchar(20) NOT NULL,
  `GL_ACC_NUM` int(11) NOT NULL,
  PRIMARY KEY (`PURCHASE_CREDIT_NOTE_NUM`),
  KEY `fk_PURCHASE_CREDIT_NOTE_CREDITOR1_idx` (`CREDITOR_NUM`),
  KEY `fk_PURCHASE_CREDIT_NOTE_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_PURCHASE_CREDIT_NOTE_CREDITOR1` FOREIGN KEY (`CREDITOR_NUM`) REFERENCES `creditor` (`CREDITOR_NUM`),
  CONSTRAINT `fk_PURCHASE_CREDIT_NOTE_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_credit_note`
--

LOCK TABLES `purchase_credit_note` WRITE;
/*!40000 ALTER TABLE `purchase_credit_note` DISABLE KEYS */;
INSERT INTO `purchase_credit_note` VALUES ('PCN-2','2020-01-28','CN FROM MARS PAINT FOR BEING JACKASS!','COD','CRED-1',610),('PCN-232','2020-04-08',NULL,'60','CRED-1',610);
/*!40000 ALTER TABLE `purchase_credit_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_credit_note_stock`
--

DROP TABLE IF EXISTS `purchase_credit_note_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_credit_note_stock` (
  `PURCHASE_CREDIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_CREDIT_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `PURCHASE_CREDIT_NOTE_STOCK_QTY` varchar(45) NOT NULL,
  PRIMARY KEY (`PURCHASE_CREDIT_NOTE_NUM`,`PURCHASE_CREDIT_NOTELINE_LINENUMBER`,`STOCK_NUM`),
  KEY `fk_PURCHASE_CREDIT_NOTE_STOCK_PURCHASE_CREDIT_NOTELINE1_idx` (`PURCHASE_CREDIT_NOTE_NUM`,`PURCHASE_CREDIT_NOTELINE_LINENUMBER`),
  KEY `fk_PURCHASE_CREDIT_NOTE_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_PURCHASE_CREDIT_NOTE_STOCK_PURCHASE_CREDIT_NOTELINE1` FOREIGN KEY (`PURCHASE_CREDIT_NOTE_NUM`, `PURCHASE_CREDIT_NOTELINE_LINENUMBER`) REFERENCES `purchase_credit_noteline` (`PURCHASE_CREDIT_NOTE_NUM`, `PURCHASE_CREDIT_NOTELINE_LINENUMBER`),
  CONSTRAINT `fk_PURCHASE_CREDIT_NOTE_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_credit_note_stock`
--

LOCK TABLES `purchase_credit_note_stock` WRITE;
/*!40000 ALTER TABLE `purchase_credit_note_stock` DISABLE KEYS */;
INSERT INTO `purchase_credit_note_stock` VALUES ('PCN-232',1,'FSKI-1','7');
/*!40000 ALTER TABLE `purchase_credit_note_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_credit_noteline`
--

DROP TABLE IF EXISTS `purchase_credit_noteline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_credit_noteline` (
  `PURCHASE_CREDIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_CREDIT_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `PURCHASE_CREDIT_NOTELINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `PURCHASE_CREDIT_NOTELINE_STOCK_DESC` varchar(50) NOT NULL,
  `PURCHASE_CREDIT_NOTELINE_STOCK_PRICE` decimal(10,2) NOT NULL,
  `PURCHASE_CREDIT_NOTELINE_STOCK_QTY` int(11) NOT NULL,
  `PURCHASE_CREDIT_NOTELINE_DISCOUNT` decimal(10,2) NOT NULL,
  `PURCHASE_CREDIT_NOTELINE_SUBTOTAL` varchar(45) GENERATED ALWAYS AS (((`PURCHASE_CREDIT_NOTELINE_STOCK_PRICE` * `PURCHASE_CREDIT_NOTELINE_STOCK_QTY`) - `PURCHASE_CREDIT_NOTELINE_DISCOUNT`)) VIRTUAL,
  PRIMARY KEY (`PURCHASE_CREDIT_NOTE_NUM`,`PURCHASE_CREDIT_NOTELINE_LINENUMBER`),
  KEY `fk_PURCHASE_CREDIT_NOTELINE_PURCHASE_CREDIT_NOTE1_idx` (`PURCHASE_CREDIT_NOTE_NUM`),
  CONSTRAINT `fk_PURCHASE_CREDIT_NOTELINE_PURCHASE_CREDIT_NOTE1` FOREIGN KEY (`PURCHASE_CREDIT_NOTE_NUM`) REFERENCES `purchase_credit_note` (`PURCHASE_CREDIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_credit_noteline`
--

LOCK TABLES `purchase_credit_noteline` WRITE;
/*!40000 ALTER TABLE `purchase_credit_noteline` DISABLE KEYS */;
INSERT INTO `purchase_credit_noteline` (`PURCHASE_CREDIT_NOTE_NUM`, `PURCHASE_CREDIT_NOTELINE_LINENUMBER`, `PURCHASE_CREDIT_NOTELINE_STOCK_NUM`, `PURCHASE_CREDIT_NOTELINE_STOCK_DESC`, `PURCHASE_CREDIT_NOTELINE_STOCK_PRICE`, `PURCHASE_CREDIT_NOTELINE_STOCK_QTY`, `PURCHASE_CREDIT_NOTELINE_DISCOUNT`) VALUES ('PCN-2',1,NULL,'BIG CN',300.00,1,0.00),('PCN-232',1,'FSKI-1','EXORA FRONT SKIRT',35.00,7,0.00);
/*!40000 ALTER TABLE `purchase_credit_noteline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_debit_note`
--

DROP TABLE IF EXISTS `purchase_debit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_debit_note` (
  `PURCHASE_DEBIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_DEBIT_NOTE_DATE` date NOT NULL,
  `PURCHASE_DEBIT_NOTE_DESC` varchar(255) DEFAULT NULL,
  `PURCHASE_DEBIT_NOTE_CREDIT_TERM` enum('COD','30','45','60','90') NOT NULL,
  `CREDITOR_NUM` varchar(20) NOT NULL,
  `GL_ACC_NUM` int(11) NOT NULL,
  PRIMARY KEY (`PURCHASE_DEBIT_NOTE_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTE_CREDITOR1_idx` (`CREDITOR_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTE_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_CREDITOR1` FOREIGN KEY (`CREDITOR_NUM`) REFERENCES `creditor` (`CREDITOR_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_debit_note`
--

LOCK TABLES `purchase_debit_note` WRITE;
/*!40000 ALTER TABLE `purchase_debit_note` DISABLE KEYS */;
INSERT INTO `purchase_debit_note` VALUES ('MARS-DN-124','2020-03-03',NULL,'COD','CRED-1',610);
/*!40000 ALTER TABLE `purchase_debit_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_debit_note_bank_payment`
--

DROP TABLE IF EXISTS `purchase_debit_note_bank_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_debit_note_bank_payment` (
  `BANK_PAYMENT_NUM` varchar(20) NOT NULL,
  `PURCHASE_DEBIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`BANK_PAYMENT_NUM`,`PURCHASE_DEBIT_NOTE_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTE_BANK_PAYMENT_BANK_PAYMENT1_idx` (`BANK_PAYMENT_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTE_BANK_PAYMENT_PURCHASE_DEBIT_NOTE1_idx` (`PURCHASE_DEBIT_NOTE_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_BANK_PAYMENT_BANK_PAYMENT1` FOREIGN KEY (`BANK_PAYMENT_NUM`) REFERENCES `bank_payment` (`BANK_PAYMENT_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_BANK_PAYMENT_PURCHASE_DEBIT_NOTE1` FOREIGN KEY (`PURCHASE_DEBIT_NOTE_NUM`) REFERENCES `purchase_debit_note` (`PURCHASE_DEBIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_debit_note_bank_payment`
--

LOCK TABLES `purchase_debit_note_bank_payment` WRITE;
/*!40000 ALTER TABLE `purchase_debit_note_bank_payment` DISABLE KEYS */;
INSERT INTO `purchase_debit_note_bank_payment` VALUES ('BP-3','MARS-DN-124',200.00);
/*!40000 ALTER TABLE `purchase_debit_note_bank_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_debit_note_cash_payment`
--

DROP TABLE IF EXISTS `purchase_debit_note_cash_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_debit_note_cash_payment` (
  `CASH_PAYMENT_NUM` varchar(20) NOT NULL,
  `PURCHASE_DEBIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`CASH_PAYMENT_NUM`,`PURCHASE_DEBIT_NOTE_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTE_CASH_PAYMENT_CASH_PAYMENT1_idx` (`CASH_PAYMENT_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTE_CASH_PAYMENT_PURCHASE_DEBIT_NOTE1_idx` (`PURCHASE_DEBIT_NOTE_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_CASH_PAYMENT_CASH_PAYMENT1` FOREIGN KEY (`CASH_PAYMENT_NUM`) REFERENCES `cash_payment` (`CASH_PAYMENT_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_CASH_PAYMENT_PURCHASE_DEBIT_NOTE1` FOREIGN KEY (`PURCHASE_DEBIT_NOTE_NUM`) REFERENCES `purchase_debit_note` (`PURCHASE_DEBIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_debit_note_cash_payment`
--

LOCK TABLES `purchase_debit_note_cash_payment` WRITE;
/*!40000 ALTER TABLE `purchase_debit_note_cash_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_debit_note_cash_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_debit_note_purchase_credit_note`
--

DROP TABLE IF EXISTS `purchase_debit_note_purchase_credit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_debit_note_purchase_credit_note` (
  `PURCHASE_CREDIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_DEBIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`PURCHASE_CREDIT_NOTE_NUM`,`PURCHASE_DEBIT_NOTE_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_PURCHASE_CREDIT_idx` (`PURCHASE_CREDIT_NOTE_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_PURCHASE_DEBIT__idx` (`PURCHASE_DEBIT_NOTE_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_PURCHASE_CREDIT_N1` FOREIGN KEY (`PURCHASE_CREDIT_NOTE_NUM`) REFERENCES `purchase_credit_note` (`PURCHASE_CREDIT_NOTE_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_PURCHASE_DEBIT_NO1` FOREIGN KEY (`PURCHASE_DEBIT_NOTE_NUM`) REFERENCES `purchase_debit_note` (`PURCHASE_DEBIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_debit_note_purchase_credit_note`
--

LOCK TABLES `purchase_debit_note_purchase_credit_note` WRITE;
/*!40000 ALTER TABLE `purchase_debit_note_purchase_credit_note` DISABLE KEYS */;
INSERT INTO `purchase_debit_note_purchase_credit_note` VALUES ('PCN-232','MARS-DN-124',200.00);
/*!40000 ALTER TABLE `purchase_debit_note_purchase_credit_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_debit_note_stock`
--

DROP TABLE IF EXISTS `purchase_debit_note_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_debit_note_stock` (
  `PURCHASE_DEBIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_DEBIT_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `PURCHASE_DEBIT_NOTE_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`STOCK_NUM`,`PURCHASE_DEBIT_NOTE_NUM`,`PURCHASE_DEBIT_NOTELINE_LINENUMBER`),
  KEY `fk_PURCHASE_DEBIT_NOTE_STOCK_PURCHASE_DEBIT_NOTELINE1_idx` (`PURCHASE_DEBIT_NOTELINE_LINENUMBER`,`PURCHASE_DEBIT_NOTE_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTE_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_STOCK_PURCHASE_DEBIT_NOTELINE1` FOREIGN KEY (`PURCHASE_DEBIT_NOTELINE_LINENUMBER`, `PURCHASE_DEBIT_NOTE_NUM`) REFERENCES `purchase_debit_noteline` (`PURCHASE_DEBIT_NOTELINE_LINENUMBER`, `PURCHASE_DEBIT_NOTE_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTE_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_debit_note_stock`
--

LOCK TABLES `purchase_debit_note_stock` WRITE;
/*!40000 ALTER TABLE `purchase_debit_note_stock` DISABLE KEYS */;
INSERT INTO `purchase_debit_note_stock` VALUES ('MARS-DN-124',1,'SPR-1',20);
/*!40000 ALTER TABLE `purchase_debit_note_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_debit_noteline`
--

DROP TABLE IF EXISTS `purchase_debit_noteline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_debit_noteline` (
  `PURCHASE_DEBIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_DEBIT_NOTELINE_LINENUMBER` int(11) NOT NULL,
  `PURCHASE_DEBIT_NOTELINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `PURCHASE_DEBIT_NOTELINE_STOCK_DESC` varchar(50) NOT NULL,
  `PURCHASE_DEBIT_NOTELINE_STOCK_PRICE` decimal(10,2) NOT NULL,
  `PURCHASE_DEBIT_NOTELINE_STOCK_QTY` int(11) NOT NULL,
  `PURCHASE_DEBIT_NOTELINE_DISCOUNT` decimal(10,2) NOT NULL,
  `PURCHASE_DEBIT_NOTELINE_SUBTOTAL` decimal(10,2) GENERATED ALWAYS AS (((`PURCHASE_DEBIT_NOTELINE_STOCK_PRICE` * `PURCHASE_DEBIT_NOTELINE_STOCK_QTY`) - `PURCHASE_DEBIT_NOTELINE_DISCOUNT`)) VIRTUAL,
  PRIMARY KEY (`PURCHASE_DEBIT_NOTELINE_LINENUMBER`,`PURCHASE_DEBIT_NOTE_NUM`),
  KEY `fk_PURCHASE_DEBIT_NOTELINE_PURCHASE_DEBIT_NOTE1_idx` (`PURCHASE_DEBIT_NOTE_NUM`),
  CONSTRAINT `fk_PURCHASE_DEBIT_NOTELINE_PURCHASE_DEBIT_NOTE1` FOREIGN KEY (`PURCHASE_DEBIT_NOTE_NUM`) REFERENCES `purchase_debit_note` (`PURCHASE_DEBIT_NOTE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_debit_noteline`
--

LOCK TABLES `purchase_debit_noteline` WRITE;
/*!40000 ALTER TABLE `purchase_debit_noteline` DISABLE KEYS */;
INSERT INTO `purchase_debit_noteline` (`PURCHASE_DEBIT_NOTE_NUM`, `PURCHASE_DEBIT_NOTELINE_LINENUMBER`, `PURCHASE_DEBIT_NOTELINE_STOCK_NUM`, `PURCHASE_DEBIT_NOTELINE_STOCK_DESC`, `PURCHASE_DEBIT_NOTELINE_STOCK_PRICE`, `PURCHASE_DEBIT_NOTELINE_STOCK_QTY`, `PURCHASE_DEBIT_NOTELINE_DISCOUNT`) VALUES ('MARS-DN-124',1,'SPR-1','SPOILER',25.00,20,0.00);
/*!40000 ALTER TABLE `purchase_debit_noteline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_invoice`
--

DROP TABLE IF EXISTS `purchase_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_invoice` (
  `PURCHASE_INVOICE_NUM` varchar(50) NOT NULL,
  `PURCHASE_INVOICE_DATE` date NOT NULL,
  `PURCHASE_INVOICE_DESC` varchar(255) DEFAULT NULL,
  `PURCHASE_INVOICE_CREDIT_TERM` enum('COD','30','45','60','90') NOT NULL,
  `CREDITOR_NUM` varchar(20) NOT NULL,
  `GL_ACC_NUM` int(11) NOT NULL,
  PRIMARY KEY (`PURCHASE_INVOICE_NUM`),
  KEY `fk_PURCHASE_INVOICE_CREDITOR1_idx` (`CREDITOR_NUM`),
  KEY `fk_PURCHASE_INVOICE_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICE_CREDITOR1` FOREIGN KEY (`CREDITOR_NUM`) REFERENCES `creditor` (`CREDITOR_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICE_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_invoice`
--

LOCK TABLES `purchase_invoice` WRITE;
/*!40000 ALTER TABLE `purchase_invoice` DISABLE KEYS */;
INSERT INTO `purchase_invoice` VALUES ('INV-043511','2019-12-03','ADS','45','CRED-1',610),('ROT-02','2020-03-03',NULL,'30','CRED-1',909),('SKP-323','2020-03-19',NULL,'60','CRED-3',610);
/*!40000 ALTER TABLE `purchase_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_invoice_bank_payment`
--

DROP TABLE IF EXISTS `purchase_invoice_bank_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_invoice_bank_payment` (
  `BANK_PAYMENT_NUM` varchar(20) NOT NULL,
  `PURCHASE_INVOICE_NUM` varchar(50) NOT NULL,
  `PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`BANK_PAYMENT_NUM`,`PURCHASE_INVOICE_NUM`),
  KEY `fk_PURCHASE_INVOICE_BANK_PAYMENT_BANK_PAYMENT1_idx` (`BANK_PAYMENT_NUM`),
  KEY `fk_PURCHASE_INVOICE_BANK_PAYMENT_PURCHASE_INVOICE1_idx` (`PURCHASE_INVOICE_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICE_BANK_PAYMENT_BANK_PAYMENT1` FOREIGN KEY (`BANK_PAYMENT_NUM`) REFERENCES `bank_payment` (`BANK_PAYMENT_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICE_BANK_PAYMENT_PURCHASE_INVOICE1` FOREIGN KEY (`PURCHASE_INVOICE_NUM`) REFERENCES `purchase_invoice` (`PURCHASE_INVOICE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_invoice_bank_payment`
--

LOCK TABLES `purchase_invoice_bank_payment` WRITE;
/*!40000 ALTER TABLE `purchase_invoice_bank_payment` DISABLE KEYS */;
INSERT INTO `purchase_invoice_bank_payment` VALUES ('BP-2','INV-043511',200.00);
/*!40000 ALTER TABLE `purchase_invoice_bank_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_invoice_cash_payment`
--

DROP TABLE IF EXISTS `purchase_invoice_cash_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_invoice_cash_payment` (
  `CASH_PAYMENT_NUM` varchar(20) NOT NULL,
  `PURCHASE_INVOICE_NUM` varchar(50) NOT NULL,
  `PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`CASH_PAYMENT_NUM`,`PURCHASE_INVOICE_NUM`),
  KEY `fk_PURCHASE_INVOICE_CASH_PAYMENT_CASH_PAYMENT1_idx` (`CASH_PAYMENT_NUM`),
  KEY `fk_PURCHASE_INVOICE_CASH_PAYMENT_PURCHASE_INVOICE1_idx` (`PURCHASE_INVOICE_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICE_CASH_PAYMENT_CASH_PAYMENT1` FOREIGN KEY (`CASH_PAYMENT_NUM`) REFERENCES `cash_payment` (`CASH_PAYMENT_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICE_CASH_PAYMENT_PURCHASE_INVOICE1` FOREIGN KEY (`PURCHASE_INVOICE_NUM`) REFERENCES `purchase_invoice` (`PURCHASE_INVOICE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_invoice_cash_payment`
--

LOCK TABLES `purchase_invoice_cash_payment` WRITE;
/*!40000 ALTER TABLE `purchase_invoice_cash_payment` DISABLE KEYS */;
INSERT INTO `purchase_invoice_cash_payment` VALUES ('CP-4','SKP-323',200.00);
/*!40000 ALTER TABLE `purchase_invoice_cash_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_invoice_purchase_credit_note`
--

DROP TABLE IF EXISTS `purchase_invoice_purchase_credit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_invoice_purchase_credit_note` (
  `PURCHASE_CREDIT_NOTE_NUM` varchar(50) NOT NULL,
  `PURCHASE_INVOICE_NUM` varchar(50) NOT NULL,
  `PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`PURCHASE_INVOICE_NUM`,`PURCHASE_CREDIT_NOTE_NUM`),
  KEY `fk_PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_PURCHASE_CREDIT_NO_idx` (`PURCHASE_CREDIT_NOTE_NUM`),
  KEY `fk_PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_PURCHASE_INVOICE1_idx` (`PURCHASE_INVOICE_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_PURCHASE_CREDIT_NOTE1` FOREIGN KEY (`PURCHASE_CREDIT_NOTE_NUM`) REFERENCES `purchase_credit_note` (`PURCHASE_CREDIT_NOTE_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_PURCHASE_INVOICE1` FOREIGN KEY (`PURCHASE_INVOICE_NUM`) REFERENCES `purchase_invoice` (`PURCHASE_INVOICE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_invoice_purchase_credit_note`
--

LOCK TABLES `purchase_invoice_purchase_credit_note` WRITE;
/*!40000 ALTER TABLE `purchase_invoice_purchase_credit_note` DISABLE KEYS */;
INSERT INTO `purchase_invoice_purchase_credit_note` VALUES ('PCN-2','INV-043511',300.00);
/*!40000 ALTER TABLE `purchase_invoice_purchase_credit_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_invoice_stock`
--

DROP TABLE IF EXISTS `purchase_invoice_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_invoice_stock` (
  `PURCHASE_INVOICE_NUM` varchar(50) NOT NULL,
  `PURCHASE_INVOICELINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `PURCHASE_INVOICE_STOCK_QTY` varchar(45) NOT NULL,
  PRIMARY KEY (`PURCHASE_INVOICE_NUM`,`PURCHASE_INVOICELINE_LINENUMBER`,`STOCK_NUM`),
  KEY `fk_PURCHASE_INVOICE_STOCK_PURCHASE_INVOICELINE1_idx` (`PURCHASE_INVOICE_NUM`,`PURCHASE_INVOICELINE_LINENUMBER`),
  KEY `fk_PURCHASE_INVOICE_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICE_STOCK_PURCHASE_INVOICELINE1` FOREIGN KEY (`PURCHASE_INVOICE_NUM`, `PURCHASE_INVOICELINE_LINENUMBER`) REFERENCES `purchase_invoiceline` (`PURCHASE_INVOICE_NUM`, `PURCHASE_INVOICELINE_LINENUMBER`),
  CONSTRAINT `fk_PURCHASE_INVOICE_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_invoice_stock`
--

LOCK TABLES `purchase_invoice_stock` WRITE;
/*!40000 ALTER TABLE `purchase_invoice_stock` DISABLE KEYS */;
INSERT INTO `purchase_invoice_stock` VALUES ('ROT-02',1,'FBUM-1','5');
/*!40000 ALTER TABLE `purchase_invoice_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_invoiceline`
--

DROP TABLE IF EXISTS `purchase_invoiceline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_invoiceline` (
  `PURCHASE_INVOICE_NUM` varchar(50) NOT NULL,
  `PURCHASE_INVOICELINE_LINENUMBER` int(11) NOT NULL,
  `PURCHASE_INVOICELINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `PURCHASE_INVOICELINE_STOCK_DESC` varchar(50) NOT NULL,
  `PURCHASE_INVOICELINE_STOCK_PRICE` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PURCHASE_INVOICELINE_STOCK_QTY` int(11) NOT NULL DEFAULT '0',
  `PURCHASE_INVOICELINE_DISCOUNT` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PURCHASE_INVOICELINE_SUBTOTAL` decimal(10,2) GENERATED ALWAYS AS (((`PURCHASE_INVOICELINE_STOCK_PRICE` * `PURCHASE_INVOICELINE_STOCK_QTY`) - `PURCHASE_INVOICELINE_DISCOUNT`)) VIRTUAL,
  PRIMARY KEY (`PURCHASE_INVOICE_NUM`,`PURCHASE_INVOICELINE_LINENUMBER`),
  KEY `fk_PURCHASE_INVOICELINE_PURCHASE_INVOICE1_idx` (`PURCHASE_INVOICE_NUM`),
  CONSTRAINT `fk_PURCHASE_INVOICELINE_PURCHASE_INVOICE1` FOREIGN KEY (`PURCHASE_INVOICE_NUM`) REFERENCES `purchase_invoice` (`PURCHASE_INVOICE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_invoiceline`
--

LOCK TABLES `purchase_invoiceline` WRITE;
/*!40000 ALTER TABLE `purchase_invoiceline` DISABLE KEYS */;
INSERT INTO `purchase_invoiceline` (`PURCHASE_INVOICE_NUM`, `PURCHASE_INVOICELINE_LINENUMBER`, `PURCHASE_INVOICELINE_STOCK_NUM`, `PURCHASE_INVOICELINE_STOCK_DESC`, `PURCHASE_INVOICELINE_STOCK_PRICE`, `PURCHASE_INVOICELINE_STOCK_QTY`, `PURCHASE_INVOICELINE_DISCOUNT`) VALUES ('INV-043511',1,NULL,'PAINT',500.00,1,0.00),('INV-043511',2,NULL,'THINNER',350.00,2,0.00),('ROT-02',1,'FBUM-1','EXORA FRONT BUMPER',55.00,5,0.00),('SKP-323',1,NULL,'PAINT',50.00,25,0.00);
/*!40000 ALTER TABLE `purchase_invoiceline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_return`
--

DROP TABLE IF EXISTS `purchase_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_return` (
  `PURCHASE_RETURN_NUM` varchar(20) NOT NULL,
  `PURCHASE_RETURN_DATE` date NOT NULL,
  `PURCHASE_RETURN_DESC` varchar(255) DEFAULT NULL,
  `CREDITOR_NUM` varchar(20) NOT NULL,
  PRIMARY KEY (`PURCHASE_RETURN_NUM`),
  KEY `fk_PURCHASE_RETURN_CREDITOR1_idx` (`CREDITOR_NUM`),
  CONSTRAINT `fk_PURCHASE_RETURN_CREDITOR1` FOREIGN KEY (`CREDITOR_NUM`) REFERENCES `creditor` (`CREDITOR_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_return`
--

LOCK TABLES `purchase_return` WRITE;
/*!40000 ALTER TABLE `purchase_return` DISABLE KEYS */;
INSERT INTO `purchase_return` VALUES ('PR-1','2020-04-07','1','CRED-3');
/*!40000 ALTER TABLE `purchase_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_return_stock`
--

DROP TABLE IF EXISTS `purchase_return_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_return_stock` (
  `PURCHASE_RETURN_NUM` varchar(20) NOT NULL,
  `PURCHASE_RETURNLINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `PURCHASE_RETURN_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`PURCHASE_RETURNLINE_LINENUMBER`,`PURCHASE_RETURN_NUM`,`STOCK_NUM`),
  KEY `fk_PURCHASE_RETURN_STOCK_PURCHASE_RETURNLINE1_idx` (`PURCHASE_RETURN_NUM`,`PURCHASE_RETURNLINE_LINENUMBER`),
  KEY `fk_PURCHASE_RETURN_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_PURCHASE_RETURN_STOCK_PURCHASE_RETURNLINE1` FOREIGN KEY (`PURCHASE_RETURN_NUM`, `PURCHASE_RETURNLINE_LINENUMBER`) REFERENCES `purchase_returnline` (`PURCHASE_RETURN_NUM`, `PURCHASE_RETURNLINE_LINENUMBER`),
  CONSTRAINT `fk_PURCHASE_RETURN_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_return_stock`
--

LOCK TABLES `purchase_return_stock` WRITE;
/*!40000 ALTER TABLE `purchase_return_stock` DISABLE KEYS */;
INSERT INTO `purchase_return_stock` VALUES ('PR-1',1,'SPR-1',55);
/*!40000 ALTER TABLE `purchase_return_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_returnline`
--

DROP TABLE IF EXISTS `purchase_returnline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_returnline` (
  `PURCHASE_RETURN_NUM` varchar(20) NOT NULL,
  `PURCHASE_RETURNLINE_LINENUMBER` int(11) NOT NULL,
  `PURCHASE_RETURNLINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `PURCHASE_RETURNLINE_STOCK_DESC` varchar(50) NOT NULL,
  `PURCHASE_RETURNLINE_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`PURCHASE_RETURN_NUM`,`PURCHASE_RETURNLINE_LINENUMBER`),
  KEY `fk_PURCHASE_RETURNLINE_PURCHASE_RETURN1_idx` (`PURCHASE_RETURN_NUM`),
  CONSTRAINT `fk_PURCHASE_RETURNLINE_PURCHASE_RETURN1` FOREIGN KEY (`PURCHASE_RETURN_NUM`) REFERENCES `purchase_return` (`PURCHASE_RETURN_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_returnline`
--

LOCK TABLES `purchase_returnline` WRITE;
/*!40000 ALTER TABLE `purchase_returnline` DISABLE KEYS */;
INSERT INTO `purchase_returnline` VALUES ('PR-1',1,'SPR-1','SPOILER',55);
/*!40000 ALTER TABLE `purchase_returnline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_invoice`
--

DROP TABLE IF EXISTS `sales_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_invoice` (
  `SALES_INVOICE_NUM` varchar(20) NOT NULL,
  `SALES_INVOICE_DATE` date NOT NULL,
  `SALES_INVOICE_DESC` varchar(255) DEFAULT NULL,
  `SALES_INVOICE_CREDIT_TERM` enum('COD','30','45','60','90') NOT NULL,
  `DEBTOR_NUM` varchar(20) NOT NULL,
  `GL_ACC_NUM` int(11) NOT NULL,
  PRIMARY KEY (`SALES_INVOICE_NUM`),
  KEY `fk_INVOICE_DEBTOR1_idx` (`DEBTOR_NUM`),
  KEY `fk_INVOICE_GL1_idx` (`GL_ACC_NUM`),
  CONSTRAINT `fk_INVOICE_DEBTOR1` FOREIGN KEY (`DEBTOR_NUM`) REFERENCES `debtor` (`DEBTOR_NUM`),
  CONSTRAINT `fk_INVOICE_GL1` FOREIGN KEY (`GL_ACC_NUM`) REFERENCES `gl` (`GL_ACC_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_invoice`
--

LOCK TABLES `sales_invoice` WRITE;
/*!40000 ALTER TABLE `sales_invoice` DISABLE KEYS */;
INSERT INTO `sales_invoice` VALUES ('PRO-1','2020-01-31',NULL,'60','DEB-3',500),('PRO-2','2020-02-29',NULL,'COD','DEB-3',500),('SIPR-1','2020-03-02',NULL,'60','DEB-1',500),('TSP-1','2020-01-01',NULL,'30','DEB-2',500),('TSP-10','2020-02-06',NULL,'30','DEB-2',500),('TSP-11','2020-02-29',NULL,'60','DEB-2',500),('TSP-2','2020-01-03',NULL,'30','DEB-2',500),('TSP-3','2020-01-07',NULL,'30','DEB-2',500),('TSP-4','2020-01-09',NULL,'30','DEB-2',500),('TSP-5','2020-01-16',NULL,'30','DEB-2',500),('TSP-6','2020-01-20',NULL,'30','DEB-2',500),('TSP-8','2020-03-27',NULL,'30','DEB-2',500),('TSP-9','2020-02-01',NULL,'30','DEB-2',500);
/*!40000 ALTER TABLE `sales_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_invoice_bank_receipt`
--

DROP TABLE IF EXISTS `sales_invoice_bank_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_invoice_bank_receipt` (
  `BANK_RECEIPT_NUM` varchar(20) NOT NULL,
  `SALES_INVOICE_NUM` varchar(20) NOT NULL,
  `SALES_INVOICE_BANK_RECEIPT_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`SALES_INVOICE_NUM`,`BANK_RECEIPT_NUM`),
  KEY `fk_SALES_INVOICE_BANK_RECEIPT_BANK_RECEIPT1_idx` (`BANK_RECEIPT_NUM`),
  KEY `fk_SALES_INVOICE_BANK_RECEIPT_SALES_INVOICE1_idx` (`SALES_INVOICE_NUM`),
  CONSTRAINT `fk_SALES_INVOICE_BANK_RECEIPT_BANK_RECEIPT1` FOREIGN KEY (`BANK_RECEIPT_NUM`) REFERENCES `bank_receipt` (`BANK_RECEIPT_NUM`),
  CONSTRAINT `fk_SALES_INVOICE_BANK_RECEIPT_SALES_INVOICE1` FOREIGN KEY (`SALES_INVOICE_NUM`) REFERENCES `sales_invoice` (`SALES_INVOICE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_invoice_bank_receipt`
--

LOCK TABLES `sales_invoice_bank_receipt` WRITE;
/*!40000 ALTER TABLE `sales_invoice_bank_receipt` DISABLE KEYS */;
INSERT INTO `sales_invoice_bank_receipt` VALUES ('BR-7','PRO-2',150.00),('BR-4','TSP-2',100.00),('BR-4','TSP-3',175.00),('BR-5','TSP-3',500.00),('BR-6','TSP-3',75.00);
/*!40000 ALTER TABLE `sales_invoice_bank_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_invoice_cash_receipt`
--

DROP TABLE IF EXISTS `sales_invoice_cash_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_invoice_cash_receipt` (
  `CASH_RECEIPT_NUM` varchar(20) NOT NULL,
  `SALES_INVOICE_NUM` varchar(20) NOT NULL,
  `SALES_INVOICE_CASH_RECEIPT_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`SALES_INVOICE_NUM`,`CASH_RECEIPT_NUM`),
  KEY `fk_SALES_INVOICE_CASH_RECEIPT_CASH_RECEIPT1_idx` (`CASH_RECEIPT_NUM`),
  KEY `fk_SALES_INVOICE_CASH_RECEIPT_SALES_INVOICE1_idx` (`SALES_INVOICE_NUM`),
  CONSTRAINT `fk_SALES_INVOICE_CASH_RECEIPT_CASH_RECEIPT1` FOREIGN KEY (`CASH_RECEIPT_NUM`) REFERENCES `cash_receipt` (`CASH_RECEIPT_NUM`),
  CONSTRAINT `fk_SALES_INVOICE_CASH_RECEIPT_SALES_INVOICE1` FOREIGN KEY (`SALES_INVOICE_NUM`) REFERENCES `sales_invoice` (`SALES_INVOICE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_invoice_cash_receipt`
--

LOCK TABLES `sales_invoice_cash_receipt` WRITE;
/*!40000 ALTER TABLE `sales_invoice_cash_receipt` DISABLE KEYS */;
INSERT INTO `sales_invoice_cash_receipt` VALUES ('CR-5','PRO-2',100.00),('CR-4','SIPR-1',300.00),('CR-3','TSP-2',275.00);
/*!40000 ALTER TABLE `sales_invoice_cash_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_invoice_credit_note`
--

DROP TABLE IF EXISTS `sales_invoice_credit_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_invoice_credit_note` (
  `CREDIT_NOTE_NUM` varchar(20) NOT NULL,
  `SALES_INVOICE_NUM` varchar(20) NOT NULL,
  `SALES_INVOICE_CREDIT_NOTE_AMOUNT` decimal(10,2) NOT NULL,
  PRIMARY KEY (`SALES_INVOICE_NUM`,`CREDIT_NOTE_NUM`),
  KEY `fk_SALES_INVOICE_CREDIT_NOTE_SALES_INVOICE1_idx` (`SALES_INVOICE_NUM`),
  KEY `fk_SALES_INVOICE_CREDIT_NOTE_CREDIT_NOTE1_idx` (`CREDIT_NOTE_NUM`),
  CONSTRAINT `fk_SALES_INVOICE_CREDIT_NOTE_CREDIT_NOTE1` FOREIGN KEY (`CREDIT_NOTE_NUM`) REFERENCES `credit_note` (`CREDIT_NOTE_NUM`),
  CONSTRAINT `fk_SALES_INVOICE_CREDIT_NOTE_SALES_INVOICE1` FOREIGN KEY (`SALES_INVOICE_NUM`) REFERENCES `sales_invoice` (`SALES_INVOICE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_invoice_credit_note`
--

LOCK TABLES `sales_invoice_credit_note` WRITE;
/*!40000 ALTER TABLE `sales_invoice_credit_note` DISABLE KEYS */;
INSERT INTO `sales_invoice_credit_note` VALUES ('CN-1','PRO-1',900.00),('CN-1','PRO-2',150.00),('CN-2','TSP-1',220.00);
/*!40000 ALTER TABLE `sales_invoice_credit_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_invoice_stock`
--

DROP TABLE IF EXISTS `sales_invoice_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_invoice_stock` (
  `SALES_INVOICE_NUM` varchar(20) NOT NULL,
  `SALES_INVOICELINE_LINENUMBER` int(11) NOT NULL,
  `STOCK_NUM` varchar(20) NOT NULL,
  `SALES_INVOICE_STOCK_QTY` int(11) NOT NULL,
  PRIMARY KEY (`SALES_INVOICE_NUM`,`SALES_INVOICELINE_LINENUMBER`,`STOCK_NUM`),
  KEY `fk_SALES_INVOICE_STOCK_SALES_INVOICELINE1_idx` (`SALES_INVOICE_NUM`,`SALES_INVOICELINE_LINENUMBER`),
  KEY `fk_SALES_INVOICE_STOCK_STOCK1_idx` (`STOCK_NUM`),
  CONSTRAINT `fk_SALES_INVOICE_STOCK_SALES_INVOICELINE1` FOREIGN KEY (`SALES_INVOICE_NUM`, `SALES_INVOICELINE_LINENUMBER`) REFERENCES `sales_invoiceline` (`SALES_INVOICE_NUM`, `SALES_INVOICELINE_LINENUMBER`),
  CONSTRAINT `fk_SALES_INVOICE_STOCK_STOCK1` FOREIGN KEY (`STOCK_NUM`) REFERENCES `stock` (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_invoice_stock`
--

LOCK TABLES `sales_invoice_stock` WRITE;
/*!40000 ALTER TABLE `sales_invoice_stock` DISABLE KEYS */;
INSERT INTO `sales_invoice_stock` VALUES ('PRO-1',1,'SPR-1',10),('PRO-1',2,'FSKI-1',10),('PRO-1',3,'FBUM-1',10);
/*!40000 ALTER TABLE `sales_invoice_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_invoiceline`
--

DROP TABLE IF EXISTS `sales_invoiceline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_invoiceline` (
  `SALES_INVOICE_NUM` varchar(20) NOT NULL,
  `SALES_INVOICELINE_LINENUMBER` int(11) NOT NULL,
  `SALES_INVOICELINE_STOCK_NUM` varchar(50) DEFAULT NULL,
  `SALES_INVOICELINE_STOCK_DESC` varchar(50) NOT NULL,
  `SALES_INVOICELINE_STOCK_PRICE` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SALES_INVOICELINE_STOCK_QTY` int(11) NOT NULL DEFAULT '0',
  `SALES_INVOICELINE_DISCOUNT` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SALES_INVOICELINE_SUBTOTAL` decimal(10,2) GENERATED ALWAYS AS (((`SALES_INVOICELINE_STOCK_PRICE` * `SALES_INVOICELINE_STOCK_QTY`) - `SALES_INVOICELINE_DISCOUNT`)) VIRTUAL,
  PRIMARY KEY (`SALES_INVOICE_NUM`,`SALES_INVOICELINE_LINENUMBER`),
  KEY `fk_INVOICELINE_INVOICE1_idx` (`SALES_INVOICE_NUM`),
  CONSTRAINT `fk_INVOICELINE_INVOICE1` FOREIGN KEY (`SALES_INVOICE_NUM`) REFERENCES `sales_invoice` (`SALES_INVOICE_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_invoiceline`
--

LOCK TABLES `sales_invoiceline` WRITE;
/*!40000 ALTER TABLE `sales_invoiceline` DISABLE KEYS */;
INSERT INTO `sales_invoiceline` (`SALES_INVOICE_NUM`, `SALES_INVOICELINE_LINENUMBER`, `SALES_INVOICELINE_STOCK_NUM`, `SALES_INVOICELINE_STOCK_DESC`, `SALES_INVOICELINE_STOCK_PRICE`, `SALES_INVOICELINE_STOCK_QTY`, `SALES_INVOICELINE_DISCOUNT`) VALUES ('PRO-1',1,'SPR-1','SPOILER',25.00,10,0.00),('PRO-1',2,'FSKI-1','EXORA FRONT SKIRT',35.00,10,0.00),('PRO-1',3,'FBUM-1','EXORA FRONT BUMPER',55.00,10,0.00),('PRO-2',1,'SPR-1','SPOILER',25.00,20,0.00),('SIPR-1',1,'FSKI-1','EXORA FRONT SKIRT',50.00,15,0.00),('TSP-1',1,'BUM-1','EXORA BUMPER5',55.00,4,0.00),('TSP-10',1,'FBUM-1','EXORA FRONT BUMPER',55.00,5,0.00),('TSP-11',1,'FBUM-1','EXORA FRONT BUMPER',55.00,12,0.00),('TSP-2',1,'FBUM-1','EXORA FRONT BUMPER',55.00,10,0.00),('TSP-2',2,NULL,'dsa',12.00,0,0.00),('TSP-3',1,'FBUM-1','EXORA FRONT BUMPER',55.00,20,0.00),('TSP-4',1,'FBUM-1','EXORA FRONT BUMPER',55.00,10,0.00),('TSP-5',1,'FBUM-1','EXORA FRONT BUMPER',55.00,5,0.00),('TSP-6',1,'FBUM-1','EXORA FRONT BUMPER',55.00,12,0.00),('TSP-8',1,'FBUM-1','EXORA FRONT BUMPER',55.00,11,0.00),('TSP-9',1,'FBUM-1','EXORA FRONT BUMPER',55.00,16,0.00);
/*!40000 ALTER TABLE `sales_invoiceline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `STOCK_NUM` varchar(20) NOT NULL,
  `STOCK_DESC` varchar(50) NOT NULL,
  `STOCK_PRICE` decimal(10,2) DEFAULT NULL,
  `STOCK_MINPRICE` decimal(10,2) DEFAULT NULL,
  `STOCK_MAXPRICE` decimal(10,2) DEFAULT NULL,
  `STOCK_COST` decimal(10,2) DEFAULT NULL,
  `STOCK_MINQTY` int(11) DEFAULT NULL,
  `STOCK_MAXQTY` int(11) DEFAULT NULL,
  PRIMARY KEY (`STOCK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES ('FBUM-1','EXORA FRONT BUMPER',55.00,NULL,NULL,NULL,NULL,NULL),('FSKI-1','EXORA FRONT SKIRT',35.00,NULL,NULL,NULL,NULL,NULL),('SPR-1','SPOILER',25.00,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `USER_USERNAME` varchar(20) NOT NULL,
  `USER_PASSWORD` varchar(20) NOT NULL,
  PRIMARY KEY (`USER_USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('protocount','password');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'accountingapp'
--
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_BANK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_BANK`(IN BANK_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM bank WHERE BANK_NUM IN (';
SELECT CONCAT(@STRNG,BANK_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_BANK_PAYMENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_BANK_PAYMENT`(IN BANK_PAYMENT_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM purchase_invoice_bank_payment WHERE BANK_PAYMENT_NUM IN (';
SELECT CONCAT(@STRNG,BANK_PAYMENT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note_bank_payment WHERE BANK_PAYMENT_NUM IN (';
SELECT CONCAT(@STRNG,BANK_PAYMENT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM bank_payment WHERE BANK_PAYMENT_NUM IN (';
SELECT CONCAT(@STRNG,BANK_PAYMENT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_BANK_RECEIPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_BANK_RECEIPT`(IN BANK_RECEIPT_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM sales_invoice_bank_receipt WHERE BANK_RECEIPT_NUM IN (';
SELECT CONCAT(@STRNG,BANK_RECEIPT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM debit_note_bank_receipt WHERE BANK_RECEIPT_NUM IN (';
SELECT CONCAT(@STRNG,BANK_RECEIPT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM bank_receipt WHERE BANK_RECEIPT_NUM IN (';
SELECT CONCAT(@STRNG,BANK_RECEIPT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_CASH_PAYMENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_CASH_PAYMENT`(IN CASH_PAYMENT_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM purchase_invoice_cash_payment WHERE CASH_PAYMENT_NUM IN (';
SELECT CONCAT(@STRNG,CASH_PAYMENT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note_cash_payment WHERE CASH_PAYMENT_NUM IN (';
SELECT CONCAT(@STRNG,CASH_PAYMENT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM cash_payment WHERE CASH_PAYMENT_NUM IN (';
SELECT CONCAT(@STRNG,CASH_PAYMENT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_CASH_RECEIPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_CASH_RECEIPT`(IN CASH_RECEIPT_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM sales_invoice_cash_receipt WHERE CASH_RECEIPT_NUM IN (';
SELECT CONCAT(@STRNG,CASH_RECEIPT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM debit_note_cash_receipt WHERE CASH_RECEIPT_NUM IN (';
SELECT CONCAT(@STRNG,CASH_RECEIPT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM cash_receipt WHERE CASH_RECEIPT_NUM IN (';
SELECT CONCAT(@STRNG,CASH_RECEIPT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_CREDITOR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_CREDITOR`(IN CREDITOR_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM creditor WHERE CREDITOR_NUM IN (';
SELECT CONCAT(@STRNG,CREDITOR_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_CREDIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_CREDIT_NOTE`(IN CREDIT_NOTE_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM credit_note_stock WHERE CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM credit_noteline WHERE CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM credit_note WHERE CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_DEBIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_DEBIT_NOTE`(IN DEBIT_NOTE_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM debit_note_stock WHERE DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM debit_noteline WHERE DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM debit_note_cash_receipt WHERE DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM debit_note_bank_receipt WHERE DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM debit_note_credit_note WHERE DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM debit_note WHERE DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_DEBTOR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_DEBTOR`(IN DEBTOR_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM debtor WHERE DEBTOR_NUM IN (';
SELECT CONCAT(@STRNG,DEBTOR_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_DELIVERY_ORDER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_DELIVERY_ORDER`(IN DELIVERY_ORDER_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM delivery_order_stock WHERE DELIVERY_ORDER_NUM IN (';
SELECT CONCAT(@STRNG,DELIVERY_ORDER_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM delivery_orderline WHERE DELIVERY_ORDER_NUM IN (';
SELECT CONCAT(@STRNG,DELIVERY_ORDER_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM delivery_order WHERE DELIVERY_ORDER_NUM IN (';
SELECT CONCAT(@STRNG,DELIVERY_ORDER_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_DELIVERY_RETURN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_DELIVERY_RETURN`(IN DELIVERY_RETURN_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM delivery_return_stock WHERE DELIVERY_RETURN_NUM IN (';
SELECT CONCAT(@STRNG,DELIVERY_RETURN_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM delivery_returnline WHERE DELIVERY_RETURN_NUM IN (';
SELECT CONCAT(@STRNG,DELIVERY_RETURN_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM delivery_return WHERE DELIVERY_RETURN_NUM IN (';
SELECT CONCAT(@STRNG,DELIVERY_RETURN_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_GOODS_RECEIVED_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_GOODS_RECEIVED_NOTE`(IN GOODS_RECEIVED_NOTE_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM goods_received_note_stock WHERE GOODS_RECEIVED_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,GOODS_RECEIVED_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM goods_received_noteline WHERE GOODS_RECEIVED_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,GOODS_RECEIVED_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM goods_received_note WHERE GOODS_RECEIVED_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,GOODS_RECEIVED_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_JOURNAL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_JOURNAL`(IN JOURNAL_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM journalline WHERE JOURNAL_NUM IN (';
SELECT CONCAT(@STRNG,JOURNAL_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM journal WHERE JOURNAL_NUM IN (';
SELECT CONCAT(@STRNG,JOURNAL_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_PURCHASE_CREDIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_PURCHASE_CREDIT_NOTE`(IN PURCHASE_CREDIT_NOTE_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM purchase_credit_note_stock WHERE PURCHASE_CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_credit_noteline WHERE PURCHASE_CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_CREDIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_PURCHASE_DEBIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_PURCHASE_DEBIT_NOTE`(IN PURCHASE_DEBIT_NOTE_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM purchase_debit_note_stock WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_noteline WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note_cash_payment WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note_bank_payment WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_PURCHASE_INVOICE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_PURCHASE_INVOICE`(IN PURCHASE_INVOICE_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM purchase_invoice_stock WHERE PURCHASE_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_invoiceline WHERE PURCHASE_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_invoice_cash_payment WHERE PURCHASE_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_invoice_bank_payment WHERE PURCHASE_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_invoice WHERE PURCHASE_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_PURCHASE_RETURN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_PURCHASE_RETURN`(IN PURCHASE_RETURN_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM purchase_return_stock WHERE PURCHASE_RETURN_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_RETURN_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_returnline WHERE PURCHASE_RETURN_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_RETURN_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_return WHERE PURCHASE_RETURN_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_RETURN_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_SALES_INVOICE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_SALES_INVOICE`(IN SALES_INVOICE_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM sales_invoice_stock WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoiceline WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoice_cash_receipt WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoice_bank_receipt WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoice_credit_note WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoice WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DELETE_STOCK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `DELETE_STOCK`(IN STOCK_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM stock WHERE STOCK_NUM IN (';
SELECT CONCAT(@STRNG,STOCK_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_ACCOUNT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_ACCOUNT`(IN GL_CATEGORY VARCHAR(45),IN GL_ACC_NUM INT, IN GL_DESC VARCHAR(45))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO gl VALUES(GL_ACC_NUM,GL_DESC,GL_CATEGORY,'NORMAL');
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_BANK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_BANK`(IN BANK_NUM_PARAM VARCHAR(20),IN BANK_NAME_PARAM VARCHAR(255), IN BANK_ADDRESS_PARAM VARCHAR(255), IN BANK_POSTCODE_PARAM VARCHAR(5), IN GL_ACC_NUM INT, IN BANK_NUM_OLD_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO bank VALUES(BANK_NUM_PARAM,BANK_NAME_PARAM,BANK_ADDRESS_PARAM,BANK_POSTCODE_PARAM,DEFAULT);
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_BANK_PAYMENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_BANK_PAYMENT`(IN BANK_PAYMENT_NUM_PARAM VARCHAR(20),IN BANK_NUM_PARAM VARCHAR(20), IN CREDITOR_NUM_PARAM VARCHAR(20), IN BANK_PAYMENT_DATE_PARAM DATE, IN BANK_PAYMENT_METHOD_PARAM VARCHAR(45),IN BANK_PAYMENT_TRANSACTION_ID_PARAM VARCHAR(45),IN BANK_PAYMENT_DESC_PARAM VARCHAR(255),IN BANK_PAYMENT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM_PARAM INT,IN BANK_PAYMENT_NUM_OLD_PARAM VARCHAR(20), IN OFFSET_ONE_PARAM VARCHAR(255),IN OFFSET_TWO_PARAM VARCHAR(255))
BEGIN
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO bank_payment VALUES(BANK_PAYMENT_NUM_PARAM,BANK_NUM_PARAM,CREDITOR_NUM_PARAM,BANK_PAYMENT_DATE_PARAM,BANK_PAYMENT_METHOD_PARAM,BANK_PAYMENT_TRANSACTION_ID_PARAM,BANK_PAYMENT_DESC_PARAM,BANK_PAYMENT_AMOUNT_PARAM,GL_ACC_NUM_PARAM);

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoice_bank_payment VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',BANK_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',BANK_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_note_bank_payment VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',BANK_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',BANK_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_BANK_RECEIPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_BANK_RECEIPT`(IN BANK_RECEIPT_NUM_PARAM VARCHAR(20),IN BANK_NUM_PARAM VARCHAR(20), IN DEBTOR_NUM_PARAM VARCHAR(20), IN BANK_RECEIPT_DATE_PARAM DATE, IN BANK_RECEIPT_METHOD_PARAM VARCHAR(45),IN BANK_RECEIPT_TRANSACTION_ID_PARAM VARCHAR(45),IN BANK_RECEIPT_DESC_PARAM VARCHAR(255),IN BANK_RECEIPT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM_PARAM INT,IN BANK_RECEIPT_NUM_OLD_PARAM VARCHAR(20), IN OFFSET_ONE_PARAM VARCHAR(255),IN OFFSET_TWO_PARAM VARCHAR(255))
BEGIN
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO bank_receipt VALUES(BANK_RECEIPT_NUM_PARAM,BANK_NUM_PARAM,DEBTOR_NUM_PARAM,BANK_RECEIPT_DATE_PARAM,BANK_RECEIPT_METHOD_PARAM,BANK_RECEIPT_TRANSACTION_ID_PARAM,BANK_RECEIPT_DESC_PARAM,BANK_RECEIPT_AMOUNT_PARAM,GL_ACC_NUM_PARAM);

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoice_bank_receipt VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',BANK_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',BANK_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_note_bank_receipt VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',BANK_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',BANK_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_CASH_PAYMENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_CASH_PAYMENT`(IN CASH_PAYMENT_NUM_PARAM VARCHAR(20), IN CREDITOR_NUM_PARAM VARCHAR(20), IN CASH_PAYMENT_DATE_PARAM DATE, IN CASH_PAYMENT_METHOD_PARAM VARCHAR(45),IN CASH_PAYMENT_TRANSACTION_ID_PARAM VARCHAR(45),IN CASH_PAYMENT_DESC_PARAM VARCHAR(255),IN CASH_PAYMENT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM1_PARAM INT,IN GL_ACC_NUM2_PARAM INT,IN CASH_PAYMENT_NUM_OLD_PARAM VARCHAR(20), IN OFFSET_ONE_PARAM VARCHAR(255),IN OFFSET_TWO_PARAM VARCHAR(255))
BEGIN
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO cash_payment VALUES(CASH_PAYMENT_NUM_PARAM,CREDITOR_NUM_PARAM,CASH_PAYMENT_DATE_PARAM,CASH_PAYMENT_METHOD_PARAM,CASH_PAYMENT_TRANSACTION_ID_PARAM,CASH_PAYMENT_DESC_PARAM,CASH_PAYMENT_AMOUNT_PARAM,GL_ACC_NUM1_PARAM,DEFAULT);

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoice_cash_payment VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CASH_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CASH_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_note_cash_payment VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CASH_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CASH_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_CASH_RECEIPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_CASH_RECEIPT`(IN CASH_RECEIPT_NUM_PARAM VARCHAR(20), IN DEBTOR_NUM_PARAM VARCHAR(20), IN CASH_RECEIPT_DATE_PARAM DATE, IN CASH_RECEIPT_METHOD_PARAM VARCHAR(45),IN CASH_RECEIPT_TRANSACTION_ID_PARAM VARCHAR(45),IN CASH_RECEIPT_DESC_PARAM VARCHAR(255),IN CASH_RECEIPT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM1_PARAM INT,IN GL_ACC_NUM2_PARAM INT,IN CASH_RECEIPT_NUM_OLD_PARAM VARCHAR(20), IN OFFSET_ONE_PARAM VARCHAR(255),IN OFFSET_TWO_PARAM VARCHAR(255))
BEGIN
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO cash_receipt VALUES(CASH_RECEIPT_NUM_PARAM,DEBTOR_NUM_PARAM,CASH_RECEIPT_DATE_PARAM,CASH_RECEIPT_METHOD_PARAM,CASH_RECEIPT_TRANSACTION_ID_PARAM,CASH_RECEIPT_DESC_PARAM,CASH_RECEIPT_AMOUNT_PARAM,GL_ACC_NUM1_PARAM,DEFAULT);

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoice_cash_receipt VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CASH_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CASH_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_note_cash_receipt VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CASH_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CASH_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_CREDITOR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_CREDITOR`(IN CREDITOR_NUM_PARAM VARCHAR(20),IN CREDITOR_NAME_PARAM VARCHAR(255), IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN CREDITOR_POSTCODE_PARAM VARCHAR(5), IN CREDITOR_PHONE_PARAM VARCHAR(15),IN CREDITOR_FAX_PARAM VARCHAR(15),IN CREDITOR_OTHER_DESC_PARAM VARCHAR(255),IN CREDITOR_CREDIT_TERM_PARAM ENUM('COD', '30', '45', '60', '90'),IN GL_ACC_NUM INT,IN CREDITOR_NUM_OLD_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO creditor VALUES(CREDITOR_NUM_PARAM,CREDITOR_NAME_PARAM,CREDITOR_ADDRESS_PARAM,CREDITOR_POSTCODE_PARAM,CREDITOR_PHONE_PARAM,CREDITOR_FAX_PARAM,CREDITOR_OTHER_DESC_PARAM,CREDITOR_CREDIT_TERM_PARAM,DEFAULT);
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_CREDIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_CREDIT_NOTE`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN CREDIT_NOTE_NUM_PARAM VARCHAR(20), IN CREDIT_NOTE_DATE_PARAM DATE, IN CREDIT_NOTE_DESC_PARAM VARCHAR(255), IN CREDIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, IN CREDIT_NOTE_NUM_OLD_PARAM VARCHAR(20), IN CREDIT_NOTELINE_PARAM VARCHAR(255), IN OFFSET_ONE_PARAM VARCHAR(255),IN OFFSET_TWO_PARAM VARCHAR(255), IN CREDIT_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE POS3 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT credit_note VALUES(CREDIT_NOTE_NUM_PARAM,CREDIT_NOTE_DATE_PARAM,CREDIT_NOTE_DESC_PARAM,CREDIT_NOTE_CREDIT_TERM_PARAM,DEBTOR_NUM_PARAM,GL_ACC_NUM_PARAM);

IF CREDIT_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT credit_noteline VALUES ';

creditnoteline_loop:LOOP
IF REGEXP_INSTR(CREDIT_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(CREDIT_NOTELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE creditnoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(CREDIT_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(CREDIT_NOTELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(CREDIT_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP creditnoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



END;
END IF;


IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoice_credit_note VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_note_credit_note VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF CREDIT_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT credit_note_stock VALUES ';

creditnotestock_loop:LOOP
IF REGEXP_INSTR(CREDIT_NOTE_STOCK_PARAM,'=',POS3)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(CREDIT_NOTE_STOCK_PARAM,POS3),')') INTO @STRNG;
LEAVE creditnotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(CREDIT_NOTE_STOCK_PARAM,'=',POS3) - POS3) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(CREDIT_NOTE_STOCK_PARAM,POS3,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(CREDIT_NOTE_STOCK_PARAM,'=',POS3)+1) INTO POS3;
END;
END IF;
END LOOP creditnotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_DEBIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_DEBIT_NOTE`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN DEBIT_NOTE_NUM_PARAM VARCHAR(20), IN DEBIT_NOTE_DATE_PARAM DATE, IN DEBIT_NOTE_DESC_PARAM VARCHAR(255), IN DEBIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, IN DEBIT_NOTE_NUM_OLD_PARAM VARCHAR(20), IN DEBIT_NOTELINE_PARAM VARCHAR(255), IN DEBIT_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT debit_note VALUES(DEBIT_NOTE_NUM_PARAM,DEBIT_NOTE_DATE_PARAM,DEBIT_NOTE_DESC_PARAM,DEBIT_NOTE_CREDIT_TERM_PARAM,DEBTOR_NUM_PARAM,GL_ACC_NUM_PARAM);

IF DEBIT_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_noteline VALUES ';

debitnoteline_loop:LOOP
IF REGEXP_INSTR(DEBIT_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(DEBIT_NOTELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE debitnoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DEBIT_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(DEBIT_NOTELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(DEBIT_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP debitnoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF DEBIT_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_note_stock VALUES ';

debitnotestock_loop:LOOP
IF REGEXP_INSTR(DEBIT_NOTE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(DEBIT_NOTE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE debitnotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DEBIT_NOTE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(DEBIT_NOTE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DEBIT_NOTE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP debitnotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_DEBTOR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_DEBTOR`(IN DEBTOR_NUM_PARAM VARCHAR(20),IN DEBTOR_NAME_PARAM VARCHAR(255), IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN DEBTOR_POSTCODE_PARAM VARCHAR(5), IN DEBTOR_PHONE_PARAM VARCHAR(15),IN DEBTOR_FAX_PARAM VARCHAR(15),IN DEBTOR_OTHER_DESC_PARAM VARCHAR(255),IN DEBTOR_CREDIT_TERM_PARAM ENUM('COD', '30', '45', '60', '90'),IN GL_ACC_NUM_PARAM INT,IN DEBTOR_NUM_OLD_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO debtor VALUES(DEBTOR_NUM_PARAM,DEBTOR_NAME_PARAM,DEBTOR_ADDRESS_PARAM,DEBTOR_POSTCODE_PARAM,DEBTOR_PHONE_PARAM,DEBTOR_FAX_PARAM,DEBTOR_OTHER_DESC_PARAM,DEBTOR_CREDIT_TERM_PARAM,DEFAULT);
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_DELIVERY_ORDER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_DELIVERY_ORDER`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN DELIVERY_ORDER_NUM_PARAM VARCHAR(20), IN DELIVERY_ORDER_DATE_PARAM DATE, IN DELIVERY_ORDER_DESC_PARAM VARCHAR(255), IN DELIVERY_ORDER_NUM_OLD_PARAM VARCHAR(20), IN DELIVERY_ORDERLINE_PARAM VARCHAR(255),IN DELIVERY_ORDER_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT delivery_order VALUES(DELIVERY_ORDER_NUM_PARAM,DELIVERY_ORDER_DATE_PARAM,DELIVERY_ORDER_DESC_PARAM,DEBTOR_NUM_PARAM);

IF DELIVERY_ORDERLINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT delivery_orderline VALUES ';

deliveryorderline_loop:LOOP
IF REGEXP_INSTR(DELIVERY_ORDERLINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DELIVERY_ORDER_NUM_PARAM,'",',SUBSTRING(DELIVERY_ORDERLINE_PARAM,POS),')') INTO @STRNG;
LEAVE deliveryorderline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DELIVERY_ORDERLINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DELIVERY_ORDER_NUM_PARAM,'",',SUBSTRING(DELIVERY_ORDERLINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DELIVERY_ORDERLINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP deliveryorderline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF DELIVERY_ORDER_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT delivery_order_stock VALUES ';

deliveryorderstock_loop:LOOP
IF REGEXP_INSTR(DELIVERY_ORDER_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DELIVERY_ORDER_NUM_PARAM,'",',SUBSTRING(DELIVERY_ORDER_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE deliveryorderstock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DELIVERY_ORDER_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DELIVERY_ORDER_NUM_PARAM,'",',SUBSTRING(DELIVERY_ORDER_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DELIVERY_ORDER_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP deliveryorderstock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;



COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_DELIVERY_RETURN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_DELIVERY_RETURN`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN DELIVERY_RETURN_NUM_PARAM VARCHAR(20), IN DELIVERY_RETURN_DATE_PARAM DATE, IN DELIVERY_RETURN_DESC_PARAM VARCHAR(255), IN DELIVERY_RETURN_NUM_OLD_PARAM VARCHAR(20), IN DELIVERY_RETURNLINE_PARAM VARCHAR(255), IN DELIVERY_RETURN_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT delivery_return VALUES(DELIVERY_RETURN_NUM_PARAM,DELIVERY_RETURN_DATE_PARAM,DELIVERY_RETURN_DESC_PARAM,DEBTOR_NUM_PARAM);

IF DELIVERY_RETURNLINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT delivery_returnline VALUES ';

deliveryreturnline_loop:LOOP
IF REGEXP_INSTR(DELIVERY_RETURNLINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DELIVERY_RETURN_NUM_PARAM,'",',SUBSTRING(DELIVERY_RETURNLINE_PARAM,POS),')') INTO @STRNG;
LEAVE deliveryreturnline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DELIVERY_RETURNLINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DELIVERY_RETURN_NUM_PARAM,'",',SUBSTRING(DELIVERY_RETURNLINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DELIVERY_RETURNLINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP deliveryreturnline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF DELIVERY_RETURN_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT delivery_return_stock VALUES ';

deliveryreturnstock_loop:LOOP
IF REGEXP_INSTR(DELIVERY_RETURN_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DELIVERY_RETURN_NUM_PARAM,'",',SUBSTRING(DELIVERY_RETURN_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE deliveryreturnstock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DELIVERY_RETURN_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DELIVERY_RETURN_NUM_PARAM,'",',SUBSTRING(DELIVERY_RETURN_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DELIVERY_RETURN_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP deliveryreturnstock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_GOODS_RECEIVED_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_GOODS_RECEIVED_NOTE`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN GOODS_RECEIVED_NOTE_NUM_PARAM VARCHAR(20), IN GOODS_RECEIVED_NOTE_DATE_PARAM DATE, IN GOODS_RECEIVED_NOTE_DESC_PARAM VARCHAR(255), IN GOODS_RECEIVED_NOTE_NUM_OLD_PARAM VARCHAR(20), IN GOODS_RECEIVED_NOTELINE_PARAM VARCHAR(255), IN GOODS_RECEIVED_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT goods_received_note VALUES(GOODS_RECEIVED_NOTE_NUM_PARAM,GOODS_RECEIVED_NOTE_DATE_PARAM,GOODS_RECEIVED_NOTE_DESC_PARAM,CREDITOR_NUM_PARAM);

IF GOODS_RECEIVED_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT goods_received_noteline VALUES ';

goodsreceivednoteline_loop:LOOP
IF REGEXP_INSTR(GOODS_RECEIVED_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',GOODS_RECEIVED_NOTE_NUM_PARAM,'",',SUBSTRING(GOODS_RECEIVED_NOTELINE_PARAM,POS),')') INTO @STRNG;
LEAVE goodsreceivednoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(GOODS_RECEIVED_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',GOODS_RECEIVED_NOTE_NUM_PARAM,'",',SUBSTRING(GOODS_RECEIVED_NOTELINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(GOODS_RECEIVED_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP goodsreceivednoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF GOODS_RECEIVED_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT goods_received_note_stock VALUES ';

goodsreceivednotestock_loop:LOOP
IF REGEXP_INSTR(GOODS_RECEIVED_NOTE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',GOODS_RECEIVED_NOTE_NUM_PARAM,'",',SUBSTRING(GOODS_RECEIVED_NOTE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE goodsreceivednotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(GOODS_RECEIVED_NOTE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',GOODS_RECEIVED_NOTE_NUM_PARAM,'",',SUBSTRING(GOODS_RECEIVED_NOTE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(GOODS_RECEIVED_NOTE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP goodsreceivednotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;



COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_JOURNAL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_JOURNAL`(IN JOURNAL_NUM_PARAM VARCHAR(20), IN JOURNAL_DATE_PARAM DATE,IN JOURNAL_DESC_PARAM VARCHAR(255), IN JOURNAL_NUM_OLD_PARAM VARCHAR(20), IN JOURNALLINE_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT journal VALUES(JOURNAL_NUM_PARAM,JOURNAL_DATE_PARAM,JOURNAL_DESC_PARAM);

IF JOURNALLINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT journalline VALUES ';

invoiceline_loop:LOOP
IF REGEXP_INSTR(JOURNALLINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',JOURNAL_NUM_PARAM,'",',SUBSTRING(JOURNALLINE_PARAM,POS),')') INTO @STRNG;
LEAVE invoiceline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(JOURNALLINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',JOURNAL_NUM_PARAM,'",',SUBSTRING(JOURNALLINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(JOURNALLINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP invoiceline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;



COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_PURCHASE_CREDIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_PURCHASE_CREDIT_NOTE`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN PURCHASE_CREDIT_NOTE_NUM_PARAM VARCHAR(20), IN PURCHASE_CREDIT_NOTE_DATE_PARAM DATE, IN PURCHASE_CREDIT_NOTE_DESC_PARAM VARCHAR(255), IN PURCHASE_CREDIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, IN PURCHASE_CREDIT_NOTE_NUM_OLD_PARAM VARCHAR(20), IN PURCHASE_CREDIT_NOTELINE_PARAM VARCHAR(255), IN OFFSET_ONE_PARAM VARCHAR(255),IN OFFSET_TWO_PARAM VARCHAR(255), IN PURCHASE_CREDIT_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE POS3 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT purchase_credit_note VALUES(PURCHASE_CREDIT_NOTE_NUM_PARAM,PURCHASE_CREDIT_NOTE_DATE_PARAM,PURCHASE_CREDIT_NOTE_DESC_PARAM,PURCHASE_CREDIT_NOTE_CREDIT_TERM_PARAM,CREDITOR_NUM_PARAM,GL_ACC_NUM_PARAM);

IF PURCHASE_CREDIT_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_credit_noteline VALUES ';

purchasecreditnoteline_loop:LOOP
IF REGEXP_INSTR(PURCHASE_CREDIT_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_CREDIT_NOTELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE purchasecreditnoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_CREDIT_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_CREDIT_NOTELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_CREDIT_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP purchasecreditnoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoice_purchase_credit_note VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_note_purchase_credit_note VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF PURCHASE_CREDIT_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_credit_note_stock VALUES ';

purchasecreditnotestock_loop:LOOP
IF REGEXP_INSTR(PURCHASE_CREDIT_NOTE_STOCK_PARAM,'=',POS3)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_CREDIT_NOTE_STOCK_PARAM,POS3),')') INTO @STRNG;
LEAVE purchasecreditnotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_CREDIT_NOTE_STOCK_PARAM,'=',POS3) - POS3) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_CREDIT_NOTE_STOCK_PARAM,POS3,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_CREDIT_NOTE_STOCK_PARAM,'=',POS3)+1) INTO POS3;
END;
END IF;
END LOOP purchasecreditnotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;


COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_PURCHASE_DEBIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_PURCHASE_DEBIT_NOTE`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255),IN PURCHASE_DEBIT_NOTE_NUM_PARAM VARCHAR(50), IN PURCHASE_DEBIT_NOTE_DATE_PARAM DATE, IN PURCHASE_DEBIT_NOTE_DESC_PARAM VARCHAR(255),IN PURCHASE_DEBIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, IN PURCHASE_DEBIT_NOTE_NUM_OLD_PARAM VARCHAR(50), IN PURCHASE_DEBIT_NOTELINE_PARAM VARCHAR(255), IN PURCHASE_DEBIT_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT purchase_debit_note VALUES(PURCHASE_DEBIT_NOTE_NUM_PARAM,PURCHASE_DEBIT_NOTE_DATE_PARAM,PURCHASE_DEBIT_NOTE_DESC_PARAM,PURCHASE_DEBIT_NOTE_CREDIT_TERM,CREDITOR_NUM_PARAM,GL_ACC_NUM_PARAM);

IF PURCHASE_DEBIT_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_noteline VALUES ';

purchasedebitnoteline_loop:LOOP
IF REGEXP_INSTR(PURCHASE_DEBIT_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_DEBIT_NOTELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE purchasedebitnoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_DEBIT_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_DEBIT_NOTELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_DEBIT_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP purchasedebitnoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF PURCHASE_DEBIT_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_note_stock VALUES ';

purchasedebitnotestock_loop:LOOP
IF REGEXP_INSTR(PURCHASE_DEBIT_NOTE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_DEBIT_NOTE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE purchasedebitnotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_DEBIT_NOTE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_DEBIT_NOTE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_DEBIT_NOTE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP purchasedebitnotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_PURCHASE_INVOICE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_PURCHASE_INVOICE`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN PURCHASE_INVOICE_NUM_PARAM VARCHAR(50), IN PURCHASE_INVOICE_DATE_PARAM DATE, IN PURCHASE_INVOICE_DESC_PARAM VARCHAR(255),IN PURCHASE_INVOICE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, IN PURCHASE_INVOICE_NUM_OLD_PARAM VARCHAR(50), IN PURCHASE_INVOICELINE_PARAM VARCHAR(255), IN PURCHASE_INVOICE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT purchase_invoice VALUES(PURCHASE_INVOICE_NUM_PARAM,PURCHASE_INVOICE_DATE_PARAM,PURCHASE_INVOICE_DESC_PARAM,PURCHASE_INVOICE_CREDIT_TERM_PARAM,CREDITOR_NUM_PARAM,GL_ACC_NUM_PARAM);

IF PURCHASE_INVOICELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoiceline VALUES ';

invoiceline_loop:LOOP
IF REGEXP_INSTR(PURCHASE_INVOICELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_INVOICE_NUM_PARAM,'",',SUBSTRING(PURCHASE_INVOICELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE invoiceline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_INVOICELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_INVOICE_NUM_PARAM,'",',SUBSTRING(PURCHASE_INVOICELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_INVOICELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP invoiceline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF PURCHASE_INVOICE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoice_stock VALUES ';

purchaseinvoicestock_loop:LOOP
IF REGEXP_INSTR(PURCHASE_INVOICE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_INVOICE_NUM_PARAM,'",',SUBSTRING(PURCHASE_INVOICE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE purchaseinvoicestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_INVOICE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_INVOICE_NUM_PARAM,'",',SUBSTRING(PURCHASE_INVOICE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_INVOICE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP purchaseinvoicestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_PURCHASE_RETURN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_PURCHASE_RETURN`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN PURCHASE_RETURN_NUM_PARAM VARCHAR(20), IN PURCHASE_RETURN_DATE_PARAM DATE, IN PURCHASE_RETURN_DESC_PARAM VARCHAR(255), IN PURCHASE_RETURN_NUM_OLD_PARAM VARCHAR(20), IN PURCHASE_RETURNLINE_PARAM VARCHAR(255), IN PURCHASE_RETURN_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT purchase_return VALUES(PURCHASE_RETURN_NUM_PARAM,PURCHASE_RETURN_DATE_PARAM,PURCHASE_RETURN_DESC_PARAM,CREDITOR_NUM_PARAM);

IF PURCHASE_RETURNLINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_returnline VALUES ';

purchasereturnline_loop:LOOP
IF REGEXP_INSTR(PURCHASE_RETURNLINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_RETURN_NUM_PARAM,'",',SUBSTRING(PURCHASE_RETURNLINE_PARAM,POS),')') INTO @STRNG;
LEAVE purchasereturnline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_RETURNLINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_RETURN_NUM_PARAM,'",',SUBSTRING(PURCHASE_RETURNLINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_RETURNLINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP purchasereturnline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF PURCHASE_RETURN_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_return_stock VALUES ';

purchasereturnstock_loop:LOOP
IF REGEXP_INSTR(PURCHASE_RETURN_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_RETURN_NUM_PARAM,'",',SUBSTRING(PURCHASE_RETURN_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE purchasereturnstock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_RETURN_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_RETURN_NUM_PARAM,'",',SUBSTRING(PURCHASE_RETURN_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_RETURN_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP purchasereturnstock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_SALES_INVOICE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_SALES_INVOICE`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN SALES_INVOICE_NUM_PARAM VARCHAR(20), IN SALES_INVOICE_DATE_PARAM DATE, IN SALES_INVOICE_DESC_PARAM VARCHAR(255), IN SALES_INVOICE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'),IN GL_ACC_NUM_PARAM INT, IN SALES_INVOICE_NUM_OLD_PARAM VARCHAR(20), IN SALES_INVOICELINE_PARAM VARCHAR(255), IN SALES_INVOICE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

INSERT sales_invoice VALUES(SALES_INVOICE_NUM_PARAM,SALES_INVOICE_DATE_PARAM,SALES_INVOICE_DESC_PARAM,SALES_INVOICE_CREDIT_TERM_PARAM,DEBTOR_NUM_PARAM,GL_ACC_NUM_PARAM);

IF SALES_INVOICELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoiceline VALUES ';

invoiceline_loop:LOOP
IF REGEXP_INSTR(SALES_INVOICELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',SALES_INVOICE_NUM_PARAM,'",',SUBSTRING(SALES_INVOICELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE invoiceline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(SALES_INVOICELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',SALES_INVOICE_NUM_PARAM,'",',SUBSTRING(SALES_INVOICELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(SALES_INVOICELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP invoiceline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF SALES_INVOICE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoice_stock VALUES ';

salesinvoicestock_loop:LOOP
IF REGEXP_INSTR(SALES_INVOICE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',SALES_INVOICE_NUM_PARAM,'",',SUBSTRING(SALES_INVOICE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE salesinvoicestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(SALES_INVOICE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',SALES_INVOICE_NUM_PARAM,'",',SUBSTRING(SALES_INVOICE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(SALES_INVOICE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP salesinvoicestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_STOCK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `INSERT_STOCK`(IN STOCK_NUM_PARAM VARCHAR(20),IN STOCK_DESC_PARAM VARCHAR(255), IN STOCK_PRICE_PARAM DEC(10,2), IN STOCK_MINPRICE_PARAM DEC(10,2), IN STOCK_MAXPRICE_PARAM DEC(10,2),IN STOCK_COST_PARAM DEC(10,2),IN STOCK_MINQTY_PARAM INT,IN STOCK_MAXQTY_PARAM INT,IN STOCK_NUM_OLD_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO stock VALUES(STOCK_NUM_PARAM,STOCK_DESC_PARAM,STOCK_PRICE_PARAM,STOCK_MINPRICE_PARAM,STOCK_MAXPRICE_PARAM,STOCK_COST_PARAM,STOCK_MINQTY_PARAM,STOCK_MAXQTY_PARAM);
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_ACCOUNT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_ACCOUNT`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT GL_CATEGORY,GL_ACC_NUM,GL_DESC,GL_STATUS from gl_category left join gl using (GL_CATEGORY) order by GL_ORDER,GL_ACC_NUM;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_BALANCE_SHEET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_BALANCE_SHEET`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT GL_CATEGORY FROM gl_category WHERE GL_AREA='BALANCE SHEET' ORDER BY GL_ORDER;

SELECT GL_CATEGORY,GL_ACC_NUM,GL_DESC,NAME,DATE,ITEM,NUM,DEBIT,CREDIT FROM gl NATURAL JOIN gl_category NATURAL JOIN (
(SELECT debtor.GL_ACC_NUM,DEBTOR_NAME AS NAME, SALES_INVOICE_DATE AS DATE, 'SALES INVOICE' AS ITEM, SALES_INVOICE_NUM AS NUM,SUM(SALES_INVOICELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM debtor JOIN sales_invoice USING(DEBTOR_NUM) NATURAL JOIN sales_invoiceline GROUP BY SALES_INVOICE_NUM)
UNION ALL(SELECT debtor.GL_ACC_NUM,DEBTOR_NAME AS NAME, DEBIT_NOTE_DATE AS DATE, 'DEBIT NOTE' AS ITEM, DEBIT_NOTE_NUM AS NUM,SUM(DEBIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM debtor JOIN debit_note USING(DEBTOR_NUM) NATURAL JOIN debit_noteline GROUP BY DEBIT_NOTE_NUM)
UNION ALL(SELECT debtor.GL_ACC_NUM,DEBTOR_NAME AS NAME, CREDIT_NOTE_DATE AS DATE, 'CREDIT NOTE' AS ITEM, CREDIT_NOTE_NUM AS NUM,NULL AS DEBIT,SUM(CREDIT_NOTELINE_SUBTOTAL) AS CREDIT FROM debtor JOIN credit_note USING(DEBTOR_NUM) NATURAL JOIN credit_noteline GROUP BY CREDIT_NOTE_NUM)
UNION ALL(SELECT creditor.GL_ACC_NUM,CREDITOR_NAME AS NAME, PURCHASE_INVOICE_DATE AS DATE, 'PURCHASE INVOICE' AS ITEM, PURCHASE_INVOICE_NUM AS NUM,NULL AS DEBIT,SUM(PURCHASE_INVOICELINE_SUBTOTAL) AS CREDIT FROM creditor JOIN purchase_invoice USING(CREDITOR_NUM) NATURAL JOIN purchase_invoiceline GROUP BY PURCHASE_INVOICE_NUM)
UNION ALL(SELECT creditor.GL_ACC_NUM,CREDITOR_NAME AS NAME, PURCHASE_DEBIT_NOTE_DATE AS DATE, 'PURCHASE DEBIT NOTE' AS ITEM, PURCHASE_DEBIT_NOTE_NUM AS NUM,NULL AS DEBIT,SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) AS CREDIT FROM creditor JOIN purchase_debit_note USING(CREDITOR_NUM) NATURAL JOIN purchase_debit_noteline GROUP BY PURCHASE_DEBIT_NOTE_NUM)
UNION ALL(SELECT creditor.GL_ACC_NUM,CREDITOR_NAME AS NAME, PURCHASE_CREDIT_NOTE_DATE AS DATE, 'PURCHASE CREDIT NOTE' AS ITEM, PURCHASE_CREDIT_NOTE_NUM AS NUM,SUM(PURCHASE_CREDIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM creditor JOIN purchase_credit_note USING(CREDITOR_NUM) NATURAL JOIN purchase_credit_noteline GROUP BY PURCHASE_CREDIT_NOTE_NUM)
UNION ALL(SELECT debtor.GL_ACC_NUM, DEBTOR_NAME AS NAME, BANK_RECEIPT_DATE AS DATE, 'BANK RECEIPT' AS ITEM, BANK_RECEIPT_NUM AS NUM, NULL AS DEBIT, BANK_RECEIPT_AMOUNT AS CREDIT FROM debtor JOIN bank_receipt USING (DEBTOR_NUM))
UNION ALL(SELECT creditor.GL_ACC_NUM, CREDITOR_NAME AS NAME, BANK_PAYMENT_DATE AS DATE, 'BANK PAYMENT' AS ITEM, BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM creditor JOIN bank_payment USING (CREDITOR_NUM))
UNION ALL(SELECT debtor.GL_ACC_NUM, DEBTOR_NAME AS NAME, CASH_RECEIPT_DATE AS DATE, 'CASH RECEIPT' AS ITEM, CASH_RECEIPT_NUM AS NUM, NULL AS DEBIT, CASH_RECEIPT_AMOUNT AS CREDIT FROM debtor JOIN cash_receipt USING (DEBTOR_NUM))
UNION ALL(SELECT creditor.GL_ACC_NUM, CREDITOR_NAME AS NAME, CASH_PAYMENT_DATE AS DATE, 'CASH PAYMENT' AS ITEM, CASH_PAYMENT_NUM AS NUM, CASH_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM creditor JOIN cash_payment USING (CREDITOR_NUM))
UNION ALL(SELECT bank.GL_ACC_NUM, BANK_NAME AS NAME, BANK_RECEIPT_DATE AS DATE, 'BANK RECEIPT' AS ITEM, BANK_RECEIPT_NUM AS NUM, BANK_RECEIPT_AMOUNT AS DEBIT, NULL AS CREDIT FROM bank JOIN bank_receipt USING (BANK_NUM))
UNION ALL(SELECT bank.GL_ACC_NUM, BANK_NAME AS NAME, BANK_PAYMENT_DATE AS DATE, 'BANK PAYMENT' AS ITEM, BANK_PAYMENT_NUM AS NUM, NULL AS DEBIT, BANK_PAYMENT_AMOUNT AS CREDIT FROM bank JOIN bank_payment USING (BANK_NUM))
UNION ALL(SELECT GL_ACC_NUM, NULL AS NAME, BANK_RECEIPT_DATE AS DATE, 'BANK RECEIPT' AS ITEM, BANK_RECEIPT_NUM AS NUM, NULL AS DEBIT, BANK_RECEIPT_AMOUNT AS CREDIT FROM bank_receipt)
UNION ALL(SELECT GL_ACC_NUM, NULL AS NAME, BANK_PAYMENT_DATE AS DATE, 'BANK PAYMENT' AS ITEM, BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM bank_payment)
UNION ALL(SELECT GL_ACC_NUM2, NULL AS NAME, CASH_RECEIPT_DATE AS DATE, 'CASH RECEIPT' AS ITEM, CASH_RECEIPT_NUM AS NUM, CASH_RECEIPT_AMOUNT AS DEBIT, NULL AS CREDIT FROM cash_receipt)
UNION ALL(SELECT GL_ACC_NUM2, NULL AS NAME, CASH_PAYMENT_DATE AS DATE, 'CASH PAYMENT' AS ITEM, CASH_PAYMENT_NUM AS NUM, NULL AS DEBIT, CASH_PAYMENT_AMOUNT AS CREDIT FROM cash_payment)
UNION ALL(SELECT GL_ACC_NUM1, NULL AS NAME, CASH_RECEIPT_DATE AS DATE, 'CASH RECEIPT' AS ITEM, CASH_RECEIPT_NUM AS NUM, NULL AS DEBIT, CASH_RECEIPT_AMOUNT AS CREDIT FROM cash_receipt)
UNION ALL(SELECT GL_ACC_NUM1, NULL AS NAME, CASH_PAYMENT_DATE AS DATE, 'CASH PAYMENT' AS ITEM, CASH_PAYMENT_NUM AS NUM, CASH_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM cash_payment)
UNION ALL(SELECT GL_ACC_NUM, NULL AS NAME, JOURNAL_DATE AS DATE, 'JOURNAL' AS ITEM, JOURNAL_NUM AS NUM, JOURNALLINE_DEBIT AS DEBIT, JOURNALLINE_CREDIT AS CREDIT FROM journal NATURAL JOIN journalline)
) T1 WHERE GL_AREA='BALANCE SHEET' ORDER BY GL_ORDER,GL_ACC_NUM,DATE;

SELECT GL_CATEGORY,GL_ACC_NUM,GL_DESC,DATE,ITEM,NUM,DEBIT,CREDIT FROM gl NATURAL JOIN gl_category NATURAL JOIN (
(SELECT GL_ACC_NUM,SALES_INVOICE_DATE AS DATE, 'SALES INVOICE' AS ITEM, SALES_INVOICE_NUM AS NUM,NULL AS DEBIT, SUM(SALES_INVOICELINE_SUBTOTAL) AS CREDIT FROM sales_invoice NATURAL JOIN sales_invoiceline GROUP BY SALES_INVOICE_NUM)
UNION ALL(SELECT GL_ACC_NUM,DEBIT_NOTE_DATE AS DATE, 'DEBIT NOTE' AS ITEM, DEBIT_NOTE_NUM AS NUM,NULL AS DEBIT, SUM(DEBIT_NOTELINE_SUBTOTAL) AS CREDIT FROM debit_note NATURAL JOIN debit_noteline GROUP BY DEBIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM,CREDIT_NOTE_DATE AS DATE, 'CREDIT NOTE' AS ITEM, CREDIT_NOTE_NUM AS NUM,SUM(CREDIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM credit_note NATURAL JOIN credit_noteline GROUP BY CREDIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM,PURCHASE_INVOICE_DATE AS DATE, 'PURCHASE INVOICE' AS ITEM, PURCHASE_INVOICE_NUM AS NUM,SUM(PURCHASE_INVOICELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM purchase_invoice NATURAL JOIN purchase_invoiceline GROUP BY PURCHASE_INVOICE_NUM)
UNION ALL(SELECT GL_ACC_NUM,PURCHASE_DEBIT_NOTE_DATE AS DATE, 'PURCHASE DEBIT NOTE' AS ITEM, PURCHASE_DEBIT_NOTE_NUM AS NUM,SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM purchase_debit_note NATURAL JOIN purchase_debit_noteline GROUP BY PURCHASE_DEBIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM,PURCHASE_CREDIT_NOTE_DATE AS DATE, 'PURCHASE CREDIT NOTE' AS ITEM, PURCHASE_CREDIT_NOTE_NUM AS NUM,NULL AS DEBIT,SUM(PURCHASE_CREDIT_NOTELINE_SUBTOTAL) AS CREDIT FROM purchase_credit_note NATURAL JOIN purchase_credit_noteline GROUP BY PURCHASE_CREDIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM, BANK_RECEIPT_DATE AS DATE, 'BANK RECEIPT' AS ITEM, BANK_RECEIPT_NUM AS NUM, NULL AS DEBIT, BANK_RECEIPT_AMOUNT AS CREDIT FROM bank_receipt)
UNION ALL(SELECT GL_ACC_NUM, BANK_PAYMENT_DATE AS DATE, 'BANK PAYMENT' AS ITEM, BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM bank_payment)
UNION ALL(SELECT GL_ACC_NUM1, CASH_RECEIPT_DATE AS DATE, 'CASH RECEIPT' AS ITEM, CASH_RECEIPT_NUM AS NUM, NULL AS DEBIT, CASH_RECEIPT_AMOUNT AS CREDIT FROM cash_receipt)
UNION ALL(SELECT GL_ACC_NUM1, CASH_PAYMENT_DATE AS DATE, 'CASH PAYMENT' AS ITEM, CASH_PAYMENT_NUM AS NUM, CASH_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM cash_payment)
UNION ALL(SELECT GL_ACC_NUM, JOURNAL_DATE AS DATE, 'JOURNAL' AS ITEM, JOURNAL_NUM AS NUM, JOURNALLINE_DEBIT AS DEBIT, JOURNALLINE_CREDIT AS CREDIT FROM journal NATURAL JOIN journalline)
) T1 WHERE GL_AREA='PROFIT AND LOSS' ORDER BY GL_ORDER,GL_ACC_NUM,DATE;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_BANK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_BANK`(IN BANK_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT *,BANK_NUM AS BANK_NUM_OLD FROM bank WHERE BANK_NUM=BANK_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_BANKLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_BANKLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT BANK_NUM AS NUM, BANK_NAME AS NAME,BANK_ADDRESS AS ADDRESS, BANK_POSTCODE AS POSTCODE FROM bank ORDER BY BANK_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_BANK_PAYMENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_BANK_PAYMENT`(IN BANK_PAYMENT_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT *,BANK_PAYMENT_NUM AS BANK_PAYMENT_NUM_OLD FROM bank_payment WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_PARAM;

SELECT PURCHASE_INVOICE_NUM,PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT FROM purchase_invoice_bank_payment WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_PARAM;

SELECT PURCHASE_DEBIT_NOTE_NUM,PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT FROM purchase_debit_note_bank_payment WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_PARAM;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_BANK_PAYMENTLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_BANK_PAYMENTLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_TRANSACTION_ID AS 'TRANSACTION ID', BANK_PAYMENT_DATE AS DATE, BANK_PAYMENT_METHOD AS METHOD, BANK_PAYMENT_DESC AS DESCRIPTION, BANK_PAYMENT_AMOUNT AS AMOUNT FROM bank_payment LEFT JOIN bank USING (BANK_NUM) ORDER BY BANK_PAYMENT_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_BANK_RECEIPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_BANK_RECEIPT`(IN BANK_RECEIPT_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT *,BANK_RECEIPT_NUM AS BANK_RECEIPT_NUM_OLD FROM bank_receipt WHERE BANK_RECEIPT_NUM=BANK_RECEIPT_NUM_PARAM;

SELECT SALES_INVOICE_NUM,SALES_INVOICE_BANK_RECEIPT_AMOUNT FROM sales_invoice_bank_receipt WHERE BANK_RECEIPT_NUM=BANK_RECEIPT_NUM_PARAM;

SELECT DEBIT_NOTE_NUM,DEBIT_NOTE_BANK_RECEIPT_AMOUNT FROM debit_note_bank_receipt WHERE BANK_RECEIPT_NUM=BANK_RECEIPT_NUM_PARAM;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_BANK_RECEIPTLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_BANK_RECEIPTLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT BANK_RECEIPT_NUM AS NUM, BANK_RECEIPT_TRANSACTION_ID AS 'TRANSACTION ID', BANK_RECEIPT_DATE AS DATE, BANK_RECEIPT_METHOD AS METHOD, BANK_RECEIPT_DESC AS DESCRIPTION, BANK_RECEIPT_AMOUNT AS AMOUNT FROM bank_receipt LEFT JOIN bank USING (BANK_NUM) ORDER BY BANK_RECEIPT_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_CASH_PAYMENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_CASH_PAYMENT`(IN CASH_PAYMENT_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT *,CASH_PAYMENT_NUM AS CASH_PAYMENT_NUM_OLD FROM cash_payment WHERE CASH_PAYMENT_NUM=CASH_PAYMENT_NUM_PARAM;

SELECT PURCHASE_INVOICE_NUM,PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT FROM purchase_invoice_cash_payment WHERE CASH_PAYMENT_NUM=CASH_PAYMENT_NUM_PARAM;

SELECT PURCHASE_DEBIT_NOTE_NUM,PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT FROM purchase_debit_note_cash_payment WHERE CASH_PAYMENT_NUM=CASH_PAYMENT_NUM_PARAM;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_CASH_PAYMENTLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_CASH_PAYMENTLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CASH_PAYMENT_NUM AS NUM, CASH_PAYMENT_TRANSACTION_ID AS 'TRANSACTION ID', CASH_PAYMENT_DATE AS DATE, CASH_PAYMENT_METHOD AS METHOD, CASH_PAYMENT_DESC AS DESCRIPTION, CASH_PAYMENT_AMOUNT AS AMOUNT FROM cash_payment ORDER BY CASH_PAYMENT_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_CASH_RECEIPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_CASH_RECEIPT`(IN CASH_RECEIPT_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT *,CASH_RECEIPT_NUM AS CASH_RECEIPT_NUM_OLD FROM cash_receipt WHERE CASH_RECEIPT_NUM=CASH_RECEIPT_NUM_PARAM;

SELECT SALES_INVOICE_NUM,SALES_INVOICE_CASH_RECEIPT_AMOUNT FROM sales_invoice_cash_receipt WHERE CASH_RECEIPT_NUM=CASH_RECEIPT_NUM_PARAM;

SELECT DEBIT_NOTE_NUM,DEBIT_NOTE_CASH_RECEIPT_AMOUNT FROM debit_note_cash_receipt WHERE CASH_RECEIPT_NUM=CASH_RECEIPT_NUM_PARAM;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_CASH_RECEIPTLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_CASH_RECEIPTLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CASH_RECEIPT_NUM AS NUM, CASH_RECEIPT_TRANSACTION_ID AS 'TRANSACTION ID', CASH_RECEIPT_DATE AS DATE, CASH_RECEIPT_METHOD AS METHOD, CASH_RECEIPT_DESC AS DESCRIPTION, CASH_RECEIPT_AMOUNT AS AMOUNT FROM cash_receipt ORDER BY CASH_RECEIPT_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_CREDITOR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_CREDITOR`(IN CREDITOR_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT *,CREDITOR_NUM AS CREDITOR_NUM_OLD FROM creditor WHERE CREDITOR_NUM=CREDITOR_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_CREDITORLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_CREDITORLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDITOR_NUM AS NUM, CREDITOR_NAME AS NAME,CREDITOR_ADDRESS AS ADDRESS, CREDITOR_POSTCODE AS POSTCODE,CREDITOR_PHONE AS PHONE,CREDITOR_FAX AS FAX,CREDITOR_OTHER_DESC AS 'OTHER DESCRIPTION',CREDITOR_CREDIT_TERM AS 'CREDIT_TERM' FROM creditor ORDER BY CREDITOR_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_CREDITOR_OUTSTANDING` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_CREDITOR_OUTSTANDING`(IN CREDITOR_NUM_PARAM VARCHAR(20),IN DOC_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT PURCHASE_INVOICE_NUM AS NUM,  (SELECT CREDITOR_NAME FROM creditor WHERE creditor.CREDITOR_NUM=t1.CREDITOR_NUM) AS NAME,
'PURCHASE INVOICE' AS TYPE, PURCHASE_INVOICE_DATE AS DATE, SUM(PURCHASE_INVOICELINE_SUBTOTAL) AS ORIGINAL_AMOUNT,
ROUND((SELECT SUM(PURCHASE_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT) FROM purchase_invoice_cash_payment WHERE PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT FROM purchase_invoice_cash_payment WHERE CASH_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT) FROM purchase_invoice_bank_payment WHERE PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT FROM purchase_invoice_bank_payment WHERE BANK_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
),2) AS OUTSTANDING 
from purchase_invoice as t1 LEFT JOIN purchase_invoiceline USING (PURCHASE_INVOICE_NUM) WHERE  t1.CREDITOR_NUM=CREDITOR_NUM_PARAM AND 
(SELECT SUM(PURCHASE_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT) FROM purchase_invoice_cash_payment WHERE PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT FROM purchase_invoice_cash_payment WHERE CASH_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT) FROM purchase_invoice_bank_payment WHERE PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT FROM purchase_invoice_bank_payment WHERE BANK_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
from purchase_invoice as t2 LEFT JOIN purchase_invoiceline USING (PURCHASE_INVOICE_NUM) WHERE t2.PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM)>0
GROUP BY PURCHASE_INVOICE_NUM UNION ALL 
(SELECT PURCHASE_DEBIT_NOTE_NUM, (SELECT CREDITOR_NAME FROM creditor WHERE creditor.CREDITOR_NUM=t3.CREDITOR_NUM) AS NAME,
'PURCHASE DEBIT NOTE' AS TYPE,PURCHASE_DEBIT_NOTE_DATE, SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) AS ORIGINAL_AMOUNT,
ROUND((SELECT SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT) FROM purchase_debit_note_cash_payment WHERE PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT FROM purchase_debit_note_cash_payment WHERE CASH_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT) FROM purchase_debit_note_bank_payment WHERE PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT FROM purchase_debit_note_bank_payment WHERE BANK_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
),2) AS OUTSTANDING
from purchase_debit_note as t3 LEFT JOIN purchase_debit_noteline using (PURCHASE_DEBIT_NOTE_NUM) WHERE t3.CREDITOR_NUM=CREDITOR_NUM_PARAM AND 
(SELECT SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT) FROM purchase_debit_note_cash_payment WHERE PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT FROM purchase_debit_note_cash_payment WHERE CASH_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT) FROM purchase_debit_note_bank_payment WHERE PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT FROM purchase_debit_note_bank_payment WHERE BANK_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
from purchase_debit_note as t4 LEFT JOIN purchase_debit_noteline using (PURCHASE_DEBIT_NOTE_NUM) WHERE t4.PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM)>0 
GROUP BY PURCHASE_DEBIT_NOTE_NUM) ORDER BY DATE;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_CREDIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_CREDIT_NOTE`(IN CREDIT_NOTE_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBTOR_NUM, DEBTOR_NAME, DEBTOR_ADDRESS, CREDIT_NOTE_NUM,CREDIT_NOTE_DATE,CREDIT_NOTE_DESC,CREDIT_NOTE_CREDIT_TERM, credit_note.GL_ACC_NUM, CREDIT_NOTE_NUM AS CREDIT_NOTE_NUM_OLD FROM debtor JOIN credit_note USING (DEBTOR_NUM) WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;
SELECT CREDIT_NOTELINE_LINENUMBER,CREDIT_NOTELINE_STOCK_NUM,CREDIT_NOTELINE_STOCK_DESC,CREDIT_NOTELINE_STOCK_PRICE,CREDIT_NOTELINE_STOCK_QTY,CREDIT_NOTELINE_DISCOUNT FROM credit_noteline WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;

SELECT SALES_INVOICE_NUM,SALES_INVOICE_CREDIT_NOTE_AMOUNT FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;

SELECT DEBIT_NOTE_NUM,DEBIT_NOTE_CREDIT_NOTE_AMOUNT FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;

SELECT CREDIT_NOTELINE_LINENUMBER,STOCK_NUM,CREDIT_NOTE_STOCK_QTY FROM credit_note_stock WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_CREDIT_NOTELIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_CREDIT_NOTELIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDIT_NOTE_NUM AS NUM,DEBTOR_NAME,CREDIT_NOTE_DATE AS DATE,CREDIT_NOTE_DESC AS DESCRIPTION, SUM(CREDIT_NOTELINE_SUBTOTAL) AS SUBTOTAL FROM debtor JOIN credit_note USING(DEBTOR_NUM) LEFT JOIN credit_noteline USING (CREDIT_NOTE_NUM) GROUP BY CREDIT_NOTE_NUM ORDER BY CREDIT_NOTE_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DEBIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DEBIT_NOTE`(IN DEBIT_NOTE_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBTOR_NUM, DEBTOR_NAME, DEBTOR_ADDRESS, DEBIT_NOTE_NUM,DEBIT_NOTE_DATE,DEBIT_NOTE_DESC,DEBIT_NOTE_CREDIT_TERM, debit_note.GL_ACC_NUM, DEBIT_NOTE_NUM AS DEBIT_NOTE_NUM_OLD FROM debtor JOIN debit_note USING (DEBTOR_NUM) WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_PARAM;
SELECT DEBIT_NOTELINE_LINENUMBER,DEBIT_NOTELINE_STOCK_NUM,DEBIT_NOTELINE_STOCK_DESC,DEBIT_NOTELINE_STOCK_PRICE,DEBIT_NOTELINE_STOCK_QTY,DEBIT_NOTELINE_DISCOUNT FROM debit_noteline WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_PARAM;
SELECT DEBIT_NOTELINE_LINENUMBER,STOCK_NUM,DEBIT_NOTE_STOCK_QTY FROM debit_note_stock WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DEBIT_NOTELIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DEBIT_NOTELIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBIT_NOTE_NUM AS NUM,DEBTOR_NAME,DEBIT_NOTE_DATE AS DATE,DEBIT_NOTE_DESC AS DESCRIPTION, SUM(DEBIT_NOTELINE_SUBTOTAL) AS SUBTOTAL,
(SELECT SUM(DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(DEBIT_NOTE_BANK_RECEIPT_AMOUNT) FROM debit_note_bank_receipt WHERE debit_note_bank_receipt.DEBIT_NOTE_NUM=debit_note.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_CASH_RECEIPT_AMOUNT) FROM debit_note_cash_receipt WHERE debit_note_cash_receipt.DEBIT_NOTE_NUM=debit_note.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_CREDIT_NOTE_AMOUNT) FROM debit_note_credit_note WHERE debit_note_credit_note.DEBIT_NOTE_NUM=debit_note.DEBIT_NOTE_NUM),0)) AS OUTSTANDING 
FROM debtor JOIN debit_note USING(DEBTOR_NUM) LEFT JOIN debit_noteline USING (DEBIT_NOTE_NUM) GROUP BY DEBIT_NOTE_NUM ORDER BY DEBIT_NOTE_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DEBIT_NOTE_RECEIPT_HISTORY` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DEBIT_NOTE_RECEIPT_HISTORY`(IN DEBIT_NOTE_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT BANK_RECEIPT_NUM AS NUM, BANK_RECEIPT_DATE AS DATE,'BANK RECEIPT' AS TYPE, BANK_RECEIPT_TRANSACTION_ID AS DESCRIPTION, DEBIT_NOTE_BANK_RECEIPT_AMOUNT AS AMOUNT FROM bank_receipt NATURAL JOIN debit_note_bank_receipt WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_PARAM 
UNION ALL (SELECT CASH_RECEIPT_NUM, CASH_RECEIPT_DATE,'CASH RECEIPT', CASH_RECEIPT_TRANSACTION_ID, DEBIT_NOTE_CASH_RECEIPT_AMOUNT FROM cash_receipt NATURAL JOIN debit_note_cash_receipt WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_PARAM)
UNION ALL (SELECT CREDIT_NOTE_NUM, CREDIT_NOTE_DATE,'CREDIT NOTE', CREDIT_NOTE_DESC, DEBIT_NOTE_CREDIT_NOTE_AMOUNT FROM credit_note NATURAL JOIN debit_note_credit_note WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_PARAM);

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DEBTOR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DEBTOR`(IN DEBTOR_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT *,DEBTOR_NUM AS DEBTOR_NUM_OLD FROM debtor WHERE DEBTOR_NUM=DEBTOR_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DEBTORLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DEBTORLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBTOR_NUM AS NUM, DEBTOR_NAME AS NAME,DEBTOR_ADDRESS AS ADDRESS, DEBTOR_POSTCODE AS POSTCODE,DEBTOR_PHONE AS PHONE,DEBTOR_FAX AS FAX,DEBTOR_OTHER_DESC AS 'OTHER DESCRIPTION',DEBTOR_CREDIT_TERM AS 'CREDIT_TERM' FROM debtor ORDER BY DEBTOR_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DEBTOR_AGING` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DEBTOR_AGING`(IN DEBTOR_NUM_PARAM VARCHAR(255),IN CURRDATE_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG='';

SELECT CONCAT("SELECT DEBTOR_NUM AS 'DEBTOR_NUM',DEBTOR_NAME AS NAME,SALES_INVOICE_NUM AS NUM, SALES_INVOICE_DATE AS DATE,
'SALES INVOICE' AS ITEM,
ROUND((SELECT SUM(SALES_INVOICELINE_SUBTOTAL) 
-IFNULL((SELECT SUM(SALES_INVOICE_CASH_RECEIPT_AMOUNT) FROM sales_invoice_cash_receipt WHERE SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_BANK_RECEIPT_AMOUNT) FROM sales_invoice_bank_receipt WHERE SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_CREDIT_NOTE_AMOUNT) FROM sales_invoice_credit_note WHERE SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
),2)as AMOUNT,SALES_INVOICE_CREDIT_TERM AS 'CREDIT_TERM'
FROM debtor JOIN sales_invoice USING (DEBTOR_NUM) NATURAL JOIN sales_invoiceline as t1 WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,
") AND SALES_INVOICE_DATE<=",CURRDATE_PARAM," AND
(SELECT SUM(SALES_INVOICELINE_SUBTOTAL) 
-IFNULL((SELECT SUM(SALES_INVOICE_CASH_RECEIPT_AMOUNT) FROM sales_invoice_cash_receipt WHERE SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_BANK_RECEIPT_AMOUNT) FROM sales_invoice_bank_receipt WHERE SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_CREDIT_NOTE_AMOUNT) FROM sales_invoice_credit_note WHERE SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
FROM debtor JOIN sales_invoice USING (DEBTOR_NUM) NATURAL JOIN sales_invoiceline as t2 WHERE t2.SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM)>0
GROUP BY SALES_INVOICE_NUM 
UNION ALL 
(SELECT DEBTOR_NUM,DEBTOR_NAME,DEBIT_NOTE_NUM, DEBIT_NOTE_DATE,
'DEBIT NOTE',
ROUND((SELECT SUM(DEBIT_NOTELINE_SUBTOTAL) 
-IFNULL((SELECT SUM(DEBIT_NOTE_CASH_RECEIPT_AMOUNT) FROM debit_note_cash_receipt WHERE DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_BANK_RECEIPT_AMOUNT) FROM debit_note_bank_receipt WHERE DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_CREDIT_NOTE_AMOUNT) FROM debit_note_credit_note WHERE DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
),2)as AMOUNT, DEBIT_NOTE_CREDIT_TERM AS 'CREDIT_TERM'
FROM debtor JOIN debit_note USING (DEBTOR_NUM) NATURAL JOIN debit_noteline as t3 WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,
") AND DEBIT_NOTE_DATE<=",CURRDATE_PARAM," AND
(SELECT SUM(DEBIT_NOTELINE_SUBTOTAL) 
-IFNULL((SELECT SUM(DEBIT_NOTE_CASH_RECEIPT_AMOUNT) FROM debit_note_cash_receipt WHERE DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_BANK_RECEIPT_AMOUNT) FROM debit_note_bank_receipt WHERE DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_CREDIT_NOTE_AMOUNT) FROM debit_note_credit_note WHERE DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
FROM debtor JOIN debit_note USING (DEBTOR_NUM) NATURAL JOIN debit_noteline as t4 WHERE t4.DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM)>0
GROUP BY DEBIT_NOTE_NUM)
UNION ALL
(SELECT DEBTOR_NUM,DEBTOR_NAME,CREDIT_NOTE_NUM, CREDIT_NOTE_DATE,'CREDIT NOTE',
ROUND((SELECT -SUM(CREDIT_NOTELINE_SUBTOTAL) 
+IFNULL((SELECT SUM(SALES_INVOICE_CREDIT_NOTE_AMOUNT) FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=t5.CREDIT_NOTE_NUM),0)
+IFNULL((SELECT SUM(DEBIT_NOTE_CREDIT_NOTE_AMOUNT) FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=t5.CREDIT_NOTE_NUM),0)
),2),CREDIT_NOTE_CREDIT_TERM AS 'CREDIT_TERM'
FROM debtor JOIN credit_note USING (DEBTOR_NUM) NATURAL JOIN credit_noteline as t5 WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,
") AND CREDIT_NOTE_DATE<=",CURRDATE_PARAM," AND
(SELECT -SUM(CREDIT_NOTELINE_SUBTOTAL) 
+IFNULL((SELECT SUM(SALES_INVOICE_CREDIT_NOTE_AMOUNT) FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=t6.CREDIT_NOTE_NUM),0)
+IFNULL((SELECT SUM(DEBIT_NOTE_CREDIT_NOTE_AMOUNT) FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=t6.CREDIT_NOTE_NUM),0)
FROM debtor JOIN credit_note USING (DEBTOR_NUM) NATURAL JOIN credit_noteline as t6 WHERE t6.CREDIT_NOTE_NUM=t5.CREDIT_NOTE_NUM)<0
GROUP BY CREDIT_NOTE_NUM)
UNION ALL
(SELECT DEBTOR_NUM,DEBTOR_NAME,BANK_RECEIPT_NUM, BANK_RECEIPT_DATE,'BANK RECEIPT',
ROUND((SELECT -BANK_RECEIPT_AMOUNT 
+IFNULL((SELECT SUM(SALES_INVOICE_BANK_RECEIPT_AMOUNT) FROM sales_invoice_bank_receipt WHERE BANK_RECEIPT_NUM=t7.BANK_RECEIPT_NUM),0)
+IFNULL((SELECT SUM(DEBIT_NOTE_BANK_RECEIPT_AMOUNT) FROM debit_note_bank_receipt WHERE BANK_RECEIPT_NUM=t7.BANK_RECEIPT_NUM),0)
),2),NULL
FROM (debtor JOIN bank_receipt as t7 USING (DEBTOR_NUM)) WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,
") AND BANK_RECEIPT_DATE<=",CURRDATE_PARAM," AND
(SELECT - BANK_RECEIPT_AMOUNT 
+IFNULL((SELECT SUM(SALES_INVOICE_BANK_RECEIPT_AMOUNT) FROM sales_invoice_bank_receipt WHERE BANK_RECEIPT_NUM=t8.BANK_RECEIPT_NUM),0)
+IFNULL((SELECT SUM(DEBIT_NOTE_BANK_RECEIPT_AMOUNT) FROM debit_note_bank_receipt WHERE BANK_RECEIPT_NUM=t8.BANK_RECEIPT_NUM),0)
FROM debtor JOIN bank_receipt as t8 USING (DEBTOR_NUM) WHERE t8.BANK_RECEIPT_NUM=t7.BANK_RECEIPT_NUM)<0
GROUP BY BANK_RECEIPT_NUM)
UNION ALL
(SELECT DEBTOR_NUM,DEBTOR_NAME,CASH_RECEIPT_NUM, CASH_RECEIPT_DATE,'CASH RECEIPT',
ROUND((SELECT -CASH_RECEIPT_AMOUNT 
+IFNULL((SELECT SUM(SALES_INVOICE_CASH_RECEIPT_AMOUNT) FROM sales_invoice_cash_receipt WHERE CASH_RECEIPT_NUM=t9.CASH_RECEIPT_NUM),0)
+IFNULL((SELECT SUM(DEBIT_NOTE_CASH_RECEIPT_AMOUNT) FROM debit_note_cash_receipt WHERE CASH_RECEIPT_NUM=t9.CASH_RECEIPT_NUM),0)
),2),NULL
FROM (debtor JOIN cash_receipt as t9 USING (DEBTOR_NUM)) WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,
") AND CASH_RECEIPT_DATE<=",CURRDATE_PARAM," AND
(SELECT - CASH_RECEIPT_AMOUNT 
+IFNULL((SELECT SUM(SALES_INVOICE_CASH_RECEIPT_AMOUNT) FROM sales_invoice_cash_receipt WHERE CASH_RECEIPT_NUM=t10.CASH_RECEIPT_NUM),0)
+IFNULL((SELECT SUM(DEBIT_NOTE_CASH_RECEIPT_AMOUNT) FROM debit_note_cash_receipt WHERE CASH_RECEIPT_NUM=t10.CASH_RECEIPT_NUM),0)
FROM debtor JOIN cash_receipt as t10 USING (DEBTOR_NUM) WHERE t10.CASH_RECEIPT_NUM=t9.CASH_RECEIPT_NUM)<0
GROUP BY CASH_RECEIPT_NUM)
ORDER BY DEBTOR_NUM,DATE") INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DEBTOR_COLLECTION` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DEBTOR_COLLECTION`(IN DATE_START_PARAM VARCHAR(255), IN DATE_END_PARAM VARCHAR(255), IN DEBTOR_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG='';

SELECT CONCAT("SELECT DEBTOR_NUM,DEBTOR_NAME,BANK_RECEIPT_NUM AS NUM,BANK_RECEIPT_DATE AS DATE,'BANK RECEIPT' AS TYPE,BANK_RECEIPT_METHOD AS METHOD,BANK_RECEIPT_TRANSACTION_ID AS 'TRANSACTION ID', BANK_RECEIPT_AMOUNT AS AMOUNT FROM bank_receipt JOIN debtor USING (DEBTOR_NUM) WHERE BANK_RECEIPT_DATE>=",DATE_START_PARAM," AND BANK_RECEIPT_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,")
UNION ALL (SELECT DEBTOR_NUM,DEBTOR_NAME,CASH_RECEIPT_NUM,CASH_RECEIPT_DATE,'CASH RECEIPT',CASH_RECEIPT_METHOD,CASH_RECEIPT_TRANSACTION_ID, CASH_RECEIPT_AMOUNT AS AMOUNT FROM cash_receipt JOIN debtor USING (DEBTOR_NUM) WHERE CASH_RECEIPT_DATE>=",DATE_START_PARAM," AND CASH_RECEIPT_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,")) ORDER BY DEBTOR_NUM,DATE") INTO @STRNG; 

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG='';

SELECT CONCAT("SELECT BANK_RECEIPT_NUM AS 'RECEIPT DOC NUM',SALES_INVOICE_NUM AS 'DOC NUM','SALES INVOICE' AS 'DOC TYPE', SALES_INVOICE_DATE AS 'DOC DATE', SALES_INVOICE_CREDIT_TERM AS 'CREDIT TERM', SUM(SALES_INVOICELINE_SUBTOTAL) AS 'DOC AMOUNT',SALES_INVOICE_BANK_RECEIPT_AMOUNT AS 'RECEIPT AMOUNT' FROM sales_invoice_bank_receipt NATURAL JOIN sales_invoice NATURAL JOIN sales_invoiceline WHERE SALES_INVOICE_DATE>=",DATE_START_PARAM," AND SALES_INVOICE_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") GROUP BY BANK_RECEIPT_NUM,SALES_INVOICE_NUM
UNION ALL (SELECT CASH_RECEIPT_NUM,SALES_INVOICE_NUM,'SALES INVOICE', SALES_INVOICE_DATE, SALES_INVOICE_CREDIT_TERM, SUM(SALES_INVOICELINE_SUBTOTAL),SALES_INVOICE_CASH_RECEIPT_AMOUNT FROM sales_invoice_cash_receipt NATURAL JOIN sales_invoice NATURAL JOIN sales_invoiceline WHERE SALES_INVOICE_DATE>=",DATE_START_PARAM," AND SALES_INVOICE_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") GROUP BY CASH_RECEIPT_NUM,SALES_INVOICE_NUM)
UNION ALL (SELECT BANK_RECEIPT_NUM,DEBIT_NOTE_NUM,'DEBIT NOTE', DEBIT_NOTE_DATE, DEBIT_NOTE_CREDIT_TERM, SUM(DEBIT_NOTELINE_SUBTOTAL),DEBIT_NOTE_BANK_RECEIPT_AMOUNT FROM debit_note_bank_receipt NATURAL JOIN debit_note NATURAL JOIN debit_noteline WHERE DEBIT_NOTE_DATE>=",DATE_START_PARAM," AND DEBIT_NOTE_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") GROUP BY BANK_RECEIPT_NUM,DEBIT_NOTE_NUM)
UNION ALL (SELECT CASH_RECEIPT_NUM,DEBIT_NOTE_NUM,'DEBIT NOTE', DEBIT_NOTE_DATE, DEBIT_NOTE_CREDIT_TERM, SUM(DEBIT_NOTELINE_SUBTOTAL),DEBIT_NOTE_CASH_RECEIPT_AMOUNT FROM debit_note_cash_receipt NATURAL JOIN debit_note NATURAL JOIN debit_noteline WHERE DEBIT_NOTE_DATE>=",DATE_START_PARAM," AND DEBIT_NOTE_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") GROUP BY CASH_RECEIPT_NUM,DEBIT_NOTE_NUM) ORDER BY 'RECEIPT DOC NUM','DOC DATE'")INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DEBTOR_OUTSTANDING` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DEBTOR_OUTSTANDING`(IN DEBTOR_NUM_PARAM VARCHAR(20),IN DOC_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT SALES_INVOICE_NUM AS NUM,  (SELECT DEBTOR_NAME FROM debtor WHERE debtor.DEBTOR_NUM=t1.DEBTOR_NUM) AS NAME,
'INVOICE' AS TYPE, SALES_INVOICE_DATE AS DATE, SUM(SALES_INVOICELINE_SUBTOTAL) AS ORIGINAL_AMOUNT,
ROUND((SELECT SUM(SALES_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(SALES_INVOICE_CASH_RECEIPT_AMOUNT) FROM sales_invoice_cash_receipt WHERE SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_CASH_RECEIPT_AMOUNT FROM sales_invoice_cash_receipt WHERE CASH_RECEIPT_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_BANK_RECEIPT_AMOUNT) FROM sales_invoice_bank_receipt WHERE SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_BANK_RECEIPT_AMOUNT FROM sales_invoice_bank_receipt WHERE BANK_RECEIPT_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_CREDIT_NOTE_AMOUNT) FROM sales_invoice_credit_note WHERE SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_CREDIT_NOTE_AMOUNT FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
),2) AS OUTSTANDING 
from sales_invoice as t1 LEFT JOIN sales_invoiceline USING (SALES_INVOICE_NUM) WHERE  t1.DEBTOR_NUM=DEBTOR_NUM_PARAM AND 
(SELECT SUM(SALES_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(SALES_INVOICE_CASH_RECEIPT_AMOUNT) FROM sales_invoice_cash_receipt WHERE SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_CASH_RECEIPT_AMOUNT FROM sales_invoice_cash_receipt WHERE CASH_RECEIPT_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_BANK_RECEIPT_AMOUNT) FROM sales_invoice_bank_receipt WHERE SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_BANK_RECEIPT_AMOUNT FROM sales_invoice_bank_receipt WHERE BANK_RECEIPT_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_CREDIT_NOTE_AMOUNT) FROM sales_invoice_credit_note WHERE SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_CREDIT_NOTE_AMOUNT FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
from sales_invoice as t2 LEFT JOIN sales_invoiceline USING (SALES_INVOICE_NUM) WHERE t2.SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM)>0
GROUP BY SALES_INVOICE_NUM UNION ALL 
(SELECT DEBIT_NOTE_NUM, (SELECT DEBTOR_NAME FROM debtor WHERE debtor.DEBTOR_NUM=t3.DEBTOR_NUM) AS NAME,
'DEBIT NOTE' AS TYPE,DEBIT_NOTE_DATE, SUM(DEBIT_NOTELINE_SUBTOTAL) AS ORIGINAL_AMOUNT,
ROUND((SELECT SUM(DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(DEBIT_NOTE_CASH_RECEIPT_AMOUNT) FROM debit_note_cash_receipt WHERE DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_CASH_RECEIPT_AMOUNT FROM debit_note_cash_receipt WHERE CASH_RECEIPT_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_BANK_RECEIPT_AMOUNT) FROM debit_note_bank_receipt WHERE DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_BANK_RECEIPT_AMOUNT FROM debit_note_bank_receipt WHERE BANK_RECEIPT_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_CREDIT_NOTE_AMOUNT) FROM debit_note_credit_note WHERE DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_CREDIT_NOTE_AMOUNT FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
),2) AS OUTSTANDING
from debit_note as t3 LEFT JOIN debit_noteline using (DEBIT_NOTE_NUM) WHERE t3.DEBTOR_NUM=DEBTOR_NUM_PARAM AND 
(SELECT SUM(DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(DEBIT_NOTE_CASH_RECEIPT_AMOUNT) FROM debit_note_cash_receipt WHERE DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_CASH_RECEIPT_AMOUNT FROM debit_note_cash_receipt WHERE CASH_RECEIPT_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_BANK_RECEIPT_AMOUNT) FROM debit_note_bank_receipt WHERE DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_BANK_RECEIPT_AMOUNT FROM debit_note_bank_receipt WHERE BANK_RECEIPT_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_CREDIT_NOTE_AMOUNT) FROM debit_note_credit_note WHERE DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_CREDIT_NOTE_AMOUNT FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
from debit_note as t4 LEFT JOIN debit_noteline using (DEBIT_NOTE_NUM) WHERE t4.DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM)>0 
GROUP BY DEBIT_NOTE_NUM) ORDER BY DATE;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DEBTOR_STATEMENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DEBTOR_STATEMENT`(IN DATE_START_PARAM DATE, IN DATE_END_PARAM DATE, IN DEBTOR_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT IFNULL((SELECT SUM(SALES_INVOICELINE_SUBTOTAL) FROM debtor JOIN sales_invoice USING (DEBTOR_NUM) NATURAL JOIN sales_invoiceline WHERE SALES_INVOICE_DATE<DATE_START_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM),0)
+IFNULL((SELECT SUM(DEBIT_NOTELINE_SUBTOTAL) FROM debtor JOIN debit_note USING (DEBTOR_NUM) NATURAL JOIN debit_noteline WHERE DEBIT_NOTE_DATE<DATE_START_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM),0)
-IFNULL((SELECT SUM(CASH_RECEIPT_AMOUNT) FROM cash_receipt JOIN debtor USING(DEBTOR_NUM) WHERE CASH_RECEIPT_DATE<DATE_START_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM),0)
-IFNULL((SELECT SUM(BANK_RECEIPT_AMOUNT) FROM bank_receipt JOIN debtor USING(DEBTOR_NUM) WHERE BANK_RECEIPT_DATE<DATE_START_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM),0)
-IFNULL((SELECT SUM(CREDIT_NOTELINE_SUBTOTAL) FROM debtor join credit_note USING (DEBTOR_NUM) NATURAL JOIN credit_noteline WHERE CREDIT_NOTE_DATE<DATE_START_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM),0)
AS 'B/F';

SELECT SALES_INVOICE_DATE AS DATE, SALES_INVOICE_NUM AS NUM, NULL AS REF, 'SALES INVOICE' AS TYPE, SUM(SALES_INVOICELINE_SUBTOTAL) AS DR, NULL AS CR FROM debtor JOIN sales_invoice USING (DEBTOR_NUM) NATURAL JOIN sales_invoiceline WHERE SALES_INVOICE_DATE>=DATE_START_PARAM AND SALES_INVOICE_DATE<=DATE_END_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM GROUP BY SALES_INVOICE_NUM 
UNION ALL (SELECT DEBIT_NOTE_DATE, DEBIT_NOTE_NUM, NULL,'DEBIT NOTE', SUM(DEBIT_NOTELINE_SUBTOTAL), NULL FROM debtor JOIN debit_note USING (DEBTOR_NUM) NATURAL JOIN debit_noteline WHERE DEBIT_NOTE_DATE>=DATE_START_PARAM AND DEBIT_NOTE_DATE<=DATE_END_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM GROUP BY DEBIT_NOTE_NUM) 
UNION ALL (SELECT CASH_RECEIPT_DATE AS DATE, CASH_RECEIPT_NUM, CASH_RECEIPT_TRANSACTION_ID, 'CASH RECEIPT', NULL, CASH_RECEIPT_AMOUNT from debtor JOIN cash_receipt USING (DEBTOR_NUM) WHERE CASH_RECEIPT_DATE>=DATE_START_PARAM AND CASH_RECEIPT_DATE<=DATE_END_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM) 
UNION ALL (SELECT BANK_RECEIPT_DATE AS DATE, BANK_RECEIPT_NUM, BANK_RECEIPT_TRANSACTION_ID, 'BANK RECEIPT', NULL, BANK_RECEIPT_AMOUNT from debtor JOIN bank_receipt USING (DEBTOR_NUM) WHERE BANK_RECEIPT_DATE>=DATE_START_PARAM AND BANK_RECEIPT_DATE<=DATE_END_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM)
UNION ALL (SELECT CREDIT_NOTE_DATE,CREDIT_NOTE_NUM, NULL, 'CREDIT NOTE', NULL, SUM(CREDIT_NOTELINE_SUBTOTAL) FROM debtor JOIN credit_note USING (DEBTOR_NUM) NATURAL JOIN credit_noteline WHERE CREDIT_NOTE_DATE>=DATE_START_PARAM AND CREDIT_NOTE_DATE<=DATE_END_PARAM AND DEBTOR_NUM=DEBTOR_NUM_PARAM GROUP BY CREDIT_NOTE_NUM)
ORDER BY DATE;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DELIVERY_ORDER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DELIVERY_ORDER`(IN DELIVERY_ORDER_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBTOR_NUM, DEBTOR_NAME, DEBTOR_ADDRESS, DELIVERY_ORDER_NUM,DELIVERY_ORDER_DATE,DELIVERY_ORDER_DESC, DELIVERY_ORDER_NUM AS DELIVERY_ORDER_NUM_OLD FROM debtor JOIN delivery_order USING (DEBTOR_NUM) WHERE DELIVERY_ORDER_NUM=DELIVERY_ORDER_NUM_PARAM;
SELECT DELIVERY_ORDERLINE_LINENUMBER,DELIVERY_ORDERLINE_STOCK_NUM,DELIVERY_ORDERLINE_STOCK_DESC,DELIVERY_ORDERLINE_STOCK_QTY FROM delivery_orderline WHERE DELIVERY_ORDER_NUM=DELIVERY_ORDER_NUM_PARAM;
SELECT DELIVERY_ORDERLINE_LINENUMBER,STOCK_NUM,DELIVERY_ORDER_STOCK_QTY FROM delivery_order_stock WHERE DELIVERY_ORDER_NUM=DELIVERY_ORDER_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DELIVERY_ORDERLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DELIVERY_ORDERLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DELIVERY_ORDER_NUM AS NUM, DEBTOR_NAME,DELIVERY_ORDER_DATE AS DATE,DELIVERY_ORDER_DESC AS DESCRIPTION,SUM(DELIVERY_ORDERLINE_STOCK_QTY) AS QTY FROM debtor JOIN delivery_order USING(DEBTOR_NUM) LEFT JOIN delivery_orderline USING (DELIVERY_ORDER_NUM) GROUP BY DELIVERY_ORDER_NUM ORDER BY DELIVERY_ORDER_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DELIVERY_RETURN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DELIVERY_RETURN`(IN DELIVERY_RETURN_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBTOR_NUM, DEBTOR_NAME, DEBTOR_ADDRESS, DELIVERY_RETURN_NUM,DELIVERY_RETURN_DATE,DELIVERY_RETURN_DESC, DELIVERY_RETURN_NUM AS DELIVERY_RETURN_NUM_OLD FROM debtor JOIN delivery_return USING (DEBTOR_NUM) WHERE DELIVERY_RETURN_NUM=DELIVERY_RETURN_NUM_PARAM;
SELECT DELIVERY_RETURNLINE_LINENUMBER,DELIVERY_RETURNLINE_STOCK_NUM,DELIVERY_RETURNLINE_STOCK_DESC,DELIVERY_RETURNLINE_STOCK_QTY FROM delivery_returnline WHERE DELIVERY_RETURN_NUM=DELIVERY_RETURN_NUM_PARAM;
SELECT DELIVERY_RETURNLINE_LINENUMBER,STOCK_NUM,DELIVERY_RETURN_STOCK_QTY FROM delivery_return_stock WHERE DELIVERY_RETURN_NUM=DELIVERY_RETURN_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_DELIVERY_RETURNLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_DELIVERY_RETURNLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DELIVERY_RETURN_NUM AS NUM, DEBTOR_NAME,DELIVERY_RETURN_DATE AS DATE,DELIVERY_RETURN_DESC AS DESCRIPTION,SUM(DELIVERY_RETURNLINE_STOCK_QTY) AS QTY FROM debtor JOIN delivery_return USING(DEBTOR_NUM) LEFT JOIN delivery_returnline USING (DELIVERY_RETURN_NUM) GROUP BY DELIVERY_RETURN_NUM ORDER BY DELIVERY_RETURN_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_GOODS_RECEIVED_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_GOODS_RECEIVED_NOTE`(IN GOODS_RECEIVED_NOTE_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDITOR_NUM, CREDITOR_NAME, CREDITOR_ADDRESS, GOODS_RECEIVED_NOTE_NUM,GOODS_RECEIVED_NOTE_DATE,GOODS_RECEIVED_NOTE_DESC, GOODS_RECEIVED_NOTE_NUM AS GOODS_RECEIVED_NOTE_NUM_OLD FROM creditor JOIN goods_received_note USING (CREDITOR_NUM) WHERE GOODS_RECEIVED_NOTE_NUM=GOODS_RECEIVED_NOTE_NUM_PARAM;
SELECT GOODS_RECEIVED_NOTELINE_LINENUMBER,GOODS_RECEIVED_NOTELINE_STOCK_NUM,GOODS_RECEIVED_NOTELINE_STOCK_DESC,GOODS_RECEIVED_NOTELINE_STOCK_QTY FROM goods_received_noteline WHERE GOODS_RECEIVED_NOTE_NUM=GOODS_RECEIVED_NOTE_NUM_PARAM;
SELECT GOODS_RECEIVED_NOTELINE_LINENUMBER,STOCK_NUM,GOODS_RECEIVED_NOTE_STOCK_QTY FROM goods_received_note_stock WHERE GOODS_RECEIVED_NOTE_NUM=GOODS_RECEIVED_NOTE_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_GOODS_RECEIVED_NOTELIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_GOODS_RECEIVED_NOTELIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT GOODS_RECEIVED_NOTE_NUM AS NUM, CREDITOR_NAME,GOODS_RECEIVED_NOTE_DATE AS DATE,GOODS_RECEIVED_NOTE_DESC AS DESCRIPTION,SUM(GOODS_RECEIVED_NOTELINE_STOCK_QTY) AS QTY FROM creditor JOIN goods_received_note USING(CREDITOR_NUM) LEFT JOIN goods_received_noteline USING (GOODS_RECEIVED_NOTE_NUM) GROUP BY GOODS_RECEIVED_NOTE_NUM ORDER BY GOODS_RECEIVED_NOTE_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_JOURNAL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_JOURNAL`(IN JOURNAL_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT JOURNAL_NUM, JOURNAL_DATE, JOURNAL_DESC, JOURNAL_NUM AS JOURNAL_NUM_OLD FROM journal WHERE JOURNAL_NUM=JOURNAL_NUM_PARAM;
SELECT JOURNALLINE_LINENUMBER,GL_ACC_NUM,JOURNALLINE_GL_DESC,JOURNALLINE_DESC,JOURNALLINE_DEBIT,JOURNALLINE_CREDIT FROM journalline WHERE JOURNAL_NUM=JOURNAL_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_JOURNALLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_JOURNALLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT JOURNAL_NUM AS NUM,JOURNAL_DATE AS DATE,JOURNAL_DESC AS DESCRIPTION, SUM(JOURNALLINE_DEBIT) AS 'NET TOTAL' FROM journal LEFT JOIN journalline USING (JOURNAL_NUM) GROUP BY JOURNAL_NUM ORDER BY JOURNAL_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PROFIT_AND_LOSS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PROFIT_AND_LOSS`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT GL_CATEGORY FROM gl_category WHERE GL_AREA='PROFIT AND LOSS' ORDER BY GL_ORDER;

SELECT GL_CATEGORY,GL_ACC_NUM,GL_DESC,DATE,ITEM,NUM,DEBIT,CREDIT FROM gl NATURAL JOIN gl_category NATURAL JOIN (
(SELECT GL_ACC_NUM,SALES_INVOICE_DATE AS DATE, 'SALES INVOICE' AS ITEM, SALES_INVOICE_NUM AS NUM,NULL AS DEBIT, SUM(SALES_INVOICELINE_SUBTOTAL) AS CREDIT FROM sales_invoice NATURAL JOIN sales_invoiceline GROUP BY SALES_INVOICE_NUM)
UNION ALL(SELECT GL_ACC_NUM,DEBIT_NOTE_DATE AS DATE, 'DEBIT NOTE' AS ITEM, DEBIT_NOTE_NUM AS NUM,NULL AS DEBIT, SUM(DEBIT_NOTELINE_SUBTOTAL) AS CREDIT FROM debit_note NATURAL JOIN debit_noteline GROUP BY DEBIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM,CREDIT_NOTE_DATE AS DATE, 'CREDIT NOTE' AS ITEM, CREDIT_NOTE_NUM AS NUM,SUM(CREDIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM credit_note NATURAL JOIN credit_noteline GROUP BY CREDIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM,PURCHASE_INVOICE_DATE AS DATE, 'PURCHASE INVOICE' AS ITEM, PURCHASE_INVOICE_NUM AS NUM,SUM(PURCHASE_INVOICELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM purchase_invoice NATURAL JOIN purchase_invoiceline GROUP BY PURCHASE_INVOICE_NUM)
UNION ALL(SELECT GL_ACC_NUM,PURCHASE_DEBIT_NOTE_DATE AS DATE, 'PURCHASE DEBIT NOTE' AS ITEM, PURCHASE_DEBIT_NOTE_NUM AS NUM,SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM purchase_debit_note NATURAL JOIN purchase_debit_noteline GROUP BY PURCHASE_DEBIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM,PURCHASE_CREDIT_NOTE_DATE AS DATE, 'PURCHASE CREDIT NOTE' AS ITEM, PURCHASE_CREDIT_NOTE_NUM AS NUM,NULL AS DEBIT,SUM(PURCHASE_CREDIT_NOTELINE_SUBTOTAL) AS CREDIT FROM purchase_credit_note NATURAL JOIN purchase_credit_noteline GROUP BY PURCHASE_CREDIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM, BANK_RECEIPT_DATE AS DATE, 'BANK RECEIPT' AS ITEM, BANK_RECEIPT_NUM AS NUM, NULL AS DEBIT, BANK_RECEIPT_AMOUNT AS CREDIT FROM bank_receipt)
UNION ALL(SELECT GL_ACC_NUM, BANK_PAYMENT_DATE AS DATE, 'BANK PAYMENT' AS ITEM, BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM bank_payment)
UNION ALL(SELECT GL_ACC_NUM1, CASH_RECEIPT_DATE AS DATE, 'CASH RECEIPT' AS ITEM, CASH_RECEIPT_NUM AS NUM, NULL AS DEBIT, CASH_RECEIPT_AMOUNT AS CREDIT FROM cash_receipt)
UNION ALL(SELECT GL_ACC_NUM1, CASH_PAYMENT_DATE AS DATE, 'CASH PAYMENT' AS ITEM, CASH_PAYMENT_NUM AS NUM, CASH_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM cash_payment)
UNION ALL(SELECT GL_ACC_NUM, JOURNAL_DATE AS DATE, 'JOURNAL' AS ITEM, JOURNAL_NUM AS NUM, JOURNALLINE_DEBIT AS DEBIT, JOURNALLINE_CREDIT AS CREDIT FROM journal NATURAL JOIN journalline)
) T1 WHERE GL_AREA='PROFIT AND LOSS' ORDER BY GL_ORDER,GL_ACC_NUM,DATE;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_CREDIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_CREDIT_NOTE`(IN PURCHASE_CREDIT_NOTE_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDITOR_NUM, CREDITOR_NAME, CREDITOR_ADDRESS, PURCHASE_CREDIT_NOTE_NUM,PURCHASE_CREDIT_NOTE_DATE,PURCHASE_CREDIT_NOTE_DESC, PURCHASE_CREDIT_NOTE_CREDIT_TERM, purchase_credit_note.GL_ACC_NUM, PURCHASE_CREDIT_NOTE_NUM AS PURCHASE_CREDIT_NOTE_NUM_OLD FROM creditor JOIN purchase_credit_note USING (CREDITOR_NUM) WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
SELECT PURCHASE_CREDIT_NOTELINE_LINENUMBER,PURCHASE_CREDIT_NOTELINE_STOCK_NUM,PURCHASE_CREDIT_NOTELINE_STOCK_DESC,PURCHASE_CREDIT_NOTELINE_STOCK_PRICE,PURCHASE_CREDIT_NOTELINE_STOCK_QTY,PURCHASE_CREDIT_NOTELINE_DISCOUNT FROM purchase_credit_noteline WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
SELECT PURCHASE_INVOICE_NUM,PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
SELECT PURCHASE_DEBIT_NOTE_NUM,PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
SELECT PURCHASE_CREDIT_NOTELINE_LINENUMBER,STOCK_NUM,PURCHASE_CREDIT_NOTE_STOCK_QTY FROM purchase_credit_note_stock WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_CREDIT_NOTELIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_CREDIT_NOTELIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT PURCHASE_CREDIT_NOTE_DATE AS DATE,CREDITOR_NAME, PURCHASE_CREDIT_NOTE_NUM AS NUM,PURCHASE_CREDIT_NOTE_DESC AS DESCRIPTION, SUM(PURCHASE_CREDIT_NOTELINE_SUBTOTAL) AS SUBTOTAL FROM creditor JOIN purchase_credit_note USING(CREDITOR_NUM) LEFT JOIN purchase_credit_noteline USING (PURCHASE_CREDIT_NOTE_NUM) GROUP BY PURCHASE_CREDIT_NOTE_NUM ORDER BY PURCHASE_CREDIT_NOTE_DATE;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_DEBIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_DEBIT_NOTE`(IN PURCHASE_DEBIT_NOTE_NUM_PARAM VARCHAR(50))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDITOR_NUM, CREDITOR_NAME, CREDITOR_ADDRESS,PURCHASE_DEBIT_NOTE_NUM,PURCHASE_DEBIT_NOTE_DATE,PURCHASE_DEBIT_NOTE_DESC,PURCHASE_DEBIT_NOTE_CREDIT_TERM, purchase_debit_note.GL_ACC_NUM, PURCHASE_DEBIT_NOTE_NUM AS PURCHASE_DEBIT_NOTE_NUM_OLD FROM creditor JOIN purchase_debit_note USING (CREDITOR_NUM) WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM;
SELECT PURCHASE_DEBIT_NOTELINE_LINENUMBER,PURCHASE_DEBIT_NOTELINE_STOCK_NUM,PURCHASE_DEBIT_NOTELINE_STOCK_DESC,PURCHASE_DEBIT_NOTELINE_STOCK_PRICE,PURCHASE_DEBIT_NOTELINE_STOCK_QTY,PURCHASE_DEBIT_NOTELINE_DISCOUNT FROM purchase_debit_noteline WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM;
SELECT PURCHASE_DEBIT_NOTELINE_LINENUMBER,STOCK_NUM,PURCHASE_DEBIT_NOTE_STOCK_QTY FROM purchase_debit_note_stock WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_DEBIT_NOTELIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_DEBIT_NOTELIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT PURCHASE_DEBIT_NOTE_DATE AS DATE,CREDITOR_NAME,PURCHASE_DEBIT_NOTE_NUM AS NUM,PURCHASE_DEBIT_NOTE_DESC AS DESCRIPTION, SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) AS SUBTOTAL,
(SELECT SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT) FROM purchase_debit_note_bank_payment WHERE purchase_debit_note_bank_payment.PURCHASE_DEBIT_NOTE_NUM=purchase_debit_note.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT) FROM purchase_debit_note_cash_payment WHERE purchase_debit_note_cash_payment.PURCHASE_DEBIT_NOTE_NUM=purchase_debit_note.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_debit_note_purchase_credit_note WHERE purchase_debit_note_purchase_credit_note.PURCHASE_DEBIT_NOTE_NUM=purchase_debit_note.PURCHASE_DEBIT_NOTE_NUM),0)) AS OUTSTANDING 
FROM creditor JOIN purchase_debit_note USING(CREDITOR_NUM) LEFT JOIN purchase_debit_noteline USING (PURCHASE_DEBIT_NOTE_NUM) GROUP BY PURCHASE_DEBIT_NOTE_NUM ORDER BY PURCHASE_DEBIT_NOTE_DATE;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_DEBIT_NOTE_PAYMENT_HISTORY` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_DEBIT_NOTE_PAYMENT_HISTORY`(IN PURCHASE_DEBIT_NOTE_NUM_PARAM VARCHAR(50))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_DATE AS DATE,'BANK PAYMENT' AS TYPE, BANK_PAYMENT_TRANSACTION_ID AS DESCRIPTION, PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT AS AMOUNT FROM bank_payment NATURAL JOIN purchase_debit_note_bank_payment WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM 
UNION ALL (SELECT CASH_PAYMENT_NUM, CASH_PAYMENT_DATE,'CASH PAYMENT', CASH_PAYMENT_TRANSACTION_ID, PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT FROM cash_payment NATURAL JOIN purchase_debit_note_cash_payment WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM)
UNION ALL (SELECT PURCHASE_CREDIT_NOTE_NUM, PURCHASE_CREDIT_NOTE_DATE,'PURCHASE CREDIT NOTE', PURCHASE_CREDIT_NOTE_DESC, PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_credit_note NATURAL JOIN purchase_debit_note_purchase_credit_note WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM);

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_INVOICE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_INVOICE`(IN PURCHASE_INVOICE_NUM_PARAM VARCHAR(50))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDITOR_NUM,CREDITOR_NAME,CREDITOR_ADDRESS,PURCHASE_INVOICE_NUM,PURCHASE_INVOICE_DATE,PURCHASE_INVOICE_DESC,PURCHASE_INVOICE_CREDIT_TERM,purchase_invoice.GL_ACC_NUM,PURCHASE_INVOICE_NUM AS PURCHASE_INVOICE_NUM_OLD FROM creditor JOIN purchase_invoice USING (CREDITOR_NUM) WHERE PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_PARAM;
SELECT PURCHASE_INVOICELINE_LINENUMBER,PURCHASE_INVOICELINE_STOCK_NUM,PURCHASE_INVOICELINE_STOCK_DESC,PURCHASE_INVOICELINE_STOCK_PRICE,PURCHASE_INVOICELINE_STOCK_QTY,PURCHASE_INVOICELINE_DISCOUNT FROM purchase_invoiceline WHERE PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_PARAM;
SELECT PURCHASE_INVOICELINE_LINENUMBER,STOCK_NUM,PURCHASE_INVOICE_STOCK_QTY FROM purchase_invoice_stock WHERE PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_INVOICELIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_INVOICELIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT PURCHASE_INVOICE_DATE AS DATE,CREDITOR_NAME,PURCHASE_INVOICE_NUM AS NUM, PURCHASE_INVOICE_DESC AS DESCRIPTION, SUM(PURCHASE_INVOICELINE_SUBTOTAL) AS SUBTOTAL,
(SELECT SUM(PURCHASE_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT) FROM purchase_invoice_bank_payment WHERE purchase_invoice_bank_payment.PURCHASE_INVOICE_NUM=purchase_invoice.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT) FROM purchase_invoice_cash_payment WHERE purchase_invoice_cash_payment.PURCHASE_INVOICE_NUM=purchase_invoice.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_invoice_purchase_credit_note WHERE purchase_invoice_purchase_credit_note.PURCHASE_INVOICE_NUM=purchase_invoice.PURCHASE_INVOICE_NUM),0)) AS OUTSTANDING 
FROM creditor JOIN purchase_invoice USING(CREDITOR_NUM) LEFT JOIN purchase_invoiceline USING(PURCHASE_INVOICE_NUM) GROUP BY PURCHASE_INVOICE_NUM ORDER BY PURCHASE_INVOICE_DATE;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_INVOICE_PAYMENT_HISTORY` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_INVOICE_PAYMENT_HISTORY`(IN PURCHASE_INVOICE_NUM_PARAM VARCHAR(50))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_DATE AS DATE,'BANK PAYMENT' AS TYPE, BANK_PAYMENT_TRANSACTION_ID AS DESCRIPTION, PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT AS AMOUNT FROM bank_payment NATURAL JOIN purchase_invoice_bank_payment WHERE PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_PARAM 
UNION ALL (SELECT CASH_PAYMENT_NUM, CASH_PAYMENT_DATE,'CASH PAYMENT', CASH_PAYMENT_TRANSACTION_ID, PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT FROM cash_payment NATURAL JOIN purchase_invoice_cash_payment WHERE PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_PARAM)
UNION ALL (SELECT PURCHASE_CREDIT_NOTE_NUM, PURCHASE_CREDIT_NOTE_DATE,'PURCHASE CREDIT NOTE', PURCHASE_CREDIT_NOTE_DESC, PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_credit_note NATURAL JOIN purchase_invoice_purchase_credit_note WHERE PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_PARAM);

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_RETURN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_RETURN`(IN PURCHASE_RETURN_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDITOR_NUM, CREDITOR_NAME, CREDITOR_ADDRESS, PURCHASE_RETURN_NUM,PURCHASE_RETURN_DATE,PURCHASE_RETURN_DESC, PURCHASE_RETURN_NUM AS PURCHASE_RETURN_NUM_OLD FROM creditor JOIN purchase_return USING (CREDITOR_NUM) WHERE PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_PARAM;
SELECT PURCHASE_RETURNLINE_LINENUMBER,PURCHASE_RETURNLINE_STOCK_NUM,PURCHASE_RETURNLINE_STOCK_DESC,PURCHASE_RETURNLINE_STOCK_QTY FROM purchase_returnline WHERE PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_PARAM;
SELECT PURCHASE_RETURNLINE_LINENUMBER,STOCK_NUM,PURCHASE_RETURN_STOCK_QTY FROM purchase_return_stock WHERE PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_PURCHASE_RETURNLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_PURCHASE_RETURNLIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT PURCHASE_RETURN_NUM AS NUM, CREDITOR_NAME,PURCHASE_RETURN_DATE AS DATE,PURCHASE_RETURN_DESC AS DESCRIPTION,SUM(PURCHASE_RETURNLINE_STOCK_QTY) AS QTY FROM creditor JOIN purchase_return USING(CREDITOR_NUM) LEFT JOIN purchase_returnline USING (PURCHASE_RETURN_NUM) GROUP BY PURCHASE_RETURN_NUM ORDER BY PURCHASE_RETURN_NUM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_SALES_INVOICE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_SALES_INVOICE`(IN SALES_INVOICE_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBTOR_NUM, DEBTOR_NAME, DEBTOR_ADDRESS, SALES_INVOICE_NUM,SALES_INVOICE_DATE,SALES_INVOICE_DESC, SALES_INVOICE_CREDIT_TERM,sales_invoice.GL_ACC_NUM, SALES_INVOICE_NUM AS SALES_INVOICE_NUM_OLD FROM debtor JOIN sales_invoice USING (DEBTOR_NUM) WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_PARAM;
SELECT SALES_INVOICELINE_LINENUMBER,SALES_INVOICELINE_STOCK_NUM,SALES_INVOICELINE_STOCK_DESC,SALES_INVOICELINE_STOCK_PRICE,SALES_INVOICELINE_STOCK_QTY,SALES_INVOICELINE_DISCOUNT FROM sales_invoiceline WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_PARAM;
SELECT SALES_INVOICELINE_LINENUMBER,STOCK_NUM,SALES_INVOICE_STOCK_QTY FROM sales_invoice_stock WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_SALES_INVOICELIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_SALES_INVOICELIST`()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT SALES_INVOICE_NUM AS NUM,DEBTOR_NAME,SALES_INVOICE_DATE AS DATE,SALES_INVOICE_DESC AS DESCRIPTION, SUM(SALES_INVOICELINE_SUBTOTAL) AS SUBTOTAL, 
(SELECT SUM(SALES_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(SALES_INVOICE_BANK_RECEIPT_AMOUNT) FROM sales_invoice_bank_receipt WHERE sales_invoice_bank_receipt.SALES_INVOICE_NUM=sales_invoice.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_CASH_RECEIPT_AMOUNT) FROM sales_invoice_cash_receipt WHERE sales_invoice_cash_receipt.SALES_INVOICE_NUM=sales_invoice.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_CREDIT_NOTE_AMOUNT) FROM sales_invoice_credit_note WHERE sales_invoice_credit_note.SALES_INVOICE_NUM=sales_invoice.SALES_INVOICE_NUM),0)) AS OUTSTANDING 
FROM debtor JOIN sales_invoice USING(DEBTOR_NUM) LEFT JOIN sales_invoiceline USING (SALES_INVOICE_NUM) GROUP BY SALES_INVOICE_NUM ORDER BY SALES_INVOICE_NUM;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_SALES_INVOICE_RECEIPT_HISTORY` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_SALES_INVOICE_RECEIPT_HISTORY`(IN SALES_INVOICE_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT BANK_RECEIPT_NUM AS NUM, BANK_RECEIPT_DATE AS DATE,'BANK RECEIPT' AS TYPE, BANK_RECEIPT_TRANSACTION_ID AS DESCRIPTION, SALES_INVOICE_BANK_RECEIPT_AMOUNT AS AMOUNT FROM bank_receipt NATURAL JOIN sales_invoice_bank_receipt WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_PARAM 
UNION ALL (SELECT CASH_RECEIPT_NUM, CASH_RECEIPT_DATE,'CASH RECEIPT', CASH_RECEIPT_TRANSACTION_ID, SALES_INVOICE_CASH_RECEIPT_AMOUNT FROM cash_receipt NATURAL JOIN sales_invoice_cash_receipt WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_PARAM)
UNION ALL (SELECT CREDIT_NOTE_NUM, CREDIT_NOTE_DATE,'CREDIT NOTE', CREDIT_NOTE_DESC, SALES_INVOICE_CREDIT_NOTE_AMOUNT FROM credit_note NATURAL JOIN sales_invoice_credit_note WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_PARAM);

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_STOCK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_STOCK`(IN STOCK_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT *,STOCK_NUM AS STOCK_NUM_OLD FROM stock WHERE STOCK_NUM=STOCK_NUM_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SELECT_STOCKLIST` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `SELECT_STOCKLIST`(IN DOC_NUM_PARAM VARCHAR(50))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

IF DOC_NUM_PARAM IS NOT NULL THEN 

SELECT STOCK_NUM AS NUM, STOCK_DESC AS DESCRIPTION,STOCK_PRICE AS PRICE,STOCK_MINPRICE AS 'MIN PRICE',STOCK_MAXPRICE AS 'MAX PRICE', STOCK_COST AS COST, STOCK_MINQTY AS 'MIN QTY', STOCK_MAXQTY AS 'MAX QTY',0
-IFNULL((SELECT SUM(DELIVERY_ORDER_STOCK_QTY) FROM delivery_order_stock WHERE delivery_order_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(DELIVERY_ORDER_STOCK_QTY) FROM delivery_order_stock WHERE delivery_order_stock.DELIVERY_ORDER_NUM=DOC_NUM_PARAM AND delivery_order_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(DELIVERY_RETURN_STOCK_QTY) FROM delivery_return_stock WHERE delivery_return_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(DELIVERY_RETURN_STOCK_QTY) FROM delivery_return_stock WHERE delivery_return_stock.DELIVERY_RETURN_NUM=DOC_NUM_PARAM AND delivery_return_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(SALES_INVOICE_STOCK_QTY) FROM sales_invoice_stock WHERE sales_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(SALES_INVOICE_STOCK_QTY) FROM sales_invoice_stock WHERE sales_invoice_stock.SALES_INVOICE_NUM=DOC_NUM_PARAM AND sales_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_STOCK_QTY) FROM debit_note_stock WHERE debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(DEBIT_NOTE_STOCK_QTY) FROM debit_note_stock WHERE debit_note_stock.DEBIT_NOTE_NUM=DOC_NUM_PARAM AND debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(CREDIT_NOTE_STOCK_QTY) FROM credit_note_stock WHERE credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(CREDIT_NOTE_STOCK_QTY) FROM credit_note_stock WHERE credit_note_stock.CREDIT_NOTE_NUM=DOC_NUM_PARAM AND credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
+IFNULL((SELECT SUM(GOODS_RECEIVED_NOTE_STOCK_QTY) FROM goods_received_note_stock WHERE goods_received_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(GOODS_RECEIVED_NOTE_STOCK_QTY) FROM goods_received_note_stock WHERE goods_received_note_stock.GOODS_RECEIVED_NOTE_NUM=DOC_NUM_PARAM AND goods_received_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_RETURN_STOCK_QTY) FROM purchase_return_stock WHERE purchase_return_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_RETURN_STOCK_QTY) FROM purchase_return_stock WHERE purchase_return_stock.PURCHASE_RETURN_NUM=DOC_NUM_PARAM AND purchase_return_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_INVOICE_STOCK_QTY) FROM purchase_invoice_stock WHERE purchase_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_INVOICE_STOCK_QTY) FROM purchase_invoice_stock WHERE purchase_invoice_stock.PURCHASE_INVOICE_NUM=DOC_NUM_PARAM AND purchase_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0) 
+IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_STOCK_QTY) FROM purchase_debit_note_stock WHERE purchase_debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_STOCK_QTY) FROM purchase_debit_note_stock WHERE purchase_debit_note_stock.PURCHASE_DEBIT_NOTE_NUM=DOC_NUM_PARAM AND purchase_debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_CREDIT_NOTE_STOCK_QTY) FROM purchase_credit_note_stock WHERE purchase_credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_CREDIT_NOTE_STOCK_QTY) FROM purchase_credit_note_stock WHERE purchase_credit_note_stock.PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND purchase_credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
AS 'BAL QTY'
FROM stock ORDER BY STOCK_NUM;

ELSE 
SELECT STOCK_NUM AS NUM, STOCK_DESC AS DESCRIPTION,STOCK_PRICE AS PRICE,STOCK_MINPRICE AS 'MIN PRICE',STOCK_MAXPRICE AS 'MAX PRICE', STOCK_COST AS COST, STOCK_MINQTY AS 'MIN QTY', STOCK_MAXQTY AS 'MAX QTY',0
-IFNULL((SELECT SUM(DELIVERY_ORDER_STOCK_QTY) FROM delivery_order_stock WHERE delivery_order_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(DELIVERY_RETURN_STOCK_QTY) FROM delivery_return_stock WHERE delivery_return_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(SALES_INVOICE_STOCK_QTY) FROM sales_invoice_stock WHERE sales_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_STOCK_QTY) FROM debit_note_stock WHERE debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(CREDIT_NOTE_STOCK_QTY) FROM credit_note_stock WHERE credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(GOODS_RECEIVED_NOTE_STOCK_QTY) FROM goods_received_note_stock WHERE goods_received_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_RETURN_STOCK_QTY) FROM purchase_return_stock WHERE purchase_return_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_INVOICE_STOCK_QTY) FROM purchase_invoice_stock WHERE purchase_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_STOCK_QTY) FROM purchase_debit_note_stock WHERE purchase_debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)  
-IFNULL((SELECT SUM(PURCHASE_CREDIT_NOTE_STOCK_QTY) FROM purchase_credit_note_stock WHERE purchase_credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)  
AS 'BAL QTY'
FROM stock ORDER BY STOCK_NUM;
END IF;


COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_ACCOUNT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_ACCOUNT`(IN GL_ACC_NUM_OLD_PARAM INT,IN GL_CATEGORY_PARAM VARCHAR(45), IN GL_ACC_NUM_PARAM INT, IN GL_DESC_PARAM VARCHAR(45))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
UPDATE gl SET GL_ACC_NUM=GL_ACC_NUM_PARAM, GL_DESC=GL_DESC_PARAM, GL_CATEGORY=GL_CATEGORY_PARAM,GL_STATUS='NORMAL' WHERE GL_ACC_NUM=GL_ACC_NUM_OLD_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_BANK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_BANK`(IN BANK_NUM_PARAM VARCHAR(20),IN BANK_NAME_PARAM VARCHAR(255), IN BANK_ADDRESS_PARAM VARCHAR(255), IN BANK_POSTCODE_PARAM VARCHAR(5),IN GL_ACC_NUM_PARAM INT,IN BANK_NUM_OLD_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
UPDATE bank SET BANK_NUM=BANK_NUM_PARAM,BANK_NAME=BANK_NAME_PARAM,BANK_ADDRESS=BANK_ADDRESS_PARAM,BANK_POSTCODE=BANK_POSTCODE_PARAM,GL_ACC_NUM=DEFAULT WHERE BANK_NUM=BANK_NUM_OLD_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_BANK_PAYMENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_BANK_PAYMENT`(IN BANK_PAYMENT_NUM_PARAM VARCHAR(20),IN BANK_NUM_PARAM VARCHAR(20), IN CREDITOR_NUM_PARAM VARCHAR(20), IN BANK_PAYMENT_DATE_PARAM DATE, IN BANK_PAYMENT_METHOD_PARAM VARCHAR(45),IN BANK_PAYMENT_TRANSACTION_ID_PARAM VARCHAR(45),IN BANK_PAYMENT_DESC_PARAM VARCHAR(255),IN BANK_PAYMENT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM_PARAM INT,IN BANK_PAYMENT_NUM_OLD_PARAM VARCHAR(20), IN OFFSET_ONE_PARAM VARCHAR(255), IN OFFSET_TWO_PARAM VARCHAR(255))
BEGIN
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
DELETE FROM purchase_invoice_bank_payment WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_OLD_PARAM;
DELETE FROM purchase_debit_note_bank_payment WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_OLD_PARAM;
UPDATE bank_payment SET BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_PARAM,BANK_NUM=BANK_NUM_PARAM,CREDITOR_NUM=CREDITOR_NUM_PARAM,BANK_PAYMENT_DATE=BANK_PAYMENT_DATE_PARAM,BANK_PAYMENT_METHOD=BANK_PAYMENT_METHOD_PARAM,BANK_PAYMENT_TRANSACTION_ID=BANK_PAYMENT_TRANSACTION_ID_PARAM,BANK_PAYMENT_DESC=BANK_PAYMENT_DESC_PARAM,BANK_PAYMENT_AMOUNT=BANK_PAYMENT_AMOUNT_PARAM,GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_OLD_PARAM;

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoice_bank_payment VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',BANK_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',BANK_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_note_bank_payment VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',BANK_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',BANK_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_BANK_RECEIPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_BANK_RECEIPT`(IN BANK_RECEIPT_NUM_PARAM VARCHAR(20),IN BANK_NUM_PARAM VARCHAR(20), IN DEBTOR_NUM_PARAM VARCHAR(20), IN BANK_RECEIPT_DATE_PARAM DATE, IN BANK_RECEIPT_METHOD_PARAM VARCHAR(45),IN BANK_RECEIPT_TRANSACTION_ID_PARAM VARCHAR(45),IN BANK_RECEIPT_DESC_PARAM VARCHAR(255),IN BANK_RECEIPT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM_PARAM INT,IN BANK_RECEIPT_NUM_OLD_PARAM VARCHAR(20), IN OFFSET_ONE_PARAM VARCHAR(255), IN OFFSET_TWO_PARAM VARCHAR(255))
BEGIN
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
DELETE FROM sales_invoice_bank_receipt WHERE BANK_RECEIPT_NUM=BANK_RECEIPT_NUM_OLD_PARAM;
DELETE FROM debit_note_bank_receipt WHERE BANK_RECEIPT_NUM=BANK_RECEIPT_NUM_OLD_PARAM;
UPDATE bank_receipt SET BANK_RECEIPT_NUM=BANK_RECEIPT_NUM_PARAM,BANK_NUM=BANK_NUM_PARAM,DEBTOR_NUM=DEBTOR_NUM_PARAM,BANK_RECEIPT_DATE=BANK_RECEIPT_DATE_PARAM,BANK_RECEIPT_METHOD=BANK_RECEIPT_METHOD_PARAM,BANK_RECEIPT_TRANSACTION_ID=BANK_RECEIPT_TRANSACTION_ID_PARAM,BANK_RECEIPT_DESC=BANK_RECEIPT_DESC_PARAM,BANK_RECEIPT_AMOUNT=BANK_RECEIPT_AMOUNT_PARAM,GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE BANK_RECEIPT_NUM=BANK_RECEIPT_NUM_OLD_PARAM;

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoice_bank_receipt VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',BANK_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',BANK_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_note_bank_receipt VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',BANK_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',BANK_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_CASH_PAYMENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_CASH_PAYMENT`(IN CASH_PAYMENT_NUM_PARAM VARCHAR(20), IN CREDITOR_NUM_PARAM VARCHAR(20), IN CASH_PAYMENT_DATE_PARAM DATE, IN CASH_PAYMENT_METHOD_PARAM VARCHAR(45),IN CASH_PAYMENT_TRANSACTION_ID_PARAM VARCHAR(45),IN CASH_PAYMENT_DESC_PARAM VARCHAR(255),IN CASH_PAYMENT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM1_PARAM INT,IN GL_ACC_NUM2_PARAM INT,IN CASH_PAYMENT_NUM_OLD_PARAM VARCHAR(20), IN OFFSET_ONE_PARAM VARCHAR(255), IN OFFSET_TWO_PARAM VARCHAR(255))
BEGIN
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
DELETE FROM purchase_invoice_cash_payment WHERE CASH_PAYMENT_NUM=CASH_PAYMENT_NUM_OLD_PARAM;
DELETE FROM purchase_debit_note_cash_payment WHERE CASH_PAYMENT_NUM=CASH_PAYMENT_NUM_OLD_PARAM;
UPDATE cash_payment SET CASH_PAYMENT_NUM=CASH_PAYMENT_NUM_PARAM,CREDITOR_NUM=CREDITOR_NUM_PARAM,CASH_PAYMENT_DATE=CASH_PAYMENT_DATE_PARAM,CASH_PAYMENT_METHOD=CASH_PAYMENT_METHOD_PARAM,CASH_PAYMENT_TRANSACTION_ID=CASH_PAYMENT_TRANSACTION_ID_PARAM,CASH_PAYMENT_DESC=CASH_PAYMENT_DESC_PARAM,CASH_PAYMENT_AMOUNT=CASH_PAYMENT_AMOUNT_PARAM,GL_ACC_NUM1=GL_ACC_NUM1_PARAM,GL_ACC_NUM2=DEFAULT WHERE CASH_PAYMENT_NUM=CASH_PAYMENT_NUM_OLD_PARAM;

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoice_cash_payment VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CASH_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CASH_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_note_cash_payment VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CASH_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CASH_PAYMENT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_CASH_RECEIPT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_CASH_RECEIPT`(IN CASH_RECEIPT_NUM_PARAM VARCHAR(20), IN DEBTOR_NUM_PARAM VARCHAR(20), IN CASH_RECEIPT_DATE_PARAM DATE, IN CASH_RECEIPT_METHOD_PARAM VARCHAR(45),IN CASH_RECEIPT_TRANSACTION_ID_PARAM VARCHAR(45),IN CASH_RECEIPT_DESC_PARAM VARCHAR(255),IN CASH_RECEIPT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM1_PARAM INT,IN GL_ACC_NUM2_PARAM INT,IN CASH_RECEIPT_NUM_OLD_PARAM VARCHAR(20), IN OFFSET_ONE_PARAM VARCHAR(255), IN OFFSET_TWO_PARAM VARCHAR(255))
BEGIN
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
DELETE FROM sales_invoice_cash_receipt WHERE CASH_RECEIPT_NUM=CASH_RECEIPT_NUM_OLD_PARAM;
DELETE FROM debit_note_cash_receipt WHERE CASH_RECEIPT_NUM=CASH_RECEIPT_NUM_OLD_PARAM;
UPDATE cash_receipt SET CASH_RECEIPT_NUM=CASH_RECEIPT_NUM_PARAM,DEBTOR_NUM=DEBTOR_NUM_PARAM,CASH_RECEIPT_DATE=CASH_RECEIPT_DATE_PARAM,CASH_RECEIPT_METHOD=CASH_RECEIPT_METHOD_PARAM,CASH_RECEIPT_TRANSACTION_ID=CASH_RECEIPT_TRANSACTION_ID_PARAM,CASH_RECEIPT_DESC=CASH_RECEIPT_DESC_PARAM,CASH_RECEIPT_AMOUNT=CASH_RECEIPT_AMOUNT_PARAM,GL_ACC_NUM1=GL_ACC_NUM1_PARAM,GL_ACC_NUM2=DEFAULT WHERE CASH_RECEIPT_NUM=CASH_RECEIPT_NUM_OLD_PARAM;

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoice_cash_receipt VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CASH_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CASH_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_note_cash_receipt VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CASH_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CASH_RECEIPT_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_CREDITOR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_CREDITOR`(IN CREDITOR_NUM_PARAM VARCHAR(20),IN CREDITOR_NAME_PARAM VARCHAR(255), IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN CREDITOR_POSTCODE_PARAM VARCHAR(5), IN CREDITOR_PHONE_PARAM VARCHAR(15),IN CREDITOR_FAX_PARAM VARCHAR(15),IN CREDITOR_OTHER_DESC_PARAM VARCHAR(255),IN CREDITOR_CREDIT_TERM_PARAM ENUM('COD', '30', '45', '60', '90'), IN GL_ACC_NUM_PARAM INT, IN CREDITOR_NUM_OLD_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
UPDATE creditor SET CREDITOR_NUM=CREDITOR_NUM_PARAM, CREDITOR_NAME=CREDITOR_NAME_PARAM, CREDITOR_ADDRESS=CREDITOR_ADDRESS_PARAM,CREDITOR_POSTCODE=CREDITOR_POSTCODE_PARAM,CREDITOR_PHONE=CREDITOR_PHONE_PARAM,CREDITOR_FAX=CREDITOR_FAX_PARAM,CREDITOR_OTHER_DESC=CREDITOR_OTHER_DESC_PARAM,CREDITOR_CREDIT_TERM=CREDITOR_CREDIT_TERM_PARAM,GL_ACC_NUM=DEFAULT WHERE CREDITOR_NUM=CREDITOR_NUM_OLD_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_CREDIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_CREDIT_NOTE`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN CREDIT_NOTE_NUM_PARAM VARCHAR(20), IN CREDIT_NOTE_DATE_PARAM DATE, IN CREDIT_NOTE_DESC_PARAM VARCHAR(255), IN CREDIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, CREDIT_NOTE_NUM_OLD_PARAM VARCHAR(20), IN CREDIT_NOTELINE_PARAM VARCHAR(255), IN OFFSET_ONE_PARAM VARCHAR(255), IN OFFSET_TWO_PARAM VARCHAR(255), IN CREDIT_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE POS3 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM credit_note_stock WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_OLD_PARAM;
DELETE FROM credit_noteline WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_OLD_PARAM;
DELETE FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_OLD_PARAM;
DELETE FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_OLD_PARAM;
UPDATE credit_note SET CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM, CREDIT_NOTE_DATE=CREDIT_NOTE_DATE_PARAM, CREDIT_NOTE_DESC=CREDIT_NOTE_DESC_PARAM, CREDIT_NOTE_CREDIT_TERM=CREDIT_NOTE_CREDIT_TERM_PARAM, DEBTOR_NUM=DEBTOR_NUM_PARAM, GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_OLD_PARAM;

IF CREDIT_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT credit_noteline VALUES ';

creditnoteline_loop:LOOP
IF REGEXP_INSTR(CREDIT_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(CREDIT_NOTELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE creditnoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(CREDIT_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(CREDIT_NOTELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(CREDIT_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP creditnoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoice_credit_note VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_note_credit_note VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF CREDIT_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT credit_note_stock VALUES ';

creditnotestock_loop:LOOP
IF REGEXP_INSTR(CREDIT_NOTE_STOCK_PARAM,'=',POS3)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(CREDIT_NOTE_STOCK_PARAM,POS3),')') INTO @STRNG;
LEAVE creditnotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(CREDIT_NOTE_STOCK_PARAM,'=',POS3) - POS3) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(CREDIT_NOTE_STOCK_PARAM,POS3,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(CREDIT_NOTE_STOCK_PARAM,'=',POS3)+1) INTO POS3;
END;
END IF;
END LOOP creditnotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_DEBIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_DEBIT_NOTE`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN DEBIT_NOTE_NUM_PARAM VARCHAR(20), IN DEBIT_NOTE_DATE_PARAM DATE, IN DEBIT_NOTE_DESC_PARAM VARCHAR(255), IN DEBIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, DEBIT_NOTE_NUM_OLD_PARAM VARCHAR(20), IN DEBIT_NOTELINE_PARAM VARCHAR(255), IN DEBIT_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM debit_note_stock WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_OLD_PARAM;
DELETE FROM debit_noteline WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_OLD_PARAM;
UPDATE debit_note SET DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_PARAM, DEBIT_NOTE_DATE=DEBIT_NOTE_DATE_PARAM, DEBIT_NOTE_DESC=DEBIT_NOTE_DESC_PARAM, DEBIT_NOTE_CREDIT_TERM=DEBIT_NOTE_CREDIT_TERM_PARAM, DEBTOR_NUM=DEBTOR_NUM_PARAM, GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_OLD_PARAM;

IF DEBIT_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_noteline VALUES ';

debitnoteline_loop:LOOP
IF REGEXP_INSTR(DEBIT_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(DEBIT_NOTELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE debitnoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DEBIT_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(DEBIT_NOTELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(DEBIT_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP debitnoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF DEBIT_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT debit_note_stock VALUES ';

debitnotestock_loop:LOOP
IF REGEXP_INSTR(DEBIT_NOTE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(DEBIT_NOTE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE debitnotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DEBIT_NOTE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(DEBIT_NOTE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DEBIT_NOTE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP debitnotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_DEBTOR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_DEBTOR`(IN DEBTOR_NUM_PARAM VARCHAR(20),IN DEBTOR_NAME_PARAM VARCHAR(255), IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN DEBTOR_POSTCODE_PARAM VARCHAR(5), IN DEBTOR_PHONE_PARAM VARCHAR(15),IN DEBTOR_FAX_PARAM VARCHAR(15),IN DEBTOR_OTHER_DESC_PARAM VARCHAR(255),IN DEBTOR_CREDIT_TERM_PARAM ENUM('COD', '30', '45', '60', '90'),IN GL_ACC_NUM_PARAM INT,IN DEBTOR_NUM_OLD_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
UPDATE debtor SET DEBTOR_NUM=DEBTOR_NUM_PARAM, DEBTOR_NAME=DEBTOR_NAME_PARAM,DEBTOR_ADDRESS=DEBTOR_ADDRESS_PARAM,DEBTOR_POSTCODE=DEBTOR_POSTCODE_PARAM,DEBTOR_PHONE=DEBTOR_PHONE_PARAM,DEBTOR_FAX=DEBTOR_FAX_PARAM,DEBTOR_OTHER_DESC=DEBTOR_OTHER_DESC_PARAM,DEBTOR_CREDIT_TERM=DEBTOR_CREDIT_TERM_PARAM,GL_ACC_NUM=DEFAULT WHERE DEBTOR_NUM=DEBTOR_NUM_OLD_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_DELIVERY_ORDER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_DELIVERY_ORDER`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN DELIVERY_ORDER_NUM_PARAM VARCHAR(20), IN DELIVERY_ORDER_DATE_PARAM DATE, IN DELIVERY_ORDER_DESC_PARAM VARCHAR(255), DELIVERY_ORDER_NUM_OLD_PARAM VARCHAR(20), IN DELIVERY_ORDERLINE_PARAM VARCHAR(255), IN DELIVERY_ORDER_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM delivery_order_stock WHERE DELIVERY_ORDER_NUM=DELIVERY_ORDER_NUM_OLD_PARAM;
DELETE FROM delivery_orderline WHERE DELIVERY_ORDER_NUM=DELIVERY_ORDER_NUM_OLD_PARAM;
UPDATE delivery_order SET DELIVERY_ORDER_NUM=DELIVERY_ORDER_NUM_PARAM, DELIVERY_ORDER_DATE=DELIVERY_ORDER_DATE_PARAM, DELIVERY_ORDER_DESC=DELIVERY_ORDER_DESC_PARAM, DEBTOR_NUM=DEBTOR_NUM_PARAM WHERE DELIVERY_ORDER_NUM=DELIVERY_ORDER_NUM_OLD_PARAM;

IF DELIVERY_ORDERLINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT delivery_orderline VALUES ';

deliveryorderline_loop:LOOP
IF REGEXP_INSTR(DELIVERY_ORDERLINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DELIVERY_ORDER_NUM_PARAM,'",',SUBSTRING(DELIVERY_ORDERLINE_PARAM,POS),')') INTO @STRNG;
LEAVE deliveryorderline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DELIVERY_ORDERLINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DELIVERY_ORDER_NUM_PARAM,'",',SUBSTRING(DELIVERY_ORDERLINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DELIVERY_ORDERLINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP deliveryorderline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;


IF DELIVERY_ORDER_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT delivery_order_stock VALUES ';

deliveryorderstock_loop:LOOP
IF REGEXP_INSTR(DELIVERY_ORDER_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DELIVERY_ORDER_NUM_PARAM,'",',SUBSTRING(DELIVERY_ORDER_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE deliveryorderstock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DELIVERY_ORDER_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DELIVERY_ORDER_NUM_PARAM,'",',SUBSTRING(DELIVERY_ORDER_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DELIVERY_ORDER_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP deliveryorderstock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;


COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_DELIVERY_RETURN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_DELIVERY_RETURN`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN DELIVERY_RETURN_NUM_PARAM VARCHAR(20), IN DELIVERY_RETURN_DATE_PARAM DATE, IN DELIVERY_RETURN_DESC_PARAM VARCHAR(255), DELIVERY_RETURN_NUM_OLD_PARAM VARCHAR(20), IN DELIVERY_RETURNLINE_PARAM VARCHAR(255), IN DELIVERY_RETURN_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM delivery_return_stock WHERE DELIVERY_RETURN_NUM=DELIVERY_RETURN_NUM_OLD_PARAM;
DELETE FROM delivery_returnline WHERE DELIVERY_RETURN_NUM=DELIVERY_RETURN_NUM_OLD_PARAM;
UPDATE delivery_return SET DELIVERY_RETURN_NUM=DELIVERY_RETURN_NUM_PARAM, DELIVERY_RETURN_DATE=DELIVERY_RETURN_DATE_PARAM, DELIVERY_RETURN_DESC=DELIVERY_RETURN_DESC_PARAM, DEBTOR_NUM=DEBTOR_NUM_PARAM WHERE DELIVERY_RETURN_NUM=DELIVERY_RETURN_NUM_OLD_PARAM;

IF DELIVERY_RETURNLINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT delivery_returnline VALUES ';

deliveryreturnline_loop:LOOP
IF REGEXP_INSTR(DELIVERY_RETURNLINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DELIVERY_RETURN_NUM_PARAM,'",',SUBSTRING(DELIVERY_RETURNLINE_PARAM,POS),')') INTO @STRNG;
LEAVE deliveryreturnline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DELIVERY_RETURNLINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DELIVERY_RETURN_NUM_PARAM,'",',SUBSTRING(DELIVERY_RETURNLINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DELIVERY_RETURNLINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP deliveryreturnline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF DELIVERY_RETURN_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT delivery_return_stock VALUES ';

deliveryreturnstock_loop:LOOP
IF REGEXP_INSTR(DELIVERY_RETURN_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',DELIVERY_RETURN_NUM_PARAM,'",',SUBSTRING(DELIVERY_RETURN_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE deliveryreturnstock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(DELIVERY_RETURN_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',DELIVERY_RETURN_NUM_PARAM,'",',SUBSTRING(DELIVERY_RETURN_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(DELIVERY_RETURN_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP deliveryreturnstock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;


COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_GOODS_RECEIVED_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_GOODS_RECEIVED_NOTE`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN GOODS_RECEIVED_NOTE_NUM_PARAM VARCHAR(20), IN GOODS_RECEIVED_NOTE_DATE_PARAM DATE, IN GOODS_RECEIVED_NOTE_DESC_PARAM VARCHAR(255), GOODS_RECEIVED_NOTE_NUM_OLD_PARAM VARCHAR(20), IN GOODS_RECEIVED_NOTELINE_PARAM VARCHAR(255), IN GOODS_RECEIVED_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM goods_received_note_stock WHERE GOODS_RECEIVED_NOTE_NUM=GOODS_RECEIVED_NOTE_NUM_OLD_PARAM;
DELETE FROM goods_received_noteline WHERE GOODS_RECEIVED_NOTE_NUM=GOODS_RECEIVED_NOTE_NUM_OLD_PARAM;
UPDATE goods_received_note SET GOODS_RECEIVED_NOTE_NUM=GOODS_RECEIVED_NOTE_NUM_PARAM, GOODS_RECEIVED_NOTE_DATE=GOODS_RECEIVED_NOTE_DATE_PARAM, GOODS_RECEIVED_NOTE_DESC=GOODS_RECEIVED_NOTE_DESC_PARAM, CREDITOR_NUM=CREDITOR_NUM_PARAM WHERE GOODS_RECEIVED_NOTE_NUM=GOODS_RECEIVED_NOTE_NUM_OLD_PARAM;

IF GOODS_RECEIVED_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT goods_received_noteline VALUES ';

goodsreceivednoteline_loop:LOOP
IF REGEXP_INSTR(GOODS_RECEIVED_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',GOODS_RECEIVED_NOTE_NUM_PARAM,'",',SUBSTRING(GOODS_RECEIVED_NOTELINE_PARAM,POS),')') INTO @STRNG;
LEAVE goodsreceivednoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(GOODS_RECEIVED_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',GOODS_RECEIVED_NOTE_NUM_PARAM,'",',SUBSTRING(GOODS_RECEIVED_NOTELINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(GOODS_RECEIVED_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP goodsreceivednoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF GOODS_RECEIVED_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT goods_received_note_stock VALUES ';

goodsreceivednotestock_loop:LOOP
IF REGEXP_INSTR(GOODS_RECEIVED_NOTE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',GOODS_RECEIVED_NOTE_NUM_PARAM,'",',SUBSTRING(GOODS_RECEIVED_NOTE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE goodsreceivednotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(GOODS_RECEIVED_NOTE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',GOODS_RECEIVED_NOTE_NUM_PARAM,'",',SUBSTRING(GOODS_RECEIVED_NOTE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(GOODS_RECEIVED_NOTE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP goodsreceivednotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;


COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_JOURNAL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_JOURNAL`(IN JOURNAL_NUM_PARAM VARCHAR(20), IN JOURNAL_DATE_PARAM DATE,IN JOURNAL_DESC_PARAM VARCHAR(255), IN JOURNAL_NUM_OLD_PARAM VARCHAR(20), IN JOURNALLINE_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM journalline WHERE JOURNAL_NUM=JOURNAL_NUM_OLD_PARAM;
UPDATE journal SET JOURNAL_NUM=JOURNAL_NUM_PARAM, JOURNAL_DATE=JOURNAL_DATE_PARAM, JOURNAL_DESC=JOURNAL_DESC_PARAM WHERE JOURNAL_NUM=JOURNAL_NUM_OLD_PARAM;

IF JOURNALLINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT journalline VALUES ';

invoiceline_loop:LOOP
IF REGEXP_INSTR(JOURNALLINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',JOURNAL_NUM_PARAM,'",',SUBSTRING(JOURNALLINE_PARAM,POS),')') INTO @STRNG;
LEAVE invoiceline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(JOURNALLINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',JOURNAL_NUM_PARAM,'",',SUBSTRING(JOURNALLINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(JOURNALLINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP invoiceline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;



COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_PURCHASE_CREDIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_PURCHASE_CREDIT_NOTE`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN PURCHASE_CREDIT_NOTE_NUM_PARAM VARCHAR(20), IN PURCHASE_CREDIT_NOTE_DATE_PARAM DATE, IN PURCHASE_CREDIT_NOTE_DESC_PARAM VARCHAR(255), IN PURCHASE_CREDIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, PURCHASE_CREDIT_NOTE_NUM_OLD_PARAM VARCHAR(20), IN PURCHASE_CREDIT_NOTELINE_PARAM VARCHAR(255), IN OFFSET_ONE_PARAM VARCHAR(255), IN OFFSET_TWO_PARAM VARCHAR(255), IN PURCHASE_CREDIT_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE POS2 INT DEFAULT 1;
DECLARE POS3 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM purchase_credit_note_stock WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_OLD_PARAM;
DELETE FROM purchase_credit_noteline WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_OLD_PARAM;
DELETE FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_OLD_PARAM;
DELETE FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_OLD_PARAM;
UPDATE purchase_credit_note SET PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM, PURCHASE_CREDIT_NOTE_DATE=PURCHASE_CREDIT_NOTE_DATE_PARAM, PURCHASE_CREDIT_NOTE_DESC=PURCHASE_CREDIT_NOTE_DESC_PARAM, PURCHASE_CREDIT_NOTE_CREDIT_TERM=PURCHASE_CREDIT_NOTE_CREDIT_TERM_PARAM, CREDITOR_NUM=CREDITOR_NUM_PARAM, GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_OLD_PARAM;

IF PURCHASE_CREDIT_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_credit_noteline VALUES ';

purchasecreditnoteline_loop:LOOP
IF REGEXP_INSTR(PURCHASE_CREDIT_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_CREDIT_NOTELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE purchasecreditnoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_CREDIT_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_CREDIT_NOTELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_CREDIT_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP purchasecreditnoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_ONE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoice_purchase_credit_note VALUES ';

offset_one_loop:LOOP
IF REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1),')') INTO @STRNG;
LEAVE offset_one_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_ONE_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_ONE_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP offset_one_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF OFFSET_TWO_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_note_purchase_credit_note VALUES ';

offset_two_loop:LOOP
IF REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2),')') INTO @STRNG;
LEAVE offset_two_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2) - POS2) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(OFFSET_TWO_PARAM,POS2,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(OFFSET_TWO_PARAM,'=',POS2)+1) INTO POS2;
END;
END IF;
END LOOP offset_two_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF PURCHASE_CREDIT_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_credit_note_stock VALUES ';

purchasecreditnotestock_loop:LOOP
IF REGEXP_INSTR(PURCHASE_CREDIT_NOTE_STOCK_PARAM,'=',POS3)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_CREDIT_NOTE_STOCK_PARAM,POS3),')') INTO @STRNG;
LEAVE purchasecreditnotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_CREDIT_NOTE_STOCK_PARAM,'=',POS3) - POS3) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_CREDIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_CREDIT_NOTE_STOCK_PARAM,POS3,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_CREDIT_NOTE_STOCK_PARAM,'=',POS3)+1) INTO POS3;
END;
END IF;
END LOOP purchasecreditnotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_PURCHASE_DEBIT_NOTE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_PURCHASE_DEBIT_NOTE`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255),IN PURCHASE_DEBIT_NOTE_NUM_PARAM VARCHAR(50), IN PURCHASE_DEBIT_NOTE_DATE_PARAM DATE, IN PURCHASE_DEBIT_NOTE_DESC_PARAM VARCHAR(255), IN PURCHASE_DEBIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'),IN GL_ACC_NUM_PARAM INT, PURCHASE_DEBIT_NOTE_NUM_OLD_PARAM VARCHAR(50), IN PURCHASE_DEBIT_NOTELINE_PARAM VARCHAR(255), IN PURCHASE_DEBIT_NOTE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM purchase_debit_note_stock WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_OLD_PARAM;
DELETE FROM purchase_debit_noteline WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_OLD_PARAM;
UPDATE purchase_debit_note SET PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM, PURCHASE_DEBIT_NOTE_DATE=PURCHASE_DEBIT_NOTE_DATE_PARAM, PURCHASE_DEBIT_NOTE_DESC=PURCHASE_DEBIT_NOTE_DESC_PARAM,PURCHASE_DEBIT_NOTE_CREDIT_TERM=PURCHASE_DEBIT_NOTE_CREDIT_TERM_PARAM, CREDITOR_NUM=CREDITOR_NUM_PARAM, GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_OLD_PARAM;

IF PURCHASE_DEBIT_NOTELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_noteline VALUES ';

purchasedebitnoteline_loop:LOOP
IF REGEXP_INSTR(PURCHASE_DEBIT_NOTELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_DEBIT_NOTELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE purchasedebitnoteline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_DEBIT_NOTELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_DEBIT_NOTELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_DEBIT_NOTELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP purchasedebitnoteline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF PURCHASE_DEBIT_NOTE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_debit_note_stock VALUES ';

purchasedebitnotestock_loop:LOOP
IF REGEXP_INSTR(PURCHASE_DEBIT_NOTE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_DEBIT_NOTE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE purchasedebitnotestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_DEBIT_NOTE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_DEBIT_NOTE_NUM_PARAM,'",',SUBSTRING(PURCHASE_DEBIT_NOTE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_DEBIT_NOTE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP purchasedebitnotestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_PURCHASE_INVOICE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_PURCHASE_INVOICE`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255),IN PURCHASE_INVOICE_NUM_PARAM VARCHAR(50), IN PURCHASE_INVOICE_DATE_PARAM DATE, IN PURCHASE_INVOICE_DESC_PARAM VARCHAR(255),IN PURCHASE_INVOICE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, IN PURCHASE_INVOICE_NUM_OLD_PARAM VARCHAR(50), IN PURCHASE_INVOICELINE_PARAM VARCHAR(255), IN PURCHASE_INVOICE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM purchase_invoice_stock WHERE PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_OLD_PARAM;
DELETE FROM purchase_invoiceline WHERE PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_OLD_PARAM;
UPDATE purchase_invoice SET PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_PARAM, PURCHASE_INVOICE_DATE=PURCHASE_INVOICE_DATE_PARAM, PURCHASE_INVOICE_DESC=PURCHASE_INVOICE_DESC_PARAM, PURCHASE_INVOICE_CREDIT_TERM=PURCHASE_INVOICE_CREDIT_TERM_PARAM,CREDITOR_NUM=CREDITOR_NUM_PARAM, GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE PURCHASE_INVOICE_NUM=PURCHASE_INVOICE_NUM_OLD_PARAM;

IF PURCHASE_INVOICELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoiceline VALUES ';

invoiceline_loop:LOOP
IF REGEXP_INSTR(PURCHASE_INVOICELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_INVOICE_NUM_PARAM,'",',SUBSTRING(PURCHASE_INVOICELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE invoiceline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_INVOICELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_INVOICE_NUM_PARAM,'",',SUBSTRING(PURCHASE_INVOICELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_INVOICELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP invoiceline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF PURCHASE_INVOICE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_invoice_stock VALUES ';

purchaseinvoicestock_loop:LOOP
IF REGEXP_INSTR(PURCHASE_INVOICE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_INVOICE_NUM_PARAM,'",',SUBSTRING(PURCHASE_INVOICE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE purchaseinvoicestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_INVOICE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_INVOICE_NUM_PARAM,'",',SUBSTRING(PURCHASE_INVOICE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_INVOICE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP purchaseinvoicestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_PURCHASE_RETURN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_PURCHASE_RETURN`(IN CREDITOR_NUM_PARAM VARCHAR(20), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN PURCHASE_RETURN_NUM_PARAM VARCHAR(20), IN PURCHASE_RETURN_DATE_PARAM DATE, IN PURCHASE_RETURN_DESC_PARAM VARCHAR(255), PURCHASE_RETURN_NUM_OLD_PARAM VARCHAR(20), IN PURCHASE_RETURNLINE_PARAM VARCHAR(255), IN PURCHASE_RETURN_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM purchase_return_stock WHERE PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_OLD_PARAM;
DELETE FROM purchase_returnline WHERE PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_OLD_PARAM;
UPDATE purchase_return SET PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_PARAM, PURCHASE_RETURN_DATE=PURCHASE_RETURN_DATE_PARAM, PURCHASE_RETURN_DESC=PURCHASE_RETURN_DESC_PARAM, CREDITOR_NUM=CREDITOR_NUM_PARAM WHERE PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_OLD_PARAM;

IF PURCHASE_RETURNLINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_returnline VALUES ';

purchasereturnline_loop:LOOP
IF REGEXP_INSTR(PURCHASE_RETURNLINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_RETURN_NUM_PARAM,'",',SUBSTRING(PURCHASE_RETURNLINE_PARAM,POS),')') INTO @STRNG;
LEAVE purchasereturnline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_RETURNLINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_RETURN_NUM_PARAM,'",',SUBSTRING(PURCHASE_RETURNLINE_PARAM,POS,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_RETURNLINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP purchasereturnline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF PURCHASE_RETURN_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT purchase_return_stock VALUES ';

purchasereturnstock_loop:LOOP
IF REGEXP_INSTR(PURCHASE_RETURN_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',PURCHASE_RETURN_NUM_PARAM,'",',SUBSTRING(PURCHASE_RETURN_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE purchasereturnstock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(PURCHASE_RETURN_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',PURCHASE_RETURN_NUM_PARAM,'",',SUBSTRING(PURCHASE_RETURN_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(PURCHASE_RETURN_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP purchasereturnstock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_SALES_INVOICE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_SALES_INVOICE`(IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN SALES_INVOICE_NUM_PARAM VARCHAR(20), IN SALES_INVOICE_DATE_PARAM DATE, IN SALES_INVOICE_DESC_PARAM VARCHAR(255), IN SALES_INVOICE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, SALES_INVOICE_NUM_OLD_PARAM VARCHAR(20), IN SALES_INVOICELINE_PARAM VARCHAR(255), IN SALES_INVOICE_STOCK_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
DECLARE POS1 INT DEFAULT 1;
DECLARE LENGTH INT DEFAULT 0;
DECLARE DONE VARCHAR(20) DEFAULT 'NO';

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
DELETE FROM sales_invoice_stock WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_OLD_PARAM;
DELETE FROM sales_invoiceline WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_OLD_PARAM;
UPDATE sales_invoice SET SALES_INVOICE_NUM=SALES_INVOICE_NUM_PARAM, SALES_INVOICE_DATE=SALES_INVOICE_DATE_PARAM, SALES_INVOICE_DESC=SALES_INVOICE_DESC_PARAM,SALES_INVOICE_CREDIT_TERM=SALES_INVOICE_CREDIT_TERM_PARAM, DEBTOR_NUM=DEBTOR_NUM_PARAM, GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_OLD_PARAM;

IF SALES_INVOICELINE_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoiceline VALUES ';

invoiceline_loop:LOOP
IF REGEXP_INSTR(SALES_INVOICELINE_PARAM,'=',POS)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',SALES_INVOICE_NUM_PARAM,'",',SUBSTRING(SALES_INVOICELINE_PARAM,POS),',DEFAULT)') INTO @STRNG;
LEAVE invoiceline_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(SALES_INVOICELINE_PARAM,'=',POS) - POS) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',SALES_INVOICE_NUM_PARAM,'",',SUBSTRING(SALES_INVOICELINE_PARAM,POS,LENGTH),',DEFAULT),') INTO @STRNG;
SELECT (REGEXP_INSTR(SALES_INVOICELINE_PARAM,'=',POS)+1) INTO POS;
END;
END IF;
END LOOP invoiceline_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

IF SALES_INVOICE_STOCK_PARAM IS NOT NULL THEN 
BEGIN
SET @STRNG ='INSERT sales_invoice_stock VALUES ';

salesinvoicestock_loop:LOOP
IF REGEXP_INSTR(SALES_INVOICE_STOCK_PARAM,'=',POS1)=0 THEN 
BEGIN
SELECT CONCAT(@STRNG,'("',SALES_INVOICE_NUM_PARAM,'",',SUBSTRING(SALES_INVOICE_STOCK_PARAM,POS1),')') INTO @STRNG;
LEAVE salesinvoicestock_loop;
END;
ELSE 
BEGIN 
SELECT (REGEXP_INSTR(SALES_INVOICE_STOCK_PARAM,'=',POS1) - POS1) INTO LENGTH;
SELECT CONCAT(@STRNG,'("',SALES_INVOICE_NUM_PARAM,'",',SUBSTRING(SALES_INVOICE_STOCK_PARAM,POS1,LENGTH),'),') INTO @STRNG;
SELECT (REGEXP_INSTR(SALES_INVOICE_STOCK_PARAM,'=',POS1)+1) INTO POS1;
END;
END IF;
END LOOP salesinvoicestock_loop;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END;
END IF;

COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_STOCK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `UPDATE_STOCK`(IN STOCK_NUM_PARAM VARCHAR(20),IN STOCK_DESC_PARAM VARCHAR(255), IN STOCK_PRICE_PARAM DEC(10,2), IN STOCK_MINPRICE_PARAM DEC(10,2), IN STOCK_MAXPRICE_PARAM DEC(10,2),IN STOCK_COST_PARAM DEC(10,2),IN STOCK_MINQTY_PARAM INT,IN STOCK_MAXQTY_PARAM INT, IN STOCK_NUM_OLD_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
UPDATE stock SET STOCK_NUM=STOCK_NUM_PARAM, STOCK_DESC=STOCK_DESC_PARAM,STOCK_PRICE=STOCK_PRICE_PARAM,STOCK_MINPRICE=STOCK_MINPRICE_PARAM,STOCK_MAXPRICE=STOCK_MAXPRICE_PARAM,STOCK_COST=STOCK_COST_PARAM,STOCK_MINQTY=STOCK_MINQTY_PARAM,STOCK_MAXQTY=STOCK_MAXQTY_PARAM WHERE STOCK_NUM=STOCK_NUM_OLD_PARAM;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-19 15:52:48

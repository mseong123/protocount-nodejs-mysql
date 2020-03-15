DELIMITER //
CREATE PROCEDURE INSERT_CASH_RECEIPT (IN CASH_RECEIPT_NUM_PARAM VARCHAR(10), IN DEBTOR_NUM_PARAM VARCHAR(10), IN CASH_RECEIPT_DATE_PARAM DATE, IN CASH_RECEIPT_METHOD_PARAM VARCHAR(45),IN CASH_RECEIPT_TRANSACTION_ID_PARAM VARCHAR(45),IN CASH_RECEIPT_DESC_PARAM VARCHAR(255),IN CASH_RECEIPT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM1_PARAM INT,IN GL_ACC_NUM2_PARAM INT,IN CASH_RECEIPT_NUM_OLD_PARAM VARCHAR(10), IN OFFSET_ONE_PARAM VARCHAR(255),IN OFFSET_TWO_PARAM VARCHAR(255))
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
END











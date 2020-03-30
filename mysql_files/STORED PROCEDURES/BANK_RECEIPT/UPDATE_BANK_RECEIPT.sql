DELIMITER //
CREATE PROCEDURE UPDATE_BANK_RECEIPT (IN BANK_RECEIPT_NUM_PARAM VARCHAR(20),IN BANK_NUM_PARAM VARCHAR(20), IN DEBTOR_NUM_PARAM VARCHAR(20), IN BANK_RECEIPT_DATE_PARAM DATE, IN BANK_RECEIPT_METHOD_PARAM VARCHAR(45),IN BANK_RECEIPT_TRANSACTION_ID_PARAM VARCHAR(45),IN BANK_RECEIPT_DESC_PARAM VARCHAR(255),IN BANK_RECEIPT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM_PARAM INT,IN BANK_RECEIPT_NUM_OLD_PARAM VARCHAR(20), IN OFFSET_ONE_PARAM VARCHAR(255), IN OFFSET_TWO_PARAM VARCHAR(255))
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
END//

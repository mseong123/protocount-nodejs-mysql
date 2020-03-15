DELIMITER //
CREATE PROCEDURE INSERT_BANK_PAYMENT (IN BANK_PAYMENT_NUM_PARAM VARCHAR(10),IN BANK_NUM_PARAM VARCHAR(10), IN CREDITOR_NUM_PARAM VARCHAR(10), IN BANK_PAYMENT_DATE_PARAM DATE, IN BANK_PAYMENT_METHOD_PARAM VARCHAR(45),IN BANK_PAYMENT_TRANSACTION_ID_PARAM VARCHAR(45),IN BANK_PAYMENT_DESC_PARAM VARCHAR(255),IN BANK_PAYMENT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM_PARAM INT,IN BANK_PAYMENT_NUM_OLD_PARAM VARCHAR(10), IN OFFSET_ONE_PARAM VARCHAR(255),IN OFFSET_TWO_PARAM VARCHAR(255))
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
END











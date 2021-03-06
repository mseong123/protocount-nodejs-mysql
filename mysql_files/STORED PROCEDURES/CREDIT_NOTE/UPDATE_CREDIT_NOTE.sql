DELIMITER //
CREATE PROCEDURE UPDATE_CREDIT_NOTE (IN DEBTOR_NUM_PARAM VARCHAR(20), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN CREDIT_NOTE_NUM_PARAM VARCHAR(20), IN CREDIT_NOTE_DATE_PARAM DATE, IN CREDIT_NOTE_DESC_PARAM VARCHAR(255), IN CREDIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, CREDIT_NOTE_NUM_OLD_PARAM VARCHAR(20), IN CREDIT_NOTELINE_PARAM VARCHAR(255), IN OFFSET_ONE_PARAM VARCHAR(255), IN OFFSET_TWO_PARAM VARCHAR(255), IN CREDIT_NOTE_STOCK_PARAM VARCHAR(255))
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
END//
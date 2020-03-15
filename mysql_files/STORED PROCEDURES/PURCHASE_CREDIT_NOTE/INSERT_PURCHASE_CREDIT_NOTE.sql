DELIMITER //
CREATE PROCEDURE INSERT_PURCHASE_CREDIT_NOTE (IN CREDITOR_NUM_PARAM VARCHAR(10), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN PURCHASE_CREDIT_NOTE_NUM_PARAM VARCHAR(10), IN PURCHASE_CREDIT_NOTE_DATE_PARAM DATE, IN PURCHASE_CREDIT_NOTE_DESC_PARAM VARCHAR(255), IN GL_ACC_NUM_PARAM INT, IN PURCHASE_CREDIT_NOTE_NUM_OLD_PARAM VARCHAR(10), IN PURCHASE_CREDIT_NOTELINE_PARAM VARCHAR(255), IN OFFSET_ONE_PARAM VARCHAR(255),IN OFFSET_TWO_PARAM VARCHAR(255))
BEGIN
DECLARE POS INT DEFAULT 1;
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

INSERT purchase_credit_note VALUES(PURCHASE_CREDIT_NOTE_NUM_PARAM,PURCHASE_CREDIT_NOTE_DATE_PARAM,PURCHASE_CREDIT_NOTE_DESC_PARAM,CREDITOR_NUM_PARAM,GL_ACC_NUM_PARAM);

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

COMMIT;
END//
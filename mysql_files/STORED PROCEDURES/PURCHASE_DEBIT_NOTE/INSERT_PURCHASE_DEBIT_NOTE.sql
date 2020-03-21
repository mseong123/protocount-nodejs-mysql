DELIMITER //
CREATE PROCEDURE INSERT_PURCHASE_DEBIT_NOTE (IN CREDITOR_NUM_PARAM VARCHAR(10), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN CREDITOR_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'),IN PURCHASE_DEBIT_NOTE_NUM_PARAM VARCHAR(50), IN PURCHASE_DEBIT_NOTE_DATE_PARAM DATE, IN PURCHASE_DEBIT_NOTE_DESC_PARAM VARCHAR(255),IN PURCHASE_DEBIT_NOTE_CREDIT_TERM_PARAM ENUM('COD','30','45','60','90'), IN GL_ACC_NUM_PARAM INT, IN PURCHASE_DEBIT_NOTE_NUM_OLD_PARAM VARCHAR(50), IN PURCHASE_DEBIT_NOTELINE_PARAM VARCHAR(255))
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



COMMIT;
END//
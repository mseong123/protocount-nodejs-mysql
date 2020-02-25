DELIMITER //
CREATE PROCEDURE UPDATE_DEBIT_NOTE (IN DEBTOR_NUM_PARAM VARCHAR(10), IN DEBTOR_NAME_PARAM VARCHAR(255),IN DEBTOR_ADDRESS_PARAM VARCHAR(255), IN DEBIT_NOTE_NUM_PARAM VARCHAR(10), IN DEBIT_NOTE_DATE_PARAM DATE, IN DEBIT_NOTE_DESC_PARAM VARCHAR(255), IN GL_ACC_NUM_PARAM INT, DEBIT_NOTE_NUM_OLD_PARAM VARCHAR(10), IN DEBIT_NOTELINE_PARAM VARCHAR(255))
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
DELETE FROM debit_noteline WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_OLD_PARAM;
UPDATE debit_note SET DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_PARAM, DEBIT_NOTE_DATE=DEBIT_NOTE_DATE_PARAM, DEBIT_NOTE_DESC=DEBIT_NOTE_DESC_PARAM, DEBTOR_NUM=DEBTOR_NUM_PARAM, GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE DEBIT_NOTE_NUM=DEBIT_NOTE_NUM_OLD_PARAM;

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



COMMIT;
END//
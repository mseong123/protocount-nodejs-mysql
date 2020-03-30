DELIMITER //
CREATE PROCEDURE UPDATE_JOURNAL (IN JOURNAL_NUM_PARAM VARCHAR(20), IN JOURNAL_DATE_PARAM DATE,IN JOURNAL_DESC_PARAM VARCHAR(255), IN JOURNAL_NUM_OLD_PARAM VARCHAR(20), IN JOURNALLINE_PARAM VARCHAR(255))
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
END//
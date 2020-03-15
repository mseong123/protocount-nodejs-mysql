DELIMITER //
CREATE PROCEDURE UPDATE_PURCHASE_RETURN (IN CREDITOR_NUM_PARAM VARCHAR(10), IN CREDITOR_NAME_PARAM VARCHAR(255),IN CREDITOR_ADDRESS_PARAM VARCHAR(255), IN PURCHASE_RETURN_NUM_PARAM VARCHAR(10), IN PURCHASE_RETURN_DATE_PARAM DATE, IN PURCHASE_RETURN_DESC_PARAM VARCHAR(255), PURCHASE_RETURN_NUM_OLD_PARAM VARCHAR(10), IN PURCHASE_RETURNLINE_PARAM VARCHAR(255))
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



COMMIT;
END//
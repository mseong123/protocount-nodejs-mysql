
DELIMITER //
CREATE PROCEDURE DELETE_PURCHASE_CREDIT_NOTE (IN PURCHASE_CREDIT_NOTE_NUM_PARAM VARCHAR(255))
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
END//
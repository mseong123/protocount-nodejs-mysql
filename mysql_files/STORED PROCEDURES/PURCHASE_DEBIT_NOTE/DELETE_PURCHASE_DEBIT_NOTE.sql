
DELIMITER //
CREATE PROCEDURE DELETE_PURCHASE_DEBIT_NOTE (IN PURCHASE_DEBIT_NOTE_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM purchase_debit_noteline WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note_cash_payment WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note_bank_payment WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM purchase_debit_note WHERE PURCHASE_DEBIT_NOTE_NUM IN (';
SELECT CONCAT(@STRNG,PURCHASE_DEBIT_NOTE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END//
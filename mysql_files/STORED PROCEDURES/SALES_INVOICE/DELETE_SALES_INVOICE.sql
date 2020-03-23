
DELIMITER //
CREATE PROCEDURE DELETE_SALES_INVOICE (IN SALES_INVOICE_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM sales_invoiceline WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoice_cash_receipt WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoice_bank_receipt WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoice_credit_note WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM sales_invoice WHERE SALES_INVOICE_NUM IN (';
SELECT CONCAT(@STRNG,SALES_INVOICE_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END//
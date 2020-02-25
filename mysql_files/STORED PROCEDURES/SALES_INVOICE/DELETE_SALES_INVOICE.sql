
DELIMITER //
CREATE PROCEDURE DELETE_SALES_INVOICE (IN SALES_INVOICE_NUM_PARAM VARCHAR(10))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
DELETE FROM sales_invoiceline WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_PARAM;
DELETE FROM sales_invoice WHERE SALES_INVOICE_NUM=SALES_INVOICE_NUM_PARAM;
COMMIT;
END//
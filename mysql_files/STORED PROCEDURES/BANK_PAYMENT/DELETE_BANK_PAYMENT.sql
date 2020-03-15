
DELIMITER //
CREATE PROCEDURE DELETE_BANK_PAYMENT (IN BANK_PAYMENT_NUM_PARAM VARCHAR(10))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
DELETE FROM purchase_invoice_bank_payment WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_PARAM;
DELETE FROM purchase_debit_note_bank_payment WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_PARAM;
DELETE FROM bank_payment WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_PARAM;
COMMIT;
END//

DELIMITER //
CREATE PROCEDURE DELETE_CREDIT_NOTE (IN CREDIT_NOTE_NUM_PARAM VARCHAR(10))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
DELETE FROM credit_noteline WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;
DELETE FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;
DELETE FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;
DELETE FROM credit_note WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;
COMMIT;
END//
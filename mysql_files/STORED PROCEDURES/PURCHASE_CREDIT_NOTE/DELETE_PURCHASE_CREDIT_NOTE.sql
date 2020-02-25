
DELIMITER //
CREATE PROCEDURE DELETE_PURCHASE_CREDIT_NOTE (IN PURCHASE_CREDIT_NOTE_NUM_PARAM VARCHAR(10))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
DELETE FROM purchase_credit_noteline WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
DELETE FROM purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
COMMIT;
END//
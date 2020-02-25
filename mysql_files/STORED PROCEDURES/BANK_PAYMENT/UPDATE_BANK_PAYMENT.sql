DELIMITER //
CREATE PROCEDURE UPDATE_BANK_PAYMENT (IN BANK_PAYMENT_NUM_PARAM VARCHAR(10),IN BANK_NUM_PARAM VARCHAR(10), IN CREDITOR_NUM_PARAM VARCHAR(10), IN BANK_PAYMENT_DATE_PARAM DATE, IN BANK_PAYMENT_METHOD_PARAM VARCHAR(45),IN BANK_PAYMENT_TRANSACTION_ID_PARAM VARCHAR(45),IN BANK_PAYMENT_DESC_PARAM VARCHAR(255),IN BANK_PAYMENT_AMOUNT_PARAM DECIMAL(10,2),IN GL_ACC_NUM_PARAM INT,IN BANK_PAYMENT_NUM_OLD_PARAM VARCHAR(10))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
UPDATE bank_payment SET BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_PARAM,BANK_NUM=BANK_NUM_PARAM,CREDITOR_NUM=CREDITOR_NUM_PARAM,BANK_PAYMENT_DATE=BANK_PAYMENT_DATE_PARAM,BANK_PAYMENT_METHOD=BANK_PAYMENT_METHOD_PARAM,BANK_PAYMENT_TRANSACTION_ID=BANK_PAYMENT_TRANSACTION_ID_PARAM,BANK_PAYMENT_DESC=BANK_PAYMENT_DESC_PARAM,BANK_PAYMENT_AMOUNT=BANK_PAYMENT_AMOUNT_PARAM,GL_ACC_NUM=GL_ACC_NUM_PARAM WHERE BANK_PAYMENT_NUM=BANK_PAYMENT_NUM_OLD_PARAM;
COMMIT;
END//

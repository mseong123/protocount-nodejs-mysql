
DELIMITER //
CREATE PROCEDURE SELECT_CREDIT_NOTE(IN CREDIT_NOTE_NUM_PARAM VARCHAR(10))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBTOR_NUM, DEBTOR_NAME, DEBTOR_ADDRESS, CREDIT_NOTE_NUM,CREDIT_NOTE_DATE,CREDIT_NOTE_DESC, credit_note.GL_ACC_NUM, CREDIT_NOTE_NUM AS CREDIT_NOTE_NUM_OLD FROM debtor JOIN credit_note USING (DEBTOR_NUM) WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;
SELECT CREDIT_NOTELINE_LINENUMBER,CREDIT_NOTELINE_STOCK_NUM,CREDIT_NOTELINE_STOCK_DESC,CREDIT_NOTELINE_STOCK_PRICE,CREDIT_NOTELINE_STOCK_QTY,CREDIT_NOTELINE_DISCOUNT FROM credit_noteline WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;
COMMIT;
END//
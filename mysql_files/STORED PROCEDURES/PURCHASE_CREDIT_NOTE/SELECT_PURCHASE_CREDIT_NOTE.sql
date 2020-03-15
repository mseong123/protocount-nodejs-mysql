
DELIMITER //
CREATE PROCEDURE SELECT_PURCHASE_CREDIT_NOTE(IN PURCHASE_CREDIT_NOTE_NUM_PARAM VARCHAR(10))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDITOR_NUM, CREDITOR_NAME, CREDITOR_ADDRESS, PURCHASE_CREDIT_NOTE_NUM,PURCHASE_CREDIT_NOTE_DATE,PURCHASE_CREDIT_NOTE_DESC, purchase_credit_note.GL_ACC_NUM, PURCHASE_CREDIT_NOTE_NUM AS PURCHASE_CREDIT_NOTE_NUM_OLD FROM creditor JOIN purchase_credit_note USING (CREDITOR_NUM) WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
SELECT PURCHASE_CREDIT_NOTELINE_LINENUMBER,PURCHASE_CREDIT_NOTELINE_STOCK_NUM,PURCHASE_CREDIT_NOTELINE_STOCK_DESC,PURCHASE_CREDIT_NOTELINE_STOCK_PRICE,PURCHASE_CREDIT_NOTELINE_STOCK_QTY,PURCHASE_CREDIT_NOTELINE_DISCOUNT FROM purchase_credit_noteline WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
SELECT PURCHASE_INVOICE_NUM,PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
SELECT PURCHASE_DEBIT_NOTE_NUM,PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=PURCHASE_CREDIT_NOTE_NUM_PARAM;
COMMIT;
END//
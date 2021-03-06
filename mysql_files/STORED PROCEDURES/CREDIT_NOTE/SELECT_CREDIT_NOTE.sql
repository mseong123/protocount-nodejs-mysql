
DELIMITER //
CREATE PROCEDURE SELECT_CREDIT_NOTE(IN CREDIT_NOTE_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBTOR_NUM, DEBTOR_NAME, DEBTOR_ADDRESS, CREDIT_NOTE_NUM,CREDIT_NOTE_DATE,CREDIT_NOTE_DESC,CREDIT_NOTE_CREDIT_TERM, credit_note.GL_ACC_NUM, CREDIT_NOTE_NUM AS CREDIT_NOTE_NUM_OLD FROM debtor JOIN credit_note USING (DEBTOR_NUM) WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;
SELECT CREDIT_NOTELINE_LINENUMBER,CREDIT_NOTELINE_STOCK_NUM,CREDIT_NOTELINE_STOCK_DESC,CREDIT_NOTELINE_STOCK_PRICE,CREDIT_NOTELINE_STOCK_QTY,CREDIT_NOTELINE_DISCOUNT FROM credit_noteline WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;

SELECT SALES_INVOICE_NUM,SALES_INVOICE_CREDIT_NOTE_AMOUNT FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;

SELECT DEBIT_NOTE_NUM,DEBIT_NOTE_CREDIT_NOTE_AMOUNT FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;

SELECT CREDIT_NOTELINE_LINENUMBER,STOCK_NUM,CREDIT_NOTE_STOCK_QTY FROM credit_note_stock WHERE CREDIT_NOTE_NUM=CREDIT_NOTE_NUM_PARAM;

COMMIT;
END//
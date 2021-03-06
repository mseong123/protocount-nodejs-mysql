DELIMITER //
CREATE PROCEDURE SELECT_DEBTOR_COLLECTION(IN DATE_START_PARAM VARCHAR(255), IN DATE_END_PARAM VARCHAR(255), IN DEBTOR_NUM_PARAM VARCHAR(255)) 
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG='';

SELECT CONCAT("SELECT DEBTOR_NUM,DEBTOR_NAME,BANK_RECEIPT_NUM AS NUM,BANK_RECEIPT_DATE AS DATE,'BANK RECEIPT' AS TYPE,BANK_RECEIPT_METHOD AS METHOD,BANK_RECEIPT_TRANSACTION_ID AS 'TRANSACTION ID', BANK_RECEIPT_AMOUNT AS AMOUNT FROM bank_receipt JOIN debtor USING (DEBTOR_NUM) WHERE BANK_RECEIPT_DATE>=",DATE_START_PARAM," AND BANK_RECEIPT_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,")
UNION ALL (SELECT DEBTOR_NUM,DEBTOR_NAME,CASH_RECEIPT_NUM,CASH_RECEIPT_DATE,'CASH RECEIPT',CASH_RECEIPT_METHOD,CASH_RECEIPT_TRANSACTION_ID, CASH_RECEIPT_AMOUNT AS AMOUNT FROM cash_receipt JOIN debtor USING (DEBTOR_NUM) WHERE CASH_RECEIPT_DATE>=",DATE_START_PARAM," AND CASH_RECEIPT_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,")) ORDER BY DEBTOR_NUM,DATE") INTO @STRNG; 

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG='';

SELECT CONCAT("SELECT BANK_RECEIPT_NUM AS 'RECEIPT DOC NUM',SALES_INVOICE_NUM AS 'DOC NUM','SALES INVOICE' AS 'DOC TYPE', SALES_INVOICE_DATE AS 'DOC DATE', SALES_INVOICE_CREDIT_TERM AS 'CREDIT TERM', SUM(SALES_INVOICELINE_SUBTOTAL) AS 'DOC AMOUNT',SALES_INVOICE_BANK_RECEIPT_AMOUNT AS 'RECEIPT AMOUNT' FROM sales_invoice_bank_receipt NATURAL JOIN sales_invoice NATURAL JOIN sales_invoiceline WHERE SALES_INVOICE_DATE>=",DATE_START_PARAM," AND SALES_INVOICE_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") GROUP BY BANK_RECEIPT_NUM,SALES_INVOICE_NUM
UNION ALL (SELECT CASH_RECEIPT_NUM,SALES_INVOICE_NUM,'SALES INVOICE', SALES_INVOICE_DATE, SALES_INVOICE_CREDIT_TERM, SUM(SALES_INVOICELINE_SUBTOTAL),SALES_INVOICE_CASH_RECEIPT_AMOUNT FROM sales_invoice_cash_receipt NATURAL JOIN sales_invoice NATURAL JOIN sales_invoiceline WHERE SALES_INVOICE_DATE>=",DATE_START_PARAM," AND SALES_INVOICE_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") GROUP BY CASH_RECEIPT_NUM,SALES_INVOICE_NUM)
UNION ALL (SELECT BANK_RECEIPT_NUM,DEBIT_NOTE_NUM,'DEBIT NOTE', DEBIT_NOTE_DATE, DEBIT_NOTE_CREDIT_TERM, SUM(DEBIT_NOTELINE_SUBTOTAL),DEBIT_NOTE_BANK_RECEIPT_AMOUNT FROM debit_note_bank_receipt NATURAL JOIN debit_note NATURAL JOIN debit_noteline WHERE DEBIT_NOTE_DATE>=",DATE_START_PARAM," AND DEBIT_NOTE_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") GROUP BY BANK_RECEIPT_NUM,DEBIT_NOTE_NUM)
UNION ALL (SELECT CASH_RECEIPT_NUM,DEBIT_NOTE_NUM,'DEBIT NOTE', DEBIT_NOTE_DATE, DEBIT_NOTE_CREDIT_TERM, SUM(DEBIT_NOTELINE_SUBTOTAL),DEBIT_NOTE_CASH_RECEIPT_AMOUNT FROM debit_note_cash_receipt NATURAL JOIN debit_note NATURAL JOIN debit_noteline WHERE DEBIT_NOTE_DATE>=",DATE_START_PARAM," AND DEBIT_NOTE_DATE<=",DATE_END_PARAM," AND DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") GROUP BY CASH_RECEIPT_NUM,DEBIT_NOTE_NUM) ORDER BY 'RECEIPT DOC NUM','DOC DATE'")INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END//
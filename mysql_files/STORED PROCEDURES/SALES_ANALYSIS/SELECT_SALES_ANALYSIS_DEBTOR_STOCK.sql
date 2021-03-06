DELIMITER //
CREATE PROCEDURE SELECT_SALES_ANALYSIS_DEBTOR_STOCK(IN DATE_START_PARAM VARCHAR(255), IN DATE_END_PARAM VARCHAR(255), IN DEBTOR_NUM_PARAM VARCHAR(255), IN STOCK_NUM_PARAM VARCHAR(255)) 
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG='';

SELECT CONCAT("SELECT DEBTOR_NUM,DEBTOR_NAME,SALES_INVOICE_DATE AS DATE,SUM(SALES_INVOICELINE_SUBTOTAL) AS SUBTOTAL FROM debtor JOIN sales_invoice USING (DEBTOR_NUM) NATURAL JOIN sales_invoiceline WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") AND SALES_INVOICE_DATE>=",DATE_START_PARAM," AND SALES_INVOICE_DATE<=",DATE_END_PARAM," GROUP BY SALES_INVOICE_NUM
UNION ALL (SELECT DEBTOR_NUM,DEBTOR_NAME,DEBIT_NOTE_DATE,SUM(DEBIT_NOTELINE_SUBTOTAL) FROM debtor JOIN debit_note USING (DEBTOR_NUM) NATURAL JOIN debit_noteline WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") AND DEBIT_NOTE_DATE>=",DATE_START_PARAM," AND DEBIT_NOTE_DATE<=",DATE_END_PARAM," GROUP BY DEBIT_NOTE_NUM)
UNION ALL (SELECT DEBTOR_NUM,DEBTOR_NAME,CREDIT_NOTE_DATE,-SUM(CREDIT_NOTELINE_SUBTOTAL) FROM debtor JOIN credit_note USING (DEBTOR_NUM) NATURAL JOIN credit_noteline WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") AND CREDIT_NOTE_DATE>=",DATE_START_PARAM," AND CREDIT_NOTE_DATE<=",DATE_END_PARAM," GROUP BY CREDIT_NOTE_NUM)
ORDER BY DEBTOR_NUM,DATE") INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG='';

SELECT CONCAT("SELECT DEBTOR_NUM,SALES_INVOICELINE_STOCK_NUM AS 'STOCK NUM',(SELECT STOCK_DESC FROM stock WHERE STOCK_NUM = SALES_INVOICELINE_STOCK_NUM) AS 'STOCK DESC',SALES_INVOICE_DATE AS DATE, SUM(SALES_INVOICELINE_STOCK_QTY) AS QTY,SUM(SALES_INVOICELINE_SUBTOTAL) AS SUBTOTAL FROM debtor JOIN sales_invoice USING (DEBTOR_NUM) NATURAL JOIN sales_invoiceline WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") AND SALES_INVOICELINE_STOCK_NUM IN (",STOCK_NUM_PARAM,") AND SALES_INVOICE_DATE>=",DATE_START_PARAM," AND SALES_INVOICE_DATE<=",DATE_END_PARAM," GROUP BY SALES_INVOICELINE_STOCK_NUM,SALES_INVOICE_NUM
UNION ALL (SELECT DEBTOR_NUM,DEBIT_NOTELINE_STOCK_NUM,(SELECT STOCK_DESC FROM stock WHERE STOCK_NUM = DEBIT_NOTELINE_STOCK_NUM),DEBIT_NOTE_DATE,SUM(DEBIT_NOTELINE_STOCK_QTY),SUM(DEBIT_NOTELINE_SUBTOTAL) FROM debtor JOIN debit_note USING (DEBTOR_NUM) NATURAL JOIN debit_noteline WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") AND DEBIT_NOTELINE_STOCK_NUM IN (",STOCK_NUM_PARAM,") AND DEBIT_NOTE_DATE>=",DATE_START_PARAM," AND DEBIT_NOTE_DATE<=",DATE_END_PARAM," GROUP BY DEBIT_NOTELINE_STOCK_NUM,DEBIT_NOTE_NUM) 
UNION ALL (SELECT DEBTOR_NUM,CREDIT_NOTELINE_STOCK_NUM,(SELECT STOCK_DESC FROM stock WHERE STOCK_NUM = CREDIT_NOTELINE_STOCK_NUM),CREDIT_NOTE_DATE,-SUM(CREDIT_NOTELINE_STOCK_QTY),-SUM(CREDIT_NOTELINE_SUBTOTAL) FROM debtor JOIN credit_note USING (DEBTOR_NUM) NATURAL JOIN credit_noteline WHERE DEBTOR_NUM IN (",DEBTOR_NUM_PARAM,") AND CREDIT_NOTELINE_STOCK_NUM IN (",STOCK_NUM_PARAM,") AND CREDIT_NOTE_DATE>=",DATE_START_PARAM," AND CREDIT_NOTE_DATE<=",DATE_END_PARAM," GROUP BY CREDIT_NOTELINE_STOCK_NUM,CREDIT_NOTE_NUM) 
ORDER BY 'STOCK NUM',DATE") INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END//
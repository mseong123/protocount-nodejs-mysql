DELIMITER //
CREATE PROCEDURE SELECT_CREDITOR_STATEMENT(IN DATE_START_PARAM DATE, IN DATE_END_PARAM DATE, IN CREDITOR_NUM_PARAM VARCHAR(20)) 
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT IFNULL((SELECT SUM(PURCHASE_INVOICELINE_SUBTOTAL) FROM creditor JOIN purchase_invoice USING (CREDITOR_NUM) NATURAL JOIN purchase_invoiceline WHERE PURCHASE_INVOICE_DATE<DATE_START_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM),0)
+IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) FROM creditor JOIN purchase_debit_note USING (CREDITOR_NUM) NATURAL JOIN purchase_debit_noteline WHERE PURCHASE_DEBIT_NOTE_DATE<DATE_START_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM),0)
-IFNULL((SELECT SUM(CASH_PAYMENT_AMOUNT) FROM cash_payment JOIN creditor USING(CREDITOR_NUM) WHERE CASH_PAYMENT_DATE<DATE_START_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM),0)
-IFNULL((SELECT SUM(BANK_PAYMENT_AMOUNT) FROM bank_payment JOIN creditor USING(CREDITOR_NUM) WHERE BANK_PAYMENT_DATE<DATE_START_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM),0)
-IFNULL((SELECT SUM(PURCHASE_CREDIT_NOTELINE_SUBTOTAL) FROM creditor join purchase_credit_note USING (CREDITOR_NUM) NATURAL JOIN purchase_credit_noteline WHERE PURCHASE_CREDIT_NOTE_DATE<DATE_START_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM),0)
AS 'B/F';

SELECT PURCHASE_INVOICE_DATE AS DATE, PURCHASE_INVOICE_NUM AS NUM, NULL AS REF, 'PURCHASE INVOICE' AS TYPE, NULL AS DR, SUM(PURCHASE_INVOICELINE_SUBTOTAL) AS CR FROM creditor JOIN purchase_invoice USING (CREDITOR_NUM) NATURAL JOIN purchase_invoiceline WHERE PURCHASE_INVOICE_DATE>=DATE_START_PARAM AND PURCHASE_INVOICE_DATE<=DATE_END_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM GROUP BY PURCHASE_INVOICE_NUM 
UNION ALL (SELECT PURCHASE_DEBIT_NOTE_DATE, PURCHASE_DEBIT_NOTE_NUM, NULL,'PURCHASE DEBIT NOTE', NULL, SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) FROM creditor JOIN purchase_debit_note USING (CREDITOR_NUM) NATURAL JOIN purchase_debit_noteline WHERE PURCHASE_DEBIT_NOTE_DATE>=DATE_START_PARAM AND PURCHASE_DEBIT_NOTE_DATE<=DATE_END_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM GROUP BY PURCHASE_DEBIT_NOTE_NUM) 
UNION ALL (SELECT CASH_PAYMENT_DATE AS DATE, CASH_PAYMENT_NUM, CASH_PAYMENT_TRANSACTION_ID, 'CASH PAYMENT', CASH_PAYMENT_AMOUNT,NULL from creditor JOIN cash_payment USING (CREDITOR_NUM) WHERE CASH_PAYMENT_DATE>=DATE_START_PARAM AND CASH_PAYMENT_DATE<=DATE_END_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM) 
UNION ALL (SELECT BANK_PAYMENT_DATE AS DATE, BANK_PAYMENT_NUM, BANK_PAYMENT_TRANSACTION_ID, 'BANK PAYMENT', BANK_PAYMENT_AMOUNT,NULL from creditor JOIN bank_payment USING (CREDITOR_NUM) WHERE BANK_PAYMENT_DATE>=DATE_START_PARAM AND BANK_PAYMENT_DATE<=DATE_END_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM)
UNION ALL (SELECT PURCHASE_CREDIT_NOTE_DATE,PURCHASE_CREDIT_NOTE_NUM, NULL, 'PURCHASE CREDIT NOTE', SUM(PURCHASE_CREDIT_NOTELINE_SUBTOTAL),NULL FROM creditor JOIN purchase_credit_note USING (CREDITOR_NUM) NATURAL JOIN purchase_credit_noteline WHERE PURCHASE_CREDIT_NOTE_DATE>=DATE_START_PARAM AND PURCHASE_CREDIT_NOTE_DATE<=DATE_END_PARAM AND CREDITOR_NUM=CREDITOR_NUM_PARAM GROUP BY PURCHASE_CREDIT_NOTE_NUM)
ORDER BY DATE;

COMMIT;
END//
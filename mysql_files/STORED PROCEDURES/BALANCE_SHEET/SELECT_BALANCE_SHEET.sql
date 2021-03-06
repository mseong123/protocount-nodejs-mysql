DELIMITER //
CREATE PROCEDURE SELECT_BALANCE_SHEET() 
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT GL_CATEGORY FROM gl_category WHERE GL_AREA='BALANCE SHEET' ORDER BY GL_ORDER;

SELECT GL_CATEGORY,GL_ACC_NUM,GL_DESC,NAME,DATE,ITEM,NUM,DEBIT,CREDIT FROM gl NATURAL JOIN gl_category NATURAL JOIN (
(SELECT debtor.GL_ACC_NUM,DEBTOR_NAME AS NAME, SALES_INVOICE_DATE AS DATE, 'SALES INVOICE' AS ITEM, SALES_INVOICE_NUM AS NUM,SUM(SALES_INVOICELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM debtor JOIN sales_invoice USING(DEBTOR_NUM) NATURAL JOIN sales_invoiceline GROUP BY SALES_INVOICE_NUM)
UNION ALL(SELECT debtor.GL_ACC_NUM,DEBTOR_NAME AS NAME, DEBIT_NOTE_DATE AS DATE, 'DEBIT NOTE' AS ITEM, DEBIT_NOTE_NUM AS NUM,SUM(DEBIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM debtor JOIN debit_note USING(DEBTOR_NUM) NATURAL JOIN debit_noteline GROUP BY DEBIT_NOTE_NUM)
UNION ALL(SELECT debtor.GL_ACC_NUM,DEBTOR_NAME AS NAME, CREDIT_NOTE_DATE AS DATE, 'CREDIT NOTE' AS ITEM, CREDIT_NOTE_NUM AS NUM,NULL AS DEBIT,SUM(CREDIT_NOTELINE_SUBTOTAL) AS CREDIT FROM debtor JOIN credit_note USING(DEBTOR_NUM) NATURAL JOIN credit_noteline GROUP BY CREDIT_NOTE_NUM)
UNION ALL(SELECT creditor.GL_ACC_NUM,CREDITOR_NAME AS NAME, PURCHASE_INVOICE_DATE AS DATE, 'PURCHASE INVOICE' AS ITEM, PURCHASE_INVOICE_NUM AS NUM,NULL AS DEBIT,SUM(PURCHASE_INVOICELINE_SUBTOTAL) AS CREDIT FROM creditor JOIN purchase_invoice USING(CREDITOR_NUM) NATURAL JOIN purchase_invoiceline GROUP BY PURCHASE_INVOICE_NUM)
UNION ALL(SELECT creditor.GL_ACC_NUM,CREDITOR_NAME AS NAME, PURCHASE_DEBIT_NOTE_DATE AS DATE, 'PURCHASE DEBIT NOTE' AS ITEM, PURCHASE_DEBIT_NOTE_NUM AS NUM,NULL AS DEBIT,SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) AS CREDIT FROM creditor JOIN purchase_debit_note USING(CREDITOR_NUM) NATURAL JOIN purchase_debit_noteline GROUP BY PURCHASE_DEBIT_NOTE_NUM)
UNION ALL(SELECT creditor.GL_ACC_NUM,CREDITOR_NAME AS NAME, PURCHASE_CREDIT_NOTE_DATE AS DATE, 'PURCHASE CREDIT NOTE' AS ITEM, PURCHASE_CREDIT_NOTE_NUM AS NUM,SUM(PURCHASE_CREDIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM creditor JOIN purchase_credit_note USING(CREDITOR_NUM) NATURAL JOIN purchase_credit_noteline GROUP BY PURCHASE_CREDIT_NOTE_NUM)
UNION ALL(SELECT debtor.GL_ACC_NUM, DEBTOR_NAME AS NAME, BANK_RECEIPT_DATE AS DATE, 'BANK RECEIPT' AS ITEM, BANK_RECEIPT_NUM AS NUM, NULL AS DEBIT, BANK_RECEIPT_AMOUNT AS CREDIT FROM debtor JOIN bank_receipt USING (DEBTOR_NUM))
UNION ALL(SELECT creditor.GL_ACC_NUM, CREDITOR_NAME AS NAME, BANK_PAYMENT_DATE AS DATE, 'BANK PAYMENT' AS ITEM, BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM creditor JOIN bank_payment USING (CREDITOR_NUM))
UNION ALL(SELECT debtor.GL_ACC_NUM, DEBTOR_NAME AS NAME, CASH_RECEIPT_DATE AS DATE, 'CASH RECEIPT' AS ITEM, CASH_RECEIPT_NUM AS NUM, NULL AS DEBIT, CASH_RECEIPT_AMOUNT AS CREDIT FROM debtor JOIN cash_receipt USING (DEBTOR_NUM))
UNION ALL(SELECT creditor.GL_ACC_NUM, CREDITOR_NAME AS NAME, CASH_PAYMENT_DATE AS DATE, 'CASH PAYMENT' AS ITEM, CASH_PAYMENT_NUM AS NUM, CASH_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM creditor JOIN cash_payment USING (CREDITOR_NUM))
UNION ALL(SELECT bank.GL_ACC_NUM, BANK_NAME AS NAME, BANK_RECEIPT_DATE AS DATE, 'BANK RECEIPT' AS ITEM, BANK_RECEIPT_NUM AS NUM, BANK_RECEIPT_AMOUNT AS DEBIT, NULL AS CREDIT FROM bank JOIN bank_receipt USING (BANK_NUM))
UNION ALL(SELECT bank.GL_ACC_NUM, BANK_NAME AS NAME, BANK_PAYMENT_DATE AS DATE, 'BANK PAYMENT' AS ITEM, BANK_PAYMENT_NUM AS NUM, NULL AS DEBIT, BANK_PAYMENT_AMOUNT AS CREDIT FROM bank JOIN bank_payment USING (BANK_NUM))
UNION ALL(SELECT GL_ACC_NUM, NULL AS NAME, BANK_RECEIPT_DATE AS DATE, 'BANK RECEIPT' AS ITEM, BANK_RECEIPT_NUM AS NUM, NULL AS DEBIT, BANK_RECEIPT_AMOUNT AS CREDIT FROM bank_receipt)
UNION ALL(SELECT GL_ACC_NUM, NULL AS NAME, BANK_PAYMENT_DATE AS DATE, 'BANK PAYMENT' AS ITEM, BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM bank_payment)
UNION ALL(SELECT GL_ACC_NUM2, NULL AS NAME, CASH_RECEIPT_DATE AS DATE, 'CASH RECEIPT' AS ITEM, CASH_RECEIPT_NUM AS NUM, CASH_RECEIPT_AMOUNT AS DEBIT, NULL AS CREDIT FROM cash_receipt)
UNION ALL(SELECT GL_ACC_NUM2, NULL AS NAME, CASH_PAYMENT_DATE AS DATE, 'CASH PAYMENT' AS ITEM, CASH_PAYMENT_NUM AS NUM, NULL AS DEBIT, CASH_PAYMENT_AMOUNT AS CREDIT FROM cash_payment)
UNION ALL(SELECT GL_ACC_NUM1, NULL AS NAME, CASH_RECEIPT_DATE AS DATE, 'CASH RECEIPT' AS ITEM, CASH_RECEIPT_NUM AS NUM, NULL AS DEBIT, CASH_RECEIPT_AMOUNT AS CREDIT FROM cash_receipt)
UNION ALL(SELECT GL_ACC_NUM1, NULL AS NAME, CASH_PAYMENT_DATE AS DATE, 'CASH PAYMENT' AS ITEM, CASH_PAYMENT_NUM AS NUM, CASH_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM cash_payment)
UNION ALL(SELECT GL_ACC_NUM, NULL AS NAME, JOURNAL_DATE AS DATE, 'JOURNAL' AS ITEM, JOURNAL_NUM AS NUM, JOURNALLINE_DEBIT AS DEBIT, JOURNALLINE_CREDIT AS CREDIT FROM journal NATURAL JOIN journalline)
) T1 WHERE GL_AREA='BALANCE SHEET' ORDER BY GL_ORDER,GL_ACC_NUM,DATE;

SELECT GL_CATEGORY,GL_ACC_NUM,GL_DESC,DATE,ITEM,NUM,DEBIT,CREDIT FROM gl NATURAL JOIN gl_category NATURAL JOIN (
(SELECT GL_ACC_NUM,SALES_INVOICE_DATE AS DATE, 'SALES INVOICE' AS ITEM, SALES_INVOICE_NUM AS NUM,NULL AS DEBIT, SUM(SALES_INVOICELINE_SUBTOTAL) AS CREDIT FROM sales_invoice NATURAL JOIN sales_invoiceline GROUP BY SALES_INVOICE_NUM)
UNION ALL(SELECT GL_ACC_NUM,DEBIT_NOTE_DATE AS DATE, 'DEBIT NOTE' AS ITEM, DEBIT_NOTE_NUM AS NUM,NULL AS DEBIT, SUM(DEBIT_NOTELINE_SUBTOTAL) AS CREDIT FROM debit_note NATURAL JOIN debit_noteline GROUP BY DEBIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM,CREDIT_NOTE_DATE AS DATE, 'CREDIT NOTE' AS ITEM, CREDIT_NOTE_NUM AS NUM,SUM(CREDIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM credit_note NATURAL JOIN credit_noteline GROUP BY CREDIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM,PURCHASE_INVOICE_DATE AS DATE, 'PURCHASE INVOICE' AS ITEM, PURCHASE_INVOICE_NUM AS NUM,SUM(PURCHASE_INVOICELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM purchase_invoice NATURAL JOIN purchase_invoiceline GROUP BY PURCHASE_INVOICE_NUM)
UNION ALL(SELECT GL_ACC_NUM,PURCHASE_DEBIT_NOTE_DATE AS DATE, 'PURCHASE DEBIT NOTE' AS ITEM, PURCHASE_DEBIT_NOTE_NUM AS NUM,SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) AS DEBIT,NULL AS CREDIT FROM purchase_debit_note NATURAL JOIN purchase_debit_noteline GROUP BY PURCHASE_DEBIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM,PURCHASE_CREDIT_NOTE_DATE AS DATE, 'PURCHASE CREDIT NOTE' AS ITEM, PURCHASE_CREDIT_NOTE_NUM AS NUM,NULL AS DEBIT,SUM(PURCHASE_CREDIT_NOTELINE_SUBTOTAL) AS CREDIT FROM purchase_credit_note NATURAL JOIN purchase_credit_noteline GROUP BY PURCHASE_CREDIT_NOTE_NUM)
UNION ALL(SELECT GL_ACC_NUM, BANK_RECEIPT_DATE AS DATE, 'BANK RECEIPT' AS ITEM, BANK_RECEIPT_NUM AS NUM, NULL AS DEBIT, BANK_RECEIPT_AMOUNT AS CREDIT FROM bank_receipt)
UNION ALL(SELECT GL_ACC_NUM, BANK_PAYMENT_DATE AS DATE, 'BANK PAYMENT' AS ITEM, BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM bank_payment)
UNION ALL(SELECT GL_ACC_NUM1, CASH_RECEIPT_DATE AS DATE, 'CASH RECEIPT' AS ITEM, CASH_RECEIPT_NUM AS NUM, NULL AS DEBIT, CASH_RECEIPT_AMOUNT AS CREDIT FROM cash_receipt)
UNION ALL(SELECT GL_ACC_NUM1, CASH_PAYMENT_DATE AS DATE, 'CASH PAYMENT' AS ITEM, CASH_PAYMENT_NUM AS NUM, CASH_PAYMENT_AMOUNT AS DEBIT, NULL AS CREDIT FROM cash_payment)
UNION ALL(SELECT GL_ACC_NUM, JOURNAL_DATE AS DATE, 'JOURNAL' AS ITEM, JOURNAL_NUM AS NUM, JOURNALLINE_DEBIT AS DEBIT, JOURNALLINE_CREDIT AS CREDIT FROM journal NATURAL JOIN journalline)
) T1 WHERE GL_AREA='PROFIT AND LOSS' ORDER BY GL_ORDER,GL_ACC_NUM,DATE;

COMMIT;
END//
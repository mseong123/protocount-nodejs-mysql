DELIMITER //
CREATE PROCEDURE SELECT_CREDITOR_OUTSTANDING(IN CREDITOR_NUM_PARAM VARCHAR(20),IN DOC_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT PURCHASE_INVOICE_NUM AS NUM,  (SELECT CREDITOR_NAME FROM creditor WHERE creditor.CREDITOR_NUM=t1.CREDITOR_NUM) AS NAME,
'PURCHASE INVOICE' AS TYPE, PURCHASE_INVOICE_DATE AS DATE, SUM(PURCHASE_INVOICELINE_SUBTOTAL) AS ORIGINAL_AMOUNT,
ROUND((SELECT SUM(PURCHASE_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT) FROM purchase_invoice_cash_payment WHERE PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT FROM purchase_invoice_cash_payment WHERE CASH_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT) FROM purchase_invoice_bank_payment WHERE PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT FROM purchase_invoice_bank_payment WHERE BANK_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM),0)
),2) AS OUTSTANDING 
from purchase_invoice as t1 LEFT JOIN purchase_invoiceline USING (PURCHASE_INVOICE_NUM) WHERE  t1.CREDITOR_NUM=CREDITOR_NUM_PARAM AND 
(SELECT SUM(PURCHASE_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT) FROM purchase_invoice_cash_payment WHERE PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_CASH_PAYMENT_AMOUNT FROM purchase_invoice_cash_payment WHERE CASH_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT) FROM purchase_invoice_bank_payment WHERE PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_BANK_PAYMENT_AMOUNT FROM purchase_invoice_bank_payment WHERE BANK_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
+IFNULL((SELECT PURCHASE_INVOICE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_invoice_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND PURCHASE_INVOICE_NUM=t2.PURCHASE_INVOICE_NUM),0)
from purchase_invoice as t2 LEFT JOIN purchase_invoiceline USING (PURCHASE_INVOICE_NUM) WHERE t2.PURCHASE_INVOICE_NUM=t1.PURCHASE_INVOICE_NUM)>0
GROUP BY PURCHASE_INVOICE_NUM UNION ALL 
(SELECT PURCHASE_DEBIT_NOTE_NUM, (SELECT CREDITOR_NAME FROM creditor WHERE creditor.CREDITOR_NUM=t3.CREDITOR_NUM) AS NAME,
'PURCHASE DEBIT NOTE' AS TYPE,PURCHASE_DEBIT_NOTE_DATE, SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) AS ORIGINAL_AMOUNT,
ROUND((SELECT SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT) FROM purchase_debit_note_cash_payment WHERE PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT FROM purchase_debit_note_cash_payment WHERE CASH_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT) FROM purchase_debit_note_bank_payment WHERE PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT FROM purchase_debit_note_bank_payment WHERE BANK_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM),0)
),2) AS OUTSTANDING
from purchase_debit_note as t3 LEFT JOIN purchase_debit_noteline using (PURCHASE_DEBIT_NOTE_NUM) WHERE t3.CREDITOR_NUM=CREDITOR_NUM_PARAM AND 
(SELECT SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT) FROM purchase_debit_note_cash_payment WHERE PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT FROM purchase_debit_note_cash_payment WHERE CASH_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT) FROM purchase_debit_note_bank_payment WHERE PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT FROM purchase_debit_note_bank_payment WHERE BANK_PAYMENT_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
+IFNULL((SELECT PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_debit_note_purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND PURCHASE_DEBIT_NOTE_NUM=t4.PURCHASE_DEBIT_NOTE_NUM),0)
from purchase_debit_note as t4 LEFT JOIN purchase_debit_noteline using (PURCHASE_DEBIT_NOTE_NUM) WHERE t4.PURCHASE_DEBIT_NOTE_NUM=t3.PURCHASE_DEBIT_NOTE_NUM)>0 
GROUP BY PURCHASE_DEBIT_NOTE_NUM) ORDER BY DATE;

COMMIT;
END//
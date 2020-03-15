DELIMITER //
CREATE PROCEDURE SELECT_DEBTOR_OUTSTANDING(IN DEBTOR_NUM_PARAM VARCHAR(10),IN DOC_NUM_PARAM VARCHAR(10))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT SALES_INVOICE_NUM AS NUM,  (SELECT DEBTOR_NAME FROM debtor WHERE debtor.DEBTOR_NUM=t1.DEBTOR_NUM) AS NAME,
'INVOICE' AS TYPE, SALES_INVOICE_DATE AS DATE, SUM(SALES_INVOICELINE_SUBTOTAL) AS ORIGINAL_AMOUNT,
ROUND((SELECT SUM(SALES_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(SALES_INVOICE_CASH_RECEIPT_AMOUNT) FROM sales_invoice_cash_receipt WHERE SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_CASH_RECEIPT_AMOUNT FROM sales_invoice_cash_receipt WHERE CASH_RECEIPT_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_BANK_RECEIPT_AMOUNT) FROM sales_invoice_bank_receipt WHERE SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_BANK_RECEIPT_AMOUNT FROM sales_invoice_bank_receipt WHERE BANK_RECEIPT_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_CREDIT_NOTE_AMOUNT) FROM sales_invoice_credit_note WHERE SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_CREDIT_NOTE_AMOUNT FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM),0)
),2) AS OUTSTANDING 
from sales_invoice as t1 LEFT JOIN sales_invoiceline USING (SALES_INVOICE_NUM) WHERE  t1.DEBTOR_NUM=DEBTOR_NUM_PARAM AND 
(SELECT SUM(SALES_INVOICELINE_SUBTOTAL)
-IFNULL((SELECT SUM(SALES_INVOICE_CASH_RECEIPT_AMOUNT) FROM sales_invoice_cash_receipt WHERE SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_CASH_RECEIPT_AMOUNT FROM sales_invoice_cash_receipt WHERE CASH_RECEIPT_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_BANK_RECEIPT_AMOUNT) FROM sales_invoice_bank_receipt WHERE SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_BANK_RECEIPT_AMOUNT FROM sales_invoice_bank_receipt WHERE BANK_RECEIPT_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
-IFNULL((SELECT SUM(SALES_INVOICE_CREDIT_NOTE_AMOUNT) FROM sales_invoice_credit_note WHERE SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
+IFNULL((SELECT SALES_INVOICE_CREDIT_NOTE_AMOUNT FROM sales_invoice_credit_note WHERE CREDIT_NOTE_NUM=DOC_NUM_PARAM AND SALES_INVOICE_NUM=t2.SALES_INVOICE_NUM),0)
from sales_invoice as t2 LEFT JOIN sales_invoiceline USING (SALES_INVOICE_NUM) WHERE t2.SALES_INVOICE_NUM=t1.SALES_INVOICE_NUM)>0
GROUP BY SALES_INVOICE_NUM UNION ALL 
(SELECT DEBIT_NOTE_NUM, (SELECT DEBTOR_NAME FROM debtor WHERE debtor.DEBTOR_NUM=t3.DEBTOR_NUM) AS NAME,
'DEBIT NOTE' AS TYPE,DEBIT_NOTE_DATE, SUM(DEBIT_NOTELINE_SUBTOTAL) AS ORIGINAL_AMOUNT,
ROUND((SELECT SUM(DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(DEBIT_NOTE_CASH_RECEIPT_AMOUNT) FROM debit_note_cash_receipt WHERE DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_CASH_RECEIPT_AMOUNT FROM debit_note_cash_receipt WHERE CASH_RECEIPT_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_BANK_RECEIPT_AMOUNT) FROM debit_note_bank_receipt WHERE DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_BANK_RECEIPT_AMOUNT FROM debit_note_bank_receipt WHERE BANK_RECEIPT_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_CREDIT_NOTE_AMOUNT) FROM debit_note_credit_note WHERE DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_CREDIT_NOTE_AMOUNT FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM),0)
),2) AS OUTSTANDING
from debit_note as t3 LEFT JOIN debit_noteline using (DEBIT_NOTE_NUM) WHERE t3.DEBTOR_NUM=DEBTOR_NUM_PARAM AND 
(SELECT SUM(DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(DEBIT_NOTE_CASH_RECEIPT_AMOUNT) FROM debit_note_cash_receipt WHERE DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_CASH_RECEIPT_AMOUNT FROM debit_note_cash_receipt WHERE CASH_RECEIPT_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_BANK_RECEIPT_AMOUNT) FROM debit_note_bank_receipt WHERE DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_BANK_RECEIPT_AMOUNT FROM debit_note_bank_receipt WHERE BANK_RECEIPT_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_CREDIT_NOTE_AMOUNT) FROM debit_note_credit_note WHERE DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
+IFNULL((SELECT DEBIT_NOTE_CREDIT_NOTE_AMOUNT FROM debit_note_credit_note WHERE CREDIT_NOTE_NUM=DOC_NUM_PARAM AND DEBIT_NOTE_NUM=t4.DEBIT_NOTE_NUM),0)
from debit_note as t4 LEFT JOIN debit_noteline using (DEBIT_NOTE_NUM) WHERE t4.DEBIT_NOTE_NUM=t3.DEBIT_NOTE_NUM)>0 
GROUP BY DEBIT_NOTE_NUM) ORDER BY DATE;

COMMIT;
END//
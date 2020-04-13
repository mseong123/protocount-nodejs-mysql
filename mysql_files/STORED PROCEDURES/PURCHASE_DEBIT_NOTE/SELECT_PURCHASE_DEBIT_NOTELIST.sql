
DELIMITER //
CREATE PROCEDURE SELECT_PURCHASE_DEBIT_NOTELIST ()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT PURCHASE_DEBIT_NOTE_DATE AS DATE,CREDITOR_NAME,PURCHASE_DEBIT_NOTE_NUM AS NUM,PURCHASE_DEBIT_NOTE_DESC AS DESCRIPTION, SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL) AS SUBTOTAL,
(SELECT SUM(PURCHASE_DEBIT_NOTELINE_SUBTOTAL)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT) FROM purchase_debit_note_bank_payment WHERE purchase_debit_note_bank_payment.PURCHASE_DEBIT_NOTE_NUM=purchase_debit_note.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT) FROM purchase_debit_note_cash_payment WHERE purchase_debit_note_cash_payment.PURCHASE_DEBIT_NOTE_NUM=purchase_debit_note.PURCHASE_DEBIT_NOTE_NUM),0)
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT) FROM purchase_debit_note_purchase_credit_note WHERE purchase_debit_note_purchase_credit_note.PURCHASE_DEBIT_NOTE_NUM=purchase_debit_note.PURCHASE_DEBIT_NOTE_NUM),0)) AS OUTSTANDING 
FROM creditor JOIN purchase_debit_note USING(CREDITOR_NUM) LEFT JOIN purchase_debit_noteline USING (PURCHASE_DEBIT_NOTE_NUM) GROUP BY PURCHASE_DEBIT_NOTE_NUM ORDER BY PURCHASE_DEBIT_NOTE_DATE;
COMMIT;
END//
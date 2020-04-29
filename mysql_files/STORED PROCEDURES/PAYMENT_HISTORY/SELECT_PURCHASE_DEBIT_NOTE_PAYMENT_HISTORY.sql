
DELIMITER //
CREATE PROCEDURE SELECT_PURCHASE_DEBIT_NOTE_PAYMENT_HISTORY(IN PURCHASE_DEBIT_NOTE_NUM_PARAM VARCHAR(50))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT BANK_PAYMENT_NUM AS NUM, BANK_PAYMENT_DATE AS DATE,'BANK PAYMENT' AS TYPE, BANK_PAYMENT_TRANSACTION_ID AS DESCRIPTION, PURCHASE_DEBIT_NOTE_BANK_PAYMENT_AMOUNT AS AMOUNT FROM bank_payment NATURAL JOIN purchase_debit_note_bank_payment WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM 
UNION ALL (SELECT CASH_PAYMENT_NUM, CASH_PAYMENT_DATE,'CASH PAYMENT', CASH_PAYMENT_TRANSACTION_ID, PURCHASE_DEBIT_NOTE_CASH_PAYMENT_AMOUNT FROM cash_payment NATURAL JOIN purchase_debit_note_cash_payment WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM)
UNION ALL (SELECT PURCHASE_CREDIT_NOTE_NUM, PURCHASE_CREDIT_NOTE_DATE,'PURCHASE CREDIT NOTE', PURCHASE_CREDIT_NOTE_DESC, PURCHASE_DEBIT_NOTE_PURCHASE_CREDIT_NOTE_AMOUNT FROM purchase_credit_note NATURAL JOIN purchase_debit_note_purchase_credit_note WHERE PURCHASE_DEBIT_NOTE_NUM=PURCHASE_DEBIT_NOTE_NUM_PARAM);

COMMIT;
END//
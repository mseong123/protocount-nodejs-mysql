
DELIMITER //
CREATE PROCEDURE SELECT_PURCHASE_CREDIT_NOTELIST ()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT PURCHASE_CREDIT_NOTE_DATE AS DATE,CREDITOR_NAME, PURCHASE_CREDIT_NOTE_NUM AS NUM,PURCHASE_CREDIT_NOTE_DESC AS DESCRIPTION, SUM(PURCHASE_CREDIT_NOTELINE_SUBTOTAL) AS SUBTOTAL FROM creditor JOIN purchase_credit_note USING(CREDITOR_NUM) LEFT JOIN purchase_credit_noteline USING (PURCHASE_CREDIT_NOTE_NUM) GROUP BY PURCHASE_CREDIT_NOTE_NUM ORDER BY PURCHASE_CREDIT_NOTE_DATE;
COMMIT;
END//
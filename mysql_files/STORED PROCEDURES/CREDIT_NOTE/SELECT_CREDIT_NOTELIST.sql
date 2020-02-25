
DELIMITER //
CREATE PROCEDURE SELECT_CREDIT_NOTELIST ()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DEBTOR_NUM, DEBTOR_NAME, CREDIT_NOTE_NUM,CREDIT_NOTE_DATE,CREDIT_NOTE_DESC, SUM(CREDIT_NOTELINE_SUBTOTAL) AS CREDIT_NOTE_SUBTOTAL FROM debtor JOIN credit_note USING(DEBTOR_NUM) LEFT JOIN credit_noteline USING (CREDIT_NOTE_NUM) GROUP BY CREDIT_NOTE_NUM ORDER BY CREDIT_NOTE_NUM;
COMMIT;
END//
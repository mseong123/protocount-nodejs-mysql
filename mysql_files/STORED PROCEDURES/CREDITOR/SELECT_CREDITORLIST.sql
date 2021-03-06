
DELIMITER //
CREATE PROCEDURE SELECT_CREDITORLIST ()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDITOR_NUM AS NUM, CREDITOR_NAME AS NAME,CREDITOR_ADDRESS AS ADDRESS, CREDITOR_POSTCODE AS POSTCODE,CREDITOR_PHONE AS PHONE,CREDITOR_FAX AS FAX,CREDITOR_OTHER_DESC AS 'OTHER DESCRIPTION',CREDITOR_CREDIT_TERM AS 'CREDIT_TERM' FROM creditor ORDER BY CREDITOR_NUM;
COMMIT;
END//
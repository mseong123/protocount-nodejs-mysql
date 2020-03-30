
DELIMITER //
CREATE PROCEDURE SELECT_DEBTOR(IN DEBTOR_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT *,DEBTOR_NUM AS DEBTOR_NUM_OLD FROM debtor WHERE DEBTOR_NUM=DEBTOR_NUM_PARAM;
COMMIT;
END//
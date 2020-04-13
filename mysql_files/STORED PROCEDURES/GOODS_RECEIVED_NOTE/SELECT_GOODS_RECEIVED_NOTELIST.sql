
DELIMITER //
CREATE PROCEDURE SELECT_GOODS_RECEIVED_NOTELIST ()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT GOODS_RECEIVED_NOTE_NUM AS NUM, CREDITOR_NAME,GOODS_RECEIVED_NOTE_DATE AS DATE,GOODS_RECEIVED_NOTE_DESC AS DESCRIPTION,SUM(GOODS_RECEIVED_NOTELINE_STOCK_QTY) AS QTY FROM creditor JOIN goods_received_note USING(CREDITOR_NUM) LEFT JOIN goods_received_noteline USING (GOODS_RECEIVED_NOTE_NUM) GROUP BY GOODS_RECEIVED_NOTE_NUM ORDER BY GOODS_RECEIVED_NOTE_NUM;
COMMIT;
END//

DELIMITER //
CREATE PROCEDURE SELECT_STOCK_ADJUSTMENTLIST ()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT STOCK_ADJUSTMENT_NUM AS NUM, STOCK_ADJUSTMENT_DATE AS DATE,STOCK_ADJUSTMENT_DESC AS DESCRIPTION,SUM(STOCK_ADJUSTMENTLINE_STOCK_QTY) AS QTY FROM stock_adjustment LEFT JOIN stock_adjustmentline USING (STOCK_ADJUSTMENT_NUM) GROUP BY STOCK_ADJUSTMENT_NUM ORDER BY STOCK_ADJUSTMENT_NUM;
COMMIT;
END//
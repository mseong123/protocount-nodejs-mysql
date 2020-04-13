
DELIMITER //
CREATE PROCEDURE SELECT_STOCKLIST ()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT STOCK_NUM AS NUM, STOCK_DESC AS DESCRIPTION,STOCK_PRICE AS PRICE,STOCK_MINPRICE AS 'MIN PRICE',STOCK_MAXPRICE AS 'MAX PRICE', STOCK_COST AS COST, STOCK_MINQTY AS 'MIN QTY', STOCK_MAXQTY AS 'MAX QTY', STOCK_BALQTY AS 'BAL QTY' FROM stock ORDER BY STOCK_NUM;
COMMIT;
END//
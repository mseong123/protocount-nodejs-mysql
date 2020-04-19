DELIMITER //
CREATE PROCEDURE INSERT_STOCK (IN STOCK_NUM_PARAM VARCHAR(20),IN STOCK_DESC_PARAM VARCHAR(255), IN STOCK_PRICE_PARAM DEC(10,2), IN STOCK_MINPRICE_PARAM DEC(10,2), IN STOCK_MAXPRICE_PARAM DEC(10,2),IN STOCK_COST_PARAM DEC(10,2),IN STOCK_MINQTY_PARAM INT,IN STOCK_MAXQTY_PARAM INT,IN STOCK_NUM_OLD_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
INSERT INTO stock VALUES(STOCK_NUM_PARAM,STOCK_DESC_PARAM,STOCK_PRICE_PARAM,STOCK_MINPRICE_PARAM,STOCK_MAXPRICE_PARAM,STOCK_COST_PARAM,STOCK_MINQTY_PARAM,STOCK_MAXQTY_PARAM);
COMMIT;
END











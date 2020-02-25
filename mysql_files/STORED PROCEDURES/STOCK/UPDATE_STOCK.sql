DELIMITER //
CREATE PROCEDURE UPDATE_STOCK (IN STOCK_NUM_PARAM VARCHAR(10),IN STOCK_DESC_PARAM VARCHAR(255), IN STOCK_PRICE_PARAM DEC(10,2), IN STOCK_MINPRICE_PARAM DEC(10,2), IN STOCK_MAXPRICE_PARAM DEC(10,2),IN STOCK_COST_PARAM DEC(10,2),IN STOCK_MINQTY_PARAM INT,IN STOCK_MAXQTY_PARAM INT,IN STOCK_BALQTY_PARAM INT, IN STOCK_NUM_OLD_PARAM VARCHAR(10))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
UPDATE stock SET STOCK_NUM=STOCK_NUM_PARAM, STOCK_DESC=STOCK_DESC_PARAM,STOCK_PRICE=STOCK_PRICE_PARAM,STOCK_MINPRICE=STOCK_MINPRICE_PARAM,STOCK_MAXPRICE=STOCK_MAXPRICE_PARAM,STOCK_COST=STOCK_COST_PARAM,STOCK_MINQTY=STOCK_MINQTY_PARAM,STOCK_MAXQTY=STOCK_MAXQTY_PARAM,STOCK_BALQTY=STOCK_BALQTY_PARAM WHERE STOCK_NUM=STOCK_NUM_OLD_PARAM;
COMMIT;
END

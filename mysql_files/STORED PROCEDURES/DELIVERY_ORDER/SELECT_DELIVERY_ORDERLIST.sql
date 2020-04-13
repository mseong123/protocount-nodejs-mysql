
DELIMITER //
CREATE PROCEDURE SELECT_DELIVERY_ORDERLIST ()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT DELIVERY_ORDER_NUM AS NUM, DEBTOR_NAME,DELIVERY_ORDER_DATE AS DATE,DELIVERY_ORDER_DESC AS DESCRIPTION,SUM(DELIVERY_ORDERLINE_STOCK_QTY) AS QTY FROM debtor JOIN delivery_order USING(DEBTOR_NUM) LEFT JOIN delivery_orderline USING (DELIVERY_ORDER_NUM) GROUP BY DELIVERY_ORDER_NUM ORDER BY DELIVERY_ORDER_NUM;
COMMIT;
END//

DELIMITER //
CREATE PROCEDURE SELECT_PURCHASE_RETURN(IN PURCHASE_RETURN_NUM_PARAM VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;
SELECT CREDITOR_NUM, CREDITOR_NAME, CREDITOR_ADDRESS, PURCHASE_RETURN_NUM,PURCHASE_RETURN_DATE,PURCHASE_RETURN_DESC, PURCHASE_RETURN_NUM AS PURCHASE_RETURN_NUM_OLD FROM creditor JOIN purchase_return USING (CREDITOR_NUM) WHERE PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_PARAM;
SELECT PURCHASE_RETURNLINE_LINENUMBER,PURCHASE_RETURNLINE_STOCK_NUM,PURCHASE_RETURNLINE_STOCK_DESC,PURCHASE_RETURNLINE_STOCK_QTY FROM purchase_returnline WHERE PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_PARAM;
SELECT PURCHASE_RETURNLINE_LINENUMBER,STOCK_NUM,PURCHASE_RETURN_STOCK_QTY FROM purchase_return_stock WHERE PURCHASE_RETURN_NUM=PURCHASE_RETURN_NUM_PARAM;
COMMIT;
END//
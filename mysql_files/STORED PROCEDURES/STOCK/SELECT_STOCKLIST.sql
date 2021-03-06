
DELIMITER //
CREATE PROCEDURE SELECT_STOCKLIST (IN DOC_NUM_PARAM VARCHAR(50))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

IF DOC_NUM_PARAM IS NOT NULL THEN 

SELECT STOCK_NUM AS NUM, STOCK_DESC AS DESCRIPTION,STOCK_PRICE AS PRICE,STOCK_MINPRICE AS 'MIN PRICE',STOCK_MAXPRICE AS 'MAX PRICE', STOCK_COST AS COST, STOCK_MINQTY AS 'MIN QTY', STOCK_MAXQTY AS 'MAX QTY',0
-IFNULL((SELECT SUM(DELIVERY_ORDER_STOCK_QTY) FROM delivery_order_stock WHERE delivery_order_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(DELIVERY_ORDER_STOCK_QTY) FROM delivery_order_stock WHERE delivery_order_stock.DELIVERY_ORDER_NUM=DOC_NUM_PARAM AND delivery_order_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(DELIVERY_RETURN_STOCK_QTY) FROM delivery_return_stock WHERE delivery_return_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(DELIVERY_RETURN_STOCK_QTY) FROM delivery_return_stock WHERE delivery_return_stock.DELIVERY_RETURN_NUM=DOC_NUM_PARAM AND delivery_return_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(SALES_INVOICE_STOCK_QTY) FROM sales_invoice_stock WHERE sales_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(SALES_INVOICE_STOCK_QTY) FROM sales_invoice_stock WHERE sales_invoice_stock.SALES_INVOICE_NUM=DOC_NUM_PARAM AND sales_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_STOCK_QTY) FROM debit_note_stock WHERE debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(DEBIT_NOTE_STOCK_QTY) FROM debit_note_stock WHERE debit_note_stock.DEBIT_NOTE_NUM=DOC_NUM_PARAM AND debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(CREDIT_NOTE_STOCK_QTY) FROM credit_note_stock WHERE credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(CREDIT_NOTE_STOCK_QTY) FROM credit_note_stock WHERE credit_note_stock.CREDIT_NOTE_NUM=DOC_NUM_PARAM AND credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
+IFNULL((SELECT SUM(GOODS_RECEIVED_NOTE_STOCK_QTY) FROM goods_received_note_stock WHERE goods_received_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(GOODS_RECEIVED_NOTE_STOCK_QTY) FROM goods_received_note_stock WHERE goods_received_note_stock.GOODS_RECEIVED_NOTE_NUM=DOC_NUM_PARAM AND goods_received_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_RETURN_STOCK_QTY) FROM purchase_return_stock WHERE purchase_return_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_RETURN_STOCK_QTY) FROM purchase_return_stock WHERE purchase_return_stock.PURCHASE_RETURN_NUM=DOC_NUM_PARAM AND purchase_return_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_INVOICE_STOCK_QTY) FROM purchase_invoice_stock WHERE purchase_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_INVOICE_STOCK_QTY) FROM purchase_invoice_stock WHERE purchase_invoice_stock.PURCHASE_INVOICE_NUM=DOC_NUM_PARAM AND purchase_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0) 
+IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_STOCK_QTY) FROM purchase_debit_note_stock WHERE purchase_debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_STOCK_QTY) FROM purchase_debit_note_stock WHERE purchase_debit_note_stock.PURCHASE_DEBIT_NOTE_NUM=DOC_NUM_PARAM AND purchase_debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_CREDIT_NOTE_STOCK_QTY) FROM purchase_credit_note_stock WHERE purchase_credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_CREDIT_NOTE_STOCK_QTY) FROM purchase_credit_note_stock WHERE purchase_credit_note_stock.PURCHASE_CREDIT_NOTE_NUM=DOC_NUM_PARAM AND purchase_credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(STOCK_ADJUSTMENTLINE_STOCK_QTY) FROM stock_adjustmentline WHERE stock_adjustmentline.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(STOCK_ADJUSTMENTLINE_STOCK_QTY) FROM stock_adjustmentline WHERE stock_adjustmentline.STOCK_ADJUSTMENT_NUM=DOC_NUM_PARAM AND stock_adjustmentline.STOCK_NUM=stock.STOCK_NUM),0) 
AS 'BAL QTY'
FROM stock ORDER BY STOCK_NUM;

ELSE 
SELECT STOCK_NUM AS NUM, STOCK_DESC AS DESCRIPTION,STOCK_PRICE AS PRICE,STOCK_MINPRICE AS 'MIN PRICE',STOCK_MAXPRICE AS 'MAX PRICE', STOCK_COST AS COST, STOCK_MINQTY AS 'MIN QTY', STOCK_MAXQTY AS 'MAX QTY',0
-IFNULL((SELECT SUM(DELIVERY_ORDER_STOCK_QTY) FROM delivery_order_stock WHERE delivery_order_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(DELIVERY_RETURN_STOCK_QTY) FROM delivery_return_stock WHERE delivery_return_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(SALES_INVOICE_STOCK_QTY) FROM sales_invoice_stock WHERE sales_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_STOCK_QTY) FROM debit_note_stock WHERE debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(CREDIT_NOTE_STOCK_QTY) FROM credit_note_stock WHERE credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(GOODS_RECEIVED_NOTE_STOCK_QTY) FROM goods_received_note_stock WHERE goods_received_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
-IFNULL((SELECT SUM(PURCHASE_RETURN_STOCK_QTY) FROM purchase_return_stock WHERE purchase_return_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_INVOICE_STOCK_QTY) FROM purchase_invoice_stock WHERE purchase_invoice_stock.STOCK_NUM=stock.STOCK_NUM),0)
+IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_STOCK_QTY) FROM purchase_debit_note_stock WHERE purchase_debit_note_stock.STOCK_NUM=stock.STOCK_NUM),0)  
-IFNULL((SELECT SUM(PURCHASE_CREDIT_NOTE_STOCK_QTY) FROM purchase_credit_note_stock WHERE purchase_credit_note_stock.STOCK_NUM=stock.STOCK_NUM),0) 
+IFNULL((SELECT SUM(STOCK_ADJUSTMENTLINE_STOCK_QTY) FROM stock_adjustmentline WHERE stock_adjustmentline.STOCK_NUM=stock.STOCK_NUM),0)   
AS 'BAL QTY'
FROM stock ORDER BY STOCK_NUM;
END IF;


COMMIT;
END//
DELIMITER //
CREATE PROCEDURE SELECT_STOCK_CARD(IN DATE_START_PARAM VARCHAR(255), IN DATE_END_PARAM VARCHAR(255), IN STOCK_NUM_PARAM VARCHAR(255)) 
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG='';

SELECT CONCAT("SELECT STOCK_NUM,0
-IFNULL((SELECT SUM(DELIVERY_ORDER_STOCK_QTY) FROM delivery_order_stock NATURAL JOIN delivery_order WHERE delivery_order_stock.STOCK_NUM=stock.STOCK_NUM AND DELIVERY_ORDER_DATE<",DATE_START_PARAM,"),0)
+IFNULL((SELECT SUM(DELIVERY_RETURN_STOCK_QTY) FROM delivery_return_stock NATURAL JOIN delivery_return WHERE delivery_return_stock.STOCK_NUM=stock.STOCK_NUM AND DELIVERY_RETURN_DATE<",DATE_START_PARAM,"),0) 
-IFNULL((SELECT SUM(SALES_INVOICE_STOCK_QTY) FROM sales_invoice_stock NATURAL JOIN sales_invoice WHERE sales_invoice_stock.STOCK_NUM=stock.STOCK_NUM AND SALES_INVOICE_DATE<",DATE_START_PARAM,"),0)
-IFNULL((SELECT SUM(DEBIT_NOTE_STOCK_QTY) FROM debit_note_stock NATURAL JOIN debit_note WHERE debit_note_stock.STOCK_NUM=stock.STOCK_NUM AND DEBIT_NOTE_DATE<",DATE_START_PARAM,"),0)
+IFNULL((SELECT SUM(CREDIT_NOTE_STOCK_QTY) FROM credit_note_stock NATURAL JOIN credit_note WHERE credit_note_stock.STOCK_NUM=stock.STOCK_NUM AND CREDIT_NOTE_DATE<",DATE_START_PARAM,"),0)
+IFNULL((SELECT SUM(GOODS_RECEIVED_NOTE_STOCK_QTY) FROM goods_received_note_stock NATURAL JOIN goods_received_note WHERE goods_received_note_stock.STOCK_NUM=stock.STOCK_NUM AND GOODS_RECEIVED_NOTE_DATE<",DATE_START_PARAM,"),0) 
-IFNULL((SELECT SUM(PURCHASE_RETURN_STOCK_QTY) FROM purchase_return_stock NATURAL JOIN purchase_return WHERE purchase_return_stock.STOCK_NUM=stock.STOCK_NUM AND PURCHASE_RETURN_DATE<",DATE_START_PARAM,"),0)
+IFNULL((SELECT SUM(PURCHASE_INVOICE_STOCK_QTY) FROM purchase_invoice_stock NATURAL JOIN purchase_invoice WHERE purchase_invoice_stock.STOCK_NUM=stock.STOCK_NUM AND PURCHASE_INVOICE_DATE<",DATE_START_PARAM,"),0)
+IFNULL((SELECT SUM(PURCHASE_DEBIT_NOTE_STOCK_QTY) FROM purchase_debit_note_stock NATURAL JOIN purchase_debit_note WHERE purchase_debit_note_stock.STOCK_NUM=stock.STOCK_NUM AND PURCHASE_DEBIT_NOTE_DATE<",DATE_START_PARAM,"),0)  
-IFNULL((SELECT SUM(PURCHASE_CREDIT_NOTE_STOCK_QTY) FROM purchase_credit_note_stock NATURAL JOIN purchase_credit_note WHERE purchase_credit_note_stock.STOCK_NUM=stock.STOCK_NUM AND PURCHASE_CREDIT_NOTE_DATE<",DATE_START_PARAM,"),0) 
+IFNULL((SELECT SUM(STOCK_ADJUSTMENTLINE_STOCK_QTY) FROM stock_adjustmentline NATURAL JOIN stock_adjustment WHERE stock_adjustmentline.STOCK_NUM=stock.STOCK_NUM AND STOCK_ADJUSTMENT_DATE<",DATE_START_PARAM,"),0)   
AS 'BF QTY'
FROM stock WHERE STOCK_NUM IN (",STOCK_NUM_PARAM,")") INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG='';


SELECT CONCAT("SELECT STOCK_NUM,STOCK_DESC,DELIVERY_ORDER_NUM AS 'DOC NUM',DELIVERY_ORDER_DATE AS DATE, 'DELIVERY ORDER' AS TYPE,0 AS 'IN',-(SELECT SUM(DELIVERY_ORDER_STOCK_QTY) FROM delivery_order_stock WHERE delivery_order_stock.STOCK_NUM=stock.STOCK_NUM AND delivery_order_stock.DELIVERY_ORDER_NUM=delivery_order.DELIVERY_ORDER_NUM) AS 'OUT' FROM stock NATURAL JOIN delivery_order_stock NATURAL JOIN delivery_order WHERE DELIVERY_ORDER_DATE>=",DATE_START_PARAM," AND DELIVERY_ORDER_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,DELIVERY_ORDER_NUM 
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,DELIVERY_RETURN_NUM,DELIVERY_RETURN_DATE, 'DELIVERY RETURN',(SELECT SUM(DELIVERY_RETURN_STOCK_QTY) FROM delivery_return_stock WHERE delivery_return_stock.STOCK_NUM=stock.STOCK_NUM AND delivery_return_stock.DELIVERY_RETURN_NUM=delivery_return.DELIVERY_RETURN_NUM) AS 'IN',0 AS 'OUT' FROM stock NATURAL JOIN delivery_return_stock NATURAL JOIN delivery_return WHERE DELIVERY_RETURN_DATE>=",DATE_START_PARAM," AND DELIVERY_RETURN_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,DELIVERY_RETURN_NUM)
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,SALES_INVOICE_NUM,SALES_INVOICE_DATE, 'SALES INVOICE',0 AS 'IN',-(SELECT SUM(SALES_INVOICE_STOCK_QTY) FROM sales_invoice_stock WHERE sales_invoice_stock.STOCK_NUM=stock.STOCK_NUM AND sales_invoice_stock.SALES_INVOICE_NUM=sales_invoice.SALES_INVOICE_NUM) AS 'OUT' FROM stock NATURAL JOIN sales_invoice_stock NATURAL JOIN sales_invoice WHERE SALES_INVOICE_DATE>=",DATE_START_PARAM," AND SALES_INVOICE_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,SALES_INVOICE_NUM)
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,DEBIT_NOTE_NUM,DEBIT_NOTE_DATE, 'DEBIT NOTE',0 AS 'IN',-(SELECT SUM(DEBIT_NOTE_STOCK_QTY) FROM debit_note_stock WHERE debit_note_stock.STOCK_NUM=stock.STOCK_NUM AND debit_note_stock.DEBIT_NOTE_NUM=debit_note.DEBIT_NOTE_NUM) AS 'OUT' FROM stock NATURAL JOIN debit_note_stock NATURAL JOIN debit_note WHERE DEBIT_NOTE_DATE>=",DATE_START_PARAM," AND DEBIT_NOTE_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,DEBIT_NOTE_NUM)
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,CREDIT_NOTE_NUM,CREDIT_NOTE_DATE, 'CREDIT NOTE',(SELECT SUM(CREDIT_NOTE_STOCK_QTY) FROM credit_note_stock WHERE credit_note_stock.STOCK_NUM=stock.STOCK_NUM AND credit_note_stock.CREDIT_NOTE_NUM=credit_note.CREDIT_NOTE_NUM) AS 'IN',0 AS 'OUT' FROM stock NATURAL JOIN credit_note_stock NATURAL JOIN credit_note WHERE CREDIT_NOTE_DATE>=",DATE_START_PARAM," AND CREDIT_NOTE_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,CREDIT_NOTE_NUM)
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,GOODS_RECEIVED_NOTE_NUM,GOODS_RECEIVED_NOTE_DATE, 'GOODS RECEIVED NOTE',(SELECT SUM(GOODS_RECEIVED_NOTE_STOCK_QTY) FROM goods_received_note_stock WHERE goods_received_note_stock.STOCK_NUM=stock.STOCK_NUM AND goods_received_note_stock.GOODS_RECEIVED_NOTE_NUM=goods_received_note.GOODS_RECEIVED_NOTE_NUM) AS 'IN',0 AS 'OUT' FROM stock NATURAL JOIN goods_received_note_stock NATURAL JOIN goods_received_note WHERE GOODS_RECEIVED_NOTE_DATE>=",DATE_START_PARAM," AND GOODS_RECEIVED_NOTE_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,GOODS_RECEIVED_NOTE_NUM)
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,PURCHASE_RETURN_NUM,PURCHASE_RETURN_DATE, 'PURCHASE_RETURN',0 AS 'IN',-(SELECT SUM(PURCHASE_RETURN_STOCK_QTY) FROM purchase_return_stock WHERE purchase_return_stock.STOCK_NUM=stock.STOCK_NUM AND purchase_return_stock.PURCHASE_RETURN_NUM=purchase_return.PURCHASE_RETURN_NUM) AS 'OUT' FROM stock NATURAL JOIN purchase_return_stock NATURAL JOIN purchase_return WHERE PURCHASE_RETURN_DATE>=",DATE_START_PARAM," AND PURCHASE_RETURN_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,PURCHASE_RETURN_NUM)
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,PURCHASE_INVOICE_NUM,PURCHASE_INVOICE_DATE, 'PURCHASE INVOICE',(SELECT SUM(PURCHASE_INVOICE_STOCK_QTY) FROM purchase_invoice_stock WHERE purchase_invoice_stock.STOCK_NUM=stock.STOCK_NUM AND purchase_invoice_stock.PURCHASE_INVOICE_NUM=purchase_invoice.PURCHASE_INVOICE_NUM) AS 'IN',0 AS 'OUT' FROM stock NATURAL JOIN purchase_invoice_stock NATURAL JOIN purchase_invoice WHERE PURCHASE_INVOICE_DATE>=",DATE_START_PARAM," AND PURCHASE_INVOICE_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,PURCHASE_INVOICE_NUM)
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,PURCHASE_DEBIT_NOTE_NUM,PURCHASE_DEBIT_NOTE_DATE, 'PURCHASE DEBIT NOTE',(SELECT SUM(PURCHASE_DEBIT_NOTE_STOCK_QTY) FROM purchase_debit_note_stock WHERE purchase_debit_note_stock.STOCK_NUM=stock.STOCK_NUM AND purchase_debit_note_stock.PURCHASE_DEBIT_NOTE_NUM=purchase_debit_note.PURCHASE_DEBIT_NOTE_NUM) AS 'IN',0 AS 'OUT' FROM stock NATURAL JOIN purchase_debit_note_stock NATURAL JOIN purchase_debit_note WHERE PURCHASE_DEBIT_NOTE_DATE>=",DATE_START_PARAM," AND PURCHASE_DEBIT_NOTE_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,PURCHASE_DEBIT_NOTE_NUM)
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,PURCHASE_CREDIT_NOTE_NUM,PURCHASE_CREDIT_NOTE_DATE, 'PURCHASE CREDIT NOTE',0 AS 'IN',-(SELECT SUM(PURCHASE_CREDIT_NOTE_STOCK_QTY) FROM purchase_credit_note_stock WHERE purchase_credit_note_stock.STOCK_NUM=stock.STOCK_NUM AND purchase_credit_note_stock.PURCHASE_CREDIT_NOTE_NUM=purchase_credit_note.PURCHASE_CREDIT_NOTE_NUM) AS 'OUT' FROM stock NATURAL JOIN purchase_credit_note_stock NATURAL JOIN purchase_credit_note WHERE PURCHASE_CREDIT_NOTE_DATE>=",DATE_START_PARAM," AND PURCHASE_CREDIT_NOTE_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,PURCHASE_CREDIT_NOTE_NUM)
UNION ALL (SELECT STOCK_NUM,STOCK_DESC,STOCK_ADJUSTMENT_NUM,STOCK_ADJUSTMENT_DATE,'STOCK ADJUSTMENT',(SELECT IF((SELECT SUM(STOCK_ADJUSTMENTLINE_STOCK_QTY) FROM stock_adjustmentline WHERE stock_adjustmentline.STOCK_NUM=stock.STOCK_NUM AND stock_adjustmentline.STOCK_ADJUSTMENT_NUM=stock_adjustment.STOCK_ADJUSTMENT_NUM)>=0,(SELECT SUM(STOCK_ADJUSTMENTLINE_STOCK_QTY) FROM stock_adjustmentline WHERE stock_adjustmentline.STOCK_NUM=stock.STOCK_NUM AND stock_adjustmentline.STOCK_ADJUSTMENT_NUM=stock_adjustment.STOCK_ADJUSTMENT_NUM),0)),(SELECT IF((SELECT SUM(STOCK_ADJUSTMENTLINE_STOCK_QTY) FROM stock_adjustmentline WHERE stock_adjustmentline.STOCK_NUM=stock.STOCK_NUM AND stock_adjustmentline.STOCK_ADJUSTMENT_NUM=stock_adjustment.STOCK_ADJUSTMENT_NUM)<0,(SELECT SUM(STOCK_ADJUSTMENTLINE_STOCK_QTY) FROM stock_adjustmentline WHERE stock_adjustmentline.STOCK_NUM=stock.STOCK_NUM AND stock_adjustmentline.STOCK_ADJUSTMENT_NUM=stock_adjustment.STOCK_ADJUSTMENT_NUM),0)) FROM stock NATURAL JOIN stock_adjustment NATURAL JOIN stock_adjustmentline WHERE STOCK_ADJUSTMENT_DATE>=",DATE_START_PARAM," AND STOCK_ADJUSTMENT_DATE<=",DATE_END_PARAM," AND STOCK_NUM IN (",STOCK_NUM_PARAM,") GROUP BY STOCK_NUM,STOCK_ADJUSTMENT_NUM)
ORDER BY STOCK_NUM,DATE") INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
END//
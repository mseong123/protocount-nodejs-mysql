
DELIMITER //
CREATE PROCEDURE DELETE_STOCK_ADJUSTMENT (IN STOCK_ADJUSTMENT_NUM_PARAM VARCHAR(255))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SET @STRNG ='DELETE FROM stock_adjustmentline WHERE STOCK_ADJUSTMENT_NUM IN (';
SELECT CONCAT(@STRNG,STOCK_ADJUSTMENT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @STRNG ='DELETE FROM stock_adjustment WHERE STOCK_ADJUSTMENT_NUM IN (';
SELECT CONCAT(@STRNG,STOCK_ADJUSTMENT_NUM_PARAM,')') INTO @STRNG;

PREPARE stmt FROM @STRNG;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;



COMMIT;
END//
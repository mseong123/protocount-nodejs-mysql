DELIMITER //
CREATE PROCEDURE SELECT_ACCOUNT() 
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;
START TRANSACTION;

SELECT GL_CATEGORY,GL_ACC_NUM,GL_DESC,GL_STATUS from gl_category left join gl using (GL_CATEGORY) order by GL_ORDER,GL_ACC_NUM;

COMMIT;
END//
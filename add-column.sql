DELIMITER $$
DROP PROCEDURE IF EXISTS add_column $$
CREATE PROCEDURE add_column()
BEGIN
	START TRANSACTION;

	-- Add new ArrivedDate column to Order table
	ALTER TABLE `Order` ADD COLUMN ArrivedDate DATE;

	-- Updates orders with ID 1,2 and 3 to be todays date.
	UPDATE `Order` SET ArrivedDate = CURRENT_DATE() where OrderID < 4;

	-- Check the number of affected rows.
	GET DIAGNOSTICS @rows = ROW_COUNT;
	IF @rows = 0 THEN
	   -- If an error occurred, rollback the transaction
	   ROLLBACK;
	   SELECT 'Transaction rolled back due to an error.';
	ELSE
	   -- If no error occurred, commit the transaction.
	   COMMIT;
           SELECT 'Transaction committed successfully.';
	END IF;
END $$
DELIMITER ;
CALL add_column();

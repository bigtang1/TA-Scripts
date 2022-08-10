DECLARE	@Days	SMALLINT,
		@Hours		INT,
		@Minutes	BIGINT,
		@Restarted_Date DATETIME;
 
/*** Capture the SQL Server instance last restart date ***/
/*** We will gte the Tempdb creation date ***/
SELECT  @Days = DATEDIFF(D, create_date, GETDATE()),
		@Restarted_Date = create_date
FROM    sys.databases
WHERE   database_id = 2;
 
/*** Prepare Number of Days and Hours Since the last SQL Server restart ***/
SELECT @Days = CASE WHEN @Days = 0 THEN 1 ELSE @Days END; 
SELECT @Hours = @Days * 24; 
SELECT @Minutes = @Hours * 60; 
 
 
/*** Retrieve the total transactions occurred in SQL Server Instance since last restart ***/
SELECT  @Restarted_Date			AS 'Last_Restarted_On',
		@@SERVERNAME		AS 'Instance_Name',
		cntr_value		AS 'Total_Trans_Since_Last_Restart',
		cntr_value / @Days	AS 'Avg_Trans_Per_Day',
		cntr_value / @Hours	AS 'Avg_Trans_Per_Hour',
		cntr_value / @Minutes	AS 'Avg_Trans_Per_Min'
FROM    sys.dm_os_performance_counters
WHERE   counter_name = 'Transactions/sec'
        AND instance_name = '_Total';
 
 
/*** Database Wise Average Transactions since last restart ***/
SELECT  @Restarted_Date			AS 'Last_Restarted_On',
		@@SERVERNAME		AS 'Instance_Name',
		instance_name		AS 'Database_Name',
		cntr_value		AS 'Total_Trans_Since_Last_Restart',
		cntr_value / @Days	AS 'Avg_Trans_Per_Day',
		cntr_value / @Hours	AS 'Avg_Trans_Per_Hour',
		cntr_value / @Minutes	AS 'Avg_Trans_Per_Min'
FROM    sys.dm_os_performance_counters
WHERE   counter_name = 'Transactions/sec'
        AND instance_name <> '_Total'
ORDER BY cntr_value DESC;
--------------------------------------------------------------
------------------    PROD RESTORE    ------------------------
--------------------------------------------------------------
-- Run on CRDBTEBP01
-- Run in SQLCMD mode

/*
DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), request_session_id) + ';'  
FROM sys.dm_tran_locks
WHERE resource_type = 'DATABASE'
  AND resource_database_id  = db_id('Products')
  AND NOT EXISTS (SELECT 1/0 FROM sys.dm_exec_sessions 
							WHERE sys.dm_exec_sessions.session_id = sys.dm_tran_locks.request_session_id
							  AND sys.dm_exec_sessions.is_user_process = 0)
--  AND is_user_process = 0;
--PRINT @KILL;
EXEC(@kill);
*/
USE master;
GO
ALTER AVAILABILITY GROUP [PROD]
     REMOVE DATABASE [PRODUCTS];
GO
ALTER DATABASE [Products] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Remember to delete the Products database from the other node.
 
RESTORE DATABASE [Products] 
		  FROM DISK = 'H:\MSSQL13.PROD\MSSQL\Backup\Products_MassTrans_20210914015304.bak'
		  WITH REPLACE, STATS = 10, NORECOVERY;
RESTORE DATABASE [Products] 
		  FROM DISK = 'H:\MSSQL13.PROD\MSSQL\Backup\Products_MassTrans_20210914015305.dif'
		  WITH STATS = 10, NORECOVERY;
RESTORE DATABASE [Products] WITH RECOVERY;
GO
 
 
------------------------------------------------------------------------------------------
-- Fix users
USE [Products]
GO
IF SUSER_SID('EISUser') IS NOT NULL
	ALTER USER EISUser WITH LOGIN = EISUser;
IF SUSER_SID('PODFix') IS NOT NULL
	ALTER USER PODfix WITH LOGIN = PODfix;
IF SUSER_SID('PODUser') IS NOT NULL
	ALTER USER PODUser WITH LOGIN = PODUser;
 
IF DATABASE_PRINCIPAL_ID('PolicyUser') IS NULL AND SUSER_SID('PolicyUser') IS NOT NULL
BEGIN
	CREATE USER PolicyUser FROM LOGIN PolicyUser;
	ALTER ROLE db_datareader ADD MEMBER PolicyUser;
END
IF DATABASE_PRINCIPAL_ID('PeopleUser') IS NULL AND SUSER_SID('PeopleUser') IS NOT NULL
BEGIN
	CREATE USER [PeopleUser] FROM LOGIN PeopleUser
	ALTER ROLE db_datareader ADD MEMBER PeopleUser;
END
IF DATABASE_PRINCIPAL_ID('poduser') IS NULL AND SUSER_SID('poduser') IS NOT NULL
BEGIN
	CREATE USER [poduser] FROM LOGIN poduser;
	ALTER ROLE TWMReadonly ADD MEMBER poduser;
END
IF DATABASE_PRINCIPAL_ID('EIS_PROD_Link') IS NULL AND SUSER_SID('EIS_PROD_Link') IS NOT NULL
BEGIN
	CREATE USER [EIS_PROD_Link] FROM LOGIN [EIS_PROD_Link];
	ALTER ROLE db_datareader ADD MEMBER EIS_PROD_Link;
END
GO
------------------------------------------------------------------------------------------
-- Add DB to AG
--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
:CONNECT CRDBTEBP02\PROD
USE [master];
GO
DROP DATABASE [PRODUCTS];
GO

:CONNECT crdbtebp01
USE [master];
GO
ALTER AVAILABILITY GROUP [PROD]
MODIFY REPLICA ON N'CRDBTEBP02\PROD' WITH (SEEDING_MODE = AUTOMATIC);
GO
ALTER AVAILABILITY GROUP [PROD]
ADD DATABASE [PRODUCTS];
GO

:CONNECT CRDBTEBP02\PROD
USE [master];
GO
ALTER AVAILABILITY GROUP [PROD] GRANT CREATE ANY DATABASE;
GO
 
 

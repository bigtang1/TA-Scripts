--Connect to crdbtebp01

BACKUP DATABASE Products_MassTrans TO DISK = 'H:\MSSQL13.PROD\MSSQL\Backup\Products_MassTrans_CO_POD_Restore.bak' 
WITH COMPRESSION, COPY_ONLY, STATS = 10, INIT

DECLARE @FullRestore nvarchar(2000);
DECLARE @DiffRestore nvarchar(2000);
DECLARE @FullCheckpoint_lsn numeric (25);

SELECT TOP 1
		@FullRestore = 'RESTORE DATABASE [Products] 
		  FROM DISK = ''' + backupmediafamily.physical_device_name + '''
		  WITH REPLACE, STATS = 10, NORECOVERY;'
		, @FullCheckpoint_lsn = backupset.checkpoint_lsn
		--backupset.database_name, backupset.type, 
		--backupset.name, backupmediafamily.physical_device_name, backupset.backup_finish_date,
		--backupmediafamily.logical_device_name, backupmediafamily.device_type, 
		--CAST(backupset.backup_size/1024/1024 as int) AS Size_in_MB,
		--datediff(minute,backupset.backup_start_date,backupset.backup_finish_date) backuptime_minutes, is_copy_only
FROM msdb.dbo.backupset
JOIN msdb.dbo.backupmediafamily
	ON backupset.media_set_id = backupmediafamily.media_set_id
WHERE backupset.type in ('D') -- Full (D), Differential (I) or Log (L) 
  AND backupset.database_name like 'Products_MassTrans' -- Only backups for a specific DB or group of DBs
--  AND is_copy_only = 0
ORDER BY backupset.backup_finish_date DESC


SELECT TOP 1
		@DiffRestore = 'RESTORE DATABASE [Products] 
		  FROM DISK = ''' + backupmediafamily.physical_device_name + '''
		  WITH STATS = 10, NORECOVERY;'
FROM msdb.dbo.backupset
JOIN msdb.dbo.backupmediafamily
	ON backupset.media_set_id = backupmediafamily.media_set_id
WHERE backupset.type in ('I') -- Full (D), Differential (I) or Log (L) 
  AND backupset.database_name like 'Products_MassTrans' -- Only backups for a specific DB or group of DBs
  AND is_copy_only = 0
  AND database_backup_lsn = @FullCheckpoint_lsn
ORDER BY backupset.backup_finish_date DESC

PRINT '--------------------------------------------------------------'
PRINT '------------------    PROD RESTORE    ------------------------'

PRINT '/*
DECLARE @kill varchar(8000) = '''';  
SELECT @kill = @kill + ''kill '' + CONVERT(varchar(5), request_session_id) + '';''  
FROM sys.dm_tran_locks
WHERE resource_type = ''DATABASE''
  AND resource_database_id  = db_id(''Products'')
  AND NOT EXISTS (SELECT 1/0 FROM sys.dm_exec_sessions 
							WHERE sys.dm_exec_sessions.session_id = sys.dm_tran_locks.request_session_id
							  AND sys.dm_exec_sessions.is_user_process = 0)
--  AND is_user_process = 0;
--PRINT @KILL;
EXEC(@kill);
*/'

PRINT 'USE master;'
PRINT 'GO'
PRINT 'ALTER AVAILABILITY GROUP [PROD]
     REMOVE DATABASE [PRODUCTS];'
PRINT 'GO'

PRINT 'ALTER DATABASE [Products] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;'

PRINT '-- Remember to delete the Products database from the other node.'
PRINT ''
PRINT @FullRestore
PRINT @DiffRestore
PRINT 'RESTORE DATABASE [Products] WITH RECOVERY;
GO'
PRINT ''
PRINT ''
PRINT 
'------------------------------------------------------------------------------------------
-- Fix users
USE [Products]
GO
IF SUSER_SID(''EISUser'') IS NOT NULL
	ALTER USER EISUser WITH LOGIN = EISUser;
IF SUSER_SID(''PODFix'') IS NOT NULL
	ALTER USER PODfix WITH LOGIN = PODfix;
IF SUSER_SID(''PODUser'') IS NOT NULL
	ALTER USER PODUser WITH LOGIN = PODUser;'
PRINT ''
PRINT 'IF DATABASE_PRINCIPAL_ID(''PolicyUser'') IS NULL AND SUSER_SID(''PolicyUser'') IS NOT NULL
BEGIN
	CREATE USER PolicyUser FROM LOGIN PolicyUser;
	ALTER ROLE db_datareader ADD MEMBER PolicyUser;
END
IF DATABASE_PRINCIPAL_ID(''PeopleUser'') IS NULL AND SUSER_SID(''PeopleUser'') IS NOT NULL
BEGIN
	CREATE USER [PeopleUser] FROM LOGIN PeopleUser
	ALTER ROLE db_datareader ADD MEMBER PeopleUser;
END'
PRINT 'IF DATABASE_PRINCIPAL_ID(''poduser'') IS NULL AND SUSER_SID(''poduser'') IS NOT NULL
BEGIN
	CREATE USER [poduser] FROM LOGIN poduser;
	ALTER ROLE TWMReadonly ADD MEMBER poduser;
END
IF DATABASE_PRINCIPAL_ID(''EIS_PROD_Link'') IS NULL AND SUSER_SID(''EIS_PROD_Link'') IS NOT NULL
BEGIN
	CREATE USER [EIS_PROD_Link] FROM LOGIN [EIS_PROD_Link];
	ALTER ROLE db_datareader ADD MEMBER EIS_PROD_Link;
END
GO'

PRINT
'------------------------------------------------------------------------------------------
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
MODIFY REPLICA ON N''CRDBTEBP02\PROD'' WITH (SEEDING_MODE = AUTOMATIC);
GO
ALTER AVAILABILITY GROUP [PROD]
ADD DATABASE [PRODUCTS];
GO

:CONNECT CRDBTEBP02\PROD
USE [master];
GO
ALTER AVAILABILITY GROUP [PROD] GRANT CREATE ANY DATABASE;
GO'


PRINT ''
PRINT ''
PRINT '--------------------------------------------------------------'
PRINT '---------------    NON - PROD RESTORE    ---------------------'

PRINT '--crdbtebm01\model'
PRINT '--crdbtebt01\test'
PRINT '--crdbtebt01\dev'

PRINT '/*
DECLARE @kill varchar(8000) = '''';  
SELECT @kill = @kill + ''kill '' + CONVERT(varchar(5), request_session_id) + '';''  
FROM sys.dm_tran_locks
WHERE resource_type = ''DATABASE''
  AND resource_database_id  = db_id(''Products'')
  AND NOT EXISTS (SELECT 1/0 FROM sys.dm_exec_sessions 
							WHERE sys.dm_exec_sessions.session_id = sys.dm_tran_locks.request_session_id
							  AND sys.dm_exec_sessions.is_user_process = 0)
--  AND is_user_process = 0;
--PRINT @KILL;
EXEC(@kill);
*/
ALTER DATABASE [Products] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;'

PRINT ''
PRINT REPLACE (@FullRestore,'H:\','\\CRDBTEBP01\H$\')
PRINT REPLACE (@DiffRestore,'H:\','\\CRDBTEBP01\H$\')
PRINT 'RESTORE DATABASE [Products] WITH RECOVERY;'

PRINT 
'------------------------------------------------------------------------------------------
-- Fix users
USE [Products]
GO
IF SUSER_SID(''EISUser'') IS NOT NULL
	ALTER USER EISUser WITH LOGIN = EISUser;
IF SUSER_SID(''PODFix'') IS NOT NULL
	ALTER USER PODfix WITH LOGIN = PODfix;
IF SUSER_SID(''PODUser'') IS NOT NULL
	ALTER USER PODUser WITH LOGIN = PODUser;'
PRINT ''
PRINT 'IF DATABASE_PRINCIPAL_ID(''PolicyUser'') IS NULL AND SUSER_SID(''PolicyUser'') IS NOT NULL
BEGIN
	CREATE USER PolicyUser FROM LOGIN PolicyUser;
	ALTER ROLE db_datareader ADD MEMBER PolicyUser;
END
IF DATABASE_PRINCIPAL_ID(''PeopleUser'') IS NULL AND SUSER_SID(''PeopleUser'') IS NOT NULL
BEGIN
	CREATE USER [PeopleUser] FROM LOGIN PeopleUser
	ALTER ROLE db_datareader ADD MEMBER PeopleUser;
END'
PRINT 'IF DATABASE_PRINCIPAL_ID(''poduser'') IS NULL AND SUSER_SID(''poduser'') IS NOT NULL
BEGIN
	CREATE USER [poduser] FROM LOGIN poduser;
	ALTER ROLE TWMReadonly ADD MEMBER poduser;
END
IF DATABASE_PRINCIPAL_ID(''EIS_PROD_Link'') IS NULL AND SUSER_SID(''EIS_PROD_Link'') IS NOT NULL
BEGIN
	CREATE USER [EIS_PROD_Link] FROM LOGIN [EIS_PROD_Link];
	ALTER ROLE db_datareader ADD MEMBER EIS_PROD_Link;
END'
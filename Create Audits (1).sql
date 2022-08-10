USE [master]
GO

CREATE PROCEDURE #CreateAudit (@DBName nvarchar(200), @FilePath nvarchar(1000)) AS
DECLARE @sql nvarchar(max)

SET @sql = 
'USE [master];
CREATE SERVER AUDIT [Audit data access on '+@DBName+']
TO FILE 
(	FILEPATH = N'''+@FilePath+'''
	,MAXSIZE = 1024 MB
	,MAX_FILES = 50
	,RESERVE_DISK_SPACE = ON
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)
ALTER SERVER AUDIT [Audit data access on '+@DBName+'] WITH (STATE = ON);'

SET @sql = @sql + 
'USE ['+@DBName+']
CREATE DATABASE AUDIT SPECIFICATION [Audit data access on '+@DBName+']
FOR SERVER AUDIT [Audit data access on '+@DBName+']
ADD (DELETE ON DATABASE::['+@DBName+'] BY [dbo]),
ADD (INSERT ON DATABASE::['+@DBName+'] BY [dbo]),
ADD (SELECT ON DATABASE::['+@DBName+'] BY [dbo]),
ADD (UPDATE ON DATABASE::['+@DBName+'] BY [dbo])
WITH (STATE = ON);
'
EXEC sp_executesql @sql
GO

EXEC #CreateAudit 'COR','J:\sqlauditfiles\'
EXEC #CreateAudit 'Enrollment_Kits','J:\sqlauditfiles\'
EXEC #CreateAudit 'LCWFS','J:\sqlauditfiles\'
EXEC #CreateAudit 'MCS','J:\sqlauditfiles\'
EXEC #CreateAudit 'mkagent','J:\sqlauditfiles\'

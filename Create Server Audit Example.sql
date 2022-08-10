USE [master]
GO

----------------------------------------------------------------------------------------------------
------------------------------------------  COR  --------------------------------------------------
----------------------------------------------------------------------------------------------------


CREATE SERVER AUDIT [Audit data access on COR]
TO FILE 
(	FILEPATH = N'J:\AuditFiles\'
	,MAXSIZE = 1024 MB
	,MAX_FILES = 50
	,RESERVE_DISK_SPACE = ON
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)
ALTER SERVER AUDIT [Audit data access on COR] WITH (STATE = ON)
GO


USE [TRS_BI_Staging]
GO

CREATE DATABASE AUDIT SPECIFICATION [Audit data access on COR]
FOR SERVER AUDIT [Audit data access on COR]
ADD (DELETE ON DATABASE::[COR] BY [dbo]),
ADD (INSERT ON DATABASE::[COR] BY [dbo]),
ADD (SELECT ON DATABASE::[COR] BY [dbo]),
ADD (UPDATE ON DATABASE::[COR] BY [dbo])
WITH (STATE = ON)
GO

----------------------------------------------------------------------------------------------------
------------------------------------------  Enrollment_Kits  --------------------------------------------------
----------------------------------------------------------------------------------------------------


CREATE SERVER AUDIT [Audit data access on Enrollment_Kits]
TO FILE 
(	FILEPATH = N'J:\AuditFiles\'
	,MAXSIZE = 1024 MB
	,MAX_FILES = 50
	,RESERVE_DISK_SPACE = ON
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)
ALTER SERVER AUDIT [Audit data access on Enrollment_Kits] WITH (STATE = ON)
GO


USE [TRS_BI_Staging]
GO

CREATE DATABASE AUDIT SPECIFICATION [Audit data access on Enrollment_Kits]
FOR SERVER AUDIT [Audit data access on Enrollment_Kits]
ADD (DELETE ON DATABASE::[Enrollment_Kits] BY [dbo]),
ADD (INSERT ON DATABASE::[Enrollment_Kits] BY [dbo]),
ADD (SELECT ON DATABASE::[Enrollment_Kits] BY [dbo]),
ADD (UPDATE ON DATABASE::[Enrollment_Kits] BY [dbo])
WITH (STATE = ON)
GO

----------------------------------------------------------------------------------------------------
------------------------------------------  LCWFS  --------------------------------------------------
----------------------------------------------------------------------------------------------------


CREATE SERVER AUDIT [Audit data access on LCWFS]
TO FILE 
(	FILEPATH = N'J:\AuditFiles\'
	,MAXSIZE = 1024 MB
	,MAX_FILES = 50
	,RESERVE_DISK_SPACE = ON
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)
ALTER SERVER AUDIT [Audit data access on LCWFS] WITH (STATE = ON)
GO


USE [TRS_BI_Staging]
GO

CREATE DATABASE AUDIT SPECIFICATION [Audit data access on LCWFS]
FOR SERVER AUDIT [Audit data access on LCWFS]
ADD (DELETE ON DATABASE::[LCWFS] BY [dbo]),
ADD (INSERT ON DATABASE::[LCWFS] BY [dbo]),
ADD (SELECT ON DATABASE::[LCWFS] BY [dbo]),
ADD (UPDATE ON DATABASE::[LCWFS] BY [dbo])
WITH (STATE = ON)
GO

----------------------------------------------------------------------------------------------------
------------------------------------------  MCS  --------------------------------------------------
----------------------------------------------------------------------------------------------------


CREATE SERVER AUDIT [Audit data access on MCS]
TO FILE 
(	FILEPATH = N'J:\AuditFiles\'
	,MAXSIZE = 1024 MB
	,MAX_FILES = 50
	,RESERVE_DISK_SPACE = ON
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)
ALTER SERVER AUDIT [Audit data access on MCS] WITH (STATE = ON)
GO


USE [TRS_BI_Staging]
GO

CREATE DATABASE AUDIT SPECIFICATION [Audit data access on MCS]
FOR SERVER AUDIT [Audit data access on MCS]
ADD (DELETE ON DATABASE::[MCS] BY [dbo]),
ADD (INSERT ON DATABASE::[MCS] BY [dbo]),
ADD (SELECT ON DATABASE::[MCS] BY [dbo]),
ADD (UPDATE ON DATABASE::[MCS] BY [dbo])
WITH (STATE = ON)
GO

----------------------------------------------------------------------------------------------------
------------------------------------------  mkagent  --------------------------------------------------
----------------------------------------------------------------------------------------------------


CREATE SERVER AUDIT [Audit data access on mkagent]
TO FILE 
(	FILEPATH = N'J:\AuditFiles\'
	,MAXSIZE = 1024 MB
	,MAX_FILES = 50
	,RESERVE_DISK_SPACE = ON
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)
ALTER SERVER AUDIT [Audit data access on mkagent] WITH (STATE = ON)
GO


USE [TRS_BI_Staging]
GO

CREATE DATABASE AUDIT SPECIFICATION [Audit data access on mkagent]
FOR SERVER AUDIT [Audit data access on mkagent]
ADD (DELETE ON DATABASE::[mkagent] BY [dbo]),
ADD (INSERT ON DATABASE::[mkagent] BY [dbo]),
ADD (SELECT ON DATABASE::[mkagent] BY [dbo]),
ADD (UPDATE ON DATABASE::[mkagent] BY [dbo])
WITH (STATE = ON)
GO


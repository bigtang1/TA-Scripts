USE SSDBAUtils
Go
CREATE TABLE [dbo].[Tbl_DB_Change_Log](
[database_name] [varchar](100) NULL,
[PostTime] [datetime] NULL,
[DB_User] [nvarchar](100) NULL,
[Event] [nvarchar](100) NULL,
[TSQL] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

Go

CREATE trigger [track_db_change]
on all server for DDL_DATABASE_LEVEL_EVENTS,DDL_SERVER_SECURITY_EVENTS
,CREATE_DATABASE
,ALTER_DATABASE
,DROP_DATABASE

AS
--execute AS Login ='sa'
set ansi_padding on
DECLARE @data XML
SET @data = EVENTDATA()
set nocount on
INSERT SSDBAUtils..Tbl_DB_Change_Log
   (database_name,PostTime, DB_User, Event, TSQL)
   VALUES
   (@data.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'nvarchar(100)'),GETDATE(),
   CONVERT(nvarchar(100), SUSER_NAME()),
   @data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'),
   @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)') ) ;
set nocount off
set ansi_padding off


GO



SELECT * FROM SSDBAUtils..Tbl_DB_Change_Log

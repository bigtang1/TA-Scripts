USE [dbutils]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_dbReplicaState]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create function [dbo].[fn_dbReplicaState](@database_name sysname)
returns nvarchar(60)
as
begin

	declare @current_role nvarchar(60)

	if SERVERPROPERTY('IsHadrEnabled') =  1

		select @current_role = role_desc 
		from sys.dm_hadr_availability_replica_states 
		where is_local = 1
		and group_id in 
		(
			select group_id 		
			from sys.availability_databases_cluster 
			where database_name = @database_name
		)

	return isnull(@current_role,'NONE')

end
GO
/****** Object:  UserDefinedFunction [dbo].[fn_getdriveinfo]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_getdriveinfo] ()
RETURNS @DriveInfo TABLE
(
	DriveLetter char(1),
	TotalSpace bigint,
	FreeSpace bigint,
	Label nvarchar(256)
)
AS
BEGIN

	DECLARE @Result INT
	DECLARE @objFSO INT
	DECLARE @Drv INT 
	DECLARE @cDrive VARCHAR(13) 
	DECLARE @Size VARCHAR(50) 
	DECLARE @Free VARCHAR(50)
	DECLARE @Label varchar(10)
	DECLARE @DriveLetter int
	DECLARE @DriveType int

	EXEC sp_OACreate 'Scripting.FileSystemObject', @objFSO OUTPUT 

	--Start at C:
	SET @DriveLetter = 67
	
	WHILE @DriveLetter <= 90
	BEGIN

		SET @cDrive = 'GetDrive("' + CHAR(@DriveLetter) + '")' 
		
		EXEC @Result = sp_OAMethod @objFSO, @cDrive, @Drv OUTPUT 
		
		If @Result = 0
		BEGIN

			EXEC sp_OAGetProperty @Drv,'TotalSize', @Size OUTPUT 
			EXEC sp_OAGetProperty @Drv,'FreeSpace', @Free OUTPUT 
			EXEC sp_OAGetProperty @Drv,'VolumeName', @Label OUTPUT
			EXEC sp_OAGetProperty @Drv,'DriveType', @DriveType OUTPUT 

			EXEC sp_OADestroy @Drv 
			
			SET @Size = (CONVERT(BIGINT,@Size) / 1024 / 1024 )
			SET @Free = (CONVERT(BIGINT,@Free) / 1024 / 1024 )

			--Only concerned with fixed drives, ignore everythign else
			IF @DriveType = 2
				INSERT INTO @DriveInfo VALUES (CHAR(@DriveLetter), @Size, @Free, @Label)

		END
		
		SET @DriveLetter = @DriveLetter + 1

	END

	EXEC sp_OADestroy @objFSO 

	RETURN
END
GO
/****** Object:  Table [dbo].[backup_exclusions]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[backup_exclusions](
	[db_name] [varchar](50) NOT NULL,
	[exclude_full] [bit] NOT NULL,
	[exclude_diff] [bit] NOT NULL,
	[exclude_log] [bit] NOT NULL,
	[exclude_cleanup] [bit] NOT NULL,
	[comment] [nvarchar](255) NULL,
	[added_by] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[backup_database_status]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_database_status]
as
	select 
		cast(d.name as nvarchar(30)) as name, 
		case  
			when d.source_database_id is null 
			then cast(databasepropertyex(d.name, 'status') as nvarchar(15)) 
			else 'SNAPSHOT'
		end as status, 
		cast(dbutils.dbo.fn_dbReplicaState(d.name) as nvarchar(15)) as replica_state, 
		cast(databasepropertyex(d.name, 'recovery') as nvarchar(15)) as recovery_model,
		e.exclude_full,
		e.exclude_diff,
		e.exclude_log
	from 
		master.sys.databases d
	left outer join 
		dbutils.dbo.backup_exclusions e
	on e.db_name COLLATE DATABASE_DEFAULT = d.name
GO
/****** Object:  View [dbo].[backup_database_status_2005]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_database_status_2005]
as
	select 
		cast(d.name as nvarchar(30)) as name, 
		cast(databasepropertyex(d.name, 'status') as nvarchar(15)) as status, 
		cast(databasepropertyex(d.name, 'recovery') as nvarchar(15)) as recovery_model,
		e.exclude_full,
		e.exclude_diff,
		e.exclude_log
	from 
		master.sys.databases d
	left outer join 
		dbutils.dbo.backup_exclusions e
	on e.db_name COLLATE DATABASE_DEFAULT = d.name
GO
/****** Object:  View [dbo].[backup_eligible_diff_databases]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_eligible_diff_databases]
as
	select 
		name 
	from 
		master.sys.databases
	where 
		name not in ('master', 'msdb', 'tempdb', 'model')
		and source_database_id is null
		and name not in ( select db_name COLLATE DATABASE_DEFAULT from dbutils.dbo.backup_exclusions where exclude_diff = 1 )
		and cast(databasepropertyex(name, 'status') as nvarchar(128)) = 'ONLINE'
		and dbutils.dbo.fn_dbReplicaState(name) COLLATE DATABASE_DEFAULT in ('NONE', 'PRIMARY')
GO
/****** Object:  View [dbo].[backup_eligible_diff_databases_2005]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_eligible_diff_databases_2005]
as
	select 
		name 
	from 
		master.dbo.sysdatabases
	where 
		name not in ('master', 'msdb', 'tempdb', 'model')
		and name not in ( select db_name COLLATE DATABASE_DEFAULT from dbutils.dbo.backup_exclusions where exclude_diff = 1 )
		and cast(databasepropertyex(name, 'status') as nvarchar(128)) = 'ONLINE'
GO
/****** Object:  View [dbo].[backup_eligible_full_databases]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_eligible_full_databases]
as
	select 
		name 
	from 
		master.sys.databases
	where 
		name not in ('master', 'msdb', 'tempdb', 'model')
		and source_database_id is null
		and name not in ( select db_name COLLATE DATABASE_DEFAULT from dbutils.dbo.backup_exclusions where exclude_full = 1 )
		and cast(databasepropertyex(name, 'status') as nvarchar(128)) = 'ONLINE'
		and dbutils.dbo.fn_dbReplicaState(name) COLLATE DATABASE_DEFAULT in ('NONE', 'PRIMARY')
GO
/****** Object:  View [dbo].[backup_eligible_full_databases_2005]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_eligible_full_databases_2005]
as
	select 
		name 
	from 
		master.dbo.sysdatabases
	where 
		name not in ('master', 'msdb', 'tempdb', 'model')
		and name not in ( select db_name COLLATE DATABASE_DEFAULT from dbutils.dbo.backup_exclusions where exclude_full = 1 )
		and cast(databasepropertyex(name, 'status') as nvarchar(128)) = 'ONLINE'
GO
/****** Object:  View [dbo].[backup_eligible_log_databases]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_eligible_log_databases]
as
	select 
		name 
	from 
		master.sys.databases
	where 
		name not in ('master', 'msdb', 'tempdb', 'model')
		and source_database_id is null
		and name not in ( select db_name COLLATE DATABASE_DEFAULT from dbutils.dbo.backup_exclusions where exclude_log = 1 )
		and cast(databasepropertyex(name, 'status') as nvarchar(128)) = 'ONLINE'
		and cast(databasepropertyex(name, 'recovery') as nvarchar(128)) <> 'SIMPLE'
		and cast(databasepropertyex(name, 'updateability') as nvarchar(128)) = 'READ_WRITE'
GO
/****** Object:  View [dbo].[backup_eligible_log_databases_2005]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_eligible_log_databases_2005]
as
	select 
		name 
	from 
		master.dbo.sysdatabases
	where 
		name not in ('master', 'msdb', 'tempdb', 'model')
		and name not in ( select db_name COLLATE DATABASE_DEFAULT from dbutils.dbo.backup_exclusions where exclude_log = 1 )
		and cast(databasepropertyex(name, 'status') as nvarchar(128)) = 'ONLINE'
		and cast(databasepropertyex(name, 'recovery') as nvarchar(128)) <> 'SIMPLE'
		and cast(databasepropertyex(name, 'updateability') as nvarchar(128)) = 'READ_WRITE'
GO
/****** Object:  View [dbo].[backup_eligible_sys_databases]    Script Date: 10/19/2022 1:46:26 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_eligible_sys_databases]
as
	select 
		name 
	from 
		master.sys.databases
	where 
		name in ('master', 'msdb', 'model')
		and source_database_id is null
		and cast(databasepropertyex(name, 'status') as nvarchar(128)) = 'ONLINE'
GO
/****** Object:  View [dbo].[backup_eligible_sys_databases_2005]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create view [dbo].[backup_eligible_sys_databases_2005]
as
	select 
		name 
	from 
		master.dbo.sysdatabases
	where 
		name in ('master', 'msdb', 'model')
		and cast(databasepropertyex(name, 'status') as nvarchar(128)) = 'ONLINE'
GO
/****** Object:  Table [dbo].[AdminsMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminsMaster](
	[Instance] [sysname] NULL,
	[Admins] [nvarchar](256) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[backup_config]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[backup_config](
	[backup_method] [nvarchar](6) NOT NULL,
	[native_dest_full] [nvarchar](1024) NULL,
	[native_dest_diff] [nvarchar](1024) NULL,
	[native_dest_log] [nvarchar](1024) NULL,
	[native_retention_days] [int] NULL,
	[native_retention_days_log] [int] NULL,
	[native_skip_checks] [bit] NULL,
	[nbu_directory] [nvarchar](256) NULL,
	[nbu_master_server] [nvarchar](128) NULL,
	[nbu_policy] [nvarchar](64) NULL,
	[nbu_stripes_full] [int] NULL,
	[nbu_stripes_diff] [int] NULL,
	[nbu_batchsize_log] [int] NULL,
	[nbu_numbufs] [nvarchar](10) NOT NULL,
	[compression] [nvarchar](20) NOT NULL,
	[Exclude_User_DBs] [bit] NULL,
	[nbu_policy_full] [nvarchar](64) NULL,
	[nbu_policy_sys] [nvarchar](64) NULL,
	[nbu_policy_diff] [nvarchar](64) NULL,
	[nbu_policy_log] [nvarchar](64) NULL,
	[s3backup_source] [nvarchar](50) NULL,
	[s3bucketname] [nvarchar](50) NULL,
	[s3folder] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConfigMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigMaster](
	[Instance] [sysname] NULL,
	[ConfigName] [nvarchar](50) NULL,
	[MinValue] [int] NULL,
	[MaxValue] [int] NULL,
	[ConfigValue] [int] NULL,
	[RunValue] [int] NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataFileStatsMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataFileStatsMaster](
	[Instance] [sysname] NULL,
	[DBName] [varchar](255) NULL,
	[FileId] [int] NULL,
	[FileGroup] [int] NULL,
	[TotalExtents] [decimal](20, 2) NULL,
	[UsedExtents] [decimal](20, 2) NULL,
	[Name] [varchar](255) NULL,
	[FileName] [varchar](400) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DBFileInfoMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBFileInfoMaster](
	[Instance] [sysname] NULL,
	[DBName] [varchar](65) NULL,
	[LogicalFileName] [varchar](400) NULL,
	[UsageType] [varchar](30) NULL,
	[Size_MB] [decimal](20, 2) NULL,
	[SpaceUsed_MB] [decimal](20, 2) NULL,
	[MaxSize_MB] [decimal](20, 2) NULL,
	[NextAllocation_MB] [decimal](20, 2) NULL,
	[GrowthType] [varchar](65) NULL,
	[FileId] [int] NULL,
	[GroupId] [int] NULL,
	[PhysicalFileName] [varchar](400) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DBMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBMaster](
	[Instance] [sysname] NULL,
	[DatabaseName] [sysname] NULL,
	[DBType] [nchar](6) NULL,
	[RecoveryModel] [nvarchar](11) NULL,
	[ReadOnly] [bit] NULL,
	[State] [nvarchar](60) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DBRoleMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBRoleMaster](
	[Instance] [nvarchar](128) NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[DBRole] [varchar](100) NULL,
	[MemberName] [varchar](100) NULL,
	[MemberSID] [varbinary](128) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DBSizeMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBSizeMaster](
	[Instance] [sysname] NULL,
	[DatabaseName] [sysname] NULL,
	[MBFileSize] [int] NULL,
	[DBFileName] [nvarchar](260) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FixedDrivesMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FixedDrivesMaster](
	[Instance] [sysname] NULL,
	[DriveLetter] [varchar](10) NULL,
	[Label] [nvarchar](256) NULL,
	[MB_Total] [int] NULL,
	[MB_Free] [int] NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuestAccessMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuestAccessMaster](
	[Instance] [sysname] NULL,
	[DBName] [varchar](255) NULL,
	[StateDesc] [nvarchar](128) NULL,
	[PermissionName] [nvarchar](128) NULL,
	[ClassDesc] [nvarchar](128) NULL,
	[SecurableName] [nvarchar](128) NULL,
	[Schema] [nvarchar](128) NULL,
	[Grantee] [sysname] NOT NULL,
	[TypeDesc] [nvarchar](128) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[install_info]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[install_info](
	[Installed_By] [nvarchar](128) NULL,
	[Install_Date] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstanceMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstanceMaster](
	[ID] [int] NULL,
	[Name] [sysname] NULL,
	[Internal_Value] [int] NULL,
	[Value] [nvarchar](512) NULL,
	[Instance] [sysname] NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginMaster](
	[Instance] [sysname] NULL,
	[LoginName] [sysname] NULL,
	[LoginType] [char](1) NULL,
	[is_disabled] [sysname] NULL,
	[LastUpdate] [datetime] NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogSizeStatsMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogSizeStatsMaster](
	[Instance] [sysname] NULL,
	[DBName] [varchar](255) NULL,
	[LogFile] [real] NULL,
	[LogFileUsed] [real] NULL,
	[Status] [bit] NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[maintenance_exclusions]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[maintenance_exclusions](
	[db_name] [varchar](50) NOT NULL,
	[exclude_stats] [bit] NOT NULL,
	[exclude_defrag] [bit] NOT NULL,
	[exclude_checkdb] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MirrorMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MirrorMaster](
	[PrincipleInstance] [sysname] NULL,
	[Database] [sysname] NULL,
	[MirrorInstance] [sysname] NOT NULL,
	[SafetyLevel] [nvarchar](60) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProtectMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProtectMaster](
	[Instance] [sysname] NULL,
	[Owner] [sysname] NULL,
	[Object] [sysname] NULL,
	[Grantee] [sysname] NULL,
	[Grantor] [sysname] NULL,
	[ProtectType] [nvarchar](10) NULL,
	[Action] [nvarchar](50) NULL,
	[Column] [sysname] NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegReadMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegReadMaster](
	[Instance] [sysname] NULL,
	[Value] [nvarchar](128) NULL,
	[Data] [nvarchar](128) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMaster](
	[Instance] [sysname] NULL,
	[ServerRole] [sysname] NULL,
	[MemberName] [sysname] NULL,
	[MemberSID] [varbinary](85) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[serverexclude]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[serverexclude](
	[Exclude_any_rerun] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SetupFileMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SetupFileMaster](
	[Instance] [sysname] NULL,
	[SetupFileName] [nvarchar](50) NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMaster](
	[Instance] [sysname] NULL,
	[DatabaseName] [sysname] NULL,
	[UserName] [sysname] NULL,
	[hasdbaccess] [sysname] NULL,
	[is_policy_checked] [sysname] NULL,
	[CollectDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdminsMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[backup_config] ADD  CONSTRAINT [df_backup_config_native_retention_days]  DEFAULT ((7)) FOR [native_retention_days]
GO
ALTER TABLE [dbo].[backup_config] ADD  CONSTRAINT [df_backup_config_native_retention_days_log]  DEFAULT ((3)) FOR [native_retention_days_log]
GO
ALTER TABLE [dbo].[backup_config] ADD  CONSTRAINT [df_backup_config_native_skip_checks]  DEFAULT ((0)) FOR [native_skip_checks]
GO
ALTER TABLE [dbo].[backup_config] ADD  CONSTRAINT [df_backup_config_nbu_directory]  DEFAULT (N'C:\Progra~1\VERITAS\NetBackup\bin\') FOR [nbu_directory]
GO
ALTER TABLE [dbo].[backup_config] ADD  CONSTRAINT [df_backup_config_nbu_master_server]  DEFAULT (N'DCCLU17.US.AEGON.COM') FOR [nbu_master_server]
GO
ALTER TABLE [dbo].[backup_config] ADD  CONSTRAINT [df_backup_config_nbu_stripes_full]  DEFAULT ((1)) FOR [nbu_stripes_full]
GO
ALTER TABLE [dbo].[backup_config] ADD  CONSTRAINT [df_backup_config_nbu_stripes_diff]  DEFAULT ((1)) FOR [nbu_stripes_diff]
GO
ALTER TABLE [dbo].[backup_config] ADD  CONSTRAINT [df_backup_config_nbu_stripes_log]  DEFAULT ((1)) FOR [nbu_batchsize_log]
GO
ALTER TABLE [dbo].[backup_config] ADD  DEFAULT ((2)) FOR [nbu_numbufs]
GO
ALTER TABLE [dbo].[backup_config] ADD  DEFAULT (N'TRUE') FOR [compression]
GO
ALTER TABLE [dbo].[backup_exclusions] ADD  CONSTRAINT [df_backup_exclusions_exclude_full]  DEFAULT ((0)) FOR [exclude_full]
GO
ALTER TABLE [dbo].[backup_exclusions] ADD  CONSTRAINT [df_backup_exclusions_exclude_diff]  DEFAULT ((0)) FOR [exclude_diff]
GO
ALTER TABLE [dbo].[backup_exclusions] ADD  CONSTRAINT [df_backup_exclusions_exclude_log]  DEFAULT ((0)) FOR [exclude_log]
GO
ALTER TABLE [dbo].[backup_exclusions] ADD  CONSTRAINT [df_backup_exclusions_exclude_cleanup]  DEFAULT ((0)) FOR [exclude_cleanup]
GO
ALTER TABLE [dbo].[ConfigMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[DataFileStatsMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[DBFileInfoMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[DBMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[DBRoleMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[DBSizeMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[FixedDrivesMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[GuestAccessMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[InstanceMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[LoginMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[LogSizeStatsMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[maintenance_exclusions] ADD  CONSTRAINT [df_maintenance_exclusions_exclude_stats]  DEFAULT ((0)) FOR [exclude_stats]
GO
ALTER TABLE [dbo].[maintenance_exclusions] ADD  CONSTRAINT [df_maintenance_exclusions_exclude_defrag]  DEFAULT ((0)) FOR [exclude_defrag]
GO
ALTER TABLE [dbo].[maintenance_exclusions] ADD  CONSTRAINT [df_maintenance_exclusions_exclude_checkdb]  DEFAULT ((0)) FOR [exclude_checkdb]
GO
ALTER TABLE [dbo].[MirrorMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[ProtectMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[RegReadMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[RoleMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[SetupFileMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[UserMaster] ADD  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[backup_config]  WITH CHECK ADD  CONSTRAINT [CK_backup_config_backup_method] CHECK  (([backup_method]='native' OR [backup_method]='nbu' OR [backup_method]='s3'))
GO
ALTER TABLE [dbo].[backup_config] CHECK CONSTRAINT [CK_backup_config_backup_method]
GO
ALTER TABLE [dbo].[backup_config]  WITH CHECK ADD  CONSTRAINT [CK_backup_config_nbu_batchsize_log] CHECK  (([nbu_batchsize_log]<=(6)))
GO
ALTER TABLE [dbo].[backup_config] CHECK CONSTRAINT [CK_backup_config_nbu_batchsize_log]
GO
ALTER TABLE [dbo].[backup_config]  WITH CHECK ADD  CONSTRAINT [CK_backup_config_nbu_numbufs] CHECK  (([nbu_numbufs]<=(2)))
GO
ALTER TABLE [dbo].[backup_config] CHECK CONSTRAINT [CK_backup_config_nbu_numbufs]
GO
ALTER TABLE [dbo].[backup_config]  WITH CHECK ADD  CONSTRAINT [CK_backup_config_nbu_stripes_diff] CHECK  (([nbu_stripes_diff]<=(6)))
GO
ALTER TABLE [dbo].[backup_config] CHECK CONSTRAINT [CK_backup_config_nbu_stripes_diff]
GO
ALTER TABLE [dbo].[backup_config]  WITH CHECK ADD  CONSTRAINT [CK_backup_config_nbu_stripes_full] CHECK  (([nbu_stripes_full]<=(6)))
GO
ALTER TABLE [dbo].[backup_config] CHECK CONSTRAINT [CK_backup_config_nbu_stripes_full]
GO
/****** Object:  StoredProcedure [dbo].[pCollectLocalServerData]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE  procedure [dbo].[pCollectLocalServerData] 
	@CompileOnly bit = 0
as
set nocount on

declare @Instance nvarchar(128),
        @TabName nvarchar(128),
--08/11/16 Changed Cmd value from 1000 to 1100 - II
        @Cmd nvarchar(1100),
        @UserName nvarchar(128),
     
        @SmoLoginMode int,
        @SmoAuditLevel int,

        @Version varchar(4),
        @ReturnVal int,
        @SQLPath varchar(256),
        @Now datetime,
        @Status sql_variant,
	@HADRStatus sql_variant,
        @DatabaseName sysname, 
        @DBType nvarchar(6),
--      Added 3/24/10 to support license reporting
		@ServicePack nvarchar(6),
		@Edition nvarchar(128),
		@MaxCol int

select @Now = getdate()

--drop and create Master tables needed for collection
if exists(select * from dbutils.dbo.sysobjects where name = 'InstanceMaster')
   drop table dbutils.dbo.InstanceMaster
create table dbutils.dbo.InstanceMaster (ID int null,  Name  sysname null, Internal_Value int null, Value nvarchar(512) null, Instance sysname null, CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'DBMaster')
   drop table dbutils.dbo.DBMaster
create table dbutils.dbo.DBMaster (Instance sysname null, DatabaseName sysname null,  DBType nchar(6) null, RecoveryModel nvarchar(11), ReadOnly bit, State nvarchar(60), CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'RegReadMaster')
   drop table dbutils.dbo.RegReadMaster
create table dbutils.dbo.RegReadMaster (Instance sysname null, Value nvarchar(128) null, Data nvarchar(128) null,CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'SetupFileMaster')
    drop table dbutils.dbo.SetupFileMaster
create table dbutils.dbo.SetupFileMaster (Instance sysname null, SetupFileName nvarchar(50) null,CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'ConfigMaster')
    drop table dbutils.dbo.ConfigMaster
create table dbutils.dbo.ConfigMaster (Instance sysname null, ConfigName nvarchar(50) null, MinValue int null, MaxValue int null, ConfigValue int null, RunValue int null,CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'RoleMaster')
   drop table dbutils.dbo.RoleMaster
create table dbutils.dbo.RoleMaster (Instance sysname null, ServerRole sysname null, MemberName sysname null, MemberSID varbinary(85) null,CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'ProtectMaster')
   drop table dbutils.dbo.ProtectMaster
create table dbutils.dbo.ProtectMaster (Instance sysname null, [Owner] sysname null,  [Object] sysname null, Grantee sysname null, Grantor sysname null, ProtectType nvarchar(10) null, [Action] nvarchar(50) null,  [Column] sysname null, CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'LoginMaster')
   drop table dbutils.dbo.LoginMaster
create table dbutils.dbo.LoginMaster (Instance sysname null, LoginName sysname null, LoginType char null, is_disabled sysname null, LastUpdate datetime null, CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'DBSizeMaster')
   drop table dbutils.dbo.DBSizeMaster
create table dbutils.dbo.DBSizeMaster (Instance sysname NULL, DatabaseName sysname  null, MBFileSize int NULL, DBFileName nvarchar(260)  null, CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'UserMaster')
   drop table dbutils.dbo.UserMaster
create table dbutils.dbo.UserMaster (Instance sysname null, DatabaseName sysname null, UserName sysname null, hasdbaccess sysname null, is_policy_checked sysname null, CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'LogSizeStatsMaster')
   drop table dbutils.dbo.LogSizeStatsMaster
create table LogSizeStatsMaster (Instance sysname null, DBName varchar(255) NULL ,LogFile real,LogFileUsed real,Status bit, CollectDate datetime null default getdate()) 

if exists(select * from dbutils.dbo.sysobjects where name = 'FixedDrivesMaster')
   drop table dbutils.dbo.FixedDrivesMaster
create table FixedDrivesMaster (Instance sysname null, DriveLetter varchar(10), Label NVARCHAR(256), MB_Total int, MB_Free int, CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'DBFileInfoMaster')
   drop table dbutils.dbo.DBFileInfoMaster
create table DBFileInfoMaster( Instance sysname null,[DBName] varchar(65),[LogicalFileName] varchar(400),[UsageType] varchar (30),[Size_MB] dec(20,2), [SpaceUsed_MB] dec(20,2),[MaxSize_MB] dec(20,2),[NextAllocation_MB] dec(20,2), [GrowthType] varchar(65),[FileId] int,[GroupId] int,[PhysicalFileName] varchar(400),CollectDate datetime null default getdate()) 

if exists(select * from dbutils.dbo.sysobjects where name = 'DataFileStatsMaster')
   drop table dbutils.dbo.DataFileStatsMaster
create table DataFileStatsMaster(Instance sysname null,  DBName varchar(255), FileId int, [FileGroup] int, TotalExtents dec(20,2),UsedExtents dec(20,2),[Name] varchar(255), [FileName] varchar(400), CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'DBRoleMaster')
   drop table dbutils.dbo.DBRoleMaster
create table DBRoleMaster ([Instance] [nvarchar](128) NULL, [DatabaseName] [nvarchar](128) NULL, [DBRole] [varchar](100) null, [MemberName] [varchar](100) null, [MemberSID] [varbinary](128) null, [CollectDate] [datetime] NULL DEFAULT getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'GuestAccessMaster')
   drop table dbutils.dbo.GuestAccessMaster
create table [dbo].[GuestAccessMaster](Instance sysname null,  DBName varchar(255),[StateDesc] [nvarchar](128) NULL,[PermissionName] [nvarchar](128) NULL,[ClassDesc] [nvarchar](128) NULL,[SecurableName] [nvarchar](128) NULL,	[Schema] [nvarchar](128) NULL,	[Grantee] [sysname] NOT NULL,[TypeDesc] [nvarchar](128) NULL, CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'MirrorMaster')
   drop table dbutils.dbo.MirrorMaster
create table dbutils.dbo.MirrorMaster (PrincipleInstance sysname null, [Database] sysname null, MirrorInstance sysname, SafetyLevel nvarchar(60), CollectDate datetime null default getdate())

if exists(select * from dbutils.dbo.sysobjects where name = 'AdminsMaster')
   drop table dbutils.dbo.AdminsMaster
create table dbutils.dbo.AdminsMaster (Instance sysname null, Admins nvarchar(256), CollectDate datetime null default getdate())




select @Instance = @@servername
   
create table #t_ver (ID int,  Name  sysname, Internal_Value int, Value nvarchar(512))
insert #t_ver exec master.dbo.xp_msver
-- added to support license reporting start
select @MaxCol = (select max(ID) from #t_ver)
set @ServicePack = (select cast(SERVERPROPERTY ('productlevel') as nvarchar(6)))
set @Edition = (select cast(SERVERPROPERTY ('edition') as nvarchar(128)))
insert into #t_ver (ID, Name, Internal_Value,Value)
values (@MaxCol + 1,'ServicePack',null,@ServicePack)
insert into #t_ver (ID, Name, Internal_Value,Value)
values (@MaxCol + 2,'Edition',null,@Edition)
-- added to support license reporting end
insert into dbutils.dbo.InstanceMaster (ID, Name, Internal_Value, Value, Instance) select ID, Name, Internal_Value, Value, @Instance From #t_ver

select @Version = substring(Value,1,4) from #t_ver where Name = 'FileVersion' 

insert into dbutils.dbo.DBMaster (Instance, DatabaseName,  DBType, RecoveryModel, ReadOnly, State) select  @Instance, name, null, recovery_model_desc, is_read_only, state_desc from master.sys.databases

update dbutils.dbo.DBMaster set DBType = 'System' where DatabaseName in ('master', 'tempdb', 'msdb', 'model')
update dbutils.dbo.DBMaster set DBType = 'Sample' where DatabaseName in ('pubs', 'northwind','AdventureWorks', 'AdventureWorksDW')
update dbutils.dbo.DBMaster set DBType = 'User' where DBType is null


create table #trr (Value nvarchar(128),  Data nvarchar(128))


insert #trr exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'LoginMode'
insert #trr exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'AuditLevel'
insert #trr exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer\SuperSocketNetLib\Tcp', N'TcpPort'
insert #trr exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\Setup', N'PatchLevel'
insert #trr exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\Setup', N'SQLPath'


insert into dbutils.dbo.RegReadMaster (Instance, Value, Data) select  @Instance, Value, Data From #trr



select @SQLPath = Data + '\Install' from dbutils.dbo.RegReadMaster where Instance = @Instance and Value = 'SQLPath'


create table #tsetup (SetupFileName varchar(256))

select @Cmd = 'dir /b ' + @SQLPath + '\sql*.log'
insert #tsetup exec master.dbo.xp_cmdshell @Cmd
select @Cmd = 'dir /b ' + @SQLPath + '\setup.iss'
insert #tsetup exec master.dbo.xp_cmdshell @Cmd

insert into dbutils.dbo.SetupFileMaster (Instance, SetupFileName) select  @Instance, SetupFileName From #tsetup




create table #tconfig (ConfigName nvarchar(50), MinValue int, MaxValue int, ConfigValue int, RunValue int)
insert #tconfig exec master.dbo.sp_configure
insert into dbutils.dbo.ConfigMaster (Instance, ConfigName, MinValue, MaxValue, ConfigValue, RunValue) select @Instance as Instance, ConfigName, MinValue, MaxValue, ConfigValue, RunValue From #tconfig





create table #trole (ServerRole sysname, MemberName sysname, MemberSID varbinary(85))
insert #trole exec master.dbo.sp_helpsrvrolemember
insert into dbutils.dbo.RoleMaster (Instance, ServerRole, MemberName, MemberSID) select @Instance, ServerRole, MemberName, MemberSID From #trole

	
insert into dbutils.dbo.MirrorMaster 
SELECT @@servername , d.name , m.mirroring_partner_instance , m.mirroring_safety_level_desc ,null
FROM   sys.database_mirroring m JOIN sys.databases d ON
       m.database_id = d.database_id
WHERE  mirroring_state_desc IS NOT NULL
and mirroring_role_desc = 'PRINCIPAL'


--STORED/EXTENDED PROC AUDIT
insert into dbutils.dbo.ProtectMaster ([Owner], [Object], Grantee, Grantor, ProtectType, Action, [Column]) exec master.dbo.sp_helprotect


update dbutils.dbo.ProtectMaster set Instance = @Instance 

--LOGIN AUDIT

insert into dbutils.dbo.LoginMaster (Instance, LoginName, LoginType, is_disabled, LastUpdate) select @Instance as Instance, name, type, is_disabled, modify_date From master.sys.server_principals



insert into LogSizeStatsMaster (DBName,LogFile,LogFileUsed,Status) exec ('DBCC SQLPERF(LOGSPACE) WITH NO_INFOMSGS')
update LogSizeStatsMaster Set Instance = @Instance

--LOCAL ADMINS

declare @LocalAdmins table ( result_text nvarchar(256))

insert into @LocalAdmins exec xp_cmdshell 'net localgroup "Administrators"'

delete from @LocalAdmins where result_text is null
delete from @LocalAdmins where result_text like '---%'
delete from @LocalAdmins where result_text like 'Alias name%'
delete from @LocalAdmins where result_text like 'Comment%'
delete from @LocalAdmins where result_text like 'Members%'
delete from @LocalAdmins where result_text like 'The command%'

insert into dbutils.dbo.AdminsMaster (Instance, Admins) select @Instance, result_text from @LocalAdmins 

--DRIVE DETAILS

INSERT INTO dbutils.dbo.FixedDrivesMaster
SELECT @@SERVERNAME, DriveLetter, Label, TotalSpace, FreeSpace, GetDate()
FROM dbutils.dbo.fn_getdriveinfo()

--END DRIVE DETAILS


declare cur_DBMaster cursor for select Instance, DatabaseName from dbutils.dbo.DBMaster order by Instance, DatabaseName
open cur_DBMaster

fetch next from cur_DBMaster into @Instance, @DatabaseName

while @@fetch_status = 0
  begin
	select @Status = databasepropertyex(@DatabaseName,'status')
	select @HADRStatus = dbutils.dbo.fn_dbReplicaState(@DatabaseName)

    if @Status = 'ONLINE' and @HADRStatus in ('PRIMARY','NONE')
       begin
	     select @Cmd = 'insert into dbutils.dbo.UserMaster (Instance, DatabaseName, UserName, hasdbaccess, is_policy_checked) select ''' + @Instance + ''', ''' + @DatabaseName + ''', sysusers.name, hasdbaccess, is_policy_checked  From [' + @DatabaseName + '].dbo.sysusers left join sys.sql_logins on sysusers.sid = sql_logins.sid order by uid'
		 if @CompileOnly = 0 exec(@Cmd) else print @Cmd
		 select @Cmd = 'insert into dbutils.dbo.DBSizeMaster (Instance, DatabaseName, MBFileSize, DBFileName) select ''' + @Instance + ''', ''' + @DatabaseName + ''', CAST(size as bigint) * 8 / 1024, filename From [' + @DatabaseName + '].dbo.sysfiles'
		 if @CompileOnly = 0 exec(@Cmd) else print @Cmd

		select @Cmd =
		'SELECT Instance = ''' + @Instance + ''','+
		' DBName = left(''' + @DatabaseName + ''',65),'+
		' LogicalFileName = [name],'+
		' UsageType = CASE WHEN (64&[status])=64 THEN ''Log'' ELSE ''Data'' END,'+
		' Size_MB = CAST(size as bigint)*8/1024.00,'+
		' SpaceUsed_MB = NULL,'+
		' MaxSize_MB = CASE [maxsize] WHEN -1 THEN -1 WHEN 0 THEN CAST(size as bigint)*8/1024.00 ELSE maxsize/**8/1024.00*/ END,'+
		' NextExtent_MB = CASE WHEN (1048576&[status])=1048576 THEN ([growth]/100.00)*(CAST(size as bigint)*8/1024.00) WHEN [growth]=0 THEN 0 ELSE [growth]*8/1024.00 END,'+
		' GrowthType = CASE WHEN (1048576&[status])=1048576 THEN ''%'' ELSE ''Pages'' END,'+
		' FileId = [fileid],'+
		' GroupId = [groupid],'+
		' PhysicalFileName= [filename],'+
		' CurTimeStamp = GETDATE()'+
		'FROM ['+@DatabaseName+']..sysfiles' 


        insert into DBFileInfoMaster exec (@Cmd)

		update DBFileInfoMaster
		set SpaceUsed_MB = (select LogFileUsed from LogSizeStatsMaster where DBName = @DatabaseName)
		where UsageType = 'Log'
		and DBName = @DatabaseName 

		select @Cmd = 'USE [' + @DatabaseName + '] DBCC SHOWFILESTATS WITH NO_INFOMSGS'

		insert DataFileStatsMaster (FileId,[FileGroup],TotalExtents,UsedExtents,[Name],[FileName])execute(@Cmd)

        update DataFileStatsMaster set DBName = @DatabaseName, Instance = @Instance where DBName is null


		update DBFileInfoMaster
		set [SpaceUsed_MB] = S.[UsedExtents]*64/1024.00
		from DBFileInfoMaster as F
		inner join DataFileStatsMaster as S
		on F.[FileId] = S.[FileId]
		and F.[GroupId] = S.[FileGroup]
		and F.[DBName] = S.[DBName] 
        and F.[DBName] = @DatabaseName

        
		select @Cmd = 'USE [' + @DatabaseName + '] exec sp_helprolemember'

       insert into DBRoleMaster (DBRole, MemberName, MemberSID) execute (@Cmd)

       update DBRoleMaster set Instance = @Instance,
                               DatabaseName = @DatabaseName
       where Instance is null


		if @Version <> '2000'
		  begin
			select @Cmd = 'INSERT INTO GuestAccessMaster (Instance, DBName, StateDesc, PermissionName, ClassDesc, SecurableName, [Schema], Grantee, TypeDesc)
			SELECT ''' + @Instance + ''', ''' + @DatabaseName +''', 
				State_Desc, Permission_Name, Class_Desc,
				COALESCE(O.name,DB_NAME(Perms.major_id)) SecurableName,
				SCHEMA_NAME(O.schema_id) [Schema], Grantees.Name Grantee, Grantees.Type_Desc
			FROM [' + @DatabaseName + '].sys.database_permissions Perms
			INNER JOIN [' + @DatabaseName + '].sys.database_principals Grantees ON Perms.Grantee_Principal_Id = Grantees.Principal_Id
			LEFT OUTER JOIN [' + @DatabaseName + '].sys.all_objects O ON Perms.major_id = O.object_id
			where Permission_Name = ''CONNECT'' and Grantees.Name = ''guest''
			ORDER BY SecurableName'

            exec (@Cmd)
		  end





       end
     else
       print 'skipping database ' + @DatabaseName

    fetch next from cur_DBMaster into @Instance, @DatabaseName
  end

close cur_DBMaster
deallocate cur_DBMaster


update DBFileInfoMaster set SpaceUsed_MB = case when Size_MB < SpaceUsed_MB then NULL else SpaceUsed_MB end where UsageType = 'Log'

update dbutils.dbo.InstanceMaster set CollectDate = @Now
update dbutils.dbo.DBMaster set CollectDate = @Now
update dbutils.dbo.RegReadMaster set CollectDate = @Now
update dbutils.dbo.SetupFileMaster set CollectDate = @Now
update dbutils.dbo.ConfigMaster set CollectDate = @Now
update dbutils.dbo.RoleMaster set CollectDate = @Now
update dbutils.dbo.ProtectMaster set CollectDate = @Now
update dbutils.dbo.LoginMaster set CollectDate = @Now
update dbutils.dbo.DBSizeMaster set CollectDate = @Now
update dbutils.dbo.UserMaster set CollectDate = @Now
update dbutils.dbo.LogSizeStatsMaster set CollectDate = @Now
update dbutils.dbo.FixedDrivesMaster set CollectDate = @Now
update dbutils.dbo.DBFileInfoMaster set CollectDate = @Now
update dbutils.dbo.DataFileStatsMaster set CollectDate = @Now
update dbutils.dbo.DBRoleMaster set CollectDate = @Now
update dbutils.dbo.GuestAccessMaster set CollectDate = @Now
update dbutils.dbo.MirrorMaster set CollectDate = @Now
update dbutils.dbo.AdminsMaster set CollectDate = @Now

GO
/****** Object:  StoredProcedure [dbo].[sp_backup]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_backup]
(
	@backuptype	varchar(4) = null
)
as
begin

	declare @backup_method nvarchar(6)

	if @backuptype is null
	begin
		raiserror('Backup type not specified. Procedure usage: ''execute dbutils.dbo.sp_backup [backup_type]''. Valid backup types are ''full'', ''diff'', ''log'' or ''sys''. ', 16, 1 )
		return -1
	end

	set @backuptype = lower(@backuptype)

	if @backuptype not in ('full', 'diff', 'log', 'sys')
	begin
		raiserror('Invalid backup type specified. Valid backup types are ''full'', ''diff'', ''log'' or ''sys''. ', 16, 1 )
		return -1
	end

	select @backup_method = backup_method from dbutils.dbo.backup_config

	if @backup_method is null
	begin
		raiserror('Backup method not specified in dbutils.dbo.backup_config table.', 16, 1 )
		return -1
	end

	if @backup_method = 'native'
		exec dbutils.dbo.sp_backup_native @backuptype
	else if @backup_method = 'nbu'
		exec dbutils.dbo.sp_backup_nbu @backuptype
	else if  @backup_method = 'tsm'
		exec dbutils.dbo.sp_backup_tsm @backuptype
	else
	begin
		raiserror('Invalid backup method specified in dbutils.dbo.backup_config table. Not sure how you got here, the check constraint should prevent this!', 16, 1 )
		return -1
	end


end
GO
/****** Object:  StoredProcedure [dbo].[sp_backup_native]    Script Date: 10/19/2022 1:46:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[sp_backup_native]
(
	@backuptype nvarchar(4) = null
)
as
begin

	declare @dbname nvarchar(max)
	declare @backup_dest nvarchar(max)
	declare @backup_dest_full nvarchar(max)
	declare @backup_sql nvarchar(max)
	declare @backup_count int
	declare @missingfull bit
	declare @sqlcompression nvarchar(20)
	declare @sqlver nvarchar(64)

	set @sqlver = cast(serverproperty('ProductVersion') as varchar(64))
	set @sqlver = left(@sqlver,charindex('.',@sqlver)-1)

	set @backup_count = 0
	set @backuptype = lower(@backuptype)
	

	--Check valid backup type
	if @backuptype is null or @backuptype not in ('full', 'diff', 'log', 'sys')
	begin
		raiserror('Invalid backup type specified. Valid backup types are ''full'', ''diff'', ''log'' or ''sys''. ', 16, 1 )
		return -1
	end

	--Retrieve configuration information
	select @backup_dest_full=native_dest_full, @sqlcompression=compression from dbutils.dbo.backup_config
	if @backup_dest_full is null
	begin
		raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
		return -1
	end
	if right(@backup_dest_full,1) <> '\'
		set @backup_dest_full = @backup_dest_full + '\'
	if lower(@sqlcompression) = 'true'
		set @sqlcompression = 'compression'	

	--List database status for output
	if @sqlver >= 9
		select * from dbutils.dbo.backup_database_status order by name
	else
		select * from dbutils.dbo.backup_database_status_2005 order by name

	--Begin backup routines
	if @backuptype = 'full'
	begin
		print 'Full backup started at ' + cast(getdate() as varchar)

		--Retrieve configuration information
		select @backup_dest=native_dest_full from dbutils.dbo.backup_config
		if @backup_dest is null
		begin
			raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
			return -1
		end
		if right(@backup_dest,1) <> '\'
			set @backup_dest = @backup_dest + '\'

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_full_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_full_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			print 'Backup of database ' + @dbname + ' started at ' + cast(getdate() as varchar)
			set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.bak'' with init'
			if @sqlver >= 10 and serverproperty('EngineEdition') = 3
				If @sqlcompression = 'compression'
				set @backup_sql = @backup_sql + ',' + @sqlcompression
				else set @backup_sql = @backup_sql 
			print @backup_sql 
			exec( @backup_sql )
			print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist
		if @backup_count = 0
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
			return -1
		end
		print 'Full backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'sys'
	begin
		print 'System database backup started at ' + cast(getdate() as varchar)
		--Retrieve configuration information
		select @backup_dest=native_dest_full from dbutils.dbo.backup_config
		if @backup_dest is null
		begin
			raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
			return -1
		end
		if right(@backup_dest,1) <> '\' and @backup_dest <> 'TDPSQL' and @backup_dest <> 'TDPSQL'
			set @backup_dest = @backup_dest + '\'

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_sys_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_sys_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.bak'' with init'
			if @sqlver >= 10 and serverproperty('EngineEdition') = 3
				If @sqlcompression = 'compression'
				set @backup_sql = @backup_sql + ',' + @sqlcompression
				else set @backup_sql = @backup_sql
			print @backup_sql
			exec( @backup_sql )
			print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist
		if @backup_count = 0
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
			return -1
		end
		print 'System database backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'diff'
	begin
		print 'Differential backup started at ' + cast(getdate() as varchar)
		--Retrieve configuration information
		select @backup_dest=native_dest_diff from dbutils.dbo.backup_config
		if @backup_dest is null
		begin
			raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
			return -1
		end
		if right(@backup_dest,1) <> '\' and @backup_dest <> 'TDPSQL'
			set @backup_dest = @backup_dest + '\'

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_diff_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_diff_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			print 'Backup of database ' + @dbname + ' started at ' + cast(getdate() as varchar)
			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = 
					case
						when backup_date is null then 1
						when backup_date < restore_date then 1
						when backup_date < create_date then 1
						else 0
					end
				from (
					select
						create_date, 
						restore_date = ( select max(restore_date) as restore_date from msdb.dbo.restorehistory where destination_database_name = @dbname),
						backup_date = (	select max(backup_start_date) as backup_date from msdb.dbo.backupset where database_name = @dbname and type = 'D')
					from master.sys.databases
					where name = @dbname ) t

				if @missingfull = 1
				begin
					print 'WARNING: No valid full backup found for database ' + @dbname + ', performing full backup now'
					set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest_full + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.bak'' with init'
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
						If @sqlcompression = 'compression'
						set @backup_sql = @backup_sql + ',' + @sqlcompression
						else set @backup_sql = @backup_sql
					print @backup_sql
					exec( @backup_sql )
					print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
				end
			end
			--Continue with the differential backup
			set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.dif'' with differential, init'
			if @sqlver >= 10 and serverproperty('EngineEdition') = 3
				If @sqlcompression = 'compression'
				set @backup_sql = @backup_sql + ',' + @sqlcompression
				else set @backup_sql = @backup_sql
			print @backup_sql
			exec( @backup_sql )
			print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist
		if @backup_count = 0
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
			return -1
		end
		print 'Differential backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'log'
	begin
		print 'Log backup started at ' + cast(getdate() as varchar)
		--Retrieve configuration information
		select @backup_dest=native_dest_log from dbutils.dbo.backup_config
		if @backup_dest is null
		begin
			raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
			return -1
		end
		if right(@backup_dest,1) <> '\' and @backup_dest <> 'TDPSQL'
			set @backup_dest = @backup_dest + '\'

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_log_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_log_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			print 'Backup of database ' + @dbname + ' started at ' + cast(getdate() as varchar)
			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = case when last_log_backup_lsn is null then 1 else 0 end
				from master.sys.database_recovery_status 
				where database_id = db_id(@dbname)

				if @missingfull = 1
				begin
					print 'WARNING: Broken log chain for database ' + @dbname + ', performing full backup now'
					set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest_full + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.bak'' with init'
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
						set @backup_sql = @backup_sql + ',' + @sqlcompression
					print @backup_sql
					exec( @backup_sql )
					print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
				end
			end
			--Continue with the log backup
			set @backup_sql = 'backup log [' + @dbname + '] to disk = ''' + @backup_dest + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.trn'' with init'
			if @sqlver >= 10 and serverproperty('EngineEdition') = 3
				If @sqlcompression = 'compression'
				set @backup_sql = @backup_sql + ',' + @sqlcompression
				else set @backup_sql = @backup_sql
			print @backup_sql
			exec( @backup_sql )
			print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist
		if @backup_count = 0
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 10, 1 )
			--return -1
		end
		print 'Log backup completed at ' + cast(getdate() as varchar)
	end

end


GO
/****** Object:  StoredProcedure [dbo].[sp_backup_native_20180111]    Script Date: 10/19/2022 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_backup_native_20180111]
(
	@backuptype nvarchar(4) = null
)
as
begin

	declare @dbname nvarchar(max)
	declare @backup_dest nvarchar(max)
	declare @backup_dest_full nvarchar(max)
	declare @backup_sql nvarchar(max)
	declare @backup_count int
	declare @missingfull bit
	declare @sqlver nvarchar(64)

	set @sqlver = cast(serverproperty('ProductVersion') as varchar(64))
	set @sqlver = left(@sqlver,charindex('.',@sqlver)-1)

	set @backup_count = 0
	set @backuptype = lower(@backuptype)

	--Check valid backup type
	if @backuptype is null or @backuptype not in ('full', 'diff', 'log', 'sys')
	begin
		raiserror('Invalid backup type specified. Valid backup types are ''full'', ''diff'', ''log'' or ''sys''. ', 16, 1 )
		return -1
	end

	--Retrieve configuration information
	select @backup_dest_full=native_dest_full from dbutils.dbo.backup_config
	if @backup_dest_full is null
	begin
		raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
		return -1
	end
	if right(@backup_dest_full,1) <> '\'
		set @backup_dest_full = @backup_dest_full + '\'

	--List database status for output
	if @sqlver >= 9
		select * from dbutils.dbo.backup_database_status order by name
	else
		select * from dbutils.dbo.backup_database_status_2005 order by name

	--Begin backup routines
	if @backuptype = 'full'
	begin
		print 'Full backup started at ' + cast(getdate() as varchar)

		--Retrieve configuration information
		select @backup_dest=native_dest_full from dbutils.dbo.backup_config
		if @backup_dest is null
		begin
			raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
			return -1
		end
		if right(@backup_dest,1) <> '\'
			set @backup_dest = @backup_dest + '\'

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_full_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_full_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			print 'Backup of database ' + @dbname + ' started at ' + cast(getdate() as varchar)
			set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.bak'' with init'
			if @sqlver >= 10 and serverproperty('EngineEdition') = 3
				set @backup_sql = @backup_sql + ', compression'
			exec( @backup_sql )
			print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist
		if @backup_count = 0
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
			return -1
		end
		print 'Full backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'sys'
	begin
		print 'System database backup started at ' + cast(getdate() as varchar)
		--Retrieve configuration information
		select @backup_dest=native_dest_full from dbutils.dbo.backup_config
		if @backup_dest is null
		begin
			raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
			return -1
		end
		if right(@backup_dest,1) <> '\' and @backup_dest <> 'TDPSQL' and @backup_dest <> 'TDPSQL'
			set @backup_dest = @backup_dest + '\'

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_sys_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_sys_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.bak'' with init'
			if @sqlver >= 10 and serverproperty('EngineEdition') = 3
				set @backup_sql = @backup_sql + ', compression'
			exec( @backup_sql )
			print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist
		if @backup_count = 0
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
			return -1
		end
		print 'System database backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'diff'
	begin
		print 'Differential backup started at ' + cast(getdate() as varchar)
		--Retrieve configuration information
		select @backup_dest=native_dest_diff from dbutils.dbo.backup_config
		if @backup_dest is null
		begin
			raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
			return -1
		end
		if right(@backup_dest,1) <> '\' and @backup_dest <> 'TDPSQL'
			set @backup_dest = @backup_dest + '\'

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_diff_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_diff_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			print 'Backup of database ' + @dbname + ' started at ' + cast(getdate() as varchar)
			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = 
					case
						when backup_date is null then 1
						when backup_date < restore_date then 1
						when backup_date < create_date then 1
						else 0
					end
				from (
					select
						create_date, 
						restore_date = ( select max(restore_date) as restore_date from msdb.dbo.restorehistory where destination_database_name = @dbname),
						backup_date = (	select max(backup_start_date) as backup_date from msdb.dbo.backupset where database_name = @dbname and type = 'D')
					from master.sys.databases
					where name = @dbname ) t

				if @missingfull = 1
				begin
					print 'WARNING: No valid full backup found for database ' + @dbname + ', performing full backup now'
					set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest_full + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.bak'' with init'
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
						set @backup_sql = @backup_sql + ', compression'
					exec( @backup_sql )
					print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
				end
			end
			--Continue with the differential backup
			set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.dif'' with differential, init'
			if @sqlver >= 10 and serverproperty('EngineEdition') = 3
				set @backup_sql = @backup_sql + ', compression'
			exec( @backup_sql )
			print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist
		if @backup_count = 0
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
			return -1
		end
		print 'Differential backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'log'
	begin
		print 'Log backup started at ' + cast(getdate() as varchar)
		--Retrieve configuration information
		select @backup_dest=native_dest_log from dbutils.dbo.backup_config
		if @backup_dest is null
		begin
			raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
			return -1
		end
		if right(@backup_dest,1) <> '\' and @backup_dest <> 'TDPSQL'
			set @backup_dest = @backup_dest + '\'

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_log_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_log_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			print 'Backup of database ' + @dbname + ' started at ' + cast(getdate() as varchar)
			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = case when last_log_backup_lsn is null then 1 else 0 end
				from master.sys.database_recovery_status 
				where database_id = db_id(@dbname)

				if @missingfull = 1
				begin
					print 'WARNING: Broken log chain for database ' + @dbname + ', performing full backup now'
					set @backup_sql = 'backup database [' + @dbname + '] to disk = ''' + @backup_dest_full + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.bak'' with init'
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
						set @backup_sql = @backup_sql + ', compression'
					exec( @backup_sql )
					print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
				end
			end
			--Continue with the log backup
			set @backup_sql = 'backup log [' + @dbname + '] to disk = ''' + @backup_dest + @dbname + '_' + replace(replace(replace(convert(varchar,getdate(),120),':',''),'-',''),' ','') + '.trn'' with init'
			if @sqlver >= 10 and serverproperty('EngineEdition') = 3
				set @backup_sql = @backup_sql + ', compression'
			exec( @backup_sql )
			print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist
		if @backup_count = 0
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 10, 1 )
			--return -1
		end
		print 'Log backup completed at ' + cast(getdate() as varchar)
	end

end

GO
/****** Object:  StoredProcedure [dbo].[sp_backup_nbu]    Script Date: 10/19/2022 1:46:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[sp_backup_nbu]
(
	@backuptype varchar(4) = null
)
as
begin

	declare @dbname nvarchar(max)
	declare @nbu_master_server nvarchar(128)
	declare @nbu_directory nvarchar(256)
	declare @nbu_script nvarchar(256)
	declare @nbu_policy nvarchar(64)
	declare @nbu_stripes_full int
	declare @nbu_stripes_diff int
	declare @nbu_batchsize_log int
	declare @nbu_batch_line nvarchar(256)
	declare @backup_sql varchar(8000)
	declare @compression nvarchar(20)
	declare @backup_count int
	declare @missingfull bit
	declare @sqlver nvarchar(64)
	declare @servname nvarchar(64)
	declare @instname nvarchar(64)
	declare @nbu_numbufs nvarchar(10)
	declare @retval int

	set @sqlver = cast(serverproperty('ProductVersion') as varchar(64))
	set @sqlver = left(@sqlver,charindex('.',@sqlver)-1)

	if charindex('\',@@Servername) = 0
	begin
		set @servname = @@servername
		set @instname = ''
	end
	else
	begin
		set @servname = left(@@servername,charindex('\',@@Servername)-1)
		set @instname = right(@@servername,len(@@servername)-charindex('\',@@Servername))
	end

	set @backup_count = 0
	set @backuptype = lower(@backuptype)

	--Check valid backup type
	if @backuptype is null or @backuptype not in ('full', 'diff', 'log', 'sys')
	begin
		raiserror('Invalid backup type specified. Valid backup types are ''full'', ''diff'', ''log'' or ''sys''. ', 16, 1 )
		return -1
	end

	--Retrieve configuration information
	select @nbu_directory = nbu_directory, @nbu_master_server = nbu_master_server, @nbu_policy = nbu_policy, @nbu_stripes_full = nbu_stripes_full, @nbu_stripes_diff = nbu_stripes_diff, @nbu_batchsize_log = nbu_batchsize_log, @nbu_numbufs = nbu_numbufs, @compression = compression from dbutils.dbo.backup_config
	if @nbu_directory is null or @nbu_master_server is null or @nbu_policy is null
	begin
		raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
		return -1
	end
	if right(@nbu_directory,1) <> '\'
		set @nbu_directory = @nbu_directory + '\'

	if @nbu_stripes_full > 12 set @nbu_stripes_full = 12
	if @nbu_stripes_diff > 12 set @nbu_stripes_diff = 12
	if @nbu_batchsize_log > 12 set @nbu_batchsize_log = 12

	--List database status for output
	if @sqlver >= 9
		select * from dbutils.dbo.backup_database_status order by name
	else
		select * from dbutils.dbo.backup_database_status_2005 order by name

	--Begin backup routines
	if @backuptype = 'full'
	begin
		print 'Full backup started at ' + cast(getdate() as varchar)

		if @sqlver >= 9 
			if not exists (select name from dbutils.dbo.backup_eligible_full_databases)
			begin
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end
		else 
			if not exists (select name from dbutils.dbo.backup_eligible_full_databases_2005)
			begin
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end

		set @nbu_script = @nbu_directory + 'sqlfull' + @@servicename + '.bch'

		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DATABASE $ALL', 0

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from master.sys.databases where name not in (select name from dbutils.dbo.backup_eligible_full_databases) order by name
		else
			declare dblist cursor static for
				select name from master.dbo.sysdatabases where name not in (select name from dbutils.dbo.backup_eligible_full_databases_2005) order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @nbu_batch_line = 'EXCLUDE "' + @dbname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if SERVERPROPERTY('IsClustered') = 1
		begin
			set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		end
		
		set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0

		--New test entries
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'MAXTRANSFERSIZE 6', 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'BLOCKSIZE 7', 0


		set @nbu_batch_line = 'STRIPES ' + cast(@nbu_stripes_full as nvarchar)
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
		set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

		set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			raiserror('NBU returned non-zero error code, check logs', 16, 1 )
			return -1
		end

		print 'Full backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'sys'
	begin
		print 'System database backup started at ' + cast(getdate() as varchar)

		if @sqlver >= 9 
			if not exists (select name from dbutils.dbo.backup_eligible_sys_databases)
			begin
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end
		else 
			if not exists (select name from dbutils.dbo.backup_eligible_sys_databases_2005)
			begin
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end

		set @nbu_script = @nbu_directory + 'sqlsys' + @@servicename + '.bch'

		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DATABASE $ALL', 0

		--Retrieve database exclusion list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from master.sys.databases where name not in (select name from dbutils.dbo.backup_eligible_sys_databases) order by name
		else
			declare dblist cursor static for
				select name from master.dbo.sysdatabases where name not in (select name from dbutils.dbo.backup_eligible_sys_databases_2005) order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @nbu_batch_line = 'EXCLUDE "' + @dbname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if SERVERPROPERTY('IsClustered') = 1
		begin
			set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		end
		set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0

		--New test entries
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'MAXTRANSFERSIZE 6', 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'BLOCKSIZE 7', 0


		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
		set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

		set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			raiserror('NBU returned non-zero error code, check logs', 16, 1 )
			return -1
		end

		print 'System database backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'diff'
	begin
		print 'Differential backup started at ' + cast(getdate() as varchar)

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_diff_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_diff_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin

			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = 
					case
						when backup_date is null then 1
						when backup_date < restore_date then 1
						when backup_date < create_date then 1
						else 0
					end
				from (
					select
						create_date, 
						restore_date = ( select max(restore_date) as restore_date from msdb.dbo.restorehistory where destination_database_name = @dbname),
						backup_date = (	select max(backup_start_date) as backup_date from msdb.dbo.backupset where database_name = @dbname and type = 'D')
					from master.sys.databases
					where name = @dbname ) t

				if @missingfull = 1
				begin
					print 'WARNING: No valid full backup found for database ' + @dbname + ', performing full backup now'

					set @nbu_script = @nbu_directory + 'sqlmissingfull' + @@servicename + '.bch'

					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
					set @nbu_batch_line = 'DATABASE "' + @dbname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					if SERVERPROPERTY('IsClustered') = 1
					begin
						set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
						exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					end					
					set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0

					--New test entries
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'MAXTRANSFERSIZE 6', 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'BLOCKSIZE 7', 0

					set @nbu_batch_line = 'STRIPES ' + cast(@nbu_stripes_full as nvarchar)
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
					set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

					set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
					exec @retval=xp_cmdshell @backup_sql
					if @retval <> 0
					begin
						raiserror('NBU returned non-zero error code, check logs', 16, 1 )
						return -1
					end

				end
			end
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		if @sqlver >= 9 
			if not exists (select name from dbutils.dbo.backup_eligible_diff_databases)
			begin
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end
		else 
			if not exists (select name from dbutils.dbo.backup_eligible_diff_databases_2005)
			begin
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end

		set @nbu_script = @nbu_directory + 'sqldiff' + @@servicename + '.bch'

		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DATABASE $ALL', 0

		--Retrieve database exclusion list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from master.sys.databases where name not in (select name from dbutils.dbo.backup_eligible_diff_databases) order by name
		else
			declare dblist cursor static for
				select name from master.dbo.sysdatabases where name not in (select name from dbutils.dbo.backup_eligible_diff_databases_2005) order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @nbu_batch_line = 'EXCLUDE "' + @dbname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if SERVERPROPERTY('IsClustered') = 1
		begin
			set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		end
		set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0

		--New test entries
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'MAXTRANSFERSIZE 6', 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'BLOCKSIZE 7', 0

		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DUMPOPTION INCREMENTAL', 0
		set @nbu_batch_line = 'STRIPES ' + cast(@nbu_stripes_diff as nvarchar)
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
		set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

		set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			raiserror('NBU returned non-zero error code, check logs', 16, 1 )
			return -1
		end

		print 'Differential backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'log'
	begin
		print 'Log backup started at ' + cast(getdate() as varchar)

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_log_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_log_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			print 'Backup of database ' + @dbname + ' started at ' + cast(getdate() as varchar)
			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = case when last_log_backup_lsn is null then 1 else 0 end
				from master.sys.database_recovery_status 
				where database_id = db_id(@dbname)

				if @missingfull = 1
				begin
					print 'WARNING: Broken log chain for database ' + @dbname + ', performing full backup now'
					set @nbu_script = @nbu_directory + 'sqlmissingfull' + @@servicename + '.bch'

					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
					set @nbu_batch_line = 'DATABASE "' + @dbname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					if SERVERPROPERTY('IsClustered') = 1
					begin
						set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
						exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					end
					set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0

					--New test entries
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'MAXTRANSFERSIZE 6', 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'BLOCKSIZE 7', 0

					set @nbu_batch_line = 'STRIPES ' + cast(@nbu_stripes_full as nvarchar)
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
					set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

					set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
					exec @retval=xp_cmdshell @backup_sql
					if @retval <> 0
					begin
						raiserror('NBU returned non-zero error code, check logs', 16, 1 )
						return -1
					end
				end
			end
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		if @sqlver >= 9 
			if not exists (select name from dbutils.dbo.backup_eligible_log_databases)
			begin
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 10, 1 )
				return -1
			end
		else 
			if not exists (select name from dbutils.dbo.backup_eligible_log_databases_2005)
			begin
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 10, 1 )
				return -1
			end

		set @nbu_script = @nbu_directory + 'sqllog' + @@servicename + '.bch'

		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DATABASE $ALL', 0

		--Retrieve database exclusion list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from master.sys.databases where name not in (select name from dbutils.dbo.backup_eligible_log_databases) order by name
		else
			declare dblist cursor static for
				select name from master.dbo.sysdatabases where name not in (select name from dbutils.dbo.backup_eligible_log_databases_2005) order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @nbu_batch_line = 'EXCLUDE "' + @dbname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if SERVERPROPERTY('IsClustered') = 1
		begin
			set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		end
		set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0

		--New test entries
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'MAXTRANSFERSIZE 6', 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'BLOCKSIZE 7', 0

		set @nbu_batch_line = 'BATCHSIZE ' + cast(@nbu_batchsize_log as nvarchar)
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OBJECTTYPE TRXLOG', 0
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
		set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

		set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			raiserror('NBU returned non-zero error code, check logs', 16, 1 )
			return -1
		end

		print 'Log backup completed at ' + cast(getdate() as varchar)
	end

end


GO
/****** Object:  StoredProcedure [dbo].[sp_backup_nbu_rerun]    Script Date: 10/19/2022 1:46:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[sp_backup_nbu_rerun]
(
	@backuptype varchar(4) = null
)
as
begin

	declare @dbname nvarchar(max)
	declare @nbu_master_server nvarchar(128)
	declare @nbu_directory nvarchar(256)
	declare @nbu_script nvarchar(256)
	declare @nbu_policy nvarchar(64)
	declare @nbu_stripes_full int
	declare @nbu_stripes_diff int
	declare @nbu_batchsize_log int
	declare @nbu_batch_line nvarchar(256)
	declare @backup_sql varchar(8000)
	declare @compression nvarchar(20)
	declare @backup_count int
	declare @missingfull bit
	declare @sqlver nvarchar(64)
	declare @servname nvarchar(64)
	declare @instname nvarchar(64)
	declare @nbu_numbufs nvarchar(10)
	declare @retval int

--Adding new variables 
	declare @current_time time
	declare @subject nvarchar(500)
	declare @env varchar(10)
	declare @run_date datetime
	declare @exclude bit
	declare @failed_backup_number  int
	declare @day_of_week varchar(10)
	declare @body varchar(8000)
	declare @dbs_with_no_log_backup VARCHAR(1000) 
	declare @path nvarchar(300)
	declare @filename nvarchar(100)
	declare @output nvarchar(1000)


	set @servname = @@servername
	set @current_time = (Select Convert(Time, GetDate()))
	set @day_of_week = (SELECT DATENAME(WEEKDAY, GETDATE()))

	set @sqlver = cast(serverproperty('ProductVersion') as varchar(64))
	set @sqlver = left(@sqlver,charindex('.',@sqlver)-1)

	if charindex('\',@@Servername) = 0
	begin
		set @servname = @@servername
		set @instname = ''
	end
	else
	begin
		set @servname = left(@@servername,charindex('\',@@Servername)-1)
		set @instname = right(@@servername,len(@@servername)-charindex('\',@@Servername))
	end

	set @backup_count = 0
	set @backuptype = lower(@backuptype)

	--Check valid backup type
	if @backuptype is null or @backuptype not in ('full', 'diff', 'log', 'sys')
	begin
		raiserror('Invalid backup type specified. Valid backup types are ''full'', ''diff'', ''log'' or ''sys''. ', 16, 1 )
		return -1
	end

	--Retrieve configuration information
	select @nbu_directory = nbu_directory, @nbu_master_server = nbu_master_server, @nbu_policy = nbu_policy, @nbu_stripes_full = nbu_stripes_full, @nbu_stripes_diff = nbu_stripes_diff, @nbu_batchsize_log = nbu_batchsize_log, @nbu_numbufs = nbu_numbufs, @compression = compression from dbutils.dbo.backup_config
	if @nbu_directory is null or @nbu_master_server is null or @nbu_policy is null
	begin
		raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
		return -1
	end
	if right(@nbu_directory,1) <> '\'
		set @nbu_directory = @nbu_directory + '\'

	if @nbu_stripes_full > 12 set @nbu_stripes_full = 12
	if @nbu_stripes_diff > 12 set @nbu_stripes_diff = 12
	if @nbu_batchsize_log > 12 set @nbu_batchsize_log = 12

	--List database status for output
	if @sqlver >= 9
		select * from dbutils.dbo.backup_database_status order by name
	else
		select * from dbutils.dbo.backup_database_status_2005 order by name

-- set loging path and file
		set @filename = 
			case @backuptype
				when 'full' then 'Backup - User DBs Full_rerun.log'
				when 'diff' then 'Backup - User DBs Diff_rerun.log'
				when 'log' then 'Backup - User DBs Log_rerun.log'
				when 'sys' then 'Backup - System DBs Full_rerun.log'
				else 'invalid backuptype'
			end
	set @path = 'E:\SQLADMIN$'+@instname +'\'+@filename


	--Begin backup routines
	if @backuptype = 'full'
	begin
		print 'Full backup rerun started at ' + cast(getdate() as varchar)
		set @output = 'Full backup started at ' + cast(getdate() as varchar)
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		if @sqlver >= 9 
			if not exists (select name from dbutils.dbo.backup_eligible_full_databases)
			begin
				set @output = @output +char(13)+char(10)+'No databases available for backup, or all databases excluded using the current configuration. '
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end
		else 
			if not exists (select name from dbutils.dbo.backup_eligible_full_databases_2005)
			begin
				set @output = @output +char(13)+char(10)+'No databases available for backup, or all databases excluded using the current configuration. '
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end


--Checking for which db the backup failed and adding it to backuprerun_full table
	IF EXISTS(SELECT * FROM dbutils.dbo.sysobjects WHERE name = 'backuprerun_full')
   DROP TABLE dbutils.dbo.backuprerun_full

	IF OBJECT_ID ('tempdb..backup_rerun_temptable') IS NOT NULL  DROP TABLE tempdb..backup_rerun_temptable

	SELECT database_name, last_db_backup_date, Backup_Type  
	INTO tempdb..backup_rerun_temptable
	FROM
	(
	SELECT  
	   --CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, 
	   msdb.dbo.backupset.database_name,  
	   MAX(msdb.dbo.backupset.backup_finish_date) AS last_db_backup_date,
		CASE msdb..backupset.type WHEN 'D' THEN 'full'
			WHEN 'I' THEN 'diff'
		END AS Backup_Type
	FROM   msdb.dbo.backupmediafamily  
	   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id  
	WHERE  msdb..backupset.type = 'D'
	and msdb.dbo.backupset.database_name in (select name from sys.databases)
	GROUP BY 
	   msdb.dbo.backupset.database_name, msdb..backupset.type 
	 ) AS t

	   SELECT * INTO dbutils.dbo.backuprerun_full
	   FROM tempdb..backup_rerun_temptable
	   WHERE last_db_backup_date <
	   (SELECT top 1
		 CASE 
			WHEN [sJOBH].[run_date] IS NULL OR [sJOBH].[run_time] IS NULL THEN NULL
			ELSE CAST(
					CAST([sJOBH].[run_date] AS CHAR(8))
					+ ' ' 
					+ STUFF(
						STUFF(RIGHT('000000' + CAST([sJOBH].[run_time] AS VARCHAR(6)),  6)
							, 3, 0, ':')
						, 6, 0, ':')
					AS DATETIME)
		  END AS [LastRunDateTime]
		FROM [msdb].[dbo].[sysjobhistory] AS [sJOBH]
		WHERE step_name = 'Backup - User DBs FULL'
		ORDER BY [LastRunDateTime] desc)
		and database_name in (select name from [dbo].[backup_eligible_full_databases])
	ORDER BY last_db_backup_date desc

--Check if backup only failed on NBU side but sql take it as completed 

	set @failed_backup_number  = (SELECT count(*) FROM dbutils.dbo.backuprerun_full)

	if @failed_backup_number  = 0
	begin
	set @subject = 'Failed Full backup could not rerun for [' + @@SERVERNAME + '], check Netbackup logs and rerun it.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'On sql side all backups look successfull, please check Netbackup log for failoure and make sure the backup chain is not broken!',
				@body_format = 'text',
				@importance = 'high'

				set @output = @output +char(13)+char(10)+'Failed backup not find.'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				return -1
	end
	else
	set @output = @output +char(13)+char(10)+'Failed backup is find.'
	exec dbo.sp_WriteStringToFile @path, @output, '2'
		PRINT 'Failed backup is find.'

--Check if environmentInfo table exist
	  IF NOT EXISTS(SELECT * FROM dbutils.dbo.sysobjects WHERE name = 'EnvironmentInfo') 

  begin
		
		EXEC master.dbo.sp_addlinkedserver @server = N'AGTDBAMONHAL', @srvproduct=N'SQL Server'
		EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'AGTDBAMONHAL', @locallogin = NULL , @useself = N'True'
		EXECUTE AGTDBAMONHAL.sysdba_dbinfo.[dbo].[sp_GetEnvironmentData] @@servername, @environment=@env OUTPUT;
		SET @run_date = getdate()
	
		CREATE TABLE dbutils.dbo.EnvironmentInfo
		(
		Production_level nvarchar(10),
		Last_run_date datetime
		)

		INSERT INTO dbutils.dbo.EnvironmentInfo
		(
		Production_level,
		Last_run_date
		)
		VALUES
		(
		@env,
		@run_date
		)

		EXEC master.dbo.sp_dropserver @server=N'AGTDBAMONHAL', @droplogins='droplogins'
		set @output = @output +char(13)+char(10)+'EnvironmentInfo table created'
		exec dbo.sp_WriteStringToFile @path, @output, '2'
	end

	ELSE
	set @output = @output +char(13)+char(10)+'EnvironmentInfo table exist'
	exec dbo.sp_WriteStringToFile @path, @output, '2'
	PRINT 'EnvironmentInfo table exist'

	
--Check if environment info has correct data and not older then 1 week
	IF (SELECT Last_run_date FROM dbutils.dbo.EnvironmentInfo) <= DATEADD(ww, -1, GETDATE())
	 or  (select top 1 Production_level from [dbutils].[dbo].[EnvironmentInfo]) Is null 
	BEGIN
		--If environment info older then 1 week overwrite it with current info from DBAI
		EXEC master.dbo.sp_addlinkedserver @server = N'AGTDBAMONHAL', @srvproduct=N'SQL Server'
		EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'AGTDBAMONHAL', @locallogin = NULL , @useself = N'True'
		EXECUTE AGTDBAMONHAL.sysdba_dbinfo.[dbo].[sp_GetEnvironmentData] @@servername, @environment=@env OUTPUT;
		SET @run_date = getdate()
				
		DROP TABLE dbutils.dbo.EnvironmentInfo

		CREATE TABLE dbutils.dbo.EnvironmentInfo
		(
		Production_level nvarchar(10),
		Last_run_date datetime
		)

		INSERT INTO dbutils.dbo.EnvironmentInfo
		(
		Production_level,
		Last_run_date
		)
		VALUES
		(
		@env,
		@run_date
		)

		EXEC master.dbo.sp_dropserver @server=N'AGTDBAMONHAL', @droplogins='droplogins'
		IF (select top 1 Production_level from [dbutils].[dbo].[EnvironmentInfo]) Is null
		begin
		set @subject = 'Failed Full backup could not rerun for [' + @@SERVERNAME + '], as EnvironmentInfo table not set.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'Check dbutils.dbo.EnvironmentInfo table. Production_level has to contain not null value.',
				@body_format = 'text',
				@importance = 'high'
				set @output = @output +char(13)+char(10)+'Failed Full backup could not rerun .Check dbutils.dbo.EnvironmentInfo table. Production_level has to contain not null value.'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
		return -1
		end
	END

	ELSE
		set @output = @output +char(13)+char(10)+'Environment info is current'
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		PRINT 'Environment info is current'


-- Adding new checks for time on prod instances
	set @env = (SELECT Production_level FROM dbutils.dbo.EnvironmentInfo)


	if @current_time between '07:00:00' and '17:00:00' and @env = 'prod' and @day_of_week in ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
			begin
				set @subject = 'Failed Full backup could not rerun for [' + @@SERVERNAME + '] as it office time now.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'Please check if the backup should be rerun manually or other action has to be taken.',
				@body_format = 'text',
				@importance = 'high'
				set @output = @output +char(13)+char(10)+'Failed Full backup could not rerun as it office time now.'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				return -1
			end
			else 
				set @output = @output +char(13)+char(10)+'Environment level and office hours check ok.'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				print 'Environment level and office hours check ok.'

--Check if the server is excluded from backup rerun

	IF NOT EXISTS(SELECT * FROM dbutils.dbo.sysobjects WHERE name = 'serverexclude')
		BEGIN
			CREATE TABLE dbutils.dbo.serverexclude
			(
			Exclude_any_rerun bit not null
			)
		END

	set @exclude = (SELECT top 1 Exclude_any_rerun FROM dbutils.dbo.serverexclude)

	if @exclude = 'true'
			begin
				set @subject = 'Failed Full backup could not rerun for [' + @@SERVERNAME + '] as it is in exclude list.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'Please rerun check if the backup should be rerun manually or other action has to be taken.',
				@body_format = 'text',
				@importance = 'high'
				set @output = @output +char(13)+char(10)+'Failed Full backup could not rerun as it is in exclude list.'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				return -1
			end
		else
			set @output = @output +char(13)+char(10)+'Server not in exclude list'
			exec dbo.sp_WriteStringToFile @path, @output, '2'
		print 'Server not in exclude list'

--New checks end


		set @nbu_script = @nbu_directory + 'sqlfull' + @@servicename + '.bch'

		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DATABASE $ALL', 0

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				--Set dblist cursor to pass all database for exclusion where the backup was successfull
				--select name from master.sys.databases where name not in (select name from dbutils.dbo.backup_eligible_full_databases) order by name		
				select name from master.sys.databases where name not in (SELECT database_name FROM dbutils.dbo.backuprerun_full WHERE dbutils.dbo.backuprerun_full.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_full_databases]))
		else
			declare dblist cursor static for
--Set dblist cursor to pass all database for exclusion where the backup was successfull
				--select name from master.dbo.sysdatabases where name not in (select name from dbutils.dbo.backup_eligible_full_databases_2005) order by name
				select name from master.sys.databases where name not in (SELECT database_name FROM dbutils.dbo.backuprerun_full WHERE dbutils.dbo.backuprerun_full.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_full_databases_2005]))
		
		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @nbu_batch_line = 'EXCLUDE "' + @dbname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if SERVERPROPERTY('IsClustered') = 1
		begin
			set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		end
		set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'STRIPES ' + cast(@nbu_stripes_full as nvarchar)
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
		set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

		set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			
					set @subject = 'Rerun of failed FULL backup failed for [' + @@SERVERNAME + '].'
						exec msdb.dbo.sp_send_dbmail 
						@profile_name = 'System DBA Team Mail',
						@recipients = 'shagtdistsystemdbasq@transamerica.com',
						@subject = @subject,
						@body = 'Please check the logs, and see if user action is needed.',
						@body_format = 'text',
						@importance = 'high'

						set @output = @output +char(13)+char(10)+'NBU returned non-zero error code, check logs'
						exec dbo.sp_WriteStringToFile @path, @output, '2'

			raiserror('NBU returned non-zero error code, check logs', 16, 1 )			
			return -1
		end

		print 'Full backup completed at ' + cast(getdate() as varchar)
				set @output = @output +char(13)+char(10)+'Full backup completed at ' + cast(getdate() as varchar)
				exec dbo.sp_WriteStringToFile @path, @output, '2'
		return 0
	end

	if @backuptype = 'sys'
	begin
		set @output = 'System database backup rerun started at ' + cast(getdate() as varchar)
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		print 'System database backup rerun started at ' + cast(getdate() as varchar)

		if @sqlver >= 9 
			if not exists (select name from dbutils.dbo.backup_eligible_sys_databases)
			begin
				set @output = @output +char(13)+char(10)+'No databases available for backup, or all databases excluded using the current configuration. '
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end
		else 
			if not exists (select name from dbutils.dbo.backup_eligible_sys_databases_2005)
			begin
				set @output = @output +char(13)+char(10)+'No databases available for backup, or all databases excluded using the current configuration. '
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end


--Checking for which db the backup failed and adding it to backuprerun_full table
IF EXISTS(SELECT * FROM dbutils.dbo.sysobjects WHERE name = 'backuprerun_sys')
   DROP TABLE dbutils.dbo.backuprerun_sys

IF OBJECT_ID ('tempdb..backup_rerun_temptable') IS NOT NULL  DROP TABLE tempdb..backup_rerun_temptable

SELECT database_name, last_db_backup_date, Backup_Type  
INTO tempdb..backup_rerun_temptable
FROM
(
SELECT  
   msdb.dbo.backupset.database_name,  
   MAX(msdb.dbo.backupset.backup_finish_date) AS last_db_backup_date,
    CASE msdb..backupset.type WHEN 'D' THEN 'full'
		WHEN 'I' THEN 'diff'
	END AS Backup_Type
FROM   msdb.dbo.backupmediafamily  
   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id  
WHERE  msdb..backupset.type = 'D'
and msdb.dbo.backupset.database_name in (select name from sys.databases)
GROUP BY 
   msdb.dbo.backupset.database_name, msdb..backupset.type 
 ) AS t

   SELECT * INTO dbutils.dbo.backuprerun_sys
   FROM tempdb..backup_rerun_temptable
   WHERE last_db_backup_date <
   (SELECT top 1
     CASE 
        WHEN [sJOBH].[run_date] IS NULL OR [sJOBH].[run_time] IS NULL THEN NULL
        ELSE CAST(
                CAST([sJOBH].[run_date] AS CHAR(8))
                + ' ' 
                + STUFF(
                    STUFF(RIGHT('000000' + CAST([sJOBH].[run_time] AS VARCHAR(6)),  6)
                        , 3, 0, ':')
                    , 6, 0, ':')
                AS DATETIME)
      END AS [LastRunDateTime]
    FROM [msdb].[dbo].[sysjobhistory] AS [sJOBH]
	WHERE step_name = 'Backup - System DBs Full'
	and database_name in ('master', 'model', 'msdb')
	
	ORDER BY [LastRunDateTime] desc)
	ORDER BY last_db_backup_date desc

--Check if backup only failed on NBU side but sql take it as completed 

	set @failed_backup_number  = (SELECT count(*) FROM dbutils.dbo.backuprerun_sys)

	if @failed_backup_number  = 0
	begin
	set @subject = 'Failed SYS backup could not rerun for [' + @@SERVERNAME + '], check Netbackup logs and rerun it.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'On sql side all backups look successfull, please check Netbackup log for failoure and make sure the backup chain is not broken!',
				@body_format = 'text',
				@importance = 'high'

				set @output = @output +char(13)+char(10)+'On sql side all backups look successfull, please check Netbackup log for failoure and make sure the backup chain is not broken!'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				return -1
	end
	else
		set @output = @output +char(13)+char(10)+'Failed backup is find.'
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		PRINT 'Failed backup is find.'

--New checks end

		set @nbu_script = @nbu_directory + 'sqlsys' + @@servicename + '.bch'

		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DATABASE $ALL', 0

		--Retrieve database exclusion list
		if @sqlver >= 9
			declare dblist cursor static for
				--select name from master.sys.databases where name not in (select name from dbutils.dbo.backup_eligible_sys_databases) order by name
		select name from master.sys.databases where name not in (SELECT database_name FROM dbutils.dbo.backuprerun_sys WHERE dbutils.dbo.backuprerun_sys.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_sys_databases]))
		else
			declare dblist cursor static for
				--select name from master.dbo.sysdatabases where name not in (select name from dbutils.dbo.backup_eligible_sys_databases_2005) order by name
				select name from master.sys.databases where name not in (SELECT database_name FROM dbutils.dbo.backuprerun_sys WHERE dbutils.dbo.backuprerun_sys.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_sys_databases_2005]))
				open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @nbu_batch_line = 'EXCLUDE "' + @dbname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if SERVERPROPERTY('IsClustered') = 1
		begin
			set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		end
		set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
		set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

		set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			
			set @subject = 'Rerun of failed SYS backup failed for [' + @@SERVERNAME + '].'
						exec msdb.dbo.sp_send_dbmail 
						@profile_name = 'System DBA Team Mail',
						@recipients = 'shagtdistsystemdbasq@transamerica.com',
						@subject = @subject,
						@body = 'Please check the logs, and see if user action is needed.',
						@body_format = 'text',
						@importance = 'high'

						set @output = @output +char(13)+char(10)+'NBU returned non-zero error code, check logs'
						exec dbo.sp_WriteStringToFile @path, @output, '2'
						
						raiserror('NBU returned non-zero error code, check logs', 16, 1 )
						return -1
		end
		set @output = @output +char(13)+char(10)+'System database backup rerun completed at ' + cast(getdate() as varchar)
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		print 'System database backup rerun completed at ' + cast(getdate() as varchar)
		return 0
	end

if @backuptype = 'diff'
begin
		set @output = 'Differential backup rerun started at ' + cast(getdate() as varchar)
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		print 'Differential backup rerun started at ' + cast(getdate() as varchar)

--Checking for which db the backup failed and adding it to backuprerun_full table
	
	IF EXISTS(SELECT * FROM dbutils.dbo.sysobjects WHERE name = 'backuprerun_diff')
   DROP TABLE dbutils.dbo.backuprerun_diff

	IF OBJECT_ID ('tempdb..backup_rerun_temptable') IS NOT NULL  DROP TABLE tempdb..backup_rerun_temptable

	SELECT database_name, last_db_backup_date, Backup_Type  
	INTO tempdb..backup_rerun_temptable
	FROM
	(
	SELECT  
	   --CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, 
	   msdb.dbo.backupset.database_name,  
	   MAX(msdb.dbo.backupset.backup_finish_date) AS last_db_backup_date,
		CASE msdb..backupset.type WHEN 'D' THEN 'full'
			WHEN 'I' THEN 'diff'
		END AS Backup_Type
	FROM   msdb.dbo.backupmediafamily  
	   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id  
	WHERE  msdb..backupset.type = 'I'
	and msdb.dbo.backupset.database_name in (select name from sys.databases)
	GROUP BY 
	   msdb.dbo.backupset.database_name, msdb..backupset.type 
	 ) AS t

	   SELECT * INTO dbutils.dbo.backuprerun_diff
	   FROM tempdb..backup_rerun_temptable
	   WHERE last_db_backup_date <
	   (SELECT top 1
		 CASE 
			WHEN [sJOBH].[run_date] IS NULL OR [sJOBH].[run_time] IS NULL THEN NULL
			ELSE CAST(
					CAST([sJOBH].[run_date] AS CHAR(8))
					+ ' ' 
					+ STUFF(
						STUFF(RIGHT('000000' + CAST([sJOBH].[run_time] AS VARCHAR(6)),  6)
							, 3, 0, ':')
						, 6, 0, ':')
					AS DATETIME)
		  END AS [LastRunDateTime]
		FROM [msdb].[dbo].[sysjobhistory] AS [sJOBH]
		WHERE step_name = 'Backup - User DBs Diff'
		ORDER BY [LastRunDateTime] desc)
		and database_name in (select name from [dbo].[backup_eligible_diff_databases])
	ORDER BY last_db_backup_date desc


--Check if backup only failed on NBU side but sql take it as completed 

	set @failed_backup_number  = (SELECT count(*) FROM dbutils.dbo.backuprerun_diff)

	if @failed_backup_number  = 0
	begin
	set @subject = 'Failed diff backup could not rerun for [' + @@SERVERNAME + '], check Netbackup logs and rerun it.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'On sql side all backups look successfull, please check Netbackup log for failoure and make sure the backup chain is not broken!',
				@body_format = 'text',
				@importance = 'high'

				set @output = @output +char(13)+char(10)+'On sql side all backups look successfull, please check Netbackup log for failoure and make sure the backup chain is not broken!'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				return -1
	end
	else
		set @output = @output +char(13)+char(10)+'Failed backup is find.'
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		PRINT 'Failed backup is find.'


--Check if environmentInfo table exist
	  IF NOT EXISTS(SELECT * FROM dbutils.dbo.sysobjects WHERE name = 'EnvironmentInfo') 

  begin
		
		EXEC master.dbo.sp_addlinkedserver @server = N'AGTDBAMONHAL', @srvproduct=N'SQL Server'
		EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'AGTDBAMONHAL', @locallogin = NULL , @useself = N'True'
		EXECUTE AGTDBAMONHAL.sysdba_dbinfo.[dbo].[sp_GetEnvironmentData] @@servername, @environment=@env OUTPUT;
		SET @run_date = getdate()
	
		CREATE TABLE dbutils.dbo.EnvironmentInfo
		(
		Production_level nvarchar(10),
		Last_run_date datetime
		)

		INSERT INTO dbutils.dbo.EnvironmentInfo
		(
		Production_level,
		Last_run_date
		)
		VALUES
		(
		@env,
		@run_date
		)

		EXEC master.dbo.sp_dropserver @server=N'AGTDBAMONHAL', @droplogins='droplogins'
		
	end

	ELSE
	set @output = @output +char(13)+char(10)+'EnvironmentInfo table exist'
	exec dbo.sp_WriteStringToFile @path, @output, '2'
	PRINT 'EnvironmentInfo table exist'

	
--Check if environment info has correct data and is older then 1 week
	IF (SELECT Last_run_date FROM dbutils.dbo.EnvironmentInfo) <= DATEADD(ww, -1, GETDATE())
	 or  (select top 1 Production_level from [dbutils].[dbo].[EnvironmentInfo]) Is null 
	BEGIN
		--If environment info older then 1 week overwrite it with current info from DBAI
		EXEC master.dbo.sp_addlinkedserver @server = N'AGTDBAMONHAL', @srvproduct=N'SQL Server'
		EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'AGTDBAMONHAL', @locallogin = NULL , @useself = N'True'
		EXECUTE AGTDBAMONHAL.sysdba_dbinfo.[dbo].[sp_GetEnvironmentData] @@servername, @environment=@env OUTPUT;
		SET @run_date = getdate()
				
		DROP TABLE dbutils.dbo.EnvironmentInfo

		CREATE TABLE dbutils.dbo.EnvironmentInfo
		(
		Production_level nvarchar(10),
		Last_run_date datetime
		)

		INSERT INTO dbutils.dbo.EnvironmentInfo
		(
		Production_level,
		Last_run_date
		)
		VALUES
		(
		@env,
		@run_date
		)

		EXEC master.dbo.sp_dropserver @server=N'AGTDBAMONHAL', @droplogins='droplogins'
		IF (select top 1 Production_level from [dbutils].[dbo].[EnvironmentInfo]) Is null
		begin
		set @subject = 'Failed diff backup could not rerun for [' + @@SERVERNAME + '], as EnvironmentInfo table not set.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'Check dbutils.dbo.EnvironmentInfo table. Production_level has to contain not null value.',
				@body_format = 'text',
				@importance = 'high'
				set @output = @output +char(13)+char(10)+'Failed diff backup could not rerun .Check dbutils.dbo.EnvironmentInfo table. Production_level has to contain not null value.'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
		return -1
		
		end
	END

	ELSE
	set @output = @output +char(13)+char(10)+'Environment info is current'
	exec dbo.sp_WriteStringToFile @path, @output, '2'
	PRINT 'Environment info is current'

-- Adding new checks for time on prod instances
	set @env = (SELECT Production_level FROM dbutils.dbo.EnvironmentInfo)


	if @current_time between '07:00:00' and '17:00:00' and @env = 'prod' and @day_of_week in ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
			begin
				set @subject = 'Failed DIFF backup could not rerun for [' + @@SERVERNAME + '] as it office time now.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'Please check if the backup should be rerun manually or other action has to be taken.',
				@body_format = 'text',
				@importance = 'high'
				set @output = @output +char(13)+char(10)+'Failed DIFF backup could not rerun as it office time now.'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				return -1
			end
			else 
				set @output = @output +char(13)+char(10)+'Environment level and office hours check ok.'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				print 'Environment level and office hours check ok.'

--Check if the server is excluded from backup rerun

	IF NOT EXISTS(SELECT * FROM dbutils.dbo.sysobjects WHERE name = 'serverexclude')
		BEGIN
			CREATE TABLE dbutils.dbo.serverexclude
			(
			Exclude_any_rerun bit not null
			)
		END

	set @exclude = (SELECT top 1 Exclude_any_rerun FROM dbutils.dbo.serverexclude)

	if @exclude = 'true'
			begin
				set @subject = 'Failed DIFF backup could not rerun for [' + @@SERVERNAME + '] as it is in exclude list.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'Please rerun check if the backup should be rerun manually or other action has to be taken.',
				@body_format = 'text',
				@importance = 'high'
				set @output = @output +char(13)+char(10)+'Failed DIFF backup could not rerun as it is in exclude list.'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				return -1
			end
		else
		set @output = @output +char(13)+char(10)+'Server not in exclude list'
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		print 'Server not in exclude list'

--New checks end

		--Retrieve database list
--Retrieve list of databases where diff failed and not in exclusion list to check if a valid full exist
		if @sqlver >= 9
			declare dblist cursor static for
				--select name from dbutils.dbo.backup_eligible_diff_databases order by name
				SELECT database_name FROM dbutils.dbo.backuprerun_diff WHERE dbutils.dbo.backuprerun_diff.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_diff_databases])

		else
			declare dblist cursor static for
				--select name from dbutils.dbo.backup_eligible_diff_databases_2005 order by name
				SELECT database_name FROM dbutils.dbo.backuprerun_diff WHERE dbutils.dbo.backuprerun_diff.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_diff_databases_2005])

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin

			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = 
					case
						when backup_date is null then 1
						when backup_date < restore_date then 1
						when backup_date < create_date then 1
						else 0
					end
				from (
					select
						create_date, 
						restore_date = ( select max(restore_date) as restore_date from msdb.dbo.restorehistory where destination_database_name = @dbname),
						backup_date = (	select max(backup_start_date) as backup_date from msdb.dbo.backupset where database_name = @dbname and type = 'D')
					from master.sys.databases
					where name = @dbname ) t

				if @missingfull = 1
				begin
					print 'WARNING: No valid full backup found for database ' + @dbname + ', performing full backup now'
					set @output = @output +char(13)+char(10)+'WARNING: No valid full backup found for database ' + @dbname + ', performing full backup now'
					exec dbo.sp_WriteStringToFile @path, @output, '2'
					set @nbu_script = @nbu_directory + 'sqlmissingfull' + @@servicename + '.bch'

					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
					set @nbu_batch_line = 'DATABASE "' + @dbname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					if SERVERPROPERTY('IsClustered') = 1
					begin
						set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
						exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					end					
					set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'STRIPES ' + cast(@nbu_stripes_full as nvarchar)
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
					set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

					set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
					exec @retval=xp_cmdshell @backup_sql
					if @retval <> 0
					begin
						set @output = @output +char(13)+char(10)+'NBU returned non-zero error code, check logs'
						exec dbo.sp_WriteStringToFile @path, @output, '2'
						raiserror('NBU returned non-zero error code, check logs', 16, 1 )
						return -1
					end

				end
			end
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		if @sqlver >= 9 
			if not exists (select name from dbutils.dbo.backup_eligible_diff_databases)
			begin
				set @output = @output +char(13)+char(10)+'No databases available for backup, or all databases excluded using the current configuration. '
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end
		else 
			if not exists (select name from dbutils.dbo.backup_eligible_diff_databases_2005)
			begin
				set @output = @output +char(13)+char(10)+'No databases available for backup, or all databases excluded using the current configuration. '
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
				return -1
			end

		set @nbu_script = @nbu_directory + 'sqldiff' + @@servicename + '.bch'

		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DATABASE $ALL', 0

		--Retrieve database exclusion list
--Set dblist cursor to pass all database for exclusion where the backup was successfull
		if @sqlver >= 9
			declare dblist cursor static for
				select name from master.sys.databases where name not in (SELECT database_name FROM dbutils.dbo.backuprerun_diff WHERE dbutils.dbo.backuprerun_diff.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_diff_databases]))
		else
--Set dblist cursor to pass all database for exclusion where the backup was successfull
			declare dblist cursor static for
				select name from master.sys.databases where name not in (SELECT database_name FROM dbutils.dbo.backuprerun_diff WHERE dbutils.dbo.backuprerun_diff.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_diff_databases_2005]))

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @nbu_batch_line = 'EXCLUDE "' + @dbname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if SERVERPROPERTY('IsClustered') = 1
		begin
			set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		end
		set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DUMPOPTION INCREMENTAL', 0
		set @nbu_batch_line = 'STRIPES ' + cast(@nbu_stripes_diff as nvarchar)
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
		set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

		set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		
		
		begin
			
			set @subject = 'Rerun of failed DIFF backup failed for [' + @@SERVERNAME + '].'
						exec msdb.dbo.sp_send_dbmail 
						@profile_name = 'System DBA Team Mail',
						@recipients = 'shagtdistsystemdbasq@transamerica.com',
						@subject = @subject,
						@body = 'Please check the logs, and see if user action is needed.',
						@body_format = 'text',
						@importance = 'high'

						set @output = @output +char(13)+char(10)+'NBU returned non-zero error code, check logs'
						exec dbo.sp_WriteStringToFile @path, @output, '2'
			raiserror('NBU returned non-zero error code, check logs', 16, 1 )
			return -1
		end
		set @output = @output +char(13)+char(10)+'Differential backup rerun completed at ' + cast(getdate() as varchar)
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		print 'Differential backup rerun completed at ' + cast(getdate() as varchar)
		
		return 0
	end
end

	if @backuptype = 'log'
	begin
		print 'Log backup rerun started at ' + cast(getdate() as varchar)
		set @output = 'Log backup rerun started at ' + cast(getdate() as varchar)
		exec dbo.sp_WriteStringToFile @path, @output, '2'

--Get the list of databases where the backup failed.

	IF EXISTS(SELECT * FROM dbutils.dbo.sysobjects WHERE name = 'backuprerun_log')
    DROP TABLE dbutils.dbo.backuprerun_log

	IF OBJECT_ID ('tempdb..backup_rerun_temptable') IS NOT NULL  DROP TABLE tempdb..backup_rerun_temptable

	SELECT database_name, last_db_backup_date, Backup_Type  
	INTO tempdb..backup_rerun_temptable
	FROM
	(
	SELECT  
	   msdb.dbo.backupset.database_name,  
	   MAX(msdb.dbo.backupset.backup_finish_date) AS last_db_backup_date,
		CASE msdb..backupset.type WHEN 'D' THEN 'full'
			WHEN 'I' THEN 'diff'
			WHEN 'L' THEN 'Log'
		END AS Backup_Type
	FROM   msdb.dbo.backupmediafamily  
	   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id  
	WHERE  msdb..backupset.type = 'L'
	and msdb.dbo.backupset.database_name in (select name from sys.databases)
	GROUP BY 
	   msdb.dbo.backupset.database_name, msdb..backupset.type 
	 ) AS t

	   SELECT * INTO dbutils.dbo.backuprerun_log
	   FROM tempdb..backup_rerun_temptable
	   WHERE last_db_backup_date <
	   (SELECT top 1
		 CASE 
			WHEN [sJOBH].[run_date] IS NULL OR [sJOBH].[run_time] IS NULL THEN NULL
			ELSE CAST(
					CAST([sJOBH].[run_date] AS CHAR(8))
					+ ' ' 
					+ STUFF(
						STUFF(RIGHT('000000' + CAST([sJOBH].[run_time] AS VARCHAR(6)),  6)
							, 3, 0, ':')
						, 6, 0, ':')
					AS DATETIME)
		  END AS [LastRunDateTime]
		FROM [msdb].[dbo].[sysjobhistory] AS [sJOBH]
		WHERE step_name = 'Backup - User DBs Log'	
		ORDER BY [LastRunDateTime] desc)
		and database_name in (select name from [dbo].[backup_eligible_log_databases])
	ORDER BY last_db_backup_date desc

	
--Check if backup only failed on NBU side but sql take it as completed 

	set @failed_backup_number  = (SELECT count(*) FROM dbutils.dbo.backuprerun_log)

	if @failed_backup_number  = 0
	begin
	set @subject = 'Failed log backup could not rerun for [' + @@SERVERNAME + '], check Netbackup logs and rerun it.'
				exec msdb.dbo.sp_send_dbmail 
				@profile_name = 'System DBA Team Mail',
				@recipients = 'shagtdistsystemdbasq@transamerica.com',
				@subject = @subject,
				@body = 'On sql side all backups look successfull, please check Netbackup log for failoure and make sure the backup chain is not broken!',
				@body_format = 'text',
				@importance = 'high'
				set @output = @output +char(13)+char(10)+'Failed log backup could not rerun for [' + @@SERVERNAME + '], check Netbackup logs and rerun it. On sql side all backups look successfull, please check Netbackup log for failoure and make sure the backup chain is ok'
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				return -1
	end
	else
		set @output = @output +char(13)+char(10)+'Failed backup is find.'
		exec dbo.sp_WriteStringToFile @path, @output, '2'
		PRINT 'Failed backup is find.'

--New checks end


		--Retrieve database list from dbutils.dbo.backuprerun_log
		
		
		--if @sqlver >= 9
			declare dblist cursor static for
				select database_name from dbutils.dbo.backuprerun_log where database_name in (select name from dbutils.dbo.backup_eligible_log_databases) order by database_name
		--else
		--	declare dblist cursor static for
		--		select name from dbutils.dbo.backup_eligible_log_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			print 'Backup of database ' + @dbname + ' started at ' + cast(getdate() as varchar)
			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = case when last_log_backup_lsn is null then 1 else 0 end
				from master.sys.database_recovery_status 
				where database_id = db_id(@dbname)

				if @missingfull = 1
				begin
					print 'WARNING: Broken log chain for database ' + @dbname + ', performing full backup now'
					set @output = @output +char(13)+char(10)+'WARNING: Broken log chain for database ' + @dbname + ', performing full backup now'
					exec dbo.sp_WriteStringToFile @path, @output, '2'
					set @nbu_script = @nbu_directory + 'sqlmissingfull' + @@servicename + '.bch'

					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
					set @nbu_batch_line = 'DATABASE "' + @dbname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					if SERVERPROPERTY('IsClustered') = 1
					begin
						set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
						exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					end
					set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'STRIPES ' + cast(@nbu_stripes_full as nvarchar)
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
					set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
					exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

					set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
					exec @retval=xp_cmdshell @backup_sql
					if @retval <> 0
					begin
						set @output = @output +char(13)+char(10)+'NBU returned non-zero error code, check logs'
						exec dbo.sp_WriteStringToFile @path, @output, '2'
						raiserror('NBU returned non-zero error code, check logs', 16, 1 )
						return -1
					end
				end
			end
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist



		if @sqlver >= 9 
			if not exists (select name from dbutils.dbo.backup_eligible_log_databases)
			begin
				set @output = @output +char(13)+char(10)+'No databases available for backup, or all databases excluded using the current configuration. '
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 10, 1 )
				return -1
			end
		else 
			if not exists (select name from dbutils.dbo.backup_eligible_log_databases_2005)
			begin
				set @output = @output +char(13)+char(10)+'No databases available for backup, or all databases excluded using the current configuration. '
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 10, 1 )
				return -1
			end

		set @nbu_script = @nbu_directory + 'sqllog' + @@servicename + '.bch'

		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OPERATION BACKUP', 1
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'DATABASE $ALL', 0

		--Retrieve database exclusion list
		if @sqlver >= 9
			declare dblist cursor static for
				--select name from master.sys.databases where name not in (select name from dbutils.dbo.backup_eligible_log_databases) order by name
				select name from master.sys.databases where name not in (SELECT database_name FROM dbutils.dbo.backuprerun_log WHERE dbutils.dbo.backuprerun_log.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_log_databases]))
		
		else
			declare dblist cursor static for
				--select name from master.dbo.sysdatabases where name not in (select name from dbutils.dbo.backup_eligible_log_databases_2005) order by name
				select name from master.sys.databases where name not in (SELECT database_name FROM dbutils.dbo.backuprerun_log WHERE dbutils.dbo.backuprerun_log.database_name in (SELECT name FROM [dbutils].[dbo].[backup_eligible_log_databases_2005]))
		

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @nbu_batch_line = 'EXCLUDE "' + @dbname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		set @nbu_batch_line = 'SQLHOST "' + @servname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLINSTANCE "' + @instname + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		if SERVERPROPERTY('IsClustered') = 1
		begin
			set @nbu_batch_line = 'BROWSECLIENT "' + @servname + '"'
			exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		end
		set @nbu_batch_line = 'NBSERVER "' + @nbu_master_server + '"'
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'BATCHSIZE ' + cast(@nbu_batchsize_log as nvarchar)
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'OBJECTTYPE TRXLOG', 0
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
		set @nbu_batch_line = 'NUMBUFS ' + @nbu_numbufs + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		set @nbu_batch_line = 'SQLCOMPRESSION ' + @compression + ''
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, @nbu_batch_line, 0
		exec dbutils.dbo.sp_WriteStringToFile @nbu_script, 'ENDOPER TRUE', 0	

		set @backup_sql = @nbu_directory + 'dbbackex.exe -f ' + @nbu_script + ' -p ' + @nbu_policy + ' -np'
		exec @retval=xp_cmdshell @backup_sql
		if @retval != 0
			BEGIN
				SELECT @dbs_with_no_log_backup = COALESCE(@dbs_with_no_log_backup + ', ', '') + database_name
				FROM tempdb..backup_rerun_temptable
				where last_db_backup_date <= DATEADD(hh, -2, GETDATE())

				IF @dbs_with_no_log_backup is not null
					begin 
						set @subject = 'Rerun of failed log backup failed for [' + @@SERVERNAME + '].'
						set @body = 'There were no successfull logbackup in the past 2 hours of the following databases:  ' + @dbs_with_no_log_backup + '.'
							exec msdb.dbo.sp_send_dbmail 
							@profile_name = 'System DBA Team Mail',
							@recipients = 'shagtdistsystemdbasq@transamerica.com',
							@subject = @subject,
							@body = @body,
							@body_format = 'text',
							@importance = 'high'

							set @output = @output +char(13)+char(10)+'Rerun of failed log backup failed. There were no successfull logbackup in the past 2 hours of the following databases:  ' + @dbs_with_no_log_backup +'. '
							exec dbo.sp_WriteStringToFile @path, @output, '2'
						return -1
					end
					else
					begin
						set @output = @output +char(13)+char(10)+'Rerun of failed log backup failed but every database, which is subject of log backup, has at least one successful log from the last 2 hours.'
						exec dbo.sp_WriteStringToFile @path, @output, '2'
						print 'Every database, which is subject of log backup, has at least one successful log from the last 2 hours.'
						return -1
					end
			END		
			ELSE
			BEGIN
				print 'Log backup rerun completed at ' + cast(getdate() as varchar)
				set @output = @output +char(13)+char(10)+'Log backup rerun completed at ' + cast(getdate() as varchar)
				exec dbo.sp_WriteStringToFile @path, @output, '2'
				return 0
			END
	END

	
	



GO
/****** Object:  StoredProcedure [dbo].[sp_backup_tsm]    Script Date: 10/19/2022 1:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_backup_tsm]
(
	@backuptype varchar(4) = null
)
as
begin

	declare @dbname nvarchar(max)
	declare @tsm_db_list nvarchar(max)
	declare @tsm_directory nvarchar(256)
	declare @backup_sql varchar(8000)
	declare @backup_count int
	declare @missingfull bit
	declare @sqlver nvarchar(64)
	declare @retval int

	set @sqlver = cast(serverproperty('ProductVersion') as varchar(64))
	set @sqlver = left(@sqlver,charindex('.',@sqlver)-1)

	set @backup_count = 0
	set @backuptype = lower(@backuptype)

	set @tsm_db_list = ''

	--Check valid backup type
	if @backuptype is null or @backuptype not in ('full', 'diff', 'log', 'sys')
	begin
		raiserror('Invalid backup type specified. Valid backup types are ''full'', ''diff'', ''log'' or ''sys''. ', 16, 1 )
		return -1
	end

	--Retrieve configuration information
	select @tsm_directory = tsm_directory from dbutils.dbo.backup_config
	if @tsm_directory is null
	begin
		raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
		return -1
	end
	if right(@tsm_directory,1) <> '\'
		set @tsm_directory = @tsm_directory + '\'

	--List database status for output
	if @sqlver >= 9
		select * from dbutils.dbo.backup_database_status order by name
	else
		select * from dbutils.dbo.backup_database_status_2005 order by name

	--Begin backup routines
	if @backuptype = 'full'
	begin
		print 'Full backup started at ' + cast(getdate() as varchar)

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_full_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_full_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @tsm_db_list = @tsm_db_list + '"' + @dbname + '",'
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		if @tsm_db_list = ''
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
			return -1
		end

		--Trim right comma
		set @tsm_db_list = left(@tsm_db_list, len(@tsm_db_list)-1)

		set @backup_sql = @tsm_directory + 'tdpsqlc.exe backup ' + @tsm_db_list + ' FULL /sqlserver=' + @@SERVERNAME + ' /LOGF=sqlfull.log /SQLAUTH=INT'
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
			set @backup_sql = @backup_sql + ' /SQLCOMP=Yes'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			raiserror('TSM returned non-zero error code, check logs', 16, 1 )
			return -1
		end

		print 'Full backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'sys'
	begin
		print 'System database backup started at ' + cast(getdate() as varchar)

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_sys_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_sys_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @tsm_db_list = @tsm_db_list + '"' + @dbname + '",'
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		if @tsm_db_list = ''
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
			return -1
		end

		--Trim right comma
		set @tsm_db_list = left(@tsm_db_list, len(@tsm_db_list)-1)

		set @backup_sql = @tsm_directory + 'tdpsqlc.exe backup ' + @tsm_db_list + ' FULL /sqlserver=' + @@SERVERNAME + ' /LOGF=sqlsys.log /SQLAUTH=INT'
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
			set @backup_sql = @backup_sql + ' /SQLCOMP=Yes'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			raiserror('TSM returned non-zero error code, check logs', 16, 1 )
			return -1
		end

		print 'System database backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'diff'
	begin
		print 'Differential backup started at ' + cast(getdate() as varchar)

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_diff_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_diff_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin

			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = 
					case
						when backup_date is null then 1
						when backup_date < restore_date then 1
						when backup_date < create_date then 1
						else 0
					end
				from (
					select
						create_date, 
						restore_date = ( select max(restore_date) as restore_date from msdb.dbo.restorehistory where destination_database_name = @dbname),
						backup_date = (	select max(backup_start_date) as backup_date from msdb.dbo.backupset where database_name = @dbname and type = 'D')
					from master.sys.databases
					where name = @dbname ) t

				if @missingfull = 1
				begin
					print 'WARNING: No valid full backup found for database ' + @dbname + ', performing full backup now'
					set @backup_sql = @tsm_directory + 'tdpsqlc.exe backup "' + @dbname + '" FULL /sqlserver=' + @@SERVERNAME + ' /LOGF=sqlfull.log /SQLAUTH=INT'
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
						set @backup_sql = @backup_sql + ' /SQLCOMP=Yes'
					exec @retval=xp_cmdshell @backup_sql
					if @retval <> 0
					begin
						raiserror('TSM returned non-zero error code, check logs', 16, 1 )
						return -1
					end
				end
			end

			set @tsm_db_list = @tsm_db_list + '"' + @dbname + '",'
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		if @tsm_db_list = ''
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 16, 1 )
			return -1
		end

		--Trim right comma
		set @tsm_db_list = left(@tsm_db_list, len(@tsm_db_list)-1)

		set @backup_sql = @tsm_directory + 'tdpsqlc.exe backup ' + @tsm_db_list + ' DIFFFULL /sqlserver=' + @@SERVERNAME + ' /LOGF=sqldiff.log /SQLAUTH=INT'
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
			set @backup_sql = @backup_sql + ' /SQLCOMP=Yes'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			raiserror('TSM returned non-zero error code, check logs', 16, 1 )
			return -1
		end

		print 'Differential backup completed at ' + cast(getdate() as varchar)
	end

	if @backuptype = 'log'
	begin
		print 'Log backup started at ' + cast(getdate() as varchar)

		--Retrieve database list
		if @sqlver >= 9
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_log_databases order by name
		else
			declare dblist cursor static for
				select name from dbutils.dbo.backup_eligible_log_databases_2005 order by name

		open dblist
		fetch next from dblist into @dbname
		while @@fetch_status = 0
		begin
			set @backup_count = @backup_count + 1
			print 'Backup of database ' + @dbname + ' started at ' + cast(getdate() as varchar)
			--Check if database has a current full backup. If not, execute a full backup now.
			if @sqlver >= 9
			begin
				select @missingfull = case when last_log_backup_lsn is null then 1 else 0 end
				from master.sys.database_recovery_status 
				where database_id = db_id(@dbname)

				if @missingfull = 1
				begin
					print 'WARNING: Broken log chain for database ' + @dbname + ', performing full backup now'
					set @backup_sql = @tsm_directory + 'tdpsqlc.exe backup "' + @dbname + '" FULL /sqlserver=' + @@SERVERNAME + ' /LOGF=sqlfull.log /SQLAUTH=INT'
					if @sqlver >= 10 and serverproperty('EngineEdition') = 3
						set @backup_sql = @backup_sql + ' /SQLCOMP=Yes'
					exec @retval=xp_cmdshell @backup_sql
					if @retval <> 0
					begin
						raiserror('TSM returned non-zero error code, check logs', 16, 1 )
						return -1
					end
					print 'Backup of database ' + @dbname + ' completed at ' + cast(getdate() as varchar)
				end
			end
			set @tsm_db_list = @tsm_db_list + '"' + @dbname + '",'
			fetch next from dblist into @dbname
		end
		close dblist
		deallocate dblist

		if @tsm_db_list = ''
		begin
			raiserror('No databases available for backup, or all databases excluded using the current configuration. ', 10, 1 )
			return -1
		end

		--Trim right comma
		set @tsm_db_list = left(@tsm_db_list, len(@tsm_db_list)-1)

		set @backup_sql = @tsm_directory + 'tdpsqlc.exe backup ' + @tsm_db_list + ' LOG /sqlserver=' + @@SERVERNAME + ' /LOGF=sqllog.log /SQLAUTH=INT'
		if @sqlver >= 10 and serverproperty('EngineEdition') = 3
			set @backup_sql = @backup_sql + ' /SQLCOMP=Yes'
		exec @retval=xp_cmdshell @backup_sql
		if @retval <> 0
		begin
			raiserror('TSM returned non-zero error code, check logs', 16, 1 )
			return -1
		end

		print 'Log backup completed at ' + cast(getdate() as varchar)
	end

end
GO
/****** Object:  StoredProcedure [dbo].[sp_checkdb]    Script Date: 10/19/2022 1:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc [dbo].[sp_checkdb]
(
 @Physical sysname = null,
 @dbname sysname = 'all_dbs' 
 )
as
begin

set nocount on

declare @db_name sysname
declare @sqlver nvarchar(64)
declare @cmd varchar(5120)

set @sqlver = cast(serverproperty('ProductVersion') as varchar(64))
set @sqlver = left(@sqlver,charindex('.',@sqlver)-1)

create table #eligible_dbs (name sysname)

IF @Physical not in ( 'Physical_Only' ) or (@sqlver < 11)

BEGIN

if @dbname = 'all_dbs'
	insert into #eligible_dbs select name from master.sys.databases where lower(name) not in ('master', 'msdb', 'tempdb', 'model') and state = 0 and is_read_only = 0 and dbutils.dbo.fn_dbReplicaState(name) in ('NONE', 'PRIMARY') and not exists (select db_name from dbutils.dbo.maintenance_exclusions where upper(db_name) collate database_default = upper(name) and exclude_checkdb = 1) 
		else
	insert into #eligible_dbs select name from master.sys.databases where lower(name) = lower(@dbname) and state = 0 and is_read_only = 0 and dbutils.dbo.fn_dbReplicaState(name) in ('NONE', 'PRIMARY')
	
declare eligible_dbs cursor for 
	select name from #eligible_dbs order by name	

open eligible_dbs

fetch next from eligible_dbs into @db_name

while (@@fetch_status = 0)
begin

	set @cmd = 'dbcc updateusage ([' + @db_name + '])'

	print '---------------------------------------------'
	print 'Updating usage on database [' + @db_name + ']'
	print '---------------------------------------------'
	exec (@cmd)

	set @cmd = 'dbcc checkdb ([' + @db_name + '])'

	print '---------------------------------------------'
	print 'Checking integrity of database [' + @db_name + ']'
	print '---------------------------------------------'


	exec (@cmd)
	print 'Full intregeaty check'
	fetch next from eligible_dbs into @db_name
	
END
END


ELSE

Begin


if @dbname = 'all_dbs'
	insert into #eligible_dbs select name from master.sys.databases where lower(name) not in ('master', 'msdb', 'tempdb', 'model') and state = 0 and is_read_only = 0 and dbutils.dbo.fn_dbReplicaState(name) in ('NONE', 'PRIMARY') and not exists (select db_name from dbutils.dbo.maintenance_exclusions where upper(db_name) collate database_default = upper(name) and exclude_checkdb = 1)
else
	insert into #eligible_dbs select name from master.sys.databases where lower(name) = lower(@dbname) and state = 0 and is_read_only = 0 and dbutils.dbo.fn_dbReplicaState(name) in ('NONE', 'PRIMARY') and not exists (select db_name from dbutils.dbo.maintenance_exclusions where upper(db_name) collate database_default = upper(name) and exclude_checkdb = 1)
	
declare eligible_dbs cursor for 
	select name from #eligible_dbs order by name	

open eligible_dbs

fetch next from eligible_dbs into @db_name

while (@@fetch_status = 0)
begin

	set @cmd = 'dbcc updateusage ([' + @db_name + '])'

	print '---------------------------------------------'
	print 'Updating usage on database [' + @db_name + ']'
	print '---------------------------------------------'
	exec (@cmd)

	set @cmd = 'dbcc checkdb ([' + @db_name + ']) with '+ @Physical + ''

	print '---------------------------------------------'
	print 'Checking integrity of database [' + @db_name + ']'
	print '---------------------------------------------'

	exec (@cmd)
	Print 'Physical Only'
	fetch next from eligible_dbs into @db_name

END
END

close eligible_dbs
deallocate eligible_dbs

End
GO
/****** Object:  StoredProcedure [dbo].[sp_defragment]    Script Date: 10/19/2022 1:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE proc [dbo].[sp_defragment] ( @min_fragmentation tinyint = 10, @rebuild_pct tinyint = 30, @rebuild_online bit = 1, @sort_in_tempdb bit = 1, @maxdop tinyint = 4, @dbname sysname = 'all_dbs' )
as
begin

set nocount on

declare @dbid int
declare @db_name sysname
declare @schema_name sysname
declare @object_name sysname
declare @index_name sysname
declare @partition_number int
declare @partition varchar(10)
declare @avg_frag float
declare @orig_ffactor tinyint
declare @allow_plock bit
declare @min_frag varchar(3)
declare @cmd varchar(5120)
declare @settings varchar(5120)
declare @sqlver nvarchar(64)

set @sqlver = cast(serverproperty('ProductVersion') as varchar(64))
set @sqlver = left(@sqlver,charindex('.',@sqlver)-1)

set @settings = 'SET ANSI_NULLS ON ; SET ANSI_PADDING ON ; SET ANSI_WARNINGS ON ; SET ARITHABORT ON ; SET CONCAT_NULL_YIELDS_NULL ON ; SET QUOTED_IDENTIFIER ON ; SET NUMERIC_ROUNDABORT OFF ; '

set @min_frag = cast(@min_fragmentation as varchar(3))

create table #fragmented_indexes ( db_name sysname, schema_name sysname, object_name sysname, index_name sysname, partition_number int, avg_fragmentation_in_percent float, fill_factor tinyint, allow_page_locks bit)
create table #eligible_dbs ( database_id int, name sysname )

if @dbname = 'all_dbs'
	insert into #eligible_dbs select database_id, name from master.sys.databases where lower(name) not in ('master', 'msdb', 'tempdb', 'model') and state = 0 and is_read_only = 0 and dbutils.dbo.fn_dbReplicaState(name) in ('NONE', 'PRIMARY') and not exists (select db_name from dbutils.dbo.maintenance_exclusions where upper(db_name) collate database_default = upper(name) and exclude_defrag = 1)
else
	insert into #eligible_dbs select database_id, name from master.sys.databases where lower(name) = lower(@dbname) and state = 0 and is_read_only = 0 and dbutils.dbo.fn_dbReplicaState(name) in ('NONE', 'PRIMARY')

declare eligible_dbs cursor for
	select database_id, name from #eligible_dbs order by database_id

open eligible_dbs

fetch next from eligible_dbs into @dbid, @db_name

while (@@fetch_status = 0)
begin

	set @cmd = 'insert into #fragmented_indexes '
	set @cmd = @cmd + ' select '
	set @cmd = @cmd + '''' + @db_name + ''', '
	set @cmd = @cmd + 's.name, '
	set @cmd = @cmd + 'o.name, '
	set @cmd = @cmd + 'i.name, '
	set @cmd = @cmd + 'partition_number, '
	set @cmd = @cmd + 'avg_fragmentation_in_percent, '
	set @cmd = @cmd + 'i.fill_factor, '
	set @cmd = @cmd + 'i.allow_page_locks '
	set @cmd = @cmd + 'from  '
	set @cmd = @cmd + 'master.sys.dm_db_index_physical_stats (' + cast(@dbid as varchar(5)) + ', null, null , null, null) ips, '
	set @cmd = @cmd + '[' + @db_name + '].sys.objects o, '
	set @cmd = @cmd + '[' + @db_name + '].sys.schemas s, '
	set @cmd = @cmd + '[' + @db_name + '].sys.indexes i '
	set @cmd = @cmd + 'where  '
	set @cmd = @cmd + 'ips.index_id > 0 and '
	set @cmd = @cmd + 'o.object_id = ips.object_id and '
	set @cmd = @cmd + 's.schema_id = o.schema_id and '
	set @cmd = @cmd + 'i.object_id = ips.object_id and '
	set @cmd = @cmd + 'i.index_id = ips.index_id'

	--print @cmd
	exec (@cmd)

	fetch next from eligible_dbs into @dbid, @db_name

end

close eligible_dbs
deallocate eligible_dbs

select db_name, schema_name, object_name, index_name, partition_number, avg_fragmentation_in_percent, fill_factor, allow_page_locks 
from #fragmented_indexes
order by db_name, schema_name, object_name, index_name, partition_number

declare fragmented_indexes cursor for 
	select db_name, schema_name, object_name, index_name, partition_number, avg_fragmentation_in_percent, fill_factor, allow_page_locks 
	from #fragmented_indexes 
	where avg_fragmentation_in_percent > @min_frag
	order by avg_fragmentation_in_percent desc

open fragmented_indexes

fetch next from fragmented_indexes into @db_name, @schema_name, @object_name, @index_name, @partition_number, @avg_frag, @orig_ffactor, @allow_plock

while (@@fetch_status = 0)
begin

	if @orig_ffactor = 0 
		set @orig_ffactor = 100

	if @avg_frag < @rebuild_pct and @allow_plock = 1
	begin
		set @cmd = 'alter index "' + @index_name + '" on [' + @db_name + '].[' + @schema_name + '].[' + @object_name + '] reorganize'
		
		if @partition_number = 1
		begin
			print 'Reorganizing index ' + @index_name + ' on object [' + @db_name + '].[' + @schema_name + '].[' + @object_name + '] (' + cast(round(@avg_frag, 0) as varchar(3)) + '% fragmented)'
		end
		else
		begin
			set @partition = cast ( @partition_number as varchar(10))
			print 'Reorganizing partition #' + @partition + ' of index ' + @index_name + ' on object [' + @db_name + '].[' + @schema_name + '].[' + @object_name + '] (' + cast(round(@avg_frag, 0) as varchar(3)) + '% fragmented)'
			set @cmd = @cmd + ' partition=' + @partition
		end

		--print @cmd
		exec (@settings + @cmd)

	end
	else
	begin
		set @cmd = 'alter index "' + @index_name + '" on [' + @db_name + '].[' + @schema_name + '].[' + @object_name + '] rebuild '
		if @partition_number = 1
		begin
			set @cmd = @cmd + ' with ( fillfactor = ' + cast(@orig_ffactor as varchar(3)) + ', '
			if @rebuild_online = 1
				if @sqlver >= 12
					set @cmd = @cmd + ' online = on ( WAIT_AT_LOW_PRIORITY ( MAX_DURATION = 1 MINUTES, ABORT_AFTER_WAIT = SELF )),'
				else
					set @cmd = @cmd + ' online = on,'
			else
				set @cmd = @cmd + ' online = off,'

			if @sort_in_tempdb = 1
				set @cmd = @cmd + ' sort_in_tempdb = on,'
			else
				set @cmd = @cmd + ' sort_in_tempdb = off,'

			set @cmd = @cmd + ' maxdop = ' + cast(@maxdop as varchar(3)) + ')'
			print 'Rebuilding index ' + @index_name + ' on object [' + @db_name + '].[' + @schema_name + '].[' + @object_name + '] (' + cast(round(@avg_frag, 0) as varchar(3)) + '% fragmented)'
		end
		else
		begin
			set @partition = cast ( @partition_number as varchar(10))
			set @cmd = @cmd + ' partition=' + @partition + 'with ('
			if @sort_in_tempdb = 1
				set @cmd = @cmd + ' sort_in_tempdb = on,'
			else
				set @cmd = @cmd + ' sort_in_tempdb = off,'
				
			set @cmd = @cmd + ' maxdop = ' + cast(@maxdop as varchar(3)) + ')'
						
			print 'Rebuilding partition #' + @partition + ' of index ' + @index_name + ' on object [' + @db_name + '].[' + @schema_name + '].[' + @object_name + '] (' + cast(round(@avg_frag, 0) as varchar(3)) + '% fragmented)'
		end
		begin try
			--print @cmd
			set @cmd = 'set QUOTED_IDENTIFIER on; ' + @cmd
			exec (@settings + @cmd)
		end try
		begin catch
------------------------------------
-- NEW Code Block Added 30-03-2020
-- CHANN (Chad's Update)
------------------------------------
                     if ERROR_NUMBER() in (2725, 1712, 153)
                     begin
                           print 'WARNING: Online index rebuild failed, attempting to rebuild the index offline.'
                           set @cmd = replace(@cmd , 'online = on ( WAIT_AT_LOW_PRIORITY ( MAX_DURATION = 1 MINUTES, ABORT_AFTER_WAIT = SELF ))', 'online = off')
                           set @cmd = replace(@cmd , 'online = on', 'online = off')
                           --print @cmd
                           exec (@settings + @cmd)
                     end
                     else if ERROR_NUMBER() in (35327, 35328)
                     begin
                           print 'WARNING: Online index rebuild failed, attempting to rebuild the index offline.'
                           set @cmd = replace(@cmd , 'online = on ( WAIT_AT_LOW_PRIORITY ( MAX_DURATION = 1 MINUTES, ABORT_AFTER_WAIT = SELF ))', 'online = off')
                            set @cmd = replace(@cmd , 'online = on', 'online = off')
                           set @cmd = replace(@cmd , 'fillfactor = 100,','')
                           set @cmd = replace(@cmd , 'sort_in_tempdb = on,', '')
                           --print @cmd
                           exec (@settings + @cmd)
                     end
--------------------------------------
--------------------------------------
			else
				exec dbutils.dbo.sp_RethrowError;
		end catch

	end

	fetch next from fragmented_indexes into @db_name, @schema_name, @object_name, @index_name, @partition_number, @avg_frag, @orig_ffactor, @allow_plock

end

close fragmented_indexes
deallocate fragmented_indexes

drop table #fragmented_indexes

end
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_backupsethistory]    Script Date: 10/19/2022 1:46:31 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[sp_delete_backupsethistory]
	@bsid int
as
begin

	set nocount on

	declare @msid int
	declare @rows int

	set @rows = (select count(*) from msdb.dbo.restorehistory where backup_set_id = @bsid)
	if (@rows > 0)
	begin
		delete from msdb.dbo.restorefile where restore_history_id in (select restore_history_id from msdb.dbo.restorehistory where backup_set_id = @bsid)
		delete from msdb.dbo.restorefilegroup where restore_history_id in (select restore_history_id from msdb.dbo.restorehistory where backup_set_id = @bsid)
		delete from msdb.dbo.restorehistory where backup_set_id = @bsid
	end

	set @msid = (select media_set_id from msdb.dbo.backupset where backup_set_id = @bsid)

	delete from msdb.dbo.backupfile where backup_set_id = @bsid
	if object_id('msdb.dbo.backupfilegroup') is not null
		delete from msdb.dbo.backupfilegroup where backup_set_id = @bsid
	delete from msdb.dbo.backupset where backup_set_id = @bsid
	
	set @rows = (select count(*) from msdb.dbo.backupset where media_set_id = @msid)
	if (@rows = 0)
	begin
		delete from msdb.dbo.backupmediafamily where media_set_id = @msid
		delete from msdb.dbo.backupmediaset where media_set_id = @msid
	end

end

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_expired_backups]    Script Date: 10/19/2022 1:46:31 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc [dbo].[sp_delete_expired_backups]
as
begin

	set nocount on

	declare @dbname nvarchar(1024)
	declare @bkptype char(1)
	declare @bkpdate datetime
	declare @bsid int
	declare @filename nvarchar(260)
	declare @filename_nbu nvarchar(260)
	declare @backup_method nvarchar(6)
	declare @retention_days int
	declare @retention_days_log int
	declare @command nvarchar(1024)
	declare @skip_checks bit
	declare @nbu_directory nvarchar(256)
	declare @nbu_master_server nvarchar(128)
	declare @nbu_start_date nvarchar(10)
	declare @archived int
	declare @archive_err int
	declare @sysdate nvarchar(64)
	declare @day nvarchar(2)
	declare @month nvarchar(2)
	declare @result table (line nvarchar(512))

	set @day = right('0' + cast(datepart(dd ,getdate()) as nvarchar), 2)
	set @month = right('0' + cast(datepart(mm ,getdate()) as nvarchar), 2)
	set @command = 'echo %DATE%'

	insert into @result
		exec xp_cmdshell @command

	select top 1 @sysdate = line from @result

	set @archive_err = 0

	select  @backup_method = backup_method, 
		@retention_days = native_retention_days, 
		@retention_days_log = native_retention_days_log, 
		@skip_checks = native_skip_checks, 
		@nbu_directory = nbu_directory,
		@nbu_master_server = nbu_master_server 
	from dbutils.dbo.backup_config
	
	if @backup_method is null
	begin
		raiserror('Backup configuration is not set in table dbutils.dbo.backup_config. ', 16, 1 )
		return -1
	end

	if @backup_method not in ('native', 's3') 
	begin
		raiserror('Skipping cleanup - backup method is not "native".', 10, 1 )
		return -1
	end
	
	if @retention_days is null or @retention_days_log is null or @skip_checks is null
	begin
		raiserror('Backup configuration not fully specified for "native" method in table dbutils.dbo.backup_config. ', 16, 1 )
		return -1
	end

	create table #expired_files ( backup_set_id int, backup_set_uuid uniqueidentifier, physical_device_name nvarchar(260), backup_start_date datetime )

	--Create list of full and differential backups older than the retention period
	insert into #expired_files 
		select backup_set_id, backup_set_uuid, physical_device_name, backup_start_date
		from msdb.dbo.backupset bs, msdb.dbo.backupmediafamily bf 
		where database_name COLLATE DATABASE_DEFAULT not in 
			( select db_name 
			  from dbutils.dbo.backup_exclusions 
			  where exclude_cleanup = 1 ) 
		and type <> 'L'
		and backup_start_date <= getdate()- @retention_days 
		and bf.media_set_id = bs.media_set_id
		and bs.is_copy_only = 0
		and server_name = @@servername
		and (physical_device_name like '\\%' or physical_device_name like '_:\%')

	--Create list of log backups older than the retention period
	insert into #expired_files 
		select backup_set_id, backup_set_uuid, physical_device_name, backup_start_date
		from msdb.dbo.backupset bs, msdb.dbo.backupmediafamily bf 
		where database_name COLLATE DATABASE_DEFAULT not in 
			( select db_name 
			  from dbutils.dbo.backup_exclusions 
			  where exclude_cleanup = 1 ) 
		and type = 'L' 
		and backup_start_date <= getdate()-@retention_days_log 
		and bf.media_set_id = bs.media_set_id
		and bs.is_copy_only = 0
		and server_name = @@servername
		and (physical_device_name like '\\%' or physical_device_name like '_:\%')
	
	--Remove full backups from the expiration list that are still required for differential restores
	delete from #expired_files 
	where backup_set_uuid in
	( select distinct differential_base_guid
	  from msdb.dbo.backupset
	  where backup_set_id not in
	  (  select backup_set_id
	     from #expired_files
	  )
	)

	--Delete old files
	print 'Removing old backup files:'
	declare filelist cursor for
		select backup_set_id, physical_device_name, backup_start_date from #expired_files
	open filelist
	fetch next from filelist into @bsid, @filename, @bkpdate
	while @@fetch_status = 0
	begin
		if @filename like '\\%' or @skip_checks = 1
		begin
			print 'Deleting file: ' + @filename
			set @command = 'del "' + @filename + '"'
			exec master.dbo.xp_cmdshell @command, no_output
			exec sp_delete_backupsethistory @bsid
		end
	else
		begin
			print 'Checking archive bit on file: ' + @filename
			set @command = 'dir /B /A:A "' + @filename + '"'
			exec @archived = master.dbo.xp_cmdshell @command, no_output
			if @archived <> 0
			begin
				print 'Deleting file: ' + @filename
				set @command = 'del "' + @filename + '"'
				exec master.dbo.xp_cmdshell @command, no_output
				exec sp_delete_backupsethistory @bsid
			end
			else if @nbu_directory is null or @nbu_master_server is null
			begin
				print 'ERROR: Archive bit not cleared, cannot check NBU as NBU configuration settings not specified in table dbutils.dbo.backup_config.'
				set @archive_err = 1
			end
			else
			begin
				print 'Archive bit not cleared, checking NBU.'
				if charindex(@day, @sysdate) < charindex(@month,@sysdate)
					set @nbu_start_date = convert(nvarchar(10),@bkpdate,103)
				else 
					set @nbu_start_date = convert(nvarchar(10),@bkpdate,101)
				set @filename_nbu = replace(@filename, ':', '')
				set @filename_nbu = replace(@filename_nbu, '\', '/')
				set @filename_nbu = '/' + @filename_nbu
				set @command = @nbu_directory + 'bplist.exe -S ' + @nbu_master_server + ' -t 40 -b -I -PI -s ' + @nbu_start_date + ' -nt_files "' + @filename_nbu + '"'
				exec @archived = master.dbo.xp_cmdshell @command, no_output
				if @archived <> 0
				begin
					set @command = @nbu_directory + 'bplist.exe -S ' + @nbu_master_server + ' -t 13 -b -I -PI -s ' + @nbu_start_date + ' -nt_files "' + @filename_nbu + '"'
					exec @archived = master.dbo.xp_cmdshell @command, no_output
				end
				if @archived <> 0
				begin
					set @command = @nbu_directory + 'bplist.exe -S ' + @nbu_master_server + ' -t 9 -b -I -PI -s ' + @nbu_start_date + ' -nt_files "' + @filename_nbu + '"'
					exec @archived = master.dbo.xp_cmdshell @command, no_output
				end
				if @archived <> 0
				begin
					set @command = @nbu_directory + 'bplist.exe -S ' + @nbu_master_server + ' -t 0 -b -I -PI -s ' + @nbu_start_date + ' -nt_files "' + @filename_nbu + '"'
					exec @archived = master.dbo.xp_cmdshell @command, no_output
				end
				if @archived <> 0
				begin
					set @command = @nbu_directory + 'bplist.exe -S ' + @nbu_master_server + ' -b -I -PI -s ' + @nbu_start_date + ' -nt_files "' + @filename_nbu + '"'
					exec @archived = master.dbo.xp_cmdshell @command, no_output
				end
				if @archived <> 0
				begin
					print 'ERROR: File has not been archived, aborting cleanup.'
					set @archive_err = 1
				end
				else
				begin
					print 'Deleting file: ' + @filename
					set @command = 'del "' + @filename + '"'
					exec master.dbo.xp_cmdshell @command, no_output
					exec sp_delete_backupsethistory @bsid
				end
			end
		end

		fetch next from filelist into @bsid, @filename, @bkpdate
	end
	close filelist
	deallocate filelist

	drop table #expired_files

	if @archive_err = 1
		raiserror('One or more files marked for cleanup have not been archived.', 16, 1 )

end
GO
/****** Object:  StoredProcedure [dbo].[sp_mirror_db]    Script Date: 10/19/2022 1:46:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc [dbo].[sp_mirror_db](  @primary_instance nvarchar(128), 
				   @db_name nvarchar(128), 
				   @data_directory nvarchar(512) = null,
				   @log_directory nvarchar(512) = null,
				   @skip_kerb_check bit = 0,
				   @skip_full_backup bit = 0,
				   @skip_diff_backup bit = 0,
				   @debug bit = 0 )
as
begin

	set nocount on

	declare @sql_version nvarchar(max)
	
	declare @source_server nvarchar(max)
	
	declare @auth_scheme nvarchar(40)
	declare @client_net_address varchar(48)
	declare @local_net_address varchar(48)
	
	declare @recovery_model int
	declare @full_date datetime
	declare @full_path nvarchar(max)
	declare @diff_date datetime
	declare @diff_path nvarchar(max)
	declare @log_start_date datetime
	declare @log_last_lsn numeric(25,0) 
 	declare @log_path nvarchar(max)
	
	declare @move_statement nvarchar(max)
	declare @file_id int
	declare @file_name nvarchar(max)
	declare @group_id int
	declare @file_path nvarchar(max)
	declare @file_suffix nvarchar(4)
	declare @regpath nvarchar(512)

	declare @active_spid int
	declare @username sysname

	declare @primary_host nvarchar(100)
	declare @primary_domain nvarchar(100)
	declare @primary_port nvarchar(6)
	declare @mirror_host nvarchar(100)
	declare @mirror_domain nvarchar(100)
	declare @mirror_port nvarchar(6)
	
	declare @cmd nvarchar(max)
	declare @msg nvarchar(max)

	--Check and prepare procedure parameters
	set @sql_version = CAST(SERVERPROPERTY('ProductVersion') as nvarchar)
	set @sql_version = left(@sql_version,charindex('.',@sql_version)-1)

	if UPPER(@primary_instance) = UPPER(@@SERVERNAME)
	begin
		set @msg = 'You cannot create a mirrored database on the same instance as the primary database.'
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end
		
	if CHARINDEX('\',@primary_instance) = 0 
		set @source_server = @primary_instance
	else
		set @source_server = LEFT(@primary_instance,CHARINDEX('\',@primary_instance)-1)

	if @data_directory is not null and @log_directory is null
	begin
		set @msg = '@log_directory not provided. You must provide a value for @log_directory when @data_directory is specified.'  
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end

	if @data_directory is null and @log_directory is not null
	begin
		set @msg = '@data_directory not provided. You must provide a value for @data_directory when @log_directory is specified.'  
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end
		
	if @skip_kerb_check = 0
	begin

		--Check to see if the remote queries will require multiple hops. If they do, and we're not using Kerberos, return an error
		select @auth_scheme=auth_scheme, @client_net_address=client_net_address, @local_net_address=local_net_address from master.sys.dm_exec_connections where session_id=@@spid
		
		if @auth_scheme = 'NTLM' and @client_net_address <> '<local machine>' and @primary_instance <> @@SERVERNAME and @client_net_address <> @local_net_address
		begin
			set @msg = 'This operation requires multi-hop authentication and this session is not using Kerberos authentication. Execute this command locally on ' + @@SERVERNAME + ' or configure ' + @@SERVERNAME + ' to use Kerberos authentication.'
			raiserror(@msg, 16, 1 )
			goto cleanup
		end	

	end
			
	--Create a temporary linked server to gather data from the source instance
	if exists ( select srvid from master.sys.sysservers where srvid != 0 and srvname = 'ls_primary_instance')
		exec master.dbo.sp_dropserver @server='ls_primary_instance', @droplogins='droplogins'
		
	exec master.dbo.sp_addlinkedserver @server = 'ls_primary_instance', @srvproduct = '', @provider = 'SQLNCLI', @datasrc = @primary_instance
	exec master.dbo.sp_addlinkedsrvlogin @rmtsrvname = 'ls_primary_instance', @locallogin = NULL , @useself = 'True'
	exec master.dbo.sp_serveroption @server=N'ls_primary_instance', @optname=N'rpc', @optvalue=N'true'
	exec master.dbo.sp_serveroption @server=N'ls_primary_instance', @optname=N'rpc out', @optvalue=N'true'

	begin try
		exec master.sys.sp_testlinkedserver ls_primary_instance
	end try
	begin catch
		set @msg = 'Cannot connect to ' + @primary_instance + '. ' + ERROR_MESSAGE()
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end catch

	--Capture the machine name, domain name and mirroring port for each instance
	if object_id('tempdb..##primary_endpoint') is not null
		drop table ##primary_endpoint;
		
	SELECT @mirror_host=name from master.sys.servers where server_id=0
	EXECUTE master.dbo.xp_regread 'HKEY_LOCAL_MACHINE', 'SYSTEM\CurrentControlSet\services\Tcpip\Parameters', N'Domain',@mirror_domain OUTPUT
	SELECT @mirror_port=port from master.sys.tcp_endpoints where name = 'Mirroring'

	set @cmd='declare @domain nvarchar(100)
	          declare @host nvarchar(100)
			  select @host=name from ls_primary_instance.master.sys.servers where server_id=0
			  EXECUTE ls_primary_instance.master.dbo.xp_regread ''HKEY_LOCAL_MACHINE'', ''SYSTEM\CurrentControlSet\services\Tcpip\Parameters'', N''Domain'',@domain OUTPUT
			  select @host as host, @domain as domain, port into ##primary_endpoint from ls_primary_instance.master.sys.tcp_endpoints where name = ''Mirroring'''
	exec (@cmd)
	select @primary_host=CAST(host as nvarchar(100)), @primary_domain=domain, @primary_port=port from ##primary_endpoint

	if charindex('\',@mirror_host) <> 0
		set @mirror_host = left(@mirror_host, charindex('\',@mirror_host)-1)
	if charindex('\',@primary_host) <> 0
		set @primary_host = left(@primary_host, charindex('\',@primary_host)-1)

	if @primary_port is null or @mirror_port is null
	begin
		set @msg = 'Mirroring endpoints have not been configured on both the primary and mirror instances or the mirroring endpoints are not named [Mirroring]. Configure the appropriate endpoints and try again.'
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end

	--Check the source DB recovery model and set the source and dest DB names to the correct case
	if object_id('tempdb..##primary_dbinfo') is not null
		drop table ##primary_dbinfo;

	set @cmd = 'select name, recovery_model into ##primary_dbinfo from [ls_primary_instance].master.sys.databases where lower(name) = lower(''' + @db_name + ''')'
	exec (@cmd)

	select @db_name=name, @recovery_model = recovery_model from ##primary_dbinfo

	if @recovery_model <> 1
	begin
		set @msg = 'Recovery model for ' + @db_name + ' on instance ' + @primary_instance + ' is not FULL. Set the recovery model to FULL and execute new full and log backups then try again.'
		raiserror(@msg, 16, 1 )
		goto cleanup
	end
				
	--Get the date & filename of the most recent full backup
	if object_id('tempdb..##primary_dbfullinfo') is not null
		drop table ##primary_dbfullinfo;

	set @cmd = 'select top 1 backup_start_date, physical_device_name into ##primary_dbfullinfo from [ls_primary_instance].msdb.dbo.backupset bs, [ls_primary_instance].msdb.dbo.backupmediafamily bf where database_name = ''' + @db_name + ''' and type = ''D'' and is_copy_only = 0 and bf.media_set_id = bs.media_set_id order by backup_start_date desc'
	exec (@cmd)

	select @full_date=backup_start_date, @full_path=physical_device_name 
	from   ##primary_dbfullinfo

	--Terminate the procedure if no full backup was found
	if @full_date is null
	begin
		set @msg = 'No full backup found for database ' + @db_name + ' on instance ' + @primary_instance
		raiserror(@msg, 16, 1 )
		goto cleanup
	end

	--Convert the file path to UNC if required
	if SUBSTRING(@full_path,2,1) = ':'
		set @full_path = '\\' + @source_server + '\' + LEFT(@full_path,1) + '$' + RIGHT(@full_path,LEN(@full_path)-2)

	--If the destination database does not already exist, or the logical file names don't match the source, generate a move statement
	set @move_statement = ''
	
	if object_id('tempdb..##primary_dbfiles') is not null
		drop table ##primary_dbfiles;
		
	if @sql_version = '10' or @sql_version = '11' or @sql_version = '12' 
		set @cmd='create table ##primary_dbfiles (LogicalName nvarchar(128), PhysicalName nvarchar(260), [Type] char(1), FileGroupName nvarchar(128), Size numeric(20,0), MaxSize numeric(20,0), FileID bigint, CreateLSN numeric(25,0), DropLSN numeric(25,0) NULL, UniqueID uniqueidentifier, ReadOnlyLSN numeric(25,0) NULL, ReadWriteLSN numeric(25,0) NULL, BackupSizeInBytes bigint, SourceBlockSize int, FileGroupID int, LogGroupGUID uniqueidentifier NULL, DifferentialBaseLSN numeric(25,0) NULL, DifferentialBaseGUID uniqueidentifier, IsReadOnly bit, IsPresent bit, TDEThumbprint varbinary(32))'
	else if @sql_version = '9'
		set @cmd='create table ##primary_dbfiles (LogicalName nvarchar(128), PhysicalName nvarchar(260), [Type] char(1), FileGroupName nvarchar(128), Size numeric(20,0), MaxSize numeric(20,0), FileID bigint, CreateLSN numeric(25,0), DropLSN numeric(25,0) NULL, UniqueID uniqueidentifier, ReadOnlyLSN numeric(25,0) NULL, ReadWriteLSN numeric(25,0) NULL, BackupSizeInBytes bigint, SourceBlockSize int, FileGroupID int, LogGroupGUID uniqueidentifier NULL, DifferentialBaseLSN numeric(25,0) NULL, DifferentialBaseGUID uniqueidentifier, IsReadOnly bit, IsPresent bit)'
	else if @sql_version = '13' 
		set @cmd= 'create table ##primary_dbfiles (LogicalName nvarchar(128), PhysicalName nvarchar(260), [Type] char(1), FileGroupName nvarchar(128), Size numeric(20,0), MaxSize numeric(20,0), FileID bigint, CreateLSN numeric(25,0), DropLSN numeric(25,0) NULL, UniqueID uniqueidentifier, ReadOnlyLSN numeric(25,0) NULL, ReadWriteLSN numeric(25,0) NULL, BackupSizeInBytes bigint, SourceBlockSize int, FileGroupID int, LogGroupGUID uniqueidentifier NULL, DifferentialBaseLSN numeric(25,0) NULL, DifferentialBaseGUID uniqueidentifier, IsReadOnly bit, IsPresent bit, TDEThumbprint varbinary(32), SnapshotUrl nvarchar(360))'
	else
	begin
		set @msg = 'Unrecognized SQL Server version. This procedure works on SQL 2005, 2008 and 2008r2 only.'
		raiserror(@msg, 16, 1 )
		goto cleanup
	end
	
	exec (@cmd)
	
	begin try
		set @cmd = 'restore filelistonly from disk = ''' + @full_path + ''''
		insert into ##primary_dbfiles exec (@cmd)
	end try
	begin catch
		set @msg = 'Unable to read file ''' + @full_path + ''', make sure that the file exists and that the service account has read access.'
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end catch
	
	--If data and log directories were specified, set the move statement to use those directories
	if @data_directory is not null and @log_directory is not null
	begin

		if RIGHT(@data_directory,1) = '\'
			set @data_directory = LEFT(@data_directory, len(@data_directory)-1)
		if RIGHT(@log_directory,1) = '\'
			set @log_directory = LEFT(@log_directory, len(@log_directory)-1)
			
		declare source_files cursor for
			select FileID, LogicalName, FileGroupID from ##primary_dbfiles

		open source_files
		fetch next from source_files into @file_id, @file_name, @group_id
		while @@fetch_status = 0
		begin
		
			if @group_id = 0
				set @file_path = @log_directory + '\' + REPLACE(@file_name,@db_name,@db_name) + '.ldf'
			else if @group_id = 1
				set @file_path = @data_directory + '\' + REPLACE(@file_name,@db_name,@db_name) + '.mdf'
			else 
				set @file_path = @data_directory + '\' + REPLACE(@file_name,@db_name,@db_name) + '.ndf'
				
			set @move_statement = @move_statement + 'move ''' + @file_name + ''' to ''' + @file_path + ''', '
			
			fetch next from source_files into @file_id, @file_name, @group_id
		end
		close source_files
		deallocate source_files		
	
	end
	--Else if the dest DB does not exist or is in an unreadable state, generate the move statement from the instance defaults
	else if not exists (select name from master.sys.databases where name = @db_name and state in (0,1) )
	begin
		print '--> ' + @db_name + ' does not exist or is inaccessible, generating filenames from instance default file locations.'
		
		if cast(serverproperty('ProductVersion') as nvarchar) like '10.0%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL10.' + @@SERVICENAME + '\\MSSQLServer'
		else if cast(serverproperty('ProductVersion') as nvarchar) like '10.5%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL10_50.' + @@SERVICENAME + '\\MSSQLServer'
		else if cast(serverproperty('ProductVersion') as nvarchar) like '11.0%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL11.' + @@SERVICENAME + '\\MSSQLServer'
		else if cast(serverproperty('ProductVersion') as nvarchar) like '12.0%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL12.' + @@SERVICENAME + '\\MSSQLServer'
		else if cast(serverproperty('ProductVersion') as nvarchar) like '13.0%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL13.' + @@SERVICENAME + '\\MSSQLServer'
		
		--Retrieve the data directory from the registry. If that fails, use model
		exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', @regpath, N'DefaultData', @data_directory output
		if @data_directory is null
			select @data_directory = LEFT(filename, LEN(filename) - CHARINDEX('\', REVERSE(filename))) from model.dbo.sysfiles where groupid = 1
			
		--Retrieve the log directory from the registry. If that fails, use model
		exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', @regpath, N'DefaultLog', @log_directory output
		if @log_directory is null
			select @log_directory = LEFT(filename, LEN(filename) - CHARINDEX('\', REVERSE(filename))) from model.dbo.sysfiles where groupid = 0

		declare source_files cursor for
			select FileID, LogicalName, FileGroupID from ##primary_dbfiles

		open source_files
		fetch next from source_files into @file_id, @file_name, @group_id
		while @@fetch_status = 0
		begin
		
			if @group_id = 0
				set @file_path = @log_directory + '\' + REPLACE(@file_name,@db_name,@db_name) + '.ldf'
			else if @group_id = 1
				set @file_path = @data_directory + '\' + REPLACE(@file_name,@db_name,@db_name) + '.mdf'
			else 
				set @file_path = @data_directory + '\' + REPLACE(@file_name,@db_name,@db_name) + '.ndf'
				
			set @move_statement = @move_statement + 'move ''' + @file_name + ''' to ''' + @file_path + ''', '
			
			fetch next from source_files into @file_id, @file_name, @group_id
		end
		close source_files
		deallocate source_files		
			
	end
	--Else if the dest DB does exist, generate the move statement from the existing DB.
	--Skip this step if we're debugging or skipping the full backup
	else if @skip_full_backup = 0 and @debug = 0
	begin
	
		--If the mirrored database exists, but is still in recovery from a previous mirroring session,
		--restore it so that we can read the file information
		if exists (select name from master.sys.databases where name = @db_name and state = 1 )
		begin
		
			set @cmd = 'restore database [' + @db_name + '] with recovery'
			exec(@cmd)
		
		end
			
		if object_id('tempdb..##mirror_dbfiles') is not null
			drop table ##mirror_dbfiles;

		set @cmd = 'select name, filename, groupid into ##mirror_dbfiles from [' + @db_name + '].dbo.sysfiles'
		exec (@cmd)
	
		if exists(select sf.LogicalName, sf.FileGroupID from ##primary_dbfiles sf where not exists (select df.name, df.groupid from ##mirror_dbfiles df where df.name collate database_default = sf.LogicalName collate database_default and df.groupid = sf.FileGroupID))
		begin
			print '--> ' + @db_name + ' file definitions do not match ' + @db_name + ', generating ambiguous filenames from existing files in ' + @db_name + '.'

			
			declare source_files cursor for
				select FileID, LogicalName, FileGroupID from ##primary_dbfiles

			open source_files
			fetch next from source_files into @file_id, @file_name, @group_id
			while @@fetch_status = 0
			begin
			
				if @group_id = 0
					set @file_suffix = '.ldf'
				else if @group_id = 1
					set @file_suffix = '.mdf'
				else 
					set @file_suffix = '.ndf'
					
				select @file_path=LEFT(filename, LEN(filename) - CHARINDEX('\', REVERSE(filename))+1) + REPLACE(@file_name,@db_name,@db_name) + @file_suffix from ##mirror_dbfiles where groupid = @group_id
				set @move_statement = @move_statement + 'move ''' + @file_name + ''' to ''' + @file_path + ''', '
				
				fetch next from source_files into @file_id, @file_name, @group_id
			end
			close source_files
			deallocate source_files		
					
		end
	end
	
	--Kill any processes using the database
	declare active_procs cursor for
		select spid from master.dbo.sysprocesses 
		 where db_name(dbid) = @db_name and 
		       loginame not like '%\svc%' and 
		       loginame <> 'sa'
	open active_procs
	fetch next from active_procs into @active_spid
	while @@fetch_status = 0
	begin
		print '--> Killing active processes in database ' + @db_name
		set @cmd = 'kill ' + cast(@active_spid as nvarchar)
		if @debug = 0
			exec (@cmd)
		else
			print @cmd

		fetch next from active_procs into @active_spid
	end
	close active_procs
	deallocate active_procs

	if @skip_full_backup = 0
	begin
	
		--Execute the full restore			
		print '--> Restoring ' + @db_name + ' using full backup'
		set @cmd = 'restore database [' + @db_name + '] from disk=''' + @full_path + ''' with ' + @move_statement + 'stats=10, replace, norecovery'
		if @debug = 0
			exec (@cmd)
		else
			print @cmd

	end
	
	--Get the date & filename of the most recent differential backup
	if object_id('tempdb..##primary_dbdiffinfo') is not null
		drop table ##primary_dbdiffinfo;

	set @cmd = 'select top 1 backup_start_date, physical_device_name into ##primary_dbdiffinfo from [ls_primary_instance].msdb.dbo.backupset bs, [ls_primary_instance].msdb.dbo.backupmediafamily bf where database_name = ''' + @db_name + ''' and type = ''I'' and bf.media_set_id = bs.media_set_id order by backup_start_date desc'
	exec (@cmd)

	select @diff_date=backup_start_date, @diff_path=physical_device_name 
	from   ##primary_dbdiffinfo

	--Convert the file path to UNC if required
	if @diff_path is not null
	begin
		if SUBSTRING(@diff_path,2,1) = ':'
			set @diff_path = '\\' + @source_server + '\' + LEFT(@diff_path,1) + '$' + RIGHT(@diff_path,LEN(@diff_path)-2)
	end
		
	if @skip_diff_backup = 0
	begin
	
		--Execute the differential restore, if appropriate
		if @diff_date is not null and @diff_date > @full_date
		begin
			print '--> Restoring ' + @db_name + ' using differential backup'
			set @cmd = 'restore database [' + @db_name + '] from disk=''' + @diff_path + ''' with stats=10, norecovery'
			if @debug = 0
				exec (@cmd)
			else
				print @cmd
		end
		
	end
	
	--Execute the log file restores
	print '--> Restoring ' + @db_name + ' using log backup(s)'

	--Get the date & filenames of all the log backups after the full or differential backups but prior to the start date
	if @diff_date is null or @diff_date < @full_date
		set @log_start_date = @full_date
	else
		set @log_start_date = @diff_date
		
	if object_id('tempdb..##primary_dbloginfo') is not null
		drop table ##primary_dbloginfo;
			
	set @cmd = 'select top 1 physical_device_name, last_lsn into ##primary_dbloginfo from [ls_primary_instance].msdb.dbo.backupset bs, [ls_primary_instance].msdb.dbo.backupmediafamily bf where database_name = ''' + @db_name + ''' and backup_start_date > ''' + convert(nvarchar,@log_start_date,121) + ''' and type = ''L'' and bf.media_set_id = bs.media_set_id order by backup_start_date asc'
	exec (@cmd)
	
	while exists (select * from ##primary_dbloginfo)
	begin
	
		select @log_path=physical_device_name, @log_last_lsn=last_lsn from ##primary_dbloginfo
	
		--Convert the file path to UNC if required, or to the @backup_directory location if specified
		if SUBSTRING(@log_path,2,1) = ':'
			set @log_path = '\\' + @source_server + '\' + LEFT(@log_path,1) + '$' + RIGHT(@log_path,LEN(@log_path)-2)
	
		set @cmd = 'restore database [' + @db_name + '] from disk=''' + @log_path + ''' with norecovery'
		
		--Wrap this in a try/catch block because errors are expected due to including unnecessary log files
		begin try
			if @debug = 0
				exec (@cmd)
			else
				print @cmd
		end try
		begin catch		
		end catch
		
		delete from ##primary_dbloginfo
		
		set @cmd = 'insert into ##primary_dbloginfo select top 1 physical_device_name, last_lsn from [ls_primary_instance].msdb.dbo.backupset bs, [ls_primary_instance].msdb.dbo.backupmediafamily bf where database_name = ''' + @db_name + ''' and first_lsn = ''' + CAST(@log_last_lsn as nvarchar) + ''' and last_lsn <> ''' + CAST(@log_last_lsn as nvarchar) + ''' and type = ''L'' and bf.media_set_id = bs.media_set_id order by backup_start_date asc'
		exec (@cmd)
		
	end
	
	print '--> Restore process is complete'

	print '--> Configuring database mirroring'
	set @cmd = 'ALTER DATABASE [' + @db_name + '] SET PARTNER = ''TCP://' + @primary_host + '.' + @primary_domain + ':' + @primary_port + ''''
	
	if @debug = 0
		exec (@cmd)
	else
		print @cmd
	
	set @cmd = 'ALTER DATABASE [' + @db_name + '] SET PARTNER = ''TCP://' + @mirror_host + '.' + @mirror_domain + ':' + @mirror_port + ''''
	
	if @debug = 0
		exec (@cmd) at ls_primary_instance
	else
		print @cmd	
		
	set @cmd = 'ALTER DATABASE [' + @db_name + '] SET SAFETY OFF'
	
	if @debug = 0
		exec (@cmd) at ls_primary_instance
	else
		print @cmd	
		
	cleanup:
	--Cleanup the temporary linked server and any temp tables created
	if exists ( select srvid from master.sys.sysservers where srvid != 0 and srvname = 'ls_primary_instance')
		exec master.dbo.sp_dropserver @server='ls_primary_instance', @droplogins='droplogins'

	if object_id('tempdb..##primary_endpoint') is not null
		drop table ##primary_endpoint;
	if object_id('tempdb..##primary_dbinfo') is not null
		drop table ##primary_dbinfo;
	if object_id('tempdb..##primary_dbfullinfo') is not null
		drop table ##primary_dbfullinfo;
	if object_id('tempdb..##primary_dbdiffinfo') is not null
		drop table ##primary_dbdiffinfo;
	if object_id('tempdb..##primary_dbloginfo') is not null
		drop table ##primary_dbloginfo;
	if object_id('tempdb..##primary_dbfiles') is not null
		drop table ##primary_dbfiles;
	if object_id('tempdb..##mirror_dbfiles') is not null
		drop table ##mirror_dbfiles;		
		
end
GO
/****** Object:  StoredProcedure [dbo].[sp_refresh_stats]    Script Date: 10/19/2022 1:46:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc [dbo].[sp_refresh_stats]
(
 @dbname sysname = 'all_dbs' 
)
as
begin

set nocount on

declare @tick char(1)
set @tick = char(39)

declare @db_name sysname
declare @cmd varchar(5120)

create table #eligible_dbs (name sysname)

if @dbname = 'all_dbs'
	insert into #eligible_dbs select name from master.sys.databases where lower(name) not in ('master', 'msdb', 'tempdb', 'model') and state = 0 and is_read_only = 0 and dbutils.dbo.fn_dbReplicaState(name) in ('NONE', 'PRIMARY') and not exists (select db_name from dbutils.dbo.maintenance_exclusions where upper(db_name) collate database_default = upper(name) and exclude_stats = 1) 
else
	insert into #eligible_dbs select name from master.sys.databases where lower(name) = lower(@dbname) and state = 0 and is_read_only = 0 and dbutils.dbo.fn_dbReplicaState(name) in ('NONE', 'PRIMARY') 

declare eligible_dbs cursor for 
	select name from #eligible_dbs order by name	

open eligible_dbs

fetch next from eligible_dbs into @db_name

while (@@fetch_status = 0)
begin

	set @cmd = 'use [' + @db_name + ']; exec sp_updatestats ''resample'';'

	print '---------------------------------------------'
	print 'Updating statistics on database [' + @db_name + ']'
	print '---------------------------------------------'
	exec (@cmd)

	fetch next from eligible_dbs into @db_name

end


close eligible_dbs
deallocate eligible_dbs

dbcc freeproccache 
end
GO
/****** Object:  StoredProcedure [dbo].[sp_restore_db]    Script Date: 10/19/2022 1:46:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc [dbo].[sp_restore_db]( @source_instance nvarchar(128) = null, 
								   @source_db nvarchar(128), 
								   @dest_db nvarchar(128) = null, 
								   @skip_logs bit = 0,
								   @restore_date datetime = null, 
								   @backup_directory nvarchar(512) = null,
								   @data_directory nvarchar(512) = null,
								   @log_directory nvarchar(512) = null,
								   @skip_kerb_check bit = 0,
								   @debug bit = 0 )
as
begin

	set nocount on

	declare @sql_version nvarchar(max)
	set @sql_version = CAST(SERVERPROPERTY('ProductVersion') as nvarchar)
	set @sql_version = left(@sql_version,charindex('.',@sql_version)-1)
	
	declare @source_server nvarchar(max)
	declare @recovery_model nvarchar(max)
	
	declare @auth_scheme nvarchar(40)
	declare @client_net_address varchar(48)
	declare @local_net_address varchar(48)

	declare @full_date datetime
	declare @full_path nvarchar(max)
	declare @diff_date datetime
	declare @diff_path nvarchar(max)
	declare @log_start_date datetime
	declare @log_end_date datetime
	declare @log_path nvarchar(max)
	
	declare @move_statement nvarchar(max)
	declare @file_id int
	declare @file_name nvarchar(max)
	declare @group_id int
	declare @file_path nvarchar(max)
	declare @file_suffix nvarchar(4)
	declare @regpath nvarchar(512)

	declare @active_spid int
	declare @username sysname

	declare @cmd nvarchar(max)
	declare @msg nvarchar(max)

	--Check and prepare procedure parameters
	if @source_instance is null
		set @source_instance = @@SERVERNAME
	else
		set @source_instance = UPPER(@source_instance)
		
	if @restore_date is null
		set @restore_date = GETDATE()
		
	if CHARINDEX('\',@source_instance) = 0 
		set @source_server = @source_instance
	else
		set @source_server = LEFT(@source_instance,CHARINDEX('\',@source_instance)-1)

	if @backup_directory is not null
		if RIGHT(@backup_directory,1) <> '\'
			set @backup_directory = @backup_directory + '\'
			
	if @data_directory is not null and @log_directory is null
	begin
		set @msg = '@log_directory not provided. You must provide a value for @log_directory when @data_directory is specified.'  
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end

	if @data_directory is null and @log_directory is not null
	begin
		set @msg = '@data_directory not provided. You must provide a value for @data_directory when @log_directory is specified.'  
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end
		
	--Check to see if the remote queries will require multiple hops. If they do, and we're not using Kerberos, return an error
	select @auth_scheme=auth_scheme, @client_net_address=client_net_address, @local_net_address=local_net_address from master.sys.dm_exec_connections where session_id=@@spid
	
	if @skip_kerb_check = 0 and @auth_scheme = 'NTLM' and @client_net_address <> '<local machine>' and @source_instance <> @@SERVERNAME and @client_net_address <> @local_net_address
	begin
		set @msg = 'This operation requires multi-hop authentication and this session is not using Kerberos authentication. Execute this command locally on ' + @@SERVERNAME + ' or configure ' + @@SERVERNAME + ' to use Kerberos authentication.'
		raiserror(@msg, 16, 1 )
		goto cleanup
	end	

	--Set the source and dest database names to the correct case
	if object_id('tempdb..#rdbname') is not null
		drop table #rdbname;

	create table #rdbname (database_name sysname)

	set @cmd = 'select database_name from OPENROWSET(''SQLNCLI'', ''Server=' + @source_instance + ';Trusted_Connection=yes;'', ''select database_name from msdb.dbo.backupset where lower(database_name) = lower(''''' + @source_db + ''''')'')'
	
	begin try
		insert into #rdbname exec (@cmd)
	end try
	begin catch
		set @msg = 'Error retrieving data from [' + @source_instance + ']: ' + ERROR_MESSAGE()
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end catch

	--If nothing exists in the backupset table on the remote instance, we can't continue the restore
	if not exists(select database_name from #rdbname)
	begin
		set @msg = 'No backup records exist for ' + @source_db + ' on instance ' + @source_instance
		raiserror(@msg, 16, 1 )
		goto cleanup
	end
	
	select @source_db=database_name from #rdbname

	if @dest_db is null 
		set @dest_db = @source_db
	else		
		select @dest_db = name from master.sys.databases where lower(name) = lower(@dest_db)
			
	--Capture the current recovery model of the destination database, use model if it doesn't exist
	if exists (select name from master.sys.databases where name = @dest_db)
		select @recovery_model=recovery_model_desc from master.sys.databases where name = @dest_db
	else
		select @recovery_model=recovery_model_desc from master.sys.databases where name = 'model'
		
	--Get the date & filename of the most recent full backup prior to the start date
	if object_id('tempdb..#rdbfullinfo') is not null
		drop table #rdbfullinfo;

	create table #rdbfullinfo (backup_start_date datetime, physical_device_name nvarchar(260))

	set @cmd = 'select * from OPENROWSET(''SQLNCLI'', ''Server=' + @source_instance + ';Trusted_Connection=yes;'', ''select top 1 backup_start_date, physical_device_name from msdb.dbo.backupset bs, msdb.dbo.backupmediafamily bf where database_name = ''''' + @source_db + ''''' and backup_start_date < ''''' + convert(nvarchar,@restore_date,121) + ''''' and type = ''''D'''' and is_copy_only = 0 and bf.media_set_id = bs.media_set_id order by backup_start_date desc'')'

	begin try
		insert into #rdbfullinfo exec (@cmd)
	end try
	begin catch
		set @msg = 'Error retrieving data from [' + @source_instance + ']: ' + ERROR_MESSAGE()
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end catch

	select @full_date=backup_start_date, @full_path=physical_device_name 
	from   #rdbfullinfo

	--Get the date & filename of the most recent differential backup prior to the start date
	if object_id('tempdb..#rdbdiffinfo') is not null
		drop table #rdbdiffinfo;

	create table #rdbdiffinfo (backup_start_date datetime, physical_device_name nvarchar(260))

	set @cmd = 'select * from OPENROWSET(''SQLNCLI'', ''Server=' + @source_instance + ';Trusted_Connection=yes;'', ''select top 1 backup_start_date, physical_device_name from msdb.dbo.backupset bs, msdb.dbo.backupmediafamily bf where database_name = ''''' + @source_db + ''''' and backup_start_date < ''''' + convert(nvarchar,@restore_date,121) + ''''' and type = ''''I'''' and is_copy_only = 0 and bf.media_set_id = bs.media_set_id order by backup_start_date desc'')'

	begin try
		insert into #rdbdiffinfo exec (@cmd)
	end try
	begin catch
		set @msg = 'Error retrieving data from [' + @source_instance + ']: ' + ERROR_MESSAGE()
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end catch

	select @diff_date=backup_start_date, @diff_path=physical_device_name 
	from   #rdbdiffinfo

	--Get the date & filenames of all the log backups after the full or differential backups but prior to the start date
	if @diff_date is null or @diff_date < @full_date
		set @log_start_date = @full_date
	else
		set @log_start_date = @diff_date
		
	--Add a 2 hour buffer to the start and end dates for the log backups. This will ensure that our select returns
	--all the necessary log backups, and the restore commands will ignore any they don't need.
	set @log_start_date = DATEADD(hh,-2,@log_start_date)
	set @log_end_date = DATEADD(hh,2,@restore_date)
	
	if object_id('tempdb..#rdbloginfo') is not null
		drop table #rdbloginfo;

	create table #rdbloginfo (backup_start_date datetime, physical_device_name nvarchar(260))

	set @cmd = 'select * from OPENROWSET(''SQLNCLI'', ''Server=' + @source_instance + ';Trusted_Connection=yes;'', ''select backup_start_date, physical_device_name from msdb.dbo.backupset bs, msdb.dbo.backupmediafamily bf where database_name = ''''' + @source_db + ''''' and backup_start_date between ''''' + convert(nvarchar,@log_start_date,121) + ''''' and ''''' + convert(nvarchar,@log_end_date,121) + ''''' and type = ''''L'''' and is_copy_only = 0 and bf.media_set_id = bs.media_set_id order by backup_start_date asc'')'

	begin try
		insert into #rdbloginfo exec (@cmd)
	end try
	begin catch
		set @msg = 'Error retrieving data from [' + @source_instance + ']: ' + ERROR_MESSAGE()
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end catch

	--Terminate the procedure if no full backup was found
	if @full_date is null
	begin
		set @msg = 'No full backup found for database ' + @source_db + ' on instance ' + @source_instance + ' prior to ' + convert(nvarchar,@restore_date,121)
		raiserror(@msg, 16, 1 )
		goto cleanup
	end

	--Convert the file paths to UNC if required, or to the @backup_directory location if specified
	if @backup_directory is not null
		set @full_path = @backup_directory + RIGHT(@full_path,CHARINDEX('\',REVERSE(@full_path))-1)
	else if SUBSTRING(@full_path,2,1) = ':'
		set @full_path = '\\' + @source_server + '\' + LEFT(@full_path,1) + '$' + RIGHT(@full_path,LEN(@full_path)-2)

	if @diff_path is not null
	begin
		if @backup_directory is not null
			set @diff_path = @backup_directory + RIGHT(@diff_path,CHARINDEX('\',REVERSE(@diff_path))-1)
		else if SUBSTRING(@diff_path,2,1) = ':'
			set @diff_path = '\\' + @source_server + '\' + LEFT(@diff_path,1) + '$' + RIGHT(@diff_path,LEN(@diff_path)-2)
	end

	--If the destination database does not already exist, or the logical file names don't match the source, generate a move statement
	set @move_statement = ''
	
	if object_id('tempdb..#sdbfiles') is not null
		drop table #sdbfiles;
		
	create table #sdbfiles (LogicalName nvarchar(128), PhysicalName nvarchar(260), [Type] char(1), FileGroupName nvarchar(128), Size numeric(20,0), MaxSize numeric(20,0), FileID bigint, CreateLSN numeric(25,0), DropLSN numeric(25,0) NULL, UniqueID uniqueidentifier, ReadOnlyLSN numeric(25,0) NULL, ReadWriteLSN numeric(25,0) NULL, BackupSizeInBytes bigint, SourceBlockSize int, FileGroupID int, LogGroupGUID uniqueidentifier NULL, DifferentialBaseLSN numeric(25,0) NULL, DifferentialBaseGUID uniqueidentifier, IsReadOnly bit, IsPresent bit)

	if cast(@sql_version as int) >= 10
		alter table #sdbfiles add TDEThumbprint varbinary(32)
	if cast(@sql_version as int) >= 13
		alter table #sdbfiles add SnapshotURL nvarchar(360)
	
	begin try
		set @cmd = 'restore filelistonly from disk = ''' + @full_path + ''''
		insert into #sdbfiles exec (@cmd)
	end try
	begin catch
		set @msg = 'Unable to read file ''' + @full_path + ''', make sure that the file exists and that the service account has read access.'
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end catch
	
	if @data_directory is not null and @log_directory is not null
	begin

		if RIGHT(@data_directory,1) = '\'
			set @data_directory = LEFT(@data_directory, len(@data_directory)-1)
		if RIGHT(@log_directory,1) = '\'
			set @log_directory = LEFT(@log_directory, len(@log_directory)-1)
			
		declare source_files cursor for
			select FileID, LogicalName, FileGroupID from #sdbfiles

		open source_files
		fetch next from source_files into @file_id, @file_name, @group_id
		while @@fetch_status = 0
		begin
		
			if @group_id = 0
				set @file_path = @log_directory + '\' + REPLACE(@file_name,@source_db,@dest_db) + '.ldf'
			else if @group_id = 1
				set @file_path = @data_directory + '\' + REPLACE(@file_name,@source_db,@dest_db) + '.mdf'
			else 
				set @file_path = @data_directory + '\' + REPLACE(@file_name,@source_db,@dest_db) + '.ndf'
				
			set @move_statement = @move_statement + 'move ''' + @file_name + ''' to ''' + @file_path + ''', '
			
			fetch next from source_files into @file_id, @file_name, @group_id
		end
		close source_files
		deallocate source_files		
	
	end
	else if not exists (select name from master.sys.databases where name = @dest_db)
	begin
		print '--> ' + @dest_db + ' does not exist, generating filenames from instance default file locations.'
		
		if cast(serverproperty('ProductVersion') as nvarchar) like '10.0%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL10.' + @@SERVICENAME + '\\MSSQLServer'
		else if cast(serverproperty('ProductVersion') as nvarchar) like '10.5%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL10_50.' + @@SERVICENAME + '\\MSSQLServer'
		else if cast(serverproperty('ProductVersion') as nvarchar) like '11.0%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL11.' + @@SERVICENAME + '\\MSSQLServer'
		else if cast(serverproperty('ProductVersion') as nvarchar) like '12.0%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL12.' + @@SERVICENAME + '\\MSSQLServer'
		else if cast(serverproperty('ProductVersion') as nvarchar) like '13.0%'
			set @regpath = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL13.' + @@SERVICENAME + '\\MSSQLServer'
					
		
		--Retrieve the data directory from the registry. If that fails, use an existing UserDB Data file location
		exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', @regpath, N'DefaultData', @data_directory output
		if @data_directory is null
			select top 1 @data_directory = LEFT(physical_name, LEN(physical_name) - CHARINDEX('\', REVERSE(physical_name))) from sys.master_files where type_desc = 'ROWS' and database_id not in ('0','1','2','3','4')

			
		--Retrieve the log directory from the registry. If that fails, use an existing UserDB Data file location
		exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', @regpath, N'DefaultLog', @log_directory output
		if @log_directory is null
			select top 1 @log_directory = LEFT(physical_name, LEN(physical_name) - CHARINDEX('\', REVERSE(physical_name))) from sys.master_files where type_desc = 'LOG' and database_id not in ('0','1','2','3','4')

		declare source_files cursor for
			select FileID, LogicalName, FileGroupID from #sdbfiles

		open source_files
		fetch next from source_files into @file_id, @file_name, @group_id
		while @@fetch_status = 0
		begin
		
			if @group_id = 0
				set @file_path = @log_directory + '\' + REPLACE(@file_name,@source_db,@dest_db) + '.ldf'
			else if @group_id = 1
				set @file_path = @data_directory + '\' + REPLACE(@file_name,@source_db,@dest_db) + '.mdf'
			else 
				set @file_path = @data_directory + '\' + REPLACE(@file_name,@source_db,@dest_db) + '.ndf'
				
			set @move_statement = @move_statement + 'move ''' + @file_name + ''' to ''' + @file_path + ''', '
			
			fetch next from source_files into @file_id, @file_name, @group_id
		end
		close source_files
		deallocate source_files		
			
	end
	else 
	begin
	
		if object_id('tempdb..#ddbfiles') is not null
			drop table #ddbfiles;

		create table #ddbfiles (name sysname, filename nvarchar(260), groupid smallint)

		set @cmd = 'select name, filename, groupid from [' + @dest_db + '].dbo.sysfiles'
		insert into #ddbfiles exec (@cmd)
	
		if exists(select sf.LogicalName, sf.FileGroupID from #sdbfiles sf where not exists (select df.name, df.groupid from #ddbfiles df where df.name = sf.LogicalName and df.groupid = sf.FileGroupID))
		begin
			print '--> ' + @dest_db + ' file definitions do not match ' + @source_db + ', generating ambiguous filenames from existing files in ' + @dest_db + '.'

			
			declare source_files cursor for
				select FileID, LogicalName, FileGroupID from #sdbfiles

			open source_files
			fetch next from source_files into @file_id, @file_name, @group_id
			while @@fetch_status = 0
			begin
			
				if @group_id = 0
					set @file_suffix = '.ldf'
				else if @group_id = 1
					set @file_suffix = '.mdf'
				else 
					set @file_suffix = '.ndf'
					
				select @file_path=LEFT(filename, LEN(filename) - CHARINDEX('\', REVERSE(filename))+1) + REPLACE(@file_name,@source_db,@dest_db) + @file_suffix from #ddbfiles where groupid = @group_id
				set @move_statement = @move_statement + 'move ''' + @file_name + ''' to ''' + @file_path + ''', '
				
				fetch next from source_files into @file_id, @file_name, @group_id
			end
			close source_files
			deallocate source_files		
					
		end
	end

	--Kill any processes using the database
	declare active_procs cursor for
		select spid from master.dbo.sysprocesses 
		 where db_name(dbid) = @dest_db and 
		       loginame not like '%\svc%' and 
		       loginame <> 'sa'
	open active_procs
	fetch next from active_procs into @active_spid
	while @@fetch_status = 0
	begin
		print '--> Killing active processes in database ' + @dest_db
		set @cmd = 'kill ' + cast(@active_spid as nvarchar)
		if @debug = 0
			exec (@cmd)
		else
			print @cmd

		fetch next from active_procs into @active_spid
	end
	close active_procs
	deallocate active_procs


	--Execute the full restore			
	print '--> Restoring ' + @dest_db + ' using full backup'
	set @cmd = 'restore database [' + @dest_db + '] from disk=''' + @full_path + ''' with ' + @move_statement + 'stats=10, replace, norecovery'
	if @debug = 0
		exec (@cmd)
	else
		print @cmd

	--Execute the differential restore, if appropriate
	if @diff_date is not null and @diff_date > @full_date
	begin
		print '--> Restoring ' + @dest_db + ' using differential backup'
		set @cmd = 'restore database [' + @dest_db + '] from disk=''' + @diff_path + ''' with stats=10, norecovery'
		if @debug = 0
			exec (@cmd)
		else
			print @cmd
	end

	--Execute the log file restores, if appropriate
	if @skip_logs = 0
	begin
		print '--> Restoring ' + @dest_db + ' using log backup(s)'
		
		declare log_backups cursor for
			select physical_device_name from #rdbloginfo order by backup_start_date asc

		open log_backups
		fetch next from log_backups into @log_path
		while @@fetch_status = 0
		begin
		
			--Convert the file path to UNC if required, or to the @backup_directory location if specified
			if @backup_directory is not null
				set @log_path = @backup_directory + RIGHT(@log_path,CHARINDEX('\',REVERSE(@log_path))-1)
			else if SUBSTRING(@log_path,2,1) = ':'
				set @log_path = '\\' + @source_server + '\' + LEFT(@log_path,1) + '$' + RIGHT(@log_path,LEN(@log_path)-2)
		
			set @cmd = 'restore database [' + @dest_db + '] from disk=''' + @log_path + ''' with stopat = ''' + convert(nvarchar,@restore_date,121) + ''', norecovery'
			
			--Wrap this in a try/catch block because errors are expected due to including unnecessary log files
			begin try
				if @debug = 0
					exec (@cmd)
				else
					print @cmd
			end try
			begin catch		
			end catch
			
			fetch next from log_backups into @log_path
		end
		close log_backups
		deallocate log_backups	
	end
	
	--Recover the restored database
	print '--> Recovering ' + @dest_db
	set @cmd = 'restore database [' + @dest_db + '] with recovery'
	if @debug = 0
		exec (@cmd)
	else
		print @cmd
	
	--Set database options
	print '--> Resetting database options on ' + @dest_db
	set @cmd = 'alter database [' + @dest_db + '] set recovery ' + @recovery_model + ' with no_wait'
	if @debug = 0
		exec (@cmd)
	else
		print @cmd

	set @cmd = 'use [' + @dest_db + ']; exec dbo.sp_changedbowner @loginame = ''sa'', @map = false;'
	if @debug = 0
		exec (@cmd)
	else
		print @cmd

	--Remap orphaned users
	if @debug = 0
	begin
	
		if object_id('tempdb..#userlist') is not null
			drop table #userlist;

		create table #userlist (name sysname)

		set @cmd = 'select name from [' + @dest_db + '].dbo.sysusers where issqluser = 1 and name not in (''dbo'', ''sys'', ''guest'', ''information_schema'')'
		insert into #userlist exec (@cmd)

		declare user_update_cursor cursor for
			select name from #userlist

		open user_update_cursor
		fetch next from user_update_cursor into @username
		while @@fetch_status = 0
		begin
			if exists (select name from master.dbo.syslogins where name = @username)
			begin
				print '--> Remapping user [' + @username + '] to matching login'
				set @cmd = 'use [' + @dest_db + ']; alter user [' + @username + '] with login = [' + @username + '];'
				if @debug = 0
					exec (@cmd)
				else
					print @cmd
			end
			fetch next from user_update_cursor into @username
		end
		close user_update_cursor
		deallocate user_update_cursor

	end
	
	print '--> Restore process is complete'
	
	cleanup:

	if object_id('tempdb..#rdbname') is not null
		drop table #rdbname;
	if object_id('tempdb..#rdbfullinfo') is not null
		drop table #rdbfullinfo;
	if object_id('tempdb..#rdbdiffinfo') is not null
		drop table #rdbdiffinfo;
	if object_id('tempdb..#rdbloginfo') is not null
		drop table #rdbloginfo;
	if object_id('tempdb..#sdbfiles') is not null
		drop table #sdbfiles;
	if object_id('tempdb..#ddbfiles') is not null
		drop table #ddbfiles;		
	if object_id('tempdb..#userlist') is not null
		drop table #userlist;
		
end










GO
/****** Object:  StoredProcedure [dbo].[sp_RethrowError]    Script Date: 10/19/2022 1:46:32 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Create the stored procedure to generate an error using 
-- RAISERROR. The original error information is used to
-- construct the msg_str for RAISERROR.
CREATE PROCEDURE [dbo].[sp_RethrowError] AS
    -- Return if there is no error information to retrieve.
    IF ERROR_NUMBER() IS NULL
        RETURN;

    DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);

    -- Assign variables to error-handling functions that 
    -- capture information for RAISERROR.
    SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

    -- Build the message string that will contain original
    -- error information.
    SELECT @ErrorMessage = 
        N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 
            'Message: '+ ERROR_MESSAGE();

    -- Raise an error: msg_str parameter of RAISERROR will contain
    -- the original error information.
	IF @ErrorSeverity > 18
		RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        ) WITH LOG;
	ELSE
		RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );
GO
/****** Object:  StoredProcedure [dbo].[sp_WriteStringToFile]    Script Date: 10/19/2022 1:46:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_WriteStringToFile] (
	@FileName NVARCHAR(255),
	@String NVARCHAR(max),
	@InitFile BIT = 0)
AS

DECLARE @objFileSystem INT
DECLARE @objTextStream INT
DECLARE @Command NVARCHAR(1000)
DECLARE @HR INT

set nocount on

SET @String = @String + Char(13) + Char(10)

EXECUTE @HR = sp_OACreate 'Scripting.FileSystemObject', @objFileSystem OUT

IF @HR <> 0
	RAISERROR ('Unable to create FileSystemObject, result code %d',16,1,@HR)

IF @InitFile = 1 
	EXECUTE @HR = sp_OAMethod @objFileSystem, 'OpenTextFile', @objTextStream OUT, @FileName, 2, True
ELSE
	EXECUTE @HR = sp_OAMethod @objFileSystem, 'OpenTextFile', @objTextStream OUT, @FileName, 8, True

IF @HR <> 0
	RAISERROR ('Unable to open specified file, result code %d',16,1,@HR)

EXECUTE @HR = sp_OAMethod @objTextStream, 'Write', Null, @String

IF @HR <> 0
	RAISERROR ('Unable to write to specified file, result code %d',16,1,@HR)

EXECUTE @HR = sp_OAMethod @objTextStream, 'Close'

IF @HR <> 0
	RAISERROR ('Unable to close specified file, result code %d',16,1,@HR)

EXECUTE sp_OADestroy @objTextStream
EXECUTE sp_OADestroy @objTextStream
GO

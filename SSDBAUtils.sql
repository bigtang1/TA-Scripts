USE [SSDBAUtils]
GO
/****** Object:  StoredProcedure [dbo].[pApplySecurity]    Script Date: 10/19/2022 1:44:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[pApplySecurity]
@Version int = 0,
@Action varchar(2) = 'LI',
@Instance nvarchar(100) = null,
@SourceDatabaseName nvarchar(100) = null,
@TargetDatabaseName nvarchar(100) = null,
@SecurityBasePath nvarchar(256) = null
as

declare @rc int
if @Instance is null or @SourceDatabaseName is null 
	begin
		print 'Usage: dbo.pApplySecurity @Version (Req''d, Def = 0), @Action (Req''d, Def = LI), @Instance (Req''d), @SourceDatabaseName (Req''d), @TargetDatabaseName (Def = @SourceDatabaseName)'
		print ''
		print '         Examples: dbo.pApplySecurity  0, ''LI'', ''SERVER\INSTANCE'', ''database_1''					-- [LI]sts the security scripts for database_1'
		print '                   dbo.pApplySecurity  0, ''A'',  ''SERVER\INSTANCE'', ''database_1''					-- Use database_1 security scripts and [A]pply to database_1'
		print '                   dbo.pApplySecurity  0, ''A'',  ''SERVER\INSTANCE'', ''database_1'', ''database_2''	-- Use database_1 security scripts and [A]pply to database_2'
		print '                   dbo.pApplySecurity -3, ''A'',  ''SERVER\INSTANCE'', ''database_1'', ''database_2''	-- Use database_1 security scripts and [A]pply to database_2 minus [3] versions'
		print '                   dbo.pApplySecurity  0, ''D'',  ''SERVER\INSTANCE'', ''database_1'', ''database_2''	-- Use database_1 security scripts and [D]rop from database_2'
		print '                   dbo.pApplySecurity  0, ''DA'', ''SERVER\INSTANCE'', ''database_1'', ''database_2''	-- Use database_1 security scripts and [D]rop from database_2 and [A]pply to database_2'
		print '                   dbo.pApplySecurity  0, ''DA'', ''SERVER\INSTANCE'', ''database_1''					-- Use database_1 security scripts and [D]rop from database_1 and [A]pply to database_1'
		print ''
		return;
	end

set nocount on

if @Action not in ('A', 'LI', 'D', 'DA')
	begin
		print 'Invalid Option: ' + @Action
		return -1
	end


declare @BasePath  nvarchar(255),
        @ExtPath nvarchar(255),
		@Cmd nvarchar(1000),
		@FNameApply nvarchar(255),
		@SecurityFileApply nvarchar(255),
		@InstanceDirectory nvarchar(100)

--temp tables, #FilesSorted with negative identity for going backwards for each version
create table #Files (FName nvarchar(255))
create table #FilesSortedApply (Version int identity(0,-1),FName nvarchar(255), FPath nvarchar(255), FType char(2))

if @SecurityBasePath is null
	select @BasePath = '\\CRASAPPDBA01\SelfServe\Security\Instance'
else
	select @BasePath = @SecurityBasePath 

select @InstanceDirectory = replace(@Instance, '\','@')



if @Instance is not null and @SourceDatabaseName is not null 
	select @ExtPath = @BasePath + '\' + @InstanceDirectory + '\' + @SourceDatabaseName

if @TargetDatabaseName is null
	select @TargetDatabaseName = @SourceDatabaseName

select @Cmd = 'dir ' +  @ExtPath + ' /o-n /b'  --this sort is critical as it puts in proper order for identity assignment

exec @rc = master..xp_cmdshell @Cmd, no_output

if @rc <> 0
  begin
	print 'Directory not found/access denied, review directory name and security access on [' + @ExtPath + ']'
	return -2
  end

insert into #Files exec master..xp_cmdshell @Cmd

delete from #Files where FName is null  --remove garbage

insert into #FilesSortedApply (FName, FPath, FType) select FName, @ExtPath, 'UA' from #Files where FName like '%users%' order by FName desc  --get the users files


if @Action = 'LI' --'LI'st files
	begin
		select * from #FilesSortedApply
		return 0
	end

select @FNameApply = FName from #FilesSortedApply where Version = @Version and FType =  'UA'

if @FNameApply is null
	begin
		raiserror('Version [%i] not found, try again.',1,1, @Version)
		return -2
	end

select @SecurityFileApply = @ExtPath + '\' + @FNameApply



--Dynamic drops occur here on the @TargetDatabaseName
if @Action like 'D' or @Action like 'DA'
	begin
	    print 'Dropping Security at ' + @Instance + '.' + @TargetDatabaseName 
		select @Instance, @TargetDatabaseName, @ExtPath
        exec SSDBAUtils.dbo.pRemoveSchemaUserRoleSecurity @Instance, @TargetDatabaseName, @ExtPath, 1, 0  --hardwired 'true or 1' to remove security
	end

	--waitfor delay '00:00:10'
	
if @Action like 'A' or @Action like 'DA'
	begin
		if (select count(*) from #FilesSortedApply where FType = 'UA') = 0
		begin
			print 'Apply specified but no Apply script exists'
			return -3
		end
		
		select @Cmd = 'dir ' + @SecurityFileApply
		exec @rc = master..xp_cmdshell @Cmd, no_output

		if @rc <> 0
		  begin
			print 'File not found/access denied, review filename and security access on [' + @SecurityFileApply + ']'
			return -2
		  end
		
	    print 'Applying Security at ' + @Instance + '.' + @TargetDatabaseName + ' with file '  + @SecurityFileApply
		select @Cmd = 'SQLCMD.EXE -S ' + @Instance + ' -E -d ' + @TargetDatabaseName + ' -i ' + @SecurityFileApply
		exec master..xp_cmdshell @Cmd
	end

return 0


GO
/****** Object:  StoredProcedure [dbo].[pBackupDatabase]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[pBackupDatabase] 
@DatabaseName sysname, 
@FilePath nvarchar(500), 
@NumberOfFiles int = 1,
@WithClause nvarchar(500) = 'with stats = 10, init, compression, checksum, copy_only'
as

declare @cmd1 nvarchar(max) = 'backup database ',
        @cmd2 nvarchar(max) = '',
		@cmdTmp nvarchar(max) = '',
		@cmdFinal nvarchar(max),
		@counter int = 1,
		@now nvarchar(max) = replace(replace(convert(nvarchar, getdate(),121), ' ', '_'),':','')

--param checks
if @NumberOfFiles not between 1 and 20
	begin
		raiserror('Number of files must be between 1 and 20', 11, 1)
		return
	end

if db_id(@DatabaseName) is null
	begin
		raiserror('Database does not exist', 11, 1)
		return
	end


	declare @NumFiles nvarchar(2), @Count nvarchar(2)

while @counter <= @NumberOfFiles
  begin
      
	  select @NumFiles = case when @NumberOfFiles < 10 then '0' + cast(@NumberOfFiles as nvarchar) else cast(@NumberOfFiles as nvarchar) end
	  select @Count = case when @counter < 10 then '0' + cast(@counter as nvarchar) else cast(@counter as nvarchar) end
	  
	  select @cmdTmp = 'disk=''' + @FilePath + '\' + @DatabaseName + '_' + @now + '_File_' + @Count + 'of' + @NumFiles + '.bak' + ''',' + char(13) 
	  
	  if @counter = @NumberOfFiles
	    begin
		  select @cmdTmp = replace(@cmdTmp,',','')
		end
		
		select @cmd2 = @cmd2 + @cmdTmp
		select @counter = @counter + 1
  end
  select @cmdFinal = @cmd1 + @DatabaseName + ' to ' + char(13) + @cmd2 + @WithClause
  print @cmdFinal
  exec(@cmdFinal)

GO
/****** Object:  StoredProcedure [dbo].[pBackupRestoreTableData]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[pBackupRestoreTableData]
@Now datetime = getdate,
@BakResFlag nchar(1) = null,
@SourceDatabase nvarchar(128),
@Owner nvarchar(128),
@TableName nvarchar(128),
@TargetDatabase nvarchar(128) = 'UserDataBak',
@SourceTableName nvarchar(128) = 'NA',
@Debug bit = 0
as
set nocount on

declare 
@TablePreFix nvarchar(128) = '',
@NewTableName nvarchar(128) = '',
@NewTableNameAbbrev nvarchar(128) = '',
@refTableName nvarchar(128) = '',
@curTableName nvarchar(128) = '',
@CmdString nvarchar(4000),
@curCommand nvarchar(4000),
@ColumnList nvarchar(4000)

select @TablePreFix = 'ud' + replace(replace(replace(convert(varchar(25), @Now, 120),'-',''),':',''),' ','_') + '_'
select @NewTableNameAbbrev = @SourceDatabase + '_' + @Owner + '_' + @TableName

select @NewTableName = @TablePreFix + @SourceDatabase + '_' + @Owner + '_' + @TableName

--remove any prior global temps
if object_id('tempdb.dbo.##FKs') is not null
    drop table ##FKs
if object_id('tempdb.dbo.##TabName') is not null
    drop table ##TabName
if object_id('tempdb.dbo.##TabColName') is not null
    drop table ##TabColName

--command holding table
create table #ExecuteCommand (Command nvarchar(4000) null )

if @BakResFlag in ('B','b')
  begin
    select @CmdString = 'SELECT * INTO [' + @TargetDatabase + '].[' + @Owner + '].[' + @NewTableName + '] FROM [' + @SourceDatabase + '].[' + @Owner +'].[' + @TableName + ']'
	insert into #ExecuteCommand (Command) values (@CmdString)
  end
else  --restore table here
  begin
        --disable the constraints
		select @curCommand = 'use ' + @SourceDatabase + ' 
		   select object_name(rkeyid) as RefTableName,
				  object_name(fkeyid) as TableName
			 into ##FKs
			 from [' + @SourceDatabase + '].[' + @Owner +'].sysforeignkeys
			where object_name(rkeyid) = ''' + @TableName + '''
		 order by object_name(fkeyid)'

    	exec sp_executesql @curCommand

		declare curFKRemoval cursor global for
		   select RefTableName,
				  TableName
			 from ##FKs
		 order by  RefTableName
		 for read only

		open curFKRemoval
		
		fetch next from curFKRemoval into @refTableName, @curTableName

		  while @@fetch_status = 0
			begin
			  select @CmdString = 'ALTER TABLE [' + @SourceDatabase + '].[' + @Owner +'].[' + @curTableName + '] NOCHECK CONSTRAINT ALL'
			  insert into #ExecuteCommand (Command) values (@CmdString)

			  fetch next from curFKRemoval into @refTableName, @curTableName
			end

		  close curFKRemoval
		  deallocate curFKRemoval



        --set this up to get the last table saved
		select @CmdString = 'use ' + @SourceDatabase + ' 
		   select name as TableName
			 into ##TabName
			 from [' + @TargetDatabase + '].sys.tables
			where name like ''%' + @NewTableNameAbbrev + '''
		 order by name desc'

		 exec sp_executesql @CmdString


		 --going to load the last table saved or user specified table
		 if @SourceTableName = 'NA'
		   select top 1 @NewTableName = TableName from ##TabName order by TableName desc  -- order by desc very important
         else
		   select @NewTableName = @SourceTableName

		 --build the DELETE
		  select @CmdString = 'DELETE FROM [' + @SourceDatabase + '].[' + @Owner +'].[' + @TableName + ']' 
		  insert into #ExecuteCommand (Command) values (@CmdString)

		  --get columns here & identity if applicable

		select @curCommand = 'use ' + @SourceDatabase + ' 
		   select COLUMN_NAME,
		     COLUMNPROPERTY(object_id(TABLE_SCHEMA + ''.'' + TABLE_NAME), COLUMN_NAME, ''IsIdentity'') as Ident
			 into ##TabColName
			 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = ''' + @TableName + '''
			 order by ORDINAL_POSITION'
			 exec sp_executesql @curCommand

			 --update for qualified "look"
			 update ##TabColName set COLUMN_NAME = '[' + COLUMN_NAME + ']'

			 --get the comma delimited list of column names
			select @ColumnList = coalesce(@ColumnList + ',', '') + cast(column_name as nvarchar)
			from   ##TabColName

			--if there is an identity column prefix and suffix the proper identity_insert switch
          if exists(select * from ##TabColName where Ident = 1)
		    begin
		      select @CmdString = 'SET IDENTITY_INSERT [' + @SourceDatabase + '].[' + @Owner +'].[' + @TableName + '] ON' + CHAR(10)
		      select @CmdString = @CmdString + 'INSERT INTO [' + @SourceDatabase + '].[' + @Owner +'].[' + @TableName + '] (' + @ColumnList + ') SELECT ' +  @ColumnList + ' FROM  [' + @TargetDatabase + '].[' + @Owner +'].[' +  @NewTableName + ']' + CHAR(10)
		      select @CmdString = @CmdString + 'SET IDENTITY_INSERT [' + @SourceDatabase + '].[' + @Owner +'].[' + @TableName + '] OFF' 
			  insert into #ExecuteCommand (Command) values (@CmdString)
			end
          else
		    begin
		      select @CmdString = 'INSERT INTO [' + @SourceDatabase + '].[' + @Owner +'].[' + @TableName + '] (' + @ColumnList + ') SELECT ' +  @ColumnList + ' FROM  [' + @TargetDatabase + '].[' + @Owner +'].[' +  @NewTableName + ']' 
		      insert into #ExecuteCommand (Command) values (@CmdString)
		    end


			--re-enable the constraints
		 declare curFKReApply cursor global for
		   select RefTableName,
				  TableName
			 from ##FKs
		 order by  RefTableName
		 for read only

		open curFKReApply
		
		fetch next from curFKReApply into @refTableName, @curTableName

		  while @@fetch_status = 0
			begin
			  select @CmdString = 'ALTER TABLE [' + @SourceDatabase + '].[' + @Owner +'].[' + @curTableName + '] CHECK CONSTRAINT ALL'
			  insert into #ExecuteCommand (Command) values (@CmdString)
			  fetch next from curFKReApply into @refTableName, @curTableName
			end

		  close curFKReApply
		  deallocate curFKReApply

  end

	if @Debug = 0
	  begin
		declare curExecuteCommands cursor global for
		select Command
			from #ExecuteCommand
		for read only

		open curExecuteCommands
		
		fetch next from curExecuteCommands into @CmdString
		print '--BEGIN Execute Block'
			while @@fetch_status = 0
			begin
				print @CmdString
				exec sp_executesql @CmdString
				fetch next from curExecuteCommands into @CmdString
			end
		print '--END   Execute Block'
		print ''
		close curExecuteCommands
		deallocate curExecuteCommands  
	  end
	else
	  begin 
		select  Command from #ExecuteCommand
	  end

	--remove any prior global temps
	if object_id('tempdb.dbo.##FKs') is not null
	  drop table ##FKs
	if object_id('tempdb.dbo.##TabName') is not null
	  drop table ##TabName
	if object_id('tempdb.dbo.##TabColName') is not null
	  drop table ##TabColName

GO
/****** Object:  StoredProcedure [dbo].[pClearJobStepLog]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create procedure [dbo].[pClearJobStepLog] @JobID uniqueidentifier = null
as




--this makes sure the log is clean only on the first step, 
--so no others get deleted on subsequent restore ops

if @JobID is not null --pass via sql token
	begin
		raiserror ('Clearing Job Step Log',1,1)
		exec msdb.dbo.sp_delete_jobsteplog @job_id = @JobID
	end
else 
	begin
		raiserror ('Job Step Log was NOT cleared',1,1)
	end
GO
/****** Object:  StoredProcedure [dbo].[pCreateDatabase]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[pCreateDatabase] @NewDatabaseName sysname, @SecurityFromDatabase sysname, @Debug bit = 0
as
set nocount on

declare @cmdString nvarchar(max)


if exists(select name as DatabaseName from  master.sys.databases where name = @NewDatabaseName)
  begin
	raiserror (N'Database [%s] already exists.', 12, 1, @NewDatabaseName)
	return(-1)
  end
if not exists(select name as DatabaseName from  master.sys.databases where name = @SecurityFromDatabase)
  begin
	raiserror (N'Copy from Security Database [%s] does not exist.', 12, 1, @SecurityFromDatabase)
	return(-2)
  end

  select @cmdString = 'create database ' + @NewDatabaseName
  select @cmdString
  exec (@cmdString)

exec SSDBAUtils.dbo.pApplySecurity @Version=0, @Action='DA', @Instance=@@SERVERNAME, @SourceDatabaseName=@SecurityFromDatabase, @TargetDatabaseName=@NewDatabaseName
GO
/****** Object:  StoredProcedure [dbo].[pDropDatabase]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create procedure [dbo].[pDropDatabase] @OldDatabaseName sysname, @Debug bit = 0
as
set nocount on

if @OldDatabaseName in ('master','model','msdb','distribution','dbutils','ssdbautils','tempdb','ReportServer','ReportServerTempDB')
  begin
	raiserror (N'Cannot drop [%s], it is a system database, ', 12, 1, @OldDatabaseName)
	return(-1)
  end

select sb.name as DatabaseName, mf.name as LogicalName, mf.physical_name as PhysicalName
from master.sys.master_files mf 
inner join master.sys.databases sb on sb.database_id = mf.database_id
where sb.name = @OldDatabaseName

if @@ROWCOUNT = 0
  begin
	raiserror (N'Database [%s] not found, cannot drop.', 12, 1, @OldDatabaseName)
	return(-2)
  end


declare @cmdString nvarchar(max)

--single user
select @cmdString = 'alter database ' + @OldDatabaseName + ' set single_user with rollback immediate'

if @Debug = 0 exec (@cmdString)
select @cmdString


--drop the DB
select @cmdString = 'drop database ' + @OldDatabaseName 
if @Debug = 0 exec (@cmdString)
select @cmdString



 




GO
/****** Object:  StoredProcedure [dbo].[pExecuteJobNotification]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[pExecuteJobNotification]
@job_id    UNIQUEIDENTIFIER = NULL, -- Must provide either this or job_name
@job_name  sysname          = NULL, -- Must provide either this or job_id
 
@profile_name               sysname    = NULL,        
@recipients                 VARCHAR(MAX)  = NULL, 
@copy_recipients            VARCHAR(MAX)  = NULL,
@blind_copy_recipients      VARCHAR(MAX)  = NULL,
@subject                    NVARCHAR(255) = NULL,
@body                       NVARCHAR(MAX) = NULL, 
@body_format                VARCHAR(20)   = NULL, 
@importance                 VARCHAR(6)    = 'NORMAL',
@sensitivity                VARCHAR(12)   = 'NORMAL',
@file_attachments           NVARCHAR(MAX) = NULL,  
@query                      NVARCHAR(MAX) = NULL,
@execute_query_database     sysname       = NULL,  
@attach_query_result_as_file BIT          = 0,
@query_attachment_filename  NVARCHAR(260) = NULL,  
@query_result_header        BIT           = 1,
@query_result_width         INT           = 256,            
@query_result_separator     CHAR(1)       = ' ',
@exclude_query_output       BIT           = 0,
@append_query_error         BIT           = 0,
@query_no_truncate          BIT           = 1,
@query_result_no_padding    BIT           = 0,
@mailitem_id               INT            = NULL OUTPUT,
@from_address               VARCHAR(max)  = NULL,
@reply_to                   VARCHAR(max)  = NULL


as
set nocount on

declare @ServerName nvarchar(128) = '',
        @DatabaseName nvarchar(128) = '',
		@SelectCommand nvarchar(max),
		@JobStatus nvarchar(20),
		@NotifyList nvarchar(512),
		@CCNotifyList nvarchar(512),
	    @BCCNotifyList nvarchar(512),
		@ParmDefinition nvarchar(100)

  DECLARE @retval      INT
  DECLARE @max_step_id INT
  DECLARE @valid_range VARCHAR(50)

  EXECUTE @retval = msdb.dbo.sp_verify_job_identifiers '@job_name',
													  '@job_id',
													   @job_name OUTPUT,
													   @job_id   OUTPUT,
													  'NO_TEST'
  IF (@retval <> 0)
    RETURN(1) -- Failure

          SELECT @JobStatus = 
		   case when last_run_outcome = 0 then 'Failed'
		        when last_run_outcome = 1 then 'Succeeded'
				when last_run_outcome = 2 then 'Retry'
				when last_run_outcome = 3 then 'Canceled'
				when last_run_outcome = 5 then 'Unknown'
				else 'NULL'
		   end
		     --as 'JobStatus'
    FROM msdb.dbo.sysjobs_view sjv, msdb.dbo.sysjobsteps as steps, msdb.dbo.sysjobstepslogs as logs 
    WHERE (sjv.job_id = @job_id)
      AND (steps.job_id = @job_id)
      AND (steps.step_uid = logs.step_uid)
	  AND steps.step_name <> 'Email Step'

select @subject = @subject + ' - [ ' + upper(@JobStatus) + ' ]'

exec MSDB.dbo.sp_send_dbmail 
@profile_name=@profile_name, 
@recipients=@recipients, 
@copy_recipients=@copy_recipients,
@blind_copy_recipients=@blind_copy_recipients,
@subject=@subject, 
@query=@query, 
@body=@body, 
@body_format=@body_format, 
@query_result_header=1,
@query_result_width=8196, 
@query_no_truncate=1, 
@append_query_error=1


GO
/****** Object:  StoredProcedure [dbo].[pExecuteReleaseItem]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[pExecuteReleaseItem] 
@ItemID int, 
@ExecCommand varchar(8000), 
@ServerDatabaseInfo nvarchar(128)


as
set nocount on
declare @ExecRc int = -1,
        @UpdateRc int = -1,
        @LastError int = 0,
		@DateString nvarchar(30)

declare @ServerName nvarchar(128) = '',
        @DatabaseName nvarchar(128) = '',
		@ProcCommand nvarchar(max)

select @ServerName = substring(@ServerDatabaseInfo,0, CHARINDEX('.',@ServerDatabaseInfo))
select @DatabaseName = reverse(substring(reverse(@ServerDatabaseInfo),0, CHARINDEX('.',reverse(@ServerDatabaseInfo))))

select @ProcCommand = 'exec OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @ServerName + ';Integrated Security=SSPI'').' + @DatabaseName + '.dbo.pUpdateReleaseItem ' + cast(@ItemID as nvarchar) + ',' + '''Executing''' + ',' + '''' + convert(nvarchar,getdate(),121)  + ''''
exec @UpdateRc = master.dbo.sp_executesql @ProcCommand


exec @ExecRc = master.dbo.xp_cmdshell @ExecCommand


if @ExecRc = 0
  begin
    select @ProcCommand = 'exec OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @ServerName + ';Integrated Security=SSPI'').' + @DatabaseName + '.dbo.pUpdateReleaseItem ' + cast(@ItemID as nvarchar) + ',' + '''Complete''' + ',' + '''' + convert(nvarchar,getdate(),121) + '''' + ',' + '''' + convert(nvarchar,getdate(),121) + '''' 
    exec @UpdateRc = master.dbo.sp_executesql @ProcCommand
	raiserror('Release Step Successful', 10, 1)
	return 0
  end
else
  begin
    select @ProcCommand = 'exec OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @ServerName + ';Integrated Security=SSPI'').' + @DatabaseName + '.dbo.pUpdateReleaseItem ' + cast(@ItemID as nvarchar) + ',' + '''Failed''' + ',' + '''' + convert(nvarchar,getdate(),121) + '''' + ',' + '''' + convert(nvarchar,getdate(),121) + '''' 
    exec @UpdateRc = master.dbo.sp_executesql @ProcCommand
	raiserror('Release Step Failed', 11, 1)
  end

GO
/****** Object:  StoredProcedure [dbo].[pExecuteReleaseNotification]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[pExecuteReleaseNotification] 
@PackageID int, 
@ServerDatabaseInfo nvarchar(128),
@profile_name               sysname    = NULL,        
@recipients                 VARCHAR(MAX)  = NULL, 
@copy_recipients            VARCHAR(MAX)  = NULL,
@blind_copy_recipients      VARCHAR(MAX)  = NULL,
@subject                    NVARCHAR(255) = NULL,
@body                       NVARCHAR(MAX) = NULL, 
@body_format                VARCHAR(20)   = NULL, 
@importance                 VARCHAR(6)    = 'NORMAL',
@sensitivity                VARCHAR(12)   = 'NORMAL',
@file_attachments           NVARCHAR(MAX) = NULL,  
@query                      NVARCHAR(MAX) = NULL,
@execute_query_database     sysname       = NULL,  
@attach_query_result_as_file BIT          = 0,
@query_attachment_filename  NVARCHAR(260) = NULL,  
@query_result_header        BIT           = 1,
@query_result_width         INT           = 256,            
@query_result_separator     CHAR(1)       = ' ',
@exclude_query_output       BIT           = 0,
@append_query_error         BIT           = 0,
@query_no_truncate          BIT           = 1,
@query_result_no_padding    BIT           = 0,
@mailitem_id               INT            = NULL OUTPUT,
@from_address               VARCHAR(max)  = NULL,
@reply_to                   VARCHAR(max)  = NULL


as
set nocount on
declare @ExecRc int = -1,
        @UpdateRc int = -1,
        @LastError int = 0,
		@DateString nvarchar(30)

declare @ServerName nvarchar(128) = '',
        @DatabaseName nvarchar(128) = '',
		@SelectCommand nvarchar(max),
		@PackageStatus nvarchar(20),
		@NotifyList nvarchar(512),
		@CCNotifyList nvarchar(512),
		@BCCNotifyList nvarchar(512),
		@ParmDefinition nvarchar(200)

select @ServerName = substring(@ServerDatabaseInfo,0, CHARINDEX('.',@ServerDatabaseInfo))
select @DatabaseName = reverse(substring(reverse(@ServerDatabaseInfo),0, CHARINDEX('.',reverse(@ServerDatabaseInfo))))

select @SelectCommand = 'select @PackageStatusOUT = PackageStatus from  OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @ServerName + ';Integrated Security=SSPI'').' + @DatabaseName + '.dbo.ReleasePackage where PackageID = ' + cast(@PackageID as nvarchar) + ''
select @ParmDefinition = N'@PackageStatusOUT nvarchar(20) OUTPUT';
exec @UpdateRc = master.dbo.sp_executesql @SelectCommand, @ParmDefinition, @PackageStatusOUT = @PackageStatus OUTPUT


select @SelectCommand = 'select @NotifyListOUT = NotifyList, @CCNotifyListOUT = CCNotifyList, @BCCNotifyListOUT = BCCNotifyList from  OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @ServerName + ';Integrated Security=SSPI'').' + @DatabaseName + '.dbo.ReleasePackage where PackageID = ' + cast(@PackageID as nvarchar) + ''
select @ParmDefinition = N'@NotifyListOUT nvarchar(512) OUTPUT, @CCNotifyListOUT nvarchar(512) OUTPUT, @BCCNotifyListOUT nvarchar(512) OUTPUT';
exec @UpdateRc = master.dbo.sp_executesql @SelectCommand, @ParmDefinition, @NotifyListOUT = @NotifyList OUTPUT, @CCNotifyListOUT = @CCNotifyList OUTPUT, @BCCNotifyListOUT = @BCCNotifyList OUTPUT



select @subject = @subject + ' - [ ' + upper(@PackageStatus) + ' ]'
--exec MSDB.dbo.sp_send_dbmail @profile_name=@profile_name, @recipients=@NotifyList, @subject=@subject , @query=N'exec SSDBAUtils.dbo.pReadJobStepLog @job_name=''0_Release_MDL_MyCustom_Immediate''', @body=@body
--exec MSDB.dbo.sp_send_dbmail @profile_name=@profile_name, @recipients=@NotifyList, @copy_recipients=@CCNotifyList,@subject=@subject, @query=@query, @body=@body, @body_format=@body_format, @query_no_truncate=@query_no_truncate
exec MSDB.dbo.sp_send_dbmail @profile_name=@profile_name, @recipients=@NotifyList, @copy_recipients=@CCNotifyList, @blind_copy_recipients=@BCCNotifyList,@subject=@subject, @query=@query, @body=@body, @body_format=@body_format, @query_no_truncate=@query_no_truncate


GO
/****** Object:  StoredProcedure [dbo].[pGetHAPrimary]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[pGetHAPrimary] 
@SourceName sysname output,
@SourceNameOUT sysname output
as
set nocount on
declare @Primary sysname, @IsHadrEnabled int = -1
declare @Query nvarchar(2000), @ParmDefinition nvarchar(1000)

select @Query = N'select @IsHadrEnabledOUT = cast(ServerProp as int) from openrowset(''SQLNCLI'', ''server=' + @SourceName + ';trusted_connection=yes;'', ''select serverproperty(''''IsHadrEnabled'''') as ServerProp'')'
select @ParmDefinition = N'@IsHadrEnabledOUT int OUTPUT'
exec master.dbo.sp_executesql @Query, @ParmDefinition, @IsHadrEnabledOUT = @IsHadrEnabled OUTPUT


if isnull(@IsHadrEnabled,0) = 0
  begin
    select @SourceNameOUT = @SourceName   --bail here, no need to go further
  end
else
  begin
    declare @HADNSName sysname
	select @HADNSName = case charindex(',',@SourceName) when 0 then @SourceName else left(@SourceName, charindex(',',@SourceName) - 1) end

	select @Query = N'select @PrimaryOUT = gs.primary_replica  
	from OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @SourceName + ';Integrated Security=SSPI'').master.sys.availability_group_listeners l 
	inner join  OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @SourceName + ';Integrated Security=SSPI'').master.sys.dm_hadr_availability_group_states gs on gs.group_id = l.group_id
	inner join  OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @SourceName + ';Integrated Security=SSPI'').master.sys.availability_groups ag on ag.group_id = l.group_id
	inner join  OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @SourceName + ';Integrated Security=SSPI'').master.sys.availability_replicas ar on ar.group_id = l.group_id
	inner join  OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @SourceName + ';Integrated Security=SSPI'').master.sys.dm_hadr_availability_replica_states rs on rs.group_id = l.group_id and rs.replica_id = ar.replica_id'


	--select @Query

	select @ParmDefinition = N'@PrimaryOUT nvarchar(max) OUTPUT'
	exec master.dbo.sp_executesql @Query, @ParmDefinition, @PrimaryOUT = @Primary OUTPUT

	--if @Primary is null
	--	select @SourceNameOUT = @SourceName
	--else
		select @SourceNameOUT = @Primary


  end

GO
/****** Object:  StoredProcedure [dbo].[pIncrementalShrinkDatabaseFile]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[pIncrementalShrinkDatabaseFile]
@DatabaseName sysname,        -- Database
@DBFileName sysname = NULL,   -- Set Name of Database file to shrink
@TargetFreeMB int = 1000,        --Set Desired file free space in MB after shrink
@ShrinkIncrementMB int = 1000    -- Set Increment to shrink file by in MB
as
set nocount on
declare @sqlFileInfo nvarchar(4000), @sql nvarchar(4000)

if exists (select  * from tempdb.dbo.sysobjects o where o.xtype in ('U') and o.id = object_id(N'tempdb..#DataFile'))
	drop table #DataFile

create table #DataFile (FileSizeMB float,UsedSpaceMB float, UnusedSpaceMB float, DBFileName nvarchar(128))


set @sqlFileInfo = 'use ' + @DatabaseName + ' select
	[FileSizeMB]	=
		convert(numeric(10,2),round(a.size/128.,2)),
	[UsedSpaceMB]	=
		convert(numeric(10,2),round(fileproperty( a.name,''SpaceUsed'')/128.,2)) ,
	[UnusedSpaceMB]	=
		convert(numeric(10,2),round((a.size-fileproperty( a.name,''SpaceUsed''))/128.,2)) ,
	[DBFileName]	= a.name
from sys.database_files a where type <> 1'  --no log files

insert into #DataFile exec (@sqlFileInfo)

exec ( @sqlFileInfo )

declare @SizeMB int
declare @UsedMB int
declare @CurDBFileName sysname
declare @count int = 0

if @DBFileName is null
	declare curFiles cursor for select DBFileName from #DataFile 
else
	declare curFiles cursor for select DBFileName from #DataFile where DBFileName = @DBFileName

open curFiles
fetch next from curFiles into @CurDBFileName

while (@@fetch_status = 0)
	begin
	    select @CurDBFileName as 'FileName'
		select @SizeMB = FileSizeMB, @UsedMB  = UsedSpaceMB from #DataFile where DBFileName = @CurDBFileName



		while  @SizeMB > @UsedMB+@TargetFreeMB+@ShrinkIncrementMB
			begin
				select @count = @count + 1
				print 'Shrink Iteration: ' + cast(@count as nvarchar)
				select @SizeMB , @UsedMB+@TargetFreeMB+@ShrinkIncrementMB
				set @sql = 'use ' + @DatabaseName + ' dbcc shrinkfile ( '+@CurDBFileName+', '+ convert(varchar(20),@SizeMB-@ShrinkIncrementMB)+' ) '



				--if @count = 1
				--	begin
				--		exec (@sqlFileInfo)
				--		select @count = 0
				--		fetch next from curFiles into @CurDBFileName
				--		break
				--	end

				print 'Start: ' + @sql + ' at '+convert(varchar(30),getdate(),121)
				exec ( @sql )

				delete from #DataFile
				insert into #DataFile exec (@sqlFileInfo)

				select @SizeMB = FileSizeMB, @UsedMB  = UsedSpaceMB from #DataFile where DBFileName = @CurDBFileName


				select [FileSize] = @SizeMB, [UsedSpace] = @UsedMB, [DBFileName] = @DBFileName, GETDATE()
				print 'Done: ' + @sql + ' at '+convert(varchar(30),getdate(),121)
				raiserror ('', 0, 1) with nowait --flush buffer
			end

        select @count = 0
		fetch next from curFiles into @CurDBFileName
	end

exec (@sqlFileInfo)
close curFiles
deallocate curFiles

GO
/****** Object:  StoredProcedure [dbo].[pKillDatabaseUsers]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[pKillDatabaseUsers]
@dbname varchar(50) = null,
@hardkill bit = 0  --1 is an Executed Hard Kill

as
declare @errmsg varchar(255),
        @spid integer,
        @status sysname,
        @loginame sysname,
        @hostname sysname,
        @program_name sysname,
        @cmd sysname,
        @uid sysname,
        @nt_username sysname,
        @sid varchar,
        @login_time datetime,
		@msg varchar(255)

if @dbname is null
  begin
   select @errmsg = 'Database Name is null'
    raiserror (@errmsg, 11, 1) with nowait
  end

if @dbname not in (select name from master.dbo.sysdatabases)
  begin
    select @errmsg = 'Database Name ' + @dbname + ' is not found'
    raiserror (@errmsg, 11, 1) with nowait
  end

exec ('alter database [' + @dbname + '] set restricted_user with rollback immediate')


declare cursor_normal_spid_detector cursor for
  select 
  spid, 
  ltrim(status),  
  login_time, 
  loginame, 
  ltrim(hostname), 
  ltrim(program_name), 
  ltrim(cmd), 
  uid, 
  nt_username, 
  db_name(dbid) dbname
  from  
  master.dbo.sysprocesses
  where 
	spid <> @@spid                  -- not current process
	and db_name(dbid) = @dbname 
	and loginame <> 'sa' 			-- exclude sa
  for read only

  open cursor_normal_spid_detector
		
  fetch next from cursor_normal_spid_detector into @spid, @status, @login_time, @loginame, @hostname, @program_name, @cmd, @uid, @nt_username, @dbname
  if (@@fetch_status = 0)
     begin
       select @msg = 'The following users are logged into target database '+ ltrim(rtrim(@dbname))  
       print @msg

       while (@@fetch_status = 0) 
         begin
           select @msg=''
	       select @msg = @msg   + ' Spid=' + ltrim(rtrim(@spid))
	                            + ' LoginName=' + ltrim(rtrim(@loginame))
	                            + ' Status=' + ltrim(rtrim(@status))
		            			+ ' LoginTime=' + ltrim(rtrim(cast(@login_time as varchar(30))))
		 		    		    + ' Hostname=' + ltrim(rtrim(@hostname))
		 			    	    + ' ProgramName=' + ltrim(rtrim(@program_name))
	       print @msg 

		   if @hardkill = 1
		     begin
		       exec ('kill ' + @spid)
			   print ' Hard Kill on: ' + ltrim(rtrim(@spid))
			 end

	       fetch next from cursor_normal_spid_detector into @spid, @status, @login_time, @loginame, @hostname, @program_name, @cmd, @uid, @nt_username, @dbname
	     end

     end
close cursor_normal_spid_detector
deallocate cursor_normal_spid_detector


GO
/****** Object:  StoredProcedure [dbo].[pManageTableData]    Script Date: 10/19/2022 1:44:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[pManageTableData]
@BakResFlag nchar(1) = null,
@TableSetName nvarchar(128),
@TargetDatabase nvarchar(128) = 'UserDataBak',
@Debug bit = 0
as
	if object_id('tempdb.dbo.##TableSet') is not null
	  drop table ##TableSet


declare @curCommand nvarchar(4000),
@Now datetime = getdate(),
@ApplySequence int,
@DatabaseName nvarchar(128),
@Owner nvarchar(128),
@TableName nvarchar(128)



		select @curCommand = 'use ' + @TargetDatabase + ' 
		   select [DatabaseName]
                 ,[Owner]
                 ,[TableName]
				 ,[ApplySequence]
		     into ##TableSet
			 from [' + @TargetDatabase + '].[dbo].TableSet
			where TableSetName = ''' + @TableSetName + '''
		 order by [ApplySequence] ' + case when @BakResFlag = 'B' then 'DESC' else 'ASC' end
select @curCommand
     	exec sp_executesql @curCommand

		declare curTableSet cursor global for
		   select [DatabaseName]
                 ,[Owner]
                 ,[TableName]
			 from ##TableSet
		 order by  [ApplySequence]
		 for read only

		open curTableSet
		
		fetch next from curTableSet into @DatabaseName, @Owner, @TableName

		  while @@fetch_status = 0
			begin
			  exec SSDBAUtils.dbo.pBackupRestoreTableData @Now = @Now, @BakResFlag = @BakResFlag, @SourceDatabase = @DatabaseName, @Owner = @Owner, @TableName = @TableName, @TargetDatabase = @TargetDatabase, @Debug = @Debug
			  fetch next from curTableSet into @DatabaseName, @Owner, @TableName
			end

		  close curTableSet
		  deallocate curTableSet

	if object_id('tempdb.dbo.##TableSet') is not null
	  drop table ##TableSet
GO
/****** Object:  StoredProcedure [dbo].[pPostProcess]    Script Date: 10/19/2022 1:44:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[pPostProcess] 
@DatabaseName nvarchar(128),
@Debug bit = 0
as

declare @SQLComand nvarchar(max)

--Shrink the log file and reclaim space
select @SQLComand = 'USE [' + d.name + N']' + CHAR(13) + CHAR(10) 
    + 'DBCC SHRINKFILE (N''' + mf.name + N''' , 0, TRUNCATEONLY)' 
    + CHAR(13) + CHAR(10) 
FROM 
         sys.master_files mf 
    JOIN sys.databases d 
        ON mf.database_id = d.database_id 
WHERE d.database_id > 4 and mf.type_desc = 'LOG'
 and db_name(mf.database_id) = @DatabaseName

 if @Debug = 0 exec(@SQLComand) else print '--Debug: ' + CHAR(13) + CHAR(10) + @SQLComand + CHAR(13) + CHAR(10) + 'GO'

 select @SQLComand = 'ALTER DATABASE [' + @DatabaseName + '] SET MULTI_USER'
 if @Debug = 0 exec(@SQLComand) else print '--Debug: ' + CHAR(13) + CHAR(10) + @SQLComand + CHAR(13) + CHAR(10) + 'GO'

     
 
GO
/****** Object:  StoredProcedure [dbo].[pPreProcessJob]    Script Date: 10/19/2022 1:44:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[pPreProcessJob] @DatabaseNameIN sysname, @JobID uniqueidentifier = null, @JobStepID int = 0
as

declare @Version nvarchar(128)
declare @SQLString nvarchar(500);
declare @ParmDefinition nvarchar(500);
declare @ReturnCodeOUT int = -1
declare @ReturnCode int = -1

select @Version = cast(serverproperty('ProductVersion') as nvarchar(128))

--this makes sure the log is clean only on the first step, 
--so no others get deleted on subsequent restore ops
if @JobStepID = 1  
	begin
		if @JobID is not null --pass via sql token
		begin
		  raiserror ('Clearing Job Step Log on initial job call of Step # 1',1,1)
		  exec msdb.dbo.sp_delete_jobsteplog @job_id = @JobID
		end
	end

--Backup check
if exists(select * from master..sysprocesses where db_name(dbid) = @DatabaseNameIN and cmd = 'BACKUP DATABASE')
begin
	raiserror (N'Database [%s] is executing a BACKUP, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-1)
end

--Restore check
if exists(select * from master..sysprocesses where db_name(dbid) = @DatabaseNameIN and cmd = 'RESTORE DATABASE')
begin
	raiserror (N'Database [%s] is executing a RESTORE, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-2)
end

--DBCC check
if exists(select * from master..sysprocesses where db_name(dbid) = @DatabaseNameIN and cmd like 'DBCC%')
begin
	raiserror (N'Database [%s] is executing a DBCC, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-3)
end






--Online check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and state_desc = ''ONLINE'') select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 0
begin
	raiserror (N'Database [%s] is not ONLINE, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-4)
end
 



--ReadOnly check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and is_read_only = 1) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is in READONLY mode, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-5)
end




--Replication check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and (is_published = 1 or is_subscribed = 1 or is_merge_published = 1 or is_distributor = 1)) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is associated with REPLICATION, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-6)
end




--Encryption check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and (is_encrypted = 1 or is_master_key_encrypted_by_server = 1)) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is ENCRYPTED, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-7)
end





--cdc check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and is_cdc_enabled = 1) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is CDC (Change Data Capture) enabled, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-8)
end






--mirror check
set @SQLString = N'if exists(select * from sys.databases a inner join sys.database_mirroring b on a.database_id = b.database_id where a.name = @DatabaseName and b.mirroring_state is not null) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is MIRRORED, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-9)
end







--HA check check on versions 2012=11, 2014=12
if @Version like '11%' or @Version like '12%'  
	begin
		raiserror (N'Checking for High Availability', 1, 1)
		set @SQLString = N'if exists(select * from sys.databases a where name = @DatabaseName and group_database_id is not null) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
		set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
		execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
		if @ReturnCode = 1
		begin
			raiserror (N'Database [%s] is HIGH AVAILABILITY, Exiting without action.', 12, 1, @DatabaseNameIN)
			return(-10)
		end
	end


raiserror (N'Database [%s] has passed the Pre Process checks', 1, 1, @DatabaseNameIN)
return(0)


GO
/****** Object:  StoredProcedure [dbo].[pPreProcessJobV3]    Script Date: 10/19/2022 1:44:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create procedure [dbo].[pPreProcessJobV3] @DatabaseNameIN sysname
as

declare @Version nvarchar(128)
declare @SQLString nvarchar(500);
declare @ParmDefinition nvarchar(500);
declare @ReturnCodeOUT int = -1
declare @ReturnCode int = -1

select @Version = cast(serverproperty('ProductVersion') as nvarchar(128))



--Backup check
if exists(select * from master..sysprocesses where db_name(dbid) = @DatabaseNameIN and cmd = 'BACKUP DATABASE')
begin
	raiserror (N'Database [%s] is executing a BACKUP, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-1)
end

--Restore check
if exists(select * from master..sysprocesses where db_name(dbid) = @DatabaseNameIN and cmd = 'RESTORE DATABASE')
begin
	raiserror (N'Database [%s] is executing a RESTORE, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-2)
end

--DBCC check
if exists(select * from master..sysprocesses where db_name(dbid) = @DatabaseNameIN and cmd like 'DBCC%')
begin
	raiserror (N'Database [%s] is executing a DBCC, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-3)
end






--Online check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and state_desc = ''ONLINE'') select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 0
begin
	raiserror (N'Database [%s] is not ONLINE, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-4)
end
 



--ReadOnly check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and is_read_only = 1) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is in READONLY mode, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-5)
end




--Replication check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and (is_published = 1 or is_subscribed = 1 or is_merge_published = 1 or is_distributor = 1)) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is associated with REPLICATION, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-6)
end




--Encryption check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and (is_encrypted = 1 or is_master_key_encrypted_by_server = 1)) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is ENCRYPTED, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-7)
end





--cdc check
set @SQLString = N'if exists(select * from sys.databases where name = @DatabaseName and is_cdc_enabled = 1) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is CDC (Change Data Capture) enabled, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-8)
end






--mirror check
set @SQLString = N'if exists(select * from sys.databases a inner join sys.database_mirroring b on a.database_id = b.database_id where a.name = @DatabaseName and b.mirroring_state is not null) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
if @ReturnCode = 1
begin
	raiserror (N'Database [%s] is MIRRORED, Exiting without action.', 12, 1, @DatabaseNameIN)
	return(-9)
end







--HA check check on versions 2012=11, 2014=12, 2016=13
if @Version like '11%' or @Version like '12%' or @Version like '13%' 
	begin
		raiserror (N'Checking for High Availability', 1, 1)
		set @SQLString = N'if exists(select * from sys.databases a where name = @DatabaseName and group_database_id is not null) select @ReturnCodeOUT = 1 else select @ReturnCodeOUT = 0'
		set @ParmDefinition = N'@DatabaseName nvarchar(128), @ReturnCodeOUT int OUTPUT';
		execute sp_executesql @SQLString, @ParmDefinition, @DatabaseName = @DatabaseNameIN, @ReturnCodeOUT = @ReturnCode OUTPUT;
		if @ReturnCode = 1
		begin
			raiserror (N'Database [%s] is HIGH AVAILABILITY, Exiting without action.', 12, 1, @DatabaseNameIN)
			return(-10)
		end
	end


raiserror (N'Database [%s] has passed the Pre Process checks', 1, 1, @DatabaseNameIN)
return(0)


GO
/****** Object:  StoredProcedure [dbo].[pReadJobStepLog]    Script Date: 10/19/2022 1:44:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[pReadJobStepLog]
  @job_id    UNIQUEIDENTIFIER = NULL, -- Must provide either this or job_name
  @job_name  sysname          = NULL, -- Must provide either this or job_id
  @step_id   INT              = NULL,
  @step_name sysname          = NULL
AS
set nocount on
BEGIN
  DECLARE @retval      INT
  DECLARE @max_step_id INT
  DECLARE @valid_range VARCHAR(50)

  EXECUTE @retval = msdb.dbo.sp_verify_job_identifiers '@job_name',
													  '@job_id',
													   @job_name OUTPUT,
													   @job_id   OUTPUT,
													  'NO_TEST'
  IF (@retval <> 0)
    RETURN(1) -- Failure

  -- Check step id (if supplied)
  IF (@step_id IS NOT NULL)
  BEGIN
    -- Get current maximum step id
    SELECT @max_step_id = ISNULL(MAX(step_id), 0)
    FROM msdb.dbo.sysjobsteps
    WHERE job_id = @job_id
   IF @max_step_id = 0
   BEGIN
      RAISERROR(14528, -1, -1, @job_name)
      RETURN(1) -- Failure 
   END
    ELSE IF (@step_id < 1) OR (@step_id > @max_step_id)
    BEGIN
      SELECT @valid_range = '1..' + CONVERT(VARCHAR, @max_step_id)
      RAISERROR(14266, -1, -1, '@step_id', @valid_range)
      RETURN(1) -- Failure
    END
  END

  -- Check step name (if supplied)
  -- NOTE: A supplied step id overrides a supplied step name
  IF ((@step_id IS NULL) AND (@step_name IS NOT NULL))
  BEGIN
    SELECT @step_id = step_id
    FROM msdb.dbo.sysjobsteps
    WHERE (step_name = @step_name)
      AND (job_id = @job_id)

    IF (@step_id IS NULL)
    BEGIN
      RAISERROR(14262, -1, -1, '@step_name', @step_name)
      RETURN(1) -- Failure
    END
  END

declare @body NVARCHAR(MAX),@Style nvarchar(max)

--select @Style = '
--table {border-collapse: collapse; border: 1px solid black; font-family: courier;font-size:12px;}
--td {border-spacing: 0; border: 1px solid black;text-align:left; padding: 2; white-space: nowrap;}
--th {border-spacing: 0; border: 1px solid black;text-align:left; font-weight:bold; padding: 2;white-space: nowrap;font-size:14px;}
--tr:nth-child(even) {background-color: #f2f2f2}
--'
select @body = N'
<div style="overflow-x:auto;"> 
    <br/>   
    <table>'
    + N'<tr><th>Step ID</th><th>Step Name</th><th>Status</th><th>Date</th><th>Output</th></tr>'
    + CAST((
           SELECT
           steps.step_id as 'td',
           steps.step_name  as 'td',
		   case when last_run_outcome = 0 then 'Failed'
		        when last_run_outcome = 1 then 'Succeeded'
				when last_run_outcome = 2 then 'Retry'
				when last_run_outcome = 3 then 'Canceled'
				when last_run_outcome = 5 then 'Unknown'
				else 'NULL'
		   end
		     as 'td',
           convert(varchar(25),logs.date_modified,109)  as 'td',
		   --convert(nvarchar(4000),logs.log) as 'td'--,
		   case when len(log) < 10000 then log else left(log,10000) + '...(LOG TRUNCATED)' end as 'td'
		   --command as 'td'
    FROM msdb.dbo.sysjobs_view sjv, msdb.dbo.sysjobsteps as steps, msdb.dbo.sysjobstepslogs as logs 
    WHERE (sjv.job_id = @job_id)
      AND (steps.job_id = @job_id)
      AND ((@step_id IS NULL) OR (step_id = @step_id))
      AND (steps.step_uid = logs.step_uid)
	  AND steps.step_name <> 'Email Step'
	  order by steps.step_id
      FOR XML RAW('tr'), ELEMENTS
    ) AS NVARCHAR(MAX))
    + N'</table> 
	    </div>'

	--print @body
	select @body as 'Output'

   
  RETURN(@@error) -- 0 means success
END


-- pReadJobStepLog @job_name='1_Release_DEV_v2.5 Upgrade_Immediate'


GO
/****** Object:  StoredProcedure [dbo].[pRemoveSchemaUserRoleSecurity]    Script Date: 10/19/2022 1:44:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[pRemoveSchemaUserRoleSecurity]
@InstanceName nvarchar(200) = null,
@TargetDatabaseName nvarchar(200) = null,
@ExtPath nvarchar(100),
@Debug bit = 0,
@RetainAdmins bit = 0,
@DropRoles bit = 0
as

set nocount on

 if @TargetDatabaseName is null
	begin
		print 'Usage: dbo.pRemoteRemoveSchemaUserRoleSecurity @InstanceName (Def = NULL), @TargetDatabaseName (Req''d), @Debug (Def = 0)'
		print ''
		print '         Examples: dbo.pRemoveSchemaUserRoleSecurity ''instance'', ''database_1''    -- Prints security from database_1'
		print '         Examples: dbo.pRemoveSchemaUserRoleSecurity ''instance'', ''database_1'', 0 -- Prints security from database_1'
		print '         Examples: dbo.pRemoveSchemaUserRoleSecurity ''instance'', ''database_1'', 1 -- Removes security from database_1'
		print ''
		return;
	end
	--exec pRemoveSchemaUserRoleSecurity2 'UKDBEDMAPPT01\DM01TST', 'CADIS_TEST_AFTER_M','\\CRASAPPDBA01\SelfServe\Security\Instance\UKDBEDMAPPT01@DM01TST\CADIS_TEST_AFTER_M'
 if @InstanceName is null --use local server if the instance is not provided
	select @InstanceName = @@SERVERNAME  

declare @CrLf char(2)
select @CrLf = char(13) + char(10)
declare @myid uniqueidentifier
set @myid = newid()

declare @lsTempName nvarchar(50) = 'tmp_' + cast(@myid as nvarchar(50))
select @lsTempName = replace(@lsTempName, '-','')

exec master.dbo.sp_addlinkedserver @server = @lsTempName, @srvproduct = '', @provider = 'SQLNCLI', @datasrc = @InstanceName
exec master.dbo.sp_addlinkedsrvlogin @rmtsrvname = @lsTempName, @locallogin = NULL , @useself = 'True'
exec master.dbo.sp_serveroption @server=@lsTempName, @optname=N'use remote collation', @optvalue=N'false'
exec master.dbo.sp_serveroption @server=@lsTempName, @optname=N'rpc', @optvalue=N'true'
exec master.dbo.sp_serveroption @server=@lsTempName, @optname=N'rpc out', @optvalue=N'true'


if @Debug = 0
    print 'Printing output of the remove only, will NOT execute'
else
    print 'Executing removal of Schemas, Users and Roles on ' + @InstanceName + '.' + @TargetDatabaseName

declare @cmd nvarchar(4000),
        @PrincipleUser nvarchar(200), 
        @PrincipleSchema nvarchar(200),
		@query nvarchar(max) = '',
		@queryTemp nvarchar(max) = ''

if @RetainAdmins = 1
	begin
		select @cmd = 
		'declare cur_user cursor for
		select p.name as ''PrincipleUser'', 
			   s.name as ''PrincipleSchema''
		  from ' + @lsTempName + '.' + @TargetDatabaseName + '.sys.database_principals p 
			  left outer join ' + @lsTempName + '.' + @TargetDatabaseName + '.sys.syslogins l on l.name = p.name
			  left outer join ' + @lsTempName + '.' + @TargetDatabaseName + '.sys.schemas s
			  on p.principal_id = s.principal_id 
		where p.type in (''S'', ''U'', ''G'') 
		  and is_fixed_role = 0 
		  and p.name not in (''dbo'', ''guest'', ''INFORMATION_SCHEMA'', ''sys'', ''public'')
			and ((l.securityadmin = 0) and (l.sysadmin = 0 ))
		for read only'
	end
 else
	 begin
		 select @cmd = 
		'declare cur_user cursor for
		 select p.name as ''PrincipleUser'', 
				s.name as ''PrincipleSchema''
		  from ' + @lsTempName + '.' + @TargetDatabaseName + '.sys.database_principals p 
			  left outer join ' + @lsTempName + '.' + @TargetDatabaseName + '.sys.syslogins l on l.name = p.name
			  left outer join ' + @lsTempName + '.' + @TargetDatabaseName + '.sys.schemas s
				on p.principal_id = s.principal_id 
		  where p.type in (''S'', ''U'', ''G'') 
			and is_fixed_role = 0 
			and p.name not in (''dbo'', ''guest'', ''INFORMATION_SCHEMA'', ''sys'', ''public'')
		 for read only'
	 end

exec (@cmd)


open cur_user
fetch next from cur_user into @PrincipleUser, @PrincipleSchema
while @@fetch_status <> -1
begin
    begin try
    
     if @PrincipleSchema is not null
		begin
		   select @queryTemp = 'PRINT ''*** Dropping Schema ' + @TargetDatabaseName + ' - ' + @PrincipleSchema + '''' + @CrLf
		   select @queryTemp = @queryTemp + 'USE [' + @TargetDatabaseName + ']' + @CrLf + 'DROP SCHEMA [' +  @PrincipleSchema + '];'
		   select @query = @query + @queryTemp + @CrLf + 'GO' + @CrLf + @CrLf
		end
		
     if @PrincipleUser is not null
		begin
		  select @queryTemp = 'PRINT ''*** Dropping User ' + @TargetDatabaseName + ' - ' + @PrincipleUser + '''' + @CrLf
          select @queryTemp = @queryTemp + 'USE [' + @TargetDatabaseName + ']' + @CrLf + 'DROP USER [' +  @PrincipleUser + '];'
		  select @query = @query + @queryTemp + @CrLf + 'GO' + @CrLf + @CrLf
        end  

    end try
    begin catch
        print error_message()
		return -1
    end catch
    fetch next from cur_user into @PrincipleUser, @PrincipleSchema
end

close cur_user
deallocate cur_user    


if @DropRoles = 1
  begin
		select @cmd = 
		'declare cur_user cursor for
		 select p.name as ''PrincipleUser'', 
				s.name as ''PrincipleSchema''
			from ' + @lsTempName + '.' + @TargetDatabaseName + '.sys.database_principals p 
				left outer join ' + @lsTempName + '.' + @TargetDatabaseName + '.sys.schemas s
				on p.principal_id = s.principal_id
		  where p.type in (''R'') 
			and is_fixed_role = 0 
			and p.name not in (''dbo'', ''guest'', ''INFORMATION_SCHEMA'', ''sys'', ''public'')
		 for read only'

		exec (@cmd)
		open cur_user
		fetch next from cur_user into @PrincipleUser, @PrincipleSchema
		while @@fetch_status <> -1
		begin
			begin try
			 if @PrincipleSchema is not null
				begin
				   select @queryTemp = 'PRINT ''*** Dropping Schema ' + @TargetDatabaseName + ' - ' + @PrincipleSchema + '''' + @CrLf
				   select @queryTemp = @queryTemp + 'USE [' + @TargetDatabaseName + ']' + @CrLf + 'DROP SCHEMA [' +  @PrincipleSchema + '];'
				   select @query = @query + @queryTemp + @CrLf + 'GO' + @CrLf + @CrLf
				end
		
			 if @PrincipleUser is not null
				begin
				  select @queryTemp = 'PRINT ''*** Dropping User ' + @TargetDatabaseName + ' - ' + @PrincipleUser + '''' + @CrLf
				  select @queryTemp = @queryTemp + 'USE [' + @TargetDatabaseName + ']' + char(13) + char(10) + 'DROP ROLE [' +  @PrincipleUser + '];'
				  select @query = @query + @queryTemp + @CrLf + 'GO' + @CrLf + @CrLf
				end  
			end try
			begin catch
				print error_message()
				return -2
			end catch
			fetch next from cur_user into @PrincipleUser, @PrincipleSchema
		end

		close cur_user
		deallocate cur_user   
  end

exec master.dbo.sp_dropserver @server=@lsTempName, @droplogins='droplogins' 

if datalength(@query) = 0
  begin
    select @query = '-- No users or roles found for DROP'
  end

exec SSDBAUtils.dbo.pWriteStringToFile @query, @ExtPath, 'dropTemp2.sql'

declare @DropFile nvarchar(1000) = @ExtPath +'\'+ 'dropTemp2.sql'
select @cmd = N'SQLCMD.EXE -S ' + @InstanceName + ' -E -d ' + @TargetDatabaseName + ' -i "' + @DropFile + '"'

if @Debug = 1 exec xp_cmdshell @cmd

;
GO
/****** Object:  StoredProcedure [dbo].[pRenameDatabase]    Script Date: 10/19/2022 1:44:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[pRenameDatabase] @OldDatabaseName sysname, @NewDatabaseName sysname, @Debug bit = 0
as
set nocount on
select
    sb.name as DatabaseName, 
	mf.name as OldLogicalName, 
	mf.physical_name as OldPhysicalName,
	cast('' as nvarchar(100)) as NewLogicalName,
    cast('' as nvarchar(256)) as NewPhysicalName,
	cast('' as nvarchar(256)) as NewPhysicalFileName
	into #DBInfo
	from master.sys.master_files mf 
	inner join master.sys.databases sb on sb.database_id = mf.database_id
	where sb.name = @OldDatabaseName

if @@ROWCOUNT = 0
  begin
	raiserror (N'Database [%s] is not found.', 12, 1, @OldDatabaseName)
	return(-1)
  end

select sb.name as DatabaseName, mf.name as LogicalName, mf.physical_name as PhysicalName
from master.sys.master_files mf 
inner join master.sys.databases sb on sb.database_id = mf.database_id
where sb.name = @NewDatabaseName

if @@ROWCOUNT <> 0
  begin
	raiserror (N'Database [%s] is found, cannot rename.', 12, 1, @NewDatabaseName)
	return(-2)
  end

declare @Rand int = 0,
        @sRand nvarchar(10) = '',
		@NewLogicalName nvarchar(100), 
		@OldLogicalName nvarchar(100),
		@NewPhysicalName nvarchar(256),
	    @OldPhysicalName nvarchar(256),
		@NewPhysicalFileName nvarchar(100)

select @Rand = cast(RAND() * 10000 AS INT)
select @sRand = '_' + cast(@Rand as nvarchar) 



update #DBInfo set NewLogicalName = OldLogicalName + @sRand,
				   NewPhysicalName = reverse(stuff(reverse(OldPhysicalName),charindex('.',reverse(OldPhysicalName), 0)+1,0, reverse(@sRand)))

update #DBInfo set NewPhysicalFileName = reverse(left(reverse(NewPhysicalName), charindex('\',reverse(NewPhysicalName), 1) - 1))

if @Debug = 0 select  NewPhysicalFileName, NewLogicalName, NewPhysicalName from #DBInfo

declare @cmdString nvarchar(max),
        @cmdString2 nvarchar(max),
		@Counter int = 0

--single user
select @cmdString = 'alter database ' + @OldDatabaseName + ' set single_user with rollback immediate'

if @Debug = 0 exec (@cmdString)
select @cmdString

declare curFile cursor for select NewLogicalName, OldLogicalName, NewPhysicalName, OldPhysicalName, NewPhysicalFileName from #DBInfo
open curFile
fetch next from curFile into @NewLogicalName, @OldLogicalName, @NewPhysicalName, @OldPhysicalName, @NewPhysicalFileName
while @@FETCH_STATUS = 0
  begin
    select @cmdString = 'alter database ' + @OldDatabaseName + ' modify file (name=''' + @OldLogicalName +''', newname=''' + @NewLogicalName + ''')'
    --changing logical file names
	if @Debug = 0 exec (@cmdString)
    select @cmdString

    fetch next from curFile into  @NewLogicalName, @OldLogicalName, @NewPhysicalName, @OldPhysicalName, @NewPhysicalFileName
  end
  close curFile
  deallocate curFile

  --detaching
  select @cmdString2 = 'exec master.dbo.sp_detach_db ' + @OldDatabaseName
  if @Debug = 0 exec (@cmdString2)
  select @cmdString2

  --waitfor delay '00:00:05'

  select @cmdString2 = 'exec master.dbo.sp_attach_db @dbname = ''' + @NewDatabaseName + ''''
  select @Counter = 1
  declare curFile2 cursor for select NewLogicalName, OldLogicalName, NewPhysicalName, OldPhysicalName, NewPhysicalFileName from #DBInfo
open curFile2
fetch next from curFile2 into @NewLogicalName, @OldLogicalName, @NewPhysicalName, @OldPhysicalName, @NewPhysicalFileName
while @@FETCH_STATUS = 0
  begin
    --take ownership change each file
	select @cmdString = 'exec xp_cmdshell ''takeown /F  "' + @OldPhysicalName + '"''' 
    if @Debug = 0 exec (@cmdString)
    select @cmdString

    --permission change each file
	select @cmdString = 'exec xp_cmdshell ''icacls "' + @OldPhysicalName + '" /grant:r Administrators:F''' 
    if @Debug = 0 exec (@cmdString)
    select @cmdString

	--renaming each file
    select @cmdString = 'exec xp_cmdshell ''rename ' + '"' + @OldPhysicalName + '", "' + @NewPhysicalFileName +'"'''
    if @Debug = 0 exec (@cmdString)
    select @cmdString

	select @cmdString2 = @cmdString2 + ', @filename' + cast(@Counter as nvarchar) + ' = ''' +  @NewPhysicalName + ''''
	select @Counter = @Counter + 1
    fetch next from curFile2 into  @NewLogicalName, @OldLogicalName, @NewPhysicalName, @OldPhysicalName, @NewPhysicalFileName
  end
  close curFile2
  deallocate curFile2


  --attaching
  if @Debug = 0 exec (@cmdString2)
  select @cmdString2

  --multiuser
  select @cmdString = 'alter database ' + @NewDatabaseName + ' set multi_user'

  if @Debug = 0 exec (@cmdString)
  select @cmdString

 



GO
/****** Object:  StoredProcedure [dbo].[pRestoreDBMultiWithOverride]    Script Date: 10/19/2022 1:44:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[pRestoreDBMultiWithOverride]
     (
          @p_inputfiletype  sysname,
          @p_sourceinstance sysname,
          @p_sourcedbname sysname,
          @p_targetdbname sysname,
          @p_inputfile1  nvarchar(256),--sysname,
          @p_inputfile2 nvarchar(256),--sysname,
          @p_restoredate datetime = null,
          @p_DataDriveOverride char(2) = null,
	      @p_LogDriveOverride char(2) = null,
	      @p_debug bit = 0 
     )

----------------------------------------------------------------------------------------
--  MODIFICATION HISTORY
--  Initial Version
--	DATE/WHAT		WHO		VERSION
--  02/01/2012		Scott	1.0
--  03/22/2012		Steve	1.1
--  09/10/2014      Tb      2.0
--  Fix bug with setting of @i_skiplogs variable
-- 2.0 Allow for restore of mixed number of data and log files in the restore bak/dif files
----------------------------------------------------------------------------------------
AS

SET NOCOUNT on
SET FMTONLY OFF 

declare 
        @this_server			sysname,
        @procname			varchar(255),
        @procversion		varchar(4),
        @sqlfixsp				Varchar(32),
        @executestmt		nvarchar(4000),
        @executestmt2	varchar(4000),
        @executestmt3	varchar(4000),
        @sqlcmd				varchar(4000),
        @dircmd				varchar(4000),        
        @executeprefix		nvarchar(100),
        @princname			sysname,
        @dbcnt					integer,
        @schemacnt			integer,
        @scriptcnt				integer,
        @scriptpegdbname sysname,                              
        @fullscriptfile			varchar(2000),
        @devtrack			varchar(1),         
        @dummy				varchar,
        @dbmdbrgfoldernodename varchar(32),
        @pegasyssecmode varchar(32),
        @startime datetime,
        @login_time datetime,
        @spid integer,
        @dbname sysname,
        @status sysname,
        @loginame sysname,
        @msg sysname,
        @hostname sysname,
        @program_name sysname,
        @cmd sysname,
        @uid sysname,
        @nt_username sysname,
        @sid varchar,
        @i_skiplogs varchar

declare @source_server_name sysname,
          @cur_source_server_name sysname,
          @source_database_name  sysname,
          @cur_source_database_name sysname,
          @target_database_name  sysname,
          @cur_target_database_name sysname,         

        @reporting_timespan sysname,
        @deleteexisting sysname,

        @datestmt       varchar(4000),
        @output         sysname,
        @ErrorString varchar(255),
        @HdrString varchar(255),
        @sqlfixstr varchar(100),


        @princ_name varchar(75),

          @temp_database_name  varchar(50),
        @temp_server_name varchar(50),
        @temp_princ_name varchar(75),
        @temp_princ_id varchar(16),
        @temp_recno integer,
        @temp_perm_state varchar(30),
         @servercnt integer,        
  
        @role varchar(50),
        @roleconcat varchar(250),
        @rolecnt integer ,
        @frole VARchar(50),
        @froleconcat varchar(250),
        @frolecnt integer,
        @typrun varchar(5),
        @msgindent int,    
        @killStatements             varchar(4000)  
        


--- Set Proc name, etc
Select @this_server = @@Servername
Set @procname = 'dbo.SS_PROC_RestoreDB_WithOverride'
set @procversion = '2.0'
Set @sqlfixsp = ''
--set @pegasyssecmode ='STANDARD'

if ((@p_debug <> 0 and @p_debug <> 1) or @p_debug is null )
  begin
    select @p_debug = 1 --assume debug on for bad parm
  end
  
if (@p_debug = 1 )
  begin
    print 'DEBUGGER is ON'
  end

--- Check and set parms
IF ((Upper(@p_inputfiletype) <> 'FILE') and (Upper(@p_inputfiletype) <> 'LASTBKUP'))
     BEGIN
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE parm *****'
          GOTO CLEANUP
     END
Else
    set @p_inputfiletype = Upper(@p_inputfiletype)

IF ((@p_inputfile1 IS Null) or (@p_inputfile1 = ''))
     BEGIN
     If @p_inputfiletype = 'FILE'
		Begin
          print ' ***** ERROR OCCURRED - INPUFILETYPE=FILE specified but no Files provided in parms *****'
          GOTO CLEANUP
		End
     END
Else

-- Note that @inputfile2 cannot be validated since it is always optional

IF ((@p_sourceinstance IS Null) or (@p_sourceinstance = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no SOURCEINSTANCE parm provided *****'
          GOTO CLEANUP
		End
     END
Else

IF ((@p_sourcedbname IS Null) or (@p_sourcedbname = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no SOURCEDBNAME parm provided *****'
          GOTO CLEANUP
		End
     END
Else

IF ((@p_targetdbname IS Null) or (@p_targetdbname = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no TARGETDBNAME parm provided *****'
          GOTO CLEANUP
		End
     END



-- Parms are ok but lets make sure that target db exists in svr before we go any further
select @dbcnt = COUNT(*) from sys.sysdatabases where name = ''+@p_targetdbname+''
If @dbcnt <= 0
	Begin
		print ' ***** ERROR OCCURRED - Target database '+Upper(@p_targetdbname)+' cannot be found on the current server *****'
		GOTO CLEANUP
	end
	
-- Check for sessions in the database to be restored

DECLARE cursor_normal_spid_detector CURSOR
FOR
  select 
  spid, 
  LTRIM(status), 
  SUBSTRING(sid,1,16), 
  login_time, 
  loginame, 
  LTRIM(hostname), 
  LTRIM(program_name), 
  LTRIM(cmd), 
  uid, 
  nt_username, 
  db_name(dbid) dbname
  from  
  master.dbo.sysprocesses
  where 
	spid <> @@spid       -- not current process
	and db_name(dbid) = @p_targetdbname 
	and loginame <> 'sa' 			-- exclude sa
  FOR READ ONLY
-- Open Direct SPID Cursor
  open cursor_normal_spid_detector
  select @startime = getdate()				
-- Fetch next from Direct SPID cursor
  FETCH NEXT FROM cursor_normal_spid_detector INTO @spid, @status, @sid, @login_time, @loginame, @hostname, @program_name, @cmd, @uid, @nt_username, @dbname
  IF (@@fetch_status = 0)
     BEGIN
       Select @msg = 'The following users are logged into target database '+ LTrim(Rtrim(@dbname))  
       Print @msg
       select @killStatements = '/* Optional kill spid statements ' + char(13) + char(10) 
       WHILE (@@fetch_status = 0) 
         BEGIN
           Select @msg=' '
	       Select @msg = @msg   + 'SPID=' + LTrim(Rtrim(@spid))
	                            + ' Login Name=' + LTrim(Rtrim(@loginame))
	                            + ' Status=' + LTrim(Rtrim(@status))
		            			+ ' Login Time=' + Ltrim(RTrim(cast(@login_time as varchar(30))))
		 		    		    + ' Hostname=' + LTrim(Rtrim(@hostname))
		 			    	    + ' Program Name=' + LTrim(Rtrim(@program_name))
	       Print @msg 	
	       select @killStatements = @killStatements + ' kill ' + cast(@spid as varchar) 	+ char(13) + char(10)	
	       FETCH NEXT FROM cursor_normal_spid_detector INTO @spid, @status, @sid, @login_time, @loginame,  @hostname, @program_name, @cmd, @uid, @nt_username, @dbname  
	     END
       close cursor_normal_spid_detector
	   deallocate cursor_normal_spid_detector
	   select @killStatements = @killStatements + '*/ ' + char(13) + char(10)
	   print @killStatements
           Print 'Restore of database '+ LTrim(Rtrim(@dbname)) + ' is terminating.'
	   GOTO CLEANUP
     END
   ELSE 
     BEGIN
       close cursor_normal_spid_detector
	   deallocate cursor_normal_spid_detector
     END  
-- Log activity/errors
select @ErrorString =  'BEGINNING PROCEDURE ' +@procname+ ' (Version ' + CONVERT(varchar(3), @procversion) + ') at ' + CONVERT(varchar(30), GETDATE(), 109) + '.'
select @HdrString = replicate('*',datalength(@ErrorString))
print @HdrString
print @ErrorString

	
-- STEP #1 - Database Restore Step
-- STEP #1A - LASTBKUP Type
/*
Parameters

@source_instance	optional		The name of the instance that contains the source database. If excluded, the restore will read from the current instance.
@source_db	required			The name of the source database to restore from.
@dest_db	optional					The name of the destination database to restore to. If excluded, the restored database will use the same name as the source database. 
@skip_logs	optional				Set to 1 and no log files will be restored. Used if you only want to restore a full or differential backup. If excluded, the restore will use any available log backup files.
@restore_date	optional			The date and time to restore to. If excluded, the current date and time will be used.
@data_directory	optional		The directory in which all restored data files will be placed. If omitted, the procedure will determine the appropriate directory from the current destination database if it exists, or will use the instance default locations if not.
@log_directory	optional			The directory in which all restored log files will be placed. If omitted, the procedure will determine the appropriate directory from the current destination database if it exists, or will use the instance default locations if not.
@debug	optional					Set to 1 and the procedure will print the restore commands to the screen without executing them.
		

*/
--GOTO ADDSEC
--GOTO STRIPSEC

IF @p_inputfiletype = 'LASTBKUP'
   	Begin
   	  select @ErrorString =  'Starting Restore step at ' + CONVERT(varchar(30), GETDATE(), 109) + '.'
 	  Print @ErrorString 
	  if @p_restoredate is null
	    begin
	      Set @i_skiplogs = '1'
          Select @executestmt = 'exec dbutils.dbo.sp_restore_db @source_instance = ''' + @p_sourceinstance + ''', @source_db = ''' +@p_sourcedbname + ''', @dest_db = '''+ @p_targetdbname +''', @skip_logs='+@i_skiplogs+', @debug='+cast(@p_debug as CHAR(1))
	    end
	  else
	    begin
	      Set @i_skiplogs = '0'
	      Select @executestmt = 'exec dbutils.dbo.sp_restore_db @source_instance = ''' + @p_sourceinstance + ''', @source_db = ''' +@p_sourcedbname + ''', @dest_db = '''+ @p_targetdbname +''', @skip_logs='+@i_skiplogs+', @debug='+cast(@p_debug as CHAR(1))+', @restore_date='''+convert(nvarchar,@p_restoredate,121)+''''
	    end	    
 	   
	 -- Run the restore 
	 print @executestmt
	 execute (@executestmt)
	
		GOTO CLEANUP
	End
    	
-- STEP #1B - File Type
Else
	Begin
	    /*Tb Mixed restore files 09/10/2014*/
	    declare @p_inputfile1_supplied bit = 0,
                @p_inputfile2_supplied bit = 0,
                @count tinyint = 1,
                @moveclause varchar(4000) = '',
                @lname varchar(128),
                @pname varchar(260),
                @ppath varchar(260),
                @fname varchar(50),
                @recoveryclause varchar(10),
                @restorestmt varchar(4000),
                @xpcmd varchar (2000),
                @result int
                
        select @p_inputfile1_supplied = 1,  --make it to here, a file has been supplied
               @p_inputfile2_supplied = case when (@p_inputfile2 IS Null) or (@p_inputfile2 = '') then 0 else 1 end
 


        --get the files from the existing db to be replaced
        if ( @p_inputfile1_supplied = 1)
          begin
			  create table #BakDifTmp (
					LogicalName nvarchar(128), 
					PhysicalName nvarchar(260),
					[Type] char(1),
					FileGroupName nvarchar(128),
					Size numeric(20,0) ,
					MaxSize numeric(20,0),
					Fileid	tinyint,
					CreateLSN numeric(25,0),
					DropLSN numeric(25, 0),
					UniqueID uniqueidentifier,
					ReadOnlyLSN numeric(25,0),
					ReadWriteLSN numeric(25,0),
					BackupSizeInBytes bigint,
					SourceBlockSize int,
					FileGroupId int,
					LogGroupGUID uniqueidentifier,
					DifferentialBaseLSN numeric(25,0),
					DifferentialBaseGUID uniqueidentifier,
					IsReadOnly bit,
					IsPresent bit, 
					TDEThumbprint varbinary(32))

			--added column on 2016 of SnapShotURL
		    declare @SQLversion nvarchar(20) 
            select @SQLversion = convert(nvarchar(25),SERVERPROPERTY('productversion'))
			if @SQLversion >= '13'
			  begin
			     alter table #BakDifTmp add SnapshotUrl nvarchar(360)
			  end
            
            --have to go and query the sys.master_files table to get the list of data and log files, #targetdbfiles(1)
            select database_id,file_id,type,data_space_id,name,physical_name, substring(physical_name, 1,2) as drive,
                   case type when 0 then 'row'
                             when 1 then 'log'
                             when 2 then 'fs' else 'unkn' end as filetype,
                   substring(left(physical_name,len(physical_name) - charindex('\',reverse(physical_name),1) + 1),3,len(physical_name) - 2) as fpath,
                   reverse(left(reverse(physical_name),charindex('\', reverse(physical_name), 1) - 1)) as fname,
                   db_name(database_id) as [db_name],
                   processed = 0
            into #targetdbfiles1 
            from sys.master_files where database_id = db_id(@p_targetdbname)


			
				
            --hold bak file elements
			select @executestmt3 = 'restore filelistonly from disk = ''' + @p_inputfile1 + ''''
			insert #BakDifTmp exec (@executestmt3)
                
            select logicalname as bak_logname, 
			       physicalname as bak_physname, 
			       t.[type] as bak_ftype, 
			       drive as db_drive,
			       cast(null as CHAR(2)) as DataDriveOverride,
			       cast(null as CHAR(2)) as LogDriveOverride, 
			       fpath as db_path, 
			       fname as db_file,
			       [db_name] as [db_name],
			       0 as processed
			into #restoreelements
			from #BakDifTmp t left outer join #targetdbfiles1 tgt on t.Fileid = tgt.[file_id] --on t.logicalname = tgt.name

                --Bak file restore
                update  #restoreelements set [db_name] = (select top 1 [db_name] from #restoreelements where [db_name] is not null)                                               

				--make some assumptions about placement of data files for .Bak extra file(s)
				update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'D'),
									 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'D'),
									 db_file = 'DtaBak_' + [db_name] + bak_logname + '.ndf'
								 where db_drive is null and bak_ftype = 'D' 
                                 
				--make some assumptions about placement of log files for .Bak file extra file(s)
				update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'L'),
									 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'L'),
									 db_file = 'LogBak_' + [db_name] + bak_logname + '.ldf'
								 where db_drive is null and bak_ftype = 'L' 
								 
				--override placement of the data files by drive letter				 
				if (@p_DataDriveOverride is not null)
				    update #restoreelements set DataDriveOverride = @p_DataDriveOverride where bak_ftype = 'D'
				if (@p_LogDriveOverride is not null)
				    update #restoreelements set LogDriveOverride = @p_LogDriveOverride where bak_ftype = 'L'
 				
 				select @recoveryclause = case when (@p_inputfile2_supplied = 0) then 'recovery' else 'norecovery' end
 	---------------------------------------------------
	 --is this multifile restore or single file restore
		create table #RestoreLabel
		(
			MediaName	nvarchar(128) null,
			MediaSetId	uniqueidentifier null,
			FamilyCount	int null,
			FamilySequenceNumber	int null,
			MediaFamilyId	uniqueidentifier null,
			MediaSequenceNumber	int null,
			MediaLabelPresent	tinyint null,
			MediaDescription	nvarchar(255) null,
			SoftwareName	nvarchar(128) null,
			SoftwareVendorId	int null,
			MediaDate	datetime null,
			Mirror_Count	int null,
			IsCompressed	bit null
		)
		declare @FamilyCount int = 0, @MediaFamilyId varchar(50), @MediaSetID int = 0

		insert into #RestoreLabel exec ('restore labelonly from disk=''' + @p_inputfile1 + '''')

	
	--select @FamilyCount = FamilyCount, @MediaFamilyId = MediaFamilyId  from #RestoreLabel
	--select @FamilyCount, '@FamilyCount',@MediaFamilyId,'@MediaFamilyId'

	if @FamilyCount = 1
	  begin
	    print 'Singlefile restore starting'
		select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile1+''' with replace, stats=10, ' + @recoveryclause + ', '
	  end
	else
	  begin
		print 'Multifile restore starting'
		declare @cmd1 nvarchar(1000) = 'restore database ' + @p_targetdbname + ' from ' + char(13),
		@cmd2 nvarchar(1000) = '',
		@cmd3 nvarchar(1000) = 'with stats = 10, replace, ',
		@cmdTmp nvarchar(1000) = '',
		@cmdFinal nvarchar(4000),
		@counter int = 1,
		@NumberOfFiles int = 1,
		@strCount varchar(2),
		@Label varchar(10),
		@strNumFiles varchar(2)

		select @NumberOfFiles = cast(right(left(right(@p_inputfile1,10),6),2) as int)
		select @p_inputfile1 = reverse(@p_inputfile1)
		select @p_inputfile1 = substring(@p_inputfile1,11,DATALENGTH(@p_inputfile1))
		select @p_inputfile1 = reverse(@p_inputfile1)


		while @counter <= @NumberOfFiles
		  begin
		  	  select @strNumFiles = case when @NumberOfFiles < 10 then '0' + cast(@NumberOfFiles as nvarchar) else cast(@NumberOfFiles as nvarchar) end
	          select @strCount = case when @counter < 10 then '0' + cast(@counter as nvarchar) else cast(@counter as nvarchar) end

			  select @Label = @strCount + 'of' + @strNumFiles + '.bak'

			  select @cmdTmp = 'disk=''' + @p_inputfile1 + @Label +''',' + char(13) 
			  --select @cmdTmp , 'cmdTmp'
			  if @counter = @NumberOfFiles
				begin
				  select @cmdTmp = replace(@cmdTmp,',','')
				end
		
				select @cmd2 = @cmd2 + @cmdTmp
				select @counter = @counter + 1
		  end

		  select @executestmt3 = @cmd1 + @cmd2 + @cmd3
		  --print @executestmt3

	  end
	
	----------------------------------------------------			
				--select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile1+''' with replace, stats=10, ' + @recoveryclause + ', '


                

				while (select count(*) from #restoreelements where processed = 0 ) > 0
					begin

						select top 1 @lname = bak_logname,
									 @pname = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path + db_file
						                           when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path + db_file
						                           else 'Undefined'
						                      end,
						             @ppath = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path
						                           when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path
						                           else 'Undefined'
						                      end    
    
						from #restoreelements where processed = 0 
						
						--create directory if not exists
						select @xpcmd = 'dir ' + @ppath
						exec @result = xp_cmdshell @xpcmd, no_output
						if @result <> 0
						  begin
						    print 'Creating Directory'
						  	select @xpcmd = 'mkdir ' + @ppath
						  	if @p_debug = 0
							  begin
						        exec @result = xp_cmdshell @xpcmd, no_output
								print @xpcmd
                              end
						    else
						      print @xpcmd
						  end 

					   select @moveclause = 'move ''' + @lname + ''' to ''' + @pname + ''',' from #restoreelements
					   select @executestmt3 = @executestmt3 + @moveclause

					   update #restoreelements set processed = 1 where bak_logname = @lname 
					end

				select @executestmt3 = substring(@executestmt3, 1, datalength(@executestmt3)-1) --remove trailing comma
				
				print '*** RESTORE with MOVE on bak file *** '
				if @p_debug = 0
					begin
						print  @executestmt3
    					execute (@executestmt3)
					end
                else
                    print  @executestmt3

               
            --Dif file restore
            --have to go and requery the sys.master_files table to get the NEW list (if any) data and log files from previous bak file restore. Hence, #targetdbfiles(2)

            select database_id,file_id,type,data_space_id,name,physical_name, substring(physical_name, 1,2) as drive,
                   case type when 0 then 'row'
                             when 1 then 'log'
                             when 2 then 'fs' else 'unkn' end as filetype,
                   substring(left(physical_name,len(physical_name) - charindex('\',reverse(physical_name),1) + 1),3,len(physical_name) - 2) as fpath,
                   reverse(left(reverse(physical_name),charindex('\', reverse(physical_name), 1) - 1)) as fname,
                   db_name(database_id) as [db_name],
                   processed = 0
            into #targetdbfiles2 
            from sys.master_files where database_id = db_id(@p_targetdbname)

             --clear out previous bak information
        		truncate table #BakDifTmp
        		truncate table #restoreelements
        		
				select @executestmt3 = 'restore filelistonly from disk = ''' + @p_inputfile2 + ''''
				insert #BakDifTmp exec (@executestmt3)

                
                if (@p_inputfile2_supplied = 1)
					begin
						insert into #restoreelements
						select logicalname as bak_logname, 
							   physicalname as bak_physname, 
							   t.[type] as bak_ftype, 
							   drive as db_drive,
							   null as DataDriveOverride,
							   null as LogDriveOverride, 
							   fpath as db_path, 
							   fname as db_file,
							   [db_name] as [db_name],
							   0 as processed
						from #BakDifTmp t left outer join #targetdbfiles2 tgt on  t.Fileid = tgt.[file_id]--on t.logicalname = tgt.name
					
					update  #restoreelements set [db_name] = (select top 1 [db_name] from #restoreelements where [db_name] is not null)                                               

					--make some assumptions about placement of data files for Dif file
					update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'D'),
										 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'D'),
										 db_file = 'DtaDif_' + [db_name] + bak_logname + '.ndf'
									 where db_drive is null and bak_ftype = 'D' 
	                                 
					--make some assumptions about placement of log files for Dif file
					update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'L'),
										 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'L'),
										 db_file = 'LogDif_' + [db_name] + bak_logname + '.ldf'
									 where db_drive is null and bak_ftype = 'L' 
					
					--override placement of the log files by drive letter				 
					if (@p_DataDriveOverride is not null)
						update #restoreelements set DataDriveOverride = @p_DataDriveOverride where bak_ftype = 'D'
					if (@p_LogDriveOverride is not null)
						update #restoreelements set LogDriveOverride = @p_LogDriveOverride where bak_ftype = 'L'


---------------------------------------------------------
















---------------------------------------------------------
         
					select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile2+''' with replace, stats=10, recovery, '
                    
					while (select count(*) from #restoreelements where processed = 0 ) > 0
						begin
						--select * from #restoreelements
							select top 1 @lname = bak_logname,
										 @pname = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path + db_file
						                               when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path + db_file
						                               else 'Undefined'
						                          end,
						                 @ppath = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path
						                               when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path
						                               else 'Undefined'
						                      end      

							from #restoreelements where processed = 0 

						--create directory if not exists
						select @xpcmd = 'dir ' + @ppath
						exec @result = xp_cmdshell @xpcmd, no_output
						if @result <> 0
						  begin
						    print 'Creating Directory'
						  	select @xpcmd = 'mkdir ' + @ppath
						    if @p_debug = 0
						      begin
						        exec @result = xp_cmdshell @xpcmd, no_output
								print @xpcmd
                              end
						    else
						      print @xpcmd
						  end 


						   select @moveclause = 'move ''' + @lname + ''' to ''' + @pname + ''',' from #restoreelements
						   select @executestmt3 = @executestmt3 + @moveclause

						   update #restoreelements set processed = 1 where bak_logname = @lname 

						end

						select @executestmt3 = substring(@executestmt3, 1, datalength(@executestmt3)-1) --remove trailing comma
						
						print '*** RESTORE with MOVE on dif file *** '
						if @p_debug = 0
						  begin
						    print  @executestmt3
    						execute (@executestmt3)
						  end
						else
							print  @executestmt3
 					end

          end   
               
        /*Tb Mixed restore files 09/10/2014*/
		if @p_debug = 0
			begin
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE WITH NO_WAIT;'
				Print @executestmt
				execute (@executestmt)
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE;'
				Print @executestmt
				execute (@executestmt)
				select @executestmt = 'ALTER AUTHORIZATION ON DATABASE::[' + @p_targetdbname + '] TO sa'
				Print @executestmt
				execute (@executestmt) 	
				select @executestmt = 'select type_desc as Type, name as LogicalName, physical_name as FileLocation from [' + @p_targetdbname + '].sys.database_files'
		        execute (@executestmt)  
			end
        else
			begin
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE WITH NO_WAIT;'
				Print @executestmt
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE;'
				Print @executestmt
				select @executestmt = 'ALTER AUTHORIZATION ON DATABASE::[' + @p_targetdbname + '] TO sa'
				Print @executestmt
			end   
			     
      
                    

		goto CLEANUP						
	End


-- Clean Up
CLEANUP:

IF (object_id('cur_user') IS NOT Null)
     BEGIN
          CLOSE cur_user
          DEALLOCATE cur_user
    END    
IF (object_id('cur_role') IS NOT Null)
     BEGIN
          CLOSE cur_role
          DEALLOCATE cur_role 
     END 
 IF (object_id('#tblsqlscripts') IS NOT Null)
     BEGIN
		 DROP TABLE #tblSQLScripts
     END     

SET ANSI_NULLS OFF








GO
/****** Object:  StoredProcedure [dbo].[pRestoreDBWithOverride]    Script Date: 10/19/2022 1:44:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[pRestoreDBWithOverride]
     (
          @p_inputfiletype  sysname,
          @p_sourceinstance sysname,
          @p_sourcedbname sysname,
          @p_targetdbname sysname,
          @p_inputfile1  nvarchar(256),--sysname,
          @p_inputfile2 nvarchar(256),--sysname,
          @p_restoredate datetime = null,
          @p_DataDriveOverride char(2) = null,
	      @p_LogDriveOverride char(2) = null,
	      @p_debug bit = 0 
     )

----------------------------------------------------------------------------------------
--  MODIFICATION HISTORY
--  Initial Version
--	DATE/WHAT		WHO		VERSION
--  02/01/2012		Scott	1.0
--  03/22/2012		Steve	1.1
--  09/10/2014      Tb      2.0
--  Fix bug with setting of @i_skiplogs variable
-- 2.0 Allow for restore of mixed number of data and log files in the restore bak/dif files
----------------------------------------------------------------------------------------
AS

SET NOCOUNT on
SET FMTONLY OFF 

declare 
        @this_server			sysname,
        @procname			varchar(255),
        @procversion		varchar(4),
        @sqlfixsp				Varchar(32),
        @executestmt		nvarchar(4000),
        @executestmt2	varchar(4000),
        @executestmt3	varchar(4000),
        @sqlcmd				varchar(4000),
        @dircmd				varchar(4000),        
        @executeprefix		nvarchar(100),
        @princname			sysname,
        @dbcnt					integer,
        @schemacnt			integer,
        @scriptcnt				integer,
        @scriptpegdbname sysname,                              
        @fullscriptfile			varchar(2000),
        @devtrack			varchar(1),         
        @dummy				varchar,
        @dbmdbrgfoldernodename varchar(32),
        @pegasyssecmode varchar(32),
        @startime datetime,
        @login_time datetime,
        @spid integer,
        @dbname sysname,
        @status sysname,
        @loginame sysname,
        @msg sysname,
        @hostname sysname,
        @program_name sysname,
        @cmd sysname,
        @uid sysname,
        @nt_username sysname,
        @sid varchar,
        @i_skiplogs varchar

declare @source_server_name sysname,
          @cur_source_server_name sysname,
          @source_database_name  sysname,
          @cur_source_database_name sysname,
          @target_database_name  sysname,
          @cur_target_database_name sysname,         

        @reporting_timespan sysname,
        @deleteexisting sysname,

        @datestmt       varchar(4000),
        @output         sysname,
        @ErrorString varchar(255),
        @HdrString varchar(255),
        @sqlfixstr varchar(100),


        @princ_name varchar(75),

          @temp_database_name  varchar(50),
        @temp_server_name varchar(50),
        @temp_princ_name varchar(75),
        @temp_princ_id varchar(16),
        @temp_recno integer,
        @temp_perm_state varchar(30),
         @servercnt integer,        
  
        @role varchar(50),
        @roleconcat varchar(250),
        @rolecnt integer ,
        @frole VARchar(50),
        @froleconcat varchar(250),
        @frolecnt integer,
        @typrun varchar(5),
        @msgindent int,    
        @killStatements             varchar(4000)  
        


--- Set Proc name, etc
Select @this_server = @@Servername
Set @procname = 'dbo.SS_PROC_RestoreDB_WithOverride'
set @procversion = '2.0'
Set @sqlfixsp = ''
--set @pegasyssecmode ='STANDARD'

if ((@p_debug <> 0 and @p_debug <> 1) or @p_debug is null )
  begin
    select @p_debug = 1 --assume debug on for bad parm
  end
  
if (@p_debug = 1 )
  begin
    print 'DEBUGGER is ON'
  end

--- Check and set parms
IF ((Upper(@p_inputfiletype) <> 'FILE') and (Upper(@p_inputfiletype) <> 'LASTBKUP'))
     BEGIN
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE parm *****'
          GOTO CLEANUP
     END
Else
    set @p_inputfiletype = Upper(@p_inputfiletype)

IF ((@p_inputfile1 IS Null) or (@p_inputfile1 = ''))
     BEGIN
     If @p_inputfiletype = 'FILE'
		Begin
          print ' ***** ERROR OCCURRED - INPUFILETYPE=FILE specified but no Files provided in parms *****'
          GOTO CLEANUP
		End
     END
Else

-- Note that @inputfile2 cannot be validated since it is always optional

IF ((@p_sourceinstance IS Null) or (@p_sourceinstance = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no SOURCEINSTANCE parm provided *****'
          GOTO CLEANUP
		End
     END
Else

IF ((@p_sourcedbname IS Null) or (@p_sourcedbname = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no SOURCEDBNAME parm provided *****'
          GOTO CLEANUP
		End
     END
Else

IF ((@p_targetdbname IS Null) or (@p_targetdbname = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no TARGETDBNAME parm provided *****'
          GOTO CLEANUP
		End
     END



-- Parms are ok but lets make sure that target db exists in svr before we go any further
select @dbcnt = COUNT(*) from sys.sysdatabases where name = ''+@p_targetdbname+''
If @dbcnt <= 0
	Begin
		print ' ***** ERROR OCCURRED - Target database '+Upper(@p_targetdbname)+' cannot be found on the current server *****'
		GOTO CLEANUP
	end
	
-- Check for sessions in the database to be restored

DECLARE cursor_normal_spid_detector CURSOR
FOR
  select 
  spid, 
  LTRIM(status), 
  SUBSTRING(sid,1,16), 
  login_time, 
  loginame, 
  LTRIM(hostname), 
  LTRIM(program_name), 
  LTRIM(cmd), 
  uid, 
  nt_username, 
  db_name(dbid) dbname
  from  
  master.dbo.sysprocesses
  where 
	spid <> @@spid       -- not current process
	and db_name(dbid) = @p_targetdbname 
	and loginame <> 'sa' 			-- exclude sa
  FOR READ ONLY
-- Open Direct SPID Cursor
  open cursor_normal_spid_detector
  select @startime = getdate()				
-- Fetch next from Direct SPID cursor
  FETCH NEXT FROM cursor_normal_spid_detector INTO @spid, @status, @sid, @login_time, @loginame, @hostname, @program_name, @cmd, @uid, @nt_username, @dbname
  IF (@@fetch_status = 0)
     BEGIN
       Select @msg = 'The following users are logged into target database '+ LTrim(Rtrim(@dbname))  
       Print @msg
       select @killStatements = '/* Optional kill spid statements ' + char(13) + char(10) 
       WHILE (@@fetch_status = 0) 
         BEGIN
           Select @msg=' '
	       Select @msg = @msg   + 'SPID=' + LTrim(Rtrim(@spid))
	                            + ' Login Name=' + LTrim(Rtrim(@loginame))
	                            + ' Status=' + LTrim(Rtrim(@status))
		            			+ ' Login Time=' + Ltrim(RTrim(cast(@login_time as varchar(30))))
		 		    		    + ' Hostname=' + LTrim(Rtrim(@hostname))
		 			    	    + ' Program Name=' + LTrim(Rtrim(@program_name))
	       Print @msg 	
	       select @killStatements = @killStatements + ' kill ' + cast(@spid as varchar) 	+ char(13) + char(10)	
	       FETCH NEXT FROM cursor_normal_spid_detector INTO @spid, @status, @sid, @login_time, @loginame,  @hostname, @program_name, @cmd, @uid, @nt_username, @dbname  
	     END
       close cursor_normal_spid_detector
	   deallocate cursor_normal_spid_detector
	   select @killStatements = @killStatements + '*/ ' + char(13) + char(10)
	   print @killStatements
           Print 'Restore of database '+ LTrim(Rtrim(@dbname)) + ' is terminating.'
	   GOTO CLEANUP
     END
   ELSE 
     BEGIN
       close cursor_normal_spid_detector
	   deallocate cursor_normal_spid_detector
     END  
-- Log activity/errors
select @ErrorString =  'BEGINNING PROCEDURE ' +@procname+ ' (Version ' + CONVERT(varchar(3), @procversion) + ') at ' + CONVERT(varchar(30), GETDATE(), 109) + '.'
select @HdrString = replicate('*',datalength(@ErrorString))
print @HdrString
print @ErrorString

	
-- STEP #1 - Database Restore Step
-- STEP #1A - LASTBKUP Type
/*
Parameters

@source_instance	optional		The name of the instance that contains the source database. If excluded, the restore will read from the current instance.
@source_db	required			The name of the source database to restore from.
@dest_db	optional					The name of the destination database to restore to. If excluded, the restored database will use the same name as the source database. 
@skip_logs	optional				Set to 1 and no log files will be restored. Used if you only want to restore a full or differential backup. If excluded, the restore will use any available log backup files.
@restore_date	optional			The date and time to restore to. If excluded, the current date and time will be used.
@data_directory	optional		The directory in which all restored data files will be placed. If omitted, the procedure will determine the appropriate directory from the current destination database if it exists, or will use the instance default locations if not.
@log_directory	optional			The directory in which all restored log files will be placed. If omitted, the procedure will determine the appropriate directory from the current destination database if it exists, or will use the instance default locations if not.
@debug	optional					Set to 1 and the procedure will print the restore commands to the screen without executing them.
		

*/
--GOTO ADDSEC
--GOTO STRIPSEC

IF @p_inputfiletype = 'LASTBKUP'
   	Begin
   	  select @ErrorString =  'Starting Restore step at ' + CONVERT(varchar(30), GETDATE(), 109) + '.'
 	  Print @ErrorString 
	  if @p_restoredate is null
	    begin
	      Set @i_skiplogs = '1'
          Select @executestmt = 'exec dbutils.dbo.sp_restore_db @source_instance = ''' + @p_sourceinstance + ''', @source_db = ''' +@p_sourcedbname + ''', @dest_db = '''+ @p_targetdbname +''', @skip_logs='+@i_skiplogs+', @debug='+cast(@p_debug as CHAR(1))
	    end
	  else
	    begin
	      Set @i_skiplogs = '0'
	      Select @executestmt = 'exec dbutils.dbo.sp_restore_db @source_instance = ''' + @p_sourceinstance + ''', @source_db = ''' +@p_sourcedbname + ''', @dest_db = '''+ @p_targetdbname +''', @skip_logs='+@i_skiplogs+', @debug='+cast(@p_debug as CHAR(1))+', @restore_date='''+convert(nvarchar,@p_restoredate,121)+''''
	    end	    
 	   
	 -- Run the restore 
	 print @executestmt
	 execute (@executestmt)
	
		GOTO CLEANUP
	End
    	
-- STEP #1B - File Type
Else
	Begin
	    /*Tb Mixed restore files 09/10/2014*/
	    declare @p_inputfile1_supplied bit = 0,
                @p_inputfile2_supplied bit = 0,
                @count tinyint = 1,
                @moveclause varchar(4000) = '',
                @lname varchar(128),
                @pname varchar(260),
                @ppath varchar(260),
                @fname varchar(50),
                @recoveryclause varchar(10),
                @restorestmt varchar(4000),
                @xpcmd varchar (2000),
                @result int
                
        select @p_inputfile1_supplied = 1,  --make it to here, a file has been supplied
               @p_inputfile2_supplied = case when (@p_inputfile2 IS Null) or (@p_inputfile2 = '') then 0 else 1 end
 
        --get the files from the existing db to be replaced
        if ( @p_inputfile1_supplied = 1)
          begin
			  create table #BakDifTmp (
					LogicalName nvarchar(128), 
					PhysicalName nvarchar(260),
					[Type] char(1),
					FileGroupName nvarchar(128),
					Size numeric(20,0) ,
					MaxSize numeric(20,0),
					Fileid	tinyint,
					CreateLSN numeric(25,0),
					DropLSN numeric(25, 0),
					UniqueID uniqueidentifier,
					ReadOnlyLSN numeric(25,0),
					ReadWriteLSN numeric(25,0),
					BackupSizeInBytes bigint,
					SourceBlockSize int,
					FileGroupId int,
					LogGroupGUID uniqueidentifier,
					DifferentialBaseLSN numeric(25,0),
					DifferentialBaseGUID uniqueidentifier,
					IsReadOnly bit,
					IsPresent bit, 
					TDEThumbprint varbinary(32))


		  --added column on 2016 of SnapShotURL
		    declare @SQLversion nvarchar(20) 
            select @SQLversion = convert(nvarchar(25),SERVERPROPERTY('productversion'))
			if @SQLversion >= '13'
			  begin
			     alter table #BakDifTmp add SnapshotUrl nvarchar(360)
			  end

            
            --have to go and query the sys.master_files table to get the list of data and log files, #targetdbfiles(1)
            select database_id,file_id,type,data_space_id,name,physical_name, substring(physical_name, 1,2) as drive,
                   case type when 0 then 'row'
                             when 1 then 'log'
                             when 2 then 'fs' else 'unkn' end as filetype,
                   substring(left(physical_name,len(physical_name) - charindex('\',reverse(physical_name),1) + 1),3,len(physical_name) - 2) as fpath,
                   reverse(left(reverse(physical_name),charindex('\', reverse(physical_name), 1) - 1)) as fname,
                   db_name(database_id) as [db_name],
                   processed = 0
            into #targetdbfiles1 
            from sys.master_files where database_id = db_id(@p_targetdbname)


			
				
            --hold bak file elements
			select @executestmt3 = 'restore filelistonly from disk = ''' + @p_inputfile1 + ''''
			insert #BakDifTmp exec (@executestmt3)
                
            select logicalname as bak_logname, 
			       physicalname as bak_physname, 
			       t.[type] as bak_ftype, 
			       drive as db_drive,
			       cast(null as CHAR(2)) as DataDriveOverride,
			       cast(null as CHAR(2)) as LogDriveOverride, 
			       fpath as db_path, 
			       fname as db_file,
			       [db_name] as [db_name],
			       0 as processed
			into #restoreelements
			from #BakDifTmp t left outer join #targetdbfiles1 tgt on t.Fileid = tgt.[file_id] --on t.logicalname = tgt.name

                --Bak file restore
                update  #restoreelements set [db_name] = (select top 1 [db_name] from #restoreelements where [db_name] is not null)                                               

				--make some assumptions about placement of data files for .Bak extra file(s)
				update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'D'),
									 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'D'),
									 db_file = 'DtaBak_' + [db_name] + bak_logname + '.ndf'
								 where db_drive is null and bak_ftype = 'D' 
                                 
				--make some assumptions about placement of log files for .Bak file extra file(s)
				update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'L'),
									 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'L'),
									 db_file = 'LogBak_' + [db_name] + bak_logname + '.ldf'
								 where db_drive is null and bak_ftype = 'L' 
								 
				--override placement of the data files by drive letter				 
				if (@p_DataDriveOverride is not null)
				    update #restoreelements set DataDriveOverride = @p_DataDriveOverride where bak_ftype = 'D'
				if (@p_LogDriveOverride is not null)
				    update #restoreelements set LogDriveOverride = @p_LogDriveOverride where bak_ftype = 'L'
 				
 				select @recoveryclause = case when (@p_inputfile2_supplied = 0) then 'recovery' else 'norecovery' end
 				
				select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile1+''' with replace, stats=10, ' + @recoveryclause + ', '


                

				while (select count(*) from #restoreelements where processed = 0 ) > 0
					begin

						select top 1 @lname = bak_logname,
									 @pname = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path + db_file
						                           when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path + db_file
						                           else 'Undefined'
						                      end,
						             @ppath = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path
						                           when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path
						                           else 'Undefined'
						                      end    
    
						from #restoreelements where processed = 0 
						
						--create directory if not exists
						select @xpcmd = 'dir ' + @ppath
						exec @result = xp_cmdshell @xpcmd, no_output
						if @result <> 0
						  begin
						    print 'Creating Directory'
						  	select @xpcmd = 'mkdir ' + @ppath
						  	if @p_debug = 0
							  begin
						        exec @result = xp_cmdshell @xpcmd, no_output
								print @xpcmd
                              end
						    else
						      print @xpcmd
						  end 

					   select @moveclause = 'move ''' + @lname + ''' to ''' + @pname + ''',' from #restoreelements
					   select @executestmt3 = @executestmt3 + @moveclause

					   update #restoreelements set processed = 1 where bak_logname = @lname 
					end

				select @executestmt3 = substring(@executestmt3, 1, datalength(@executestmt3)-1) --remove trailing comma
				
				print '*** RESTORE with MOVE on bak file *** '
				if @p_debug = 0
					begin
					print  @executestmt3
    				execute (@executestmt3)
					end
                else
                    print  @executestmt3

               
            --Dif file restore
            --have to go and requery the sys.master_files table to get the NEW list (if any) data and log files from previous bak file restore. Hence, #targetdbfiles(2)

            select database_id,file_id,type,data_space_id,name,physical_name, substring(physical_name, 1,2) as drive,
                   case type when 0 then 'row'
                             when 1 then 'log'
                             when 2 then 'fs' else 'unkn' end as filetype,
                   substring(left(physical_name,len(physical_name) - charindex('\',reverse(physical_name),1) + 1),3,len(physical_name) - 2) as fpath,
                   reverse(left(reverse(physical_name),charindex('\', reverse(physical_name), 1) - 1)) as fname,
                   db_name(database_id) as [db_name],
                   processed = 0
            into #targetdbfiles2 
            from sys.master_files where database_id = db_id(@p_targetdbname)

             --clear out previous bak information
        		truncate table #BakDifTmp
        		truncate table #restoreelements
        		
				select @executestmt3 = 'restore filelistonly from disk = ''' + @p_inputfile2 + ''''
				insert #BakDifTmp exec (@executestmt3)

                
                if (@p_inputfile2_supplied = 1)
					begin
						insert into #restoreelements
						select logicalname as bak_logname, 
							   physicalname as bak_physname, 
							   t.[type] as bak_ftype, 
							   drive as db_drive,
							   null as DataDriveOverride,
							   null as LogDriveOverride, 
							   fpath as db_path, 
							   fname as db_file,
							   [db_name] as [db_name],
							   0 as processed
						from #BakDifTmp t left outer join #targetdbfiles2 tgt on  t.Fileid = tgt.[file_id]--on t.logicalname = tgt.name
					
					update  #restoreelements set [db_name] = (select top 1 [db_name] from #restoreelements where [db_name] is not null)                                               

					--make some assumptions about placement of data files for Dif file
					update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'D'),
										 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'D'),
										 db_file = 'DtaDif_' + [db_name] + bak_logname + '.ndf'
									 where db_drive is null and bak_ftype = 'D' 
	                                 
					--make some assumptions about placement of log files for Dif file
					update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'L'),
										 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'L'),
										 db_file = 'LogDif_' + [db_name] + bak_logname + '.ldf'
									 where db_drive is null and bak_ftype = 'L' 
					
					--override placement of the log files by drive letter				 
					if (@p_DataDriveOverride is not null)
						update #restoreelements set DataDriveOverride = @p_DataDriveOverride where bak_ftype = 'D'
					if (@p_LogDriveOverride is not null)
						update #restoreelements set LogDriveOverride = @p_LogDriveOverride where bak_ftype = 'L'

         
					select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile2+''' with replace, stats=10, recovery, '
                    
					while (select count(*) from #restoreelements where processed = 0 ) > 0
						begin
						--select * from #restoreelements
							select top 1 @lname = bak_logname,
										 @pname = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path + db_file
						                               when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path + db_file
						                               else 'Undefined'
						                          end,
						                 @ppath = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path
						                               when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path
						                               else 'Undefined'
						                      end      

							from #restoreelements where processed = 0 

						--create directory if not exists
						select @xpcmd = 'dir ' + @ppath
						exec @result = xp_cmdshell @xpcmd, no_output
						if @result <> 0
						  begin
						    print 'Creating Directory'
						  	select @xpcmd = 'mkdir ' + @ppath
						    if @p_debug = 0
						      begin
						        exec @result = xp_cmdshell @xpcmd, no_output
								print @xpcmd
                              end
						    else
						      print @xpcmd
						  end 


						   select @moveclause = 'move ''' + @lname + ''' to ''' + @pname + ''',' from #restoreelements
						   select @executestmt3 = @executestmt3 + @moveclause

						   update #restoreelements set processed = 1 where bak_logname = @lname 

						end

						select @executestmt3 = substring(@executestmt3, 1, datalength(@executestmt3)-1) --remove trailing comma
						
						print '*** RESTORE with MOVE on dif file *** '
						if @p_debug = 0
						  begin
						    print  @executestmt3
    						execute (@executestmt3)
						  end
						else
							print  @executestmt3
 					end

          end   
               
        /*Tb Mixed restore files 09/10/2014*/
		if @p_debug = 0
			begin
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE WITH NO_WAIT;'
				Print @executestmt
				execute (@executestmt)
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE;'
				Print @executestmt
				execute (@executestmt)
				select @executestmt = 'ALTER AUTHORIZATION ON DATABASE::[' + @p_targetdbname + '] TO sa'
				Print @executestmt
				execute (@executestmt) 	
				select @executestmt = 'select type_desc as Type, name as LogicalName, physical_name as FileLocation from [' + @p_targetdbname + '].sys.database_files'
		        execute (@executestmt)  
			end
        else
			begin
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE WITH NO_WAIT;'
				Print @executestmt
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE;'
				Print @executestmt
				select @executestmt = 'ALTER AUTHORIZATION ON DATABASE::[' + @p_targetdbname + '] TO sa'
				Print @executestmt
			end   
			     
      
                    

		goto CLEANUP						
	End


-- Clean Up
CLEANUP:

IF (object_id('cur_user') IS NOT Null)
     BEGIN
          CLOSE cur_user
          DEALLOCATE cur_user
    END    
IF (object_id('cur_role') IS NOT Null)
     BEGIN
          CLOSE cur_role
          DEALLOCATE cur_role 
     END 
 IF (object_id('#tblsqlscripts') IS NOT Null)
     BEGIN
		 DROP TABLE #tblSQLScripts
     END     

SET ANSI_NULLS OFF








GO
/****** Object:  StoredProcedure [dbo].[pSendNotification]    Script Date: 10/19/2022 1:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[pSendNotification] 
@job_name					sysname  = NULL,
@NotifyType					nvarchar(20) = 'Task',
@ServerDatabaseHome			nvarchar(128),
@QueryForID					int = 0, --this can be taskid, releaseid or some other int key
@CommandData				nvarchar(max) = NULL,
@Notes						nvarchar(max) = NULL,
@profile_name               sysname    = NULL,        
@recipients                 VARCHAR(MAX)  = NULL, 
@copy_recipients            VARCHAR(MAX)  = NULL,
@blind_copy_recipients      VARCHAR(MAX)  = NULL,
@subject                    NVARCHAR(255) = NULL,
@body                       NVARCHAR(MAX) = NULL, 
@body_format                VARCHAR(20)   = NULL, 
@importance                 VARCHAR(6)    = 'NORMAL',
@sensitivity                VARCHAR(12)   = 'NORMAL',
@file_attachments           NVARCHAR(MAX) = NULL,  
@query                      NVARCHAR(MAX) = NULL,
@execute_query_database     sysname       = NULL,  
@attach_query_result_as_file BIT          = 0,
@query_attachment_filename  NVARCHAR(260) = NULL,  
@query_result_header        BIT           = 1,
@query_result_width         INT           = 256,            
@query_result_separator     CHAR(1)       = ' ',
@exclude_query_output       BIT           = 0,
@append_query_error         BIT           = 0,
@query_no_truncate          BIT           = 1,
@query_result_no_padding    BIT           = 0,
@mailitem_id               INT            = NULL OUTPUT,
@from_address               VARCHAR(max)  = NULL,
@reply_to                   VARCHAR(max)  = NULL,
@Debug bit = 0

as
set nocount on


declare @ServerName nvarchar(128) = '',
        @DatabaseName nvarchar(128) = '',
		@MessageQuery nvarchar(max) = '',
		@MessageBody nvarchar(max) = '',
		@MessageCommandData nvarchar(max) = '',
		@JobLogBody nvarchar(max) = '',
		@ParmDefinition nvarchar(200),
		@MessageNotes nvarchar(max) = '',
		@SelectCommand nvarchar(max),
		@UpdateRc int = -1,
		@PackageStatus nvarchar(20),
		@JobStatus nvarchar(20),
		@NotifyList nvarchar(512),
		@CCNotifyList nvarchar(512),
		@BCCNotifyList nvarchar(512),
		@Style nvarchar(max) = '
<style>
      table {border-collapse:collapse;border:1px solid black;font-family:courier;font-size:12px;white-space:nowrap;}
         td {border-spacing:0;border:1px solid black;text-align:left;padding:2; }
         th {border-spacing:0;border:1px solid black;text-align:left;padding:2;font-weight:bold;font-size:14px;background-color:#dcdcf7;white-space: nowrap;}
</style>'

--this breaks out the format 'SERVER.DATABASE' provided by the service call
select @ServerName = substring(@ServerDatabaseHome,0, CHARINDEX('.',@ServerDatabaseHome))
select @DatabaseName = reverse(substring(reverse(@ServerDatabaseHome),0, CHARINDEX('.',reverse(@ServerDatabaseHome))))


if @NotifyType = 'Task'
  begin
    print 'Task email'
	select @MessageQuery = N'
	select @TaskBodyOUT = 
	''<div style="overflow-x:auto;"><br/><table><tr><th>Task Result ID</th><th>Task ID</th><th>Result Location</th><th>Execution Date</th><th>TaskType</th><th>Status</th><th>Region</th></tr>''
	+ CAST((
	select top 10
	TaskResultID as ''td'',
	a.TaskID  as ''td'',
	''"'' + ResultLocation + ''"'' as ''td'',
	convert(varchar(25),ExecutionDate,109)  as ''td'',
	TaskType  as ''td'',
	Status  as ''td'',
	Region  as ''td''
	from OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @ServerName + ';Integrated Security=SSPI'').' + @DatabaseName + '.dbo.apptaskresult r
	inner join OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @ServerName + ';Integrated Security=SSPI'').' + @DatabaseName + '.dbo.apptask a on a.taskid = r.taskid
	where a.taskid = ' + cast(@QueryForID as varchar) + '
	order by executiondate desc
	FOR XML RAW(''tr''), ELEMENTS) AS NVARCHAR(MAX)) + N''</table></div>''
	'
	select @ParmDefinition = N'@TaskBodyOUT nvarchar(max) OUTPUT'
	exec master.dbo.sp_executesql @MessageQuery, @ParmDefinition, @TaskBodyOUT = @MessageBody OUTPUT

	if @Notes <> ''
	  begin
	    select @MessageNotes = N'
		<table><tr><th>Task Note(s)</th></tr>
		<tr><td>' + replace(@Notes,char(13) + char(10),'<br/>') + '</td></tr>
		</table><br />
		'
	  end

    select @MessageBody = @MessageNotes + @MessageBody + '<br/>'
  end
  --END TASK--------------------------------------------------------------------------------------------------------------
else if @NotifyType = 'Release'
  begin
    print 'Release email'
	select @MessageNotes = @Notes

	select @SelectCommand = 'select @PackageStatusOUT = PackageStatus from  OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @ServerName + ';Integrated Security=SSPI'').' + @DatabaseName + '.dbo.ReleasePackage where PackageID = ' + cast(@QueryForID as nvarchar) + ''
	select @ParmDefinition = N'@PackageStatusOUT nvarchar(20) OUTPUT';
	exec @UpdateRc = master.dbo.sp_executesql @SelectCommand, @ParmDefinition, @PackageStatusOUT = @PackageStatus OUTPUT


	select @SelectCommand = 'select @NotifyListOUT = NotifyList, @CCNotifyListOUT = CCNotifyList, @BCCNotifyListOUT = BCCNotifyList from  OPENDATASOURCE(''SQLNCLI'', ''Data Source=' + @ServerName + ';Integrated Security=SSPI'').' + @DatabaseName + '.dbo.ReleasePackage where PackageID = ' + cast(@QueryForID as nvarchar) + ''
	select @ParmDefinition = N'@NotifyListOUT nvarchar(512) OUTPUT, @CCNotifyListOUT nvarchar(512) OUTPUT, @BCCNotifyListOUT nvarchar(512) OUTPUT';
	exec @UpdateRc = master.dbo.sp_executesql @SelectCommand, @ParmDefinition, @NotifyListOUT = @NotifyList OUTPUT, @CCNotifyListOUT = @CCNotifyList OUTPUT, @BCCNotifyListOUT = @BCCNotifyList OUTPUT

	select @subject = @subject + ' - [ ' + upper(@PackageStatus) + ' ]'  --append the status in the title

	select @MessageBody = @MessageNotes + @MessageBody + '<br/>'
  end
  --END RELEASE-----------------------------------------------------------------------------------------------------------



--begin Job data. This is attached to all emails
if @CommandData <> ''
  begin
	select @MessageCommandData = @CommandData
	if @NotifyType = 'Release'
	  begin
	    select @MessageCommandData = '' --not including this in Release emails, too cryptic
	  end
  end

--This is job log stuff, all emails get this and the style block
create table #t (OutData nvarchar(max) null)
insert #t (OutData) exec pReadJobStepLog @job_name=@job_name
select @JobLogBody = OutData from #t
drop table #t



    select @MessageBody = @Style + @MessageBody + @MessageCommandData + @JobLogBody


declare @JobID UNIQUEIDENTIFIER = NULL
select @JobID = job_id from  msdb.dbo.sysjobs_view where name = @job_name

SELECT @JobStatus = 
	case when last_run_outcome = 0 then 'Failed'
		when last_run_outcome = 1 then 'Succeeded'
		when last_run_outcome = 2 then 'Retry'
		when last_run_outcome = 3 then 'Canceled'
		when last_run_outcome = 5 then 'Unknown'
		else 'NULL'
	end

FROM msdb.dbo.sysjobs_view sjv, msdb.dbo.sysjobsteps as steps, msdb.dbo.sysjobstepslogs as logs 
WHERE (sjv.job_id = @JobID)
AND (steps.job_id = @JobID)
AND (steps.step_uid = logs.step_uid)
AND steps.step_name <> 'Email Step'


if @NotifyType <> 'Task' and @NotifyType <> 'Release'
  begin
	select @subject = @subject + ' - [ ' + upper(@JobStatus) + ' ]'
  end


if @Debug = 0
  begin
	exec msdb.dbo.sp_send_dbmail 
	@profile_name=@profile_name, 
	@recipients=@recipients, 
	@copy_recipients=@copy_recipients, 
	@blind_copy_recipients=@blind_copy_recipients,
	@subject=@subject, 
	@query=@query, 
	@body=@MessageBody, 
	@body_format=@body_format, 
	@query_no_truncate=@query_no_truncate
  end
else
  select @MessageBody

GO
/****** Object:  StoredProcedure [dbo].[pTestReadWritePermissions]    Script Date: 10/19/2022 1:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[pTestReadWritePermissions] @UNCFilePath nvarchar(500) = '\\CRASAPPDBA01\SelfServe'
as

declare @CommandString nvarchar(1000)
	
set @CommandString = 'dir /n c:\ > ' + @UNCFilePath + '\DBAServicesReadWriteTest.txt'
print @CommandString
exec xp_cmdshell @CommandString
set @CommandString = 'dir /n ' + @UNCFilePath + '\DBAServicesReadWriteTest.txt'
print @CommandString
exec xp_cmdshell @CommandString
set @CommandString = 'del ' + @UNCFilePath + '\DBAServicesReadWriteTest.txt'
print @CommandString
exec xp_cmdshell @CommandString
set @CommandString = 'dir /n ' + @UNCFilePath + '\DBAServicesReadWriteTest.txt'
print @CommandString
exec xp_cmdshell @CommandString

GO
/****** Object:  StoredProcedure [dbo].[pVerifyRestore]    Script Date: 10/19/2022 1:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pVerifyRestore]( @source_instance nvarchar(128) = null, 
								    @source_db nvarchar(128), 
								    @restore_date datetime = null, 
									@integrity_check bit = 0,  --this does a full sql integrity check if 1 via "restore verifyonly", if 0 only checks for existence
								    @skip_logs bit = 0,
								    @skip_kerb_check bit = 0,
								    @debug bit = 0 )
as
begin

	set nocount on
	print 'Src Instance: ' + @source_instance
	print 'Src Database: ' + @source_db
	print 'Restore Date: ' + cast(@restore_date as nvarchar)
	print case when @debug = 1 then '       Debug: ON' else '       Debug: OFF' end
	print case when @skip_logs = 1 then ' Log File(s): SKIP' else ' Log File(s): INCLUDE' end
	print case when @integrity_check = 1 then '  Check Type: INTEGRITY' else '  Check Type: FILE EXISTS' end

	declare @sql_version nvarchar(max)
	set @sql_version = CAST(SERVERPROPERTY('ProductVersion') as nvarchar)
	set @sql_version = left(@sql_version,charindex('.',@sql_version)-1)
	
	declare @source_server nvarchar(max)
	
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
	
	declare @cmd nvarchar(max)
	declare @msg nvarchar(max)

	declare @return_value int = -1

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

		
	--Check to see if the remote queries will require multiple hops. If they do, and we're not using Kerberos, return an error
	select @auth_scheme=auth_scheme, @client_net_address=client_net_address, @local_net_address=local_net_address from master.sys.dm_exec_connections where session_id=@@spid
	
	if @skip_kerb_check = 0 and @auth_scheme = 'NTLM' and @client_net_address <> '<local machine>' and @source_instance <> @@SERVERNAME and @client_net_address <> @local_net_address
	begin
		set @msg = 'This operation requires multi-hop authentication and this session is not using Kerberos authentication. Execute this command locally on ' + @@SERVERNAME + ' or configure ' + @@SERVERNAME + ' to use Kerberos authentication.'
		raiserror(@msg, 16, 1 )
		goto cleanup
	end	
			
	--Create a temporary linked server to gather data from the source instance
	if exists ( select srvid from master.sys.sysservers where srvid != 0 and srvname = 'ls_restore_db')
		exec master.dbo.sp_dropserver @server='ls_restore_db', @droplogins='droplogins'
		
	exec master.dbo.sp_addlinkedserver @server = 'ls_restore_db', @srvproduct = '', @provider = 'SQLNCLI', @datasrc = @source_instance
	exec master.dbo.sp_addlinkedsrvlogin @rmtsrvname = 'ls_restore_db', @locallogin = NULL , @useself = 'True'

	begin try
		exec master.sys.sp_testlinkedserver ls_restore_db
	end try
	begin catch
		set @msg = 'Cannot connect to ' + @source_instance + '. ' + ERROR_MESSAGE()
		raiserror(@msg, 16, 1 )
		goto cleanup	
	end catch

	--Set the source and dest database names to the correct case
	if object_id('tempdb..##rdbname') is not null
		drop table ##rdbname;

	set @cmd = 'select database_name into ##rdbname from [ls_restore_db].msdb.dbo.backupset where lower(database_name) = lower(''' + @source_db + ''')'
	exec (@cmd)

	--If nothing exists in the backupset table on the remote instance, we can't continue the restore
	if not exists(select database_name from ##rdbname)
	begin
		set @msg = 'No backup records exist for ' + @source_db + ' on instance ' + @source_instance
		raiserror(@msg, 16, 1 )
		goto cleanup
	end
	
	select @source_db=database_name from ##rdbname

	
	--Get the date & filename of the most recent full backup prior to the start date
	if object_id('tempdb..##rdbfullinfo') is not null
		drop table ##rdbfullinfo;

	set @cmd = 'select top 1 backup_start_date, physical_device_name into ##rdbfullinfo from [ls_restore_db].msdb.dbo.backupset bs, [ls_restore_db].msdb.dbo.backupmediafamily bf where database_name = ''' + @source_db + ''' and backup_start_date < ''' + convert(nvarchar,@restore_date,121) + ''' and type = ''D'' and is_copy_only = 0 and bf.media_set_id = bs.media_set_id order by backup_start_date desc'
	exec (@cmd)

	select @full_date=backup_start_date, @full_path=physical_device_name 
	from   ##rdbfullinfo
	
	--Get the date & filename of the most recent differential backup prior to the start date
	if object_id('tempdb..##rdbdiffinfo') is not null
		drop table ##rdbdiffinfo;

	set @cmd = 'select top 1 backup_start_date, physical_device_name into ##rdbdiffinfo from [ls_restore_db].msdb.dbo.backupset bs, [ls_restore_db].msdb.dbo.backupmediafamily bf where database_name = ''' + @source_db + ''' and backup_start_date < ''' + convert(nvarchar,@restore_date,121) + ''' and type = ''I'' and bf.media_set_id = bs.media_set_id order by backup_start_date desc'
	exec (@cmd)

	select @diff_date=backup_start_date, @diff_path=physical_device_name 
	from   ##rdbdiffinfo

	--Get the date & filenames of all the log backups after the full or differential backups but prior to the start date
	if @diff_date is null or @diff_date < @full_date
		set @log_start_date = @full_date
	else
		set @log_start_date = @diff_date
		
	set @log_end_date = @restore_date  --only get logfiles that encompass the @restore_date

	if object_id('tempdb..##rdbloginfo') is not null
		drop table ##rdbloginfo;

	set @cmd = 'select physical_device_name into ##rdbloginfo from [ls_restore_db].msdb.dbo.backupset bs, [ls_restore_db].msdb.dbo.backupmediafamily bf where database_name = ''' + @source_db + ''' and backup_start_date between ''' + convert(nvarchar,@log_start_date,121) + ''' and ''' + convert(nvarchar,@log_end_date,121) + ''' and type = ''L'' and bf.media_set_id = bs.media_set_id order by backup_start_date asc'
	exec (@cmd)

	--Terminate the procedure if no full backup was found
	if @full_date is null
	begin
		set @msg = 'No full backup found for database ' + @source_db + ' on instance ' + @source_instance + ' prior to ' + convert(nvarchar,@restore_date,121)
		raiserror(@msg, 16, 1 )
		goto cleanup
	end

	set @full_path = '\\' + @source_server + '\' + LEFT(@full_path,1) + '$' + RIGHT(@full_path,LEN(@full_path)-2)

	set @diff_path = '\\' + @source_server + '\' + LEFT(@diff_path,1) + '$' + RIGHT(@diff_path,LEN(@diff_path)-2)


	if object_id('tempdb..##sdbfiles') is not null
		drop table ##sdbfiles;
		
	if @sql_version = '10' or @sql_version = '11'
		set @cmd='create table ##sdbfiles (LogicalName nvarchar(128), PhysicalName nvarchar(260), [Type] char(1), FileGroupName nvarchar(128), Size numeric(20,0), MaxSize numeric(20,0), FileID bigint, CreateLSN numeric(25,0), DropLSN numeric(25,0) NULL, UniqueID uniqueidentifier, ReadOnlyLSN numeric(25,0) NULL, ReadWriteLSN numeric(25,0) NULL, BackupSizeInBytes bigint, SourceBlockSize int, FileGroupID int, LogGroupGUID uniqueidentifier NULL, DifferentialBaseLSN numeric(25,0) NULL, DifferentialBaseGUID uniqueidentifier, IsReadOnly bit, IsPresent bit, TDEThumbprint varbinary(32))'
	else if @sql_version = '9'
		set @cmd='create table ##sdbfiles (LogicalName nvarchar(128), PhysicalName nvarchar(260), [Type] char(1), FileGroupName nvarchar(128), Size numeric(20,0), MaxSize numeric(20,0), FileID bigint, CreateLSN numeric(25,0), DropLSN numeric(25,0) NULL, UniqueID uniqueidentifier, ReadOnlyLSN numeric(25,0) NULL, ReadWriteLSN numeric(25,0) NULL, BackupSizeInBytes bigint, SourceBlockSize int, FileGroupID int, LogGroupGUID uniqueidentifier NULL, DifferentialBaseLSN numeric(25,0) NULL, DifferentialBaseGUID uniqueidentifier, IsReadOnly bit, IsPresent bit)'
	else
	begin
		set @msg = 'Unrecognized SQL Server version. This procedure works on SQL 2005, 2008, 2008r2 and 2012 only.'
		raiserror(@msg, 16, 1 )
		goto cleanup
	end
	
	exec (@cmd)

	declare @exists int = null
	declare @parmDef nvarchar(100) = '@existsOUT int output'

	if @integrity_check = 1
	  set @cmd = 'restore verifyonly from disk=''' + @full_path + ''' with  file = 1, continue_after_error, nounload'
	else
      set @cmd = 'exec master.dbo.xp_fileexist ''' + @full_path + ''', @existsOUT OUTPUT'

	if @debug = 0
	  begin
		begin try 
		if @integrity_check = 1
		   exec (@cmd)
		else
		   begin
		     exec sp_executesql @cmd, @parmDef, @existsOUT = @exists output
			 if @exists = 0
			   begin
			     print 'Full backup file not found'
				 set @return_value = -22
				 goto cleanup
			   end
		   end
		end try
		begin catch
			print 'Error on file ' + @full_path
			set @return_value = -2
			goto cleanup
		end catch
	  end
	else
	  print @cmd

	if @diff_date is not null and @diff_date > @full_date
	begin
	  if @integrity_check = 1
		set @cmd = 'restore verifyonly from disk=''' + @diff_path + ''' with  file = 1, continue_after_error, nounload'
	  else
	    set @cmd = 'exec master.dbo.xp_fileexist ''' + @diff_path + ''', @existsOUT OUTPUT'

		if @debug = 0
		  begin
			begin try 
			if @integrity_check = 1
			   exec (@cmd)
			else
			   begin
				 exec sp_executesql @cmd, @parmDef, @existsOUT = @exists output
				 if @exists = 0
				   begin
					 print 'Differential backup file not found'
					 set @return_value = -33
					 goto cleanup
				   end
			   end
			end try
			begin catch
				print 'Error on file ' + @diff_path
				set @return_value = -3
				goto cleanup
			end catch
		  end
		else
		  print @cmd
	end

	--Execute the log file verifys, if appropriate
	if @skip_logs = 0
	begin
		
		declare log_backups cursor for
			select physical_device_name from ##rdbloginfo

		open log_backups
		fetch next from log_backups into @log_path
		while @@fetch_status = 0
		begin
		
			set @log_path = '\\' + @source_server + '\' + LEFT(@log_path,1) + '$' + RIGHT(@log_path,LEN(@log_path)-2)
			if @integrity_check = 1
			  set @cmd = 'restore verifyonly from disk=''' + @log_path + ''' with  file = 1, continue_after_error, nounload'
			else
			  set @cmd = 'exec master.dbo.xp_fileexist ''' + @log_path + ''', @existsOUT OUTPUT'

			if @debug = 0
			  begin
				  begin try 
					if @integrity_check = 1
					   exec (@cmd)
					else
					   begin
						 exec sp_executesql @cmd, @parmDef, @existsOUT = @exists output
						 if @exists = 0
						   begin
							 print 'Transaction log file not found'
							 set @return_value = -44
							 goto cleanup
						   end
					   end
				  end try
				  begin catch
					  print 'Error on file ' + @log_path
					  set @return_value = -4
					  close log_backups
		              deallocate log_backups
					  goto cleanup
				  end catch
			  end
			else
			  print @cmd
			
			fetch next from log_backups into @log_path
		end
		close log_backups
		deallocate log_backups	
	end

	set @return_value = 0

	cleanup:
	--Cleanup the temporary linked server and any temp tables created
	if exists ( select srvid from master.sys.sysservers where srvid != 0 and srvname = 'ls_restore_db')
		exec master.dbo.sp_dropserver @server='ls_restore_db', @droplogins='droplogins'

	if object_id('tempdb..##rdbname') is not null
		drop table ##rdbname;
	if object_id('tempdb..##rdbfullinfo') is not null
		drop table ##rdbfullinfo;
	if object_id('tempdb..##rdbdiffinfo') is not null
		drop table ##rdbdiffinfo;
	if object_id('tempdb..##rdbloginfo') is not null
		drop table ##rdbloginfo;
	if object_id('tempdb..##sdbfiles') is not null
		drop table ##sdbfiles;
	if object_id('tempdb..##ddbfiles') is not null
		drop table ##ddbfiles;		
	if object_id('tempdb..##userlist') is not null
		drop table ##userlist;
	
	if cursor_status('global','log_backups')>=-1
		begin
		 deallocate log_backups
		end

	return @return_value
end

GO
/****** Object:  StoredProcedure [dbo].[pVerifyRestoreV3]    Script Date: 10/19/2022 1:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pVerifyRestoreV3]( @source_instance nvarchar(128) = null, 
								    @source_db nvarchar(128), 
								    @restore_date datetime = null, 
									@integrity_check bit = 0,  --this does a full sql integrity check if 1 via "restore verifyonly", if 0 only checks for existence
								    @skip_logs bit = 0,
								    @skip_kerb_check bit = 0,
								    @debug bit = 0 )
as
begin

	set nocount on
	print 'Src Instance: ' + @source_instance
	print 'Src Database: ' + @source_db
	print 'Restore Date: ' + cast(@restore_date as nvarchar)
	print case when @debug = 1 then '       Debug: ON' else '       Debug: OFF' end
	print case when @skip_logs = 1 then ' Log File(s): SKIP' else ' Log File(s): INCLUDE' end
	print case when @integrity_check = 1 then '  Check Type: INTEGRITY' else '  Check Type: FILE EXISTS' end

	declare @sql_version nvarchar(max)
	set @sql_version = CAST(SERVERPROPERTY('ProductVersion') as nvarchar)
	set @sql_version = left(@sql_version,charindex('.',@sql_version)-1)
	
	declare @source_server nvarchar(max)
	
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
	
	declare @cmd nvarchar(max)
	declare @msg nvarchar(max)

	declare @return_value int = -1

	declare @SourceNameOUT sysname
    exec SSDBAUtils.dbo.pGetHAPrimary @source_instance, @SourceNameOUT output
    select @source_instance = @SourceNameOUT


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
	
	--Verify on a Compatible Version
	if @sql_version = '10' or @sql_version = '11' or @sql_version = '12' or @sql_version = '13'
		print 'Supported Version of SQL'
	else
	begin
		set @msg = 'Unrecognized SQL Server version. This procedure works on SQL 2005, 2008, 2008r2 and 2012 only.'
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
			
	DECLARE @rdbname table (database_name varchar(128) )

	--Set the source and dest database names to the correct case
	set @cmd = 'select database_name from OPENROWSET(''SQLNCLI'', ''Server=' + @source_instance + ';Trusted_Connection=yes;'', ''select database_name from msdb.dbo.backupset where lower(database_name) = lower(''''' + @source_db + ''''')'')'
	INSERT INTO @rdbname exec (@cmd)

	--If nothing exists in the backupset table on the remote instance, we can't continue the restore
	if not exists(select database_name from @rdbname)
	begin
		set @msg = 'No backup records exist for ' + @source_db + ' on instance ' + @source_instance
		raiserror(@msg, 16, 1 )
		goto cleanup
	end
	
	select @source_db=database_name from @rdbname
	
	--Get the date & filename of the most recent full backup prior to the start date
	DECLARE @rdbfullinfo table (backup_start_date datetime, physical_device_name nvarchar(260))

	set @cmd = 'select * from OPENROWSET(''SQLNCLI'', ''Server=' + @source_instance + ';Trusted_Connection=yes;'', ''select top 1 backup_start_date, physical_device_name from msdb.dbo.backupset bs, msdb.dbo.backupmediafamily bf where database_name = ''''' + @source_db + ''''' and backup_start_date < ''''' + convert(nvarchar,@restore_date,121) + ''''' and type = ''''D'''' and is_copy_only = 0 and bf.media_set_id = bs.media_set_id order by backup_start_date desc'')'
	INSERT INTO @rdbfullinfo exec(@cmd)

	select @full_date=backup_start_date, @full_path=physical_device_name 
	from   @rdbfullinfo 
	
	--Get the date & filename of the most recent differential backup prior to the start date
	DECLARE @rdbdiffinfo table(backup_start_date datetime, physical_device_name nvarchar(260))
	
	set @cmd = 'select * from OPENROWSET(''SQLNCLI'', ''Server=' + @source_instance + ';Trusted_Connection=yes;'', ''select top 1 backup_start_date, physical_device_name from msdb.dbo.backupset bs, msdb.dbo.backupmediafamily bf where database_name = ''''' + @source_db + ''''' and backup_start_date < ''''' + convert(nvarchar,@restore_date,121) + ''''' and type = ''''I'''' and is_copy_only = 0 and bf.media_set_id = bs.media_set_id order by backup_start_date desc'')'
	INSERT INTO @rdbdiffinfo exec(@cmd)

	select @diff_date=backup_start_date, @diff_path=physical_device_name 
	from   @rdbdiffinfo

	--Get the date & filenames of all the log backups after the full or differential backups but prior to the start date
	if @diff_date is null or @diff_date < @full_date
		set @log_start_date = @full_date
	else
		set @log_start_date = @diff_date
		
	set @log_end_date = @restore_date  --only get logfiles that encompass the @restore_date

	DECLARE @rdbloginfo table (backup_start_date datetime, physical_device_name nvarchar(260))

	set @cmd = 'select * from OPENROWSET(''SQLNCLI'', ''Server=' + @source_instance + ';Trusted_Connection=yes;'', ''select backup_start_date, physical_device_name from msdb.dbo.backupset bs, msdb.dbo.backupmediafamily bf where database_name = ''''' + @source_db + ''''' and backup_start_date between ''''' + convert(nvarchar,@log_start_date,121) + ''''' and ''''' + convert(nvarchar,@log_end_date,121) + ''''' and type = ''''L'''' and is_copy_only = 0 and bf.media_set_id = bs.media_set_id order by backup_start_date asc'')'
	INSERT INTO @rdbloginfo exec(@cmd)

	--Terminate the procedure if no full backup was found
	if @full_date is null
	begin
		set @msg = 'No full backup found for database ' + @source_db + ' on instance ' + @source_instance + ' prior to ' + convert(nvarchar,@restore_date,121)
		raiserror(@msg, 16, 1 )
		goto cleanup
	end

	set @full_path = '\\' + @source_server + '\' + LEFT(@full_path,1) + '$' + RIGHT(@full_path,LEN(@full_path)-2)

	set @diff_path = '\\' + @source_server + '\' + LEFT(@diff_path,1) + '$' + RIGHT(@diff_path,LEN(@diff_path)-2)


	
	declare @exists int = null
	declare @parmDef nvarchar(100) = '@existsOUT int output'

	if @integrity_check = 1
	  set @cmd = 'restore verifyonly from disk=''' + @full_path + ''' with  file = 1, continue_after_error, nounload'
	else
      set @cmd = 'exec master.dbo.xp_fileexist ''' + @full_path + ''', @existsOUT OUTPUT'

	if @debug = 0
	  begin
		begin try 
		if @integrity_check = 1
		   exec (@cmd)
		else
		   begin
		     exec sp_executesql @cmd, @parmDef, @existsOUT = @exists output
			 if @exists = 0
			   begin
				 set @msg = 'Full backup file not found, verify the file Exists and that the Service Account for the Local Instance has File System Access to the Source Server' 
			     print @msg
				 print @full_path
				 set @return_value = -22
				 goto cleanup
			   end
		   end
		end try
		begin catch
			print 'Error on file ' + @full_path
			set @return_value = -2
			goto cleanup
		end catch
	  end
	else
	  print @cmd

	if @diff_date is not null and @diff_date > @full_date
	begin
	  if @integrity_check = 1
		set @cmd = 'restore verifyonly from disk=''' + @diff_path + ''' with  file = 1, continue_after_error, nounload'
	  else
	    set @cmd = 'exec master.dbo.xp_fileexist ''' + @diff_path + ''', @existsOUT OUTPUT'

		if @debug = 0
		  begin
			begin try 
			if @integrity_check = 1
			   exec (@cmd)
			else
			   begin
				 exec sp_executesql @cmd, @parmDef, @existsOUT = @exists output
				 if @exists = 0
				   begin
					 print 'Differential backup file not found'
					 set @return_value = -33
					 goto cleanup
				   end
			   end
			end try
			begin catch
				print 'Error on file ' + @diff_path
				set @return_value = -3
				goto cleanup
			end catch
		  end
		else
		  print @cmd
	end

	--Execute the log file verifys, if appropriate
	if @skip_logs = 0
	begin
		
		declare log_backups cursor for
			select physical_device_name from @rdbloginfo

		open log_backups
		fetch next from log_backups into @log_path
		while @@fetch_status = 0
		begin
		
			set @log_path = '\\' + @source_server + '\' + LEFT(@log_path,1) + '$' + RIGHT(@log_path,LEN(@log_path)-2)
			if @integrity_check = 1
			  set @cmd = 'restore verifyonly from disk=''' + @log_path + ''' with  file = 1, continue_after_error, nounload'
			else
			  set @cmd = 'exec master.dbo.xp_fileexist ''' + @log_path + ''', @existsOUT OUTPUT'

			if @debug = 0
			  begin
				  begin try 
					if @integrity_check = 1
					   exec (@cmd)
					else
					   begin
						 exec sp_executesql @cmd, @parmDef, @existsOUT = @exists output
						 if @exists = 0
						   begin
							 print 'Transaction log file not found'
							 set @return_value = -44
							 goto cleanup
						   end
					   end
				  end try
				  begin catch
					  print 'Error on file ' + @log_path
					  set @return_value = -4
					  close log_backups
		              deallocate log_backups
					  goto cleanup
				  end catch
			  end
			else
			  print @cmd
			
			fetch next from log_backups into @log_path
		end
		close log_backups
		deallocate log_backups	
	end

	set @return_value = 0

	cleanup:
	--Cleanup Clear out the Cursor

	if cursor_status('global','log_backups')>=-1
		begin
		 deallocate log_backups
		end

	return @return_value
end


GO
/****** Object:  StoredProcedure [dbo].[pWriteStringToFile]    Script Date: 10/19/2022 1:45:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[pWriteStringToFile]
@String NVARCHAR(max),
@Path NVARCHAR(255),
@Filename NVARCHAR(100)
AS
DECLARE @objFileSystem int,
@objTextStream int,
@objErrorObject int,
@strErrorMessage NVARCHAR(1000),
@Command NVARCHAR(1000),
@hr int,
@FileAndPath NVARCHAR(1000)

set nocount on

select @strErrorMessage='opening the File System Object'
EXECUTE @hr = sys.sp_OACreate 'Scripting.FileSystemObject', @objFileSystem OUT

Select @FileAndPath=@Path+'\'+@Filename
if @hr=0
	Select @objErrorObject=@objFileSystem, @strErrorMessage='Creating file "' + @FileAndPath + '"'
if @hr=0
	execute @hr = sys.sp_OAMethod @objFileSystem, 'CreateTextFile', @objTextStream OUT, @FileAndPath,2,True

if @hr=0
	Select @objErrorObject=@objTextStream, 	@strErrorMessage='writing to the file "' + @FileAndPath + '"'
if @hr=0
	execute @hr = sys.sp_OAMethod @objTextStream, 'Write', Null, @String

if @hr=0
	Select @objErrorObject=@objTextStream, @strErrorMessage='closing the file "' + @FileAndPath + '"'
if @hr=0
	execute @hr = sys.sp_OAMethod @objTextStream, 'Close'
if @hr<>0
	begin
		Declare @Source varchar(255),
		@Description Varchar(255),
		@Helpfile Varchar(255),
		@HelpID int

		EXECUTE sys.sp_OAGetErrorInfo @objErrorObject,@Source output,@Description output,@Helpfile output,@HelpID output
		Select @strErrorMessage='Error whilst '	+coalesce(@strErrorMessage,'doing something')+', '+coalesce(@Description,'')
		raiserror (@strErrorMessage,16,1)
	end

EXECUTE sys.sp_OADestroy @objTextStream
EXECUTE sys.sp_OADestroy @objFileSystem

GO
/****** Object:  StoredProcedure [dbo].[sp_DBPermissions]    Script Date: 10/19/2022 1:45:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*********************************************************************************************
sp_DBPermissions V6.0
Kenneth Fisher
  
http://www.sqlstudies.com
  
This stored procedure returns 3 data sets.  The first dataset is the list of database
principals, the second is role membership, and the third is object and database level
permissions.
     
The final 2 columns of each query are "Un-Do"/"Do" scripts.  For example removing a member
from a role or adding them to a role.  I am fairly confident in the role scripts, however, 
the scripts in the database principals query and database/object permissions query are 
works in progress.  In particular certificates, keys and column level permissions are not
scripted out.  Also while the scripts have worked flawlessly on the systems I've tested 
them on, these systems are fairly similar when it comes to security so I can't say that 
in a more complicated system there won't be the odd bug.
     
Standard disclaimer: You use scripts off of the web at your own risk.  I fully expect this
     script to work without issue but I've been known to be wrong before.
     
Parameters:
    @DBName
        If NULL use the current database, otherwise give permissions based on the parameter.
     
        There is a special case where you pass in ALL to the @DBName.  In this case the SP
        will loop through (yes I'm using a cursor) all of the DBs in sysdatabases and run
        the queries into temp tables before returning the results.  WARNINGS: If you use
        this option and have a large number of databases it will be SLOW.  If you use this
        option and don't specify any other parameters (say a specific @Principal) and have
        even a medium number of databases it will be SLOW.  Also the undo/do scripts do 
        not have USE statements in them so please take that into account.
    @Principal
        If NOT NULL then all three queries only pull for that database principal.  @Principal
        is a pattern check.  The queries check for any row where the passed in value exists.
        It uses the pattern '%' + @Principal + '%'
    @Role
        If NOT NULL then the roles query will pull members of the role.  If it is NOT NULL and
        @DBName is NULL then DB principal and permissions query will pull the principal row for
        the role and the permissions for the role.  @Role is a pattern check.  The queries 
        check for any row where the passed in value exists.  It uses the pattern '%' + @Role +
        '%'
    @Type
        If NOT NULL then all three queries will only pull principals of that type.  
        S = SQL login
        U = Windows login
        G = Windows group
        R = Server role
        C = Login mapped to a certificate
        K = Login mapped to an asymmetric key
    @ObjectName
        If NOT NULL then the third query will display permissions specific to the object 
        specified and the first two queries will display only those users with those specific
        permissions.  Unfortunately at this point only objects in sys.all_objects will work.
        This parameter uses the pattern '%' + @ObjectName + '%'
    @Permission
        If NOT NULL then the third query will display only permissions that match what is in
        the parameter.  The first two queries will display only those users with that specific
        permission.
    @LoginName
        If NOT NULL then each of the queries will only pull back database principals that
        have the same SID as a login that matches the pattern '%' + @LoginName + '%'
    @UseLikeSearch
        When this is set to 1 (the default) then the search parameters will use LIKE (and
        %'s will be added around the @Principal, @Role, @ObjectName, and @LoginName parameters).  
        When set to 0 searchs will use =.
    @IncludeMSShipped
        When this is set to 1 (the default) then all principals will be included.  When set 
        to 0 the fixed server roles and SA and Public principals will be excluded.
    @DropTempTables
        When this is set to 1 (the default) the temp tables used are dropped.  If it's 0
        then the tempt ables are kept for references after the code has finished.
        The temp tables are:
            ##DBPrincipals
            ##DBRoles 
            ##DBPermissions
    @Output
        What type of output is desired.
        Default - Either 'Default' or it doesn't match any of the allowed values then the SP
                    will return the standard 3 outputs.
        None - No output at all.  Usually used if you keeping the temp tables to do your own
                    reporting.
        CreateOnly - Only return the create scripts where they aren't NULL.
        DropOnly - Only return the drop scripts where they aren't NULL.
        ScriptsOnly - Return drop and create scripts where they aren't NULL.
        Report - Returns one output with one row per principal and a comma delimited list of
                    roles the principal is a member of and a comma delimited list of the 
                    individual permissions they have.
    @Print
        Defaults to 0, but if a 1 is passed in then the queries are not run but printed
        out instead.  This is primarily for debugging.
     
Data is ordered as follows
    1st result set: DBPrincipal
    2nd result set: RoleName, UserName if the parameter @Role is used else
                    UserName, RoleName
    3rd result set: ObjectName then Grantee_Name if the parameter @ObjectName
                    is used otherwise Grantee_Name, ObjectName
     
-- V2.0
-- 8/18/2013 � Create a stub if the SP doesn�t exist, then always do an alter
-- 8/18/2013 - Use instance collation for all concatenated strings
-- 9/04/2013 - dbo can�t be added or removed from roles.  Don�t script.
-- 9/04/2013 - Fix scripts for schema level permissions.
-- 9/04/2013 � Change print option to show values of variables not the 
--             Variable names.
-- V3.0
-- 10/5/2013 - Added @Type parameter to pull only principals of a given type.
-- 10/10/2013 - Added @ObjectName parameter to pull only permissions for a given object.
-- V4.0
-- 11/18/2013 - Added parameter names to sp_addrolemember and sp_droprolemember.
-- 11/19/2013 - Added an ORDER BY to each of the result sets.  See above for details.
-- 01/04/2014 - Add an ALL option to the DBName parameter.
-- V4.1
-- 02/07/2014 - Fix bug scripting permissions where object and schema have the same ID
-- 02/15/2014 - Add support for user defined types
-- 02/15/2014 - Fix: Add schema to object GRANT and REVOKE scripts
-- V5.0
-- 4/29/2014 - Fix: Removed extra print statements
-- 4/29/2014 - Fix: Added SET NOCOUNT ON
-- 4/29/2014 - Added a USE statement to the scripts when using the @DBName = 'All' option
-- 5/01/2014 - Added @Permission parameter
-- 5/14/2014 - Added additional permissions based on information from Kendal Van Dyke's
        post http://www.kendalvandyke.com/2014/02/using-sysobjects-when-scripting.html
-- 6/02/2014 - Added @LoginName parameter
-- V5.5
-- 7/15/2014 - Bunch of changes recommended by @SQLSoldier/"https://twitter.com/SQLSoldier"
                Primarily changing the strings to unicode & adding QUOTENAME in a few places
                I'd missed it.
-- V6.0
-- 10/19/2014 - Add @UserLikeSearch and @IncludeMSShipped parameters. 
-- 11/29/2016 - Fixed permissions for symmetric keys
--              Found and fixed by Brenda Grossnickle
-- 03/25/2017 - Move SID towards the end of the first output so the more important 
--              columns are closer to the front.
-- 03/25/2017 - Add IF Exists to drop and create user scripts
-- 03/25/2017 - Remove create/drop user scripts for guest, public, sys and INFORMATION_SCHEMA
-- 03/25/2017 - Add @DropTempTables to keep the temp tables after the SP is run.
-- 03/26/2017 - Add @Output to allow different types of output.
*********************************************************************************************/
     
CREATE PROCEDURE [dbo].[sp_DBPermissions] 
(
    @DBName sysname = NULL, 
    @Principal sysname = NULL, 
    @Role sysname = NULL, 
    @Type nvarchar(30) = NULL,
    @ObjectName sysname = NULL,
    @Permission sysname = NULL,
    @LoginName sysname = NULL,
    @UseLikeSearch bit = 1,
    @IncludeMSShipped bit = 1,
    @DropTempTables bit = 1,
    @Output varchar(30) = 'Default',
    @Print bit = 0
)
AS
   
SET NOCOUNT ON
     
DECLARE @Collation nvarchar(75) 
SET @Collation = N' COLLATE ' + CAST(SERVERPROPERTY('Collation') AS nvarchar(50))
     
DECLARE @sql nvarchar(max)
DECLARE @sql2 nvarchar(max)
DECLARE @ObjectList nvarchar(max)
DECLARE @use nvarchar(500)
DECLARE @AllDBNames sysname
     
IF @DBName IS NULL OR @DBName = N'All'
    BEGIN
        SET @use = ''
        IF @DBName IS NULL
            SET @DBName = DB_NAME()
            --SELECT @DBName = db_name(database_id) 
            --FROM sys.dm_exec_requests 
            --WHERE session_id = @@SPID
    END
ELSE
--    IF EXISTS (SELECT 1 FROM sys.databases WHERE name = @DBName)
    IF db_id(@DBName) IS NOT NULL
        SET @use = N'USE ' + QUOTENAME(@DBName) + N';' + NCHAR(13)
    ELSE
        BEGIN
            RAISERROR (N'%s is not a valid database name.',
                            16, 
                            1,
                            @DBName)
            RETURN
        END
 
DECLARE @LikeOperator nvarchar(4)
 
IF @UseLikeSearch = 1
    SET @LikeOperator = N'LIKE'
ELSE
    SET @LikeOperator = N'='
     
IF @UseLikeSearch = 1
BEGIN
    IF LEN(ISNULL(@Principal,'')) > 0
        SET @Principal = N'%' + @Principal + N'%'
         
    IF LEN(ISNULL(@Role,'')) > 0
        SET @Role = N'%' + @Role + N'%'
     
    IF LEN(ISNULL(@ObjectName,'')) > 0
        SET @ObjectName = N'%' + @ObjectName + N'%'
   
    IF LEN(ISNULL(@LoginName,'')) > 0
        SET @LoginName = N'%' + @LoginName + N'%'
END
   
IF @Print = 1 AND @DBName = N'All'
    BEGIN
        PRINT 'DECLARE @AllDBNames sysname'
        PRINT 'SET @AllDBNames = ''master'''
        PRINT ''
    END
--=========================================================================
-- Database Principals
SET @sql =   
    N'SELECT ' + CASE WHEN @DBName = 'All' THEN N'@AllDBNames' ELSE N'''' + @DBName + N'''' END + N' AS DBName,' + 
    N'   DBPrincipals.principal_id AS DBPrincipalId, DBPrincipals.name AS DBPrincipal, SrvPrincipals.name AS SrvPrincipal, ' + NCHAR(13) + 
    N'   DBPrincipals.type, DBPrincipals.type_desc, DBPrincipals.default_schema_name, DBPrincipals.create_date, ' + NCHAR(13) + 
    N'   DBPrincipals.modify_date, DBPrincipals.is_fixed_role, ' + NCHAR(13) +
    N'   Authorizations.name AS RoleAuthorization, DBPrincipals.sid, ' + NCHAR(13) +  
    N'   CASE WHEN DBPrincipals.is_fixed_role = 0 AND DBPrincipals.name NOT IN (''dbo'',''guest'', ''INFORMATION_SCHEMA'', ''public'', ''sys'') THEN ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' + NCHAR(13) ELSE N'' END + 
    N'          ''IF DATABASE_PRINCIPAL_ID('''''' + DBPrincipals.name + '''''') IS NOT NULL '' + ' + NCHAR(13) + 
    N'           ''DROP '' + CASE DBPrincipals.[type] WHEN ''C'' THEN NULL ' + NCHAR(13) + 
    N'               WHEN ''K'' THEN NULL ' + NCHAR(13) + 
    N'               WHEN ''R'' THEN ''ROLE'' ' + NCHAR(13) + 
    N'               WHEN ''A'' THEN ''APPLICATION ROLE'' ' + NCHAR(13) + 
    N'               ELSE ''USER'' END + ' + NCHAR(13) + 
    N'           '' ''+QUOTENAME(DBPrincipals.name' + @Collation + N') + '';'' ELSE NULL END AS DropScript, ' + NCHAR(13) + 
    N'   CASE WHEN DBPrincipals.is_fixed_role = 0 AND DBPrincipals.name NOT IN (''dbo'',''guest'', ''INFORMATION_SCHEMA'', ''public'', ''sys'') THEN ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' +NCHAR(13) ELSE N'' END + 
    N'          ''IF DATABASE_PRINCIPAL_ID('''''' + DBPrincipals.name + '''''') IS NULL '' + ' + NCHAR(13) + 
    N'           ''CREATE '' + CASE DBPrincipals.[type] WHEN ''C'' THEN NULL ' + NCHAR(13) + 
    N'               WHEN ''K'' THEN NULL ' + NCHAR(13) + 
    N'               WHEN ''R'' THEN ''ROLE'' ' + NCHAR(13) + 
    N'               WHEN ''A'' THEN ''APPLICATION ROLE'' ' + NCHAR(13) + 
    N'               ELSE ''USER'' END + ' + NCHAR(13) + 
    N'           '' ''+QUOTENAME(DBPrincipals.name' + @Collation + N') END + ' + NCHAR(13) + 
    N'           CASE WHEN DBPrincipals.[type] = ''R'' THEN ' + NCHAR(13) + 
    N'               ISNULL('' AUTHORIZATION ''+QUOTENAME(Authorizations.name' + @Collation + N'),'''') ' + NCHAR(13) + 
    N'               WHEN DBPrincipals.[type] = ''A'' THEN ' + NCHAR(13) + 
    N'                   ''''  ' + NCHAR(13) + 
    N'               WHEN DBPrincipals.[type] NOT IN (''C'',''K'') THEN ' + NCHAR(13) + 
    N'                   ISNULL('' FOR LOGIN '' + 
                            QUOTENAME(SrvPrincipals.name' + @Collation + N'),'' WITHOUT LOGIN'') +  ' + NCHAR(13) + 
    N'                   ISNULL('' WITH DEFAULT_SCHEMA =  ''+
                            QUOTENAME(DBPrincipals.default_schema_name' + @Collation + N'),'''') ' + NCHAR(13) + 
    N'           ELSE '''' ' + NCHAR(13) + 
    N'           END + '';'' +  ' + NCHAR(13) + 
    N'           CASE WHEN DBPrincipals.[type] NOT IN (''C'',''K'',''R'',''A'') ' + NCHAR(13) + 
    N'               AND SrvPrincipals.name IS NULL ' + NCHAR(13) + 
    N'               AND DBPrincipals.sid IS NOT NULL ' + NCHAR(13) + 
    N'               AND DBPrincipals.sid NOT IN (0x00, 0x01)  ' + NCHAR(13) + 
    N'               THEN '' -- Possible missing server principal''  ' + NCHAR(13) + 
    N'               ELSE '''' END ' + NCHAR(13) + 
    N'       AS CreateScript ' + NCHAR(13) + 
    N'FROM sys.database_principals DBPrincipals ' + NCHAR(13) + 
    N'LEFT OUTER JOIN sys.database_principals Authorizations ' + NCHAR(13) + 
    N'   ON DBPrincipals.owning_principal_id = Authorizations.principal_id ' + NCHAR(13) + 
    N'LEFT OUTER JOIN sys.server_principals SrvPrincipals ' + NCHAR(13) + 
    N'   ON DBPrincipals.sid = SrvPrincipals.sid ' + NCHAR(13) + 
    N'   AND DBPrincipals.sid NOT IN (0x00, 0x01) ' + NCHAR(13) + 
    N'WHERE 1=1 '
     
IF LEN(ISNULL(@Principal,@Role)) > 0 
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.name ' + @LikeOperator + N' ' + 
            ISNULL(QUOTENAME(@Principal,N''''),QUOTENAME(@Role,'''')) 
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.name ' + @LikeOperator + N' ISNULL(@Principal,@Role) '
     
IF LEN(@Type) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.type ' + @LikeOperator + N' ' + QUOTENAME(@Type,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.type ' + @LikeOperator + N' @Type'
     
IF LEN(@LoginName) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND SrvPrincipals.name ' + @LikeOperator + N' ' + QUOTENAME(@LoginName,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND SrvPrincipals.name ' + @LikeOperator + N' @LoginName'
   
IF LEN(@ObjectName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.all_objects [Objects] ' + NCHAR(13) + 
        N'               INNER JOIN sys.database_permissions Permission ' + NCHAR(13) +  
        N'                   ON Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'               WHERE Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'                 AND Permission.grantee_principal_id = DBPrincipals.principal_id ' + NCHAR(13)
           
        IF @Print = 1
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' ' + QUOTENAME(@ObjectName,'''') 
        ELSE
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' @ObjectName'
   
        SET @sql = @sql + N')'
    END
   
IF LEN(@Permission) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.database_permissions Permission ' + NCHAR(13) +  
        N'               WHERE Permission.grantee_principal_id = DBPrincipals.principal_id ' + NCHAR(13)
           
        IF @Print = 1
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' ' + QUOTENAME(@Permission,'''') 
        ELSE
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' @Permission'
   
        SET @sql = @sql + N')'
    END
 
IF @IncludeMSShipped = 0
    SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.is_fixed_role = 0 ' + NCHAR(13) + 
                '  AND DBPrincipals.name NOT IN (''dbo'',''public'',''INFORMATION_SCHEMA'',''guest'',''sys'') '
 
IF @Print = 1
BEGIN
    PRINT N'-- Database Principals'
    PRINT CAST(@sql AS nvarchar(max))
    PRINT '' -- Spacing before the next print
    PRINT ''
END
ELSE
BEGIN
    IF object_id('tempdb..##DBPrincipals') IS NOT NULL
        DROP TABLE ##DBPrincipals
 
    -- Create temp table to store the data in
    CREATE TABLE ##DBPrincipals (
        DBName sysname NULL,
        DBPrincipalId int NULL,
        DBPrincipal sysname NULL,
        SrvPrincipal sysname NULL,
        type char(1) NULL,
        type_desc nchar(60) NULL,
        default_schema_name sysname NULL,
        create_date datetime NULL,
        modify_date datetime NULL,
        is_fixed_role bit NULL,
        RoleAuthorization sysname NULL,
        sid varbinary(85) NULL,
        DropScript nvarchar(max) NULL,
        CreateScript nvarchar(max) NULL
        )
     
    SET @sql =  @use + N'INSERT INTO ##DBPrincipals ' + NCHAR(13) + @sql
 
    IF @DBName = 'All'
        BEGIN
            -- Declare a READ_ONLY cursor to loop through the databases
            DECLARE cur_DBList CURSOR
            READ_ONLY
            FOR SELECT name FROM sys.databases ORDER BY name
     
            OPEN cur_DBList
     
            FETCH NEXT FROM cur_DBList INTO @AllDBNames
            WHILE (@@fetch_status <> -1)
            BEGIN
                IF (@@fetch_status <> -2)
                BEGIN
                    SET @sql2 = N'USE ' + QUOTENAME(@AllDBNames) + N';' + NCHAR(13) + @sql
                    EXEC sp_executesql @sql2, 
                        N'@Principal sysname, @Role sysname, @Type nvarchar(30), @ObjectName sysname, 
                        @AllDBNames sysname, @Permission sysname, @LoginName sysname', 
                        @Principal, @Role, @Type, @ObjectName, @AllDBNames, @Permission, @LoginName
                    -- PRINT @sql2
                END
                FETCH NEXT FROM cur_DBList INTO @AllDBNames
            END
     
            CLOSE cur_DBList
            DEALLOCATE cur_DBList
        END
    ELSE
        EXEC sp_executesql @sql, N'@Principal sysname, @Role sysname, @Type nvarchar(30), 
            @ObjectName sysname, @Permission sysname, @LoginName sysname', 
            @Principal, @Role, @Type, @ObjectName, @Permission, @LoginName
END 
--=========================================================================
-- Database Role Members
SET @sql =  
    N'SELECT ' + CASE WHEN @DBName = 'All' THEN N'@AllDBNames' ELSE N'''' + @DBName + N'''' END + N' AS DBName,' + 
    N' Users.principal_id AS UserPrincipalId, Users.name AS UserName, Roles.name AS RoleName, ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' + NCHAR(13) ELSE N'' END + 
    N'   CASE WHEN Users.is_fixed_role = 0 AND Users.name <> ''dbo'' THEN ' + NCHAR(13) + 
    N'   ''EXEC sp_droprolemember @rolename = ''+QUOTENAME(Roles.name' + @Collation + 
                N','''''''')+'', @membername = ''+QUOTENAME(CASE WHEN Users.name = ''dbo'' THEN NULL
                ELSE Users.name END' + @Collation + 
                N','''''''')+'';'' END AS DropScript, ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' + NCHAR(13) ELSE N'' END + 
    N'   CASE WHEN Users.is_fixed_role = 0 AND Users.name <> ''dbo'' THEN ' + NCHAR(13) + 
    N'   ''EXEC sp_addrolemember @rolename = ''+QUOTENAME(Roles.name' + @Collation + 
                N','''''''')+'', @membername = ''+QUOTENAME(CASE WHEN Users.name = ''dbo'' THEN NULL
                ELSE Users.name END' + @Collation + 
                N','''''''')+'';'' END AS AddScript ' + NCHAR(13) + 
    N'FROM sys.database_role_members RoleMembers ' + NCHAR(13) + 
    N'JOIN sys.database_principals Users ' + NCHAR(13) + 
    N'   ON RoleMembers.member_principal_id = Users.principal_id ' + NCHAR(13) + 
    N'JOIN sys.database_principals Roles ' + NCHAR(13) + 
    N'   ON RoleMembers.role_principal_id = Roles.principal_id ' + NCHAR(13) + 
    N'WHERE 1=1 '
         
IF LEN(ISNULL(@Principal,'')) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Users.name ' + @LikeOperator + N' '+QUOTENAME(@Principal,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Users.name ' + @LikeOperator + N' @Principal'
     
IF LEN(ISNULL(@Role,'')) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Roles.name ' + @LikeOperator + N' '+QUOTENAME(@Role,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Roles.name ' + @LikeOperator + N' @Role'
     
IF LEN(@Type) > 0 
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Users.type ' + @LikeOperator + N' ' + QUOTENAME(@Type,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Users.type ' + @LikeOperator + N' @Type'
   
IF LEN(@LoginName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.server_principals SrvPrincipals ' + NCHAR(13) + 
        N'               WHERE Users.sid NOT IN (0x00, 0x01) ' + NCHAR(13) + 
        N'                 AND SrvPrincipals.sid = Users.sid ' + NCHAR(13) + 
        N'                 AND Users.type NOT IN (''R'') ' + NCHAR(13) 
        IF @Print = 1
            SET @sql = @sql + NCHAR(13) + '  AND SrvPrincipals.name ' + @LikeOperator + N' ' + QUOTENAME(@LoginName,'''')
        ELSE
            SET @sql = @sql + NCHAR(13) + '  AND SrvPrincipals.name ' + @LikeOperator + N' @LoginName'
   
        SET @sql = @sql + N')'
    END
   
IF LEN(@ObjectName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.all_objects [Objects] ' + NCHAR(13) + 
        N'               INNER JOIN sys.database_permissions Permission ' + NCHAR(13) +  
        N'                   ON Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'               WHERE Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'                 AND Permission.grantee_principal_id = Users.principal_id ' + NCHAR(13)
           
        IF @Print = 1
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' ' + QUOTENAME(@ObjectName,'''') 
        ELSE
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' @ObjectName'
   
        SET @sql = @sql + N')'
    END
   
IF LEN(@Permission) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.database_permissions Permission ' + NCHAR(13) +  
        N'               WHERE Permission.grantee_principal_id = Users.principal_id ' + NCHAR(13)
           
        IF @Print = 1
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' ' + QUOTENAME(@Permission,'''') 
        ELSE
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' @Permission'
   
        SET @sql = @sql + N')'
    END
   
IF @IncludeMSShipped = 0
    SET @sql = @sql + NCHAR(13) + N'  AND Users.is_fixed_role = 0 ' + NCHAR(13) + 
                '  AND Users.name NOT IN (''dbo'',''public'',''INFORMATION_SCHEMA'',''guest'',''sys'') '
 
IF @Print = 1
BEGIN
    PRINT N'-- Database Role Members'
    PRINT CAST(@sql AS nvarchar(max))
    PRINT '' -- Spacing before the next print
    PRINT ''
END
ELSE
BEGIN
    IF object_id('tempdb..##DBRoles') IS NOT NULL
        DROP TABLE ##DBRoles
 
    -- Create temp table to store the data in
    CREATE TABLE ##DBRoles (
        DBName sysname NULL,
        UserPrincipalId int NULL,
        UserName sysname NULL,
        RoleName sysname NULL,
        DropScript nvarchar(max) NULL,
        AddScript nvarchar(max) NULL
        )
 
    SET @sql =  @use + NCHAR(13) + 'INSERT INTO ##DBRoles ' + NCHAR(13) + @sql
     
    IF @DBName = 'All'
        BEGIN
            -- Declare a READ_ONLY cursor to loop through the databases
            DECLARE cur_DBList CURSOR
            READ_ONLY
            FOR SELECT name FROM sys.databases ORDER BY name
     
            OPEN cur_DBList
     
            FETCH NEXT FROM cur_DBList INTO @AllDBNames
            WHILE (@@fetch_status <> -1)
            BEGIN
                IF (@@fetch_status <> -2)
                BEGIN
                    SET @sql2 = 'USE ' + QUOTENAME(@AllDBNames) + ';' + NCHAR(13) + @sql
                    EXEC sp_executesql @sql2, 
                        N'@Principal sysname, @Role sysname, @Type nvarchar(30), @ObjectName sysname, 
                        @AllDBNames sysname, @Permission sysname, @LoginName sysname', 
                        @Principal, @Role, @Type, @ObjectName, @AllDBNames, @Permission, @LoginName
                    -- PRINT @sql2
                END
                FETCH NEXT FROM cur_DBList INTO @AllDBNames
            END
     
            CLOSE cur_DBList
            DEALLOCATE cur_DBList
        END
    ELSE
        EXEC sp_executesql @sql, N'@Principal sysname, @Role sysname, @Type nvarchar(30), 
            @ObjectName sysname, @Permission sysname, @LoginName sysname', 
            @Principal, @Role, @Type, @ObjectName, @Permission, @LoginName
END
     
--=========================================================================
-- Database & object Permissions
SET @ObjectList =
    N'; WITH ObjectList AS (' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName , ' + NCHAR(13) + 
    N'       name ' + @Collation + ' AS name, ' + NCHAR(13) + 
    N'       database_id AS id, ' + NCHAR(13) + 
    N'       ''DATABASE'' AS class_desc,' + NCHAR(13) + 
    N'       '''' AS class ' + NCHAR(13) + 
    N'   FROM master.sys.databases' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT SCHEMA_NAME(sys.all_objects.schema_id) ' + @Collation + N' AS SchemaName,' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       object_id AS id, ' + NCHAR(13) + 
    N'       ''OBJECT_OR_COLUMN'' AS class_desc,' + NCHAR(13) + 
    N'       ''OBJECT'' AS class ' + NCHAR(13) + 
    N'   FROM sys.all_objects' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT name ' + @Collation + N' AS SchemaName, ' + NCHAR(13) + 
    N'       NULL AS name, ' + NCHAR(13) + 
    N'       schema_id AS id, ' + NCHAR(13) + 
    N'       ''SCHEMA'' AS class_desc,' + NCHAR(13) + 
    N'       ''SCHEMA'' AS class ' + NCHAR(13) + 
    N'   FROM sys.schemas' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       principal_id AS id, ' + NCHAR(13) + 
    N'       ''DATABASE_PRINCIPAL'' AS class_desc,' + NCHAR(13) + 
    N'       CASE type_desc ' + NCHAR(13) + 
    N'           WHEN ''APPLICATION_ROLE'' THEN ''APPLICATION ROLE'' ' + NCHAR(13) + 
    N'           WHEN ''DATABASE_ROLE'' THEN ''ROLE'' ' + NCHAR(13) + 
    N'           ELSE ''USER'' END AS class ' + NCHAR(13) + 
    N'   FROM sys.database_principals' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       assembly_id AS id, ' + NCHAR(13) + 
    N'       ''ASSEMBLY'' AS class_desc,' + NCHAR(13) + 
    N'       ''ASSEMBLY'' AS class ' + NCHAR(13) + 
    N'   FROM sys.assemblies' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) 
 
SET @ObjectList = @ObjectList + 
    N'   SELECT SCHEMA_NAME(sys.types.schema_id) ' + @Collation + N' AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       user_type_id AS id, ' + NCHAR(13) + 
    N'       ''TYPE'' AS class_desc,' + NCHAR(13) + 
    N'       ''TYPE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.types' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT SCHEMA_NAME(schema_id) ' + @Collation + N' AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       xml_collection_id AS id, ' + NCHAR(13) + 
    N'       ''XML_SCHEMA_COLLECTION'' AS class_desc,' + NCHAR(13) + 
    N'       ''XML SCHEMA COLLECTION'' AS class ' + NCHAR(13) + 
    N'   FROM sys.xml_schema_collections' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       message_type_id AS id, ' + NCHAR(13) + 
    N'       ''MESSAGE_TYPE'' AS class_desc,' + NCHAR(13) + 
    N'       ''MESSAGE TYPE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.service_message_types' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       service_contract_id AS id, ' + NCHAR(13) + 
    N'       ''SERVICE_CONTRACT'' AS class_desc,' + NCHAR(13) + 
    N'       ''CONTRACT'' AS class ' + NCHAR(13) + 
    N'   FROM sys.service_contracts' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       service_id AS id, ' + NCHAR(13) + 
    N'       ''SERVICE'' AS class_desc,' + NCHAR(13) + 
    N'       ''SERVICE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.services' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       remote_service_binding_id AS id, ' + NCHAR(13) + 
    N'       ''REMOTE_SERVICE_BINDING'' AS class_desc,' + NCHAR(13) + 
    N'       ''REMOTE SERVICE BINDING'' AS class ' + NCHAR(13) + 
    N'   FROM sys.remote_service_bindings' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       route_id AS id, ' + NCHAR(13) + 
    N'       ''ROUTE'' AS class_desc,' + NCHAR(13) + 
    N'       ''ROUTE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.routes' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       fulltext_catalog_id AS id, ' + NCHAR(13) + 
    N'       ''FULLTEXT_CATALOG'' AS class_desc,' + NCHAR(13) + 
    N'       ''FULLTEXT CATALOG'' AS class ' + NCHAR(13) + 
    N'   FROM sys.fulltext_catalogs' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       symmetric_key_id AS id, ' + NCHAR(13) + 
    N'       ''SYMMETRIC_KEYS'' AS class_desc,' + NCHAR(13) + 
    N'       ''SYMMETRIC KEY'' AS class ' + NCHAR(13) + 
    N'   FROM sys.symmetric_keys' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       certificate_id AS id, ' + NCHAR(13) + 
    N'       ''CERTIFICATE'' AS class_desc,' + NCHAR(13) + 
    N'       ''CERTIFICATE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.certificates' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       asymmetric_key_id AS id, ' + NCHAR(13) + 
    N'       ''ASYMMETRIC_KEY'' AS class_desc,' + NCHAR(13) + 
    N'       ''ASYMMETRIC KEY'' AS class ' + NCHAR(13) + 
    N'   FROM sys.asymmetric_keys' + NCHAR(13) +  
    N'   ) ' + NCHAR(13)
   
    SET @sql =
    N'SELECT ' + CASE WHEN @DBName = 'All' THEN N'@AllDBNames' ELSE N'''' + @DBName + N'''' END + N' AS DBName,' + NCHAR(13) + 
    N'   Grantee.principal_id AS GranteePrincipalId, Grantee.name AS GranteeName, Grantor.name AS GrantorName, ' + NCHAR(13) + 
    N'   Permission.class_desc, Permission.permission_name, ' + NCHAR(13) + 
    N'   ObjectList.name AS ObjectName, ' + NCHAR(13) + 
    N'   ObjectList.SchemaName, ' + NCHAR(13) + 
    N'   Permission.state_desc,  ' + NCHAR(13) + 
    N'   CASE WHEN Grantee.is_fixed_role = 0 AND Grantee.name <> ''dbo'' THEN ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' + NCHAR(13) ELSE N'' END + 
    N'   ''REVOKE '' + ' + NCHAR(13) + 
    N'   CASE WHEN Permission.[state]  = ''W'' THEN ''GRANT OPTION FOR '' ELSE '''' END + ' + NCHAR(13) + 
    N'   '' '' + Permission.permission_name' + @Collation + N' +  ' + NCHAR(13) + 
    N'       CASE WHEN Permission.major_id <> 0 THEN '' ON '' + ' + NCHAR(13) + 
    N'           ObjectList.class + ''::'' +  ' + NCHAR(13) + 
    N'           ISNULL(QUOTENAME(ObjectList.SchemaName),'''') + ' + NCHAR(13) + 
    N'           CASE WHEN ObjectList.SchemaName + ObjectList.name IS NULL THEN '''' ELSE ''.'' END + ' + NCHAR(13) + 
    N'           ISNULL(QUOTENAME(ObjectList.name),'''') ' + NCHAR(13) + 
    N'           ' + @Collation + ' + '' '' ELSE '''' END + ' + NCHAR(13) + 
    N'       '' FROM '' + QUOTENAME(Grantee.name' + @Collation + N')  + ''; '' END AS RevokeScript, ' + NCHAR(13) + 
    N'   CASE WHEN Grantee.is_fixed_role = 0 AND Grantee.name <> ''dbo'' THEN ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' + NCHAR(13) ELSE N'' END + 
    N'   CASE WHEN Permission.[state]  = ''W'' THEN ''GRANT'' ELSE Permission.state_desc' + @Collation + 
            N' END + ' + NCHAR(13) + 
    N'       '' '' + Permission.permission_name' + @Collation + N' + ' + NCHAR(13) + 
    N'       CASE WHEN Permission.major_id <> 0 THEN '' ON '' + ' + NCHAR(13) + 
    N'           ObjectList.class + ''::'' +  ' + NCHAR(13) + 
    N'           ISNULL(QUOTENAME(ObjectList.SchemaName),'''') + ' + NCHAR(13) + 
    N'           CASE WHEN ObjectList.SchemaName + ObjectList.name IS NULL THEN '''' ELSE ''.'' END + ' + NCHAR(13) + 
    N'           ISNULL(QUOTENAME(ObjectList.name),'''') ' + NCHAR(13) + 
    N'           ' + @Collation + N' + '' '' ELSE '''' END + ' + NCHAR(13) + 
    N'       '' TO '' + QUOTENAME(Grantee.name' + @Collation + N')  + '' '' +  ' + NCHAR(13) + 
    N'       CASE WHEN Permission.[state]  = ''W'' THEN '' WITH GRANT OPTION '' ELSE '''' END +  ' + NCHAR(13) + 
    N'       '' AS ''+ QUOTENAME(Grantor.name' + @Collation + N')+'';'' END AS GrantScript ' + NCHAR(13) + 
    N'FROM sys.database_permissions Permission ' + NCHAR(13) + 
    N'JOIN sys.database_principals Grantee ' + NCHAR(13) + 
    N'   ON Permission.grantee_principal_id = Grantee.principal_id ' + NCHAR(13) + 
    N'JOIN sys.database_principals Grantor ' + NCHAR(13) + 
    N'   ON Permission.grantor_principal_id = Grantor.principal_id ' + NCHAR(13) + 
    N'LEFT OUTER JOIN ObjectList ' + NCHAR(13) + 
    N'   ON Permission.major_id = ObjectList.id ' + NCHAR(13) + 
    N'   AND Permission.class_desc = ObjectList.class_desc ' + NCHAR(13) + 
    N'WHERE 1=1 '
     
IF LEN(ISNULL(@Principal,@Role)) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.name ' + @LikeOperator + N' ' + ISNULL(QUOTENAME(@Principal,''''),QUOTENAME(@Role,'''')) 
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.name ' + @LikeOperator + N' ISNULL(@Principal,@Role) '
             
IF LEN(@Type) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.type ' + @LikeOperator + N' ' + QUOTENAME(@Type,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.type ' + @LikeOperator + N' @Type'
     
IF LEN(@ObjectName) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND ObjectList.name ' + @LikeOperator + N' ' + QUOTENAME(@ObjectName,'''') 
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND ObjectList.name ' + @LikeOperator + N' @ObjectName '
     
IF LEN(@Permission) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Permission.permission_name ' + @LikeOperator + N' ' + QUOTENAME(@Permission,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Permission.permission_name ' + @LikeOperator + N' @Permission'
   
IF LEN(@LoginName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.server_principals SrvPrincipals ' + NCHAR(13) + 
        N'               WHERE SrvPrincipals.sid = Grantee.sid ' + NCHAR(13) + 
        N'                 AND Grantee.sid NOT IN (0x00, 0x01) ' + NCHAR(13) + 
        N'                 AND Grantee.type NOT IN (''R'') ' + NCHAR(13) 
        IF @Print = 1
            SET @sql = @sql + NCHAR(13) + N'  AND SrvPrincipals.name ' + @LikeOperator + N' ' + QUOTENAME(@LoginName,'''')
        ELSE
            SET @sql = @sql + NCHAR(13) + N'  AND SrvPrincipals.name ' + @LikeOperator + N' @LoginName'
   
        SET @sql = @sql + ')'
    END
 
IF @IncludeMSShipped = 0
    SET @sql = @sql + NCHAR(13) + N'  AND Grantee.is_fixed_role = 0 ' + NCHAR(13) + 
                '  AND Grantee.name NOT IN (''dbo'',''public'',''INFORMATION_SCHEMA'',''guest'',''sys'') '
   
IF @Print = 1
    BEGIN
        PRINT '-- Database & object Permissions'
        PRINT CAST(@use AS nvarchar(max))
        PRINT CAST(@ObjectList AS nvarchar(max))
        PRINT CAST(@sql AS nvarchar(max))
    END
ELSE
BEGIN
    IF object_id('tempdb..##DBPermissions') IS NOT NULL
        DROP TABLE ##DBPermissions
 
    -- Create temp table to store the data in
    CREATE TABLE ##DBPermissions (
        DBName sysname NULL,
        GranteePrincipalId int NULL,
        GranteeName sysname NULL,
        GrantorName sysname NULL,
        class_desc nvarchar(60) NULL,
        permission_name nvarchar(128) NULL,
        ObjectName sysname NULL,
        SchemaName sysname NULL,
        state_desc nvarchar(60) NULL,
        RevokeScript nvarchar(max) NULL,
        GrantScript nvarchar(max) NULL
        )
     
    -- Add insert statement to @sql
    SET @sql =  @use + @ObjectList + 
                N'INSERT INTO ##DBPermissions ' + NCHAR(13) + 
                @sql
     
    IF @DBName = 'All'
        BEGIN
            -- Declare a READ_ONLY cursor to loop through the databases
            DECLARE cur_DBList CURSOR
            READ_ONLY
            FOR SELECT name FROM sys.databases ORDER BY name
     
            OPEN cur_DBList
     
            FETCH NEXT FROM cur_DBList INTO @AllDBNames
            WHILE (@@fetch_status <> -1)
            BEGIN
                IF (@@fetch_status <> -2)
                BEGIN
                    SET @sql2 = 'USE ' + QUOTENAME(@AllDBNames) + ';' + NCHAR(13) + @sql
                    EXEC sp_executesql @sql2, 
                        N'@Principal sysname, @Role sysname, @Type nvarchar(30), @ObjectName sysname, 
                            @AllDBNames sysname, @Permission sysname, @LoginName sysname', 
                        @Principal, @Role, @Type, @ObjectName, @AllDBNames, @Permission, @LoginName
                    -- PRINT @sql2
                END
                FETCH NEXT FROM cur_DBList INTO @AllDBNames
            END
     
            CLOSE cur_DBList
            DEALLOCATE cur_DBList
        END
    ELSE
        BEGIN
            EXEC sp_executesql @sql, N'@Principal sysname, @Role sysname, @Type nvarchar(30), 
                @ObjectName sysname, @Permission sysname, @LoginName sysname', 
                @Principal, @Role, @Type, @ObjectName, @Permission, @LoginName
        END
END
 
IF @Print <> 1
BEGIN
    IF @Output = 'None'
        PRINT ''
    ELSE IF @Output = 'CreateOnly'
    BEGIN
        SELECT CreateScript FROM ##DBPrincipals WHERE CreateScript IS NOT NULL
        SELECT AddScript FROM ##DBRoles WHERE AddScript IS NOT NULL
        SELECT GrantScript FROM ##DBPermissions WHERE GrantScript IS NOT NULL
    END
    ELSE IF @Output = 'DropOnly'
    BEGIN
        SELECT DropScript FROM ##DBPrincipals WHERE DropScript IS NOT NULL
        SELECT DropScript FROM ##DBRoles WHERE DropScript IS NOT NULL
        SELECT RevokeScript FROM ##DBPermissions WHERE RevokeScript IS NOT NULL
    END
    ELSE IF @Output = 'ScriptsOnly'
    BEGIN
        SELECT DropScript, CreateScript FROM ##DBPrincipals WHERE DropScript IS NOT NULL OR CreateScript IS NOT NULL
        SELECT DropScript, AddScript FROM ##DBRoles WHERE DropScript IS NOT NULL OR AddScript IS NOT NULL
        SELECT RevokeScript, GrantScript FROM ##DBPermissions WHERE RevokeScript IS NOT NULL OR GrantScript IS NOT NULL
    END
    ELSE IF @Output = 'Report'
    BEGIN
        SELECT DBName, DBPrincipal, SrvPrincipal, type, type_desc,
                STUFF((SELECT ', ' + ##DBRoles.RoleName
                        FROM ##DBRoles
                        WHERE ##DBPrincipals.DBName = ##DBRoles.DBName
                          AND ##DBPrincipals.DBPrincipalId = ##DBRoles.UserPrincipalId
                        ORDER BY ##DBRoles.RoleName
                        FOR XML PATH(''),TYPE).value('.','VARCHAR(MAX)')
                    , 1, 2, '') AS RoleMembership,
                STUFF((SELECT ', ' + ##DBPermissions.state_desc + ' ' + ##DBPermissions.permission_name + ' on ' + 
                            ISNULL('OBJECT:'+##DBPermissions.ObjectName, 'DATABASE:'+##DBPermissions.DBName)
                        FROM ##DBPermissions
                        WHERE ##DBPrincipals.DBName = ##DBPermissions.DBName
                          AND ##DBPrincipals.DBPrincipalId = ##DBPermissions.GranteePrincipalId
                        ORDER BY ##DBPermissions.state_desc, ISNULL(##DBPermissions.ObjectName, ##DBPermissions.DBName), ##DBPermissions.permission_name
                        FOR XML PATH(''),TYPE).value('.','VARCHAR(MAX)')
                    , 1, 2, '') AS DirectPermissions
        FROM ##DBPrincipals
        ORDER BY DBName, type, DBPrincipal
    END
    ELSE -- 'Default' or no match
    BEGIN
        SELECT DBName, DBPrincipal, SrvPrincipal, type, type_desc, default_schema_name, 
                create_date, modify_date, is_fixed_role, RoleAuthorization, sid, 
                DropScript, CreateScript
        FROM ##DBPrincipals ORDER BY DBName, DBPrincipal
        IF LEN(@Role) > 0
            SELECT DBName, UserName, RoleName, DropScript, AddScript 
            FROM ##DBRoles ORDER BY DBName, RoleName, UserName
        ELSE
            SELECT DBName, UserName, RoleName, DropScript, AddScript 
            FROM ##DBRoles ORDER BY DBName, UserName, RoleName
 
        IF LEN(@ObjectName) > 0
            SELECT DBName, GranteeName, GrantorName, class_desc, permission_name, ObjectName, 
                SchemaName, state_desc, RevokeScript, GrantScript 
            FROM ##DBPermissions ORDER BY DBName, ObjectName, GranteeName
        ELSE
            SELECT DBName, GranteeName, GrantorName, class_desc, permission_name, ObjectName, 
                SchemaName, state_desc, RevokeScript, GrantScript 
            FROM ##DBPermissions ORDER BY DBName, GranteeName, ObjectName
    END
 
    IF @DropTempTables = 1
    BEGIN
        DROP TABLE ##DBPrincipals
        DROP TABLE ##DBRoles
        DROP TABLE ##DBPermissions
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_WhoIsActive]    Script Date: 10/19/2022 1:45:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************************************************************************
Who Is Active? v11.30 (2017-12-10)
(C) 2007-2017, Adam Machanic

Feedback: mailto:adam@dataeducation.com
Updates: http://whoisactive.com
Blog: http://dataeducation.com

License: 
	Who is Active? is free to download and use for personal, educational, and internal 
	corporate purposes, provided that this header is preserved. Redistribution or sale 
	of Who is Active?, in whole or in part, is prohibited without the author's express 
	written consent.
*********************************************************************************************/
CREATE PROC [dbo].[sp_WhoIsActive]
(
--~
	--Filters--Both inclusive and exclusive
	--Set either filter to '' to disable
	--Valid filter types are: session, program, database, login, and host
	--Session is a session ID, and either 0 or '' can be used to indicate "all" sessions
	--All other filter types support % or _ as wildcards
	@filter sysname = '',
	@filter_type VARCHAR(10) = 'session',
	@not_filter sysname = '',
	@not_filter_type VARCHAR(10) = 'session',

	--Retrieve data about the calling session?
	@show_own_spid BIT = 0,

	--Retrieve data about system sessions?
	@show_system_spids BIT = 0,

	--Controls how sleeping SPIDs are handled, based on the idea of levels of interest
	--0 does not pull any sleeping SPIDs
	--1 pulls only those sleeping SPIDs that also have an open transaction
	--2 pulls all sleeping SPIDs
	@show_sleeping_spids TINYINT = 1,

	--If 1, gets the full stored procedure or running batch, when available
	--If 0, gets only the actual statement that is currently running in the batch or procedure
	@get_full_inner_text BIT = 0,

	--Get associated query plans for running tasks, if available
	--If @get_plans = 1, gets the plan based on the request's statement offset
	--If @get_plans = 2, gets the entire plan based on the request's plan_handle
	@get_plans TINYINT = 0,

	--Get the associated outer ad hoc query or stored procedure call, if available
	@get_outer_command BIT = 0,

	--Enables pulling transaction log write info and transaction duration
	@get_transaction_info BIT = 0,

	--Get information on active tasks, based on three interest levels
	--Level 0 does not pull any task-related information
	--Level 1 is a lightweight mode that pulls the top non-CXPACKET wait, giving preference to blockers
	--Level 2 pulls all available task-based metrics, including: 
	--number of active tasks, current wait stats, physical I/O, context switches, and blocker information
	@get_task_info TINYINT = 1,

	--Gets associated locks for each request, aggregated in an XML format
	@get_locks BIT = 0,

	--Get average time for past runs of an active query
	--(based on the combination of plan handle, sql handle, and offset)
	@get_avg_time BIT = 0,

	--Get additional non-performance-related information about the session or request
	--text_size, language, date_format, date_first, quoted_identifier, arithabort, ansi_null_dflt_on, 
	--ansi_defaults, ansi_warnings, ansi_padding, ansi_nulls, concat_null_yields_null, 
	--transaction_isolation_level, lock_timeout, deadlock_priority, row_count, command_type
	--
	--If a SQL Agent job is running, an subnode called agent_info will be populated with some or all of
	--the following: job_id, job_name, step_id, step_name, msdb_query_error (in the event of an error)
	--
	--If @get_task_info is set to 2 and a lock wait is detected, a subnode called block_info will be
	--populated with some or all of the following: lock_type, database_name, object_id, file_id, hobt_id, 
	--applock_hash, metadata_resource, metadata_class_id, object_name, schema_name
	@get_additional_info BIT = 0,

	--Walk the blocking chain and count the number of 
	--total SPIDs blocked all the way down by a given session
	--Also enables task_info Level 1, if @get_task_info is set to 0
	@find_block_leaders BIT = 0,

	--Pull deltas on various metrics
	--Interval in seconds to wait before doing the second data pull
	@delta_interval TINYINT = 0,

	--List of desired output columns, in desired order
	--Note that the final output will be the intersection of all enabled features and all 
	--columns in the list. Therefore, only columns associated with enabled features will 
	--actually appear in the output. Likewise, removing columns from this list may effectively
	--disable features, even if they are turned on
	--
	--Each element in this list must be one of the valid output column names. Names must be
	--delimited by square brackets. White space, formatting, and additional characters are
	--allowed, as long as the list contains exact matches of delimited valid column names.
	@output_column_list VARCHAR(8000) = '[dd%][session_id][sql_text][sql_command][login_name][wait_info][tasks][tran_log%][cpu%][temp%][block%][reads%][writes%][context%][physical%][query_plan][locks][%]',

	--Column(s) by which to sort output, optionally with sort directions. 
		--Valid column choices:
		--session_id, physical_io, reads, physical_reads, writes, tempdb_allocations, 
		--tempdb_current, CPU, context_switches, used_memory, physical_io_delta, reads_delta, 
		--physical_reads_delta, writes_delta, tempdb_allocations_delta, tempdb_current_delta, 
		--CPU_delta, context_switches_delta, used_memory_delta, tasks, tran_start_time, 
		--open_tran_count, blocking_session_id, blocked_session_count, percent_complete, 
		--host_name, login_name, database_name, start_time, login_time, program_name
		--
		--Note that column names in the list must be bracket-delimited. Commas and/or white
		--space are not required. 
	@sort_order VARCHAR(500) = '[start_time] ASC',

	--Formats some of the output columns in a more "human readable" form
	--0 disables outfput format
	--1 formats the output for variable-width fonts
	--2 formats the output for fixed-width fonts
	@format_output TINYINT = 1,

	--If set to a non-blank value, the script will attempt to insert into the specified 
	--destination table. Please note that the script will not verify that the table exists, 
	--or that it has the correct schema, before doing the insert.
	--Table can be specified in one, two, or three-part format
	@destination_table VARCHAR(4000) = '',

	--If set to 1, no data collection will happen and no result set will be returned; instead,
	--a CREATE TABLE statement will be returned via the @schema parameter, which will match 
	--the schema of the result set that would be returned by using the same collection of the
	--rest of the parameters. The CREATE TABLE statement will have a placeholder token of 
	--<table_name> in place of an actual table name.
	@return_schema BIT = 0,
	@schema VARCHAR(MAX) = NULL OUTPUT,

	--Help! What do I do?
	@help BIT = 0
--~
)
/*
OUTPUT COLUMNS
--------------
Formatted/Non:	[session_id] [smallint] NOT NULL
	Session ID (a.k.a. SPID)

Formatted:		[dd hh:mm:ss.mss] [varchar](15) NULL
Non-Formatted:	<not returned>
	For an active request, time the query has been running
	For a sleeping session, time since the last batch completed

Formatted:		[dd hh:mm:ss.mss (avg)] [varchar](15) NULL
Non-Formatted:	[avg_elapsed_time] [int] NULL
	(Requires @get_avg_time option)
	How much time has the active portion of the query taken in the past, on average?

Formatted:		[physical_io] [varchar](30) NULL
Non-Formatted:	[physical_io] [bigint] NULL
	Shows the number of physical I/Os, for active requests

Formatted:		[reads] [varchar](30) NULL
Non-Formatted:	[reads] [bigint] NULL
	For an active request, number of reads done for the current query
	For a sleeping session, total number of reads done over the lifetime of the session

Formatted:		[physical_reads] [varchar](30) NULL
Non-Formatted:	[physical_reads] [bigint] NULL
	For an active request, number of physical reads done for the current query
	For a sleeping session, total number of physical reads done over the lifetime of the session

Formatted:		[writes] [varchar](30) NULL
Non-Formatted:	[writes] [bigint] NULL
	For an active request, number of writes done for the current query
	For a sleeping session, total number of writes done over the lifetime of the session

Formatted:		[tempdb_allocations] [varchar](30) NULL
Non-Formatted:	[tempdb_allocations] [bigint] NULL
	For an active request, number of TempDB writes done for the current query
	For a sleeping session, total number of TempDB writes done over the lifetime of the session

Formatted:		[tempdb_current] [varchar](30) NULL
Non-Formatted:	[tempdb_current] [bigint] NULL
	For an active request, number of TempDB pages currently allocated for the query
	For a sleeping session, number of TempDB pages currently allocated for the session

Formatted:		[CPU] [varchar](30) NULL
Non-Formatted:	[CPU] [int] NULL
	For an active request, total CPU time consumed by the current query
	For a sleeping session, total CPU time consumed over the lifetime of the session

Formatted:		[context_switches] [varchar](30) NULL
Non-Formatted:	[context_switches] [bigint] NULL
	Shows the number of context switches, for active requests

Formatted:		[used_memory] [varchar](30) NOT NULL
Non-Formatted:	[used_memory] [bigint] NOT NULL
	For an active request, total memory consumption for the current query
	For a sleeping session, total current memory consumption

Formatted:		[physical_io_delta] [varchar](30) NULL
Non-Formatted:	[physical_io_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of physical I/Os reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[reads_delta] [varchar](30) NULL
Non-Formatted:	[reads_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of reads reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[physical_reads_delta] [varchar](30) NULL
Non-Formatted:	[physical_reads_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of physical reads reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[writes_delta] [varchar](30) NULL
Non-Formatted:	[writes_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of writes reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[tempdb_allocations_delta] [varchar](30) NULL
Non-Formatted:	[tempdb_allocations_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of TempDB writes reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[tempdb_current_delta] [varchar](30) NULL
Non-Formatted:	[tempdb_current_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of allocated TempDB pages reported on the first and second 
	collections. If the request started after the first collection, the value will be NULL

Formatted:		[CPU_delta] [varchar](30) NULL
Non-Formatted:	[CPU_delta] [int] NULL
	(Requires @delta_interval option)
	Difference between the CPU time reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[context_switches_delta] [varchar](30) NULL
Non-Formatted:	[context_switches_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the context switches count reported on the first and second collections
	If the request started after the first collection, the value will be NULL

Formatted:		[used_memory_delta] [varchar](30) NULL
Non-Formatted:	[used_memory_delta] [bigint] NULL
	Difference between the memory usage reported on the first and second collections
	If the request started after the first collection, the value will be NULL

Formatted:		[tasks] [varchar](30) NULL
Non-Formatted:	[tasks] [smallint] NULL
	Number of worker tasks currently allocated, for active requests

Formatted/Non:	[status] [varchar](30) NOT NULL
	Activity status for the session (running, sleeping, etc)

Formatted/Non:	[wait_info] [nvarchar](4000) NULL
	Aggregates wait information, in the following format:
		(Ax: Bms/Cms/Dms)E
	A is the number of waiting tasks currently waiting on resource type E. B/C/D are wait
	times, in milliseconds. If only one thread is waiting, its wait time will be shown as B.
	If two tasks are waiting, each of their wait times will be shown (B/C). If three or more 
	tasks are waiting, the minimum, average, and maximum wait times will be shown (B/C/D).
	If wait type E is a page latch wait and the page is of a "special" type (e.g. PFS, GAM, SGAM), 
	the page type will be identified.
	If wait type E is CXPACKET, the nodeId from the query plan will be identified

Formatted/Non:	[locks] [xml] NULL
	(Requires @get_locks option)
	Aggregates lock information, in XML format.
	The lock XML includes the lock mode, locked object, and aggregates the number of requests. 
	Attempts are made to identify locked objects by name

Formatted/Non:	[tran_start_time] [datetime] NULL
	(Requires @get_transaction_info option)
	Date and time that the first transaction opened by a session caused a transaction log 
	write to occur.

Formatted/Non:	[tran_log_writes] [nvarchar](4000) NULL
	(Requires @get_transaction_info option)
	Aggregates transaction log write information, in the following format:
	A:wB (C kB)
	A is a database that has been touched by an active transaction
	B is the number of log writes that have been made in the database as a result of the transaction
	C is the number of log kilobytes consumed by the log records

Formatted:		[open_tran_count] [varchar](30) NULL
Non-Formatted:	[open_tran_count] [smallint] NULL
	Shows the number of open transactions the session has open

Formatted:		[sql_command] [xml] NULL
Non-Formatted:	[sql_command] [nvarchar](max) NULL
	(Requires @get_outer_command option)
	Shows the "outer" SQL command, i.e. the text of the batch or RPC sent to the server, 
	if available

Formatted:		[sql_text] [xml] NULL
Non-Formatted:	[sql_text] [nvarchar](max) NULL
	Shows the SQL text for active requests or the last statement executed
	for sleeping sessions, if available in either case.
	If @get_full_inner_text option is set, shows the full text of the batch.
	Otherwise, shows only the active statement within the batch.
	If the query text is locked, a special timeout message will be sent, in the following format:
		<timeout_exceeded />
	If an error occurs, an error message will be sent, in the following format:
		<error message="message" />

Formatted/Non:	[query_plan] [xml] NULL
	(Requires @get_plans option)
	Shows the query plan for the request, if available.
	If the plan is locked, a special timeout message will be sent, in the following format:
		<timeout_exceeded />
	If an error occurs, an error message will be sent, in the following format:
		<error message="message" />

Formatted/Non:	[blocking_session_id] [smallint] NULL
	When applicable, shows the blocking SPID

Formatted:		[blocked_session_count] [varchar](30) NULL
Non-Formatted:	[blocked_session_count] [smallint] NULL
	(Requires @find_block_leaders option)
	The total number of SPIDs blocked by this session,
	all the way down the blocking chain.

Formatted:		[percent_complete] [varchar](30) NULL
Non-Formatted:	[percent_complete] [real] NULL
	When applicable, shows the percent complete (e.g. for backups, restores, and some rollbacks)

Formatted/Non:	[host_name] [sysname] NOT NULL
	Shows the host name for the connection

Formatted/Non:	[login_name] [sysname] NOT NULL
	Shows the login name for the connection

Formatted/Non:	[database_name] [sysname] NULL
	Shows the connected database

Formatted/Non:	[program_name] [sysname] NULL
	Shows the reported program/application name

Formatted/Non:	[additional_info] [xml] NULL
	(Requires @get_additional_info option)
	Returns additional non-performance-related session/request information
	If the script finds a SQL Agent job running, the name of the job and job step will be reported
	If @get_task_info = 2 and the script finds a lock wait, the locked object will be reported

Formatted/Non:	[start_time] [datetime] NOT NULL
	For active requests, shows the time the request started
	For sleeping sessions, shows the time the last batch completed

Formatted/Non:	[login_time] [datetime] NOT NULL
	Shows the time that the session connected

Formatted/Non:	[request_id] [int] NULL
	For active requests, shows the request_id
	Should be 0 unless MARS is being used

Formatted/Non:	[collection_time] [datetime] NOT NULL
	Time that this script's final SELECT ran
*/
AS
BEGIN;
	SET NOCOUNT ON; 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET QUOTED_IDENTIFIER ON;
	SET ANSI_PADDING ON;
	SET CONCAT_NULL_YIELDS_NULL ON;
	SET ANSI_WARNINGS ON;
	SET NUMERIC_ROUNDABORT OFF;
	SET ARITHABORT ON;

	IF
		@filter IS NULL
		OR @filter_type IS NULL
		OR @not_filter IS NULL
		OR @not_filter_type IS NULL
		OR @show_own_spid IS NULL
		OR @show_system_spids IS NULL
		OR @show_sleeping_spids IS NULL
		OR @get_full_inner_text IS NULL
		OR @get_plans IS NULL
		OR @get_outer_command IS NULL
		OR @get_transaction_info IS NULL
		OR @get_task_info IS NULL
		OR @get_locks IS NULL
		OR @get_avg_time IS NULL
		OR @get_additional_info IS NULL
		OR @find_block_leaders IS NULL
		OR @delta_interval IS NULL
		OR @format_output IS NULL
		OR @output_column_list IS NULL
		OR @sort_order IS NULL
		OR @return_schema IS NULL
		OR @destination_table IS NULL
		OR @help IS NULL
	BEGIN;
		RAISERROR('Input parameters cannot be NULL', 16, 1);
		RETURN;
	END;
	
	IF @filter_type NOT IN ('session', 'program', 'database', 'login', 'host')
	BEGIN;
		RAISERROR('Valid filter types are: session, program, database, login, host', 16, 1);
		RETURN;
	END;
	
	IF @filter_type = 'session' AND @filter LIKE '%[^0123456789]%'
	BEGIN;
		RAISERROR('Session filters must be valid integers', 16, 1);
		RETURN;
	END;
	
	IF @not_filter_type NOT IN ('session', 'program', 'database', 'login', 'host')
	BEGIN;
		RAISERROR('Valid filter types are: session, program, database, login, host', 16, 1);
		RETURN;
	END;
	
	IF @not_filter_type = 'session' AND @not_filter LIKE '%[^0123456789]%'
	BEGIN;
		RAISERROR('Session filters must be valid integers', 16, 1);
		RETURN;
	END;
	
	IF @show_sleeping_spids NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @show_sleeping_spids are: 0, 1, or 2', 16, 1);
		RETURN;
	END;
	
	IF @get_plans NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @get_plans are: 0, 1, or 2', 16, 1);
		RETURN;
	END;

	IF @get_task_info NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @get_task_info are: 0, 1, or 2', 16, 1);
		RETURN;
	END;

	IF @format_output NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @format_output are: 0, 1, or 2', 16, 1);
		RETURN;
	END;
	
	IF @help = 1
	BEGIN;
		DECLARE 
			@header VARCHAR(MAX),
			@params VARCHAR(MAX),
			@outputs VARCHAR(MAX);

		SELECT 
			@header =
				REPLACE
				(
					REPLACE
					(
						CONVERT
						(
							VARCHAR(MAX),
							SUBSTRING
							(
								t.text, 
								CHARINDEX('/' + REPLICATE('*', 93), t.text) + 94,
								CHARINDEX(REPLICATE('*', 93) + '/', t.text) - (CHARINDEX('/' + REPLICATE('*', 93), t.text) + 94)
							)
						),
						CHAR(13)+CHAR(10),
						CHAR(13)
					),
					'	',
					''
				),
			@params =
				CHAR(13) +
					REPLACE
					(
						REPLACE
						(
							CONVERT
							(
								VARCHAR(MAX),
								SUBSTRING
								(
									t.text, 
									CHARINDEX('--~', t.text) + 5, 
									CHARINDEX('--~', t.text, CHARINDEX('--~', t.text) + 5) - (CHARINDEX('--~', t.text) + 5)
								)
							),
							CHAR(13)+CHAR(10),
							CHAR(13)
						),
						'	',
						''
					),
				@outputs = 
					CHAR(13) +
						REPLACE
						(
							REPLACE
							(
								REPLACE
								(
									CONVERT
									(
										VARCHAR(MAX),
										SUBSTRING
										(
											t.text, 
											CHARINDEX('OUTPUT COLUMNS'+CHAR(13)+CHAR(10)+'--------------', t.text) + 32,
											CHARINDEX('*/', t.text, CHARINDEX('OUTPUT COLUMNS'+CHAR(13)+CHAR(10)+'--------------', t.text) + 32) - (CHARINDEX('OUTPUT COLUMNS'+CHAR(13)+CHAR(10)+'--------------', t.text) + 32)
										)
									),
									CHAR(9),
									CHAR(255)
								),
								CHAR(13)+CHAR(10),
								CHAR(13)
							),
							'	',
							''
						) +
						CHAR(13)
		FROM sys.dm_exec_requests AS r
		CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
		WHERE
			r.session_id = @@SPID;

		WITH
		a0 AS
		(SELECT 1 AS n UNION ALL SELECT 1),
		a1 AS
		(SELECT 1 AS n FROM a0 AS a, a0 AS b),
		a2 AS
		(SELECT 1 AS n FROM a1 AS a, a1 AS b),
		a3 AS
		(SELECT 1 AS n FROM a2 AS a, a2 AS b),
		a4 AS
		(SELECT 1 AS n FROM a3 AS a, a3 AS b),
		numbers AS
		(
			SELECT TOP(LEN(@header) - 1)
				ROW_NUMBER() OVER
				(
					ORDER BY (SELECT NULL)
				) AS number
			FROM a4
			ORDER BY
				number
		)
		SELECT
			RTRIM(LTRIM(
				SUBSTRING
				(
					@header,
					number + 1,
					CHARINDEX(CHAR(13), @header, number + 1) - number - 1
				)
			)) AS [------header---------------------------------------------------------------------------------------------------------------]
		FROM numbers
		WHERE
			SUBSTRING(@header, number, 1) = CHAR(13);

		WITH
		a0 AS
		(SELECT 1 AS n UNION ALL SELECT 1),
		a1 AS
		(SELECT 1 AS n FROM a0 AS a, a0 AS b),
		a2 AS
		(SELECT 1 AS n FROM a1 AS a, a1 AS b),
		a3 AS
		(SELECT 1 AS n FROM a2 AS a, a2 AS b),
		a4 AS
		(SELECT 1 AS n FROM a3 AS a, a3 AS b),
		numbers AS
		(
			SELECT TOP(LEN(@params) - 1)
				ROW_NUMBER() OVER
				(
					ORDER BY (SELECT NULL)
				) AS number
			FROM a4
			ORDER BY
				number
		),
		tokens AS
		(
			SELECT 
				RTRIM(LTRIM(
					SUBSTRING
					(
						@params,
						number + 1,
						CHARINDEX(CHAR(13), @params, number + 1) - number - 1
					)
				)) AS token,
				number,
				CASE
					WHEN SUBSTRING(@params, number + 1, 1) = CHAR(13) THEN number
					ELSE COALESCE(NULLIF(CHARINDEX(',' + CHAR(13) + CHAR(13), @params, number), 0), LEN(@params)) 
				END AS param_group,
				ROW_NUMBER() OVER
				(
					PARTITION BY
						CHARINDEX(',' + CHAR(13) + CHAR(13), @params, number),
						SUBSTRING(@params, number+1, 1)
					ORDER BY 
						number
				) AS group_order
			FROM numbers
			WHERE
				SUBSTRING(@params, number, 1) = CHAR(13)
		),
		parsed_tokens AS
		(
			SELECT
				MIN
				(
					CASE
						WHEN token LIKE '@%' THEN token
						ELSE NULL
					END
				) AS parameter,
				MIN
				(
					CASE
						WHEN token LIKE '--%' THEN RIGHT(token, LEN(token) - 2)
						ELSE NULL
					END
				) AS description,
				param_group,
				group_order
			FROM tokens
			WHERE
				NOT 
				(
					token = '' 
					AND group_order > 1
				)
			GROUP BY
				param_group,
				group_order
		)
		SELECT
			CASE
				WHEN description IS NULL AND parameter IS NULL THEN '-------------------------------------------------------------------------'
				WHEN param_group = MAX(param_group) OVER() THEN parameter
				ELSE COALESCE(LEFT(parameter, LEN(parameter) - 1), '')
			END AS [------parameter----------------------------------------------------------],
			CASE
				WHEN description IS NULL AND parameter IS NULL THEN '----------------------------------------------------------------------------------------------------------------------'
				ELSE COALESCE(description, '')
			END AS [------description-----------------------------------------------------------------------------------------------------]
		FROM parsed_tokens
		ORDER BY
			param_group, 
			group_order;
		
		WITH
		a0 AS
		(SELECT 1 AS n UNION ALL SELECT 1),
		a1 AS
		(SELECT 1 AS n FROM a0 AS a, a0 AS b),
		a2 AS
		(SELECT 1 AS n FROM a1 AS a, a1 AS b),
		a3 AS
		(SELECT 1 AS n FROM a2 AS a, a2 AS b),
		a4 AS
		(SELECT 1 AS n FROM a3 AS a, a3 AS b),
		numbers AS
		(
			SELECT TOP(LEN(@outputs) - 1)
				ROW_NUMBER() OVER
				(
					ORDER BY (SELECT NULL)
				) AS number
			FROM a4
			ORDER BY
				number
		),
		tokens AS
		(
			SELECT 
				RTRIM(LTRIM(
					SUBSTRING
					(
						@outputs,
						number + 1,
						CASE
							WHEN 
								COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs)) < 
								COALESCE(NULLIF(CHARINDEX(CHAR(13) + CHAR(255) COLLATE Latin1_General_Bin2, @outputs, number + 1), 0), LEN(@outputs))
								THEN COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs)) - number - 1
							ELSE
								COALESCE(NULLIF(CHARINDEX(CHAR(13) + CHAR(255) COLLATE Latin1_General_Bin2, @outputs, number + 1), 0), LEN(@outputs)) - number - 1
						END
					)
				)) AS token,
				number,
				COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs)) AS output_group,
				ROW_NUMBER() OVER
				(
					PARTITION BY 
						COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs))
					ORDER BY
						number
				) AS output_group_order
			FROM numbers
			WHERE
				SUBSTRING(@outputs, number, 10) = CHAR(13) + 'Formatted'
				OR SUBSTRING(@outputs, number, 2) = CHAR(13) + CHAR(255) COLLATE Latin1_General_Bin2
		),
		output_tokens AS
		(
			SELECT 
				*,
				CASE output_group_order
					WHEN 2 THEN MAX(CASE output_group_order WHEN 1 THEN token ELSE NULL END) OVER (PARTITION BY output_group)
					ELSE ''
				END COLLATE Latin1_General_Bin2 AS column_info
			FROM tokens
		)
		SELECT
			CASE output_group_order
				WHEN 1 THEN '-----------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN
							SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+1, CHARINDEX(']', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+2) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info))
						ELSE
							SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+2, CHARINDEX(']', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+2) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)-1)
					END
				ELSE ''
			END AS formatted_column_name,
			CASE output_group_order
				WHEN 1 THEN '-----------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN
							SUBSTRING(column_info, CHARINDEX(']', column_info)+2, LEN(column_info))
						ELSE
							SUBSTRING(column_info, CHARINDEX(']', column_info)+2, CHARINDEX('Non-Formatted:', column_info, CHARINDEX(']', column_info)+2) - CHARINDEX(']', column_info)-3)
					END
				ELSE ''
			END AS formatted_column_type,
			CASE output_group_order
				WHEN 1 THEN '---------------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN ''
						ELSE
							CASE
								WHEN SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, 1) = '<' THEN
									SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, CHARINDEX('>', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info)))
								ELSE
									SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, CHARINDEX(']', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info)))
							END
					END
				ELSE ''
			END AS unformatted_column_name,
			CASE output_group_order
				WHEN 1 THEN '---------------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN ''
						ELSE
							CASE
								WHEN SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, 1) = '<' THEN ''
								ELSE
									SUBSTRING(column_info, CHARINDEX(']', column_info, CHARINDEX('Non-Formatted:', column_info))+2, CHARINDEX('Non-Formatted:', column_info, CHARINDEX(']', column_info)+2) - CHARINDEX(']', column_info)-3)
							END
					END
				ELSE ''
			END AS unformatted_column_type,
			CASE output_group_order
				WHEN 1 THEN '----------------------------------------------------------------------------------------------------------------------'
				ELSE REPLACE(token, CHAR(255) COLLATE Latin1_General_Bin2, '')
			END AS [------description-----------------------------------------------------------------------------------------------------]
		FROM output_tokens
		WHERE
			NOT 
			(
				output_group_order = 1 
				AND output_group = LEN(@outputs)
			)
		ORDER BY
			output_group,
			CASE output_group_order
				WHEN 1 THEN 99
				ELSE output_group_order
			END;

		RETURN;
	END;

	WITH
	a0 AS
	(SELECT 1 AS n UNION ALL SELECT 1),
	a1 AS
	(SELECT 1 AS n FROM a0 AS a, a0 AS b),
	a2 AS
	(SELECT 1 AS n FROM a1 AS a, a1 AS b),
	a3 AS
	(SELECT 1 AS n FROM a2 AS a, a2 AS b),
	a4 AS
	(SELECT 1 AS n FROM a3 AS a, a3 AS b),
	numbers AS
	(
		SELECT TOP(LEN(@output_column_list))
			ROW_NUMBER() OVER
			(
				ORDER BY (SELECT NULL)
			) AS number
		FROM a4
		ORDER BY
			number
	),
	tokens AS
	(
		SELECT 
			'|[' +
				SUBSTRING
				(
					@output_column_list,
					number + 1,
					CHARINDEX(']', @output_column_list, number) - number - 1
				) + '|]' AS token,
			number
		FROM numbers
		WHERE
			SUBSTRING(@output_column_list, number, 1) = '['
	),
	ordered_columns AS
	(
		SELECT
			x.column_name,
			ROW_NUMBER() OVER
			(
				PARTITION BY
					x.column_name
				ORDER BY
					tokens.number,
					x.default_order
			) AS r,
			ROW_NUMBER() OVER
			(
				ORDER BY
					tokens.number,
					x.default_order
			) AS s
		FROM tokens
		JOIN
		(
			SELECT '[session_id]' AS column_name, 1 AS default_order
			UNION ALL
			SELECT '[dd hh:mm:ss.mss]', 2
			WHERE
				@format_output IN (1, 2)
			UNION ALL
			SELECT '[dd hh:mm:ss.mss (avg)]', 3
			WHERE
				@format_output IN (1, 2)
				AND @get_avg_time = 1
			UNION ALL
			SELECT '[avg_elapsed_time]', 4
			WHERE
				@format_output = 0
				AND @get_avg_time = 1
			UNION ALL
			SELECT '[physical_io]', 5
			WHERE
				@get_task_info = 2
			UNION ALL
			SELECT '[reads]', 6
			UNION ALL
			SELECT '[physical_reads]', 7
			UNION ALL
			SELECT '[writes]', 8
			UNION ALL
			SELECT '[tempdb_allocations]', 9
			UNION ALL
			SELECT '[tempdb_current]', 10
			UNION ALL
			SELECT '[CPU]', 11
			UNION ALL
			SELECT '[context_switches]', 12
			WHERE
				@get_task_info = 2
			UNION ALL
			SELECT '[used_memory]', 13
			UNION ALL
			SELECT '[physical_io_delta]', 14
			WHERE
				@delta_interval > 0	
				AND @get_task_info = 2
			UNION ALL
			SELECT '[reads_delta]', 15
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[physical_reads_delta]', 16
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[writes_delta]', 17
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[tempdb_allocations_delta]', 18
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[tempdb_current_delta]', 19
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[CPU_delta]', 20
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[context_switches_delta]', 21
			WHERE
				@delta_interval > 0
				AND @get_task_info = 2
			UNION ALL
			SELECT '[used_memory_delta]', 22
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[tasks]', 23
			WHERE
				@get_task_info = 2
			UNION ALL
			SELECT '[status]', 24
			UNION ALL
			SELECT '[wait_info]', 25
			WHERE
				@get_task_info > 0
				OR @find_block_leaders = 1
			UNION ALL
			SELECT '[locks]', 26
			WHERE
				@get_locks = 1
			UNION ALL
			SELECT '[tran_start_time]', 27
			WHERE
				@get_transaction_info = 1
			UNION ALL
			SELECT '[tran_log_writes]', 28
			WHERE
				@get_transaction_info = 1
			UNION ALL
			SELECT '[open_tran_count]', 29
			UNION ALL
			SELECT '[sql_command]', 30
			WHERE
				@get_outer_command = 1
			UNION ALL
			SELECT '[sql_text]', 31
			UNION ALL
			SELECT '[query_plan]', 32
			WHERE
				@get_plans >= 1
			UNION ALL
			SELECT '[blocking_session_id]', 33
			WHERE
				@get_task_info > 0
				OR @find_block_leaders = 1
			UNION ALL
			SELECT '[blocked_session_count]', 34
			WHERE
				@find_block_leaders = 1
			UNION ALL
			SELECT '[percent_complete]', 35
			UNION ALL
			SELECT '[host_name]', 36
			UNION ALL
			SELECT '[login_name]', 37
			UNION ALL
			SELECT '[database_name]', 38
			UNION ALL
			SELECT '[program_name]', 39
			UNION ALL
			SELECT '[additional_info]', 40
			WHERE
				@get_additional_info = 1
			UNION ALL
			SELECT '[start_time]', 41
			UNION ALL
			SELECT '[login_time]', 42
			UNION ALL
			SELECT '[request_id]', 43
			UNION ALL
			SELECT '[collection_time]', 44
		) AS x ON 
			x.column_name LIKE token ESCAPE '|'
	)
	SELECT
		@output_column_list =
			STUFF
			(
				(
					SELECT
						',' + column_name as [text()]
					FROM ordered_columns
					WHERE
						r = 1
					ORDER BY
						s
					FOR XML
						PATH('')
				),
				1,
				1,
				''
			);
	
	IF COALESCE(RTRIM(@output_column_list), '') = ''
	BEGIN;
		RAISERROR('No valid column matches found in @output_column_list or no columns remain due to selected options.', 16, 1);
		RETURN;
	END;
	
	IF @destination_table <> ''
	BEGIN;
		SET @destination_table = 
			--database
			COALESCE(QUOTENAME(PARSENAME(@destination_table, 3)) + '.', '') +
			--schema
			COALESCE(QUOTENAME(PARSENAME(@destination_table, 2)) + '.', '') +
			--table
			COALESCE(QUOTENAME(PARSENAME(@destination_table, 1)), '');
			
		IF COALESCE(RTRIM(@destination_table), '') = ''
		BEGIN;
			RAISERROR('Destination table not properly formatted.', 16, 1);
			RETURN;
		END;
	END;

	WITH
	a0 AS
	(SELECT 1 AS n UNION ALL SELECT 1),
	a1 AS
	(SELECT 1 AS n FROM a0 AS a, a0 AS b),
	a2 AS
	(SELECT 1 AS n FROM a1 AS a, a1 AS b),
	a3 AS
	(SELECT 1 AS n FROM a2 AS a, a2 AS b),
	a4 AS
	(SELECT 1 AS n FROM a3 AS a, a3 AS b),
	numbers AS
	(
		SELECT TOP(LEN(@sort_order))
			ROW_NUMBER() OVER
			(
				ORDER BY (SELECT NULL)
			) AS number
		FROM a4
		ORDER BY
			number
	),
	tokens AS
	(
		SELECT 
			'|[' +
				SUBSTRING
				(
					@sort_order,
					number + 1,
					CHARINDEX(']', @sort_order, number) - number - 1
				) + '|]' AS token,
			SUBSTRING
			(
				@sort_order,
				CHARINDEX(']', @sort_order, number) + 1,
				COALESCE(NULLIF(CHARINDEX('[', @sort_order, CHARINDEX(']', @sort_order, number)), 0), LEN(@sort_order)) - CHARINDEX(']', @sort_order, number)
			) AS next_chunk,
			number
		FROM numbers
		WHERE
			SUBSTRING(@sort_order, number, 1) = '['
	),
	ordered_columns AS
	(
		SELECT
			x.column_name +
				CASE
					WHEN tokens.next_chunk LIKE '%asc%' THEN ' ASC'
					WHEN tokens.next_chunk LIKE '%desc%' THEN ' DESC'
					ELSE ''
				END AS column_name,
			ROW_NUMBER() OVER
			(
				PARTITION BY
					x.column_name
				ORDER BY
					tokens.number
			) AS r,
			tokens.number
		FROM tokens
		JOIN
		(
			SELECT '[session_id]' AS column_name
			UNION ALL
			SELECT '[physical_io]'
			UNION ALL
			SELECT '[reads]'
			UNION ALL
			SELECT '[physical_reads]'
			UNION ALL
			SELECT '[writes]'
			UNION ALL
			SELECT '[tempdb_allocations]'
			UNION ALL
			SELECT '[tempdb_current]'
			UNION ALL
			SELECT '[CPU]'
			UNION ALL
			SELECT '[context_switches]'
			UNION ALL
			SELECT '[used_memory]'
			UNION ALL
			SELECT '[physical_io_delta]'
			UNION ALL
			SELECT '[reads_delta]'
			UNION ALL
			SELECT '[physical_reads_delta]'
			UNION ALL
			SELECT '[writes_delta]'
			UNION ALL
			SELECT '[tempdb_allocations_delta]'
			UNION ALL
			SELECT '[tempdb_current_delta]'
			UNION ALL
			SELECT '[CPU_delta]'
			UNION ALL
			SELECT '[context_switches_delta]'
			UNION ALL
			SELECT '[used_memory_delta]'
			UNION ALL
			SELECT '[tasks]'
			UNION ALL
			SELECT '[tran_start_time]'
			UNION ALL
			SELECT '[open_tran_count]'
			UNION ALL
			SELECT '[blocking_session_id]'
			UNION ALL
			SELECT '[blocked_session_count]'
			UNION ALL
			SELECT '[percent_complete]'
			UNION ALL
			SELECT '[host_name]'
			UNION ALL
			SELECT '[login_name]'
			UNION ALL
			SELECT '[database_name]'
			UNION ALL
			SELECT '[start_time]'
			UNION ALL
			SELECT '[login_time]'
			UNION ALL
			SELECT '[program_name]'
		) AS x ON 
			x.column_name LIKE token ESCAPE '|'
	)
	SELECT
		@sort_order = COALESCE(z.sort_order, '')
	FROM
	(
		SELECT
			STUFF
			(
				(
					SELECT
						',' + column_name as [text()]
					FROM ordered_columns
					WHERE
						r = 1
					ORDER BY
						number
					FOR XML
						PATH('')
				),
				1,
				1,
				''
			) AS sort_order
	) AS z;

	CREATE TABLE #sessions
	(
		recursion SMALLINT NOT NULL,
		session_id SMALLINT NOT NULL,
		request_id INT NOT NULL,
		session_number INT NOT NULL,
		elapsed_time INT NOT NULL,
		avg_elapsed_time INT NULL,
		physical_io BIGINT NULL,
		reads BIGINT NULL,
		physical_reads BIGINT NULL,
		writes BIGINT NULL,
		tempdb_allocations BIGINT NULL,
		tempdb_current BIGINT NULL,
		CPU INT NULL,
		thread_CPU_snapshot BIGINT NULL,
		context_switches BIGINT NULL,
		used_memory BIGINT NOT NULL, 
		tasks SMALLINT NULL,
		status VARCHAR(30) NOT NULL,
		wait_info NVARCHAR(4000) NULL,
		locks XML NULL,
		transaction_id BIGINT NULL,
		tran_start_time DATETIME NULL,
		tran_log_writes NVARCHAR(4000) NULL,
		open_tran_count SMALLINT NULL,
		sql_command XML NULL,
		sql_handle VARBINARY(64) NULL,
		statement_start_offset INT NULL,
		statement_end_offset INT NULL,
		sql_text XML NULL,
		plan_handle VARBINARY(64) NULL,
		query_plan XML NULL,
		blocking_session_id SMALLINT NULL,
		blocked_session_count SMALLINT NULL,
		percent_complete REAL NULL,
		host_name sysname NULL,
		login_name sysname NOT NULL,
		database_name sysname NULL,
		program_name sysname NULL,
		additional_info XML NULL,
		start_time DATETIME NOT NULL,
		login_time DATETIME NULL,
		last_request_start_time DATETIME NULL,
		PRIMARY KEY CLUSTERED (session_id, request_id, recursion) WITH (IGNORE_DUP_KEY = ON),
		UNIQUE NONCLUSTERED (transaction_id, session_id, request_id, recursion) WITH (IGNORE_DUP_KEY = ON)
	);

	IF @return_schema = 0
	BEGIN;
		--Disable unnecessary autostats on the table
		CREATE STATISTICS s_session_id ON #sessions (session_id)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_request_id ON #sessions (request_id)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_transaction_id ON #sessions (transaction_id)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_session_number ON #sessions (session_number)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_status ON #sessions (status)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_start_time ON #sessions (start_time)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_last_request_start_time ON #sessions (last_request_start_time)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_recursion ON #sessions (recursion)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;

		DECLARE @recursion SMALLINT;
		SET @recursion = 
			CASE @delta_interval
				WHEN 0 THEN 1
				ELSE -1
			END;

		DECLARE @first_collection_ms_ticks BIGINT;
		DECLARE @last_collection_start DATETIME;
		DECLARE @sys_info BIT;
		SET @sys_info = ISNULL(CONVERT(BIT, SIGN(OBJECT_ID('sys.dm_os_sys_info'))), 0);

		--Used for the delta pull
		REDO:;
		
		IF 
			@get_locks = 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[locks|]%' ESCAPE '|'
		BEGIN;
			SELECT
				y.resource_type,
				y.database_name,
				y.object_id,
				y.file_id,
				y.page_type,
				y.hobt_id,
				y.allocation_unit_id,
				y.index_id,
				y.schema_id,
				y.principal_id,
				y.request_mode,
				y.request_status,
				y.session_id,
				y.resource_description,
				y.request_count,
				s.request_id,
				s.start_time,
				CONVERT(sysname, NULL) AS object_name,
				CONVERT(sysname, NULL) AS index_name,
				CONVERT(sysname, NULL) AS schema_name,
				CONVERT(sysname, NULL) AS principal_name,
				CONVERT(NVARCHAR(2048), NULL) AS query_error
			INTO #locks
			FROM
			(
				SELECT
					sp.spid AS session_id,
					CASE sp.status
						WHEN 'sleeping' THEN CONVERT(INT, 0)
						ELSE sp.request_id
					END AS request_id,
					CASE sp.status
						WHEN 'sleeping' THEN sp.last_batch
						ELSE COALESCE(req.start_time, sp.last_batch)
					END AS start_time,
					sp.dbid
				FROM sys.sysprocesses AS sp
				OUTER APPLY
				(
					SELECT TOP(1)
						CASE
							WHEN 
							(
								sp.hostprocess > ''
								OR r.total_elapsed_time < 0
							) THEN
								r.start_time
							ELSE
								DATEADD
								(
									ms, 
									1000 * (DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())) / 500) - DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())), 
									DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())
								)
						END AS start_time
					FROM sys.dm_exec_requests AS r
					WHERE
						r.session_id = sp.spid
						AND r.request_id = sp.request_id
				) AS req
				WHERE
					--Process inclusive filter
					1 =
						CASE
							WHEN @filter <> '' THEN
								CASE @filter_type
									WHEN 'session' THEN
										CASE
											WHEN
												CONVERT(SMALLINT, @filter) = 0
												OR sp.spid = CONVERT(SMALLINT, @filter)
													THEN 1
											ELSE 0
										END
									WHEN 'program' THEN
										CASE
											WHEN sp.program_name LIKE @filter THEN 1
											ELSE 0
										END
									WHEN 'login' THEN
										CASE
											WHEN sp.loginame LIKE @filter THEN 1
											ELSE 0
										END
									WHEN 'host' THEN
										CASE
											WHEN sp.hostname LIKE @filter THEN 1
											ELSE 0
										END
									WHEN 'database' THEN
										CASE
											WHEN DB_NAME(sp.dbid) LIKE @filter THEN 1
											ELSE 0
										END
									ELSE 0
								END
							ELSE 1
						END
					--Process exclusive filter
					AND 0 =
						CASE
							WHEN @not_filter <> '' THEN
								CASE @not_filter_type
									WHEN 'session' THEN
										CASE
											WHEN sp.spid = CONVERT(SMALLINT, @not_filter) THEN 1
											ELSE 0
										END
									WHEN 'program' THEN
										CASE
											WHEN sp.program_name LIKE @not_filter THEN 1
											ELSE 0
										END
									WHEN 'login' THEN
										CASE
											WHEN sp.loginame LIKE @not_filter THEN 1
											ELSE 0
										END
									WHEN 'host' THEN
										CASE
											WHEN sp.hostname LIKE @not_filter THEN 1
											ELSE 0
										END
									WHEN 'database' THEN
										CASE
											WHEN DB_NAME(sp.dbid) LIKE @not_filter THEN 1
											ELSE 0
										END
									ELSE 0
								END
							ELSE 0
						END
					AND 
					(
						@show_own_spid = 1
						OR sp.spid <> @@SPID
					)
					AND 
					(
						@show_system_spids = 1
						OR sp.hostprocess > ''
					)
					AND sp.ecid = 0
			) AS s
			INNER HASH JOIN
			(
				SELECT
					x.resource_type,
					x.database_name,
					x.object_id,
					x.file_id,
					CASE
						WHEN x.page_no = 1 OR x.page_no % 8088 = 0 THEN 'PFS'
						WHEN x.page_no = 2 OR x.page_no % 511232 = 0 THEN 'GAM'
						WHEN x.page_no = 3 OR (x.page_no - 1) % 511232 = 0 THEN 'SGAM'
						WHEN x.page_no = 6 OR (x.page_no - 6) % 511232 = 0 THEN 'DCM'
						WHEN x.page_no = 7 OR (x.page_no - 7) % 511232 = 0 THEN 'BCM'
						WHEN x.page_no IS NOT NULL THEN '*'
						ELSE NULL
					END AS page_type,
					x.hobt_id,
					x.allocation_unit_id,
					x.index_id,
					x.schema_id,
					x.principal_id,
					x.request_mode,
					x.request_status,
					x.session_id,
					x.request_id,
					CASE
						WHEN COALESCE(x.object_id, x.file_id, x.hobt_id, x.allocation_unit_id, x.index_id, x.schema_id, x.principal_id) IS NULL THEN NULLIF(resource_description, '')
						ELSE NULL
					END AS resource_description,
					COUNT(*) AS request_count
				FROM
				(
					SELECT
						tl.resource_type +
							CASE
								WHEN tl.resource_subtype = '' THEN ''
								ELSE '.' + tl.resource_subtype
							END AS resource_type,
						COALESCE(DB_NAME(tl.resource_database_id), N'(null)') AS database_name,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_type = 'OBJECT' THEN tl.resource_associated_entity_id
								WHEN tl.resource_description LIKE '%object_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('object_id = ', tl.resource_description) + 12), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('object_id = ', tl.resource_description) + 12),
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('object_id = ', tl.resource_description) + 12)
										)
									)
								ELSE NULL
							END
						) AS object_id,
						CONVERT
						(
							INT,
							CASE 
								WHEN tl.resource_type = 'FILE' THEN CONVERT(INT, tl.resource_description)
								WHEN tl.resource_type IN ('PAGE', 'EXTENT', 'RID') THEN LEFT(tl.resource_description, CHARINDEX(':', tl.resource_description)-1)
								ELSE NULL
							END
						) AS file_id,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_type IN ('PAGE', 'EXTENT', 'RID') THEN 
									SUBSTRING
									(
										tl.resource_description, 
										CHARINDEX(':', tl.resource_description) + 1, 
										COALESCE
										(
											NULLIF
											(
												CHARINDEX(':', tl.resource_description, CHARINDEX(':', tl.resource_description) + 1), 
												0
											), 
											DATALENGTH(tl.resource_description)+1
										) - (CHARINDEX(':', tl.resource_description) + 1)
									)
								ELSE NULL
							END
						) AS page_no,
						CASE
							WHEN tl.resource_type IN ('PAGE', 'KEY', 'RID', 'HOBT') THEN tl.resource_associated_entity_id
							ELSE NULL
						END AS hobt_id,
						CASE
							WHEN tl.resource_type = 'ALLOCATION_UNIT' THEN tl.resource_associated_entity_id
							ELSE NULL
						END AS allocation_unit_id,
						CONVERT
						(
							INT,
							CASE
								WHEN
									/*TODO: Deal with server principals*/ 
									tl.resource_subtype <> 'SERVER_PRINCIPAL' 
									AND tl.resource_description LIKE '%index_id or stats_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('index_id or stats_id = ', tl.resource_description) + 23), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('index_id or stats_id = ', tl.resource_description) + 23), 
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('index_id or stats_id = ', tl.resource_description) + 23)
										)
									)
								ELSE NULL
							END 
						) AS index_id,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_description LIKE '%schema_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('schema_id = ', tl.resource_description) + 12), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('schema_id = ', tl.resource_description) + 12), 
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('schema_id = ', tl.resource_description) + 12)
										)
									)
								ELSE NULL
							END 
						) AS schema_id,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_description LIKE '%principal_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('principal_id = ', tl.resource_description) + 15), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('principal_id = ', tl.resource_description) + 15), 
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('principal_id = ', tl.resource_description) + 15)
										)
									)
								ELSE NULL
							END
						) AS principal_id,
						tl.request_mode,
						tl.request_status,
						tl.request_session_id AS session_id,
						tl.request_request_id AS request_id,

						/*TODO: Applocks, other resource_descriptions*/
						RTRIM(tl.resource_description) AS resource_description,
						tl.resource_associated_entity_id
						/*********************************************/
					FROM 
					(
						SELECT 
							request_session_id,
							CONVERT(VARCHAR(120), resource_type) COLLATE Latin1_General_Bin2 AS resource_type,
							CONVERT(VARCHAR(120), resource_subtype) COLLATE Latin1_General_Bin2 AS resource_subtype,
							resource_database_id,
							CONVERT(VARCHAR(512), resource_description) COLLATE Latin1_General_Bin2 AS resource_description,
							resource_associated_entity_id,
							CONVERT(VARCHAR(120), request_mode) COLLATE Latin1_General_Bin2 AS request_mode,
							CONVERT(VARCHAR(120), request_status) COLLATE Latin1_General_Bin2 AS request_status,
							request_request_id
						FROM sys.dm_tran_locks
					) AS tl
				) AS x
				GROUP BY
					x.resource_type,
					x.database_name,
					x.object_id,
					x.file_id,
					CASE
						WHEN x.page_no = 1 OR x.page_no % 8088 = 0 THEN 'PFS'
						WHEN x.page_no = 2 OR x.page_no % 511232 = 0 THEN 'GAM'
						WHEN x.page_no = 3 OR (x.page_no - 1) % 511232 = 0 THEN 'SGAM'
						WHEN x.page_no = 6 OR (x.page_no - 6) % 511232 = 0 THEN 'DCM'
						WHEN x.page_no = 7 OR (x.page_no - 7) % 511232 = 0 THEN 'BCM'
						WHEN x.page_no IS NOT NULL THEN '*'
						ELSE NULL
					END,
					x.hobt_id,
					x.allocation_unit_id,
					x.index_id,
					x.schema_id,
					x.principal_id,
					x.request_mode,
					x.request_status,
					x.session_id,
					x.request_id,
					CASE
						WHEN COALESCE(x.object_id, x.file_id, x.hobt_id, x.allocation_unit_id, x.index_id, x.schema_id, x.principal_id) IS NULL THEN NULLIF(resource_description, '')
						ELSE NULL
					END
			) AS y ON
				y.session_id = s.session_id
				AND y.request_id = s.request_id
			OPTION (HASH GROUP);

			--Disable unnecessary autostats on the table
			CREATE STATISTICS s_database_name ON #locks (database_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_object_id ON #locks (object_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_hobt_id ON #locks (hobt_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_allocation_unit_id ON #locks (allocation_unit_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_index_id ON #locks (index_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_schema_id ON #locks (schema_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_principal_id ON #locks (principal_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_request_id ON #locks (request_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_start_time ON #locks (start_time)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_resource_type ON #locks (resource_type)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_object_name ON #locks (object_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_schema_name ON #locks (schema_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_page_type ON #locks (page_type)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_request_mode ON #locks (request_mode)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_request_status ON #locks (request_status)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_resource_description ON #locks (resource_description)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_index_name ON #locks (index_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_principal_name ON #locks (principal_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
		END;
		
		DECLARE 
			@sql VARCHAR(MAX), 
			@sql_n NVARCHAR(MAX);

		SET @sql = 
			CONVERT(VARCHAR(MAX), '') +
			'DECLARE @blocker BIT;
			SET @blocker = 0;
			DECLARE @i INT;
			SET @i = 2147483647;

			DECLARE @sessions TABLE
			(
				session_id SMALLINT NOT NULL,
				request_id INT NOT NULL,
				login_time DATETIME,
				last_request_end_time DATETIME,
				status VARCHAR(30),
				statement_start_offset INT,
				statement_end_offset INT,
				sql_handle BINARY(20),
				host_name NVARCHAR(128),
				login_name NVARCHAR(128),
				program_name NVARCHAR(128),
				database_id SMALLINT,
				memory_usage INT,
				open_tran_count SMALLINT, 
				' +
				CASE
					WHEN 
					(
						@get_task_info <> 0 
						OR @find_block_leaders = 1 
					) THEN
						'wait_type NVARCHAR(32),
						wait_resource NVARCHAR(256),
						wait_time BIGINT, 
						'
					ELSE 
						''
				END +
				'blocked SMALLINT,
				is_user_process BIT,
				cmd VARCHAR(32),
				PRIMARY KEY CLUSTERED (session_id, request_id) WITH (IGNORE_DUP_KEY = ON)
			);

			DECLARE @blockers TABLE
			(
				session_id INT NOT NULL PRIMARY KEY WITH (IGNORE_DUP_KEY = ON)
			);

			BLOCKERS:;

			INSERT @sessions
			(
				session_id,
				request_id,
				login_time,
				last_request_end_time,
				status,
				statement_start_offset,
				statement_end_offset,
				sql_handle,
				host_name,
				login_name,
				program_name,
				database_id,
				memory_usage,
				open_tran_count, 
				' +
				CASE
					WHEN 
					(
						@get_task_info <> 0
						OR @find_block_leaders = 1 
					) THEN
						'wait_type,
						wait_resource,
						wait_time, 
						'
					ELSE
						''
				END +
				'blocked,
				is_user_process,
				cmd 
			)
			SELECT TOP(@i)
				spy.session_id,
				spy.request_id,
				spy.login_time,
				spy.last_request_end_time,
				spy.status,
				spy.statement_start_offset,
				spy.statement_end_offset,
				spy.sql_handle,
				spy.host_name,
				spy.login_name,
				spy.program_name,
				spy.database_id,
				spy.memory_usage,
				spy.open_tran_count,
				' +
				CASE
					WHEN 
					(
						@get_task_info <> 0  
						OR @find_block_leaders = 1 
					) THEN
						'spy.wait_type,
						CASE
							WHEN
								spy.wait_type LIKE N''PAGE%LATCH_%''
								OR spy.wait_type = N''CXPACKET''
								OR spy.wait_type LIKE N''LATCH[_]%''
								OR spy.wait_type = N''OLEDB'' THEN
									spy.wait_resource
							ELSE
								NULL
						END AS wait_resource,
						spy.wait_time, 
						'
					ELSE
						''
				END +
				'spy.blocked,
				spy.is_user_process,
				spy.cmd
			FROM
			(
				SELECT TOP(@i)
					spx.*, 
					' +
					CASE
						WHEN 
						(
							@get_task_info <> 0 
							OR @find_block_leaders = 1 
						) THEN
							'ROW_NUMBER() OVER
							(
								PARTITION BY
									spx.session_id,
									spx.request_id
								ORDER BY
									CASE
										WHEN spx.wait_type LIKE N''LCK[_]%'' THEN 
											1
										ELSE
											99
									END,
									spx.wait_time DESC,
									spx.blocked DESC
							) AS r 
							'
						ELSE 
							'1 AS r 
							'
					END +
				'FROM
				(
					SELECT TOP(@i)
						sp0.session_id,
						sp0.request_id,
						sp0.login_time,
						sp0.last_request_end_time,
						LOWER(sp0.status) AS status,
						CASE
							WHEN sp0.cmd = ''CREATE INDEX'' THEN
								0
							ELSE
								sp0.stmt_start
						END AS statement_start_offset,
						CASE
							WHEN sp0.cmd = N''CREATE INDEX'' THEN
								-1
							ELSE
								COALESCE(NULLIF(sp0.stmt_end, 0), -1)
						END AS statement_end_offset,
						sp0.sql_handle,
						sp0.host_name,
						sp0.login_name,
						sp0.program_name,
						sp0.database_id,
						sp0.memory_usage,
						sp0.open_tran_count, 
						' +
						CASE
							WHEN 
							(
								@get_task_info <> 0 
								OR @find_block_leaders = 1 
							) THEN
								'CASE
									WHEN sp0.wait_time > 0 AND sp0.wait_type <> N''CXPACKET'' THEN
										sp0.wait_type
									ELSE
										NULL
								END AS wait_type,
								CASE
									WHEN sp0.wait_time > 0 AND sp0.wait_type <> N''CXPACKET'' THEN 
										sp0.wait_resource
									ELSE
										NULL
								END AS wait_resource,
								CASE
									WHEN sp0.wait_type <> N''CXPACKET'' THEN
										sp0.wait_time
									ELSE
										0
								END AS wait_time, 
								'
							ELSE
								''
						END +
						'sp0.blocked,
						sp0.is_user_process,
						sp0.cmd
					FROM
					(
						SELECT TOP(@i)
							sp1.session_id,
							sp1.request_id,
							sp1.login_time,
							sp1.last_request_end_time,
							sp1.status,
							sp1.cmd,
							sp1.stmt_start,
							sp1.stmt_end,
							MAX(NULLIF(sp1.sql_handle, 0x00)) OVER (PARTITION BY sp1.session_id, sp1.request_id) AS sql_handle,
							sp1.host_name,
							MAX(sp1.login_name) OVER (PARTITION BY sp1.session_id, sp1.request_id) AS login_name,
							sp1.program_name,
							sp1.database_id,
							MAX(sp1.memory_usage)  OVER (PARTITION BY sp1.session_id, sp1.request_id) AS memory_usage,
							MAX(sp1.open_tran_count)  OVER (PARTITION BY sp1.session_id, sp1.request_id) AS open_tran_count,
							sp1.wait_type,
							sp1.wait_resource,
							sp1.wait_time,
							sp1.blocked,
							sp1.hostprocess,
							sp1.is_user_process
						FROM
						(
							SELECT TOP(@i)
								sp2.spid AS session_id,
								CASE sp2.status
									WHEN ''sleeping'' THEN
										CONVERT(INT, 0)
									ELSE
										sp2.request_id
								END AS request_id,
								MAX(sp2.login_time) AS login_time,
								MAX(sp2.last_batch) AS last_request_end_time,
								MAX(CONVERT(VARCHAR(30), RTRIM(sp2.status)) COLLATE Latin1_General_Bin2) AS status,
								MAX(CONVERT(VARCHAR(32), RTRIM(sp2.cmd)) COLLATE Latin1_General_Bin2) AS cmd,
								MAX(sp2.stmt_start) AS stmt_start,
								MAX(sp2.stmt_end) AS stmt_end,
								MAX(sp2.sql_handle) AS sql_handle,
								MAX(CONVERT(sysname, RTRIM(sp2.hostname)) COLLATE SQL_Latin1_General_CP1_CI_AS) AS host_name,
								MAX(CONVERT(sysname, RTRIM(sp2.loginame)) COLLATE SQL_Latin1_General_CP1_CI_AS) AS login_name,
								MAX
								(
									CASE
										WHEN blk.queue_id IS NOT NULL THEN
											N''Service Broker
												database_id: '' + CONVERT(NVARCHAR, blk.database_id) +
												N'' queue_id: '' + CONVERT(NVARCHAR, blk.queue_id)
										ELSE
											CONVERT
											(
												sysname,
												RTRIM(sp2.program_name)
											)
									END COLLATE SQL_Latin1_General_CP1_CI_AS
								) AS program_name,
								MAX(sp2.dbid) AS database_id,
								MAX(sp2.memusage) AS memory_usage,
								MAX(sp2.open_tran) AS open_tran_count,
								RTRIM(sp2.lastwaittype) AS wait_type,
								RTRIM(sp2.waitresource) AS wait_resource,
								MAX(sp2.waittime) AS wait_time,
								COALESCE(NULLIF(sp2.blocked, sp2.spid), 0) AS blocked,
								MAX
								(
									CASE
										WHEN blk.session_id = sp2.spid THEN
											''blocker''
										ELSE
											RTRIM(sp2.hostprocess)
									END
								) AS hostprocess,
								CONVERT
								(
									BIT,
									MAX
									(
										CASE
											WHEN sp2.hostprocess > '''' THEN
												1
											ELSE
												0
										END
									)
								) AS is_user_process
							FROM
							(
								SELECT TOP(@i)
									session_id,
									CONVERT(INT, NULL) AS queue_id,
									CONVERT(INT, NULL) AS database_id
								FROM @blockers

								UNION ALL

								SELECT TOP(@i)
									CONVERT(SMALLINT, 0),
									CONVERT(INT, NULL) AS queue_id,
									CONVERT(INT, NULL) AS database_id
								WHERE
									@blocker = 0

								UNION ALL

								SELECT TOP(@i)
									CONVERT(SMALLINT, spid),
									queue_id,
									database_id
								FROM sys.dm_broker_activated_tasks
								WHERE
									@blocker = 0
							) AS blk
							INNER JOIN sys.sysprocesses AS sp2 ON
								sp2.spid = blk.session_id
								OR
								(
									blk.session_id = 0
									AND @blocker = 0
								)
							' +
							CASE 
								WHEN 
								(
									@get_task_info = 0 
									AND @find_block_leaders = 0
								) THEN
									'WHERE
										sp2.ecid = 0 
									' 
								ELSE
									''
							END +
							'GROUP BY
								sp2.spid,
								CASE sp2.status
									WHEN ''sleeping'' THEN
										CONVERT(INT, 0)
									ELSE
										sp2.request_id
								END,
								RTRIM(sp2.lastwaittype),
								RTRIM(sp2.waitresource),
								COALESCE(NULLIF(sp2.blocked, sp2.spid), 0)
						) AS sp1
					) AS sp0
					WHERE
						@blocker = 1
						OR
						(1=1 
						' +
							--inclusive filter
							CASE
								WHEN @filter <> '' THEN
									CASE @filter_type
										WHEN 'session' THEN
											CASE
												WHEN CONVERT(SMALLINT, @filter) <> 0 THEN
													'AND sp0.session_id = CONVERT(SMALLINT, @filter) 
													'
												ELSE
													''
											END
										WHEN 'program' THEN
											'AND sp0.program_name LIKE @filter 
											'
										WHEN 'login' THEN
											'AND sp0.login_name LIKE @filter 
											'
										WHEN 'host' THEN
											'AND sp0.host_name LIKE @filter 
											'
										WHEN 'database' THEN
											'AND DB_NAME(sp0.database_id) LIKE @filter 
											'
										ELSE
											''
									END
								ELSE
									''
							END +
							--exclusive filter
							CASE
								WHEN @not_filter <> '' THEN
									CASE @not_filter_type
										WHEN 'session' THEN
											CASE
												WHEN CONVERT(SMALLINT, @not_filter) <> 0 THEN
													'AND sp0.session_id <> CONVERT(SMALLINT, @not_filter) 
													'
												ELSE
													''
											END
										WHEN 'program' THEN
											'AND sp0.program_name NOT LIKE @not_filter 
											'
										WHEN 'login' THEN
											'AND sp0.login_name NOT LIKE @not_filter 
											'
										WHEN 'host' THEN
											'AND sp0.host_name NOT LIKE @not_filter 
											'
										WHEN 'database' THEN
											'AND DB_NAME(sp0.database_id) NOT LIKE @not_filter 
											'
										ELSE
											''
									END
								ELSE
									''
							END +
							CASE @show_own_spid
								WHEN 1 THEN
									''
								ELSE
									'AND sp0.session_id <> @@spid 
									'
							END +
							CASE 
								WHEN @show_system_spids = 0 THEN
									'AND sp0.hostprocess > '''' 
									' 
								ELSE
									''
							END +
							CASE @show_sleeping_spids
								WHEN 0 THEN
									'AND sp0.status <> ''sleeping'' 
									'
								WHEN 1 THEN
									'AND
									(
										sp0.status <> ''sleeping''
										OR sp0.open_tran_count > 0
									)
									'
								ELSE
									''
							END +
						')
				) AS spx
			) AS spy
			WHERE
				spy.r = 1; 
			' + 
			CASE @recursion
				WHEN 1 THEN 
					'IF @@ROWCOUNT > 0
					BEGIN;
						INSERT @blockers
						(
							session_id
						)
						SELECT TOP(@i)
							blocked
						FROM @sessions
						WHERE
							NULLIF(blocked, 0) IS NOT NULL

						EXCEPT

						SELECT TOP(@i)
							session_id
						FROM @sessions; 
						' +

						CASE
							WHEN
							(
								@get_task_info > 0
								OR @find_block_leaders = 1
							) THEN
								'IF @@ROWCOUNT > 0
								BEGIN;
									SET @blocker = 1;
									GOTO BLOCKERS;
								END; 
								'
							ELSE 
								''
						END +
					'END; 
					'
				ELSE 
					''
			END +
			'SELECT TOP(@i)
				@recursion AS recursion,
				x.session_id,
				x.request_id,
				DENSE_RANK() OVER
				(
					ORDER BY
						x.session_id
				) AS session_number,
				' +
				CASE
					WHEN @output_column_list LIKE '%|[dd hh:mm:ss.mss|]%' ESCAPE '|' THEN 
						'x.elapsed_time '
					ELSE 
						'0 '
				END + 
					'AS elapsed_time, 
					' +
				CASE
					WHEN
						(
							@output_column_list LIKE '%|[dd hh:mm:ss.mss (avg)|]%' ESCAPE '|' OR 
							@output_column_list LIKE '%|[avg_elapsed_time|]%' ESCAPE '|'
						)
						AND @recursion = 1
							THEN 
								'x.avg_elapsed_time / 1000 '
					ELSE 
						'NULL '
				END + 
					'AS avg_elapsed_time, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[physical_io|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[physical_io_delta|]%' ESCAPE '|'
							THEN 
								'x.physical_io '
					ELSE 
						'NULL '
				END + 
					'AS physical_io, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[reads|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[reads_delta|]%' ESCAPE '|'
							THEN 
								'x.reads '
					ELSE 
						'0 '
				END + 
					'AS reads, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[physical_reads|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[physical_reads_delta|]%' ESCAPE '|'
							THEN 
								'x.physical_reads '
					ELSE 
						'0 '
				END + 
					'AS physical_reads, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[writes|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[writes_delta|]%' ESCAPE '|'
							THEN 
								'x.writes '
					ELSE 
						'0 '
				END + 
					'AS writes, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[tempdb_allocations|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[tempdb_allocations_delta|]%' ESCAPE '|'
							THEN 
								'x.tempdb_allocations '
					ELSE 
						'0 '
				END + 
					'AS tempdb_allocations, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[tempdb_current|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[tempdb_current_delta|]%' ESCAPE '|'
							THEN 
								'x.tempdb_current '
					ELSE 
						'0 '
				END + 
					'AS tempdb_current, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[CPU|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
							THEN
								'x.CPU '
					ELSE
						'0 '
				END + 
					'AS CPU, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
						AND @get_task_info = 2
						AND @sys_info = 1
							THEN 
								'x.thread_CPU_snapshot '
					ELSE 
						'0 '
				END + 
					'AS thread_CPU_snapshot, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[context_switches|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[context_switches_delta|]%' ESCAPE '|'
							THEN 
								'x.context_switches '
					ELSE 
						'NULL '
				END + 
					'AS context_switches, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[used_memory|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[used_memory_delta|]%' ESCAPE '|'
							THEN 
								'x.used_memory '
					ELSE 
						'0 '
				END + 
					'AS used_memory, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[tasks|]%' ESCAPE '|'
						AND @recursion = 1
							THEN 
								'x.tasks '
					ELSE 
						'NULL '
				END + 
					'AS tasks, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[status|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[sql_command|]%' ESCAPE '|'
						)
						AND @recursion = 1
							THEN 
								'x.status '
					ELSE 
						''''' '
				END + 
					'AS status, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[wait_info|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								CASE @get_task_info
									WHEN 2 THEN
										'COALESCE(x.task_wait_info, x.sys_wait_info) '
									ELSE
										'x.sys_wait_info '
								END
					ELSE 
						'NULL '
				END + 
					'AS wait_info, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[tran_start_time|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[tran_log_writes|]%' ESCAPE '|' 
						)
						AND @recursion = 1
							THEN 
								'x.transaction_id '
					ELSE 
						'NULL '
				END + 
					'AS transaction_id, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[open_tran_count|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.open_tran_count '
					ELSE 
						'NULL '
				END + 
					'AS open_tran_count, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[sql_text|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.sql_handle '
					ELSE 
						'NULL '
				END + 
					'AS sql_handle, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[sql_text|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[query_plan|]%' ESCAPE '|' 
						)
						AND @recursion = 1
							THEN 
								'x.statement_start_offset '
					ELSE 
						'NULL '
				END + 
					'AS statement_start_offset, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[sql_text|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[query_plan|]%' ESCAPE '|' 
						)
						AND @recursion = 1
							THEN 
								'x.statement_end_offset '
					ELSE 
						'NULL '
				END + 
					'AS statement_end_offset, 
					' +
				'NULL AS sql_text, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[query_plan|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.plan_handle '
					ELSE 
						'NULL '
				END + 
					'AS plan_handle, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[blocking_session_id|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'NULLIF(x.blocking_session_id, 0) '
					ELSE 
						'NULL '
				END + 
					'AS blocking_session_id, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[percent_complete|]%' ESCAPE '|'
						AND @recursion = 1
							THEN 
								'x.percent_complete '
					ELSE 
						'NULL '
				END + 
					'AS percent_complete, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[host_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.host_name '
					ELSE 
						''''' '
				END + 
					'AS host_name, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[login_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.login_name '
					ELSE 
						''''' '
				END + 
					'AS login_name, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[database_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'DB_NAME(x.database_id) '
					ELSE 
						'NULL '
				END + 
					'AS database_name, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[program_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.program_name '
					ELSE 
						''''' '
				END + 
					'AS program_name, 
					' +
				CASE
					WHEN
						@output_column_list LIKE '%|[additional_info|]%' ESCAPE '|'
						AND @recursion = 1
							THEN
								'(
									SELECT TOP(@i)
										x.text_size,
										x.language,
										x.date_format,
										x.date_first,
										CASE x.quoted_identifier
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS quoted_identifier,
										CASE x.arithabort
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS arithabort,
										CASE x.ansi_null_dflt_on
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_null_dflt_on,
										CASE x.ansi_defaults
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_defaults,
										CASE x.ansi_warnings
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_warnings,
										CASE x.ansi_padding
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_padding,
										CASE ansi_nulls
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_nulls,
										CASE x.concat_null_yields_null
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS concat_null_yields_null,
										CASE x.transaction_isolation_level
											WHEN 0 THEN ''Unspecified''
											WHEN 1 THEN ''ReadUncomitted''
											WHEN 2 THEN ''ReadCommitted''
											WHEN 3 THEN ''Repeatable''
											WHEN 4 THEN ''Serializable''
											WHEN 5 THEN ''Snapshot''
										END AS transaction_isolation_level,
										x.lock_timeout,
										x.deadlock_priority,
										x.row_count,
										x.command_type, 
										' +
										CASE
											WHEN OBJECT_ID('master.dbo.fn_varbintohexstr') IS NOT NULL THEN
												'master.dbo.fn_varbintohexstr(x.sql_handle) AS sql_handle,
												master.dbo.fn_varbintohexstr(x.plan_handle) AS plan_handle,'
											ELSE
												'CONVERT(VARCHAR(256), x.sql_handle, 1) AS sql_handle,
												CONVERT(VARCHAR(256), x.plan_handle, 1) AS plan_handle,'
										END +
										'
										' +
										CASE
											WHEN @output_column_list LIKE '%|[program_name|]%' ESCAPE '|' THEN
												'(
													SELECT TOP(1)
														CONVERT(uniqueidentifier, CONVERT(XML, '''').value(''xs:hexBinary( substring(sql:column("agent_info.job_id_string"), 0) )'', ''binary(16)'')) AS job_id,
														agent_info.step_id,
														(
															SELECT TOP(1)
																NULL
															FOR XML
																PATH(''job_name''),
																TYPE
														),
														(
															SELECT TOP(1)
																NULL
															FOR XML
																PATH(''step_name''),
																TYPE
														)
													FROM
													(
														SELECT TOP(1)
															SUBSTRING(x.program_name, CHARINDEX(''0x'', x.program_name) + 2, 32) AS job_id_string,
															SUBSTRING(x.program_name, CHARINDEX('': Step '', x.program_name) + 7, CHARINDEX('')'', x.program_name, CHARINDEX('': Step '', x.program_name)) - (CHARINDEX('': Step '', x.program_name) + 7)) AS step_id
														WHERE
															x.program_name LIKE N''SQLAgent - TSQL JobStep (Job 0x%''
													) AS agent_info
													FOR XML
														PATH(''agent_job_info''),
														TYPE
												),
												'
											ELSE ''
										END +
										CASE
											WHEN @get_task_info = 2 THEN
												'CONVERT(XML, x.block_info) AS block_info, 
												'
											ELSE
												''
										END + '
										x.host_process_id,
										x.group_id
									FOR XML
										PATH(''additional_info''),
										TYPE
								) '
					ELSE
						'NULL '
				END + 
					'AS additional_info, 
				x.start_time, 
					' +
				CASE
					WHEN
						@output_column_list LIKE '%|[login_time|]%' ESCAPE '|'
						AND @recursion = 1
							THEN
								'x.login_time '
					ELSE 
						'NULL '
				END + 
					'AS login_time, 
				x.last_request_start_time
			FROM
			(
				SELECT TOP(@i)
					y.*,
					CASE
						WHEN DATEDIFF(hour, y.start_time, GETDATE()) > 576 THEN
							DATEDIFF(second, GETDATE(), y.start_time)
						ELSE DATEDIFF(ms, y.start_time, GETDATE())
					END AS elapsed_time,
					COALESCE(tempdb_info.tempdb_allocations, 0) AS tempdb_allocations,
					COALESCE
					(
						CASE
							WHEN tempdb_info.tempdb_current < 0 THEN 0
							ELSE tempdb_info.tempdb_current
						END,
						0
					) AS tempdb_current, 
					' +
					CASE
						WHEN 
							(
								@get_task_info <> 0
								OR @find_block_leaders = 1
							) THEN
								'N''('' + CONVERT(NVARCHAR, y.wait_duration_ms) + N''ms)'' +
									y.wait_type +
										CASE
											WHEN y.wait_type LIKE N''PAGE%LATCH_%'' THEN
												N'':'' +
												COALESCE(DB_NAME(CONVERT(INT, LEFT(y.resource_description, CHARINDEX(N'':'', y.resource_description) - 1))), N''(null)'') +
												N'':'' +
												SUBSTRING(y.resource_description, CHARINDEX(N'':'', y.resource_description) + 1, LEN(y.resource_description) - CHARINDEX(N'':'', REVERSE(y.resource_description)) - CHARINDEX(N'':'', y.resource_description)) +
												N''('' +
													CASE
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 1 OR
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) % 8088 = 0
																THEN 
																	N''PFS''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 2 OR
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) % 511232 = 0
																THEN 
																	N''GAM''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 3 OR
															(CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) - 1) % 511232 = 0
																THEN
																	N''SGAM''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 6 OR
															(CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) - 6) % 511232 = 0 
																THEN 
																	N''DCM''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 7 OR
															(CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) - 7) % 511232 = 0 
																THEN 
																	N''BCM''
														ELSE 
															N''*''
													END +
												N'')''
											WHEN y.wait_type = N''CXPACKET'' THEN
												N'':'' + SUBSTRING(y.resource_description, CHARINDEX(N''nodeId'', y.resource_description) + 7, 4)
											WHEN y.wait_type LIKE N''LATCH[_]%'' THEN
												N'' ['' + LEFT(y.resource_description, COALESCE(NULLIF(CHARINDEX(N'' '', y.resource_description), 0), LEN(y.resource_description) + 1) - 1) + N'']''
											WHEN
												y.wait_type = N''OLEDB''
												AND y.resource_description LIKE N''%(SPID=%)'' THEN
													N''['' + LEFT(y.resource_description, CHARINDEX(N''(SPID='', y.resource_description) - 2) +
														N'':'' + SUBSTRING(y.resource_description, CHARINDEX(N''(SPID='', y.resource_description) + 6, CHARINDEX(N'')'', y.resource_description, (CHARINDEX(N''(SPID='', y.resource_description) + 6)) - (CHARINDEX(N''(SPID='', y.resource_description) + 6)) + '']''
											ELSE
												N''''
										END COLLATE Latin1_General_Bin2 AS sys_wait_info, 
										'
							ELSE
								''
						END +
						CASE
							WHEN @get_task_info = 2 THEN
								'tasks.physical_io,
								tasks.context_switches,
								tasks.tasks,
								tasks.block_info,
								tasks.wait_info AS task_wait_info,
								tasks.thread_CPU_snapshot,
								'
							ELSE
								'' 
					END +
					CASE 
						WHEN NOT (@get_avg_time = 1 AND @recursion = 1) THEN
							'CONVERT(INT, NULL) '
						ELSE 
							'qs.total_elapsed_time / qs.execution_count '
					END + 
						'AS avg_elapsed_time 
				FROM
				(
					SELECT TOP(@i)
						sp.session_id,
						sp.request_id,
						COALESCE(r.logical_reads, s.logical_reads) AS reads,
						COALESCE(r.reads, s.reads) AS physical_reads,
						COALESCE(r.writes, s.writes) AS writes,
						COALESCE(r.CPU_time, s.CPU_time) AS CPU,
						sp.memory_usage + COALESCE(r.granted_query_memory, 0) AS used_memory,
						LOWER(sp.status) AS status,
						COALESCE(r.sql_handle, sp.sql_handle) AS sql_handle,
						COALESCE(r.statement_start_offset, sp.statement_start_offset) AS statement_start_offset,
						COALESCE(r.statement_end_offset, sp.statement_end_offset) AS statement_end_offset,
						' +
						CASE
							WHEN 
							(
								@get_task_info <> 0
								OR @find_block_leaders = 1 
							) THEN
								'sp.wait_type COLLATE Latin1_General_Bin2 AS wait_type,
								sp.wait_resource COLLATE Latin1_General_Bin2 AS resource_description,
								sp.wait_time AS wait_duration_ms, 
								'
							ELSE
								''
						END +
						'NULLIF(sp.blocked, 0) AS blocking_session_id,
						r.plan_handle,
						NULLIF(r.percent_complete, 0) AS percent_complete,
						sp.host_name,
						sp.login_name,
						sp.program_name,
						s.host_process_id,
						COALESCE(r.text_size, s.text_size) AS text_size,
						COALESCE(r.language, s.language) AS language,
						COALESCE(r.date_format, s.date_format) AS date_format,
						COALESCE(r.date_first, s.date_first) AS date_first,
						COALESCE(r.quoted_identifier, s.quoted_identifier) AS quoted_identifier,
						COALESCE(r.arithabort, s.arithabort) AS arithabort,
						COALESCE(r.ansi_null_dflt_on, s.ansi_null_dflt_on) AS ansi_null_dflt_on,
						COALESCE(r.ansi_defaults, s.ansi_defaults) AS ansi_defaults,
						COALESCE(r.ansi_warnings, s.ansi_warnings) AS ansi_warnings,
						COALESCE(r.ansi_padding, s.ansi_padding) AS ansi_padding,
						COALESCE(r.ansi_nulls, s.ansi_nulls) AS ansi_nulls,
						COALESCE(r.concat_null_yields_null, s.concat_null_yields_null) AS concat_null_yields_null,
						COALESCE(r.transaction_isolation_level, s.transaction_isolation_level) AS transaction_isolation_level,
						COALESCE(r.lock_timeout, s.lock_timeout) AS lock_timeout,
						COALESCE(r.deadlock_priority, s.deadlock_priority) AS deadlock_priority,
						COALESCE(r.row_count, s.row_count) AS row_count,
						COALESCE(r.command, sp.cmd) AS command_type,
						COALESCE
						(
							CASE
								WHEN
								(
									s.is_user_process = 0
									AND r.total_elapsed_time >= 0
								) THEN
									DATEADD
									(
										ms,
										1000 * (DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())) / 500) - DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())),
										DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())
									)
							END,
							NULLIF(COALESCE(r.start_time, sp.last_request_end_time), CONVERT(DATETIME, ''19000101'', 112)),
							sp.login_time
						) AS start_time,
						sp.login_time,
						CASE
							WHEN s.is_user_process = 1 THEN
								s.last_request_start_time
							ELSE
								COALESCE
								(
									DATEADD
									(
										ms,
										1000 * (DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())) / 500) - DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())),
										DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())
									),
									s.last_request_start_time
								)
						END AS last_request_start_time,
						r.transaction_id,
						sp.database_id,
						sp.open_tran_count,
						' +
							CASE
								WHEN EXISTS
								(
									SELECT
										*
									FROM sys.all_columns AS ac
									WHERE
										ac.object_id = OBJECT_ID('sys.dm_exec_sessions')
										AND ac.name = 'group_id'
								)
									THEN 's.group_id'
								ELSE 'CONVERT(INT, NULL) AS group_id'
							END + '
					FROM @sessions AS sp
					LEFT OUTER LOOP JOIN sys.dm_exec_sessions AS s ON
						s.session_id = sp.session_id
						AND s.login_time = sp.login_time
					LEFT OUTER LOOP JOIN sys.dm_exec_requests AS r ON
						sp.status <> ''sleeping''
						AND r.session_id = sp.session_id
						AND r.request_id = sp.request_id
						AND
						(
							(
								s.is_user_process = 0
								AND sp.is_user_process = 0
							)
							OR
							(
								r.start_time = s.last_request_start_time
								AND s.last_request_end_time <= sp.last_request_end_time
							)
						)
				) AS y
				' + 
				CASE 
					WHEN @get_task_info = 2 THEN
						CONVERT(VARCHAR(MAX), '') +
						'LEFT OUTER HASH JOIN
						(
							SELECT TOP(@i)
								task_nodes.task_node.value(''(session_id/text())[1]'', ''SMALLINT'') AS session_id,
								task_nodes.task_node.value(''(request_id/text())[1]'', ''INT'') AS request_id,
								task_nodes.task_node.value(''(physical_io/text())[1]'', ''BIGINT'') AS physical_io,
								task_nodes.task_node.value(''(context_switches/text())[1]'', ''BIGINT'') AS context_switches,
								task_nodes.task_node.value(''(tasks/text())[1]'', ''INT'') AS tasks,
								task_nodes.task_node.value(''(block_info/text())[1]'', ''NVARCHAR(4000)'') AS block_info,
								task_nodes.task_node.value(''(waits/text())[1]'', ''NVARCHAR(4000)'') AS wait_info,
								task_nodes.task_node.value(''(thread_CPU_snapshot/text())[1]'', ''BIGINT'') AS thread_CPU_snapshot
							FROM
							(
								SELECT TOP(@i)
									CONVERT
									(
										XML,
										REPLACE
										(
											CONVERT(NVARCHAR(MAX), tasks_raw.task_xml_raw) COLLATE Latin1_General_Bin2,
											N''</waits></tasks><tasks><waits>'',
											N'', ''
										)
									) AS task_xml
								FROM
								(
									SELECT TOP(@i)
										CASE waits.r
											WHEN 1 THEN
												waits.session_id
											ELSE
												NULL
										END AS [session_id],
										CASE waits.r
											WHEN 1 THEN
												waits.request_id
											ELSE
												NULL
										END AS [request_id],											
										CASE waits.r
											WHEN 1 THEN
												waits.physical_io
											ELSE
												NULL
										END AS [physical_io],
										CASE waits.r
											WHEN 1 THEN
												waits.context_switches
											ELSE
												NULL
										END AS [context_switches],
										CASE waits.r
											WHEN 1 THEN
												waits.thread_CPU_snapshot
											ELSE
												NULL
										END AS [thread_CPU_snapshot],
										CASE waits.r
											WHEN 1 THEN
												waits.tasks
											ELSE
												NULL
										END AS [tasks],
										CASE waits.r
											WHEN 1 THEN
												waits.block_info
											ELSE
												NULL
										END AS [block_info],
										REPLACE
										(
											REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
											REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
											REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
												CONVERT
												(
													NVARCHAR(MAX),
													N''('' +
														CONVERT(NVARCHAR, num_waits) + N''x: '' +
														CASE num_waits
															WHEN 1 THEN
																CONVERT(NVARCHAR, min_wait_time) + N''ms''
															WHEN 2 THEN
																CASE
																	WHEN min_wait_time <> max_wait_time THEN
																		CONVERT(NVARCHAR, min_wait_time) + N''/'' + CONVERT(NVARCHAR, max_wait_time) + N''ms''
																	ELSE
																		CONVERT(NVARCHAR, max_wait_time) + N''ms''
																END
															ELSE
																CASE
																	WHEN min_wait_time <> max_wait_time THEN
																		CONVERT(NVARCHAR, min_wait_time) + N''/'' + CONVERT(NVARCHAR, avg_wait_time) + N''/'' + CONVERT(NVARCHAR, max_wait_time) + N''ms''
																	ELSE 
																		CONVERT(NVARCHAR, max_wait_time) + N''ms''
																END
														END +
													N'')'' + wait_type COLLATE Latin1_General_Bin2
												),
												NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
												NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
												NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
											NCHAR(0),
											N''''
										) AS [waits]
									FROM
									(
										SELECT TOP(@i)
											w1.*,
											ROW_NUMBER() OVER
											(
												PARTITION BY
													w1.session_id,
													w1.request_id
												ORDER BY
													w1.block_info DESC,
													w1.num_waits DESC,
													w1.wait_type
											) AS r
										FROM
										(
											SELECT TOP(@i)
												task_info.session_id,
												task_info.request_id,
												task_info.physical_io,
												task_info.context_switches,
												task_info.thread_CPU_snapshot,
												task_info.num_tasks AS tasks,
												CASE
													WHEN task_info.runnable_time IS NOT NULL THEN
														''RUNNABLE''
													ELSE
														wt2.wait_type
												END AS wait_type,
												NULLIF(COUNT(COALESCE(task_info.runnable_time, wt2.waiting_task_address)), 0) AS num_waits,
												MIN(COALESCE(task_info.runnable_time, wt2.wait_duration_ms)) AS min_wait_time,
												AVG(COALESCE(task_info.runnable_time, wt2.wait_duration_ms)) AS avg_wait_time,
												MAX(COALESCE(task_info.runnable_time, wt2.wait_duration_ms)) AS max_wait_time,
												MAX(wt2.block_info) AS block_info
											FROM
											(
												SELECT TOP(@i)
													t.session_id,
													t.request_id,
													SUM(CONVERT(BIGINT, t.pending_io_count)) OVER (PARTITION BY t.session_id, t.request_id) AS physical_io,
													SUM(CONVERT(BIGINT, t.context_switches_count)) OVER (PARTITION BY t.session_id, t.request_id) AS context_switches, 
													' +
													CASE
														WHEN 
															@output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
															AND @sys_info = 1
															THEN
																'SUM(tr.usermode_time + tr.kernel_time) OVER (PARTITION BY t.session_id, t.request_id) '
														ELSE
															'CONVERT(BIGINT, NULL) '
													END + 
														' AS thread_CPU_snapshot, 
													COUNT(*) OVER (PARTITION BY t.session_id, t.request_id) AS num_tasks,
													t.task_address,
													t.task_state,
													CASE
														WHEN
															t.task_state = ''RUNNABLE''
															AND w.runnable_time > 0 THEN
																w.runnable_time
														ELSE
															NULL
													END AS runnable_time
												FROM sys.dm_os_tasks AS t
												CROSS APPLY
												(
													SELECT TOP(1)
														sp2.session_id
													FROM @sessions AS sp2
													WHERE
														sp2.session_id = t.session_id
														AND sp2.request_id = t.request_id
														AND sp2.status <> ''sleeping''
												) AS sp20
												LEFT OUTER HASH JOIN
												( 
												' +
													CASE
														WHEN @sys_info = 1 THEN
															'SELECT TOP(@i)
																(
																	SELECT TOP(@i)
																		ms_ticks
																	FROM sys.dm_os_sys_info
																) -
																	w0.wait_resumed_ms_ticks AS runnable_time,
																w0.worker_address,
																w0.thread_address,
																w0.task_bound_ms_ticks
															FROM sys.dm_os_workers AS w0
															WHERE
																w0.state = ''RUNNABLE''
																OR @first_collection_ms_ticks >= w0.task_bound_ms_ticks'
														ELSE
															'SELECT
																CONVERT(BIGINT, NULL) AS runnable_time,
																CONVERT(VARBINARY(8), NULL) AS worker_address,
																CONVERT(VARBINARY(8), NULL) AS thread_address,
																CONVERT(BIGINT, NULL) AS task_bound_ms_ticks
															WHERE
																1 = 0'
														END +
												'
												) AS w ON
													w.worker_address = t.worker_address 
												' +
												CASE
													WHEN
														@output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
														AND @sys_info = 1
														THEN
															'LEFT OUTER HASH JOIN sys.dm_os_threads AS tr ON
																tr.thread_address = w.thread_address
																AND @first_collection_ms_ticks >= w.task_bound_ms_ticks
															'
													ELSE
														''
												END +
											') AS task_info
											LEFT OUTER HASH JOIN
											(
												SELECT TOP(@i)
													wt1.wait_type,
													wt1.waiting_task_address,
													MAX(wt1.wait_duration_ms) AS wait_duration_ms,
													MAX(wt1.block_info) AS block_info
												FROM
												(
													SELECT DISTINCT TOP(@i)
														wt.wait_type +
															CASE
																WHEN wt.wait_type LIKE N''PAGE%LATCH_%'' THEN
																	'':'' +
																	COALESCE(DB_NAME(CONVERT(INT, LEFT(wt.resource_description, CHARINDEX(N'':'', wt.resource_description) - 1))), N''(null)'') +
																	N'':'' +
																	SUBSTRING(wt.resource_description, CHARINDEX(N'':'', wt.resource_description) + 1, LEN(wt.resource_description) - CHARINDEX(N'':'', REVERSE(wt.resource_description)) - CHARINDEX(N'':'', wt.resource_description)) +
																	N''('' +
																		CASE
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 1 OR
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) % 8088 = 0
																					THEN 
																						N''PFS''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 2 OR
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) % 511232 = 0 
																					THEN 
																						N''GAM''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 3 OR
																				(CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) - 1) % 511232 = 0 
																					THEN 
																						N''SGAM''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 6 OR
																				(CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) - 6) % 511232 = 0 
																					THEN 
																						N''DCM''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 7 OR
																				(CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) - 7) % 511232 = 0
																					THEN 
																						N''BCM''
																			ELSE
																				N''*''
																		END +
																	N'')''
																WHEN wt.wait_type = N''CXPACKET'' THEN
																	N'':'' + SUBSTRING(wt.resource_description, CHARINDEX(N''nodeId'', wt.resource_description) + 7, 4)
																WHEN wt.wait_type LIKE N''LATCH[_]%'' THEN
																	N'' ['' + LEFT(wt.resource_description, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description), 0), LEN(wt.resource_description) + 1) - 1) + N'']''
																ELSE 
																	N''''
															END COLLATE Latin1_General_Bin2 AS wait_type,
														CASE
															WHEN
															(
																wt.blocking_session_id IS NOT NULL
																AND wt.wait_type LIKE N''LCK[_]%''
															) THEN
																(
																	SELECT TOP(@i)
																		x.lock_type,
																		REPLACE
																		(
																			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
																			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
																			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
																				DB_NAME
																				(
																					CONVERT
																					(
																						INT,
																						SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''dbid='', wt.resource_description), 0) + 5, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''dbid='', wt.resource_description) + 5), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''dbid='', wt.resource_description) - 5)
																					)
																				),
																				NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
																				NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
																				NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
																			NCHAR(0),
																			N''''
																		) AS database_name,
																		CASE x.lock_type
																			WHEN N''objectlock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''objid='', wt.resource_description), 0) + 6, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''objid='', wt.resource_description) + 6), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''objid='', wt.resource_description) - 6)
																			ELSE
																				NULL
																		END AS object_id,
																		CASE x.lock_type
																			WHEN N''filelock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''fileid='', wt.resource_description), 0) + 7, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''fileid='', wt.resource_description) + 7), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''fileid='', wt.resource_description) - 7)
																			ELSE
																				NULL
																		END AS file_id,
																		CASE
																			WHEN x.lock_type in (N''pagelock'', N''extentlock'', N''ridlock'') THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''associatedObjectId='', wt.resource_description), 0) + 19, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''associatedObjectId='', wt.resource_description) + 19), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''associatedObjectId='', wt.resource_description) - 19)
																			WHEN x.lock_type in (N''keylock'', N''hobtlock'', N''allocunitlock'') THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''hobtid='', wt.resource_description), 0) + 7, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''hobtid='', wt.resource_description) + 7), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''hobtid='', wt.resource_description) - 7)
																			ELSE
																				NULL
																		END AS hobt_id,
																		CASE x.lock_type
																			WHEN N''applicationlock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''hash='', wt.resource_description), 0) + 5, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''hash='', wt.resource_description) + 5), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''hash='', wt.resource_description) - 5)
																			ELSE
																				NULL
																		END AS applock_hash,
																		CASE x.lock_type
																			WHEN N''metadatalock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''subresource='', wt.resource_description), 0) + 12, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''subresource='', wt.resource_description) + 12), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''subresource='', wt.resource_description) - 12)
																			ELSE
																				NULL
																		END AS metadata_resource,
																		CASE x.lock_type
																			WHEN N''metadatalock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''classid='', wt.resource_description), 0) + 8, COALESCE(NULLIF(CHARINDEX(N'' dbid='', wt.resource_description) - CHARINDEX(N''classid='', wt.resource_description), 0), LEN(wt.resource_description) + 1) - 8)
																			ELSE
																				NULL
																		END AS metadata_class_id
																	FROM
																	(
																		SELECT TOP(1)
																			LEFT(wt.resource_description, CHARINDEX(N'' '', wt.resource_description) - 1) COLLATE Latin1_General_Bin2 AS lock_type
																	) AS x
																	FOR XML
																		PATH('''')
																)
															ELSE NULL
														END AS block_info,
														wt.wait_duration_ms,
														wt.waiting_task_address
													FROM
													(
														SELECT TOP(@i)
															wt0.wait_type COLLATE Latin1_General_Bin2 AS wait_type,
															wt0.resource_description COLLATE Latin1_General_Bin2 AS resource_description,
															wt0.wait_duration_ms,
															wt0.waiting_task_address,
															CASE
																WHEN wt0.blocking_session_id = p.blocked THEN
																	wt0.blocking_session_id
																ELSE
																	NULL
															END AS blocking_session_id
														FROM sys.dm_os_waiting_tasks AS wt0
														CROSS APPLY
														(
															SELECT TOP(1)
																s0.blocked
															FROM @sessions AS s0
															WHERE
																s0.session_id = wt0.session_id
																AND COALESCE(s0.wait_type, N'''') <> N''OLEDB''
																AND wt0.wait_type <> N''OLEDB''
														) AS p
													) AS wt
												) AS wt1
												GROUP BY
													wt1.wait_type,
													wt1.waiting_task_address
											) AS wt2 ON
												wt2.waiting_task_address = task_info.task_address
												AND wt2.wait_duration_ms > 0
												AND task_info.runnable_time IS NULL
											GROUP BY
												task_info.session_id,
												task_info.request_id,
												task_info.physical_io,
												task_info.context_switches,
												task_info.thread_CPU_snapshot,
												task_info.num_tasks,
												CASE
													WHEN task_info.runnable_time IS NOT NULL THEN
														''RUNNABLE''
													ELSE
														wt2.wait_type
												END
										) AS w1
									) AS waits
									ORDER BY
										waits.session_id,
										waits.request_id,
										waits.r
									FOR XML
										PATH(N''tasks''),
										TYPE
								) AS tasks_raw (task_xml_raw)
							) AS tasks_final
							CROSS APPLY tasks_final.task_xml.nodes(N''/tasks'') AS task_nodes (task_node)
							WHERE
								task_nodes.task_node.exist(N''session_id'') = 1
						) AS tasks ON
							tasks.session_id = y.session_id
							AND tasks.request_id = y.request_id 
						'
					ELSE
						''
				END +
				'LEFT OUTER HASH JOIN
				(
					SELECT TOP(@i)
						t_info.session_id,
						COALESCE(t_info.request_id, -1) AS request_id,
						SUM(t_info.tempdb_allocations) AS tempdb_allocations,
						SUM(t_info.tempdb_current) AS tempdb_current
					FROM
					(
						SELECT TOP(@i)
							tsu.session_id,
							tsu.request_id,
							tsu.user_objects_alloc_page_count +
								tsu.internal_objects_alloc_page_count AS tempdb_allocations,
							tsu.user_objects_alloc_page_count +
								tsu.internal_objects_alloc_page_count -
								tsu.user_objects_dealloc_page_count -
								tsu.internal_objects_dealloc_page_count AS tempdb_current
						FROM sys.dm_db_task_space_usage AS tsu
						CROSS APPLY
						(
							SELECT TOP(1)
								s0.session_id
							FROM @sessions AS s0
							WHERE
								s0.session_id = tsu.session_id
						) AS p

						UNION ALL

						SELECT TOP(@i)
							ssu.session_id,
							NULL AS request_id,
							ssu.user_objects_alloc_page_count +
								ssu.internal_objects_alloc_page_count AS tempdb_allocations,
							ssu.user_objects_alloc_page_count +
								ssu.internal_objects_alloc_page_count -
								ssu.user_objects_dealloc_page_count -
								ssu.internal_objects_dealloc_page_count AS tempdb_current
						FROM sys.dm_db_session_space_usage AS ssu
						CROSS APPLY
						(
							SELECT TOP(1)
								s0.session_id
							FROM @sessions AS s0
							WHERE
								s0.session_id = ssu.session_id
						) AS p
					) AS t_info
					GROUP BY
						t_info.session_id,
						COALESCE(t_info.request_id, -1)
				) AS tempdb_info ON
					tempdb_info.session_id = y.session_id
					AND tempdb_info.request_id =
						CASE
							WHEN y.status = N''sleeping'' THEN
								-1
							ELSE
								y.request_id
						END
				' +
				CASE 
					WHEN 
						NOT 
						(
							@get_avg_time = 1 
							AND @recursion = 1
						) THEN 
							''
					ELSE
						'LEFT OUTER HASH JOIN
						(
							SELECT TOP(@i)
								*
							FROM sys.dm_exec_query_stats
						) AS qs ON
							qs.sql_handle = y.sql_handle
							AND qs.plan_handle = y.plan_handle
							AND qs.statement_start_offset = y.statement_start_offset
							AND qs.statement_end_offset = y.statement_end_offset
						'
				END + 
			') AS x
			OPTION (KEEPFIXED PLAN, OPTIMIZE FOR (@i = 1)); ';

		SET @sql_n = CONVERT(NVARCHAR(MAX), @sql);

		SET @last_collection_start = GETDATE();

		IF 
			@recursion = -1
			AND @sys_info = 1
		BEGIN;
			SELECT
				@first_collection_ms_ticks = ms_ticks
			FROM sys.dm_os_sys_info;
		END;

		INSERT #sessions
		(
			recursion,
			session_id,
			request_id,
			session_number,
			elapsed_time,
			avg_elapsed_time,
			physical_io,
			reads,
			physical_reads,
			writes,
			tempdb_allocations,
			tempdb_current,
			CPU,
			thread_CPU_snapshot,
			context_switches,
			used_memory,
			tasks,
			status,
			wait_info,
			transaction_id,
			open_tran_count,
			sql_handle,
			statement_start_offset,
			statement_end_offset,		
			sql_text,
			plan_handle,
			blocking_session_id,
			percent_complete,
			host_name,
			login_name,
			database_name,
			program_name,
			additional_info,
			start_time,
			login_time,
			last_request_start_time
		)
		EXEC sp_executesql 
			@sql_n,
			N'@recursion SMALLINT, @filter sysname, @not_filter sysname, @first_collection_ms_ticks BIGINT',
			@recursion, @filter, @not_filter, @first_collection_ms_ticks;

		--Collect transaction information?
		IF
			@recursion = 1
			AND
			(
				@output_column_list LIKE '%|[tran_start_time|]%' ESCAPE '|'
				OR @output_column_list LIKE '%|[tran_log_writes|]%' ESCAPE '|' 
			)
		BEGIN;	
			DECLARE @i INT;
			SET @i = 2147483647;

			UPDATE s
			SET
				tran_start_time =
					CONVERT
					(
						DATETIME,
						LEFT
						(
							x.trans_info,
							NULLIF(CHARINDEX(NCHAR(254) COLLATE Latin1_General_Bin2, x.trans_info) - 1, -1)
						),
						121
					),
				tran_log_writes =
					RIGHT
					(
						x.trans_info,
						LEN(x.trans_info) - CHARINDEX(NCHAR(254) COLLATE Latin1_General_Bin2, x.trans_info)
					)
			FROM
			(
				SELECT TOP(@i)
					trans_nodes.trans_node.value('(session_id/text())[1]', 'SMALLINT') AS session_id,
					COALESCE(trans_nodes.trans_node.value('(request_id/text())[1]', 'INT'), 0) AS request_id,
					trans_nodes.trans_node.value('(trans_info/text())[1]', 'NVARCHAR(4000)') AS trans_info				
				FROM
				(
					SELECT TOP(@i)
						CONVERT
						(
							XML,
							REPLACE
							(
								CONVERT(NVARCHAR(MAX), trans_raw.trans_xml_raw) COLLATE Latin1_General_Bin2, 
								N'</trans_info></trans><trans><trans_info>', N''
							)
						)
					FROM
					(
						SELECT TOP(@i)
							CASE u_trans.r
								WHEN 1 THEN u_trans.session_id
								ELSE NULL
							END AS [session_id],
							CASE u_trans.r
								WHEN 1 THEN u_trans.request_id
								ELSE NULL
							END AS [request_id],
							CONVERT
							(
								NVARCHAR(MAX),
								CASE
									WHEN u_trans.database_id IS NOT NULL THEN
										CASE u_trans.r
											WHEN 1 THEN COALESCE(CONVERT(NVARCHAR, u_trans.transaction_start_time, 121) + NCHAR(254), N'')
											ELSE N''
										END + 
											REPLACE
											(
												REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
												REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
												REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
													CONVERT(VARCHAR(128), COALESCE(DB_NAME(u_trans.database_id), N'(null)')),
													NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
													NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
													NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
												NCHAR(0),
												N'?'
											) +
											N': ' +
										CONVERT(NVARCHAR, u_trans.log_record_count) + N' (' + CONVERT(NVARCHAR, u_trans.log_kb_used) + N' kB)' +
										N','
									ELSE
										N'N/A,'
								END COLLATE Latin1_General_Bin2
							) AS [trans_info]
						FROM
						(
							SELECT TOP(@i)
								trans.*,
								ROW_NUMBER() OVER
								(
									PARTITION BY
										trans.session_id,
										trans.request_id
									ORDER BY
										trans.transaction_start_time DESC
								) AS r
							FROM
							(
								SELECT TOP(@i)
									session_tran_map.session_id,
									session_tran_map.request_id,
									s_tran.database_id,
									COALESCE(SUM(s_tran.database_transaction_log_record_count), 0) AS log_record_count,
									COALESCE(SUM(s_tran.database_transaction_log_bytes_used), 0) / 1024 AS log_kb_used,
									MIN(s_tran.database_transaction_begin_time) AS transaction_start_time
								FROM
								(
									SELECT TOP(@i)
										*
									FROM sys.dm_tran_active_transactions
									WHERE
										transaction_begin_time <= @last_collection_start
								) AS a_tran
								INNER HASH JOIN
								(
									SELECT TOP(@i)
										*
									FROM sys.dm_tran_database_transactions
									WHERE
										database_id < 32767
								) AS s_tran ON
									s_tran.transaction_id = a_tran.transaction_id
								LEFT OUTER HASH JOIN
								(
									SELECT TOP(@i)
										*
									FROM sys.dm_tran_session_transactions
								) AS tst ON
									s_tran.transaction_id = tst.transaction_id
								CROSS APPLY
								(
									SELECT TOP(1)
										s3.session_id,
										s3.request_id
									FROM
									(
										SELECT TOP(1)
											s1.session_id,
											s1.request_id
										FROM #sessions AS s1
										WHERE
											s1.transaction_id = s_tran.transaction_id
											AND s1.recursion = 1
											
										UNION ALL
									
										SELECT TOP(1)
											s2.session_id,
											s2.request_id
										FROM #sessions AS s2
										WHERE
											s2.session_id = tst.session_id
											AND s2.recursion = 1
									) AS s3
									ORDER BY
										s3.request_id
								) AS session_tran_map
								GROUP BY
									session_tran_map.session_id,
									session_tran_map.request_id,
									s_tran.database_id
							) AS trans
						) AS u_trans
						FOR XML
							PATH('trans'),
							TYPE
					) AS trans_raw (trans_xml_raw)
				) AS trans_final (trans_xml)
				CROSS APPLY trans_final.trans_xml.nodes('/trans') AS trans_nodes (trans_node)
			) AS x
			INNER HASH JOIN #sessions AS s ON
				s.session_id = x.session_id
				AND s.request_id = x.request_id
			OPTION (OPTIMIZE FOR (@i = 1));
		END;

		--Variables for text and plan collection
		DECLARE	
			@session_id SMALLINT,
			@request_id INT,
			@sql_handle VARBINARY(64),
			@plan_handle VARBINARY(64),
			@statement_start_offset INT,
			@statement_end_offset INT,
			@start_time DATETIME,
			@database_name sysname;

		IF 
			@recursion = 1
			AND @output_column_list LIKE '%|[sql_text|]%' ESCAPE '|'
		BEGIN;
			DECLARE sql_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT 
					session_id,
					request_id,
					sql_handle,
					statement_start_offset,
					statement_end_offset
				FROM #sessions
				WHERE
					recursion = 1
					AND sql_handle IS NOT NULL
			OPTION (KEEPFIXED PLAN);

			OPEN sql_cursor;

			FETCH NEXT FROM sql_cursor
			INTO 
				@session_id,
				@request_id,
				@sql_handle,
				@statement_start_offset,
				@statement_end_offset;

			--Wait up to 5 ms for the SQL text, then give up
			SET LOCK_TIMEOUT 5;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					UPDATE s
					SET
						s.sql_text =
						(
							SELECT
								REPLACE
								(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
										N'--' + NCHAR(13) + NCHAR(10) +
										CASE 
											WHEN @get_full_inner_text = 1 THEN est.text
											WHEN LEN(est.text) < (@statement_end_offset / 2) + 1 THEN est.text
											WHEN SUBSTRING(est.text, (@statement_start_offset/2), 2) LIKE N'[a-zA-Z0-9][a-zA-Z0-9]' THEN est.text
											ELSE
												CASE
													WHEN @statement_start_offset > 0 THEN
														SUBSTRING
														(
															est.text,
															((@statement_start_offset/2) + 1),
															(
																CASE
																	WHEN @statement_end_offset = -1 THEN 2147483647
																	ELSE ((@statement_end_offset - @statement_start_offset)/2) + 1
																END
															)
														)
													ELSE RTRIM(LTRIM(est.text))
												END
										END +
										NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2,
										NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
										NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
										NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
									NCHAR(0),
									N''
								) AS [processing-instruction(query)]
							FOR XML
								PATH(''),
								TYPE
						),
						s.statement_start_offset = 
							CASE 
								WHEN LEN(est.text) < (@statement_end_offset / 2) + 1 THEN 0
								WHEN SUBSTRING(CONVERT(VARCHAR(MAX), est.text), (@statement_start_offset/2), 2) LIKE '[a-zA-Z0-9][a-zA-Z0-9]' THEN 0
								ELSE @statement_start_offset
							END,
						s.statement_end_offset = 
							CASE 
								WHEN LEN(est.text) < (@statement_end_offset / 2) + 1 THEN -1
								WHEN SUBSTRING(CONVERT(VARCHAR(MAX), est.text), (@statement_start_offset/2), 2) LIKE '[a-zA-Z0-9][a-zA-Z0-9]' THEN -1
								ELSE @statement_end_offset
							END
					FROM 
						#sessions AS s,
						(
							SELECT TOP(1)
								text
							FROM
							(
								SELECT 
									text, 
									0 AS row_num
								FROM sys.dm_exec_sql_text(@sql_handle)
								
								UNION ALL
								
								SELECT 
									NULL,
									1 AS row_num
							) AS est0
							ORDER BY
								row_num
						) AS est
					WHERE 
						s.session_id = @session_id
						AND s.request_id = @request_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END TRY
				BEGIN CATCH;
					UPDATE s
					SET
						s.sql_text = 
							CASE ERROR_NUMBER() 
								WHEN 1222 THEN '<timeout_exceeded />'
								ELSE '<error message="' + ERROR_MESSAGE() + '" />'
							END
					FROM #sessions AS s
					WHERE 
						s.session_id = @session_id
						AND s.request_id = @request_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END CATCH;

				FETCH NEXT FROM sql_cursor
				INTO
					@session_id,
					@request_id,
					@sql_handle,
					@statement_start_offset,
					@statement_end_offset;
			END;

			--Return this to the default
			SET LOCK_TIMEOUT -1;

			CLOSE sql_cursor;
			DEALLOCATE sql_cursor;
		END;

		IF 
			@get_outer_command = 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[sql_command|]%' ESCAPE '|'
		BEGIN;
			DECLARE @buffer_results TABLE
			(
				EventType VARCHAR(30),
				Parameters INT,
				EventInfo NVARCHAR(4000),
				start_time DATETIME,
				session_number INT IDENTITY(1,1) NOT NULL PRIMARY KEY
			);

			DECLARE buffer_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT 
					session_id,
					MAX(start_time) AS start_time
				FROM #sessions
				WHERE
					recursion = 1
				GROUP BY
					session_id
				ORDER BY
					session_id
				OPTION (KEEPFIXED PLAN);

			OPEN buffer_cursor;

			FETCH NEXT FROM buffer_cursor
			INTO 
				@session_id,
				@start_time;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					--In SQL Server 2008, DBCC INPUTBUFFER will throw 
					--an exception if the session no longer exists
					INSERT @buffer_results
					(
						EventType,
						Parameters,
						EventInfo
					)
					EXEC sp_executesql
						N'DBCC INPUTBUFFER(@session_id) WITH NO_INFOMSGS;',
						N'@session_id SMALLINT',
						@session_id;

					UPDATE br
					SET
						br.start_time = @start_time
					FROM @buffer_results AS br
					WHERE
						br.session_number = 
						(
							SELECT MAX(br2.session_number)
							FROM @buffer_results br2
						);
				END TRY
				BEGIN CATCH
				END CATCH;

				FETCH NEXT FROM buffer_cursor
				INTO 
					@session_id,
					@start_time;
			END;

			UPDATE s
			SET
				sql_command = 
				(
					SELECT 
						REPLACE
						(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								CONVERT
								(
									NVARCHAR(MAX),
									N'--' + NCHAR(13) + NCHAR(10) + br.EventInfo + NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2
								),
								NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
								NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
								NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
							NCHAR(0),
							N''
						) AS [processing-instruction(query)]
					FROM @buffer_results AS br
					WHERE 
						br.session_number = s.session_number
						AND br.start_time = s.start_time
						AND 
						(
							(
								s.start_time = s.last_request_start_time
								AND EXISTS
								(
									SELECT *
									FROM sys.dm_exec_requests r2
									WHERE
										r2.session_id = s.session_id
										AND r2.request_id = s.request_id
										AND r2.start_time = s.start_time
								)
							)
							OR 
							(
								s.request_id = 0
								AND EXISTS
								(
									SELECT *
									FROM sys.dm_exec_sessions s2
									WHERE
										s2.session_id = s.session_id
										AND s2.last_request_start_time = s.last_request_start_time
								)
							)
						)
					FOR XML
						PATH(''),
						TYPE
				)
			FROM #sessions AS s
			WHERE
				recursion = 1
			OPTION (KEEPFIXED PLAN);

			CLOSE buffer_cursor;
			DEALLOCATE buffer_cursor;
		END;

		IF 
			@get_plans >= 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[query_plan|]%' ESCAPE '|'
		BEGIN;
			DECLARE @live_plan BIT;
			SET @live_plan = ISNULL(CONVERT(BIT, SIGN(OBJECT_ID('sys.dm_exec_query_statistics_xml'))), 0)

			DECLARE plan_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT
					session_id,
					request_id,
					plan_handle,
					statement_start_offset,
					statement_end_offset
				FROM #sessions
				WHERE
					recursion = 1
					AND plan_handle IS NOT NULL
			OPTION (KEEPFIXED PLAN);

			OPEN plan_cursor;

			FETCH NEXT FROM plan_cursor
			INTO 
				@session_id,
				@request_id,
				@plan_handle,
				@statement_start_offset,
				@statement_end_offset;

			--Wait up to 5 ms for a query plan, then give up
			SET LOCK_TIMEOUT 5;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				DECLARE @query_plan XML;
				IF @live_plan = 1
				BEGIN;
					BEGIN TRY;
						SELECT
							@query_plan = x.query_plan
						FROM sys.dm_exec_query_statistics_xml(@session_id) AS x;

						IF 
							@query_plan IS NOT NULL
							AND EXISTS
							(
								SELECT
									*
								FROM sys.dm_exec_requests AS r
								WHERE
									r.session_id = @session_id
									AND r.request_id = @request_id
									AND r.plan_handle = @plan_handle
									AND r.statement_start_offset = @statement_start_offset
									AND r.statement_end_offset = @statement_end_offset
							)
						BEGIN;
							UPDATE s
							SET
								s.query_plan = @query_plan
							FROM #sessions AS s
							WHERE 
								s.session_id = @session_id
								AND s.request_id = @request_id
								AND s.recursion = 1
							OPTION (KEEPFIXED PLAN);
						END;
					END TRY
					BEGIN CATCH;
						SET @query_plan = NULL;
					END CATCH;
				END;

				IF @query_plan IS NULL
				BEGIN;
					BEGIN TRY;
						UPDATE s
						SET
							s.query_plan =
							(
								SELECT
									CONVERT(xml, query_plan)
								FROM sys.dm_exec_text_query_plan
								(
									@plan_handle, 
									CASE @get_plans
										WHEN 1 THEN
											@statement_start_offset
										ELSE
											0
									END, 
									CASE @get_plans
										WHEN 1 THEN
											@statement_end_offset
										ELSE
											-1
									END
								)
							)
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
							AND s.request_id = @request_id
							AND s.recursion = 1
						OPTION (KEEPFIXED PLAN);
					END TRY
					BEGIN CATCH;
						IF ERROR_NUMBER() = 6335
						BEGIN;
							UPDATE s
							SET
								s.query_plan =
								(
									SELECT
										N'--' + NCHAR(13) + NCHAR(10) + 
										N'-- Could not render showplan due to XML data type limitations. ' + NCHAR(13) + NCHAR(10) + 
										N'-- To see the graphical plan save the XML below as a .SQLPLAN file and re-open in SSMS.' + NCHAR(13) + NCHAR(10) +
										N'--' + NCHAR(13) + NCHAR(10) +
											REPLACE(qp.query_plan, N'<RelOp', NCHAR(13)+NCHAR(10)+N'<RelOp') + 
											NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2 AS [processing-instruction(query_plan)]
									FROM sys.dm_exec_text_query_plan
									(
										@plan_handle, 
										CASE @get_plans
											WHEN 1 THEN
												@statement_start_offset
											ELSE
												0
										END, 
										CASE @get_plans
											WHEN 1 THEN
												@statement_end_offset
											ELSE
												-1
										END
									) AS qp
									FOR XML
										PATH(''),
										TYPE
								)
							FROM #sessions AS s
							WHERE 
								s.session_id = @session_id
								AND s.request_id = @request_id
								AND s.recursion = 1
							OPTION (KEEPFIXED PLAN);
						END;
						ELSE
						BEGIN;
							UPDATE s
							SET
								s.query_plan = 
									CASE ERROR_NUMBER() 
										WHEN 1222 THEN '<timeout_exceeded />'
										ELSE '<error message="' + ERROR_MESSAGE() + '" />'
									END
							FROM #sessions AS s
							WHERE 
								s.session_id = @session_id
								AND s.request_id = @request_id
								AND s.recursion = 1
							OPTION (KEEPFIXED PLAN);
						END;
					END CATCH;
				END;

				FETCH NEXT FROM plan_cursor
				INTO
					@session_id,
					@request_id,
					@plan_handle,
					@statement_start_offset,
					@statement_end_offset;
			END;

			--Return this to the default
			SET LOCK_TIMEOUT -1;

			CLOSE plan_cursor;
			DEALLOCATE plan_cursor;
		END;

		IF 
			@get_locks = 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[locks|]%' ESCAPE '|'
		BEGIN;
			DECLARE locks_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT DISTINCT
					database_name
				FROM #locks
				WHERE
					EXISTS
					(
						SELECT *
						FROM #sessions AS s
						WHERE
							s.session_id = #locks.session_id
							AND recursion = 1
					)
					AND database_name <> '(null)'
				OPTION (KEEPFIXED PLAN);

			OPEN locks_cursor;

			FETCH NEXT FROM locks_cursor
			INTO 
				@database_name;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					SET @sql_n = CONVERT(NVARCHAR(MAX), '') +
						'UPDATE l ' +
						'SET ' +
							'object_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'o.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'index_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'i.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'schema_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										's.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'principal_name = ' + 
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'dp.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								') ' +
						'FROM #locks AS l ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.allocation_units AS au ON ' +
							'au.allocation_unit_id = l.allocation_unit_id ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.partitions AS p ON ' +
							'p.hobt_id = ' +
								'COALESCE ' +
								'( ' +
									'l.hobt_id, ' +
									'CASE ' +
										'WHEN au.type IN (1, 3) THEN au.container_id ' +
										'ELSE NULL ' +
									'END ' +
								') ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.partitions AS p1 ON ' +
							'l.hobt_id IS NULL ' +
							'AND au.type = 2 ' +
							'AND p1.partition_id = au.container_id ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.objects AS o ON ' +
							'o.object_id = COALESCE(l.object_id, p.object_id, p1.object_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.indexes AS i ON ' +
							'i.object_id = COALESCE(l.object_id, p.object_id, p1.object_id) ' +
							'AND i.index_id = COALESCE(l.index_id, p.index_id, p1.index_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.schemas AS s ON ' +
							's.schema_id = COALESCE(l.schema_id, o.schema_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.database_principals AS dp ON ' +
							'dp.principal_id = l.principal_id ' +
						'WHERE ' +
							'l.database_name = @database_name ' +
						'OPTION (KEEPFIXED PLAN); ';
					
					EXEC sp_executesql
						@sql_n,
						N'@database_name sysname',
						@database_name;
				END TRY
				BEGIN CATCH;
					UPDATE #locks
					SET
						query_error = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									CONVERT
									(
										NVARCHAR(MAX), 
										ERROR_MESSAGE() COLLATE Latin1_General_Bin2
									),
									NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
									NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
									NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
								NCHAR(0),
								N''
							)
					WHERE 
						database_name = @database_name
					OPTION (KEEPFIXED PLAN);
				END CATCH;

				FETCH NEXT FROM locks_cursor
				INTO
					@database_name;
			END;

			CLOSE locks_cursor;
			DEALLOCATE locks_cursor;

			CREATE CLUSTERED INDEX IX_SRD ON #locks (session_id, request_id, database_name);

			UPDATE s
			SET 
				s.locks =
				(
					SELECT 
						REPLACE
						(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								CONVERT
								(
									NVARCHAR(MAX), 
									l1.database_name COLLATE Latin1_General_Bin2
								),
								NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
								NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
								NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
							NCHAR(0),
							N''
						) AS [Database/@name],
						MIN(l1.query_error) AS [Database/@query_error],
						(
							SELECT 
								l2.request_mode AS [Lock/@request_mode],
								l2.request_status AS [Lock/@request_status],
								COUNT(*) AS [Lock/@request_count]
							FROM #locks AS l2
							WHERE 
								l1.session_id = l2.session_id
								AND l1.request_id = l2.request_id
								AND l2.database_name = l1.database_name
								AND l2.resource_type = 'DATABASE'
							GROUP BY
								l2.request_mode,
								l2.request_status
							FOR XML
								PATH(''),
								TYPE
						) AS [Database/Locks],
						(
							SELECT
								COALESCE(l3.object_name, '(null)') AS [Object/@name],
								l3.schema_name AS [Object/@schema_name],
								(
									SELECT
										l4.resource_type AS [Lock/@resource_type],
										l4.page_type AS [Lock/@page_type],
										l4.index_name AS [Lock/@index_name],
										CASE 
											WHEN l4.object_name IS NULL THEN l4.schema_name
											ELSE NULL
										END AS [Lock/@schema_name],
										l4.principal_name AS [Lock/@principal_name],
										l4.resource_description AS [Lock/@resource_description],
										l4.request_mode AS [Lock/@request_mode],
										l4.request_status AS [Lock/@request_status],
										SUM(l4.request_count) AS [Lock/@request_count]
									FROM #locks AS l4
									WHERE 
										l4.session_id = l3.session_id
										AND l4.request_id = l3.request_id
										AND l3.database_name = l4.database_name
										AND COALESCE(l3.object_name, '(null)') = COALESCE(l4.object_name, '(null)')
										AND COALESCE(l3.schema_name, '') = COALESCE(l4.schema_name, '')
										AND l4.resource_type <> 'DATABASE'
									GROUP BY
										l4.resource_type,
										l4.page_type,
										l4.index_name,
										CASE 
											WHEN l4.object_name IS NULL THEN l4.schema_name
											ELSE NULL
										END,
										l4.principal_name,
										l4.resource_description,
										l4.request_mode,
										l4.request_status
									FOR XML
										PATH(''),
										TYPE
								) AS [Object/Locks]
							FROM #locks AS l3
							WHERE 
								l3.session_id = l1.session_id
								AND l3.request_id = l1.request_id
								AND l3.database_name = l1.database_name
								AND l3.resource_type <> 'DATABASE'
							GROUP BY 
								l3.session_id,
								l3.request_id,
								l3.database_name,
								COALESCE(l3.object_name, '(null)'),
								l3.schema_name
							FOR XML
								PATH(''),
								TYPE
						) AS [Database/Objects]
					FROM #locks AS l1
					WHERE
						l1.session_id = s.session_id
						AND l1.request_id = s.request_id
						AND l1.start_time IN (s.start_time, s.last_request_start_time)
						AND s.recursion = 1
					GROUP BY 
						l1.session_id,
						l1.request_id,
						l1.database_name
					FOR XML
						PATH(''),
						TYPE
				)
			FROM #sessions s
			OPTION (KEEPFIXED PLAN);
		END;

		IF 
			@find_block_leaders = 1
			AND @recursion = 1
			AND @output_column_list LIKE '%|[blocked_session_count|]%' ESCAPE '|'
		BEGIN;
			WITH
			blockers AS
			(
				SELECT
					session_id,
					session_id AS top_level_session_id,
					CONVERT(VARCHAR(8000), '.' + CONVERT(VARCHAR(8000), session_id) + '.') AS the_path
				FROM #sessions
				WHERE
					recursion = 1

				UNION ALL

				SELECT
					s.session_id,
					b.top_level_session_id,
					CONVERT(VARCHAR(8000), b.the_path + CONVERT(VARCHAR(8000), s.session_id) + '.') AS the_path
				FROM blockers AS b
				JOIN #sessions AS s ON
					s.blocking_session_id = b.session_id
					AND s.recursion = 1
					AND b.the_path NOT LIKE '%.' + CONVERT(VARCHAR(8000), s.session_id) + '.%' COLLATE Latin1_General_Bin2
			)
			UPDATE s
			SET
				s.blocked_session_count = x.blocked_session_count
			FROM #sessions AS s
			JOIN
			(
				SELECT
					b.top_level_session_id AS session_id,
					COUNT(*) - 1 AS blocked_session_count
				FROM blockers AS b
				GROUP BY
					b.top_level_session_id
			) x ON
				s.session_id = x.session_id
			WHERE
				s.recursion = 1;
		END;

		IF
			@get_task_info = 2
			AND @output_column_list LIKE '%|[additional_info|]%' ESCAPE '|'
			AND @recursion = 1
		BEGIN;
			CREATE TABLE #blocked_requests
			(
				session_id SMALLINT NOT NULL,
				request_id INT NOT NULL,
				database_name sysname NOT NULL,
				object_id INT,
				hobt_id BIGINT,
				schema_id INT,
				schema_name sysname NULL,
				object_name sysname NULL,
				query_error NVARCHAR(2048),
				PRIMARY KEY (database_name, session_id, request_id)
			);

			CREATE STATISTICS s_database_name ON #blocked_requests (database_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_schema_name ON #blocked_requests (schema_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_object_name ON #blocked_requests (object_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_query_error ON #blocked_requests (query_error)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
		
			INSERT #blocked_requests
			(
				session_id,
				request_id,
				database_name,
				object_id,
				hobt_id,
				schema_id
			)
			SELECT
				session_id,
				request_id,
				database_name,
				object_id,
				hobt_id,
				CONVERT(INT, SUBSTRING(schema_node, CHARINDEX(' = ', schema_node) + 3, LEN(schema_node))) AS schema_id
			FROM
			(
				SELECT
					session_id,
					request_id,
					agent_nodes.agent_node.value('(database_name/text())[1]', 'sysname') AS database_name,
					agent_nodes.agent_node.value('(object_id/text())[1]', 'int') AS object_id,
					agent_nodes.agent_node.value('(hobt_id/text())[1]', 'bigint') AS hobt_id,
					agent_nodes.agent_node.value('(metadata_resource/text()[.="SCHEMA"]/../../metadata_class_id/text())[1]', 'varchar(100)') AS schema_node
				FROM #sessions AS s
				CROSS APPLY s.additional_info.nodes('//block_info') AS agent_nodes (agent_node)
				WHERE
					s.recursion = 1
			) AS t
			WHERE
				t.database_name IS NOT NULL
				AND
				(
					t.object_id IS NOT NULL
					OR t.hobt_id IS NOT NULL
					OR t.schema_node IS NOT NULL
				);
			
			DECLARE blocks_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR
				SELECT DISTINCT
					database_name
				FROM #blocked_requests;
				
			OPEN blocks_cursor;
			
			FETCH NEXT FROM blocks_cursor
			INTO 
				@database_name;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					SET @sql_n = 
						CONVERT(NVARCHAR(MAX), '') +
						'UPDATE b ' +
						'SET ' +
							'b.schema_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										's.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'b.object_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'o.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								') ' +
						'FROM #blocked_requests AS b ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.partitions AS p ON ' +
							'p.hobt_id = b.hobt_id ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.objects AS o ON ' +
							'o.object_id = COALESCE(p.object_id, b.object_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.schemas AS s ON ' +
							's.schema_id = COALESCE(o.schema_id, b.schema_id) ' +
						'WHERE ' +
							'b.database_name = @database_name; ';
					
					EXEC sp_executesql
						@sql_n,
						N'@database_name sysname',
						@database_name;
				END TRY
				BEGIN CATCH;
					UPDATE #blocked_requests
					SET
						query_error = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									CONVERT
									(
										NVARCHAR(MAX), 
										ERROR_MESSAGE() COLLATE Latin1_General_Bin2
									),
									NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
									NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
									NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
								NCHAR(0),
								N''
							)
					WHERE
						database_name = @database_name;
				END CATCH;

				FETCH NEXT FROM blocks_cursor
				INTO
					@database_name;
			END;
			
			CLOSE blocks_cursor;
			DEALLOCATE blocks_cursor;
			
			UPDATE s
			SET
				additional_info.modify
				('
					insert <schema_name>{sql:column("b.schema_name")}</schema_name>
					as last
					into (/additional_info/block_info)[1]
				')
			FROM #sessions AS s
			INNER JOIN #blocked_requests AS b ON
				b.session_id = s.session_id
				AND b.request_id = s.request_id
				AND s.recursion = 1
			WHERE
				b.schema_name IS NOT NULL;

			UPDATE s
			SET
				additional_info.modify
				('
					insert <object_name>{sql:column("b.object_name")}</object_name>
					as last
					into (/additional_info/block_info)[1]
				')
			FROM #sessions AS s
			INNER JOIN #blocked_requests AS b ON
				b.session_id = s.session_id
				AND b.request_id = s.request_id
				AND s.recursion = 1
			WHERE
				b.object_name IS NOT NULL;

			UPDATE s
			SET
				additional_info.modify
				('
					insert <query_error>{sql:column("b.query_error")}</query_error>
					as last
					into (/additional_info/block_info)[1]
				')
			FROM #sessions AS s
			INNER JOIN #blocked_requests AS b ON
				b.session_id = s.session_id
				AND b.request_id = s.request_id
				AND s.recursion = 1
			WHERE
				b.query_error IS NOT NULL;
		END;

		IF
			@output_column_list LIKE '%|[program_name|]%' ESCAPE '|'
			AND @output_column_list LIKE '%|[additional_info|]%' ESCAPE '|'
			AND @recursion = 1
			AND DB_ID('msdb') IS NOT NULL
		BEGIN;
			SET @sql_n =
				N'BEGIN TRY;
					DECLARE @job_name sysname;
					SET @job_name = NULL;
					DECLARE @step_name sysname;
					SET @step_name = NULL;

					SELECT
						@job_name = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									j.name,
									NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
									NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
									NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
								NCHAR(0),
								N''?''
							),
						@step_name = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									s.step_name,
									NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
									NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
									NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
								NCHAR(0),
								N''?''
							)
					FROM msdb.dbo.sysjobs AS j
					INNER JOIN msdb.dbo.sysjobsteps AS s ON
						j.job_id = s.job_id
					WHERE
						j.job_id = @job_id
						AND s.step_id = @step_id;

					IF @job_name IS NOT NULL
					BEGIN;
						UPDATE s
						SET
							additional_info.modify
							(''
								insert text{sql:variable("@job_name")}
								into (/additional_info/agent_job_info/job_name)[1]
							'')
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
							AND s.recursion = 1
						OPTION (KEEPFIXED PLAN);
						
						UPDATE s
						SET
							additional_info.modify
							(''
								insert text{sql:variable("@step_name")}
								into (/additional_info/agent_job_info/step_name)[1]
							'')
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
							AND s.recursion = 1
						OPTION (KEEPFIXED PLAN);
					END;
				END TRY
				BEGIN CATCH;
					DECLARE @msdb_error_message NVARCHAR(256);
					SET @msdb_error_message = ERROR_MESSAGE();
				
					UPDATE s
					SET
						additional_info.modify
						(''
							insert <msdb_query_error>{sql:variable("@msdb_error_message")}</msdb_query_error>
							as last
							into (/additional_info/agent_job_info)[1]
						'')
					FROM #sessions AS s
					WHERE 
						s.session_id = @session_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END CATCH;'

			DECLARE @job_id UNIQUEIDENTIFIER;
			DECLARE @step_id INT;

			DECLARE agent_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT
					s.session_id,
					agent_nodes.agent_node.value('(job_id/text())[1]', 'uniqueidentifier') AS job_id,
					agent_nodes.agent_node.value('(step_id/text())[1]', 'int') AS step_id
				FROM #sessions AS s
				CROSS APPLY s.additional_info.nodes('//agent_job_info') AS agent_nodes (agent_node)
				WHERE
					s.recursion = 1
			OPTION (KEEPFIXED PLAN);
			
			OPEN agent_cursor;

			FETCH NEXT FROM agent_cursor
			INTO 
				@session_id,
				@job_id,
				@step_id;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				EXEC sp_executesql
					@sql_n,
					N'@job_id UNIQUEIDENTIFIER, @step_id INT, @session_id SMALLINT',
					@job_id, @step_id, @session_id

				FETCH NEXT FROM agent_cursor
				INTO 
					@session_id,
					@job_id,
					@step_id;
			END;

			CLOSE agent_cursor;
			DEALLOCATE agent_cursor;
		END; 
		
		IF 
			@delta_interval > 0 
			AND @recursion <> 1
		BEGIN;
			SET @recursion = 1;

			DECLARE @delay_time CHAR(12);
			SET @delay_time = CONVERT(VARCHAR, DATEADD(second, @delta_interval, 0), 114);
			WAITFOR DELAY @delay_time;

			GOTO REDO;
		END;
	END;

	SET @sql = 
		--Outer column list
		CONVERT
		(
			VARCHAR(MAX),
			CASE
				WHEN 
					@destination_table <> '' 
					AND @return_schema = 0 
						THEN 'INSERT ' + @destination_table + ' '
				ELSE ''
			END +
			'SELECT ' +
				@output_column_list + ' ' +
			CASE @return_schema
				WHEN 1 THEN 'INTO #session_schema '
				ELSE ''
			END
		--End outer column list
		) + 
		--Inner column list
		CONVERT
		(
			VARCHAR(MAX),
			'FROM ' +
			'( ' +
				'SELECT ' +
					'session_id, ' +
					--[dd hh:mm:ss.mss]
					CASE
						WHEN @format_output IN (1, 2) THEN
							'CASE ' +
								'WHEN elapsed_time < 0 THEN ' +
									'RIGHT ' +
									'( ' +
										'REPLICATE(''0'', max_elapsed_length) + CONVERT(VARCHAR, (-1 * elapsed_time) / 86400), ' +
										'max_elapsed_length ' +
									') + ' +
										'RIGHT ' +
										'( ' +
											'CONVERT(VARCHAR, DATEADD(second, (-1 * elapsed_time), 0), 120), ' +
											'9 ' +
										') + ' +
										'''.000'' ' +
								'ELSE ' +
									'RIGHT ' +
									'( ' +
										'REPLICATE(''0'', max_elapsed_length) + CONVERT(VARCHAR, elapsed_time / 86400000), ' +
										'max_elapsed_length ' +
									') + ' +
										'RIGHT ' +
										'( ' +
											'CONVERT(VARCHAR, DATEADD(second, elapsed_time / 1000, 0), 120), ' +
											'9 ' +
										') + ' +
										'''.'' + ' + 
										'RIGHT(''000'' + CONVERT(VARCHAR, elapsed_time % 1000), 3) ' +
							'END AS [dd hh:mm:ss.mss], '
						ELSE
							''
					END +
					--[dd hh:mm:ss.mss (avg)] / avg_elapsed_time
					CASE 
						WHEN  @format_output IN (1, 2) THEN 
							'RIGHT ' +
							'( ' +
								'''00'' + CONVERT(VARCHAR, avg_elapsed_time / 86400000), ' +
								'2 ' +
							') + ' +
								'RIGHT ' +
								'( ' +
									'CONVERT(VARCHAR, DATEADD(second, avg_elapsed_time / 1000, 0), 120), ' +
									'9 ' +
								') + ' +
								'''.'' + ' +
								'RIGHT(''000'' + CONVERT(VARCHAR, avg_elapsed_time % 1000), 3) AS [dd hh:mm:ss.mss (avg)], '
						ELSE
							'avg_elapsed_time, '
					END +
					--physical_io
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_io))) OVER() - LEN(CONVERT(VARCHAR, physical_io))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io), 1), 19)) AS '
						ELSE ''
					END + 'physical_io, ' +
					--reads
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, reads))) OVER() - LEN(CONVERT(VARCHAR, reads))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads), 1), 19)) AS '
						ELSE ''
					END + 'reads, ' +
					--physical_reads
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_reads))) OVER() - LEN(CONVERT(VARCHAR, physical_reads))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads), 1), 19)) AS '
						ELSE ''
					END + 'physical_reads, ' +
					--writes
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, writes))) OVER() - LEN(CONVERT(VARCHAR, writes))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes), 1), 19)) AS '
						ELSE ''
					END + 'writes, ' +
					--tempdb_allocations
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_allocations))) OVER() - LEN(CONVERT(VARCHAR, tempdb_allocations))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations), 1), 19)) AS '
						ELSE ''
					END + 'tempdb_allocations, ' +
					--tempdb_current
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_current))) OVER() - LEN(CONVERT(VARCHAR, tempdb_current))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current), 1), 19)) AS '
						ELSE ''
					END + 'tempdb_current, ' +
					--CPU
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, CPU))) OVER() - LEN(CONVERT(VARCHAR, CPU))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU), 1), 19)) AS '
						ELSE ''
					END + 'CPU, ' +
					--context_switches
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, context_switches))) OVER() - LEN(CONVERT(VARCHAR, context_switches))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches), 1), 19)) AS '
						ELSE ''
					END + 'context_switches, ' +
					--used_memory
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, used_memory))) OVER() - LEN(CONVERT(VARCHAR, used_memory))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory), 1), 19)) AS '
						ELSE ''
					END + 'used_memory, ' +
					CASE
						WHEN @output_column_list LIKE '%|_delta|]%' ESCAPE '|' THEN
							--physical_io_delta			
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND physical_io_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_io_delta))) OVER() - LEN(CONVERT(VARCHAR, physical_io_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io_delta), 1), 19)) ' 
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io_delta), 1), 19)) '
											ELSE 'physical_io_delta '
										END +
								'ELSE NULL ' +
							'END AS physical_io_delta, ' +
							--reads_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND reads_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, reads_delta))) OVER() - LEN(CONVERT(VARCHAR, reads_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads_delta), 1), 19)) '
											ELSE 'reads_delta '
										END +
								'ELSE NULL ' +
							'END AS reads_delta, ' +
							--physical_reads_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND physical_reads_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_reads_delta))) OVER() - LEN(CONVERT(VARCHAR, physical_reads_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads_delta), 1), 19)) '
											ELSE 'physical_reads_delta '
										END + 
								'ELSE NULL ' +
							'END AS physical_reads_delta, ' +
							--writes_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND writes_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, writes_delta))) OVER() - LEN(CONVERT(VARCHAR, writes_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes_delta), 1), 19)) '
											ELSE 'writes_delta '
										END + 
								'ELSE NULL ' +
							'END AS writes_delta, ' +
							--tempdb_allocations_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND tempdb_allocations_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_allocations_delta))) OVER() - LEN(CONVERT(VARCHAR, tempdb_allocations_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations_delta), 1), 19)) '
											ELSE 'tempdb_allocations_delta '
										END + 
								'ELSE NULL ' +
							'END AS tempdb_allocations_delta, ' +
							--tempdb_current_delta
							--this is the only one that can (legitimately) go negative 
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_current_delta))) OVER() - LEN(CONVERT(VARCHAR, tempdb_current_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current_delta), 1), 19)) '
											ELSE 'tempdb_current_delta '
										END + 
								'ELSE NULL ' +
							'END AS tempdb_current_delta, ' +
							--CPU_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
										'THEN ' +
											'CASE ' +
												'WHEN ' +
													'thread_CPU_delta > CPU_delta ' +
													'AND thread_CPU_delta > 0 ' +
														'THEN ' +
															CASE @format_output
																WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, thread_CPU_delta + CPU_delta))) OVER() - LEN(CONVERT(VARCHAR, thread_CPU_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, thread_CPU_delta), 1), 19)) '
																WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, thread_CPU_delta), 1), 19)) '
																ELSE 'thread_CPU_delta '
															END + 
												'WHEN CPU_delta >= 0 THEN ' +
													CASE @format_output
														WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, thread_CPU_delta + CPU_delta))) OVER() - LEN(CONVERT(VARCHAR, CPU_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU_delta), 1), 19)) '
														WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU_delta), 1), 19)) '
														ELSE 'CPU_delta '
													END + 
												'ELSE NULL ' +
											'END ' +
								'ELSE ' +
									'NULL ' +
							'END AS CPU_delta, ' +
							--context_switches_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND context_switches_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, context_switches_delta))) OVER() - LEN(CONVERT(VARCHAR, context_switches_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches_delta), 1), 19)) '
											ELSE 'context_switches_delta '
										END + 
								'ELSE NULL ' +
							'END AS context_switches_delta, ' +
							--used_memory_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND used_memory_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, used_memory_delta))) OVER() - LEN(CONVERT(VARCHAR, used_memory_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory_delta), 1), 19)) '
											ELSE 'used_memory_delta '
										END + 
								'ELSE NULL ' +
							'END AS used_memory_delta, '
						ELSE ''
					END +
					--tasks
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tasks))) OVER() - LEN(CONVERT(VARCHAR, tasks))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tasks), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tasks), 1), 19)) '
						ELSE ''
					END + 'tasks, ' +
					'status, ' +
					'wait_info, ' +
					'locks, ' +
					'tran_start_time, ' +
					'LEFT(tran_log_writes, LEN(tran_log_writes) - 1) AS tran_log_writes, ' +
					--open_tran_count
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, open_tran_count))) OVER() - LEN(CONVERT(VARCHAR, open_tran_count))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, open_tran_count), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, open_tran_count), 1), 19)) AS '
						ELSE ''
					END + 'open_tran_count, ' +
					--sql_command
					CASE @format_output 
						WHEN 0 THEN 'REPLACE(REPLACE(CONVERT(NVARCHAR(MAX), sql_command), ''<?query --''+CHAR(13)+CHAR(10), ''''), CHAR(13)+CHAR(10)+''--?>'', '''') AS '
						ELSE ''
					END + 'sql_command, ' +
					--sql_text
					CASE @format_output 
						WHEN 0 THEN 'REPLACE(REPLACE(CONVERT(NVARCHAR(MAX), sql_text), ''<?query --''+CHAR(13)+CHAR(10), ''''), CHAR(13)+CHAR(10)+''--?>'', '''') AS '
						ELSE ''
					END + 'sql_text, ' +
					'query_plan, ' +
					'blocking_session_id, ' +
					--blocked_session_count
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, blocked_session_count))) OVER() - LEN(CONVERT(VARCHAR, blocked_session_count))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, blocked_session_count), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, blocked_session_count), 1), 19)) AS '
						ELSE ''
					END + 'blocked_session_count, ' +
					--percent_complete
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, CONVERT(MONEY, percent_complete), 2))) OVER() - LEN(CONVERT(VARCHAR, CONVERT(MONEY, percent_complete), 2))) + CONVERT(CHAR(22), CONVERT(MONEY, percent_complete), 2)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, CONVERT(CHAR(22), CONVERT(MONEY, blocked_session_count), 1)) AS '
						ELSE ''
					END + 'percent_complete, ' +
					'host_name, ' +
					'login_name, ' +
					'database_name, ' +
					'program_name, ' +
					'additional_info, ' +
					'start_time, ' +
					'login_time, ' +
					'CASE ' +
						'WHEN status = N''sleeping'' THEN NULL ' +
						'ELSE request_id ' +
					'END AS request_id, ' +
					'GETDATE() AS collection_time '
		--End inner column list
		) +
		--Derived table and INSERT specification
		CONVERT
		(
			VARCHAR(MAX),
				'FROM ' +
				'( ' +
					'SELECT TOP(2147483647) ' +
						'*, ' +
						'CASE ' +
							'MAX ' +
							'( ' +
								'LEN ' +
								'( ' +
									'CONVERT ' +
									'( ' +
										'VARCHAR, ' +
										'CASE ' +
											'WHEN elapsed_time < 0 THEN ' +
												'(-1 * elapsed_time) / 86400 ' +
											'ELSE ' +
												'elapsed_time / 86400000 ' +
										'END ' +
									') ' +
								') ' +
							') OVER () ' +
								'WHEN 1 THEN 2 ' +
								'ELSE ' +
									'MAX ' +
									'( ' +
										'LEN ' +
										'( ' +
											'CONVERT ' +
											'( ' +
												'VARCHAR, ' +
												'CASE ' +
													'WHEN elapsed_time < 0 THEN ' +
														'(-1 * elapsed_time) / 86400 ' +
													'ELSE ' +
														'elapsed_time / 86400000 ' +
												'END ' +
											') ' +
										') ' +
									') OVER () ' +
						'END AS max_elapsed_length, ' +
						CASE
							WHEN @output_column_list LIKE '%|_delta|]%' ESCAPE '|' THEN
								'MAX(physical_io * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(physical_io * recursion) OVER (PARTITION BY session_id, request_id) AS physical_io_delta, ' +
								'MAX(reads * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(reads * recursion) OVER (PARTITION BY session_id, request_id) AS reads_delta, ' +
								'MAX(physical_reads * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(physical_reads * recursion) OVER (PARTITION BY session_id, request_id) AS physical_reads_delta, ' +
								'MAX(writes * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(writes * recursion) OVER (PARTITION BY session_id, request_id) AS writes_delta, ' +
								'MAX(tempdb_allocations * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(tempdb_allocations * recursion) OVER (PARTITION BY session_id, request_id) AS tempdb_allocations_delta, ' +
								'MAX(tempdb_current * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(tempdb_current * recursion) OVER (PARTITION BY session_id, request_id) AS tempdb_current_delta, ' +
								'MAX(CPU * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(CPU * recursion) OVER (PARTITION BY session_id, request_id) AS CPU_delta, ' +
								'MAX(thread_CPU_snapshot * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(thread_CPU_snapshot * recursion) OVER (PARTITION BY session_id, request_id) AS thread_CPU_delta, ' +
								'MAX(context_switches * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(context_switches * recursion) OVER (PARTITION BY session_id, request_id) AS context_switches_delta, ' +
								'MAX(used_memory * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(used_memory * recursion) OVER (PARTITION BY session_id, request_id) AS used_memory_delta, ' +
								'MIN(last_request_start_time) OVER (PARTITION BY session_id, request_id) AS first_request_start_time, '
							ELSE ''
						END +
						'COUNT(*) OVER (PARTITION BY session_id, request_id) AS num_events ' +
					'FROM #sessions AS s1 ' +
					CASE 
						WHEN @sort_order = '' THEN ''
						ELSE
							'ORDER BY ' +
								@sort_order
					END +
				') AS s ' +
				'WHERE ' +
					's.recursion = 1 ' +
			') x ' +
			'OPTION (KEEPFIXED PLAN); ' +
			'' +
			CASE @return_schema
				WHEN 1 THEN
					'SET @schema = ' +
						'''CREATE TABLE <table_name> ( '' + ' +
							'STUFF ' +
							'( ' +
								'( ' +
									'SELECT ' +
										''','' + ' +
										'QUOTENAME(COLUMN_NAME) + '' '' + ' +
										'DATA_TYPE + ' + 
										'CASE ' +
											'WHEN DATA_TYPE LIKE ''%char'' THEN ''('' + COALESCE(NULLIF(CONVERT(VARCHAR, CHARACTER_MAXIMUM_LENGTH), ''-1''), ''max'') + '') '' ' +
											'ELSE '' '' ' +
										'END + ' +
										'CASE IS_NULLABLE ' +
											'WHEN ''NO'' THEN ''NOT '' ' +
											'ELSE '''' ' +
										'END + ''NULL'' AS [text()] ' +
									'FROM tempdb.INFORMATION_SCHEMA.COLUMNS ' +
									'WHERE ' +
										'TABLE_NAME = (SELECT name FROM tempdb.sys.objects WHERE object_id = OBJECT_ID(''tempdb..#session_schema'')) ' +
										'ORDER BY ' +
											'ORDINAL_POSITION ' +
									'FOR XML ' +
										'PATH('''') ' +
								'), + ' +
								'1, ' +
								'1, ' +
								''''' ' +
							') + ' +
						''')''; ' 
				ELSE ''
			END
		--End derived table and INSERT specification
		);

	SET @sql_n = CONVERT(NVARCHAR(MAX), @sql);

	EXEC sp_executesql
		@sql_n,
		N'@schema VARCHAR(MAX) OUTPUT',
		@schema OUTPUT;
END;
GO
/****** Object:  StoredProcedure [dbo].[SS_PROC_KillDatabaseUsers]    Script Date: 10/19/2022 1:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SS_PROC_KillDatabaseUsers]
@dbname varchar(50) = null,
@hardkill bit = 0  --1 is an Executed Hard Kill

as
declare @errmsg varchar(255),
        @spid integer,
        @status sysname,
        @loginame sysname,
        @hostname sysname,
        @program_name sysname,
        @cmd sysname,
        @uid sysname,
        @nt_username sysname,
        @sid varchar,
        @login_time datetime,
		@msg varchar(255)

if @dbname is null
  begin
   select @errmsg = 'Database Name is null'
    raiserror (@errmsg, 11, 1) with nowait
  end

if @dbname not in (select name from master.dbo.sysdatabases)
  begin
    select @errmsg = 'Database Name ' + @dbname + ' is not found'
    raiserror (@errmsg, 11, 1) with nowait
  end

exec ('alter database [' + @dbname + '] set restricted_user with rollback immediate')


declare cursor_normal_spid_detector cursor for
  select 
  spid, 
  ltrim(status),  
  login_time, 
  loginame, 
  ltrim(hostname), 
  ltrim(program_name), 
  ltrim(cmd), 
  uid, 
  nt_username, 
  db_name(dbid) dbname
  from  
  master.dbo.sysprocesses
  where 
	spid <> @@spid                  -- not current process
	and db_name(dbid) = @dbname 
	and loginame <> 'sa' 			-- exclude sa
  for read only

  open cursor_normal_spid_detector
		
  fetch next from cursor_normal_spid_detector into @spid, @status, @login_time, @loginame, @hostname, @program_name, @cmd, @uid, @nt_username, @dbname
  if (@@fetch_status = 0)
     begin
       select @msg = 'The following users are logged into target database '+ ltrim(rtrim(@dbname))  
       print @msg

       while (@@fetch_status = 0) 
         begin
           select @msg=''
	       select @msg = @msg   + ' Spid=' + ltrim(rtrim(@spid))
	                            + ' LoginName=' + ltrim(rtrim(@loginame))
	                            + ' Status=' + ltrim(rtrim(@status))
		            			+ ' LoginTime=' + ltrim(rtrim(cast(@login_time as varchar(30))))
		 		    		    + ' Hostname=' + ltrim(rtrim(@hostname))
		 			    	    + ' ProgramName=' + ltrim(rtrim(@program_name))
	       print @msg 

		   if @hardkill = 1
		     begin
		       exec ('kill ' + @spid)
			   print ' Hard Kill on: ' + ltrim(rtrim(@spid))
			 end

	       fetch next from cursor_normal_spid_detector into @spid, @status, @login_time, @loginame, @hostname, @program_name, @cmd, @uid, @nt_username, @dbname
	     end

     end
close cursor_normal_spid_detector
deallocate cursor_normal_spid_detector


GO
/****** Object:  StoredProcedure [dbo].[SS_PROC_RestoreDB_WithOverride]    Script Date: 10/19/2022 1:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SS_PROC_RestoreDB_WithOverride]
     (
          @p_inputfiletype  sysname,
          @p_sourceinstance sysname,
          @p_sourcedbname sysname,
          @p_targetdbname sysname,
          @p_inputfile1  nvarchar(256),--sysname,
          @p_inputfile2 nvarchar(256),--sysname,
          @p_restoredate datetime = null,
          @p_DataDriveOverride char(2) = null,
	      @p_LogDriveOverride char(2) = null,
	      @p_debug bit = 0 
     )

----------------------------------------------------------------------------------------
--  MODIFICATION HISTORY
--  Initial Version
--	DATE/WHAT		WHO		VERSION
--  02/01/2012		Scott	1.0
--  03/22/2012		Steve	1.1
--  09/10/2014      Tb      2.0
--  Fix bug with setting of @i_skiplogs variable
-- 2.0 Allow for restore of mixed number of data and log files in the restore bak/dif files
----------------------------------------------------------------------------------------
AS

SET NOCOUNT on
SET FMTONLY OFF 

declare 
        @this_server			sysname,
        @procname			varchar(255),
        @procversion		varchar(4),
        @sqlfixsp				Varchar(32),
        @executestmt		nvarchar(4000),
        @executestmt2	varchar(4000),
        @executestmt3	varchar(4000),
        @sqlcmd				varchar(4000),
        @dircmd				varchar(4000),        
        @executeprefix		nvarchar(100),
        @princname			sysname,
        @dbcnt					integer,
        @schemacnt			integer,
        @scriptcnt				integer,
        @scriptpegdbname sysname,                              
        @fullscriptfile			varchar(2000),
        @devtrack			varchar(1),         
        @dummy				varchar,
        @dbmdbrgfoldernodename varchar(32),
        @pegasyssecmode varchar(32),
        @startime datetime,
        @login_time datetime,
        @spid integer,
        @dbname sysname,
        @status sysname,
        @loginame sysname,
        @msg sysname,
        @hostname sysname,
        @program_name sysname,
        @cmd sysname,
        @uid sysname,
        @nt_username sysname,
        @sid varchar,
        @i_skiplogs varchar

declare @source_server_name sysname,
          @cur_source_server_name sysname,
          @source_database_name  sysname,
          @cur_source_database_name sysname,
          @target_database_name  sysname,
          @cur_target_database_name sysname,         

        @reporting_timespan sysname,
        @deleteexisting sysname,

        @datestmt       varchar(4000),
        @output         sysname,
        @ErrorString varchar(255),
        @HdrString varchar(255),
        @sqlfixstr varchar(100),


        @princ_name varchar(75),

          @temp_database_name  varchar(50),
        @temp_server_name varchar(50),
        @temp_princ_name varchar(75),
        @temp_princ_id varchar(16),
        @temp_recno integer,
        @temp_perm_state varchar(30),
         @servercnt integer,        
  
        @role varchar(50),
        @roleconcat varchar(250),
        @rolecnt integer ,
        @frole VARchar(50),
        @froleconcat varchar(250),
        @frolecnt integer,
        @typrun varchar(5),
        @msgindent int,    
        @killStatements             varchar(4000)  
        


--- Set Proc name, etc
Select @this_server = @@Servername
Set @procname = 'dbo.SS_PROC_RestoreDB_WithOverride'
set @procversion = '2.0'
Set @sqlfixsp = ''
--set @pegasyssecmode ='STANDARD'

if ((@p_debug <> 0 and @p_debug <> 1) or @p_debug is null )
  begin
    select @p_debug = 1 --assume debug on for bad parm
  end
  
if (@p_debug = 1 )
  begin
    print 'DEBUGGER is ON'
  end

--- Check and set parms
IF ((Upper(@p_inputfiletype) <> 'FILE') and (Upper(@p_inputfiletype) <> 'LASTBKUP'))
     BEGIN
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE parm *****'
          GOTO CLEANUP
     END
Else
    set @p_inputfiletype = Upper(@p_inputfiletype)

IF ((@p_inputfile1 IS Null) or (@p_inputfile1 = ''))
     BEGIN
     If @p_inputfiletype = 'FILE'
		Begin
          print ' ***** ERROR OCCURRED - INPUFILETYPE=FILE specified but no Files provided in parms *****'
          GOTO CLEANUP
		End
     END
Else

-- Note that @inputfile2 cannot be validated since it is always optional

IF ((@p_sourceinstance IS Null) or (@p_sourceinstance = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no SOURCEINSTANCE parm provided *****'
          GOTO CLEANUP
		End
     END
Else

IF ((@p_sourcedbname IS Null) or (@p_sourcedbname = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no SOURCEDBNAME parm provided *****'
          GOTO CLEANUP
		End
     END
Else

IF ((@p_targetdbname IS Null) or (@p_targetdbname = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no TARGETDBNAME parm provided *****'
          GOTO CLEANUP
		End
     END



-- Parms are ok but lets make sure that target db exists in svr before we go any further
select @dbcnt = COUNT(*) from sys.sysdatabases where name = ''+@p_targetdbname+''
If @dbcnt <= 0
	Begin
		print ' ***** ERROR OCCURRED - Target database '+Upper(@p_targetdbname)+' cannot be found on the current server *****'
		GOTO CLEANUP
	end
	
-- Check for sessions in the database to be restored

DECLARE cursor_normal_spid_detector CURSOR
FOR
  select 
  spid, 
  LTRIM(status), 
  SUBSTRING(sid,1,16), 
  login_time, 
  loginame, 
  LTRIM(hostname), 
  LTRIM(program_name), 
  LTRIM(cmd), 
  uid, 
  nt_username, 
  db_name(dbid) dbname
  from  
  master.dbo.sysprocesses
  where 
	spid <> @@spid       -- not current process
	and db_name(dbid) = @p_targetdbname 
	and loginame <> 'sa' 			-- exclude sa
  FOR READ ONLY
-- Open Direct SPID Cursor
  open cursor_normal_spid_detector
  select @startime = getdate()				
-- Fetch next from Direct SPID cursor
  FETCH NEXT FROM cursor_normal_spid_detector INTO @spid, @status, @sid, @login_time, @loginame, @hostname, @program_name, @cmd, @uid, @nt_username, @dbname
  IF (@@fetch_status = 0)
     BEGIN
       Select @msg = 'The following users are logged into target database '+ LTrim(Rtrim(@dbname))  
       Print @msg
       select @killStatements = '/* Optional kill spid statements ' + char(13) + char(10) 
       WHILE (@@fetch_status = 0) 
         BEGIN
           Select @msg=' '
	       Select @msg = @msg   + 'SPID=' + LTrim(Rtrim(@spid))
	                            + ' Login Name=' + LTrim(Rtrim(@loginame))
	                            + ' Status=' + LTrim(Rtrim(@status))
		            			+ ' Login Time=' + Ltrim(RTrim(cast(@login_time as varchar(30))))
		 		    		    + ' Hostname=' + LTrim(Rtrim(@hostname))
		 			    	    + ' Program Name=' + LTrim(Rtrim(@program_name))
	       Print @msg 	
	       select @killStatements = @killStatements + ' kill ' + cast(@spid as varchar) 	+ char(13) + char(10)	
	       FETCH NEXT FROM cursor_normal_spid_detector INTO @spid, @status, @sid, @login_time, @loginame,  @hostname, @program_name, @cmd, @uid, @nt_username, @dbname  
	     END
       close cursor_normal_spid_detector
	   deallocate cursor_normal_spid_detector
	   select @killStatements = @killStatements + '*/ ' + char(13) + char(10)
	   print @killStatements
           Print 'Restore of database '+ LTrim(Rtrim(@dbname)) + ' is terminating.'
	   GOTO CLEANUP
     END
   ELSE 
     BEGIN
       close cursor_normal_spid_detector
	   deallocate cursor_normal_spid_detector
     END  
-- Log activity/errors
select @ErrorString =  'BEGINNING PROCEDURE ' +@procname+ ' (Version ' + CONVERT(varchar(3), @procversion) + ') at ' + CONVERT(varchar(30), GETDATE(), 109) + '.'
select @HdrString = replicate('*',datalength(@ErrorString))
print @HdrString
print @ErrorString

	
-- STEP #1 - Database Restore Step
-- STEP #1A - LASTBKUP Type
/*
Parameters

@source_instance	optional		The name of the instance that contains the source database. If excluded, the restore will read from the current instance.
@source_db	required			The name of the source database to restore from.
@dest_db	optional					The name of the destination database to restore to. If excluded, the restored database will use the same name as the source database. 
@skip_logs	optional				Set to 1 and no log files will be restored. Used if you only want to restore a full or differential backup. If excluded, the restore will use any available log backup files.
@restore_date	optional			The date and time to restore to. If excluded, the current date and time will be used.
@data_directory	optional		The directory in which all restored data files will be placed. If omitted, the procedure will determine the appropriate directory from the current destination database if it exists, or will use the instance default locations if not.
@log_directory	optional			The directory in which all restored log files will be placed. If omitted, the procedure will determine the appropriate directory from the current destination database if it exists, or will use the instance default locations if not.
@debug	optional					Set to 1 and the procedure will print the restore commands to the screen without executing them.
		

*/
--GOTO ADDSEC
--GOTO STRIPSEC

IF @p_inputfiletype = 'LASTBKUP'
   	Begin
   	  select @ErrorString =  'Starting Restore step at ' + CONVERT(varchar(30), GETDATE(), 109) + '.'
 	  Print @ErrorString 


	  declare  @SourceNameOUT sysname
      exec SSDBAUtils.dbo.pGetHAPrimary @p_sourceinstance, @SourceNameOUT output
      select @p_sourceinstance = @SourceNameOUT


	  if @p_restoredate is null
	    begin
	      Set @i_skiplogs = '1'
          Select @executestmt = 'exec dbutils.dbo.sp_restore_db @source_instance = ''' + @p_sourceinstance + ''', @source_db = ''' +@p_sourcedbname + ''', @dest_db = '''+ @p_targetdbname +''', @skip_logs='+@i_skiplogs+', @debug='+cast(@p_debug as CHAR(1))
	    end
	  else
	    begin
	      Set @i_skiplogs = '0'
	      Select @executestmt = 'exec dbutils.dbo.sp_restore_db @source_instance = ''' + @p_sourceinstance + ''', @source_db = ''' +@p_sourcedbname + ''', @dest_db = '''+ @p_targetdbname +''', @skip_logs='+@i_skiplogs+', @debug='+cast(@p_debug as CHAR(1))+', @restore_date='''+convert(nvarchar,@p_restoredate,121)+''''
	    end	    
 	   
	 -- Run the restore 
	 print @executestmt
	 execute (@executestmt)
	
		GOTO CLEANUP
	End
    	
-- STEP #1B - File Type
Else
	Begin
	    /*Tb Mixed restore files 09/10/2014*/
	    declare @p_inputfile1_supplied bit = 0,
                @p_inputfile2_supplied bit = 0,
                @count tinyint = 1,
                @moveclause varchar(4000) = '',
                @lname varchar(128),
                @pname varchar(260),
                @ppath varchar(260),
                @fname varchar(50),
                @recoveryclause varchar(10),
                @restorestmt varchar(4000),
                @xpcmd varchar (2000),
                @result int
                
        select @p_inputfile1_supplied = 1,  --make it to here, a file has been supplied
               @p_inputfile2_supplied = case when (@p_inputfile2 IS Null) or (@p_inputfile2 = '') then 0 else 1 end
 
        --get the files from the existing db to be replaced
        if ( @p_inputfile1_supplied = 1)
          begin
			  create table #BakDifTmp (
					LogicalName nvarchar(128), 
					PhysicalName nvarchar(260),
					[Type] char(1),
					FileGroupName nvarchar(128),
					Size numeric(20,0) ,
					MaxSize numeric(20,0),
					Fileid	tinyint,
					CreateLSN numeric(25,0),
					DropLSN numeric(25, 0),
					UniqueID uniqueidentifier,
					ReadOnlyLSN numeric(25,0),
					ReadWriteLSN numeric(25,0),
					BackupSizeInBytes bigint,
					SourceBlockSize int,
					FileGroupId int,
					LogGroupGUID uniqueidentifier,
					DifferentialBaseLSN numeric(25,0),
					DifferentialBaseGUID uniqueidentifier,
					IsReadOnly bit,
					IsPresent bit, 
					TDEThumbprint varbinary(32))


		  --added column on 2016 of SnapShotURL
		    declare @SQLversion nvarchar(20) 
            select @SQLversion = convert(nvarchar(25),SERVERPROPERTY('productversion'))
			if @SQLversion >= '13'
			  begin
			     alter table #BakDifTmp add SnapshotUrl nvarchar(360)
			  end

            
            --have to go and query the sys.master_files table to get the list of data and log files, #targetdbfiles(1)
            select database_id,file_id,type,data_space_id,name,physical_name, substring(physical_name, 1,2) as drive,
                   case type when 0 then 'row'
                             when 1 then 'log'
                             when 2 then 'fs' else 'unkn' end as filetype,
                   substring(left(physical_name,len(physical_name) - charindex('\',reverse(physical_name),1) + 1),3,len(physical_name) - 2) as fpath,
                   reverse(left(reverse(physical_name),charindex('\', reverse(physical_name), 1) - 1)) as fname,
                   db_name(database_id) as [db_name],
                   processed = 0
            into #targetdbfiles1 
            from sys.master_files where database_id = db_id(@p_targetdbname)


			
				
            --hold bak file elements
			select @executestmt3 = 'restore filelistonly from disk = ''' + @p_inputfile1 + ''''
			insert #BakDifTmp exec (@executestmt3)
                
            select logicalname as bak_logname, 
			       physicalname as bak_physname, 
			       t.[type] as bak_ftype, 
			       drive as db_drive,
			       cast(null as CHAR(2)) as DataDriveOverride,
			       cast(null as CHAR(2)) as LogDriveOverride, 
			       fpath as db_path, 
			       fname as db_file,
			       [db_name] as [db_name],
			       0 as processed
			into #restoreelements
			from #BakDifTmp t left outer join #targetdbfiles1 tgt on t.Fileid = tgt.[file_id] --on t.logicalname = tgt.name

                --Bak file restore
                update  #restoreelements set [db_name] = (select top 1 [db_name] from #restoreelements where [db_name] is not null)                                               

				--make some assumptions about placement of data files for .Bak extra file(s)
				update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'D'),
									 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'D'),
									 db_file = 'DtaBak_' + [db_name] + bak_logname + '.ndf'
								 where db_drive is null and bak_ftype = 'D' 
                                 
				--make some assumptions about placement of log files for .Bak file extra file(s)
				update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'L'),
									 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'L'),
									 db_file = 'LogBak_' + [db_name] + bak_logname + '.ldf'
								 where db_drive is null and bak_ftype = 'L' 
								 
				--override placement of the data files by drive letter				 
				if (@p_DataDriveOverride is not null)
				    update #restoreelements set DataDriveOverride = @p_DataDriveOverride where bak_ftype = 'D'
				if (@p_LogDriveOverride is not null)
				    update #restoreelements set LogDriveOverride = @p_LogDriveOverride where bak_ftype = 'L'
 				
 				select @recoveryclause = case when (@p_inputfile2_supplied = 0) then 'recovery' else 'norecovery' end
 				
				select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile1+''' with replace, stats=10, ' + @recoveryclause + ', '


                

				while (select count(*) from #restoreelements where processed = 0 ) > 0
					begin

						select top 1 @lname = bak_logname,
									 @pname = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path + db_file
						                           when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path + db_file
						                           else 'Undefined'
						                      end,
						             @ppath = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path
						                           when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path
						                           else 'Undefined'
						                      end    
    
						from #restoreelements where processed = 0 
						
						--create directory if not exists
						select @xpcmd = 'dir ' + @ppath
						exec @result = xp_cmdshell @xpcmd, no_output
						if @result <> 0
						  begin
						    print 'Creating Directory'
						  	select @xpcmd = 'mkdir ' + @ppath
						  	if @p_debug = 0
							  begin
						        exec @result = xp_cmdshell @xpcmd, no_output
								print @xpcmd
                              end
						    else
						      print @xpcmd
						  end 

					   select @moveclause = 'move ''' + @lname + ''' to ''' + @pname + ''',' from #restoreelements
					   select @executestmt3 = @executestmt3 + @moveclause

					   update #restoreelements set processed = 1 where bak_logname = @lname 
					end

				select @executestmt3 = substring(@executestmt3, 1, datalength(@executestmt3)-1) --remove trailing comma
				
				print '*** RESTORE with MOVE on bak file *** '
				if @p_debug = 0
					begin
					print  @executestmt3
    				execute (@executestmt3)
					end
                else
                    print  @executestmt3

               
            --Dif file restore
            --have to go and requery the sys.master_files table to get the NEW list (if any) data and log files from previous bak file restore. Hence, #targetdbfiles(2)

            select database_id,file_id,type,data_space_id,name,physical_name, substring(physical_name, 1,2) as drive,
                   case type when 0 then 'row'
                             when 1 then 'log'
                             when 2 then 'fs' else 'unkn' end as filetype,
                   substring(left(physical_name,len(physical_name) - charindex('\',reverse(physical_name),1) + 1),3,len(physical_name) - 2) as fpath,
                   reverse(left(reverse(physical_name),charindex('\', reverse(physical_name), 1) - 1)) as fname,
                   db_name(database_id) as [db_name],
                   processed = 0
            into #targetdbfiles2 
            from sys.master_files where database_id = db_id(@p_targetdbname)

             --clear out previous bak information
        		truncate table #BakDifTmp
        		truncate table #restoreelements
        		
				select @executestmt3 = 'restore filelistonly from disk = ''' + @p_inputfile2 + ''''
				insert #BakDifTmp exec (@executestmt3)

                
                if (@p_inputfile2_supplied = 1)
					begin
						insert into #restoreelements
						select logicalname as bak_logname, 
							   physicalname as bak_physname, 
							   t.[type] as bak_ftype, 
							   drive as db_drive,
							   null as DataDriveOverride,
							   null as LogDriveOverride, 
							   fpath as db_path, 
							   fname as db_file,
							   [db_name] as [db_name],
							   0 as processed
						from #BakDifTmp t left outer join #targetdbfiles2 tgt on  t.Fileid = tgt.[file_id]--on t.logicalname = tgt.name
					
					update  #restoreelements set [db_name] = (select top 1 [db_name] from #restoreelements where [db_name] is not null)                                               

					--make some assumptions about placement of data files for Dif file
					update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'D'),
										 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'D'),
										 db_file = 'DtaDif_' + [db_name] + bak_logname + '.ndf'
									 where db_drive is null and bak_ftype = 'D' 
	                                 
					--make some assumptions about placement of log files for Dif file
					update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'L'),
										 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'L'),
										 db_file = 'LogDif_' + [db_name] + bak_logname + '.ldf'
									 where db_drive is null and bak_ftype = 'L' 
					
					--override placement of the log files by drive letter				 
					if (@p_DataDriveOverride is not null)
						update #restoreelements set DataDriveOverride = @p_DataDriveOverride where bak_ftype = 'D'
					if (@p_LogDriveOverride is not null)
						update #restoreelements set LogDriveOverride = @p_LogDriveOverride where bak_ftype = 'L'

         
					select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile2+''' with replace, stats=10, recovery, '
                    
					while (select count(*) from #restoreelements where processed = 0 ) > 0
						begin
						--select * from #restoreelements
							select top 1 @lname = bak_logname,
										 @pname = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path + db_file
						                               when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path + db_file
						                               else 'Undefined'
						                          end,
						                 @ppath = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path
						                               when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path
						                               else 'Undefined'
						                      end      

							from #restoreelements where processed = 0 

						--create directory if not exists
						select @xpcmd = 'dir ' + @ppath
						exec @result = xp_cmdshell @xpcmd, no_output
						if @result <> 0
						  begin
						    print 'Creating Directory'
						  	select @xpcmd = 'mkdir ' + @ppath
						    if @p_debug = 0
						      begin
						        exec @result = xp_cmdshell @xpcmd, no_output
								print @xpcmd
                              end
						    else
						      print @xpcmd
						  end 


						   select @moveclause = 'move ''' + @lname + ''' to ''' + @pname + ''',' from #restoreelements
						   select @executestmt3 = @executestmt3 + @moveclause

						   update #restoreelements set processed = 1 where bak_logname = @lname 

						end

						select @executestmt3 = substring(@executestmt3, 1, datalength(@executestmt3)-1) --remove trailing comma
						
						print '*** RESTORE with MOVE on dif file *** '
						if @p_debug = 0
						  begin
						    print  @executestmt3
    						execute (@executestmt3)
						  end
						else
							print  @executestmt3
 					end

          end   
               
        /*Tb Mixed restore files 09/10/2014*/
		if @p_debug = 0
			begin
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE WITH NO_WAIT;'
				Print @executestmt
				execute (@executestmt)
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE;'
				Print @executestmt
				execute (@executestmt)
				select @executestmt = 'ALTER AUTHORIZATION ON DATABASE::[' + @p_targetdbname + '] TO sa'
				Print @executestmt
				execute (@executestmt) 	
				select @executestmt = 'select type_desc as Type, name as LogicalName, physical_name as FileLocation from [' + @p_targetdbname + '].sys.database_files'
		        execute (@executestmt)  
			end
        else
			begin
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE WITH NO_WAIT;'
				Print @executestmt
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE;'
				Print @executestmt
				select @executestmt = 'ALTER AUTHORIZATION ON DATABASE::[' + @p_targetdbname + '] TO sa'
				Print @executestmt
			end   
			     
      
                    

		goto CLEANUP						
	End


-- Clean Up
CLEANUP:

IF (object_id('cur_user') IS NOT Null)
     BEGIN
          CLOSE cur_user
          DEALLOCATE cur_user
    END    
IF (object_id('cur_role') IS NOT Null)
     BEGIN
          CLOSE cur_role
          DEALLOCATE cur_role 
     END 
 IF (object_id('#tblsqlscripts') IS NOT Null)
     BEGIN
		 DROP TABLE #tblSQLScripts
     END     

SET ANSI_NULLS OFF








GO
/****** Object:  StoredProcedure [dbo].[SS_PROC_RestoreDBMulti_WithOverride]    Script Date: 10/19/2022 1:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SS_PROC_RestoreDBMulti_WithOverride]
     (
          @p_inputfiletype  sysname,
          @p_sourceinstance sysname,
          @p_sourcedbname sysname,
          @p_targetdbname sysname,
          @p_inputfile1  nvarchar(256),--sysname,
          @p_inputfile2 nvarchar(256),--sysname,
          @p_restoredate datetime = null,
          @p_DataDriveOverride char(2) = null,
	      @p_LogDriveOverride char(2) = null,
	      @p_debug bit = 0 
     )

----------------------------------------------------------------------------------------
--  MODIFICATION HISTORY
--  Initial Version
--	DATE/WHAT		WHO		VERSION
--  02/01/2012		Scott	1.0
--  03/22/2012		Steve	1.1
--  09/10/2014      Tb      2.0
--  Fix bug with setting of @i_skiplogs variable
-- 2.0 Allow for restore of mixed number of data and log files in the restore bak/dif files
----------------------------------------------------------------------------------------
AS

SET NOCOUNT on
SET FMTONLY OFF 

declare 
        @this_server			sysname,
        @procname			varchar(255),
        @procversion		varchar(4),
        @sqlfixsp				Varchar(32),
        @executestmt		nvarchar(4000),
        @executestmt2	varchar(4000),
        @executestmt3	varchar(4000),
        @sqlcmd				varchar(4000),
        @dircmd				varchar(4000),        
        @executeprefix		nvarchar(100),
        @princname			sysname,
        @dbcnt					integer,
        @schemacnt			integer,
        @scriptcnt				integer,
        @scriptpegdbname sysname,                              
        @fullscriptfile			varchar(2000),
        @devtrack			varchar(1),         
        @dummy				varchar,
        @dbmdbrgfoldernodename varchar(32),
        @pegasyssecmode varchar(32),
        @startime datetime,
        @login_time datetime,
        @spid integer,
        @dbname sysname,
        @status sysname,
        @loginame sysname,
        @msg sysname,
        @hostname sysname,
        @program_name sysname,
        @cmd sysname,
        @uid sysname,
        @nt_username sysname,
        @sid varchar,
        @i_skiplogs varchar

declare @source_server_name sysname,
          @cur_source_server_name sysname,
          @source_database_name  sysname,
          @cur_source_database_name sysname,
          @target_database_name  sysname,
          @cur_target_database_name sysname,         

        @reporting_timespan sysname,
        @deleteexisting sysname,

        @datestmt       varchar(4000),
        @output         sysname,
        @ErrorString varchar(255),
        @HdrString varchar(255),
        @sqlfixstr varchar(100),


        @princ_name varchar(75),

          @temp_database_name  varchar(50),
        @temp_server_name varchar(50),
        @temp_princ_name varchar(75),
        @temp_princ_id varchar(16),
        @temp_recno integer,
        @temp_perm_state varchar(30),
         @servercnt integer,        
  
        @role varchar(50),
        @roleconcat varchar(250),
        @rolecnt integer ,
        @frole VARchar(50),
        @froleconcat varchar(250),
        @frolecnt integer,
        @typrun varchar(5),
        @msgindent int,    
        @killStatements             varchar(4000)  
        


--- Set Proc name, etc
Select @this_server = @@Servername
Set @procname = 'dbo.SS_PROC_RestoreDB_WithOverride'
set @procversion = '2.0'
Set @sqlfixsp = ''
--set @pegasyssecmode ='STANDARD'

if ((@p_debug <> 0 and @p_debug <> 1) or @p_debug is null )
  begin
    select @p_debug = 1 --assume debug on for bad parm
  end
  
if (@p_debug = 1 )
  begin
    print 'DEBUGGER is ON'
  end

--- Check and set parms
IF ((Upper(@p_inputfiletype) <> 'FILE') and (Upper(@p_inputfiletype) <> 'LASTBKUP'))
     BEGIN
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE parm *****'
          GOTO CLEANUP
     END
Else
    set @p_inputfiletype = Upper(@p_inputfiletype)

IF ((@p_inputfile1 IS Null) or (@p_inputfile1 = ''))
     BEGIN
     If @p_inputfiletype = 'FILE'
		Begin
          print ' ***** ERROR OCCURRED - INPUFILETYPE=FILE specified but no Files provided in parms *****'
          GOTO CLEANUP
		End
     END
Else

-- Note that @inputfile2 cannot be validated since it is always optional

IF ((@p_sourceinstance IS Null) or (@p_sourceinstance = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no SOURCEINSTANCE parm provided *****'
          GOTO CLEANUP
		End
     END
Else

IF ((@p_sourcedbname IS Null) or (@p_sourcedbname = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no SOURCEDBNAME parm provided *****'
          GOTO CLEANUP
		End
     END
Else

IF ((@p_targetdbname IS Null) or (@p_targetdbname = ''))
     BEGIN
     If @p_inputfiletype = 'LASTBKUP'
		Begin
          print ' ***** ERROR OCCURRED - Invalid INPUFILETYPE=LASTBKUP specified but no TARGETDBNAME parm provided *****'
          GOTO CLEANUP
		End
     END



-- Parms are ok but lets make sure that target db exists in svr before we go any further
select @dbcnt = COUNT(*) from sys.sysdatabases where name = ''+@p_targetdbname+''
If @dbcnt <= 0
	Begin
		print ' ***** ERROR OCCURRED - Target database '+Upper(@p_targetdbname)+' cannot be found on the current server *****'
		GOTO CLEANUP
	end
	
-- Check for sessions in the database to be restored

DECLARE cursor_normal_spid_detector CURSOR
FOR
  select 
  spid, 
  LTRIM(status), 
  SUBSTRING(sid,1,16), 
  login_time, 
  loginame, 
  LTRIM(hostname), 
  LTRIM(program_name), 
  LTRIM(cmd), 
  uid, 
  nt_username, 
  db_name(dbid) dbname
  from  
  master.dbo.sysprocesses
  where 
	spid <> @@spid       -- not current process
	and db_name(dbid) = @p_targetdbname 
	and loginame <> 'sa' 			-- exclude sa
  FOR READ ONLY
-- Open Direct SPID Cursor
  open cursor_normal_spid_detector
  select @startime = getdate()				
-- Fetch next from Direct SPID cursor
  FETCH NEXT FROM cursor_normal_spid_detector INTO @spid, @status, @sid, @login_time, @loginame, @hostname, @program_name, @cmd, @uid, @nt_username, @dbname
  IF (@@fetch_status = 0)
     BEGIN
       Select @msg = 'The following users are logged into target database '+ LTrim(Rtrim(@dbname))  
       Print @msg
       select @killStatements = '/* Optional kill spid statements ' + char(13) + char(10) 
       WHILE (@@fetch_status = 0) 
         BEGIN
           Select @msg=' '
	       Select @msg = @msg   + 'SPID=' + LTrim(Rtrim(@spid))
	                            + ' Login Name=' + LTrim(Rtrim(@loginame))
	                            + ' Status=' + LTrim(Rtrim(@status))
		            			+ ' Login Time=' + Ltrim(RTrim(cast(@login_time as varchar(30))))
		 		    		    + ' Hostname=' + LTrim(Rtrim(@hostname))
		 			    	    + ' Program Name=' + LTrim(Rtrim(@program_name))
	       Print @msg 	
	       select @killStatements = @killStatements + ' kill ' + cast(@spid as varchar) 	+ char(13) + char(10)	
	       FETCH NEXT FROM cursor_normal_spid_detector INTO @spid, @status, @sid, @login_time, @loginame,  @hostname, @program_name, @cmd, @uid, @nt_username, @dbname  
	     END
       close cursor_normal_spid_detector
	   deallocate cursor_normal_spid_detector
	   select @killStatements = @killStatements + '*/ ' + char(13) + char(10)
	   print @killStatements
           Print 'Restore of database '+ LTrim(Rtrim(@dbname)) + ' is terminating.'
	   GOTO CLEANUP
     END
   ELSE 
     BEGIN
       close cursor_normal_spid_detector
	   deallocate cursor_normal_spid_detector
     END  
-- Log activity/errors
select @ErrorString =  'BEGINNING PROCEDURE ' +@procname+ ' (Version ' + CONVERT(varchar(3), @procversion) + ') at ' + CONVERT(varchar(30), GETDATE(), 109) + '.'
select @HdrString = replicate('*',datalength(@ErrorString))
print @HdrString
print @ErrorString

	
-- STEP #1 - Database Restore Step
-- STEP #1A - LASTBKUP Type
/*
Parameters

@source_instance	optional		The name of the instance that contains the source database. If excluded, the restore will read from the current instance.
@source_db	required			The name of the source database to restore from.
@dest_db	optional					The name of the destination database to restore to. If excluded, the restored database will use the same name as the source database. 
@skip_logs	optional				Set to 1 and no log files will be restored. Used if you only want to restore a full or differential backup. If excluded, the restore will use any available log backup files.
@restore_date	optional			The date and time to restore to. If excluded, the current date and time will be used.
@data_directory	optional		The directory in which all restored data files will be placed. If omitted, the procedure will determine the appropriate directory from the current destination database if it exists, or will use the instance default locations if not.
@log_directory	optional			The directory in which all restored log files will be placed. If omitted, the procedure will determine the appropriate directory from the current destination database if it exists, or will use the instance default locations if not.
@debug	optional					Set to 1 and the procedure will print the restore commands to the screen without executing them.
		

*/
--GOTO ADDSEC
--GOTO STRIPSEC

IF @p_inputfiletype = 'LASTBKUP'
   	Begin
   	  select @ErrorString =  'Starting Restore step at ' + CONVERT(varchar(30), GETDATE(), 109) + '.'
 	  Print @ErrorString 
	  if @p_restoredate is null
	    begin
	      Set @i_skiplogs = '1'
          Select @executestmt = 'exec dbutils.dbo.sp_restore_db @source_instance = ''' + @p_sourceinstance + ''', @source_db = ''' +@p_sourcedbname + ''', @dest_db = '''+ @p_targetdbname +''', @skip_logs='+@i_skiplogs+', @debug='+cast(@p_debug as CHAR(1))
	    end
	  else
	    begin
	      Set @i_skiplogs = '0'
	      Select @executestmt = 'exec dbutils.dbo.sp_restore_db @source_instance = ''' + @p_sourceinstance + ''', @source_db = ''' +@p_sourcedbname + ''', @dest_db = '''+ @p_targetdbname +''', @skip_logs='+@i_skiplogs+', @debug='+cast(@p_debug as CHAR(1))+', @restore_date='''+convert(nvarchar,@p_restoredate,121)+''''
	    end	    
 	   
	 -- Run the restore 
	 print @executestmt
	 execute (@executestmt)
	
		GOTO CLEANUP
	End
    	
-- STEP #1B - File Type
Else
	Begin
	    /*Tb Mixed restore files 09/10/2014*/
	    declare @p_inputfile1_supplied bit = 0,
                @p_inputfile2_supplied bit = 0,
                @count tinyint = 1,
                @moveclause varchar(4000) = '',
                @lname varchar(128),
                @pname varchar(260),
                @ppath varchar(260),
                @fname varchar(50),
                @recoveryclause varchar(10),
                @restorestmt varchar(4000),
                @xpcmd varchar (2000),
                @result int
                
        select @p_inputfile1_supplied = 1,  --make it to here, a file has been supplied
               @p_inputfile2_supplied = case when (@p_inputfile2 IS Null) or (@p_inputfile2 = '') then 0 else 1 end
 


        --get the files from the existing db to be replaced
        if ( @p_inputfile1_supplied = 1)
          begin
			  create table #BakDifTmp (
					LogicalName nvarchar(128), 
					PhysicalName nvarchar(260),
					[Type] char(1),
					FileGroupName nvarchar(128),
					Size numeric(20,0) ,
					MaxSize numeric(20,0),
					Fileid	tinyint,
					CreateLSN numeric(25,0),
					DropLSN numeric(25, 0),
					UniqueID uniqueidentifier,
					ReadOnlyLSN numeric(25,0),
					ReadWriteLSN numeric(25,0),
					BackupSizeInBytes bigint,
					SourceBlockSize int,
					FileGroupId int,
					LogGroupGUID uniqueidentifier,
					DifferentialBaseLSN numeric(25,0),
					DifferentialBaseGUID uniqueidentifier,
					IsReadOnly bit,
					IsPresent bit, 
					TDEThumbprint varbinary(32))

			--added column on 2016 of SnapShotURL
		    declare @SQLversion nvarchar(20) 
            select @SQLversion = convert(nvarchar(25),SERVERPROPERTY('productversion'))
			if @SQLversion >= '13'
			  begin
			     alter table #BakDifTmp add SnapshotUrl nvarchar(360)
			  end
            
            --have to go and query the sys.master_files table to get the list of data and log files, #targetdbfiles(1)
            select database_id,file_id,type,data_space_id,name,physical_name, substring(physical_name, 1,2) as drive,
                   case type when 0 then 'row'
                             when 1 then 'log'
                             when 2 then 'fs' else 'unkn' end as filetype,
                   substring(left(physical_name,len(physical_name) - charindex('\',reverse(physical_name),1) + 1),3,len(physical_name) - 2) as fpath,
                   reverse(left(reverse(physical_name),charindex('\', reverse(physical_name), 1) - 1)) as fname,
                   db_name(database_id) as [db_name],
                   processed = 0
            into #targetdbfiles1 
            from sys.master_files where database_id = db_id(@p_targetdbname)


			
				
            --hold bak file elements
			select @executestmt3 = 'restore filelistonly from disk = ''' + @p_inputfile1 + ''''
			insert #BakDifTmp exec (@executestmt3)
                
            select logicalname as bak_logname, 
			       physicalname as bak_physname, 
			       t.[type] as bak_ftype, 
			       drive as db_drive,
			       cast(null as CHAR(2)) as DataDriveOverride,
			       cast(null as CHAR(2)) as LogDriveOverride, 
			       fpath as db_path, 
			       fname as db_file,
			       [db_name] as [db_name],
			       0 as processed
			into #restoreelements
			from #BakDifTmp t left outer join #targetdbfiles1 tgt on t.Fileid = tgt.[file_id] --on t.logicalname = tgt.name

                --Bak file restore
                update  #restoreelements set [db_name] = (select top 1 [db_name] from #restoreelements where [db_name] is not null)                                               

				--make some assumptions about placement of data files for .Bak extra file(s)
				update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'D'),
									 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'D'),
									 db_file = 'DtaBak_' + [db_name] + bak_logname + '.ndf'
								 where db_drive is null and bak_ftype = 'D' 
                                 
				--make some assumptions about placement of log files for .Bak file extra file(s)
				update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'L'),
									 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'L'),
									 db_file = 'LogBak_' + [db_name] + bak_logname + '.ldf'
								 where db_drive is null and bak_ftype = 'L' 
								 
				--override placement of the data files by drive letter				 
				if (@p_DataDriveOverride is not null)
				    update #restoreelements set DataDriveOverride = @p_DataDriveOverride where bak_ftype = 'D'
				if (@p_LogDriveOverride is not null)
				    update #restoreelements set LogDriveOverride = @p_LogDriveOverride where bak_ftype = 'L'
 				
 				select @recoveryclause = case when (@p_inputfile2_supplied = 0) then 'recovery' else 'norecovery' end
 	---------------------------------------------------
	 --is this multifile restore or single file restore
		create table #RestoreLabel
		(
			MediaName	nvarchar(128) null,
			MediaSetId	uniqueidentifier null,
			FamilyCount	int null,
			FamilySequenceNumber	int null,
			MediaFamilyId	uniqueidentifier null,
			MediaSequenceNumber	int null,
			MediaLabelPresent	tinyint null,
			MediaDescription	nvarchar(255) null,
			SoftwareName	nvarchar(128) null,
			SoftwareVendorId	int null,
			MediaDate	datetime null,
			Mirror_Count	int null,
			IsCompressed	bit null
		)
		declare @FamilyCount int = 0, @MediaFamilyId varchar(50), @MediaSetID int = 0

		insert into #RestoreLabel exec ('restore labelonly from disk=''' + @p_inputfile1 + '''')

	
	--select @FamilyCount = FamilyCount, @MediaFamilyId = MediaFamilyId  from #RestoreLabel
	--select @FamilyCount, '@FamilyCount',@MediaFamilyId,'@MediaFamilyId'

	if @FamilyCount = 1
	  begin
	    print 'Singlefile restore starting'
		select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile1+''' with replace, stats=10, ' + @recoveryclause + ', '
	  end
	else
	  begin
		print 'Multifile restore starting'
		declare @cmd1 nvarchar(1000) = 'restore database ' + @p_targetdbname + ' from ' + char(13),
		@cmd2 nvarchar(1000) = '',
		@cmd3 nvarchar(1000) = 'with stats = 10, replace, ',
		@cmdTmp nvarchar(1000) = '',
		@cmdFinal nvarchar(4000),
		@counter int = 1,
		@NumberOfFiles int = 1,
		@strCount varchar(2),
		@Label varchar(10),
		@strNumFiles varchar(2)

		select @NumberOfFiles = cast(right(left(right(@p_inputfile1,10),6),2) as int)
		select @p_inputfile1 = reverse(@p_inputfile1)
		select @p_inputfile1 = substring(@p_inputfile1,11,DATALENGTH(@p_inputfile1))
		select @p_inputfile1 = reverse(@p_inputfile1)


		while @counter <= @NumberOfFiles
		  begin
		  	  select @strNumFiles = case when @NumberOfFiles < 10 then '0' + cast(@NumberOfFiles as nvarchar) else cast(@NumberOfFiles as nvarchar) end
	          select @strCount = case when @counter < 10 then '0' + cast(@counter as nvarchar) else cast(@counter as nvarchar) end

			  select @Label = @strCount + 'of' + @strNumFiles + '.bak'

			  select @cmdTmp = 'disk=''' + @p_inputfile1 + @Label +''',' + char(13) 
			  --select @cmdTmp , 'cmdTmp'
			  if @counter = @NumberOfFiles
				begin
				  select @cmdTmp = replace(@cmdTmp,',','')
				end
		
				select @cmd2 = @cmd2 + @cmdTmp
				select @counter = @counter + 1
		  end

		  select @executestmt3 = @cmd1 + @cmd2 + @cmd3
		  --print @executestmt3

	  end
	
	----------------------------------------------------			
				--select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile1+''' with replace, stats=10, ' + @recoveryclause + ', '


                

				while (select count(*) from #restoreelements where processed = 0 ) > 0
					begin

						select top 1 @lname = bak_logname,
									 @pname = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path + db_file
						                           when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path + db_file
						                           else 'Undefined'
						                      end,
						             @ppath = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path
						                           when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path
						                           else 'Undefined'
						                      end    
    
						from #restoreelements where processed = 0 
						
						--create directory if not exists
						select @xpcmd = 'dir ' + @ppath
						exec @result = xp_cmdshell @xpcmd, no_output
						if @result <> 0
						  begin
						    print 'Creating Directory'
						  	select @xpcmd = 'mkdir ' + @ppath
						  	if @p_debug = 0
							  begin
						        exec @result = xp_cmdshell @xpcmd, no_output
								print @xpcmd
                              end
						    else
						      print @xpcmd
						  end 

					   select @moveclause = 'move ''' + @lname + ''' to ''' + @pname + ''',' from #restoreelements
					   select @executestmt3 = @executestmt3 + @moveclause

					   update #restoreelements set processed = 1 where bak_logname = @lname 
					end

				select @executestmt3 = substring(@executestmt3, 1, datalength(@executestmt3)-1) --remove trailing comma
				
				print '*** RESTORE with MOVE on bak file *** '
				if @p_debug = 0
					begin
						print  @executestmt3
    					execute (@executestmt3)
					end
                else
                    print  @executestmt3

               
            --Dif file restore
            --have to go and requery the sys.master_files table to get the NEW list (if any) data and log files from previous bak file restore. Hence, #targetdbfiles(2)

            select database_id,file_id,type,data_space_id,name,physical_name, substring(physical_name, 1,2) as drive,
                   case type when 0 then 'row'
                             when 1 then 'log'
                             when 2 then 'fs' else 'unkn' end as filetype,
                   substring(left(physical_name,len(physical_name) - charindex('\',reverse(physical_name),1) + 1),3,len(physical_name) - 2) as fpath,
                   reverse(left(reverse(physical_name),charindex('\', reverse(physical_name), 1) - 1)) as fname,
                   db_name(database_id) as [db_name],
                   processed = 0
            into #targetdbfiles2 
            from sys.master_files where database_id = db_id(@p_targetdbname)

             --clear out previous bak information
        		truncate table #BakDifTmp
        		truncate table #restoreelements
        		
				select @executestmt3 = 'restore filelistonly from disk = ''' + @p_inputfile2 + ''''
				insert #BakDifTmp exec (@executestmt3)

                
                if (@p_inputfile2_supplied = 1)
					begin
						insert into #restoreelements
						select logicalname as bak_logname, 
							   physicalname as bak_physname, 
							   t.[type] as bak_ftype, 
							   drive as db_drive,
							   null as DataDriveOverride,
							   null as LogDriveOverride, 
							   fpath as db_path, 
							   fname as db_file,
							   [db_name] as [db_name],
							   0 as processed
						from #BakDifTmp t left outer join #targetdbfiles2 tgt on  t.Fileid = tgt.[file_id]--on t.logicalname = tgt.name
					
					update  #restoreelements set [db_name] = (select top 1 [db_name] from #restoreelements where [db_name] is not null)                                               

					--make some assumptions about placement of data files for Dif file
					update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'D'),
										 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'D'),
										 db_file = 'DtaDif_' + [db_name] + bak_logname + '.ndf'
									 where db_drive is null and bak_ftype = 'D' 
	                                 
					--make some assumptions about placement of log files for Dif file
					update #restoreelements set db_drive = (select top 1 db_drive from #restoreelements where bak_ftype = 'L'),
										 db_path = (select top 1 db_path from #restoreelements where bak_ftype = 'L'),
										 db_file = 'LogDif_' + [db_name] + bak_logname + '.ldf'
									 where db_drive is null and bak_ftype = 'L' 
					
					--override placement of the log files by drive letter				 
					if (@p_DataDriveOverride is not null)
						update #restoreelements set DataDriveOverride = @p_DataDriveOverride where bak_ftype = 'D'
					if (@p_LogDriveOverride is not null)
						update #restoreelements set LogDriveOverride = @p_LogDriveOverride where bak_ftype = 'L'


---------------------------------------------------------
















---------------------------------------------------------
         
					select @executestmt3 = 'restore database [' + @p_targetdbname +'] from disk='''+@p_inputfile2+''' with replace, stats=10, recovery, '
                    
					while (select count(*) from #restoreelements where processed = 0 ) > 0
						begin
						--select * from #restoreelements
							select top 1 @lname = bak_logname,
										 @pname = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path + db_file
						                               when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path + db_file
						                               else 'Undefined'
						                          end,
						                 @ppath = case when bak_ftype = 'D' then case when DataDriveOverride is null then db_drive else DataDriveOverride  end + db_path
						                               when bak_ftype = 'L' then case when LogDriveOverride is null then db_drive else LogDriveOverride  end + db_path
						                               else 'Undefined'
						                      end      

							from #restoreelements where processed = 0 

						--create directory if not exists
						select @xpcmd = 'dir ' + @ppath
						exec @result = xp_cmdshell @xpcmd, no_output
						if @result <> 0
						  begin
						    print 'Creating Directory'
						  	select @xpcmd = 'mkdir ' + @ppath
						    if @p_debug = 0
						      begin
						        exec @result = xp_cmdshell @xpcmd, no_output
								print @xpcmd
                              end
						    else
						      print @xpcmd
						  end 


						   select @moveclause = 'move ''' + @lname + ''' to ''' + @pname + ''',' from #restoreelements
						   select @executestmt3 = @executestmt3 + @moveclause

						   update #restoreelements set processed = 1 where bak_logname = @lname 

						end

						select @executestmt3 = substring(@executestmt3, 1, datalength(@executestmt3)-1) --remove trailing comma
						
						print '*** RESTORE with MOVE on dif file *** '
						if @p_debug = 0
						  begin
						    print  @executestmt3
    						execute (@executestmt3)
						  end
						else
							print  @executestmt3
 					end

          end   
               
        /*Tb Mixed restore files 09/10/2014*/
		if @p_debug = 0
			begin
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE WITH NO_WAIT;'
				Print @executestmt
				execute (@executestmt)
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE;'
				Print @executestmt
				execute (@executestmt)
				select @executestmt = 'ALTER AUTHORIZATION ON DATABASE::[' + @p_targetdbname + '] TO sa'
				Print @executestmt
				execute (@executestmt) 	
				select @executestmt = 'select type_desc as Type, name as LogicalName, physical_name as FileLocation from [' + @p_targetdbname + '].sys.database_files'
		        execute (@executestmt)  
			end
        else
			begin
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE WITH NO_WAIT;'
				Print @executestmt
				select @executestmt = 'ALTER DATABASE [' + @p_targetdbname +'] SET RECOVERY SIMPLE;'
				Print @executestmt
				select @executestmt = 'ALTER AUTHORIZATION ON DATABASE::[' + @p_targetdbname + '] TO sa'
				Print @executestmt
			end   
			     
      
                    

		goto CLEANUP						
	End


-- Clean Up
CLEANUP:

IF (object_id('cur_user') IS NOT Null)
     BEGIN
          CLOSE cur_user
          DEALLOCATE cur_user
    END    
IF (object_id('cur_role') IS NOT Null)
     BEGIN
          CLOSE cur_role
          DEALLOCATE cur_role 
     END 
 IF (object_id('#tblsqlscripts') IS NOT Null)
     BEGIN
		 DROP TABLE #tblSQLScripts
     END     

SET ANSI_NULLS OFF








GO
/****** Object:  StoredProcedure [dbo].[UD_GetListDBAccess]    Script Date: 10/19/2022 1:45:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[UD_GetListDBAccess]
@db_name [varchar](100) = Null,
@location [varchar](100) = Null
WITH EXECUTE AS CALLER
AS
begin    
set nocount on  
 DECLARE @name sysname    
 DECLARE @type varchar (1)    
 DECLARE @hasaccess int    
 DECLARE @denylogin int    
 DECLARE @is_disabled int    
 DECLARE @PWD_varbinary  varbinary (256)    
 DECLARE @PWD_string  varchar (514)    
 DECLARE @SID_varbinary varbinary (85)    
 DECLARE @SID_string varchar (514)    
 DECLARE @tmpstr  varchar (1024)    
 DECLARE @is_policy_checked varchar (3)    
 DECLARE @is_expiration_checked varchar (3)    
 declare @login_name sysname ,@sql varchar(8000)    
 set @login_name = null    
 if @db_name is null    
 begin    
  raiserror('Procedure requires db_name',16,1,50001)    
  goto endofproc    
 end    
 if not exists (select 1 from sys.databases where name=@db_name)
 begin
 raiserror('Invalid database Name',16,1,50001)    
 goto endofproc
 end
 create table ##permission_info (id int primary key identity, information varchar(8000))    
 DECLARE @defaultdb sysname    
  create table #login_info(sid varbinary(85),name sysname,type char(1),is_disabled bit,default_database_name sysname,hasaccess int,denylogin int)    
  -- DECLARE login_curs CURSOR FOR    
    set @sql= 'SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM    
 sys.server_principals p LEFT JOIN master.sys.syslogins l ON ( l.name = p.name )    
 inner join '+@db_name+'.sys.database_principals u ON (l.sid =U.SID)    
     WHERE u.type IN ( ''S'',''G'',''U'' ) AND u.name not in ( ''sa'',''SamPull'',''SNation'')  and u.principal_id>4
     order by p.name'      
 insert into #login_info exec (@sql)    
 
 if exists(select 1 from #login_info)
 begin
 DECLARE login_curs CURSOR FOR select * from #login_info    
   
 OPEN login_curs    
   
 FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin    
 IF (@@fetch_status = -1)    
 BEGIN    
   PRINT 'No login(s) found.'    
   CLOSE login_curs    
   DEALLOCATE login_curs    
 END    
 insert into ##permission_info(information) values('USE '+@db_name)    
 insert into ##permission_info(information) values('GO')    
 SET @tmpstr = '/* Creating Login information '    
 insert into ##permission_info(information) values(@tmpstr)    
 SET @tmpstr = '** Generated ' + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'    
 insert into ##permission_info(information) values(@tmpstr)    
 insert into ##permission_info(information) values('')    
 WHILE (@@fetch_status <> -1)    
 BEGIN    
   IF (@@fetch_status <> -2)    
   BEGIN    
  insert into ##permission_info(information) values('')    
  SET @tmpstr = '-- Login: ' + @name    
  insert into ##permission_info(information) values(@tmpstr)    
  IF (@type IN ( 'G', 'U'))    
  BEGIN -- NT authenticated account/group    
    set @tmpstr = 'if not exists(select * from master.sys.server_principals where name = '''+@name+''')    
 begin    
 CREATE LOGIN ' + QUOTENAME( @name ) + ' FROM WINDOWS WITH DEFAULT_DATABASE = [' + @defaultdb + ']'    
  END    
  ELSE BEGIN -- SQL Server authentication    
   -- obtain password and sid    
    SET @PWD_varbinary = CAST( LOGINPROPERTY( @name, 'PasswordHash' ) AS varbinary (256) )    
   EXEC sp_hexadecimal @PWD_varbinary, @PWD_string OUT    
   EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT    
     
   -- obtain password policy state    
   SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name    
   SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name    
    set @tmpstr = 'if not exists(select * from master.sys.server_principals where name =''' + @name +''')    
begin    
 '    
    SET @tmpstr = @tmpstr+'CREATE LOGIN ' + QUOTENAME( @name ) + ' WITH PASSWORD = ' + @PWD_string + ' HASHED, SID = ' + @SID_string + ', DEFAULT_DATABASE = [' + @defaultdb + ']'    
   IF ( @is_policy_checked IS NOT NULL )    
   BEGIN    
     SET @tmpstr = @tmpstr + ', CHECK_POLICY = ' + @is_policy_checked    
   END    
   IF ( @is_expiration_checked IS NOT NULL )    
   BEGIN    
     SET @tmpstr = @tmpstr + ', CHECK_EXPIRATION = ' + @is_expiration_checked    
   END    
  END    
  IF (@denylogin = 1)    
  BEGIN -- login is denied access    
    SET @tmpstr = @tmpstr + '; DENY CONNECT SQL TO ' + QUOTENAME( @name )    
  END    
  ELSE IF (@hasaccess = 0)    
  BEGIN -- login exists but does not have access    
    SET @tmpstr = @tmpstr + '; REVOKE CONNECT SQL TO ' + QUOTENAME( @name )    
  END    
  IF (@is_disabled = 1)    
  BEGIN -- login is disabled    
    SET @tmpstr = @tmpstr + '; ALTER LOGIN ' + QUOTENAME( @name ) + ' DISABLE'    
  END    
  set @tmpstr=@tmpstr+'    
 end'    
  insert into ##permission_info(information) values(@tmpstr)    
   END    
   
   FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin    
    END    
 CLOSE login_curs    
 DEALLOCATE login_curs    
 end
/*creating roles*/
set @sql= 'select ''if not exists (select 1 from  '+@db_name+'.sys.database_principals where type =''''R'''' and name=''''''+name+'''''')
create role [''+name+''];'' from '+@db_name+'.sys.database_principals where type=''R'' and principal_id not between 16384 and 16393 and principal_id <>0'    
insert into ##permission_info(information) values('/* Creating Database Roles*/')    
insert into ##permission_info(information) exec (@sql)    

 /* creating database user*/    
   
 set @sql='select ''IF NOT EXISTS (SELECT 1 FROM ['+@db_name+'].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= ''''''+NAME+'''''')    
 BEGIN    
  IF EXISTS (SELECT 1 FROM ['+@DB_NAME+'].SYS.database_principals WHERE NAME =''''''+NAME+'''''')    
  DROP USER [''+NAME+'']    
  CREATE USER [''+name+''] FOR LOGIN [''+NAME+''] WITH DEFAULT_SCHEMA = ''+isnull(DEFAULT_SCHEMA_NAME,''dbo'') +''    
 END''from ['+@db_name+'].sys.database_principals WHERE PRINCIPAL_ID>4 AND TYPE in (''s'',''u'',''g'') order by name'    
 insert into ##permission_info(information) values('/* GRANTING PERMISSIONS TO DATABASE*/')    
   
 insert into ##permission_info(information) exec (@sql)    
 --print @sql    
 /* GRANTING DBROLE PERMISSIONS*/    
   
 set @sql ='select ''exec sp_addrolemember ''''''+dpr.name+'''''',''''''+dpm.name+'''''';''    
 from ['+@db_name+'].sys.database_principals dpr    
 inner join ['+@db_name+'].sys.database_role_members drm on dpr.principal_id=drm.role_principal_id    
 inner join ['+@db_name+'].sys.database_principals dpm on drm.member_principal_id=dpm.principal_id    
 where dpm.name<>''dbo'' order by dpr.name,dpm.name'    
   
 insert into ##permission_info(information) exec (@sql)    
 insert into ##permission_info(information) values('/* GRANTING DBROLE PERMISSIONS*/')
 set @sql='select case class_desc when ''OBJECT_OR_COLUMN'' then State_Desc+'' ''+DPER.PERMISSION_NAME COLLATE DATABASE_DEFAULT+'' ON OBJECT::''+sch.name+''.''+obj.name+'' TO ''+ QUOTENAME(dpri.name)  
when ''Database'' then State_Desc+''  ''+DPER.PERMISSION_NAME COLLATE DATABASE_DEFAULT+'' ON ''+class_desc+''::'+@db_name+' TO ''+Quotename(dpri.name)  
when ''Schema'' then State_Desc+''  ''+DPER.PERMISSION_NAME COLLATE DATABASE_DEFAULT+'' ON ''+class_desc+''::''+(select name from ['+@db_name+'].sys.schemas where schema_id=dper.major_id)+'' TO ''+Quotename(dpri.name) end
from ['+@db_name+'].sys.database_permissions dper    
inner join ['+@db_name+'].sys.database_principals dpri on  dper.grantee_principal_id = dpri.principal_id    
left join ['+@db_name+'].sys.objects obj on dper.major_id=obj.object_id    
left join ['+@db_name+'].sys.schemas sch on obj.schema_id=sch.schema_id    
where major_id>=0 and class_desc in (''OBJECT_OR_COLUMN'',''Database'',''Schema'') order by State_Desc,DPER.PERMISSION_NAME,class_desc,dpri.name,sch.name,obj.name'
--print @sql  
-- SET @SQL='select ''Grant ''+DPER.PERMISSION_NAME COLLATE DATABASE_DEFAULT +'' ON OBJECT::''+sch.name+''.''+obj.name+'' TO ''+dpri.name    
-- from '+@db_name+'.sys.database_permissions dper    
-- inner join '+@db_name+'.sys.database_principals dpri on  dper.grantee_principal_id = dpri.principal_id    
-- inner join '+@db_name+'.sys.objects obj on dper.major_id=obj.object_id    
-- inner join '+@db_name+'.sys.schemas sch on obj.schema_id=sch.schema_id    
-- where class=1 and major_id>0 and state_desc=''GRANT'''    
 --print @sql    
 insert into ##permission_info(information) EXEC (@SQL)    
 --select information from ##permission_info order by id    
 drop table #login_info    
 --    
 if @location is not null    
 begin    
  set @sql= 'exec master..xp_cmdshell ''bcp "select information from ##permission_info where information is not null order by id" queryout '+'"' + @location+@db_name+'\'+@db_name+'_druserlist.txt" -T -c'''    
  exec (@sql)    
 END    
 ELSE    
 BEGIN    
  SELECT INFORMATION FROM ##PERMISSION_INFO    
 END    
 --select information from ##permission_info order by id    
 drop table ##permission_info    
endofproc:
end --proc 
GO

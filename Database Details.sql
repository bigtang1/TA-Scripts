DECLARE @DB_Name varchar(100) 
DECLARE @Command nvarchar(4000) 
--DROP table #dblist 
CREATE TABLE #dblist  
   (servername VARCHAR (50), dbname VARCHAR (256), dbschcnt INT, dbsize INT, dbtblcnt INT, 
    dbsprcnt INT, dbvwcnt INT, dbindcnt INT, dbtrgcnt INT, dbgrpcnt INT, dbpricnt INT)


DECLARE database_cursor CURSOR FOR 
SELECT name 
FROM MASTER.sys.sysdatabases 

OPEN database_cursor 

FETCH NEXT FROM database_cursor INTO @DB_Name 

WHILE @@FETCH_STATUS = 0 
BEGIN 
	print @DB_Name;
	--if @DB_Name = 'WorkplaceExperience' or @DB_Name = 'AGtest-Delete'
	--Begin
	--	print 'Skipping ' + @DB_Name;
	--	FETCH NEXT FROM database_cursor INTO @DB_Name 
	--END
	--use [@DB_Name];

     SELECT @Command = ' use ' + @DB_Name + ';
	 
	 	   declare @dbinst varchar(50); 
	   declare @dbschcnt int         declare @dbsize int             
  declare @dbtblcnt int
  declare @dbsprcnt int
  declare @dbvwcnt int
  declare @dbtrgcnt int          declare @dbindcnt int
  declare @dbgrpcnt int          declare @dbpricnt int
  
  set @dbinst = @@servername; 
  set @dbschcnt = (select count(*) from sys.schemas
      where name not in (''guest'', ''information_schema'', ''db_owner'', ''db_accessadmin'', ''db_backupoperator'',
                        ''db_datareader'', ''db_datawriter'', ''db_ddladmin'', ''db_denydatareader'', 
                                      ''db_denydatawriter'', ''db_securityadmin''))
  set @dbsize = (select sum(size) from sys.database_files)
  set @dbsize = @dbsize/128 
  set @dbtblcnt = (select count(*) from sys.objects where type = ''U'' and name not like (''dt%''))
  set @dbsprcnt = (select count(*) from sys.objects where type = ''P'' and name not like (''dt%''))
  set @dbvwcnt = (select count(*) from sys.objects where type = ''V'')
  set @dbindcnt = (select count(*)
             from sys.objects so join sys.indexes si on so.object_id = si.object_id
             where so.type not in (''IT'', ''S'', ''D'') and si.type <> 0)
  set @dbtrgcnt = (select count(*) from sys.triggers)
  set @dbgrpcnt = (select count(*) from sys.database_principals where type = ''G'')
  set @dbpricnt = (select count(*) from sys.database_principals where type <> ''G'')
  insert #dblist values(@dbinst,''' + @DB_Name + ''', @dbschcnt, @dbsize, @dbtblcnt, @dbsprcnt, @dbvwcnt, @dbindcnt, @dbtrgcnt, @dbgrpcnt, @dbpricnt)'

  print @Command
     EXEC sp_executesql @Command 

     FETCH NEXT FROM database_cursor INTO @DB_Name 
END 

CLOSE database_cursor 
DEALLOCATE database_cursor 

SELECT        servername as ServerName,
                     '' as HA_Listener,
                     dbname as Database_Name,
                     dbschcnt as Schema_Cnt,
                     dbsize as DBSize_MB,
                     dbtblcnt as DBTable_Cnt,
                     dbsprcnt as DBSProc_Cnt,
                     dbvwcnt as DBView_Cnt,
                     dbindcnt as DBIndex_Cnt,
                     dbtrgcnt as DBTrigger_Cnt,
                     dbgrpcnt as DBGroup_Cnt,
                     dbpricnt as DBAcct_Cnt
FROM          #dblist  
WHERE         dbname not in ('master', 'msdb', 'model', 'tempdb') order by dbname
-- drop the temp table
--DROP table #dblist 
--select * from #dblist


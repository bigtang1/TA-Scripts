-- setup temp table for data
CREATE TABLE #dblist  
   (servername VARCHAR (50), dbname VARCHAR (256), dbschcnt INT, dbsize INT, dbtblcnt INT, 
    dbsprcnt INT, dbvwcnt INT, dbindcnt INT, dbtrgcnt INT, dbgrpcnt INT, dbpricnt INT)
-- gather data from each database and insert into temp table
EXEC sp_MSforeachdb 
' use ?
  declare @dbinst varchar(50); declare @dbname varchar(256)
  declare @dbschcnt int;          declare @dbsize int;              
  declare @dbtblcnt int
  declare @dbsprcnt int;          declare @dbvwcnt int
  declare @dbtrgcnt int;          declare @dbindcnt int
  declare @dbgrpcnt int;          declare @dbpricnt int
  set @dbinst = @@servername; set @dbname = ''?''
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
  insert #dblist values(@dbinst,@dbname, @dbschcnt, @dbsize, @dbtblcnt, @dbsprcnt, @dbvwcnt, @dbindcnt, @dbtrgcnt, @dbgrpcnt, @dbpricnt)'
-- data has been gathered in #dblist
-- output the data data
SELECT        servername as ServerName,
                     'TRSSQL01HAL' as HA_Listener,
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
DROP table #dblist 

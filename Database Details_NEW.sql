/*

select * from ServerInventoryACUL
CREATE TABLE ServerInventoryACUL(SQLInstanceName varchar(255) NOT NULL)
GO
insert into ServerInventoryACUL values ('CRDBTTBISQLP03\SQL01')
insert into ServerInventoryACUL values ('CRDBTTEXSQLP02\SQL01')
insert into ServerInventoryACUL values ('CRDBTTEXSQLP03\SQL01')
insert into ServerInventoryACUL values ('CRDBTTBISQLP04\SQL02')

insert into ServerInventoryACUL values ('CRDBTTBISQLP01\SQL01')
insert into ServerInventoryACUL values ('CRCLESPSQLP01\SQL01')
insert into ServerInventoryACUL values ('CRDBTTBISQLM01\SQL01')
insert into ServerInventoryACUL values ('CRDBTTBISQLM02\SQL01')
insert into ServerInventoryACUL values ('CRASESPBIMDL01\SQL01')
insert into ServerInventoryACUL values ('CRDBTTBISQLT01\SQL01')
insert into ServerInventoryACUL values ('CRDBTTBISQLD01\SQL01')
insert into ServerInventoryACUL values ('CRASESPBIDEV01\SQL01')
insert into ServerInventoryACUL values ('CRDBTRSEPCP01')
insert into ServerInventoryACUL values ('CRDBTRSEPCD01\TST')
insert into ServerInventoryACUL values ('CRDBTRSEPCD01\DEV')
insert into ServerInventoryACUL values ('CRASDIAEPICOR03')
insert into ServerInventoryACUL values ('CRASEPCTST02\MDL01')
insert into ServerInventoryACUL values ('CRASEPCTST02\TST01')
insert into ServerInventoryACUL values ('CRASEPCTST02\DEV01')

insert into ServerInventoryACUL values ('IP-0A74482B')
insert into ServerInventoryACUL values ('IP-0A80D4DE')
insert into ServerInventoryACUL values ('IP-0A80D048')
insert into ServerInventoryACUL values ('IP-0A80D0B1')

delete from ServerInventoryACUL where SQLInstanceName = 'CRASEPCTST02\TST01'
delete from ServerInventoryACUL where SQLInstanceName = 'CRASEPCTST02\MDL01'
delete from ServerInventoryACUL where SQLInstanceName = 'CRASDIAEPICOR03'
delete from ServerInventoryACUL where SQLInstanceName = 'CRDBTRSEPCD01\DEV'
delete from ServerInventoryACUL where SQLInstanceName = 'CRDBTRSEPCD01\TST'
delete from ServerInventoryACUL where SQLInstanceName = 'CRDBTRSEPCP01'
delete from ServerInventoryACUL where SQLInstanceName = 'CRASESPBIDEV01\SQL01'
delete from ServerInventoryACUL where SQLInstanceName = 'CRASESPBIMDL01\SQL01'
delete from ServerInventoryACUL where SQLInstanceName = 'CRDBTTBISQLD01\SQL01'
delete from ServerInventoryACUL where SQLInstanceName = 'CRDBTTBISQLT01\SQL01'
delete from ServerInventoryACUL where SQLInstanceName ='CRDBTTBISQLM02\SQL01'
delete from ServerInventoryACUL where SQLInstanceName ='CRDBTTBISQLM01\SQL01'
delete from ServerInventoryACUL where SQLInstanceName ='CRCLESPSQLP01\SQL01'
delete from ServerInventoryACUL where SQLInstanceName ='CRDBTTBISQLP01\SQL01'
delete from ServerInventoryACUL
*/




SET NOCOUNT ON
-- declare vars

DECLARE @DB_Name varchar(100) 
DECLARE @Command nvarchar(4000) 
DECLARE @SQLInstanceName varchar(255)
DECLARE @SQLCmd  varchar(1000)


-- Temp tables

drop table if exists #dblist
CREATE TABLE #dblist  
   (servername VARCHAR (50), dbname VARCHAR (256), dbschcnt INT, dbsize INT, dbtblcnt INT, 
   dbsprcnt INT, dbvwcnt INT, dbindcnt INT, dbtrgcnt INT, dbgrpcnt INT, dbpricnt INT)

DROP   TABLE if exists dbo.#DatabaseDriver
CREATE TABLE #DatabaseDriver ([DBName] varchar(255))

-- Loop thur DB Instances
DECLARE ServerInventory_cursor CURSOR FOR
select SQLInstanceName
from ServerInventoryACUL

open ServerInventory_cursor
FETCH NEXT FROM ServerInventory_cursor INTO @SQLInstanceName
WHILE @@FETCH_STATUS = 0
BEGIN

		-- set up link server
		if exists(select * from sys.servers where name = N'TEMPLINKACUL')
			exec sp_dropserver 'TEMPLINKACUL'

		--------------------------------------------------------------------
		-- set up temp link to target server - this is so we can execute the queries below with EXEC <SQL> AT [TEMPLINK]
		exec master.dbo.sp_addlinkedserver @server = N'TEMPLINKACUL', @srvproduct=N'MSSQLSERVER', @provider=N'SQLNCLI', @datasrc= @SQLInstanceName
		EXEC master.dbo.sp_serveroption @server=N'TEMPLINKACUL', @optname=N'data access', @optvalue=N'true'
		EXEC master.dbo.sp_serveroption @server=N'TEMPLINKACUL', @optname=N'rpc', @optvalue=N'true'
		EXEC master.dbo.sp_serveroption @server=N'TEMPLINKACUL', @optname=N'rpc out', @optvalue=N'true'
		EXEC master.dbo.sp_serveroption @server=N'TEMPLINKACUL', @optname=N'use remote collation', @optvalue=N'true'
		EXEC master.dbo.sp_serveroption @server=N'TEMPLINKACUL', @optname=N'remote proc transaction promotion', @optvalue=N'false'

		
		delete from #DatabaseDriver
		-- get list of read/write databases from the linked server
		set @SQLCmd = 'SELECT name FROM MASTER.sys.sysdatabases where DATABASEPROPERTYEX(name, ''Updateability'') = ''READ_WRITE'' AND DATABASEPROPERTYEX(name, ''Status'') = ''ONLINE'''

		insert into #DatabaseDriver
		exec (@SQLCmd) at [TEMPLINKACUL]

		DECLARE database_cursor CURSOR FOR
		select DBName from #DatabaseDriver

		OPEN database_cursor 

		FETCH NEXT FROM database_cursor INTO @DB_Name 

		WHILE @@FETCH_STATUS = 0 
		BEGIN 
			print @SQLInstanceName + ' - ' + @DB_Name;
	if  @DB_Name = 'AGtest-Delete'
	Begin
		print 'Skipping ' + @DB_Name;
		FETCH NEXT FROM database_cursor INTO @DB_Name
		continue 
	END


set @Command = 'EXEC (''use [' + @DB_Name + '];  select @@SERVERNAME
,'''''+ @DB_Name + '''''
,(select count(*) from sys.schemas
			  where name not in (''''guest'''', ''''information_schema'''', ''''db_owner'''', ''''db_accessadmin'''', ''''db_backupoperator'''',
								''''db_datareader'''', ''''db_datawriter'''', ''''db_ddladmin'''', ''''db_denydatareader'''', 
											  ''''db_denydatawriter'''', ''''db_securityadmin''''))
,(select sum(size) from sys.database_files'+')/128
,(select count(*) from sys.objects where type = ''''U'''' )
,(select count(*) from sys.objects where type = ''''P'''' )
,(select count(*) from sys.objects where type = ''''V'''')
,(select count(*)
					 from sys.objects so join sys.indexes si on so.object_id = si.object_id
					 where so.type not in (''''IT'''', ''''S'''', ''''D'''') and si.type <> 0)
,(select count(*) from sys.triggers)
,(select count(*) from sys.database_principals where type = ''''G'''')
,(select count(*) from sys.database_principals where type <> ''''G'''')

'')  AT [TEMPLINKACUL]'


		  insert into #dblist
		  EXEC (@Command)

			 FETCH NEXT FROM database_cursor INTO @DB_Name 
		END 

		CLOSE database_cursor 
		DEALLOCATE database_cursor 

		FETCH NEXT FROM ServerInventory_cursor INTO @SQLInstanceName
END 

CLOSE ServerInventory_cursor 
DEALLOCATE ServerInventory_cursor 


SELECT        *
FROM          #dblist  


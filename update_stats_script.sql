set nocount on

declare @tick char(1)
set @tick = char(39)

declare @db_name sysname
declare @cmd varchar(5120)

create table #eligible_dbs (name sysname)

	insert into #eligible_dbs select name from master.sys.databases where lower(name) not in ('master', 'msdb', 'tempdb', 'model') and state = 0 and is_read_only = 0 and dbutils.dbo.fn_dbReplicaState(name) in ('NONE', 'PRIMARY') and not exists (select db_name from dbutils.dbo.maintenance_exclusions where upper(db_name) collate database_default = upper(name) and exclude_stats = 1) 

declare eligible_dbs cursor for 
	select name from #eligible_dbs order by name	

open eligible_dbs

fetch next from eligible_dbs into @db_name

while (@@fetch_status = 0)
begin

	set @cmd = 'use [' + @db_name + ']; exec sp_updatestats ;'

	print '---------------------------------------------'
	print 'Updating statistics on database [' + @db_name + ']'
	print '---------------------------------------------'
	exec (@cmd)

	fetch next from eligible_dbs into @db_name

end


close eligible_dbs
deallocate eligible_dbs

dbcc freeproccache 






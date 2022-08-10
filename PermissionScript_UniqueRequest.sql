CREATE TABLE #perms			
([server_name]          varchar(25),  [datb_name]            varchar(50),			
 [principal_name]       varchar(75),  [role_name]            varchar(100),			
 [scope_name]           varchar(100), [principal_type]       varchar(100), 			
 [perms]                varchar(50), )			
 DECLARE @sql varchar(1000)			
SELECT  @sql = 'USE ?; INSERT INTO #perms			
       SELECT @@servername as server_name, db_name() as datb_name, 			
	   a2.name as UserName, a.name as RoleName, ''DATABASE'' as Scope,		
	   a2.type_desc as Type, '''' as permission_name		
	   FROM sys.database_principals a join 		
	        sys.database_role_members b on a.principal_id = b.role_principal_id join		
			sys.database_principals a2 on b.member_principal_id = a2.principal_id
       UNION			
       SELECT DISTINCT @@servername as server_name, db_name() as datb_name, 			
	   a.name as UserName, '''' as RoleName, b.class_desc,		
	   a.type_desc as Type, b.permission_name		
	   FROM sys.database_principals a join 		
	        sys.database_permissions b on a.principal_id = b.grantee_principal_id		
	   WHERE a.type <> ''R'' 		
	   ORDER BY ROLENAME DESC'		
--PRINT   @sql 		 	
EXEC sp_MSforeachdb @sql 			
SELECT * FROM #perms			
WHERE datb_name not in ('master', 'tempdb', 'model', 'ssisdb') and principal_name not like ('##%')			
ORDER BY datb_name ASC, role_name DESC, principal_name ASC			
DROP TABLE #perms			

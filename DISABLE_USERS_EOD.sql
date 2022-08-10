SET	NOCOUNT	ON

-- this section ddds all logins (but exemptions) to denydatawriter and denyexecutewhereupdate

DECLARE		@UserName		NVARCHAR (128)
DECLARE		UserID			CURSOR	FAST_FORWARD	READ_ONLY
FOR
SELECT		U.name
FROM		[sys].[database_principals] U
WHERE		U.type	IN		('S', 'U', 'G')
AND			U.name	NOT IN	
				(	
				N'dbo',
				N'guest',
				N'sys',
				N'INFORMATION_SCHEMA',
				N'US\USHLATRSPegasysCR',
				N'US\USHLATRSPegasysLA',
				N'US\sptlatrscontrolm',
				N'US\sptlatrscontrolmmo',
				N'US\SVCLATRSPPCS',
				N'eodoper',
				N'US\ULARSSQLAdminDADM',
				N'MFAAuditPrd',
				N'US\luim',
				N'US\YEEJ',
				N'sugimob',
				N'US\SugimoB',
				N'xp10jky',
				N'trssqlmon',
				N'sptlatrssoa',
				N'sptlatrsplansoa',
				N'US\ALATRSDevQACMDADM',
				N'us\svclatrsmfc',
				N'xp32bms',
				N'US\DADMJERICE',
				N'TRSTOR'	
				)
AND			U.name	NOT LIKE	N'zpegasysz%'

OPEN		UserID
FETCH		UserID	INTO	@UserName

WHILE		@@FETCH_STATUS	= 0
BEGIN
	PRINT	N'Adding user ''' + @UserName + N''' to roles ''db_denydatawriter'' & ''DenyExecuteWhereUpdate'''

	EXEC	sp_addrolemember	'db_denydatawriter',		@UserName
	IF		@@ERROR	<> 0
			PRINT	N'Unable to add ''' + @UserName + ''' to role ''db_denydatawriter'', Error: ' + CAST (@@ERROR AS NVARCHAR (8))
	EXEC	sp_addrolemember	'DenyExecuteWhereUpdate',	@UserName
	IF		@@ERROR	<> 0
			PRINT	N'Unable to add ''' + @UserName + ''' to role ''DenyExecuteWhereUpdate'', Error: ' + CAST (@@Error AS NVARCHAR (8)) 

	FETCH	UserID	INTO	@UserName
END

CLOSE		UserID
DEALLOCATE	UserID

-- this section adds all logins to denydatareader and denyexecute

DECLARE		UserID		CURSOR	FAST_FORWARD	READ_ONLY
FOR
SELECT		U.name
FROM		[sys].[database_principals] U
WHERE		U.type	IN		('S', 'U', 'G')
AND			U.name	NOT IN
				(
				N'dbo',
				N'guest',
				N'sys',
				N'INFORMATION_SCHEMA',
				N'US\USHLATRSPegasysCR',
				N'US\USHLATRSPegasysLA',
				N'US\sptlatrscontrolm',
				N'US\sptlatrscontrolmmo',
				N'US\SVCLATRSPPCS',
				N'eodoper',
				N'US\SPTLATRSDOTCOM',
				N'US\SPTLATRSSOA',
				N'MFAAuditPrd',
				N'US\luim',
				N'US\YEEJ',
				N'sugimob',
				N'US\SugimoB',
				N'xp10jky',
				N'trssqlmon',
				N'trsweb',
				N'TRSTOR',
				N'sptlatrssoa',
				N'sptlatrsplansoa',
                N'US\ALATRSITInforcePEGSupport',
                N'US\ALATRSDEVCMSDADM',
				N'US\ALATRSDEVWEBDADM',
				N'US\ALATRSDEVNBEDOCSDADM',
				N'us\svclatrsmfc',
				N'US\ALATRSDevQACMDADM',
				N'US\DADMJERICE',
				N'US\ULATRSITDOCGENDEV'
				)
AND			U.name	NOT LIKE	N'zpegasysz%'

OPEN		UserID
FETCH		UserID	INTO	@UserName

WHILE		@@FETCH_STATUS	= 0
BEGIN
	PRINT	N'Adding user ''' + @UserName + N' to roles ''db_denydatareader'' & ''DenyExecute'''

	EXEC	sp_addrolemember	'db_denydatareader',	@UserName
	IF		@@ERROR	<> 0
			PRINT	N'Unable to add ''' + @UserName + ''' to role ''db_denydatareader'', Error: ' + CAST (@@ERROR AS NVARCHAR (8)) 
	EXEC	sp_addrolemember	'DenyExecute',			@UserName
	IF		@@ERROR	<> 0
			PRINT	N'Unable to add ''' + @UserName + ''' to role ''DenyExecute'', Error: ' + CAST (@@ERROR AS NVARCHAR (8)) 

	FETCH	UserID	INTO	@UserName
END

CLOSE		UserID
DEALLOCATE	UserID

-- Verify success or failure for denydatawriter

IF	EXISTS	(	SELECT				UU.[Name]
				FROM				[sys].[database_principals] R
				INNER JOIN			[sys].[database_role_members] RM	ON	R.[principal_id] = RM.[role_principal_id]
				INNER JOIN			[sys].[database_principals] U		ON	RM.[member_principal_id] = U.[principal_id]
																		AND	R.[name] = 'db_denydatawriter'
				RIGHT OUTER JOIN	[sys].[database_principals] UU		ON	U.[principal_id] = UU.[principal_id]
				WHERE				R.[name] IS NULL
				AND					UU.[type] IN		('S', 'U', 'G')
				AND UU.[name] NOT IN	
				(	
				N'dbo',
				N'guest',
				N'sys',
				N'INFORMATION_SCHEMA',
				N'US\USHLATRSPegasysCR',
				N'US\USHLATRSPegasysLA',
				N'US\sptlatrscontrolm',
				N'US\sptlatrscontrolmmo',
				N'US\SVCLATRSPPCS',
				N'eodoper',
				N'US\ULARSSQLAdminDADM',
				N'MFAAuditPrd',
				N'US\luim',
				N'US\YEEJ',
				N'sugimob',
				N'US\SugimoB',
				N'xp10jky',
				N'trssqlmon',
				N'sptlatrssoa',
				N'sptlatrsplansoa',
				N'US\ALATRSDevQACMDADM',
				N'us\svclatrsmfc',
				N'xp32bms',
				N'US\DADMJERICE',
				N'TRSTOR'
				)
				AND					UU.name	NOT LIKE		N'zpegasysz%'
			)
			RAISERROR	('Failed to completely assign role ''db_denydatawriter''', 18, 1)

-- verify succes or failure for denyexecutewhereupdate

IF	EXISTS	(	SELECT				UU.[Name]
				FROM				[sys].[database_principals] R
				INNER JOIN			[sys].[database_role_members] RM	ON	R.[principal_id] = RM.[role_principal_id]
				INNER JOIN			[sys].[database_principals] U		ON	RM.[member_principal_id] = U.[principal_id]
																		AND	R.[name] = 'DenyExecuteWhereUpdate'
				RIGHT OUTER JOIN	[sys].[database_principals] UU		ON	U.[principal_id] = UU.[principal_id]
				WHERE				R.[name] IS NULL
				AND					UU.[type] IN		('S', 'U', 'G')
				AND					UU.[name] NOT IN	
				(	
				N'dbo',
				N'guest',
				N'sys',
				N'INFORMATION_SCHEMA',
				N'US\USHLATRSPegasysCR',
				N'US\USHLATRSPegasysLA',
				N'US\sptlatrscontrolm',
				N'US\sptlatrscontrolmmo',
				N'US\SVCLATRSPPCS',
				N'eodoper',
				N'US\ULARSSQLAdminDADM',
				N'MFAAuditPrd',
				N'US\luim',
				N'US\YEEJ',
				N'sugimob',
				N'US\SugimoB',
				N'xp10jky',
				N'trssqlmon',
				N'sptlatrssoa',
				N'sptlatrsplansoa',
				N'US\ALATRSDevQACMDADM',
				N'us\svclatrsmfc',
				N'xp32bms',
				N'US\DADMJERICE',
				N'TRSTOR'
				)
				AND					UU.name	NOT LIKE		N'zpegasysz%'
			)
			RAISERROR	('Failed to completely assign role ''DenyExecuteWhereUpdate''', 18, 2)

-- verify succes or failure for denydatareader

IF	EXISTS	(	SELECT				UU.[Name]
				FROM				[sys].[database_principals] R
				INNER JOIN			[sys].[database_role_members] RM	ON	R.[principal_id] = RM.[role_principal_id]
				INNER JOIN			[sys].[database_principals] U		ON	RM.[member_principal_id] = U.[principal_id]
																		AND	R.[name] = 'db_denydatareader'
				RIGHT OUTER JOIN	[sys].[database_principals] UU		ON	U.[principal_id] = UU.[principal_id]
				WHERE				R.[name] IS NULL
				AND					UU.[type] IN		('S', 'U', 'G')
				AND					UU.[name] NOT IN	
				(	
				N'dbo',
				N'guest',
				N'sys',
				N'INFORMATION_SCHEMA',
				N'US\USHLATRSPegasysCR',
				N'US\USHLATRSPegasysLA',
				N'US\sptlatrscontrolm',
				N'US\sptlatrscontrolmmo',
				N'US\SVCLATRSPPCS',
				N'eodoper',
				N'US\SPTLATRSDOTCOM',
				N'US\SPTLATRSSOA',
				N'MFAAuditPrd',
				N'US\luim',
				N'US\YEEJ',
				N'sugimob',
				N'US\SugimoB',
				N'xp10jky',
				N'trssqlmon',
				N'trsweb',
				N'TRSTOR',
				N'US\ALATRSITInforcePEGSupport',
				N'sptlatrssoa',
				N'sptlatrsplansoa',
				N'US\ALATRSDEVCMSDADM',
				N'US\ALATRSDEVWEBDADM',
				N'US\ALATRSDEVNBEDOCSDADM',
				N'US\ALATRSDevQACMDADM',
				N'us\svclatrsmfc',
				N'US\DADMJERICE',
				N'US\ULATRSITDOCGENDEV'
				)
				AND					UU.name	NOT LIKE		N'zpegasysz%'
			)
			RAISERROR	('Failed to completely assign role ''db_denydatareader''', 18, 3)

-- verify succes or failure for denyexecute

IF	EXISTS	(	SELECT				UU.[Name]
				FROM				[sys].[database_principals] R
				INNER JOIN			[sys].[database_role_members] RM	ON	R.[principal_id] = RM.[role_principal_id]
				INNER JOIN			[sys].[database_principals] U		ON	RM.[member_principal_id] = U.[principal_id]
																		AND	R.[name] = 'DenyExecute'
				RIGHT OUTER JOIN	[sys].[database_principals] UU		ON	U.[principal_id] = UU.[principal_id]
				WHERE				R.[name] IS NULL
				AND					UU.[type] IN		('S', 'U', 'G')
				AND					UU.[name] NOT IN	
				(	
				N'dbo',
				N'guest',
				N'sys',
				N'INFORMATION_SCHEMA',
				N'US\USHLATRSPegasysCR',
				N'US\USHLATRSPegasysLA',
				N'US\sptlatrscontrolm',
				N'US\sptlatrscontrolmmo',
				N'US\SVCLATRSPPCS',
				N'eodoper',
				N'US\SPTLATRSDOTCOM',
				N'US\SPTLATRSSOA',
				N'MFAAuditPrd',
				N'US\luim',
				N'US\YEEJ',
				N'sugimob',
				N'US\SugimoB',
				N'xp10jky',
				N'trssqlmon',
				N'trsweb',
				N'TRSTOR',
				N'US\ALATRSITInforcePEGSupport',
				N'sptlatrssoa',
				N'sptlatrsplansoa',
				N'US\ALATRSDEVCMSDADM',
				N'US\ALATRSDEVWEBDADM',
				N'US\ALATRSDEVNBEDOCSDADM',
				N'US\ALATRSDevQACMDADM',
				N'us\svclatrsmfc',
				N'US\DADMJERICE',
				N'US\ULATRSITDOCGENDEV'
				)
				AND					UU.name	NOT LIKE		N'zpegasysz%'
			)
			RAISERROR	('Failed to completely assign role ''DenyExecute''', 18, 4)

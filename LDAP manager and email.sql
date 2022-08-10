 DECLARE @DBUserAcct    nvarchar(128)					
DECLARE @ManagerPath   nvarchar(128),@ManagerName   nvarchar(50)	,@emailaddress nvarchar(128)				
DECLARE @DBUserQuery   nvarchar(400),@ManagerQuery  nvarchar(500)					
DECLARE @temppath Table(ManagerPath nvarchar(128),Mail nvarchar(128))					
DECLARE @tempname Table(ManagerName nvarchar(128))					
DECLARE @tempcn   Table(TempCN nvarchar(128))					
DECLARE @templong nvarchar(128)					
DECLARE @dbtype   nvarchar(50)	
 
 set @DBUserAcct = 'aculross'

      PRINT '------------'					
	  PRINT @DBUserAcct				
      SET   @DBUserQuery = 'SELECT manager,mail FROM OPENQUERY(ADSI,'					
                    + '''SELECT sAMAccountname,manager,CN,mail FROM '''					
                    + '''LDAP://DC=US,DC=AEGON,DC=com'''					
                    + ''' WHERE sAmAccountname='''					
                    + '''' + @DBUserAcct + ''''''')'					
      PRINT   @DBUserQuery					
      DELETE  @temppath					
      INSERT  @temppath EXEC(@DBUserQuery)
	  --EXEC(@DBUserQuery)					
      SELECT  @ManagerPath=ManagerPath,@emailaddress=mail FROM @temppath	
	  print @ManagerPath
	  print @emailaddress
	  
	  				
      SET     @ManagerPath='LDAP://' + '' + @ManagerPath + ''					
      --      FIX manager path for apostrophe in name					
	  SET     @ManagerPath=REPLACE (@ManagerPath, '''','''''''''') 				
	        PRINT   'Manager Path(2): ' + @ManagerPath				
      SET     @ManagerQuery = 'SELECT CN FROM OPENQUERY(ADSI,'					
                    + '''SELECT CN, ADsPath FROM ''''' + @ManagerPath + ''''''') WHERE CN is NOT NULL'					
      --      @ManagerQuery					
	  DELETE  @tempname				
      SET     @ManagerName='Undefined'					
      IF      @ManagerPath <> 'LDAP://' and CHARINDEX('OU=AGTE',@ManagerQuery) = 0 and CHARINDEX('NV',@ManagerQuery) = 0					
              BEGIN					
              INSERT  @tempname EXEC(@ManagerQuery)	
			  EXEC(@ManagerQuery)				
              SELECT  @ManagerName=ManagerName FROM @tempname					
              END					
  					
        -- UPDATE The CN for each user.					
      --SET  @DBUserQuery = 'SELECT CN FROM OPENQUERY(ADSI,'					
      --              + '''SELECT sAMAccountname,manager,CN FROM '''					
      --              + '''LDAP://DC=US,DC=AEGON,DC=com'''					
      --              + ''' WHERE sAmAccountname='''					
       --             + '''' + @DBUserAcct + ''''''')'					
      --PRINT   @DBUserQuery					
      --DELETE  @tempcn		
	  
	  print @ManagerName
	  print @emailaddress
	  			
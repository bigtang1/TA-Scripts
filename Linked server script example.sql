Source SQL                         Link Name           Target SQL

CRDBTTRPLD01\SQL01   TRSSQL01            CRDBTRSD01\TRSSQL01_DEV
CRDBTTRPLT01\SQL01    TRSSQL01            CRDBTRSTST02\TRSSQL01_TST1
CRDBTTRPLM01\SQL01  TRSSQL01            CRDBTRSD01\TRSSQL01_MDL
CRDBTTRPLP01\SQL01   TRSSQL01            TRSSQL01HAL

-- DEV
EXEC master.dbo.sp_addlinkedserver @server = N'TRSSQL01', @provider=N'SQLNCLI', @srvproduct=N'MSSQLSERVER', @datasrc=N'CRDBTRSD01\TRSSQL01_DEV'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'TRSSQL01',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'collation compatible', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'data access', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'dist', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'pub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'rpc', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'rpc out', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'sub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'connect timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'collation name', @optvalue=null
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'lazy schema validation', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'query timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'use remote collation', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'remote proc transaction promotion', @optvalue=N'false'
GO

-- TEST
EXEC master.dbo.sp_addlinkedserver @server = N'TRSSQL01', @provider=N'SQLNCLI', @srvproduct=N'MSSQLSERVER', @datasrc=N'CRDBTRSTST02\TRSSQL01_TST1'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'TRSSQL01',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'collation compatible', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'data access', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'dist', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'pub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'rpc', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'rpc out', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'sub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'connect timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'collation name', @optvalue=null
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'lazy schema validation', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'query timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'use remote collation', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'remote proc transaction promotion', @optvalue=N'false'
GO

-- MODEL
EXEC master.dbo.sp_addlinkedserver @server = N'TRSSQL01', @provider=N'SQLNCLI', @srvproduct=N'MSSQLSERVER', @datasrc=N'CRDBTRSD01\TRSSQL01_MDL'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'TRSSQL01',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'collation compatible', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'data access', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'dist', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'pub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'rpc', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'rpc out', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'sub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'connect timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'collation name', @optvalue=null
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'lazy schema validation', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'query timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'use remote collation', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'remote proc transaction promotion', @optvalue=N'false'
GO

-- PROD
EXEC master.dbo.sp_addlinkedserver @server = N'TRSSQL01', @provider=N'SQLNCLI', @srvproduct=N'MSSQLSERVER', @datasrc=N'TRSSQL01HAL'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'TRSSQL01',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'collation compatible', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'data access', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'dist', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'pub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'rpc', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'rpc out', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'sub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'connect timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'collation name', @optvalue=null
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'lazy schema validation', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'query timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'use remote collation', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'TRSSQL01', @optname=N'remote proc transaction promotion', @optvalue=N'false'
GO


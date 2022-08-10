USE Accounting_Adhoc
GO
/* Creating Login information 
** Generated Jun 17 2021 10:04AM on CRDBTTBISQLP03\SQL01 */


-- Login: US\evarga
if not exists(select * from master.sys.server_principals where name = 'US\evarga')       begin       CREATE LOGIN [US\evarga] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\sptbittproxy
if not exists(select * from master.sys.server_principals where name = 'US\sptbittproxy')       begin       CREATE LOGIN [US\sptbittproxy] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\sptwpctrlm0prd
if not exists(select * from master.sys.server_principals where name = 'US\sptwpctrlm0prd')       begin       CREATE LOGIN [US\sptwpctrlm0prd] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\ulaespbiadmindev
if not exists(select * from master.sys.server_principals where name = 'US\ulaespbiadmindev')       begin       CREATE LOGIN [US\ulaespbiadmindev] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\ULATRSFinancialFAcct
if not exists(select * from master.sys.server_principals where name = 'US\ULATRSFinancialFAcct')       begin       CREATE LOGIN [US\ULATRSFinancialFAcct] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\ULTCLPBIDev
if not exists(select * from master.sys.server_principals where name = 'US\ULTCLPBIDev')       begin       CREATE LOGIN [US\ULTCLPBIDev] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end
/* Creating Database Roles*/
if not exists (select 1 from  Accounting_Adhoc.sys.database_principals where type ='R' and name='role_CONVERTEDCASEEM')  create role [role_CONVERTEDCASEEM];
/* GRANTING PERMISSIONS TO DATABASE*/
IF NOT EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\evarga')       BEGIN        IF EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals WHERE NAME ='US\evarga')        DROP USER [US\evarga]        CREATE USER [US\evarga] FOR LOGIN [US\evarga] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptbittproxy')       BEGIN        IF EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals WHERE NAME ='US\sptbittproxy')        DROP USER [US\sptbittproxy]        CREATE USER [US\sptbittproxy] FOR LOGIN [US\sptbittproxy] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptwpctrlm0prd')       BEGIN        IF EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals WHERE NAME ='US\sptwpctrlm0prd')        DROP USER [US\sptwpctrlm0prd]        CREATE USER [US\sptwpctrlm0prd] FOR LOGIN [US\sptwpctrlm0prd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ulaespbiadmindev')       BEGIN        IF EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals WHERE NAME ='US\ulaespbiadmindev')        DROP USER [US\ulaespbiadmindev]        CREATE USER [US\ulaespbiadmindev] FOR LOGIN [US\ulaespbiadmindev] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ULATRSFinancialFAcct')       BEGIN        IF EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals WHERE NAME ='US\ULATRSFinancialFAcct')        DROP USER [US\ULATRSFinancialFAcct]        CREATE USER [US\ULATRSFinancialFAcct] FOR LOGIN [US\ULATRSFinancialFAcct] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ULTCLPBIDEV')       BEGIN        IF EXISTS (SELECT 1 FROM [Accounting_Adhoc].SYS.database_principals WHERE NAME ='US\ULTCLPBIDEV')        DROP USER [US\ULTCLPBIDEV]        CREATE USER [US\ULTCLPBIDEV] FOR LOGIN [US\ULTCLPBIDEV] WITH DEFAULT_SCHEMA = dbo       END
exec sp_addrolemember 'db_accessadmin','US\sptwpctrlm0prd';
exec sp_addrolemember 'db_datareader','US\evarga';
exec sp_addrolemember 'db_datareader','US\sptwpctrlm0prd';
exec sp_addrolemember 'db_datareader','US\ulaespbiadmindev';
exec sp_addrolemember 'db_datareader','US\ULTCLPBIDEV';
exec sp_addrolemember 'db_datawriter','US\sptwpctrlm0prd';
exec sp_addrolemember 'db_ddladmin','US\sptwpctrlm0prd';
exec sp_addrolemember 'db_owner','US\sptbittproxy';
exec sp_addrolemember 'db_owner','US\sptwpctrlm0prd';
exec sp_addrolemember 'db_securityadmin','US\sptwpctrlm0prd';
exec sp_addrolemember 'role_CONVERTEDCASEEM','US\ULATRSFinancialFAcct';
/* GRANTING DBROLE PERMISSIONS*/
GRANT  CONNECT ON DATABASE::Accounting_Adhoc TO [dbo]
GRANT  CONNECT ON DATABASE::Accounting_Adhoc TO [US\evarga]
GRANT  CONNECT ON DATABASE::Accounting_Adhoc TO [US\sptbittproxy]
GRANT  CONNECT ON DATABASE::Accounting_Adhoc TO [US\sptwpctrlm0prd]
GRANT  CONNECT ON DATABASE::Accounting_Adhoc TO [US\ulaespbiadmindev]
GRANT  CONNECT ON DATABASE::Accounting_Adhoc TO [US\ULATRSFinancialFAcct]
GRANT  CONNECT ON DATABASE::Accounting_Adhoc TO [US\ULTCLPBIDEV]
GRANT  EXECUTE ON DATABASE::Accounting_Adhoc TO [US\sptwpctrlm0prd]
GRANT  SELECT ON SCHEMA::dbo TO [role_CONVERTEDCASEEM]
GRANT  VIEW ANY COLUMN ENCRYPTION KEY DEFINITION ON DATABASE::Accounting_Adhoc TO [public]
GRANT  VIEW ANY COLUMN MASTER KEY DEFINITION ON DATABASE::Accounting_Adhoc TO [public]
USE WorkplaceExperience
GO
/* Creating Login information 
** Generated Jun 17 2021  9:54AM on CRDBTTBISQLP03\SQL01 */


-- Login: exawsprd
if not exists(select * from master.sys.server_principals where name ='exawsprd')      begin       CREATE LOGIN [exawsprd] WITH PASSWORD = 0x02005AC1DDBB6610F250DAE1D01E810AA051A8394A6DB370BA35316704B479D01819297A8DE26D6CCB0FD261C77DCEDDC4E0F800B43ADA7B7E8ADC5DE0E44540EC7C1EAD3E48 HASHED, SID = 0xDD06ACA9F6ADA747B6A172682B390559, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: sptInformEx
if not exists(select * from master.sys.server_principals where name ='sptInformEx')      begin       CREATE LOGIN [sptInformEx] WITH PASSWORD = 0x02008E06212BAFA3EDF3569B43D45014F0311188DBA658366CA8BF14E0B989B3B8CCB2F77DA75B5435639A7ABA8CBC57C0144D53C2EA9410144707EF613C304FAA14807E01AA HASHED, SID = 0x0B4E2E13B8B42C45AF5ECF3C2A1CE313, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: sptwxprod
if not exists(select * from master.sys.server_principals where name ='sptwxprod')      begin       CREATE LOGIN [sptwxprod] WITH PASSWORD = 0x02008FB3357825DBBC52D88226D558A876B00FC851008A969567E653D1A7F82DB126FAE59944CDCD83E19D813265D5D2D826EF6A2B02484696DD214635CF986FBB501CAC3364 HASHED, SID = 0x441397826482B84C90A99BCB658A7959, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: US\sptbittproxy
if not exists(select * from master.sys.server_principals where name = 'US\sptbittproxy')       begin       CREATE LOGIN [US\sptbittproxy] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\sptwpctrlm0prd
if not exists(select * from master.sys.server_principals where name = 'US\sptwpctrlm0prd')       begin       CREATE LOGIN [US\sptwpctrlm0prd] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svccrdbttbisasp02
if not exists(select * from master.sys.server_principals where name = 'US\svccrdbttbisasp02')       begin       CREATE LOGIN [US\svccrdbttbisasp02] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svccrdbttexsasp01
if not exists(select * from master.sys.server_principals where name = 'US\svccrdbttexsasp01')       begin       CREATE LOGIN [US\svccrdbttexsasp01] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svccrdbttexsasp03
if not exists(select * from master.sys.server_principals where name = 'US\svccrdbttexsasp03')       begin       CREATE LOGIN [US\svccrdbttexsasp03] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\ulaespbiadmindev
if not exists(select * from master.sys.server_principals where name = 'US\ulaespbiadmindev')       begin       CREATE LOGIN [US\ulaespbiadmindev] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUTATECHEXDEV
if not exists(select * from master.sys.server_principals where name = 'US\XUTATECHEXDEV')       begin       CREATE LOGIN [US\XUTATECHEXDEV] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUTATECHWORKPLACEDATAENGTEAM
if not exists(select * from master.sys.server_principals where name = 'US\XUTATECHWORKPLACEDATAENGTEAM')       begin       CREATE LOGIN [US\XUTATECHWORKPLACEDATAENGTEAM] FROM WINDOWS WITH DEFAULT_DATABASE = [WorkplaceExperience]       end
/* Creating Database Roles*/
if not exists (select 1 from  WorkplaceExperience.sys.database_principals where type ='R' and name='wex_userrole')  create role [wex_userrole];
if not exists (select 1 from  WorkplaceExperience.sys.database_principals where type ='R' and name='ref_updaterole')  create role [ref_updaterole];
if not exists (select 1 from  WorkplaceExperience.sys.database_principals where type ='R' and name='wex_supportrole')  create role [wex_supportrole];
/* GRANTING PERMISSIONS TO DATABASE*/
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'exawsprd')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='exawsprd')        DROP USER [exawsprd]        CREATE USER [exawsprd] FOR LOGIN [exawsprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'extest')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='extest')        DROP USER [extest]        CREATE USER [extest] FOR LOGIN [extest] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'sptInformEx')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='sptInformEx')        DROP USER [sptInformEx]        CREATE USER [sptInformEx] FOR LOGIN [sptInformEx] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'sptwxprod')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='sptwxprod')        DROP USER [sptwxprod]        CREATE USER [sptwxprod] FOR LOGIN [sptwxprod] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptbittproxy')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='US\sptbittproxy')        DROP USER [US\sptbittproxy]        CREATE USER [US\sptbittproxy] FOR LOGIN [US\sptbittproxy] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptwpctrlm0prd')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='US\sptwpctrlm0prd')        DROP USER [US\sptwpctrlm0prd]        CREATE USER [US\sptwpctrlm0prd] FOR LOGIN [US\sptwpctrlm0prd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svccrdbttbisasp02')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='US\svccrdbttbisasp02')        DROP USER [US\svccrdbttbisasp02]        CREATE USER [US\svccrdbttbisasp02] FOR LOGIN [US\svccrdbttbisasp02] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svccrdbttexsasp01')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='US\svccrdbttexsasp01')        DROP USER [US\svccrdbttexsasp01]        CREATE USER [US\svccrdbttexsasp01] FOR LOGIN [US\svccrdbttexsasp01] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svccrdbttexsasp03')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='US\svccrdbttexsasp03')        DROP USER [US\svccrdbttexsasp03]        CREATE USER [US\svccrdbttexsasp03] FOR LOGIN [US\svccrdbttexsasp03] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ulaespbiadmindev')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='US\ulaespbiadmindev')        DROP USER [US\ulaespbiadmindev]        CREATE USER [US\ulaespbiadmindev] FOR LOGIN [US\ulaespbiadmindev] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUTATECHEXDEV')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='US\XUTATECHEXDEV')        DROP USER [US\XUTATECHEXDEV]        CREATE USER [US\XUTATECHEXDEV] FOR LOGIN [US\XUTATECHEXDEV] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUTATECHWORKPLACEDATAENGTEAM')       BEGIN        IF EXISTS (SELECT 1 FROM [WorkplaceExperience].SYS.database_principals WHERE NAME ='US\XUTATECHWORKPLACEDATAENGTEAM')        DROP USER [US\XUTATECHWORKPLACEDATAENGTEAM]        CREATE USER [US\XUTATECHWORKPLACEDATAENGTEAM] FOR LOGIN [US\XUTATECHWORKPLACEDATAENGTEAM] WITH DEFAULT_SCHEMA = dbo       END
exec sp_addrolemember 'db_datareader','US\svccrdbttbisasp02';
exec sp_addrolemember 'db_datareader','US\svccrdbttexsasp01';
exec sp_addrolemember 'db_datareader','US\svccrdbttexsasp03';
exec sp_addrolemember 'db_datareader','US\ulaespbiadmindev';
exec sp_addrolemember 'db_datareader','US\XUTATECHEXDEV';
exec sp_addrolemember 'db_datareader','US\XUTATECHWORKPLACEDATAENGTEAM';
exec sp_addrolemember 'db_owner','US\sptbittproxy';
exec sp_addrolemember 'db_owner','US\sptwpctrlm0prd';
exec sp_addrolemember 'ref_updaterole','sptInformEx';
exec sp_addrolemember 'wex_supportrole','sptwxprod';
exec sp_addrolemember 'wex_userrole','exawsprd';
exec sp_addrolemember 'wex_userrole','extest';
exec sp_addrolemember 'wex_userrole','US\ulaespbiadmindev';
exec sp_addrolemember 'wex_userrole','US\XUTATECHEXDEV';
exec sp_addrolemember 'wex_userrole','US\XUTATECHWORKPLACEDATAENGTEAM';
/* GRANTING DBROLE PERMISSIONS*/
GRANT  ALTER ON SCHEMA::ref TO [wex_supportrole]
GRANT  ALTER ON SCHEMA::wxstg TO [wex_supportrole]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [dbo]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [exawsprd]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [extest]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [sptInformEx]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [sptwxprod]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [US\sptbittproxy]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [US\sptwpctrlm0prd]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [US\svccrdbttbisasp02]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [US\svccrdbttexsasp01]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [US\svccrdbttexsasp03]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [US\ulaespbiadmindev]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [US\XUTATECHEXDEV]
GRANT  CONNECT ON DATABASE::WorkplaceExperience TO [US\XUTATECHWORKPLACEDATAENGTEAM]
GRANT  DELETE ON SCHEMA::ref TO [ref_updaterole]
GRANT  DELETE ON SCHEMA::ref TO [wex_supportrole]
GRANT  EXECUTE ON SCHEMA::ex TO [exawsprd]
GRANT  EXECUTE ON SCHEMA::ex TO [wex_supportrole]
GRANT  EXECUTE ON SCHEMA::wxstg TO [wex_supportrole]
GRANT  EXECUTE ON SCHEMA::dbo TO [wex_userrole]
GRANT  EXECUTE ON SCHEMA::ex TO [wex_userrole]
GRANT  INSERT ON SCHEMA::ref TO [ref_updaterole]
GRANT  INSERT ON SCHEMA::ref TO [wex_supportrole]
GRANT  INSERT ON SCHEMA::wxstg TO [wex_supportrole]
GRANT SELECT ON OBJECT::dbo.ExCycleLog TO [sptwxprod]
GRANT  SELECT ON SCHEMA::ex TO [exawsprd]
GRANT  SELECT ON SCHEMA::ref TO [ref_updaterole]
GRANT  SELECT ON SCHEMA::ex TO [wex_supportrole]
GRANT  SELECT ON SCHEMA::ref TO [wex_supportrole]
GRANT  SELECT ON SCHEMA::wxstg TO [wex_supportrole]
GRANT  SELECT ON SCHEMA::temp TO [wex_supportrole]
GRANT  SELECT ON SCHEMA::dbo TO [wex_userrole]
GRANT  SELECT ON SCHEMA::ex TO [wex_userrole]
GRANT  UPDATE ON SCHEMA::ref TO [ref_updaterole]
GRANT  UPDATE ON SCHEMA::ref TO [wex_supportrole]
GRANT  VIEW ANY COLUMN ENCRYPTION KEY DEFINITION ON DATABASE::WorkplaceExperience TO [public]
GRANT  VIEW ANY COLUMN MASTER KEY DEFINITION ON DATABASE::WorkplaceExperience TO [public]
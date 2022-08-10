USE TRS_BI_Staging
GO
/* Creating Login information 
** Generated Jun 17 2021  9:53AM on CRDBTTBISQLP03\SQL01 */


-- Login: infttdengprd
if not exists(select * from master.sys.server_principals where name ='infttdengprd')      begin       CREATE LOGIN [infttdengprd] WITH PASSWORD = 0x02009DA983383E458EEF4D8EB30BC97F264EE9F35F8CACAC0658FE0E394A1BA005B6D66EFA61C24862A13824014CCFF4A0A0034C88095974EF71D78D7874009706F0A7B00227 HASHED, SID = 0x93B45239CDD41A45B46BB85BC52D5591, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: MDLScheduler
if not exists(select * from master.sys.server_principals where name ='MDLScheduler')      begin       CREATE LOGIN [MDLScheduler] WITH PASSWORD = 0x0200F2484D6F1C7F45BA2BFED3FB3D65B90D35AA3AECE3805EDA7550C85C4611EA6785BDED4F873794B381CDBF7E7FEAC7A86EBB88984AB36D408745F3D16584FAA03D68219C HASHED, SID = 0x53BE6A7FCD271F4BB4A042F27279CF78, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: sptmdldwlink
if not exists(select * from master.sys.server_principals where name ='sptmdldwlink')      begin       CREATE LOGIN [sptmdldwlink] WITH PASSWORD = 0x0200D83AACC1FAC2F13D4C27F9052D5856367164A51329810101838AC2D8D436D7E17A2467D8E241E5DF31423A16CC6A393724BE3CF9A9E14A481EA0C993E7BF732914981220 HASHED, SID = 0x8597BDB5987DBA4292726CAF7F0B7FC8, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: trsbidwprod
if not exists(select * from master.sys.server_principals where name ='trsbidwprod')      begin       CREATE LOGIN [trsbidwprod] WITH PASSWORD = 0x0200110039412B775B3EBF4C47BC3F5412922BD960ABD266EBBEA6D58F1416AE6E2FAE59D423AEF662D0CA13E205EFE99FB5C96ED92CECB3B66698B65ADAFF898C6D8C280A46 HASHED, SID = 0x2BFE6699837A6E4DB26AF4BE55AB8F74, DEFAULT_DATABASE = [TRS_BI_Datawarehouse], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: trsbiwebprd
if not exists(select * from master.sys.server_principals where name ='trsbiwebprd')      begin       CREATE LOGIN [trsbiwebprd] WITH PASSWORD = 0x02009494551C7F97EE0BC2D5EEF5C5067F61DE71120D52609AC9EFD809925DF2F9A4824E2BDBEF13ED055137FA5702FDB08DA0201D3BF13BD284CA8501FB6017E44F54EE4349 HASHED, SID = 0x3D4E5BC37832B44AB43716575F46F3DD, DEFAULT_DATABASE = [TRS_BI_Datawarehouse], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: US\ALATRSCNTRLMOps
if not exists(select * from master.sys.server_principals where name = 'US\ALATRSCNTRLMOps')       begin       CREATE LOGIN [US\ALATRSCNTRLMOps] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\ankopalidis
if not exists(select * from master.sys.server_principals where name = 'US\ankopalidis')       begin       CREATE LOGIN [US\ankopalidis] FROM WINDOWS WITH DEFAULT_DATABASE = [TRS_BI_Staging]       end

-- Login: US\dsingh
if not exists(select * from master.sys.server_principals where name = 'US\dsingh')       begin       CREATE LOGIN [US\dsingh] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\jbeck
if not exists(select * from master.sys.server_principals where name = 'US\jbeck')       begin       CREATE LOGIN [US\jbeck] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\sptbittproxy
if not exists(select * from master.sys.server_principals where name = 'US\sptbittproxy')       begin       CREATE LOGIN [US\sptbittproxy] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\sptlatrsbiproxy
if not exists(select * from master.sys.server_principals where name = 'US\sptlatrsbiproxy')       begin       CREATE LOGIN [US\sptlatrsbiproxy] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\spttasqlnonprod
if not exists(select * from master.sys.server_principals where name = 'US\spttasqlnonprod')       begin       CREATE LOGIN [US\spttasqlnonprod] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\sptwpctrlm0prd
if not exists(select * from master.sys.server_principals where name = 'US\sptwpctrlm0prd')       begin       CREATE LOGIN [US\sptwpctrlm0prd] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svccrdbttbisasp02
if not exists(select * from master.sys.server_principals where name = 'US\svccrdbttbisasp02')       begin       CREATE LOGIN [US\svccrdbttbisasp02] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svccrdbttbisqlm01
if not exists(select * from master.sys.server_principals where name = 'US\svccrdbttbisqlm01')       begin       CREATE LOGIN [US\svccrdbttbisqlm01] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svcltcsql
if not exists(select * from master.sys.server_principals where name = 'US\svcltcsql')       begin       CREATE LOGIN [US\svcltcsql] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svctcmbiadatabase
if not exists(select * from master.sys.server_principals where name = 'US\svctcmbiadatabase')       begin       CREATE LOGIN [US\svctcmbiadatabase] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svctcmtableau
if not exists(select * from master.sys.server_principals where name = 'US\svctcmtableau')       begin       CREATE LOGIN [US\svctcmtableau] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\ulaespbiadmindev
if not exists(select * from master.sys.server_principals where name = 'US\ulaespbiadmindev')       begin       CREATE LOGIN [US\ulaespbiadmindev] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XACRTCMBusIntelAnalyAdmin
if not exists(select * from master.sys.server_principals where name = 'US\XACRTCMBusIntelAnalyAdmin')       begin       CREATE LOGIN [US\XACRTCMBusIntelAnalyAdmin] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XDTTRDMReadContractors
if not exists(select * from master.sys.server_principals where name = 'US\XDTTRDMReadContractors')       begin       CREATE LOGIN [US\XDTTRDMReadContractors] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUESPBIRPTAccess
if not exists(select * from master.sys.server_principals where name = 'US\XUESPBIRPTAccess')       begin       CREATE LOGIN [US\XUESPBIRPTAccess] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUESPBIRPTAccessDWRO
if not exists(select * from master.sys.server_principals where name = 'US\XUESPBIRPTAccessDWRO')       begin       CREATE LOGIN [US\XUESPBIRPTAccessDWRO] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUESPBIRPTAccessTST
if not exists(select * from master.sys.server_principals where name = 'US\XUESPBIRPTAccessTST')       begin       CREATE LOGIN [US\XUESPBIRPTAccessTST] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUTAAdvCtrBusAnalytics
if not exists(select * from master.sys.server_principals where name = 'US\XUTAAdvCtrBusAnalytics')       begin       CREATE LOGIN [US\XUTAAdvCtrBusAnalytics] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUTATECHWORKPLACEDATAENGTEAM
if not exists(select * from master.sys.server_principals where name = 'US\XUTATECHWORKPLACEDATAENGTEAM')       begin       CREATE LOGIN [US\XUTATECHWORKPLACEDATAENGTEAM] FROM WINDOWS WITH DEFAULT_DATABASE = [WorkplaceExperience]       end
/* Creating Database Roles*/
if not exists (select 1 from  TRS_BI_Staging.sys.database_principals where type ='R' and name='tempCreate')  create role [tempCreate];
if not exists (select 1 from  TRS_BI_Staging.sys.database_principals where type ='R' and name='UserView_Role')  create role [UserView_Role];
if not exists (select 1 from  TRS_BI_Staging.sys.database_principals where type ='R' and name='AWS_Role')  create role [AWS_Role];
if not exists (select 1 from  TRS_BI_Staging.sys.database_principals where type ='R' and name='RestrictedView_Role')  create role [RestrictedView_Role];
if not exists (select 1 from  TRS_BI_Staging.sys.database_principals where type ='R' and name='PiiView_Role')  create role [PiiView_Role];
if not exists (select 1 from  TRS_BI_Staging.sys.database_principals where type ='R' and name='DWLogReader')  create role [DWLogReader];
/* GRANTING PERMISSIONS TO DATABASE*/
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'infttdengprd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='infttdengprd')        DROP USER [infttdengprd]        CREATE USER [infttdengprd] FOR LOGIN [infttdengprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'MDLScheduler')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='MDLScheduler')        DROP USER [MDLScheduler]        CREATE USER [MDLScheduler] FOR LOGIN [MDLScheduler] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'sptmdldwlink')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='sptmdldwlink')        DROP USER [sptmdldwlink]        CREATE USER [sptmdldwlink] FOR LOGIN [sptmdldwlink] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'trsbidwprod')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='trsbidwprod')        DROP USER [trsbidwprod]        CREATE USER [trsbidwprod] FOR LOGIN [trsbidwprod] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'trsbiwebprd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='trsbiwebprd')        DROP USER [trsbiwebprd]        CREATE USER [trsbiwebprd] FOR LOGIN [trsbiwebprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ALATRSCNTRLMOps')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\ALATRSCNTRLMOps')        DROP USER [US\ALATRSCNTRLMOps]        CREATE USER [US\ALATRSCNTRLMOps] FOR LOGIN [US\ALATRSCNTRLMOps] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ankopalidis')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\ankopalidis')        DROP USER [US\ankopalidis]        CREATE USER [US\ankopalidis] FOR LOGIN [US\ankopalidis] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\dsingh')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\dsingh')        DROP USER [US\dsingh]        CREATE USER [US\dsingh] FOR LOGIN [US\dsingh] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\jbeck')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\jbeck')        DROP USER [US\jbeck]        CREATE USER [US\jbeck] FOR LOGIN [US\jbeck] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptbittproxy')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\sptbittproxy')        DROP USER [US\sptbittproxy]        CREATE USER [US\sptbittproxy] FOR LOGIN [US\sptbittproxy] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptlatrsbiproxy')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\sptlatrsbiproxy')        DROP USER [US\sptlatrsbiproxy]        CREATE USER [US\sptlatrsbiproxy] FOR LOGIN [US\sptlatrsbiproxy] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\spttasqlnonprod')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\spttasqlnonprod')        DROP USER [US\spttasqlnonprod]        CREATE USER [US\spttasqlnonprod] FOR LOGIN [US\spttasqlnonprod] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptwpctrlm0prd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\sptwpctrlm0prd')        DROP USER [US\sptwpctrlm0prd]        CREATE USER [US\sptwpctrlm0prd] FOR LOGIN [US\sptwpctrlm0prd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svccrdbttbisasp02')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\svccrdbttbisasp02')        DROP USER [US\svccrdbttbisasp02]        CREATE USER [US\svccrdbttbisasp02] FOR LOGIN [US\svccrdbttbisasp02] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svccrdbttbisqlm01')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\svccrdbttbisqlm01')        DROP USER [US\svccrdbttbisqlm01]        CREATE USER [US\svccrdbttbisqlm01] FOR LOGIN [US\svccrdbttbisqlm01] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svcltcsql')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\svcltcsql')        DROP USER [US\svcltcsql]        CREATE USER [US\svcltcsql] FOR LOGIN [US\svcltcsql] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svctcmbiadatabase')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\svctcmbiadatabase')        DROP USER [US\svctcmbiadatabase]        CREATE USER [US\svctcmbiadatabase] FOR LOGIN [US\svctcmbiadatabase] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svctcmtableau')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\svctcmtableau')        DROP USER [US\svctcmtableau]        CREATE USER [US\svctcmtableau] FOR LOGIN [US\svctcmtableau] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ULAESPBIAdminDEV')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\ULAESPBIAdminDEV')        DROP USER [US\ULAESPBIAdminDEV]        CREATE USER [US\ULAESPBIAdminDEV] FOR LOGIN [US\ULAESPBIAdminDEV] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XACRTCMBusIntelAnalyAdmin')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\XACRTCMBusIntelAnalyAdmin')        DROP USER [US\XACRTCMBusIntelAnalyAdmin]        CREATE USER [US\XACRTCMBusIntelAnalyAdmin] FOR LOGIN [US\XACRTCMBusIntelAnalyAdmin] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XDTTRDMReadContractors')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\XDTTRDMReadContractors')        DROP USER [US\XDTTRDMReadContractors]        CREATE USER [US\XDTTRDMReadContractors] FOR LOGIN [US\XDTTRDMReadContractors] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUESPBIRPTAccess')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\XUESPBIRPTAccess')        DROP USER [US\XUESPBIRPTAccess]        CREATE USER [US\XUESPBIRPTAccess] FOR LOGIN [US\XUESPBIRPTAccess] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUESPBIRPTAccessDWRO')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\XUESPBIRPTAccessDWRO')        DROP USER [US\XUESPBIRPTAccessDWRO]        CREATE USER [US\XUESPBIRPTAccessDWRO] FOR LOGIN [US\XUESPBIRPTAccessDWRO] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUESPBIRPTAccessTST')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\XUESPBIRPTAccessTST')        DROP USER [US\XUESPBIRPTAccessTST]        CREATE USER [US\XUESPBIRPTAccessTST] FOR LOGIN [US\XUESPBIRPTAccessTST] WITH DEFAULT_SCHEMA = usr       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUTAAdvCtrBusAnalytics')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\XUTAAdvCtrBusAnalytics')        DROP USER [US\XUTAAdvCtrBusAnalytics]        CREATE USER [US\XUTAAdvCtrBusAnalytics] FOR LOGIN [US\XUTAAdvCtrBusAnalytics] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUTATECHWORKPLACEDATAENGTEAM')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Staging].SYS.database_principals WHERE NAME ='US\XUTATECHWORKPLACEDATAENGTEAM')        DROP USER [US\XUTATECHWORKPLACEDATAENGTEAM]        CREATE USER [US\XUTATECHWORKPLACEDATAENGTEAM] FOR LOGIN [US\XUTATECHWORKPLACEDATAENGTEAM] WITH DEFAULT_SCHEMA = dbo       END
exec sp_addrolemember 'AWS_Role','US\dsingh';
exec sp_addrolemember 'AWS_Role','US\XUESPBIRPTAccessDWRO';
exec sp_addrolemember 'db_datareader','trsbidwprod';
exec sp_addrolemember 'db_datareader','trsbiwebprd';
exec sp_addrolemember 'db_datareader','US\ALATRSCNTRLMOps';
exec sp_addrolemember 'db_datareader','US\svccrdbttbisasp02';
exec sp_addrolemember 'db_datareader','US\svctcmbiadatabase';
exec sp_addrolemember 'db_datareader','US\ULAESPBIAdminDEV';
exec sp_addrolemember 'db_datareader','US\XACRTCMBusIntelAnalyAdmin';
exec sp_addrolemember 'db_datareader','US\XDTTRDMReadContractors';
exec sp_addrolemember 'db_datareader','US\XUTAAdvCtrBusAnalytics';
exec sp_addrolemember 'db_datareader','US\XUTATECHWORKPLACEDATAENGTEAM';
exec sp_addrolemember 'db_owner','US\sptbittproxy';
exec sp_addrolemember 'db_owner','US\sptlatrsbiproxy';
exec sp_addrolemember 'db_owner','US\sptwpctrlm0prd';
exec sp_addrolemember 'DWLogReader','US\ankopalidis';
exec sp_addrolemember 'DWLogReader','US\svctcmtableau';
exec sp_addrolemember 'PiiView_Role','US\jbeck';
exec sp_addrolemember 'RestrictedView_Role','US\svcltcsql';
exec sp_addrolemember 'RestrictedView_Role','US\XUTATECHWORKPLACEDATAENGTEAM';
exec sp_addrolemember 'UserView_Role','infttdengprd';
exec sp_addrolemember 'UserView_Role','sptmdldwlink';
exec sp_addrolemember 'UserView_Role','trsbiwebprd';
exec sp_addrolemember 'UserView_Role','US\spttasqlnonprod';
exec sp_addrolemember 'UserView_Role','US\svccrdbttbisqlm01';
exec sp_addrolemember 'UserView_Role','US\svctcmtableau';
exec sp_addrolemember 'UserView_Role','US\XUESPBIRPTAccess';
exec sp_addrolemember 'UserView_Role','US\XUTATECHWORKPLACEDATAENGTEAM';
/* GRANTING DBROLE PERMISSIONS*/
DENY  ALTER ON SCHEMA::dbo TO [tempCreate]
GRANT  ALTER ON SCHEMA::Stg TO [tempCreate]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [dbo]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [infttdengprd]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [MDLScheduler]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [sptmdldwlink]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [trsbidwprod]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [trsbiwebprd]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\ALATRSCNTRLMOps]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\ankopalidis]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\dsingh]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\jbeck]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\sptbittproxy]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\sptlatrsbiproxy]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\spttasqlnonprod]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\sptwpctrlm0prd]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\svccrdbttbisasp02]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\svccrdbttbisqlm01]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\svcltcsql]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\svctcmbiadatabase]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\svctcmtableau]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\ULAESPBIAdminDEV]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\XACRTCMBusIntelAnalyAdmin]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\XDTTRDMReadContractors]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\XUESPBIRPTAccess]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\XUESPBIRPTAccessDWRO]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\XUESPBIRPTAccessTST]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\XUTAAdvCtrBusAnalytics]
GRANT  CONNECT ON DATABASE::TRS_BI_Staging TO [US\XUTATECHWORKPLACEDATAENGTEAM]
GRANT  CREATE TABLE ON DATABASE::TRS_BI_Staging TO [tempCreate]
GRANT  EXECUTE ON SCHEMA::pii TO [PiiView_Role]
GRANT  EXECUTE ON SCHEMA::rpt TO [PiiView_Role]
GRANT  EXECUTE ON SCHEMA::usr TO [PiiView_Role]
GRANT  EXECUTE ON SCHEMA::ac TO [PiiView_Role]
GRANT  EXECUTE ON SCHEMA::ex TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::pii TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::restricted TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::rpt TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::usr TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::ac TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::rpt TO [UserView_Role]
GRANT  EXECUTE ON SCHEMA::usr TO [UserView_Role]
GRANT  INSERT ON DATABASE::TRS_BI_Staging TO [tempCreate]
GRANT  INSERT ON SCHEMA::Stg TO [US\ULAESPBIAdminDEV]
GRANT  REFERENCES ON DATABASE::TRS_BI_Staging TO [AWS_Role]
GRANT  SELECT ON DATABASE::TRS_BI_Staging TO [AWS_Role]
GRANT  SELECT ON DATABASE::TRS_BI_Staging TO [tempCreate]
GRANT SELECT ON OBJECT::dbo.DwAuditLog TO [DWLogReader]
GRANT SELECT ON OBJECT::dbo.DwLog TO [DWLogReader]
GRANT SELECT ON OBJECT::dbo.EndRunDWFlag TO [MDLScheduler]
GRANT SELECT ON OBJECT::dbo.Driver_DW_Flag TO [trsbiwebprd]
GRANT SELECT ON OBJECT::dbo.DwLog TO [trsbiwebprd]
GRANT SELECT ON OBJECT::usr.DWStatusCheck TO [US\spttasqlnonprod]
GRANT SELECT ON OBJECT::dbo.EndRunDWFlag TO [US\svccrdbttbisqlm01]
GRANT SELECT ON OBJECT::dbo.FUNDDESC TO [US\XUESPBIRPTAccessTST]
GRANT SELECT ON OBJECT::usr.FUNDDESC TO [US\XUESPBIRPTAccessTST]
GRANT SELECT ON OBJECT::dbo.CO_SOURCE TO [UserView_Role]
GRANT SELECT ON OBJECT::dbo.PLAN_SRC_DETAIL TO [UserView_Role]
GRANT  SELECT ON SCHEMA::pii TO [PiiView_Role]
GRANT  SELECT ON SCHEMA::rpt TO [PiiView_Role]
GRANT  SELECT ON SCHEMA::usr TO [PiiView_Role]
GRANT  SELECT ON SCHEMA::ac TO [PiiView_Role]
GRANT  SELECT ON SCHEMA::ex TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::dbo TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::pii TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::restricted TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::rpt TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::usr TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::ac TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::Stg TO [US\ULAESPBIAdminDEV]
GRANT  SELECT ON SCHEMA::rpt TO [UserView_Role]
GRANT  SELECT ON SCHEMA::usr TO [UserView_Role]
GRANT  SHOWPLAN ON DATABASE::TRS_BI_Staging TO [US\ULAESPBIAdminDEV]
GRANT  VIEW ANY COLUMN ENCRYPTION KEY DEFINITION ON DATABASE::TRS_BI_Staging TO [public]
GRANT  VIEW ANY COLUMN MASTER KEY DEFINITION ON DATABASE::TRS_BI_Staging TO [public]
GRANT  VIEW DATABASE STATE ON DATABASE::TRS_BI_Staging TO [AWS_Role]
GRANT  VIEW DEFINITION ON DATABASE::TRS_BI_Staging TO [AWS_Role]
GRANT  VIEW DEFINITION ON DATABASE::TRS_BI_Staging TO [US\XACRTCMBusIntelAnalyAdmin]
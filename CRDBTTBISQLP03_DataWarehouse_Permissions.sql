USE TRS_BI_Datawarehouse
GO
/* Creating Login information 
** Generated Jun 17 2021  9:51AM on CRDBTTBISQLP03\SQL01 */


-- Login: infttdengprd
if not exists(select * from master.sys.server_principals where name ='infttdengprd')      begin       CREATE LOGIN [infttdengprd] WITH PASSWORD = 0x02009DA983383E458EEF4D8EB30BC97F264EE9F35F8CACAC0658FE0E394A1BA005B6D66EFA61C24862A13824014CCFF4A0A0034C88095974EF71D78D7874009706F0A7B00227 HASHED, SID = 0x93B45239CDD41A45B46BB85BC52D5591, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: spttaaaprd
if not exists(select * from master.sys.server_principals where name ='spttaaaprd')      begin       CREATE LOGIN [spttaaaprd] WITH PASSWORD = 0x0200D306CA29FBBA42FEDA81D6422A0AAE130DDF6C5B8F4399C7DC218DA569D45730A3853AFBBEC90EE6ABFD5640C35426F593D4EC7806CFAF3187E871E8B51C42EFC07BF05E HASHED, SID = 0x74C21666E0623242B63E4F9A3898CEAE, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: trsbidwprd
if not exists(select * from master.sys.server_principals where name ='trsbidwprd')      begin       CREATE LOGIN [trsbidwprd] WITH PASSWORD = 0x0200A1E965E4871042252C342D2FD77FD337E9E813D46088BCF48407B8A2AD907566C012875F25A4B1F2DB4D1533AB559EEAF2AE761F9860C9A619D5FDC62A870DB81DA00B42 HASHED, SID = 0xCDFFBBE6A87F0C4AB39156C73C778016, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: trsbidwprod
if not exists(select * from master.sys.server_principals where name ='trsbidwprod')      begin       CREATE LOGIN [trsbidwprod] WITH PASSWORD = 0x0200110039412B775B3EBF4C47BC3F5412922BD960ABD266EBBEA6D58F1416AE6E2FAE59D423AEF662D0CA13E205EFE99FB5C96ED92CECB3B66698B65ADAFF898C6D8C280A46 HASHED, SID = 0x2BFE6699837A6E4DB26AF4BE55AB8F74, DEFAULT_DATABASE = [TRS_BI_Datawarehouse], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: trsbiwebprd
if not exists(select * from master.sys.server_principals where name ='trsbiwebprd')      begin       CREATE LOGIN [trsbiwebprd] WITH PASSWORD = 0x02009494551C7F97EE0BC2D5EEF5C5067F61DE71120D52609AC9EFD809925DF2F9A4824E2BDBEF13ED055137FA5702FDB08DA0201D3BF13BD284CA8501FB6017E44F54EE4349 HASHED, SID = 0x3D4E5BC37832B44AB43716575F46F3DD, DEFAULT_DATABASE = [TRS_BI_Datawarehouse], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: ULATRSPivotalRptProd
if not exists(select * from master.sys.server_principals where name ='ULATRSPivotalRptProd')      begin       CREATE LOGIN [ULATRSPivotalRptProd] WITH PASSWORD = 0x0200A18FDE0761A6D584C6691C38D3B8071703535F0430615EE3B147D4C64B18625E406B62F4BE76081FCB4DC802A61262CAF57E30581CE361B316AF163A72F133AA8517DDFF HASHED, SID = 0xBDC3C2A187649545926A5656139C0F7E, DEFAULT_DATABASE = [master], CHECK_POLICY = ON, CHECK_EXPIRATION = OFF       end

-- Login: US\ALATRSCNTRLMOps
if not exists(select * from master.sys.server_principals where name = 'US\ALATRSCNTRLMOps')       begin       CREATE LOGIN [US\ALATRSCNTRLMOps] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\ALATRSPivRelAdmins
if not exists(select * from master.sys.server_principals where name = 'US\ALATRSPivRelAdmins')       begin       CREATE LOGIN [US\ALATRSPivRelAdmins] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\dsingh
if not exists(select * from master.sys.server_principals where name = 'US\dsingh')       begin       CREATE LOGIN [US\dsingh] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\jbeck
if not exists(select * from master.sys.server_principals where name = 'US\jbeck')       begin       CREATE LOGIN [US\jbeck] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\sptbittproxy
if not exists(select * from master.sys.server_principals where name = 'US\sptbittproxy')       begin       CREATE LOGIN [US\sptbittproxy] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\sptlatrsbiproxy
if not exists(select * from master.sys.server_principals where name = 'US\sptlatrsbiproxy')       begin       CREATE LOGIN [US\sptlatrsbiproxy] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\spttaaaprd
if not exists(select * from master.sys.server_principals where name = 'US\spttaaaprd')       begin       CREATE LOGIN [US\spttaaaprd] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\spttawsdnaprd
if not exists(select * from master.sys.server_principals where name = 'US\spttawsdnaprd')       begin       CREATE LOGIN [US\spttawsdnaprd] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\sptwpctrlm0prd
if not exists(select * from master.sys.server_principals where name = 'US\sptwpctrlm0prd')       begin       CREATE LOGIN [US\sptwpctrlm0prd] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svccrdbttbisasp02
if not exists(select * from master.sys.server_principals where name = 'US\svccrdbttbisasp02')       begin       CREATE LOGIN [US\svccrdbttbisasp02] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svccrdbttbisasp03
if not exists(select * from master.sys.server_principals where name = 'US\svccrdbttbisasp03')       begin       CREATE LOGIN [US\svccrdbttbisasp03] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svcltcsql
if not exists(select * from master.sys.server_principals where name = 'US\svcltcsql')       begin       CREATE LOGIN [US\svcltcsql] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svctcmalteryx
if not exists(select * from master.sys.server_principals where name = 'US\svctcmalteryx')       begin       CREATE LOGIN [US\svctcmalteryx] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svctcmalteryxprd
if not exists(select * from master.sys.server_principals where name = 'US\svctcmalteryxprd')       begin       CREATE LOGIN [US\svctcmalteryxprd] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svctcmbiadatabase
if not exists(select * from master.sys.server_principals where name = 'US\svctcmbiadatabase')       begin       CREATE LOGIN [US\svctcmbiadatabase] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\svctcmtableau
if not exists(select * from master.sys.server_principals where name = 'US\svctcmtableau')       begin       CREATE LOGIN [US\svctcmtableau] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\UCRTCMDenverBITeam
if not exists(select * from master.sys.server_principals where name = 'US\UCRTCMDenverBITeam')       begin       CREATE LOGIN [US\UCRTCMDenverBITeam] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\UCRTCMDenverBITeamDev
if not exists(select * from master.sys.server_principals where name = 'US\UCRTCMDenverBITeamDev')       begin       CREATE LOGIN [US\UCRTCMDenverBITeamDev] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\ulaespbiadmindev
if not exists(select * from master.sys.server_principals where name = 'US\ulaespbiadmindev')       begin       CREATE LOGIN [US\ulaespbiadmindev] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\ULTCLPBIDev
if not exists(select * from master.sys.server_principals where name = 'US\ULTCLPBIDev')       begin       CREATE LOGIN [US\ULTCLPBIDev] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\uttdtengineering
if not exists(select * from master.sys.server_principals where name = 'US\uttdtengineering')       begin       CREATE LOGIN [US\uttdtengineering] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XACRTCMBusIntelAnalyAdmin
if not exists(select * from master.sys.server_principals where name = 'US\XACRTCMBusIntelAnalyAdmin')       begin       CREATE LOGIN [US\XACRTCMBusIntelAnalyAdmin] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XDTTRDMReadContractors
if not exists(select * from master.sys.server_principals where name = 'US\XDTTRDMReadContractors')       begin       CREATE LOGIN [US\XDTTRDMReadContractors] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XDTTSDMReadSensitive
if not exists(select * from master.sys.server_principals where name = 'US\XDTTSDMReadSensitive')       begin       CREATE LOGIN [US\XDTTSDMReadSensitive] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUESPBIRPTAccess
if not exists(select * from master.sys.server_principals where name = 'US\XUESPBIRPTAccess')       begin       CREATE LOGIN [US\XUESPBIRPTAccess] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUESPBIRPTAccessDWRO
if not exists(select * from master.sys.server_principals where name = 'US\XUESPBIRPTAccessDWRO')       begin       CREATE LOGIN [US\XUESPBIRPTAccessDWRO] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUESPBIRPTAccessQA
if not exists(select * from master.sys.server_principals where name = 'US\XUESPBIRPTAccessQA')       begin       CREATE LOGIN [US\XUESPBIRPTAccessQA] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUESPBIRPTAccessTST
if not exists(select * from master.sys.server_principals where name = 'US\XUESPBIRPTAccessTST')       begin       CREATE LOGIN [US\XUESPBIRPTAccessTST] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUTAAdvCtrBusAnalytics
if not exists(select * from master.sys.server_principals where name = 'US\XUTAAdvCtrBusAnalytics')       begin       CREATE LOGIN [US\XUTAAdvCtrBusAnalytics] FROM WINDOWS WITH DEFAULT_DATABASE = [master]       end

-- Login: US\XUTATECHWORKPLACEDATAENGTEAM
if not exists(select * from master.sys.server_principals where name = 'US\XUTATECHWORKPLACEDATAENGTEAM')       begin       CREATE LOGIN [US\XUTATECHWORKPLACEDATAENGTEAM] FROM WINDOWS WITH DEFAULT_DATABASE = [WorkplaceExperience]       end
/* Creating Database Roles*/
if not exists (select 1 from  TRS_BI_Datawarehouse.sys.database_principals where type ='R' and name='UserView_Role')  create role [UserView_Role];
if not exists (select 1 from  TRS_BI_Datawarehouse.sys.database_principals where type ='R' and name='RestrictedView_Role')  create role [RestrictedView_Role];
if not exists (select 1 from  TRS_BI_Datawarehouse.sys.database_principals where type ='R' and name='PIIView_Role')  create role [PIIView_Role];
if not exists (select 1 from  TRS_BI_Datawarehouse.sys.database_principals where type ='R' and name='aegonaggregateView_Role')  create role [aegonaggregateView_Role];
if not exists (select 1 from  TRS_BI_Datawarehouse.sys.database_principals where type ='R' and name='AdvAnalytics_ReadRole')  create role [AdvAnalytics_ReadRole];
/* GRANTING PERMISSIONS TO DATABASE*/
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'infttdengprd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='infttdengprd')        DROP USER [infttdengprd]        CREATE USER [infttdengprd] FOR LOGIN [infttdengprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'spttaaaprd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='spttaaaprd')        DROP USER [spttaaaprd]        CREATE USER [spttaaaprd] FOR LOGIN [spttaaaprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'trsbidwprd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='trsbidwprd')        DROP USER [trsbidwprd]        CREATE USER [trsbidwprd] FOR LOGIN [trsbidwprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'trsbidwprod')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='trsbidwprod')        DROP USER [trsbidwprod]        CREATE USER [trsbidwprod] FOR LOGIN [trsbidwprod] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'trsbiwebprd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='trsbiwebprd')        DROP USER [trsbiwebprd]        CREATE USER [trsbiwebprd] FOR LOGIN [trsbiwebprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'ULATRSPivotalRptProd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='ULATRSPivotalRptProd')        DROP USER [ULATRSPivotalRptProd]        CREATE USER [ULATRSPivotalRptProd] FOR LOGIN [ULATRSPivotalRptProd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ALATRSCNTRLMOps')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\ALATRSCNTRLMOps')        DROP USER [US\ALATRSCNTRLMOps]        CREATE USER [US\ALATRSCNTRLMOps] FOR LOGIN [US\ALATRSCNTRLMOps] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ALATRSPivRelAdmins')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\ALATRSPivRelAdmins')        DROP USER [US\ALATRSPivRelAdmins]        CREATE USER [US\ALATRSPivRelAdmins] FOR LOGIN [US\ALATRSPivRelAdmins] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\craithel')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\craithel')        DROP USER [US\craithel]        CREATE USER [US\craithel] FOR LOGIN [US\craithel] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\dsingh')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\dsingh')        DROP USER [US\dsingh]        CREATE USER [US\dsingh] FOR LOGIN [US\dsingh] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\jbeck')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\jbeck')        DROP USER [US\jbeck]        CREATE USER [US\jbeck] FOR LOGIN [US\jbeck] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\rchintala')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\rchintala')        DROP USER [US\rchintala]        CREATE USER [US\rchintala] FOR LOGIN [US\rchintala] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptbittproxy')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\sptbittproxy')        DROP USER [US\sptbittproxy]        CREATE USER [US\sptbittproxy] FOR LOGIN [US\sptbittproxy] WITH DEFAULT_SCHEMA = US\sptbittproxy       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptlatrsbiproxy')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\sptlatrsbiproxy')        DROP USER [US\sptlatrsbiproxy]        CREATE USER [US\sptlatrsbiproxy] FOR LOGIN [US\sptlatrsbiproxy] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\spttaaaprd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\spttaaaprd')        DROP USER [US\spttaaaprd]        CREATE USER [US\spttaaaprd] FOR LOGIN [US\spttaaaprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\spttawsdnaprd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\spttawsdnaprd')        DROP USER [US\spttawsdnaprd]        CREATE USER [US\spttawsdnaprd] FOR LOGIN [US\spttawsdnaprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\sptwpctrlm0prd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\sptwpctrlm0prd')        DROP USER [US\sptwpctrlm0prd]        CREATE USER [US\sptwpctrlm0prd] FOR LOGIN [US\sptwpctrlm0prd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svccrdbttbisasp02')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\svccrdbttbisasp02')        DROP USER [US\svccrdbttbisasp02]        CREATE USER [US\svccrdbttbisasp02] FOR LOGIN [US\svccrdbttbisasp02] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svccrdbttbisasp03')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\svccrdbttbisasp03')        DROP USER [US\svccrdbttbisasp03]        CREATE USER [US\svccrdbttbisasp03] FOR LOGIN [US\svccrdbttbisasp03] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svcespbisqltst')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\svcespbisqltst')        DROP USER [US\svcespbisqltst]        CREATE USER [US\svcespbisqltst] FOR LOGIN [US\svcespbisqltst] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svcltcsql')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\svcltcsql')        DROP USER [US\svcltcsql]        CREATE USER [US\svcltcsql] FOR LOGIN [US\svcltcsql] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svctcmalteryx')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\svctcmalteryx')        DROP USER [US\svctcmalteryx]        CREATE USER [US\svctcmalteryx] FOR LOGIN [US\svctcmalteryx] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svctcmalteryxprd')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\svctcmalteryxprd')        DROP USER [US\svctcmalteryxprd]        CREATE USER [US\svctcmalteryxprd] FOR LOGIN [US\svctcmalteryxprd] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svctcmbiadatabase')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\svctcmbiadatabase')        DROP USER [US\svctcmbiadatabase]        CREATE USER [US\svctcmbiadatabase] FOR LOGIN [US\svctcmbiadatabase] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\svctcmtableau')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\svctcmtableau')        DROP USER [US\svctcmtableau]        CREATE USER [US\svctcmtableau] FOR LOGIN [US\svctcmtableau] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\UCRTCMDenverBITeam')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\UCRTCMDenverBITeam')        DROP USER [US\UCRTCMDenverBITeam]        CREATE USER [US\UCRTCMDenverBITeam] FOR LOGIN [US\UCRTCMDenverBITeam] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\UCRTCMDenverBITeamDev')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\UCRTCMDenverBITeamDev')        DROP USER [US\UCRTCMDenverBITeamDev]        CREATE USER [US\UCRTCMDenverBITeamDev] FOR LOGIN [US\UCRTCMDenverBITeamDev] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ulaespbiadmin')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\ulaespbiadmin')        DROP USER [US\ulaespbiadmin]        CREATE USER [US\ulaespbiadmin] FOR LOGIN [US\ulaespbiadmin] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ULAESPBIAdminDEV')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\ULAESPBIAdminDEV')        DROP USER [US\ULAESPBIAdminDEV]        CREATE USER [US\ULAESPBIAdminDEV] FOR LOGIN [US\ULAESPBIAdminDEV] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\ULTCLPBIDev')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\ULTCLPBIDev')        DROP USER [US\ULTCLPBIDev]        CREATE USER [US\ULTCLPBIDev] FOR LOGIN [US\ULTCLPBIDev] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\uttdtengineering')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\uttdtengineering')        DROP USER [US\uttdtengineering]        CREATE USER [US\uttdtengineering] FOR LOGIN [US\uttdtengineering] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XACRTCMBusIntelAnalyAdmin')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\XACRTCMBusIntelAnalyAdmin')        DROP USER [US\XACRTCMBusIntelAnalyAdmin]        CREATE USER [US\XACRTCMBusIntelAnalyAdmin] FOR LOGIN [US\XACRTCMBusIntelAnalyAdmin] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XDTTRDMReadContractors')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\XDTTRDMReadContractors')        DROP USER [US\XDTTRDMReadContractors]        CREATE USER [US\XDTTRDMReadContractors] FOR LOGIN [US\XDTTRDMReadContractors] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XDTTSDMReadSensitive')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\XDTTSDMReadSensitive')        DROP USER [US\XDTTSDMReadSensitive]        CREATE USER [US\XDTTSDMReadSensitive] FOR LOGIN [US\XDTTSDMReadSensitive] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUESPBIRPTAccess')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\XUESPBIRPTAccess')        DROP USER [US\XUESPBIRPTAccess]        CREATE USER [US\XUESPBIRPTAccess] FOR LOGIN [US\XUESPBIRPTAccess] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUESPBIRPTAccessDWRO')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\XUESPBIRPTAccessDWRO')        DROP USER [US\XUESPBIRPTAccessDWRO]        CREATE USER [US\XUESPBIRPTAccessDWRO] FOR LOGIN [US\XUESPBIRPTAccessDWRO] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUESPBIRPTAccessQA')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\XUESPBIRPTAccessQA')        DROP USER [US\XUESPBIRPTAccessQA]        CREATE USER [US\XUESPBIRPTAccessQA] FOR LOGIN [US\XUESPBIRPTAccessQA] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUESPBIRPTAccessTST')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\XUESPBIRPTAccessTST')        DROP USER [US\XUESPBIRPTAccessTST]        CREATE USER [US\XUESPBIRPTAccessTST] FOR LOGIN [US\XUESPBIRPTAccessTST] WITH DEFAULT_SCHEMA = usr       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUTAAdvCtrBusAnalytics')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\XUTAAdvCtrBusAnalytics')        DROP USER [US\XUTAAdvCtrBusAnalytics]        CREATE USER [US\XUTAAdvCtrBusAnalytics] FOR LOGIN [US\XUTAAdvCtrBusAnalytics] WITH DEFAULT_SCHEMA = dbo       END
IF NOT EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals SU INNER JOIN MASTER.SYS.server_principals SL ON SU.SID=SL.SID WHERE SU.NAME= 'US\XUTATECHWORKPLACEDATAENGTEAM')       BEGIN        IF EXISTS (SELECT 1 FROM [TRS_BI_Datawarehouse].SYS.database_principals WHERE NAME ='US\XUTATECHWORKPLACEDATAENGTEAM')        DROP USER [US\XUTATECHWORKPLACEDATAENGTEAM]        CREATE USER [US\XUTATECHWORKPLACEDATAENGTEAM] FOR LOGIN [US\XUTATECHWORKPLACEDATAENGTEAM] WITH DEFAULT_SCHEMA = dbo       END
exec sp_addrolemember 'AdvAnalytics_ReadRole','spttaaaprd';
exec sp_addrolemember 'aegonaggregateView_Role','US\svctcmbiadatabase';
exec sp_addrolemember 'aegonaggregateView_Role','US\XDTTSDMReadSensitive';
exec sp_addrolemember 'db_datareader','trsbidwprd';
exec sp_addrolemember 'db_datareader','trsbidwprod';
exec sp_addrolemember 'db_datareader','trsbiwebprd';
exec sp_addrolemember 'db_datareader','US\ALATRSCNTRLMOps';
exec sp_addrolemember 'db_datareader','US\svccrdbttbisasp02';
exec sp_addrolemember 'db_datareader','US\svcltcsql';
exec sp_addrolemember 'db_datareader','US\ULAESPBIAdminDEV';
exec sp_addrolemember 'db_datareader','US\ULTCLPBIDev';
exec sp_addrolemember 'db_datareader','US\XUTATECHWORKPLACEDATAENGTEAM';
exec sp_addrolemember 'db_owner','US\sptbittproxy';
exec sp_addrolemember 'db_owner','US\sptlatrsbiproxy';
exec sp_addrolemember 'db_owner','US\sptwpctrlm0prd';
exec sp_addrolemember 'db_owner','US\svccrdbttbisasp03';
exec sp_addrolemember 'db_owner','US\ulaespbiadmin';
exec sp_addrolemember 'PIIView_Role','infttdengprd';
exec sp_addrolemember 'PIIView_Role','trsbidwprod';
exec sp_addrolemember 'PIIView_Role','US\jbeck';
exec sp_addrolemember 'PIIView_Role','US\rchintala';
exec sp_addrolemember 'PIIView_Role','US\uttdtengineering';
exec sp_addrolemember 'PIIView_Role','US\XACRTCMBusIntelAnalyAdmin';
exec sp_addrolemember 'RestrictedView_Role','trsbiwebprd';
exec sp_addrolemember 'RestrictedView_Role','US\craithel';
exec sp_addrolemember 'RestrictedView_Role','US\dsingh';
exec sp_addrolemember 'RestrictedView_Role','US\svcltcsql';
exec sp_addrolemember 'RestrictedView_Role','US\UCRTCMDenverBITeamDev';
exec sp_addrolemember 'RestrictedView_Role','US\XDTTRDMReadContractors';
exec sp_addrolemember 'RestrictedView_Role','US\XUESPBIRPTAccessDWRO';
exec sp_addrolemember 'RestrictedView_Role','US\XUESPBIRPTAccessQA';
exec sp_addrolemember 'RestrictedView_Role','US\XUTAAdvCtrBusAnalytics';
exec sp_addrolemember 'RestrictedView_Role','US\XUTATECHWORKPLACEDATAENGTEAM';
exec sp_addrolemember 'UserView_Role','spttaaaprd';
exec sp_addrolemember 'UserView_Role','trsbidwprod';
exec sp_addrolemember 'UserView_Role','ULATRSPivotalRptProd';
exec sp_addrolemember 'UserView_Role','US\ALATRSPivRelAdmins';
exec sp_addrolemember 'UserView_Role','US\spttaaaprd';
exec sp_addrolemember 'UserView_Role','US\spttawsdnaprd';
exec sp_addrolemember 'UserView_Role','US\svctcmalteryx';
exec sp_addrolemember 'UserView_Role','US\svctcmalteryxprd';
exec sp_addrolemember 'UserView_Role','US\svctcmtableau';
exec sp_addrolemember 'UserView_Role','US\UCRTCMDenverBITeam';
exec sp_addrolemember 'UserView_Role','US\ULAESPBIAdminDEV';
exec sp_addrolemember 'UserView_Role','US\XUESPBIRPTAccess';
exec sp_addrolemember 'UserView_Role','US\XUESPBIRPTAccessTST';
exec sp_addrolemember 'UserView_Role','US\XUTATECHWORKPLACEDATAENGTEAM';
/* GRANTING DBROLE PERMISSIONS*/
DENY EXECUTE ON OBJECT::dbo.fn_diagramobjects TO [guest]
DENY EXECUTE ON OBJECT::dbo.sp_alterdiagram TO [guest]
DENY EXECUTE ON OBJECT::dbo.sp_creatediagram TO [guest]
DENY EXECUTE ON OBJECT::dbo.sp_dropdiagram TO [guest]
DENY EXECUTE ON OBJECT::dbo.sp_helpdiagramdefinition TO [guest]
DENY EXECUTE ON OBJECT::dbo.sp_helpdiagrams TO [guest]
DENY EXECUTE ON OBJECT::dbo.sp_renamediagram TO [guest]
GRANT ALTER ON OBJECT::dbo.factParticipant TO [trsbidwprod]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [dbo]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [infttdengprd]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [spttaaaprd]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [trsbidwprd]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [trsbidwprod]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [trsbiwebprd]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [ULATRSPivotalRptProd]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\ALATRSCNTRLMOps]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\ALATRSPivRelAdmins]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\craithel]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\dsingh]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\jbeck]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\rchintala]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\sptbittproxy]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\sptlatrsbiproxy]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\spttaaaprd]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\spttawsdnaprd]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\sptwpctrlm0prd]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\svccrdbttbisasp02]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\svccrdbttbisasp03]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\svcespbisqltst]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\svcltcsql]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\svctcmalteryx]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\svctcmalteryxprd]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\svctcmbiadatabase]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\svctcmtableau]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\UCRTCMDenverBITeam]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\UCRTCMDenverBITeamDev]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\ulaespbiadmin]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\ULAESPBIAdminDEV]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\ULTCLPBIDev]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\uttdtengineering]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\XACRTCMBusIntelAnalyAdmin]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\XDTTRDMReadContractors]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\XDTTSDMReadSensitive]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\XUESPBIRPTAccess]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\XUESPBIRPTAccessDWRO]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\XUESPBIRPTAccessQA]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\XUESPBIRPTAccessTST]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\XUTAAdvCtrBusAnalytics]
GRANT  CONNECT ON DATABASE::TRS_BI_Datawarehouse TO [US\XUTATECHWORKPLACEDATAENGTEAM]
GRANT EXECUTE ON OBJECT::dbo.fn_diagramobjects TO [public]
GRANT EXECUTE ON OBJECT::dbo.sp_alterdiagram TO [public]
GRANT EXECUTE ON OBJECT::dbo.sp_creatediagram TO [public]
GRANT EXECUTE ON OBJECT::dbo.sp_dropdiagram TO [public]
GRANT EXECUTE ON OBJECT::dbo.sp_helpdiagramdefinition TO [public]
GRANT EXECUTE ON OBJECT::dbo.sp_helpdiagrams TO [public]
GRANT EXECUTE ON OBJECT::dbo.sp_renamediagram TO [public]
GRANT EXECUTE ON OBJECT::usr.usp_GetNavBalance TO [US\XUESPBIRPTAccessTST]
GRANT  EXECUTE ON SCHEMA::rpt TO [PIIView_Role]
GRANT  EXECUTE ON SCHEMA::usr TO [PIIView_Role]
GRANT  EXECUTE ON SCHEMA::pii TO [PIIView_Role]
GRANT  EXECUTE ON SCHEMA::restricted TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::ex TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::rpt TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::usr TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::pii TO [RestrictedView_Role]
GRANT  EXECUTE ON SCHEMA::rpt TO [UserView_Role]
GRANT  EXECUTE ON SCHEMA::usr TO [UserView_Role]
GRANT SELECT ON OBJECT::dbo.dimOutlook TO [AdvAnalytics_ReadRole]
GRANT SELECT ON OBJECT::dbo.dimParticipant TO [AdvAnalytics_ReadRole]
GRANT SELECT ON OBJECT::dbo.dimPlan TO [AdvAnalytics_ReadRole]
GRANT SELECT ON OBJECT::restricted.ClientContact TO [aegonaggregateView_Role]
GRANT SELECT ON OBJECT::restricted.Division TO [aegonaggregateView_Role]
GRANT SELECT ON OBJECT::restricted.Financial TO [aegonaggregateView_Role]
GRANT SELECT ON OBJECT::restricted.ParticipantInfo TO [aegonaggregateView_Role]
GRANT SELECT ON OBJECT::restricted.ParticipantNonpii TO [aegonaggregateView_Role]
GRANT SELECT ON OBJECT::restricted.PlanInfo TO [aegonaggregateView_Role]
GRANT SELECT ON OBJECT::ac.TermLeads TO [PIIView_Role]
GRANT SELECT ON OBJECT::dbo.factParticipant TO [trsbidwprod]
GRANT SELECT ON OBJECT::dbo.dimDate TO [UserView_Role]
GRANT  SELECT ON SCHEMA::usr TO [AdvAnalytics_ReadRole]
GRANT  SELECT ON SCHEMA::dbo TO [infttdengprd]
GRANT  SELECT ON SCHEMA::rpt TO [PIIView_Role]
GRANT  SELECT ON SCHEMA::usr TO [PIIView_Role]
GRANT  SELECT ON SCHEMA::ac TO [PIIView_Role]
GRANT  SELECT ON SCHEMA::pii TO [PIIView_Role]
GRANT  SELECT ON SCHEMA::restricted TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::ex TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::dbo TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::rpt TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::usr TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::pii TO [RestrictedView_Role]
GRANT  SELECT ON SCHEMA::rpt TO [UserView_Role]
GRANT  SELECT ON SCHEMA::usr TO [UserView_Role]
GRANT  SHOWPLAN ON DATABASE::TRS_BI_Datawarehouse TO [US\ULAESPBIAdminDEV]
GRANT  VIEW ANY COLUMN ENCRYPTION KEY DEFINITION ON DATABASE::TRS_BI_Datawarehouse TO [public]
GRANT  VIEW ANY COLUMN MASTER KEY DEFINITION ON DATABASE::TRS_BI_Datawarehouse TO [public]
GRANT  VIEW DATABASE STATE ON DATABASE::TRS_BI_Datawarehouse TO [US\ULAESPBIAdminDEV]
GRANT  VIEW DEFINITION ON DATABASE::TRS_BI_Datawarehouse TO [US\ULAESPBIAdminDEV]
GRANT  VIEW DEFINITION ON DATABASE::TRS_BI_Datawarehouse TO [US\XACRTCMBusIntelAnalyAdmin]
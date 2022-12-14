USE [master]
GO
/****** Object:  Database [WorkplaceExperience]    Script Date: 6/17/2021 10:57:34 AM ******/
CREATE DATABASE [WorkplaceExperience]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WorkplaceExperience', FILENAME = N'J:\MSSQL13.SQL01\MSSQL\Data\WorkplaceExperience_data.mdf' , SIZE = 158515200KB , MAXSIZE = UNLIMITED, FILEGROWTH = 512000KB )
 LOG ON 
( NAME = N'WorkplaceExperience_log', FILENAME = N'J:\MSSQL13.SQL01\MSSQL\Data\WorkplaceExperience_log_data.ldf' , SIZE = 83414912KB , MAXSIZE = 2048GB , FILEGROWTH = 512000KB )
GO
ALTER DATABASE [WorkplaceExperience] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WorkplaceExperience].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WorkplaceExperience] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET ARITHABORT OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WorkplaceExperience] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WorkplaceExperience] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WorkplaceExperience] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WorkplaceExperience] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET RECOVERY FULL 
GO
ALTER DATABASE [WorkplaceExperience] SET  MULTI_USER 
GO
ALTER DATABASE [WorkplaceExperience] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WorkplaceExperience] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WorkplaceExperience] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WorkplaceExperience] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [WorkplaceExperience] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'WorkplaceExperience', N'ON'
GO
ALTER DATABASE [WorkplaceExperience] SET QUERY_STORE = OFF
GO
USE [WorkplaceExperience]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [WorkplaceExperience]
GO
/****** Object:  User [US\XUTATECHWORKPLACEDATAENGTEAM]    Script Date: 6/17/2021 10:57:35 AM ******/
CREATE USER [US\XUTATECHWORKPLACEDATAENGTEAM] FOR LOGIN [US\XUTATECHWORKPLACEDATAENGTEAM]
GO
/****** Object:  User [US\XUTATECHEXDEV]    Script Date: 6/17/2021 10:57:35 AM ******/
CREATE USER [US\XUTATECHEXDEV] FOR LOGIN [US\XUTATECHEXDEV]
GO
/****** Object:  User [US\ulaespbiadmindev]    Script Date: 6/17/2021 10:57:35 AM ******/
CREATE USER [US\ulaespbiadmindev] FOR LOGIN [US\ulaespbiadmindev]
GO
/****** Object:  User [US\svccrdbttexsasp03]    Script Date: 6/17/2021 10:57:35 AM ******/
CREATE USER [US\svccrdbttexsasp03] FOR LOGIN [US\svccrdbttexsasp03] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [US\svccrdbttexsasp01]    Script Date: 6/17/2021 10:57:36 AM ******/
CREATE USER [US\svccrdbttexsasp01] FOR LOGIN [US\svccrdbttexsasp01] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [US\svccrdbttbisasp02]    Script Date: 6/17/2021 10:57:36 AM ******/
CREATE USER [US\svccrdbttbisasp02] FOR LOGIN [US\svccrdbttbisasp02] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [US\sptwpctrlm0prd]    Script Date: 6/17/2021 10:57:36 AM ******/
CREATE USER [US\sptwpctrlm0prd] FOR LOGIN [US\sptwpctrlm0prd] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [US\sptbittproxy]    Script Date: 6/17/2021 10:57:36 AM ******/
CREATE USER [US\sptbittproxy] FOR LOGIN [US\sptbittproxy] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [sptwxprod]    Script Date: 6/17/2021 10:57:36 AM ******/
CREATE USER [sptwxprod] FOR LOGIN [sptwxprod] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [sptInformEx]    Script Date: 6/17/2021 10:57:36 AM ******/
CREATE USER [sptInformEx] FOR LOGIN [sptInformEx] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [extest]    Script Date: 6/17/2021 10:57:36 AM ******/
CREATE USER [extest] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [exawsprd]    Script Date: 6/17/2021 10:57:36 AM ******/
CREATE USER [exawsprd] FOR LOGIN [exawsprd] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [wex_userrole]    Script Date: 6/17/2021 10:57:36 AM ******/
CREATE ROLE [wex_userrole]
GO
/****** Object:  DatabaseRole [wex_supportrole]    Script Date: 6/17/2021 10:57:37 AM ******/
CREATE ROLE [wex_supportrole]
GO
/****** Object:  DatabaseRole [ref_updaterole]    Script Date: 6/17/2021 10:57:37 AM ******/
CREATE ROLE [ref_updaterole]
GO
ALTER ROLE [wex_userrole] ADD MEMBER [US\XUTATECHWORKPLACEDATAENGTEAM]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\XUTATECHWORKPLACEDATAENGTEAM]
GO
ALTER ROLE [wex_userrole] ADD MEMBER [US\XUTATECHEXDEV]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\XUTATECHEXDEV]
GO
ALTER ROLE [wex_userrole] ADD MEMBER [US\ulaespbiadmindev]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\ulaespbiadmindev]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\svccrdbttexsasp03]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\svccrdbttexsasp01]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\svccrdbttbisasp02]
GO
ALTER ROLE [db_owner] ADD MEMBER [US\sptwpctrlm0prd]
GO
ALTER ROLE [db_owner] ADD MEMBER [US\sptbittproxy]
GO
ALTER ROLE [wex_supportrole] ADD MEMBER [sptwxprod]
GO
ALTER ROLE [ref_updaterole] ADD MEMBER [sptInformEx]
GO
ALTER ROLE [wex_userrole] ADD MEMBER [extest]
GO
ALTER ROLE [wex_userrole] ADD MEMBER [exawsprd]
GO
/****** Object:  Schema [ex]    Script Date: 6/17/2021 10:57:38 AM ******/
CREATE SCHEMA [ex]
GO
/****** Object:  Schema [ref]    Script Date: 6/17/2021 10:57:38 AM ******/
CREATE SCHEMA [ref]
GO
/****** Object:  Schema [temp]    Script Date: 6/17/2021 10:57:38 AM ******/
CREATE SCHEMA [temp]
GO
/****** Object:  Schema [wxstg]    Script Date: 6/17/2021 10:57:38 AM ******/
CREATE SCHEMA [wxstg]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_CamelCase]    Script Date: 6/17/2021 10:57:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_CamelCase] (
	@Str VARCHAR(8000)
)
RETURNS VARCHAR(8000) AS
BEGIN
  DECLARE @Result VARCHAR(2000)
  SET @Str = LOWER(@Str) + ' '
  SET @Result = ''
  WHILE 1=1
  BEGIN
    IF PATINDEX('% %',@Str) = 0 BREAK
    SET @Result = @Result + UPPER(Left(@Str,1))+
    SUBSTRING  (@Str,2,CHARINDEX(' ',@Str)-1)
    SET @Str = SUBSTRING(@Str,
      CHARINDEX(' ',@Str)+1,LEN(@Str))
  END
  SET @Result = LEFT(@Result,LEN(@Result))
  RETURN @Result
END

GO
/****** Object:  Table [ref].[tab_PlanLevelFlags]    Script Date: 6/17/2021 10:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_PlanLevelFlags](
	[dimPlanId] [int] NULL,
	[CaseNumber] [varchar](20) NULL,
	[PlanName] [varchar](161) NULL,
	[CompanyName] [varchar](80) NULL,
	[MultiDivision] [varchar](7) NULL,
	[MultiPartDivision] [varchar](7) NULL,
	[OutsourceDeferralFlag] [int] NULL,
	[DeferralMethod] [varchar](80) NULL,
	[PreTaxFlag] [int] NULL,
	[RothFlag] [int] NULL,
	[AfterTaxFlag] [int] NULL,
	[AutoRebalance] [int] NULL,
	[AutoIncrease] [int] NULL,
	[CustomPortfolios] [int] NULL,
	[DCMA] [int] NULL,
	[FundTransfer] [int] NULL,
	[PCRA] [int] NULL,
	[PortfolioXpress] [int] NULL,
	[SDA] [int] NULL,
	[SecurePathForLife] [int] NULL,
	[PretaxContributionFlag] [int] NULL,
	[RothContributionFlag] [int] NULL,
	[AfterTaxContributionFlag] [int] NULL,
	[TA_Calculated_Eligibility] [int] NULL,
	[EligibilityTracking] [int] NULL,
	[DeferralTracking] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[tab_dimPlan]    Script Date: 6/17/2021 10:57:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 10. tab_dimPlan

CREATE  VIEW [dbo].[tab_dimPlan] 
AS
--WITH cte1 AS
--(
--  SELECT    ACCOUNT_NO, 
--          --DEF_AMT_PCT_C, 
--		  DEFERRAL_METHOD AS DeferralMethod, 
--          CASE WHEN PRETAX >= 1 THEN 1 ELSE 0 END AS PreTaxFlag,
--          CASE WHEN ROTH >= 1 THEN 1 ELSE 0 END AS RothFlag,
--          CASE WHEN AFTERTAX >= 1 THEN 1 ELSE 0 END AS AfterTaxFlag
--  FROM
--  (
--    SELECT  ACCOUNT_NO, 
--           DEF_AMT_PCT_C, 
--		   DEFERRAL_METHOD, 
--           SUM(CASE WHEN THETYPE = 'PreTax' THEN 1 ELSE 0 END) AS PRETAX,
--           SUM(CASE WHEN THETYPE = 'Roth' THEN 1 ELSE 0 END) AS ROTH,
--           SUM(CASE WHEN THETYPE = 'AfterTax' THEN 1 ELSE 0 END) AS AFTERTAX
--    FROM 
--    (
--       SELECT PPG.ACCOUNT_NO, 
--              OD.DEF_AMT_PCT_C,
--              COALESCE(HLP.HLP_TEXT,'UNKNOWN') AS DEFERRAL_METHOD, 
--              CASE 
--                              WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%Pre%' THEN 'PreTax' 
--                              WHEN cs.direction = 'EMPLOYEE' AND cs.Roth = 'YES' THEN 'Roth' 
--                              WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%After%' THEN 'AfterTax' 
--              END AS theType
--       FROM TRS_BI_STAGING.DBO.PLAN_PROV_GRP PPG 
--	      --INNER JOIN [WorkplaceExperience].[ref].[EXPlansRpt] ex ON PPG.ACCOUNT_NO = ex.PlanNumber  -- ADDED FOR PRODUCTION
--          INNER JOIN TRS_BI_STAGING.DBO.PLAN_PROVISION PP ON PPG.ENRL_PROV_GRP_I = PP.ENRL_PROV_GRP_I 
--                AND  PPG.RELATED_GRP_TYP_C = 361 
--                AND  PP.PROV_TYP_C = 80 
--          INNER JOIN TRS_BI_STAGING.DBO.OUTSRC_SERVICE OS ON PP.PROVISION_I = OS.OUTSRC_I 
--                AND  OS.SERV_OFFERING_C = '1'
--                AND  OS.SERV_TYP_C = 7 
--          INNER JOIN        
--          (
--                SELECT OUTSRC_I, 
--				       DEF_AMT_PCT_C
--                FROM   TRS_BI_STAGING.DBO.OUTSRC_DEFERRAL OD 
--                WHERE OD.DEF_AMT_PCT_C = ( SELECT MAX(DEF_AMT_PCT_C) 
--				                           FROM TRS_BI_STAGING.DBO.OUTSRC_DEFERRAL OD2 
--										   WHERE OD.OUTSRC_I = OD2.OUTSRC_I 
--										 ) 
--          ) AS OD ON OS.OUTSRC_I = OD.OUTSRC_I 
--          INNER JOIN TRS_BI_STAGING.DBO.PLAN_PROVISION PP2 ON PPG.ENRL_PROV_GRP_I = PP2.ENRL_PROV_GRP_I 
--              AND PPG.RELATED_GRP_TYP_C = 361 
--              AND PP2.PROV_TYP_C = 1066
--          INNER JOIN TRS_BI_STAGING.DBO.PLAN_DEFERRAL_GRP PDG ON PP2.PROVISION_I = PDG.DEF_GRP_I
--              AND PPG.ENRL_PROV_GRP_I = PDG.ENRL_PROV_GRP_I
--          INNER JOIN TRS_BI_STAGING.DBO.PLAN_SRC_DETAIL PSD ON PDG.SRC_I = PSD.SRC_I
--          INNER JOIN TRS_BI_DATAWAREHOUSE.DBO.DIMCONTRIBUTIONSOURCE CS ON PSD.SRC_I = CS.SRC_I
--              AND CS.ACTIVERECORDFLAG = 1
--          LEFT JOIN TRS_BI_STAGING.DBO.HELPER2 HLP ON OD.DEF_AMT_PCT_C = HLP.HLP_VALUE 
--              AND  HLP.HLP_CODE = 'DEFMETHD' 
--              AND  HLP.PKG_ID = 'TDA'
--    ) AS A

--    GROUP BY  ACCOUNT_NO, 
--             DEF_AMT_PCT_C, 
--			 DEFERRAL_METHOD
--  ) AS A
--)
--, cte2 AS
--(
--  SELECT ACCOUNT_NO, 
--       [AUTO REBALANCE] AS AutoRebalance,                                                               
--       [SELF DIRECTED ACCOUNT] AS SDA,                                                           
--       [PORTFOLIO XPRESS] AS PortfolioXpress,                                                                
--       [RECURRING FUND TRANSFERS] AS FundTransfer,                                                        
--       [MANAGED ADVICE (DCMA)] AS DCMA,                                                           
--       [PCRA] AS PCRA,                                                                            
--       [SECUREPATH FOR LIFE] AS SecurePathForLife,                                                             
--       [DEFERRAL AUTO INCREASE] AS AutoIncrease,                                                          
--       [CUSTOM PORTFOLIOS] AS CustomPortfolios
--  FROM [WorkplaceExperience].[ref].[tab_PlanFlags] sourceTable
--    PIVOT(
--           MIN([enabled]) FOR [Service] IN  ([AUTO REBALANCE],                                                               
--                                             [SELF DIRECTED ACCOUNT],                                                           
--                                             [PORTFOLIO XPRESS],                                                                
--                                             [RECURRING FUND TRANSFERS],                                                        
--                                             [MANAGED ADVICE (DCMA)],                                                           
--                                             [PCRA],                                                                            
--                                             [SECUREPATH FOR LIFE],                                                             
--                                             [DEFERRAL AUTO INCREASE],                                                          
--                                             [CUSTOM PORTFOLIOS])
--     ) AS pivotTable    
--)
--, cte3 AS
--(
--   SELECT	A.ACCOUNT_NO,
--		 MAX(CASE WHEN THETYPE = 'PreTax' then 1 else 0 end) as PretaxContributionFlag,
--		 MAX(CASE WHEN THETYPE = 'Roth' THEN 1 ELSE 0 END) AS RothContributionFlag,
--		 MAX(CASE WHEN THETYPE = 'AfterTax' THEN 1 ELSE 0 END) AS AfterTaxContributionFlag
--   FROM
--   (
--       SELECT   a.account_no, 
--                CASE 
--                     WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%Pre%' THEN 'PreTax' 
--                     WHEN cs.direction = 'EMPLOYEE' AND cs.Roth = 'YES' THEN 'Roth' 
--                     WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%After%' THEN 'AfterTax' 
--   				  else 'Other'
--                END AS theType
--       FROM     trs_bi_staging.dbo.plan_prov_grp a 
--   	     INNER JOIN trs_bi_staging.dbo.plan_provision b ON a.enrl_prov_grp_i = b.enrl_prov_grp_i
--         INNER JOIN TRS_BI_DataWarehouse.dbo.dimContributionSource cs ON b.provision_i = cs.src_i
--       WHERE   a.RELATED_GRP_TYP_C = 361
--          AND  b.PROV_TYP_C = 13  -- when provision_i is contribution source
--          AND 	CS.DIRECTION = 'EMPLOYEE'
--   ) AS A
--   GROUP BY A.ACCOUNT_NO
--)
SELECT d.[dimPlanId]
      ,d.CaseNumber   -- ADDED THIS COMMENTED OUT BELOW FOR PRODUCTION
    --  ,CASE WHEN w.PlanNumberEnv IS NOT NULL THEN w.PlanNumberEnv
	   --     ELSE 
	   --       CASE WHEN LEN(d.ContractNumber) = 8 THEN
	   --            CASE WHEN d.[ContractNumber] = 'TA069793' AND d.AffiliateNumber = '00001' THEN 'TA069793ME00001'
			 --           WHEN d.[ContractNumber] = 'TT080191' AND d.AffiliateNumber = '00001' THEN 'TT080191DB00001'
				--	    WHEN d.[ContractNumber] = 'TI097839' AND d.AffiliateNumber = '00001' THEN 'TI097839JM00001'
				--		WHEN d.[ContractNumber] = 'TT069432' AND d.AffiliateNumber = '00001' THEN 'TT069432JM00001'
				--		WHEN d.[ContractNumber] = 'TT069433' AND d.AffiliateNumber = '00001' THEN 'TT069433JM00001'
							 									 
				--		WHEN d.[ContractNumber] = 'TI097756' AND d.AffiliateNumber = '00001' THEN 'TI097756EX00001'
				--		WHEN d.[ContractNumber] = 'TO097791' AND d.AffiliateNumber = '00001' THEN 'TO097791EX00001'
				--		WHEN d.[ContractNumber] = 'TT069365' AND d.AffiliateNumber = '00001' THEN 'TT069365EX00001'
	   --                 ELSE d.ContractNumber + 'JW' + d.AffiliateNumber
				--	END
			 --      WHEN LEN(d.ContractNumber) = 7 THEN
			 --      CASE WHEN d.[ContractNumber] = 'QK63040' AND d.AffiliateNumber = '00001' THEN 'QK63040SK 00001' 
			 --           WHEN d.[ContractNumber] = 'QK63041' AND d.AffiliateNumber = '00001' THEN 'QK63041LH 00001'						
			 --           ELSE d.ContractNumber + 'JW ' + d.AffiliateNumber
				--	END
		  --         WHEN LEN(d.ContractNumber) = 6 THEN d.ContractNumber + 'JW  ' + d.AffiliateNumber											  
			 --      WHEN LEN(d.ContractNumber) = 5 THEN d.ContractNumber + 'JW   ' + d.AffiliateNumber
		  --     END
		  --END AS [CaseNumber]     
      ,d.[ContractNumber]   
      ,d.[PlanName]
	  ,d.ERName AS CompanyName  
	  ,d.MultiDivision
	  ,d.MultiPartDivision
	  
	  ,COALESCE(c.OutsourceDeferralFlag, 0) AS OutsourceDeferralFlag
	  ,COALESCE(c.DeferralMethod, 'NA') AS DeferralMethod
	
      ,COALESCE(c.PreTaxFlag, 0) AS PreTaxFlag
      ,COALESCE(c.RothFlag, 0) AS RothFlag
      ,COALESCE(c.AfterTaxFlag, 0) AS AfterTaxFlag

	  ,COALESCE(c.AutoRebalance, 0) AS AutoRebalance
	  ,COALESCE(c.AutoIncrease, 0) AS AutoIncrease
	  ,COALESCE(c.CustomPortfolios, 0) AS CustomPortfolios
	  ,COALESCE(c.DCMA, 0) AS DCMA
	  ,COALESCE(c.FundTransfer, 0) AS FundTransfer
	  ,COALESCE(c.PCRA, 0) AS PCRA
	  ,COALESCE(c.PortfolioXpress, 0) AS PortfolioXpress
	  ,COALESCE(c.SDA, 0) AS SDA
	  ,COALESCE(c.SecurePathForLife, 0) AS SecurePathForLife

	  ,COALESCE(c.PretaxContributionFlag, 0) AS PretaxContributionFlag
	  ,COALESCE(c.RothContributionFlag, 0) AS RothContributionFlag
	  ,COALESCE(c.AfterTaxContributionFlag, 0) AS AfterTaxContributionFlag
  FROM  [TRS_BI_DataWarehouse].[dbo].[dimPlan] d WITH (NOLOCK) 
    --INNER JOIN [WorkplaceExperience].[ref].[EXPlansRpt] ex ON d.CaseNumber = ex.PlanNumber  -- ADDED FOR PRODUCTION
    --LEFT JOIN [WorkplaceExperience].[wxstg].[WXPlansRef] w WITH (NOLOCK) ON d.CaseNumber = w.PlanNumber   -- COMMENTED OUT FOR PRODUCTION
    LEFT JOIN WorkplaceExperience.ref.tab_PlanLevelFlags c ON d.CaseNumber = c.CaseNumber
	--LEFT JOIN cte1 c ON d.CaseNumber = c.ACCOUNT_NO 
	--LEFT JOIN cte2 p WITH (NOLOCK) ON d.CaseNumber = p.ACCOUNT_NO
	--LEFT JOIN cte3 k ON k.ACCOUNT_NO = d.CaseNumber
  --WHERE d.BusinessLine <> 'AEGON'
  --  AND d.CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)

GO
/****** Object:  Table [ref].[tab_ForNewEnrollment]    Script Date: 6/17/2021 10:57:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_ForNewEnrollment](
	[MASTER_CASE_NO] [varchar](20) NOT NULL,
	[SOC_SEC_NO] [varchar](12) NOT NULL,
	[MinMonthEnd] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[tab_factNewEnrollment]    Script Date: 6/17/2021 10:57:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE     VIEW [dbo].[tab_factNewEnrollment]
AS

SELECT     c1.dimPlanId,
           d1.dimDateId,
           b1.dimParticipantId,
		   COALESCE( pd.dimParticipantDivisionId, 0)  AS dimDivisionId,
	       CASE WHEN b1.EmploymentStatus = 'ACTIVE' THEN 1 ELSE 0 END AS dimEmploymentStatusId,
		   a1.SOC_SEC_NO
FROM WorkplaceExperience.ref.tab_ForNewEnrollment a1
--INNER JOIN [WorkplaceExperience].[ref].[EXPlans] ex ON a1.MASTER_CASE_NO = ex.PlanNumber  -- ADDED FOR PRODUCTION
INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipant b1 WITH (NOLOCK) ON a1.MASTER_CASE_NO = b1.CASENUMBER AND a1.SOC_SEC_NO = b1.SocialSecurityNumber
      AND a1.MinMonthEnd BETWEEN b1.EffectiveFrom AND COALESCE(b1.EffectiveTo, '12/31/9999') 
INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan c1 WITH (NOLOCK) ON a1.MASTER_CASE_NO = c1.CASENUMBER
   --   AND c1.BusinessLine <> 'AEGON' 
	  --AND c1.CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)
	  AND a1.MinMonthEnd BETWEEN c1.EffectiveFrom AND COALESCE(c1.EffectiveTo, '12/31/9999') 
INNER JOIN TRS_BI_DataWarehouse.dbo.dimDate d1 WITH (NOLOCK) ON a1.MinMonthEnd = d1.DATEVALUE
INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd ON pd.dimParticipantId = b1.dimParticipantId	   
--LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pd2 WITH (NOLOCK) ON pd.EmployeeDivisionCode = pd2.DivisionCode AND pd.CaseNumber = pd2.ACCOUNT_NO
WHERE NOT (b1.MultiDivisionalParticipant = 'YES' AND b1.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED')


GO
/****** Object:  Table [ref].[explans]    Script Date: 6/17/2021 10:57:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[explans](
	[PlanNumber] [varchar](20) NOT NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[LoadDatetime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[source_for_tab_factDeferral]    Script Date: 6/17/2021 10:57:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[source_for_tab_factDeferral]
AS
WITH ctePlanDeferral AS
(
  SELECT DISTINCT A.ACCOUNT_NO
      ,C.ENRL_PROV_GRP_I
      ,C.DEF_GRP_I                                -- one plan number may have multiple rows for a def_grp_i/src_i/src_typ_c
      ,C.SRC_I
      ,C.DEF_GRP_NM  
      ,D.DOC_NM
	  ,D.SRC_TYP_C
  FROM [TRS_BI_Staging].[dbo].[PLAN_PROV_GRP] A WITH (NOLOCK) 
    INNER JOIN [WorkplaceExperience].[ref].[EXPlans] ex ON A.ACCOUNT_NO = ex.PlanNumber  -- added for production
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] B WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = B.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_DEFERRAL_GRP] C WITH (NOLOCK)
		ON B.PROVISION_I = C.DEF_GRP_I
	   AND A.ENRL_PROV_GRP_I = C.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_SRC_DETAIL] D WITH (NOLOCK)
		ON C.SRC_I = D.SRC_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] E WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = E.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[OUTSRC_SERVICE] F WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = E.ENRL_PROV_GRP_I
	   AND E.PROVISION_I = F.OUTSRC_I
	INNER JOIN [TRS_BI_Staging].[dbo].[OUTSRC_DEFERRAL] G WITH (NOLOCK)
		ON F.OUTSRC_I = G.OUTSRC_I
  WHERE E.PROV_TYP_C = 80
    AND F.SERV_TYP_C = 7
    AND F.SERV_OFFERING_C = '1'
    AND G.SERV_TYP_C = 7
    AND A.ENRL_STAT_C = 7
    AND B.RELATED_TYP_C IN (26,113)
    --AND c.DEF_GRP_NM NOT LIKE '%bonus%' AND c.DEF_GRP_NM NOT LIKE '%Annual%'  --Replaced this with the following condition to exclude bonus
	and C.DEF_GRP_SEQ_N = (SELECT MIN(DEF_GRP_SEQ_N) 
	                       FROM TRS_BI_Staging.dbo.PLAN_DEFERRAL_GRP F
					       WHERE C.ENRL_PROV_GRP_I = F.ENRL_PROV_GRP_I 
						       AND C.SRC_I = F.SRC_I
						  )
)
, cteEmployeeDeferral AS
(
  SELECT a.CaseNumber
	  ,a.ENRL_PROV_GRP_I
	  ,a.PART_ENRL_I
	  ,a.SOC_SEC_NO	  
	  ,a.DIV_I
	  ,a.DEF_GRP_I
	  ,a.DEF_GRP_NM
	  ,a.DOC_NM
	  ,a.SRC_I
	  ,a.SRC_TYP_C
	  ,a.EFF_D
	  ,a.MOD_TS
	  ,a.STAT_C
	  ,a.DEF_P
	  ,a.DEF_A
	  ,ROW_NUMBER() OVER(PARTITION BY PART_ENRL_I, ENRL_PROV_GRP_I, DEF_GRP_I, SRC_I, [DIV_I]
										ORDER BY EFF_D DESC) AS rownum1
	  ,ROW_NUMBER() OVER(PARTITION BY PART_ENRL_I, ENRL_PROV_GRP_I, DEF_GRP_I, SRC_I,[DIV_I]                                        
										ORDER BY STAT_C ASC, EFF_D DESC) AS rownum2	  	  
  FROM
  (
    SELECT  b.ACCOUNT_NO AS CaseNumber			
		,b.ENRL_PROV_GRP_I -- dimplanId
		,b.DEF_GRP_I
		,b.DEF_GRP_NM
		,b.SRC_I
		,b.SRC_TYP_C
		,b.DOC_NM
		,c.PART_ENRL_I     --dimParticipantId
		,c.SOC_SEC_NO        --- newly added to handle dimParticipantId=0 (their PART_ENRL_I=0 in dimParticipant table) later
		,CASE WHEN d.[MULTI_PART_DIV_C] = 0 THEN 0
              ELSE c.[DIV_I]
         END AS DIV_I
		,c.EFF_D           --dimDateId
		,c.MOD_TS
		,c.STAT_C
		,CASE WHEN c.DEF_P = 0 THEN NULL ELSE c.DEF_P END AS DEF_P
	    ,CASE WHEN c.DEF_A = 0 THEN NULL ELSE c.DEF_A END AS DEF_A		
		,ROW_NUMBER() OVER(PARTITION BY c.PART_ENRL_I, b.ENRL_PROV_GRP_I, B.DEF_GRP_I, B.SRC_I, 
		                                CASE WHEN d.[MULTI_PART_DIV_C] = 0 THEN 0
                                            ELSE c.[DIV_I]
                                        END, 
										c.EFF_D  ORDER BY c.[MOD_TS] DESC) AS rownum		 
    FROM ctePlanDeferral b		
	  INNER JOIN [TRS_BI_Staging].[dbo].[PART_DEF_DATA] c WITH (NOLOCK)	ON b.ENRL_PROV_GRP_I = c.ENRL_PROV_GRP_I
	     AND b.SRC_I = c.SRC_I
	     AND b.DEF_GRP_I = c.DEF_GRP_I
	  INNER JOIN [TRS_BI_Staging].[dbo].[CASE_DATA] d WITH(NOLOCK) ON  b.[ACCOUNT_NO] = d.[CASE_NO]	     
		
   ) a
   WHERE rownum = 1    --- get the corresponding last record for the EFF_D    
)
SELECT
	  a.CaseNumber
	  ,a.ENRL_PROV_GRP_I
	  ,a.PART_ENRL_I
	  ,a.SOC_SEC_NO	  
	  ,a.DIV_I
	  ,a.DEF_GRP_I
	  ,a.DEF_GRP_NM
	  ,a.DOC_NM
	  ,a.SRC_I
	  ,a.SRC_TYP_C
	  ,a.EFF_D
	  ,a.MOD_TS
	  ,a.DEF_P
	  ,a.DEF_A
      ,CASE WHEN (ROW_NUMBER() OVER(PARTITION BY CaseNumber, a.PART_ENRL_I, a.DIV_I, a.SRC_I, a.DEF_GRP_I, EOMONTH(a.EFF_D) ORDER BY a.EFF_D DESC)) = 1 THEN 1 ELSE 0 END AS MonthEndFlag
	  ,CASE WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%Pre%'  THEN 'PreTax' 
			WHEN cs.direction = 'EMPLOYEE' AND cs.Roth = 'YES' THEN 'Roth'
		    WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%After%' THEN 'AfterTax'
		END AS theType
	  ,CAST(CONVERT(char(8),a.EFF_D,112) AS INT) AS EffDateId
FROM cteEmployeeDeferral a  
  INNER JOIN TRS_BI_DataWarehouse.dbo.dimContributionSource cs WITH (NOLOCK) ON cs.SRC_I = a.SRC_I 
		     AND CASE WHEN a.EFF_D < '2010-10-01' THEN '2010-10-01' ELSE a.EFF_D END BETWEEN cs.EffectiveFrom AND COALESCE(cs.EffectiveTo, '12/31/9999')
WHERE a.rownum2 <= a.rownum1
  

GO
/****** Object:  Table [ref].[tab_factDeferral]    Script Date: 6/17/2021 10:57:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_factDeferral](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DIV_I] [numeric](17, 0) NULL,
	[DEF_GRP_I] [numeric](17, 0) NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[DEF_GRP_NM] [varchar](80) NULL,
	[SRC_I] [numeric](17, 0) NULL,
	[DEF_P] [numeric](6, 3) NULL,
	[DEF_A] [numeric](13, 2) NULL,
	[DOC_NM] [varchar](50) NULL,
	[CaseNumber] [varchar](20) NULL,
	[ENRL_PROV_GRP_I] [numeric](17, 0) NULL,
	[PART_ENRL_I] [numeric](17, 0) NULL,
	[SRC_TYP_C] [smallint] NULL,
	[EFF_D] [date] NULL,
	[MOD_TS] [datetime2](6) NULL,
	[MonthEndFlag] [tinyint] NULL,
	[TheType] [varchar](10) NULL,
	[EffDateId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[tab_factBalance_PPT]    Script Date: 6/17/2021 10:57:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE    VIEW [dbo].[tab_factBalance_PPT] 
AS
SELECT 
       f.dimplanId
       ,f.dimDateId
       ,f.dimParticipantId
	   ,f.SocialSecurityNumber
	   ,f.dimEmploymentStatusId
	   ,f.dimAgeId

	   ,f.dimDivisionId

	   ,f.useAutoRebalance
	   ,f.usePortfolioXpress
	   ,f.useEStatement
	   ,f.useEInvestMaterials
	   ,f.useConversionMaterials
	   ,f.useCustomPortfolio
	   ,f.useEConfirm
	   ,f.useEnrollMaterials
	   ,f.useManagedAccount
	   ,f.useManagedAdvice
	   ,f.useOnTrackMaterials
	   ,f.usePlanRelatedMeterials
	   ,f.useRecurringTransfers
	   ,f.useRequiredNotices

	   ,f.dimOutlookId              
       ,f.dimOutlookForecastId      
       ,f.dimDiversificationId

	   ,f.BalanceIndicator
	   ,f.Balance
	   ,f.PreTaxEligible

       ,SUM(b.DEF_P) AS DEF_P
	   ,SUM(b.DEF_A) AS DEF_A

	   ,CASE WHEN SUM(b.DEF_A) > 0 OR SUM(b.DEF_P) >0 THEN 1 ELSE 0 END AS ContributingFlag

	   ,SUM(CASE WHEN b.TheType = 'PreTax' THEN b.DEF_P END) AS PreTax_P
	   ,SUM(CASE WHEN b.TheType = 'PreTax' THEN b.DEF_A END) AS PreTax_A         
	   ,SUM(CASE WHEN b.TheType = 'AfterTax' THEN b.DEF_P END) AS AfterTax_P
	   ,SUM(CASE WHEN b.TheType = 'AfterTax' THEN b.DEF_A END) AS AfterTax_A				  
	   ,SUM(CASE WHEN b.TheType = 'Roth' THEN b.DEF_P END) AS Roth_P
       ,SUM(CASE WHEN b.TheType = 'Roth' THEN b.DEF_A END) AS Roth_A  
	   
FROM
(
  SELECT 
      f.dimplanId                     
	  ,f.dimdateId	                     	              
	  ,f.dimParticipantId
	  ,f.SocialSecurityNumber
	  ,CASE WHEN d.EmploymentStatus = 'ACTIVE' THEN 1 
	        WHEN d.EmploymentStatus = 'TERMED' THEN 0
	        ELSE -1 
	   END AS dimEmploymentStatusId 
        
	  ,f.dimAgeId

	  ,COALESCE(pd.dimParticipantDivisionId, 0) AS dimDivisionId

	  ,CAST(CASE WHEN f.[AutoRebalanceId] = 0 THEN 0 ELSE 1 END AS BIT) AS useAutoRebalance      
      ,CAST(CASE WHEN f.[PortfolioXpressId] = 0 THEN 0 ELSE 1 END AS BIT) AS usePortfolioXpress    
      ,CAST(CASE WHEN f.[EStatementsId] = 0 THEN 0 ELSE 1 END  AS BIT) AS useEStatement
      ,CAST(CASE WHEN f.[EInvestMaterialsId] = 0 THEN 0 ELSE 1 END  AS BIT) AS useEInvestMaterials
	  ,CAST(CASE WHEN f.ConversionMaterialId = 0 THEN 0 ELSE 1 END  AS BIT) AS useConversionMaterials
	  ,CAST(CASE WHEN f.CustomPortfolioId = 0 THEN 0 ELSE 1 END  AS BIT) AS useCustomPortfolio
	  ,CAST(CASE WHEN f.EConfirmId = 0 THEN 0 ELSE 1 END  AS BIT) AS useEConfirm
	  ,CAST(CASE WHEN f.EnrollmentMaterialId = 0 THEN 0 ELSE 1 END  AS BIT) AS useEnrollMaterials
	  ,CAST(CASE WHEN f.ManagedAccountId = 0 THEN 0 ELSE 1 END  AS BIT) AS useManagedAccount
	  ,CAST(CASE WHEN f.ManagedAdviceId = 0 THEN 0 ELSE 1 END  AS BIT) AS useManagedAdvice
	  ,CAST(CASE WHEN f.OnTrackEdMaterialsId = 0 THEN 0 ELSE 1 END  AS BIT) AS useOnTrackMaterials
	  ,CAST(CASE WHEN f.PlanRelatedMaterialsId = 0 THEN 0 ELSE 1 END  AS BIT) AS usePlanRelatedMeterials
	  ,CAST(CASE WHEN f.RecurringTransfersId = 0 THEN 0 ELSE 1 END  AS BIT) AS useRecurringTransfers
	  ,CAST(CASE WHEN f.[RequiredNoticesId] = 0 THEN 0 ELSE 1 END  AS BIT) AS useRequiredNotices
	   
	  ,f.[dimOutlookId]              
      ,f.[dimOutlookForecastId]      
      ,f.[dimDiversificationId]
	  
	  ,f.BalanceIndicator
	  ,f.PreTaxEligible

	 
	  ,f.CaseNumber
	  ,d.PART_ENRL_I

	  ,d.MultiDivisionalParticipant
	  ,pd.DIV_I
	  
	  --,MAX(Balance)  AS Balance	--- Since factParticipant is in dimPlanId-dimDateId-dimParticipantId grain (except for dimParticipantId=0), no aggregation is needed. Using group by to avoid doubling balance for participants with two same divisions   
      ,Balance               -- removed aggregation because the join condition for division tables changed below from DIV_I, so won't have duplicate records with DIV_I=0
  FROM TRS_BI_Datawarehouse.dbo.[factParticipant] f WITH (NOLOCK)
    --INNER JOIN [WorkplaceExperience].[ref].[EXPlans] ex ON f.CaseNumber = ex.PlanNumber  -- ADDED FOR PRODUCTION
    INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan p1 WITH (NOLOCK)  ON f.dimPlanId = p1.dimPlanId AND f.dimEmployerAccountId = 0 
	               AND (f.BalanceIndicator = 1 OR f.dimEmploymentStatusId =1)    
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipant d WITH (NOLOCK) ON d.dimParticipantId = f.dimParticipantId  	
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd WITH (NOLOCK) ON pd.dimParticipantId = d.dimParticipantId
	--LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pp WITH (NOLOCK) ON pd.EmployeeDivisionCode = pp.DivisionCode AND pd.CaseNumber = pp.ACCOUNT_NO		  
  WHERE NOT (d.MultiDivisionalParticipant = 'YES' AND d.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED')    	   
) f
OUTER APPLY 
(
  	  SELECT TheType, DEF_P, DEF_A
	  FROM
	  ( 
	    SELECT 
		  --   b.CaseNumber
	      --   ,b.PART_ENRL_I
			 --,b.DIV_I
			 --,b.EFF_D
			 
			 b.TheType

			 ,MAX(b.DEF_P) AS DEF_P
			 ,MAX(b.DEF_A) AS DEF_A	

			 ,ROW_NUMBER() OVER (PARTITION BY CaseNumber, PART_ENRL_I, b.TheType ORDER BY EFF_D DESC) AS row_id
	   
	     FROM WorkplaceExperience.ref.tab_factDeferral b WITH (NOLOCK)	
	     WHERE  f.PreTaxEligible = 1  
		    AND f.dimEmploymentStatusId = 1   -- added this as a workaround for the issue of PreTaxEligible=1 with terminated employment status. This excludes UNKNOWN status.
		    AND b.MonthEndFlag = 1
		    AND b.CaseNumber = f.CaseNumber 		   
		    AND  f.PART_ENRL_I = b.PART_ENRL_I
		    AND  f.dimDateId >= b.EffDateId	   
		    AND (f.MultiDivisionalParticipant = 'NO' OR (f.MultiDivisionalParticipant = 'YES' AND f.DIV_I = b.DIV_I))  -- same division only if it's multiDivision    
	     GROUP BY 
		     b.CaseNumber
	         ,b.PART_ENRL_I
			 ,CASE WHEN f.MultiDivisionalParticipant = 'YES' THEN b.DIV_I END
			 ,b.EFF_D
			 ,b.TheType
	  ) c
	   WHERE row_id = 1    
	) b
GROUP BY
 f.dimplanId
       ,f.dimDateId
       ,f.dimParticipantId
	   ,f.SocialSecurityNumber
	   ,f.dimEmploymentStatusId
	   ,f.dimAgeId

	   ,f.dimDivisionId

	   ,f.useAutoRebalance
	   ,f.usePortfolioXpress
	   ,f.useEStatement
	   ,f.useEInvestMaterials
	   ,f.useConversionMaterials
	   ,f.useCustomPortfolio
	   ,f.useEConfirm
	   ,f.useEnrollMaterials
	   ,f.useManagedAccount
	   ,f.useManagedAdvice
	   ,f.useOnTrackMaterials
	   ,f.usePlanRelatedMeterials
	   ,f.useRecurringTransfers
	   ,f.useRequiredNotices

	   ,f.dimOutlookId              
       ,f.dimOutlookForecastId      
       ,f.dimDiversificationId

	   ,f.BalanceIndicator
	   ,f.Balance
	   ,f.PreTaxEligible

GO
/****** Object:  Table [ref].[tab_BIHelper2]    Script Date: 6/17/2021 10:57:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_BIHelper2](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[hlp_code] [varchar](20) NULL,
	[hlp_val_1] [varchar](20) NULL,
	[hlp_val_2] [varchar](20) NULL,
	[hlp_val_3] [varchar](20) NULL,
	[hlp_text_1] [varchar](20) NULL,
	[hlp_text_2] [varchar](20) NULL,
	[hlp_text_3] [varchar](50) NULL,
	[hlp_text_4] [varchar](20) NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[tab_dimTransactionODSP]    Script Date: 6/17/2021 10:57:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[tab_dimTransactionODSP]
AS
WITH cte1 AS
(
   SELECT a.id AS dimTransactionId 
        ,'Distribution' AS TransactionCategory
        ,a.hlp_text_3 AS TransactionType
		, NULL AS TransactionSubType
   FROM WorkplaceExperience.ref.tab_BIHelper2 a WITH (NOLOCK)
   WHERE a.hlp_code = 'DIST_TYPE'
)
,cte2 AS
(
    SELECT  'MoneyIn' AS TransactionCategory
	        ,'Rollover' AS TransactionType        
	        ,NULL AS TransactionSubType
	UNION ALL
	SELECT DISTINCT  
	        'MoneyIn' AS TransactionCategory
			,'Takeover' AS TransactionType
	  	    ,c.[HLP_TEXT] AS TransactionSubType
    FROM [CRDBTTBISQLP04\SQL02].[TRS_BI_Pre_Staging].[dbo].[BILL_REMIT_DETAIL] b WITH (NOLOCK)
	     INNER JOIN [CRDBTTBISQLP04\SQL02].[TRS_BI_Pre_Staging].[dbo].[HELPER2] c WITH (NOLOCK) ON b.[TAKEOVER_TYP_C] = CAST(c.[HLP_VALUE] AS [int]) 
		    AND c.[HLP_CODE] = 'REM_1006'
            AND c.[HLP_VALUE] != ''
    WHERE [TAKEOVER_TYP_C] IN (1, 2, 17)
)
SELECT dimTransactionId
      ,TransactionCategory
	  ,TransactionType
	  ,TransactionSubType
FROM cte1 a
UNION ALL
SELECT 100 + ROW_NUMBER() OVER (ORDER BY TransactionCategory, TransactionType, TransactionSubType) AS dimTransactionId
       ,TransactionCategory
	   ,TransactionType
	   ,TransactionSubType
FROM cte2 b
UNION ALL
SELECT 200 AS dimTransactionId
       ,'Loan' AS TransactionCategory
	   ,NULL AS TransactionType
	   ,NULL AS TransactionSubType

GO
/****** Object:  Table [ref].[tab_TransactDetailCERollover]    Script Date: 6/17/2021 10:57:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_TransactDetailCERollover](
	[BUSINESS_LINE] [varchar](10) NULL,
	[MASTER_CASE_NO] [varchar](20) NULL,
	[TR_REF_NO] [varchar](14) NULL,
	[TR_NO] [varchar](4) NULL,
	[EFF_DT] [date] NULL,
	[SOC_SEC_NO] [varchar](12) NULL,
	[Amount] [numeric](38, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[tab_BillRemitDetail]    Script Date: 6/17/2021 10:57:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_BillRemitDetail](
	[BUSINESS_LINE] [varchar](10) NULL,
	[CASE_NO] [varchar](20) NULL,
	[SOC_SEC_NO] [varchar](12) NULL,
	[TR_REF_NO] [varchar](14) NULL,
	[TAKEOVER_TYP_C] [int] NULL,
	[HLP_TEXT] [varchar](80) NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[tab_factRolloverContractExchange]    Script Date: 6/17/2021 10:57:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE      VIEW [dbo].[tab_factRolloverContractExchange]
AS

SELECT  e.dimPlanId
       ,COALESCE(d.dimParticipantId, 0) AS dimParticipantId
	   ,a.[SOC_SEC_NO]
	   ,COALESCE(pd.dimParticipantDivisionId, 0) AS dimDivisionId
	   ,CASE WHEN EOMONTH(a.EFF_DT)  = EOMONTH(GETDATE()) THEN CAST(CONVERT(CHAR(8), a.EFF_DT,112) AS INT) 
			        ELSE CAST(CONVERT(CHAR(8), EOMONTH(a.EFF_DT),112) AS INT)  
				END AS dimDateId
	   ,CASE WHEN d.EmploymentStatus = 'ACTIVE' THEN 1 ELSE 0 END AS dimEmploymentStatus     
	    
       ,t.dimTransactionId

	   ,SUM(a.Amount) AS Amount
FROM WorkplaceExperience.ref.tab_TransactDetailCERollover a
--INNER JOIN [WorkplaceExperience].[ref].[EXPlans] ex ON a.[MASTER_CASE_NO] = ex.PlanNumber  -- ADDED FOR PRODUCTION
LEFT JOIN WorkplaceExperience.ref.tab_BillRemitDetail b ON a.[MASTER_CASE_NO] = b.[CASE_NO]       
	   AND a.SOC_SEC_NO = b.SOC_SEC_NO
       AND a.[TR_REF_NO] = b.[TR_REF_NO]
       AND a.[BUSINESS_LINE] = b.[BUSINESS_LINE]
INNER JOIN WorkplaceExperience.dbo.[tab_dimTransactionODSP] t ON t.TransactionCategory = 'MoneyIn' 
       AND t.TransactionType = CASE WHEN a.[TR_NO] = '1007' THEN 'Rollover' WHEN a.[TR_NO] = '1006' THEN 'Takeover' END 
       AND (a.[TR_NO] = '1007' OR  b.[HLP_TEXT] = t.TransactionSubType) 
INNER JOIN [TRS_BI_DataWarehouse].dbo.[dimPlan] e WITH (NOLOCK) ON a.[MASTER_CASE_NO] = e.[CaseNumber]
       AND CAST(a.EFF_DT AS DATE) BETWEEN e.EffectiveFrom AND COALESCE(e.EffectiveTo, '12/31/9999')
LEFT JOIN [TRS_BI_DataWarehouse].dbo.[dimParticipant] d WITH (NOLOCK) ON a.[MASTER_CASE_NO] = d.[CaseNumber]
	   AND a.SOC_SEC_NO = d.SocialSecurityNumber
	   AND CAST(a.EFF_DT AS DATE) BETWEEN d.EffectiveFrom AND COALESCE(d.EffectiveTo, '12/31/9999')
LEFT JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd ON pd.dimParticipantId = d.dimParticipantId	
   AND NOT (d.MultiDivisionalParticipant = 'YES' AND d.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED')   
--LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pd2 WITH (NOLOCK) ON pd.DIV_I = pd2.DIV_I	 
WHERE 
   --e.BusinessLine <> 'AEGON' 
   --AND e.CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)
   a.[TR_NO] = '1006' AND b.[TAKEOVER_TYP_C] IN (1, 2, 17) OR a.[TR_NO] = '1007' 
GROUP BY e.dimPlanId
       ,COALESCE(d.dimParticipantId, 0)
	   ,a.[SOC_SEC_NO]
	   ,COALESCE(pd.dimParticipantDivisionId, 0)
	   ,CASE WHEN EOMONTH(a.EFF_DT)  = EOMONTH(GETDATE()) THEN CAST(CONVERT(CHAR(8), a.EFF_DT,112) AS INT) 
			        ELSE CAST(CONVERT(CHAR(8), EOMONTH(a.EFF_DT),112) AS INT)  
				END
	   ,CASE WHEN d.EmploymentStatus = 'ACTIVE' THEN 1 ELSE 0 END        
       ,t.dimTransactionId

GO
/****** Object:  Table [ref].[tab_WithdrawalDetail]    Script Date: 6/17/2021 10:57:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_WithdrawalDetail](
	[SOC_SEC_NO] [varchar](12) NULL,
	[CASE_NO] [varchar](20) NULL,
	[dimDateId] [int] NULL,
	[EFF_DT] [date] NULL,
	[dimWithdrawalTypeId] [int] NULL,
	[TOT_WD_AMT] [numeric](38, 2) NULL,
	[EE_PAYOUT_AMT] [numeric](38, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[tab_factWithdrawals]    Script Date: 6/17/2021 10:58:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE    VIEW [dbo].[tab_factWithdrawals]
AS
SELECT  p.dimPlanId   
       ,COALESCE(pt.dimParticipantId, 0) AS dimParticipantId
	   ,w.SOC_SEC_NO  
	   ,w.dimDateId
	   ,COALESCE(pd.dimParticipantDivisionId, 0) AS dimDivisionId
	   ,CASE WHEN pt.EmploymentStatus = 'ACTIVE' THEN 1 ELSE 0 END AS dimEmploymentStatus
	   ,w.dimWithdrawalTypeId
       ,w.[TOT_WD_AMT] as TOT_WD_AMT 
       ,w.[EE_PAYOUT_AMT] as EE_PAYOUT_AMT  -- this is the correct column to use       
  FROM WorkplaceExperience.ref.tab_WithdrawalDetail w WITH (NOLOCK)   
    --INNER JOIN [WorkplaceExperience].[ref].[EXPlans] ex ON w.CASE_NO = ex.PlanNumber  -- ADDED FOR PRODUCTION
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan p WITH (NOLOCK) ON w.CASE_NO = p.CaseNumber 
	    --   AND p.BusinessLine <> 'AEGON' 
		   --AND p.CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)
		   AND w.EFF_DT BETWEEN p.EffectiveFrom AND COALESCE(p.EffectiveTo, '12/31/9999')
	LEFT JOIN TRS_BI_DataWarehouse.dbo.dimParticipant pt WITH (NOLOCK) ON w.SOC_SEC_NO = pt.SocialSecurityNumber AND pt.CaseNumber = w.CASE_NO AND w.EFF_DT BETWEEN pt.EffectiveFrom AND COALESCE(pt.EffectiveTo, '12/31/9999')
	LEFT JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd ON pd.dimParticipantId = pt.dimParticipantId
	    AND NOT (pt.MultiDivisionalParticipant = 'YES' AND pt.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED') 
	--LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pd2 WITH (NOLOCK) ON pd.DIV_I = pd2.DIV_I AND CAST(w.EFF_DT AS DATE) BETWEEN pd2.EffectiveFrom AND COALESCE(pd2.EffectiveTo, '12/31/9999')			    		
  


GO
/****** Object:  Table [ref].[tab_TransactDetailContribution]    Script Date: 6/17/2021 10:58:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_TransactDetailContribution](
	[BUSINESS_LINE] [varchar](10) NULL,
	[MASTER_CASE_NO] [varchar](20) NULL,
	[SOC_SEC_NO] [varchar](12) NULL,
	[dimDateId] [int] NULL,
	[DateValue] [date] NULL,
	[direction] [varchar](10) NULL,
	[theType] [varchar](8) NULL,
	[isMandatory] [int] NULL,
	[Amt] [numeric](38, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[tab_factContribution]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--============== 3. View: [dbo].[tab_factContribution]

CREATE      VIEW [dbo].[tab_factContribution]
AS

      SELECT  e.dimPlanId
	          ,e.CaseNumber
			  ,COALESCE(p.dimParticipantId, 0) AS dimParticipantId
			  ,a.[SOC_SEC_NO]
			  ,a.dimDateId			  		   

			  ,ISNULL(CASE WHEN CAST(DATEDIFF(DAY, p.BirthDate, a.DateValue) / 365.25 AS INT) < 0 THEN 0
       	                   WHEN CAST(DATEDIFF(DAY, p.BirthDate, a.DateValue) / 365.25 AS INT) > 120 THEN 120
       	                   ELSE CAST(DATEDIFF(DAY, p.BirthDate, a.DateValue) / 365.25 AS INT)
       	              END , 0)	AS dimAgeId
			        
              ,CASE WHEN p.EmploymentStatus = 'ACTIVE' THEN 1 
	                WHEN p.EmploymentStatus = 'TERMED' THEN 0
	                ELSE -1 
		       END AS dimEmploymentStatusId
			  
			  ,a.direction
		      ,a.theType	
			  ,a.isMandatory
			  ,COALESCE(pd.dimParticipantDivisionId, 0) AS dimDivisionId
              ,a.Amt
       FROM ref.tab_TransactDetailContribution a	
	      --INNER JOIN [WorkplaceExperience].[ref].[EXPlans] ex ON a.[MASTER_CASE_NO] = ex.PlanNumber  -- ADDED FOR PRODUCTION
		  LEFT JOIN TRS_BI_DataWarehouse.dbo.dimParticipant p WITH (NOLOCK) ON a.[MASTER_CASE_NO] = p.[CaseNumber] 
	           AND a.SOC_SEC_NO = p.SocialSecurityNumber 	
			   AND a.DateValue BETWEEN p.EffectiveFrom AND COALESCE(p.EffectiveTo, '12/31/9999')
		  INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan e WITH (NOLOCK) ON a.[MASTER_CASE_NO] = e.[CaseNumber] AND e.BusinessLine = a.BUSINESS_LINE
               --AND e.BusinessLine <> 'AEGON' 
			   --AND p.CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)
			   AND a.DateValue BETWEEN e.EffectiveFrom AND COALESCE(e.EffectiveTo, '12/31/9999')
		  LEFT JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd ON pd.dimParticipantId = p.dimParticipantId 
		       AND NOT (p.MultiDivisionalParticipant = 'YES' AND p.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED')	   
          --LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pd2 WITH (NOLOCK) ON pd.EmployeeDivisionCode = pd2.DivisionCode AND pd.CaseNumber = pd2.ACCOUNT_NO 

GO
/****** Object:  View [dbo].[src_tab_factDeferral]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


;


CREATE    VIEW [dbo].[src_tab_factDeferral]
AS
SELECT [id]
      ,DIV_I
      ,CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', RTRIM(SocialSecurityNumber)), 2) AS SocialSecurityNumber
      ,DEF_GRP_NM
      ,SRC_I
      ,DEF_P
      ,DEF_A
      ,DOC_NM
      ,CaseNumber
      ,ENRL_PROV_GRP_I
      ,PART_ENRL_I
      ,SRC_TYP_C
      ,EFF_D
      ,MonthEndFlag
      ,TheType
      ,EffDateId 
FROM (
      SELECT ROW_NUMBER() OVER (PARTITION BY PART_ENRL_I, ENRL_PROV_GRP_I, DEF_GRP_I,SRC_I,DIV_I ORDER BY EFF_D DESC) AS row_id, * 
	  FROM WorkplaceExperience.ref.tab_factDeferral  WITH (NOLOCK)
      WHERE MonthEndFlag = 1 
	    and EffDateId <= (SELECT MAX(dimDateId) FROM TRS_BI_DataWarehouse.dbo.factParticipant WITH (NOLOCK))
     ) a 
WHERE row_id = 1

GO
/****** Object:  View [dbo].[PerformanceTest_DateList]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[PerformanceTest_DateList]
AS
SELECT '2017-10-01' AS StartDate, '2017-12-31' AS EndDate

GO
/****** Object:  View [dbo].[PerformanceTest_Part1_PlanList]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[PerformanceTest_Part1_PlanList]
AS


SELECT 'QK62616JW 00001' AS CaseNumber UNION ALL
SELECT 'TA069808JW00001' AS CaseNumber UNION ALL
SELECT 'TT080460JW00001' AS CaseNumber

GO
/****** Object:  View [dbo].[PerformanceTest_Part2_PlanList]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW  [dbo].[PerformanceTest_Part2_PlanList]
AS


SELECT 'QK61881JW 00001' AS CaseNumber UNION ALL
SELECT 'TA069480JW00001' AS CaseNumber UNION ALL
SELECT 'TI097401JW00001' AS CaseNumber 

GO
/****** Object:  View [dbo].[src_CASE_DATA]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--================= 10. View: [dbo].[src_CASE_DATA]
CREATE    VIEW [dbo].[src_CASE_DATA]
AS
SELECT [CASE_DATA_ID]
      ,[PKG_ID]
      ,[MASTER_CASE_NO]
      ,[CASE_NO]
      ,[RELATED_GRP_TYP_C]
      ,[MULTI_DIV_CD]
      ,[MULTI_PART_DIV_C]
      ,[CASE_EFF_DT]
      ,[TERM_DT]
      ,[AFF_NO]
      ,[CONT_NO]
      ,[CASE_STAT_CD]
      ,[LAST_PYE_VAL_DT]
      ,[LAST_CYE_REV_DT]
      ,[SERVICER_NOTIF_CD]
      ,[PLAN_ANNV_DT]
      ,[SERIES_5500_FIL_CD]
      ,[PHONE_TRFR_ACC_CD]
      ,[PX_RISK_PREF_C]
      ,[PORTF_XPRS_MGR_C]
      ,[PPA_WAIT_PERIOD]
      ,[PPA_QDIA_PLAN_C]
      ,[PLAN_NO]
      ,[PLAN_PROD_TYP_CD]
      ,[PLAN_DESC_C]
      ,[ERISA_PLAN_C]
      ,[ROTH_PLAN_C]
      ,[PCRA_REMIT_C]
      ,[PCRA_PROXY_DIR_C]
      ,[INVESTOR_PLAN_ID]
      ,[RCMA_NO]
      ,[SDA_ACCOUNT_C]
      ,[IN_PLN_ROTH_CONV_C]
      ,[PYE_DT]
      ,[PLAN_EFF_DT]
      ,[FYE_DT]
      ,[PLAN_TERM_DT]
      ,[TERM_PAYT_DT]
      ,[LN_PERMIT_C]
      ,[INSERV_WD_ALLOW_C]
      ,[HRDSHP_WD_ALLOW_C]
      ,[NORM_RET_AGE_C]
      ,[NORM_RTMT_AGE_T]
      ,[EARLY_RET_AGE_C]
      ,[EARLY_RTMT_AGE_T]
      ,[VST_100_ERLY_RET_C]
      ,[CALL_ROUTING_CD]
      ,[AUTO_DEF_EFF_MONTH]
      ,[AUTO_DEF_EFF_DAY]
      ,[PART_COM_LVL_SRV_C]
      ,[VESTING_IND_CD]
      ,[CASE_TAX_TRMT_CD]
      ,[SPL_IND_C]
      ,[SPL_EFF_D]
      ,[SPL_END_D]
      ,[ACCESS_CD]
      ,[BUSINESS_LINE]
      ,[TLIC_TFLIC_IND_C]
      ,[SERVICE_MODEL_TYP_C]
      ,[EMPLOYER_TYP_C]
      ,[PROCESS_FLAG]
      ,[CASE_TAX_REPT_CD]
      ,[SEGMENTATION_C]
FROM TRS_BI_Staging.dbo.CASE_DATA WITH (NOLOCK)
  --WHERE BUSINESS_LINE <> 'AEGON'

GO
/****** Object:  View [dbo].[src_dimFund]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--========= TTDDDC-150 views created and not impacted by AEGON plan restriction:

CREATE   VIEW [dbo].[src_dimFund] 
AS
SELECT [dimFundId], 
       [FD_PROV_I], 
	   [BUS_LINE], 
	   [FundDescription], 
	   [FundNumber], 
	   [FundNumberP3], 
	   [FundSortOrder], 
	   [AssetCategory], 
	   [AssetClass], 
	   [FundStyle], 
	   [BlendedFundGroupCode], 
	   [StockInvestmentMix], 
	   [StartDate], 
	   [ClosedDate], 
	   [FundDisplay], 
	   [FundAction], 
	   [ServiceOnly], 
	   [Status], 
	   [FundFamily], 
	   [FundName], 
	   [EffectiveFrom], 
	   [EffectiveTo], 
	   [ActiveRecordFlag], 
	   [CreateDate]
FROM TRS_BI_DataWarehouse.dbo.dimFund  WITH (NOLOCK)

GO
/****** Object:  View [dbo].[src_dimInternalContact]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--========== 1. View: dbo.src_dimInternalContact
CREATE    VIEW [dbo].[src_dimInternalContact]
AS
WITH cteDate AS
(
   SELECT MAX(DimDateID) AS ReportDateId 
   FROM TRS_BI_DataWarehouse.dbo.factBalance WITH (NOLOCK)
)
SELECT Account_NO, 
       ClientExecutive, 
	   ClientConsultant,
	   ActiveRecordFlag,
	   d.ReportDateId
FROM TRS_BI_Datawarehouse.dbo.dimInternalContact c WITH (NOLOCK)
  LEFT JOIN cteDate d ON 1=1
WHERE --BusinessLine <> 'AEGON' 
   ActiveRecordFlag = 1
   --AND ACCOUNT_NO NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)

GO
/****** Object:  View [dbo].[src_dimOutlookForecast]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[src_dimOutlookForecast] 
AS
SELECT [dimOutlookForecastId], 
       [Weather], 
	   [OutlookStatus], 
	   [CreateDate], 
	   [WeatherSortKey]
FROM TRS_BI_DataWarehouse.dbo.dimOutlookForecast WITH (NOLOCK)

GO
/****** Object:  View [dbo].[src_dimParticipant]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--============ 1. View: [dbo].[src_dimParticipant]
CREATE     VIEW [dbo].[src_dimParticipant] 
AS
SELECT [dimParticipantId] 
      ,CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', RTRIM(SocialSecurityNumber)), 2) AS SocialSecurityNumber
	  ,[CaseNumber]
      ,[PART_ENRL_I]
      ,[HighlyCompensated]
      ,[ParticipantStatus]
      ,[DepartmentCode]
      ,[EENumber]
      ,[Class]
      ,[CatchupElection]
      ,[MultiDivisionalParticipant]
      ,[HireDate]
      ,[RehireDate]
      ,[RetirementDate]
      ,[TerminationDate]
      ,[EmploymentStatus]
      ,[StayInPlanDate]
      ,[CycleDate]
      ,[PlanEntryDate]
      ,[PCRAEnrollDate]
      ,[PCRAStatus]
      ,[PCRAEnrollSource]
      ,[DeathDate]
      ,[Language]
      ,[BusinessLine]
      ,[EffectiveFrom]
      ,[EffectiveTo]
      ,[ActiveRecordFlag]
      ,[CreateDate]
      ,[LastModifiedDate]
FROM TRS_BI_DataWarehouse.dbo.dimParticipant WITH (NOLOCK)
--WHERE BusinessLine <> 'AEGON'
--   AND CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)
----WHERE EffectiveFrom <=  CAST(CAST((SELECT MAX(dimDateId) FROM TRS_BI_DataWarehouse.dbo.factParticipant WITH (NOLOCK)) AS VARCHAR(255)) AS DATE) 
----    AND (EffectiveTo IS NULL OR EffectiveTo = CAST(CAST((SELECT MAX(dimDateId) FROM TRS_BI_DataWarehouse.dbo.factParticipant WITH (NOLOCK)) AS VARCHAR(255)) AS DATE) )      

GO
/****** Object:  View [dbo].[src_dimParticipantDivision]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--============= 2. View: [dbo].[src_dimParticipantDivision]
CREATE     VIEW [dbo].[src_dimParticipantDivision] 
AS
SELECT [dimParticipantId]
      ,[dimParticipantDivisionId]
      ,[CaseNumber]
	  ,CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', RTRIM(SocialSecurityNumber)), 2) AS SocialSecurityNumber
      ,[PART_ENRL_I]
      ,[DivisionEENumber]
      ,[DIV_I]
      ,[EmployeeDivisionCode]
      ,[EmployerDivisionCode]
      ,[DivisionHireDate]
      ,[DivisionTermDate]
      ,[DivisionRehireDate]
      ,[DivisionEmploymentStatus]
      ,[MultiDivisionIndicator]
      ,[BusinessLine]
      ,[EffectiveFrom]
      ,[EffectiveTo]
      ,[ActiveRecordFlag]
      ,[CreateDate]
      ,[LastModifiedDate]
FROM TRS_BI_Datawarehouse.dbo.dimParticipantDivision WITH (NOLOCK)
--WHERE BusinessLine <> 'AEGON'
--  AND CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)
----WHERE EffectiveFrom <=  CAST(CAST((SELECT MAX(dimDateId) FROM TRS_BI_DataWarehouse.dbo.factParticipant WITH (NOLOCK)) AS VARCHAR(255)) AS DATE) 
----    AND (EffectiveTo IS NULL OR EffectiveTo = CAST(CAST((SELECT MAX(dimDateId) FROM TRS_BI_DataWarehouse.dbo.factParticipant WITH (NOLOCK)) AS VARCHAR(255)) AS DATE) ) 

GO
/****** Object:  View [dbo].[src_dimPlan]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--================== 3. View: [dbo].[src_dimPlan]
CREATE     VIEW [dbo].[src_dimPlan] 
AS
SELECT [dimPlanId], 
	  [CaseNumber], 
	  [PlanNumber], 
	  [AffiliateNumber], 
	  [ContractNumber], 
	  [CaseReferenceNumber], 
	  [ERName], 
	  [MultiDivision], 
	  [MultiPartDivision], 
	  [CaseEffectiveDate], 
	  [TerminationDate], 
	  [EmployerIdentificationNumber], 
	  [Last_PYE_ValidationDate], 
	  [Last_CYE_ValidationDate], 
	  [PlanName], 
	  [CompanyName], 
	  [Address], 
	  [City], 
	  [StateAbbreviation], 
	  [ZipCode], 
	  [PlanAnniversary], 
	  [Series5500], 
	  [PhoneTransferAcc], 
	  [PortfolioXpressRiskPreference], 
	  [PPA_WaitPeriod], 
	  [PlanProductType], 
	  [PlanDescription], 
	  [ERISA_Plan], 
	  [RothPlan], 
	  [PCRA_Remit], 
	  [PCRA_Proxy_Dir], 
	  [InvestorPlanID], 
	  [RCMA_Number], 
	  [SDA_Account], 
	  [InPlanRothConversion], 
	  [PYE_Date], 
	  [PlanEffectiveDate], 
	  [FYE_Date], 
	  [PlanTerminationDate], 
	  [TermPayoutDate], 
	  [LoanPermitted], 
	  [InserviceWithdrawalAllowed], 
	  [HardshipWithdrawalAllowed], 
	  [NormalRetirementAgeDescription], 
	  [EarlyRetirementAgeDescription], 
	  [Vested100EarlyRetirement], 
	  [AutoDeferalEffectiveMonth], 
	  [AutoDeferalEffectiveDay], 
	  [PartComLvlSrv], 
	  [CaseTaxTreatment], 
	  [SPL_Indicator], 
	  [SPL_EffectiveDate], 
	  [SPL_EndDate], 
	  [CaseAccess], 
	  [StateName], 
	  [EffectiveFrom], 
	  [EffectiveTo], 
	  [ActiveRecordFlag], 
	  [CaseStatus], 
	  [BusinessLine], 
	  [Relationship], 
	  [Alliance], 
	  [CarveOutName], 
	  [PlanServiceType], 
	  [EmployerType], 
	  [IndustrySector], 
	  [IndustryType], 
	  [HashKey], 
	  [IndustryTypeCode], 
	  [MarketType]
FROM TRS_BI_DataWarehouse.dbo.dimPlan WITH (NOLOCK)
--WHERE BusinessLine <> 'AEGON'
--  AND CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)

--UNION ALL 

--select  2147483646 as [dimPlanId],
--      'QA99999   00001' as [CaseNumber], 
--      '' as [PlanNumber],   
--      '00001' as [AffiliateNumber], 
--      'QA99999' as  [ContractNumber], 
--      '990730100110' as [CaseReferenceNumber], 
--      'ABC CORPORATION' as [ERName], 
--      'YES' as [MultiDivision], 
--      'NO' as [MultiPartDivision], 
--      '2015-01-01' as [CaseEffectiveDate], 
--      null as [TerminationDate], 
--      '00-0000000' as [EmployerIdentificationNumber], 
--      '2019-12-31' as [Last_PYE_ValidationDate], 
--      '2019-12-31' as [Last_CYE_ValidationDate], 
--      '401(K) PLAN FOR THE EMPLOYEES OF ABC CORPORATION' as [PlanName], 
--      'ABC CORPORATION' as [CompanyName], 
--      '4 Manhattanville Rd Mail Drop 3-33' as [Address], 
--      'NY' as [City], null as [StateAbbreviation],   
--      '10577' as [ZipCode], 
--      '0101' as [PlanAnniversary], 
--      'N/A' as [Series5500], 
--      'AUTO/CSR TRANSFERS ALLOWED' as [PhoneTransferAcc], 
--      'YES' as [PortfolioXpressRiskPreference], 
--      CAST(0 AS SMALLINT) as [PPA_WaitPeriod],      --!!!!!           
--      '401(K) PLAN' as [PlanProductType], 
--      'NOT APPLICABLE' as [PlanDescription],   
--      'YES' as [ERISA_Plan], 
--      'UNKNOWN' as [RothPlan],                      
--      'NO' as [PCRA_Remit], 
--      'PARTICIPANT' as [PCRA_Proxy_Dir],      
--      '6440' as [InvestorPlanID],              --!!!! 
--      '' as [RCMA_Number],                  
--      'NO' as [SDA_Account], 
--      'NO' as [InPlanRothConversion], 
--      '1231' as [PYE_Date], 
--      '2012-07-01' as [PlanEffectiveDate], 
--      '1231' as [FYE_Date], 
--      null as [PlanTerminationDate], 
--      '' as [TermPayoutDate],              
--      'YES' as [LoanPermitted], 
--      'YES' as [InserviceWithdrawalAllowed], 
--      'YES' as [HardshipWithdrawalAllowed], 
--      '' as [NormalRetirementAgeDescription],   
--      '' as [EarlyRetirementAgeDescription],    
--      'NO' as [Vested100EarlyRetirement],         
--      CAST(3 AS SMALLINT) as [AutoDeferalEffectiveMonth],   ---!!!!
--      CAST(15 AS SMALLINT) as [AutoDeferalEffectiveDay],    ----!!!!
--      '' as [PartComLvlSrv],                    
--      'CORPORATE' as [CaseTaxTreatment], 
--      'NO' as [SPL_Indicator], 
--      null as [SPL_EffectiveDate], 
--      '' as [SPL_EndDate], 
--      'ACCOUNT BALANCE,ALLOCATIONS,DEFERRALS,FUND PERFORMANCE,LOANS,TRANSACTION HISTORY,UNIT VALUES,WITHDRAWALS' as [CaseAccess], 
--      'NEW YORK' as [StateName], 
--      '2010-01-01' as [EffectiveFrom],              
--      null as [EffectiveTo], 
--      CAST(1 AS TINYINT) as [ActiveRecordFlag],  --!!!!!
--      '' as [CaseStatus], 
--      'CORP' as [BusinessLine], 
--      '' as [Relationship],               
--	  '' as [Alliance],                   
--	  'ABC CORPORATION' as [CarveOutName], 
--	  '' as [PlanServiceType],           
--	  '' as [EmployerType],              
--	  '' as [IndustrySector],            
--	  '' as [IndustryType],              
--	  null as [HashKey], 
--	  '' as [IndustryTypeCode],          
--	  '' as [MarketType]  
           
--UNION ALL 
--select 2147483647 as [dimPlanId], 
--      'QA99993   00' as [CaseNumber], 
--      '' as [PlanNumber], 
--      '00' as [AffiliateNumber], 
--      'QA99993' as  [ContractNumber], 
--      '990730100110' as [CaseReferenceNumber], 
--      'ABC COMPANY INVESTMENT ONLY PLAN' as [ERName], 
--      'NO' as [MultiDivision], 
--      'NO' as [MultiPartDivision], 
--      '2002-01-01' as [CaseEffectiveDate], 
--      null as [TerminationDate], 
--      '04-1635140' as [EmployerIdentificationNumber], 
--      '2019-12-31' as [Last_PYE_ValidationDate], 
--      '2019-12-31' as [Last_CYE_ValidationDate], 
--      'ABC COMPANY PENSION PLAN' as [PlanName], 
--      'ABC DEFINED BENEFIT PLAN' as [CompanyName], 
--      '15 BELMONT STREET' as [Address], 
--      'WORCESTER' as [City], 
--      'MA' as [StateAbbreviation], 
--      '01605-2620' as [ZipCode], 
--      '0101' as [PlanAnniversary], 
--      '5500' as [Series5500], 
--      'NO PHONE TRANSFERS ALLOWED' as [PhoneTransferAcc], 
--      'NO' as [PortfolioXpressRiskPreference], 
--      CAST(0 AS SMALLINT) as [PPA_WaitPeriod], 
--      'DEFINED BENEFIT PLAN' as [PlanProductType], 
--      'UNKNOWN' as [PlanDescription], 
--      'YES' as [ERISA_Plan], 
--      'UNKNOWN' as [RothPlan], 
--      'NO' as [PCRA_Remit], 
--      'UNKNOWN' as [PCRA_Proxy_Dir], 
--      '' as [InvestorPlanID], 
--      '' as [RCMA_Number], 
--      'NO' as [SDA_Account], 
--      'NO' as [InPlanRothConversion], 
--      '1231' as [PYE_Date], 
--      '2002-01-01' as [PlanEffectiveDate], 
--      '1231' as [FYE_Date], 
--      null as [PlanTerminationDate], 
--      '' as [TermPayoutDate], 
--      'NO' as [LoanPermitted], 
--      'YES' as [InserviceWithdrawalAllowed], 
--      'YES' as [HardshipWithdrawalAllowed], 
--      '' as [NormalRetirementAgeDescription], 
--      '' as [EarlyRetirementAgeDescription], 
--      'UNKNOWN' as [Vested100EarlyRetirement], 
--      CAST(0 AS SMALLINT) as [AutoDeferalEffectiveMonth], 
--      CAST(0 AS SMALLINT) as [AutoDeferalEffectiveDay], 
--      'MODEL A (< $20 MILLION)' as [PartComLvlSrv], 
--      'CORPORATE' as [CaseTaxTreatment], 
--      'NO' as [SPL_Indicator], 
--      null as [SPL_EffectiveDate], 
--      '' as [SPL_EndDate], 
--      'CUSTOMER SERVICE - IAG,FUND PERFORMANCE,SERVICE ASSISTANCE - IAG,UNIT VALUES' as [CaseAccess], 
--      'MASSACHUSETTS' as [StateName], 
--      '2010-01-01' as [EffectiveFrom], 
--      null as [EffectiveTo], 
--      CAST(1 AS TINYINT) as [ActiveRecordFlag], 
--      'ACTIVE' as [CaseStatus], 
--      'IS' as [BusinessLine], 
--      '' as [Relationship], 
--	  '' as [Alliance], 
--	  'ABC Company Pension Plan' as [CarveOutName], 
--	  '' as [PlanServiceType], 
--	  '' as [EmployerType], 
--	  '' as [IndustrySector], 
--	  '' as [IndustryType], 
--	  null as [HashKey], 
--	  '' as [IndustryTypeCode],
--	  '' as [MarketType]


GO
/****** Object:  View [dbo].[src_dimPlanDivision]    Script Date: 6/17/2021 10:58:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--=============== 4. View: [dbo].[src_dimPlanDivision]
CREATE    VIEW [dbo].[src_dimPlanDivision] 
AS
SELECT [dimPlanDivisionId]
      ,[ACCOUNT_NO]
      ,[DIV_I]
      ,[DivisionCode]
      ,[DivisionName]
      ,[BusinessLine]
      ,[EffectiveFrom]
      ,[EffectiveTo]
      ,[ActiveRecordFlag]
      ,[CreateDate]
FROM TRS_BI_DataWarehouse.dbo.dimPlanDivision WITH (NOLOCK)
--WHERE BusinessLine <> 'AEGON'
--  AND [ACCOUNT_NO] NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)
----WHERE EffectiveFrom <=  CAST(CAST((SELECT MAX(dimDateId) FROM TRS_BI_DataWarehouse.dbo.factParticipant WITH (NOLOCK)) AS VARCHAR(255)) AS DATE) 
----    AND (EffectiveTo IS NULL OR EffectiveTo = CAST(CAST((SELECT MAX(dimDateId) FROM TRS_BI_DataWarehouse.dbo.factParticipant WITH (NOLOCK)) AS VARCHAR(255)) AS DATE) ) 

GO
/****** Object:  View [dbo].[src_factBalance]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--=============== 5. View: [dbo].[src_factBalance]
CREATE    VIEW [dbo].[src_factBalance] 
AS
SELECT [factBalanceId]
      ,[TRANSACT_I]
      ,[CASE_NO]
      ,[ENRL_PROV_GRP_I]
	  ,CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', RTRIM(f.SOC_SEC_NO)), 2) AS SOC_SEC_NO
      ,[dimDateId]
      ,[dimEmployerAccountId]
      ,[dimParticipantId]
      ,[dimPlanId]
      ,[dimContributionSourceId]
      ,[dimDiversificationId]
      ,[dimUniqueSocialId]
      ,[dimAgeId]
      ,[SRC_I]
      ,[dimFundId]
      ,[FD_PROV_I]
      ,[dimInternalContactId]
      ,[ViewFlag]
      ,[Balance]
      ,[Principal]
      ,[Credited]
      ,[Accrued]
      ,[Dividend]
      ,[UnitCount]
      ,[CREATE_DATE]
FROM TRS_BI_DataWarehouse.dbo.factBalance f WITH (NOLOCK)
WHERE dimDateId = (SELECT MAX(dimDateId) FROM TRS_BI_DataWarehouse.dbo.factBalance WITH (NOLOCK))
--  AND f.ViewFlag = 1

GO
/****** Object:  View [dbo].[src_factLoan]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--============= 6. View: [dbo].[src_factLoan]
CREATE    VIEW [dbo].[src_factLoan] 
AS
SELECT [factLoanId]
      ,[LoanNumber]
      ,[CaseNumber]
      ,CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', RTRIM(SocialSecurityNumber)), 2) AS SocialSecurityNumber
      ,[Division]
      ,[DivisionCode]
      ,[LoanAmount]
      ,[LoanDefaultAmount]
      ,[LoanDuration]
      ,[RepaymentFrequency]
      ,[LoanCategory]
      ,[LoanStatus]
      ,[LoanStatusDetail]
      ,[LoanType]
      ,[LoanRequestDateId]
      ,[LoanIssueDateId]
      ,[LoanTakeoverDateId]
      ,[FirstRepaymentDueDateId]
      ,[GracePeriodStartDateId]
      ,[GracePeriodEndDateId]
      ,[LoanDefaultDateId]
      ,[LoanDeemedDeferralDateId]
      ,[ReamortizedDateId]
      ,[FinalLoanRepaymentDateId]
      ,[LoanPayoffDateId]
      ,[LoanProtectDateId]
      ,[LoanProtectFlag]
      ,[EffectiveAnnualPercentageRate]
      ,[ReamortizedFlag]
      ,[ReamortizedReason]
      ,[RefinancedFlag]
      ,[GraceReason]
      ,[WithdrawnTransactionReferenceNumber]
      ,[LoanGoalAmount]
      ,[ViewFlag]
      ,[dimParticipantId]
      ,[dimPlanId]
      ,[dimUniqueSocialId]
      ,[dimSourceOfActionId]
      ,[dimAgeId]
      ,[dimPlanDivisionId]
      ,[ActiveRecordFlag]
      ,[EffectiveFrom]
      ,[EffectiveTo]
      ,[CreateDate]
      ,[InsertSessionId]
      ,[UpdateSessionId]
FROM TRS_BI_DataWarehouse.dbo.factLoan WITH (NOLOCK)
--WHERE ViewFlag = 1
----WHERE EffectiveFrom <=  CAST(CAST((SELECT MAX(loanTransactionDateId) FROM [TRS_BI_DataWarehouse].[dbo].[factLoanTransaction] WITH (NOLOCK)) AS VARCHAR(255)) AS DATE) 
----    AND (EffectiveTo IS NULL OR EffectiveTo = CAST(CAST((SELECT MAX(loanTransactionDateId) FROM [TRS_BI_DataWarehouse].[dbo].[factLoanTransaction] WITH (NOLOCK)) AS VARCHAR(255)) AS DATE) ) 

GO
/****** Object:  View [dbo].[src_factLoanTransaction]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--================= 7. View: [dbo].[src_factLoanTransaction]
CREATE    VIEW [dbo].[src_factLoanTransaction]
AS
SELECT [factLoanTransactionId]
      ,[LoanNumber]
      ,[LoanTransactionDateId]
      ,[CaseNumber]
	  ,CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', RTRIM(SocialSecurityNumber)), 2) AS SocialSecurityNumber
      ,[OpeningLoanBalance]
      ,[ClosingLoanBalance]
      ,[LoanPaymentAmount]
      ,[PaymentPrincipal]
      ,[PaymentInterest]
      ,[PaymentFees]
      ,[ViewFlag]
      ,[dimParticipantId]
      ,[dimPlanId]
      ,[dimUniqueSocialId]
      ,[StatementMessageCode]
      ,[AlternateRepaymentAmount1]
      ,[AlternateRepaymentAmount2]
      ,[CreateDate]
FROM [TRS_BI_DataWarehouse].[dbo].[factLoanTransaction] WITH (NOLOCK)
WHERE loanTransactionDateId = (SELECT MAX(dimDateId) FROM [TRS_BI_DataWarehouse].[dbo].[factBalance] WITH (NOLOCK))
   --AND ViewFlag = 1

GO
/****** Object:  View [dbo].[src_factOutlook]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--============= 8. View: [dbo].[src_factOutlook]
CREATE     VIEW [dbo].[src_factOutlook]
AS
SELECT fo.[factOutlookId]
      ,fo.[dimOutlookId]
      ,CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', RTRIM(fp.SocialSecurityNumber)), 2) AS SocialSecurityNumber
      ,fo.[Salary]
      ,fo.[SalaryGoal]
      ,fo.[SpouseSalary]
      ,fo.[SpouseGoal]
      ,fo.[SpouseSocialSecurityPayment]
      ,fo.[PreTaxRegular]
      ,fo.[PreTaxCatchUp]
      ,fo.[RothRegular]
      ,fo.[RothCatchUp]
      ,fo.[PostRegular]
      ,fo.[Tier1MatchPercent]
      ,fo.[Tier1UpperLimitPercent]
      ,fo.[Tier1UpperLimitAmount]
      ,fo.[Tier2MatchPercent]
      ,fo.[Tier2UpperLimitPercent]
      ,fo.[Tier2UpperLimitAmount]
      ,fo.[Tier3MatchPercent]
      ,fo.[Tier3UpperLimitPercent]
      ,fo.[Tier3UpperLimitAmount]
      ,fo.[ProfitSharingAmount]
      ,fo.[ProfitSharingPercent]
      ,fo.[IncomeGoal]
      ,fo.[IncomeEstimate]
      ,fo.[LowIncomeEstimate]
      ,fo.[HighIncomeEstimate]
      ,fo.[RangeEstimate]
      ,fo.[ProbabilityOfSuccess]
      ,fo.[GapMeasure]
      ,fo.[dimDateId]
      ,fo.[dimSourceOfActionId]
      ,fo.[dimUniqueSocialId]
      ,fo.[dimOutlookForecastId]
FROM  TRS_BI_DataWarehouse.dbo.factParticipant fp WITH (NOLOCK)       
LEFT JOIN TRS_BI_DataWarehouse.dbo.factOutlook fo WITH (NOLOCK) ON fp.dimOutlookId = fo.dimOutlookId
WHERE fp.dimDateId = (SELECT MAX(dimdateid) FROM TRS_BI_DataWarehouse.dbo.factParticipant fp WITH (NOLOCK))
	AND fp.dimEmployerAccountId = 0
	--AND fp.ViewFlag = 1

GO
/****** Object:  View [dbo].[src_factParticipant]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--=========== 9. View: [dbo].[src_factParticipant]
CREATE    VIEW [dbo].[src_factParticipant]
AS
SELECT [factParticipantId]
      ,[CaseNumber]
	  ,CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', RTRIM(SocialSecurityNumber)), 2) AS SocialSecurityNumber
      ,[dimDateId]
      ,[dimPlanId]
      ,[dimParticipantId]
      ,[dimAgeId]
      ,[dimDiversificationId]
      ,[dimEligibilityClassId]
      ,[dimEmployerAccountId]
      ,[dimEmploymentStatusId]
      ,[dimInternalContactId]
      ,[dimOutlookForecastId]
      ,[dimOutlookId]
      ,[dimUniqueSocialId]
      ,[BalanceIndicator]
      ,[ViewFlag]
      ,[Balance]
      ,[StockInvestmentMix]
      ,[BondInvestmentMix]
      ,[MultiAssetOtherInvestmentMix]
      ,[SecurePathInvestmentMix]
      ,[UnknownInvestmentMix]
      ,[ManagedAccountId]
      ,[AutoRebalanceId]
      ,[RecurringTransfersId]
      ,[PortfolioXpressId]
      ,[CustomPortfolioId]
      ,[SecurePlanForLifeId]
      ,[ManagedAdviceId]
      ,[EStatementsId]
      ,[EConfirmId]
      ,[EInvestMaterialsId]
      ,[PCRAParticipationId]
      ,[RequiredNoticesId]
      ,[OnTrackEdMaterialsId]
      ,[PlanRelatedMaterialsId]
      ,[EnrollmentMaterialId]
      ,[ConversionMaterialId]
      ,[refParticipantEligibilityId]
      ,[PreTaxEligible]
      ,[EmployerMatchEligible]
      ,[DeferralAmount]
      ,[DeferralPercent]
      ,[DeferralAmountMatch]
      ,[DeferralPercentMatch]
      ,[IsContributing]
      ,[InsertSessionId]
      ,[CreateDate]
FROM TRS_BI_DataWarehouse.dbo.factParticipant  WITH (NOLOCK)
WHERE dimDateId = (SELECT MAX(dimDateId) FROM TRS_BI_DataWarehouse.dbo.factParticipant WITH (NOLOCK)) 
  --AND ViewFlag = 1

GO
/****** Object:  View [dbo].[src_FP_FUND_DESC]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[src_FP_FUND_DESC] 
AS
SELECT [FD_DESC_CD]
      ,[FD_NM]     
      ,[FD_INDX_DESC_CD]     
      ,[NASDAQ_SYM]        
FROM [TRS_BI_Staging].[dbo].[FP_FUND_DESC] WITH (NOLOCK)

GO
/****** Object:  View [dbo].[src_FP_MIRROR_FUND]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[src_FP_MIRROR_FUND] 
AS 
SELECT [FP_MIRROR_FUND_ID]
      ,[FP_MIRROR_DESC_CD]
      ,[FD_DESC_CD]
      ,[CREATION_TS]
      ,[USER_ID]
      ,[MOD_TS]
      ,[BUSINESS_LINE]
      ,[CREATE_DATE]
      ,[PROCESSED_DATE]
      ,[PROCESS_FLAG]
  FROM [TRS_BI_Staging].[dbo].[FP_MIRROR_FUND] WITH (NOLOCK)

GO
/****** Object:  View [dbo].[src_FUNDDESC]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE    VIEW [dbo].[src_FUNDDESC]
AS
SELECT [FUNDDESC_ID]
      ,[PKG_ID]
      ,[FD_DESCR_CODE]
      ,[FD_ACCT_IND_CD]
      ,[FD_TYPE_CD]
      ,[FD_PL_AMT_TYPE_CD]
      ,[FD_ASSET_CHRG_CD]
      ,[FD_DECIMAL_POS_CD]
      ,[FD_EFF_DATE]
      ,[FD_REC_DATE]
      ,[FD_TERM_DATE]
      ,[FD_VALTN_FREQ_CD]
      ,[FD_VALTN_DAY_CD]
      ,[FD_VALTN_PERIOD_CD]
      ,[FD_UNIT_VAL_CNT]
      ,[FD_UNIT_DEC_CNT]
      ,[FD_UNIT_VAL_CHRG]
      ,[FD_CHRG_INT_CD]
      ,[FD_DWRR_CALC_CD]
      ,[FD_FUND_ACCT_CD]
      ,[FD_ER_SEC_BAS_CD]
      ,[FD_INVEST_LIQ_CHRG]
      ,[FD_PROF_LOSS_CALC]
      ,[FD_PROF_LOSS_REV]
      ,[FD_ADMIN_CHRG_CD]
      ,[FD_INT_TYPE_CD]
      ,[FD_PROC_YR_CD]
      ,[FD_DEPOSIT_INCLUS]
      ,[FD_WITHDRL_DTE_CD]
      ,[FD_PROD_TYP_CD]
      ,[FD_TRFR_AGT_CD]
      ,[FD_MNY_MKT_IND_CD]
      ,[TWRR_ASSET_CAT_CD]
      ,[AST_CHRG_FACTR_AMT]
      ,[SAF_FD_CD]
      ,[SEGMENT_CD]
      ,[SPECIAL_FD_TYPE_CD]
      ,[FD_CUSIP_CD]
      ,[FD_NSCC_SUM_CD]
      ,[DLY_DIVD_REINV_CD]
      ,[DVD_SPLT_RT_PRC_CD]
      ,[DIVD_REINV_FREQ_CD]
      ,[DIVD_FREQ_CD]
      ,[TRANSLATION_NM]
      ,[FD_FAM_C]
      ,[FD_CLASS_C]
      ,[FD_EXPENSE_C]
      ,[RISK_RETURN_SEQ_NO]
      ,[PRIMARY_FD_C]
      ,[STAT_C]
      ,[REINV_DAY_TYP_C]
      ,[REINV_DAY_NO]
      ,[REINV_WEEK_NO]
      ,[REINV_MO_DAY_C]
      ,[NEXT_REINV_D]
      ,[LAST_REINV_D]
      ,[FD_STYLE_C]
      ,[MOD_TS]
      ,[REPORT_1_FD_NM]
      ,[REPORT_2_FD_NM]
      ,[BLENDED_FD_GRP_C]
      ,[SHARE_ACCTG_C]
      ,[RETIRE_FD_C]
      ,[FD_PROSPECTUS_C]
      ,[ROUND_TRIP_C]
      ,[SPL_MIN_LKIN_TR_A]
      ,[SPL_MIN_ENRL_AGE]
      ,[SPL_MAX_ENRL_AGE]
      ,[SPL_MAX_PART_AGE]
      ,[SPL_MAX_INVEST_A]
      ,[SPL_RELATED_DESC]
      ,[BLEND_MATURITY_D]
      ,[ANNUITY_TYP_C]
      ,[STOCK_STARTUP_C]
      ,[ANNUITY_CONT_NM]
      ,[DIV_DAY_OF_DEPOSIT_C]
      ,[DIV_DAY_OF_WD_C]
      ,[DIV_CUTOVER_D]
      ,[DIV_COMPD_FREQ_C]
      ,[DIV_COMPD_CUTOVER_D]
      ,[DIV_CLOSE_D]
      ,[NOTIFICATION_C]
      ,[FD_RESTRC_GRP_C]
      ,[DISPLAY_BLEND_FD_C]
      ,[BUSINESS_LINE]
  FROM TRS_BI_Staging.dbo.FUNDDESC WITH (NOLOCK)


GO
/****** Object:  View [dbo].[src_LE_ROLE_CP_REL]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--========== 2. View: dbo.src_LE_ROLE_CP_REL
CREATE    VIEW [dbo].[src_LE_ROLE_CP_REL]
AS
SELECT  LE_I, 
        LE_ROLE_C, 
		RELATED_I, 
		RELATED_TYP_C, 
		CP_I, 
		CP_TYP_C, 
		MOD_TS 
FROM [TRS_BI_Staging].[dbo].[LE_ROLE_CP_REL] WITH (NOLOCK)
WHERE LE_ROLE_C in (355, 345)
  --AND BUSINESS_LINE <> 'AEGON'

GO
/****** Object:  View [dbo].[src_LE_TELEPHONE]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--=========== 4. View: dbo.src_LE_TELEPHONE
CREATE    VIEW [dbo].[src_LE_TELEPHONE]
AS
SELECT CP_I, PHONE_NO
FROM [TRS_BI_Staging].[dbo].[LE_TELEPHONE] tel WITH (NOLOCK) 
--WHERE BUSINESS_LINE <> 'AEGON'

GO
/****** Object:  View [dbo].[src_OUTSRC_ELIG_SRC]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[src_OUTSRC_ELIG_SRC] 
AS
SELECT  [OUTSRC_I]
      ,[SRC_I]
      ,[SERV_LEV_C]
      ,[STAT_C]
      ,[EFF_D]
      ,[MOD_TS]    
      ,[BUSINESS_LINE]    
FROM [TRS_BI_Staging].[dbo].[OUTSRC_ELIG_SRC]  WITH (NOLOCK)    

GO
/****** Object:  View [dbo].[src_OUTSRC_SERVICE]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[src_OUTSRC_SERVICE]
AS
SELECT OUTSRC_I
      ,SERV_TYP_C
      ,SERV_OFFERING_C
      ,SERV_STATUS_C
      ,OUTSRC_SERV_BEG_D
      ,OUTSRC_SERV_END_D
      ,OUTSRC_RPT_C
      ,USER_I
      ,MOD_TS
      ,SURROGATE_KEY
      ,BUSINESS_LINE
FROM [TRS_BI_Staging].[dbo].[OUTSRC_SERVICE] WITH (NOLOCK)

GO
/****** Object:  View [dbo].[src_PERSON_SEARCH]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--=========== 3. View: dbo.src_PERSON_SEARCH
CREATE    VIEW [dbo].[src_PERSON_SEARCH]
AS
SELECT PERSON_I, LAST_NM, FST_MID_NM
FROM [TRS_BI_Staging].[dbo].[PERSON_SEARCH] per WITH (NOLOCK)
--WHERE BUSINESS_LINE <> 'AEGON'

GO
/****** Object:  View [dbo].[src_PLAN_FUND]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--=========== 11. View: [dbo].[src_PLAN_FUND]
CREATE    VIEW [dbo].[src_PLAN_FUND]
AS
SELECT [FUND_ID]
      ,[FD_PROV_I]
      ,[FD_DESC_CD]
      ,[DIRECTION_C]
      ,[FD_S]
      ,[FD_FAMILY_PROV_I]
      ,[STAT_C]
      ,[COMMENTS_T]
      ,[FD_SEQ_N]
      ,[FD_CLOSED_D]
      ,[INT_RATE_DISP_C]
      ,[SERVICE_ONLY_C]
      ,[SEND_PROSPECTUS_C]
      ,[BUSINESS_LINE]
FROM TRS_BI_Staging.dbo.PLAN_FUND WITH (NOLOCK)
--WHERE BUSINESS_LINE <> 'AEGON'

GO
/****** Object:  View [dbo].[src_PLAN_PROV_GRP]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--============= 12. View: [dbo].[src_PLAN_PROV_GRP]
CREATE    VIEW [dbo].[src_PLAN_PROV_GRP]
AS
SELECT [PLAN_PROV_GRP_ID]
      ,[PLAN_ENRL_I]
      ,[ENRL_PROV_GRP_I]
	  ,[PROV_GRP_SRCH_NM]
      ,[DFLT_GRP_C]
      ,[RELATED_GRP_I]
      ,[RELATED_GRP_TYP_C]
      ,[ACCOUNT_NO]
      ,[BUS_LINE_C]
      ,[ENRL_STAT_C]
      ,[CONV_STAT_C]
      ,[CONV_D]
      ,[CREATION_TS]
      ,[PROV_GRP_RSN_C]
      ,[REL_C]
      ,[PROV_GRP_OPT_C]
      ,[BUSINESS_LINE]
FROM TRS_BI_Staging.dbo.PLAN_PROV_GRP WITH (NOLOCK)
--WHERE BUSINESS_LINE <> 'AEGON'

GO
/****** Object:  View [dbo].[src_PLAN_PROVISION]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--============== 13. View: [dbo].[src_PLAN_PROVISION]
CREATE    VIEW [dbo].[src_PLAN_PROVISION]
AS
SELECT [PLAN_PROVISION_ID]
      ,[ENRL_PROV_GRP_I]
      ,[PROVISION_I]
      ,[PROV_TYP_C]
      ,[PROV_OWNER_C]
      ,[RELATED_I]
      ,[RELATED_TYP_C]
      ,[MOD_TS]
      ,[BUSINESS_LINE]
FROM TRS_BI_Staging.dbo.PLAN_PROVISION WITH (NOLOCK)
--WHERE BUSINESS_LINE <> 'AEGON'

GO
/****** Object:  View [dbo].[tab_dimAge]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[tab_dimAge] 
AS
SELECT [dimAgeId]      
      ,[AgeBand]     
  FROM [TRS_BI_DataWarehouse].[dbo].[dimAge] WITH (NOLOCK)


GO
/****** Object:  View [dbo].[tab_dimContributionSource]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[tab_dimContributionSource]
AS
SELECT [dimContributionSourceId]     
      ,[Direction]
      ,[RolloverSource]
      ,[PrePostTax]
      ,[Roth]
      ,[VestingAllowed]
      ,[VestingSchedule]
      ,[SourceType]
      ,[DocName]
      ,[ReportName]      
  FROM [TRS_BI_DataWarehouse].[dbo].[dimContributionSource] WITH (NOLOCK)

GO
/****** Object:  View [dbo].[tab_dimDate]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     VIEW [dbo].[tab_dimDate]  
AS 
SELECT   d.DimDateId, d.DateValue, d.Day, d.MonthName, d.Month, 
         d.QuarterName, d.Year 
FROM     "TRS_BI_DataWarehouse".dbo.dimDate d 
WHERE   (d.EndOfMonthValue=d.DateValue   
    AND d.DimDateId >= (SELECT MIN(dimDateId) from TRS_BI_Datawarehouse.dbo.factParticipant WITH (NOLOCK)) 
    AND d.DimDateId < (SELECT MAX(dimDateId) FROM TRS_BI_Datawarehouse.dbo.factParticipant WITH (NOLOCK)) 
    ) OR d.DimDateId/100 = (SELECT MAX(dimDateId)/100 FROM TRS_BI_Datawarehouse.dbo.factParticipant WITH (NOLOCK))


GO
/****** Object:  View [dbo].[tab_dimDiversification]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[tab_dimDiversification]
AS
SELECT  [dimDiversificationId]
      ,[DiversificationStatus]
      ,[DiversificationMethod]
      ,[DiversificationCategory]      
  FROM [TRS_BI_DataWarehouse].[dbo].[dimDiversification]

GO
/****** Object:  View [dbo].[tab_dimDivision]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[tab_dimDivision] 
AS

SELECT DISTINCT 
         d.dimParticipantDivisionId AS dimDivisionId,
         COALESCE(NULLIF(d.EmployeeDivisionCode, ''), 'UNKNOWN') AS DivisionCode,  
         COALESCE(b.[DivisionName], 'UNKNOWN') AS DivisionName                 
FROM  TRS_BI_Datawarehouse.dbo.dimParticipantDivision d WITH (NOLOCK) 
    LEFT JOIN 
    (
        SELECT   CD.CASE_NO AS ACCOUNT_NO,
                 PX.DIV_NO AS DIVISIONCODE,
                 MAX(LTRIM(RTRIM(LTRIM(RTRIM(O.ORG_1_NM)+' '+LTRIM(RTRIM(O.ORG_2_NM)))))) AS DIVISIONNAME
        FROM     [TRS_BI_STAGING].[DBO].[CASE_DATA] CD WITH (NOLOCK) 
            INNER JOIN [TRS_BI_STAGING].[DBO].[P2_DIV_XREF] PX WITH (NOLOCK) ON CD.CASE_NO = PX.CASE_NO 
			INNER JOIN [TRS_BI_STAGING].[DBO].[PLAN_PROV_GRP] PPG WITH (NOLOCK) ON CD.CASE_NO = PPG.ACCOUNT_NO 
               AND  PPG.ENRL_PROV_GRP_I = PX.ORG_ENRL_I
               AND  PPG.RELATED_GRP_TYP_C = 361
            LEFT JOIN [TRS_BI_STAGING].[DBO].[ORG_SEARCH] O WITH (NOLOCK) ON PX.ORG_I = O.ORG_I 
                 AND O.ROLE_C = 14            
            GROUP BY CD.CASE_NO, PX.DIV_NO
    
    ) b ON d.EmployeeDivisionCode = b.DivisionCode AND d.CaseNumber = b.ACCOUNT_NO


GO
/****** Object:  View [dbo].[tab_dimDivision_Balance]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[tab_dimDivision_Balance] 
AS

SELECT DISTINCT b.dimPlanDivisionId AS dimDivisionId,	 
	   b.[DivisionCode],
	   b.[DivisionName]	           
FROM TRS_BI_Datawarehouse.dbo.dimParticipantDivision d WITH (NOLOCK)
    INNER JOIN [TRS_BI_DataWarehouse].dbo.dimPlanDivision b WITH (NOLOCK) ON b.DIV_I = d.DIV_I

GO
/****** Object:  View [dbo].[tab_dimEmployerAccount]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---- using a table different from dimEmployerAccount, same as  the plan data report
CREATE VIEW [dbo].[tab_dimEmployerAccount] 
AS
WITH cteAccount AS
(
   SELECT DISTINCT dimEmployerAccountId
   FROM TRS_BI_Datawarehouse.dbo.factParticipant f WITH (NOLOCK)
   WHERE ViewFlag = 1 AND BalanceIndicator = 1
)
SELECT p.dimEmployerAccountId       
      ,CASE WHEN d.EmployerAccountID = 0 THEN 'Participants' ELSE [EmployerAccountType] END AS AccountType   
  FROM [TRS_BI_Datawarehouse].[usr].[EmployerAccounts] d WITH (NOLOCK)           
    INNER JOIN cteAccount p ON d.EmployerAccountId = p.dimEmployerAccountId
  --WHERE BusinessLine <> 'AEGON'


GO
/****** Object:  View [dbo].[tab_dimEmploymentStatus]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[tab_dimEmploymentStatus]
AS
SELECT 0 AS dimEmploymentStatusId, 'Terminated' AS EmploymentStatus
UNION ALL
SELECT 1 AS dimEmploymentStatusId, 'Active' AS EmploymentStatus
UNION ALL
SELECT -1 AS dimEmploymentStatusId, 'UNKNOWN' AS EmploymentStatus


GO
/****** Object:  View [dbo].[tab_dimFund]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[tab_dimFund]
AS
SELECT dimFundId, AssetCategory, AssetClass, FundStyle,  FundFamily, FundName, FundDescription
FROM TRS_BI_DataWarehouse.usr.Fund f

GO
/****** Object:  View [dbo].[tab_dimOutlookForecast]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[tab_dimOutlookForecast]
AS
SELECT [dimOutlookForecastId]
      ,[Weather]
      ,[OutlookStatus]     
  FROM [TRS_BI_DataWarehouse].[dbo].[dimOutlookForecast]
  

GO
/****** Object:  View [dbo].[tab_dimParticipant]    Script Date: 6/17/2021 10:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE      VIEW [dbo].[tab_dimParticipant] 
AS
----WITH cteParticipant AS
----(
----   SELECT DISTINCT dimParticipantId
----   FROM TRS_BI_Datawarehouse.dbo.factParticipant f WITH (NOLOCK)
----   WHERE ViewFlag = 1 
----      AND (BalanceIndicator = 1 OR f.dimEmploymentStatusId = 1) 
----      AND f.dimEmployerAccountId = 0
----)
SELECT  d.[dimParticipantId]   
      ,CASE WHEN d.EmploymentStatus = 'ACTIVE' THEN 1 ELSE 0 END AS dimEmploymentStatusId
	  ,d.SocialSecurityNumber	  
	  ,d.FirstName + ' ' + d.LastName AS FullName
	  ,CASE WHEN d.HighlyCompensated = 'YES' THEN 1 ELSE 0 END AS dimHCEId
  FROM  [TRS_BI_DataWarehouse].[dbo].[dimParticipant] d WITH (NOLOCK) 
  --WHERE d.BusinessLine <> 'AEGON' 
  --  AND CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)
	
    

GO
/****** Object:  View [dbo].[tab_dimTransactionType]    Script Date: 6/17/2021 10:58:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[tab_dimTransactionType]
AS
 SELECT [dimTransactionTypeId]      
      ,[ParentCategoryText]
      ,[SubCategoryText]
      ,[SourceCategoryText]
      ,[FundCategoryText]
  FROM [TRS_BI_DataWarehouse].[dbo].[dimTransactionType] WITH (NOLOCK)

GO
/****** Object:  View [dbo].[tab_factBalance_Employer]    Script Date: 6/17/2021 10:58:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE  VIEW [dbo].[tab_factBalance_Employer] 
AS

SELECT 
      f.dimplanId                     
	  ,f.dimdateId	                     	              
	  ,dimEmployerAccountId
	  
	  ,SUM(Balance)  AS Balance		
  FROM [TRS_BI_Datawarehouse].[dbo].[factParticipant] f WITH (NOLOCK) -- TRS_BI_Datawarehouse.[usr].[ParticipantInfo] f  	     
  WHERE  f.dimEmployerAccountId > 0
  GROUP BY 
	   f.dimplanId                     
	  ,f.dimdateId	                     	              
	  ,f.dimEmployerAccountId    

GO
/****** Object:  View [dbo].[tab_factFinancial_PPT]    Script Date: 6/17/2021 10:58:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[tab_factFinancial_PPT] 
AS

WITH cte1 AS
(
  SELECT  
         f.dimPlanId     
         ,CASE WHEN d1.CurrentMonthFlag = 0 THEN CAST(CONVERT(char(8),d1.EndOfMonthValue,112) AS int) 
		       ELSE d1.dimDateId
		  END AS dimDateId         
	     ,f.dimParticipantId
		 ,f.SOC_SEC_NO
		 ,c.direction
		 ,CASE WHEN c.direction = 'EMPLOYEE' AND c.PrePostTax = 'YES' AND c.SourceType like '%Pre%'  THEN 'PreTax' 
			   WHEN c.direction = 'EMPLOYEE' AND c.Roth = 'YES' THEN 'Roth'
			   WHEN c.direction = 'EMPLOYEE' AND c.PrePostTax = 'YES' AND c.SourceType like '%After%' THEN 'AfterTax'
			   ELSE 'Other'
		  END AS theType		 
	     
	     ,f.dimAgeId
	     --,f.dimFundId
	     
	     ,SUM([Amount]) AS Amt	  	  
	  
  FROM  [TRS_BI_DataWarehouse].[dbo].[factFinancial] f WITH (NOLOCK)
    INNER JOIN [TRS_BI_Datawarehouse].[dbo].[dimTransactionType] t WITH (NOLOCK) ON f.dimTransactionTypeId = t.dimTransactionTypeId AND t.ParentCategoryText = 'CONTRIBUTIONS' and t.SubCategoryText = 'MONEY IN'
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimContributionSource c WITH (NOLOCK) ON f.dimContributionSourceId = c.dimContributionSourceId 	
	INNER JOIN [TRS_BI_DataWarehouse].[dbo].dimDate d1 WITH (NOLOCK) ON f.dimDateId = d1.dimDateId 
  WHERE f.dimEmployerAccountId = 0 
    AND f.viewFlag = 0	 
  GROUP BY f.dimPlanId     
      ,CASE WHEN d1.CurrentMonthFlag = 0 THEN CAST(CONVERT(char(8),d1.EndOfMonthValue,112) AS int) 
		       ELSE d1.dimDateId
		  END        
	  ,f.dimParticipantId
	  ,f.SOC_SEC_NO
	  ,c.direction
	  		 ,CASE WHEN c.direction = 'EMPLOYEE' AND c.PrePostTax = 'YES' AND c.SourceType like '%Pre%' THEN 'PreTax'  
			   WHEN c.direction = 'EMPLOYEE' AND c.Roth = 'YES' THEN 'Roth'
			   WHEN c.direction = 'EMPLOYEE' AND c.PrePostTax = 'YES' AND c.SourceType like '%After%' THEN 'AfterTax'
			   ELSE 'Other'
		  END 
	  ,f.dimAgeId

	  --,f.dimFundId 
)

SELECT a.dimPlanId,
       a.dimParticipantId,
	   a.DimDateId,
	   --a.dimFundId,
	   CASE WHEN p.EmploymentStatus = 'ACTIVE' THEN 1 
	        WHEN p.EmploymentStatus = 'TERMED' THEN 0
	        ELSE -1 
		END AS dimEmploymentStatusId,
	   COALESCE(pp.dimPlanDivisionId, 0) AS dimDivisionId,
	   a.SOC_SEC_NO,
	   a.dimAgeId,
	   p.CaseNumber,
	   a.direction,
	   a.theType,

	   a.Amt AS Amt
FROM cte1 a
  INNER JOIN [TRS_BI_Datawarehouse].[dbo].dimParticipant p WITH (NOLOCK) ON a.dimParticipantId = p.dimParticipantId
  INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd WITH (NOLOCK) ON pd.dimParticipantId = a.dimParticipantId     
  LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pp WITH (NOLOCK) ON pd.EmployeeDivisionCode = pp.DivisionCode AND pd.CaseNumber = pp.ACCOUNT_NO
WHERE NOT (p.MultiDivisionalParticipant = 'YES' AND p.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED')


GO
/****** Object:  View [dbo].[tab_factFund]    Script Date: 6/17/2021 10:58:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[tab_factFund] 
AS
 SELECT f.dimplanId                     
	  ,f.dimdateId             	   
	  ,f.dimParticipantId             
	  ,COALESCE(pp.dimPlanDivisionId, 0) AS dimDivisionId
	  ,f.dimfundId 

	  ,SUM([Balance]) AS fundBalance 	
	  ,SUM(f.UnitCount) AS UnitCount
  FROM  [TRS_BI_Datawarehouse].dbo.factBalance f WITH (NOLOCK) 	   
     INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimParticipant] d WITH (NOLOCK) ON d.dimParticipantId = f.dimParticipantId AND f.ViewFlag = 1  
	 INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd WITH (NOLOCK) ON pd.dimParticipantId = f.dimParticipantId     
	 LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pp WITH (NOLOCK) ON pp.DIV_I = pd.DIV_I
  WHERE f.dimEmployerAccountId = 0	 
    AND NOT (d.MultiDivisionalParticipant = 'YES' AND d.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED')
  GROUP BY f.dimplanId                      
	  ,f.dimdateId             	   
	  ,f.dimParticipantId
	  ,COALESCE(pp.dimPlanDivisionId, 0) 
	  ,f.dimfundId	  

GO
/****** Object:  View [dbo].[tab_factLoanBalance]    Script Date: 6/17/2021 10:58:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--3. 

CREATE     VIEW [dbo].[tab_factLoanBalance]
as
SELECT 
	   CASE WHEN t.StatementMessageCode IN (0, 2, 5) THEN 'Active'
	        WHEN t.StatementMessageCode = 4 THEN 'Deemed'
	   END AS LoanStatus,
	   n.LoanStatusDetail,
	   CASE WHEN n.LoanType = 'NEW' AND (LoanStatus = 'ACTIVE' OR (n.loanstatus = 'INACTIVE' AND n.loanstatusdetail = 'PORTABILITY-LOAN MOVED')) THEN 'NEW'
	        WHEN n.LoanType = 'TAKE OVER'  THEN 'TAKE OVER'
			ELSE 'Other'
	   END AS LoanType,


	   t.LoanTransactionDateId AS dimDateId,  -- if get correct date from stmt_end_dt, then use that as as-of date for counts; not using this for new loans  

	   t.dimPlanId,
	   
	   CASE WHEN p.EmploymentStatus = 'ACTIVE' THEN 1 
	        WHEN p.EmploymentStatus = 'TERMED' THEN 0
	        ELSE -1 END AS dimEmploymentStatusId,
			  
	   t.dimParticipantId,
	   t.SocialSecurityNumber, 
	   COALESCE( pd.dimParticipantDivisionId, 0) AS dimPlanDivisionId,
	   200 AS dimTransactionId,
	   t.LoanNumber,         -- count(distinct LoanNumber) is the number of loans  (e.g. number of active loans)

	   CASE WHEN t.StatementMessageCode IN (0, 2, 5) THEN t.ClosingLoanBalance
	        WHEN t.StatementMessageCode = 4 THEN t.ClosingLoanBalance + t.AlternateRepaymentAmount1
	   END AS ClosingLoanBalance
  FROM [TRS_BI_DataWarehouse].[dbo].[factLoanTransaction] t WITH (NOLOCK)
    --INNER JOIN [WorkplaceExperience].[ref].[EXPlansRpt] ex ON t.CaseNumber = ex.PlanNumber  -- ADDED FOR PRODUCTION
    INNER JOIN (
		select dimDateId, DateValue
		from TRS_BI_DataWarehouse.dbo.dimdate d WITH (NOLOCK)
		where (d.CurrentMonthFlag = 0 AND d.DateValue = d.EndOfMonthValue) OR d.CurrentMonthFlag = 1  
	)  d
	 ON  t.LoanTransactionDateId = d.DimDateId  
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipant p WITH (NOLOCK) ON t.dimParticipantId = p.dimParticipantId
    LEFT JOIN TRS_BI_DataWarehouse.dbo.factLoan n WITH (NOLOCK) ON t.LoanNumber = n.LoanNumber AND n.CaseNumber = t.CaseNumber AND d.DateValue BETWEEN n.EffectiveFrom AND COALESCE(n.EffectiveTo, '12/31/9999')	
	-- add the following to fix the division issue in factLoan
	LEFT JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd WITH (NOLOCK) ON pd.dimParticipantId = p.dimParticipantId
	  AND ( (p.MultiDivisionalParticipant = 'NO' ) OR
			(
			  p.MultiDivisionalParticipant = 'YES' AND n.DivisionCode = pd.EmployeeDivisionCode 
			  AND NOT (p.MultiDivisionalParticipant = 'YES' AND p.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED') 
			)
		  )
	--LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pp WITH (NOLOCK) ON pd.EmployeeDivisionCode = pp.DivisionCode AND pd.CaseNumber = pp.ACCOUNT_NO    
  WHERE --t.ViewFlag = 1 AND 
        t.StatementMessageCode IN (0, 2, 5, 4)  

GO
/****** Object:  View [dbo].[tab_factNewLoans]    Script Date: 6/17/2021 10:58:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE      VIEW [dbo].[tab_factNewLoans]
AS
SELECT 
	   CASE WHEN d.CurrentMonthFlag = 0 THEN CAST(CONVERT(char(8),d.EndOfMonthValue,112) AS int)
	        ELSE d.dimdateId 
	   END AS dimdateId,
	   n.dimPlanId,	 
	   n.dimParticipantId,
	   CASE WHEN p.EmploymentStatus = 'ACTIVE' THEN 1 
	        WHEN p.EmploymentStatus = 'TERMED' THEN 0
	        ELSE -1 END AS dimEmploymentStatusId,
	   n.SocialSecurityNumber,  
	   pd.dimParticipantDivisionId AS dimPlanDivisionId, 
	   n.LoanNumber         
  FROM TRS_BI_DataWarehouse.dbo.factLoan n WITH (NOLOCK)      
  	--INNER JOIN [WorkplaceExperience].[ref].[EXPlans] ex ON n.CaseNumber = ex.PlanNumber  -- added for production  
    INNER JOIN TRS_BI_DataWarehouse.dbo.dimdate d WITH (NOLOCK) ON N.LoanIssueDateId = d.DimDateId  
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipant p WITH (NOLOCK) ON n.dimParticipantId = p.dimParticipantId
		-- add the following to fix the division issue in factLoan
	LEFT JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd WITH (NOLOCK) ON pd.dimParticipantId = p.dimParticipantId
	  AND ( (p.MultiDivisionalParticipant = 'NO' ) OR
			(
			  p.MultiDivisionalParticipant = 'YES' AND n.DivisionCode = pd.EmployeeDivisionCode 
			  AND NOT (p.MultiDivisionalParticipant = 'YES' AND p.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED') 
			)
		  )	  
	--LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pp WITH (NOLOCK) ON pd.EmployeeDivisionCode = pp.DivisionCode AND pd.CaseNumber = pp.ACCOUNT_NO   

  WHERE --n.ViewFlag = 1
   n.LoanType IN ('NEW')  
   AND (LoanStatus = 'ACTIVE' OR (n.loanstatus = 'INACTIVE' AND n.loanstatusdetail = 'PORTABILITY-LOAN MOVED') )
   AND d.DateValue BETWEEN n.EffectiveFrom AND COALESCE(n.EffectiveTo, '12/31/9999')
   AND NOT EXISTS (
                     SELECT 0
                     FROM TRS_BI_DataWarehouse.dbo.factLoan m WITH (NOLOCK)
                     WHERE n.LoanNumber = m.LoanNumber
                          and m.LoanStatusDetail = 'REVERSED'
                  )

GO
/****** Object:  View [dbo].[tab_factPCRA_SecurePathForLife]    Script Date: 6/17/2021 10:58:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE      VIEW [dbo].[tab_factPCRA_SecurePathForLife] 
AS
WITH cte1 AS
(
 SELECT 
      f.dimplanId                     
	  ,f.dimdateId             	   
	  ,f.dimParticipantId
	  ,f.SOC_SEC_NO AS SocialSecurityNumber               

	  ,CASE WHEN df.FundDescription = 'PCRA' THEN 1 ELSE 0 END AS usePCRA
	  ,CASE WHEN df.AssetCategory =  'SecurePath for Life' THEN 1 ELSE 0 END AS useSecurePathForLife
	  ,SUM(f.Balance) AS fundBalance
  FROM  [TRS_BI_Datawarehouse].dbo.factBalance f WITH (NOLOCK) 	   
     --INNER JOIN [WorkplaceExperience].[ref].[EXPlans] ex ON f.Case_No = ex.PlanNumber  -- ADDED FOR PRODUCTION
	 INNER JOIN [TRS_BI_DataWarehouse].[dbo].dimFund df WITH (NOLOCK) ON f.dimFundId = df.dimFundId 
  WHERE --f.ViewFlag = 1
    f.dimEmployerAccountId = 0	 
    AND (df.FundDescription = 'PCRA' OR df.AssetCategory = 'SecurePath for Life')
  GROUP BY f.dimplanId                      
	  ,f.dimdateId             	   
	  ,f.dimParticipantId
	  ,f.SOC_SEC_NO
	  ,CASE WHEN df.FundDescription = 'PCRA' THEN 1 ELSE 0 END 
	  ,CASE WHEN df.AssetCategory =  'SecurePath for Life' THEN 1 ELSE 0 END	  	  
)
SELECT f.dimPlanId,
       f.dimDateId,
	   f.dimParticipantId,
	   CASE WHEN d.EmploymentStatus = 'ACTIVE' THEN 1 
	        WHEN d.EmploymentStatus = 'TERMED' THEN 0
			ELSE -1 
		END AS dimEmploymentStatusId,
	   f.SocialSecurityNumber,
	   COALESCE(pd.dimParticipantDivisionId, 0) AS dimDivisionId,
	   f.usePCRA,
	   f.useSecurePathForLife,
	   --MAX(f.fundBalance) AS fundBalance  -- commented out because we changed the join condition for division tables below
	   f.fundBalance
FROM cte1 f 
   INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimParticipant] d WITH (NOLOCK) ON d.dimParticipantId = f.dimParticipantId  
   INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd WITH (NOLOCK) ON pd.dimParticipantId = f.dimParticipantId     
   --LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pp WITH (NOLOCK) ON pd.EmployeeDivisionCode = pp.DivisionCode AND pd.CaseNumber = pp.ACCOUNT_NO	
WHERE NOT (d.MultiDivisionalParticipant = 'YES' AND d.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED')


GO
/****** Object:  Table [dbo].[ExCycleLog]    Script Date: 6/17/2021 10:58:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExCycleLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ProcessType] [varchar](20) NULL,
	[ProcessName] [varchar](50) NULL,
	[DatabaseName] [varchar](20) NULL,
	[TableName] [varchar](50) NULL,
	[LogMessage] [varchar](300) NULL,
	[Error] [char](1) NULL,
	[RecordDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[psol_shadow_user$]    Script Date: 6/17/2021 10:58:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[psol_shadow_user$](
	[ACCOUNT_NO] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[BalanceByFundCaseLevel]    Script Date: 6/17/2021 10:58:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[BalanceByFundCaseLevel](
	[dimPlanId] [int] NOT NULL,
	[PlanNumber] [varchar](20) NOT NULL,
	[ContractNumber] [varchar](10) NOT NULL,
	[AffiliateNumber] [varchar](10) NOT NULL,
	[CompanyName] [varchar](80) NOT NULL,
	[PlanName] [varchar](161) NOT NULL,
	[PlanType] [varchar](80) NOT NULL,
	[PlanCategory] [varchar](20) NOT NULL,
	[FD_PROV_I] [bigint] NULL,
	[FundSortOrder] [int] NOT NULL,
	[FundStyle] [varchar](30) NOT NULL,
	[AssetCategory] [varchar](30) NOT NULL,
	[AssetClass] [varchar](30) NOT NULL,
	[FundFamily] [varchar](35) NOT NULL,
	[FundName] [varchar](100) NOT NULL,
	[TickerSymbol] [varchar](100) NULL,
	[Participants] [int] NULL,
	[Balance] [decimal](38, 2) NULL,
	[UnitCount] [decimal](38, 6) NULL,
	[ReportDate] [date] NOT NULL,
	[LoadDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[BalanceByFundDivisionLevel]    Script Date: 6/17/2021 10:58:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[BalanceByFundDivisionLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NOT NULL,
	[ContractNumber] [varchar](10) NOT NULL,
	[AffiliateNumber] [varchar](10) NOT NULL,
	[CompanyName] [varchar](80) NOT NULL,
	[PlanName] [varchar](161) NOT NULL,
	[PlanType] [varchar](80) NOT NULL,
	[PlanCategory] [varchar](20) NOT NULL,
	[DIV_I] [varchar](50) NULL,
	[DivisionCode] [varchar](15) NULL,
	[DivisionName] [varchar](161) NULL,
	[FD_PROV_I] [bigint] NULL,
	[FundSortOrder] [int] NOT NULL,
	[FundStyle] [varchar](30) NOT NULL,
	[AssetCategory] [varchar](30) NOT NULL,
	[AssetClass] [varchar](30) NOT NULL,
	[FundFamily] [varchar](35) NOT NULL,
	[FundName] [varchar](100) NOT NULL,
	[Participants] [int] NULL,
	[Balance] [decimal](38, 2) NULL,
	[UnitCount] [decimal](38, 6) NULL,
	[ReportDate] [date] NOT NULL,
	[LoadDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[BalanceByFundUserLevel]    Script Date: 6/17/2021 10:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[BalanceByFundUserLevel](
	[dimPlanId] [int] NULL,
	[PlanNumber] [varchar](20) NULL,
	[UserId] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](80) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[FD_PROV_I] [bigint] NULL,
	[FundSortOrder] [int] NULL,
	[FundStyle] [varchar](30) NULL,
	[AssetCategory] [varchar](30) NULL,
	[AssetClass] [varchar](30) NULL,
	[FundFamily] [varchar](35) NULL,
	[FundName] [varchar](100) NULL,
	[TickerSymbol] [varchar](100) NULL,
	[Participants] [int] NULL,
	[Balance] [decimal](38, 2) NULL,
	[UnitCount] [decimal](38, 6) NULL,
	[ReportDate] [date] NULL,
	[LoadDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[CaseLevelMetrics]    Script Date: 6/17/2021 10:58:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[CaseLevelMetrics](
	[PlanNumber] [varchar](20) NOT NULL,
	[ContractNumber] [varchar](10) NOT NULL,
	[AffiliateNumber] [varchar](10) NOT NULL,
	[CompanyName] [varchar](80) NULL,
	[PlanName] [varchar](255) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](80) NULL,
	[Participants] [int] NULL,
	[ParticipantsActive] [int] NULL,
	[ParticipantsTerminated] [int] NULL,
	[TotalBalance] [decimal](15, 2) NULL,
	[AvgParticipantBalance] [decimal](15, 2) NULL,
	[EligibleEmployees] [int] NULL,
	[ContributingEmployees] [int] NULL,
	[NonContributingEmployees] [int] NULL,
	[ParticipationRate] [decimal](15, 2) NULL,
	[AvgContributionRate] [decimal](15, 2) NULL,
	[AvgContributionAmount] [decimal](15, 2) NULL,
	[EmployeesNotReceivingMatch] [int] NULL,
	[TotalOutlooks] [int] NULL,
	[OnTrackOutlooks] [int] NULL,
	[UnknownOutlooks] [int] NULL,
	[OnTrackOutlookPercentage] [decimal](15, 2) NULL,
	[ReportDate] [date] NOT NULL,
	[LoadDatetime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[EligibleEmployees]    Script Date: 6/17/2021 10:58:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[EligibleEmployees](
	[PlanNumber] [varchar](20) NULL,
	[dimParticipantId] [int] NULL,
	[dimUniqueSocialId] [int] NULL,
	[dimParticipantDivisionId] [int] NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[PART_ENRL_I] [decimal](17, 0) NULL,
	[DEF_GRP_NM] [varchar](80) NULL,
	[DEF_A] [decimal](13, 2) NULL,
	[DEF_P] [decimal](6, 3) NULL,
	[ReportDate] [date] NOT NULL,
	[LoadDatetime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[FundPerformanceCaseLevel]    Script Date: 6/17/2021 10:58:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[FundPerformanceCaseLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[EnterpriseBusinessLine] [varchar](10) NULL,
	[AssetCategory] [varchar](30) NULL,
	[AssetClass] [varchar](30) NULL,
	[FundStyle] [varchar](30) NULL,
	[FundFamily] [varchar](35) NULL,
	[FundDescriptionCode] [varchar](4) NULL,
	[FundName] [varchar](80) NULL,
	[FundGroupCode] [varchar](4) NULL,
	[FundInceptionDate] [varchar](10) NULL,
	[FundBusinessLine] [varchar](10) NULL,
	[OneMonthPerformance] [float] NULL,
	[ThreeMonthPerformance] [float] NULL,
	[YTDPerformance] [float] NULL,
	[OneYearPerformance] [float] NULL,
	[ThreeYearPerformance] [float] NULL,
	[FiveYearPerformance] [float] NULL,
	[TenYearPerformance] [float] NULL,
	[FifteenYearPerformance] [float] NULL,
	[TwentyYearPerformance] [float] NULL,
	[PerformanceSinceInception] [float] NULL,
	[NetExpenseRatio] [float] NULL,
	[GrossExpenseRatio] [float] NULL,
	[ReportDate] [date] NULL,
	[LoadDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[LoadStatus]    Script Date: 6/17/2021 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[LoadStatus](
	[LoadStage] [varchar](100) NULL,
	[LoadDate] [datetime] NULL,
	[LoadStatus] [varchar](20) NULL,
	[LoadError] [varchar](1000) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[MetricsCaseLevel]    Script Date: 6/17/2021 10:58:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[MetricsCaseLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](161) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[TotalParticipantCount] [int] NULL,
	[ActiveParticipantCount] [int] NULL,
	[TerminatedParticipantCount] [int] NULL,
	[TotalParticipantCountWithBalance] [int] NULL,
	[ActiveParticipantCountWithBalance] [int] NULL,
	[TerminatedParticipantCountWithBalance] [int] NULL,
	[ParticipationRate] [decimal](15, 2) NULL,
	[AvgContributionRate] [decimal](15, 2) NULL,
	[EligibleEmployeeCount] [int] NULL,
	[ContributingEmployeeCount] [int] NULL,
	[NonContributingEmployeeCount] [int] NULL,
	[AvgContributionAmount] [decimal](38, 2) NULL,
	[ActiveParticipantFundBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgActiveParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantFundBalance] [decimal](38, 2) NULL,
	[ActiveParticipantCoreFunds] [decimal](38, 2) NULL,
	[TerminatedParticipantCoreFunds] [decimal](38, 2) NULL,
	[AvgParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgActiveParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantCoreFund] [decimal](38, 2) NULL,
	[PCRA_Allowed_Flag] [bit] NULL,
	[ActiveParticipantPCRA] [decimal](38, 2) NULL,
	[TerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[AvgParticipantPCRA] [decimal](38, 2) NULL,
	[AvgActiveParticipantPCRA] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[SDB_Allowed_Flag] [bit] NULL,
	[ActiveParticipantSDB] [decimal](38, 2) NULL,
	[TerminatedParticipantSDB] [decimal](38, 2) NULL,
	[AvgParticipantSDB] [decimal](38, 2) NULL,
	[AvgActiveParticipantSDB] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantSDB] [decimal](38, 2) NULL,
	[SuspenseBalance] [decimal](38, 2) NULL,
	[ForefeitureBalance] [decimal](38, 2) NULL,
	[ExpenseAccountBalance] [decimal](38, 2) NULL,
	[AdvancedEmployerBalance] [decimal](38, 2) NULL,
	[ActiveParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialLoanBalance] [int] NULL,
	[ActiveParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[ActiveParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalLoanBalance] [int] NULL,
	[ActiveParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[ActiveParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithOtherLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithOtherLoanBalance] [int] NULL,
	[LoanPermittedFlag] [bit] NULL,
	[ParticipantsPastDue] [int] NULL,
	[AutoRebalanceFlag] [int] NULL,
	[AutoIncreaseFlag] [int] NULL,
	[CustomPortfoliosFlag] [int] NULL,
	[DCMAFlag] [int] NULL,
	[FundTransferFlag] [int] NULL,
	[PCRAFlag] [int] NULL,
	[PortfolioXpressFlag] [int] NULL,
	[SDAFlag] [int] NULL,
	[SecurePathForLifeFlag] [int] NULL,
	[ReportDate] [date] NULL,
	[LoadDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[MetricsDivisionLevel]    Script Date: 6/17/2021 10:58:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[MetricsDivisionLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[DivisionCode] [varchar](20) NULL,
	[DIV_I] [bigint] NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](161) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[TotalParticipantCount] [int] NULL,
	[ActiveParticipantCount] [int] NULL,
	[TerminatedParticipantCount] [int] NULL,
	[ParticipationRate] [decimal](15, 2) NULL,
	[AvgContributionRate] [decimal](15, 2) NULL,
	[EligibleEmployeeCount] [int] NULL,
	[ContributingEmployeeCount] [int] NULL,
	[NonContributingEmployeeCount] [int] NULL,
	[AvgContributionAmount] [decimal](38, 2) NULL,
	[ActiveParticipantCoreFunds] [decimal](38, 2) NULL,
	[TerminatedParticipantCoreFunds] [decimal](38, 2) NULL,
	[AvgParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgActiveParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantCoreFund] [decimal](38, 2) NULL,
	[PCRA_Allowed_Flag] [bit] NULL,
	[ActiveParticipantPCRA] [decimal](38, 2) NULL,
	[TerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[AvgParticipantPCRA] [decimal](38, 2) NULL,
	[AvgActiveParticipantPCRA] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[SDB_Allowed_Flag] [bit] NULL,
	[ActiveParticipantSDB] [decimal](38, 2) NULL,
	[TerminatedParticipantSDB] [decimal](38, 2) NULL,
	[AvgParticipantSDB] [decimal](38, 2) NULL,
	[AvgActiveParticipantSDB] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantSDB] [decimal](38, 2) NULL,
	[SuspenseBalance] [decimal](38, 2) NULL,
	[ForefeitureBalance] [decimal](38, 2) NULL,
	[ExpenseAccountBalance] [decimal](38, 2) NULL,
	[AdvancedEmployerBalance] [decimal](38, 2) NULL,
	[ActiveParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialLoanBalance] [int] NULL,
	[ActiveParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[ActiveParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalLoanBalance] [int] NULL,
	[ActiveParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[ActiveParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithOtherLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithOtherLoanBalance] [int] NULL,
	[LoanPermittedFlag] [bit] NULL,
	[ParticipantsPastDue] [int] NULL,
	[ReportDate] [date] NULL,
	[LoadDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[MetricsUserLevel]    Script Date: 6/17/2021 10:59:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[MetricsUserLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[UserId] [varchar](20) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](161) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[TotalParticipantCount] [int] NULL,
	[ActiveParticipantCount] [int] NULL,
	[TerminatedParticipantCount] [int] NULL,
	[TotalParticipantCountWithBalance] [int] NULL,
	[ActiveParticipantCountWithBalance] [int] NULL,
	[TerminatedParticipantCountWithBalance] [int] NULL,
	[ParticipationRate] [decimal](15, 2) NULL,
	[AvgContributionRate] [decimal](15, 2) NULL,
	[EligibleEmployeeCount] [int] NULL,
	[ContributingEmployeeCount] [int] NULL,
	[NonContributingEmployeeCount] [int] NULL,
	[AvgContributionAmount] [decimal](38, 2) NULL,
	[ActiveParticipantFundBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgActiveParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantFundBalance] [decimal](38, 2) NULL,
	[ActiveParticipantCoreFunds] [decimal](38, 2) NULL,
	[TerminatedParticipantCoreFunds] [decimal](38, 2) NULL,
	[AvgParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgActiveParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantCoreFund] [decimal](38, 2) NULL,
	[PCRA_Allowed_Flag] [bit] NULL,
	[ActiveParticipantPCRA] [decimal](38, 2) NULL,
	[TerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[AvgParticipantPCRA] [decimal](38, 2) NULL,
	[AvgActiveParticipantPCRA] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[SDB_Allowed_Flag] [bit] NULL,
	[ActiveParticipantSDB] [decimal](38, 2) NULL,
	[TerminatedParticipantSDB] [decimal](38, 2) NULL,
	[AvgParticipantSDB] [decimal](38, 2) NULL,
	[AvgActiveParticipantSDB] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantSDB] [decimal](38, 2) NULL,
	[SuspenseBalance] [decimal](38, 2) NULL,
	[ForefeitureBalance] [decimal](38, 2) NULL,
	[ExpenseAccountBalance] [decimal](38, 2) NULL,
	[AdvancedEmployerBalance] [decimal](38, 2) NULL,
	[ActiveParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialLoanBalance] [int] NULL,
	[ActiveParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[ActiveParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalLoanBalance] [int] NULL,
	[ActiveParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[ActiveParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithOtherLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithOtherLoanBalance] [int] NULL,
	[LoanPermittedFlag] [bit] NULL,
	[ParticipantsPastDue] [int] NULL,
	[AutoRebalanceFlag] [int] NULL,
	[AutoIncreaseFlag] [int] NULL,
	[CustomPortfoliosFlag] [int] NULL,
	[DCMAFlag] [int] NULL,
	[FundTransferFlag] [int] NULL,
	[PCRAFlag] [int] NULL,
	[PortfolioXpressFlag] [int] NULL,
	[SDAFlag] [int] NULL,
	[SecurePathForLifeFlag] [int] NULL,
	[ReportDate] [date] NULL,
	[LoadDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[OutlooksUserLevel]    Script Date: 6/17/2021 10:59:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[OutlooksUserLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[RestrictedCaseFlag] [bit] NULL,
	[UserId] [char](12) NULL,
	[OntrackOutlookCount] [int] NULL,
	[UnknownOutlookCount] [int] NULL,
	[NotOntrackOutlookCount] [int] NULL,
	[TotalOutlookCount] [int] NULL,
	[OntrackPercentage] [decimal](15, 2) NULL,
	[ReportDate] [date] NULL,
	[LoadDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[ParticipantDetails]    Script Date: 6/17/2021 10:59:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[ParticipantDetails](
	[dimParticipantId] [bigint] NULL,
	[dimPlanid] [bigint] NULL,
	[CaseNumber] [varchar](20) NULL,
	[PlanName] [varchar](1000) NULL,
	[EmployerName] [varchar](1000) NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[EmployeeNumber] [varchar](100) NULL,
	[UserList] [varchar](max) NULL,
	[DivisionList] [varchar](max) NULL,
	[MultiDivisionFlag] [bit] NULL,
	[FirstName] [varchar](20) NULL,
	[MiddleInitial] [char](1) NULL,
	[LastName] [varchar](30) NULL,
	[Suffix] [varchar](10) NULL,
	[Gender] [varchar](15) NULL,
	[AddressLine1] [varchar](1000) NULL,
	[AddressLine2] [varchar](1000) NULL,
	[DeliverableStatus] [varchar](100) NULL,
	[AddressStatus] [varchar](100) NULL,
	[City] [varchar](1000) NULL,
	[StateAbbreviation] [varchar](5) NULL,
	[StateName] [varchar](1000) NULL,
	[ZipCode] [varchar](1000) NULL,
	[DayPhoneNumber] [varchar](1000) NULL,
	[DayPhoneExt] [varchar](10) NULL,
	[MobilePhoneNumber] [varchar](1000) NULL,
	[EveningPhoneNumber] [varchar](1000) NULL,
	[EveningPhoneExt] [varchar](10) NULL,
	[EmailAddress] [varchar](1000) NULL,
	[BirthDate] [date] NULL,
	[DeathDate] [date] NULL,
	[HireDate] [date] NULL,
	[TerminationDate] [date] NULL,
	[ReHireDate] [date] NULL,
	[LastStatementDate] [date] NULL,
	[PartSiteAccess] [varchar](20) NULL,
	[IVRAccess] [varchar](20) NULL,
	[SubLocation] [varchar](100) NULL,
	[PayRollCycle] [varchar](100) NULL,
	[HoursWorked] [bigint] NULL,
	[MaritalStatus] [varchar](20) NULL,
	[UserBalances] [varchar](max) NULL,
	[ReportDate] [date] NULL,
	[LoadDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [ex].[plans_list]    Script Date: 6/17/2021 10:59:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[plans_list](
	[planid] [bigint] NOT NULL,
	[plannumber] [varchar](20) NULL,
 CONSTRAINT [plans_list_pkey] PRIMARY KEY CLUSTERED 
(
	[planid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_CASE_DATA]    Script Date: 6/17/2021 10:59:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_CASE_DATA](
	[CASE_DATA_ID] [int] NULL,
	[PKG_ID] [varchar](4) NULL,
	[MASTER_CASE_NO] [varchar](20) NULL,
	[CASE_NO] [varchar](20) NULL,
	[RELATED_GRP_TYP_C] [smallint] NULL,
	[MULTI_DIV_CD] [varchar](1) NULL,
	[MULTI_PART_DIV_C] [varchar](1) NULL,
	[CASE_EFF_DT] [varchar](8) NULL,
	[TERM_DT] [varchar](8) NULL,
	[AFF_NO] [varchar](10) NULL,
	[CONT_NO] [varchar](10) NULL,
	[CASE_STAT_CD] [varchar](2) NULL,
	[LAST_PYE_VAL_DT] [varchar](8) NULL,
	[LAST_CYE_REV_DT] [varchar](8) NULL,
	[SERVICER_NOTIF_CD] [varchar](1) NULL,
	[PLAN_ANNV_DT] [varchar](4) NULL,
	[SERIES_5500_FIL_CD] [varchar](1) NULL,
	[PHONE_TRFR_ACC_CD] [varchar](1) NULL,
	[PX_RISK_PREF_C] [smallint] NULL,
	[PORTF_XPRS_MGR_C] [int] NULL,
	[PPA_WAIT_PERIOD] [smallint] NULL,
	[PPA_QDIA_PLAN_C] [varchar](1) NULL,
	[PLAN_NO] [varchar](5) NULL,
	[PLAN_PROD_TYP_CD] [varchar](2) NULL,
	[PLAN_DESC_C] [varchar](2) NULL,
	[ERISA_PLAN_C] [varchar](1) NULL,
	[ROTH_PLAN_C] [varchar](1) NULL,
	[PCRA_REMIT_C] [smallint] NULL,
	[PCRA_PROXY_DIR_C] [varchar](1) NULL,
	[INVESTOR_PLAN_ID] [varchar](10) NULL,
	[RCMA_NO] [varchar](8) NULL,
	[SDA_ACCOUNT_C] [smallint] NULL,
	[IN_PLN_ROTH_CONV_C] [smallint] NULL,
	[PYE_DT] [varchar](4) NULL,
	[PLAN_EFF_DT] [varchar](8) NULL,
	[FYE_DT] [varchar](4) NULL,
	[PLAN_TERM_DT] [varchar](8) NULL,
	[TERM_PAYT_DT] [varchar](4) NULL,
	[LN_PERMIT_C] [varchar](1) NULL,
	[INSERV_WD_ALLOW_C] [varchar](1) NULL,
	[HRDSHP_WD_ALLOW_C] [varchar](1) NULL,
	[NORM_RET_AGE_C] [smallint] NULL,
	[NORM_RTMT_AGE_T] [varchar](80) NULL,
	[EARLY_RET_AGE_C] [smallint] NULL,
	[EARLY_RTMT_AGE_T] [varchar](80) NULL,
	[VST_100_ERLY_RET_C] [smallint] NULL,
	[CALL_ROUTING_CD] [varchar](4) NULL,
	[AUTO_DEF_EFF_MONTH] [smallint] NULL,
	[AUTO_DEF_EFF_DAY] [smallint] NULL,
	[PART_COM_LVL_SRV_C] [smallint] NULL,
	[VESTING_IND_CD] [varchar](1) NULL,
	[CASE_TAX_TRMT_CD] [varchar](2) NULL,
	[SPL_IND_C] [varchar](1) NULL,
	[SPL_EFF_D] [date] NULL,
	[SPL_END_D] [date] NULL,
	[ACCESS_CD] [varchar](1) NULL,
	[BUSINESS_LINE] [varchar](10) NULL,
	[TLIC_TFLIC_IND_C] [varchar](1) NULL,
	[SERVICE_MODEL_TYP_C] [varchar](1) NULL,
	[EMPLOYER_TYP_C] [varchar](1) NULL,
	[PROCESS_FLAG] [tinyint] NULL,
	[CASE_TAX_REPT_CD] [varchar](6) NULL,
	[SEGMENTATION_C] [varchar](1) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_dimFund]    Script Date: 6/17/2021 10:59:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_dimFund](
	[dimFundId] [int] NULL,
	[FD_PROV_I] [numeric](17, 0) NULL,
	[BUS_LINE] [varchar](10) NULL,
	[FundDescription] [varchar](10) NULL,
	[FundNumber] [smallint] NULL,
	[FundNumberP3] [int] NULL,
	[FundSortOrder] [int] NULL,
	[AssetCategory] [varchar](30) NULL,
	[AssetClass] [varchar](30) NULL,
	[FundStyle] [varchar](30) NULL,
	[BlendedFundGroupCode] [varchar](10) NULL,
	[StockInvestmentMix] [numeric](9, 6) NULL,
	[StartDate] [date] NULL,
	[ClosedDate] [date] NULL,
	[FundDisplay] [varchar](20) NULL,
	[FundAction] [varchar](25) NULL,
	[ServiceOnly] [varchar](10) NULL,
	[Status] [varchar](10) NULL,
	[FundFamily] [varchar](35) NULL,
	[FundName] [varchar](100) NULL,
	[EffectiveFrom] [date] NULL,
	[EffectiveTo] [date] NULL,
	[ActiveRecordFlag] [tinyint] NULL,
	[CreateDate] [datetime2](6) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_dimInternalContact]    Script Date: 6/17/2021 11:00:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_dimInternalContact](
	[Account_NO] [varchar](20) NULL,
	[ClientExecutive] [varchar](51) NULL,
	[ClientConsultant] [varchar](51) NULL,
	[LoadDateTime] [datetime] NULL,
	[ReportDateId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_dimOutlookForecast]    Script Date: 6/17/2021 11:00:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_dimOutlookForecast](
	[dimOutlookForecastId] [tinyint] NULL,
	[Weather] [varchar](25) NULL,
	[OutlookStatus] [varchar](25) NULL,
	[CreateDate] [datetime2](6) NULL,
	[WeatherSortKey] [tinyint] NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_dimParticipant]    Script Date: 6/17/2021 11:00:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_dimParticipant](
	[dimParticipantId] [int] NULL,
	[SocialSecurityNumber] [varchar](64) NULL,
	[CaseNumber] [varchar](20) NULL,
	[PART_ENRL_I] [numeric](17, 0) NULL,
	[HighlyCompensated] [varchar](10) NULL,
	[ParticipantStatus] [varchar](35) NULL,
	[DepartmentCode] [varchar](12) NULL,
	[EENumber] [varchar](20) NULL,
	[Class] [varchar](250) NULL,
	[CatchupElection] [varchar](20) NULL,
	[MultiDivisionalParticipant] [varchar](10) NULL,
	[HireDate] [date] NULL,
	[RehireDate] [date] NULL,
	[RetirementDate] [date] NULL,
	[TerminationDate] [date] NULL,
	[EmploymentStatus] [varchar](10) NULL,
	[StayInPlanDate] [date] NULL,
	[CycleDate] [date] NULL,
	[PlanEntryDate] [date] NULL,
	[PCRAEnrollDate] [date] NULL,
	[PCRAStatus] [varchar](40) NULL,
	[PCRAEnrollSource] [varchar](10) NULL,
	[DeathDate] [date] NULL,
	[Language] [varchar](10) NULL,
	[BusinessLine] [varchar](10) NULL,
	[EffectiveFrom] [date] NULL,
	[EffectiveTo] [date] NULL,
	[ActiveRecordFlag] [tinyint] NULL,
	[CreateDate] [datetime2](6) NULL,
	[LastModifiedDate] [datetime2](6) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_dimParticipantDivision]    Script Date: 6/17/2021 11:00:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_dimParticipantDivision](
	[dimParticipantId] [int] NULL,
	[dimParticipantDivisionId] [int] NULL,
	[CaseNumber] [varchar](20) NULL,
	[SocialSecurityNumber] [varchar](64) NULL,
	[PART_ENRL_I] [numeric](17, 0) NULL,
	[DivisionEENumber] [varchar](20) NULL,
	[DIV_I] [numeric](17, 0) NULL,
	[EmployeeDivisionCode] [varchar](15) NULL,
	[EmployerDivisionCode] [varchar](15) NULL,
	[DivisionHireDate] [date] NULL,
	[DivisionTermDate] [date] NULL,
	[DivisionRehireDate] [date] NULL,
	[DivisionEmploymentStatus] [varchar](10) NULL,
	[MultiDivisionIndicator] [varchar](10) NULL,
	[BusinessLine] [varchar](10) NULL,
	[EffectiveFrom] [date] NULL,
	[EffectiveTo] [date] NULL,
	[ActiveRecordFlag] [tinyint] NULL,
	[CreateDate] [datetime2](6) NULL,
	[LastModifiedDate] [datetime2](6) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Index [ClusteredIndex-stg_dimParticipantDivision-dimParticipantDivisionId]    Script Date: 6/17/2021 11:00:15 AM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-stg_dimParticipantDivision-dimParticipantDivisionId] ON [ex].[stg_dimParticipantDivision]
(
	[dimParticipantDivisionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Table [ex].[stg_dimPlan]    Script Date: 6/17/2021 11:00:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_dimPlan](
	[dimPlanId] [int] NULL,
	[CaseNumber] [varchar](20) NULL,
	[PlanNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[ContractNumber] [varchar](10) NULL,
	[CaseReferenceNumber] [varchar](12) NULL,
	[MultiDivision] [varchar](7) NULL,
	[MultiPartDivision] [varchar](7) NULL,
	[CaseEffectiveDate] [date] NULL,
	[TerminationDate] [date] NULL,
	[EmployerIdentificationNumber] [varchar](10) NULL,
	[Last_PYE_ValidationDate] [date] NULL,
	[Last_CYE_ValidationDate] [date] NULL,
	[PlanAnniversary] [varchar](4) NULL,
	[PlanProductType] [varchar](80) NULL,
	[ERISA_Plan] [varchar](7) NULL,
	[RothPlan] [varchar](80) NULL,
	[PCRA_Remit] [varchar](7) NULL,
	[PCRA_Proxy_Dir] [varchar](80) NULL,
	[InvestorPlanID] [varchar](10) NULL,
	[RCMA_Number] [varchar](8) NULL,
	[SDA_Account] [varchar](7) NULL,
	[InPlanRothConversion] [varchar](7) NULL,
	[PYE_Date] [varchar](4) NULL,
	[PlanEffectiveDate] [date] NULL,
	[FYE_Date] [varchar](4) NULL,
	[PlanTerminationDate] [date] NULL,
	[TermPayoutDate] [varchar](4) NULL,
	[LoanPermitted] [varchar](7) NULL,
	[InserviceWithdrawalAllowed] [varchar](7) NULL,
	[HardshipWithdrawalAllowed] [varchar](7) NULL,
	[NormalRetirementAgeDescription] [varchar](80) NULL,
	[EarlyRetirementAgeDescription] [varchar](80) NULL,
	[Vested100EarlyRetirement] [varchar](7) NULL,
	[AutoDeferalEffectiveMonth] [smallint] NULL,
	[AutoDeferalEffectiveDay] [smallint] NULL,
	[PartComLvlSrv] [varchar](80) NULL,
	[CaseTaxTreatment] [varchar](50) NULL,
	[SPL_Indicator] [varchar](7) NULL,
	[SPL_EffectiveDate] [date] NULL,
	[SPL_EndDate] [date] NULL,
	[EffectiveFrom] [date] NULL,
	[EffectiveTo] [date] NULL,
	[ActiveRecordFlag] [tinyint] NULL,
	[CaseStatus] [varchar](80) NULL,
	[BusinessLine] [varchar](10) NULL,
	[Relationship] [varchar](80) NULL,
	[Alliance] [varchar](80) NULL,
	[MarketType] [varchar](80) NULL,
	[ERName] [varchar](80) NULL,
	[PlanName] [varchar](161) NULL,
	[CompanyName] [varchar](161) NULL,
	[Address] [varchar](80) NULL,
	[City] [varchar](20) NULL,
	[StateAbbreviation] [varchar](2) NULL,
	[ZipCode] [varchar](10) NULL,
	[Series5500] [varchar](7) NULL,
	[PhoneTransferAcc] [varchar](80) NULL,
	[PortfolioXpressRiskPreference] [varchar](7) NULL,
	[PPA_WaitPeriod] [smallint] NULL,
	[PlanDescription] [varchar](80) NULL,
	[CaseAccess] [varchar](250) NULL,
	[StateName] [varchar](80) NULL,
	[CarveOutName] [varchar](80) NULL,
	[PlanServiceType] [varchar](80) NULL,
	[EmployerType] [varchar](80) NULL,
	[IndustrySector] [varchar](255) NULL,
	[IndustryType] [varchar](80) NULL,
	[HashKey] [varchar](64) NULL,
	[IndustryTypeCode] [varchar](12) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_dimPlanDivision]    Script Date: 6/17/2021 11:00:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_dimPlanDivision](
	[dimPlanDivisionId] [int] NULL,
	[ACCOUNT_NO] [varchar](20) NULL,
	[DIV_I] [numeric](17, 0) NULL,
	[DivisionCode] [varchar](15) NULL,
	[DivisionName] [varchar](161) NULL,
	[BusinessLine] [varchar](10) NULL,
	[EffectiveFrom] [date] NULL,
	[EffectiveTo] [date] NULL,
	[ActiveRecordFlag] [tinyint] NULL,
	[CreateDate] [datetime2](6) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_factBalance]    Script Date: 6/17/2021 11:00:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_factBalance](
	[factBalanceId] [bigint] NULL,
	[TRANSACT_I] [numeric](17, 0) NULL,
	[CASE_NO] [varchar](20) NULL,
	[ENRL_PROV_GRP_I] [numeric](17, 0) NULL,
	[SOC_SEC_NO] [varchar](64) NULL,
	[dimDateId] [int] NULL,
	[dimEmployerAccountId] [int] NULL,
	[dimParticipantId] [int] NULL,
	[dimPlanId] [int] NULL,
	[dimContributionSourceId] [int] NULL,
	[dimDiversificationId] [tinyint] NULL,
	[dimUniqueSocialId] [int] NULL,
	[dimAgeId] [int] NULL,
	[SRC_I] [numeric](17, 0) NULL,
	[dimFundId] [int] NULL,
	[FD_PROV_I] [numeric](17, 0) NULL,
	[dimInternalContactId] [int] NULL,
	[ViewFlag] [tinyint] NULL,
	[Balance] [numeric](15, 2) NULL,
	[Principal] [numeric](15, 2) NULL,
	[Credited] [numeric](15, 2) NULL,
	[Accrued] [numeric](15, 2) NULL,
	[Dividend] [numeric](15, 2) NULL,
	[UnitCount] [numeric](15, 6) NULL,
	[CREATE_DATE] [date] NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_factLoan]    Script Date: 6/17/2021 11:00:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_factLoan](
	[factLoanId] [bigint] NULL,
	[LoanNumber] [varchar](14) NULL,
	[CaseNumber] [varchar](20) NULL,
	[SocialSecurityNumber] [varchar](64) NULL,
	[Division] [bigint] NULL,
	[DivisionCode] [varchar](15) NULL,
	[LoanAmount] [numeric](15, 2) NULL,
	[LoanDefaultAmount] [numeric](15, 2) NULL,
	[LoanDuration] [smallint] NULL,
	[RepaymentFrequency] [varchar](32) NULL,
	[LoanCategory] [varchar](32) NULL,
	[LoanStatus] [varchar](32) NULL,
	[LoanStatusDetail] [varchar](32) NULL,
	[LoanType] [varchar](32) NULL,
	[LoanRequestDateId] [int] NULL,
	[LoanIssueDateId] [int] NULL,
	[LoanTakeoverDateId] [int] NULL,
	[FirstRepaymentDueDateId] [int] NULL,
	[GracePeriodStartDateId] [int] NULL,
	[GracePeriodEndDateId] [int] NULL,
	[LoanDefaultDateId] [int] NULL,
	[LoanDeemedDeferralDateId] [int] NULL,
	[ReamortizedDateId] [int] NULL,
	[FinalLoanRepaymentDateId] [int] NULL,
	[LoanPayoffDateId] [int] NULL,
	[LoanProtectDateId] [int] NULL,
	[LoanProtectFlag] [varchar](3) NULL,
	[EffectiveAnnualPercentageRate] [numeric](7, 4) NULL,
	[ReamortizedFlag] [varchar](3) NULL,
	[ReamortizedReason] [varchar](32) NULL,
	[RefinancedFlag] [varchar](3) NULL,
	[GraceReason] [varchar](64) NULL,
	[WithdrawnTransactionReferenceNumber] [varchar](14) NULL,
	[LoanGoalAmount] [numeric](15, 2) NULL,
	[ViewFlag] [tinyint] NULL,
	[dimParticipantId] [int] NULL,
	[dimPlanId] [int] NULL,
	[dimUniqueSocialId] [int] NULL,
	[dimSourceOfActionId] [int] NULL,
	[dimAgeId] [int] NULL,
	[dimPlanDivisionId] [int] NULL,
	[ActiveRecordFlag] [tinyint] NULL,
	[EffectiveFrom] [date] NULL,
	[EffectiveTo] [date] NULL,
	[CreateDate] [datetime2](7) NULL,
	[InsertSessionId] [int] NULL,
	[UpdateSessionId] [int] NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_factLoanTransaction]    Script Date: 6/17/2021 11:00:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_factLoanTransaction](
	[factLoanTransactionId] [bigint] NULL,
	[LoanNumber] [varchar](14) NULL,
	[LoanTransactionDateId] [int] NULL,
	[CaseNumber] [varchar](20) NULL,
	[SocialSecurityNumber] [varchar](64) NULL,
	[OpeningLoanBalance] [numeric](15, 2) NULL,
	[ClosingLoanBalance] [numeric](15, 2) NULL,
	[LoanPaymentAmount] [numeric](15, 2) NULL,
	[PaymentPrincipal] [numeric](15, 2) NULL,
	[PaymentInterest] [numeric](15, 2) NULL,
	[PaymentFees] [numeric](15, 2) NULL,
	[ViewFlag] [tinyint] NULL,
	[dimParticipantId] [int] NULL,
	[dimPlanId] [int] NULL,
	[dimUniqueSocialId] [int] NULL,
	[StatementMessageCode] [int] NULL,
	[AlternateRepaymentAmount1] [numeric](15, 2) NULL,
	[AlternateRepaymentAmount2] [numeric](15, 2) NULL,
	[CreateDate] [datetime2](7) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_factOutlook]    Script Date: 6/17/2021 11:00:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_factOutlook](
	[factOutlookId] [int] NULL,
	[dimOutlookId] [int] NULL,
	[SocialSecurityNumber] [varchar](64) NULL,
	[Salary] [numeric](18, 2) NULL,
	[SalaryGoal] [numeric](18, 2) NULL,
	[SpouseSalary] [numeric](18, 2) NULL,
	[SpouseGoal] [numeric](18, 2) NULL,
	[SpouseSocialSecurityPayment] [numeric](18, 2) NULL,
	[PreTaxRegular] [numeric](18, 4) NULL,
	[PreTaxCatchUp] [numeric](18, 4) NULL,
	[RothRegular] [numeric](18, 4) NULL,
	[RothCatchUp] [numeric](18, 4) NULL,
	[PostRegular] [numeric](18, 4) NULL,
	[Tier1MatchPercent] [numeric](18, 2) NULL,
	[Tier1UpperLimitPercent] [numeric](18, 2) NULL,
	[Tier1UpperLimitAmount] [numeric](18, 2) NULL,
	[Tier2MatchPercent] [numeric](18, 2) NULL,
	[Tier2UpperLimitPercent] [numeric](18, 2) NULL,
	[Tier2UpperLimitAmount] [numeric](18, 2) NULL,
	[Tier3MatchPercent] [numeric](18, 2) NULL,
	[Tier3UpperLimitPercent] [numeric](18, 2) NULL,
	[Tier3UpperLimitAmount] [numeric](18, 2) NULL,
	[ProfitSharingAmount] [numeric](18, 2) NULL,
	[ProfitSharingPercent] [numeric](18, 2) NULL,
	[IncomeGoal] [numeric](18, 2) NULL,
	[IncomeEstimate] [numeric](18, 2) NULL,
	[LowIncomeEstimate] [numeric](18, 2) NULL,
	[HighIncomeEstimate] [numeric](18, 2) NULL,
	[RangeEstimate] [numeric](18, 2) NULL,
	[ProbabilityOfSuccess] [numeric](18, 2) NULL,
	[GapMeasure] [numeric](18, 4) NULL,
	[dimDateId] [int] NULL,
	[dimSourceOfActionId] [int] NULL,
	[dimUniqueSocialId] [int] NULL,
	[dimOutlookForecastId] [tinyint] NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Index [ClusteredIndex-stg_factOutlook-factOutlookId]    Script Date: 6/17/2021 11:01:01 AM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-stg_factOutlook-factOutlookId] ON [ex].[stg_factOutlook]
(
	[factOutlookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [ex].[stg_factParticipant]    Script Date: 6/17/2021 11:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_factParticipant](
	[factParticipantId] [bigint] NULL,
	[CaseNumber] [varchar](20) NULL,
	[SocialSecurityNumber] [varchar](64) NULL,
	[dimDateId] [int] NULL,
	[dimPlanId] [int] NULL,
	[dimParticipantId] [int] NULL,
	[dimAgeId] [int] NULL,
	[dimDiversificationId] [tinyint] NULL,
	[dimEligibilityClassId] [int] NULL,
	[dimEmployerAccountId] [int] NULL,
	[dimEmploymentStatusId] [tinyint] NULL,
	[dimInternalContactId] [int] NULL,
	[dimOutlookForecastId] [tinyint] NULL,
	[dimOutlookId] [int] NULL,
	[dimUniqueSocialId] [int] NULL,
	[BalanceIndicator] [tinyint] NULL,
	[ViewFlag] [tinyint] NULL,
	[Balance] [numeric](15, 2) NULL,
	[StockInvestmentMix] [numeric](18, 9) NULL,
	[BondInvestmentMix] [numeric](18, 9) NULL,
	[MultiAssetOtherInvestmentMix] [numeric](18, 9) NULL,
	[SecurePathInvestmentMix] [numeric](18, 9) NULL,
	[UnknownInvestmentMix] [numeric](18, 9) NULL,
	[ManagedAccountId] [int] NULL,
	[AutoRebalanceId] [int] NULL,
	[RecurringTransfersId] [int] NULL,
	[PortfolioXpressId] [int] NULL,
	[CustomPortfolioId] [int] NULL,
	[SecurePlanForLifeId] [int] NULL,
	[ManagedAdviceId] [int] NULL,
	[EStatementsId] [int] NULL,
	[EConfirmId] [int] NULL,
	[EInvestMaterialsId] [int] NULL,
	[PCRAParticipationId] [int] NULL,
	[RequiredNoticesId] [int] NULL,
	[OnTrackEdMaterialsId] [int] NULL,
	[PlanRelatedMaterialsId] [int] NULL,
	[EnrollmentMaterialId] [int] NULL,
	[ConversionMaterialId] [int] NULL,
	[refParticipantEligibilityId] [int] NULL,
	[PreTaxEligible] [tinyint] NULL,
	[EmployerMatchEligible] [tinyint] NULL,
	[DeferralAmount] [numeric](13, 2) NULL,
	[DeferralPercent] [numeric](6, 3) NULL,
	[DeferralAmountMatch] [numeric](13, 2) NULL,
	[DeferralPercentMatch] [numeric](6, 3) NULL,
	[IsContributing] [tinyint] NULL,
	[InsertSessionId] [int] NULL,
	[CreateDate] [datetime] NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_FP_FUND_DESC]    Script Date: 6/17/2021 11:01:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_FP_FUND_DESC](
	[FD_DESC_CD] [varchar](4) NULL,
	[FD_NM] [varchar](80) NULL,
	[FD_INDX_DESC_CD] [varchar](4) NULL,
	[NASDAQ_SYM] [varchar](12) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_FP_MIRROR_FUND]    Script Date: 6/17/2021 11:01:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_FP_MIRROR_FUND](
	[FP_MIRROR_FUND_ID] [int] NOT NULL,
	[FP_MIRROR_DESC_CD] [char](4) NOT NULL,
	[FD_DESC_CD] [char](4) NOT NULL,
	[CREATION_TS] [datetime2](6) NULL,
	[USER_ID] [char](8) NULL,
	[MOD_TS] [datetime2](6) NULL,
	[BUSINESS_LINE] [varchar](10) NOT NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_FUNDDESC]    Script Date: 6/17/2021 11:01:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_FUNDDESC](
	[FUNDDESC_ID] [int] NOT NULL,
	[PKG_ID] [char](4) NOT NULL,
	[FD_DESCR_CODE] [char](4) NOT NULL,
	[FD_ACCT_IND_CD] [char](1) NOT NULL,
	[FD_TYPE_CD] [char](1) NOT NULL,
	[FD_PL_AMT_TYPE_CD] [char](1) NOT NULL,
	[FD_ASSET_CHRG_CD] [char](1) NOT NULL,
	[FD_DECIMAL_POS_CD] [char](2) NOT NULL,
	[FD_EFF_DATE] [char](8) NOT NULL,
	[FD_REC_DATE] [char](8) NOT NULL,
	[FD_TERM_DATE] [char](8) NOT NULL,
	[FD_VALTN_FREQ_CD] [char](2) NOT NULL,
	[FD_VALTN_DAY_CD] [char](2) NOT NULL,
	[FD_VALTN_PERIOD_CD] [char](1) NOT NULL,
	[FD_UNIT_VAL_CNT] [char](1) NOT NULL,
	[FD_UNIT_DEC_CNT] [char](1) NOT NULL,
	[FD_UNIT_VAL_CHRG] [char](1) NOT NULL,
	[FD_CHRG_INT_CD] [char](1) NOT NULL,
	[FD_DWRR_CALC_CD] [char](1) NOT NULL,
	[FD_FUND_ACCT_CD] [char](2) NOT NULL,
	[FD_ER_SEC_BAS_CD] [char](1) NOT NULL,
	[FD_INVEST_LIQ_CHRG] [char](2) NOT NULL,
	[FD_PROF_LOSS_CALC] [char](1) NOT NULL,
	[FD_PROF_LOSS_REV] [char](1) NOT NULL,
	[FD_ADMIN_CHRG_CD] [char](1) NOT NULL,
	[FD_INT_TYPE_CD] [char](1) NOT NULL,
	[FD_PROC_YR_CD] [char](1) NOT NULL,
	[FD_DEPOSIT_INCLUS] [char](1) NOT NULL,
	[FD_WITHDRL_DTE_CD] [char](1) NOT NULL,
	[FD_PROD_TYP_CD] [char](4) NOT NULL,
	[FD_TRFR_AGT_CD] [char](2) NOT NULL,
	[FD_MNY_MKT_IND_CD] [char](1) NOT NULL,
	[TWRR_ASSET_CAT_CD] [char](1) NOT NULL,
	[AST_CHRG_FACTR_AMT] [decimal](5, 4) NOT NULL,
	[SAF_FD_CD] [char](1) NOT NULL,
	[SEGMENT_CD] [char](2) NOT NULL,
	[SPECIAL_FD_TYPE_CD] [char](1) NOT NULL,
	[FD_CUSIP_CD] [char](9) NOT NULL,
	[FD_NSCC_SUM_CD] [char](1) NOT NULL,
	[DLY_DIVD_REINV_CD] [char](1) NOT NULL,
	[DVD_SPLT_RT_PRC_CD] [char](1) NOT NULL,
	[DIVD_REINV_FREQ_CD] [char](1) NOT NULL,
	[DIVD_FREQ_CD] [char](1) NOT NULL,
	[TRANSLATION_NM] [char](10) NOT NULL,
	[FD_FAM_C] [smallint] NOT NULL,
	[FD_CLASS_C] [smallint] NOT NULL,
	[FD_EXPENSE_C] [smallint] NOT NULL,
	[RISK_RETURN_SEQ_NO] [int] NOT NULL,
	[PRIMARY_FD_C] [char](1) NOT NULL,
	[STAT_C] [char](1) NOT NULL,
	[REINV_DAY_TYP_C] [char](1) NOT NULL,
	[REINV_DAY_NO] [char](1) NOT NULL,
	[REINV_WEEK_NO] [char](1) NOT NULL,
	[REINV_MO_DAY_C] [char](2) NOT NULL,
	[NEXT_REINV_D] [date] NULL,
	[LAST_REINV_D] [date] NULL,
	[FD_STYLE_C] [smallint] NOT NULL,
	[MOD_TS] [datetime2](6) NOT NULL,
	[REPORT_1_FD_NM] [char](25) NOT NULL,
	[REPORT_2_FD_NM] [char](25) NOT NULL,
	[BLENDED_FD_GRP_C] [char](10) NOT NULL,
	[SHARE_ACCTG_C] [char](1) NOT NULL,
	[RETIRE_FD_C] [smallint] NOT NULL,
	[FD_PROSPECTUS_C] [char](1) NOT NULL,
	[ROUND_TRIP_C] [char](1) NOT NULL,
	[SPL_MIN_LKIN_TR_A] [decimal](17, 2) NOT NULL,
	[SPL_MIN_ENRL_AGE] [smallint] NOT NULL,
	[SPL_MAX_ENRL_AGE] [smallint] NOT NULL,
	[SPL_MAX_PART_AGE] [smallint] NOT NULL,
	[SPL_MAX_INVEST_A] [decimal](17, 2) NOT NULL,
	[SPL_RELATED_DESC] [char](4) NOT NULL,
	[BLEND_MATURITY_D] [date] NULL,
	[ANNUITY_TYP_C] [char](2) NOT NULL,
	[STOCK_STARTUP_C] [char](1) NOT NULL,
	[ANNUITY_CONT_NM] [varchar](256) NOT NULL,
	[DIV_DAY_OF_DEPOSIT_C] [smallint] NOT NULL,
	[DIV_DAY_OF_WD_C] [smallint] NOT NULL,
	[DIV_CUTOVER_D] [date] NULL,
	[DIV_COMPD_FREQ_C] [smallint] NOT NULL,
	[DIV_COMPD_CUTOVER_D] [date] NULL,
	[DIV_CLOSE_D] [date] NULL,
	[NOTIFICATION_C] [smallint] NOT NULL,
	[FD_RESTRC_GRP_C] [smallint] NOT NULL,
	[DISPLAY_BLEND_FD_C] [char](1) NOT NULL,
	[BUSINESS_LINE] [varchar](10) NOT NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_LE_ROLE_CP_REL]    Script Date: 6/17/2021 11:01:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_LE_ROLE_CP_REL](
	[LE_I] [numeric](17, 0) NULL,
	[LE_ROLE_C] [smallint] NULL,
	[RELATED_I] [numeric](17, 0) NULL,
	[RELATED_TYP_C] [smallint] NULL,
	[CP_I] [numeric](17, 0) NULL,
	[CP_TYP_C] [varchar](1) NULL,
	[MOD_TS] [datetime2](6) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_LE_TELEPHONE]    Script Date: 6/17/2021 11:01:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_LE_TELEPHONE](
	[CP_I] [numeric](17, 0) NULL,
	[PHONE_NO] [varchar](12) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_OUTSRC_ELIG_SRC]    Script Date: 6/17/2021 11:01:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_OUTSRC_ELIG_SRC](
	[OUTSRC_I] [numeric](17, 0) NULL,
	[SRC_I] [numeric](17, 0) NULL,
	[SERV_LEV_C] [varchar](1) NULL,
	[STAT_C] [smallint] NULL,
	[EFF_D] [date] NULL,
	[MOD_TS] [datetime2](6) NULL,
	[BUSINESS_LINE] [varchar](10) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_OUTSRC_SERVICE]    Script Date: 6/17/2021 11:01:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_OUTSRC_SERVICE](
	[OUTSRC_I] [decimal](17, 0) NOT NULL,
	[SERV_TYP_C] [smallint] NOT NULL,
	[SERV_OFFERING_C] [char](1) NOT NULL,
	[SERV_STATUS_C] [char](1) NOT NULL,
	[OUTSRC_SERV_BEG_D] [date] NULL,
	[OUTSRC_SERV_END_D] [date] NULL,
	[OUTSRC_RPT_C] [smallint] NOT NULL,
	[USER_I] [char](12) NOT NULL,
	[MOD_TS] [datetime2](6) NOT NULL,
	[SURROGATE_KEY] [bigint] NOT NULL,
	[BUSINESS_LINE] [varchar](10) NOT NULL,
	[LoadDateTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_PERSON_SEARCH]    Script Date: 6/17/2021 11:01:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_PERSON_SEARCH](
	[PERSON_I] [numeric](17, 0) NULL,
	[LAST_NM] [varchar](30) NULL,
	[FST_MID_NM] [varchar](20) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_PLAN_FUND]    Script Date: 6/17/2021 11:01:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_PLAN_FUND](
	[FUND_ID] [bigint] NULL,
	[FD_PROV_I] [numeric](17, 0) NULL,
	[FD_DESC_CD] [varchar](4) NULL,
	[DIRECTION_C] [varchar](1) NULL,
	[FD_S] [smallint] NULL,
	[FD_FAMILY_PROV_I] [numeric](17, 0) NULL,
	[STAT_C] [varchar](1) NULL,
	[COMMENTS_T] [varchar](80) NULL,
	[FD_SEQ_N] [int] NULL,
	[FD_CLOSED_D] [date] NULL,
	[INT_RATE_DISP_C] [smallint] NULL,
	[SERVICE_ONLY_C] [varchar](1) NULL,
	[SEND_PROSPECTUS_C] [varchar](1) NULL,
	[BUSINESS_LINE] [varchar](10) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_PLAN_PROV_GRP]    Script Date: 6/17/2021 11:01:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_PLAN_PROV_GRP](
	[PLAN_PROV_GRP_ID] [int] NULL,
	[PLAN_ENRL_I] [numeric](17, 0) NULL,
	[ENRL_PROV_GRP_I] [numeric](17, 0) NULL,
	[DFLT_GRP_C] [varchar](1) NULL,
	[RELATED_GRP_I] [numeric](17, 0) NULL,
	[RELATED_GRP_TYP_C] [smallint] NULL,
	[ACCOUNT_NO] [varchar](20) NULL,
	[BUS_LINE_C] [varchar](1) NULL,
	[ENRL_STAT_C] [smallint] NULL,
	[CONV_STAT_C] [smallint] NULL,
	[CONV_D] [date] NULL,
	[CREATION_TS] [datetime2](6) NULL,
	[PROV_GRP_RSN_C] [varchar](1) NULL,
	[REL_C] [varchar](1) NULL,
	[PROV_GRP_OPT_C] [varchar](1) NULL,
	[BUSINESS_LINE] [varchar](10) NULL,
	[PROV_GRP_SRCH_NM] [varchar](80) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_PLAN_PROVISION]    Script Date: 6/17/2021 11:01:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_PLAN_PROVISION](
	[PLAN_PROVISION_ID] [int] NULL,
	[ENRL_PROV_GRP_I] [numeric](17, 0) NULL,
	[PROVISION_I] [numeric](17, 0) NULL,
	[PROV_TYP_C] [smallint] NULL,
	[PROV_OWNER_C] [varchar](1) NULL,
	[RELATED_I] [numeric](17, 0) NULL,
	[RELATED_TYP_C] [smallint] NULL,
	[MOD_TS] [datetime2](6) NULL,
	[BUSINESS_LINE] [varchar](10) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_SalesforceEmployee]    Script Date: 6/17/2021 11:01:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_SalesforceEmployee](
	[FirstName] [nvarchar](40) NULL,
	[LastName] [nvarchar](80) NULL,
	[MiddleName_c] [nvarchar](30) NULL,
	[Email] [nvarchar](128) NULL,
	[MobilePhone] [nvarchar](40) NULL,
	[Phone] [nvarchar](40) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_SalesforceEmployee_bak]    Script Date: 6/17/2021 11:01:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_SalesforceEmployee_bak](
	[FirstName] [nvarchar](40) NULL,
	[LastName] [nvarchar](80) NULL,
	[Email] [nvarchar](128) NULL,
	[FederationIdentifier] [nvarchar](512) NULL,
	[MobilePhone] [nvarchar](40) NULL,
	[Phone] [nvarchar](40) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_tab_factDeferral]    Script Date: 6/17/2021 11:01:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_tab_factDeferral](
	[id] [int] NULL,
	[DIV_I] [numeric](17, 0) NULL,
	[SocialSecurityNumber] [varchar](64) NULL,
	[DEF_GRP_NM] [varchar](80) NULL,
	[SRC_I] [numeric](17, 0) NULL,
	[DEF_P] [numeric](6, 3) NULL,
	[DEF_A] [numeric](13, 2) NULL,
	[DOC_NM] [varchar](50) NULL,
	[CaseNumber] [varchar](20) NULL,
	[ENRL_PROV_GRP_I] [numeric](17, 0) NULL,
	[PART_ENRL_I] [numeric](17, 0) NULL,
	[SRC_TYP_C] [smallint] NULL,
	[EFF_D] [date] NULL,
	[MonthEndFlag] [tinyint] NULL,
	[TheType] [varchar](10) NULL,
	[EffDateId] [int] NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[stg_WorkdayEmployee_bak]    Script Date: 6/17/2021 11:01:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[stg_WorkdayEmployee_bak](
	[EmployeeID] [nvarchar](25) NULL,
	[EmployeeFirstName] [varchar](50) NULL,
	[EmployeeMiddleName] [varchar](50) NULL,
	[EmployeeLastName] [varchar](50) NULL,
	[EmployeeFullName] [varchar](100) NULL,
	[EmployeeEmailAddress] [varchar](100) NULL,
	[LoadDateTime] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ex].[SupportTeam]    Script Date: 6/17/2021 11:02:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ex].[SupportTeam](
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](80) NULL,
	[PlanName] [varchar](255) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](80) NULL,
	[FirstName] [varchar](51) NULL,
	[LastName] [varchar](51) NULL,
	[FullName] [varchar](102) NULL,
	[SupportRole] [varchar](51) NULL,
	[PhoneNumber] [varchar](12) NULL,
	[EmailAddress] [varchar](255) NULL,
	[ReportDate] [date] NOT NULL,
	[LoadDatetime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[APP_IDS]    Script Date: 6/17/2021 11:02:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[APP_IDS](
	[APP_I] [decimal](17, 0) NULL,
	[APP_DESC_T] [varchar](80) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[APP_RESOURCES]    Script Date: 6/17/2021 11:02:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[APP_RESOURCES](
	[APP_I] [decimal](17, 0) NULL,
	[RESOURCE_I] [decimal](17, 0) NULL,
	[RESOURCE_N] [char](80) NULL,
	[RESOURCE_DESC_T] [varchar](256) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[APP_ROLE_RES_REL]    Script Date: 6/17/2021 11:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[APP_ROLE_RES_REL](
	[APP_I] [decimal](17, 0) NULL,
	[RESOURCE_I] [decimal](17, 0) NULL,
	[ROLE_I] [decimal](17, 0) NULL,
	[ACCESS_LEVEL] [smallint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[APP_USER_ROLE_REL]    Script Date: 6/17/2021 11:02:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[APP_USER_ROLE_REL](
	[APP_I] [decimal](17, 0) NULL,
	[ROLE_I] [decimal](17, 0) NULL,
	[USER_I] [char](32) NULL,
	[MOD_TS] [varchar](40) NULL,
	[SESS_USER] [char](32) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[EXPlans_History]    Script Date: 6/17/2021 11:02:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[EXPlans_History](
	[PlanNumber] [varchar](20) NOT NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[LoadDatetime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[explansrpt]    Script Date: 6/17/2021 11:02:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[explansrpt](
	[PlanNumber] [varchar](20) NOT NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ClusteredIndex-PlanNumber]    Script Date: 6/17/2021 11:02:08 AM ******/
CREATE CLUSTERED INDEX [ClusteredIndex-PlanNumber] ON [ref].[explansrpt]
(
	[PlanNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Table [ref].[PSOL_DIV_ACCESS]    Script Date: 6/17/2021 11:02:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[PSOL_DIV_ACCESS](
	[USER_I] [char](12) NULL,
	[ACCOUNT_NO] [char](20) NULL,
	[ENRL_PROV_GRP_I] [decimal](17, 0) NULL,
	[DIV_NO] [char](15) NULL,
	[CREATION_TS] [varchar](1000) NULL,
	[STAT_C] [smallint] NULL,
	[MOD_TS] [varchar](1000) NULL,
	[SESS_USER] [char](32) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_PSOL_DIV_ACCESS_AccountNo_Div_User]    Script Date: 6/17/2021 11:02:10 AM ******/
CREATE CLUSTERED INDEX [IX_PSOL_DIV_ACCESS_AccountNo_Div_User] ON [ref].[PSOL_DIV_ACCESS]
(
	[ACCOUNT_NO] ASC,
	[DIV_NO] ASC,
	[USER_I] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Table [ref].[PSOL_DIV_RESTRICT]    Script Date: 6/17/2021 11:02:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[PSOL_DIV_RESTRICT](
	[ACCOUNT_NO] [char](20) NULL,
	[ENRL_PROV_GRP_I] [decimal](17, 0) NULL,
	[CREATION_TS] [varchar](1000) NULL,
	[STAT_C] [smallint] NULL,
	[MOD_TS] [varchar](1000) NULL,
	[SESS_USER] [char](32) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[PSOL_SHADOW_USER]    Script Date: 6/17/2021 11:02:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[PSOL_SHADOW_USER](
	[USER_I] [char](12) NULL,
	[ACCOUNT_NO] [char](20) NULL,
	[SHADOW_USER_I] [char](32) NULL,
	[ENRL_PROV_GRP_I] [decimal](17, 0) NULL,
	[CREATION_TS] [varchar](40) NULL,
	[STATUS_C] [smallint] NULL,
	[MOD_TS] [varchar](40) NULL,
	[SESS_USER] [char](32) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[SalesForceEmployee]    Script Date: 6/17/2021 11:02:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[SalesForceEmployee](
	[FirstName] [nvarchar](40) NULL,
	[LastName] [nvarchar](80) NULL,
	[Email] [nvarchar](128) NULL,
	[FederationIdentifier] [nvarchar](512) NULL,
	[MobilePhone] [nvarchar](40) NULL,
	[Phone] [nvarchar](40) NULL,
	[LoadDatetime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[SupportGroupEmail]    Script Date: 6/17/2021 11:02:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[SupportGroupEmail](
	[PlanNumber] [varchar](20) NOT NULL,
	[EmailAddress] [varchar](255) NOT NULL,
	[LoadDatetime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[tab_DDOL]    Script Date: 6/17/2021 11:02:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_DDOL](
	[ACCOUNT_NO] [char](20) NOT NULL,
	[SERVICE] [char](80) NOT NULL,
	[ServiceEnabled] [int] NOT NULL,
	[ACCESS_CODE_PROV_I] [decimal](17, 0) NOT NULL,
	[BUS_LINE_C] [int] NULL,
	[IncludeFlag] [tinyint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[tab_PlanFlags]    Script Date: 6/17/2021 11:02:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[tab_PlanFlags](
	[ACCOUNT_NO] [char](20) NOT NULL,
	[SERVICE] [char](80) NOT NULL,
	[ENABLED] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [ref].[WorkdayEmployee]    Script Date: 6/17/2021 11:02:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[WorkdayEmployee](
	[EmployeeID] [nvarchar](25) NOT NULL,
	[EmployeeFirstName] [varchar](50) NULL,
	[EmployeeMiddleName] [varchar](50) NULL,
	[EmployeeLastName] [varchar](50) NULL,
	[EmployeeFullName] [varchar](100) NULL,
	[EmployeeEmailAddress] [varchar](100) NULL,
	[LoadDatetime] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[BalanceByFundCaseLevel]    Script Date: 6/17/2021 11:02:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[BalanceByFundCaseLevel](
	[dimPlanId] [int] NULL,
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](80) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[FD_PROV_I] [bigint] NULL,
	[FundSortOrder] [int] NULL,
	[FundStyle] [varchar](30) NULL,
	[AssetCategory] [varchar](30) NULL,
	[AssetClass] [varchar](30) NULL,
	[FundFamily] [varchar](35) NULL,
	[FundName] [varchar](100) NULL,
	[TickerSymbol] [varchar](100) NULL,
	[Participants] [int] NULL,
	[Balance] [decimal](38, 2) NULL,
	[UnitCount] [decimal](38, 6) NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[BalanceByFundDivisionLevel]    Script Date: 6/17/2021 11:02:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[BalanceByFundDivisionLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NOT NULL,
	[ContractNumber] [varchar](10) NOT NULL,
	[AffiliateNumber] [varchar](10) NOT NULL,
	[CompanyName] [varchar](80) NOT NULL,
	[PlanName] [varchar](161) NOT NULL,
	[PlanType] [varchar](80) NOT NULL,
	[PlanCategory] [varchar](20) NOT NULL,
	[DIV_I] [varchar](50) NULL,
	[DivisionCode] [varchar](15) NULL,
	[DivisionName] [varchar](161) NULL,
	[FD_PROV_I] [bigint] NULL,
	[FundSortOrder] [int] NOT NULL,
	[FundStyle] [varchar](30) NOT NULL,
	[AssetCategory] [varchar](30) NOT NULL,
	[AssetClass] [varchar](30) NOT NULL,
	[FundFamily] [varchar](35) NOT NULL,
	[FundName] [varchar](100) NOT NULL,
	[Participants] [int] NULL,
	[Balance] [decimal](38, 2) NULL,
	[UnitCount] [decimal](38, 6) NULL,
	[ReportDate] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[BalanceByFundParticipantLevel]    Script Date: 6/17/2021 11:02:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[BalanceByFundParticipantLevel](
	[CaseNumber] [varchar](20) NULL,
	[dimDateId] [int] NULL,
	[dimParticipantId] [int] NULL,
	[dimPlanId] [int] NULL,
	[dimFundId] [int] NULL,
	[FD_PROV_I] [bigint] NULL,
	[dimAgeId] [int] NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[Balance] [decimal](15, 2) NULL,
	[UnitCount] [decimal](15, 6) NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_BalanceByFundParticipantLevel_CaseNumber]    Script Date: 6/17/2021 11:02:31 AM ******/
CREATE CLUSTERED INDEX [IX_BalanceByFundParticipantLevel_CaseNumber] ON [temp].[BalanceByFundParticipantLevel]
(
	[CaseNumber] ASC,
	[dimParticipantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Table [temp].[BalanceByFundUserLevel]    Script Date: 6/17/2021 11:02:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[BalanceByFundUserLevel](
	[dimPlanId] [int] NULL,
	[PlanNumber] [varchar](20) NULL,
	[UserId] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](80) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[FD_PROV_I] [bigint] NULL,
	[FundSortOrder] [int] NULL,
	[FundStyle] [varchar](30) NULL,
	[AssetCategory] [varchar](30) NULL,
	[AssetClass] [varchar](30) NULL,
	[FundFamily] [varchar](35) NULL,
	[FundName] [varchar](100) NULL,
	[TickerSymbol] [varchar](100) NULL,
	[Participants] [int] NULL,
	[Balance] [decimal](38, 2) NULL,
	[UnitCount] [decimal](38, 6) NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[CaseFundFlags]    Script Date: 6/17/2021 11:02:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[CaseFundFlags](
	[PlanNumber] [varchar](20) NULL,
	[PCRA_Allowed_Flag] [bit] NULL,
	[SDB_Allowed_Flag] [bit] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[CaseLevelMetrics]    Script Date: 6/17/2021 11:02:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[CaseLevelMetrics](
	[PlanNumber] [varchar](20) NOT NULL,
	[ContractNumber] [varchar](10) NOT NULL,
	[AffiliateNumber] [varchar](10) NOT NULL,
	[CompanyName] [varchar](80) NULL,
	[PlanName] [varchar](255) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](80) NULL,
	[Participants] [int] NULL,
	[ParticipantsActive] [int] NULL,
	[ParticipantsTerminated] [int] NULL,
	[TotalBalance] [decimal](15, 2) NULL,
	[AvgParticipantBalance] [decimal](15, 2) NULL,
	[EligibleEmployees] [int] NULL,
	[ContributingEmployees] [int] NULL,
	[NonContributingEmployees] [int] NULL,
	[ParticipationRate] [decimal](15, 2) NULL,
	[AvgContributionRate] [decimal](15, 2) NULL,
	[AvgContributionAmount] [decimal](15, 2) NULL,
	[EmployeesNotReceivingMatch] [int] NULL,
	[TotalOutlooks] [int] NULL,
	[OnTrackOutlooks] [int] NULL,
	[UnknownOutlooks] [int] NULL,
	[OnTrackOutlookPercentage] [decimal](15, 2) NULL,
	[ReportDate] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[ContributionPartDivisionLevel]    Script Date: 6/17/2021 11:02:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[ContributionPartDivisionLevel](
	[CaseNumber] [varchar](20) NULL,
	[dimDateId] [int] NULL,
	[dimParticipantId] [int] NULL,
	[dimPlanId] [int] NULL,
	[dimAgeId] [int] NULL,
	[dimEmploymentStatusId] [int] NULL,
	[dimEmployerAccountId] [int] NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[PreTaxEligible] [tinyint] NULL,
	[BalanceIndicator] [tinyint] NULL,
	[Balance] [decimal](15, 2) NULL,
	[ReportDate] [date] NULL,
	[PART_ENRL_I] [bigint] NULL,
	[DIV_I] [bigint] NULL,
	[MultiDivisionalParticipant] [varchar](10) NULL,
	[DivisionCode] [varchar](15) NULL,
	[DEF_P] [numeric](38, 3) NULL,
	[DEF_A] [numeric](38, 2) NULL,
	[AfterTax_A] [numeric](38, 2) NULL,
	[AfterTax_P] [numeric](38, 3) NULL,
	[PreTax_A] [numeric](38, 2) NULL,
	[PreTax_P] [numeric](38, 3) NULL,
	[Roth_A] [numeric](38, 2) NULL,
	[Roth_P] [numeric](38, 3) NULL,
	[ContributingFlag] [tinyint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ContributionPartDivisionLevel_CaseNumber]    Script Date: 6/17/2021 11:02:46 AM ******/
CREATE CLUSTERED INDEX [IX_ContributionPartDivisionLevel_CaseNumber] ON [temp].[ContributionPartDivisionLevel]
(
	[CaseNumber] ASC,
	[dimParticipantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Table [temp].[dbenv]    Script Date: 6/17/2021 11:02:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[dbenv](
	[serverenvironment] [varchar](100) NULL,
	[servername] [sql_variant] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[EligibleEmployees]    Script Date: 6/17/2021 11:02:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[EligibleEmployees](
	[PlanNumber] [varchar](20) NULL,
	[dimParticipantId] [int] NULL,
	[dimUniqueSocialId] [int] NULL,
	[dimParticipantDivisionId] [int] NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[PART_ENRL_I] [decimal](17, 0) NULL,
	[DEF_GRP_NM] [varchar](80) NULL,
	[DEF_A] [decimal](13, 2) NULL,
	[DEF_P] [decimal](6, 3) NULL,
	[ReportDate] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[EXPlansEnv]    Script Date: 6/17/2021 11:02:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[EXPlansEnv](
	[PlanNumber] [varchar](20) NOT NULL,
	[PlanNumberEnv] [varchar](20) NOT NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[LoadDatetime] [datetime] NOT NULL,
	[ContractNumberEnv] [varchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[FundPerformanceCaseLevel]    Script Date: 6/17/2021 11:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[FundPerformanceCaseLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[EnterpriseBusinessLine] [varchar](10) NULL,
	[AssetCategory] [varchar](30) NULL,
	[AssetClass] [varchar](30) NULL,
	[FundStyle] [varchar](30) NULL,
	[FundFamily] [varchar](35) NULL,
	[FundDescriptionCode] [varchar](4) NULL,
	[FundName] [varchar](80) NULL,
	[FundGroupCode] [varchar](4) NULL,
	[FundInceptionDate] [varchar](10) NULL,
	[FundBusinessLine] [varchar](10) NULL,
	[OneMonthPerformance] [float] NULL,
	[ThreeMonthPerformance] [float] NULL,
	[YTDPerformance] [float] NULL,
	[OneYearPerformance] [float] NULL,
	[ThreeYearPerformance] [float] NULL,
	[FiveYearPerformance] [float] NULL,
	[TenYearPerformance] [float] NULL,
	[FifteenYearPerformance] [float] NULL,
	[TwentyYearPerformance] [float] NULL,
	[PerformanceSinceInception] [float] NULL,
	[NetExpenseRatio] [float] NULL,
	[GrossExpenseRatio] [float] NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[LoansPartDivisionLevel]    Script Date: 6/17/2021 11:02:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[LoansPartDivisionLevel](
	[dimParticipantId] [bigint] NULL,
	[ActiveParticipant] [int] NULL,
	[TerminatedParticipant] [int] NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[CaseNumber] [varchar](30) NULL,
	[DIV_I] [bigint] NULL,
	[DivisionCode] [varchar](20) NULL,
	[ClosingLoanBalance] [decimal](15, 2) NULL,
	[LoanIssueDate] [date] NULL,
	[ReportDate] [date] NULL,
	[LoanType] [varchar](300) NULL,
	[LoanStatus] [varchar](100) NULL,
	[LoanStatusDetail] [varchar](300) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[MetricsCaseLevel]    Script Date: 6/17/2021 11:02:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[MetricsCaseLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](161) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[TotalParticipantCount] [int] NULL,
	[ActiveParticipantCount] [int] NULL,
	[TerminatedParticipantCount] [int] NULL,
	[TotalParticipantCountWithBalance] [int] NULL,
	[ActiveParticipantCountWithBalance] [int] NULL,
	[TerminatedParticipantCountWithBalance] [int] NULL,
	[ParticipationRate] [decimal](15, 2) NULL,
	[AvgContributionRate] [decimal](15, 2) NULL,
	[EligibleEmployeeCount] [int] NULL,
	[ContributingEmployeeCount] [int] NULL,
	[NonContributingEmployeeCount] [int] NULL,
	[AvgContributionAmount] [decimal](38, 2) NULL,
	[ActiveParticipantFundBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgActiveParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantFundBalance] [decimal](38, 2) NULL,
	[ActiveParticipantCoreFunds] [decimal](38, 2) NULL,
	[TerminatedParticipantCoreFunds] [decimal](38, 2) NULL,
	[AvgParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgActiveParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantCoreFund] [decimal](38, 2) NULL,
	[PCRA_Allowed_Flag] [bit] NULL,
	[ActiveParticipantPCRA] [decimal](38, 2) NULL,
	[TerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[AvgParticipantPCRA] [decimal](38, 2) NULL,
	[AvgActiveParticipantPCRA] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[SDB_Allowed_Flag] [bit] NULL,
	[ActiveParticipantSDB] [decimal](38, 2) NULL,
	[TerminatedParticipantSDB] [decimal](38, 2) NULL,
	[AvgParticipantSDB] [decimal](38, 2) NULL,
	[AvgActiveParticipantSDB] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantSDB] [decimal](38, 2) NULL,
	[SuspenseBalance] [decimal](38, 2) NULL,
	[ForefeitureBalance] [decimal](38, 2) NULL,
	[ExpenseAccountBalance] [decimal](38, 2) NULL,
	[AdvancedEmployerBalance] [decimal](38, 2) NULL,
	[ActiveParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialLoanBalance] [int] NULL,
	[ActiveParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[ActiveParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalLoanBalance] [int] NULL,
	[ActiveParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[ActiveParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithOtherLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithOtherLoanBalance] [int] NULL,
	[LoanPermittedFlag] [bit] NULL,
	[ParticipantsPastDue] [int] NULL,
	[AutoRebalanceFlag] [int] NULL,
	[AutoIncreaseFlag] [int] NULL,
	[CustomPortfoliosFlag] [int] NULL,
	[DCMAFlag] [int] NULL,
	[FundTransferFlag] [int] NULL,
	[PCRAFlag] [int] NULL,
	[PortfolioXpressFlag] [int] NULL,
	[SDAFlag] [int] NULL,
	[SecurePathForLifeFlag] [int] NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[MetricsDivisionLevel]    Script Date: 6/17/2021 11:03:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[MetricsDivisionLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[DivisionCode] [varchar](20) NULL,
	[DIV_I] [bigint] NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](161) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[TotalParticipantCount] [int] NULL,
	[ActiveParticipantCount] [int] NULL,
	[TerminatedParticipantCount] [int] NULL,
	[ParticipationRate] [decimal](15, 2) NULL,
	[AvgContributionRate] [decimal](15, 2) NULL,
	[EligibleEmployeeCount] [int] NULL,
	[ContributingEmployeeCount] [int] NULL,
	[NonContributingEmployeeCount] [int] NULL,
	[AvgContributionAmount] [decimal](38, 2) NULL,
	[ActiveParticipantCoreFunds] [decimal](38, 2) NULL,
	[TerminatedParticipantCoreFunds] [decimal](38, 2) NULL,
	[AvgParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgActiveParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantCoreFund] [decimal](38, 2) NULL,
	[PCRA_Allowed_Flag] [bit] NULL,
	[ActiveParticipantPCRA] [decimal](38, 2) NULL,
	[TerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[AvgParticipantPCRA] [decimal](38, 2) NULL,
	[AvgActiveParticipantPCRA] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[SDB_Allowed_Flag] [bit] NULL,
	[ActiveParticipantSDB] [decimal](38, 2) NULL,
	[TerminatedParticipantSDB] [decimal](38, 2) NULL,
	[AvgParticipantSDB] [decimal](38, 2) NULL,
	[AvgActiveParticipantSDB] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantSDB] [decimal](38, 2) NULL,
	[SuspenseBalance] [decimal](38, 2) NULL,
	[ForefeitureBalance] [decimal](38, 2) NULL,
	[ExpenseAccountBalance] [decimal](38, 2) NULL,
	[AdvancedEmployerBalance] [decimal](38, 2) NULL,
	[ActiveParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialLoanBalance] [int] NULL,
	[ActiveParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[ActiveParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalLoanBalance] [int] NULL,
	[ActiveParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[ActiveParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithOtherLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithOtherLoanBalance] [int] NULL,
	[LoanPermittedFlag] [bit] NULL,
	[ParticipantsPastDue] [int] NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[MetricsParticipantLevel]    Script Date: 6/17/2021 11:03:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[MetricsParticipantLevel](
	[CaseNumber] [varchar](20) NULL,
	[dimDateId] [int] NULL,
	[dimParticipantId] [int] NULL,
	[dimPlanId] [int] NULL,
	[dimAgeId] [int] NULL,
	[dimEmploymentStatusId] [int] NULL,
	[dimEmployerAccountId] [int] NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[PreTaxEligible] [tinyint] NULL,
	[BalanceIndicator] [tinyint] NULL,
	[Balance] [decimal](15, 2) NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_MetricsParticipantLevel_CaseNumber]    Script Date: 6/17/2021 11:03:31 AM ******/
CREATE CLUSTERED INDEX [IX_MetricsParticipantLevel_CaseNumber] ON [temp].[MetricsParticipantLevel]
(
	[CaseNumber] ASC,
	[dimParticipantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
/****** Object:  Table [temp].[MetricsUserLevel]    Script Date: 6/17/2021 11:03:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[MetricsUserLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[UserId] [varchar](20) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](161) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[TotalParticipantCount] [int] NULL,
	[ActiveParticipantCount] [int] NULL,
	[TerminatedParticipantCount] [int] NULL,
	[TotalParticipantCountWithBalance] [int] NULL,
	[ActiveParticipantCountWithBalance] [int] NULL,
	[TerminatedParticipantCountWithBalance] [int] NULL,
	[ParticipationRate] [decimal](15, 2) NULL,
	[AvgContributionRate] [decimal](15, 2) NULL,
	[EligibleEmployeeCount] [int] NULL,
	[ContributingEmployeeCount] [int] NULL,
	[NonContributingEmployeeCount] [int] NULL,
	[AvgContributionAmount] [decimal](38, 2) NULL,
	[ActiveParticipantFundBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgActiveParticipantFundBalance] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantFundBalance] [decimal](38, 2) NULL,
	[ActiveParticipantCoreFunds] [decimal](38, 2) NULL,
	[TerminatedParticipantCoreFunds] [decimal](38, 2) NULL,
	[AvgParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgActiveParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantCoreFund] [decimal](38, 2) NULL,
	[PCRA_Allowed_Flag] [bit] NULL,
	[ActiveParticipantPCRA] [decimal](38, 2) NULL,
	[TerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[AvgParticipantPCRA] [decimal](38, 2) NULL,
	[AvgActiveParticipantPCRA] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[SDB_Allowed_Flag] [bit] NULL,
	[ActiveParticipantSDB] [decimal](38, 2) NULL,
	[TerminatedParticipantSDB] [decimal](38, 2) NULL,
	[AvgParticipantSDB] [decimal](38, 2) NULL,
	[AvgActiveParticipantSDB] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantSDB] [decimal](38, 2) NULL,
	[SuspenseBalance] [decimal](38, 2) NULL,
	[ForefeitureBalance] [decimal](38, 2) NULL,
	[ExpenseAccountBalance] [decimal](38, 2) NULL,
	[AdvancedEmployerBalance] [decimal](38, 2) NULL,
	[ActiveParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialLoanBalance] [int] NULL,
	[ActiveParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[ActiveParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalLoanBalance] [int] NULL,
	[ActiveParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[ActiveParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithOtherLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithOtherLoanBalance] [int] NULL,
	[LoanPermittedFlag] [bit] NULL,
	[ParticipantsPastDue] [int] NULL,
	[AutoRebalanceFlag] [int] NULL,
	[AutoIncreaseFlag] [int] NULL,
	[CustomPortfoliosFlag] [int] NULL,
	[DCMAFlag] [int] NULL,
	[FundTransferFlag] [int] NULL,
	[PCRAFlag] [int] NULL,
	[PortfolioXpressFlag] [int] NULL,
	[SDAFlag] [int] NULL,
	[SecurePathForLifeFlag] [int] NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[new_ex_plans]    Script Date: 6/17/2021 11:03:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[new_ex_plans](
	[ACCOUNT_EXECUTIVE_NAME] [nvarchar](255) NULL,
	[A_CASE] [nvarchar](255) NULL,
	[ACCOUNT_CONSULTANT_NAME] [nvarchar](255) NULL,
	[B_CASE] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[new_ex_plans_history]    Script Date: 6/17/2021 11:03:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[new_ex_plans_history](
	[ACCOUNT_EXECUTIVE_NAME] [nvarchar](255) NULL,
	[A_CASE] [nvarchar](255) NULL,
	[ACCOUNT_CONSULTANT_NAME] [nvarchar](255) NULL,
	[B_CASE] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[OutlooksUserLevel]    Script Date: 6/17/2021 11:03:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[OutlooksUserLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[RestrictedCaseFlag] [bit] NULL,
	[UserId] [char](12) NULL,
	[OntrackOutlookCount] [int] NULL,
	[UnknownOutlookCount] [int] NULL,
	[NotOntrackOutlookCount] [int] NULL,
	[TotalOutlookCount] [int] NULL,
	[OntrackPercentage] [decimal](15, 2) NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[ParticipantDetails]    Script Date: 6/17/2021 11:03:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[ParticipantDetails](
	[dimParticipantId] [bigint] NULL,
	[dimPlanid] [bigint] NULL,
	[CaseNumber] [varchar](20) NULL,
	[PlanName] [varchar](1000) NULL,
	[EmployerName] [varchar](1000) NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[EmployeeNumber] [varchar](100) NULL,
	[UserList] [varchar](max) NULL,
	[DivisionList] [varchar](max) NULL,
	[MultiDivisionFlag] [bit] NULL,
	[FirstName] [varchar](20) NULL,
	[MiddleInitial] [char](1) NULL,
	[LastName] [varchar](30) NULL,
	[Suffix] [varchar](10) NULL,
	[Gender] [varchar](15) NULL,
	[AddressLine1] [varchar](1000) NULL,
	[AddressLine2] [varchar](1000) NULL,
	[DeliverableStatus] [varchar](100) NULL,
	[AddressStatus] [varchar](100) NULL,
	[City] [varchar](1000) NULL,
	[StateAbbreviation] [varchar](5) NULL,
	[StateName] [varchar](1000) NULL,
	[ZipCode] [varchar](1000) NULL,
	[DayPhoneNumber] [varchar](1000) NULL,
	[DayPhoneExt] [varchar](10) NULL,
	[MobilePhoneNumber] [varchar](1000) NULL,
	[EveningPhoneNumber] [varchar](1000) NULL,
	[EveningPhoneExt] [varchar](10) NULL,
	[EmailAddress] [varchar](1000) NULL,
	[BirthDate] [date] NULL,
	[DeathDate] [date] NULL,
	[HireDate] [date] NULL,
	[TerminationDate] [date] NULL,
	[ReHireDate] [date] NULL,
	[LastStatementDate] [date] NULL,
	[PartSiteAccess] [varchar](20) NULL,
	[IVRAccess] [varchar](20) NULL,
	[SubLocation] [varchar](100) NULL,
	[PayRollCycle] [varchar](100) NULL,
	[HoursWorked] [bigint] NULL,
	[MaritalStatus] [varchar](20) NULL,
	[UserBalances] [varchar](max) NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [temp].[ParticipantUser]    Script Date: 6/17/2021 11:04:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[ParticipantUser](
	[CaseNumber] [varchar](20) NULL,
	[PlanNumberEnv] [varchar](20) NULL,
	[dimParticipantId] [bigint] NULL,
	[EmploymentStatus] [varchar](30) NULL,
	[SocialSecurityNumber] [varchar](12) NULL,
	[EmployeeDivisionCode] [varchar](100) NULL,
	[MultiDivisionIndicator] [varchar](10) NULL,
	[DivisionEmploymentStatus] [varchar](30) NULL,
	[UserId] [varchar](30) NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ParticipantUser_CaseNumber]    Script Date: 6/17/2021 11:04:02 AM ******/
CREATE CLUSTERED INDEX [IX_ParticipantUser_CaseNumber] ON [temp].[ParticipantUser]
(
	[CaseNumber] ASC,
	[dimParticipantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [temp].[PartSearchAccess]    Script Date: 6/17/2021 11:04:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[PartSearchAccess](
	[PlanNumber] [varchar](20) NULL,
	[UserId] [varchar](20) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [temp].[PIIEnv]    Script Date: 6/17/2021 11:04:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[PIIEnv](
	[CaseNumber] [varchar](20) NOT NULL,
	[SocialSecurityNumber] [varchar](12) NOT NULL,
	[SSNEnv] [varchar](11) NULL,
	[FirstName] [varchar](20) NOT NULL,
	[FirstNameEnv] [varchar](20) NOT NULL,
	[LastName] [varchar](30) NOT NULL,
	[LastNameENV] [varchar](30) NOT NULL,
	[LoadDatetime] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_#PIIEnv_CaseNumber]    Script Date: 6/17/2021 11:04:04 AM ******/
CREATE CLUSTERED INDEX [IX_#PIIEnv_CaseNumber] ON [temp].[PIIEnv]
(
	[CaseNumber] ASC,
	[SocialSecurityNumber] ASC,
	[SSNEnv] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [temp].[SupportTeam]    Script Date: 6/17/2021 11:04:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [temp].[SupportTeam](
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](80) NULL,
	[PlanName] [varchar](255) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](80) NULL,
	[FirstName] [varchar](51) NULL,
	[LastName] [varchar](51) NULL,
	[FullName] [varchar](102) NULL,
	[SupportRole] [varchar](51) NULL,
	[PhoneNumber] [varchar](12) NULL,
	[EmailAddress] [varchar](255) NULL,
	[ReportDate] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [wxstg].[MetricsCaseLevel]    Script Date: 6/17/2021 11:04:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wxstg].[MetricsCaseLevel](
	[dimPlanId] [bigint] NULL,
	[PlanNumber] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[CompanyName] [varchar](161) NULL,
	[PlanName] [varchar](161) NULL,
	[PlanType] [varchar](80) NULL,
	[PlanCategory] [varchar](20) NULL,
	[TotalParticipantCount] [int] NULL,
	[ActiveParticipantCount] [int] NULL,
	[TerminatedParticipantCount] [int] NULL,
	[ParticipationRate] [decimal](15, 2) NULL,
	[AvgContributionRate] [decimal](15, 2) NULL,
	[EligibleEmployeeCount] [int] NULL,
	[ContributingEmployeeCount] [int] NULL,
	[NonContributingEmployeeCount] [int] NULL,
	[AvgContributionAmount] [decimal](38, 2) NULL,
	[ActiveParticipantCoreFunds] [decimal](38, 2) NULL,
	[TerminatedParticipantCoreFunds] [decimal](38, 2) NULL,
	[AvgParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgActiveParticipantCoreFund] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantCoreFund] [decimal](38, 2) NULL,
	[PCRA_Allowed_Flag] [bit] NULL,
	[ActiveParticipantPCRA] [decimal](38, 2) NULL,
	[TerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[AvgParticipantPCRA] [decimal](38, 2) NULL,
	[AvgActiveParticipantPCRA] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantPCRA] [decimal](38, 2) NULL,
	[SDB_Allowed_Flag] [bit] NULL,
	[ActiveParticipantSDB] [decimal](38, 2) NULL,
	[TerminatedParticipantSDB] [decimal](38, 2) NULL,
	[AvgParticipantSDB] [decimal](38, 2) NULL,
	[AvgActiveParticipantSDB] [decimal](38, 2) NULL,
	[AvgTerminatedParticipantSDB] [decimal](38, 2) NULL,
	[SuspenseBalance] [decimal](38, 2) NULL,
	[ForefeitureBalance] [decimal](38, 2) NULL,
	[ExpenseAccountBalance] [decimal](38, 2) NULL,
	[AdvancedEmployerBalance] [decimal](38, 2) NULL,
	[ActiveParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialLoanBalance] [int] NULL,
	[ActiveParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[ActiveParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalLoanBalance] [int] NULL,
	[ActiveParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[ActiveParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[ActiveParticipantsWithOtherLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialLoanBalance] [int] NULL,
	[TerminatedParticipantResidentialHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithResidentialHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalLoanBalance] [int] NULL,
	[TerminatedParticipantPersonalHardshipLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithPersonalHardshipLoanBalance] [int] NULL,
	[TerminatedParticipantOtherLoanBalance] [decimal](38, 2) NULL,
	[TerminatedParticipantsWithOtherLoanBalance] [int] NULL,
	[LoanPermittedFlag] [bit] NULL,
	[ParticipantsPastDue] [int] NULL,
	[ReportDate] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [wxstg].[plans_list]    Script Date: 6/17/2021 11:04:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wxstg].[plans_list](
	[planid] [bigint] NOT NULL,
	[plannumber] [varchar](20) NULL,
	[loaddate] [timestamp] NULL,
 CONSTRAINT [plans_list_pkey] PRIMARY KEY CLUSTERED 
(
	[planid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [wxstg].[WXPlansRef]    Script Date: 6/17/2021 11:04:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wxstg].[WXPlansRef](
	[PlanNumber] [varchar](20) NULL,
	[PlanNumberEnv] [varchar](20) NULL,
	[ContractNumber] [varchar](10) NULL,
	[AffiliateNumber] [varchar](10) NULL,
	[LoadDatetime] [datetime] NULL,
	[ContractNumberEnv] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ParticipantDetails_CaseNumber]    Script Date: 6/17/2021 11:04:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_ParticipantDetails_CaseNumber] ON [ex].[ParticipantDetails]
(
	[CaseNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [tab_factDeferral_nc_monthend]    Script Date: 6/17/2021 11:04:23 AM ******/
CREATE NONCLUSTERED INDEX [tab_factDeferral_nc_monthend] ON [ref].[tab_factDeferral]
(
	[MonthEndFlag] ASC,
	[EffDateId] ASC
)
INCLUDE ( 	[id],
	[DIV_I],
	[DEF_GRP_I],
	[SocialSecurityNumber],
	[DEF_GRP_NM],
	[SRC_I],
	[DEF_P],
	[DEF_A],
	[DOC_NM],
	[CaseNumber],
	[ENRL_PROV_GRP_I],
	[PART_ENRL_I],
	[SRC_TYP_C],
	[EFF_D],
	[TheType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_BalanceByFundCaseLevel]    Script Date: 6/17/2021 11:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_BalanceByFundCaseLevel]
AS
SET NOCOUNT ON;

MERGE WorkplaceExperience.ex.BalanceByFundCaseLevel AS target
	USING WorkplaceExperience.temp.BalanceByFundCaseLevel AS source ON
(target.PlanNumber = source.PlanNumber AND year(target.ReportDate) = year(source.ReportDate) AND month(target.ReportDate) = month(source.ReportDate) AND source.FD_PROV_I=target.FD_PROV_I)
WHEN MATCHED THEN UPDATE SET
  dimPlanId = source.dimPlanId
, ContractNumber = source.ContractNumber
, AffiliateNumber = source.AffiliateNumber
, CompanyName = source.CompanyName
, PlanName = source.PlanName
, PlanType = source.PlanType
, PlanCategory = source.PlanCategory
, FD_PROV_I = source.FD_PROV_I
, FundSortOrder = source.FundSortOrder
, FundStyle = source.FundStyle
, AssetCategory = source.AssetCategory
, AssetClass = source.AssetClass
, FundFamily = source.FundFamily
, FundName = source.FundName
, TickerSymbol = source.TickerSymbol
, Participants = source.Participants
, Balance = source.Balance
, UnitCount = source.UnitCount
, ReportDate=source.ReportDate
, LoadDate = GETDATE()
WHEN NOT MATCHED THEN INSERT
(  dimPlanId
  ,PlanNumber
  ,ContractNumber
  ,AffiliateNumber
  ,CompanyName
  ,PlanName
  ,PlanType
  ,PlanCategory
  ,FD_PROV_I
  ,FundSortOrder
  ,FundStyle
  ,AssetCategory
  ,AssetClass
  ,FundFamily
  ,FundName
  ,TickerSymbol
  ,Participants
  ,Balance
  ,UnitCount
  ,ReportDate
  ,LoadDate)
VALUES
( source.dimPlanId
, source.PlanNumber
, source.ContractNumber
, source.AffiliateNumber
, source.CompanyName
, source.PlanName
, source.PlanType
, source.PlanCategory
, source.FD_PROV_I
, source.FundSortOrder
, source.FundStyle
, source.AssetCategory
, source.AssetClass
, source.FundFamily
, source.FundName
, source.TickerSymbol
, source.Participants
, source.Balance
, source.UnitCount
, source.ReportDate
, GETDATE());

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_BalanceByFundDivisionLevel]    Script Date: 6/17/2021 11:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_BalanceByFundDivisionLevel]
AS
SET NOCOUNT ON;

MERGE WorkplaceExperience.ex.BalanceByFundDivisionLevel AS target
	USING WorkplaceExperience.temp.BalanceByFundDivisionLevel AS source ON
(target.PlanNumber = source.PlanNumber AND year(target.ReportDate) = year(source.ReportDate) 
	AND month(target.ReportDate) = month(source.ReportDate) AND source.DIV_I=target.DIV_I AND source.FD_PROV_I=target.FD_PROV_I)
WHEN MATCHED THEN UPDATE SET
  dimPlanId = source.dimPlanId
, ContractNumber = source.ContractNumber
, AffiliateNumber = source.AffiliateNumber
, CompanyName = source.CompanyName
, PlanName = source.PlanName
, PlanType = source.PlanType
, PlanCategory = source.PlanCategory
, DivisionCode=source.DivisionCode
, DivisionName=source.DivisionName
, FD_PROV_I=source.FD_PROV_I
, FundSortOrder = source.FundSortOrder
, FundStyle = source.FundStyle
, AssetCategory = source.AssetCategory
, AssetClass = source.AssetClass
, FundFamily = source.FundFamily
, FundName = source.FundName
, Participants = source.Participants
, Balance = source.Balance
, UnitCount = source.UnitCount
, ReportDate=source.ReportDate
, LoadDate = GETDATE()
WHEN NOT MATCHED THEN INSERT
(  dimPlanId
  ,PlanNumber
  ,ContractNumber
  ,AffiliateNumber
  ,CompanyName
  ,PlanName
  ,PlanType
  ,PlanCategory
  ,DIV_I
  ,DivisionCode
  ,DivisionName
  ,FD_PROV_I
  ,FundSortOrder
  ,FundStyle
  ,AssetCategory
  ,AssetClass
  ,FundFamily
  ,FundName
  ,Participants
  ,Balance
  ,UnitCount
  ,ReportDate
  ,LoadDate)
VALUES
( source.dimPlanId
, source.PlanNumber
, source.ContractNumber
, source.AffiliateNumber
, source.CompanyName
, source.PlanName
, source.PlanType
, source.PlanCategory
, source.DIV_I
, source.DivisionCode
, source.DivisionName
, source.FD_PROV_I
, source.FundSortOrder
, source.FundStyle
, source.AssetCategory
, source.AssetClass
, source.FundFamily
, source.FundName
, source.Participants
, source.Balance
, source.UnitCount
, source.ReportDate
, GETDATE());

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_BalanceByFundUserLevel]    Script Date: 6/17/2021 11:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_BalanceByFundUserLevel]
AS
SET NOCOUNT ON;

MERGE ex.BalanceByFundUserLevel AS target
	USING temp.BalanceByFundUserLevel AS source ON
(target.PlanNumber = source.PlanNumber AND year(target.ReportDate) = year(source.ReportDate) 
	AND month(target.ReportDate) = month(source.ReportDate) AND source.UserId=target.UserId AND source.FD_PROV_I=target.FD_PROV_I)
WHEN MATCHED THEN UPDATE SET
  dimPlanId = source.dimPlanId
, ContractNumber = source.ContractNumber
, AffiliateNumber = source.AffiliateNumber
, CompanyName = source.CompanyName
, PlanName = source.PlanName
, PlanType = source.PlanType
, PlanCategory = source.PlanCategory
, FD_PROV_I=source.FD_PROV_I
, FundSortOrder = source.FundSortOrder
, FundStyle = source.FundStyle
, AssetCategory = source.AssetCategory
, AssetClass = source.AssetClass
, FundFamily = source.FundFamily
, FundName = source.FundName
, TickerSymbol = source.TickerSymbol
, Participants = source.Participants
, Balance = source.Balance
, UnitCount = source.UnitCount
, ReportDate=source.ReportDate
, LoadDate = GETDATE()
WHEN NOT MATCHED THEN INSERT
(  dimPlanId
  ,PlanNumber
  ,UserId
  ,ContractNumber
  ,AffiliateNumber
  ,CompanyName
  ,PlanName
  ,PlanType
  ,PlanCategory
  ,FD_PROV_I
  ,FundSortOrder
  ,FundStyle
  ,AssetCategory
  ,AssetClass
  ,FundFamily
  ,FundName
  ,TickerSymbol
  ,Participants
  ,Balance
  ,UnitCount
  ,ReportDate
  ,LoadDate)
VALUES
( source.dimPlanId
, source.PlanNumber
, source.UserId
, source.ContractNumber
, source.AffiliateNumber
, source.CompanyName
, source.PlanName
, source.PlanType
, source.PlanCategory
, source.FD_PROV_I
, source.FundSortOrder
, source.FundStyle
, source.AssetCategory
, source.AssetClass
, source.FundFamily
, source.FundName
, source.TickerSymbol
, source.Participants
, source.Balance
, source.UnitCount
, source.ReportDate
, GETDATE());

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_CaseLevelMetrics]    Script Date: 6/17/2021 11:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_CaseLevelMetrics]
AS
SET NOCOUNT ON;

DECLARE @CurrentReportDate DATE = (SELECT MAX(ReportDate) FROM [temp].[CaseLevelMetrics] WITH (NOLOCK));

DELETE FROM [ex].[CaseLevelMetrics] WHERE ReportDate = @CurrentReportDate;

INSERT INTO [ex].[CaseLevelMetrics]
SELECT PlanNumber
      ,ContractNumber
      ,AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
      ,Participants
      ,ParticipantsActive
      ,ParticipantsTerminated
      ,TotalBalance
      ,AvgParticipantBalance
      ,EligibleEmployees
      ,ContributingEmployees
      ,NonContributingEmployees
      ,ParticipationRate
      ,AvgContributionRate
      ,AvgContributionAmount
      ,EmployeesNotReceivingMatch
      ,TotalOutlooks
      ,OnTrackOutlooks
      ,UnknownOutlooks
      ,OnTrackOutlookPercentage
      ,ReportDate
	  ,GETDATE()
FROM [temp].[CaseLevelMetrics] WITH (NOLOCK);

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_EligibleEmployees]    Script Date: 6/17/2021 11:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_EligibleEmployees]
AS
SET NOCOUNT ON;

INSERT INTO [ex].[EligibleEmployees]
SELECT PlanNumber
      ,dimParticipantId
      ,dimUniqueSocialId
      ,dimParticipantDivisionId
      ,SocialSecurityNumber
      ,PART_ENRL_I
      ,DEF_GRP_NM
      ,DEF_A
      ,DEF_P
      ,ReportDate
	  ,GETDATE()
FROM [temp].[EligibleEmployees] WITH (NOLOCK);

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_FundPerformanceCaseLevel]    Script Date: 6/17/2021 11:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_FundPerformanceCaseLevel]
AS
SET NOCOUNT ON;

MERGE WorkplaceExperience.ex.FundPerformanceCaseLevel AS target
	USING WorkplaceExperience.temp.FundPerformanceCaseLevel AS source ON
(target.PlanNumber = source.PlanNumber AND year(target.ReportDate) = year(source.ReportDate) AND month(target.ReportDate) = month(source.ReportDate) AND source.FundDescriptionCode=target.FundDescriptionCode)
WHEN MATCHED THEN UPDATE SET
		 dimPlanId=source.dimPlanId
		,PlanNumber=source.PlanNumber
		,EnterpriseBusinessLine=source.EnterpriseBusinessLine
		,AssetCategory=source.AssetCategory
		,AssetClass=source.AssetClass
		,FundStyle=source.FundStyle
		,FundFamily=source.FundFamily
		,FundDescriptionCode=source.FundDescriptionCode
		,FundName=source.FundName
		,FundGroupCode=source.FundGroupCode
		,FundInceptionDate=source.FundInceptionDate
		,FundBusinessLine=source.FundBusinessLine
		,OneMonthPerformance=source.OneMonthPerformance
		,ThreeMonthPerformance=source.ThreeMonthPerformance
		,YTDPerformance=source.YTDPerformance
		,OneYearPerformance=source.OneYearPerformance
		,ThreeYearPerformance=source.ThreeYearPerformance
		,FiveYearPerformance=source.FiveYearPerformance
		,TenYearPerformance=source.TenYearPerformance
		,FifteenYearPerformance=source.FifteenYearPerformance
		,TwentyYearPerformance=source.TwentyYearPerformance
		,PerformanceSinceInception=source.PerformanceSinceInception
		,NetExpenseRatio=source.NetExpenseRatio
		,GrossExpenseRatio=source.GrossExpenseRatio
		,ReportDate=source.ReportDate
		,LoadDate = GETDATE()
WHEN NOT MATCHED THEN INSERT
(		 dimPlanId
		,PlanNumber
		,EnterpriseBusinessLine
		,AssetCategory
		,AssetClass
		,FundStyle
		,FundFamily
		,FundDescriptionCode
		,FundName
		,FundGroupCode
		,FundInceptionDate
		,FundBusinessLine
		,OneMonthPerformance
		,ThreeMonthPerformance
		,YTDPerformance
		,OneYearPerformance
		,ThreeYearPerformance
		,FiveYearPerformance
		,TenYearPerformance
		,FifteenYearPerformance
		,TwentyYearPerformance
		,PerformanceSinceInception
		,NetExpenseRatio
		,GrossExpenseRatio
		,ReportDate
  ,LoadDate)
VALUES
(		 source.dimPlanId
		,source.PlanNumber
        ,source.EnterpriseBusinessLine
        ,source.AssetCategory
        ,source.AssetClass
        ,source.FundStyle
        ,source.FundFamily
        ,source.FundDescriptionCode
        ,source.FundName
        ,source.FundGroupCode
        ,source.FundInceptionDate
        ,source.FundBusinessLine
        ,source.OneMonthPerformance
        ,source.ThreeMonthPerformance
        ,source.YTDPerformance
        ,source.OneYearPerformance
        ,source.ThreeYearPerformance
        ,source.FiveYearPerformance
        ,source.TenYearPerformance
        ,source.FifteenYearPerformance
        ,source.TwentyYearPerformance
        ,source.PerformanceSinceInception
        ,source.NetExpenseRatio
        ,source.GrossExpenseRatio
        ,source.ReportDate
		,GETDATE()
);

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_LoadStatus]    Script Date: 6/17/2021 11:04:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_LoadStatus] (
	@loadStage VARCHAR(100)
   ,@loadStatus VARCHAR(20)
   ,@loadError VARCHAR(1000)
)
AS
SET NOCOUNT ON;

DECLARE @loadDate DATETIME;

SET @loadDate=GETDATE();

INSERT INTO ex.LoadStatus
SELECT  @loadStage
	   ,@loadDate
	   ,@loadStatus
	   ,@loadError;

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_MetricsCaseLevel]    Script Date: 6/17/2021 11:04:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_MetricsCaseLevel]
AS
SET NOCOUNT ON;

MERGE WorkplaceExperience.ex.MetricsCaseLevel AS target
	USING temp.MetricsCaseLevel AS source ON
(target.PlanNumber = source.PlanNumber AND year(target.ReportDate) = year(source.ReportDate) AND month(target.ReportDate) = month(source.ReportDate))
WHEN MATCHED THEN UPDATE SET
		 target.dimPlanId=source.dimPlanId
		,target.ContractNumber=source.ContractNumber
		,target.AffiliateNumber=source.AffiliateNumber
		,target.CompanyName=source.CompanyName
		,target.PlanName=source.PlanName
		,target.PlanType=source.PlanType
		,target.PlanCategory=source.PlanCategory
		,target.TotalParticipantCount=source.TotalParticipantCount
		,target.ActiveParticipantCount=source.ActiveParticipantCount
		,target.TerminatedParticipantCount=source.TerminatedParticipantCount
		,target.TotalParticipantCountWithBalance=source.TotalParticipantCountWithBalance
		,target.ActiveParticipantCountWithBalance=source.ActiveParticipantCountWithBalance
		,target.TerminatedParticipantCountWithBalance=source.TerminatedParticipantCountWithBalance
		,target.ParticipationRate=source.ParticipationRate
		,target.AvgContributionRate=source.AvgContributionRate
		,target.EligibleEmployeeCount=source.EligibleEmployeeCount
		,target.ContributingEmployeeCount=source.ContributingEmployeeCount
		,target.NonContributingEmployeeCount=source.NonContributingEmployeeCount
		,target.AvgContributionAmount=source.AvgContributionAmount
		,target.ActiveParticipantFundBalance=source.ActiveParticipantFundBalance
		,target.TerminatedParticipantFundBalance=source.TerminatedParticipantFundBalance
		,target.AvgParticipantFundBalance=source.AvgParticipantFundBalance
		,target.AvgActiveParticipantFundBalance=source.AvgActiveParticipantFundBalance
		,target.AvgTerminatedParticipantFundBalance=source.AvgTerminatedParticipantFundBalance
		,target.ActiveParticipantCoreFunds=source.ActiveParticipantCoreFunds
		,target.TerminatedParticipantCoreFunds=source.TerminatedParticipantCoreFunds
		,target.AvgParticipantCoreFund=source.AvgParticipantCoreFund
		,target.AvgActiveParticipantCoreFund=source.AvgActiveParticipantCoreFund
		,target.AvgTerminatedParticipantCoreFund=source.AvgTerminatedParticipantCoreFund
		,target.PCRA_Allowed_Flag=source.PCRA_Allowed_Flag
		,target.ActiveParticipantPCRA=source.ActiveParticipantPCRA
		,target.TerminatedParticipantPCRA=source.TerminatedParticipantPCRA
		,target.AvgParticipantPCRA=source.AvgParticipantPCRA
		,target.AvgActiveParticipantPCRA=source.AvgActiveParticipantPCRA
		,target.AvgTerminatedParticipantPCRA=source.AvgTerminatedParticipantPCRA
		,target.SDB_Allowed_Flag=source.SDB_Allowed_Flag
		,target.ActiveParticipantSDB=source.ActiveParticipantSDB
		,target.TerminatedParticipantSDB=source.TerminatedParticipantSDB
		,target.AvgParticipantSDB=source.AvgParticipantSDB
		,target.AvgActiveParticipantSDB=source.AvgActiveParticipantSDB
		,target.AvgTerminatedParticipantSDB=source.AvgTerminatedParticipantSDB
		,target.SuspenseBalance=source.SuspenseBalance
		,target.ForefeitureBalance=source.ForefeitureBalance
		,target.ExpenseAccountBalance=source.ExpenseAccountBalance
		,target.AdvancedEmployerBalance=source.AdvancedEmployerBalance
		,target.ActiveParticipantResidentialLoanBalance=source.ActiveParticipantResidentialLoanBalance
		,target.ActiveParticipantsWithResidentialLoanBalance=source.ActiveParticipantsWithResidentialLoanBalance
		,target.ActiveParticipantResidentialHardshipLoanBalance=source.ActiveParticipantResidentialHardshipLoanBalance
		,target.ActiveParticipantsWithResidentialHardshipLoanBalance=source.ActiveParticipantsWithResidentialHardshipLoanBalance
		,target.ActiveParticipantPersonalLoanBalance=source.ActiveParticipantPersonalLoanBalance
		,target.ActiveParticipantsWithPersonalLoanBalance=source.ActiveParticipantsWithPersonalLoanBalance
		,target.ActiveParticipantPersonalHardshipLoanBalance=source.ActiveParticipantPersonalHardshipLoanBalance
		,target.ActiveParticipantsWithPersonalHardshipLoanBalance=source.ActiveParticipantsWithPersonalHardshipLoanBalance
		,target.ActiveParticipantOtherLoanBalance=source.ActiveParticipantOtherLoanBalance
		,target.ActiveParticipantsWithOtherLoanBalance=source.ActiveParticipantsWithOtherLoanBalance
		,target.TerminatedParticipantResidentialLoanBalance=source.TerminatedParticipantResidentialLoanBalance
		,target.TerminatedParticipantsWithResidentialLoanBalance=source.TerminatedParticipantsWithResidentialLoanBalance
		,target.TerminatedParticipantResidentialHardshipLoanBalance=source.TerminatedParticipantResidentialHardshipLoanBalance
		,target.TerminatedParticipantsWithResidentialHardshipLoanBalance=source.TerminatedParticipantsWithResidentialHardshipLoanBalance
		,target.TerminatedParticipantPersonalLoanBalance=source.TerminatedParticipantPersonalLoanBalance
		,target.TerminatedParticipantsWithPersonalLoanBalance=source.TerminatedParticipantsWithPersonalLoanBalance
		,target.TerminatedParticipantPersonalHardshipLoanBalance=source.TerminatedParticipantPersonalHardshipLoanBalance
		,target.TerminatedParticipantsWithPersonalHardshipLoanBalance=source.TerminatedParticipantsWithPersonalHardshipLoanBalance
		,target.TerminatedParticipantOtherLoanBalance=source.TerminatedParticipantOtherLoanBalance
		,target.TerminatedParticipantsWithOtherLoanBalance=source.TerminatedParticipantsWithOtherLoanBalance
		,target.LoanPermittedFlag=source.LoanPermittedFlag
		,target.ParticipantsPastDue=source.ParticipantsPastDue
		,target.AutoRebalanceFlag=source.AutoRebalanceFlag
		,target.AutoIncreaseFlag=source.AutoIncreaseFlag
		,target.CustomPortfoliosFlag=source.CustomPortfoliosFlag
		,target.DCMAFlag=source.DCMAFlag
		,target.FundTransferFlag=source.FundTransferFlag
		,target.PCRAFlag=source.PCRAFlag
		,target.PortfolioXpressFlag = source.PortfolioXpressFlag
		,target.SDAFlag=source.SDAFlag
		,target.SecurePathForLifeFlag=source.SecurePathForLifeFlag
		,target.ReportDate=source.ReportDate
		,target.LoadDate = GETDATE()
WHEN NOT MATCHED THEN INSERT
( 
	   dimPlanId
      ,PlanNumber
      ,ContractNumber
      ,AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
      ,TotalParticipantCount
      ,ActiveParticipantCount
      ,TerminatedParticipantCount
	  ,TotalParticipantCountWithBalance
	  ,ActiveParticipantCountWithBalance
	  ,TerminatedParticipantCountWithBalance
      ,ParticipationRate
      ,AvgContributionRate
      ,EligibleEmployeeCount
      ,ContributingEmployeeCount
      ,NonContributingEmployeeCount
	  ,AvgContributionAmount
	  ,ActiveParticipantFundBalance 
	  ,TerminatedParticipantFundBalance 
	  ,AvgParticipantFundBalance 
	  ,AvgActiveParticipantFundBalance 
	  ,AvgTerminatedParticipantFundBalance 
      ,ActiveParticipantCoreFunds
      ,TerminatedParticipantCoreFunds
      ,AvgParticipantCoreFund
      ,AvgActiveParticipantCoreFund
      ,AvgTerminatedParticipantCoreFund
      ,PCRA_Allowed_Flag
      ,ActiveParticipantPCRA
      ,TerminatedParticipantPCRA
      ,AvgParticipantPCRA
      ,AvgActiveParticipantPCRA
      ,AvgTerminatedParticipantPCRA
      ,SDB_Allowed_Flag
      ,ActiveParticipantSDB
      ,TerminatedParticipantSDB
      ,AvgParticipantSDB
      ,AvgActiveParticipantSDB
      ,AvgTerminatedParticipantSDB
      ,SuspenseBalance
      ,ForefeitureBalance
      ,ExpenseAccountBalance
      ,AdvancedEmployerBalance
      ,ActiveParticipantResidentialLoanBalance
      ,ActiveParticipantsWithResidentialLoanBalance
      ,ActiveParticipantResidentialHardshipLoanBalance
      ,ActiveParticipantsWithResidentialHardshipLoanBalance
      ,ActiveParticipantPersonalLoanBalance
      ,ActiveParticipantsWithPersonalLoanBalance
      ,ActiveParticipantPersonalHardshipLoanBalance
      ,ActiveParticipantsWithPersonalHardshipLoanBalance
      ,ActiveParticipantOtherLoanBalance
      ,ActiveParticipantsWithOtherLoanBalance
      ,TerminatedParticipantResidentialLoanBalance
      ,TerminatedParticipantsWithResidentialLoanBalance
      ,TerminatedParticipantResidentialHardshipLoanBalance
      ,TerminatedParticipantsWithResidentialHardshipLoanBalance
      ,TerminatedParticipantPersonalLoanBalance
      ,TerminatedParticipantsWithPersonalLoanBalance
      ,TerminatedParticipantPersonalHardshipLoanBalance
      ,TerminatedParticipantsWithPersonalHardshipLoanBalance
      ,TerminatedParticipantOtherLoanBalance
      ,TerminatedParticipantsWithOtherLoanBalance
      ,LoanPermittedFlag
      ,ParticipantsPastDue
	  ,AutoRebalanceFlag
	  ,AutoIncreaseFlag
	  ,CustomPortfoliosFlag
	  ,DCMAFlag
	  ,FundTransferFlag
	  ,PCRAFlag
	  ,PortfolioXpressFlag
	  ,SDAFlag
	  ,SecurePathForLifeFlag
      ,ReportDate
      ,LoadDate
)	  
VALUES
(		
	   source.dimPlanId
      ,source.PlanNumber
      ,source.ContractNumber
      ,source.AffiliateNumber
      ,source.CompanyName
      ,source.PlanName
      ,source.PlanType
      ,source.PlanCategory
      ,source.TotalParticipantCount
      ,source.ActiveParticipantCount
      ,source.TerminatedParticipantCount
	  ,source.TotalParticipantCountWithBalance
	  ,source.ActiveParticipantCountWithBalance
	  ,source.TerminatedParticipantCountWithBalance
      ,source.ParticipationRate
      ,source.AvgContributionRate
      ,source.EligibleEmployeeCount
      ,source.ContributingEmployeeCount
      ,source.NonContributingEmployeeCount
	  ,source.AvgContributionAmount
	  ,source.ActiveParticipantFundBalance 
	  ,source.TerminatedParticipantFundBalance 
	  ,source.AvgParticipantFundBalance 
	  ,source.AvgActiveParticipantFundBalance 
	  ,source.AvgTerminatedParticipantFundBalance 
      ,source.ActiveParticipantCoreFunds
      ,source.TerminatedParticipantCoreFunds
      ,source.AvgParticipantCoreFund
      ,source.AvgActiveParticipantCoreFund
      ,source.AvgTerminatedParticipantCoreFund
      ,source.PCRA_Allowed_Flag
      ,source.ActiveParticipantPCRA
      ,source.TerminatedParticipantPCRA
      ,source.AvgParticipantPCRA
      ,source.AvgActiveParticipantPCRA
      ,source.AvgTerminatedParticipantPCRA
      ,source.SDB_Allowed_Flag
      ,source.ActiveParticipantSDB
      ,source.TerminatedParticipantSDB
      ,source.AvgParticipantSDB
      ,source.AvgActiveParticipantSDB
      ,source.AvgTerminatedParticipantSDB
      ,source.SuspenseBalance
      ,source.ForefeitureBalance
      ,source.ExpenseAccountBalance
      ,source.AdvancedEmployerBalance
      ,source.ActiveParticipantResidentialLoanBalance
      ,source.ActiveParticipantsWithResidentialLoanBalance
      ,source.ActiveParticipantResidentialHardshipLoanBalance
      ,source.ActiveParticipantsWithResidentialHardshipLoanBalance
      ,source.ActiveParticipantPersonalLoanBalance
      ,source.ActiveParticipantsWithPersonalLoanBalance
      ,source.ActiveParticipantPersonalHardshipLoanBalance
      ,source.ActiveParticipantsWithPersonalHardshipLoanBalance
      ,source.ActiveParticipantOtherLoanBalance
      ,source.ActiveParticipantsWithOtherLoanBalance
      ,source.TerminatedParticipantResidentialLoanBalance
      ,source.TerminatedParticipantsWithResidentialLoanBalance
      ,source.TerminatedParticipantResidentialHardshipLoanBalance
      ,source.TerminatedParticipantsWithResidentialHardshipLoanBalance
      ,source.TerminatedParticipantPersonalLoanBalance
      ,source.TerminatedParticipantsWithPersonalLoanBalance
      ,source.TerminatedParticipantPersonalHardshipLoanBalance
      ,source.TerminatedParticipantsWithPersonalHardshipLoanBalance
      ,source.TerminatedParticipantOtherLoanBalance
      ,source.TerminatedParticipantsWithOtherLoanBalance
      ,source.LoanPermittedFlag
      ,source.ParticipantsPastDue
	  ,source.AutoRebalanceFlag
	  ,source.AutoIncreaseFlag
	  ,source.CustomPortfoliosFlag
	  ,source.DCMAFlag
	  ,source.FundTransferFlag
	  ,source.PCRAFlag
	  ,source.PortfolioXpressFlag
	  ,source.SDAFlag
	  ,source.SecurePathForLifeFlag
      ,source.ReportDate
, GETDATE());


GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_MetricsDivisionLevel]    Script Date: 6/17/2021 11:04:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_MetricsDivisionLevel]
AS
SET NOCOUNT ON;

MERGE WorkplaceExperience.ex.MetricsDivisionLevel AS target
	USING WorkplaceExperience.temp.MetricsDivisionLevel AS source ON
(target.PlanNumber = source.PlanNumber AND target.DIV_I=source.DIV_I AND year(target.ReportDate) = year(source.ReportDate) AND month(target.ReportDate) = month(source.ReportDate))
WHEN MATCHED THEN UPDATE SET
		 target.dimPlanId=source.dimPlanId
		,target.ContractNumber=source.ContractNumber
		,target.DivisionCode=source.DivisionCode
		,target.AffiliateNumber=source.AffiliateNumber
		,target.CompanyName=source.CompanyName
		,target.PlanName=source.PlanName
		,target.PlanType=source.PlanType
		,target.PlanCategory=source.PlanCategory
		,target.TotalParticipantCount=source.TotalParticipantCount
		,target.ActiveParticipantCount=source.ActiveParticipantCount
		,target.TerminatedParticipantCount=source.TerminatedParticipantCount
		,target.ParticipationRate=source.ParticipationRate
		,target.AvgContributionRate=source.AvgContributionRate
		,target.EligibleEmployeeCount=source.EligibleEmployeeCount
		,target.ContributingEmployeeCount=source.ContributingEmployeeCount
		,target.NonContributingEmployeeCount=source.NonContributingEmployeeCount
		,target.AvgContributionAmount=source.AvgContributionAmount
		,target.ActiveParticipantCoreFunds=source.ActiveParticipantCoreFunds
		,target.TerminatedParticipantCoreFunds=source.TerminatedParticipantCoreFunds
		,target.AvgParticipantCoreFund=source.AvgParticipantCoreFund
		,target.AvgActiveParticipantCoreFund=source.AvgActiveParticipantCoreFund
		,target.AvgTerminatedParticipantCoreFund=source.AvgTerminatedParticipantCoreFund
		,target.PCRA_Allowed_Flag=source.PCRA_Allowed_Flag
		,target.ActiveParticipantPCRA=source.ActiveParticipantPCRA
		,target.TerminatedParticipantPCRA=source.TerminatedParticipantPCRA
		,target.AvgParticipantPCRA=source.AvgParticipantPCRA
		,target.AvgActiveParticipantPCRA=source.AvgActiveParticipantPCRA
		,target.AvgTerminatedParticipantPCRA=source.AvgTerminatedParticipantPCRA
		,target.SDB_Allowed_Flag=source.SDB_Allowed_Flag
		,target.ActiveParticipantSDB=source.ActiveParticipantSDB
		,target.TerminatedParticipantSDB=source.TerminatedParticipantSDB
		,target.AvgParticipantSDB=source.AvgParticipantSDB
		,target.AvgActiveParticipantSDB=source.AvgActiveParticipantSDB
		,target.AvgTerminatedParticipantSDB=source.AvgTerminatedParticipantSDB
		,target.SuspenseBalance=source.SuspenseBalance
		,target.ForefeitureBalance=source.ForefeitureBalance
		,target.ExpenseAccountBalance=source.ExpenseAccountBalance
		,target.AdvancedEmployerBalance=source.AdvancedEmployerBalance
		,target.ActiveParticipantResidentialLoanBalance=source.ActiveParticipantResidentialLoanBalance
		,target.ActiveParticipantsWithResidentialLoanBalance=source.ActiveParticipantsWithResidentialLoanBalance
		,target.ActiveParticipantResidentialHardshipLoanBalance=source.ActiveParticipantResidentialHardshipLoanBalance
		,target.ActiveParticipantsWithResidentialHardshipLoanBalance=source.ActiveParticipantsWithResidentialHardshipLoanBalance
		,target.ActiveParticipantPersonalLoanBalance=source.ActiveParticipantPersonalLoanBalance
		,target.ActiveParticipantsWithPersonalLoanBalance=source.ActiveParticipantsWithPersonalLoanBalance
		,target.ActiveParticipantPersonalHardshipLoanBalance=source.ActiveParticipantPersonalHardshipLoanBalance
		,target.ActiveParticipantsWithPersonalHardshipLoanBalance=source.ActiveParticipantsWithPersonalHardshipLoanBalance
		,target.ActiveParticipantOtherLoanBalance=source.ActiveParticipantOtherLoanBalance
		,target.ActiveParticipantsWithOtherLoanBalance=source.ActiveParticipantsWithOtherLoanBalance
		,target.TerminatedParticipantResidentialLoanBalance=source.TerminatedParticipantResidentialLoanBalance
		,target.TerminatedParticipantsWithResidentialLoanBalance=source.TerminatedParticipantsWithResidentialLoanBalance
		,target.TerminatedParticipantResidentialHardshipLoanBalance=source.TerminatedParticipantResidentialHardshipLoanBalance
		,target.TerminatedParticipantsWithResidentialHardshipLoanBalance=source.TerminatedParticipantsWithResidentialHardshipLoanBalance
		,target.TerminatedParticipantPersonalLoanBalance=source.TerminatedParticipantPersonalLoanBalance
		,target.TerminatedParticipantsWithPersonalLoanBalance=source.TerminatedParticipantsWithPersonalLoanBalance
		,target.TerminatedParticipantPersonalHardshipLoanBalance=source.TerminatedParticipantPersonalHardshipLoanBalance
		,target.TerminatedParticipantsWithPersonalHardshipLoanBalance=source.TerminatedParticipantsWithPersonalHardshipLoanBalance
		,target.TerminatedParticipantOtherLoanBalance=source.TerminatedParticipantOtherLoanBalance
		,target.TerminatedParticipantsWithOtherLoanBalance=source.TerminatedParticipantsWithOtherLoanBalance
		,target.LoanPermittedFlag=source.LoanPermittedFlag
		,target.ParticipantsPastDue=source.ParticipantsPastDue
		,target.ReportDate=source.ReportDate
		,target.LoadDate = GETDATE()
WHEN NOT MATCHED THEN INSERT
( 
	   dimPlanId
      ,PlanNumber
      ,ContractNumber
	  ,DivisionCode
	  ,DIV_I
      ,AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
      ,TotalParticipantCount
      ,ActiveParticipantCount
      ,TerminatedParticipantCount
      ,ParticipationRate
      ,AvgContributionRate
      ,EligibleEmployeeCount
      ,ContributingEmployeeCount
      ,NonContributingEmployeeCount
	  ,AvgContributionAmount
      ,ActiveParticipantCoreFunds
      ,TerminatedParticipantCoreFunds
      ,AvgParticipantCoreFund
      ,AvgActiveParticipantCoreFund
      ,AvgTerminatedParticipantCoreFund
      ,PCRA_Allowed_Flag
      ,ActiveParticipantPCRA
      ,TerminatedParticipantPCRA
      ,AvgParticipantPCRA
      ,AvgActiveParticipantPCRA
      ,AvgTerminatedParticipantPCRA
      ,SDB_Allowed_Flag
      ,ActiveParticipantSDB
      ,TerminatedParticipantSDB
      ,AvgParticipantSDB
      ,AvgActiveParticipantSDB
      ,AvgTerminatedParticipantSDB
      ,SuspenseBalance
      ,ForefeitureBalance
      ,ExpenseAccountBalance
      ,AdvancedEmployerBalance
      ,ActiveParticipantResidentialLoanBalance
      ,ActiveParticipantsWithResidentialLoanBalance
      ,ActiveParticipantResidentialHardshipLoanBalance
      ,ActiveParticipantsWithResidentialHardshipLoanBalance
      ,ActiveParticipantPersonalLoanBalance
      ,ActiveParticipantsWithPersonalLoanBalance
      ,ActiveParticipantPersonalHardshipLoanBalance
      ,ActiveParticipantsWithPersonalHardshipLoanBalance
      ,ActiveParticipantOtherLoanBalance
      ,ActiveParticipantsWithOtherLoanBalance
      ,TerminatedParticipantResidentialLoanBalance
      ,TerminatedParticipantsWithResidentialLoanBalance
      ,TerminatedParticipantResidentialHardshipLoanBalance
      ,TerminatedParticipantsWithResidentialHardshipLoanBalance
      ,TerminatedParticipantPersonalLoanBalance
      ,TerminatedParticipantsWithPersonalLoanBalance
      ,TerminatedParticipantPersonalHardshipLoanBalance
      ,TerminatedParticipantsWithPersonalHardshipLoanBalance
      ,TerminatedParticipantOtherLoanBalance
      ,TerminatedParticipantsWithOtherLoanBalance
      ,LoanPermittedFlag
      ,ParticipantsPastDue
      ,ReportDate
      ,LoadDate
)	  
VALUES
(		
	   source.dimPlanId
      ,source.PlanNumber
      ,source.ContractNumber
	  ,source.DivisionCode
	  ,source.DIV_I
      ,source.AffiliateNumber
      ,source.CompanyName
      ,source.PlanName
      ,source.PlanType
      ,source.PlanCategory
      ,source.TotalParticipantCount
      ,source.ActiveParticipantCount
      ,source.TerminatedParticipantCount
      ,source.ParticipationRate
      ,source.AvgContributionRate
      ,source.EligibleEmployeeCount
      ,source.ContributingEmployeeCount
      ,source.NonContributingEmployeeCount
	  ,source.AvgContributionAmount
      ,source.ActiveParticipantCoreFunds
      ,source.TerminatedParticipantCoreFunds
      ,source.AvgParticipantCoreFund
      ,source.AvgActiveParticipantCoreFund
      ,source.AvgTerminatedParticipantCoreFund
      ,source.PCRA_Allowed_Flag
      ,source.ActiveParticipantPCRA
      ,source.TerminatedParticipantPCRA
      ,source.AvgParticipantPCRA
      ,source.AvgActiveParticipantPCRA
      ,source.AvgTerminatedParticipantPCRA
      ,source.SDB_Allowed_Flag
      ,source.ActiveParticipantSDB
      ,source.TerminatedParticipantSDB
      ,source.AvgParticipantSDB
      ,source.AvgActiveParticipantSDB
      ,source.AvgTerminatedParticipantSDB
      ,source.SuspenseBalance
      ,source.ForefeitureBalance
      ,source.ExpenseAccountBalance
      ,source.AdvancedEmployerBalance
      ,source.ActiveParticipantResidentialLoanBalance
      ,source.ActiveParticipantsWithResidentialLoanBalance
      ,source.ActiveParticipantResidentialHardshipLoanBalance
      ,source.ActiveParticipantsWithResidentialHardshipLoanBalance
      ,source.ActiveParticipantPersonalLoanBalance
      ,source.ActiveParticipantsWithPersonalLoanBalance
      ,source.ActiveParticipantPersonalHardshipLoanBalance
      ,source.ActiveParticipantsWithPersonalHardshipLoanBalance
      ,source.ActiveParticipantOtherLoanBalance
      ,source.ActiveParticipantsWithOtherLoanBalance
      ,source.TerminatedParticipantResidentialLoanBalance
      ,source.TerminatedParticipantsWithResidentialLoanBalance
      ,source.TerminatedParticipantResidentialHardshipLoanBalance
      ,source.TerminatedParticipantsWithResidentialHardshipLoanBalance
      ,source.TerminatedParticipantPersonalLoanBalance
      ,source.TerminatedParticipantsWithPersonalLoanBalance
      ,source.TerminatedParticipantPersonalHardshipLoanBalance
      ,source.TerminatedParticipantsWithPersonalHardshipLoanBalance
      ,source.TerminatedParticipantOtherLoanBalance
      ,source.TerminatedParticipantsWithOtherLoanBalance
      ,source.LoanPermittedFlag
      ,source.ParticipantsPastDue
      ,source.ReportDate
	  , GETDATE());


GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_MetricsUserLevel]    Script Date: 6/17/2021 11:04:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_MetricsUserLevel]
AS
SET NOCOUNT ON;

MERGE WorkplaceExperience.ex.MetricsUserLevel AS target
	USING WorkplaceExperience.temp.MetricsUserLevel AS source ON
(target.PlanNumber = source.PlanNumber AND target.UserId=source.UserId AND year(target.ReportDate) = year(source.ReportDate) AND month(target.ReportDate) = month(source.ReportDate))
WHEN MATCHED THEN UPDATE SET
		 target.dimPlanId=source.dimPlanId
		,target.ContractNumber=source.ContractNumber
		,target.AffiliateNumber=source.AffiliateNumber
		,target.CompanyName=source.CompanyName
		,target.PlanName=source.PlanName
		,target.PlanType=source.PlanType
		,target.PlanCategory=source.PlanCategory
		,target.TotalParticipantCount=source.TotalParticipantCount
		,target.ActiveParticipantCount=source.ActiveParticipantCount
		,target.TerminatedParticipantCount=source.TerminatedParticipantCount
		,target.TotalParticipantCountWithBalance=source.TotalParticipantCountWithBalance
		,target.ActiveParticipantCountWithBalance=source.ActiveParticipantCountWithBalance
		,target.TerminatedParticipantCountWithBalance=source.TerminatedParticipantCountWithBalance
		,target.ParticipationRate=source.ParticipationRate
		,target.AvgContributionRate=source.AvgContributionRate
		,target.EligibleEmployeeCount=source.EligibleEmployeeCount
		,target.ContributingEmployeeCount=source.ContributingEmployeeCount
		,target.NonContributingEmployeeCount=source.NonContributingEmployeeCount
		,target.AvgContributionAmount=source.AvgContributionAmount
		,target.ActiveParticipantFundBalance=source.ActiveParticipantFundBalance
		,target.TerminatedParticipantFundBalance=source.TerminatedParticipantFundBalance
		,target.AvgParticipantFundBalance=source.AvgParticipantFundBalance
		,target.AvgActiveParticipantFundBalance=source.AvgActiveParticipantFundBalance
		,target.AvgTerminatedParticipantFundBalance=source.AvgTerminatedParticipantFundBalance
		,target.ActiveParticipantCoreFunds=source.ActiveParticipantCoreFunds
		,target.TerminatedParticipantCoreFunds=source.TerminatedParticipantCoreFunds
		,target.AvgParticipantCoreFund=source.AvgParticipantCoreFund
		,target.AvgActiveParticipantCoreFund=source.AvgActiveParticipantCoreFund
		,target.AvgTerminatedParticipantCoreFund=source.AvgTerminatedParticipantCoreFund
		,target.PCRA_Allowed_Flag=source.PCRA_Allowed_Flag
		,target.ActiveParticipantPCRA=source.ActiveParticipantPCRA
		,target.TerminatedParticipantPCRA=source.TerminatedParticipantPCRA
		,target.AvgParticipantPCRA=source.AvgParticipantPCRA
		,target.AvgActiveParticipantPCRA=source.AvgActiveParticipantPCRA
		,target.AvgTerminatedParticipantPCRA=source.AvgTerminatedParticipantPCRA
		,target.SDB_Allowed_Flag=source.SDB_Allowed_Flag
		,target.ActiveParticipantSDB=source.ActiveParticipantSDB
		,target.TerminatedParticipantSDB=source.TerminatedParticipantSDB
		,target.AvgParticipantSDB=source.AvgParticipantSDB
		,target.AvgActiveParticipantSDB=source.AvgActiveParticipantSDB
		,target.AvgTerminatedParticipantSDB=source.AvgTerminatedParticipantSDB
		,target.SuspenseBalance=source.SuspenseBalance
		,target.ForefeitureBalance=source.ForefeitureBalance
		,target.ExpenseAccountBalance=source.ExpenseAccountBalance
		,target.AdvancedEmployerBalance=source.AdvancedEmployerBalance
		,target.ActiveParticipantResidentialLoanBalance=source.ActiveParticipantResidentialLoanBalance
		,target.ActiveParticipantsWithResidentialLoanBalance=source.ActiveParticipantsWithResidentialLoanBalance
		,target.ActiveParticipantResidentialHardshipLoanBalance=source.ActiveParticipantResidentialHardshipLoanBalance
		,target.ActiveParticipantsWithResidentialHardshipLoanBalance=source.ActiveParticipantsWithResidentialHardshipLoanBalance
		,target.ActiveParticipantPersonalLoanBalance=source.ActiveParticipantPersonalLoanBalance
		,target.ActiveParticipantsWithPersonalLoanBalance=source.ActiveParticipantsWithPersonalLoanBalance
		,target.ActiveParticipantPersonalHardshipLoanBalance=source.ActiveParticipantPersonalHardshipLoanBalance
		,target.ActiveParticipantsWithPersonalHardshipLoanBalance=source.ActiveParticipantsWithPersonalHardshipLoanBalance
		,target.ActiveParticipantOtherLoanBalance=source.ActiveParticipantOtherLoanBalance
		,target.ActiveParticipantsWithOtherLoanBalance=source.ActiveParticipantsWithOtherLoanBalance
		,target.TerminatedParticipantResidentialLoanBalance=source.TerminatedParticipantResidentialLoanBalance
		,target.TerminatedParticipantsWithResidentialLoanBalance=source.TerminatedParticipantsWithResidentialLoanBalance
		,target.TerminatedParticipantResidentialHardshipLoanBalance=source.TerminatedParticipantResidentialHardshipLoanBalance
		,target.TerminatedParticipantsWithResidentialHardshipLoanBalance=source.TerminatedParticipantsWithResidentialHardshipLoanBalance
		,target.TerminatedParticipantPersonalLoanBalance=source.TerminatedParticipantPersonalLoanBalance
		,target.TerminatedParticipantsWithPersonalLoanBalance=source.TerminatedParticipantsWithPersonalLoanBalance
		,target.TerminatedParticipantPersonalHardshipLoanBalance=source.TerminatedParticipantPersonalHardshipLoanBalance
		,target.TerminatedParticipantsWithPersonalHardshipLoanBalance=source.TerminatedParticipantsWithPersonalHardshipLoanBalance
		,target.TerminatedParticipantOtherLoanBalance=source.TerminatedParticipantOtherLoanBalance
		,target.TerminatedParticipantsWithOtherLoanBalance=source.TerminatedParticipantsWithOtherLoanBalance
		,target.LoanPermittedFlag=source.LoanPermittedFlag
		,target.ParticipantsPastDue=source.ParticipantsPastDue
		,target.AutoRebalanceFlag=source.AutoRebalanceFlag
		,target.AutoIncreaseFlag=source.AutoIncreaseFlag
		,target.CustomPortfoliosFlag=source.CustomPortfoliosFlag
		,target.DCMAFlag=source.DCMAFlag
		,target.FundTransferFlag=source.FundTransferFlag
		,target.PCRAFlag=source.PCRAFlag
		,target.PortfolioXpressFlag = source.PortfolioXpressFlag
		,target.SDAFlag=source.SDAFlag
		,target.SecurePathForLifeFlag=source.SecurePathForLifeFlag
		,target.ReportDate=source.ReportDate
		,target.LoadDate = GETDATE()
WHEN NOT MATCHED THEN INSERT
( 
	   dimPlanId
      ,PlanNumber
      ,ContractNumber
	  ,UserId
      ,AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
      ,TotalParticipantCount
      ,ActiveParticipantCount
      ,TerminatedParticipantCount
	  ,TotalParticipantCountWithBalance
	  ,ActiveParticipantCountWithBalance
	  ,TerminatedParticipantCountWithBalance
      ,ParticipationRate
      ,AvgContributionRate
      ,EligibleEmployeeCount
      ,ContributingEmployeeCount
      ,NonContributingEmployeeCount
	  ,AvgContributionAmount
	  ,ActiveParticipantFundBalance 
	  ,TerminatedParticipantFundBalance 
	  ,AvgParticipantFundBalance 
	  ,AvgActiveParticipantFundBalance 
	  ,AvgTerminatedParticipantFundBalance
      ,ActiveParticipantCoreFunds
      ,TerminatedParticipantCoreFunds
      ,AvgParticipantCoreFund
      ,AvgActiveParticipantCoreFund
      ,AvgTerminatedParticipantCoreFund
      ,PCRA_Allowed_Flag
      ,ActiveParticipantPCRA
      ,TerminatedParticipantPCRA
      ,AvgParticipantPCRA
      ,AvgActiveParticipantPCRA
      ,AvgTerminatedParticipantPCRA
      ,SDB_Allowed_Flag
      ,ActiveParticipantSDB
      ,TerminatedParticipantSDB
      ,AvgParticipantSDB
      ,AvgActiveParticipantSDB
      ,AvgTerminatedParticipantSDB
      ,SuspenseBalance
      ,ForefeitureBalance
      ,ExpenseAccountBalance
      ,AdvancedEmployerBalance
      ,ActiveParticipantResidentialLoanBalance
      ,ActiveParticipantsWithResidentialLoanBalance
      ,ActiveParticipantResidentialHardshipLoanBalance
      ,ActiveParticipantsWithResidentialHardshipLoanBalance
      ,ActiveParticipantPersonalLoanBalance
      ,ActiveParticipantsWithPersonalLoanBalance
      ,ActiveParticipantPersonalHardshipLoanBalance
      ,ActiveParticipantsWithPersonalHardshipLoanBalance
      ,ActiveParticipantOtherLoanBalance
      ,ActiveParticipantsWithOtherLoanBalance
      ,TerminatedParticipantResidentialLoanBalance
      ,TerminatedParticipantsWithResidentialLoanBalance
      ,TerminatedParticipantResidentialHardshipLoanBalance
      ,TerminatedParticipantsWithResidentialHardshipLoanBalance
      ,TerminatedParticipantPersonalLoanBalance
      ,TerminatedParticipantsWithPersonalLoanBalance
      ,TerminatedParticipantPersonalHardshipLoanBalance
      ,TerminatedParticipantsWithPersonalHardshipLoanBalance
      ,TerminatedParticipantOtherLoanBalance
      ,TerminatedParticipantsWithOtherLoanBalance
      ,LoanPermittedFlag
      ,ParticipantsPastDue
	  ,AutoRebalanceFlag
	  ,AutoIncreaseFlag
	  ,CustomPortfoliosFlag
	  ,DCMAFlag
	  ,FundTransferFlag
	  ,PCRAFlag
	  ,PortfolioXpressFlag
	  ,SDAFlag
	  ,SecurePathForLifeFlag      
	  ,ReportDate
      ,LoadDate
)	  
VALUES
(		
	   source.dimPlanId
      ,source.PlanNumber
      ,source.ContractNumber
	  ,source.UserId
      ,source.AffiliateNumber
      ,source.CompanyName
      ,source.PlanName
      ,source.PlanType
      ,source.PlanCategory
      ,source.TotalParticipantCount
      ,source.ActiveParticipantCount
      ,source.TerminatedParticipantCount
	  ,source.TotalParticipantCountWithBalance
	  ,source.ActiveParticipantCountWithBalance
	  ,source.TerminatedParticipantCountWithBalance
      ,source.ParticipationRate
      ,source.AvgContributionRate
      ,source.EligibleEmployeeCount
      ,source.ContributingEmployeeCount
      ,source.NonContributingEmployeeCount
	  ,source.AvgContributionAmount
	  ,source.ActiveParticipantFundBalance 
	  ,source.TerminatedParticipantFundBalance 
	  ,source.AvgParticipantFundBalance 
	  ,source.AvgActiveParticipantFundBalance 
	  ,source.AvgTerminatedParticipantFundBalance 
      ,source.ActiveParticipantCoreFunds
      ,source.TerminatedParticipantCoreFunds
      ,source.AvgParticipantCoreFund
      ,source.AvgActiveParticipantCoreFund
      ,source.AvgTerminatedParticipantCoreFund
      ,source.PCRA_Allowed_Flag
      ,source.ActiveParticipantPCRA
      ,source.TerminatedParticipantPCRA
      ,source.AvgParticipantPCRA
      ,source.AvgActiveParticipantPCRA
      ,source.AvgTerminatedParticipantPCRA
      ,source.SDB_Allowed_Flag
      ,source.ActiveParticipantSDB
      ,source.TerminatedParticipantSDB
      ,source.AvgParticipantSDB
      ,source.AvgActiveParticipantSDB
      ,source.AvgTerminatedParticipantSDB
      ,source.SuspenseBalance
      ,source.ForefeitureBalance
      ,source.ExpenseAccountBalance
      ,source.AdvancedEmployerBalance
      ,source.ActiveParticipantResidentialLoanBalance
      ,source.ActiveParticipantsWithResidentialLoanBalance
      ,source.ActiveParticipantResidentialHardshipLoanBalance
      ,source.ActiveParticipantsWithResidentialHardshipLoanBalance
      ,source.ActiveParticipantPersonalLoanBalance
      ,source.ActiveParticipantsWithPersonalLoanBalance
      ,source.ActiveParticipantPersonalHardshipLoanBalance
      ,source.ActiveParticipantsWithPersonalHardshipLoanBalance
      ,source.ActiveParticipantOtherLoanBalance
      ,source.ActiveParticipantsWithOtherLoanBalance
      ,source.TerminatedParticipantResidentialLoanBalance
      ,source.TerminatedParticipantsWithResidentialLoanBalance
      ,source.TerminatedParticipantResidentialHardshipLoanBalance
      ,source.TerminatedParticipantsWithResidentialHardshipLoanBalance
      ,source.TerminatedParticipantPersonalLoanBalance
      ,source.TerminatedParticipantsWithPersonalLoanBalance
      ,source.TerminatedParticipantPersonalHardshipLoanBalance
      ,source.TerminatedParticipantsWithPersonalHardshipLoanBalance
      ,source.TerminatedParticipantOtherLoanBalance
      ,source.TerminatedParticipantsWithOtherLoanBalance
      ,source.LoanPermittedFlag
      ,source.ParticipantsPastDue
	  ,source.AutoRebalanceFlag
	  ,source.AutoIncreaseFlag
	  ,source.CustomPortfoliosFlag
	  ,source.DCMAFlag
	  ,source.FundTransferFlag
	  ,source.PCRAFlag
	  ,source.PortfolioXpressFlag
	  ,source.SDAFlag
	  ,source.SecurePathForLifeFlag      
	  ,source.ReportDate
	  , GETDATE());


GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_OutlooksUserLevel]    Script Date: 6/17/2021 11:04:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_OutlooksUserLevel]
AS
SET NOCOUNT ON;

MERGE WorkplaceExperience.ex.OutlooksUserLevel AS target
	USING WorkplaceExperience.temp.OutlooksUserLevel AS source ON
(target.PlanNumber = source.PlanNumber AND target.UserId=source.UserId AND year(target.ReportDate) = year(source.ReportDate) AND month(target.ReportDate) = month(source.ReportDate))
WHEN MATCHED THEN UPDATE SET
		 target.dimPlanId=source.dimPlanId
		,target.PlanNumber=source.PlanNumber
		,target.RestrictedCaseFlag=source.RestrictedCaseFlag
		,target.OntrackOutlookCount=source.OntrackOutlookCount
		,target.UnknownOutlookCount=source.UnknownOutlookCount
		,target.NotOntrackOutlookCount=source.NotOntrackOutlookCount
		,target.TotalOutlookCount=source.TotalOutlookCount
		,target.OntrackPercentage=source.OntrackPercentage
		,target.ReportDate=source.ReportDate
		,target.LoadDate = GETDATE()
WHEN NOT MATCHED THEN INSERT
( 
		 dimPlanId
		,PlanNumber
		,RestrictedCaseFlag
		,UserId
		,OntrackOutlookCount
		,UnknownOutlookCount
		,NotOntrackOutlookCount
		,TotalOutlookCount
		,OntrackPercentage
		,ReportDate
		,LoadDate
)	  
VALUES
(		
		 source.dimPlanId
		,source.PlanNumber
 		,source.RestrictedCaseFlag
		,source.UserId
		,source.OntrackOutlookCount
		,source.UnknownOutlookCount
		,source.NotOntrackOutlookCount
		,source.TotalOutlookCount
		,source.OntrackPercentage
		,source.ReportDate
		, GETDATE()
);


GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_ParticipantDetails]    Script Date: 6/17/2021 11:04:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_ParticipantDetails]
AS
SET NOCOUNT ON;

TRUNCATE TABLE ex.ParticipantDetails;

INSERT INTO ex.ParticipantDetails
( 
		 dimParticipantId
		,dimPlanid
		,CaseNumber
        ,PlanName
        ,EmployerName
        ,SocialSecurityNumber
        ,EmployeeNumber
        ,UserList
        ,DivisionList
		,MultiDivisionFlag
        ,FirstName
        ,MiddleInitial
        ,LastName
        ,Suffix
        ,Gender
        ,AddressLine1
        ,AddressLine2
        ,DeliverableStatus
        ,AddressStatus
        ,City
        ,StateAbbreviation
        ,StateName
        ,ZipCode
        ,DayPhoneNumber
        ,DayPhoneExt
        ,MobilePhoneNumber
        ,EveningPhoneNumber
        ,EveningPhoneExt
        ,EmailAddress
        ,BirthDate
        ,DeathDate
        ,HireDate
        ,TerminationDate
        ,ReHireDate
        ,LastStatementDate
        ,PartSiteAccess
        ,IVRAccess
        ,SubLocation
        ,PayRollCycle
        ,HoursWorked
        ,MaritalStatus
        ,UserBalances
        ,ReportDate
		,LoadDate
)
SELECT 	 dimParticipantId
		,dimPlanid
		,CaseNumber
        ,PlanName
        ,EmployerName
        ,SocialSecurityNumber
        ,EmployeeNumber
        ,UserList
        ,DivisionList
		,MultiDivisionFlag
        ,FirstName
        ,MiddleInitial
        ,LastName
        ,Suffix
        ,Gender
        ,AddressLine1
        ,AddressLine2
        ,DeliverableStatus
        ,AddressStatus
        ,City
        ,StateAbbreviation
        ,StateName
        ,ZipCode
        ,DayPhoneNumber
        ,DayPhoneExt
        ,MobilePhoneNumber
        ,EveningPhoneNumber
        ,EveningPhoneExt
        ,EmailAddress
        ,BirthDate
        ,DeathDate
        ,HireDate
        ,TerminationDate
        ,ReHireDate
        ,LastStatementDate
        ,PartSiteAccess
        ,IVRAccess
        ,SubLocation
        ,PayRollCycle
        ,HoursWorked
        ,MaritalStatus
        ,UserBalances
        ,ReportDate
	    , GETDATE()
FROM temp.ParticipantDetails;


GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_SupportTeam]    Script Date: 6/17/2021 11:04:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Insert_SupportTeam]
AS
SET NOCOUNT ON;

DECLARE @LastLoadDate DATETIME = (SELECT MAX(LoadDateTime) FROM ex.SupportTeam WITH (NOLOCK));

INSERT INTO ex.SupportTeam
(	   PlanNumber
      ,ContractNumber
      ,AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
      ,FirstName
      ,LastName
      ,FullName
      ,SupportRole
      ,PhoneNumber
      ,EmailAddress
      ,ReportDate
	  ,LoadDatetime
)
SELECT
	   source.PlanNumber
      ,source.ContractNumber
      ,source.AffiliateNumber
      ,source.CompanyName
      ,source.PlanName
      ,source.PlanType
      ,source.PlanCategory
      ,source.FirstName
      ,source.LastName
      ,source.FullName
      ,source.SupportRole
      ,source.PhoneNumber
      ,source.EmailAddress
      ,source.ReportDate
	  ,GETDATE()
FROM temp.SupportTeam source

DELETE FROM ex.SupportTeam WHERE LoadDatetime = @LastLoadDate;


GO
/****** Object:  StoredProcedure [dbo].[usp_Source_BalanceByFundCaseLevel]    Script Date: 6/17/2021 11:04:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_BalanceByFundCaseLevel]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT MAX(ReportDate) FROM [temp].[BalanceByFundParticipantLevel] WITH (NOLOCK));

-------- Final Staging Table -----------
IF OBJECT_ID('tempdb..#_BalanceByFundCaseLevel', 'U') IS NOT NULL
	DROP TABLE #_BalanceByFundCaseLevel
CREATE TABLE #_BalanceByFundCaseLevel(
	dimPlanId INT
   ,PlanNumber VARCHAR(20)
   ,ContractNumber VARCHAR(10)
   ,AffiliateNumber VARCHAR(10)
   ,CompanyName VARCHAR(80)
   ,PlanName VARCHAR(161)
   ,PlanType VARCHAR(80)
   ,PlanCategory VARCHAR(20)
   ,FD_PROV_I BIGINT
   ,FundSortOrder INT
   ,FundStyle VARCHAR(30)
   ,AssetCategory VARCHAR(30)
   ,AssetClass VARCHAR(30)
   ,FundFamily VARCHAR(35)
   ,FundName VARCHAR(100)
   ,TickerSymbol VARCHAR(100)
   ,Participants INT
   ,Balance DECIMAL(38, 2)
   ,UnitCount DECIMAL(38, 6)
   ,ReportDate DATE
);

INSERT INTO #_BalanceByFundCaseLevel

SELECT pln.dimPlanId
	  ,ex.PlanNumber
	  ,pln.ContractNumber
	  ,pln.AffiliateNumber
	  ,pln.CompanyName
	  ,pln.PlanName
	  ,pln.PlanProductType AS PlanType
	  ,CASE WHEN pln.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Defined Benefit'
	  		ELSE 'Defined Contribution'
	   END AS PlanCategory
	  ,ISNULL(fund.FD_PROV_I,0) AS FD_PROV_I
	  ,ISNULL(fund.FundSortOrder, 0) AS FundSortOrder
	  ,ISNULL(fund.FundStyle, 'N/A') AS FundStyle
      ,ISNULL(fund.AssetCategory, 'N/A') AS AssetCategory
      ,ISNULL(fund.AssetClass, 'N/A') AS AssetClass
      ,ISNULL(fund.FundFamily, 'N/A') AS FundFamily
      ,ISNULL(fund.FundName, 'N/A') AS FundName
	  ,ISNULL(ffd.NASDAQ_SYM, 'N/A') AS TickerSymbol
	  ,ISNULL(COUNT(DISTINCT bal.dimParticipantId), 0) AS Participants
	  ,ISNULL(SUM(bal.Balance), 0.00) AS Balance
	  ,ISNULL(SUM(bal.UnitCount), 0.00) AS UnitCount
	  ,ISNULL(bal.ReportDate, @ReportDate) AS ReportDate
FROM [ref].[EXPlans] ex WITH (NOLOCK)
	INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimPlan] pln WITH (NOLOCK)
		ON ex.PlanNumber = pln.CaseNumber
	   AND pln.ActiveRecordFlag = 1
	LEFT OUTER JOIN [temp].[BalanceByFundParticipantLevel] bal WITH (NOLOCK)
		ON ex.PlanNumber = bal.CaseNumber
	LEFT OUTER JOIN  [TRS_BI_DataWarehouse].[dbo].[dimFund] fund WITH (NOLOCK)
		ON bal.dimFundId = fund.dimFundId
	LEFT OUTER JOIN [TRS_BI_Staging].[dbo].[FP_FUND_DESC] ffd WITH (NOLOCK)
	    ON fund.FundDescription = ffd.FD_DESC_CD
GROUP BY pln.dimPlanId
		,ex.PlanNumber
		,pln.ContractNumber
		,pln.AffiliateNumber
		,pln.CompanyName
		,pln.PlanName
		,pln.PlanProductType
		,fund.FD_PROV_I
		,fund.FundSortOrder
        ,fund.FundStyle
        ,fund.AssetCategory
        ,fund.AssetClass
        ,fund.FundFamily
        ,fund.FundName
		,ffd.NASDAQ_SYM
		,bal.ReportDate;

-- Final select
--INSERT INTO temp.BalanceByFundCaseLevel
SELECT pl.planid AS dimPlanId
      ,env.PlanNumberEnv AS PlanNumber
      ,env.ContractNumberEnv AS ContractNumber
      ,ex.AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
	  ,FD_PROV_I
      ,FundSortOrder
      ,FundStyle
      ,AssetCategory
      ,AssetClass
      ,FundFamily
      ,FundName
	  ,TickerSymbol
      ,Participants
      ,Balance
      ,UnitCount
      ,ReportDate
FROM #_BalanceByFundCaseLevel ex
	INNER JOIN temp.EXPlansEnv env WITH (NOLOCK)
		ON ex.PlanNumber = env.PlanNumber
	INNER JOIN ex.plans_list pl
		ON --ex.PlanNumber = pl.plannumber;
		   env.PlanNumberEnv  = pl.plannumber

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_BalanceByFundDivisionLevel]    Script Date: 6/17/2021 11:04:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_BalanceByFundDivisionLevel]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT MAX(ReportDate) FROM [temp].[BalanceByFundParticipantLevel] WITH (NOLOCK));

-------- Final Staging Table -----------
IF OBJECT_ID('tempdb..#_BalanceByFundDivisionLevel', 'U') IS NOT NULL
	DROP TABLE #_BalanceByFundDivisionLevel
CREATE TABLE #_BalanceByFundDivisionLevel(
	dimPlanId INT
   ,PlanNumber VARCHAR(20)
   ,ContractNumber VARCHAR(10)
   ,AffiliateNumber VARCHAR(10)
   ,CompanyName VARCHAR(80)
   ,PlanName VARCHAR(161)
   ,PlanType VARCHAR(80)
   ,PlanCategory VARCHAR(20)
   ,DIV_I VARCHAR(50)
   ,DivisionCode VARCHAR(15)
   ,DivisionName VARCHAR(161)
   ,FD_PROV_I BIGINT
   ,FundSortOrder INT
   ,FundStyle VARCHAR(30)
   ,AssetCategory VARCHAR(30)
   ,AssetClass VARCHAR(30)
   ,FundFamily VARCHAR(35)
   ,FundName VARCHAR(100)
   ,Participants INT
   ,Balance DECIMAL(38, 2)
   ,UnitCount DECIMAL(38, 6)
   ,ReportDate DATE
);

WITH cteDivision AS (
	SELECT bal.*
		  ,par.EmploymentStatus
		  ,CAST(pDiv.DIV_I AS VARCHAR(50)) AS DIV_I
		  ,pDiv.DivisionCode
		  ,pDiv.DivisionName
		  ,parDiv.DivisionEmploymentStatus
		  ,parDiv.DivisionHireDate
		  ,parDiv.DivisionTermDate
		  ,parDiv.MultiDivisionIndicator
	FROM [temp].[BalanceByFundParticipantLevel] bal
		INNER JOIN [TRS_BI_Datawarehouse].[dbo].[dimParticipantDivision] parDiv
			ON bal.dimParticipantId = parDiv.dimParticipantId
		INNER JOIN [TRS_BI_Datawarehouse].[dbo].[dimPlanDivision] pDiv
			ON parDiv.DIV_I = pDiv.DIV_I
		INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimParticipant] par WITH (NOLOCK)
			ON bal.dimParticipantId = par.dimParticipantId
)
--SELECT * FROM cteDivision
,cteFundBalance AS (
	SELECT CaseNumber
		  ,dimPlanId
		  ,DIV_I
		  ,DivisionCode
		  ,DivisionName
		  ,dimFundId
		  ,COUNT(DISTINCT dimParticipantId) AS Participants
		  ,SUM(Balance) AS Balance
		  ,SUM(UnitCount) AS UnitCount
		  ,ReportDate
	FROM cteDivision
	WHERE MultiDivisionIndicator = 'NO'
	   OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'TERMED')
	   OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'ACTIVE' AND DivisionEmploymentStatus = 'ACTIVE')
	GROUP BY CaseNumber
			,dimPlanId
			,DIV_I
			,DivisionCode
			,DivisionName
			,dimFundId
			,ReportDate
)
--SELECT * FROM cteFundBalance
INSERT INTO #_BalanceByFundDivisionLevel
SELECT pln.dimPlanId 
	  ,ex.PlanNumber
	  ,pln.ContractNumber
	  ,pln.AffiliateNumber
	  ,pln.CompanyName
	  ,pln.PlanName
	  ,pln.PlanProductType AS PlanType
	  ,CASE WHEN pln.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Defined Benefit'
	  		ELSE 'Defined Contribution'
	   END AS PlanCategory
	  ,ISNULL(bal.DIV_I, 'Not Applicable') AS DIV_I
	  ,ISNULL(bal.DivisionCode, 'Not Applicable') AS DivisionCode
	  ,ISNULL(bal.DivisionName, 'Not Applicable') AS DivisionName
	  ,ISNULL(fund.FD_PROV_I,0) AS FD_PROV_I
	  ,ISNULL(fund.FundSortOrder, 0) AS FundSortOrder
	  ,ISNULL(fund.FundStyle, 'Not Applicable') AS FundStyle
      ,ISNULL(fund.AssetCategory, 'Not Applicable') AS AssetCategory
      ,ISNULL(fund.AssetClass, 'Not Applicable') AS AssetClass
      ,ISNULL(fund.FundFamily, 'Not Applicable') AS FundFamily
      ,ISNULL(fund.FundName, 'Not Applicable') AS FundName
	  ,ISNULL(SUM(Participants), 0) AS Participants
	  ,ISNULL(SUM(bal.Balance), 0.00) AS Balance
	  ,ISNULL(SUM(bal.UnitCount), 0.00) AS UnitCount
	  ,ISNULL(bal.ReportDate, @ReportDate) AS ReportDate
FROM [ref].[EXPlans] ex WITH (NOLOCK)
	INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimPlan] pln WITH (NOLOCK)
		ON ex.PlanNumber = pln.CaseNumber
	   AND pln.ActiveRecordFlag = 1
	LEFT OUTER JOIN cteFundBalance bal WITH (NOLOCK)
		ON ex.PlanNumber = bal.CaseNumber
	LEFT OUTER JOIN  [TRS_BI_DataWarehouse].[dbo].[dimFund] fund WITH (NOLOCK)
		ON bal.dimFundId = fund.dimFundId
GROUP BY pln.dimPlanId
		,ex.PlanNumber
	    ,pln.ContractNumber
	    ,pln.AffiliateNumber
	    ,pln.CompanyName
	    ,pln.PlanName
	    ,pln.PlanProductType
		,bal.DIV_I
		,bal.DivisionCode
		,bal.DivisionName
		,fund.FD_PROV_I
		,fund.FundSortOrder
		,fund.FundStyle
		,fund.AssetCategory
		,fund.AssetClass
		,fund.FundFamily
		,fund.FundName
		,bal.ReportDate;

-- Final select
SELECT dimPlanId
	  ,env.PlanNumberEnv AS PlanNumber
      ,ex.ContractNumber
      ,ex.AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
	  ,DIV_I
	  ,DivisionCode
	  ,DivisionName
	  ,FD_PROV_I
      ,FundSortOrder
      ,FundStyle
      ,AssetCategory
      ,AssetClass
      ,FundFamily
      ,FundName
      ,Participants
      ,Balance
      ,UnitCount
      ,ReportDate
FROM #_BalanceByFundDivisionLevel ex
	INNER JOIN temp.EXPlansEnv env WITH (NOLOCK)
		ON ex.PlanNumber = env.PlanNumber;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_BalanceByFundParticipantLevel_Delta]    Script Date: 6/17/2021 11:04:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_BalanceByFundParticipantLevel_Delta]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM [TRS_BI_DataWarehouse].[usr].[Balance]);
DECLARE @dimDateId INT = (SELECT dimDateId FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK) WHERE DateValue = @ReportDate);

IF OBJECT_ID('tempdb..#_BalanceByFundParticipantLevel', 'U') IS NOT NULL
	DROP TABLE #_BalanceByFundParticipantLevel
CREATE TABLE #_BalanceByFundParticipantLevel (
	CaseNumber VARCHAR(20)
   ,dimDateId INT
   ,dimParticipantId INT
   ,dimPlanId INT
   ,dimFundId INT
   ,FD_PROV_I BIGINT
   ,dimAgeId INT
   ,SocialSecurityNumber VARCHAR(12)
   ,Balance DECIMAL(15,2)
   ,UnitCount DECIMAL(15,6)
   ,ReportDate DATE
);

WITH cteCase AS (
	SELECT DISTINCT	
		   PlanNumber AS CaseNumber
	FROM [ref].[EXPlans] WITH (NOLOCK)
)
--SELECT * FROM cteCase
INSERT INTO #_BalanceByFundParticipantLevel
SELECT bal.CASE_NO
      ,bal.dimDateId
      ,bal.dimParticipantId
      ,bal.dimPlanId
	  ,bal.dimFundId
	  ,df.FD_PROV_I
      ,bal.dimAgeId
      ,bal.SOC_SEC_NO
      ,bal.Balance
	  ,bal.UnitCount
      ,@ReportDate as ReportDate
FROM [TRS_BI_DataWarehouse].[dbo].[factBalance] bal WITH (NOLOCK)
	INNER JOIN cteCase ex
		ON 1 = 1
	INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimPlan] pln WITH (NOLOCK)
		ON bal.dimPlanId = pln.dimPlanId
	   AND pln.CaseNumber = ex.CaseNumber
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimFund df WITH (NOLOCK)
		ON bal.dimFundId = df.dimFundId
WHERE dimEmployerAccountId = 0
AND   bal.dimDateId = @dimDateId;

-- Final select
--INSERT INTO temp.BalanceByFundParticipantLevel
SELECT CaseNumber
      ,dimDateId
      ,dimParticipantId
      ,dimPlanId
	  ,dimFundId
	  ,FD_PROV_I
      ,dimAgeId
      ,SocialSecurityNumber
      ,Balance
	  ,UnitCount
      ,ReportDate
FROM #_BalanceByFundParticipantLevel ex;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_BalanceByFundParticipantLevel_Full]    Script Date: 6/17/2021 11:04:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_BalanceByFundParticipantLevel_Full]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM [TRS_BI_DataWarehouse].[usr].[Balance])
	   ,@NumberOfMonths INT = 5;

IF OBJECT_ID('tempdb..#_DateArray', 'U') IS NOT NULL
	DROP TABLE #_DateArray
CREATE TABLE #_DateArray (
	dimDateId INT
   ,ReportDate DATE
);
INSERT INTO #_DateArray
SELECT dimDateId
	  ,DateValue
FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK)
WHERE DateValue = @ReportDate;

WITH CTE AS (
	SELECT @NumberOfMonths - 1 AS months
	UNION ALL 
	SELECT months - 1
	FROM CTE
	WHERE months > 0
)
INSERT INTO #_DateArray
SELECT dimDateId
	  ,DateValue
FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK)
WHERE DateValue IN (
	SELECT DATEADD(DAY, -1, DATEADD(MONTH, -months, DATEADD(DAY, -(DAY(@ReportDate) - 1), @ReportDate))) AS DateValue
	FROM CTE
)
ORDER BY 1 DESC;

IF OBJECT_ID('tempdb..#_BalanceByFundParticipantLevel', 'U') IS NOT NULL
	DROP TABLE #_BalanceByFundParticipantLevel
CREATE TABLE #_BalanceByFundParticipantLevel (
	CaseNumber VARCHAR(20)
   ,dimDateId INT
   ,dimParticipantId INT
   ,dimPlanId INT
   ,dimFundId INT
   ,FD_PROV_I BIGINT
   ,dimAgeId INT
   ,SocialSecurityNumber VARCHAR(12)
   ,Balance DECIMAL(15,2)
   ,UnitCount DECIMAL(15,6)
   ,ReportDate DATE
);

WITH cteCase AS (
	SELECT DISTINCT	
		   PlanNumber AS CaseNumber
	FROM [ref].[EXPlans] WITH (NOLOCK)
)
--SELECT * FROM cteCase
INSERT INTO #_BalanceByFundParticipantLevel
SELECT bal.CASE_NO
      ,bal.dimDateId
      ,bal.dimParticipantId
      ,bal.dimPlanId
	  ,bal.dimFundId
	  ,df.FD_PROV_I
      ,bal.dimAgeId
      ,bal.SOC_SEC_NO
      ,bal.Balance
	  ,bal.UnitCount
      ,dt.ReportDate
FROM [TRS_BI_DataWarehouse].[dbo].[factBalance] bal WITH (NOLOCK)
	INNER JOIN #_DateArray dt
		ON bal.dimDateId = dt.dimDateId
	INNER JOIN cteCase ex
		ON CaseNumber = CASE_NO
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimFund df WITH (NOLOCK)
		ON bal.dimFundId = df.dimFundId
WHERE dimEmployerAccountId = 0;

-- Final select
--INSERT INTO temp.BalanceByFundParticipantLevel
SELECT CaseNumber
      ,dimDateId
      ,dimParticipantId
      ,dimPlanId
	  ,dimFundId
	  ,FD_PROV_I
      ,dimAgeId
      ,SocialSecurityNumber
      ,Balance
	  ,UnitCount
      ,ReportDate
FROM #_BalanceByFundParticipantLevel ex WITH (NOLOCK);

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_BalanceByFundUserLevel]    Script Date: 6/17/2021 11:04:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_BalanceByFundUserLevel]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT MAX(ReportDate) FROM temp.BalanceByFundParticipantLevel WITH (NOLOCK));

-------- Final Staging Table -----------
IF OBJECT_ID('tempdb..#_BalanceByFundUserLevel', 'U') IS NOT NULL
	DROP TABLE #_BalanceByFundUserLevel
CREATE TABLE #_BalanceByFundUserLevel(
	dimPlanId INT
   ,PlanNumber VARCHAR(20)
   ,UserId VARCHAR(20)
   ,ContractNumber VARCHAR(10)
   ,AffiliateNumber VARCHAR(10)
   ,CompanyName VARCHAR(80)
   ,PlanName VARCHAR(161)
   ,PlanType VARCHAR(80)
   ,PlanCategory VARCHAR(20)
   ,FD_PROV_I BIGINT
   ,FundSortOrder INT
   ,FundStyle VARCHAR(30)
   ,AssetCategory VARCHAR(30)
   ,AssetClass VARCHAR(30)
   ,FundFamily VARCHAR(35)
   ,FundName VARCHAR(100)
   ,TickerSymbol VARCHAR(100)
   ,Participants INT
   ,Balance DECIMAL(38, 2)
   ,UnitCount DECIMAL(38, 6)
   ,ReportDate DATE
);

WITH #RestrictedPlans AS (
SELECT DISTINCT
	     PlanNumber,PlanNumberEnv 
FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT dr
INNER JOIN temp.EXPlansEnv ex
ON (ex.PlanNumberEnv=dr.ACCOUNT_NO)
)
,cteUser AS (
	SELECT DISTINCT 
		a.CaseNumber
	   ,a.SocialSecurityNumber
       ,d.USER_I as UserId
	   ,par.dimParticipantId as dimParticipantId
	FROM [TRS_BI_Datawarehouse].[dbo].[dimParticipantDivision] a WITH (NOLOCK)
	INNER JOIN [TRS_BI_Datawarehouse].[dbo].[dimPlanDivision] b WITH (NOLOCK)
		ON a.[DIV_I] = b.[DIV_I]
	INNER JOIN #RestrictedPlans rp
		ON a.CaseNumber=rp.PlanNumber and b.ACCOUNT_NO=rp.PlanNumber
	INNER JOIN WorkplaceExperience.ref.PSOL_DIV_ACCESS d WITH (NOLOCK)
		ON b.DivisionCode=d.DIV_NO and rp.PlanNumberEnv=d.ACCOUNT_NO
	INNER JOIN [TRS_BI_Datawarehouse].[usr].[Participant] par
		ON a.dimParticipantId=par.dimParticipantId
	WHERE (	MultiDivisionIndicator = 'NO'
			OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'TERMED')
			OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'ACTIVE' AND DivisionEmploymentStatus = 'ACTIVE')
		  )
)
--SELECT * FROM cteDivision
,cteFundBalance AS (
	SELECT par.CaseNumber
		  ,dimPlanId
		  ,UserId
		  ,dimFundId
		  ,COUNT(DISTINCT par.dimParticipantId) AS Participants
		  ,SUM(Balance) AS Balance
		  ,SUM(UnitCount) AS UnitCount
		  ,ReportDate
	FROM temp.BalanceByFundParticipantLevel par
	INNER JOIN cteUser cu
	    ON (cu.dimParticipantId=par.dimParticipantId)
	GROUP BY par.CaseNumber
			,dimPlanId
			,UserId
			,dimFundId
			,ReportDate
)
--SELECT * FROM cteFundBalance
INSERT INTO #_BalanceByFundUserLevel
SELECT pln.dimPlanId 
	  ,ex.PlanNumber
	  ,bal.UserId
	  ,pln.ContractNumber
	  ,pln.AffiliateNumber
	  ,pln.CompanyName
	  ,pln.PlanName
	  ,pln.PlanProductType AS PlanType
	  ,CASE WHEN pln.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Defined Benefit'
	  		ELSE 'Defined Contribution'
	   END AS PlanCategory
	  ,ISNULL(fund.FD_PROV_I,0) AS FD_PROV_I
	  ,ISNULL(fund.FundSortOrder, 0) AS FundSortOrder
	  ,ISNULL(fund.FundStyle, 'N/A') AS FundStyle
      ,ISNULL(fund.AssetCategory, 'N/A') AS AssetCategory
      ,ISNULL(fund.AssetClass, 'N/A') AS AssetClass
      ,ISNULL(fund.FundFamily, 'N/A') AS FundFamily
      ,ISNULL(fund.FundName, 'N/A') AS FundName
	  ,ISNULL(ffd.NASDAQ_SYM, 'N/A') AS TickerSymbol
	  ,ISNULL(SUM(Participants), 0) AS Participants
	  ,ISNULL(SUM(bal.Balance), 0.00) AS Balance
	  ,ISNULL(SUM(bal.UnitCount), 0.00) AS UnitCount
	  ,ISNULL(bal.ReportDate, @ReportDate) AS ReportDate
FROM ref.EXPlans ex WITH (NOLOCK)
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan pln WITH (NOLOCK)
		ON ex.PlanNumber = pln.CaseNumber
	   AND pln.ActiveRecordFlag = 1
	LEFT OUTER JOIN cteFundBalance bal WITH (NOLOCK)
		ON ex.PlanNumber = bal.CaseNumber
	LEFT OUTER JOIN  TRS_BI_DataWarehouse.dbo.dimFund fund WITH (NOLOCK)
		ON bal.dimFundId = fund.dimFundId
	LEFT OUTER JOIN [TRS_BI_Staging].[dbo].[FP_FUND_DESC] ffd WITH (NOLOCK)
	    ON fund.FundDescription = ffd.FD_DESC_CD
GROUP BY pln.dimPlanId 
		,ex.PlanNumber
		,bal.UserId
	    ,pln.ContractNumber
	    ,pln.AffiliateNumber
	    ,pln.CompanyName
	    ,pln.PlanName
	    ,pln.PlanProductType
		,fund.FD_PROV_I
		,fund.FundSortOrder
		,fund.FundStyle
		,fund.AssetCategory
		,fund.AssetClass
		,fund.FundFamily
		,fund.FundName
		,ffd.NASDAQ_SYM
		,bal.ReportDate;

-- Final select
SELECT pl.planid AS dimPlanId
      ,env.PlanNumberEnv AS PlanNumber
	  ,UserId
      ,env.ContractNumberEnv AS ContractNumber
      ,ex.AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
	  ,FD_PROV_I
      ,FundSortOrder
      ,FundStyle
      ,AssetCategory
      ,AssetClass
      ,FundFamily
      ,FundName
	  ,TickerSymbol
      ,Participants
      ,Balance
      ,UnitCount
      ,ReportDate
FROM #_BalanceByFundUserLevel ex
	INNER JOIN temp.EXPlansEnv env WITH (NOLOCK)
		ON ex.PlanNumber = env.PlanNumber
	INNER JOIN ex.plans_list pl
		ON --ex.PlanNumber = pl.plannumber;
		   env.PlanNumberEnv  = pl.plannumber

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_CaseFundFlags]    Script Date: 6/17/2021 11:04:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_CaseFundFlags]
AS
SET NOCOUNT ON;

----- Reference Table for User Access ----
IF OBJECT_ID('tempdb..#_CaseFundFlags', 'U') IS NOT NULL
	DROP TABLE #_CaseFundFlags
CREATE TABLE #_CaseFundFlags(
	PlanNumber VARCHAR(20),
	PCRA_Allowed_Flag BIT,
	SDB_Allowed_Flag BIT
);

------Select from Reference Tables -------
INSERT INTO #_CaseFundFlags
SELECT   D.MAIN_CASE AS ACCOUNT_NO
		,MAX(CASE WHEN C.FD_DESC_CD = 'PCRA' THEN 1 ELSE 0 END) AS PCRA_Allowed_Flag
		,MAX(CASE WHEN C.FD_DESC_CD LIKE 'NMF%' THEN 1 ELSE 0 END) AS SDB_Allowed_Flag
FROM     TRS_BI_Staging.dbo.PLAN_PROV_GRP A,
         TRS_BI_Staging.dbo.PLAN_PROVISION B,
         TRS_BI_Staging.dbo.PLAN_FUND C,
         (
           SELECT ACCOUNT_NO AS MAIN_CASE,
                  ACCOUNT_NO AS RELATED_CASE,
                  PROV_GRP_SRCH_NM AS ER_NAME,
                  ENRL_STAT_C
           FROM     TRS_BI_Staging.dbo.PLAN_PROV_GRP
           WHERE    RELATED_GRP_TYP_C = 361
           UNION ALL 
           SELECT   A.ACCOUNT_NO AS MAIN_CASE,
                    COALESCE(B.ACCOUNT_NO, A.ACCOUNT_NO) AS RELATED_CASE,
                    A.PROV_GRP_SRCH_NM AS ER_NAME,
                    A.ENRL_STAT_C
           FROM     TRS_BI_Staging.dbo.PLAN_PROV_GRP A,
                    TRS_BI_Staging.dbo.PLAN_PROV_GRP B
           WHERE    B.RELATED_GRP_I = A.ENRL_PROV_GRP_I
           AND      A.RELATED_GRP_TYP_C = 361
           AND      B.RELATED_GRP_TYP_C = 362
          ) AS D
WHERE    A.ENRL_PROV_GRP_I = B.ENRL_PROV_GRP_I
AND      B.PROVISION_I = C.FD_PROV_I
AND      B.PROV_TYP_C = 15
AND      A.RELATED_GRP_TYP_C IN (361,362)
AND      A.ACCOUNT_NO = D.RELATED_CASE
GROUP BY 
		 D.MAIN_CASE

-- Final select
--INSERT INTO temp.CaseFundFlags
SELECT   PlanNumber
	    ,PCRA_Allowed_Flag
		,SDB_Allowed_Flag
FROM #_CaseFundFlags ex;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_CaseLevelMetrics]    Script Date: 6/17/2021 11:04:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_CaseLevelMetrics]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM [TRS_BI_DataWarehouse].[usr].[Balance]);

DECLARE @DimDateId INT = (SELECT dimDateId FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK) WHERE DateValue = @ReportDate);

IF OBJECT_ID('tempdb..#_EXMetrics', 'U') IS NOT NULL
	DROP TABLE #_EXMetrics
CREATE TABLE #_EXMetrics (
	PlanNumber VARCHAR(20)
   ,ContractNumber VARCHAR(10)
   ,AffiliateNumber VARCHAR(10)
   ,CompanyName VARCHAR(80)
   ,PlanName VARCHAR(255)
   ,PlanType VARCHAR(80)
   ,PlanCategory VARCHAR(80)
   ,Participants INT
   ,ParticipantsActive INT
   ,ParticipantsTerminated INT
   ,TotalBalance DECIMAL(15,2)
   ,AvgParticipantBalance DECIMAL(15,2)
   ,EligibleEmployees INT
   ,ContributingEmployees INT
   ,NonContributingEmployees INT
   ,ParticipationRate DECIMAL(15,2)
   ,AvgContributionRate DECIMAL(15,2)
   ,AvgContributionAmount DECIMAL(15,2)
   ,EmployeesNotReceivingMatch INT
   ,TotalOutlooks INT
   ,OnTrackOutlooks INT
   ,UnknownOutlooks INT
   ,OnTrackOutlookPercentage DECIMAL(15,2)
   ,ReportDate DATE
);

WITH cteCase AS (
	SELECT DISTINCT	
		   PlanNumber AS CaseNumber
	FROM [ref].[EXPlans] WITH (NOLOCK)
	/*FROM [TRS_BI_DataWarehouse].[dbo].[dimPlan] WITH (NOLOCK)
	WHERE ActiveRecordFlag = 1
	  AND CaseStatus = 'ACTIVE'
	  AND (ERName LIKE '%AgReliant Genetics%'
		OR ERName LIKE '%S Kitchen, inc%'
		OR ERName LIKE '%Essentia Health%'
		OR ERName LIKE '%Johns Hopkins%'
		OR ERName LIKE '%Mesirow Financial%'
		OR ERName LIKE '%Nintendo%'
		OR ERName LIKE '%Park Nicollet%'
		OR ERName LIKE '%Red Bull%'
		OR ERName LIKE '%Sumitomo%'
		OR ERName LIKE '%St Lukes Hospital of Kansas City%'
		OR ERName LIKE '%Versa Networks%'
		OR ERName LIKE '%Yakima Valley Memorial%'

		OR ERName LIKE '%TBC CORPORATION%'
		OR ERName LIKE '%HARTZ MOUNTAIN CORPORATION%'
		OR ERName LIKE '%SUNSTATE EQUIPMENT CO., LLC%'
		OR ERName LIKE '%ASCEND PERFORMANCE MATERIALS%'
		OR ERName LIKE '%ARCBEST CORPORATION%'
		OR ERName LIKE '%ABF FREIGHT SYSTEM, INC.%'
		OR (ERName LIKE '%ALL CHILDREN%' AND ERName LIKE '%S HEALTH SYSTEM, INC.%')
		OR ERName LIKE '%SUBURBAN HOSPITAL, INC.%'
		OR ERName LIKE '%HOWARD COUNTY GENERAL HOSPITAL, INC.%'
		OR ERName LIKE '%TCAS, INC.%'
		OR ERName LIKE '%SC RAIL LEASING AMERICA, INC.%'
		OR (ERName LIKE '%SAINT LUKE%' AND ERName LIKE '%S HEALTH SYSTEM%')
		OR (ERName LIKE '%ST. LUKE%' AND ERName LIKE '%S HEALTH VENTURES, INC.%')

		OR ERName LIKE '%Scottrade%'
	  )*/
)
--SELECT * FROM cteCase
INSERT INTO #_EXMetrics (
	PlanNumber
   ,ContractNumber
   ,AffiliateNumber
   ,CompanyName
   ,PlanName
   ,PlanType
   ,PlanCategory
   ,ReportDate
)
SELECT cs.CaseNumber
	  ,pInfo.ContractNumber
	  ,pInfo.AffiliateNumber
	  ,pInfo.ERName
	  ,pInfo.PlanName
	  ,pInfo.PlanProductType
	  ,CASE WHEN pInfo.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Defined Benefit'
		    ELSE 'Defined Contribution'
	   END
	  ,@ReportDate
FROM cteCase cs
	INNER JOIN [TRS_BI_DataWarehouse].[usr].[PlanInfo] pInfo WITH (NOLOCK)
		ON cs.CaseNumber = pInfo.CaseNumber
WHERE ActiveRecordFlag = 1;

WITH cteBalance AS	(
	SELECT ex.PlanNumber
		  ,COUNT(DISTINCT bal.dimParticipantId) AS Participants
		  ,SUM(CASE WHEN par.EmploymentStatus = 'ACTIVE' THEN 1 ELSE 0 END) AS ParticipantsActive
		  ,SUM(CASE WHEN par.EmploymentStatus != 'ACTIVE' THEN 1 ELSE 0 END) AS ParticipantsTerminated
		  ,SUM(bal.Balance) AS TotalBalance
		  ,CAST(SUM(bal.Balance) / COUNT(DISTINCT bal.dimParticipantId) AS DECIMAL(15,2)) AS AvgParticipantBalance
	FROM [TRS_BI_DataWarehouse].[usr].[Balance] bal WITH (NOLOCK)
		INNER JOIN #_EXMetrics ex
			ON 1 = 1
		INNER JOIN [TRS_BI_DataWarehouse].[usr].[PlanInfo] pInfo WITH (NOLOCK)
			ON bal.dimPlanId = pInfo.dimPlanId
		   AND pInfo.CaseNumber = ex.PlanNumber
		INNER JOIN [TRS_BI_DataWarehouse].[usr].[Participant] par WITH (NOLOCK)
			ON bal.dimParticipantId = par.dimParticipantId
	WHERE bal.dimDateId = @DimDateId
	  AND bal.dimEmployerAccountId = 0
	GROUP BY ex.PlanNumber
)
--SELECT * FROM cteBalance
UPDATE ex
SET ex.Participants = bal.Participants
   ,ex.ParticipantsActive = bal.ParticipantsActive
   ,ex.ParticipantsTerminated = bal.ParticipantsTerminated
   ,ex.TotalBalance = bal.TotalBalance
   ,ex.AvgParticipantBalance = bal.AvgParticipantBalance
FROM #_EXMetrics ex
	INNER JOIN cteBalance bal
		ON ex.PlanNumber = bal.PlanNumber;

WITH cteEmpBalance AS	(
	SELECT ex.PlanNumber
		  ,SUM(bal.Balance) AS TotalBalance
	FROM [TRS_BI_DataWarehouse].[usr].[Balance] bal WITH (NOLOCK)
		INNER JOIN #_EXMetrics ex
			ON 1 = 1
		INNER JOIN [TRS_BI_DataWarehouse].[usr].[PlanInfo] pInfo WITH (NOLOCK)
			ON bal.dimPlanId = pInfo.dimPlanId
		   AND pInfo.CaseNumber = ex.PlanNumber
	WHERE bal.dimDateId = @DimDateId
	  AND bal.dimEmployerAccountId NOT IN (0,2)
	GROUP BY ex.PlanNumber
)
--SELECT * FROM cteEmpBalance
UPDATE ex
SET ex.TotalBalance = ex.TotalBalance + empBal.TotalBalance
FROM #_EXMetrics ex
	INNER JOIN cteEmpBalance empBal
		ON ex.PlanNumber = empBal.PlanNumber;

WITH cteOutlooks AS	(
	SELECT pInfo.CaseNumber
		  ,par.dimDateId
		  ,oInfo.dimOutlookForecastId
		  ,COUNT(DISTINCT par.dimUniqueSocialId) AS Outlooks
	FROM [TRS_BI_DataWarehouse].[usr].[ParticipantInfo] par WITH (NOLOCK)
		INNER JOIN [TRS_BI_DataWarehouse].[usr].[OutlookInfo] oInfo WITH (NOLOCK)
			ON par.dimOutlookId = oInfo.dimOutlookId
		   --AND oInfo.dimOutlookId != 0
		INNER JOIN #_EXMetrics cs
			ON 1 = 1
		INNER JOIN [TRS_BI_DataWarehouse].[usr].[PlanInfo] pInfo WITH (NOLOCK)
			ON par.dimPlanId = pInfo.dimPlanId
		   AND pInfo.CaseNumber = cs.PlanNumber
	WHERE par.dimDateId = @DimDateId
	  AND par.BalanceIndicator = 1
	  AND par.dimEmployerAccountId = 0
	GROUP BY pInfo.CaseNumber
			,par.dimDateId
			,oInfo.dimOutlookForecastId
)
,cteOnTrack AS (
	SELECT CaseNumber
		  ,SUM(CASE WHEN OutlookStatus = 'FAVORABLE' THEN Outlooks ELSE 0 END) AS OnTrack
		  ,SUM(CASE WHEN OutlookStatus = 'UNFAVORABLE' THEN Outlooks ELSE 0 END) AS NotOnTrack
		  ,SUM(CASE WHEN OutlookStatus = 'UNKNOWN' THEN Outlooks ELSE 0 END) AS Unknown
		  ,SUM(CASE WHEN OutlookStatus IN ('FAVORABLE','UNFAVORABLE') THEN Outlooks ELSE 0 END) AS TotalOutlooks
		  ,CASE WHEN SUM(CASE WHEN OutlookStatus IN ('FAVORABLE','UNFAVORABLE') THEN Outlooks ELSE 0 END) = 0 THEN 0
			    ELSE CAST(CAST(SUM(CASE WHEN OutlookStatus = 'FAVORABLE' THEN Outlooks ELSE 0 END) AS FLOAT) / CAST(SUM(CASE WHEN OutlookStatus IN ('FAVORABLE','UNFAVORABLE') THEN Outlooks ELSE 0 END) AS FLOAT) AS DECIMAL(15,2))
		   END AS OnTrackPercentage
	FROM cteOutlooks oData
		INNER JOIN [TRS_BI_DataWarehouse].[usr].[OutlookForecast] oForecast WITH (NOLOCK)
			ON oData.dimOutlookForecastId = oForecast.dimOutlookForecastId
	GROUP BY CaseNumber
)
--select * from cteOnTrack
UPDATE ex
SET ex.TotalOutlooks = ot.TotalOutlooks
   ,ex.OnTrackOutlooks = ot.OnTrack
   ,ex.UnknownOutlooks = ot.Unknown
   ,ex.OnTrackOutlookPercentage = ot.OnTrackPercentage
FROM #_EXMetrics ex
	INNER JOIN cteOnTrack ot
		ON ex.PlanNumber = ot.CaseNumber;

-- Final select
SELECT PlanNumber
      ,ContractNumber
      ,AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
      ,ISNULL(Participants, 0)
      ,ISNULL(ParticipantsActive, 0)
      ,ISNULL(ParticipantsTerminated, 0)
      ,ISNULL(TotalBalance, 0.00)
      ,ISNULL(AvgParticipantBalance, 0.00)
      --,EligibleEmployees
      --,ContributingEmployees
      --,NonContributingEmployees
      --,ParticipationRate
      --,AvgContributionRate
      --,AvgContributionAmount
      --,EmployeesNotReceivingMatch
      ,ISNULL(TotalOutlooks, 0)
      ,ISNULL(OnTrackOutlooks, 0)
	  ,ISNULL(UnknownOutlooks, 0)
      ,ISNULL(OnTrackOutlookPercentage, 0.00)
      ,ReportDate
FROM #_EXMetrics ex;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_ContributionPartDivisionLevel]    Script Date: 6/17/2021 11:04:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[usp_Source_ContributionPartDivisionLevel]
AS
SET NOCOUNT ON;

-------- Final Staging Table -----------
IF OBJECT_ID('tempdb..#_ContributionPartDivisionLevel', 'U') IS NOT NULL
	DROP TABLE #_ContributionPartDivisionLevel
CREATE TABLE #_ContributionPartDivisionLevel(
	CaseNumber VARCHAR(20) ,
	dimDateId INT ,
	dimParticipantId INT ,
	dimPlanId INT ,
	dimAgeId INT ,
	dimEmploymentStatusId INT ,
	dimEmployerAccountId INT ,
	SocialSecurityNumber VARCHAR(12) ,
	PreTaxEligible TINYINT ,
	BalanceIndicator TINYINT ,
	Balance DECIMAL(15, 2) ,
	ReportDate DATE ,
	PART_ENRL_I BIGINT ,
	DIV_I BIGINT ,
	MultiDivisionalParticipant VARCHAR(10) ,
	DivisionCode VARCHAR(15) ,
	DEF_P NUMERIC(38, 3) ,
	DEF_A NUMERIC(38, 2) ,
	AfterTax_A NUMERIC(38, 2) ,
	AfterTax_P NUMERIC(38, 3) ,
	PreTax_A NUMERIC(38, 2) ,
	PreTax_P NUMERIC(38, 3) ,
	Roth_A NUMERIC(38, 2) ,
	Roth_P NUMERIC(38, 3) ,
	ContributingFlag TINYINT
);

-----Select from Division, Participant, Contribution tables-------------
WITH cteDiv as (
		SELECT DISTINCT 
		par.dimParticipantId
	   ,par.PART_ENRL_I
	   ,par.MultiDivisionalParticipant
       ,a.DIV_I
	   --,b.dimPlanDivisionId   -- commented out by hz 12/6/2018
	   --,b.DivisionCode        -- commented out by hz 12/6/2018
	   ,a.EmployeeDivisionCode AS DivisionCode  -- added by hz 12/6/2018
FROM TRS_BI_Datawarehouse.dbo.dimParticipantDivision a WITH (NOLOCK)
		--INNER JOIN TRS_BI_Datawarehouse.dbo.dimPlanDivision b WITH (NOLOCK)  -- commented out by hz 12/6/2018
		--	ON a.DIV_I = b.DIV_I                                               -- commented out by hz 12/6/2018
		INNER JOIN WorkplaceExperience.ref.EXPlans c WITH (NOLOCK)
			ON a.CaseNumber=c.PlanNumber
		INNER JOIN TRS_BI_Datawarehouse.usr.Participant par
			ON a.dimParticipantId=par.dimParticipantId
		WHERE MultiDivisionIndicator = 'NO'
		OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'TERMED')
		OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'ACTIVE' AND DivisionEmploymentStatus = 'ACTIVE')
)
INSERT INTO #_ContributionPartDivisionLevel
SELECT
	--f.*   -- commented out by hz 12/6/2018
    f.CaseNumber
    ,f.dimDateId
	,f.dimParticipantId
    ,f.dimPlanId
    ,f.dimAgeId
    ,f.dimEmploymentStatusId
    ,f.dimEmployerAccountId
    ,f.SocialSecurityNumber
    ,f.PreTaxEligible
    ,f.BalanceIndicator
    ,f.Balance
    ,f.ReportDate
	,f.PART_ENRL_I
	,f.DIV_I
	,f.MultiDivisionalParticipant
	,f.DivisionCode

   /*  commented out by hz 12/6/2018
   ,b.DEF_P
   ,b.DEF_A
   ,b.AfterTax_A
   ,b.AfterTax_P
   ,b.PreTax_A
   ,b.PreTax_P
   ,b.Roth_A
   ,b.Roth_P
   ,CASE WHEN b.DEF_A IS NOT NULL OR b.DEF_P IS NOT NULL THEN 1 ELSE 0 END AS ContributingFlag
   */

   -- added below by hz 12/6/2018
   ,SUM(b.DEF_P) AS DEF_P
   ,SUM(b.DEF_A) AS DEF_A
   ,SUM(CASE WHEN b.TheType = 'AfterTax' THEN b.DEF_A END) AS AfterTax_A
   ,SUM(CASE WHEN b.TheType = 'AfterTax' THEN b.DEF_P END) AS AfterTax_P
   ,SUM(CASE WHEN b.TheType = 'PreTax' THEN b.DEF_A END) AS PreTax_A         
   ,SUM(CASE WHEN b.TheType = 'PreTax' THEN b.DEF_P END) AS PreTax_P
   ,SUM(CASE WHEN b.TheType = 'Roth' THEN b.DEF_A END) AS Roth_A 				  
   ,SUM(CASE WHEN b.TheType = 'Roth' THEN b.DEF_P END) AS Roth_P
   ,CASE WHEN SUM(b.DEF_A) > 0 OR SUM(b.DEF_P) >0 THEN 1 ELSE 0 END AS ContributingFlag
   -- end of added by hz 12/6/2018
FROM
(		
	SELECT 
		 a.CaseNumber
        ,a.dimDateId
		,a.dimParticipantId
        ,a.dimPlanId
        ,a.dimAgeId
        ,a.dimEmploymentStatusId
        ,a.dimEmployerAccountId
        ,a.SocialSecurityNumber
        ,a.PreTaxEligible
        ,a.BalanceIndicator
        ,a.Balance
        ,a.ReportDate
	    ,b.PART_ENRL_I
	    ,b.DIV_I
	    ,b.MultiDivisionalParticipant
	    ,b.DivisionCode
	FROM
		 temp.MetricsParticipantLevel a INNER JOIN cteDiv b on a.dimParticipantId=b.dimParticipantId
	WHERE a.dimEmployerAccountId=0
) f
OUTER APPLY 
( 
   /*  commented out by hz 12/6/2018
	  SELECT  df.CaseNumber
	         ,df.PART_ENRL_I
			 ,df.DIV_I
			 ,df.EFF_D	 
			 ,SUM(df.DEF_P) AS DEF_P
			 ,SUM(df.DEF_A) AS DEF_A
			 ,SUM(CASE WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType like '%Pre%' THEN df.DEF_P ELSE 0 END) AS PreTax_P
             ,SUM(CASE WHEN cs.direction = 'EMPLOYEE' AND cs.Roth = 'YES' THEN df.DEF_P ELSE 0 END) AS Roth_P  
	         ,SUM(CASE WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType like '%After%' THEN df.DEF_P ELSE 0 END) AS AfterTax_P
			 ,SUM(CASE WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType like '%Pre%' THEN df.DEF_A ELSE 0 END) AS PreTax_A
             ,SUM(CASE WHEN cs.direction = 'EMPLOYEE' AND cs.Roth = 'YES' THEN df.DEF_A ELSE 0 END) AS Roth_A  
	         ,SUM(CASE WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType like '%After%' THEN df.DEF_A ELSE 0 END) AS AfterTax_A
	  FROM ref.tab_factDeferral df WITH (NOLOCK)
	     INNER JOIN TRS_BI_DataWarehouse.dbo.dimContributionSource cs WITH (NOLOCK) ON cs.SRC_I = df.SRC_I
	   WHERE df.CaseNumber = f.CaseNumber
	       and df.PART_ENRL_I = f.PART_ENRL_I		  
	       AND df.DEF_GRP_NM NOT LIKE '%bonus%' AND df.DEF_GRP_NM NOT LIKE '%Annual%'  -- exclude bonus deferral. also include: incentive, performance?
		   AND df.EFF_D <= f.ReportDate
		   AND df.MonthEndFlag = 1	                     -- only keeps the last deferral records in a month
		   AND f.dimEmploymentStatusId = 1
		   AND (f.MultiDivisionalParticipant = 'NO' OR (f.MultiDivisionalParticipant = 'YES' AND f.DIV_I = df.DIV_I))  -- same division only if it's multiDivision		      		   
	   GROUP BY df.CaseNumber
	         ,df.PART_ENRL_I
			 ,df.DIV_I
			 ,df.EFF_D
	   ORDER BY df.EFF_D  DESC                  
	   OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY	  -- for each date on left side factParticipant table, only keep the most recent day's deferral records
   */
   SELECT TheType, DEF_P, DEF_A
   FROM
   ( 
	    SELECT 
			 
			 b.TheType

			 ,MAX(b.DEF_P) AS DEF_P
			 ,MAX(b.DEF_A) AS DEF_A	

			 ,ROW_NUMBER() OVER (PARTITION BY CaseNumber, PART_ENRL_I, b.TheType ORDER BY EFF_D DESC) AS row_id
	   
	     FROM WorkplaceExperience.ref.tab_factDeferral b WITH (NOLOCK)	
	     WHERE  f.PreTaxEligible = 1  
		    AND f.dimEmploymentStatusId = 1   -- added this as a workaround for the issue of PreTaxEligible=1 with terminated employment status. This excludes UNKNOWN status.
		    AND b.MonthEndFlag = 1
		    AND b.CaseNumber = f.CaseNumber 		   
		    AND  f.PART_ENRL_I = b.PART_ENRL_I
		    AND  f.dimDateId >= b.EffDateId	   
		    AND (f.MultiDivisionalParticipant = 'NO' OR (f.MultiDivisionalParticipant = 'YES' AND f.DIV_I = b.DIV_I))  -- same division only if it's multiDivision    
	     GROUP BY 
		     b.CaseNumber
	         ,b.PART_ENRL_I
			 ,CASE WHEN f.MultiDivisionalParticipant = 'YES' THEN b.DIV_I END
			 ,b.EFF_D
			 ,b.TheType
	 ) c
	 WHERE row_id = 1   
) b
GROUP BY     f.CaseNumber
    ,f.dimDateId
	,f.dimParticipantId
    ,f.dimPlanId
    ,f.dimAgeId
    ,f.dimEmploymentStatusId
    ,f.dimEmployerAccountId
    ,f.SocialSecurityNumber
    ,f.PreTaxEligible
    ,f.BalanceIndicator
    ,f.Balance
    ,f.ReportDate
	,f.PART_ENRL_I
	,f.DIV_I
	,f.MultiDivisionalParticipant
	,f.DivisionCode
;

-- Final select
SELECT CaseNumber
      ,dimDateId
      ,dimParticipantId
      ,dimPlanId
      ,dimAgeId
      ,dimEmploymentStatusId
      ,dimEmployerAccountId
      ,SocialSecurityNumber
      ,PreTaxEligible
      ,BalanceIndicator
      ,Balance
      ,ReportDate
      ,PART_ENRL_I
      ,DIV_I
      ,MultiDivisionalParticipant
      ,DivisionCode
      ,DEF_P
      ,DEF_A
      ,AfterTax_A
      ,AfterTax_P
      ,PreTax_A
      ,PreTax_P
      ,Roth_A
      ,Roth_P
      ,ContributingFlag
FROM #_ContributionPartDivisionLevel ex;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_EligibleEmployees]    Script Date: 6/17/2021 11:04:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[usp_Source_EligibleEmployees]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM [TRS_BI_DataWarehouse].[usr].[Balance]);

DECLARE @DimDateId INT = (SELECT dimDateId FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK) WHERE DateValue = @ReportDate);

IF OBJECT_ID('tempdb..#EXCase', 'U') IS NOT NULL
	DROP TABLE #EXCase
SELECT DISTINCT	
	   PlanNumber AS CaseNumber
INTO #EXCase
FROM [ref].[EXPlans] WITH (NOLOCK)
/*FROM [TRS_BI_DataWarehouse].[dbo].[dimPlan] WITH (NOLOCK)
WHERE ActiveRecordFlag = 1
	AND CaseStatus = 'ACTIVE'
	AND (ERName LIKE '%AgReliant Genetics%'
	OR ERName LIKE '%S Kitchen, inc%'
	OR ERName LIKE '%Essentia Health%'
	OR ERName LIKE '%Johns Hopkins%'
	OR ERName LIKE '%Mesirow Financial%'
	OR ERName LIKE '%Nintendo%'
	OR ERName LIKE '%Park Nicollet%'
	OR ERName LIKE '%Red Bull%'
	OR ERName LIKE '%Sumitomo%'
	OR ERName LIKE '%St Lukes Hospital of Kansas City%'
	OR ERName LIKE '%Versa Networks%'
	OR ERName LIKE '%Yakima Valley Memorial%'

	OR ERName LIKE '%TBC CORPORATION%'
	OR ERName LIKE '%HARTZ MOUNTAIN CORPORATION%'
	OR ERName LIKE '%SUNSTATE EQUIPMENT CO., LLC%'
	OR ERName LIKE '%ASCEND PERFORMANCE MATERIALS%'
	OR ERName LIKE '%ARCBEST CORPORATION%'
	OR ERName LIKE '%ABF FREIGHT SYSTEM, INC.%'
	OR (ERName LIKE '%ALL CHILDREN%' AND ERName LIKE '%S HEALTH SYSTEM, INC.%')
	OR ERName LIKE '%SUBURBAN HOSPITAL, INC.%'
	OR ERName LIKE '%HOWARD COUNTY GENERAL HOSPITAL, INC.%'
	OR ERName LIKE '%TCAS, INC.%'
	OR ERName LIKE '%SC RAIL LEASING AMERICA, INC.%'
	OR (ERName LIKE '%SAINT LUKE%' AND ERName LIKE '%S HEALTH SYSTEM%')
	OR (ERName LIKE '%ST. LUKE%' AND ERName LIKE '%S HEALTH VENTURES, INC.%')

	OR ERName LIKE '%Scottrade%'
);*/

-- This is all active employees on the plan
IF OBJECT_ID('tempdb..#EXPlanEmployees', 'U') IS NOT NULL
	DROP TABLE #EXPlanEmployees
SELECT a.dimParticipantId
	  ,a.SocialSecurityNumber
	  ,a.CaseNumber
	  ,a.PART_ENRL_I
	  ,a.HireDate
	  ,c.MultiPartDivision
	  ,b.DIV_I
	  ,b.dimParticipantDivisionId
	  ,d.dimUniqueSocialId
	  ,h.CLASS_I
INTO #EXPlanEmployees
FROM [TRS_BI_DataWarehouse].[dbo].[dimPlan] c WITH (NOLOCK)
	INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimParticipant] a  WITH (NOLOCK)
		ON a.CaseNumber = c.CaseNumber
	INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimParticipantDivision] b  WITH (NOLOCK)
		ON a.dimParticipantId = b.dimParticipantId
	INNER JOIN [TRS_BI_DataWarehouse].[dbo].[factParticipant] d  WITH (NOLOCK)
		ON a.dimParticipantId = d.dimParticipantId
	   AND c.dimPlanId = d.dimPlanId
	INNER JOIN #EXCase g
		ON c.CaseNumber = g.CaseNumber
	LEFT JOIN [TRS_BI_Staging].[dbo].[EMPLOYEE] h WITH (NOLOCK)
		ON h.CASE_NO = a.CaseNumber
	   AND h.SOC_SEC_NO = a.SocialSecurityNumber
WHERE d.dimDateId = @DimDateId
  AND d.dimEmployerAccountId = 0
  AND a.EmploymentStatus = 'ACTIVE'
  AND b.DivisionEmploymentStatus = 'ACTIVE'
  AND a.SocialSecurityNumber NOT LIKE '999%'
  AND a.LastName NOT LIKE 'ACCOUNT%'
  AND a.FirstName NOT LIKE 'ACCOUNT%'
  AND a.ParticipantStatus NOT IN ('ALTERNATE PAYEE','BENEFICIARY','DEATH');

-- Does TA outsource deferrals. Any Case_No not in this dataset, we are not outsourcing deferrals
IF OBJECT_ID('tempdb..#EXDeferralGroup', 'U') IS NOT NULL
	DROP TABLE #EXDeferralGroup
SELECT A.ACCOUNT_NO
      ,C.ENRL_PROV_GRP_I
      ,C.DEF_GRP_I
      ,C.SRC_I
      ,C.DEF_GRP_NM
      ,D.DOC_NM
	  ,D.SRC_TYP_C
INTO #EXDeferralGroup
FROM [TRS_BI_Staging].[dbo].[PLAN_PROV_GRP] A WITH (NOLOCK) 
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] B WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = B.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_DEFERRAL_GRP] C WITH (NOLOCK)
		ON B.PROVISION_I = C.DEF_GRP_I
	   AND A.ENRL_PROV_GRP_I = C.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_SRC_DETAIL] D WITH (NOLOCK)
		ON C.SRC_I = D.SRC_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] E WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = E.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[OUTSRC_SERVICE] F WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = E.ENRL_PROV_GRP_I
	   AND E.PROVISION_I = F.OUTSRC_I
	INNER JOIN [TRS_BI_Staging].[dbo].[OUTSRC_DEFERRAL] G WITH (NOLOCK)
		ON F.OUTSRC_I = G.OUTSRC_I
	INNER JOIN #EXCase as h
		ON A.ACCOUNT_NO = h.CaseNumber
WHERE E.PROV_TYP_C = 80
  AND F.SERV_TYP_C = 7
  AND F.SERV_OFFERING_C = '1'
  AND G.SERV_TYP_C = 7
  AND A.ENRL_STAT_C = 7
  AND B.RELATED_TYP_C IN (26,113)
  AND UPPER(C.DEF_GRP_NM) NOT LIKE '%BONUS%'
GROUP BY A.ACCOUNT_NO
		,C.ENRL_PROV_GRP_I
		,C.DEF_GRP_I
		,C.SRC_I
		,C.DEF_GRP_NM
		,D.DOC_NM
		,D.SRC_TYP_C;

-- Fetch the most recent deferral aount/percentage from staging tables
IF OBJECT_ID('tempdb..#EXPlanEmployeeDeferrals', 'U') IS NOT NULL
	DROP TABLE #EXPlanEmployeeDeferrals
SELECT ACCOUNT_NO
	  ,PART_ENRL_I
	  ,DIV_I
	  ,ENRL_PROV_GRP_I
	  ,DEF_GRP_I
	  ,SRC_I
	  ,SRC_TYP_C
	  ,EFF_D
	  ,DEF_P
	  ,DEF_A
	  ,Ranking
INTO #EXPlanEmployeeDeferrals
FROM (
	SELECT ACCOUNT_NO
		  ,PART_ENRL_I
		  ,DIV_I
		  ,ENRL_PROV_GRP_I
		  ,DEF_GRP_I
		  ,SRC_I
		  ,SRC_TYP_C
		  ,EFF_D
		  ,DEF_P
		  ,DEF_A
		  ,Ranking
	FROM (
		SELECT b.ACCOUNT_NO
			  ,a.PART_ENRL_I
			  ,a.DIV_I
			  ,b.ENRL_PROV_GRP_I
			  ,b.DEF_GRP_I
			  ,b.SRC_I
			  ,b.SRC_TYP_C
			  ,c.EFF_D
			  ,c.DEF_P
			  ,c.DEF_A
			  ,ROW_NUMBER() OVER(PARTITION BY b.ACCOUNT_NO, a.PART_ENRL_I, b.ENRL_PROV_GRP_I, b.DEF_GRP_I, b.SRC_I ORDER BY c.EFF_D DESC, c.MOD_TS DESC) AS [Ranking]
		FROM #EXPlanEmployees a
			INNER JOIN #EXDeferralGroup b
				ON a.CaseNumber = b.ACCOUNT_NO
			INNER JOIN [TRS_BI_Staging].[dbo].[PART_DEF_DATA] c WITH (NOLOCK)
				ON a.PART_ENRL_I = c.PART_ENRL_I
			   AND b.ENRL_PROV_GRP_I = c.ENRL_PROV_GRP_I
			   AND b.SRC_I = c.SRC_I
			   AND b.DEF_GRP_I = c.DEF_GRP_I
			   AND a.MultiPartDivision = 'NO'
			   AND c.EFF_D <= @ReportDate
	) a
	WHERE Ranking = 1
	UNION ALL
	SELECT ACCOUNT_NO
		  ,PART_ENRL_I
		  ,DIV_I
		  ,ENRL_PROV_GRP_I
		  ,DEF_GRP_I
		  ,SRC_I
		  ,SRC_TYP_C
		  ,EFF_D
		  ,DEF_P
		  ,DEF_A
		  ,Ranking
	FROM (
		SELECT b.ACCOUNT_NO
			  ,a.PART_ENRL_I
			  ,a.DIV_I
			  ,b.ENRL_PROV_GRP_I
			  ,b.DEF_GRP_I
			  ,b.SRC_I
			  ,b.SRC_TYP_C
			  ,c.EFF_D
			  ,c.DEF_P
			  ,c.DEF_A
			  ,ROW_NUMBER() OVER(PARTITION BY b.ACCOUNT_NO, a.PART_ENRL_I, b.ENRL_PROV_GRP_I, b.DEF_GRP_I, b.SRC_I ORDER BY c.EFF_D DESC, c.MOD_TS DESC) AS [Ranking]
		FROM #EXPlanEmployees a
			INNER JOIN #EXDeferralGroup b
				ON a.CaseNumber = b.ACCOUNT_NO
			INNER JOIN [TRS_BI_Staging].[dbo].[PART_DEF_DATA] c WITH (NOLOCK)
				ON a.PART_ENRL_I = c.PART_ENRL_I
			   AND b.ENRL_PROV_GRP_I = c.ENRL_PROV_GRP_I
			   AND b.SRC_I = c.SRC_I
			   AND b.DEF_GRP_I = c.DEF_GRP_I
			   AND a.DIV_I = c.DIV_I
			   AND a.MultiPartDivision = 'YES'
			   AND c.EFF_D <= @ReportDate
	) a
	WHERE Ranking = 1
) a;

-- Counting people with a positive deferral
IF OBJECT_ID('tempdb..#EXActiveWithDeferral', 'U') IS NOT NULL
	DROP TABLE #EXActiveWithDeferral
SELECT a.CaseNumber
	  ,a.dimParticipantId
	  ,a.dimUniqueSocialId
	  ,a.dimParticipantDivisionId
	  ,a.HireDate
	  ,a.SocialSecurityNumber
	  ,a.PART_ENRL_I
	  ,a.DEF_GRP_NM
	  ,a.SRC_I
	  ,a.SRC_TYP_C
	  ,a.CLASS_I
	  ,CASE WHEN b.DEF_P = 0 THEN NULL ELSE b.DEF_P END AS DEF_P
	  ,CASE WHEN b.DEF_A = 0 THEN NULL ELSE b.DEF_A END AS DEF_A
	  --,CASE WHEN a.DEF_P IS NOT NULL THEN a.dimParticipantId END AS DEFERRING_PERCENT
	  --,CASE WHEN a.DEF_A IS NOT NULL THEN a.dimParticipantId END AS DEFERRING_AMOUNT
INTO #EXActiveWithDeferral
FROM (
	SELECT a.CaseNumber
		  ,a.dimParticipantId
		  ,a.dimUniqueSocialId
		  ,a.dimParticipantDivisionId
		  ,a.HireDate
		  ,a.SocialSecurityNumber
		  ,a.PART_ENRL_I
		  ,a.DIV_I
		  ,a.CLASS_I
		  ,b.DEF_GRP_NM
		  ,b.ENRL_PROV_GRP_I
		  ,b.DEF_GRP_I
		  ,b.SRC_I
		  ,b.SRC_TYP_C
	FROM #EXPlanEmployees a
		INNER JOIN #EXDeferralGroup b
			ON a.CaseNumber = b.ACCOUNT_NO
	) a
	LEFT JOIN #EXPlanEmployeeDeferrals b
		ON a.ENRL_PROV_GRP_I = b.ENRL_PROV_GRP_I
		AND a.DIV_I = b.DIV_I
		AND a.PART_ENRL_I = b.PART_ENRL_I
		AND a.DEF_GRP_I = b.DEF_GRP_I
		AND a.SRC_I = b.SRC_I;

-- Figure out which classes of employees are eligible to particpate in the retirement plan
IF OBJECT_ID('tempdb..#EXPlanClassSourceEligibility', 'U') IS NOT NULL
	DROP TABLE #EXPlanClassSourceEligibility
SELECT C.ACCOUNT_NO
	  ,C.ENRL_PROV_GRP_I
	  ,D.SRC_I
	  ,D.SRC_TYP_C
	  ,M.CLASS_I
	  ,CASE	WHEN M.EXCLUSION_C = 0 THEN 'N' WHEN M.EXCLUSION_C = 1 THEN 'Y' END AS CLASS_EXCLUDED
	  ,LTRIM(RTRIM(LTRIM(RTRIM(d.REPORT_1_NM))+ ' ' + LTRIM(RTRIM(d.REPORT_2_NM)))) AS REPORT_NM
	  ,CASE WHEN K.SRC_I IS NOT NULL THEN 'Y' WHEN K.SRC_I IS NULL THEN 'N' END AS TRACKING_ELIGIBILITY
	  ,CASE WHEN A.DEFAULT_RULE_IND_C = 1 THEN 'Y' WHEN A.DEFAULT_RULE_IND_C = 0 THEN 'N' END AS DEFAULT_RULE_SET
	  ,T.HLP_TEXT AS MIN_AGE
	  ,SERV_REQ_C
	  ,U.HLP_VALUE AS ENTRY_CODE
	  --,D.SRC_S
	  --,D.ACTIVE_SRC_C
	  --,V.SRC_TYP_LONG_NM AS SOURCE_TYPE
	  --,D.DOC_NM
	  --,A.SERV_MOS_CT AS MONTH_SERVICE_REQ
	  --,A.SERV_DAYS_CT AS SERVICE_DAY_REQ
	  --,CASE WHEN A.YR_OF_SERV_HRS_CT = 9 THEN 0 ELSE A.YR_OF_SERV_HRS_CT END AS SERVICE_HOURS_REQ
	  --,A.ENTRY_DATE_C
	  --,U.HLP_TEXT AS ENTRY_DATE
	  --,N.CLASS_C
	  --,N.CLASS_NM
	  --,K.EFF_D
	  --,CASE WHEN J.OUTSRC_I IS NOT NULL AND K.SRC_I IS NOT NULL THEN P.HLP_TEXT ELSE '' END AS CLIENT_PROVIDING_FOR
	  --,O.CLIENT_PROVIDES_T AS OTHER_TEXT
	  --,K.SERV_LEV_C
	  --,Q.HLP_TEXT AS TRACKED_BY
	  --,R.HLP_TEXT AS REHIRE_TRACKING
	  --,S.HLP_TEXT AS SERVICE_REQUIREMENT
INTO #EXPlanClassSourceEligibility
FROM [TRS_BI_Staging].[dbo].[INIT_ELIG_RULES] A  WITH (NOLOCK)
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] B WITH (NOLOCK)
		ON A.INIT_ELIG_I = B.PROVISION_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROV_GRP] C WITH (NOLOCK)
		ON B.ENRL_PROV_GRP_I = C.ENRL_PROV_GRP_I
	   AND C.RELATED_GRP_TYP_C = 361
	INNER JOIN #EXCase z
		ON c.ACCOUNT_NO = z.CaseNumber
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_SRC_DETAIL] D WITH (NOLOCK)
		ON B.RELATED_I = D.SRC_I
	   AND DEFAULT_SRC_C = '1'
	   AND D.ACTIVE_SRC_C = 'A'
	LEFT JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] I WITH (NOLOCK)
		ON C.ENRL_PROV_GRP_I = I.ENRL_PROV_GRP_I
	   AND I.PROV_TYP_C = 80
	LEFT JOIN [TRS_BI_Staging].[dbo].[OUTSRC_SERVICE] J WITH (NOLOCK)
		ON I.PROVISION_I = J.OUTSRC_I
	   AND J.SERV_TYP_C = 0
	   AND J.SERV_OFFERING_C = '1'
	LEFT JOIN [TRS_BI_Staging].[dbo].[OUTSRC_ELIG_SRC] K WITH (NOLOCK)
		ON D.SRC_I = K.SRC_I
	   AND J.OUTSRC_I = K.OUTSRC_I
	   AND K.STAT_C = 1
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] L WITH (NOLOCK)
		ON C.ENRL_PROV_GRP_I = L.ENRL_PROV_GRP_I
	   AND A.INIT_ELIG_I = L.PROVISION_I
	   AND D.SRC_I = L.RELATED_I
	INNER JOIN [TRS_BI_Staging].[dbo].[CLASS_PROV_XREF] M WITH (NOLOCK)
		ON L.PROVISION_I = M.PROVISION_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_CLASS] N WITH (NOLOCK)
		ON M.CLASS_I = N.CLASS_I
	LEFT JOIN [TRS_BI_Staging].[dbo].[OUTSRC_ELIGIBILITY] O WITH (NOLOCK)
		ON J.OUTSRC_I = O.OUTSRC_I
	LEFT JOIN [TRS_BI_Staging].[dbo].[HELPER2] P WITH (NOLOCK)
		ON O.CLIENT_PROVIDES_C = P.HLP_VALUE
	   AND P.BUSINESS_LINE = 'CORP'
	   AND P.HLP_CODE = 'OUT_DATA'
	LEFT JOIN [TRS_BI_Staging].[dbo].[HELPER2] Q WITH (NOLOCK)
		ON K.SERV_LEV_C = Q.HLP_VALUE
	   AND Q.BUSINESS_LINE = 'CORP'
	   AND Q.HLP_CODE = 'OUTTRKBY'
	LEFT JOIN [TRS_BI_Staging].[dbo].[HELPER2] R WITH (NOLOCK)
		ON K.REHIRE_TRACKING_C = R.HLP_VALUE
	   AND R.BUSINESS_LINE = 'CORP'
	   AND R.HLP_CODE = 'OUTREHTK'
	LEFT JOIN [TRS_BI_Staging].[dbo].[HELPER2] S WITH (NOLOCK)
		ON A.SERV_REQ_C = S.HLP_VALUE
	   AND S.BUSINESS_LINE = 'CORP'
	   AND S.HLP_CODE = 'ELSRVREQ'
	LEFT JOIN [TRS_BI_Staging].[dbo].[HELPER2] T WITH (NOLOCK)
		ON A.MIN_AGE_C = T.HLP_VALUE
	   AND T.BUSINESS_LINE = 'CORP'
	   AND T.HLP_CODE = 'MIN_AGE'
	LEFT JOIN [TRS_BI_Staging].[dbo].[HELPER2] U WITH (NOLOCK)
		ON A.ENTRY_DATE_C = U.HLP_VALUE
	   AND U.BUSINESS_LINE = 'CORP'
	   AND U.HLP_CODE = 'ENT_DTCD'
	INNER JOIN [TRS_BI_Staging].[dbo].[CO_SOURCE] V WITH (NOLOCK)
		ON D.SRC_TYP_C = V.SRC_TYP_C
	   AND V.ROLLOVER_C = '0';

-- Figuring out if we outsource eligibility
IF OBJECT_ID('tempdb..#EXEligibilityCheck', 'U') IS NOT NULL
	DROP TABLE #EXEligibilityCheck
SELECT CLASS_I
	  ,SRC_I
	  ,'YES' AS TRACKED
INTO #EXEligibilityCheck
FROM #EXPlanClassSourceEligibility
WHERE CLASS_EXCLUDED = 'N'
  AND SRC_TYP_C IN (1,2,3,9,101,103,104)
  AND REPORT_NM NOT LIKE '%ROLL%'
  AND TRACKING_ELIGIBILITY = 'Y'

IF OBJECT_ID('tempdb..#EXImmediateCheck', 'U') IS NOT NULL
	DROP TABLE #EXImmediateCheck
SELECT CLASS_I
	  ,SRC_I
	  ,'YES' AS IMMEDIATELY
INTO #EXImmediateCheck
FROM #EXPlanClassSourceEligibility
WHERE CLASS_EXCLUDED = 'N'
  AND SRC_TYP_C IN (1,2,3,9,101,103,104)
  AND REPORT_NM NOT LIKE '%ROLL%'
  AND TRACKING_ELIGIBILITY = 'N'
  AND DEFAULT_RULE_SET = 'Y'	
  AND MIN_AGE = 'NO AGE'
  AND SERV_REQ_C = '0'
  AND ENTRY_CODE IN ('1','4','12');

--Figure out if we are going to use HireDate or go to PART_ELIG_SRC as the Plan Entry Date
IF OBJECT_ID('tempdb..#EXCheckSwitch', 'U') IS NOT NULL
	DROP TABLE #EXCheckSwitch
SELECT a.CaseNumber
	  ,a.dimParticipantId
	  ,a.dimUniqueSocialId
	  ,a.dimParticipantDivisionId
	  ,a.SocialSecurityNumber
	  ,a.HireDate
	  ,a.PART_ENRL_I
	  ,a.DEF_GRP_NM
	  ,a.CLASS_I
	  ,a.DEF_A
	  ,a.DEF_P
	  ,a.SRC_I
	  ,a.SRC_TYP_C
	  ,a.TRACKED
	  ,a.IMMEDIATELY
INTO #EXCheckSwitch
FROM (
	SELECT a.CaseNumber
		  ,a.dimParticipantId
		  ,a.dimUniqueSocialId
		  ,a.dimParticipantDivisionId
		  ,a.HireDate
		  ,a.SocialSecurityNumber
		  ,a.PART_ENRL_I
		  ,a.DEF_GRP_NM
		  ,a.CLASS_I
		  ,a.DEF_A
		  ,a.DEF_P
		  ,a.SRC_I
		  ,a.SRC_TYP_C
		  ,COALESCE(b.TRACKED, 'NO') AS TRACKED
		  ,COALESCE(c.IMMEDIATELY, 'NO') AS IMMEDIATELY
	FROM #EXActiveWithDeferral a
		LEFT JOIN #EXEligibilityCheck b
			ON a.CLASS_I = b.CLASS_I
		   AND a.SRC_I = b.SRC_I
		LEFT JOIN #EXImmediateCheck c
			ON a.CLASS_I = c.CLASS_I
		   AND a.SRC_I = c.SRC_I
) a;

-- Get PLAN_ENTRY_D
IF OBJECT_ID('tempdb..#EXParticipantDeferralElig', 'U') IS NOT NULL
	DROP TABLE #EXParticipantDeferralElig
SELECT a.CaseNumber
	  ,a.dimParticipantId
	  ,a.dimUniqueSocialId
	  ,a.dimParticipantDivisionId
	  ,a.HireDate
	  ,a.SocialSecurityNumber
	  ,a.PART_ENRL_I
	  ,a.DEF_GRP_NM
	  ,a.CLASS_I
	  ,a.DEF_A
	  ,a.DEF_P
	  ,a.SRC_I
	  ,a.SRC_TYP_C
	  ,a.TRACKED
	  ,a.IMMEDIATELY
	  ,c.PLAN_ENTRY_D
INTO #EXParticipantDeferralElig
FROM #EXCheckSwitch a
	LEFT JOIN [TRS_BI_Staging].[dbo].[PART_ELIG_SRC] c WITH (NOLOCK)
		ON a.PART_ENRL_I = c.PART_ENRL_I
	   AND a.SRC_I = c.SRC_I
	   AND c.PART_HIST_C = 0
	   AND c.STAT_C = 3;

-- For Roth we don't have a plan entry date in the actual table, so substituting the pre-tax date as the Roth plan entry date
IF OBJECT_ID('tempdb..#EXPreTaxEntry', 'U') IS NOT NULL
	DROP TABLE #EXPreTaxEntry
SELECT PART_ENRL_I
	  ,MIN(PLAN_ENTRY_D) AS PRE_TAX_DT	
INTO #EXPreTaxEntry
FROM #EXParticipantDeferralElig a
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_SRC_DETAIL] b WITH (NOLOCK)
		ON a.SRC_I  = b.SRC_I
	   AND b.SRC_TYP_C IN (3,9)
	   AND a.TRACKED = 'YES'
GROUP BY PART_ENRL_I;

-- For Roth we don't have a plan entry date in the actual table, so substituting the pre-tax date as the Roth plan entry date
IF OBJECT_ID('tempdb..#EXParticipantDeferralEligWithPre', 'U') IS NOT NULL
	DROP TABLE #EXParticipantDeferralEligWithPre
SELECT a.CaseNumber
	  ,a.dimParticipantId
	  ,a.dimUniqueSocialId
	  ,a.dimParticipantDivisionId
	  ,a.HireDate
	  ,a.SocialSecurityNumber
	  ,a.PART_ENRL_I
	  ,a.DEF_GRP_NM
	  ,a.CLASS_I
	  ,a.DEF_A
	  ,a.DEF_P
	  ,a.SRC_I
	  ,a.SRC_TYP_C
	  ,a.TRACKED
	  ,a.IMMEDIATELY
	  ,a.PLAN_ENTRY_D
	  ,b.PRE_TAX_DT
INTO #EXParticipantDeferralEligWithPre
FROM #EXParticipantDeferralElig a
	LEFT JOIN #EXPreTaxEntry b
		ON a.PART_ENRL_I = b.PART_ENRL_I;

-- Get eligible employees along with their deferrals
IF OBJECT_ID('tempdb..#EXTotalSet', 'U') IS NOT NULL
	DROP TABLE #EXTotalSet
SELECT CaseNumber
	  ,dimParticipantId
	  ,dimUniqueSocialId
	  ,dimParticipantDivisionId
	  ,SocialSecurityNumber
	  ,PART_ENRL_I
	  ,DEF_GRP_NM
	  ,DEF_A
	  ,DEF_P
	  ,@ReportDate AS ReportDate
INTO #EXTotalSet
FROM (		
	SELECT a.CaseNumber
		  ,a.dimParticipantId
		  ,a.dimUniqueSocialId
		  ,a.dimParticipantDivisionId
		  ,a.SocialSecurityNumber
		  ,a.PART_ENRL_I
		  ,a.DEF_GRP_NM
		  ,a.DEF_A
		  ,a.DEF_P
		  ,CASE WHEN a.SRC_TYP_C IN (102,18) AND a.TRACKED = 'NO' AND a.IMMEDIATELY = 'NO' AND a.PLAN_ENTRY_D IS NULL THEN a.PRE_TAX_DT
			    WHEN a.PLAN_ENTRY_D IS NOT NULL AND a.TRACKED = 'YES' THEN a.PLAN_ENTRY_D
			    WHEN a.PLAN_ENTRY_D IS NULL AND a.IMMEDIATELY = 'YES' THEN a.HireDate
				ELSE NULL
		   END AS PLAN_ENTRY_DATE
	FROM #EXParticipantDeferralEligWithPre a
) a
WHERE PLAN_ENTRY_DATE <= @ReportDate
  AND PLAN_ENTRY_DATE IS NOT NULL;

-- Final select
SELECT *
FROM #EXTotalSet;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_environment]    Script Date: 6/17/2021 11:04:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[usp_Source_environment]
AS
SET NOCOUNT ON;


Declare @serverenvironment varchar(100);

	 IF SERVERPROPERTY ('ServerName')='CRDBTTBISQLD01\SQL01'
			SET @serverenvironment='DEV'
ELSE IF SERVERPROPERTY ('ServerName')='CRDBTTBISQLT01\SQL01'
			SET @serverenvironment='TEST'
ELSE IF SERVERPROPERTY ('ServerName')='CRDBTTBISQLM01\SQL01'
			SET @serverenvironment='MODEL'
ELSE IF SERVERPROPERTY ('ServerName')='CRDBTTBISQLP03\SQL01'
			SET @serverenvironment='PROD'

IF OBJECT_ID('temp.dbenv','U') IS NOT NULL
	DROP TABLE temp.dbenv
SELECT @serverenvironment as serverenvironment,SERVERPROPERTY ('ServerName') as servername
	INTO temp.dbenv;

IF @serverenvironment IN ('DEV','TEST','MODEL')
	BEGIN
		EXEC usp_Translate_CaseNumbers;
		EXEC usp_Translate_PII;
	END
ELSE 
	BEGIN
		IF OBJECT_ID('temp.EXPlansEnv','U') IS NOT NULL
			DROP TABLE temp.EXPlansEnv
		SELECT PlanNumber
			  ,PlanNumber AS PlanNumberEnv
			  ,ContractNumber
			  ,AffiliateNumber
			  ,CURRENT_TIMESTAMP AS LoadDatetime
			  ,ContractNumber AS ContractNumberEnv
		INTO temp.EXPlansEnv
		FROM ref.EXPlans;
	END

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_FundPerformanceCaseLevel]    Script Date: 6/17/2021 11:04:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_FundPerformanceCaseLevel]
AS
SET NOCOUNT ON;

IF OBJECT_ID('tempdb..#_FundPerformanceCaseLevel', 'U') IS NOT NULL
	DROP TABLE #_FundPerformanceCaseLevel
	CREATE TABLE #_FundPerformanceCaseLevel (	
	dimPlanId BIGINT,
	PlanNumber VARCHAR(20),
	EnterpriseBusinessLine VARCHAR(10),
	AssetCategory VARCHAR(30),
	AssetClass VARCHAR(30),
	FundStyle VARCHAR(30),
	FundFamily VARCHAR(35),
	FundDescriptionCode VARCHAR(4) ,
	FundName VARCHAR(80),
	FundGroupCode VARCHAR(4),
	FundInceptionDate VARCHAR(10),
	FundBusinessLine VARCHAR(10),
	OneMonthPerformance FLOAT,
	ThreeMonthPerformance FLOAT,
	YTDPerformance FLOAT ,
	OneYearPerformance FLOAT ,
	ThreeYearPerformance FLOAT ,
	FiveYearPerformance FLOAT ,
	TenYearPerformance FLOAT ,
	FifteenYearPerformance FLOAT ,
	TwentyYearPerformance FLOAT ,
	PerformanceSinceInception FLOAT,
	NetExpenseRatio FLOAT ,
	GrossExpenseRatio FLOAT,
	ReportDate DATE
);

--------------DATES----------------

DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM TRS_BI_DataWarehouse.usr.Balance)
	   ,@NumberOfMonths INT = 5;

IF OBJECT_ID('tempdb..#_DateArray', 'U') IS NOT NULL
	DROP TABLE #_DateArray
CREATE TABLE #_DateArray (
	dimDateId INT
   ,ReportDate DATE
);
INSERT INTO #_DateArray
SELECT dimDateId
	  ,DateValue
FROM TRS_BI_DataWarehouse.usr.DateInfo WITH (NOLOCK)
WHERE DateValue = @ReportDate;

WITH CTE AS (
	SELECT @NumberOfMonths - 1 AS months
	UNION ALL 
	SELECT months - 1
	FROM CTE
	WHERE months > 0
)
INSERT INTO #_DateArray
SELECT dimDateId
	  ,DateValue
FROM TRS_BI_DataWarehouse.usr.DateInfo WITH (NOLOCK)
WHERE DateValue IN (
	SELECT DATEADD(DAY, -1, DATEADD(MONTH, -months, DATEADD(DAY, -(DAY(@ReportDate) - 1), @ReportDate))) AS DateValue
	FROM CTE
)
ORDER BY 1 DESC;

-------- FUNDPERFORMANCE DATE LEVEL TEMP--------------

IF OBJECT_ID('tempdb..#_FundPerformance', 'U') IS NOT NULL
  DROP TABLE #_FundPerformance
SELECT 
		 PlanNumber
		,EnterpriseBusinessLine
		,AssetCategory
		,AssetClass
		,FundStyle
		,FundFamily
		,FundDescriptionCode
		,FundName
		,FundGroupCode
		,FundInceptionDate
		,FundBusinessLine
		,OneMonthPerformance
		,ThreeMonthPerformance
		,YTDPerformance
		,OneYearPerformance
		,ThreeYearPerformance
		,FiveYearPerformance
		,TenYearPerformance
		,FifteenYearPerformance
		,TwentyYearPerformance
		,PerformanceSinceInception
		,NetExpenseRatio
		,GrossExpenseRatio
		,ReportDate
INTO #_FundPerformance
FROM (
		SELECT
				 fund_plans.CaseNumber AS PlanNumber
				,fund_plans.BUS_LINE as EnterpriseBusinessLine
				,fund_plans.AssetCategory
				,fund_plans.AssetClass
				,fund_plans.FundStyle
				,fund_plans.FundFamily
				,fd.FD_DESC_CD as FundDescriptionCode
				,fd.FD_NM as FundName
				,fd.FD_GROUP_CD as FundGroupCode
				,fd.FD_INCEPT_DT as FundInceptionDate
				,fd.BUSINESS_LINE as FundBusinessLine
				,FP_MTH_FCTR as OneMonthPerformance
				,FP_3MTHS_FCTR as ThreeMonthPerformance
				,FP_YTD_FCTR as YTDPerformance
				,FP_A_1YR_FCTR as OneYearPerformance
				,FP_A_3YRS_FCTR as ThreeYearPerformance
				,FP_A_5YRS_FCTR as FiveYearPerformance
				,FP_A_10YRS_FCTR as TenYearPerformance
				,FP_A_15YRS_FCTR as FifteenYearPerformance
				,FP_A_20YRS_FCTR as TwentyYearPerformance
				,FP_A_INCEPT_FCTR as PerformanceSinceInception
				,NET_EXPENS_RATIO as NetExpenseRatio
				,GROSS_EXPENS_RATIO as GrossExpenseRatio
				,fp.EFF_DT as ReportDate
				,ROW_NUMBER() OVER (PARTITION BY fund_plans.CaseNumber,fd.FD_DESC_CD order by fp.MOD_TS DESC) as LATEST_RECORD_NUMBER
		FROM TRS_BI_Staging.dbo.FP_FUND_DESC fd
		INNER JOIN TRS_BI_Staging.dbo.FP_PERFORM fp
				ON fd.fd_desc_cd = fp.fd_desc_cd
		INNER JOIN TRS_BI_DataWarehouse.dbo.dimDate dates
				ON fp.EFF_DT = dates.DateValue
		INNER JOIN TRS_BI_Staging.dbo.FP_FUND_EXPENSE fe
				ON fp.fd_desc_cd = fe.fd_desc_cd AND fp.EFF_DT = fe.EFF_DT
		INNER JOIN 
				(
						SELECT	bf.dimDateId,
						CaseNumber,
						FundDescription,
						df.BUS_LINE,
						df.AssetCategory,
						df.AssetClass,
						df.FundStyle,
						df.FundFamily
				FROM TRS_BI_DataWarehouse.usr.BalanceByFund bf
				INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan dp
						ON (bf.dimPlanId = dp.dimPlanId)
				INNER JOIN WorkplaceExperience.ref.Explans cases
						ON (dp.CaseNumber = cases.PlanNumber)
				INNER JOIN TRS_BI_Datawarehouse.dbo.dimFund df
						ON (bf.dimFundId = df.dimFundId)
				INNER JOIN #_DateArray dt
						ON  bf.dimDateId=dt.dimDateId
				WHERE df.FD_PROV_I <> -99999999999999999
				GROUP BY	bf.dimDateId,
							CaseNumber,
							FundDescription,
							df.BUS_LINE,
							df.AssetCategory,
							df.AssetClass,
							df.FundStyle,
							df.FundFamily
				) fund_plans
				ON fd.fd_desc_cd = fund_plans.FundDescription AND dates.dimDateId = fund_plans.dimDateId
		WHERE fe.EFF_DT >= CURRENT_TIMESTAMP - 365
		AND fp.EFF_DT >= CURRENT_TIMESTAMP - 365
		) fund_perform
WHERE LATEST_RECORD_NUMBER =1;

INSERT INTO #_FundPerformanceCaseLevel
SELECT
		 pInfo.dimPlanId
		,fp.PlanNumber
		,EnterpriseBusinessLine
		,AssetCategory
		,AssetClass
		,FundStyle
		,FundFamily
		,FundDescriptionCode
		,FundName
		,FundGroupCode
		,FundInceptionDate
		,FundBusinessLine
		,OneMonthPerformance
		,ThreeMonthPerformance
		,YTDPerformance
		,OneYearPerformance
		,ThreeYearPerformance
		,FiveYearPerformance
		,TenYearPerformance
		,FifteenYearPerformance
		,TwentyYearPerformance
		,PerformanceSinceInception
		,NetExpenseRatio
		,GrossExpenseRatio
		,ReportDate
FROM #_FundPerformance fp
INNER JOIN TRS_BI_DataWarehouse.usr.PlanInfo pInfo WITH (NOLOCK)
  ON (fp.PlanNumber = pInfo.CaseNumber)
WHERE pInfo.ActiveRecordFlag=1

-- Final select
SELECT dimPlanId  
	  ,env.PlanNumberEnv as PlanNumber
      ,EnterpriseBusinessLine
      ,AssetCategory
      ,AssetClass
      ,FundStyle
      ,FundFamily
      ,FundDescriptionCode
      ,FundName
      ,FundGroupCode
      ,FundInceptionDate
      ,FundBusinessLine
      ,OneMonthPerformance
      ,ThreeMonthPerformance
      ,YTDPerformance
      ,OneYearPerformance
      ,ThreeYearPerformance
      ,FiveYearPerformance
      ,TenYearPerformance
      ,FifteenYearPerformance
      ,TwentyYearPerformance
      ,PerformanceSinceInception
      ,NetExpenseRatio
      ,GrossExpenseRatio
      ,ReportDate
FROM #_FundPerformanceCaseLevel ex
INNER JOIN WorkplaceExperience.temp.EXPlansEnv env
    ON (ex.PlanNumber=env.PlanNumber);

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_LoansPartDivisionLevel]    Script Date: 6/17/2021 11:04:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_LoansPartDivisionLevel]
AS
SET NOCOUNT ON;


-------- Final Staging Table -----------

IF OBJECT_ID('tempdb..#_LoansPartDivisionLevel', 'U') IS NOT NULL
	DROP TABLE #_LoansPartDivisionLevel
CREATE TABLE #_LoansPartDivisionLevel(
	dimParticipantId BIGINT ,
	ActiveParticipant INT,
	TerminatedParticipant INT,
	SocialSecurityNumber VARCHAR(12),
	CaseNumber VARCHAR(30),
	DIV_I BIGINT,
	DivisionCode VARCHAR(30),
	ClosingLoanBalance DECIMAL(38, 2) ,
	LoanIssueDate DATE,
	ReportDate DATE ,
	LoanType VARCHAR(300),
	LoanStatus VARCHAR(100) ,
	LoanStatusDetail VARCHAR(300)
	);


DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM [TRS_BI_DataWarehouse].[usr].[Balance])
	   ,@NumberOfMonths INT = 5;

IF OBJECT_ID('tempdb..#_DateArray', 'U') IS NOT NULL
	DROP TABLE #_DateArray
CREATE TABLE #_DateArray (
	dimDateId INT
   ,ReportDate DATE
);

INSERT INTO #_DateArray
SELECT dimDateId
	  ,DateValue
FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK)
WHERE DateValue = @ReportDate;

WITH CTE AS (
	SELECT @NumberOfMonths - 1 AS months
	UNION ALL 
	SELECT months - 1
	FROM CTE
	WHERE months > 0
)
INSERT INTO #_DateArray
SELECT dimDateId
	  ,DateValue
FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK)
WHERE DateValue IN (
	SELECT DATEADD(DAY, -1, DATEADD(MONTH, -months, DATEADD(DAY, -(DAY(@ReportDate) - 1), @ReportDate))) AS DateValue
	FROM CTE
)
ORDER BY 1 DESC;

IF OBJECT_ID('tempdb..#_LoanStage', 'U') IS NOT NULL
  DROP TABLE #_LoanStage;

WITH tab_factLoan AS (
SELECT 
	   CASE WHEN t.StatementMessageCode IN (0, 2, 5) THEN 'Active'
	        WHEN t.StatementMessageCode = 4 THEN 'Deemed'
	   END AS LoanStatus,
	   n.LoanStatusDetail,
	   n.LoanCategory AS LoanType,
	   t.LoanTransactionDateId AS dimAsOfDateId,
	   n.LoanIssueDateId AS LoanIssueDateId,
	   t.dimPlanId,
	   CASE WHEN p.EmploymentStatus = 'ACTIVE' THEN 1 
	        WHEN p.EmploymentStatus = 'TERMED' THEN 0
	        ELSE -1 
	   END AS dimEmploymentStatusId,
	   t.dimParticipantId,
	   t.SocialSecurityNumber, 
	   COALESCE(CASE WHEN P.MultiDivisionalParticipant = 'YES' THEN n.DivisionCode 
	                 ELSE pd.EmployeeDivisionCode
	            END, '0') 
	   AS DivisionCode,
	   200 AS dimTransactionId,
	   t.LoanNumber,
	   CASE WHEN t.StatementMessageCode IN (0, 2, 5) THEN t.ClosingLoanBalance
	        WHEN t.StatementMessageCode = 4 THEN t.ClosingLoanBalance + t.AlternateRepaymentAmount1
	   END AS ClosingLoanBalance
  FROM TRS_BI_DataWarehouse.dbo.factLoanTransaction t WITH (NOLOCK)
  	INNER JOIN ref.EXPlans ex WITH (NOLOCK) 
		ON t.CaseNumber=ex.PlanNumber
	INNER JOIN #_DateArray dt 
		ON t.LoanTransactionDateId=dt.dimDateId
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipant p WITH (NOLOCK) 
		ON t.dimParticipantId = p.dimParticipantId
    LEFT JOIN TRS_BI_DataWarehouse.dbo.factLoan n WITH (NOLOCK) 
		ON t.LoanNumber = n.LoanNumber AND n.CaseNumber = t.CaseNumber 
		AND n.CaseNumber = ex.PlanNumber 
		AND dt.ReportDate BETWEEN n.EffectiveFrom AND COALESCE(n.EffectiveTo, '12/31/9999')
	LEFT JOIN TRS_BI_DataWarehouse.dbo.dimParticipantDivision pd WITH (NOLOCK) 
		ON pd.dimParticipantId = p.dimParticipantId
	  AND p.MultiDivisionalParticipant = 'NO'
	  AND NOT (p.MultiDivisionalParticipant = 'YES' AND p.EmploymentStatus = 'ACTIVE' AND pd.DivisionEmploymentStatus = 'TERMED')	  
	LEFT JOIN TRS_BI_DataWarehouse.dbo.dimPlanDivision pp WITH (NOLOCK) 
		ON pd.EmployeeDivisionCode = pp.DivisionCode AND pd.CaseNumber = pp.ACCOUNT_NO
  WHERE t.StatementMessageCode IN (0, 2, 5, 4)
)
SELECT 
		 dimParticipantId
		,SocialSecurityNumber
		,DivisionCode
		,CASE WHEN dimEmploymentStatusId = 1 THEN 1 ELSE 0 END AS ActiveParticipant
		,CASE WHEN dimEmploymentStatusId = 0 THEN 1 ELSE 0 END AS TerminatedParticipant
		,SUM(ClosingLoanBalance) AS ClosingLoanBalance
		,LoanIssueDateId
		,dimAsOfDateId
		,LoanType
		,LoanStatus
		,LoanStatusDetail
INTO #_LoanStage
FROM tab_factLoan a
WHERE 
		LoanStatus='Active' 
GROUP BY 
	     dimParticipantId
		,SocialSecurityNumber
		,DivisionCode
		,CASE WHEN dimEmploymentStatusId = 1 THEN 1 ELSE 0 END
		,CASE WHEN dimEmploymentStatusId = 0 THEN 1 ELSE 0 END
		,LoanIssueDateId
		,dimAsOfDateId
		,LoanType
		,LoanStatus
		,LoanStatusDetail;

INSERT INTO #_LoansPartDivisionLevel
SELECT
	     a.dimParticipantId
		,a.ActiveParticipant
		,a.TerminatedParticipant
		,a.SocialSecurityNumber
		,b.CaseNumber
		,NULL AS DIV_I
		,DivisionCode
		,ClosingLoanBalance
		,CONVERT(DATE,CAST(LoanIssueDateId AS VARCHAR),102) AS LoanIssueDate
		,CONVERT(DATE,CAST(dimAsOfDateId AS VARCHAR),102) AS ReportDate
		,LoanType
		,LoanStatus
		,LoanStatusDetail
FROM #_LoanStage a
INNER JOIN temp.MetricsParticipantLevel b
ON a.dimParticipantId=b.dimParticipantId and CONVERT(DATE,CAST(dimAsOfDateId AS VARCHAR),102)=b.ReportDate

-- Final select
SELECT	 dimParticipantId
		,ActiveParticipant
		,TerminatedParticipant
		,SocialSecurityNumber
		,CaseNumber
		,DIV_I
		,DivisionCode
		,ClosingLoanBalance
		,LoanIssueDate
		,ReportDate
		,LoanType
		,LoanStatus
		,LoanStatusDetail
FROM #_LoansPartDivisionLevel ex;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_MetricsCaseLevel]    Script Date: 6/17/2021 11:04:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_MetricsCaseLevel]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT MAX(ReportDate) FROM temp.MetricsParticipantLevel WITH (NOLOCK));

----- Final Staging Table ----
IF OBJECT_ID('tempdb..#_MetricsCaseLevel', 'U') IS NOT NULL
	DROP TABLE #_MetricsCaseLevel
CREATE TABLE #_MetricsCaseLevel (
	dimPlanId BIGINT,
	PlanNumber VARCHAR(20),
	ContractNumber VARCHAR(10) ,
	AffiliateNumber VARCHAR(10) ,
	CompanyName VARCHAR(161) ,
	PlanName VARCHAR(161) ,
	PlanType VARCHAR(80) ,
	PlanCategory VARCHAR(20) ,
	TotalParticipantCount INT,
	ActiveParticipantCount INT,
	TerminatedParticipantCount INT,
	TotalParticipantCountWithBalance INT,
	ActiveParticipantCountWithBalance INT,
	TerminatedParticipantCountWithBalance INT,
	ParticipationRate DECIMAL(15, 2),
	AvgContributionRate DECIMAL(15, 2),
	EligibleEmployeeCount INT,
	ContributingEmployeeCount INT,
	NonContributingEmployeeCount INT,
	AvgContributionAmount DECIMAL(38, 2),
	ActiveParticipantFundBalance DECIMAL(38, 2),
	TerminatedParticipantFundBalance DECIMAL(38, 2),
	AvgParticipantFundBalance DECIMAL(38, 2),
	AvgActiveParticipantFundBalance DECIMAL(38, 2),
	AvgTerminatedParticipantFundBalance DECIMAL(38, 2),
	ActiveParticipantCoreFunds DECIMAL(38, 2),
	TerminatedParticipantCoreFunds DECIMAL(38, 2),
	AvgParticipantCoreFund DECIMAL(38, 2),
	AvgActiveParticipantCoreFund DECIMAL(38, 2),
	AvgTerminatedParticipantCoreFund DECIMAL(38, 2),
	PCRA_Allowed_Flag BIT,
	ActiveParticipantPCRA DECIMAL(38, 2),
	TerminatedParticipantPCRA DECIMAL(38, 2),
	AvgParticipantPCRA DECIMAL(38, 2),
	AvgActiveParticipantPCRA DECIMAL(38, 2),
	AvgTerminatedParticipantPCRA DECIMAL(38, 2),
	SDB_Allowed_Flag BIT,
	ActiveParticipantSDB DECIMAL(38, 2),
	TerminatedParticipantSDB DECIMAL(38, 2),
	AvgParticipantSDB DECIMAL(38, 2),
	AvgActiveParticipantSDB DECIMAL(38, 2),
	AvgTerminatedParticipantSDB DECIMAL(38, 2),
	SuspenseBalance DECIMAL(38, 2) ,
	ForefeitureBalance DECIMAL(38, 2) ,
	ExpenseAccountBalance DECIMAL(38, 2) ,
	AdvancedEmployerBalance DECIMAL(38, 2) ,
	ActiveParticipantResidentialLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithResidentialLoanBalance INT ,
	ActiveParticipantResidentialHardshipLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithResidentialHardshipLoanBalance INT ,
	ActiveParticipantPersonalLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithPersonalLoanBalance INT ,
	ActiveParticipantPersonalHardshipLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithPersonalHardshipLoanBalance INT ,
	ActiveParticipantOtherLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithOtherLoanBalance INT ,
	TerminatedParticipantResidentialLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithResidentialLoanBalance INT ,
	TerminatedParticipantResidentialHardshipLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithResidentialHardshipLoanBalance INT ,
	TerminatedParticipantPersonalLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithPersonalLoanBalance INT ,
	TerminatedParticipantPersonalHardshipLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithPersonalHardshipLoanBalance INT ,
	TerminatedParticipantOtherLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithOtherLoanBalance INT ,
	LoanPermittedFlag BIT,
	ParticipantsPastDue INT ,
--	AutoRebalanceFlag INT,
--    AutoIncreaseFlag INT,
--    CustomPortfoliosFlag INT,
--    DCMAFlag INT,
--    FundTransferFlag INT,
--    PCRAFlag  INT,
--    PortfolioXpressFlag INT, 
--    SDAFlag INT,
--    SecurePathForLifeFlag INT,
	ReportDate DATE
);

------------ Staging tables for funds and balances -------------------

IF OBJECT_ID('tempdb..#Balances', 'U') IS NOT NULL
  DROP TABLE #Balances
SELECT
		 a.*
		,dp.EmploymentStatus
INTO #Balances
FROM     temp.BalanceByFundParticipantLevel	a
JOIN	 TRS_BI_DataWarehouse.dbo.dimParticipant dp
	ON	 a.dimParticipantId=dp.dimParticipantId

CREATE CLUSTERED INDEX IX_#Balances_main
    ON #Balances(CaseNumber,SocialSecurityNumber,dimParticipantId,dimFundId,EmploymentStatus,ReportDate); 

----------- Intermediate Staging tables for Participant Balances ------------
IF OBJECT_ID('tempdb..#_BalanceByParticipantStage', 'U') IS NOT NULL
	DROP TABLE #_BalanceByParticipantStage
SELECT   CaseNumber
		,SocialSecurityNumber
		,a.EmploymentStatus
		,SUM(a.Balance) as Balance
		,SUM(UnitCount) as UnitCount
		,ReportDate
INTO #_BalanceByParticipantStage
FROM	#Balances a
GROUP BY a.CaseNumber
		,a.SocialSecurityNumber
		,a.EmploymentStatus
		,a.ReportDate;

CREATE CLUSTERED INDEX IX_#_BalanceByParticipantStage_main
    ON #_BalanceByParticipantStage(CaseNumber,SocialSecurityNumber,EmploymentStatus,ReportDate); 

----------- Intermediate Staging tables for Funds ------------
IF OBJECT_ID('tempdb..#_BalanceStage', 'U') IS NOT NULL
	DROP TABLE #_BalanceStage
SELECT   COUNT(DISTINCT CASE WHEN a.Balance<>0 THEN a.SocialSecurityNumber END) AS ParticipantsWithFundBalance
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus = 'ACTIVE' AND a.Balance<>0 THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithFundBalance
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus != 'ACTIVE' AND a.Balance<>0 THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithFundBalance
		,a.CaseNumber
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.Balance ELSE 0 END) AS ActiveParticipantFundBalance
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.Balance ELSE 0 END) AS TerminatedParticipantFundBalance
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS ActiveParticipantUnitCount
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantUnitCount
		,a.ReportDate
INTO	 #_BalanceStage
FROM     #_BalanceByParticipantStage a
GROUP BY a.CaseNumber
		,a.ReportDate;

IF OBJECT_ID('tempdb..#_PCRAStage', 'U') IS NOT NULL
	DROP TABLE #_PCRAStage
SELECT   COUNT(DISTINCT a.SocialSecurityNumber) AS ParticipantsWithPCRA
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithPCRA
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithPCRA
		,a.CaseNumber
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.Balance ELSE 0 END) AS ActiveParticipantPCRA
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.Balance ELSE 0 END) AS TerminatedParticipantPCRA
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS ActiveParticipantPCRAUnitCount
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantPCRAUnitCount
		,a.ReportDate
INTO	 #_PCRAStage
FROM     #Balances a 
JOIN	 TRS_BI_DataWarehouse.usr.Fund f
	ON	 a.dimFundId=f.dimFundId
WHERE    f.FundStyle = 'SELF-DIRECTED'
AND      f.FundDescription = 'PCRA'
GROUP BY a.CaseNumber
		,a.ReportDate

IF OBJECT_ID('tempdb..#_SDBStage', 'U') IS NOT NULL
	DROP TABLE #_SDBStage
SELECT   COUNT(DISTINCT a.SocialSecurityNumber) AS ParticipantsWithSDB
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithSDB
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithSDB
		,a.CaseNumber
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.Balance ELSE 0 END) AS ActiveParticipantSDB
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.Balance ELSE 0 END) AS TerminatedParticipantSDB
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS ActiveParticipantSDBUnitCount
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantSDBUnitCount
		,a.ReportDate
INTO	 #_SDBStage
FROM     #Balances a 
JOIN	 TRS_BI_DataWarehouse.usr.Fund f
	ON	 a.dimFundId=f.dimFundId
WHERE    f.FundStyle = 'SELF-DIRECTED'
AND      f.FundDescription LIKE 'NMF%'
GROUP BY a.CaseNumber
		,a.ReportDate;

IF OBJECT_ID('tempdb..#CoreFundDim', 'U') IS NOT NULL
	DROP TABLE #CoreFundDim
SELECT	a.*
INTO	#CoreFundDim
FROM    #Balances a 
JOIN	 TRS_BI_DataWarehouse.usr.Fund f
	ON	 a.dimFundId=f.dimFundId
WHERE    f.FundStyle != 'SELF-DIRECTED'
OR	(	 f.FundStyle = 'SELF-DIRECTED'
AND      f.FundDescription NOT LIKE 'NMF%'
AND		 f.FundDescription <> 'PCRA')

IF OBJECT_ID('tempdb..#_CoreFundStage', 'U') IS NOT NULL
	DROP TABLE #_CoreFundStage
SELECT   COUNT(DISTINCT a.SocialSecurityNumber) AS ParticipantsWithCoreFunds
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithCoreFunds
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithCoreFunds
		,a.CaseNumber
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.Balance ELSE 0 END) AS ActiveParticipantCoreFunds
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.Balance ELSE 0 END) AS TerminatedParticipantCoreFunds
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS ActiveParticipantCoreFundUnitCount
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantCoreFundUnitCount
		,a.ReportDate
INTO	#_CoreFundStage
FROM    #CoreFundDim a
GROUP BY a.CaseNumber
		,a.ReportDate

----- Intermediate Staging Table for Case Metrics ----
IF OBJECT_ID('tempdb..#_MetricsCaseStage', 'U') IS NOT NULL
	DROP TABLE #_MetricsCaseStage
SELECT CaseNumber
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 THEN Balance ELSE 0.00 END) AS ParticipantBalance
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 1 THEN Balance ELSE 0.00 END) AS AdvanceEmployerBalance
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 2 THEN Balance ELSE 0.00 END) AS SuspenseBalance
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 3 THEN Balance ELSE 0.00 END) AS ForfeitureBalance
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 4 THEN Balance ELSE 0.00 END) AS ExpenseBudgetAccountBalance
	  ,SUM(CASE WHEN PreTaxEligible = 1 THEN 1 ELSE 0 END) AS EligibleEmployeeCount
	  ,ReportDate
INTO #_MetricsCaseStage
FROM temp.MetricsParticipantLevel WITH (NOLOCK)
GROUP BY CaseNumber
		,ReportDate;

IF OBJECT_ID('tempdb..#_PartMetricsStage', 'U') IS NOT NULL
	DROP TABLE #_PartMetricsStage
SELECT   COUNT(DISTINCT dp.SocialSecurityNumber) AS TotalParticipantCount
		,COUNT(DISTINCT CASE WHEN dp.EmploymentStatus = 'ACTIVE' THEN dp.SocialSecurityNumber END) AS ActiveParticipantCount
		,COUNT(DISTINCT CASE WHEN dp.EmploymentStatus != 'ACTIVE' THEN dp.SocialSecurityNumber END) AS TerminatedParticipantCount
		,dp.CaseNumber
INTO #_PartMetricsStage
FROM TRS_BI_DataWarehouse.dbo.dimParticipant dp WITH (NOLOCK)
INNER JOIN ref.EXPlans ex WITH (NOLOCK)
	ON	ex.PlanNumber=dp.CaseNumber
WHERE dp.ActiveRecordFlag=1
GROUP BY dp.CaseNumber

------- Intermediate Staging Table for Case Level Contributions -------
IF OBJECT_ID('tempdb..#_CaseContributionStage', 'U') IS NOT NULL
	DROP TABLE #_CaseContributionStage
SELECT
		 CaseNumber
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_P IS NOT NULL THEN SocialSecurityNumber END)),0) AS EmployeesContributingWithRate
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_A IS NOT NULL THEN SocialSecurityNumber END)),0) AS EmployeesContributingWithAmount
		,ISNULL(
			CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND (DEF_P IS NOT NULL OR DEF_A IS NOT NULL) THEN SocialSecurityNumber END ))>0 
				THEN 1 ElSE 0 END,0) AS ContributingFlag
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 THEN SocialSecurityNumber END)),0) AS ContributingEmployeeCount
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 THEN SocialSecurityNumber END)),0) AS EligibleEmployeeCount
		,CAST(CAST(ISNULL(SUM(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 THEN DEF_P ELSE 0 END),0) AS FLOAT)/
			 CAST((CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_P IS NOT NULL THEN SocialSecurityNumber END ))=0 THEN 1 
						ELSE COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_P IS NOT NULL THEN SocialSecurityNumber END )) 
							END) AS FLOAT) AS DECIMAL(15,2)) AS AverageContributionRate
		,CAST(CAST(ISNULL(SUM(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 THEN DEF_A ELSE 0 END),0) AS FLOAT)/
			 CAST((CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_A IS NOT NULL THEN SocialSecurityNumber END ))=0 THEN 1 
						ELSE COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_A IS NOT NULL THEN SocialSecurityNumber END )) 
							END) AS FLOAT) AS DECIMAL(15,2)) AS AverageContributionAmount
		,CAST(CAST(ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND (DEF_P IS NOT NULL OR DEF_A IS NOT NULL) THEN SocialSecurityNumber END ))*100,0) AS FLOAT)/
				CAST(CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 THEN SocialSecurityNumber END))=0 THEN 1 
					ELSE COUNT(DISTINCT(CASE WHEN PretaxEligible=1 THEN SocialSecurityNumber END)) END AS FLOAT) AS DECIMAL(15,2)) as ParticipationRate
		,ReportDate
INTO #_CaseContributionStage
FROM temp.ContributionPartDivisionLevel
GROUP BY CaseNumber
		,ReportDate;

------- Intermediate Staging Tables for Case Level Loans -------
IF OBJECT_ID('tempdb..#_CaseLoanStage', 'U') IS NOT NULL
	DROP TABLE #_CaseLoanStage
SELECT	 CaseNumber
      	,SUM(CASE WHEN LoanType = 'PERSONAL' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantPersonalLoanBalance
		,SUM(CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantPersonalHardshipLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantResidentialLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantResidentialHardshipLoanBalance
		,SUM(CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantOtherLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL' AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithPersonalLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithPersonalHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL' AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithResidentialLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithResidentialHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithOtherLoanBalance
      	,SUM(CASE WHEN LoanType = 'PERSONAL' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantPersonalLoanBalance
		,SUM(CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantPersonalHardshipLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantResidentialLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantResidentialHardshipLoanBalance
		,SUM(CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantOtherLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL' AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithPersonalLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithPersonalHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL' AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithResidentialLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithResidentialHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithOtherLoanBalance
		,ReportDate
  INTO #_CaseLoanStage
  FROM temp.LoansPartDivisionLevel
  GROUP BY
	   CaseNumber
      ,ReportDate;

--SELECT * FROM #_MetricsCaseStage
INSERT INTO #_MetricsCaseLevel
SELECT	 pln.dimPlanId AS dimPlanId
		,ex.PlanNumber AS PlanNumber
		,pln.ContractNumber AS ContractNumber
		,pln.AffiliateNumber AS AffiliateNumber
		,pln.CompanyName AS CompanyName
		,pln.PlanName AS PlanName
		,pln.PlanProductType AS PlanType
		,CASE WHEN pln.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Defined Benefit'
	  		ELSE 'Defined Contribution'
			END AS PlanCategory
		,ISNULL(pms.TotalParticipantCount, 0) AS TotalParticipantCount
		,ISNULL(pms.ActiveParticipantCount, 0) AS ActiveParticipantCount
		,ISNULL(pms.TerminatedParticipantCount, 0) AS TerminatedParticipantCount
		,ISNULL(bs.ParticipantsWithFundBalance, 0) AS TotalParticipantCountWithBalance
		,ISNULL(bs.ActiveParticipantsWithFundBalance, 0) AS ActiveParticipantCountWithBalance
		,ISNULL(bs.TerminatedParticipantsWithFundBalance, 0) AS TerminatedParticipantCountWithBalance
		,ISNULL(ccs.ParticipationRate,0.00) AS ParticipationRate 
		,ISNULL(ccs.AverageContributionRate,0.00) AS AvgContributionRate 
		,ISNULL(cs.EligibleEmployeeCount, 0) AS EligibleEmployeeCount
		,ISNULL(ccs.ContributingEmployeeCount, 0) AS ContributingEmployeeCount 
		,ISNULL(cs.EligibleEmployeeCount, 0)-ISNULL(ccs.ContributingEmployeeCount, 0) AS NonContributingEmployeeCount
		,ISNULL(ccs.AverageContributionAmount,0.00) AS AvgContributionAmount
		,ISNULL(bs.ActiveParticipantFundBalance, 0.00) AS ActiveParticipantFundBalance 
		,ISNULL(bs.TerminatedParticipantFundBalance, 0.00) AS TerminatedParticipantFundBalance 
		,ISNULL((bs.ActiveParticipantFundBalance+bs.TerminatedParticipantFundBalance)/
			(CASE WHEN bs.ActiveParticipantsWithFundBalance+bs.TerminatedParticipantsWithFundBalance=0 THEN 1
				ELSE bs.ActiveParticipantsWithFundBalance+bs.TerminatedParticipantsWithFundBalance END), 0.00) AS AvgParticipantFundBalance
		,ISNULL(bs.ActiveParticipantFundBalance/
			CASE WHEN bs.ActiveParticipantsWithFundBalance=0 THEN 1 ELSE bs.ActiveParticipantsWithFundBalance END , 0.00) AS AvgActiveParticipantFundBalance 
		,ISNULL(bs.TerminatedParticipantFundBalance/
			CASE WHEN bs.TerminatedParticipantsWithFundBalance=0 THEN 1 ELSE bs.TerminatedParticipantsWithFundBalance END, 0.00) AS AvgTerminatedParticipantFundBalance
		,ISNULL(cfs.ActiveParticipantCoreFunds, 0.00) AS ActiveParticipantCoreFunds 
		,ISNULL(cfs.TerminatedParticipantCoreFunds, 0.00) AS TerminatedParticipantCoreFunds 
		,ISNULL((cfs.ActiveParticipantCoreFunds+cfs.TerminatedParticipantCoreFunds)/
			(CASE WHEN cfs.ActiveParticipantsWithCoreFunds+cfs.TerminatedParticipantsWithCoreFunds=0 THEN 1
				ELSE cfs.ActiveParticipantsWithCoreFunds+cfs.TerminatedParticipantsWithCoreFunds END), 0.00) AS AvgParticipantCoreFund 
		,ISNULL(cfs.ActiveParticipantCoreFunds/
			CASE WHEN cfs.ActiveParticipantsWithCoreFunds=0 THEN 1 ELSE cfs.ActiveParticipantsWithCoreFunds END , 0.00) AS AvgActiveParticipantCoreFund 
		,ISNULL(cfs.TerminatedParticipantCoreFunds/
			CASE WHEN cfs.TerminatedParticipantsWithCoreFunds=0 THEN 1 ELSE cfs.TerminatedParticipantsWithCoreFunds END, 0.00) AS AvgTerminatedParticipantCoreFund 
		,ISNULL(cff.PCRA_Allowed_Flag,0) AS PCRA_Allowed_Flag
		,ISNULL(pcs.ActiveParticipantPCRA, 0.00) AS ActiveParticipantPCRA 
		,ISNULL(pcs.TerminatedParticipantPCRA, 0.00) AS TerminatedParticipantPCRA 
		,ISNULL((pcs.ActiveParticipantPCRA+pcs.TerminatedParticipantPCRA)/
			(CASE WHEN pcs.ActiveParticipantsWithPCRA+pcs.TerminatedParticipantsWithPCRA=0 THEN 1
				ELSE pcs.ActiveParticipantsWithPCRA+pcs.TerminatedParticipantsWithPCRA END), 0.00) AS AvgParticipantPCRA 
		,ISNULL(pcs.ActiveParticipantPCRA/
			CASE WHEN pcs.ActiveParticipantsWithPCRA=0 THEN 1 ELSE pcs.ActiveParticipantsWithPCRA END, 0.00) AS AvgActiveParticipantPCRA
		,ISNULL(pcs.TerminatedParticipantPCRA/
			CASE WHEN pcs.TerminatedParticipantsWithPCRA=0 THEN 1 ELSE pcs.TerminatedParticipantsWithPCRA END, 0.00) AS AvgTerminatedParticipantPCRA 
		,ISNULL(cff.SDB_Allowed_Flag,0) AS SDB_Allowed_Flag
		,ISNULL(sds.ActiveParticipantSDB, 0.00) AS ActiveParticipantSDB 
		,ISNULL(sds.TerminatedParticipantSDB, 0.00) AS TerminatedParticipantSDB 
		,ISNULL((sds.ActiveParticipantSDB+sds.TerminatedParticipantSDB)/
			(CASE WHEN sds.ActiveParticipantsWithSDB+sds.TerminatedParticipantsWithSDB=0 THEN 1
				ELSE sds.ActiveParticipantsWithSDB+sds.TerminatedParticipantsWithSDB END), 0.00) AS AvgParticipantSDB 
		,ISNULL(sds.ActiveParticipantSDB/
			CASE WHEN sds.ActiveParticipantsWithSDB=0 THEN 1 ELSE sds.ActiveParticipantsWithSDB END, 0.00) AS AvgActiveParticipantSDB 
		,ISNULL(sds.TerminatedParticipantSDB/
			CASE WHEN sds.TerminatedParticipantsWithSDB=0 THEN 1 ELSE sds.TerminatedParticipantsWithSDB END, 0.00) AS AvgTerminatedParticipantSDB 
		,ISNULL(cs.SuspenseBalance, 0.00) AS SuspenseBalance 
		,ISNULL(cs.ForfeitureBalance, 0.00) AS ForfeitureBalance 
		,ISNULL(cs.ExpenseBudgetAccountBalance, 0.00) AS ExpenseAccountBalance 
		,ISNULL(cs.AdvanceEmployerBalance, 0.00) AS AdvancedEmployerBalance 
		,ISNULL(cls.ActiveParticipantResidentialLoanBalance,0.00) AS ActiveParticipantResidentialLoanBalance
		,ISNULL(cls.ActiveParticipantsWithResidentialLoanBalance,0) AS ActiveParticipantsWithResidentialLoanBalance 
		,ISNULL(cls.ActiveParticipantResidentialHardshipLoanBalance,0.00) AS ActiveParticipantResidentialHardshipLoanBalance 
		,ISNULL(cls.ActiveParticipantsWithResidentialHardshipLoanBalance,0) AS ActiveParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(cls.ActiveParticipantPersonalLoanBalance,0.00) AS ActiveParticipantPersonalLoanBalance 
		,ISNULL(cls.ActiveParticipantsWithPersonalLoanBalance,0) AS ActiveParticipantsWithPersonalLoanBalance 
		,ISNULL(cls.ActiveParticipantPersonalHardshipLoanBalance,0.00) AS ActiveParticipantPersonalHardshipLoanBalance 
		,ISNULL(cls.ActiveParticipantsWithPersonalHardshipLoanBalance,0) AS ActiveParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(cls.ActiveParticipantOtherLoanBalance,0.00) AS ActiveParticipantOtherLoanBalance 
		,ISNULL(cls.ActiveParticipantsWithOtherLoanBalance,0) AS ActiveParticipantsWithOtherLoanBalance 
		,ISNULL(cls.TerminatedParticipantResidentialLoanBalance,0.00) AS TerminatedParticipantResidentialLoanBalance 
		,ISNULL(cls.TerminatedParticipantsWithResidentialLoanBalance,0) AS TerminatedParticipantsWithResidentialLoanBalance 
		,ISNULL(cls.TerminatedParticipantResidentialHardshipLoanBalance,0.00) AS TerminatedParticipantResidentialHardshipLoanBalance 
		,ISNULL(cls.TerminatedParticipantsWithResidentialHardshipLoanBalance,0) AS TerminatedParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(cls.TerminatedParticipantPersonalLoanBalance,0.00) AS TerminatedParticipantPersonalLoanBalance 
		,ISNULL(cls.TerminatedParticipantsWithPersonalLoanBalance,0) AS TerminatedParticipantsWithPersonalLoanBalance 
		,ISNULL(cls.TerminatedParticipantPersonalHardshipLoanBalance,0.00) AS TerminatedParticipantPersonalHardshipLoanBalance 
		,ISNULL(cls.TerminatedParticipantsWithPersonalHardshipLoanBalance,0) AS TerminatedParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(cls.TerminatedParticipantOtherLoanBalance,0.00) AS TerminatedParticipantOtherLoanBalance 
		,ISNULL(cls.TerminatedParticipantsWithOtherLoanBalance,0) AS TerminatedParticipantsWithOtherLoanBalance
		,CASE WHEN pln.LoanPermitted = 'YES' THEN 1 ELSE 0 END AS LoanPermittedFlag
		,0 AS ParticipantsPastDue
		,ISNULL(cs.ReportDate, @ReportDate) AS ReportDate
FROM ref.EXPlans ex WITH (NOLOCK)
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan pln WITH (NOLOCK)
		ON ex.PlanNumber = pln.CaseNumber
	   AND pln.ActiveRecordFlag = 1
	LEFT OUTER JOIN #_MetricsCaseStage cs WITH (NOLOCK)
		ON ex.PlanNumber = cs.CaseNumber
	LEFT OUTER JOIN #_CaseContributionStage ccs WITH (NOLOCK)
		ON ex.PlanNumber=ccs.CaseNumber and cs.ReportDate=ccs.ReportDate
	LEFT OUTER JOIN #_CaseLoanStage cls
		ON pln.CaseNumber=cls.CaseNumber and cs.ReportDate=cls.ReportDate
	LEFT OUTER JOIN #_PCRAStage pcs
		ON pln.CaseNumber=pcs.CaseNumber and cs.ReportDate=pcs.ReportDate
	LEFT OUTER JOIN #_BalanceStage bs
		ON pln.CaseNumber=bs.CaseNumber and cs.ReportDate=bs.ReportDate
	LEFT OUTER JOIN #_SDBStage sds
		ON pln.CaseNumber=sds.CaseNumber and cs.ReportDate=sds.ReportDate
	LEFT OUTER JOIN #_CoreFundStage cfs
		ON pln.CaseNumber=cfs.CaseNumber and cs.ReportDate=cfs.ReportDate
	LEFT OUTER JOIN #_PartMetricsStage pms
		ON pln.CaseNumber=pms.CaseNumber
	LEFT OUTER JOIN temp.CaseFundFlags cff
		ON pln.CaseNumber=cff.PlanNumber;

----- add the following for plan level flags:----
WITH ctePlanFlags AS
(
  SELECT ACCOUNT_NO, 
       [AUTO REBALANCE] AS AutoRebalance,                                                               
       [SELF DIRECTED ACCOUNT] AS SDA,                                                           
       [PORTFOLIO XPRESS] AS PortfolioXpress,                                                                
       [RECURRING FUND TRANSFERS] AS FundTransfer,                                                        
       [MANAGED ADVICE (DCMA)] AS DCMA,                                                           
       [PCRA] AS PCRA,                                                                            
       [SECUREPATH FOR LIFE] AS SecurePathForLife,                                                             
       [DEFERRAL AUTO INCREASE] AS AutoIncrease,                                                          
       [CUSTOM PORTFOLIOS] AS CustomPortfolios
  FROM [WorkplaceExperience].[ref].[tab_PlanFlags] sourceTable
    PIVOT(
           MIN([enabled]) FOR [Service] IN  ([AUTO REBALANCE],                                                               
                                             [SELF DIRECTED ACCOUNT],                                                           
                                             [PORTFOLIO XPRESS],                                                                
                                             [RECURRING FUND TRANSFERS],                                                        
                                             [MANAGED ADVICE (DCMA)],                                                           
                                             [PCRA],                                                                            
                                             [SECUREPATH FOR LIFE],                                                             
                                             [DEFERRAL AUTO INCREASE],                                                          
                                             [CUSTOM PORTFOLIOS])
     ) AS pivotTable    
)
SELECT ACCOUNT_NO
      ,COALESCE(p.AutoRebalance, 0) AS AutoRebalance
         ,COALESCE(p.AutoIncrease, 0) AS AutoIncrease
         ,COALESCE(p.CustomPortfolios, 0) AS CustomPortfolios
         ,COALESCE(p.DCMA, 0) AS DCMA
         ,COALESCE(p.FundTransfer, 0) AS FundTransfer
         ,COALESCE(p.PCRA, 0) AS PCRA
         ,COALESCE(p.PortfolioXpress, 0) AS PortfolioXpress
         ,COALESCE(p.SDA, 0) AS SDA
         ,COALESCE(p.SecurePathForLife, 0) AS SecurePathForLife
INTO #_planFlags
FROM ctePlanFlags p;


-- Final select
--INSERT INTO temp.MetricsCaseLevel
SELECT	 pl.planid AS dimPlanId 
		,env.PlanNumberEnv AS PlanNumber
		,env.ContractNumberEnv AS ContractNumber  
		,ex.AffiliateNumber 
		,CompanyName
		,PlanName 
		,PlanType
		,PlanCategory
		,TotalParticipantCount
		,ActiveParticipantCount
		,TerminatedParticipantCount
		,TotalParticipantCountWithBalance
		,ActiveParticipantCountWithBalance
		,TerminatedParticipantCountWithBalance
		,ParticipationRate 
		,AvgContributionRate 
		,EligibleEmployeeCount
		,ContributingEmployeeCount
		,NonContributingEmployeeCount
		,AvgContributionAmount
		,ActiveParticipantFundBalance
		,TerminatedParticipantFundBalance
		,AvgParticipantFundBalance
		,AvgActiveParticipantFundBalance
		,AvgTerminatedParticipantFundBalance
		,ActiveParticipantCoreFunds
		,TerminatedParticipantCoreFunds
		,AvgParticipantCoreFund
		,AvgActiveParticipantCoreFund
		,AvgTerminatedParticipantCoreFund
		,COALESCE(PCRA, 0) AS PCRA_Allowed_Flag 
		,ActiveParticipantPCRA 
		,TerminatedParticipantPCRA 
		,AvgParticipantPCRA 
		,AvgActiveParticipantPCRA
		,AvgTerminatedParticipantPCRA 
		,COALESCE(SDA, 0) AS SDB_Allowed_Flag 
		,ActiveParticipantSDB 
		,TerminatedParticipantSDB 
		,AvgParticipantSDB 
		,AvgActiveParticipantSDB 
		,AvgTerminatedParticipantSDB 
		,SuspenseBalance 
		,ForefeitureBalance 
		,ExpenseAccountBalance 
		,AdvancedEmployerBalance 
		,ActiveParticipantResidentialLoanBalance
		,ActiveParticipantsWithResidentialLoanBalance 
		,ActiveParticipantResidentialHardshipLoanBalance 
		,ActiveParticipantsWithResidentialHardshipLoanBalance 
		,ActiveParticipantPersonalLoanBalance 
		,ActiveParticipantsWithPersonalLoanBalance 
		,ActiveParticipantPersonalHardshipLoanBalance 
		,ActiveParticipantsWithPersonalHardshipLoanBalance 
		,ActiveParticipantOtherLoanBalance 
		,ActiveParticipantsWithOtherLoanBalance 
		,TerminatedParticipantResidentialLoanBalance 
		,TerminatedParticipantsWithResidentialLoanBalance 
		,TerminatedParticipantResidentialHardshipLoanBalance 
		,TerminatedParticipantsWithResidentialHardshipLoanBalance 
		,TerminatedParticipantPersonalLoanBalance 
		,TerminatedParticipantsWithPersonalLoanBalance 
		,TerminatedParticipantPersonalHardshipLoanBalance 
		,TerminatedParticipantsWithPersonalHardshipLoanBalance 
		,TerminatedParticipantOtherLoanBalance 
		,TerminatedParticipantsWithOtherLoanBalance
		,LoanPermittedFlag
		,ParticipantsPastDue
		,COALESCE(AutoRebalance, 0) AS AutoRebalanceFlag    -- add this and below for plan level flags
        ,COALESCE(AutoIncrease, 0) AS AutoIncreaseFlag
        ,COALESCE(CustomPortfolios, 0) AS CustomPortfoliosFlag
        ,COALESCE(DCMA, 0) AS DCMAFlag
        ,COALESCE(FundTransfer, 0) AS FundTransferFlag
        ,COALESCE(PCRA, 0) AS PCRAFlag
        ,COALESCE(PortfolioXpress, 0) AS PortfolioXpressFlag
        ,COALESCE(SDA, 0) AS SDAFlag
        ,COALESCE(SecurePathForLife, 0) AS SecurePathForLifeFlag
		,ReportDate
FROM #_MetricsCaseLevel ex
INNER JOIN temp.EXPlansEnv env
ON ex.PlanNumber=env.PlanNumber
INNER JOIN ex.plans_list pl
ON --ex.PlanNumber = pl.plannumber
  env.PlanNumberEnv  = pl.plannumber
LEFT JOIN #_planFlags f 
ON ex.PlanNumber = f.ACCOUNT_NO
;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_MetricsDivisionLevel]    Script Date: 6/17/2021 11:04:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_MetricsDivisionLevel]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT MAX(ReportDate) FROM temp.MetricsParticipantLevel WITH (NOLOCK));

----- Final Staging Table ----
IF OBJECT_ID('tempdb..#_MetricsDivisionLevel', 'U') IS NOT NULL
	DROP TABLE #_MetricsDivisionLevel
CREATE TABLE #_MetricsDivisionLevel (
	dimPlanId BIGINT,
	PlanNumber VARCHAR(20),
	ContractNumber VARCHAR(10) ,
	DivisionCode VARCHAR(20),
	DIV_I BIGINT,
	AffiliateNumber VARCHAR(10) ,
	CompanyName VARCHAR(161) ,
	PlanName VARCHAR(161) ,
	PlanType VARCHAR(80) ,
	PlanCategory VARCHAR(20) ,
	TotalParticipantCount INT,
	ActiveParticipantCount INT,
	TerminatedParticipantCount INT,
	ParticipationRate DECIMAL(15, 2),
	AvgContributionRate DECIMAL(15, 2),
	EligibleEmployeeCount INT,
	ContributingEmployeeCount INT,
	NonContributingEmployeeCount INT,
	AvgContributionAmount DECIMAL(38, 2),
	ActiveParticipantCoreFunds DECIMAL(38, 2),
	TerminatedParticipantCoreFunds DECIMAL(38, 2),
	AvgParticipantCoreFund DECIMAL(38, 2),
	AvgActiveParticipantCoreFund DECIMAL(38, 2),
	AvgTerminatedParticipantCoreFund DECIMAL(38, 2),
	PCRA_Allowed_Flag BIT,
	ActiveParticipantPCRA DECIMAL(38, 2),
	TerminatedParticipantPCRA DECIMAL(38, 2),
	AvgParticipantPCRA DECIMAL(38, 2),
	AvgActiveParticipantPCRA DECIMAL(38, 2),
	AvgTerminatedParticipantPCRA DECIMAL(38, 2),
	SDB_Allowed_Flag BIT,
	ActiveParticipantSDB DECIMAL(38, 2),
	TerminatedParticipantSDB DECIMAL(38, 2),
	AvgParticipantSDB DECIMAL(38, 2),
	AvgActiveParticipantSDB DECIMAL(38, 2),
	AvgTerminatedParticipantSDB DECIMAL(38, 2),
	SuspenseBalance DECIMAL(38, 2) ,
	ForefeitureBalance DECIMAL(38, 2) ,
	ExpenseAccountBalance DECIMAL(38, 2) ,
	AdvancedEmployerBalance DECIMAL(38, 2) ,
	ActiveParticipantResidentialLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithResidentialLoanBalance INT ,
	ActiveParticipantResidentialHardshipLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithResidentialHardshipLoanBalance INT ,
	ActiveParticipantPersonalLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithPersonalLoanBalance INT ,
	ActiveParticipantPersonalHardshipLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithPersonalHardshipLoanBalance INT ,
	ActiveParticipantOtherLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithOtherLoanBalance INT ,
	TerminatedParticipantResidentialLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithResidentialLoanBalance INT ,
	TerminatedParticipantResidentialHardshipLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithResidentialHardshipLoanBalance INT ,
	TerminatedParticipantPersonalLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithPersonalLoanBalance INT ,
	TerminatedParticipantPersonalHardshipLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithPersonalHardshipLoanBalance INT ,
	TerminatedParticipantOtherLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithOtherLoanBalance INT ,
	LoanPermittedFlag BIT,
	ParticipantsPastDue INT ,
	ReportDate DATE
);

-----------Plan-Division --------------------------------
IF OBJECT_ID('tempdb..#PlanDivision', 'U') IS NOT NULL
  DROP TABLE #PlanDivision;

WITH cteDiv AS (
SELECT DISTINCT 
		 a.CaseNumber
		,a.dimParticipantId
		,a.SocialSecurityNumber
		,a.DIV_I
		,b.DivisionCode
		,b.dimPlanDivisionId
		FROM TRS_BI_Datawarehouse.dbo.dimParticipantDivision a WITH (NOLOCK)
		INNER JOIN TRS_BI_Datawarehouse.dbo.dimPlanDivision b WITH (NOLOCK)
			ON a.DIV_I = b.DIV_I
		INNER JOIN WorkplaceExperience.ref.EXPlans c WITH (NOLOCK)
			ON a.CaseNumber=c.PlanNumber
		INNER JOIN TRS_BI_Datawarehouse.usr.Participant par
			ON a.dimParticipantId=par.dimParticipantId
		WHERE MultiDivisionIndicator = 'NO'
		OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'TERMED')
		OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'ACTIVE' AND DivisionEmploymentStatus = 'ACTIVE')
)
SELECT 
	 CaseNumber
	,SocialSecurityNumber
	,dimParticipantId
	,dimPlanDivisionId
	,DIV_I
	,DivisionCode
INTO #PlanDivision
FROM cteDiv

----------- Intermediate Staging tables for Funds ------------
IF OBJECT_ID('tempdb..#_PCRAStage', 'U') IS NOT NULL
	DROP TABLE #_PCRAStage
SELECT   COUNT(DISTINCT a.SocialSecurityNumber) AS ParticipantsWithPCRA
		,COUNT(DISTINCT CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithPCRA
		,COUNT(DISTINCT CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithPCRA
		,a.CaseNumber
		,cteDiv.DIV_I
		,cteDiv.DivisionCode
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN a.Balance ELSE 0 END) AS ActiveParticipantPCRA
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN a.Balance ELSE 0 END) AS TerminatedParticipantPCRA
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN a.UnitCount ELSE 0 END) AS ActiveParticipantPCRAUnitCount
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantPCRAUnitCount
		,a.ReportDate
INTO	 #_PCRAStage
FROM     temp.BalanceByFundParticipantLevel	a 
JOIN	 TRS_BI_DataWarehouse.usr.Fund f
	ON	 a.dimFundId=f.dimFundId
JOIN	 temp.MetricsParticipantLevel c
	ON	 a.dimParticipantId=c.dimParticipantId
	AND	 a.ReportDate=c.ReportDate
JOIN	 #PlanDivision cteDiv
	ON	 a.dimParticipantId=cteDiv.dimParticipantId
WHERE    f.FundStyle = 'SELF-DIRECTED'
AND      f.FundDescription = 'PCRA'
GROUP BY a.CaseNumber
		,cteDiv.DIV_I
		,cteDiv.DivisionCode
		,a.ReportDate

IF OBJECT_ID('tempdb..#_SDBStage', 'U') IS NOT NULL
	DROP TABLE #_SDBStage
SELECT   COUNT(DISTINCT a.SocialSecurityNumber) AS ParticipantsWithSDB
		,COUNT(DISTINCT CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithSDB
		,COUNT(DISTINCT CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithSDB
		,a.CaseNumber
		,cteDiv.DIV_I
		,cteDiv.DivisionCode
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN a.Balance ELSE 0 END) AS ActiveParticipantSDB
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN a.Balance ELSE 0 END) AS TerminatedParticipantSDB
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN a.UnitCount ELSE 0 END) AS ActiveParticipantSDBUnitCount
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantSDBUnitCount
		,a.ReportDate
INTO	 #_SDBStage
FROM     temp.BalanceByFundParticipantLevel	a 
JOIN	 TRS_BI_DataWarehouse.usr.Fund f
	ON	 a.dimFundId=f.dimFundId
JOIN	 temp.MetricsParticipantLevel c
	ON	 a.dimParticipantId=c.dimParticipantId
	AND	 a.ReportDate=c.ReportDate
JOIN	 #PlanDivision cteDiv
	ON	 a.dimParticipantId=cteDiv.dimParticipantId
WHERE    f.FundStyle = 'SELF-DIRECTED'
AND      f.FundDescription LIKE 'NMF%'
GROUP BY a.CaseNumber
		,cteDiv.DIV_I
		,cteDiv.DivisionCode
		,a.ReportDate

IF OBJECT_ID('tempdb..#_CoreFundStage', 'U') IS NOT NULL
	DROP TABLE #_CoreFundStage
SELECT   COUNT(DISTINCT a.SocialSecurityNumber) AS ParticipantsWithCoreFunds
		,COUNT(DISTINCT CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithCoreFunds
		,COUNT(DISTINCT CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithCoreFunds
		,a.CaseNumber
		,cteDiv.DIV_I
		,cteDiv.DivisionCode
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN a.Balance ELSE 0 END) AS ActiveParticipantCoreFunds
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN a.Balance ELSE 0 END) AS TerminatedParticipantCoreFunds
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN a.UnitCount ELSE 0 END) AS ActiveParticipantCoreFundUnitCount
		,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantCoreFundUnitCount
		,a.ReportDate
INTO	#_CoreFundStage
FROM     temp.BalanceByFundParticipantLevel	a 
JOIN	 TRS_BI_DataWarehouse.usr.Fund f
	ON	 a.dimFundId=f.dimFundId
JOIN	 temp.MetricsParticipantLevel c
	ON	 a.dimParticipantId=c.dimParticipantId
	AND	 a.ReportDate=c.ReportDate
JOIN	 #PlanDivision cteDiv
	ON	 a.dimParticipantId=cteDiv.dimParticipantId
WHERE    f.FundStyle != 'SELF-DIRECTED'
GROUP BY a.CaseNumber
		,cteDiv.DIV_I
		,cteDiv.DivisionCode
		,a.ReportDate

----- Intermediate Staging Table Division Level Metrics----
IF OBJECT_ID('tempdb..#_MetricsCaseDivisionStage', 'U') IS NOT NULL
	DROP TABLE #_MetricsCaseDivisionStage
SELECT
	   par.CaseNumber
	  ,cd.DIV_I
	  ,cd.DivisionCode
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 THEN Balance ELSE 0.00 END) AS ParticipantBalance
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 1 THEN 1 ELSE 0 END) AS ActiveParticipantCount
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId = 2 THEN 1 ELSE 0 END) AS TerminatedParticipantCount
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId IN (1,2) THEN 1 ELSE 0 END) AS TotalParticipantCount
	  ,CASE WHEN SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId IN (1,2) THEN 1 ELSE 0 END) = 0 THEN 0
		  ELSE CAST(CAST(SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 THEN Balance ELSE 0.00 END) AS FLOAT) 
			  / CAST(SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId IN (1,2) THEN 1 ELSE 0 END) AS FLOAT) AS DECIMAL(15,2))
	   END AS AvgParticipantBalance
	  ,SUM(CASE WHEN PreTaxEligible = 1 THEN 1 ELSE 0 END) AS EligibleEmployeeCount
	  ,ReportDate
INTO #_MetricsCaseDivisionStage
FROM WorkplaceExperience.temp.MetricsParticipantLevel par WITH (NOLOCK)
INNER JOIN #PlanDivision cd
	  ON (cd.dimParticipantId=par.dimParticipantId)
group by 
	  par.CaseNumber,
	  cd.DIV_I,
	  cd.DivisionCode,
	  par.ReportDate;

----- Intermediate Staging Table Case Level Metrics----
IF OBJECT_ID('tempdb..#_MetricsCaseStage', 'U') IS NOT NULL
	DROP TABLE #_MetricsCaseStage
SELECT
	   par.CaseNumber
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 1 THEN Balance ELSE 0.00 END) AS AdvanceEmployerBalance
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 2 THEN Balance ELSE 0.00 END) AS SuspenseBalance
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 3 THEN Balance ELSE 0.00 END) AS ForfeitureBalance
	  ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 4 THEN Balance ELSE 0.00 END) AS ExpenseBudgetAccountBalance
	  ,ReportDate
INTO #_MetricsCaseStage
FROM WorkplaceExperience.temp.MetricsParticipantLevel par WITH (NOLOCK)
group by 
	  par.CaseNumber,
	  par.ReportDate;

-----Intermediate Staging Table Contributions --------
IF OBJECT_ID('tempdb..#_DivisionContributionStage', 'U') IS NOT NULL
	DROP TABLE #_DivisionContributionStage
SELECT
		 CaseNumber
	    ,ISNULL(DIV_I,0) AS DIV_I
		,ISNULL(DivisionCode,0) AS DivisionCode
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_P IS NOT NULL THEN SocialSecurityNumber END)),0) AS EmployeesContributingWithRate
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_A IS NOT NULL THEN SocialSecurityNumber END)),0) AS EmployeesContributingWithAmount
		,ISNULL(
			CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND (DEF_P IS NOT NULL OR DEF_A IS NOT NULL) THEN SocialSecurityNumber END ))>0 
				THEN 1 ElSE 0 END,0) AS ContributingFlag
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 THEN SocialSecurityNumber END)),0) AS ContributingEmployeeCount
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 THEN SocialSecurityNumber END)),0) AS EligibleEmployeeCount
		,CAST(CAST(ISNULL(SUM(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 THEN DEF_P ELSE 0 END),0) AS FLOAT)/
			 CAST((CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_P IS NOT NULL THEN SocialSecurityNumber END ))=0 THEN 1 
						ELSE COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_P IS NOT NULL THEN SocialSecurityNumber END )) 
							END) AS FLOAT) AS DECIMAL(15,2)) AS AverageContributionRate
		,CAST(CAST(ISNULL(SUM(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 THEN DEF_A ELSE 0 END),0) AS FLOAT)/
			 CAST((CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_A IS NOT NULL THEN SocialSecurityNumber END ))=0 THEN 1 
						ELSE COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_A IS NOT NULL THEN SocialSecurityNumber END )) 
							END) AS FLOAT) AS DECIMAL(15,2)) AS AverageContributionAmount
		,CAST(CAST(ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND (DEF_P IS NOT NULL OR DEF_A IS NOT NULL) THEN SocialSecurityNumber END ))*100,0) AS FLOAT)/
				CAST(CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 THEN SocialSecurityNumber END))=0 THEN 1 
					ELSE COUNT(DISTINCT(CASE WHEN PretaxEligible=1 THEN SocialSecurityNumber END)) END AS FLOAT) AS DECIMAL(15,2)) as ParticipationRate
		,ReportDate
INTO #_DivisionContributionStage
FROM temp.ContributionPartDivisionLevel
GROUP BY CaseNumber
		,DIV_I
		,DivisionCode
		,ReportDate;


------- Intermediate Staging Tables for Division Level Loans -------
IF OBJECT_ID('tempdb..#_DivisionLoanStage', 'U') IS NOT NULL
	DROP TABLE #_DivisionLoanStage
SELECT	 CaseNumber
		,DIV_I
		,DivisionCode
      	,SUM(CASE WHEN LoanType = 'PERSONAL' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantPersonalLoanBalance
		,SUM(CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantPersonalHardshipLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantResidentialLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantResidentialHardshipLoanBalance
		,SUM(CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantOtherLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL' AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithPersonalLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithPersonalHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL' AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithResidentialLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithResidentialHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND ActiveParticipant=1 THEN SocialSecurityNumber END) AS ActiveParticipantsWithOtherLoanBalance
      	,SUM(CASE WHEN LoanType = 'PERSONAL' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantPersonalLoanBalance
		,SUM(CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantPersonalHardshipLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantResidentialLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantResidentialHardshipLoanBalance
		,SUM(CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantOtherLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL' AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithPersonalLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithPersonalHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL' AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithResidentialLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithResidentialHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND TerminatedParticipant=1 THEN SocialSecurityNumber END) AS TerminatedParticipantsWithOtherLoanBalance
		,ReportDate
  INTO #_DivisionLoanStage
  FROM temp.LoansPartDivisionLevel
  GROUP BY
	   CaseNumber
	  ,DIV_I
	  ,DivisionCode
      ,ReportDate;

-- FINAL STAGING TABLE
INSERT INTO #_MetricsDivisionLevel
SELECT	 pln.dimPlanId
		,ex.PlanNumber
		,pln.ContractNumber
		,cds.DivisionCode
		,cds.DIV_I
		,pln.AffiliateNumber
		,pln.CompanyName
		,pln.PlanName
		,pln.PlanProductType AS PlanType
		,CASE WHEN pln.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Defined Benefit'
	  		ELSE 'Defined Contribution'
			END AS PlanCategory
		,ISNULL(cds.TotalParticipantCount, 0) AS TotalParticipantCount
		,ISNULL(cds.ActiveParticipantCount, 0) AS ActiveParticipantCount
		,ISNULL(cds.TerminatedParticipantCount, 0) AS TerminatedParticipantCount
		,ISNULL(dcs.ParticipationRate,0.00) AS ParticipationRate 
		,ISNULL(dcs.AverageContributionRate,0.00) AS AvgContributionRate 
		,ISNULL(dcs.EligibleEmployeeCount, 0) AS EligibleEmployeeCount
		,ISNULL(dcs.ContributingEmployeeCount, 0) AS ContributingEmployeeCount 
		,ISNULL(dcs.EligibleEmployeeCount, 0)-ISNULL(dcs.ContributingEmployeeCount, 0) AS NonContributingEmployeeCount
		,ISNULL(dcs.AverageContributionAmount,0.00) AS AvgContributionAmount
		,ISNULL(cfs.ActiveParticipantCoreFunds, 0.00) AS ActiveParticipantCoreFunds 
		,ISNULL(cfs.TerminatedParticipantCoreFunds, 0.00) AS TerminatedParticipantCoreFunds 
		,ISNULL((cfs.ActiveParticipantCoreFunds+cfs.TerminatedParticipantCoreFunds)/
			(CASE WHEN cfs.ActiveParticipantsWithCoreFunds+cfs.TerminatedParticipantsWithCoreFunds=0 THEN 1
				ELSE cfs.ActiveParticipantsWithCoreFunds+cfs.TerminatedParticipantsWithCoreFunds END), 0.00) AS AvgParticipantCoreFund 
		,ISNULL(cfs.ActiveParticipantCoreFunds/
			CASE WHEN cfs.ActiveParticipantsWithCoreFunds=0 THEN 1 ELSE cfs.ActiveParticipantsWithCoreFunds END , 0.00) AS AvgActiveParticipantCoreFund 
		,ISNULL(cfs.TerminatedParticipantCoreFunds/
			CASE WHEN cfs.TerminatedParticipantsWithCoreFunds=0 THEN 1 ELSE cfs.TerminatedParticipantsWithCoreFunds END, 0.00) AS AvgTerminatedParticipantCoreFund 
		,ISNULL(cff.PCRA_Allowed_Flag,0) AS PCRA_Allowed_Flag
		,ISNULL(pcs.ActiveParticipantPCRA, 0.00) AS ActiveParticipantPCRA 
		,ISNULL(pcs.TerminatedParticipantPCRA, 0.00) AS TerminatedParticipantPCRA 
		,ISNULL((pcs.ActiveParticipantPCRA+pcs.TerminatedParticipantPCRA)/
			(CASE WHEN pcs.ActiveParticipantsWithPCRA+pcs.TerminatedParticipantsWithPCRA=0 THEN 1
				ELSE pcs.ActiveParticipantsWithPCRA+pcs.TerminatedParticipantsWithPCRA END), 0.00) AS AvgParticipantPCRA 
		,ISNULL(pcs.ActiveParticipantPCRA/
			CASE WHEN pcs.ActiveParticipantsWithPCRA=0 THEN 1 ELSE pcs.ActiveParticipantsWithPCRA END, 0.00) AS AvgActiveParticipantPCRA
		,ISNULL(pcs.TerminatedParticipantPCRA/
			CASE WHEN pcs.TerminatedParticipantsWithPCRA=0 THEN 1 ELSE pcs.TerminatedParticipantsWithPCRA END, 0.00) AS AvgTerminatedParticipantPCRA 
		,ISNULL(cff.SDB_Allowed_Flag,0) AS SDB_Allowed_Flag
		,ISNULL(sds.ActiveParticipantSDB, 0.00) AS ActiveParticipantSDB 
		,ISNULL(sds.TerminatedParticipantSDB, 0.00) AS TerminatedParticipantSDB 
		,ISNULL((sds.ActiveParticipantSDB+sds.TerminatedParticipantSDB)/
			(CASE WHEN sds.ActiveParticipantsWithSDB+sds.TerminatedParticipantsWithSDB=0 THEN 1
				ELSE sds.ActiveParticipantsWithSDB+sds.TerminatedParticipantsWithSDB END), 0.00) AS AvgParticipantSDB 
		,ISNULL(sds.ActiveParticipantSDB/
			CASE WHEN sds.ActiveParticipantsWithSDB=0 THEN 1 ELSE sds.ActiveParticipantsWithSDB END, 0.00) AS AvgActiveParticipantSDB 
		,ISNULL(sds.TerminatedParticipantSDB/
			CASE WHEN sds.TerminatedParticipantsWithSDB=0 THEN 1 ELSE sds.TerminatedParticipantsWithSDB END, 0.00) AS AvgTerminatedParticipantSDB
		,ISNULL(cs.SuspenseBalance, 0.00) AS SuspenseBalance 
		,ISNULL(cs.ForfeitureBalance, 0.00) AS ForfeitureBalance 
		,ISNULL(cs.ExpenseBudgetAccountBalance, 0.00) AS ExpenseAccountBalance 
		,ISNULL(cs.AdvanceEmployerBalance, 0.00) AS AdvancedEmployerBalance 
		,ISNULL(dls.ActiveParticipantResidentialLoanBalance,0.00) AS ActiveParticipantResidentialLoanBalance
		,ISNULL(dls.ActiveParticipantsWithResidentialLoanBalance,0) AS ActiveParticipantsWithResidentialLoanBalance 
		,ISNULL(dls.ActiveParticipantResidentialHardshipLoanBalance,0.00) AS ActiveParticipantResidentialHardshipLoanBalance 
		,ISNULL(dls.ActiveParticipantsWithResidentialHardshipLoanBalance,0) AS ActiveParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(dls.ActiveParticipantPersonalLoanBalance,0.00) AS ActiveParticipantPersonalLoanBalance 
		,ISNULL(dls.ActiveParticipantsWithPersonalLoanBalance,0) AS ActiveParticipantsWithPersonalLoanBalance 
		,ISNULL(dls.ActiveParticipantPersonalHardshipLoanBalance,0.00) AS ActiveParticipantPersonalHardshipLoanBalance 
		,ISNULL(dls.ActiveParticipantsWithPersonalHardshipLoanBalance,0) AS ActiveParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(dls.ActiveParticipantOtherLoanBalance,0.00) AS ActiveParticipantOtherLoanBalance 
		,ISNULL(dls.ActiveParticipantsWithOtherLoanBalance,0) AS ActiveParticipantsWithOtherLoanBalance 
		,ISNULL(dls.TerminatedParticipantResidentialLoanBalance,0.00) AS TerminatedParticipantResidentialLoanBalance 
		,ISNULL(dls.TerminatedParticipantsWithResidentialLoanBalance,0) AS TerminatedParticipantsWithResidentialLoanBalance 
		,ISNULL(dls.TerminatedParticipantResidentialHardshipLoanBalance,0.00) AS TerminatedParticipantResidentialHardshipLoanBalance 
		,ISNULL(dls.TerminatedParticipantsWithResidentialHardshipLoanBalance,0) AS TerminatedParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(dls.TerminatedParticipantPersonalLoanBalance,0.00) AS TerminatedParticipantPersonalLoanBalance 
		,ISNULL(dls.TerminatedParticipantsWithPersonalLoanBalance,0) AS TerminatedParticipantsWithPersonalLoanBalance 
		,ISNULL(dls.TerminatedParticipantPersonalHardshipLoanBalance,0.00) AS TerminatedParticipantPersonalHardshipLoanBalance 
		,ISNULL(dls.TerminatedParticipantsWithPersonalHardshipLoanBalance,0) AS TerminatedParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(dls.TerminatedParticipantOtherLoanBalance,0.00) AS TerminatedParticipantOtherLoanBalance 
		,ISNULL(dls.TerminatedParticipantsWithOtherLoanBalance,0) AS TerminatedParticipantsWithOtherLoanBalance
		,CASE WHEN pln.LoanPermitted = 'YES' THEN 1 ELSE 0 END AS LoanPermittedFlag
		,0 AS ParticipantsPastDue
		,ISNULL(cs.ReportDate, @ReportDate) AS ReportDate
FROM ref.EXPlans ex WITH (NOLOCK)
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan pln WITH (NOLOCK)
		ON ex.PlanNumber = pln.CaseNumber
	   AND pln.ActiveRecordFlag = 1
	LEFT OUTER JOIN #_MetricsCaseStage cs WITH (NOLOCK)
		ON ex.PlanNumber = cs.CaseNumber
	LEFT OUTER JOIN #_MetricsCaseDivisionStage cds WITH (NOLOCK)
		ON ex.PlanNumber = cds.CaseNumber and cs.ReportDate=cds.ReportDate
	LEFT OUTER JOIN #_DivisionContributionStage dcs WITH (NOLOCK)
		ON ex.PlanNumber=dcs.CaseNumber and cs.ReportDate=dcs.ReportDate and cds.DIV_I=dcs.DIV_I
	LEFT OUTER JOIN #_DivisionLoanStage dls
		ON ex.PlanNumber=dls.CaseNumber and cs.ReportDate=dls.ReportDate and cds.DIV_I=dls.DIV_I
	LEFT OUTER JOIN #_PCRAStage pcs
		ON ex.PlanNumber=pcs.CaseNumber and cs.ReportDate=pcs.ReportDate and cds.DIV_I=pcs.DIV_I
	LEFT OUTER JOIN #_SDBStage sds
		ON ex.PlanNumber=sds.CaseNumber and cs.ReportDate=sds.ReportDate and cds.DIV_I=sds.DIV_I
	LEFT OUTER JOIN #_CoreFundStage cfs
		ON ex.PlanNumber=cfs.CaseNumber and cs.ReportDate=cfs.ReportDate and cfs.DIV_I=dcs.DIV_I
	LEFT OUTER JOIN temp.CaseFundFlags cff
		ON pln.CaseNumber=cff.PlanNumber;

-- Final select
--INSERT INTO temp.MetricsDivisionLevel
SELECT	 ex.dimPlanId
		,env.PlanNumberEnv as PlanNumber
 		,ex.ContractNumber 
		,ex.DivisionCode
		,DIV_I 
		,ex.AffiliateNumber
		,CompanyName
		,PlanName 
		,PlanType
		,PlanCategory
		,TotalParticipantCount
		,ActiveParticipantCount
		,TerminatedParticipantCount
		,ParticipationRate 
		,AvgContributionRate 
		,EligibleEmployeeCount
		,ContributingEmployeeCount 
		,NonContributingEmployeeCount
		,AvgContributionAmount
		,ActiveParticipantCoreFunds 
		,TerminatedParticipantCoreFunds 
		,AvgParticipantCoreFund 
		,AvgActiveParticipantCoreFund 
		,AvgTerminatedParticipantCoreFund 
		,PCRA_Allowed_Flag 
		,ActiveParticipantPCRA 
		,TerminatedParticipantPCRA 
		,AvgParticipantPCRA 
		,AvgActiveParticipantPCRA
		,AvgTerminatedParticipantPCRA 
		,SDB_Allowed_Flag 
		,ActiveParticipantSDB 
		,TerminatedParticipantSDB 
		,AvgParticipantSDB 
		,AvgActiveParticipantSDB 
		,AvgTerminatedParticipantSDB 
		,SuspenseBalance 
		,ForefeitureBalance 
		,ExpenseAccountBalance 
		,AdvancedEmployerBalance 
		,ActiveParticipantResidentialLoanBalance
		,ActiveParticipantsWithResidentialLoanBalance 
		,ActiveParticipantResidentialHardshipLoanBalance 
		,ActiveParticipantsWithResidentialHardshipLoanBalance 
		,ActiveParticipantPersonalLoanBalance 
		,ActiveParticipantsWithPersonalLoanBalance 
		,ActiveParticipantPersonalHardshipLoanBalance 
		,ActiveParticipantsWithPersonalHardshipLoanBalance 
		,ActiveParticipantOtherLoanBalance 
		,ActiveParticipantsWithOtherLoanBalance 
		,TerminatedParticipantResidentialLoanBalance 
		,TerminatedParticipantsWithResidentialLoanBalance 
		,TerminatedParticipantResidentialHardshipLoanBalance 
		,TerminatedParticipantsWithResidentialHardshipLoanBalance 
		,TerminatedParticipantPersonalLoanBalance 
		,TerminatedParticipantsWithPersonalLoanBalance 
		,TerminatedParticipantPersonalHardshipLoanBalance 
		,TerminatedParticipantsWithPersonalHardshipLoanBalance 
		,TerminatedParticipantOtherLoanBalance 
		,TerminatedParticipantsWithOtherLoanBalance
		,LoanPermittedFlag
		,ParticipantsPastDue
		,ReportDate
FROM #_MetricsDivisionLevel ex
INNER JOIN temp.EXPlansEnv env
ON(ex.PlanNumber=env.PlanNumber);

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_MetricsParticipantLevel_Delta]    Script Date: 6/17/2021 11:04:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_MetricsParticipantLevel_Delta]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM [TRS_BI_DataWarehouse].[usr].[Balance] WITH (NOLOCK));
DECLARE @dimDateId INT = (SELECT dimDateId FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK) WHERE DateValue = @ReportDate);

IF OBJECT_ID('tempdb..#_MetricsParticipantLevel', 'U') IS NOT NULL
	DROP TABLE #_MetricsParticipantLevel
CREATE TABLE #_MetricsParticipantLevel (
	CaseNumber VARCHAR(20)
   ,dimDateId INT
   ,dimParticipantId INT
   ,dimPlanId INT
   ,dimAgeId INT
   ,dimEmploymentStatusId INT
   ,dimEmployerAccountId INT
   ,SocialSecurityNumber VARCHAR(12)
   ,PreTaxEligible TINYINT
   ,BalanceIndicator TINYINT
   ,Balance DECIMAL(15,2)
   ,ReportDate DATE
);

WITH cteCase AS (
	SELECT DISTINCT	
		   PlanNumber AS CaseNumber
	FROM [ref].[EXPlans] WITH (NOLOCK)
)
--SELECT * FROM cteCase
INSERT INTO #_MetricsParticipantLevel
SELECT par.CaseNumber
      ,par.dimDateId
      ,par.dimParticipantId
      ,par.dimPlanId
      ,par.dimAgeId
      ,par.dimEmploymentStatusId
	  ,par.dimEmployerAccountId
      ,par.SocialSecurityNumber
      ,par.PreTaxEligible
	  ,par.BalanceIndicator
      ,par.Balance
      ,@ReportDate as ReportDate
FROM [TRS_BI_DataWarehouse].[dbo].[factParticipant] par WITH (NOLOCK)
		INNER JOIN cteCase ex
			ON 1 = 1
		INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimPlan] pln WITH (NOLOCK)
			ON par.dimPlanId = pln.dimPlanId
		   AND pln.CaseNumber = ex.CaseNumber
		   WHERE par.dimDateId = @dimDateId;
--WHERE BalanceIndicator = 1
--AND dimEmployerAccountId = 0;

-- Final select
--INSERT INTO temp.MetricsParticipantLevelDelta
SELECT CaseNumber
      ,dimDateId
      ,dimParticipantId
      ,dimPlanId
      ,dimAgeId
      ,dimEmploymentStatusId
	  ,dimEmployerAccountId
      ,SocialSecurityNumber
      ,PreTaxEligible
	  ,BalanceIndicator
      ,Balance
      ,ReportDate
FROM #_MetricsParticipantLevel ex;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_MetricsParticipantLevel_Full]    Script Date: 6/17/2021 11:04:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_MetricsParticipantLevel_Full]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM [TRS_BI_DataWarehouse].[usr].[Balance])
	   ,@NumberOfMonths INT = 5;

IF OBJECT_ID('tempdb..#_DateArray', 'U') IS NOT NULL
	DROP TABLE #_DateArray
CREATE TABLE #_DateArray (
	dimDateId INT
   ,ReportDate DATE
);
INSERT INTO #_DateArray
SELECT dimDateId
	  ,DateValue
FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK)
WHERE DateValue = @ReportDate;

WITH CTE AS (
	SELECT @NumberOfMonths - 1 AS months
	UNION ALL 
	SELECT months - 1
	FROM CTE
	WHERE months > 0
)
INSERT INTO #_DateArray
SELECT dimDateId
	  ,DateValue
FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK)
WHERE DateValue IN (
	SELECT DATEADD(DAY, -1, DATEADD(MONTH, -months, DATEADD(DAY, -(DAY(@ReportDate) - 1), @ReportDate))) AS DateValue
	FROM CTE
)
ORDER BY 1 DESC;

IF OBJECT_ID('tempdb..#_MetricsParticipantLevel', 'U') IS NOT NULL
	DROP TABLE #_MetricsParticipantLevel
CREATE TABLE #_MetricsParticipantLevel (
	CaseNumber VARCHAR(20)
   ,dimDateId INT
   ,dimParticipantId INT
   ,dimPlanId INT
   ,dimAgeId INT
   ,dimEmploymentStatusId INT
   ,dimEmployerAccountId INT
   ,SocialSecurityNumber VARCHAR(12)
   ,PreTaxEligible TINYINT
   ,BalanceIndicator TINYINT
   ,Balance DECIMAL(15,2)
   ,ReportDate DATE
);

WITH cteCase AS (
	SELECT DISTINCT	
		   PlanNumber AS CaseNumber
	FROM [ref].[EXPlans] WITH (NOLOCK)
)
--SELECT * FROM cteCase
INSERT INTO #_MetricsParticipantLevel
SELECT par.CaseNumber
      ,par.dimDateId
      ,par.dimParticipantId
      ,par.dimPlanId
      ,par.dimAgeId
      ,par.dimEmploymentStatusId
	  ,par.dimEmployerAccountId
      ,par.SocialSecurityNumber
      ,par.PreTaxEligible
	  ,par.BalanceIndicator
      ,par.Balance
      ,dt.ReportDate
FROM [TRS_BI_DataWarehouse].[dbo].[factParticipant] par WITH (NOLOCK)
		INNER JOIN #_DateArray dt
			ON par.dimDateId = dt.dimDateId
		INNER JOIN cteCase ex
			ON 1 = 1
		INNER JOIN [TRS_BI_DataWarehouse].[dbo].[dimPlan] pln WITH (NOLOCK)
			ON par.dimPlanId = pln.dimPlanId
		   AND pln.CaseNumber = ex.CaseNumber
--WHERE BalanceIndicator = 1
--AND dimEmployerAccountId = 0;

-- Final select
--INSERT INTO temp.MetricsParticipantLevel
SELECT CaseNumber
      ,dimDateId
      ,dimParticipantId
      ,dimPlanId
      ,dimAgeId
      ,dimEmploymentStatusId
	  ,dimEmployerAccountId
      ,SocialSecurityNumber
      ,PreTaxEligible
	  ,BalanceIndicator
      ,Balance
      ,ReportDate
FROM #_MetricsParticipantLevel ex;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_MetricsUserLevel]    Script Date: 6/17/2021 11:04:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_MetricsUserLevel]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT MAX(ReportDate) FROM temp.MetricsParticipantLevel WITH (NOLOCK));


----- Final Staging Table ----
IF OBJECT_ID('tempdb..#_MetricsUserLevel', 'U') IS NOT NULL
	DROP TABLE #_MetricsUserLevel
CREATE TABLE #_MetricsUserLevel (
	dimPlanId BIGINT,
	PlanNumber VARCHAR(20),
	ContractNumber VARCHAR(10) ,
	UserId VARCHAR(20),
	AffiliateNumber VARCHAR(10) ,
	CompanyName VARCHAR(161) ,
	PlanName VARCHAR(161) ,
	PlanType VARCHAR(80) ,
	PlanCategory VARCHAR(20) ,
	TotalParticipantCount INT,
	ActiveParticipantCount INT,
	TerminatedParticipantCount INT,
	TotalParticipantCountWithBalance INT,
	ActiveParticipantCountWithBalance INT,
	TerminatedParticipantCountWithBalance INT,
	ParticipationRate DECIMAL(15, 2),
	AvgContributionRate DECIMAL(15, 2),
	EligibleEmployeeCount INT,
	ContributingEmployeeCount INT,
	NonContributingEmployeeCount INT,
	AvgContributionAmount DECIMAL(38, 2),
	ActiveParticipantFundBalance DECIMAL(38, 2),
	TerminatedParticipantFundBalance DECIMAL(38, 2),
	AvgParticipantFundBalance DECIMAL(38, 2),
	AvgActiveParticipantFundBalance DECIMAL(38, 2),
	AvgTerminatedParticipantFundBalance DECIMAL(38, 2),
	ActiveParticipantCoreFunds DECIMAL(38, 2),
	TerminatedParticipantCoreFunds DECIMAL(38, 2),
	AvgParticipantCoreFund DECIMAL(38, 2),
	AvgActiveParticipantCoreFund DECIMAL(38, 2),
	AvgTerminatedParticipantCoreFund DECIMAL(38, 2),
	PCRA_Allowed_Flag BIT,
	ActiveParticipantPCRA DECIMAL(38, 2),
	TerminatedParticipantPCRA DECIMAL(38, 2),
	AvgParticipantPCRA DECIMAL(38, 2),
	AvgActiveParticipantPCRA DECIMAL(38, 2),
	AvgTerminatedParticipantPCRA DECIMAL(38, 2),
	SDB_Allowed_Flag BIT,
	ActiveParticipantSDB DECIMAL(38, 2),
	TerminatedParticipantSDB DECIMAL(38, 2),
	AvgParticipantSDB DECIMAL(38, 2),
	AvgActiveParticipantSDB DECIMAL(38, 2),
	AvgTerminatedParticipantSDB DECIMAL(38, 2),
	SuspenseBalance DECIMAL(38, 2) ,
	ForefeitureBalance DECIMAL(38, 2) ,
	ExpenseAccountBalance DECIMAL(38, 2) ,
	AdvancedEmployerBalance DECIMAL(38, 2) ,
	ActiveParticipantResidentialLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithResidentialLoanBalance INT ,
	ActiveParticipantResidentialHardshipLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithResidentialHardshipLoanBalance INT ,
	ActiveParticipantPersonalLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithPersonalLoanBalance INT ,
	ActiveParticipantPersonalHardshipLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithPersonalHardshipLoanBalance INT ,
	ActiveParticipantOtherLoanBalance DECIMAL(38, 2) ,
	ActiveParticipantsWithOtherLoanBalance INT ,
	TerminatedParticipantResidentialLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithResidentialLoanBalance INT ,
	TerminatedParticipantResidentialHardshipLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithResidentialHardshipLoanBalance INT ,
	TerminatedParticipantPersonalLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithPersonalLoanBalance INT ,
	TerminatedParticipantPersonalHardshipLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithPersonalHardshipLoanBalance INT ,
	TerminatedParticipantOtherLoanBalance DECIMAL(38, 2) ,
	TerminatedParticipantsWithOtherLoanBalance INT ,
	LoanPermittedFlag BIT,
	ParticipantsPastDue INT ,
--	AutoRebalanceFlag INT,
--   AutoIncreaseFlag INT,
--    CustomPortfoliosFlag INT,
--   DCMAFlag INT,
--    FundTransferFlag INT,
--    PCRAFlag  INT,
--    PortfolioXpressFlag INT, 
--    SDAFlag INT,
--    SecurePathForLifeFlag INT,
	ReportDate DATE
);

--------------Restricted Plans -----------------------------
IF OBJECT_ID('tempdb..#RestrictedPlans', 'U') IS NOT NULL
  DROP TABLE #RestrictedPlans
SELECT DISTINCT
	     PlanNumber,PlanNumberEnv 
INTO #RestrictedPlans
FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT dr
INNER JOIN temp.EXPlansEnv ex
ON ex.PlanNumberEnv=rtrim(replace(ACCOUNT_NO,char(9),''));

-----------User-Plan-Division --------------------------------
IF OBJECT_ID('tempdb..#UserPlanDivision', 'U') IS NOT NULL
  DROP TABLE #UserPlanDivision;

WITH cteUser as (
       SELECT DISTINCT 
           a.CaseNumber
          ,a.SocialSecurityNumber
          ,a.dimParticipantId
          ,par.EmploymentStatus
		  ,a.ActiveRecordFlag as divisionActiveEmploymentFlag
		  ,par.ActiveRecordFlag as participantActiveEmploymentFlag
		  ,par.EffectiveFrom
		  ,par.EffectiveTo
		  ,ISNULL(d.USER_I,'NONE') as UserId
	FROM TRS_BI_Datawarehouse.dbo.dimParticipantDivision a WITH (NOLOCK)
	INNER JOIN #RestrictedPlans rp
		ON a.CaseNumber=rp.PlanNumber
	INNER JOIN WorkplaceExperience.ref.PSOL_DIV_ACCESS d WITH (NOLOCK)
		ON a.EmployeeDivisionCode=d.DIV_NO and rp.PlanNumberEnv=d.ACCOUNT_NO
       INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipant par
              ON a.SocialSecurityNumber = par.SocialSecurityNumber 
			  AND a.CaseNumber = par.CaseNumber
			  AND par.dimParticipantId=a.dimParticipantId
	WHERE (	MultiDivisionIndicator = 'NO'
			OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'TERMED')
			OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'ACTIVE' AND DivisionEmploymentStatus = 'ACTIVE')
		  )
)
SELECT 
        CaseNumber
       ,SocialSecurityNumber
       ,dimParticipantId
       ,EmploymentStatus
	   ,divisionActiveEmploymentFlag
	   ,participantActiveEmploymentFlag
	   ,UserId
	   ,EffectiveFrom
	   ,EffectiveTo
INTO #UserPlanDivision
FROM cteUser

CREATE CLUSTERED INDEX IX_#UserPlanDivision_main
    ON #UserPlanDivision(CaseNumber,SocialSecurityNumber,dimParticipantId,EmploymentStatus,UserId); 

IF OBJECT_ID('tempdb..#UserBalances', 'U') IS NOT NULL
  DROP TABLE #UserBalances
SELECT
		 a.*
		,cteUser.UserId
		,cteUser.EmploymentStatus
INTO #UserBalances
FROM     temp.BalanceByFundParticipantLevel	a
JOIN	 #UserPlanDivision cteUser
	ON	 a.SocialSecurityNumber=cteUser.SocialSecurityNumber AND a.CaseNumber=cteUser.CaseNumber and a.dimParticipantId = cteUser.dimParticipantId
--	AND  a.ReportDate between cteUser.EffectiveFrom and coalesce(cteUser. EffectiveTo, '2999-12-31');

CREATE CLUSTERED INDEX IX_#UserBalances_main
    ON #UserBalances(CaseNumber,SocialSecurityNumber,dimParticipantId,dimFundId,EmploymentStatus,UserId,ReportDate);

----------- Intermediate Staging tables for Participant Balances ------------
IF OBJECT_ID('tempdb..#_BalanceByParticipantStage', 'U') IS NOT NULL
	DROP TABLE #_BalanceByParticipantStage
SELECT   CaseNumber
		,UserId
		,SocialSecurityNumber
		,a.EmploymentStatus
		,SUM(a.Balance) as Balance
		,SUM(UnitCount) as UnitCount
		,ReportDate
INTO #_BalanceByParticipantStage
FROM	#UserBalances a
GROUP BY a.CaseNumber
		,UserId
		,a.SocialSecurityNumber
		,a.EmploymentStatus
		,a.ReportDate;

CREATE CLUSTERED INDEX IX_#_BalanceByParticipantStage_main
    ON #_BalanceByParticipantStage(CaseNumber,UserId,SocialSecurityNumber,EmploymentStatus,ReportDate); 

----------- Intermediate Staging tables for Funds ------------
IF OBJECT_ID('tempdb..#_BalanceStage', 'U') IS NOT NULL
	DROP TABLE #_BalanceStage
SELECT   COUNT(DISTINCT CASE WHEN a.Balance<>0 THEN a.SocialSecurityNumber END) AS ParticipantsWithFundBalance
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus = 'ACTIVE' AND a.Balance<>0 THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithFundBalance
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus != 'ACTIVE' AND a.Balance<>0 THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithFundBalance
		,CaseNumber
		,UserId
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN Balance ELSE 0 END) AS ActiveParticipantFundBalance
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN Balance ELSE 0 END) AS TerminatedParticipantFundBalance
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN UnitCount ELSE 0 END) AS ActiveParticipantUnitCount
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN UnitCount ELSE 0 END) AS TerminatedParticipantUnitCount
		,ReportDate
INTO	 #_BalanceStage
FROM     #_BalanceByParticipantStage a
GROUP BY CaseNumber
		,UserId
		,ReportDate;

IF OBJECT_ID('tempdb..#_PCRAStage', 'U') IS NOT NULL
	DROP TABLE #_PCRAStage
SELECT   COUNT(DISTINCT a.SocialSecurityNumber) AS ParticipantsWithPCRA
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithPCRA
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithPCRA
		,a.CaseNumber
		,a.UserId
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.Balance ELSE 0 END) AS ActiveParticipantPCRA
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.Balance ELSE 0 END) AS TerminatedParticipantPCRA
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS ActiveParticipantPCRAUnitCount
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantPCRAUnitCount
		,a.ReportDate
INTO	 #_PCRAStage
FROM     #UserBalances a 
JOIN	 TRS_BI_DataWarehouse.usr.Fund f
	ON	 a.dimFundId=f.dimFundId
WHERE    f.FundStyle = 'SELF-DIRECTED'
AND      f.FundDescription = 'PCRA'
GROUP BY a.CaseNumber
		,a.UserId
		,a.ReportDate;

IF OBJECT_ID('tempdb..#_SDBStage', 'U') IS NOT NULL
	DROP TABLE #_SDBStage
SELECT   COUNT(DISTINCT a.SocialSecurityNumber) AS ParticipantsWithSDB
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithSDB
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithSDB
		,a.CaseNumber
		,a.UserId
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.Balance ELSE 0 END) AS ActiveParticipantSDB
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.Balance ELSE 0 END) AS TerminatedParticipantSDB
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS ActiveParticipantSDBUnitCount
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantSDBUnitCount
		,a.ReportDate
INTO	 #_SDBStage
FROM     #UserBalances	a 
JOIN	 TRS_BI_DataWarehouse.usr.Fund f
	ON	 a.dimFundId=f.dimFundId
WHERE    f.FundStyle = 'SELF-DIRECTED'
AND      f.FundDescription LIKE 'NMF%'
GROUP BY a.CaseNumber
		,a.UserId
		,a.ReportDate;

IF OBJECT_ID('tempdb..#_CoreFundDim', 'U') IS NOT NULL
	DROP TABLE #_CoreFundDim
SELECT a.*
INTO	#_CoreFundDim
FROM	#UserBalances a
JOIN	TRS_BI_DataWarehouse.usr.Fund f WITH (NOLOCK) 
	ON	a.dimFundId=f.dimFundId
WHERE	FundStyle != 'SELF-DIRECTED'
OR	(	 f.FundStyle = 'SELF-DIRECTED'
AND      f.FundDescription NOT LIKE 'NMF%'
AND		 f.FundDescription <> 'PCRA');

IF OBJECT_ID('tempdb..#_CoreFundStage', 'U') IS NOT NULL
	DROP TABLE #_CoreFundStage
SELECT   COUNT(DISTINCT a.SocialSecurityNumber) AS ParticipantsWithCoreFunds
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.SocialSecurityNumber END) AS ActiveParticipantsWithCoreFunds
		,COUNT(DISTINCT CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.SocialSecurityNumber END) AS TerminatedParticipantsWithCoreFunds
		,a.CaseNumber
		,a.UserId
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.Balance ELSE 0 END) AS ActiveParticipantCoreFunds
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.Balance ELSE 0 END) AS TerminatedParticipantCoreFunds
		,SUM(CASE WHEN a.EmploymentStatus = 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS ActiveParticipantCoreFundUnitCount
		,SUM(CASE WHEN a.EmploymentStatus != 'ACTIVE' THEN a.UnitCount ELSE 0 END) AS TerminatedParticipantCoreFundUnitCount
		,a.ReportDate
INTO	#_CoreFundStage
FROM    #_CoreFundDim a
GROUP BY a.CaseNumber
		,a.UserId
		,a.ReportDate;

----- Intermediate Staging Table User Level Metrics----
IF OBJECT_ID('tempdb..#_MetricsUserCaseStage', 'U') IS NOT NULL
	DROP TABLE #_MetricsUserCaseStage;
SELECT
	     ISNULL(par.CaseNumber,cu.CaseNumber) as CaseNumber
	    ,cu.UserId
	    ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 THEN Balance ELSE 0.00 END) AS ParticipantBalance
	    ,CASE WHEN SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId IN (1,2) THEN 1 ELSE 0 END) = 0 THEN 0
		    ELSE CAST(CAST(SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 THEN Balance ELSE 0.00 END) AS FLOAT) 
			  / CAST(SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 0 AND dimEmploymentStatusId IN (1,2) THEN 1 ELSE 0 END) AS FLOAT) AS DECIMAL(15,2))
	     END AS AvgParticipantBalance
	    ,SUM(CASE WHEN PreTaxEligible = 1 THEN 1 ELSE 0 END) AS EligibleEmployeeCount
	    ,ISNULL(ReportDate,@ReportDate) as ReportDate
INTO	 #_MetricsUserCaseStage
FROM WorkplaceExperience.temp.MetricsParticipantLevel par WITH (NOLOCK)
RIGHT OUTER JOIN #UserPlanDivision cu
	ON	 cu.dimParticipantId=par.dimParticipantId
group by 
	    ISNULL(par.CaseNumber,cu.CaseNumber),
	    cu.UserId,
	    par.ReportDate;

----- Intermediate Staging Table Case Level Metrics----
IF OBJECT_ID('tempdb..#_MetricsCaseStage', 'U') IS NOT NULL
	DROP TABLE #_MetricsCaseStage
SELECT
	     ISNULL(par.CaseNumber,rp.PlanNumber) as CaseNumber
	    ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 1 THEN Balance ELSE 0.00 END) AS AdvanceEmployerBalance
	    ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 2 THEN Balance ELSE 0.00 END) AS SuspenseBalance
	    ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 3 THEN Balance ELSE 0.00 END) AS ForfeitureBalance
	    ,SUM(CASE WHEN BalanceIndicator = 1 AND dimEmployerAccountId = 4 THEN Balance ELSE 0.00 END) AS ExpenseBudgetAccountBalance
	    ,ISNULL(ReportDate,@ReportDate) as ReportDate
INTO #_MetricsCaseStage 
FROM WorkplaceExperience.temp.MetricsParticipantLevel par WITH (NOLOCK)
RIGHT OUTER JOIN #RestrictedPlans rp
	ON par.CaseNumber = rp.PlanNumber
group by 
	     ISNULL(par.CaseNumber,rp.PlanNumber),
	     par.ReportDate;

IF OBJECT_ID('tempdb..#_PartMetricsStage', 'U') IS NOT NULL
	DROP TABLE #_PartMetricsStage
SELECT   COUNT(DISTINCT dp.SocialSecurityNumber) AS TotalParticipantCount
		,COUNT(DISTINCT CASE WHEN dp.EmploymentStatus = 'ACTIVE' THEN dp.SocialSecurityNumber END) AS ActiveParticipantCount
		,COUNT(DISTINCT CASE WHEN dp.EmploymentStatus != 'ACTIVE' THEN dp.SocialSecurityNumber END) AS TerminatedParticipantCount
		,dp.CaseNumber
		,dp.UserId
		,par.ReportDate
INTO #_PartMetricsStage
FROM #UserPlanDivision dp WITH (NOLOCK)
INNER JOIN WorkplaceExperience.temp.MetricsParticipantLevel par WITH (NOLOCK)
ON dp.dimParticipantId = par.dimParticipantId and dp.CaseNumber = par.CaseNumber and dp.SocialSecurityNumber = par.SocialSecurityNumber
GROUP BY dp.CaseNumber
		,dp.UserId
		,par.ReportDate

-----Intermediate Staging Table Contributions --------
IF OBJECT_ID('tempdb..#_UserContributionStage', 'U') IS NOT NULL
	DROP TABLE #_UserContributionStage
SELECT
		 cu.CaseNumber
	    ,cu.UserId
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_P IS NOT NULL THEN cu.SocialSecurityNumber END)),0) AS EmployeesContributingWithRate
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_A IS NOT NULL THEN cu.SocialSecurityNumber END)),0) AS EmployeesContributingWithAmount
		,ISNULL(
			CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND (DEF_P IS NOT NULL OR DEF_A IS NOT NULL) THEN cu.SocialSecurityNumber END ))>0 
				THEN 1 ElSE 0 END,0) AS ContributingFlag
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 THEN cu.SocialSecurityNumber END)),0) AS ContributingEmployeeCount
		,ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 THEN cu.SocialSecurityNumber END)),0) AS EligibleEmployeeCount
		,CAST(CAST(ISNULL(SUM(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 THEN DEF_P ELSE 0 END),0) AS FLOAT)/
			 CAST((CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_P IS NOT NULL THEN cu.SocialSecurityNumber END ))=0 THEN 1 
						ELSE COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_P IS NOT NULL THEN cu.SocialSecurityNumber END )) 
							END) AS FLOAT) AS DECIMAL(15,2)) AS AverageContributionRate
		,CAST(CAST(ISNULL(SUM(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 THEN DEF_A ELSE 0 END),0) AS FLOAT)/
			 CAST((CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_A IS NOT NULL THEN cu.SocialSecurityNumber END ))=0 THEN 1 
						ELSE COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND DEF_A IS NOT NULL THEN cu.SocialSecurityNumber END )) 
							END) AS FLOAT) AS DECIMAL(15,2)) AS AverageContributionAmount
		,CAST(CAST(ISNULL(COUNT(DISTINCT(CASE WHEN PretaxEligible=1 AND ContributingFlag=1 AND (DEF_P IS NOT NULL OR DEF_A IS NOT NULL) THEN cu.SocialSecurityNumber END ))*100,0) AS FLOAT)/
				CAST(CASE WHEN COUNT(DISTINCT(CASE WHEN PretaxEligible=1 THEN cu.SocialSecurityNumber END))=0 THEN 1 
					ELSE COUNT(DISTINCT(CASE WHEN PretaxEligible=1 THEN cu.SocialSecurityNumber END)) END AS FLOAT) AS DECIMAL(15,2)) as ParticipationRate
		,ReportDate
INTO	 #_UserContributionStage
FROM	 temp.ContributionPartDivisionLevel cp
INNER JOIN #UserPlanDivision cu
	ON	 cu.dimParticipantId=cp.dimParticipantId
GROUP BY cu.CaseNumber
		,cu.UserId
		,ReportDate;


------- Intermediate Staging Table for User Level Loans -------
IF OBJECT_ID('tempdb..#_UserLoanStage', 'U') IS NOT NULL
	DROP TABLE #_UserLoanStage;
SELECT	 cu.CaseNumber
		,cu.UserId
      	,SUM(CASE WHEN LoanType = 'PERSONAL' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantPersonalLoanBalance
		,SUM(CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantPersonalHardshipLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantResidentialLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantResidentialHardshipLoanBalance
		,SUM(CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND ActiveParticipant=1 THEN ClosingLoanBalance END) AS ActiveParticipantOtherLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL' AND ActiveParticipant=1 THEN dp.SocialSecurityNumber END) AS ActiveParticipantsWithPersonalLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND ActiveParticipant=1 THEN dp.SocialSecurityNumber END) AS ActiveParticipantsWithPersonalHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL' AND ActiveParticipant=1 THEN dp.SocialSecurityNumber END) AS ActiveParticipantsWithResidentialLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND ActiveParticipant=1 THEN dp.SocialSecurityNumber END) AS ActiveParticipantsWithResidentialHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND ActiveParticipant=1 THEN dp.SocialSecurityNumber END) AS ActiveParticipantsWithOtherLoanBalance
      	,SUM(CASE WHEN LoanType = 'PERSONAL' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantPersonalLoanBalance
		,SUM(CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantPersonalHardshipLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantResidentialLoanBalance
		,SUM(CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantResidentialHardshipLoanBalance
		,SUM(CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND TerminatedParticipant=1 THEN ClosingLoanBalance END) AS TerminatedParticipantOtherLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL' AND TerminatedParticipant=1 THEN dp.SocialSecurityNumber END) AS TerminatedParticipantsWithPersonalLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'PERSONAL HARDSHIP' AND TerminatedParticipant=1 THEN dp.SocialSecurityNumber END) AS TerminatedParticipantsWithPersonalHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL' AND TerminatedParticipant=1 THEN dp.SocialSecurityNumber END) AS TerminatedParticipantsWithResidentialLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType = 'RESIDENTIAL HARDSHIP' AND TerminatedParticipant=1 THEN dp.SocialSecurityNumber END) AS TerminatedParticipantsWithResidentialHardshipLoanBalance
		,COUNT (DISTINCT CASE WHEN LoanType NOT IN  ('PERSONAL','PERSONAL HARDSHIP','RESIDENTIAL','RESIDENTIAL HARDSHIP') AND TerminatedParticipant=1 THEN dp.SocialSecurityNumber END) AS TerminatedParticipantsWithOtherLoanBalance
		,ReportDate
  INTO #_UserLoanStage
  FROM temp.LoansPartDivisionLevel dp
  INNER JOIN #UserPlanDivision cu
	ON dp.CaseNumber=cu.CaseNumber AND dp.dimParticipantId=cu.dimParticipantId
  GROUP BY
		 cu.CaseNumber
		,cu.UserId
		,ReportDate;

-- FINAL STAGING TABLE
INSERT INTO #_MetricsUserLevel
SELECT	 pln.dimPlanId
		,ex.PlanNumber
		,pln.ContractNumber
		,us.UserId
		,pln.AffiliateNumber
		,pln.CompanyName
		,pln.PlanName
		,pln.PlanProductType AS PlanType
		,CASE WHEN pln.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Defined Benefit'
	  		ELSE 'Defined Contribution'
			END AS PlanCategory
		,ISNULL(pms.TotalParticipantCount, 0) AS TotalParticipantCount
		,ISNULL(pms.ActiveParticipantCount, 0) AS ActiveParticipantCount
		,ISNULL(pms.TerminatedParticipantCount, 0) AS TerminatedParticipantCount
		,ISNULL(bs.ParticipantsWithFundBalance, 0) AS TotalParticipantCountWithBalance
		,ISNULL(bs.ActiveParticipantsWithFundBalance, 0) AS ActiveParticipantCountWithBalance
		,ISNULL(bs.TerminatedParticipantsWithFundBalance, 0) AS TerminatedParticipantCountWithBalance
		,ISNULL(ucs.ParticipationRate,0.00) AS ParticipationRate 
		,ISNULL(ucs.AverageContributionRate,0.00) AS AvgContributionRate 
		,ISNULL(ucs.EligibleEmployeeCount, 0) AS EligibleEmployeeCount
		,ISNULL(ucs.ContributingEmployeeCount, 0) AS ContributingEmployeeCount 
		,ISNULL(ucs.EligibleEmployeeCount, 0)-ISNULL(ucs.ContributingEmployeeCount, 0) AS NonContributingEmployeeCount
		,ISNULL(ucs.AverageContributionAmount,0.00) AS AvgContributionAmount
		,ISNULL(bs.ActiveParticipantFundBalance, 0.00) AS ActiveParticipantFundBalance 
		,ISNULL(bs.TerminatedParticipantFundBalance, 0.00) AS TerminatedParticipantFundBalance 
		,ISNULL((bs.ActiveParticipantFundBalance+bs.TerminatedParticipantFundBalance)/
			(CASE WHEN bs.ActiveParticipantsWithFundBalance+bs.TerminatedParticipantsWithFundBalance=0 THEN 1
				ELSE bs.ActiveParticipantsWithFundBalance+bs.TerminatedParticipantsWithFundBalance END), 0.00) AS AvgParticipantFundBalance
		,ISNULL(bs.ActiveParticipantFundBalance/
			CASE WHEN bs.ActiveParticipantsWithFundBalance=0 THEN 1 ELSE bs.ActiveParticipantsWithFundBalance END , 0.00) AS AvgActiveParticipantFundBalance 
		,ISNULL(bs.TerminatedParticipantFundBalance/
			CASE WHEN bs.TerminatedParticipantsWithFundBalance=0 THEN 1 ELSE bs.TerminatedParticipantsWithFundBalance END, 0.00) AS AvgTerminatedParticipantFundBalance
		,ISNULL(cfs.ActiveParticipantCoreFunds, 0.00) AS ActiveParticipantCoreFunds 
		,ISNULL(cfs.TerminatedParticipantCoreFunds, 0.00) AS TerminatedParticipantCoreFunds 
		,ISNULL((cfs.ActiveParticipantCoreFunds+cfs.TerminatedParticipantCoreFunds)/
			(CASE WHEN cfs.ActiveParticipantsWithCoreFunds+cfs.TerminatedParticipantsWithCoreFunds=0 THEN 1
				ELSE cfs.ActiveParticipantsWithCoreFunds+cfs.TerminatedParticipantsWithCoreFunds END), 0.00) AS AvgParticipantCoreFund 
		,ISNULL(cfs.ActiveParticipantCoreFunds/
			CASE WHEN cfs.ActiveParticipantsWithCoreFunds=0 THEN 1 ELSE cfs.ActiveParticipantsWithCoreFunds END , 0.00) AS AvgActiveParticipantCoreFund 
		,ISNULL(cfs.TerminatedParticipantCoreFunds/
			CASE WHEN cfs.TerminatedParticipantsWithCoreFunds=0 THEN 1 ELSE cfs.TerminatedParticipantsWithCoreFunds END, 0.00) AS AvgTerminatedParticipantCoreFund 
		,ISNULL(cff.PCRA_Allowed_Flag,0) AS PCRA_Allowed_Flag 
		,ISNULL(pcs.ActiveParticipantPCRA, 0.00) AS ActiveParticipantPCRA 
		,ISNULL(pcs.TerminatedParticipantPCRA, 0.00) AS TerminatedParticipantPCRA 
		,ISNULL((pcs.ActiveParticipantPCRA+pcs.TerminatedParticipantPCRA)/
			(CASE WHEN pcs.ActiveParticipantsWithPCRA+pcs.TerminatedParticipantsWithPCRA=0 THEN 1
				ELSE pcs.ActiveParticipantsWithPCRA+pcs.TerminatedParticipantsWithPCRA END), 0.00) AS AvgParticipantPCRA 
		,ISNULL(pcs.ActiveParticipantPCRA/
			CASE WHEN pcs.ActiveParticipantsWithPCRA=0 THEN 1 ELSE pcs.ActiveParticipantsWithPCRA END, 0.00) AS AvgActiveParticipantPCRA
		,ISNULL(pcs.TerminatedParticipantPCRA/
			CASE WHEN pcs.TerminatedParticipantsWithPCRA=0 THEN 1 ELSE pcs.TerminatedParticipantsWithPCRA END, 0.00) AS AvgTerminatedParticipantPCRA 
		,ISNULL(cff.SDB_Allowed_Flag,0) AS SDB_Allowed_Flag
		,ISNULL(sds.ActiveParticipantSDB, 0.00) AS ActiveParticipantSDB 
		,ISNULL(sds.TerminatedParticipantSDB, 0.00) AS TerminatedParticipantSDB 
		,ISNULL((sds.ActiveParticipantSDB+sds.TerminatedParticipantSDB)/
			(CASE WHEN sds.ActiveParticipantsWithSDB+sds.TerminatedParticipantsWithSDB=0 THEN 1
				ELSE sds.ActiveParticipantsWithSDB+sds.TerminatedParticipantsWithSDB END), 0.00) AS AvgParticipantSDB 
		,ISNULL(sds.ActiveParticipantSDB/
			CASE WHEN sds.ActiveParticipantsWithSDB=0 THEN 1 ELSE sds.ActiveParticipantsWithSDB END, 0.00) AS AvgActiveParticipantSDB 
		,ISNULL(sds.TerminatedParticipantSDB/
			CASE WHEN sds.TerminatedParticipantsWithSDB=0 THEN 1 ELSE sds.TerminatedParticipantsWithSDB END, 0.00) AS AvgTerminatedParticipantSDB
		,ISNULL(cs.SuspenseBalance, 0.00) AS SuspenseBalance 
		,ISNULL(cs.ForfeitureBalance, 0.00) AS ForfeitureBalance 
		,ISNULL(cs.ExpenseBudgetAccountBalance, 0.00) AS ExpenseAccountBalance 
		,ISNULL(cs.AdvanceEmployerBalance, 0.00) AS AdvancedEmployerBalance 
		,ISNULL(uls.ActiveParticipantResidentialLoanBalance,0.00) AS ActiveParticipantResidentialLoanBalance
		,ISNULL(uls.ActiveParticipantsWithResidentialLoanBalance,0) AS ActiveParticipantsWithResidentialLoanBalance 
		,ISNULL(uls.ActiveParticipantResidentialHardshipLoanBalance,0.00) AS ActiveParticipantResidentialHardshipLoanBalance 
		,ISNULL(uls.ActiveParticipantsWithResidentialHardshipLoanBalance,0) AS ActiveParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(uls.ActiveParticipantPersonalLoanBalance,0.00) AS ActiveParticipantPersonalLoanBalance 
		,ISNULL(uls.ActiveParticipantsWithPersonalLoanBalance,0) AS ActiveParticipantsWithPersonalLoanBalance 
		,ISNULL(uls.ActiveParticipantPersonalHardshipLoanBalance,0.00) AS ActiveParticipantPersonalHardshipLoanBalance 
		,ISNULL(uls.ActiveParticipantsWithPersonalHardshipLoanBalance,0) AS ActiveParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(uls.ActiveParticipantOtherLoanBalance,0.00) AS ActiveParticipantOtherLoanBalance 
		,ISNULL(uls.ActiveParticipantsWithOtherLoanBalance,0) AS ActiveParticipantsWithOtherLoanBalance 
		,ISNULL(uls.TerminatedParticipantResidentialLoanBalance,0.00) AS TerminatedParticipantResidentialLoanBalance 
		,ISNULL(uls.TerminatedParticipantsWithResidentialLoanBalance,0) AS TerminatedParticipantsWithResidentialLoanBalance 
		,ISNULL(uls.TerminatedParticipantResidentialHardshipLoanBalance,0.00) AS TerminatedParticipantResidentialHardshipLoanBalance 
		,ISNULL(uls.TerminatedParticipantsWithResidentialHardshipLoanBalance,0) AS TerminatedParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(uls.TerminatedParticipantPersonalLoanBalance,0.00) AS TerminatedParticipantPersonalLoanBalance 
		,ISNULL(uls.TerminatedParticipantsWithPersonalLoanBalance,0) AS TerminatedParticipantsWithPersonalLoanBalance 
		,ISNULL(uls.TerminatedParticipantPersonalHardshipLoanBalance,0.00) AS TerminatedParticipantPersonalHardshipLoanBalance 
		,ISNULL(uls.TerminatedParticipantsWithPersonalHardshipLoanBalance,0) AS TerminatedParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(uls.TerminatedParticipantOtherLoanBalance,0.00) AS TerminatedParticipantOtherLoanBalance 
		,ISNULL(uls.TerminatedParticipantsWithOtherLoanBalance,0) AS TerminatedParticipantsWithOtherLoanBalance
		,CASE WHEN pln.LoanPermitted = 'YES' THEN 1 ELSE 0 END AS LoanPermittedFlag
		,0 AS ParticipantsPastDue
		,ISNULL(cs.ReportDate, @ReportDate) AS ReportDate
FROM ref.EXPlans ex WITH (NOLOCK)
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan pln WITH (NOLOCK)
		ON ex.PlanNumber = pln.CaseNumber
	   AND pln.ActiveRecordFlag = 1
	INNER JOIN #RestrictedPlans rp
		ON ex.PlanNumber = rp.PlanNumber
	LEFT OUTER JOIN #_MetricsCaseStage cs WITH (NOLOCK)
		ON ex.PlanNumber = cs.CaseNumber
	LEFT OUTER JOIN #_MetricsUserCaseStage us WITH (NOLOCK)
		ON ex.PlanNumber = us.CaseNumber and cs.ReportDate=us.ReportDate
	LEFT OUTER JOIN #_PartMetricsStage pms WITH (NOLOCK)
		ON ex.PlanNumber=pms.CaseNumber and pms.ReportDate=us.ReportDate and us.UserId=pms.UserId
	LEFT OUTER JOIN #_UserContributionStage ucs WITH (NOLOCK)
		ON ex.PlanNumber=ucs.CaseNumber and cs.ReportDate=ucs.ReportDate and us.UserId=ucs.UserId
	LEFT OUTER JOIN #_UserLoanStage uls
		ON ex.PlanNumber=uls.CaseNumber and cs.ReportDate=uls.ReportDate and us.UserId=uls.UserId
	LEFT OUTER JOIN #_PCRAStage pcs
		ON ex.PlanNumber=pcs.CaseNumber and cs.ReportDate=pcs.ReportDate and us.UserId=pcs.UserId
	LEFT OUTER JOIN #_BalanceStage bs
		ON pln.CaseNumber=bs.CaseNumber and cs.ReportDate=bs.ReportDate  and us.UserId=bs.UserId
	LEFT OUTER JOIN #_SDBStage sds
		ON ex.PlanNumber=sds.CaseNumber and cs.ReportDate=sds.ReportDate and us.UserId=sds.UserId
	LEFT OUTER JOIN #_CoreFundStage cfs
		ON ex.PlanNumber=cfs.CaseNumber and cs.ReportDate=cfs.ReportDate and us.UserId=cfs.UserId
	LEFT OUTER JOIN temp.CaseFundFlags cff
		ON pln.CaseNumber=cff.PlanNumber;

----- add the following for plan level flags:----
WITH ctePlanFlags AS
(
  SELECT ACCOUNT_NO, 
       [AUTO REBALANCE] AS AutoRebalance,                                                               
       [SELF DIRECTED ACCOUNT] AS SDA,                                                           
       [PORTFOLIO XPRESS] AS PortfolioXpress,                                                                
       [RECURRING FUND TRANSFERS] AS FundTransfer,                                                        
       [MANAGED ADVICE (DCMA)] AS DCMA,                                                           
       [PCRA] AS PCRA,                                                                            
       [SECUREPATH FOR LIFE] AS SecurePathForLife,                                                             
       [DEFERRAL AUTO INCREASE] AS AutoIncrease,                                                          
       [CUSTOM PORTFOLIOS] AS CustomPortfolios
  FROM [WorkplaceExperience].[ref].[tab_PlanFlags] sourceTable
    PIVOT(
           MIN([enabled]) FOR [Service] IN  ([AUTO REBALANCE],                                                               
                                             [SELF DIRECTED ACCOUNT],                                                           
                                             [PORTFOLIO XPRESS],                                                                
                                             [RECURRING FUND TRANSFERS],                                                        
                                             [MANAGED ADVICE (DCMA)],                                                           
                                             [PCRA],                                                                            
                                             [SECUREPATH FOR LIFE],                                                             
                                             [DEFERRAL AUTO INCREASE],                                                          
                                             [CUSTOM PORTFOLIOS])
     ) AS pivotTable    
)
SELECT ACCOUNT_NO
      ,COALESCE(p.AutoRebalance, 0) AS AutoRebalance
         ,COALESCE(p.AutoIncrease, 0) AS AutoIncrease
         ,COALESCE(p.CustomPortfolios, 0) AS CustomPortfolios
         ,COALESCE(p.DCMA, 0) AS DCMA
         ,COALESCE(p.FundTransfer, 0) AS FundTransfer
         ,COALESCE(p.PCRA, 0) AS PCRA
         ,COALESCE(p.PortfolioXpress, 0) AS PortfolioXpress
         ,COALESCE(p.SDA, 0) AS SDA
         ,COALESCE(p.SecurePathForLife, 0) AS SecurePathForLife
INTO #_planFlags
FROM ctePlanFlags p;

-- Final select
--INSERT INTO temp.MetricsUserLevel
SELECT	 DISTINCT 
		 pl.planid AS dimPlanId
		,env.PlanNumberEnv AS PlanNumber
 		,env.ContractNumberEnv AS ContractNumber 
		,UserId
		,ex.AffiliateNumber
		,CompanyName
		,PlanName 
		,PlanType
		,PlanCategory
		,TotalParticipantCount
		,ActiveParticipantCount
		,TerminatedParticipantCount
		,TotalParticipantCountWithBalance
		,ActiveParticipantCountWithBalance
		,TerminatedParticipantCountWithBalance
		,ParticipationRate 
		,AvgContributionRate 
		,EligibleEmployeeCount
		,ContributingEmployeeCount 
		,NonContributingEmployeeCount
		,AvgContributionAmount
		,ActiveParticipantFundBalance
		,TerminatedParticipantFundBalance
		,AvgParticipantFundBalance
		,AvgActiveParticipantFundBalance
		,AvgTerminatedParticipantFundBalance
		,ActiveParticipantCoreFunds 
		,TerminatedParticipantCoreFunds 
		,AvgParticipantCoreFund 
		,AvgActiveParticipantCoreFund 
		,AvgTerminatedParticipantCoreFund 
		,COALESCE(PCRA, 0) AS PCRA_Allowed_Flag 
		,ActiveParticipantPCRA 
		,TerminatedParticipantPCRA 
		,AvgParticipantPCRA 
		,AvgActiveParticipantPCRA
		,AvgTerminatedParticipantPCRA 
		,COALESCE(SDA, 0) AS SDB_Allowed_Flag 
		,ActiveParticipantSDB 
		,TerminatedParticipantSDB 
		,AvgParticipantSDB 
		,AvgActiveParticipantSDB 
		,AvgTerminatedParticipantSDB 
		,SuspenseBalance 
		,ForefeitureBalance 
		,ExpenseAccountBalance 
		,AdvancedEmployerBalance 
		,ActiveParticipantResidentialLoanBalance
		,ActiveParticipantsWithResidentialLoanBalance 
		,ActiveParticipantResidentialHardshipLoanBalance 
		,ActiveParticipantsWithResidentialHardshipLoanBalance 
		,ActiveParticipantPersonalLoanBalance 
		,ActiveParticipantsWithPersonalLoanBalance 
		,ActiveParticipantPersonalHardshipLoanBalance 
		,ActiveParticipantsWithPersonalHardshipLoanBalance 
		,ActiveParticipantOtherLoanBalance 
		,ActiveParticipantsWithOtherLoanBalance 
		,TerminatedParticipantResidentialLoanBalance 
		,TerminatedParticipantsWithResidentialLoanBalance 
		,TerminatedParticipantResidentialHardshipLoanBalance 
		,TerminatedParticipantsWithResidentialHardshipLoanBalance 
		,TerminatedParticipantPersonalLoanBalance 
		,TerminatedParticipantsWithPersonalLoanBalance 
		,TerminatedParticipantPersonalHardshipLoanBalance 
		,TerminatedParticipantsWithPersonalHardshipLoanBalance 
		,TerminatedParticipantOtherLoanBalance 
		,TerminatedParticipantsWithOtherLoanBalance
		,LoanPermittedFlag
		,ParticipantsPastDue
		,COALESCE(AutoRebalance, 0) AS AutoRebalanceFlag
        ,COALESCE(AutoIncrease, 0) AS AutoIncreaseFlag
        ,COALESCE(CustomPortfolios, 0) AS CustomPortfoliosFlag
        ,COALESCE(DCMA, 0) AS DCMAFlag
        ,COALESCE(FundTransfer, 0) AS FundTransferFlag
        ,COALESCE(PCRA, 0) AS PCRAFlag
        ,COALESCE(PortfolioXpress, 0) AS PortfolioXpressFlag
        ,COALESCE(SDA, 0) AS SDAFlag
        ,COALESCE(SecurePathForLife, 0) AS SecurePathForLifeFlag
		,ReportDate
FROM #_MetricsUserLevel ex
INNER JOIN temp.EXPlansEnv env
ON ex.PlanNumber=env.PlanNumber
INNER JOIN ex.plans_list pl
ON --ex.PlanNumber = pl.plannumber
   env.PlanNumberEnv  = pl.plannumber
LEFT JOIN #_planFlags f 
ON ex.PlanNumber = f.ACCOUNT_NO
;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_Outlooks]    Script Date: 6/17/2021 11:04:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_Source_Outlooks]
AS SET NOCOUNT ON;

-----------------------final target temp table --------------------------

IF OBJECT_ID('tempdb..#_OutlooksUserLevel','U') IS NOT NULL
	DROP TABLE #_OutlooksUserLevel
CREATE TABLE #_OutlooksUserLevel(
	dimPlanId bigint,
	PlanNumber varchar(20) ,
	RestrictedCaseFlag bit,
	UserId char(12)  ,
	OntrackOutlookCount int ,
	UnknownOutlookCount int ,
	NotOntrackOutlookCount int ,
	TotalOutlookCount int ,
	OntrackPercentage decimal(15, 2),
	ReportDate Date
);
------------------------ Restricted plans --------------------------------------------------

IF OBJECT_ID('tempdb..#_RestrictedPlans', 'U') IS NOT NULL
	DROP TABLE #_RestrictedPlans;
WITH cteRp AS (
SELECT DISTINCT PlanNumber
			   ,PlanNumberEnv
FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT dr
INNER JOIN temp.EXPlansEnv ex
		ON ex.PlanNumberEnv=dr.ACCOUNT_NO
)
SELECT   cteRp.PlanNumber
		,cteRp.PlanNumberEnv
INTO	#_RestrictedPlans
FROM	cteRp;

-------------------------------- Restricted participants  ----------------------------------------------------------
IF OBJECT_ID('tempdb..#_RestrictedParts', 'U') IS NOT NULL
	DROP TABLE #_RestrictedParts;

WITH cteRestricted as (
	SELECT DISTINCT 
		mp.dimParticipantId
	   ,mp.dimPlanId
	   ,mp.CaseNumber
	   ,mp.dimDateId
       ,ISNULL(d.USER_I,'NONE') as UserId
	   ,mp.ReportDate as ReportDate
	FROM temp.MetricsParticipantLevel mp WITH (NOLOCK)
	INNER JOIN TRS_BI_Datawarehouse.dbo.dimParticipantDivision a WITH (NOLOCK)
		ON mp.dimParticipantId = a.dimParticipantId
	INNER JOIN #_RestrictedPlans rp
		ON a.CaseNumber=rp.PlanNumber
	INNER JOIN WorkplaceExperience.ref.PSOL_DIV_ACCESS d WITH (NOLOCK)
		ON a.EmployeeDivisionCode=d.DIV_NO and rp.PlanNumberEnv=d.ACCOUNT_NO
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimParticipant par WITH (NOLOCK) 
		ON a.dimParticipantId=par.dimParticipantId
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan pInfo WITH (NOLOCK)
		ON pInfo.dimPlanId = mp.dimPlanId
	WHERE (	MultiDivisionIndicator = 'NO'
			OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'TERMED')
			OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'ACTIVE' AND DivisionEmploymentStatus = 'ACTIVE')
		  )
		AND mp.dimEmployerAccountId = 0
		AND mp.BalanceIndicator = 1	   
)
SELECT	dimParticipantId
	   ,dimPlanId
	   ,CaseNumber
	   ,dimDateId
       ,UserId
	   ,ReportDate
INTO #_RestrictedParts
FROM cteRestricted;

WITH cteOutlooksRestricted AS (
	SELECT
			 rp.dimPlanId
			,oInfo.dimOutlookForecastId	
			,rp.CaseNumber
			,rp.UserId
			,rp.dimDateId
			,rp.ReportDate
			,COUNT(DISTINCT parInfo.dimUniqueSocialId) AS Outlooks
	FROM #_RestrictedParts rp
	INNER JOIN TRS_BI_DataWarehouse.dbo.factParticipant parInfo WITH (NOLOCK)
		ON  rp.dimParticipantId = parInfo.dimParticipantId 
		AND rp.dimPlanId = parInfo.dimPlanId
		AND rp.dimDateId = parInfo.dimDateId
	INNER JOIN TRS_BI_DataWarehouse.usr.OutlookInfo oInfo WITH (NOLOCK)
			ON parInfo.dimOutlookId = oInfo.dimOutlookId
		   --AND oInfo.dimOutlookId != 0
	GROUP BY rp.dimPlanId
			,oInfo.dimOutlookForecastId	
			,rp.CaseNumber
			,rp.UserId
			,rp.dimDateId
			,rp.ReportDate
)
,cteOnTrack AS (
	SELECT dimPlanId
		  ,CaseNumber
		  ,UserId
		  ,SUM(CASE WHEN OutlookStatus = 'FAVORABLE' THEN Outlooks ELSE 0 END) AS OnTrack
		  ,SUM(CASE WHEN OutlookStatus = 'UNFAVORABLE' THEN Outlooks ELSE 0 END) AS NotOnTrack
		  ,SUM(CASE WHEN OutlookStatus = 'UNKNOWN' THEN Outlooks ELSE 0 END) AS Unknown
		  ,SUM(CASE WHEN OutlookStatus IN ('FAVORABLE','UNFAVORABLE') THEN Outlooks ELSE 0 END) AS TotalOutlooks
		  ,CASE WHEN SUM(CASE WHEN OutlookStatus IN ('FAVORABLE','UNFAVORABLE', 'UNKNOWN') THEN Outlooks ELSE 0 END) = 0 THEN 0
			    ELSE CAST(CAST(SUM(CASE WHEN OutlookStatus = 'FAVORABLE' THEN Outlooks ELSE 0 END) AS FLOAT) / CAST(SUM(CASE WHEN OutlookStatus IN ('FAVORABLE','UNFAVORABLE', 'UNKNOWN') THEN Outlooks ELSE 0 END) AS FLOAT) AS DECIMAL(15,2))
		   END AS OnTrackPercentage
		  ,ReportDate
	FROM cteOutlooksRestricted oData
		INNER JOIN TRS_BI_DataWarehouse.usr.OutlookForecast oForecast WITH (NOLOCK)
			ON oData.dimOutlookForecastId = oForecast.dimOutlookForecastId
	GROUP BY dimPlanId
			,CaseNumber
			,UserId
			,ReportDate
)
INSERT INTO #_OutlooksUserLevel
SELECT	 dimPlanId
		,CaseNumber as PlanNumber
		,1 AS RestrictedCaseFlag
		,UserId
		,OnTrack as OntrackOutlookCount
		,Unknown as UnknownOutlookCount
		,NotOnTrack as NotOntrackOutlookCount
		,TotalOutlooks as TotalOutlookCount
		,OnTrackPercentage as OntrackPercentage
		,ReportDate
FROM  cteOnTrack;

------------------------ Non Restricted plans Outlooks --------------------------------------------------

WITH cteRp AS (
SELECT DISTINCT PlanNumber
			   ,PlanNumberEnv
FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT dr
INNER JOIN temp.EXPlansEnv ex
		ON ex.PlanNumberEnv=dr.ACCOUNT_NO
)
,	cteOutlooksNonRestricted as (
	SELECT DISTINCT 
	    pInfo.dimPlanId
	   ,pInfo.CaseNumber
       ,'NONE' as UserId
	   ,oInfo.dimOutlookForecastId
	   ,COUNT(DISTINCT parInfo.dimUniqueSocialId) AS Outlooks
	   ,a.ReportDate as ReportDate
	FROM temp.MetricsParticipantLevel a
	INNER JOIN TRS_BI_DataWarehouse.usr.ParticipantInfo parInfo WITH (NOLOCK)
		ON parInfo.dimParticipantId=a.dimParticipantId and a.dimDateId=parInfo.dimDateId
	INNER JOIN TRS_BI_DataWarehouse.usr.OutlookInfo oInfo WITH (NOLOCK)
			ON parInfo.dimOutlookId = oInfo.dimOutlookId
		   --AND oInfo.dimOutlookId != 0
	INNER JOIN TRS_BI_DataWarehouse.usr.PlanInfo pInfo WITH (NOLOCK)
			ON parInfo.dimPlanId = pInfo.dimPlanId
		   AND pInfo.CaseNumber = a.CaseNumber
	--LEFT OUTER JOIN cteRp rp
	--	ON a.CaseNumber=rp.PlanNumber
	WHERE --rp.PlanNumber IS NULL
			parInfo.BalanceIndicator = 1
		AND parInfo.dimEmployerAccountId = 0
	GROUP BY pInfo.dimPlanId
			,pInfo.CaseNumber
			,parInfo.dimDateId
			,oInfo.dimOutlookForecastId
			,a.ReportDate
)
,cteOnTrack AS (
	SELECT dimPlanId
		  ,CaseNumber
		  ,UserId
		  ,SUM(CASE WHEN OutlookStatus = 'FAVORABLE' THEN Outlooks ELSE 0 END) AS OnTrack
		  ,SUM(CASE WHEN OutlookStatus = 'UNFAVORABLE' THEN Outlooks ELSE 0 END) AS NotOnTrack
		  ,SUM(CASE WHEN OutlookStatus = 'UNKNOWN' THEN Outlooks ELSE 0 END) AS Unknown
		  ,SUM(CASE WHEN OutlookStatus IN ('FAVORABLE','UNFAVORABLE') THEN Outlooks ELSE 0 END) AS TotalOutlooks
		  ,CASE WHEN SUM(CASE WHEN OutlookStatus IN ('FAVORABLE','UNFAVORABLE', 'UNKNOWN') THEN Outlooks ELSE 0 END) = 0 THEN 0
			    ELSE CAST(CAST(SUM(CASE WHEN OutlookStatus = 'FAVORABLE' THEN Outlooks ELSE 0 END) AS FLOAT) / CAST(SUM(CASE WHEN OutlookStatus IN ('FAVORABLE','UNFAVORABLE', 'UNKNOWN') THEN Outlooks ELSE 0 END) AS FLOAT) AS DECIMAL(15,2))
		   END AS OnTrackPercentage
		  ,ReportDate
	FROM cteOutlooksNonRestricted oData
		INNER JOIN TRS_BI_DataWarehouse.usr.OutlookForecast oForecast WITH (NOLOCK)
			ON oData.dimOutlookForecastId = oForecast.dimOutlookForecastId
	GROUP BY dimPlanId
			,CaseNumber
			,UserId
			,ReportDate
)
INSERT INTO #_OutlooksUserLevel
SELECT	 dimPlanId
		,CaseNumber as PlanNumber
		,0 AS RestrictedCaseFlag
		,UserId
		,OnTrack as OntrackOutlookCount
		,Unknown as UnknownOutlookCount
		,NotOnTrack as NotOntrackOutlookCount
		,TotalOutlooks as TotalOutlookCount
		,OnTrackPercentage as OntrackPercentage
		,ReportDate
FROM  cteOnTrack;

---------------------------------- final select ----------------------

SELECT	 pl.planid AS dimPlanId
		,PlanNumberEnv as PlanNumber
		,RestrictedCaseFlag
		,UserId
		,OntrackOutlookCount
		,UnknownOutlookCount
		,NotOntrackOutlookCount
		,TotalOutlookCount
		,OntrackPercentage
		,ReportDate
FROM  #_OutlooksUserLevel o
INNER JOIN temp.EXPlansEnv ex
	ON ex.PlanNumber=o.PlanNumber
INNER JOIN ex.plans_list pl
	ON --ex.PlanNumber = pl.plannumber
	  ex.PlanNumberEnv  = pl.plannumber


GO
/****** Object:  StoredProcedure [dbo].[usp_Source_ParticipantContribution]    Script Date: 6/17/2021 11:04:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[usp_Source_ParticipantContribution]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM [TRS_BI_DataWarehouse].[usr].[Balance]);

DECLARE @DimDateId INT = (SELECT dimDateId FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK) WHERE DateValue = @ReportDate);

----- EXEmployee from temp.MetricsParticipantLevel
IF OBJECT_ID('tempdb..#EXEmployee', 'U') IS NOT NULL
	DROP TABLE #EXEmployee
	SELECT   a.*
		,b.PART_ENRL_I
		,c.DIV_I
		,d.MultiPartDivision
	INTO #EXEmployee
		FROM (SELECT * FROM temp.MetricsParticipantLevel a where dimEmployerAccountId=0) a
			 INNER JOIN TRS_BI_Datawarehouse.dbo.dimParticipant b
				ON a.dimParticipantId=b.dimParticipantId
			 INNER JOIN TRS_BI_Datawarehouse.dbo.dimParticipantDivision c
				ON a.dimParticipantId=c.dimParticipantId
			 INNER JOIN TRS_BI_Datawarehouse.dbo.dimPlan d
				ON a.dimPlanId=d.dimPlanId;

-- Does TA get deferral data. For all Cases_No not in this dataset, TA will not have deferral data
IF OBJECT_ID('tempdb..#EXDeferralGroup', 'U') IS NOT NULL
	DROP TABLE #EXDeferralGroup
SELECT A.ACCOUNT_NO
      ,C.ENRL_PROV_GRP_I
      ,C.DEF_GRP_I
      ,C.SRC_I
      ,C.DEF_GRP_NM
      ,D.DOC_NM
	  ,D.SRC_TYP_C
INTO #EXDeferralGroup
FROM [TRS_BI_Staging].[dbo].[PLAN_PROV_GRP] A WITH (NOLOCK) 
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] B WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = B.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_DEFERRAL_GRP] C WITH (NOLOCK)
		ON B.PROVISION_I = C.DEF_GRP_I
	   AND A.ENRL_PROV_GRP_I = C.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_SRC_DETAIL] D WITH (NOLOCK)
		ON C.SRC_I = D.SRC_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] E WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = E.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[OUTSRC_SERVICE] F WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = E.ENRL_PROV_GRP_I
	   AND E.PROVISION_I = F.OUTSRC_I
	INNER JOIN [TRS_BI_Staging].[dbo].[OUTSRC_DEFERRAL] G WITH (NOLOCK)
		ON F.OUTSRC_I = G.OUTSRC_I
	INNER JOIN ref.EXPlans h
		 ON A.ACCOUNT_NO = h.PlanNumber
WHERE E.PROV_TYP_C = 80
  AND F.SERV_TYP_C = 7
  AND F.SERV_OFFERING_C = '1'
  AND G.SERV_TYP_C = 7
  AND A.ENRL_STAT_C = 7
  AND B.RELATED_TYP_C IN (26,113)
  AND UPPER(C.DEF_GRP_NM) NOT LIKE '%BONUS%'
GROUP BY A.ACCOUNT_NO
		,C.ENRL_PROV_GRP_I
		,C.DEF_GRP_I
		,C.SRC_I
		,C.DEF_GRP_NM
		,D.DOC_NM
		,D.SRC_TYP_C;


-- Fetch the most recent deferral amount/percentage from staging tables
IF OBJECT_ID('tempdb..#EXPlanEmployeeDeferrals', 'U') IS NOT NULL
	DROP TABLE #EXPlanEmployeeDeferrals;
    SELECT 
	     ACCOUNT_NO
	    ,PART_ENRL_I
	    ,DIV_I
	    ,ENRL_PROV_GRP_I
	    ,DEF_GRP_I
	    ,SRC_I
	    ,SRC_TYP_C
	    ,EFF_D
	    ,DEF_P
	    ,DEF_A
	    ,Ranking
   INTO #EXPlanEmployeeDeferrals
		FROM (
		  SELECT 
			 *
		  FROM (
			 SELECT
			   f.ACCOUNT_NO
			  ,g.PART_ENRL_I
			  ,g.DIV_I
			  ,f.ENRL_PROV_GRP_I
			  ,f.DEF_GRP_I
			  ,f.SRC_I
			  ,f.SRC_TYP_C
			  ,g.EFF_D
			  ,g.DEF_P
			  ,g.DEF_A
			  ,ROW_NUMBER() OVER(PARTITION BY f.ACCOUNT_NO, g.PART_ENRL_I, f.ENRL_PROV_GRP_I, f.DEF_GRP_I, f.SRC_I ORDER BY g.EFF_D DESC, g.MOD_TS DESC) AS [Ranking]
			 FROM 
				#EXEmployee a
			 INNER JOIN #EXDeferralGroup f
				ON a.CaseNumber = f.ACCOUNT_NO
			 INNER JOIN [TRS_BI_Staging].[dbo].[PART_DEF_DATA] g
				ON f.ENRL_PROV_GRP_I = g.ENRL_PROV_GRP_I
			   AND f.SRC_I = g.SRC_I
			   AND f.DEF_GRP_I = g.DEF_GRP_I 
			   AND a.DIV_I = g.DIV_I
			   AND a.PART_ENRL_I = g.PART_ENRL_I
			   AND g.EFF_D=a.ReportDate
			  WHERE a.MultiPartDivision = 'NO' ) grp1
		WHERE Ranking = 1
		UNION ALL
		  SELECT 
			 *
		  FROM (
			 SELECT
			   f.ACCOUNT_NO
			  ,g.PART_ENRL_I
			  ,g.DIV_I
			  ,f.ENRL_PROV_GRP_I
			  ,f.DEF_GRP_I
			  ,f.SRC_I
			  ,f.SRC_TYP_C
			  ,g.EFF_D
			  ,g.DEF_P
			  ,g.DEF_A
			  ,ROW_NUMBER() OVER(PARTITION BY f.ACCOUNT_NO, g.PART_ENRL_I, f.ENRL_PROV_GRP_I, f.DEF_GRP_I, f.SRC_I ORDER BY g.EFF_D DESC, g.MOD_TS DESC) AS [Ranking]
			 FROM 
				#EXEmployee a
			 INNER JOIN #EXDeferralGroup f
				ON a.CaseNumber = f.ACCOUNT_NO
			 INNER JOIN [TRS_BI_Staging].[dbo].[PART_DEF_DATA] g
				ON f.ENRL_PROV_GRP_I = g.ENRL_PROV_GRP_I
			   AND f.SRC_I = g.SRC_I
			   AND f.DEF_GRP_I = g.DEF_GRP_I 
			   AND a.DIV_I = g.DIV_I
			   AND a.PART_ENRL_I = g.PART_ENRL_I
			   AND g.EFF_D=a.ReportDate
			  WHERE a.MultiPartDivision = 'YES' ) grp2
			WHERE Ranking = 1 ) all_groups;

-- Counting people with a positive deferral
IF OBJECT_ID('tempdb..#EXActiveWithDeferral', 'U') IS NOT NULL
	DROP TABLE #EXActiveWithDeferral
SELECT a.CaseNumber
	  ,a.dimParticipantId
--	  ,a.dimParticipantDivisionId
--	  ,a.HireDate
	  ,a.SocialSecurityNumber
	  ,a.PART_ENRL_I
	  ,a.DEF_GRP_NM
	  ,a.SRC_I
	  ,a.SRC_TYP_C
	  ,a.ReportDate
	  ,CASE WHEN b.DEF_P = 0 THEN NULL ELSE b.DEF_P END AS DEF_P
	  ,CASE WHEN b.DEF_A = 0 THEN NULL ELSE b.DEF_A END AS DEF_A
INTO #EXActiveWithDeferral
FROM (
	SELECT a.CaseNumber
		  ,a.dimParticipantId
--		  ,a.dimParticipantDivisionId
--		  ,a.HireDate
		  ,a.SocialSecurityNumber
		  ,a.PART_ENRL_I
		  ,a.DIV_I
		  ,d.DEF_GRP_NM
		  ,d.ENRL_PROV_GRP_I
		  ,d.DEF_GRP_I
		  ,d.SRC_I
		  ,d.SRC_TYP_C
		  ,a.ReportDate
	FROM 
		#EXEmployee a
		INNER JOIN #EXDeferralGroup d
			ON a.CaseNumber = d.ACCOUNT_NO
	) a
	LEFT OUTER JOIN #EXPlanEmployeeDeferrals b
		ON a.ENRL_PROV_GRP_I = b.ENRL_PROV_GRP_I
		AND a.DIV_I = b.DIV_I
		AND a.PART_ENRL_I = b.PART_ENRL_I
		AND a.DEF_GRP_I = b.DEF_GRP_I
		AND a.SRC_I = b.SRC_I;


-- Get eligible employees along with their deferrals
IF OBJECT_ID('tempdb..#EXTotalSet', 'U') IS NOT NULL
	DROP TABLE #EXTotalSet
SELECT CaseNumber
	  ,dimParticipantId
--	  ,dimParticipantDivisionId
	  ,SocialSecurityNumber
	  ,PART_ENRL_I
	  ,DEF_GRP_NM
	  ,DEF_A
	  ,DEF_P
	  ,ReportDate
INTO #EXTotalSet
FROM (		
	SELECT a.CaseNumber
		  ,a.dimParticipantId
--		  ,a.dimParticipantDivisionId
		  ,a.SocialSecurityNumber
		  ,a.PART_ENRL_I
		  ,a.DEF_GRP_NM
		  ,a.DEF_A
		  ,a.DEF_P
		  ,a.ReportDate
--		  ,CASE WHEN a.SRC_TYP_C IN (102,18) AND a.TRACKED = 'NO' AND a.IMMEDIATELY = 'NO' AND a.PLAN_ENTRY_D IS NULL THEN a.PRE_TAX_DT
--			    WHEN a.PLAN_ENTRY_D IS NOT NULL AND a.TRACKED = 'YES' THEN a.PLAN_ENTRY_D
--			    WHEN a.PLAN_ENTRY_D IS NULL AND a.IMMEDIATELY = 'YES' THEN a.HireDate
--				ELSE NULL
--		   END AS PLAN_ENTRY_DATE
	FROM #EXActiveWithDeferral a
) a
--WHERE PLAN_ENTRY_DATE <= @ReportDate
--  AND PLAN_ENTRY_DATE IS NOT NULL;

-- Final select
SELECT distinct CaseNumber
FROM #EXTotalSet;


GO
/****** Object:  StoredProcedure [dbo].[usp_Source_ParticipantDetails]    Script Date: 6/17/2021 11:04:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_ParticipantDetails]
AS
SET NOCOUNT ON;

------ Final Staging Table --------
IF OBJECT_ID('tempdb..#_ParticipantDetails', 'U') IS NOT NULL
	DROP TABLE #_ParticipantDetails
CREATE TABLE #_ParticipantDetails (
    dimParticipantId     BIGINT         NULL,
    dimPlanid            BIGINT         NULL,
    CaseNumber           VARCHAR (20)   NULL,
    PlanName             VARCHAR (1000) NULL,
    EmployerName         VARCHAR (1000) NULL,
    SocialSecurityNumber VARCHAR (12)   NULL,
    EmployeeNumber       VARCHAR (100)  NULL,
    UserList             VARCHAR (MAX)  NULL,
    DivisionList         VARCHAR (MAX)  NULL,
	MultiDivisionFlag	 BIT			NULL,
	FirstName            VARCHAR (20)   NULL,
    MiddleInitial        CHAR (1)       NULL,
    LastName             VARCHAR (30)   NULL,
    Suffix               VARCHAR (10)   NULL,
    Gender               VARCHAR (15)   NULL,
    AddressLine1         VARCHAR (1000) NULL,
    AddressLine2         VARCHAR (1000) NULL,
	DeliverableStatus	 VARCHAR (100)	NULL,
	AddressStatus		 VARCHAR (100)	NULL,
    City                 VARCHAR (1000) NULL,
    StateAbbreviation    VARCHAR (5)    NULL,
    StateName            VARCHAR (1000) NULL,
    ZipCode              VARCHAR (1000) NULL,
    DayPhoneNumber       VARCHAR (1000) NULL,
	DayPhoneExt			 VARCHAR (10)	NULL,
    MobilePhoneNumber    VARCHAR (1000) NULL,
    EveningPhoneNumber   VARCHAR (1000) NULL,
	EveningPhoneExt		 VARCHAR (10)	NULL,	
    EmailAddress         VARCHAR (1000) NULL,
    BirthDate            DATE           NULL,
	DeathDate			 DATE			NULL,
	HireDate			 DATE			NULL,
	TerminationDate		 DATE			NULL,
	ReHireDate			 DATE			NULL,
	LastStatementDate	 DATE			NULL,
	PartSiteAccess		 VARCHAR (20)	NULL,
	IVRAccess			 VARCHAR (20)	NULL,
	SubLocation			 VARCHAR (100)	NULL,
	PayRollCycle		 VARCHAR (100)	NULL,
	HoursWorked			 BIGINT			NULL,
	MaritalStatus		 VARCHAR(20)	NULL,
    UserBalances         VARCHAR (MAX)  NULL,
    ReportDate           DATE           NULL
);



-----------User-Plan-Division --------------------------------
IF OBJECT_ID('tempdb..#UserPlanDivision', 'U') IS NOT NULL
  DROP TABLE #UserPlanDivision;

WITH cte as (
	SELECT 
		psr.CaseNumber
	   ,psr.SocialSecurityNumber
	   ,psr.dimParticipantId
	   ,CASE WHEN ISNULL(psr.EmployeeDivisionCode,'')='UNKNOWN' THEN '' ELSE ISNULL(psr.EmployeeDivisionCode,'') END AS DivisionCode
       ,ISNULL(psr.UserId,'NONE') as UserId
	   ,psr.ReportDate
	FROM temp.ParticipantUser psr WITH (NOLOCK)
)
SELECT 
	 CaseNumber
	,SocialSecurityNumber
	,dimParticipantId
	,DivisionCode
    ,UserId
	,ReportDate
INTO #UserPlanDivision
FROM cte;

CREATE CLUSTERED INDEX IX_#UserPlanDivision_all  
    ON #UserPlanDivision(CaseNumber,SocialSecurityNumber,dimParticipantId,DivisionCode,UserId, ReportDate);   

----------- participant user division stage ------------------------------------------------

IF OBJECT_ID('tempdb..#_ParticipantDetailsStage', 'U') IS NOT NULL
	DROP TABLE #_ParticipantDetailsStage
CREATE TABLE #_ParticipantDetailsStage ( 
		 CaseNumber VARCHAR(20)
		,SocialSecurityNumber VARCHAR(15)
		,dimParticipantId BIGINT
		,UserList VARCHAR(MAX)
		,DivisionList VARCHAR(MAX)
		,ReportDate DATE
);

INSERT INTO #_ParticipantDetailsStage
SELECT CaseNumber
      ,SocialSecurityNumber
	  ,dimParticipantId
      ,(
		SELECT DISTINCT LTRIM(RTRIM(UserId)) AS UserId 
		FROM WorkplaceExperience.temp.ParticipantUser pu
		WHERE pu.CaseNumber=psr.CaseNumber and pu.SocialSecurityNumber=psr.SocialSecurityNumber and pu.ReportDate=psr.ReportDate
		FOR JSON PATH 
		) AS UserList
	  ,(
		SELECT 
				 DISTINCT LTRIM(RTRIM(upd.UserId)) AS UserId
				,(
					SELECT DISTINCT LTRIM(RTRIM(upd1.DivisionCode)) DivisionCode FROM #UserPlanDivision upd1 
						WHERE upd.CaseNumber=upd1.CaseNumber and upd.SocialSecurityNumber=upd1.SocialSecurityNumber and upd.UserId=upd1.UserId and upd1.ReportDate=upd.ReportDate
						FOR JSON AUTO
					) AS Division
		FROM #UserPlanDivision upd
		WHERE upd.CaseNumber=psr.CaseNumber and upd.SocialSecurityNumber=psr.SocialSecurityNumber and upd.ReportDate=psr.ReportDate
		FOR JSON AUTO 
		) AS DivisionList
	  ,ReportDate
FROM temp.ParticipantUser psr
GROUP BY 
	   CaseNumber
      ,SocialSecurityNumber
	  ,dimParticipantId
	  ,ReportDate;

CREATE CLUSTERED INDEX IX_#ParticipantDetailsStage_all  
    ON #_ParticipantDetailsStage(CaseNumber,SocialSecurityNumber,dimParticipantId,ReportDate); 

---------------------------participant names addresses stage --------------------------------------------------------------

IF OBJECT_ID('tempdb..#PartNameAddres', 'U') IS NOT NULL
  DROP TABLE #PartNameAddres
SELECT   a.dimParticipantId AS dimParticipantId
		,dimPlanid AS dimPlanid
		,env.PlanNumberEnv AS CaseNumberEnv
		,a.CaseNumber AS CaseNumber
		,b.PlanName AS PlanName
		,b.ERName as EmployerName
		,k.SSNEnv AS SocialSecurityNumberEnv
		,a.SocialSecurityNumber as SocialSecurityNumber
		,a.EENumber as EmployeeNumber
		,CASE WHEN a.MultiDivisionalParticipant='YES' THEN 1 ELSE 0 END AS MultiDivisionFlag
		,a.FirstName AS FirstName
		,a.MiddleInitial AS MiddleInitial
		,CASE WHEN	CHARINDEX(' ',a.LastName)<>0
				AND LEN(a.LastName)-(CHARINDEX(' ',a.LastName)) <=3
				AND SUBSTRING(a.LastName,CHARINDEX(' ',a.LastName)+1,LEN(a.LastName)-CHARINDEX(' ',a.LastName)) IN ( 'JR','SR','I','II','III','IV','V') 
			  THEN
				SUBSTRING(a.LastName,0,CHARINDEX(' ',a.LastName))
			  ELSE a.LastName
			END AS LastName
		,CASE WHEN	CHARINDEX(' ',a.LastName)<>0
				AND LEN(a.LastName)-(CHARINDEX(' ',a.LastName)) <=3
				AND SUBSTRING(a.LastName,CHARINDEX(' ',a.LastName)+1,LEN(a.LastName)-CHARINDEX(' ',a.LastName)) IN ( 'JR','SR','I','II','III','IV','V') 
			  THEN
				SUBSTRING(a.LastName,CHARINDEX(' ',a.LastName)+1,LEN(a.LastName)-CHARINDEX(' ',a.LastName))
			  ELSE NULL
			END AS Suffix
		,a.Gender AS Gender
		,a.AddressLine1 AS AddressLine1
		,a.AddressLine2 AS AddressLine2
		,NULL AS DeliverableStatus
	    ,a.AddressStatus AS AddressStatus
		,a.City AS City
		,a.StateAbbreviation AS StateAbbreviation
		,a.StateName AS StateName
		,a.ZipCode AS ZipCode
		,a.DayPhoneNumber AS DayPhoneNumber
		,NULL AS DayPhoneExt
		,a.MobilePhoneNumber AS MobilePhoneNumber
		,a.EveningPhoneNumber AS EveningPhoneNUmber
		,NULL AS EveningPhoneExt
		,a.EmailAddress AS EmailAddress
		,a.BirthDate AS BirthDate
		,a.DeathDate AS DeathDate
        ,a.HireDate AS HireDate
        ,a.TerminationDate AS TerminationDate
        ,a.RehireDate AS RehireDate
        ,CAST(NULL AS DATE) AS LastStatementDate
        ,NULL AS PartSiteAccess
        ,NULL AS IVRAccess
        ,NULL AS SubLocation
        ,NULL AS PayRollCycle
        ,NULL AS HoursWorked
        ,a.MaritalStatus AS MaritalStatus
        ,NULL AS UserBalances
INTO #PartNameAddres
FROM
TRS_BI_Datawarehouse.dbo.dimParticipant a
INNER JOIN TRS_BI_Datawarehouse.dbo.dimPlan b
	ON	a.CaseNumber=b.CaseNumber and b.ActiveRecordFlag=1 AND a.ActiveRecordFlag=1
LEFT OUTER JOIN temp.PIIEnv k
	ON	a.SocialSecurityNumber = k.SocialSecurityNumber and a.CaseNumber=k.CaseNumber
INNER JOIN temp.EXPlansEnv env
	ON	a.CaseNumber=env.PlanNumber;

CREATE CLUSTERED INDEX IX_#PartNameAddres_all  
    ON #PartNameAddres(CaseNumber,SocialSecurityNumber); 

INSERT INTO #_ParticipantDetails
SELECT   pna.dimParticipantId AS dimParticipantId
		,pna.dimPlanid AS dimPlanid
		,pna.CaseNumberEnv as CaseNumber
		,pna.PlanName AS PlanName
		,pna.EmployerName as EmployerName
		,ISNULL(pna.SocialSecurityNumberEnv,ps.SocialSecurityNumber) AS SocialSecurityNumber
		,pna.EmployeeNumber as EmployeeNumber
		,UserList AS UserList
		,DivisionList AS DivisionList
		,pna.MultiDivisionFlag AS MultiDivisionFlag
		,pna.FirstName AS FirstName
		,pna.MiddleInitial AS MiddleInitial
		,pna.LastName AS LastName
		,pna.Suffix AS Suffix
		,pna.Gender AS Gender
		,pna.AddressLine1 AS AddressLine1
		,pna.AddressLine2 AS AddressLine2
		,pna.DeliverableStatus AS DeliverableStatus
	    ,pna.AddressStatus AS AddressStatus
		,pna.City AS City
		,pna.StateAbbreviation AS StateAbbreviation
		,pna.StateName AS StateName
		,pna.ZipCode AS ZipCode
		,pna.DayPhoneNumber AS DayPhoneNumber
		,pna.DayPhoneExt AS DayPhoneExt
		,pna.MobilePhoneNumber AS MobilePhoneNumber
		,pna.EveningPhoneNumber AS EveningPhoneNUmber
		,pna.EveningPhoneExt AS EveningPhoneExt
		,pna.EmailAddress AS EmailAddress
		,pna.BirthDate AS BirthDate
		,pna.DeathDate AS DeathDate
        ,pna.HireDate AS HireDate
        ,pna.TerminationDate AS TerminationDate
        ,pna.RehireDate AS RehireDate
        ,pna.LastStatementDate AS LastStatementDate
        ,pna.PartSiteAccess AS PartSiteAccess
        ,pna.IVRAccess AS IVRAccess
        ,pna.SubLocation AS SubLocation
        ,pna.PayRollCycle AS PayRollCycle
        ,pna.HoursWorked AS HoursWorked
        ,pna.MaritalStatus AS MaritalStatus
        ,pna.UserBalances AS UserBalances
		,ps.ReportDate as ReportDate
FROM #_ParticipantDetailsStage ps
INNER JOIN #PartNameAddres pna
	ON	ps.CaseNumber=pna.CaseNumber and ps.SocialSecurityNumber=pna.SocialSecurityNumber

------------------- Final select-----------
-- insert into temp.ParticipantDetails
SELECT   dimParticipantId
		,dimPlanid
		,CaseNumber
        ,PlanName
        ,EmployerName
        ,SocialSecurityNumber
        ,EmployeeNumber
        ,UserList
        ,DivisionList
		,MultiDivisionFlag
        ,FirstName
        ,MiddleInitial
        ,LastName
        ,Suffix
        ,Gender
        ,AddressLine1
        ,AddressLine2
        ,DeliverableStatus
        ,AddressStatus
        ,City
        ,StateAbbreviation
        ,StateName
        ,ZipCode
        ,DayPhoneNumber
        ,DayPhoneExt
        ,MobilePhoneNumber
        ,EveningPhoneNumber
        ,EveningPhoneExt
        ,EmailAddress
        ,BirthDate
        ,DeathDate
        ,HireDate
        ,TerminationDate
        ,ReHireDate
        ,LastStatementDate
        ,PartSiteAccess
        ,IVRAccess
        ,SubLocation
        ,PayRollCycle
        ,HoursWorked
        ,MaritalStatus
        ,UserBalances
        ,ReportDate
FROM #_ParticipantDetails ex


GO
/****** Object:  StoredProcedure [dbo].[usp_Source_ParticipantUser]    Script Date: 6/17/2021 11:04:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_ParticipantUser]
AS
SET NOCOUNT ON;

IF OBJECT_ID('tempdb..#_ParticipantList', 'U') IS NOT NULL
	DROP TABLE #_ParticipantList
SELECT 
		 dp.CaseNumber
		,PlanNumberEnv
		,dp.dimParticipantId
		,EmploymentStatus
		,dp.SocialSecurityNumber
		,EmployeeDivisionCode
		,MultiDivisionIndicator
		,DivisionEmploymentStatus
INTO #_ParticipantList
FROM TRS_BI_Datawarehouse.dbo.dimParticipant dp
JOIN temp.EXPlansEnv ex 
ON dp.CaseNumber=ex.PlanNumber
LEFT JOIN TRS_BI_Datawarehouse.dbo.dimParticipantDivision a WITH (NOLOCK)
		ON dp.dimParticipantId = a.dimParticipantId
WHERE dp.ActiveRecordFlag =1 AND a.ActiveRecordFlag =1;


------ Final Staging Table --------
IF OBJECT_ID('tempdb..#_ParticipantUser', 'U') IS NOT NULL
	DROP TABLE #_ParticipantUser
CREATE TABLE #_ParticipantUser (
    CaseNumber					VARCHAR (20)	NULL,
	PlanNumberEnv				VARCHAR (20)	NULL,
	dimParticipantId			BIGINT			NULL,
	EmploymentStatus			VARCHAR (30)	NULL,
    SocialSecurityNumber		VARCHAR (12)	NULL,
    EmployeeDivisionCode		VARCHAR (100)	NULL,
	MultiDivisionIndicator		VARCHAR (10)	NULL,
	DivisionEmploymentStatus	VARCHAR(30)		NULL,
    UserId						VARCHAR (30)	NULL,
    ReportDate					DATE			NULL
);

--------------Restricted Plans -----------------------------
IF OBJECT_ID('tempdb..#RestrictedPlans', 'U') IS NOT NULL
  DROP TABLE #RestrictedPlans
SELECT DISTINCT
	     PlanNumber,PlanNumberEnv 
INTO #RestrictedPlans
FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT dr
INNER JOIN temp.EXPlansEnv ex
ON (ex.PlanNumberEnv=dr.ACCOUNT_NO);


------------------- Select Participants that belong to EXPlans which are not access restricted ------------------------
IF OBJECT_ID('tempdb..#EXNonRestrParticipants', 'U') IS NOT NULL
	DROP TABLE #EXNonRestrParticipants;
WITH cteCase AS (
	SELECT DISTINCT	
		   PlanNumber AS CaseNumber
		  ,PlanNumberEnv as CaseNumberEnv
	FROM temp.EXPlansEnv WITH (NOLOCK)
	WHERE PlanNumber not in 
		(SELECT PlanNumber from #RestrictedPlans)
)
SELECT DISTINCT
		 CaseNumber
		,PlanNumberEnv
		,dimParticipantId
		,EmploymentStatus
		,SocialSecurityNumber
		,EmployeeDivisionCode
		,MultiDivisionIndicator
		,DivisionEmploymentStatus
		,ISNULL(pa.UserId,'NONE') AS UserId
INTO #EXNonRestrParticipants
FROM #_ParticipantList a
LEFT JOIN temp.PartSearchAccess pa
		ON (a.PlanNumberEnv=pa.PlanNumber)


------------------- Select Participants that belong to EXPlans which are access restricted ------------------------
IF OBJECT_ID('tempdb..#EXRestrParticipants', 'U') IS NOT NULL
	DROP TABLE #EXRestrParticipants;
WITH cteUser as (
	SELECT DISTINCT 
		mp.dimParticipantId
	   ,mp.CaseNumber
	   ,mp.PlanNumberEnv
	   ,mp.EmploymentStatus
	   ,mp.EmployeeDivisionCode
	   ,mp.MultiDivisionIndicator
	   ,mp.DivisionEmploymentStatus
	   ,mp.SocialSecurityNumber
       ,ISNULL(d.USER_I,'NONE') as UserId
	FROM #_ParticipantList mp WITH (NOLOCK)
	INNER JOIN #RestrictedPlans rp
		ON mp.CaseNumber=rp.PlanNumber
	INNER JOIN WorkplaceExperience.ref.PSOL_DIV_ACCESS d WITH (NOLOCK)
		ON mp.EmployeeDivisionCode=d.DIV_NO and rp.PlanNumberEnv=d.ACCOUNT_NO
	INNER JOIN TRS_BI_DataWarehouse.dbo.dimPlan pInfo WITH (NOLOCK)
		ON pInfo.CaseNumber = mp.CaseNumber AND pInfo.ActiveRecordFlag=1
	WHERE (	MultiDivisionIndicator = 'NO'
			OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'TERMED')
			OR (MultiDivisionIndicator = 'YES' AND EmploymentStatus = 'ACTIVE' AND DivisionEmploymentStatus = 'ACTIVE')
		  )
)
SELECT DISTINCT  
	   CaseNumber
      ,PlanNumberEnv
      ,dimParticipantId
      ,EmploymentStatus
      ,SocialSecurityNumber
      ,EmployeeDivisionCode
      ,MultiDivisionIndicator
      ,DivisionEmploymentStatus
      ,UserId
INTO #EXRestrParticipants
FROM cteUser cd

INSERT INTO #_ParticipantUser
SELECT CaseNumber
      ,PlanNumberEnv
      ,dimParticipantId
      ,EmploymentStatus
      ,SocialSecurityNumber
      ,EmployeeDivisionCode
      ,MultiDivisionIndicator
      ,DivisionEmploymentStatus
      ,UserId
	  ,CONVERT(DATE,GETDATE()) AS ReportDate
FROM #EXNonRestrParticipants;

INSERT INTO #_ParticipantUser
SELECT CaseNumber
      ,PlanNumberEnv
      ,dimParticipantId
      ,EmploymentStatus
      ,SocialSecurityNumber
      ,EmployeeDivisionCode
      ,MultiDivisionIndicator
      ,DivisionEmploymentStatus
      ,UserId
	  ,CONVERT(DATE,GETDATE()) AS ReportDate
FROM #EXRestrParticipants;

-- Final select-----------
SELECT CaseNumber
      ,PlanNumberEnv
      ,dimParticipantId
      ,EmploymentStatus
      ,SocialSecurityNumber
      ,EmployeeDivisionCode
      ,MultiDivisionIndicator
      ,DivisionEmploymentStatus
      ,UserId
      ,ReportDate
FROM #_ParticipantUser ex;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_PartSearchAccess]    Script Date: 6/17/2021 11:04:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_PartSearchAccess]
AS
SET NOCOUNT ON;

----- Reference Table for User Access ----
IF OBJECT_ID('tempdb..#_PartSearchAccess', 'U') IS NOT NULL
	DROP TABLE #_PartSearchAccess
CREATE TABLE #_PartSearchAccess(
	PlanNumber VARCHAR(20),
	UserId VARCHAR(20)
);

------Select from Reference Tables -------
INSERT INTO #_PartSearchAccess
SELECT e.account_no AS PlanNumber, 
       e.user_i     AS UserId 
FROM   ref.app_resources a, 
       ref.app_role_res_rel d, 
       ref.app_user_role_rel b, 
       ref.app_ids c, 
       ref.psol_shadow_user e 
WHERE  c.app_desc_t = 'ParisIIISecurity' 
       AND c.app_i = b.app_i 
       AND b.app_i = d.app_i 
       AND d.app_i = a.app_i 
       AND a.resource_n = 'ParticipantSearch' 
       AND a.resource_i = d.resource_i 
       AND d.role_i = b.role_i 
       AND b.user_i = e.shadow_user_i 
       AND e.status_c = 0 
GROUP  BY e.user_i, 
          e.account_no, 
          a.resource_n;

-- Final select
--INSERT INTO temp.PartSearchAccess
SELECT   PlanNumber
	    ,UserId
FROM #_PartSearchAccess ex;

GO
/****** Object:  StoredProcedure [dbo].[usp_Source_SupportTeam]    Script Date: 6/17/2021 11:04:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Source_SupportTeam]
AS
SET NOCOUNT ON;

DECLARE @ReportDate DATE = (SELECT CAST(MAX(DimDateID) AS VARCHAR(8)) FROM [TRS_BI_DataWarehouse].[usr].[Balance]);

DECLARE @DimDateId INT = (SELECT dimDateId FROM [TRS_BI_DataWarehouse].[usr].[DateInfo] WITH (NOLOCK) WHERE DateValue = @ReportDate);

IF OBJECT_ID('tempdb..#_EXSupportTeam', 'U') IS NOT NULL
	DROP TABLE #_EXSupportTeam
CREATE TABLE #_EXSupportTeam (
	PlanNumber VARCHAR(20)
   ,ContractNumber VARCHAR(10)
   ,AffiliateNumber VARCHAR(10)
   ,CompanyName VARCHAR(80)
   ,PlanName VARCHAR(255)
   ,PlanType VARCHAR(80)
   ,PlanCategory VARCHAR(80)
   ,FirstName VARCHAR(51)
   ,LastName VARCHAR(51)
   ,SupportRole VARCHAR(51)
   ,PhoneNumber VARCHAR(12)
   ,EmailAddress VARCHAR(255)
   ,ReportDate DATE
);

WITH cteCase AS (
	SELECT DISTINCT	
		   CaseNumber
		  ,dp.ContractNumber
		  ,dp.AffiliateNumber
		  ,PlanName
		  ,PlanProductType
		  ,ERName
	FROM [TRS_BI_DataWarehouse].[dbo].[dimPlan] dp WITH (NOLOCK)
		INNER JOIN [ref].[EXPlans] ex WITH (NOLOCK)
			ON dp.CaseNumber = ex.PlanNumber
	WHERE ActiveRecordFlag = 1
)
--SELECT * FROM cteCase
INSERT INTO #_EXSupportTeam (
	PlanNumber
   ,ContractNumber
   ,AffiliateNumber
   ,CompanyName
   ,PlanName
   ,PlanType
   ,PlanCategory
   ,FirstName
   ,LastName
   ,SupportRole
   ,ReportDate
)
SELECT cs.CaseNumber
	  ,cs.ContractNumber
	  ,cs.AffiliateNumber
	  ,cs.ERName
	  ,cs.PlanName
	  ,cs.PlanProductType
	  ,CASE WHEN cs.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Defined Benefit'
		    ELSE 'Defined Contribution'
	   END
	  ,RTRIM(SUBSTRING(dic.ClientExecutive, 1, CHARINDEX(' ', dic.ClientExecutive)))
	  ,LTRIM(SUBSTRING(dic.ClientExecutive, CHARINDEX(' ', dic.ClientExecutive), LEN(dic.ClientExecutive) - CHARINDEX(' ', dic.ClientExecutive) + 1))
	  ,'Client Executive'
	  ,@ReportDate
FROM [TRS_BI_DataWarehouse].[dbo].[dimInternalContact] dic WITH (NOLOCK)
	INNER JOIN cteCase cs
		ON dic.ACCOUNT_NO = cs.CaseNumber
WHERE dic.ActiveRecordFlag = 1
UNION ALL
SELECT cs.CaseNumber
	  ,cs.ContractNumber
	  ,cs.AffiliateNumber
	  ,cs.ERName
	  ,cs.PlanName
	  ,cs.PlanProductType
	  ,CASE WHEN cs.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Defined Benefit'
		    ELSE 'Defined Contribution'
	   END
	  --,dic.ClientConsultant
	  ,RTRIM(SUBSTRING(dic.ClientConsultant, 1, CHARINDEX(' ', dic.ClientConsultant)))
	  ,LTRIM(SUBSTRING(dic.ClientConsultant, CHARINDEX(' ', dic.ClientConsultant), LEN(dic.ClientConsultant) - CHARINDEX(' ', dic.ClientConsultant) + 1))
	  ,CASE WHEN cs.PlanProductType IN ('MANAGED DB PLAN','TARGET BENEFIT','CASH BALANCE PLAN','DEFINED BENEFIT PLAN') THEN 'Client Consultant'
		    ELSE 'Account Manager'
	   END
	  ,@ReportDate
FROM [TRS_BI_DataWarehouse].[dbo].[dimInternalContact] dic WITH (NOLOCK)
	INNER JOIN cteCase cs
		ON dic.ACCOUNT_NO = cs.CaseNumber
WHERE dic.ActiveRecordFlag = 1;

-- Retrieving phone number
WITH ctePhone AS (
	SELECT DISTINCT
		   per.FST_MID_NM AS FirstName
		  ,per.LAST_NM AS LastName
		  ,ph.phone_no AS PhoneNumber
	FROM (
			SELECT rel.RELATED_I
				  ,rel.LE_I
				  ,rel.CP_I
			FROM [TRS_BI_Staging].[dbo].[LE_ROLE_CP_REL] rel  WITH (NOLOCK) 
				INNER JOIN (
					SELECT RELATED_I
						  ,LE_ROLE_C
						  ,RELATED_TYP_C
						  ,MAX(MOD_TS) AS MOD_TS
					FROM [TRS_BI_Staging].[dbo].[LE_ROLE_CP_REL] WITH (NOLOCK)
					WHERE LE_ROLE_C = 355
					  AND RELATED_TYP_C = 361
					GROUP BY RELATED_I
							,LE_ROLE_C
							,RELATED_TYP_C
				) latest
					ON rel.RELATED_I = latest.RELATED_I
				   AND rel.LE_ROLE_C = latest.LE_ROLE_C
				   AND rel.RELATED_TYP_C = latest.RELATED_TYP_C
				   AND rel.MOD_TS = latest.MOD_TS
		) rel
		LEFT JOIN [TRS_BI_Staging].[dbo].[PERSON_SEARCH] per WITH (NOLOCK)
			ON rel.LE_I = per.PERSON_I
		LEFT JOIN (
				SELECT rel.LE_I
					  ,tel.PHONE_NO
				FROM [TRS_BI_Staging].[dbo].[LE_ROLE_CP_REL] rel WITH (NOLOCK)
					INNER JOIN [TRS_BI_Staging].[dbo].[LE_TELEPHONE] tel WITH (NOLOCK)
						ON rel.CP_I = tel.CP_I
				WHERE rel.RELATED_I = 1
				  AND rel.LE_ROLE_C = 355
				  AND rel.CP_TYP_C = '3'
	   ) ph
			ON  rel.LE_I = ph.LE_I
	WHERE ph.PHONE_NO IS NOT NULL
)
UPDATE ex
SET ex.PhoneNumber = ph.PhoneNumber
FROM #_EXSupportTeam ex
	INNER JOIN ctePhone ph
		ON ex.FirstName = ph.FirstName
	   AND ex.LastName = ph.LastName;

-- Fix Last Name
UPDATE ex
SET ex.LastName = SUBSTRING(ex.LastName, 1, PATINDEX('% - CR', ex.LastName) - 1)
FROM #_EXSupportTeam ex
WHERE ex.LastName LIKE '%- CR'

IF OBJECT_ID('tempdb..#_EmployeeEmail', 'U') IS NOT NULL
	DROP TABLE #_EmployeeEmail
SELECT EmployeeID
	  ,EmployeeFirstName
	  ,EmployeeMiddleName
	  ,EmployeeLastName
	  ,EmployeeFullName
	  ,EmployeeEmailAddress
INTO #_EmployeeEmail
FROM [ref].[WorkdayEmployee] WITH (NOLOCK);

-- Retrieving email first pass
UPDATE ex
SET ex.EmailAddress = e.EmployeeEmailAddress
FROM #_EXSupportTeam ex
	INNER JOIN #_EmployeeEmail e
		ON ex.LastName = e.EmployeeLastName
	   AND ex.FirstName = e.EmployeeFirstName;

-- Retrieving email second pass
UPDATE ex
SET ex.EmailAddress = e.EmployeeEmailAddress
FROM #_EXSupportTeam ex
	LEFT JOIN #_EmployeeEmail e
		ON e.EmployeeLastName = ex.LastName
	   AND e.EmployeeFirstName LIKE N'%' + ex.FirstName + N'%' 
WHERE ex.EmailAddress IS NULL;

-- Retrieving email third pass
UPDATE ex
SET ex.EmailAddress = e.EmployeeEmailAddress
FROM #_EXSupportTeam ex
	LEFT JOIN #_EmployeeEmail e
		ON e.EmployeeFirstName = ex.FirstName
	   AND e.EmployeeLastName LIKE N'%' + ex.LastName + N'%' 
WHERE ex.EmailAddress IS NULL;

-- Retrieving email fourth pass
UPDATE ex
SET ex.EmailAddress = e.EmployeeEmailAddress
FROM #_EXSupportTeam ex
	LEFT JOIN #_EmployeeEmail e
		ON ex.LastName = e.EmployeeLastName
	   AND ex.FirstName LIKE N'%' + e.EmployeeFirstName + N'%' 
WHERE ex.EmailAddress IS NULL;

-- Retrieving email fifth pass
UPDATE ex
SET ex.EmailAddress = e.EmployeeEmailAddress
FROM #_EXSupportTeam ex
	LEFT JOIN #_EmployeeEmail e
		ON ex.FirstName = e.EmployeeFirstName
	   AND ex.LastName LIKE N'%' + e.EmployeeLastName + N'%' 
WHERE ex.EmailAddress IS NULL;

IF OBJECT_ID('tempdb..#_EmployeeSF', 'U') IS NOT NULL
	DROP TABLE #_EmployeeSF
SELECT FirstName
	  ,LastName
	  ,Email
	  ,FederationIdentifier
	  ,MobilePhone
	  ,Phone
INTO #_EmployeeSF
FROM [ref].[SalesForceEmployee] WITH (NOLOCK);

-- Retrieving email sales force
UPDATE ex
SET ex.EmailAddress = e.Email
FROM #_EXSupportTeam ex
	INNER JOIN #_EmployeeSF e
		ON ex.FirstName = e.FirstName
	   AND ex.LastName = e.LastName
WHERE ex.EmailAddress IS NULL
  AND e.Email IS NOT NULL;

-- Retrieving phone number sales force
UPDATE ex
SET ex.PhoneNumber = SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(Phone)), '(', ''), ')', ''), '-', ''), ' ', ''), 1, 3) + '-'
				   + SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(Phone)), '(', ''), ')', ''), '-', ''), ' ', ''), 4, 3) + '-'
				   + SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(Phone)), '(', ''), ')', ''), '-', ''), ' ', ''), 7, 4)
FROM #_EXSupportTeam ex
	INNER JOIN #_EmployeeSF e
		ON ex.FirstName = e.FirstName
	   AND ex.LastName = e.LastName
WHERE ex.PhoneNumber IS NULL
  AND e.Phone IS NOT NULL;

-- Update email exceptions
UPDATE ex
SET ex.EmailAddress = exc.EmailAddress
FROM #_EXSupportTeam ex
	INNER JOIN [ref].[SupportGroupEmail] exc WITH (NOLOCK)
		ON ex.PlanNumber = exc.PlanNumber
WHERE ex.SupportRole != 'Client Executive'

-- Final select
SELECT env.PlanNumberEnv AS PlanNumber
	  ,ex.ContractNumber
	  ,ex.AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
	  ,PlanCategory
      ,[dbo].[udf_CamelCase](FirstName)
      ,[dbo].[udf_CamelCase](LastName)
	  ,[dbo].[udf_CamelCase](FirstName + ' ' + LastName)
      ,SupportRole
      ,PhoneNumber
      ,LOWER(ex.EmailAddress)
      ,ReportDate
FROM #_EXSupportTeam ex
INNER JOIN temp.EXPlansEnv env
ON ex.PlanNumber=env.PlanNumber;

GO
/****** Object:  StoredProcedure [dbo].[usp_tab_LoadingPlanDeferral]    Script Date: 6/17/2021 11:04:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--=============== 10. SP: [dbo].[usp_tab_LoadingPlanDeferral]

CREATE     PROCEDURE [dbo].[usp_tab_LoadingPlanDeferral]
AS
BEGIN
SET NOCOUNT ON;

DROP TABLE IF EXISTS #tab_PlanDeferral;
CREATE TABLE #tab_PlanDeferral
(
    ACCOUNT_NO CHAR(20) NOT NULL,
	ENRL_PROV_GRP_I DECIMAL(17,0) NOT NULL,
	DEF_GRP_I DECIMAL(17,0) NOT NULL,
	SRC_I DECIMAL(17,0) NOT NULL,
	DEF_GRP_NM VARCHAR(80),
	DOC_NM VARCHAR(50),
	SRC_TYP_C SMALLINT	
); 


INSERT INTO #tab_PlanDeferral (ACCOUNT_NO, ENRL_PROV_GRP_I, DEF_GRP_I, SRC_I, DEF_GRP_NM, DOC_NM, SRC_TYP_C )
  SELECT DISTINCT A.ACCOUNT_NO
      ,C.ENRL_PROV_GRP_I
      ,C.DEF_GRP_I                                -- one plan number may have multiple rows for a def_grp_i/src_i/src_typ_c
      ,C.SRC_I
      ,C.DEF_GRP_NM  
      ,D.DOC_NM
	  ,D.SRC_TYP_C
  FROM [TRS_BI_Staging].[dbo].[PLAN_PROV_GRP] A WITH (NOLOCK) 
    --INNER JOIN [WorkplaceExperience].[ref].[EXPlans] ex ON A.ACCOUNT_NO = ex.PlanNumber  -- ADDED FOR PRODUCTION
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] B WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = B.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_DEFERRAL_GRP] C WITH (NOLOCK)
		ON B.PROVISION_I = C.DEF_GRP_I
	   AND A.ENRL_PROV_GRP_I = C.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_SRC_DETAIL] D WITH (NOLOCK)
		ON C.SRC_I = D.SRC_I
	INNER JOIN [TRS_BI_Staging].[dbo].[PLAN_PROVISION] E WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = E.ENRL_PROV_GRP_I
	INNER JOIN [TRS_BI_Staging].[dbo].[OUTSRC_SERVICE] F WITH (NOLOCK)
		ON A.ENRL_PROV_GRP_I = E.ENRL_PROV_GRP_I
	   AND E.PROVISION_I = F.OUTSRC_I
	INNER JOIN [TRS_BI_Staging].[dbo].[OUTSRC_DEFERRAL] G WITH (NOLOCK)
		ON F.OUTSRC_I = G.OUTSRC_I
  WHERE --A.BUSINESS_LINE <> 'AEGON'
     E.PROV_TYP_C = 80
    AND F.SERV_TYP_C = 7
    AND F.SERV_OFFERING_C = '1'
    AND G.SERV_TYP_C = 7
    AND A.ENRL_STAT_C = 7
    AND B.RELATED_TYP_C IN (26,113)
	and C.DEF_GRP_SEQ_N = (SELECT MIN(DEF_GRP_SEQ_N) 
	                       FROM TRS_BI_Staging.dbo.PLAN_DEFERRAL_GRP F
					       WHERE C.ENRL_PROV_GRP_I = F.ENRL_PROV_GRP_I 
						       AND C.SRC_I = F.SRC_I
						  )
;

DROP TABLE IF EXISTS #tab_EmployeeDeferral;
CREATE TABLE #tab_EmployeeDeferral
(
    CaseNumber VARCHAR(20), 
	ENRL_PROV_GRP_I DECIMAL(17,0), 
	PART_ENRL_I DECIMAL(17,0), 
	SOC_SEC_NO VARCHAR(12), 
	DIV_I DECIMAL(17,0), 
	DEF_GRP_I DECIMAL(17,0), 
	DEF_GRP_NM VARCHAR(80), 
	DOC_NM VARCHAR(50), 
	SRC_I DECIMAL(17,0), 
	SRC_TYP_C SMALLINT, 
	EFF_D DATE, 
	MOD_TS DATETIME2(6), 
	STAT_C CHAR(1), 
	DEF_P NUMERIC(6,3), 
	DEF_A NUMERIC(13,2), 
	rownum1 INT, 
	rownum2 INT
	
); 
INSERT INTO #tab_EmployeeDeferral (CaseNumber, ENRL_PROV_GRP_I, PART_ENRL_I, SOC_SEC_NO, DIV_I, DEF_GRP_I, DEF_GRP_NM, DOC_NM, SRC_I, SRC_TYP_C, EFF_D, MOD_TS, STAT_C, DEF_P, DEF_A, rownum1, rownum2)
SELECT a.CaseNumber
	  ,a.ENRL_PROV_GRP_I
	  ,a.PART_ENRL_I
	  ,a.SOC_SEC_NO	  
	  ,a.DIV_I
	  ,a.DEF_GRP_I
	  ,a.DEF_GRP_NM
	  ,a.DOC_NM
	  ,a.SRC_I
	  ,a.SRC_TYP_C
	  ,a.EFF_D
	  ,a.MOD_TS
	  ,a.STAT_C
	  ,a.DEF_P
	  ,a.DEF_A
	  ,ROW_NUMBER() OVER(PARTITION BY PART_ENRL_I, ENRL_PROV_GRP_I, DEF_GRP_I, SRC_I, [DIV_I]
										ORDER BY EFF_D DESC) AS rownum1
	  ,ROW_NUMBER() OVER(PARTITION BY PART_ENRL_I, ENRL_PROV_GRP_I, DEF_GRP_I, SRC_I,[DIV_I]                                        
										ORDER BY STAT_C ASC, EFF_D DESC) AS rownum2	  	  
FROM
(
    SELECT  b.ACCOUNT_NO AS CaseNumber			
		,b.ENRL_PROV_GRP_I -- dimplanId
		,b.DEF_GRP_I
		,b.DEF_GRP_NM
		,b.SRC_I
		,b.SRC_TYP_C
		,b.DOC_NM
		,c.PART_ENRL_I     --dimParticipantId
		,c.SOC_SEC_NO        --- newly added to handle dimParticipantId=0 (their PART_ENRL_I=0 in dimParticipant table) later
		,CASE WHEN d.[MULTI_PART_DIV_C] = 0 THEN 0
              ELSE c.[DIV_I]
         END AS DIV_I
		,c.EFF_D           --dimDateId
		,c.MOD_TS
		,c.STAT_C
		,CASE WHEN c.DEF_P = 0 THEN NULL ELSE c.DEF_P END AS DEF_P
	    ,CASE WHEN c.DEF_A = 0 THEN NULL ELSE c.DEF_A END AS DEF_A		
		,ROW_NUMBER() OVER(PARTITION BY c.PART_ENRL_I, b.ENRL_PROV_GRP_I, B.DEF_GRP_I, B.SRC_I, 
		                                CASE WHEN d.[MULTI_PART_DIV_C] = 0 THEN 0
                                            ELSE c.[DIV_I]
                                        END, 
										c.EFF_D  ORDER BY c.[MOD_TS] DESC) AS rownum		 
    FROM #tab_PlanDeferral b		
	  INNER JOIN [TRS_BI_Staging].[dbo].[PART_DEF_DATA] c WITH (NOLOCK)	ON b.ENRL_PROV_GRP_I = c.ENRL_PROV_GRP_I
	     AND b.SRC_I = c.SRC_I
	     AND b.DEF_GRP_I = c.DEF_GRP_I
	  INNER JOIN [TRS_BI_Staging].[dbo].[CASE_DATA] d WITH(NOLOCK) ON  b.[ACCOUNT_NO] = d.[CASE_NO]	     
		
) a
WHERE rownum = 1    --- get the corresponding last record for the EFF_D    
;

SELECT
	  a.CaseNumber
	  ,a.ENRL_PROV_GRP_I
	  ,a.PART_ENRL_I
	  ,a.SOC_SEC_NO	  
	  ,a.DIV_I
	  ,a.DEF_GRP_I
	  ,a.DEF_GRP_NM
	  ,a.DOC_NM
	  ,a.SRC_I
	  ,a.SRC_TYP_C
	  ,a.EFF_D
	  ,a.MOD_TS
	  ,a.DEF_P
	  ,a.DEF_A
      ,CASE WHEN (ROW_NUMBER() OVER(PARTITION BY a.CaseNumber, a.PART_ENRL_I, a.DIV_I, a.SRC_I, a.DEF_GRP_I, EOMONTH(a.EFF_D) ORDER BY a.EFF_D DESC)) = 1 THEN 1 ELSE 0 END AS MonthEndFlag
	  ,CASE WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%Pre%'  THEN 'PreTax' 
			WHEN cs.direction = 'EMPLOYEE' AND cs.Roth = 'YES' THEN 'Roth'
		    WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%After%' THEN 'AfterTax'
		END AS theType
	  ,CAST(CONVERT(char(8),a.EFF_D,112) AS INT) AS EffDateId
FROM #tab_EmployeeDeferral a  
  INNER JOIN TRS_BI_DataWarehouse.dbo.dimContributionSource cs WITH (NOLOCK) ON cs.SRC_I = a.SRC_I 
		     AND CASE WHEN a.EFF_D < '2010-10-01' THEN '2010-10-01' ELSE a.EFF_D END BETWEEN cs.EffectiveFrom AND COALESCE(cs.EffectiveTo, '12/31/9999')
WHERE a.rownum2 <= a.rownum1
;
  
END



GO
/****** Object:  StoredProcedure [dbo].[usp_tab_LoadingPlanFlags]    Script Date: 6/17/2021 11:04:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--================ 11. SP: [dbo].[usp_tab_LoadingPlanFlags] 

CREATE   PROCEDURE [dbo].[usp_tab_LoadingPlanFlags] 
AS
BEGIN
SET NOCOUNT ON;

DROP TABLE IF EXISTS #tab_Mapping;
CREATE TABLE #tab_Mapping
(
    ACCOUNT_NO CHAR(20) NOT NULL,
	PROVISION_I DECIMAL(17,0) NOT NULL,
	BUS_LINE_C CHAR(1) NOT NULL
);
INSERT INTO #tab_Mapping (ACCOUNT_NO, PROVISION_I, BUS_LINE_C)
SELECT  A.ACCOUNT_NO, b.PROVISION_I, a.BUS_LINE_C	   	  
FROM   TRS_BI_Staging.dbo.PLAN_PROV_GRP A WITH (NOLOCK)
         INNER JOIN  TRS_BI_Staging.dbo.PLAN_PROVISION B WITH (NOLOCK) ON A.ENRL_PROV_GRP_I = B.ENRL_PROV_GRP_I 
		   AND  A.RELATED_GRP_TYP_C = 361
	       AND  A.ENRL_STAT_C IN (7,20)		    
		   AND  B.PROV_TYP_C = 691	
		   --AND A.BUSINESS_LINE <> 'AEGON'	
	--where a.ACCOUNT_NO = '806314    00000' --PROVISION_I: 34017354538029400
;

DROP TABLE IF EXISTS workplaceExperience.ref.tab_DDOL;
CREATE TABLE workplaceExperience.ref.tab_DDOL (
	[ACCOUNT_NO] [char](20) NOT NULL,
	[SERVICE] [char](80) NOT NULL,
	[ServiceEnabled] [int] NOT NULL,
	[ACCESS_CODE_PROV_I] [decimal](17, 0) NOT NULL,
	[BUS_LINE_C] [int] NULL,
	IncludeFlag tinyint NULL
)
;
WITH Helper AS  
(
  SELECT  
            CASE
               WHEN
                  BUSINESS_LINE = 'TDA' 
               THEN
                  1 
               WHEN
                  BUSINESS_LINE = 'CORP' 
               THEN
                  2 
               WHEN
                  BUSINESS_LINE = 'IS' 
               THEN
                  3 
               WHEN
                  BUSINESS_LINE = 'AEGON' 
               THEN
                  4 
            END
            AS BUS_LINE_C, 
			HLP_TEXT AS SERVICE, 
			'1000' + SUBSTRING(HLP_CODE, 8, 1) AS SITE_RESRC_GRP_C, 
			'00000' AS SITE_RESRC_TYP_C 
         FROM
            TRS_BI_Staging.DBO.HELPER2 
         WHERE
            HLP_CODE LIKE 'DDOLM00%' 
            AND HLP_TEXT IN 
            (
               'AUTO REBALANCE', 'CUSTOM PORTFOLIOS', 'MANAGED ADVICE (DCMA)', 'PORTFOLIO XPRESS', 'RECURRING FUND TRANSFERS', 'DEFERRAL AUTO INCREASE'
            )	
			--and BUSINESS_LINE in ('CORP', 'TDA', 'IS')		
)
INSERT INTO workplaceExperience.ref.tab_DDOL(ACCOUNT_NO, SERVICE, ServiceEnabled, ACCESS_CODE_PROV_I, BUS_LINE_C, IncludeFlag)
SELECT a.ACCOUNT_NO, D.SERVICE, 1 as ServiceEnabled, C.ACCESS_CODE_PROV_I, d.BUS_LINE_C, 1 AS IncludeFlag
FROM TRS_BI_Staging.dbo.ACCESS_CODE_PROV C WITH (NOLOCK) 
     INNER JOIN #tab_Mapping A ON A.PROVISION_I = C.ACCESS_CODE_PROV_I
	 INNER JOIN Helper D ON C.SITE_RESRC_GRP_C = D.SITE_RESRC_GRP_C
                      AND   C.SITE_RESRC_TYP_C = D.SITE_RESRC_TYP_C
					  AND A.BUS_LINE_C = D.BUS_LINE_C     
WHERE  C.SITE_TYP_C = '2' 
		 AND  C.ACCESS_ALLOW_C = '1'
		 AND  C.STATUS_C = '1'   
      --and c.ACCESS_CODE_PROV_I = 34017354538029400   
;

DROP TABLE IF EXISTS #tab_DDOL_Off1;
CREATE TABLE #tab_DDOL_Off1 (
	[ACCESS_CODE_PROV_I] [decimal](17, 0) NOT NULL,
	[SERVICE] [char](80) NOT NULL,
	[BUS_LINE_C] [int] NULL
) 
;
with Helper2 AS
(
  SELECT  CASE
               WHEN
                  BUSINESS_LINE = 'TDA' 
               THEN
                  1 
               WHEN
                  BUSINESS_LINE = 'CORP' 
               THEN
                  2 
               WHEN
                  BUSINESS_LINE = 'IS' 
               THEN
                  3 
               WHEN
                  BUSINESS_LINE = 'AEGON' 
               THEN
                  4 
            END
            AS BUS_LINE_C,
          HLP_TEXT AS [SERVICE],
          '1000' + SUBSTRING(HLP_CODE, 8, 1) AS SITE_RESRC_GRP_C,
          SUBSTRING(HLP_CODE, 8, 1) + SUBSTRING(HLP_LINE_NO, 3, 4) AS SITE_RESRC_TYP_C 
  FROM 
     TRS_BI_Staging.DBO.HELPER2 
  WHERE
     HLP_CODE LIKE 'DDOLM00%' 
	 AND HLP_TEXT IN 
            (
               'AUTO REBALANCE', 'CUSTOM PORTFOLIOS', 'MANAGED ADVICE (DCMA)', 'PORTFOLIO XPRESS', 'RECURRING FUND TRANSFERS', 'DEFERRAL AUTO INCREASE'
            )	
	 --and BUSINESS_LINE in ('CORP', 'TDA', 'IS')
) 
INSERT INTO #tab_DDOL_Off1 (ACCESS_CODE_PROV_I, SERVICE, BUS_LINE_C)
SELECT E.ACCESS_CODE_PROV_I, f.SERVICE, f.BUS_LINE_C
FROM  TRS_BI_Staging.dbo.ACCESS_CODE_PROV E WITH (NOLOCK)
    INNER JOIN #tab_Mapping A ON A.PROVISION_I = e.ACCESS_CODE_PROV_I
	INNER JOIN Helper2 F ON E.SITE_RESRC_GRP_C = F.SITE_RESRC_GRP_C
       AND   E.SITE_RESRC_TYP_C = F.SITE_RESRC_TYP_C   
       AND  (
                E.ACCESS_ALLOW_C = '0'
                OR
                 (E.ACCESS_ALLOW_C = '1' AND E.STATUS_C = '0') 
            ) 
	  AND A.BUS_LINE_C = f.BUS_LINE_C
; --92083

DROP TABLE IF EXISTS #tab_DDOL_Off2;
SELECT G.ACCESS_CODE_PROV_I
  into   #tab_DDOL_Off2   
FROM   TRS_BI_Staging.dbo.ACCESS_CODE_PROV G WITH (NOLOCK)
WHERE    G.SITE_RESRC_GRP_C = '10000'
          AND    G.SITE_RESRC_TYP_C = '00000'
          AND    G.SITE_TYP_C = '2'
          AND    G.ACCESS_ALLOW_C = '0'
          AND    G.STATUS_C = '0'
; --25285

UPDATE a
SET IncludeFlag = 0
FROM workplaceExperience.ref.tab_DDOL as  a
  INNER JOIN #tab_DDOL_Off1 as b ON a.ACCESS_CODE_PROV_I = b.ACCESS_CODE_PROV_I
     and a.SERVICE = b.SERVICE
	 and a.BUS_LINE_C = b.BUS_LINE_C
;-- deleted 92083 rows	 

UPDATE a
SET IncludeFlag = 0
FROM workplaceExperience.ref.tab_DDOL as  a
  INNER JOIN #tab_DDOL_Off2 as b ON a.ACCESS_CODE_PROV_I = b.ACCESS_CODE_PROV_I
; -- deleted 15 rows

TRUNCATE TABLE workplaceExperience.ref.tab_PlanFlags;

INSERT INTO workplaceExperience.ref.tab_PlanFlags (ACCOUNT_NO, SERVICE, ENABLED)
SELECT	b.ACCOUNT_NO, b.SERVICE, B.ServiceEnabled AS ENABLED
FROM workplaceExperience.ref.tab_DDOL AS B
WHERE IncludeFlag = 1
; --85820
 
 -- the other 3 flags: ---
DROP TABLE IF EXISTS #tab_service2tmp;
CREATE TABLE #tab_service2tmp (
	[BUSINESS_LINE] [varchar](10) NULL,
	[REGION] [varchar](80) NULL,
	[CASE_NO] [char](20) NOT NULL,
	[PLAN_NAME] [char](80) NOT NULL,
	[ENRL_STAT_C] [smallint] NOT NULL,
	[FD_NO] [int] NOT NULL,
	[FD_DESC_CD] [char](4) NOT NULL,
	[FUND_NAME] [varchar](51) NULL,
	[STAT_C] [char](1) NOT NULL,
	[FD_CLOSED_D] [date] NULL,
	[ACPT_DT] [varchar](8) NULL,
	[FD_ACTION_CD] [varchar](1) NULL,
	[FD_DISPLAY_CD] [varchar](1) NULL
)
;

WITH cte1 AS
(
   SELECT  
                        A.BUS_LINE_C,
                        D.MAIN_CASE AS ACCOUNT_NO,
                        A.ACCOUNT_NO AS CASE_NO,
                        D.ENRL_STAT_C,
                        D.ER_NAME AS PLAN_NAME,
                        C.FD_SEQ_N AS FD_NO,
                        FD_DESC_CD,
                        UPPER(LTRIM(RTRIM(REPORT_1_FD_NM)) + ' ' + LTRIM(RTRIM(REPORT_2_FD_NM))) AS FUND_NAME,
                        C.FD_PROV_I,
                        C.FD_S,
                        C.STAT_C,
                        C.FD_CLOSED_D 
    FROM
                        TRS_BI_Staging.DBO.PLAN_PROV_GRP A,
                        TRS_BI_Staging.DBO.PLAN_PROVISION B,
                        TRS_BI_Staging.DBO.PLAN_FUND C,
                        (
                           SELECT 
                              ACCOUNT_NO AS MAIN_CASE,
                              ACCOUNT_NO AS RELATED_CASE,
                              PROV_GRP_SRCH_NM AS ER_NAME,
                              ENRL_STAT_C 
                           FROM
                              TRS_BI_Staging.DBO.PLAN_PROV_GRP 
                           WHERE
                              RELATED_GRP_TYP_C = 361 
                           UNION ALL
                           SELECT
                              A.ACCOUNT_NO AS MAIN_CASE,
                              COALESCE(B.ACCOUNT_NO, A.ACCOUNT_NO) AS RELATED_CASE,
                              A.PROV_GRP_SRCH_NM AS ER_NAME,
                              A.ENRL_STAT_C 
                           FROM
                              TRS_BI_Staging.DBO.PLAN_PROV_GRP A,
                              TRS_BI_Staging.DBO.PLAN_PROV_GRP B 
                           WHERE
                              B.RELATED_GRP_I = A.ENRL_PROV_GRP_I 
                              AND A.RELATED_GRP_TYP_C = 361 
                              AND B.RELATED_GRP_TYP_C = 362 
                        )
                        AS D 
                     WHERE
                        A.ENRL_PROV_GRP_I = B.ENRL_PROV_GRP_I 
                        AND B.PROVISION_I = C.FD_PROV_I 
                        AND B.PROV_TYP_C = 15 
                        AND A.RELATED_GRP_TYP_C IN 
                        (
                           361,
                           362
                        )
                        AND A.ACCOUNT_NO = D.RELATED_CASE 
                        AND A.ENRL_STAT_C IN 
                        (
                           7,
                           20
                        ) 
						--AND A.BUSINESS_LINE <> 'AEGON'
)
INSERT INTO #tab_service2tmp ([BUSINESS_LINE], [REGION], [CASE_NO], [PLAN_NAME], [ENRL_STAT_C], [FD_NO], [FD_DESC_CD], [FUND_NAME], [STAT_C], [FD_CLOSED_D], [ACPT_DT], [FD_ACTION_CD], [FD_DISPLAY_CD])
SELECT
               COALESCE(D.BUSINESS_LINE, C.BUSINESS_LINE, B.BUSINESS_LINE) AS BUSINESS_LINE,
               COALESCE(E.HLP_TEXT, '') AS REGION,
               A.ACCOUNT_NO AS CASE_NO,
               A.PLAN_NAME,
               A.ENRL_STAT_C,
               A.FD_NO,
               A.FD_DESC_CD,
               A.FUND_NAME,
               A.STAT_C,
               A.FD_CLOSED_D,
               COALESCE(D.ACPT_DT, '') AS ACPT_DT,
               COALESCE(D.FD_ACTION_CD, '') AS FD_ACTION_CD,
               COALESCE(D.FD_DISPLAY_CD, '') AS FD_DISPLAY_CD 
FROM
               cte1 AS A 
               LEFT JOIN  TRS_BI_Staging.DBO.CASE_DATA AS B 
                  ON A.CASE_NO = B.CASE_NO 
               LEFT JOIN
                  TRS_BI_Staging.DBO.CONTRACT_DATA AS C 
                  ON B.CONT_NO = C.CONT_NO 
               LEFT JOIN
                  TRS_BI_Staging.DBO.CONTRACT_FUND_DATA AS D 
                  ON C.CONT_NO = D.CONT_NO 
                  AND A.FD_S = CAST(D.FD_NO AS SMALLINT) 
               LEFT JOIN
                  TRS_BI_Staging.DBO.HELPER2 AS E 
                  ON A.BUS_LINE_C = E.HLP_VALUE 
                  AND D.BUSINESS_LINE = E.BUSINESS_LINE 
                  AND E.HLP_CODE = 'BUSLINE' 

;
WITH PLAN_FUNDS AS 
(
          SELECT
            A.REGION,
            A.CASE_NO,
            A.PLAN_NAME,
            A.FUND_NAME,
            COALESCE(I.HLP_TEXT, '') AS FUND_TYPE,
            A.FD_DESC_CD,
            A.FD_NO,
            A.ACPT_DT AS FD_EFF_DT,
            A.FD_CLOSED_D,
            D.HLP_TEXT AS FD_STATUS,
            E.HLP_TEXT AS REMIT_ACTION_CD,
            F.HLP_TEXT AS DISPLAY_CD 
		
         FROM #tab_service2tmp A 
            LEFT JOIN
               TRS_BI_Staging.DBO.HELPER2 AS D 
               ON A.STAT_C = D.HLP_VALUE 
               AND A.BUSINESS_LINE = D.BUSINESS_LINE 
               AND D.HLP_CODE = '99907'  -- fund status
            LEFT JOIN
               TRS_BI_Staging.DBO.HELPER2 AS E 
               ON A.FD_ACTION_CD = E.HLP_VALUE 
               AND A.BUSINESS_LINE = E.BUSINESS_LINE 
               AND E.HLP_CODE = 'CTRBALW' 
            LEFT JOIN
               TRS_BI_Staging.DBO.HELPER2 AS F 
               ON A.FD_DISPLAY_CD = F.HLP_VALUE 
               AND A.BUSINESS_LINE = F.BUSINESS_LINE 
               AND F.HLP_CODE = '99907B_X'   -- fund display code
            LEFT JOIN
               TRS_BI_Staging.DBO.HELPER2 AS G 
               ON A.ENRL_STAT_C = CAST(G.HLP_VALUE AS SMALLINT) 
               AND A.BUSINESS_LINE = G.BUSINESS_LINE 
               AND G.HLP_CODE = 'COGSTATC' 
            LEFT JOIN
               TRS_BI_Staging.DBO.FUNDDESC AS H 
               ON A.FD_DESC_CD = H.FD_DESCR_CODE 
               AND A.BUSINESS_LINE = H.BUSINESS_LINE 
            LEFT JOIN
               TRS_BI_Staging.DBO.HELPER2 AS I 
               ON H.FD_TRFR_AGT_CD = I.HLP_VALUE 
               AND A.BUSINESS_LINE = I.BUSINESS_LINE 
               AND I.HLP_CODE = '55112F' 
		WHERE
              F.HLP_TEXT = 'DISPLAY' -- DISPLAY_CD = 'DISPLAY' 
              AND A.FD_CLOSED_D IS NULL 
              AND D.HLP_TEXT = 'ACTIVE' --FD_STATUS = 'ACTIVE'

)
INSERT INTO workplaceExperience.ref.tab_PlanFlags (ACCOUNT_NO, SERVICE, ENABLED)
SELECT DISTINCT
      CASE_NO,
      'PCRA' AS SERVICE,
      1 AS ENABLED 
   FROM PLAN_FUNDS
   WHERE FD_DESC_CD = 'PCRA' 
UNION ALL
SELECT DISTINCT
      CASE_NO,
      'SELF DIRECTED ACCOUNT' AS SERVICE,
      1 AS ENABLED 
   FROM PLAN_FUNDS 
   WHERE FD_DESC_CD LIKE 'NMF%' 
UNION ALL
SELECT DISTINCT
      CASE_NO,
      'SECUREPATH FOR LIFE' AS SERVICE,
      1 AS ENABLED 
   FROM PLAN_FUNDS 
   WHERE FD_DESC_CD IN 
       (
         SELECT DISTINCT FD_DESCR_CODE 
         FROM TRS_BI_Staging.DBO.FUNDDESC 
         WHERE UPPER(REPORT_1_FD_NM) LIKE 'SECUREPATH%' 
            AND (FD_DESCR_CODE LIKE 'TL%' OR FD_DESCR_CODE LIKE 'TF%' )
			--AND BUSINESS_LINE <> 'AEGON'
      )

END

GO
/****** Object:  StoredProcedure [dbo].[usp_tab_LoadingPlanLevelFlags]    Script Date: 6/17/2021 11:04:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--================== 12. SP: [dbo].[usp_tab_LoadingPlanLevelFlags]


CREATE     PROCEDURE [dbo].[usp_tab_LoadingPlanLevelFlags] 
AS
WITH cte1 AS
(
  SELECT  ACCOUNT_NO, 
          --DEF_AMT_PCT_C, 
		  DEFERRAL_METHOD AS DeferralMethod, 
          CASE WHEN PRETAX >= 1 THEN 1 ELSE 0 END AS PreTaxFlag,
          CASE WHEN ROTH >= 1 THEN 1 ELSE 0 END AS RothFlag,
          CASE WHEN AFTERTAX >= 1 THEN 1 ELSE 0 END AS AfterTaxFlag
  FROM
  (
    SELECT  ACCOUNT_NO, 
           DEF_AMT_PCT_C, 
		   DEFERRAL_METHOD, 
           SUM(CASE WHEN THETYPE = 'PreTax' THEN 1 ELSE 0 END) AS PRETAX,
           SUM(CASE WHEN THETYPE = 'Roth' THEN 1 ELSE 0 END) AS ROTH,
           SUM(CASE WHEN THETYPE = 'AfterTax' THEN 1 ELSE 0 END) AS AFTERTAX
    FROM 
    (
       SELECT PPG.ACCOUNT_NO, 
              OD.DEF_AMT_PCT_C,
              COALESCE(HLP.HLP_TEXT,'UNKNOWN') AS DEFERRAL_METHOD, 
              CASE 
                              WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%Pre%' THEN 'PreTax' 
                              WHEN cs.direction = 'EMPLOYEE' AND cs.Roth = 'YES' THEN 'Roth' 
                              WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%After%' THEN 'AfterTax' 
              END AS theType
       FROM TRS_BI_STAGING.DBO.PLAN_PROV_GRP PPG 
          INNER JOIN TRS_BI_STAGING.DBO.PLAN_PROVISION PP ON PPG.ENRL_PROV_GRP_I = PP.ENRL_PROV_GRP_I 
                AND  PPG.RELATED_GRP_TYP_C = 361 
                AND  PP.PROV_TYP_C = 80 				
          INNER JOIN TRS_BI_STAGING.DBO.OUTSRC_SERVICE OS ON PP.PROVISION_I = OS.OUTSRC_I 
                AND  OS.SERV_OFFERING_C = '1'
                AND  OS.SERV_TYP_C = 7 
          INNER JOIN        
          (
                SELECT OUTSRC_I, 
				       DEF_AMT_PCT_C
                FROM   TRS_BI_STAGING.DBO.OUTSRC_DEFERRAL OD 
                WHERE OD.DEF_AMT_PCT_C = ( SELECT MAX(DEF_AMT_PCT_C) 
				                           FROM TRS_BI_STAGING.DBO.OUTSRC_DEFERRAL OD2 
										   WHERE OD.OUTSRC_I = OD2.OUTSRC_I 
										 ) 
          ) AS OD ON OS.OUTSRC_I = OD.OUTSRC_I 
          INNER JOIN TRS_BI_STAGING.DBO.PLAN_PROVISION PP2 ON PPG.ENRL_PROV_GRP_I = PP2.ENRL_PROV_GRP_I 
              AND PPG.RELATED_GRP_TYP_C = 361 
              AND PP2.PROV_TYP_C = 1066
          INNER JOIN TRS_BI_STAGING.DBO.PLAN_DEFERRAL_GRP PDG ON PP2.PROVISION_I = PDG.DEF_GRP_I
              AND PPG.ENRL_PROV_GRP_I = PDG.ENRL_PROV_GRP_I
          INNER JOIN TRS_BI_STAGING.DBO.PLAN_SRC_DETAIL PSD ON PDG.SRC_I = PSD.SRC_I
          INNER JOIN TRS_BI_DATAWAREHOUSE.DBO.DIMCONTRIBUTIONSOURCE CS ON PSD.SRC_I = CS.SRC_I
              AND CS.ACTIVERECORDFLAG = 1
          LEFT JOIN TRS_BI_STAGING.DBO.HELPER2 HLP ON OD.DEF_AMT_PCT_C = HLP.HLP_VALUE 
              AND  HLP.HLP_CODE = 'DEFMETHD' 
              AND  HLP.PKG_ID = 'TDA'
    ) AS A

    GROUP BY  ACCOUNT_NO, 
             DEF_AMT_PCT_C, 
			 DEFERRAL_METHOD
  ) AS A
)
, cte2 AS
(
  SELECT ACCOUNT_NO, 
       [AUTO REBALANCE] AS AutoRebalance,                                                               
       [SELF DIRECTED ACCOUNT] AS SDA,                                                           
       [PORTFOLIO XPRESS] AS PortfolioXpress,                                                                
       [RECURRING FUND TRANSFERS] AS FundTransfer,                                                        
       [MANAGED ADVICE (DCMA)] AS DCMA,                                                           
       [PCRA] AS PCRA,                                                                            
       [SECUREPATH FOR LIFE] AS SecurePathForLife,                                                             
       [DEFERRAL AUTO INCREASE] AS AutoIncrease,                                                          
       [CUSTOM PORTFOLIOS] AS CustomPortfolios
  FROM [WorkplaceExperience].[ref].[tab_PlanFlags] sourceTable
    PIVOT(
           MIN([enabled]) FOR [Service] IN  ([AUTO REBALANCE],                                                               
                                             [SELF DIRECTED ACCOUNT],                                                           
                                             [PORTFOLIO XPRESS],                                                                
                                             [RECURRING FUND TRANSFERS],                                                        
                                             [MANAGED ADVICE (DCMA)],                                                           
                                             [PCRA],                                                                            
                                             [SECUREPATH FOR LIFE],                                                             
                                             [DEFERRAL AUTO INCREASE],                                                          
                                             [CUSTOM PORTFOLIOS])
     ) AS pivotTable    
)
, cte3 AS
(
   SELECT	A.ACCOUNT_NO,
		 MAX(CASE WHEN THETYPE = 'PreTax' then 1 else 0 end) as PretaxContributionFlag,
		 MAX(CASE WHEN THETYPE = 'Roth' THEN 1 ELSE 0 END) AS RothContributionFlag,
		 MAX(CASE WHEN THETYPE = 'AfterTax' THEN 1 ELSE 0 END) AS AfterTaxContributionFlag
   FROM
   (
       SELECT   a.account_no, 
                CASE 
                     WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%Pre%' THEN 'PreTax' 
                     WHEN cs.direction = 'EMPLOYEE' AND cs.Roth = 'YES' THEN 'Roth' 
                     WHEN cs.direction = 'EMPLOYEE' AND cs.PrePostTax = 'YES' AND cs.SourceType LIKE '%After%' THEN 'AfterTax' 
   				  else 'Other'
                END AS theType
       FROM     trs_bi_staging.dbo.plan_prov_grp a 
   	     INNER JOIN trs_bi_staging.dbo.plan_provision b ON a.enrl_prov_grp_i = b.enrl_prov_grp_i
         INNER JOIN TRS_BI_DataWarehouse.dbo.dimContributionSource cs ON b.provision_i = cs.src_i
       WHERE   a.RELATED_GRP_TYP_C = 361
          AND  b.PROV_TYP_C = 13  -- when provision_i is contribution source
          AND 	CS.DIRECTION = 'EMPLOYEE'		  
   ) AS A
   GROUP BY A.ACCOUNT_NO
)
,
cte4 AS
(
   SELECT PPG.ACCOUNT_NO AS CaseNumber,
		   case when SERV_TYP_C = 0 then 'EligibilityTracking' 
		        when SERV_TYP_C = 7 then 'DeferralTracking'
			end AS theflag,
		   CASE WHEN OS.SERV_OFFERING_C = '1' THEN 1
		        WHEN OS.SERV_OFFERING_C = '0' THEN 0
		   END AS provided,
		   oes.SERV_LEV_C
	FROM trs_bi_staging.dbo.PLAN_PROV_GRP ppg
		INNER JOIN trs_bi_staging.dbo.PLAN_PROVISION pp ON ppg.ENRL_PROV_GRP_I = pp.ENRL_PROV_GRP_I
		INNER JOIN trs_bi_staging.dbo.OUTSRC_SERVICE os ON pp.PROVISION_I = os.OUTSRC_I
		left join trs_bi_staging.dbo.OUTSRC_ELIG_SRC oes ON  oes.OUTSRC_I = os.OUTSRC_I and oes.src_i = pp.RELATED_I and oes.STAT_C = 1
	WHERE ppg.RELATED_GRP_TYP_C = 361
			AND pp.PROV_TYP_C = 80
			and os.SERV_TYP_C in (0, 7)  -- 0: deferral (payroll deduction service); 7: eligibility tracking service

)
, cte5 AS
(
   SELECT CaseNumber,
          [EligibilityTracking] as EligibilityTracking,
		  [DeferralTracking] as DeferralTracking,
		  case when SERV_LEV_C = '0' then 1 else 0 end as TA_Calculated_Eligibility  -- 0: TA calculated, 1: client calculated, 3: only for mercer, client managed
   FROM cte4 sourceview
   pivot (
      min(provided) for theflag in ([EligibilityTracking], [DeferralTracking]) 
   ) as pivotTable
)
SELECT d.[dimPlanId]     
      ,d.CaseNumber   
      ,d.[PlanName]
	  ,d.ERName AS CompanyName  
	  ,d.MultiDivision
	  ,d.MultiPartDivision
	  
	  ,CASE WHEN c.ACCOUNT_NO IS NOT NULL THEN 1 ELSE 0 END AS OutsourceDeferralFlag
	  ,COALESCE(c.DeferralMethod, 'NA') AS DeferralMethod
	
      ,COALESCE(c.PreTaxFlag, 0) AS PreTaxFlag
      ,COALESCE(c.RothFlag, 0) AS RothFlag
      ,COALESCE(c.AfterTaxFlag, 0) AS AfterTaxFlag

	  ,COALESCE(p.AutoRebalance, 0) AS AutoRebalance
	  ,COALESCE(p.AutoIncrease, 0) AS AutoIncrease
	  ,COALESCE(p.CustomPortfolios, 0) AS CustomPortfolios
	  ,COALESCE(p.DCMA, 0) AS DCMA
	  ,COALESCE(p.FundTransfer, 0) AS FundTransfer
	  ,COALESCE(p.PCRA, 0) AS PCRA
	  ,COALESCE(p.PortfolioXpress, 0) AS PortfolioXpress
	  ,COALESCE(p.SDA, 0) AS SDA
	  ,COALESCE(p.SecurePathForLife, 0) AS SecurePathForLife

	  ,COALESCE(k.PretaxContributionFlag, 0) AS PretaxContributionFlag
	  ,COALESCE(k.RothContributionFlag, 0) AS RothContributionFlag
	  ,COALESCE(k.AfterTaxContributionFlag, 0) AS AfterTaxContributionFlag
	  ,COALESCE(x.EligibilityTracking, 0) AS  EligibilityTracking
	  ,COALESCE(x.DeferralTracking, 0) AS DeferralTracking
	  ,COALESCE(x.TA_Calculated_Eligibility, 0) AS TA_Calculated_Eligibility
  FROM  [TRS_BI_DataWarehouse].[dbo].[dimPlan] d WITH (NOLOCK)  
    LEFT JOIN cte1 c ON d.CaseNumber = c.ACCOUNT_NO 
	LEFT JOIN cte2 p WITH (NOLOCK) ON d.CaseNumber = p.ACCOUNT_NO
	LEFT JOIN cte3 k ON k.ACCOUNT_NO = d.CaseNumber
	LEFT JOIN cte5 x on d.CaseNumber = x.CaseNumber
  WHERE d.ActiveRecordFlag = 1
    --AND d.BusinessLine <> 'AEGON'
	--AND d.CaseNumber NOT IN (SELECT DISTINCT CaseNumber FROM [TRS_BI_Datawarehouse].[dbo].[dimPlan] WITH (NOLOCK) WHERE businessLine = 'AEGON' AND ActiveRecordFlag = 1)

GO
/****** Object:  StoredProcedure [dbo].[usp_Translate_CaseNumbers]    Script Date: 6/17/2021 11:04:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[usp_Translate_CaseNumbers]
AS
SET NOCOUNT ON;

IF OBJECT_ID('temp.EXPlansEnv','U') IS NOT NULL
	DROP TABLE temp.EXPlansEnv
CREATE TABLE temp.EXPlansEnv(
	PlanNumber varchar(20) NULL,
	PlanNumberEnv varchar(20) NULL,
	ContractNumber varchar(10) NULL,
	AffiliateNumber varchar(10) NULL,
	ContractNumberEnv varchar(20) NULL,
	LoadDatetime datetime NULL
);

INSERT INTO temp.EXPlansEnv
SELECT PlanNumber
	  ,PlanNumberEnv
      ,ContractNumber
	  ,AffiliateNumber
	  ,ContractNumberEnv
      ,LoadDatetime
FROM wxstg.WXPlansRef;

--UPDATE ex
--SET ex.PlanNumberEnv = CASE WHEN LEN(ContractNumber) = 8 THEN ContractNumber + 'JW' + AffiliateNumber
--						 WHEN LEN(ContractNumber) = 7 THEN ContractNumber + 'JW ' + AffiliateNumber
--						 WHEN LEN(ContractNumber) = 6 THEN ContractNumber + 'JW  ' + AffiliateNumber
--						 WHEN LEN(ContractNumber) = 5 THEN ContractNumber + 'JW   ' + AffiliateNumber
--				    END
--FROM temp.EXPlansEnv ex;

--UPDATE ex
--SET ex.PlanNumberEnv = 'QK63040SK 00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'QK63040JW 00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'QK61921GL 00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'QK61921JW 00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'QK61921GL 00002'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'QK61921JW 00002'

--UPDATE ex
--SET ex.PlanNumberEnv = 'QK63041LH 00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'QK63041JW 00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TA069793ME00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TA069793JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TT080191DB00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TT080191JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TI097839JM00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TI097839JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TT069432JM00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TT069432JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TT069433JM00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TT069433JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TI097756EX00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TI097756JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TO097791EX00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TO097791JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TT069365EX00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TT069365JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'JK62197EX 00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'JK62197JW 00001'


--UPDATE ex
--SET ex.PlanNumberEnv = 'MF73176NK 04'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'MF73176JW 04'

--UPDATE ex
--SET ex.PlanNumberEnv = 'QK62158SA 00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'QK62158JW 00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TA069846PN00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TA069846JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TT069090JM00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TT069090JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TT069026DB00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TT069026JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'QK62122LG 00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'QK62122JW 00001'

--UPDATE ex
--SET ex.PlanNumberEnv = 'TA080459LG00001'
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv = 'TA080459JW00001'

--UPDATE ex
--SET ex.PlanNumberEnv = PlanNumber 
--FROM temp.EXPlansEnv ex
--WHERE ex.PlanNumberEnv in ( 'TO097475JW00001' , 'TK097474JW00001','932291JW  00034');

--INSERT INTO temp.EXPlansEnv
--SELECT ref.PlanNumber
--	  ,ref.PlanNumberEnv
--      ,ref.ContractNumber
--	  ,ref.AffiliateNumber
--	  ,ref.ContractNumberEnv
--      ,CURRENT_TIMESTAMP AS LoadDatetime
--FROM temp.EXPlansEnv env
--FULL JOIN wxstg.WXPlansRef ref
--ON env.PlanNumber=ref.PlanNumber 
--WHERE env.PlanNumber is null;

--UPDATE ex
--SET ex.ContractNumberEnv = ref.ContractNumberEnv 
--FROM temp.EXPlansEnv ex
--JOIN wxstg.WXPlansRef ref
--ON ex.PlanNumber=ref.PlanNumber;


GO
/****** Object:  StoredProcedure [dbo].[usp_Translate_PII]    Script Date: 6/17/2021 11:04:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Translate_PII]
AS
SET NOCOUNT ON;

IF OBJECT_ID('tempdb..#PIIEnv','U') IS NOT NULL
	DROP TABLE #PIIEnv
SELECT 
		 CaseNumber
		,SocialSecurityNumber
		,SocialSecurityNumber AS SSNEnv
		,FirstName
		,FirstName AS FirstNameEnv
		,LastName
		,LastName AS LastNameENV
INTO #PIIEnv
FROM TRS_BI_Datawarehouse.dbo.dimParticipant
WHERE ActiveRecordFlag=1;

UPDATE #PIIEnv
SET SSNEnv = REPLACE(SSNEnv,'''','0')
WHERE SSNEnv like '%''%';

UPDATE #PIIEnv
SET SSNEnv = RIGHT(REPLICATE('0',3)+SUBSTRING(SUBSTRING(SSNEnv,1,3),1,CHARINDEX('-',SUBSTRING(SSNEnv,1,3))-1),3)+REPLACE(SUBSTRING(SSNEnv,CHARINDEX('-',SSNEnv),LEN(SSNEnv)),' ','')
WHERE 
		SUBSTRING(SSNEnv,1,3) LIKE '%-%' 
	AND PATINDEX('%[a-zA-Z]%' ,REPLACE(SSNEnv,'-','')) = 0
	AND LEN(RIGHT(REPLICATE('0',3)+SUBSTRING(SUBSTRING(SSNEnv,1,3),1,CHARINDEX('-',SUBSTRING(SSNEnv,1,3))-1),3)+REPLACE(SUBSTRING(SSNEnv,CHARINDEX('-',SSNEnv),LEN(SSNEnv)),' ',''))<=12;

IF OBJECT_ID('tempdb..#SSNEnv','U') IS NOT NULL
	DROP TABLE #SSNEnv
SELECT	 DISTINCT SSNEnv
		,RIGHT(REPLICATE('0',3)+CAST(CASE WHEN CAST(SUBSTRING(SSNEnv,1,3) AS INTEGER) <= 836 THEN CAST(SUBSTRING(SSNEnv,1,3) AS INTEGER) + 163 ELSE 999- CAST(SUBSTRING(SSNEnv,1,3) AS INTEGER) END AS VARCHAR),3) AS SSN1
		,RIGHT(REPLICATE('0',2)+CAST(
				CASE WHEN 
				SUBSTRING(SSNEnv,5,2) = '00' THEN 16
				WHEN CAST(SUBSTRING(SSNEnv,5,2) AS INTEGER) <= 83 THEN CAST(SUBSTRING(SSNEnv,5,2) AS INTEGER) + 16 
				ELSE 99 -CAST(SUBSTRING(SSNEnv,5,2) AS INTEGER) 
				END 
			AS VARCHAR),2) AS SSN2
		,RIGHT(REPLICATE('0',4)+CAST(
				CASE 
				WHEN CAST(SUBSTRING(SSNEnv,8,4) AS INTEGER) <= 7586 THEN CAST(SUBSTRING(SSNEnv,8,4) AS INTEGER) + 2413 
				ELSE 9999 - CAST(SUBSTRING(SSNEnv,8,4) AS INTEGER) 
				END 
			AS VARCHAR),4) AS SSN3
INTO #SSNEnv
FROM #PIIEnv
WHERE	SUBSTRING(SSNEnv,1,3) !='###' 
	AND SUBSTRING(SSNEnv,5,2) NOT LIKE '%-%'
	AND SUBSTRING(SSNEnv,8,4) NOT LIKE '%-%' 
	AND PATINDEX('%[a-zA-Z]%' ,REPLACE(SSNEnv,'-','')) = 0;

IF OBJECT_ID('temp.PIIEnv','U') IS NOT NULL
	DROP TABLE temp.PIIEnv
SELECT 
		 CaseNumber
		,SocialSecurityNumber
		,REVERSE(SSN1)+'-'+REVERSE(SSN2)+'-'+ REVERSE(SSN3) AS SSNEnv
		,FirstName
		,FirstNameEnv
		,LastName
		,LastNameENV
		,CURRENT_TIMESTAMP AS LoadDatetime
INTO	temp.PIIEnv
FROM	#SSNEnv s
JOIN	#PIIEnv p
ON		p.SSNEnv = s.SSNEnv;

CREATE CLUSTERED INDEX IX_#PIIEnv_all  
    ON temp.PIIEnv(CaseNumber,SocialSecurityNumber,SSNEnv);


GO
/****** Object:  StoredProcedure [dbo].[usp_Update_CaseLevelMetrics]    Script Date: 6/17/2021 11:04:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_Update_CaseLevelMetrics]
AS
SET NOCOUNT ON;

IF OBJECT_ID('tempdb..#EXEligibilityMetrics', 'U') IS NOT NULL
	DROP TABLE #EXEligibilityMetrics
SELECT PlanNumber
	  ,COUNT(DISTINCT dimParticipantId) AS EligibleEmployees
	  ,COUNT(DISTINCT CASE WHEN DEF_CHECK > 0 THEN dimParticipantId END) AS ContributingEmployees
	  ,COUNT(DISTINCT dimParticipantId) - COUNT(DISTINCT CASE WHEN DEF_CHECK > 0 THEN dimParticipantId END) AS NonContributingEmployees
	  ,CASE WHEN COUNT(DISTINCT dimParticipantId) < 0 THEN 0
			ELSE CAST(COUNT(DISTINCT CASE WHEN DEF_CHECK > 0 THEN dimParticipantId END) AS DECIMAL(13,4)) / CAST(COUNT(DISTINCT dimParticipantId) AS DECIMAL(13,4))
	   END AS ParticipationRate
	  ,AVG(DEF_PCT) AS AvgContributionRate
	  ,AVG(DEF_AMT) AS AvgContributionAmount
INTO #EXEligibilityMetrics
FROM (
	SELECT PlanNumber
		  ,dimParticipantId
		  ,SUM(DEF_PCT) AS DEF_PCT
		  ,SUM(DEF_AMT) AS DEF_AMT
		  ,SUM(COALESCE(DEF_PCT, 0)) + SUM(COALESCE(DEF_AMT, 0)) AS DEF_CHECK
	FROM (
		SELECT PlanNumber
			  ,dimParticipantId
			  ,DEF_GRP_NM
			  ,AVG(DEF_P) AS DEF_PCT
			  ,SUM(DEF_A) AS DEF_AMT
		FROM [temp].[EligibleEmployees] WITH (NOLOCK)
		GROUP BY PlanNumber
				,dimParticipantId
				,DEF_GRP_NM
	) x
	GROUP BY PlanNumber
			,dimParticipantId
) y
GROUP BY PlanNumber;

UPDATE x
SET x.EligibleEmployees = y.EligibleEmployees
   ,x.ContributingEmployees = y.ContributingEmployees
   ,x.NonContributingEmployees = y.NonContributingEmployees
   ,x.ParticipationRate = y.ParticipationRate
   ,x.AvgContributionRate = y.AvgContributionRate
   ,x.AvgContributionAmount = y.AvgContributionAmount
FROM [temp].[CaseLevelMetrics] x
	INNER JOIN #EXEligibilityMetrics y
		ON x.PlanNumber = y.PlanNumber

GO
/****** Object:  StoredProcedure [ex].[usp_Get_LoadStatus]    Script Date: 6/17/2021 11:04:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [ex].[usp_Get_LoadStatus] (
	@loadStage VARCHAR(100)
)
AS
SET NOCOUNT ON;

DECLARE @loadDate DATETIME;

SET @loadDate=(SELECT MAX(loadDate) FROM ex.LoadStatus WHERE LoadStage=@loadStage);

SELECT LoadStage
      ,LoadDate
      ,LoadStatus
      ,LoadError
  FROM ex.LoadStatus 
 WHERE LoadStage = @loadStage
   AND LoadDate  = @loadDate;

GO
/****** Object:  StoredProcedure [ex].[usp_GetBalanceByFundByDimPlanId]    Script Date: 6/17/2021 11:04:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [ex].[usp_GetBalanceByFundByDimPlanId] (
	@UserId VARCHAR(1000)
   ,@dimPlanId BIGINT
   ,@ReportDate DATE
   ,@UserType VARCHAR(20)
)
AS SET NOCOUNT ON;

DECLARE	@Cases TABLE (
    dimPlanId BIGINT
   ,UserId VARCHAR(100)
);

-- Set ReportDate if input is empty
SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.BalanceByFundCaseLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31') AND dimPlanId=@dimPlanId);

INSERT INTO @Cases
SELECT @dimPlanId
	  ,@UserId

SELECT bcl.PlanNumber AS PlanNumber
      ,ISNULL(ContractNumber, 'Unknown') AS ContractNumber
      ,ISNULL(AffiliateNumber, 'Unknown') AS AffiliateNumber
      ,ISNULL(CompanyName, 'Unknown') AS CompanyName
      ,ISNULL(PlanName, 'Unknown') AS PlanName
      ,ISNULL(PlanType, 'Unknown') AS PlanType
      ,ISNULL(PlanCategory, 'Unknown') AS PlanCategory
	  ,ISNULL(FD_PROV_I,0) AS FD_PROV_I
      ,ISNULL(FundSortOrder,0) AS FundSortOrder
      ,ISNULL(FundStyle,'Unknown') AS FundStyle
	  ,ISNULL(AssetCategory,'Unknown') AS AssetCategory
	  ,ISNULL(AssetClass,'Unknown') AS AssetClass
	  ,ISNULL(FundFamily,'Unknown') AS FundFamily
	  ,ISNULL(FundName,'Unknown') AS FundName
	  ,ISNULL(TickerSymbol,'Unknown') AS TickerSymbol
	  ,ISNULL(Participants, 0) AS Participants
      ,ISNULL(Balance, 0) AS Balance
	  ,ISNULL(UnitCount, 0) AS UnitCount
	  ,ISNULL(bcl.ReportDate,@ReportDate) AS ReportDate
FROM @Cases cs
	INNER JOIN ex.BalanceByFundCaseLevel bcl WITH (NOLOCK)
  ON bcl.dimPlanId=cs.dimPlanId
  AND bcl.ReportDate=@ReportDate
WHERE @UserType = 'InternalPSOL' OR (bcl.PlanNumber NOT IN (SELECT rtrim(replace(ACCOUNT_NO,char(9),'')) FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT))
UNION ALL
SELECT bul.PlanNumber AS PlanNumber
      ,ISNULL(ContractNumber, 'Unknown') AS ContractNumber
      ,ISNULL(AffiliateNumber, 'Unknown') AS AffiliateNumber
      ,ISNULL(CompanyName, 'Unknown') AS CompanyName
      ,ISNULL(PlanName, 'Unknown') AS PlanName
      ,ISNULL(PlanType, 'Unknown') AS PlanType
      ,ISNULL(PlanCategory, 'Unknown') AS PlanCategory
	  ,ISNULL(FD_PROV_I,0) AS FD_PROV_I
      ,ISNULL(FundSortOrder,0) AS FundSortOrder
      ,ISNULL(FundStyle,'Unknown') AS FundStyle
	  ,ISNULL(AssetCategory,'Unknown') AS AssetCategory
	  ,ISNULL(AssetClass,'Unknown') AS AssetClass
	  ,ISNULL(FundFamily,'Unknown') AS FundFamily
	  ,ISNULL(FundName,'Unknown') AS FundName
	  ,ISNULL(TickerSymbol,'Unknown') AS TickerSymbol
	  ,ISNULL(Participants, 0) AS Participants
      ,ISNULL(Balance, 0) AS Balance
	  ,ISNULL(UnitCount, 0) AS UnitCount
	  ,ISNULL(bul.ReportDate,@ReportDate) AS ReportDate
FROM @Cases cs
	INNER JOIN ex.BalanceByFundUserLevel bul WITH (NOLOCK)
		ON bul.dimPlanId = cs.dimPlanId
	   AND bul.UserId = cs.UserId
	   AND bul.ReportDate = @ReportDate
WHERE bul.PlanNumber IN (SELECT rtrim(replace(ACCOUNT_NO,char(9),'')) FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT);

GO
/****** Object:  StoredProcedure [ex].[usp_GetBalanceByFundCaseLevel]    Script Date: 6/17/2021 11:04:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [ex].[usp_GetBalanceByFundCaseLevel] (
	     @UserId VARCHAR(1000)
        ,@CaseNumberList VARCHAR(1000)
		,@DivisionList VARCHAR(1000)
		,@ReportDate DATE
		,@UserType VARCHAR(20)
)
AS SET NOCOUNT ON;

--DECLARE @UserId VARCHAR(1000) = 'ABECKER'
--	   ,@CaseNumberList VARCHAR(1000) = 'JK62394   00001,JK62395   00001,JK62608   00001,TEST,JK62503   00001'
--	   ,@ReportDate DATE

DECLARE	@Cases TABLE (
    Id INT
   ,CaseNumber VARCHAR(20)
   ,UserId VARCHAR(100)
   ,ReportDate DATE   
);

-- Set ReportDate if input is empty
-- SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.MetricsCaseLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31'));

WITH Split(stPos, endPos) AS (
    SELECT 0 AS stPos, CHARINDEX(',', @CaseNumberList) AS endPos
    UNION ALL
    SELECT endPos + 1, CHARINDEX(',', @CaseNumberList, endPos + 1)
    FROM Split
    WHERE endPos > 0
)
INSERT INTO @Cases
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))
      ,SUBSTRING(@CaseNumberList, stPos, COALESCE(NULLIF(endPos, 0), LEN(@CaseNumberList) + 1) - stPos)
	  ,@UserId
	  ,NULL as ReportDate
FROM Split;

UPDATE @Cases
	SET ReportDate=(SELECT MAX(ReportDate) FROM ex.BalanceByFundCaseLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31') and PlanNumber=CaseNumber);

SELECT bcl.dimPlanId as dimPlanId 
	  ,cs.CaseNumber AS PlanNumber
      ,ISNULL(ContractNumber, 'Unknown') AS ContractNumber
      ,ISNULL(AffiliateNumber, 'Unknown') AS AffiliateNumber
      ,ISNULL(CompanyName, 'Unknown') AS CompanyName
      ,ISNULL(PlanName, 'Unknown') AS PlanName
      ,ISNULL(PlanType, 'Unknown') AS PlanType
      ,ISNULL(PlanCategory, 'Unknown') AS PlanCategory
	  ,ISNULL(FD_PROV_I,0) AS FD_PROV_I
      ,ISNULL(FundSortOrder,0) AS FundSortOrder
      ,ISNULL(FundStyle,'Unknown') AS FundStyle
	  ,ISNULL(AssetCategory,'Unknown') AS AssetCategory
	  ,ISNULL(AssetClass,'Unknown') AS AssetClass
	  ,ISNULL(FundFamily,'Unknown') AS FundFamily
	  ,ISNULL(FundName,'Unknown') AS FundName
	  ,ISNULL(Participants, 0) AS Participants
      ,ISNULL(Balance, 0) AS Balance
	  ,ISNULL(UnitCount, 0) AS UnitCount
	  ,ISNULL(cs.ReportDate, bcl.ReportDate) AS ReportDate
FROM @Cases cs
	INNER JOIN ex.BalanceByFundCaseLevel bcl WITH (NOLOCK)
  ON bcl.PlanNumber=cs.CaseNumber
  AND bcl.ReportDate=cs.ReportDate
WHERE @UserType = 'InternalPSOL' OR (cs.CaseNumber NOT IN (SELECT rtrim(replace(ACCOUNT_NO,char(9),'')) FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT))
UNION ALL
SELECT bul.dimPlanId as dimPlanId
	  ,cs.CaseNumber AS PlanNumber
      ,ISNULL(ContractNumber, 'Unknown') AS ContractNumber
      ,ISNULL(AffiliateNumber, 'Unknown') AS AffiliateNumber
      ,ISNULL(CompanyName, 'Unknown') AS CompanyName
      ,ISNULL(PlanName, 'Unknown') AS PlanName
      ,ISNULL(PlanType, 'Unknown') AS PlanType
      ,ISNULL(PlanCategory, 'Unknown') AS PlanCategory
	  ,ISNULL(FD_PROV_I,0) AS FD_PROV_I
      ,ISNULL(FundSortOrder,0) AS FundSortOrder
      ,ISNULL(FundStyle,'Unknown') AS FundStyle
	  ,ISNULL(AssetCategory,'Unknown') AS AssetCategory
	  ,ISNULL(AssetClass,'Unknown') AS AssetClass
	  ,ISNULL(FundFamily,'Unknown') AS FundFamily
	  ,ISNULL(FundName,'Unknown') AS FundName
	  ,ISNULL(Participants, 0) AS Participants
      ,ISNULL(Balance, 0) AS Balance
	  ,ISNULL(UnitCount, 0) AS UnitCount
	  ,ISNULL(cs.ReportDate, bul.ReportDate) AS ReportDate
FROM @Cases cs
	INNER JOIN ex.BalanceByFundUserLevel bul WITH (NOLOCK)
		ON bul.PlanNumber = cs.CaseNumber
	   AND bul.UserId = cs.UserId
	   AND bul.ReportDate = cs.ReportDate
WHERE cs.CaseNumber IN (SELECT rtrim(replace(ACCOUNT_NO,char(9),'')) FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT);

GO
/****** Object:  StoredProcedure [ex].[usp_GetCaseLevelMetrics]    Script Date: 6/17/2021 11:04:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [ex].[usp_GetCaseLevelMetrics] (
	@CaseNumberList	VARCHAR(1000)
   ,@ReportDate DATE = NULL
)
AS
SET NOCOUNT ON;

--DECLARE @CaseNumberList	VARCHAR(1000) = 'TT069459JW00001,TA080459JW00001,TI097862JW00001,TO097872JW00001,TO097883JW00001,TO097935JW00001'
--	   ,@ReportDate	DATE = NULL

DECLARE	@Cases TABLE (
    Id INT
   ,CaseNumber	VARCHAR(20)
);

-- Set ReportDate if input is empty
SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.CaseLevelMetrics WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31'));

WITH Split(stPos, endPos) AS (
    SELECT 0 AS stPos, CHARINDEX(',', @CaseNumberList) AS endPos
    UNION ALL
    SELECT endPos + 1, CHARINDEX(',', @CaseNumberList, endPos + 1)
    FROM Split
    WHERE endPos > 0
)
INSERT INTO @Cases
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))
      ,SUBSTRING(@CaseNumberList, stPos, COALESCE(NULLIF(endPos, 0), LEN(@CaseNumberList) + 1) - stPos)
FROM Split;

SELECT PlanNumber
      ,CompanyName
      ,PlanName
      ,PlanType
	  ,PlanCategory
      ,Participants
      ,ParticipantsActive
      ,ParticipantsTerminated
      ,TotalBalance
      ,AvgParticipantBalance
      ,EligibleEmployees
      ,ContributingEmployees
      ,NonContributingEmployees
      ,ParticipationRate
      ,AvgContributionRate
      ,AvgContributionAmount
      ,EmployeesNotReceivingMatch
      ,TotalOutlooks
      ,OnTrackOutlooks
	  ,UnknownOutlooks
      ,OnTrackOutlookPercentage
	  ,ReportDate
FROM ex.CaseLevelMetrics clm WITH (NOLOCK)
	INNER JOIN @Cases cs
		ON clm.PlanNumber = cs.CaseNumber
WHERE ReportDate = @ReportDate;

GO
/****** Object:  StoredProcedure [ex].[usp_GetFundPerformanceByDimPlanId]    Script Date: 6/17/2021 11:04:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [ex].[usp_GetFundPerformanceByDimPlanId] (@UserId varchar(100),
  @dimPlanId BIGINT,
  @ReportDate date)
AS
SET NOCOUNT ON;

DECLARE	@Cases TABLE (
    dimPlanId BIGINT
   ,UserId VARCHAR(100)
);

  -- Set ReportDate if input is empty
SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.FundPerformanceCaseLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31'))

INSERT INTO @Cases
SELECT @dimPlanId
	  ,@UserId

  SELECT
       cs.dimPlanId
      ,clm.PlanNumber
      ,EnterpriseBusinessLine
      ,AssetCategory
      ,AssetClass
      ,FundStyle
      ,FundFamily
      ,FundDescriptionCode
      ,FundName
      ,FundGroupCode
      ,FundInceptionDate
      ,FundBusinessLine
      ,OneMonthPerformance
      ,ThreeMonthPerformance
      ,YTDPerformance
      ,OneYearPerformance
      ,ThreeYearPerformance
      ,FiveYearPerformance
      ,TenYearPerformance
      ,FifteenYearPerformance
      ,TwentyYearPerformance
      ,PerformanceSinceInception
      ,NetExpenseRatio
      ,GrossExpenseRatio
      ,ReportDate
      ,LoadDate
FROM @Cases cs
	LEFT JOIN ex.FundPerformanceCaseLevel clm WITH (NOLOCK)
		ON clm.dimPlanId = cs.dimPlanId
	   AND clm.ReportDate = @ReportDate
WHERE clm.PlanNumber NOT IN (SELECT ACCOUNT_NO FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT)
UNION ALL
  SELECT
       cs.dimPlanId
      ,clm.PlanNumber
      ,EnterpriseBusinessLine
      ,AssetCategory
      ,AssetClass
      ,FundStyle
      ,FundFamily
      ,FundDescriptionCode
      ,FundName
      ,FundGroupCode
      ,FundInceptionDate
      ,FundBusinessLine
      ,OneMonthPerformance
      ,ThreeMonthPerformance
      ,YTDPerformance
      ,OneYearPerformance
      ,ThreeYearPerformance
      ,FiveYearPerformance
      ,TenYearPerformance
      ,FifteenYearPerformance
      ,TwentyYearPerformance
      ,PerformanceSinceInception
      ,NetExpenseRatio
      ,GrossExpenseRatio
      ,ReportDate
      ,LoadDate
FROM @Cases cs
	LEFT JOIN ex.FundPerformanceCaseLevel clm WITH (NOLOCK)
		ON clm.dimPlanId = cs.dimPlanId
	   AND clm.ReportDate = @ReportDate
	INNER JOIN (
				SELECT DISTINCT 
					 RTRIM(LTRIM(ACCOUNT_NO)) as PlanNumber
					,RTRIM(LTRIM(USER_I)) as UserId
				FROM ref.PSOL_DIV_ACCESS
				) da
		ON clm.PlanNumber=da.PlanNumber
	   AND cs.UserId=da.UserId
WHERE clm.PlanNumber IN (SELECT ACCOUNT_NO FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT);


GO
/****** Object:  StoredProcedure [ex].[usp_GetFundPerformanceCaseLevel]    Script Date: 6/17/2021 11:04:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [ex].[usp_GetFundPerformanceCaseLevel] (
		 @UserId VARCHAR(100)
		,@CaseNumberList VARCHAR(1000)
		,@DivisionList VARCHAR(1000)
		,@ReportDate DATE)
AS
  SET NOCOUNT ON;

DECLARE	@Cases TABLE (
    Id INT
   ,CaseNumber VARCHAR(20)
   ,UserId VARCHAR(100)
   ,ReportDate DATE
);
-- Set ReportDate if input is empty
-- SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.FundPerformanceCaseLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31'));

WITH Split(stPos, endPos) AS (
    SELECT 0 AS stPos, CHARINDEX(',', @CaseNumberList) AS endPos
    UNION ALL
    SELECT endPos + 1, CHARINDEX(',', @CaseNumberList, endPos + 1)
    FROM Split
    WHERE endPos > 0
)
INSERT INTO @Cases
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))
      ,SUBSTRING(@CaseNumberList, stPos, COALESCE(NULLIF(endPos, 0), LEN(@CaseNumberList) + 1) - stPos)
	  ,@UserId
	  ,NULL as ReportDate
FROM Split;

UPDATE @Cases
	SET ReportDate=(SELECT MAX(ReportDate) FROM ex.FundPerformanceCaseLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31') and PlanNumber=CaseNumber);

  SELECT
       fcl.dimPlanId
      ,cs.CaseNumber as PlanNumber
      ,EnterpriseBusinessLine
      ,AssetCategory
      ,AssetClass
      ,FundStyle
      ,FundFamily
      ,FundDescriptionCode
      ,FundName
      ,FundGroupCode
      ,FundInceptionDate
      ,FundBusinessLine
      ,OneMonthPerformance
      ,ThreeMonthPerformance
      ,YTDPerformance
      ,OneYearPerformance
      ,ThreeYearPerformance
      ,FiveYearPerformance
      ,TenYearPerformance
      ,FifteenYearPerformance
      ,TwentyYearPerformance
      ,PerformanceSinceInception
      ,NetExpenseRatio
      ,GrossExpenseRatio
      ,ISNULL(cs.ReportDate,fcl.ReportDate) as ReportDate
      ,LoadDate
FROM @Cases cs
	INNER JOIN ex.FundPerformanceCaseLevel fcl WITH (NOLOCK)
  ON fcl.PlanNumber=cs.CaseNumber
  AND fcl.ReportDate=cs.ReportDate
WHERE cs.CaseNumber NOT IN (SELECT ACCOUNT_NO FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT)
UNION ALL
  SELECT
       fcl.dimPlanId
      ,cs.CaseNumber as PlanNumber
      ,EnterpriseBusinessLine
      ,AssetCategory
      ,AssetClass
      ,FundStyle
      ,FundFamily
      ,FundDescriptionCode
      ,FundName
      ,FundGroupCode
      ,FundInceptionDate
      ,FundBusinessLine
      ,OneMonthPerformance
      ,ThreeMonthPerformance
      ,YTDPerformance
      ,OneYearPerformance
      ,ThreeYearPerformance
      ,FiveYearPerformance
      ,TenYearPerformance
      ,FifteenYearPerformance
      ,TwentyYearPerformance
      ,PerformanceSinceInception
      ,NetExpenseRatio
      ,GrossExpenseRatio
      ,ISNULL(cs.ReportDate,fcl.ReportDate) as ReportDate
      ,LoadDate
FROM @Cases cs
	LEFT JOIN ex.FundPerformanceCaseLevel fcl WITH (NOLOCK)
		ON fcl.PlanNumber = cs.CaseNumber
	   AND fcl.ReportDate = cs.ReportDate
	INNER JOIN (
				SELECT DISTINCT 
					 RTRIM(LTRIM(ACCOUNT_NO)) as PlanNumber
					,RTRIM(LTRIM(USER_I)) as UserId
				FROM ref.PSOL_DIV_ACCESS
				) da
		ON cs.CaseNumber=da.PlanNumber
	   AND cs.UserId=da.UserId
WHERE fcl.PlanNumber IN (SELECT ACCOUNT_NO FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT);


GO
/****** Object:  StoredProcedure [ex].[usp_GetMetricsByDimPlanId]    Script Date: 6/17/2021 11:04:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [ex].[usp_GetMetricsByDimPlanId] (
	@UserId VARCHAR(1000)
   ,@dimPlanId BIGINT
   ,@ReportDate DATE
   ,@UserType VARCHAR(20)
)
AS 
SET NOCOUNT ON;

DECLARE	@Cases TABLE (
    dimPlanId BIGINT
   ,UserId VARCHAR(100)
);

-- Set ReportDate if input is empty
SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.MetricsCaseLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31') AND dimPlanId=@dimPlanId);

INSERT INTO @Cases
SELECT @dimPlanId
	  ,@UserId

SELECT
		 cs.dimPlanId as dimPlanId 
		,mcl.PlanNumber AS PlanNumber
		,ISNULL(mcl.ContractNumber, 'Unknown') AS ContractNumber
		,ISNULL(mcl.AffiliateNumber, 'Unknown') AS AffiliateNumber
		,ISNULL(CompanyName, 'Unknown') AS CompanyName
		,ISNULL(PlanName, 'Unknown') AS PlanName
		,ISNULL(PlanType, 'Unknown') AS PlanType
		,ISNULL(PlanCategory, 'Unknown') AS PlanCategory
		,ISNULL(TotalParticipantCount, 0) AS TotalParticipantCount
		,ISNULL(ActiveParticipantCount, 0) AS ActiveParticipantCount
		,ISNULL(TerminatedParticipantCount, 0) AS TerminatedParticipantCount
		,ISNULL(TotalParticipantCountWithBalance, 0) AS TotalParticipantCountWithBalance
		,ISNULL(ActiveParticipantCountWithBalance, 0) AS ActiveParticipantCountWithBalance
		,ISNULL(TerminatedParticipantCountWithBalance, 0) AS TerminatedParticipantCountWithBalance
		,ISNULL(ParticipationRate,0.00) AS ParticipationRate
		,ISNULL(AvgContributionRate,0.00) AS AvgContributionRate
		,ISNULL(AvgContributionAmount,0.00) AS AvgContributionAmount
		,ISNULL(EligibleEmployeeCount, 0) AS EligibleEmployeeCount
		,ISNULL(ContributingEmployeeCount, 0) AS ContributingEmployeeCount 
		,ISNULL(NonContributingEmployeeCount, 0) AS NonContributingEmployeeCount
		,ISNULL(ActiveParticipantFundBalance, 0.00) AS ActiveParticipantFundBalance 
		,ISNULL(TerminatedParticipantFundBalance, 0.00) AS TerminatedParticipantFundBalance 
		,ISNULL(AvgParticipantFundBalance, 0.00) AS AvgParticipantFundBalance 
		,ISNULL(AvgActiveParticipantFundBalance, 0.00) AS AvgActiveParticipantFundBalance 
		,ISNULL(AvgTerminatedParticipantFundBalance, 0.00) AS AvgTerminatedParticipantFundBalance 
		,ISNULL(ActiveParticipantCoreFunds, 0.00) AS ActiveParticipantCoreFunds 
		,ISNULL(TerminatedParticipantCoreFunds, 0.00) AS TerminatedParticipantCoreFunds 
		,ISNULL(AvgParticipantCoreFund, 0.00) AS AvgParticipantCoreFund 
		,ISNULL(AvgActiveParticipantCoreFund, 0.00) AS AvgActiveParticipantCoreFund 
		,ISNULL(AvgTerminatedParticipantCoreFund, 0.00) AS AvgTerminatedParticipantCoreFund 
		,ISNULL(PCRA_Allowed_Flag,0) AS PCRA_Allowed_Flag
		,ISNULL(ActiveParticipantPCRA, 0.00) AS ActiveParticipantPCRA 
		,ISNULL(TerminatedParticipantPCRA, 0.00) AS TerminatedParticipantPCRA 
		,ISNULL(AvgParticipantPCRA, 0.00) AS AvgParticipantPCRA 
		,ISNULL(AvgActiveParticipantPCRA, 0.00) AS AvgActiveParticipantPCRA
		,ISNULL(AvgTerminatedParticipantPCRA, 0.00) AS AvgTerminatedParticipantPCRA 
		,ISNULL(SDB_Allowed_Flag,0) AS  SDB_Allowed_Flag
		,ISNULL(ActiveParticipantSDB, 0.00) AS ActiveParticipantSDB 
		,ISNULL(TerminatedParticipantSDB, 0.00) AS TerminatedParticipantSDB 
		,ISNULL(AvgParticipantSDB, 0.00) AS AvgParticipantSDB 
		,ISNULL(AvgActiveParticipantSDB, 0.00) AS AvgActiveParticipantSDB 
		,ISNULL(AvgTerminatedParticipantSDB, 0.00) AS AvgTerminatedParticipantSDB 
		,ISNULL(SuspenseBalance, 0.00) AS SuspenseBalance 
		,ISNULL(ForefeitureBalance, 0.00) AS ForefeitureBalance 
		,ISNULL(ExpenseAccountBalance, 0.00) AS ExpenseAccountBalance 
		,ISNULL(AdvancedEmployerBalance, 0.00) AS AdvancedEmployerBalance 
		,ISNULL(ActiveParticipantResidentialLoanBalance, 0.00) AS ActiveParticipantResidentialLoanBalance
		,ISNULL(ActiveParticipantsWithResidentialLoanBalance, 0) AS ActiveParticipantsWithResidentialLoanBalance 
		,ISNULL(ActiveParticipantResidentialHardshipLoanBalance, 0.00) AS ActiveParticipantResidentialHardshipLoanBalance 
		,ISNULL(ActiveParticipantsWithResidentialHardshipLoanBalance, 0) AS ActiveParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(ActiveParticipantPersonalLoanBalance, 0.00) AS ActiveParticipantPersonalLoanBalance 
		,ISNULL(ActiveParticipantsWithPersonalLoanBalance, 0) AS ActiveParticipantsWithPersonalLoanBalance 
		,ISNULL(ActiveParticipantPersonalHardshipLoanBalance, 0.00) AS ActiveParticipantPersonalHardshipLoanBalance 
		,ISNULL(ActiveParticipantsWithPersonalHardshipLoanBalance, 0) AS ActiveParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(ActiveParticipantOtherLoanBalance, 0.00) AS ActiveParticipantOtherLoanBalance 
		,ISNULL(ActiveParticipantsWithOtherLoanBalance, 0) AS ActiveParticipantsWithOtherLoanBalance 
		,ISNULL(TerminatedParticipantResidentialLoanBalance, 0.00) AS TerminatedParticipantResidentialLoanBalance 
		,ISNULL(TerminatedParticipantsWithResidentialLoanBalance, 0) AS TerminatedParticipantsWithResidentialLoanBalance 
		,ISNULL(TerminatedParticipantResidentialHardshipLoanBalance, 0.00) AS TerminatedParticipantResidentialHardshipLoanBalance 
		,ISNULL(TerminatedParticipantsWithResidentialHardshipLoanBalance, 0) AS TerminatedParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(TerminatedParticipantPersonalLoanBalance, 0.00) AS TerminatedParticipantPersonalLoanBalance 
		,ISNULL(TerminatedParticipantsWithPersonalLoanBalance, 0) AS TerminatedParticipantsWithPersonalLoanBalance 
		,ISNULL(TerminatedParticipantPersonalHardshipLoanBalance, 0.00) AS TerminatedParticipantPersonalHardshipLoanBalance 
		,ISNULL(TerminatedParticipantsWithPersonalHardshipLoanBalance, 0) AS TerminatedParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(TerminatedParticipantOtherLoanBalance, 0.00) AS TerminatedParticipantOtherLoanBalance 
		,ISNULL(TerminatedParticipantsWithOtherLoanBalance, 0) AS TerminatedParticipantsWithOtherLoanBalance
		,ISNULL(LoanPermittedFlag,0) AS LoanPermittedFlag
		,ISNULL(ParticipantsPastDue, 0) AS ParticipantsPastDue
		,ISNULL(ReportDate, @ReportDate) AS ReportDate
FROM @Cases cs
	LEFT JOIN ex.MetricsCaseLevel mcl WITH (NOLOCK)
		ON mcl.dimPlanId = cs.dimPlanId
	   AND mcl.ReportDate = @ReportDate
WHERE @UserType = 'InternalPSOL' OR (mcl.PlanNumber NOT IN (SELECT rtrim(replace(ACCOUNT_NO,char(9),'')) FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT))
UNION ALL
SELECT 
		 cs.dimPlanId as dimPlanId 
		,mul.PlanNumber AS PlanNumber
		,ISNULL(mul.ContractNumber, 'Unknown') AS ContractNumber
		,ISNULL(mul.AffiliateNumber, 'Unknown') AS AffiliateNumber
		,ISNULL(CompanyName, 'Unknown') AS CompanyName
		,ISNULL(PlanName, 'Unknown') AS PlanName
		,ISNULL(PlanType, 'Unknown') AS PlanType
		,ISNULL(PlanCategory, 'Unknown') AS PlanCategory
		,ISNULL(TotalParticipantCount, 0) AS TotalParticipantCount
		,ISNULL(ActiveParticipantCount, 0) AS ActiveParticipantCount
		,ISNULL(TerminatedParticipantCount, 0) AS TerminatedParticipantCount
		,ISNULL(TotalParticipantCountWithBalance, 0) AS TotalParticipantCountWithBalance
		,ISNULL(ActiveParticipantCountWithBalance, 0) AS ActiveParticipantCountWithBalance
		,ISNULL(TerminatedParticipantCountWithBalance, 0) AS TerminatedParticipantCountWithBalance
		,ISNULL(ParticipationRate,0.00) AS ParticipationRate
		,ISNULL(AvgContributionRate,0.00) AS AvgContributionRate
		,ISNULL(AvgContributionAmount,0.00) AS AvgContributionAmount
		,ISNULL(EligibleEmployeeCount, 0) AS EligibleEmployeeCount
		,ISNULL(ContributingEmployeeCount, 0) AS ContributingEmployeeCount 
		,ISNULL(NonContributingEmployeeCount, 0) AS NonContributingEmployeeCount
		,ISNULL(ActiveParticipantFundBalance, 0.00) AS ActiveParticipantFundBalance 
		,ISNULL(TerminatedParticipantFundBalance, 0.00) AS TerminatedParticipantFundBalance 
		,ISNULL(AvgParticipantFundBalance, 0.00) AS AvgParticipantFundBalance 
		,ISNULL(AvgActiveParticipantFundBalance, 0.00) AS AvgActiveParticipantFundBalance 
		,ISNULL(AvgTerminatedParticipantFundBalance, 0.00) AS AvgTerminatedParticipantFundBalance 
		,ISNULL(ActiveParticipantCoreFunds, 0.00) AS ActiveParticipantCoreFunds 
		,ISNULL(TerminatedParticipantCoreFunds, 0.00) AS TerminatedParticipantCoreFunds 
		,ISNULL(AvgParticipantCoreFund, 0.00) AS AvgParticipantCoreFund 
		,ISNULL(AvgActiveParticipantCoreFund, 0.00) AS AvgActiveParticipantCoreFund 
		,ISNULL(AvgTerminatedParticipantCoreFund, 0.00) AS AvgTerminatedParticipantCoreFund 
		,ISNULL(PCRA_Allowed_Flag,0) AS PCRA_Allowed_Flag
		,ISNULL(ActiveParticipantPCRA, 0.00) AS ActiveParticipantPCRA 
		,ISNULL(TerminatedParticipantPCRA, 0.00) AS TerminatedParticipantPCRA 
		,ISNULL(AvgParticipantPCRA, 0.00) AS AvgParticipantPCRA 
		,ISNULL(AvgActiveParticipantPCRA, 0.00) AS AvgActiveParticipantPCRA
		,ISNULL(AvgTerminatedParticipantPCRA, 0.00) AS AvgTerminatedParticipantPCRA 
		,ISNULL(SDB_Allowed_Flag,0) AS  SDB_Allowed_Flag
		,ISNULL(ActiveParticipantSDB, 0.00) AS ActiveParticipantSDB 
		,ISNULL(TerminatedParticipantSDB, 0.00) AS TerminatedParticipantSDB 
		,ISNULL(AvgParticipantSDB, 0.00) AS AvgParticipantSDB 
		,ISNULL(AvgActiveParticipantSDB, 0.00) AS AvgActiveParticipantSDB 
		,ISNULL(AvgTerminatedParticipantSDB, 0.00) AS AvgTerminatedParticipantSDB 
		,ISNULL(SuspenseBalance, 0.00) AS SuspenseBalance 
		,ISNULL(ForefeitureBalance, 0.00) AS ForefeitureBalance 
		,ISNULL(ExpenseAccountBalance, 0.00) AS ExpenseAccountBalance 
		,ISNULL(AdvancedEmployerBalance, 0.00) AS AdvancedEmployerBalance 
		,ISNULL(ActiveParticipantResidentialLoanBalance, 0.00) AS ActiveParticipantResidentialLoanBalance
		,ISNULL(ActiveParticipantsWithResidentialLoanBalance, 0) AS ActiveParticipantsWithResidentialLoanBalance 
		,ISNULL(ActiveParticipantResidentialHardshipLoanBalance, 0.00) AS ActiveParticipantResidentialHardshipLoanBalance 
		,ISNULL(ActiveParticipantsWithResidentialHardshipLoanBalance, 0) AS ActiveParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(ActiveParticipantPersonalLoanBalance, 0.00) AS ActiveParticipantPersonalLoanBalance 
		,ISNULL(ActiveParticipantsWithPersonalLoanBalance, 0) AS ActiveParticipantsWithPersonalLoanBalance 
		,ISNULL(ActiveParticipantPersonalHardshipLoanBalance, 0.00) AS ActiveParticipantPersonalHardshipLoanBalance 
		,ISNULL(ActiveParticipantsWithPersonalHardshipLoanBalance, 0) AS ActiveParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(ActiveParticipantOtherLoanBalance, 0.00) AS ActiveParticipantOtherLoanBalance 
		,ISNULL(ActiveParticipantsWithOtherLoanBalance, 0) AS ActiveParticipantsWithOtherLoanBalance 
		,ISNULL(TerminatedParticipantResidentialLoanBalance, 0.00) AS TerminatedParticipantResidentialLoanBalance 
		,ISNULL(TerminatedParticipantsWithResidentialLoanBalance, 0) AS TerminatedParticipantsWithResidentialLoanBalance 
		,ISNULL(TerminatedParticipantResidentialHardshipLoanBalance, 0.00) AS TerminatedParticipantResidentialHardshipLoanBalance 
		,ISNULL(TerminatedParticipantsWithResidentialHardshipLoanBalance, 0) AS TerminatedParticipantsWithResidentialHardshipLoanBalance 
		,ISNULL(TerminatedParticipantPersonalLoanBalance, 0.00) AS TerminatedParticipantPersonalLoanBalance 
		,ISNULL(TerminatedParticipantsWithPersonalLoanBalance, 0) AS TerminatedParticipantsWithPersonalLoanBalance 
		,ISNULL(TerminatedParticipantPersonalHardshipLoanBalance, 0.00) AS TerminatedParticipantPersonalHardshipLoanBalance 
		,ISNULL(TerminatedParticipantsWithPersonalHardshipLoanBalance, 0) AS TerminatedParticipantsWithPersonalHardshipLoanBalance 
		,ISNULL(TerminatedParticipantOtherLoanBalance, 0.00) AS TerminatedParticipantOtherLoanBalance 
		,ISNULL(TerminatedParticipantsWithOtherLoanBalance, 0) AS TerminatedParticipantsWithOtherLoanBalance
		,ISNULL(LoanPermittedFlag,0) AS LoanPermittedFlag
		,ISNULL(ParticipantsPastDue, 0) AS ParticipantsPastDue
		,ISNULL(ReportDate, @ReportDate) AS ReportDate
FROM @Cases cs
	LEFT JOIN ex.MetricsUserLevel mul WITH (NOLOCK)
		ON mul.dimPlanId = cs.dimPlanId
	   AND mul.UserId = cs.UserId
	   AND mul.ReportDate = @ReportDate
	WHERE mul.PlanNumber IN (SELECT rtrim(replace(ACCOUNT_NO,char(9),'')) FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT);

GO
/****** Object:  StoredProcedure [ex].[usp_GetMetricsCaseLevel]    Script Date: 6/17/2021 11:04:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [ex].[usp_GetMetricsCaseLevel] (
	@UserId VARCHAR(1000)
   ,@CaseNumberList VARCHAR(8000)
   ,@DivisionList VARCHAR(10)
   ,@ReportDate DATE
   ,@UserType VARCHAR(20)
)
AS SET NOCOUNT ON;

--DECLARE @UserId VARCHAR(1000) = 'ABECKER'
--	   ,@CaseNumberList VARCHAR(1000) = 'JK62394   00001,JK62395   00001,JK62608   00001,TEST,JK62503   00001'
--	   ,@ReportDate DATE

SELECT @CaseNumberList = (SELECT REPLACE(REPLACE(@CaseNumberList, CHAR(13), ''), CHAR(10), ''))

DECLARE	@Cases TABLE (
    Id INT
   ,CaseNumber VARCHAR(20)
   ,UserId VARCHAR(1000)
   ,ReportDate DATE
);

-- Set ReportDate if input is empty
-- SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.MetricsCaseLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31'));

WITH Split(stPos, endPos) AS (
    SELECT 0 AS stPos, CHARINDEX(',', @CaseNumberList) AS endPos
    UNION ALL
    SELECT endPos + 1, CHARINDEX(',', @CaseNumberList, endPos + 1)
    FROM Split
    WHERE endPos > 0
)
INSERT INTO @Cases
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))
      ,SUBSTRING(@CaseNumberList, stPos, COALESCE(NULLIF(endPos, 0), LEN(@CaseNumberList) + 1) - stPos)
	  ,@UserId
	  ,NULL as ReportDate
FROM Split
OPTION (MAXRECURSION 0);

UPDATE @Cases
	SET ReportDate=(SELECT MAX(ReportDate) FROM ex.MetricsCaseLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31') and PlanNumber=CaseNumber);

SELECT mcl.dimPlanId as dimPlanId
	  ,cs.CaseNumber AS PlanNumber
      ,ISNULL(ContractNumber, 'Unknown') AS ContractNumber
      ,ISNULL(AffiliateNumber, 'Unknown') AS AffiliateNumber
      ,ISNULL(CompanyName, 'Unknown') AS CompanyName
      ,ISNULL(PlanName, 'Unknown') AS PlanName
      ,ISNULL(PlanType, 'Unknown') AS PlanType
      ,ISNULL(PlanCategory, 'Unknown') AS PlanCategory
      ,ISNULL(TotalParticipantCountWithBalance, 0) AS TotalParticipantCount 
      ,ISNULL(ActiveParticipantCountWithBalance, 0) AS ActiveParticipantCount
      ,ISNULL(TerminatedParticipantCountWithBalance, 0) AS TerminatedParticipantCount
      ,ISNULL(ParticipationRate, 0.00) AS ParticipationRate
      ,ISNULL(AvgContributionRate, 0.00) AS AvgContributionRate
      ,ISNULL(AvgContributionAmount, 0.00) AS AvgContributionAmount
      ,ISNULL(EligibleEmployeeCount, 0) AS EligibleEmployeeCount
      ,ISNULL(ContributingEmployeeCount, 0) AS ContributingEmployeeCount
      ,ISNULL(NonContributingEmployeeCount, 0) AS NonContributingEmployeeCount
      ,ISNULL(	ActiveParticipantCoreFunds+TerminatedParticipantCoreFunds
				+
				CASE WHEN PCRA_Allowed_Flag=1 THEN
				ActiveParticipantPCRA+TerminatedParticipantPCRA
				ELSE 0 END
				+
				CASE WHEN SDB_Allowed_Flag=1 THEN
				ActiveParticipantSDB+TerminatedParticipantSDB
				ELSE 0 END
				+
				SuspenseBalance+ForefeitureBalance+ExpenseAccountBalance+AdvancedEmployerBalance
				+
				CASE WHEN LoanPermittedFlag=1 THEN 
				ActiveParticipantResidentialLoanBalance
				+ ActiveParticipantResidentialHardshipLoanBalance
				+ ActiveParticipantPersonalLoanBalance
				+ ActiveParticipantPersonalHardshipLoanBalance
				+ ActiveParticipantOtherLoanBalance
				+ TerminatedParticipantResidentialLoanBalance
				+ TerminatedParticipantResidentialHardshipLoanBalance
				+ TerminatedParticipantPersonalLoanBalance
				+ TerminatedParticipantPersonalHardshipLoanBalance
				+ TerminatedParticipantOtherLoanBalance 
				ELSE 0 END
			,0.00) AS TotalPlanBalance
      ,ISNULL(cs.ReportDate, mcl.ReportDate) AS ReportDate
FROM @Cases cs
	INNER JOIN ex.MetricsCaseLevel mcl WITH (NOLOCK)
		ON mcl.PlanNumber = cs.CaseNumber
	   AND mcl.ReportDate = cs.ReportDate
WHERE @UserType = 'InternalPSOL' OR (cs.CaseNumber NOT IN (SELECT rtrim(replace(ACCOUNT_NO,char(9),'')) FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT))
UNION ALL
SELECT mul.dimPlanId as dimPlanId
	  ,cs.CaseNumber AS PlanNumber
      ,ISNULL(ContractNumber, 'Unknown') AS ContractNumber
      ,ISNULL(AffiliateNumber, 'Unknown') AS AffiliateNumber
      ,ISNULL(CompanyName, 'Unknown') AS CompanyName
      ,ISNULL(PlanName, 'Unknown') AS PlanName
      ,ISNULL(PlanType, 'Unknown') AS PlanType
      ,ISNULL(PlanCategory, 'Unknown') AS PlanCategory
      ,ISNULL(TotalParticipantCountWithBalance, 0) AS TotalParticipantCount 
      ,ISNULL(ActiveParticipantCountWithBalance, 0) AS ActiveParticipantCount
      ,ISNULL(TerminatedParticipantCountWithBalance, 0) AS TerminatedParticipantCount
      ,ISNULL(ParticipationRate, 0.00) AS ParticipationRate
      ,ISNULL(AvgContributionRate, 0.00) AS AvgContributionRate
      ,ISNULL(AvgContributionAmount, 0.00) AS AvgContributionAmount
      ,ISNULL(EligibleEmployeeCount, 0) AS EligibleEmployeeCount
      ,ISNULL(ContributingEmployeeCount, 0) AS ContributingEmployeeCount
      ,ISNULL(NonContributingEmployeeCount, 0) AS NonContributingEmployeeCount
      ,ISNULL(	ActiveParticipantCoreFunds+TerminatedParticipantCoreFunds
				+
				CASE WHEN PCRA_Allowed_Flag=1 THEN
				ActiveParticipantPCRA+TerminatedParticipantPCRA
				ELSE 0 END
				+
				CASE WHEN SDB_Allowed_Flag=1 THEN
				ActiveParticipantSDB+TerminatedParticipantSDB
				ELSE 0 END
				+
				SuspenseBalance+ForefeitureBalance+ExpenseAccountBalance+AdvancedEmployerBalance
				+
				CASE WHEN LoanPermittedFlag=1 THEN 
				ActiveParticipantResidentialLoanBalance
				+ ActiveParticipantResidentialHardshipLoanBalance
				+ ActiveParticipantPersonalLoanBalance
				+ ActiveParticipantPersonalHardshipLoanBalance
				+ ActiveParticipantOtherLoanBalance
				+ TerminatedParticipantResidentialLoanBalance
				+ TerminatedParticipantResidentialHardshipLoanBalance
				+ TerminatedParticipantPersonalLoanBalance
				+ TerminatedParticipantPersonalHardshipLoanBalance
				+ TerminatedParticipantOtherLoanBalance 
				ELSE 0 END
			,0.00) AS TotalPlanBalance
      ,ISNULL(cs.ReportDate, mul.ReportDate) AS ReportDate
FROM @Cases cs
	INNER JOIN ex.MetricsUserLevel mul WITH (NOLOCK)
		ON mul.PlanNumber = cs.CaseNumber
	   AND mul.UserId = cs.UserId
	   AND mul.ReportDate = cs.ReportDate
WHERE cs.CaseNumber IN (SELECT rtrim(replace(ACCOUNT_NO,char(9),'')) FROM WorkplaceExperience.ref.PSOL_DIV_RESTRICT);

GO
/****** Object:  StoredProcedure [ex].[usp_GetNotReceivingMatchMetric]    Script Date: 6/17/2021 11:04:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [ex].[usp_GetNotReceivingMatchMetric] (
	@CaseNumberList	VARCHAR(1000)
   ,@CompanyMatch DECIMAL(5,2)
   ,@ReportDate DATE = NULL
)
AS
SET NOCOUNT ON;

--DECLARE @CaseNumberList	VARCHAR(1000) = 'QK62911JW 00001'--'TT069459JW00001,TA080459JW00001,TI097862JW00001,TO097872JW00001,TO097883JW00001,TO097935JW00001'
--	   ,@CompanyMatch DECIMAL(5,2) = 3.00
--	   ,@ReportDate	DATE = NULL

DECLARE	@Cases TABLE (
    Id INT
   ,CaseNumber	VARCHAR(20)
);

-- Set ReportDate if input is empty
SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.EligibleEmployees WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31'));

WITH Split(stPos, endPos) AS (
    SELECT 0 AS stPos, CHARINDEX(',', @CaseNumberList) AS endPos
    UNION ALL
    SELECT endPos + 1, CHARINDEX(',', @CaseNumberList, endPos + 1)
    FROM Split
    WHERE endPos > 0
)
INSERT INTO @Cases
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))
      ,SUBSTRING(@CaseNumberList, stPos, COALESCE(NULLIF(endPos, 0), LEN(@CaseNumberList) + 1) - stPos)
FROM Split;

SELECT ee.PlanNumber
	  ,clm.CompanyName
      ,clm.PlanName
      ,clm.PlanType
	  ,clm.PlanCategory
	  ,COUNT(DISTINCT CASE WHEN ee.DEF_PCT < @CompanyMatch AND ee.DEF_CHECK > 0 THEN ee.dimParticipantId END) AS EmployeesNotReceivingMatch
	  ,@ReportDate AS ReportDate
FROM (
		SELECT PlanNumber
			  ,dimParticipantId
			  ,SUM(DEF_PCT) AS DEF_PCT
			  ,SUM(DEF_AMT) AS DEF_AMT
			  ,SUM(COALESCE(DEF_PCT, 0)) + SUM(COALESCE(DEF_AMT, 0)) AS DEF_CHECK
		FROM (
			SELECT PlanNumber
				  ,dimParticipantId
				  ,DEF_GRP_NM
				  ,AVG(DEF_P) AS DEF_PCT
				  ,SUM(DEF_A) AS DEF_AMT
			FROM ex.EligibleEmployees ee
				INNER JOIN @Cases cs
					ON ee.PlanNumber = cs.CaseNumber
			GROUP BY PlanNumber
					,dimParticipantId
					,DEF_GRP_NM
		) x
		GROUP BY PlanNumber
				,dimParticipantId
	) ee
	INNER JOIN ex.CaseLevelMetrics clm
		ON ee.PlanNumber = clm.PlanNumber
GROUP BY ee.PlanNumber
		,clm.CompanyName
		,clm.PlanName
		,clm.PlanType
		,clm.PlanCategory;
GO
/****** Object:  StoredProcedure [ex].[usp_GetOutlooksByDimPlanId]    Script Date: 6/17/2021 11:04:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- To Test it:
-- exec [ex].[usp_GetOutlooksByDimPlanId] @userid = 'REGGIE', @dimPlanId = 74, @ReportDate = NULL, @UserType = 'ExternalPSOL';


CREATE PROC [ex].[usp_GetOutlooksByDimPlanId] (
	@UserId VARCHAR(1000)
   ,@dimPlanId BIGINT
   ,@ReportDate DATE
   ,@UserType varchar(20)
)
AS SET NOCOUNT ON;

DECLARE	@Cases TABLE (
    dimPlanId BIGINT
   ,UserId VARCHAR(100)
);

-- Set ReportDate if input is empty
SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.OutlooksUserLevel WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31') AND dimPlanId=@dimPlanId);

INSERT INTO @Cases
SELECT @dimPlanId
	  ,@UserId

;
with cteExternalRestrictedOrInternal as
(
   SELECT  
		 cs.dimPlanId as dimPlanId 
		,oul.UserId 
		,oul.PlanNumber AS PlanNumber		
		,oul.OntrackOutlookCount
		,oul.UnknownOutlookCount
		,oul.NotOntrackOutlookCount
		,oul.TotalOutlookCount
		,oul.OntrackPercentage
   FROM @Cases cs
	LEFT JOIN ex.OutlooksUserLevel oul WITH (NOLOCK)
	  ON oul.dimPlanId = cs.dimPlanId
	   AND oul.ReportDate = @ReportDate		   
       AND ( ( @UserType = 'ExternalPSOL' AND oul.UserId =  cs.UserId) OR 			 
			 ( @UserType = 'InternalPSOL' and oul.UserId = 	'NONE'	)
		   )
)
SELECT cs.dimPlanId as dimPlanId
       ,CASE WHEN c.PlanNumber IS NULL THEN oul.PlanNumber ELSE c.PlanNumber END AS PlanNumber
	   ,ISNULL(CASE WHEN c.OntrackOutlookCount IS NULL THEN oul.OntrackOutlookCount ELSE c.OntrackOutlookCount END, 0) AS OntrackOutlookCount
	   ,ISNULL(CASE WHEN c.UnknownOutlookCount IS NULL THEN oul.UnknownOutlookCount ELSE c.UnknownOutlookCount END, 0) AS UnknownOutlookCount
	   ,ISNULL(CASE WHEN c.NotOntrackOutlookCount IS NULL THEN oul.NotOntrackOutlookCount ELSE c.NotOntrackOutlookCount END, 0) AS NotOntrackOutlookCount
	   ,ISNULL(CASE WHEN c.TotalOutlookCount IS NULL THEN oul.TotalOutlookCount ELSE c.TotalOutlookCount END, 0) AS TotalOutlookCount
	   ,ISNULL(CASE WHEN c.OntrackPercentage IS NULL THEN oul.OntrackPercentage ELSE c.OntrackPercentage END, 0) AS OntrackPercentage
	   ,@ReportDate AS ReportDate
from @Cases cs
	LEFT JOIN ex.OutlooksUserLevel oul WITH (NOLOCK)
	  ON oul.dimPlanId = cs.dimPlanId
	   AND oul.ReportDate = @ReportDate	
	   AND oul.UserId = 'NONE'
	LEFT JOIN cteExternalRestrictedOrInternal c ON c.dimPlanId = cs.dimPlanId and c.UserId = cs.UserId
;

--SELECT  DISTINCT
--		 cs.dimPlanId as dimPlanId 
--		,oul.PlanNumber AS PlanNumber
--		,ISNULL(oul.OntrackOutlookCount, 0) AS OntrackOutlookCount
--		,ISNULL(oul.UnknownOutlookCount, 0) AS UnknownOutlookCount
--		,ISNULL(oul.NotOntrackOutlookCount, 0) AS NotOntrackOutlookCount
--		,ISNULL(oul.TotalOutlookCount, 0) AS TotalOutlookCount
--		,ISNULL(oul.OntrackPercentage, 0) AS OntrackPercentage
--		,ISNULL(oul.ReportDate, @ReportDate) AS ReportDate
--FROM @Cases cs
--	LEFT JOIN ex.OutlooksUserLevel oul WITH (NOLOCK)
--	  ON oul.dimPlanId = cs.dimPlanId
--	   AND oul.UserId = CASE WHEN @UserType = 'ExternalPSOL' and oul.RestrictedCaseFlag=1 
--	                           THEN cs.UserId 
--							 --WHEN @UserType = 'InternalPSOL' THEN 'NONE'	
--							 ELSE 'NONE'					      
--						END	   
--	   AND oul.ReportDate = @ReportDate;


GO
/****** Object:  StoredProcedure [ex].[usp_GetParticpantDetails]    Script Date: 6/17/2021 11:04:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [ex].[usp_GetParticpantDetails] (@casenumber VARCHAR(100))
AS SET NOCOUNT ON;

SELECT	 dimParticipantId as dimParticipantId
		,dimPlanid as dimPlanid
		,CaseNumber as caseNumber
		,PlanName as planName
		,EmployerName as employerName
		,SocialSecurityNumber as socialSecurityNumber
		,EmployeeNumber as employeeNumber
		,UserList as userList
		,DivisionList as divisionList
		,MultiDivisionFlag as multiDivisionFlag
		,FirstName as firstName
		,MiddleInitial as middleInitial
		,LastName as lastName
		,Suffix as suffix
		,Gender as gender
		,AddressLine1 as addressLine1
		,AddressLine2 as addressLine2
		,DeliverableStatus as deliverableStatus
		,AddressStatus as addressStatus
		,City as city
		,StateAbbreviation as stateAbbreviation
		,StateName as stateName
		,ZipCode as zipCode
		,DayPhoneNumber as dayPhoneNumber
		,DayPhoneExt as dayPhoneExt
		,MobilePhoneNumber as mobilePhoneNumber
		,EveningPhoneNumber as eveningPhoneNumber
		,EveningPhoneExt as eveningPhoneExt
		,EmailAddress as emailAddress
		,BirthDate as birthDate
		,DeathDate as deathDate
		,HireDate as hireDate
		,TerminationDate as terminationDate
		,ReHireDate as reHireDate
		,LastStatementDate as lastStatementDate
		,PartSiteAccess as partSiteAccess
		,IVRAccess as iVRAccess
		,SubLocation as subLocation
		,PayRollCycle as payRollCycle
		,HoursWorked as hoursWorked
		,MaritalStatus as maritalStatus
		,UserBalances as userBalances
		,ReportDate as reportDate
		,CONVERT (date, GETDATE()) as loadDate
FROM ex.ParticipantDetails WITH (NOLOCK)
WHERE CaseNumber=@casenumber AND DivisionList IS NOT NULL;

GO
/****** Object:  StoredProcedure [ex].[usp_GetParticpantSearch]    Script Date: 6/17/2021 11:04:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [ex].[usp_GetParticpantSearch] (@casenumber VARCHAR(100))
AS SET NOCOUNT ON;

SELECT dimParticipantId
	  ,dimPlanId
      ,CaseNumber as caseNumber
	  ,PlanName as planName
      ,SocialSecurityNumber as socialSecurityNumber
      ,UserList as userList
	  ,DivisionList as divisionList
	  ,MultiDivisionFlag as multiDivisionFlag
      ,FirstName as firstName
      ,MiddleInitial as middleInitial
      ,LastName as lastName
	  ,Suffix as suffix
	  ,ReportDate as reportDate
	  ,CONVERT (date, GETDATE()) as loadDate
  FROM ex.ParticipantDetails WITH (NOLOCK)
  WHERE CaseNumber=@casenumber AND DivisionList IS NOT NULL;

GO
/****** Object:  StoredProcedure [ex].[usp_GetSupportTeamAttributes]    Script Date: 6/17/2021 11:04:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [ex].[usp_GetSupportTeamAttributes](
	@CaseNumberList	VARCHAR(1000)
   ,@ReportDate DATE = NULL
)
AS
SET NOCOUNT ON;

--DECLARE @CaseNumberList    VARCHAR(1000) = 'JK62232   00001'
--          ,@ReportDate     DATE = NULL

DECLARE	@Cases TABLE (
    Id INT
   ,CaseNumber	VARCHAR(20)
);

-- Set ReportDate if input is empty
SELECT @ReportDate = (SELECT MAX(ReportDate) FROM ex.SupportTeam WHERE ReportDate <= ISNULL(@ReportDate, '9999-12-31'));

WITH Split(stPos, endPos) AS (
    SELECT 0 AS stPos, CHARINDEX(',', @CaseNumberList) AS endPos
    UNION ALL
    SELECT endPos + 1, CHARINDEX(',', @CaseNumberList, endPos + 1)
    FROM Split
    WHERE endPos > 0
)
INSERT INTO @Cases
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1))
      ,SUBSTRING(@CaseNumberList, stPos, COALESCE(NULLIF(endPos, 0), LEN(@CaseNumberList) + 1) - stPos)
FROM Split
OPTION (MAXRECURSION 0);

SELECT PlanNumber
      ,CompanyName
      ,PlanName
      ,PlanType
	  ,PlanCategory
      ,FirstName
      ,LastName
      ,FullName
      ,SupportRole
      ,CASE when EmailAddress = 'stefanie.mcginty@transamerica.com' then '(508) 903-6096' else PhoneNumber END AS PhoneNumber
      ,EmailAddress
      ,ReportDate
FROM ex.SupportTeam st WITH (NOLOCK)
	INNER JOIN @Cases cs
		ON st.PlanNumber = cs.CaseNumber;

GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetAvgContributionByAge]    Script Date: 6/17/2021 11:04:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetAvgContributionByAge] @caseNumber = "QK62540JW 00001", @fromDate = "04/30/2017", @toDate = "12/31/2017", @divisionCodes = "US56,US53,054B" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetAvgContributionByAge] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;


DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);
DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

IF OBJECT_ID('tempdb..#tempEXr1') IS NOT NULL      
    DROP TABLE #tempEXr1  ;
IF OBJECT_ID('tempdb..#tempEXr2') IS NOT NULL      
    DROP TABLE #tempEXr2  ; 

CREATE TABLE #tempEXr1 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   ageBand VARCHAR(10), 
   avgContributionInContributingByAmt NUMERIC(10, 2), 
   avgContributionInContributingByRate NUMERIC(10, 4), 
   avgContributionRateInEligible NUMERIC(5, 4),
   avgContributionAmtInEligible NUMERIC(10, 2)   
);

CREATE TABLE #tempEXr2 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   avgContributionInContributingByAmt NUMERIC(10, 2), 
   avgContributionInContributingByRate NUMERIC(5, 4), 
   avgContributionRateInEligible NUMERIC(5, 4),
   avgContributionAmtInEligible NUMERIC(10, 2)
);

DECLARE @dateStr VARCHAR(200);

IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'WITH cte1 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, CAST("Age[AgeBand]" AS VARCHAR(10)) AS ageBand, "[AvgContributionInContributingAmt]" AS avgContributionInContributingByAmt, "[AvgContributionInContributingRate]" AS avgContributionInContributingByRate, "[AvgContributionInEligibleRate]" AS avgContributionRateInEligible, "[AvgContributionInEligibleAmt]" AS avgContributionAmtInEligible FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Age[AgeBand], Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "AvgContributionInContributingAmt", [AvgContributionInContributingAmt], "AvgContributionInContributingRate", [AvgContributionInContributingRate], "AvgContributionInEligibleRate", [AvgContributionInEligibleRate], "AvgContributionInEligibleAmt", [AvgContributionInEligibleAmt])'' ) 
) INSERT INTO #tempEXr1 (planNumber, planName, companyName, ageBand, avgContributionInContributingByAmt, avgContributionInContributingByRate, avgContributionRateInEligible, avgContributionAmtInEligible)
SELECT planNumber, planName, companyName, ageBand, avgContributionInContributingByAmt, avgContributionInContributingByRate, avgContributionRateInEligible, avgContributionAmtInEligible FROM cte1';

--select @query;

EXEC(@query);

SET @query = 'WITH cte2 AS
(
  SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, "[AvgContributionInContributingAmt]" AS avgContributionInContributingByAmt, "[AvgContributionInContributingRate]" AS avgContributionInContributingByRate, "[AvgContributionInEligibleRate]" AS avgContributionRateInEligible, "[AvgContributionInEligibleAmt]" AS avgContributionAmtInEligible FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "AvgContributionInContributingAmt", [AvgContributionInContributingAmt], "AvgContributionInContributingRate", [AvgContributionInContributingRate], "AvgContributionInEligibleRate", [AvgContributionInEligibleRate], "AvgContributionInEligibleAmt", [AvgContributionInEligibleAmt])'' ) 
) INSERT INTO #tempEXr2 (planNumber, planName, companyName, avgContributionInContributingByAmt, avgContributionInContributingByRate, avgContributionRateInEligible, avgContributionAmtInEligible) 
SELECT planNumber, planName, companyName, avgContributionInContributingByAmt, avgContributionInContributingByRate, avgContributionRateInEligible, avgContributionAmtInEligible FROM cte2';

EXEC(@query);


SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, planNumber, planName, companyName, ageBand, avgContributionInContributingByAmt, avgContributionInContributingByRate, avgContributionRateInEligible, avgContributionAmtInEligible
FROM #tempEXr1
UNION ALL
SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, planNumber, planName, companyName, 'All Ages' AS ageBand, avgContributionInContributingByAmt, avgContributionInContributingByRate, avgContributionRateInEligible, avgContributionAmtInEligible
FROM #tempEXr2
;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetAvgContributionByDivision]    Script Date: 6/17/2021 11:04:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetAvgContributionByDivision] @caseNumber = "QK62540JW 00001", @fromDate = "04/30/2017", @toDate = "12/31/2017", @divisionCodes = "US56,US53,054B" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetAvgContributionByDivision] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;


DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

IF OBJECT_ID('tempdb..#tempEXre1') IS NOT NULL      
    DROP TABLE #tempEXre1  ;

CREATE TABLE #tempEXre1 (
   planNumber VARCHAR(20),
   planName VARCHAR(200), 
   companyName VARCHAR(80), 
   divisionCode VARCHAR(10), 
   divisionName VARCHAR(100), 
   avgContributionInContributingByAmt NUMERIC(10, 2), 
   avgContributionInContributingByRate NUMERIC(5, 4), 
   avgContributionRateInEligible NUMERIC(5, 4),
   avgContributionAmtInEligible NUMERIC(10, 2)
);

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'WITH cte1 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, CAST("Division[DivisionCode]" AS VARCHAR(10)) AS divisionCode, CAST("Division[DivisionName]" AS VARCHAR(100)) AS divisionName, "[AvgContributionInContributingAmt]" AS avgContributionInContributingByAmt, "[AvgContributionInContributingRate]" AS avgContributionInContributingByRate, "[AvgContributionInEligibleRate]" AS avgContributionRateInEligible, "[AvgContributionInEligibleAmt]" AS avgContributionAmtInEligible FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Division[DivisionCode], Division[DivisionName], Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "AvgContributionInContributingAmt", [AvgContributionInContributingAmt], "AvgContributionInContributingRate", [AvgContributionInContributingRate], "AvgContributionInEligibleRate", [AvgContributionInEligibleRate], "AvgContributionInEligibleAmt", [AvgContributionInEligibleAmt])'' ) 
) INSERT INTO #tempEXre1 (planNumber,planName, companyName, divisionCode, divisionName, avgContributionInContributingByAmt, avgContributionInContributingByRate, avgContributionRateInEligible, avgContributionAmtInEligible)
SELECT planNumber,planName, companyName, divisionCode, divisionName, avgContributionInContributingByAmt, avgContributionInContributingByRate, avgContributionRateInEligible, avgContributionAmtInEligible
FROM cte1'
;

EXEC(@query);

SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, planNumber, planName, companyName, divisionCode, divisionName, avgContributionInContributingByAmt, avgContributionInContributingByRate, avgContributionRateInEligible, avgContributionAmtInEligible
FROM #tempEXre1;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetAvgEmployeeContribution]    Script Date: 6/17/2021 11:04:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetAvgEmployeeContribution] @caseNumber = 'QK62625JW 00001', @fromDate = '01/01/2017', @toDate = '12/31/2017';


CREATE   PROCEDURE [ex].[usp_Rpt_GetAvgEmployeeContribution] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;


IF OBJECT_ID('tempdb..#tempEXcontrib2') IS NOT NULL      
    DROP TABLE #tempEXcontrib2  ; 

CREATE TABLE #tempEXcontrib2 (
    planNumber VARCHAR(20), 
    planName VARCHAR(200), 
	companyName VARCHAR(80),
	avgEmployeeContributionAmt NUMERIC(18, 2),
	avgPretaxEmployeeContributionAmt NUMERIC(18, 2), 
	avgRothEmployeeContributionAmt NUMERIC(18, 2),
	avgAfterTaxEmployeeContributionAmt NUMERIC(18, 2)
);


DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END


-- get contribution by EE and ER, avg contributions

SET @query = 'WITH cte2 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, 
  "[AvgEmployeeContributionAmt]" AS avgEmployeeContributionAmt, 
  "[AvgEmployeePretaxContributionAmt]" AS avgPreTaxEmployeeContributionAmt, 
  "[AvgEmployeeRothContributionAmt]" AS avgRothEmployeeContributionAmt, 
  "[AvgEmployeeAfterTaxContributionAmt]" AS avgAfterTaxEmployeeContributionAmt
 FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + 
 '  "AvgEmployeeContributionAmt", [AvgEmployeeContributionAmt], "AvgEmployeePretaxContributionAmt", [AvgEmployeePretaxContributionAmt], 
	"AvgEmployeeRothContributionAmt", [AvgEmployeeRothContributionAmt], "AvgEmployeeAfterTaxContributionAmt", [AvgEmployeeAfterTaxContributionAmt])'' ) 
) INSERT INTO #tempEXcontrib2 (planNumber, planName, companyName, avgEmployeeContributionAmt, avgPretaxEmployeeContributionAmt, avgRothEmployeeContributionAmt, avgAfterTaxEmployeeContributionAmt)
SELECT planNumber, planName, companyName, avgEmployeeContributionAmt, avgPretaxEmployeeContributionAmt, avgRothEmployeeContributionAmt, avgAfterTaxEmployeeContributionAmt 
FROM cte2';

EXEC(@query);

  SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, 
       CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate,
       planNumber, 
	   planName, 
	   companyName, 
  	  
	   avgEmployeeContributionAmt, 
	   avgPreTaxEmployeeContributionAmt, 
	   avgRothEmployeeContributionAmt, 
	   avgAfterTaxEmployeeContributionAmt
  FROM #tempEXcontrib2 


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetAvgEmployeeDeferral]    Script Date: 6/17/2021 11:04:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetAvgEmployeeDeferral] @caseNumber = "QK62298TP 00001", @fromDate = "01/01/2017", @toDate = "12/31/2017" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetAvgEmployeeDeferral] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;


DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;

IF OBJECT_ID('tempdb..#tempEXavgContrib2') IS NOT NULL      
    DROP TABLE #tempEXavgContrib2  ; 

CREATE TABLE #tempEXdeferral2 (
   planNumber VARCHAR(20),  
   planName VARCHAR (200), 
   companyName VARCHAR(80), 

   avgDeferralRate NUMERIC(5, 4),  
   avgPretaxDeferralRate NUMERIC(5, 4),
   avgRothDeferralRate NUMERIC(5, 4),
   avgAfterTaxDeferralRate NUMERIC(5, 4),

   avgDeferralAmt NUMERIC(18, 2),
   avgPretaxDeferralAmt NUMERIC(18, 2), 
   avgRothDeferralAmt NUMERIC(18, 2), 
   avgAfterTaxDeferralAmt NUMERIC(18, 2)
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

-- get average deferral data
SET @query = 'WITH cte1 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName,  
        "[AvgContributionInContributingRate]" AS avgDeferralRate,
		"[AvgPreTaxDeferralRate]" AS avgPretaxDeferralRate,
		"[AvgRothdeferralRate]" AS avgRothdeferralRate, 
        "[AvgAfterTaxDeferralRate]" AS avgAfterTaxDeferralRate, 
        "[AvgContributionInContributingAmt]" AS avgDeferralAmt, 
        "[AvgPreTaxDeferralAmt]" AS avgPreTaxDeferralAmt, 
        "[AvgRothDeferralAmt]" AS avgRothDeferralAmt, 
        "[AvgAfterTaxDeferralAmt]" AS avgAfterTaxDeferralAmt
 FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + 
  ' "AvgContributionInContributingRate", [AvgContributionInContributingRate],
   "AvgPreTaxDeferralRate", [AvgPreTaxDeferralRate], 
   "AvgRothdeferralRate", [AvgRothdeferralRate], 
   "AvgAfterTaxDeferralRate", [AvgAfterTaxDeferralRate], 
   "AvgContributionInContributingAmt", [AvgContributionInContributingAmt], 
   "AvgPreTaxDeferralAmt", [AvgPreTaxDeferralAmt], 
   "AvgRothDeferralAmt", [AvgRothDeferralAmt], 
   "AvgAfterTaxDeferralAmt", [AvgAfterTaxDeferralAmt]  )'' ) 
) INSERT INTO #tempEXdeferral2 
(planNumber, planName, companyName, avgDeferralRate, avgPretaxDeferralRate, avgRothdeferralRate, avgAfterTaxDeferralRate, avgDeferralAmt, avgPreTaxDeferralAmt, avgRothDeferralAmt, avgAfterTaxDeferralAmt)
SELECT planNumber, planName, companyName, avgDeferralRate, avgPretaxDeferralRate, avgRothdeferralRate, avgAfterTaxDeferralRate, avgDeferralAmt, avgPreTaxDeferralAmt, avgRothDeferralAmt, avgAfterTaxDeferralAmt
FROM cte1'
;

EXEC(@query);


SELECT  
       CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, 
       CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, 
	   planNumber, planName, companyName,      
	   b.avgDeferralRate AS avgDeferralRate,
	   b.avgPretaxDeferralRate AS avgPreTaxDeferralRate,
	   b.avgRothDeferralRate AS avgRothDeferralRate,
	   b.avgAfterTaxDeferralRate AS avgAfterTaxDeferralRate,
	   b.avgDeferralAmt AS avgDeferralAmt,
	   b.avgPretaxDeferralAmt AS avgPreTaxDeferralAmt,
	   b.avgRothDeferralAmt AS avgRothDeferralAmt,
	   b.avgAfterTaxDeferralAmt AS avgAfterTaxDeferralAmt
FROM  #tempEXdeferral2 b 



GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetDataRefreshedDate]    Script Date: 6/17/2021 11:04:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [ex].[usp_Rpt_GetDataRefreshedDate]
AS
SET NOCOUNT ON;

SELECT CAST("[LastReportDate]" AS DATE) AS DataRefreshedDate
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')
;

GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetDeferralIndicators]    Script Date: 6/17/2021 11:04:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: 
--EXEC [ex].[usp_Rpt_GetDeferralIndicators] @caseNumber = "JK62395JW 00001";

CREATE Procedure [ex].[usp_Rpt_GetDeferralIndicators] (
 @caseNumber VARCHAR(20)
 --, 
 --@fromDate VARCHAR(10) = NULL, 
 --@toDate VARCHAR(10) = NULL,
 --@divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
--DECLARE @fDate VARCHAR(10) = @fromDate; 
--DECLARE @tDate VARCHAR(10) = @toDate; 
--DECLARE @dCodes VARCHAR(500) = @divisionCodes;

--IF OBJECT_ID('tempdb..#tempEXreportDef') IS NOT NULL      
--    DROP TABLE #tempEXreportDef  ;

--CREATE TABLE #tempEXreportDef (
--   planNumber VARCHAR(20), 
--   planName VARCHAR (200), 
--   companyName VARCHAR(80), 
--   outsourceFlag INTEGER,
--   percentsOnlyFlag INTEGER,
--   percentsOrDollarsFlag INTEGER,  
--   dollarsOnlyFlag INTEGER, 
--   preTaxFlag INTEGER,
--   rothFlag INTEGER,  
--   afterTaxFlag INTEGER
   
--);

DECLARE @query VARCHAR(8000);
--DECLARE @divStr VARCHAR(4000);

--DECLARE @lastReportDate DATE;

--SELECT  @lastReportDate = CAST("[LastReportDate]" AS DATE)
--FROM    OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

--IF (@lastReportDate < CAST(@tDate AS DATE))
--BEGIN
--  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
--END
--;

--DECLARE @dateStr VARCHAR(200);
--IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
--BEGIN 
--  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
--END
--ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
--BEGIN
--  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
--END
--ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
--BEGIN
--  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
--END
--ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
--BEGIN
--  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
--END  	

--IF (@dCodes IS NULL) 
--BEGIN
--  SET @divStr = ''
--END
--ELSE
--BEGIN
--  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
--END


SET @query = '
SELECT planNumber,
       outsourceFlag,
	   CASE WHEN DeferralMethod = ''PERCENTS ONLY'' THEN 1 ELSE 0 END AS  percentsOnlyFlag,
	   CASE WHEN DeferralMethod = ''PERCENTS OR DOLLARS'' THEN 1 ELSE 0 END AS percentsOrDollarsFlag,
	   CASE WHEN DeferralMethod = ''DOLLARS ONLY'' THEN 1 ELSE 0 END AS  dollarsOnlyFlag,
	   COALESCE(preTaxFlag, 0) AS preTaxFlag,
       COALESCE(rothFlag, 0) AS rothFlag,  
       COALESCE(afterTaxFlag, 0) AS afterTaxFlag
FROM
(
  SELECT CAST("Plan[CaseNumber]" AS VARCHAR(20)) AS planNumber, 
	     "Plan[OutsourceDeferralFlag]" AS outsourceFlag, 
	     CAST("Plan[DeferralMethod]" AS VARCHAR(30)) AS DeferralMethod,
		 "Plan[preTaxFlag]" AS preTaxFlag,
		 "Plan[rothFlag]" AS rothFlag, 
		 "Plan[afterTaxFlag]" AS afterTaxFlag	
  FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[CaseNumber], Plan[OutsourceDeferralFlag], Plan[DeferralMethod], Plan[preTaxFlag], Plan[rothFlag], Plan[afterTaxFlag],
                          FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + ' 
						  "NumberOfPlans", [NumberOfPlans])''
			    )
) a'

EXEC(@query);


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetEmployeeContribution]    Script Date: 6/17/2021 11:04:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetEmployeeContribution] @caseNumber = 'TA069793TP00001', @fromDate = '07/01/2018', @toDate = '09/30/2018';


CREATE   PROCEDURE [ex].[usp_Rpt_GetEmployeeContribution] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;


IF OBJECT_ID('tempdb..#tempEXcontrib2') IS NOT NULL      
    DROP TABLE #tempEXcontrib2  ; 
IF OBJECT_ID('tempdb..#tempEXcontrib5') IS NOT NULL      
    DROP TABLE #tempEXcontrib5 ;
IF OBJECT_ID('tempdb..#tempEXcontrib6') IS NOT NULL      
    DROP TABLE #tempEXcontrib6  ; 

CREATE TABLE #tempEXcontrib2 (
    planNumber VARCHAR(20), 
    planName VARCHAR(200), 
	companyName VARCHAR(80),
	employeeContribution NUMERIC(18, 2),
	employerContribution NUMERIC(18, 2)
);

CREATE TABLE #tempEXcontrib5 (
    planNumber VARCHAR(20), 
	planName VARCHAR(200), 
	companyName VARCHAR(80),
	rolloverAmt NUMERIC(18, 2),
	rolloverPPTCnt INTEGER
);

CREATE TABLE #tempEXcontrib6 (
    planNumber VARCHAR(20), 
	planName VARCHAR(200), 
	companyName VARCHAR(80),
	ContractExchangeAmt NUMERIC(18, 2),
	ContractExchangePPTCnt INTEGER
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END


-- get contribution by EE and ER, avg contributions

SET @query = 'WITH cte2 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, 
  "[EmployeeContributionAmt]" AS employeeContribution, "[EmployerContributionAmt]" AS employerContribution
 FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + 
 '  "EmployerContributionAmt", [EmployerContributionAmt], "EmployeeContributionAmt", [EmployeeContributionAmt])'' ) 
) INSERT INTO #tempEXcontrib2 (planNumber, planName, companyName, employeeContribution, employerContribution)
SELECT planNumber, planName, companyName, employeeContribution, employerContribution 
FROM cte2';

EXEC(@query);

-- get contract exchange and rollover

SET @query = 'WITH cte5 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, "[TransactionAmount]" AS rolloverAmt, "[ParticipantCnt]" AS rolloverPPTCnt 
 FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' FILTER(VALUES(Transactions[TransactionCategory]), (Transactions[TransactionCategory] = "MoneyIn")), FILTER(VALUES(Transactions[TransactionType]), (Transactions[TransactionType] = "Rollover")), "ParticipantCnt", [ParticipantCnt], "TransactionAmount", [TransactionAmount])'' ) 
) INSERT INTO #tempEXcontrib5 (planNumber, planName, companyName, rolloverAmt, rolloverPPTCnt)
SELECT planNumber, planName, companyName, rolloverAmt, rolloverPPTCnt
FROM cte5';

EXEC(@query);

SET @query = 'WITH cte6 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, "[TransactionAmount]" AS ContractExchangeAmt, "[ParticipantCnt]" AS ContractExchangePPTCnt 
 FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' FILTER(VALUES(Transactions[TransactionCategory]), (Transactions[TransactionCategory] = "MoneyIn")), FILTER(VALUES(Transactions[TransactionType]), (Transactions[TransactionType] = "Takeover")), FILTER(VALUES(Transactions[TransactionSubType]), (Transactions[TransactionSubType] = "CONTRACT EXCHANGE")), "ParticipantCnt", [ParticipantCnt], "TransactionAmount", [TransactionAmount])'' ) 
) INSERT INTO #tempEXcontrib6 (planNumber, planName, companyName, ContractExchangeAmt, ContractExchangePPTCnt)
SELECT planNumber, planName, companyName, ContractExchangeAmt, ContractExchangePPTCnt 
FROM cte6';

EXEC(@query);

SELECT *
FROM
(
  SELECT MAX(fromDate) AS fromDate, 
       MAX(toDate) AS toDate,
	   MAX(planNumber) AS planNumber,
	   MAX(planName) AS planName,
	   MAX(companyName) AS companyName,
	   MAX(employeeContribution) AS employeeContribution,
	   MAX(employerContribution) AS employerContribution,
	   MAX(totalContribution) AS totalContribution,
	   MAX(rolloverAmt) AS rolloverAmt,
	   MAX(rolloverPPTCnt) AS rolloverPPTCnt,
	   MAX(contractExchangeAmt) AS contractExchangeAmt,
	   MAX(contractExchangePPTCnt) AS contractExchangePPTCnt

 FROM ( 
  SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, 
       CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate,
       planNumber, 
	   planName, 
	   companyName, 
  	  
	   employeeContribution, 
	   employerContribution, 
	   COALESCE(employeeContribution, 0) + COALESCE(employerContribution, 0) AS totalContribution,
	   NULL AS rolloverAmt,
	   NULL AS rolloverPPTCnt,
	   NULL AS contractExchangeAmt,
	   NULL AS contractExchangePPTCnt
  FROM #tempEXcontrib2 
  UNION ALL
  SELECT  CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, 
       CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate,
       planNumber, 
	   planName, 
	   companyName, 

	   NULL AS employeeContribution,
	   NULL AS employerContribution,
	   NULL AS totalContribution, 
	   rolloverAmt, 
	   rolloverPPTCnt,
	   NULL AS contractExchangeAmt,
	   NULL AS contractExchangePPTCnt
  FROM #tempEXcontrib5
  UNION ALL
  SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, 
       CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate,
       planNumber, 
	   planName, 
	   companyName,
	   
	   NULL AS employeeContribution,
	   NULL AS employerContribution,
	   NULL AS totalContribution,
	   NULL AS rolloverAmt,
	   NULL AS rolloverPPTCnt, 
	   contractExchangeAmt, 
	   contractExchangePPTCnt
  FROM #tempEXcontrib6 
 ) a
)b
WHERE b.fromDate IS NOT NULL


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetEmployeeDeferral]    Script Date: 6/17/2021 11:04:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetEmployeeDeferral] @caseNumber = "QK62953JW 00001", @fromDate = "01/01/2017", @toDate = "12/31/2017" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetEmployeeDeferral] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;


DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;



IF OBJECT_ID('tempdb..#tempEXdeferral1') IS NOT NULL      
    DROP TABLE #tempEXdeferral1  ;


CREATE TABLE #tempEXdeferral1 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 

   deferralFlag INT,
   totalCnt INT,
   DeferralByPercCnt INT,
   DeferralByAmtCnt INT
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END


SET @query = 'INSERT INTO #tempEXdeferral1(planNumber,planName, companyName, DeferralFlag, totalCnt, DeferralByPercCnt, DeferralByAmtCnt)
SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, 
         1 AS DeferralFlag,
		"[PreTaxCnt]" AS totalCnt,
        "[DeferralByPercCnt]" AS DeferralByPercCnt, 
		"[DeferralByAmtCnt]" AS [DeferralByAmtCnt]
 FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], 
   FILTER(VALUES(BalanceAndParticipation[PreTaxDeferralFlag]), (BalanceAndParticipation[PreTaxDeferralFlag] = 1) ), FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + 
  '"PreTaxCnt", [PreTaxCnt],
   "DeferralByPercCnt", [DeferralByPercCnt], 
   "DeferralByAmtCnt", [DeferralByAmtCnt]  )'')
UNION ALL
SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, 
         2 AS DeferralFlag,
		"[RothCnt]" AS totalCnt,
        "[DeferralByPercCnt]" AS DeferralByPercCnt, 
		"[DeferralByAmtCnt]" AS [DeferralByAmtCnt]
 FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], 
   FILTER(VALUES(BalanceAndParticipation[RothDeferralFlag]), (BalanceAndParticipation[RothDeferralFlag] = 1) ), FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + 
  '"RothCnt", [RothCnt],
   "DeferralByPercCnt", [DeferralByPercCnt], 
   "DeferralByAmtCnt", [DeferralByAmtCnt]  )'')'

EXEC(@query);

SET @query = 'INSERT INTO #tempEXdeferral1(planNumber,planName, companyName, DeferralFlag, totalCnt, DeferralByPercCnt, DeferralByAmtCnt)
SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, 
         3 AS DeferralFlag,
		"[AfterTaxCnt]" AS totalCnt,
        "[DeferralByPercCnt]" AS DeferralByPercCnt, 
		"[DeferralByAmtCnt]" AS [DeferralByAmtCnt]
 FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], 
   FILTER(VALUES(BalanceAndParticipation[AfterTaxDeferralFlag]), (BalanceAndParticipation[AfterTaxDeferralFlag] = 1) ), FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + 
  '"AfterTaxCnt", [AfterTaxCnt],
   "DeferralByPercCnt", [DeferralByPercCnt], 
   "DeferralByAmtCnt", [DeferralByAmtCnt]  )'' )'
;

EXEC(@query);
  
SELECT  
       CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, 
       CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate,
	   a.planNumber, planName, companyName,
       MAX(CASE WHEN deferralFlag = 1 THEN totalCnt END) AS preTaxCnt,
	   MAX(CASE WHEN deferralFlag = 1 THEN DeferralByPercCnt END) AS preTaxDeferralByPercCnt,
	   MAX(CASE WHEN deferralFlag = 1 THEN DeferralByAmtCnt END) AS preTaxDeferralByAmtCnt,
	   MAX(CASE WHEN deferralFlag = 2 THEN totalCnt END) AS rothCnt,
	   MAX(CASE WHEN deferralFlag = 2 THEN DeferralByPercCnt END) AS rothDeferralByPercCnt,
	   MAX(CASE WHEN deferralFlag = 2 THEN DeferralByAmtCnt END) AS rothDeferralByAmtCnt,
	   MAX(CASE WHEN deferralFlag = 3 THEN totalCnt END) AS afterTaxCnt,
	   MAX(CASE WHEN deferralFlag = 3 THEN DeferralByPercCnt END) AS afterTaxDeferralByPercCnt,
	   MAX(CASE WHEN deferralFlag = 3 THEN DeferralByAmtCnt END) AS afterTaxDeferralByAmtCnt
FROM #tempEXdeferral1 a 
GROUP BY a.planNumber, planName, companyName
        


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetEmployeeDistribution]    Script Date: 6/17/2021 11:04:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetEmployeeDistribution] @caseNumber = "931061JW  00795", @fromDate = "01/31/2017", @toDate = "12/20/2017" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetEmployeeDistribution] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL 
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;

IF OBJECT_ID('tempdb..#tempEXrepo1') IS NOT NULL      
    DROP TABLE #tempEXrepo1  ;

CREATE TABLE #tempEXrepo1 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   withdrawalType VARCHAR(20), 
   withdrawalAmount NUMERIC(18, 2), 
   participantCnt INTEGER   
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Transaction], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'INSERT INTO #tempEXrepo1 (planNumber, planName, companyName, withdrawalType, withdrawalAmount, participantCnt)
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, CAST("Transactions[TransactionType]" AS VARCHAR(20)) AS withdrawalType, CAST("[DistributionAmount]" AS MONEY) AS withdrawalAmount, "[ParticipantCount]" AS participantCnt 
FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(Transactions[TransactionType], Plan[caseNumber], Plan[CompanyName], Plan[PlanName],  FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' FILTER(VALUES(Transactions[TransactionCategory]), (Transactions[TransactionCategory] = "Distribution")), "DistributionAmount", [DistributionAmount], "ParticipantCount", [ParticipantCount] )'' ) ';
;

EXEC(@query);

SET @query = 'INSERT INTO #tempEXrepo1 (planNumber, planName, companyName, withdrawalType, withdrawalAmount, participantCnt)
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, ''Total'' AS withdrawalType,  CAST("[DistributionAmount]" AS MONEY) AS withdrawalAmount, "[ParticipantCount]" AS participantCnt 
FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName],  FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' FILTER(VALUES(Transactions[TransactionCategory]), (Transactions[TransactionCategory] = "Distribution")), "DistributionAmount", [DistributionAmount], "ParticipantCount", [ParticipantCount] )'' ) ';
;

EXEC(@query);

WITH cte0 AS
(
   SELECT TOP 1
          CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, 
          CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, 
	      planNumber,
	      planName,
	      companyName
   FROM  #tempEXrepo1 t 
)
, cte1 AS
(
    SELECT 'Funds On Deposit' AS withdrawalType
	UNION ALL
    SELECT 'Lumpsum' 
	UNION ALL
    SELECT 'Rollover' 
	UNION ALL
    SELECT 'Hardship' 
	UNION ALL
    SELECT 'Installment' 
	UNION ALL
    SELECT 'Non - Hardship' 
	UNION ALL
	SELECT 'Total'
)
SELECT c.fromDate,
       c.toDate,
	   c.planNumber,
	   c.planName,
	   c.companyName,
	   a.withdrawalType,
	   COALESCE(b.withdrawalAmount, 0) as withdrawalAmount,
	   COALESCE(b.participantCnt, 0) as participantCnt
FROM  cte1 a
  LEFT JOIN #tempEXrepo1 b ON a.withdrawalType = b.withdrawalType
  CROSS JOIN cte0 c


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetEmployeeDistributionByDivision]    Script Date: 6/17/2021 11:04:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetEmployeeDistributionByDivision] @caseNumber = "QK62625JW 00001", @fromDate = "01/31/2017", @toDate = "12/31/2017", @divisionCodes = "EWP0,MP00,TV00" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetEmployeeDistributionByDivision] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL 
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;

IF OBJECT_ID('tempdb..#tempEXrepo14') IS NOT NULL      
    DROP TABLE #tempEXrepo14  ;

CREATE TABLE #tempEXrepo14 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   divisionCode VARCHAR(10), 
   divisionName VARCHAR(100),
   withdrawalAmount NUMERIC(18, 2), 
   participantCnt INTEGER   
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Transaction], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'INSERT INTO #tempEXrepo14 (planNumber, planName, companyName, divisionCode, divisionName, withdrawalAmount, participantCnt)
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, CAST("Division[DivisionCode]" AS VARCHAR(10)) AS divisionCode, CAST("Division[DivisionName]" AS VARCHAR(100)) AS divisionName, CAST("[DistributionAmount]" AS MONEY) AS withdrawalAmount, "[ParticipantCount]" AS participantCnt 
FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(Division[DivisionCode], Division[DivisionName], Plan[caseNumber], Plan[CompanyName], Plan[PlanName],  FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' FILTER(VALUES(Transactions[TransactionCategory]), (Transactions[TransactionCategory] = "Distribution")), "DistributionAmount", [DistributionAmount], "ParticipantCount", [ParticipantCount] )'' ) ';
;

EXEC(@query);

SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, 
       CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, 
       planNumber, planName, companyName, divisionCode, divisionName, withdrawalAmount, participantCnt
FROM #tempEXrepo14;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetEmployeeLoans]    Script Date: 6/17/2021 11:04:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetEmployeeLoans] @caseNumber = "QK62798JW 00001", @fromDate = "1/31/2017", @toDate = "12/31/2017", @divisionCodes = "SPT" 


CREATE   PROCEDURE [ex].[usp_Rpt_GetEmployeeLoans] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;

IF OBJECT_ID('tempdb..#tempEXrepo1') IS NOT NULL      
    DROP TABLE #tempEXrepo1  ;

CREATE TABLE #tempEXrepo1 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   activeLoanBalance NUMERIC(18, 2), 
   deemedLoanBalance NUMERIC(18, 2), 
   outstandingLoanBalance NUMERIC(18, 2), 
   activeLoanCnt INTEGER, 
   deemedLoanCnt INTEGER, 
   outstandingLoanCnt INTEGER,
   activeLoanEECnt INTEGER, 
   deemedLoanEECnt INTEGER, 
   outstandingLoanEECnt INTEGER,
   newLoanCnt INTEGER
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Transaction], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'INSERT INTO #tempEXrepo1 (planNumber, planName, companyName, activeLoanBalance, deemedLoanBalance, outstandingLoanBalance, activeLoanCnt, deemedLoanCnt, outstandingLoanCnt, activeLoanEECnt, deemedLoanEECnt, outstandingLoanEECnt, newLoanCnt)
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, 
CAST("[ActiveLoanBalance]" AS MONEY) AS activeLoanBalance, CAST("[DeemedLoanBalance]" AS MONEY) AS deemedLoanBalance, CAST("[OutstandingLoanBalance]" AS MONEY) AS outstandingLoanBalance, 
"[ActiveLoanCnt]" AS activeLoanCnt, "[DeemedLoanCnt]" AS deemedLoanCnt, "[OutstandingLoanCnt]" AS outstandingLoanCnt,
"[ActiveLoanEECnt]" AS activeLoanEECnt, "[DeemedLoanEECnt]" AS deemedLoanEECnt, "[OutstandingLoanEECnt]" AS outstandingLoanEECnt,
"[NewLoanCnt]" AS newLoanCnt
FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName],  FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' FILTER(VALUES(Transactions[TransactionCategory]), (Transactions[TransactionCategory] = "Loan")), 
"ActiveLoanBalance", [ActiveLoanBalance], "DeemedLoanBalance", [DeemedLoanBalance], "OutstandingLoanBalance", [OutstandingLoanBalance], 
"ActiveLoanCnt", [ActiveLoanCnt], "DeemedLoanCnt", [DeemedLoanCnt], "OutstandingLoanCnt", [OutstandingLoanCnt], 
"ActiveLoanEECnt", [ActiveLoanEECnt], "DeemedLoanEECnt", [DeemedLoanEECnt], "OutstandingLoanEECnt", [OutstandingLoanEECnt], 
"NewLoanCnt", [NewLoanCnt] )'' ) ';
;

EXEC(@query);

SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, *
FROM #tempEXrepo1;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetHCEAvgContributionByAge]    Script Date: 6/17/2021 11:04:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetHCEAvgContributionByAge] @caseNumber = "QK62625TP 00001", @fromDate = "04/30/2017", @toDate = "12/30/2017", @divisionCodes = "MO00,TV00,SS00" ;


CREATE   PROCEDURE [ex].[usp_Rpt_GetHCEAvgContributionByAge] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;


IF OBJECT_ID('tempdb..#tempEXrepor1') IS NOT NULL      
    DROP TABLE #tempEXrepor1  ;

CREATE TABLE #tempEXrepor1 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   ageBand VARCHAR(10), 
   avgContributionInContributingByAmt NUMERIC(18, 2), 
   avgContributionInContributingByRate NUMERIC(5, 4)
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'WITH cte1 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, CAST("Age[AgeBand]" AS VARCHAR(10)) AS ageBand, "[HCEAvgDeferralAmt]" AS avgContributionInContributingByAmt, "[HCEAvgDeferralRate]" AS avgContributionInContributingByRate 
 FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Age[AgeBand], Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "HCEAvgDeferralAmt", [HCEAvgDeferralAmt], "HCEAvgDeferralRate", [HCEAvgDeferralRate])'' ) 
), cte2 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, "[HCEAvgDeferralAmt]" AS avgContributionInContributingByAmt, "[HCEAvgDeferralRate]" AS avgContributionInContributingByRate 
 FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "HCEAvgDeferralAmt", [HCEAvgDeferralAmt], "HCEAvgDeferralRate", [HCEAvgDeferralRate])'' ) 
) INSERT INTO #tempEXrepor1 (planNumber,planName, companyName, ageBand, avgContributionInContributingByAmt, avgContributionInContributingByRate)
SELECT planNumber,planName, companyName, ageBand, avgContributionInContributingByAmt, avgContributionInContributingByRate 
FROM (
SELECT planNumber,planName, companyName, ageBand, avgContributionInContributingByAmt, avgContributionInContributingByRate
FROM cte1
UNION ALL
SELECT planNumber,planName, companyName, ''All Ages'' AS ageBand, avgContributionInContributingByAmt, avgContributionInContributingByRate
FROM cte2) a'
;

EXEC(@query);

SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, *, 
    NULL AS avgContributionRateInEligible, NULL AS avgContributionAmtInEligible
FROM #tempEXrepor1;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetHCEAvgContributionByDivision]    Script Date: 6/17/2021 11:04:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetHCEAvgContributionByDivision] @caseNumber = "QK62625JW 00001", @fromDate = "04/30/2017", @toDate = "12/30/2017", @divisionCodes = "MO00,TV00,SS00" ;


CREATE   PROCEDURE [ex].[usp_Rpt_GetHCEAvgContributionByDivision] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;

IF OBJECT_ID('tempdb..#tempEXreport10') IS NOT NULL      
    DROP TABLE #tempEXreport10  ;

CREATE TABLE #tempEXreport10 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   divisionCode VARCHAR(10), 
   divisionName VARCHAR(100), 
   avgContributionInContributingByAmt NUMERIC(18, 2), 
   avgContributionInContributingByRate NUMERIC(5, 4)
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'WITH cte1 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, CAST("Division[DivisionCode]" AS VARCHAR(10)) AS divisionCode, CAST("Division[DivisionName]" AS VARCHAR(100)) AS divisionName, "[HCEAvgDeferralAmt]" AS avgContributionInContributingByAmt, "[HCEAvgDeferralRate]" AS avgContributionInContributingByRate 
 FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Division[DivisionCode], Division[DivisionName], Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "HCEAvgDeferralAmt", [HCEAvgDeferralAmt], "HCEAvgDeferralRate", [HCEAvgDeferralRate])'' ) 
) INSERT INTO #tempEXreport10(planNumber,planName, companyName, divisionCode, divisionName, avgContributionInContributingByAmt, avgContributionInContributingByRate)
SELECT planNumber,planName, companyName, divisionCode, divisionName, avgContributionInContributingByAmt, avgContributionInContributingByRate
FROM cte1'
;


EXEC(@query);

SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, *, 
    NULL AS avgContributionRateInEligible, NULL AS avgContributionAmtInEligible
FROM #tempEXreport10;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetParticipation]    Script Date: 6/17/2021 11:04:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetParticipation] @caseNumber = "QK62298TP 00001", @fromDate = "04/30/2017", @toDate = "12/30/2017", @divisionCodes = "K385,K435,V893" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetParticipation] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;


IF OBJECT_ID('tempdb..#tempEXreport11') IS NOT NULL      
    DROP TABLE #tempEXreport11  ;

CREATE TABLE #tempEXreport11 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   eligibleCnt INTEGER, 
   contributingCnt INTEGER
);

IF OBJECT_ID('tempdb..#tempEXreportNewEnroll') IS NOT NULL      
    DROP TABLE #tempEXreportNewEnroll  ;

CREATE TABLE #tempEXreportNewEnroll (
   newEnrollmentCnt INTEGER
)


DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'WITH cte1 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, "[EligibleCnt]" AS eligibleCnt, "[ContributingCnt]" AS contributingCnt FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "EligibleCnt", [EligibleCnt], "ContributingCnt", [ContributingCnt])'' ) 
) INSERT INTO #tempEXreport11 (planNumber,planName, companyName, eligibleCnt, contributingCnt)
SELECT planNumber,planName, companyName, eligibleCnt, contributingCnt
FROM cte1'
;

EXEC(@query);

SET @query = 
'INSERT INTO #tempEXreportNewEnroll (newEnrollmentCnt) 
 SELECT "[NewEnrollmentCount]" 
 FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "NewEnrollmentCount", [NewEnrollmentCount])'' )'

EXEC(@query);


SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, a.*, b.*, NULL AS eligibleForAutoEnrollmentCnt, NULL AS eligibleForAutoEnrollmentOptedOutCnt
FROM #tempEXreport11 a
  LEFT JOIN #tempEXreportNewEnroll b ON 1=1


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetParticipationRateByAge]    Script Date: 6/17/2021 11:04:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetParticipationRateByAge] @caseNumber = "JK62861JW 00001", @fromDate = "04/30/2017", @toDate = "12/30/2017", @divisionCodes = "K385,K435,V893" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetParticipationRateByAge] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL 
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;

IF OBJECT_ID('tempdb..#tempEXreport12') IS NOT NULL      
    DROP TABLE #tempEXreport12  ;

CREATE TABLE #tempEXreport12 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80),
   ageBand VARCHAR(10), 
   eligibleCnt INTEGER, 
   contributingCnt INTEGER
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'WITH cte1 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, CAST("Age[AgeBand]" AS VARCHAR(10)) AS ageBand, "[EligibleCnt]" AS eligibleCnt, "[ContributingCnt]" AS contributingCnt FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Age[AgeBand], Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "EligibleCnt", [EligibleCnt], "ContributingCnt", [ContributingCnt])'' ) 
), cte2 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, "[EligibleCnt]" AS eligibleCnt, "[ContributingCnt]" AS contributingCnt FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "EligibleCnt", [EligibleCnt], "ContributingCnt", [ContributingCnt])'' ) 
) 
INSERT INTO #tempEXreport12 (planNumber,planName, companyName, ageBand, eligibleCnt, contributingCnt)
SELECT planNumber,planName, companyName, ageBand, eligibleCnt, contributingCnt FROM 
(SELECT planNumber,planName, companyName, ageBand, eligibleCnt, contributingCnt
 FROM cte1
 UNION ALL
 SELECT planNumber,planName, companyName, ''All Ages'' AS ageBand, eligibleCnt, contributingCnt
 FROM cte2
)a'
;

EXEC(@query);

SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, *
FROM #tempEXreport12;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetParticipationRateByDivision]    Script Date: 6/17/2021 11:04:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetParticipationRateByDivision] @caseNumber = "JK62861JW 00001", @fromDate = "04/30/2017", @toDate = "06/30/2017", @divisionCodes = "K385,K435,V893" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetParticipationRateByDivision] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;


IF OBJECT_ID('tempdb..#tempEXreport13') IS NOT NULL      
    DROP TABLE #tempEXreport13  ;

CREATE TABLE #tempEXreport13 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   divisionCode VARCHAR(10), 
   divisionName VARCHAR(100), 
   eligibleCnt INTEGER, 
   contributingCnt INTEGER
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'WITH cte1 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, CAST("Division[DivisionCode]" AS VARCHAR(10)) AS divisionCode, CAST("Division[DivisionName]" AS VARCHAR(100)) AS divisionName, "[EligibleCnt]" AS eligibleCnt, "[ContributingCnt]" AS contributingCnt FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Division[DivisionCode], Division[DivisionName], Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' "EligibleCnt", [EligibleCnt], "ContributingCnt", [ContributingCnt])'' ) 
) INSERT INTO #tempEXreport13 (planNumber,planName, companyName, divisionCode, divisionName, eligibleCnt, contributingCnt)
SELECT planNumber,planName, companyName, divisionCode, divisionName, eligibleCnt, contributingCnt
FROM cte1'
;

EXEC(@query);

SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, *
FROM #tempEXreport13;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetPlanAssets]    Script Date: 6/17/2021 11:04:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt_GetPlanAssets] @caseNumber = "JK62395JW 00001", @fromDate = "01/31/2018", @toDate = "05/07/2018" ;

CREATE   PROCEDURE [ex].[usp_Rpt_GetPlanAssets] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(500) = @divisionCodes;

IF OBJECT_ID('tempdb..#tempEXreport14') IS NOT NULL      
    DROP TABLE #tempEXreport14  ;

CREATE TABLE #tempEXreport14 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   termParticipantBalance NUMERIC(18, 2),
   termParticipantCnt INTEGER,
   activeParticipantBalance NUMERIC(18, 2),  
   activeParticipantCnt INTEGER, 
   advEmployerAccountBalance NUMERIC(18, 2),
   expenseBudgetAccountBalance NUMERIC(18, 2),
   forfeitureAccountBalance NUMERIC(18, 2),
   suspenseAccountBalance NUMERIC(18, 2)
);

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE;

SELECT  @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM    OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

SET @query = 'WITH cte1 AS
(
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, 1 as R, CAST("EmploymentStatus[EmploymentStatus]" AS VARCHAR(10)) AS Cat, CAST("[Balance]" AS MONEY) AS B, "[ParticipantCnt]" AS P FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(''''EmploymentStatus''''[EmploymentStatus], Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + ' FILTER( VALUES(''''Account Type''''[AccountType]), ''''Account Type''''[AccountType] = "Participants"), "Balance", [ParticipantBalance], "ParticipantCnt", [ParticipantCnt])'' ) 
 UNION ALL      
 SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, 5 AS R, CAST("Account Type[AccountType]" AS VARCHAR(30)) AS Cat, CAST("[Balance]" AS MONEY) AS B, 0 AS P FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(''''Account Type''''[AccountType], Plan[caseNumber], Plan[CompanyName], Plan[PlanName], FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + ' "Balance", [AccountBalance])'' )
) INSERT INTO #tempEXreport14 (planNumber, planName, companyName, termParticipantBalance, termParticipantCnt, activeParticipantBalance, activeParticipantCnt, advEmployerAccountBalance, expenseBudgetAccountBalance,
forfeitureAccountBalance, suspenseAccountBalance) SELECT planNumber,planName, companyName,
SUM(CASE WHEN R= 1 AND Cat <>''Active'' THEN B END) AS termParticipantBalance,
SUM(CASE WHEN R= 1 AND Cat <> ''Active'' THEN P END) AS termParticipantCnt,
MAX(CASE WHEN R= 1 AND Cat =''Active'' THEN B END) AS activeParticipantBalance,  
MAX(CASE WHEN R= 1 AND Cat =''Active'' THEN P END) AS activeParticipantCnt, 
MAX(CASE WHEN R= 5 AND Cat =''Advance Employer'' THEN B END) AS advEmployerAccountBalance,
MAX(CASE WHEN R= 5 AND Cat =''Expense Budget Account'' THEN B END) AS expenseBudgetAccountBalance,
MAX(CASE WHEN R= 5 AND Cat =''Forfeiture'' THEN B END) AS forfeitureAccountBalance,
MAX(CASE WHEN R= 5 AND Cat =''Suspense'' THEN B END) AS suspenseAccountBalance
FROM cte1 GROUP BY planNumber, planName, companyName'
;

EXEC(@query);

SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, *
FROM #tempEXreport14;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetPlanContributionFlags]    Script Date: 6/17/2021 11:04:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt_GetPlanContributionFlags] @caseNumber = 'JK62395TP 00001';

CREATE   PROCEDURE [ex].[usp_Rpt_GetPlanContributionFlags] (
 @caseNumber VARCHAR(20)
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 

DECLARE @query VARCHAR(8000);

SET @query = '
SELECT planNumber,  
	   COALESCE(pretaxContributionFlag, 0) AS pretaxContributionFlag,
       COALESCE(rothContributionFlag, 0) AS rothContributionFlag,  
       COALESCE(afterTaxContributionFlag, 0) AS afterTaxContributionFlag
FROM
(
  SELECT CAST("Plan[CaseNumber]" AS VARCHAR(20)) AS planNumber, 
	     "Plan[RothContributionFlag]" AS rothContributionFlag, 
		 "Plan[AfterTaxContributionFlag]" AS afterTaxContributionFlag,
		 "Plan[PretaxContributionFlag]" AS pretaxContributionFlag
  FROM OPENQUERY([Transaction], ''EVALUATE SUMMARIZECOLUMNS(Plan[CaseNumber], Plan[RothContributionFlag], Plan[AfterTaxContributionFlag], Plan[PretaxContributionFlag],
                          FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + ' 
						  "NumberOfPlans", [NumberOfPlans])''
			    )
) a'

EXEC(@query);


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt_GetServiceUtilization]    Script Date: 6/17/2021 11:04:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test the stored procedure:
--EXEC [ex].[usp_Rpt_GetServiceUtilization] @caseNumber = "JK62861JW 00001", @fromDate = '01/31/2018', @toDate = '04/30/2018', @divisionCodes = 'X349,K435,V893,X185,X349,X596,X627,X628,X728,X734';


CREATE   PROCEDURE [ex].[usp_Rpt_GetServiceUtilization] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(500) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 


DECLARE @dCodes VARCHAR(500) = @divisionCodes;

DECLARE @query VARCHAR(8000);
DECLARE @divStr VARCHAR(4000);

DECLARE @lastReportDate DATE; --VARCHAR(10);

SELECT @lastReportDate = CAST("[LastReportDate]" AS DATE)
FROM OPENQUERY([Balance], 'EVALUATE SUMMARIZECOLUMNS("LastReportDate", [LastReportDate])')

IF (@lastReportDate < CAST(@tDate AS DATE))
BEGIN
  SET @tDate = CONVERT(VARCHAR(10), @lastReportDate, 101)
END
;

IF OBJECT_ID('tempdb..#tmpResult1') IS NOT NULL      
    DROP TABLE #tmpResult1  ;

CREATE TABLE #tmpResult1 (
   planNumber VARCHAR(20), 
   planName VARCHAR (200), 
   companyName VARCHAR(80), 
   AutoRebalanceCnt INTEGER, 
   CustomPortfolioCnt INTEGER, 
   EConfirmCnt INTEGER, 
   EInvestMaterialCnt INTEGER, 
   EnrollMaterialCnt INTEGER, 
   EStatementCnt INTEGER,
   ManagedAccountCnt INTEGER, 
   ManagedAdviceCnt INTEGER, 
   OnTrackMaterialCnt INTEGER, 
   PlanRelatedMaterialCnt INTEGER, 
   PortfolioXpressCnt INTEGER, 
   RecurringTransferCnt INTEGER, 
   PCRACnt INTEGER, 
   SecurePathForLifeCnt INTEGER
);

CREATE TABLE #tmpResult2 (
   CustomPortfolios TINYINT, 
   PCRA TINYINT,
   PortfolioXpress TINYINT, 
   SecurePathForLife TINYINT, 
   DCMA TINYINT
)

DECLARE @dateStr VARCHAR(200);
IF (@fDate IS NULL) AND (@tDate IS NULL)   -- 1. use default most current reportDate
BEGIN 
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] = max(''''Date''''[DateValue]) )),'
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NOT NULL)   -- 2. date range
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") && ''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END
ELSE IF (@fDate IS NOT NULL) AND (@tDate IS NULL)   -- 3. >= fDate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] >= DATEVALUE("' + @fDate + '") )),';
END
ELSE IF  (@fDate IS NULL) AND (@tDate IS NOT NULL)    -- 4. <= todate
BEGIN
  SET @dateStr = 'FILTER(VALUES(''''Date''''[DateValue]), (''''Date''''[DateValue] <= DATEVALUE("' + @tDate + '") )),';
END  	

IF (@dCodes IS NULL) 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '")||(Division[DivisionCode]="') + '")),'
END

SET @query = 'WITH cte1 AS
(SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber, CAST("Plan[PlanName]" AS VARCHAR(200)) AS planName, CAST("Plan[CompanyName]" AS VARCHAR(80)) AS companyName, 
"[AutoRebalanceCnt]" AS AutoRebalanceCnt, "[CustomPortfolioCnt]" AS CustomPortfolioCnt, "[EConfirmCnt]" AS EConfirmCnt, "[EInvestMaterialCnt]" AS EInvestMaterialCnt, "[EnrollMaterialCnt]" AS EnrollMaterialCnt, "[EStatementCnt]" AS EStatementCnt,
"[ManagedAccountCnt]" AS ManagedAccountCnt, "[ManagedAdviceCnt]" AS ManagedAdviceCnt, "[OnTrackMaterialCnt]" AS OnTrackMaterialCnt, "[PlanRelatedMaterialCnt]" AS PlanRelatedMaterialCnt, "[PortfolioXpressCnt]" AS PortfolioXpressCnt, 
"[RecurringTransferCnt]" AS RecurringTransferCnt, "[PCRACnt]" AS PCRACnt, "[SecurePathForLifeCnt]" as SecurePathForLifeCnt
FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[CaseNumber], Plan[CompanyName], Plan[PlanName], FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")), ' + @dateStr + @divStr + '
 "AutoRebalanceCnt", [AutoRebalanceCnt],
 "CustomPortfolioCnt", [CustomPortfolioCnt],
 "EConfirmCnt", [EConfirmCnt],
 "EInvestMaterialCnt", [EInvestMaterialCnt],
 "EnrollMaterialCnt", [EnrollMaterialCnt],
 "EStatementCnt", [EStatementCnt],
 "ManagedAccountCnt", [ManagedAccountCnt],
 "ManagedAdviceCnt", [ManagedAdviceCnt],
 "OnTrackMaterialCnt", [OnTrackMaterialCnt],
 "PlanRelatedMaterialCnt", [PlanRelatedMaterialCnt],
 "PortfolioXpressCnt", [PortfolioXpressCnt],
 "RecurringTransferCnt", [RecurringTransferCnt],
 "PCRACnt", [PCRACnt],
 "SecurePathForLifeCnt", [SecurePathForLifeCnt]
 )'' ))
INSERT INTO #tmpResult1 (planNumber, planName, companyName, AutoRebalanceCnt, CustomPortfolioCnt, EConfirmCnt, EInvestMaterialCnt, EnrollMaterialCnt, EStatementCnt,
 ManagedAccountCnt, ManagedAdviceCnt, OnTrackMaterialCnt, PlanRelatedMaterialCnt, PortfolioXpressCnt, RecurringTransferCnt, PCRACnt, SecurePathForLifeCnt)
select planNumber, planName, companyName, AutoRebalanceCnt, CustomPortfolioCnt, EConfirmCnt, EInvestMaterialCnt, EnrollMaterialCnt, EStatementCnt,
 ManagedAccountCnt, ManagedAdviceCnt, OnTrackMaterialCnt, PlanRelatedMaterialCnt, PortfolioXpressCnt, RecurringTransferCnt, PCRACnt, SecurePathForLifeCnt from cte1';

EXEC(@query);

SET @query = '
INSERT INTO #tmpResult2 (CustomPortfolios, PCRA, PortfolioXpress, SecurePathForLife, DCMA)
SELECT "Plan[CustomPortfolios]" AS CustomPortfolios, "Plan[PCRA]" AS PCRA, "Plan[PortfolioXpress]" AS PortfolioXpress, "Plan[SecurePathForLife]" AS SecurePathForLife, "Plan[DCMA]" AS DCMA
FROM OPENQUERY([Balance], ''EVALUATE SUMMARIZECOLUMNS(Plan[CustomPortfolios], Plan[PCRA], Plan[PortfolioXpress], Plan[SecurePathForLife], Plan[DCMA], FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber] = "' + @thePlan + '")) )'' )
'

EXEC(@query);


WITH cte3 AS
( SELECT planNumber,planName, companyName,  
         AutoRebalanceCnt AS useAutoRebalanceCnt, CustomPortfolioCnt AS useCustomPortfolioCnt, EConfirmCnt AS useEConfirmCnt, EInvestMaterialCnt AS useEInvestMaterialCnt, EnrollMaterialCnt AS useEnrollMaterialCnt, EStatementCnt AS useEStatementCnt, 
		 ManagedAccountCnt AS useManagedAccountCnt, ManagedAdviceCnt AS useManagedAdviceCnt, OnTrackMaterialCnt AS useOnTrackMaterialCnt, PlanRelatedMaterialCnt AS usePlanRelatedMaterialCnt, PortfolioXpressCnt AS usePortfolioXpressCnt, RecurringTransferCnt AS useRecurringTransferCnt,
		 PCRACnt AS usePCRAParticipationCnt, SecurePathForLifeCnt AS useSecurePathForLifeCnt,
		 COALESCE(CustomPortfolios, 0) AS allowCustomPortfolios, COALESCE(PCRA, 0) AS allowPCRA, 
		 COALESCE(PortfolioXpress, 0) AS allowPortfolioXpress, COALESCE(SecurePathForLife, 0) AS allowSecurePathForLife, 
		 COALESCE(DCMA, 0) AS allowDCMA
  FROM #tmpResult1 a
   LEFT JOIN #tmpResult2 b ON 1=1
)
SELECT CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, EOMONTH(CAST(@fDate AS DATE))), 0), 126) AS fromDate, CONVERT(VARCHAR(10), CAST(@tDate AS DATE), 126) AS toDate, *
FROM cte3;


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetBalance_Contributions]    Script Date: 6/17/2021 11:04:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it:
--EXEC [ex].[usp_Rpt3_GetBalance_Contributions] @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ;

CREATE   PROCEDURE [ex].[usp_Rpt3_GetBalance_Contributions] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;


DECLARE @thePlan VARCHAR(20) = @caseNumber; --'JK62276TP 00001';  
DECLARE @fDate VARCHAR(10) = @fromDate; --'2018-10-01';  
DECLARE @tDate VARCHAR(10) = @toDate; --'2018-12-31';  
DECLARE @dCodes VARCHAR(max) = @divisionCodes; --NULL; 

DECLARE @dateStr VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @query VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue] <= DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

IF OBJECT_ID('tempdb..#balancecontribution') IS NOT NULL      
    DROP TABLE #balancecontribution  ;

CREATE TABLE #balancecontribution (
    planNumber VARCHAR(20),      
    avgContributionInContributingByRate DECIMAL(5,4),
    avgContributionInContributingByAmt DECIMAL(18,2),
    avgContributionRateInEligible DECIMAL(5,4),
    avgContributionAmtInEligible DECIMAL(18,2),
    avgPreTaxDeferralRate DECIMAL(5,4),
	avgRothdeferralRate DECIMAL(5,4), 
	avgAfterTaxDeferralRate DECIMAL(5,4), 
	avgPreTaxDeferralAmt DECIMAL(18,2), 
	avgRothDeferralAmt DECIMAL(18,2), 
	avgAfterTaxDeferralAmt DECIMAL(18,2), 
	preTaxCnt INTEGER, 
	rothCnt INTEGER,
	afterTaxCnt INTEGER,
	pretaxDeferralByPercCnt INTEGER,
	pretaxDeferralByAmtCnt INTEGER,
	rothDeferralByPercCnt INTEGER,
	rothDeferralByAmtCnt INTEGER,
	aftertaxDeferralByPercCnt INTEGER,
	aftertaxDeferralByAmtCnt INTEGER
       
);

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"AvgContributionInContributingAmt", [AvgContributionInContributingAmt],
"AvgContributionInContributingRate", [AvgContributionInContributingRate],
"AvgContributionInEligibleRate", [AvgContributionInEligibleRate],
"AvgContributionInEligibleAmt", [AvgContributionInEligibleAmt],
"AvgPreTaxDeferralRate", [AvgPreTaxDeferralRate],
"AvgRothdeferralRate", [AvgRothdeferralRate],
"AvgAfterTaxDeferralRate", [AvgAfterTaxDeferralRate],
"AvgPreTaxDeferralAmt", [AvgPreTaxDeferralAmt],
"AvgRothDeferralAmt", [AvgRothDeferralAmt],
"AvgAfterTaxDeferralAmt", [AvgAfterTaxDeferralAmt],
"PreTaxCnt", [PreTaxCnt],
"RothCnt", [RothCnt],
"AfterTaxCnt", [AfterTaxCnt],
"PretaxDeferralByPercCnt", [PretaxDeferralByPercCnt],
"PretaxDeferralByAmtCnt", [PretaxDeferralByAmtCnt],
"RothDeferralByPercCnt", [RothDeferralByPercCnt],
"RothDeferralByAmtCnt", [RothDeferralByAmtCnt],
"AftertaxDeferralByPercCnt", [AftertaxDeferralByPercCnt],
"AftertaxDeferralByAmtCnt", [AftertaxDeferralByAmtCnt]),
"planNumber", Plan[caseNumber],
"avgContributionInContributingByRate", [AvgContributionInContributingRate],
"avgContributionInContributingByAmt", [AvgContributionInContributingAmt],
"avgContributionRateInEligible", [AvgContributionInEligibleRate],
"avgContributionAmtInEligible", [AvgContributionInEligibleAmt],
"avgPreTaxDeferralRate", [AvgPreTaxDeferralRate],
"avgRothdeferralRate", [AvgRothdeferralRate],
"avgAfterTaxDeferralRate", [AvgAfterTaxDeferralRate],
"avgPreTaxDeferralAmt", [AvgPreTaxDeferralAmt],
"avgRothDeferralAmt", [AvgRothDeferralAmt],
"avgAfterTaxDeferralAmt", [AvgAfterTaxDeferralAmt],
"preTaxCnt", [PreTaxCnt],
"rothCnt", [RothCnt],
"afterTaxCnt", [AfterTaxCnt],
"pretaxDeferralByPercCnt", [PretaxDeferralByPercCnt],
"pretaxDeferralByAmtCnt", [PretaxDeferralByAmtCnt],
"rothDeferralByPercCnt", [RothDeferralByPercCnt],
"rothDeferralByAmtCnt", [RothDeferralByAmtCnt],
"aftertaxDeferralByPercCnt", [AftertaxDeferralByPercCnt],
"aftertaxDeferralByAmtCnt", [AftertaxDeferralByAmtCnt])'

INSERT INTO #balancecontribution (planNumber,      
    avgContributionInContributingByRate,
    avgContributionInContributingByAmt,
    avgContributionRateInEligible,
    avgContributionAmtInEligible,
    avgPreTaxDeferralRate ,
	avgRothdeferralRate , 
	avgAfterTaxDeferralRate , 
	avgPreTaxDeferralAmt , 
	avgRothDeferralAmt , 
	avgAfterTaxDeferralAmt , 
	preTaxCnt , 
	rothCnt ,
	afterTaxCnt ,
	pretaxDeferralByPercCnt ,
	pretaxDeferralByAmtCnt ,
	rothDeferralByPercCnt ,
	rothDeferralByAmtCnt ,
	aftertaxDeferralByPercCnt,
	aftertaxDeferralByAmtCnt)
EXEC (@query) AT Balance;

SELECT * FROM #balancecontribution

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
CAST("[AvgContributionInContributingRate]" AS DECIMAL(5,4)) AS avgContributionInContributingByRate,
CAST("[AvgContributionInContributingAmt]" AS DECIMAL(18,2)) AS avgContributionInContributingByAmt,
CAST("[AvgContributionInEligibleRate]" AS DECIMAL(5,4)) AS avgContributionRateInEligible,
CAST("[AvgContributionInEligibleAmt]" AS DECIMAL(18,2)) AS avgContributionAmtInEligible,
CAST("[AvgPreTaxDeferralRate]" AS DECIMAL(5,4)) AS avgPreTaxDeferralRate,
CAST("[AvgRothdeferralRate]" AS DECIMAL(5,4)) AS avgRothdeferralRate,
CAST("[AvgAfterTaxDeferralRate]" AS DECIMAL(5,4)) AS avgAfterTaxDeferralRate,
CAST("[AvgPreTaxDeferralAmt]" AS DECIMAL(18,2)) AS avgPreTaxDeferralAmt,
CAST("[AvgRothDeferralAmt]" AS DECIMAL(18,2)) AS avgRothDeferralAmt,
CAST("[AvgAfterTaxDeferralAmt]" AS DECIMAL(18,2)) AS avgAfterTaxDeferralAmt,
"[PreTaxCnt]" AS preTaxCnt,
"[RothCnt]" AS rothCnt,
"[AfterTaxCnt]" AS afterTaxCnt,
"[PretaxDeferralByPercCnt]" AS pretaxDeferralByPercCnt,
"[PretaxDeferralByAmtCnt]" AS pretaxDeferralByAmtCnt,
"[RothDeferralByPercCnt]" AS rothDeferralByPercCnt,
"[RothDeferralByAmtCnt]" AS rothDeferralByAmtCnt,
"[AftertaxDeferralByPercCnt]" AS aftertaxDeferralByPercCnt,
"[AftertaxDeferralByAmtCnt]" AS aftertaxDeferralByAmtCnt
FROM OPENQUERY([Balance],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"AvgContributionInContributingAmt", [AvgContributionInContributingAmt],
"AvgContributionInContributingRate", [AvgContributionInContributingRate],
"AvgContributionInEligibleRate", [AvgContributionInEligibleRate],
"AvgContributionInEligibleAmt", [AvgContributionInEligibleAmt],
"AvgPreTaxDeferralRate", [AvgPreTaxDeferralRate],
"AvgRothdeferralRate", [AvgRothdeferralRate],
"AvgAfterTaxDeferralRate", [AvgAfterTaxDeferralRate],
"AvgPreTaxDeferralAmt", [AvgPreTaxDeferralAmt],
"AvgRothDeferralAmt", [AvgRothDeferralAmt],
"AvgAfterTaxDeferralAmt", [AvgAfterTaxDeferralAmt],
"PreTaxCnt", [PreTaxCnt],
"RothCnt", [RothCnt],
"AfterTaxCnt", [AfterTaxCnt],
"PretaxDeferralByPercCnt", [PretaxDeferralByPercCnt],
"PretaxDeferralByAmtCnt", [PretaxDeferralByAmtCnt],
"RothDeferralByPercCnt", [RothDeferralByPercCnt],
"RothDeferralByAmtCnt", [RothDeferralByAmtCnt],
"AftertaxDeferralByPercCnt", [AftertaxDeferralByPercCnt],
"AftertaxDeferralByAmtCnt", [AftertaxDeferralByAmtCnt])''
)';
*/

--EXEC(@query);

GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetBalance_Participation]    Script Date: 6/17/2021 11:04:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt3_GetBalance_Participation] @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ;

CREATE     PROCEDURE [ex].[usp_Rpt3_GetBalance_Participation] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;


DECLARE @thePlan VARCHAR(20) = @caseNumber; --'JK62276TP 00001';  
DECLARE @fDate VARCHAR(10) = @fromDate; --'01/01/2018';  
DECLARE @tDate VARCHAR(10) = @toDate; --'12/31/2018';  
DECLARE @dCodes VARCHAR(max) = @divisionCodes; --NULL; 

DECLARE @dateStr VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @query VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END

IF OBJECT_ID('tempdb..#balanceparticipation') IS NOT NULL      
    DROP TABLE #balanceparticipation  ;

CREATE TABLE #balanceparticipation(
  planNumber VARCHAR(20),
  eligibleCnt INTEGER,
  contributingCnt INTEGER
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EligibleCnt", [EligibleCnt],
"ContributingCnt", [ContributingCnt]),
"planNumber", Plan[caseNumber],
"eligibleCnt", [EligibleCnt],
"contributingCnt", [ContributingCnt])'

INSERT INTO #balanceparticipation(
  planNumber,
  eligibleCnt,
  contributingCnt
)
EXEC (@query) AT Balance;

SELECT * FROM #balanceparticipation

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
"[EligibleCnt]" AS eligibleCnt,
"[ContributingCnt]" AS contributingCnt
FROM OPENQUERY([Balance],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EligibleCnt", [EligibleCnt],
"ContributingCnt", [ContributingCnt])''
)';
EXEC(@query);
*/


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetBalance_PlanAsset]    Script Date: 6/17/2021 11:04:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--To test it: (either MM/dd/yyyy or yyyy-MM-dd works for date format)
--EXEC [ex].[usp_Rpt3_GetBalance_PlanAsset] @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ;

CREATE      PROCEDURE [ex].[usp_Rpt3_GetBalance_PlanAsset] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; --'JK62276TP 00001';  
DECLARE @fDate VARCHAR(10) = @fromDate; --'01/01/2018';  
DECLARE @tDate VARCHAR(10) = @toDate; --'12/31/2018';  
DECLARE @dCodes VARCHAR(max) = @divisionCodes; --NULL; 

DECLARE @dateStr VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @query VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue] <= DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode] = "' + replace(@dCodes, ',', '") || (Division[DivisionCode] = "') + '")),'
END

IF OBJECT_ID('tempdb..#balanceplanasset') IS NOT NULL      
    DROP TABLE #balanceplanasset  ;

CREATE TABLE #balanceplanasset (
  planNumber VARCHAR(20),
  participantBalance MONEY,
  participantCnt INTEGER,
  activeParticipantBalance MONEY,
  termParticipantBalance MONEY,
  activeParticipantCnt INTEGER,
  termParticipantCnt INTEGER,
  advEmployerAccountBalance MONEY,
  expenseBudgetAccountBalance MONEY,
  forfeitureAccountBalance MONEY,
  suspenseAccountBalance MONEY
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"ParticipantBalance", [ParticipantBalance],
"ParticipantCnt", [ParticipantCnt],
"ActiveParticipantBalance", [ActiveParticipantBalance],
"TermedParticipantBalance", [TermedParticipantBalance],
"ActiveParticipantCnt", [ActiveParticipantCnt],
"TermedParticipantCnt", [TermedParticipantCnt],
"AccountBalanceForAdvanceEmployer", [AccountBalanceForAdvanceEmployer],
"AccountBalanceForExpressBudget", [AccountBalanceForExpressBudget],
"AccountBalanceForForfeiture", [AccountBalanceForForfeiture],
"AccountBalanceForSuspense", [AccountBalanceForSuspense]),
"planNumber", Plan[caseNumber],
"participantBalance", [ParticipantBalance],
"participantCnt", [ParticipantCnt],
"activeParticipantBalance", [ActiveParticipantBalance],
"termParticipantBalance", [TermedParticipantBalance],
"activeParticipantCnt", [ActiveParticipantCnt],
"termParticipantCnt", [TermedParticipantCnt],
"advEmployerAccountBalance", [AccountBalanceForAdvanceEmployer],
"expenseBudgetAccountBalance", [AccountBalanceForExpressBudget],
"forfeitureAccountBalance", [AccountBalanceForForfeiture],
"suspenseAccountBalance", [AccountBalanceForSuspense])'

INSERT INTO #balanceplanasset (
  planNumber,
  participantBalance,
  participantCnt,
  activeParticipantBalance,
  termParticipantBalance,
  activeParticipantCnt,
  termParticipantCnt,
  advEmployerAccountBalance,
  expenseBudgetAccountBalance,
  forfeitureAccountBalance,
  suspenseAccountBalance
)
EXEC (@query) AT Balance;

SELECT * FROM #balanceplanasset


/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
CAST("[ParticipantBalance]" AS MONEY) AS participantBalance,
"[ParticipantCnt]" AS participantCnt,
CAST("[ActiveParticipantBalance]" AS MONEY) AS activeParticipantBalance,
CAST("[TermedParticipantBalance]" AS MONEY) AS termParticipantBalance,
"[ActiveParticipantCnt]" AS activeParticipantCnt,
"[TermedParticipantCnt]" AS termParticipantCnt,
CAST("[AccountBalanceForAdvanceEmployer]" AS MONEY) AS advEmployerAccountBalance,
CAST("[AccountBalanceForExpressBudget]" AS MONEY) AS expenseBudgetAccountBalance,
CAST("[AccountBalanceForForfeiture]" AS MONEY) AS forfeitureAccountBalance,
CAST("[AccountBalanceForSuspense]" AS MONEY) AS suspenseAccountBalance
FROM OPENQUERY([Balance],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"ParticipantBalance", [ParticipantBalance],
"ParticipantCnt", [ParticipantCnt],
"ActiveParticipantBalance", [ActiveParticipantBalance],
"TermedParticipantBalance", [TermedParticipantBalance],
"ActiveParticipantCnt", [ActiveParticipantCnt],
"TermedParticipantCnt", [TermedParticipantCnt],
"AccountBalanceForAdvanceEmployer", [AccountBalanceForAdvanceEmployer],
"AccountBalanceForExpressBudget", [AccountBalanceForExpressBudget],
"AccountBalanceForForfeiture", [AccountBalanceForForfeiture],
"AccountBalanceForSuspense", [AccountBalanceForSuspense])'' 
)';

EXEC(@query);
*/


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetBalance_ServiceUtilization]    Script Date: 6/17/2021 11:04:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt3_GetBalance_ServiceUtilization] @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ;

CREATE    PROCEDURE [ex].[usp_Rpt3_GetBalance_ServiceUtilization] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;


DECLARE @thePlan VARCHAR(20) = @caseNumber; --'JK62276TP 00001';  
DECLARE @fDate VARCHAR(10) = @fromDate; --'01/01/2018';  
DECLARE @tDate VARCHAR(10) = @toDate; --'12/31/2018';  
DECLARE @dCodes VARCHAR(max) = @divisionCodes; --NULL; 

DECLARE @dateStr VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @query VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END

IF OBJECT_ID('tempdb..#balanceservice') IS NOT NULL      
    DROP TABLE #balanceservice  ;

CREATE TABLE #balanceservice (
  planNumber VARCHAR(20),
  useEStatementCnt INTEGER,
  useEInvestMaterialCnt INTEGER,
  useEConfirmCnt INTEGER,
  usePlanRelatedMaterialCnt INTEGER,
  useEnrollMaterialCnt INTEGER,
  useAutoRebalanceCnt INTEGER,
  usePortfolioXpressCnt INTEGER,
  useManagedAdviceCnt INTEGER,
  usePCRAParticipationCnt INTEGER,
  useSecurePathForLifeCnt INTEGER,
  useCustomPortfolioCnt INTEGER
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
Plan[CompanyName],
Plan[PlanName],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EStatementCnt", [EStatementCnt],
"EInvestMaterialCnt", [EInvestMaterialCnt],
"EConfirmCnt", [EConfirmCnt],
"PlanRelatedMaterialCnt", [PlanRelatedMaterialCnt],
"EnrollMaterialCnt", [EnrollMaterialCnt],
"AutoRebalanceCnt", [AutoRebalanceCnt],
"PortfolioXpressCnt", [PortfolioXpressCnt],
"ManagedAdviceCnt", [ManagedAdviceCnt],
"PCRACnt", [PCRACnt],
"SecurePathForLifeCnt", [SecurePathForLifeCnt],
"CustomPortfolioCnt", [CustomPortfolioCnt]),
"planNumber", Plan[caseNumber],
"useEStatementCnt", [EStatementCnt],
"useEInvestMaterialCnt", [EInvestMaterialCnt],
"useEConfirmCnt", [EConfirmCnt],
"usePlanRelatedMaterialCnt", [PlanRelatedMaterialCnt],
"useEnrollMaterialCnt", [EnrollMaterialCnt],
"useAutoRebalanceCnt", [AutoRebalanceCnt],
"usePortfolioXpressCnt", [PortfolioXpressCnt],
"useManagedAdviceCnt", [ManagedAdviceCnt],
"usePCRAParticipationCnt", [PCRACnt],
"useSecurePathForLifeCnt", [SecurePathForLifeCnt],
"useCustomPortfolioCnt", [CustomPortfolioCnt])'


INSERT INTO #balanceservice (
  planNumber,
  useEStatementCnt,
  useEInvestMaterialCnt,
  useEConfirmCnt,
  usePlanRelatedMaterialCnt,
  useEnrollMaterialCnt,
  useAutoRebalanceCnt,
  usePortfolioXpressCnt,
  useManagedAdviceCnt,
  usePCRAParticipationCnt,
  useSecurePathForLifeCnt,
  useCustomPortfolioCnt
)
EXEC (@query) AT Balance;

SELECT * FROM #balanceservice

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
"[EStatementCnt]" AS useEStatementCnt,
"[EInvestMaterialCnt]" AS useEInvestMaterialCnt,
"[EConfirmCnt]" AS useEConfirmCnt,
"[PlanRelatedMaterialCnt]" AS usePlanRelatedMaterialCnt,
"[EnrollMaterialCnt]" AS useEnrollMaterialCnt,
"[AutoRebalanceCnt]" AS useAutoRebalanceCnt,
"[PortfolioXpressCnt]" AS usePortfolioXpressCnt,
"[ManagedAdviceCnt]" AS useManagedAdviceCnt,
"[PCRACnt]" AS usePCRAParticipationCnt,
"[SecurePathForLifeCnt]" AS useSecurePathForLifeCnt,
"[CustomPortfolioCnt]" AS useCustomPortfolioCnt
FROM OPENQUERY([Balance],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
Plan[CompanyName],
Plan[PlanName],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EStatementCnt", [EStatementCnt],
"EInvestMaterialCnt", [EInvestMaterialCnt],
"EConfirmCnt", [EConfirmCnt],
"PlanRelatedMaterialCnt", [PlanRelatedMaterialCnt],
"EnrollMaterialCnt", [EnrollMaterialCnt],
"AutoRebalanceCnt", [AutoRebalanceCnt],
"PortfolioXpressCnt", [PortfolioXpressCnt],
"ManagedAdviceCnt", [ManagedAdviceCnt],
"PCRACnt", [PCRACnt],
"SecurePathForLifeCnt", [SecurePathForLifeCnt],
"CustomPortfolioCnt", [CustomPortfolioCnt])''
)';

EXEC(@query);
*/


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetBalanceByAge_Contributions]    Script Date: 6/17/2021 11:04:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt3_GetBalanceByAge_Contributions]  @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ;

CREATE      PROCEDURE [ex].[usp_Rpt3_GetBalanceByAge_Contributions] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(max) = @divisionCodes;


DECLARE @query VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @dateStr VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END

IF OBJECT_ID('tempdb..#balancebyagecontribution') IS NOT NULL      
    DROP TABLE #balancebyagecontribution  ;

CREATE TABLE #balancebyagecontribution (
  planNumber VARCHAR(20),
  ageBand VARCHAR(10),
  avgContributionInContributingByAmt DECIMAL(18,2),
  avgContributionInContributingByRate DECIMAL(5,4),
  avgContributionRateInEligible DECIMAL(5,4),
  avgContributionAmtInEligible DECIMAL(18,2)
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
Age[AgeBand],
FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"AvgContributionInContributingAmt", [AvgContributionInContributingAmt],
"AvgContributionInContributingRate", [AvgContributionInContributingRate],
"AvgContributionInEligibleRate", [AvgContributionInEligibleRate],
"AvgContributionInEligibleAmt", [AvgContributionInEligibleAmt]),
"planNumber", Plan[caseNumber],
"ageBand", Age[AgeBand],
"avgContributionInContributingByAmt", [AvgContributionInContributingAmt],
"avgContributionInContributingByRate", [AvgContributionInContributingRate],
"avgContributionRateInEligible", [AvgContributionInEligibleRate],
"avgContributionAmtInEligible", [AvgContributionInEligibleAmt])'

INSERT INTO #balancebyagecontribution (
  planNumber ,
  ageBand ,
  avgContributionInContributingByAmt ,
  avgContributionInContributingByRate ,
  avgContributionRateInEligible ,
  avgContributionAmtInEligible
)
EXEC (@query) AT Balance;

SELECT * FROM #balancebyagecontribution

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
CAST("Age[AgeBand]" AS VARCHAR(10)) AS ageBand,
CAST("[AvgContributionInContributingAmt]" AS DECIMAL(18,2)) AS avgContributionInContributingByAmt,
CAST("[AvgContributionInContributingRate]" AS DECIMAL(5,4)) AS avgContributionInContributingByRate,
CAST("[AvgContributionInEligibleRate]" AS DECIMAL(5,4)) AS avgContributionRateInEligible,
CAST("[AvgContributionInEligibleAmt]" AS DECIMAL(18,2)) AS avgContributionAmtInEligible
FROM OPENQUERY([Balance],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
Age[AgeBand],
FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"AvgContributionInContributingAmt", [AvgContributionInContributingAmt],
"AvgContributionInContributingRate", [AvgContributionInContributingRate],
"AvgContributionInEligibleRate", [AvgContributionInEligibleRate],
"AvgContributionInEligibleAmt", [AvgContributionInEligibleAmt])''
)'

EXEC(@query);
*/


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetBalanceByAge_Participation]    Script Date: 6/17/2021 11:04:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt3_GetBalanceByAge_Participation]  @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ;

CREATE    PROCEDURE [ex].[usp_Rpt3_GetBalanceByAge_Participation] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(max) = @divisionCodes;


DECLARE @query VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @dateStr VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END

IF OBJECT_ID('tempdb..#balancebyageparticipation') IS NOT NULL      
    DROP TABLE #balancebyageparticipation  ;

CREATE TABLE #balancebyageparticipation (
  planNumber VARCHAR(20),
  ageBand VARCHAR(10),
  eligibleCnt INTEGER,
  contributingCnt INTEGER
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
Age[AgeBand],
FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EligibleCnt", [EligibleCnt], 
"ContributingCnt", [ContributingCnt]),
"planNumber", Plan[caseNumber],
"ageBand", Age[AgeBand],
"eligibleCnt", [EligibleCnt],
"contributingCnt", [ContributingCnt])'

INSERT INTO #balancebyageparticipation (
  planNumber,
  ageBand,
  eligibleCnt,
  contributingCnt
)
EXEC (@query) AT Balance;

SELECT * FROM #balancebyageparticipation

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
CAST("Age[AgeBand]" AS VARCHAR(10)) AS ageBand,
"[EligibleCnt]" AS eligibleCnt,
"[ContributingCnt]" AS contributingCnt
FROM OPENQUERY([Balance],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
Age[AgeBand],
FILTER(VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EligibleCnt", [EligibleCnt], 
"ContributingCnt", [ContributingCnt])''
)'

EXEC(@query);
*/


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetBalanceByDiv_Contribution]    Script Date: 6/17/2021 11:04:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt3_GetBalanceByDiv_Contribution] @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ;

CREATE     PROCEDURE [ex].[usp_Rpt3_GetBalanceByDiv_Contribution] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(max) = @divisionCodes;


DECLARE @query VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @dateStr VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END

IF OBJECT_ID('tempdb..#balancebydivcontribution') IS NOT NULL      
    DROP TABLE #balancebydivcontribution  ;

CREATE TABLE #balancebydivcontribution (
  planNumber VARCHAR(20),
  divisionCode VARCHAR(10),
  divisionName VARCHAR(100),
  avgContributionInContributingByAmt DECIMAL(18,2),
  avgContributionInContributingByRate DECIMAL(5,4),
  avgContributionRateInEligible DECIMAL(5,4),
  avgContributionAmtInEligible DECIMAL(18,2)
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
Division[DivisionCode],
Division[DivisionName],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"AvgContributionInContributingAmt", [AvgContributionInContributingAmt],
"AvgContributionInContributingRate", [AvgContributionInContributingRate],
"AvgContributionInEligibleRate", [AvgContributionInEligibleRate],
"AvgContributionInEligibleAmt", [AvgContributionInEligibleAmt]),
"planNumber", Plan[caseNumber],
"divisionCode", Division[DivisionCode],
"divisionName", Division[DivisionName],
"avgContributionInContributingByAmt", [AvgContributionInContributingAmt],
"avgContributionInContributingByRate", [AvgContributionInContributingRate],
"avgContributionRateInEligible", [AvgContributionInEligibleRate],
"avgContributionAmtInEligible", [AvgContributionInEligibleAmt])'

INSERT INTO #balancebydivcontribution (
  planNumber,
  divisionCode,
  divisionName,
  avgContributionInContributingByAmt,
  avgContributionInContributingByRate,
  avgContributionRateInEligible,
  avgContributionAmtInEligible
)
EXEC (@query) AT Balance;

SELECT * FROM #balancebydivcontribution

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
CAST("Division[DivisionCode]" AS VARCHAR(10)) AS divisionCode,
CAST("Division[DivisionName]" AS VARCHAR(100)) AS divisionName,
CAST("[AvgContributionInContributingAmt]" AS DECIMAL(18,2)) AS avgContributionInContributingByAmt,
CAST("[AvgContributionInContributingRate]" AS DECIMAL(5,4)) AS avgContributionInContributingByRate,
CAST("[AvgContributionInEligibleRate]" AS DECIMAL(5,4)) AS avgContributionRateInEligible,
CAST("[AvgContributionInEligibleAmt]" AS DECIMAL(18,2)) AS avgContributionAmtInEligible
FROM OPENQUERY([Balance],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
Division[DivisionCode],
Division[DivisionName],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"AvgContributionInContributingAmt", [AvgContributionInContributingAmt],
"AvgContributionInContributingRate", [AvgContributionInContributingRate],
"AvgContributionInEligibleRate", [AvgContributionInEligibleRate],
"AvgContributionInEligibleAmt", [AvgContributionInEligibleAmt])''
)'
;
EXEC(@query);
*/


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetBalanceByDiv_Participation]    Script Date: 6/17/2021 11:04:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it:
--EXEC [ex].[usp_Rpt3_GetBalanceByDiv_Participation] @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ;

CREATE     PROCEDURE [ex].[usp_Rpt3_GetBalanceByDiv_Participation] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(max) = @divisionCodes;


DECLARE @query VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @dateStr VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END

IF OBJECT_ID('tempdb..#balancebydivparticipation') IS NOT NULL      
    DROP TABLE #balancebydivparticipation  ;

CREATE TABLE #balancebydivparticipation (
  planNumber VARCHAR(20),
  divisionCode VARCHAR(10),
  divisionName VARCHAR(100),
  eligibleCnt INTEGER,
  contributingCnt INTEGER
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
Division[DivisionCode],
Division[DivisionName],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EligibleCnt", [EligibleCnt],
"ContributingCnt", [ContributingCnt]),
"planNumber", Plan[caseNumber],
"divisionCode", Division[DivisionCode],
"divisionName", Division[DivisionName],
"eligibleCnt", [EligibleCnt],
"contributingCnt", [ContributingCnt])'

INSERT INTO #balancebydivparticipation (
  planNumber,
  divisionCode,
  divisionName,
  eligibleCnt,
  contributingCnt
)
EXEC (@query) AT Balance;

SELECT * FROM #balancebydivparticipation

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
CAST("Division[DivisionCode]" AS VARCHAR(10)) AS divisionCode,
CAST("Division[DivisionName]" AS VARCHAR(100)) AS divisionName,
"[EligibleCnt]" AS eligibleCnt,
"[ContributingCnt]" AS contributingCnt
FROM OPENQUERY([Balance],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
Division[DivisionCode],
Division[DivisionName],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EligibleCnt", [EligibleCnt],
"ContributingCnt", [ContributingCnt])''
)'
;

EXEC(@query);
*/


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetPlanLevelFlags]    Script Date: 6/17/2021 11:04:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 13.

--To test it: 
--EXEC [ex].[usp_Rpt3_GetPlanLevelFlags] @caseNumber = '931061    00606';

CREATE   PROCEDURE [ex].[usp_Rpt3_GetPlanLevelFlags] (
 @caseNumber VARCHAR(20)
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 

DECLARE @query VARCHAR(8000);

SELECT [dimPlanId], 
       [CaseNumber] as planNumber, 
	   [PlanName], 
	   [CompanyName], 
 
	   [OutsourceDeferralFlag] AS outsourceFlag, 
	   CASE WHEN DeferralMethod = 'PERCENTS ONLY' THEN 1 ELSE 0 END AS  percentsOnlyFlag,
	   CASE WHEN DeferralMethod = 'PERCENTS OR DOLLARS' THEN 1 ELSE 0 END AS percentsOrDollarsFlag, 
	   CASE WHEN DeferralMethod = 'DOLLARS ONLY' THEN 1 ELSE 0 END AS  dollarsOnlyFlag,
	   [PreTaxFlag] AS preTaxFlag, 
	   [RothFlag] AS rothFlag, 
	   [AfterTaxFlag] AS afterTaxFlag, 
	   
	   [PretaxContributionFlag] AS pretaxContributionFlag, 
	   [RothContributionFlag] AS rothContributionFlag, 
	   [AfterTaxContributionFlag] AS aftertaxContributionFlag,

	   [CustomPortfolios] AS allowCustomPortfolios, 
	   [DCMA] AS allowDCMA, 
	   [PCRA] AS allowPCRA, 
	   [PortfolioXpress] AS allowPortfolioXpress, 
	   [SecurePathForLife] AS allowSecurePathForLife
FROM ref.tab_PlanLevelFlags p WITH (NOLOCK)
  LEFT JOIN [wxstg].[WXPlansRef] w WITH (NOLOCK)
    ON p.CaseNumber = w.PlanNumber
WHERE w.PlanNumberEnv = @caseNumber OR p.CaseNumber = @caseNumber

GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetTransaction_Contributions]    Script Date: 6/17/2021 11:04:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt3_GetTransaction_Contributions] @caseNumber = 'NQ98232TP 02005', @fromDate = '01/01/2020', @toDate = '01/20/2020' ; 


CREATE     PROCEDURE [ex].[usp_Rpt3_GetTransaction_Contributions] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(max) = @divisionCodes;

DECLARE @query VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @dateStr VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]>=DATEVALUE("' + @fDate + '") && ''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END

IF OBJECT_ID('tempdb..#transactioncontribution') IS NOT NULL      
    DROP TABLE #transactioncontribution  ;

CREATE TABLE #transactioncontribution (
  planNumber VARCHAR(20),
  employerContribution  DECIMAL(18,2),
  employeeContribution  DECIMAL(18,2),
  contractExchangeAmt  DECIMAL(18,2),
  contractExchangePPTCnt  INTEGER,
  rolloverAmt  DECIMAL(18,2),
  rolloverPPTCnt INTEGER,
  avgEmployeeContributionAmt  DECIMAL(18,2),
  avgPreTaxEmployeeContributionAmt  DECIMAL(18,2),
  avgRothEmployeeContributionAmt  DECIMAL(18,2),
  avgAfterTaxEmployeeContributionAmt  DECIMAL(18,2)
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EmployerContributionAmt", [EmployerContributionAmt],
"EmployeeContributionAmt", [EmployeeContributionAmt],
"ContractExchangeAmount", [ContractExchangeAmount],
"ContractExchangeParticipantCnt", [ContractExchangeParticipantCnt],
"RolloverAmount", [RolloverAmount],
"RolloverParticipantCnt", [RolloverParticipantCnt],
"AvgEmployeeContributionAmt", [AvgEmployeeContributionAmt],
"AvgEmployeePretaxContributionAmt", [AvgEmployeePretaxContributionAmt],
"AvgEmployeeRothContributionAmt", [AvgEmployeeRothContributionAmt],
"AvgEmployeeAfterTaxContributionAmt", [AvgEmployeeAfterTaxContributionAmt]),
"planNumber", Plan[caseNumber],
"employerContribution", [EmployerContributionAmt],
"employeeContribution", [EmployeeContributionAmt],
"contractExchangeAmt", [ContractExchangeAmount],
"contractExchangePPTCnt", [ContractExchangeParticipantCnt],
"rolloverAmt", [RolloverAmount],
"rolloverPPTCnt", [RolloverParticipantCnt],
"avgEmployeeContributionAmt", [AvgEmployeeContributionAmt],
"avgPreTaxEmployeeContributionAmt", [AvgEmployeePretaxContributionAmt],
"avgRothEmployeeContributionAmt", [AvgEmployeeRothContributionAmt],
"avgAfterTaxEmployeeContributionAmt", [AvgEmployeeAfterTaxContributionAmt])'

INSERT INTO #transactioncontribution (
  planNumber,
  employerContribution,
  employeeContribution,
  contractExchangeAmt,
  contractExchangePPTCnt,
  rolloverAmt,
  rolloverPPTCnt,
  avgEmployeeContributionAmt,
  avgPreTaxEmployeeContributionAmt,
  avgRothEmployeeContributionAmt,
  avgAfterTaxEmployeeContributionAmt
)
EXEC (@query) AT [Transaction];

SELECT planNumber,
  COALESCE(employerContribution, 0) + COALESCE(employeeContribution, 0) AS totalContribution,
  employerContribution,
  employeeContribution,
  contractExchangeAmt,
  contractExchangePPTCnt,
  rolloverAmt,
  rolloverPPTCnt,
  avgEmployeeContributionAmt,
  avgPreTaxEmployeeContributionAmt,
  avgRothEmployeeContributionAmt,
  avgAfterTaxEmployeeContributionAmt
FROM #transactioncontribution

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
COALESCE(CAST("[EmployerContributionAmt]" AS DECIMAL(18,2)), 0) + COALESCE(CAST("[EmployeeContributionAmt]" AS DECIMAL(18,2)), 0) AS totalContribution,
CAST("[EmployerContributionAmt]" AS DECIMAL(18,2)) AS employerContribution,
CAST("[EmployeeContributionAmt]" AS DECIMAL(18,2)) AS employeeContribution,
CAST("[ContractExchangeAmount]" AS DECIMAL(18,2)) AS contractExchangeAmt,
"[ContractExchangeParticipantCnt]" AS contractExchangePPTCnt,
CAST("[RolloverAmount]" AS DECIMAL(18,2)) AS rolloverAmt,
"[RolloverParticipantCnt]" AS rolloverPPTCnt,
CAST("[AvgEmployeeContributionAmt]" AS DECIMAL(18,2)) AS avgEmployeeContributionAmt,
CAST("[AvgEmployeePretaxContributionAmt]" AS DECIMAL(18,2)) AS avgPreTaxEmployeeContributionAmt,
CAST("[AvgEmployeeRothContributionAmt]" AS DECIMAL(18,2)) AS avgRothEmployeeContributionAmt,
CAST("[AvgEmployeeAfterTaxContributionAmt]" AS DECIMAL(18,2)) AS avgAfterTaxEmployeeContributionAmt		
FROM OPENQUERY([Transaction],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"EmployerContributionAmt", [EmployerContributionAmt],
"EmployeeContributionAmt", [EmployeeContributionAmt],
"ContractExchangeAmount", [ContractExchangeAmount],
"ContractExchangeParticipantCnt", [ContractExchangeParticipantCnt],
"RolloverAmount", [RolloverAmount],
"RolloverParticipantCnt", [RolloverParticipantCnt],
"AvgEmployeeContributionAmt", [AvgEmployeeContributionAmt],
"AvgEmployeePretaxContributionAmt", [AvgEmployeePretaxContributionAmt],
"AvgEmployeeRothContributionAmt", [AvgEmployeeRothContributionAmt],
"AvgEmployeeAfterTaxContributionAmt", [AvgEmployeeAfterTaxContributionAmt])''
) ';

EXEC(@query);
*/


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetTransaction_Distribution]    Script Date: 6/17/2021 11:04:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt3_GetTransaction_Distribution] @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ; 


CREATE    PROCEDURE [ex].[usp_Rpt3_GetTransaction_Distribution] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(max) = @divisionCodes;

DECLARE @query VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @dateStr VARCHAR(max);

IF OBJECT_ID('tempdb..#tmpResultDist') IS NOT NULL      
    DROP TABLE #tmpResultDist  ;

CREATE TABLE #tmpResultDist (
    planNumber VARCHAR(20),      
    distributionAmountFundsOnDeposit NUMERIC(18, 2),
    distributionAmountHardship NUMERIC(18, 2),
    distributionAmountInstallment NUMERIC(18, 2),
    distributionAmountLumpsum NUMERIC(18, 2),
    distributionAmountNonHardship NUMERIC(18, 2),
	distributionAmountRollover NUMERIC(18, 2), 
	distributionPPTCntFundsOnDeposit INTEGER, 
	distributionPPTCntHardship INTEGER, 
	distributionPPTCntInstallment INTEGER, 
	distributionPPTCntLumpsum INTEGER, 
	distributionPPTCntNonHardship INTEGER, 
	distributionPPTCntRollover INTEGER,
	totalDistributionAmount NUMERIC(18, 2),
	totalDistributionPPTCnt INTEGER
       
);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]>=DATEVALUE("' + @fDate + '") && ''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END


SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"DistributionAmountFundsOnDeposit", [DistributionAmountFundsOnDeposit],
"DistributionAmountHardship", [DistributionAmountHardship],
"DistributionAmountInstallment", [DistributionAmountInstallment],
"DistributionAmountLumpsum", [DistributionAmountLumpsum],
"DistributionAmountNonHardship", [DistributionAmountNonHardship],
"DistributionAmountRollover", [DistributionAmountRollover],
"DistributionPPTCntFundsOnDeposit", [DistributionPPTCntFundsOnDeposit],
"DistributionPPTCntHardship", [DistributionPPTCntHardship],
"DistributionPPTCntInstallment", [DistributionPPTCntInstallment],
"DistributionPPTCntLumpsum", [DistributionPPTCntLumpsum],
"DistributionPPTCntNonHardship", [DistributionPPTCntNonHardship],
"DistributionPPTCntRollover", [DistributionPPTCntRollover],
"DistributionAmount", [DistributionAmount],
"ParticipantCount", [ParticipantCount]),
"planNumber", Plan[caseNumber], 
"distributionAmountFundsOnDeposit", [DistributionAmountFundsOnDeposit], 
"distributionAmountHardship", [DistributionAmountHardship], 
"distributionAmountInstallment", [DistributionAmountInstallment], 
"distributionAmountLumpsum", [DistributionAmountLumpsum], 
"distributionAmountNonHardship", [DistributionAmountNonHardship], 
"distributionAmountRollover", [DistributionAmountRollover],
"distributionPPTCntFundsOnDeposit", [DistributionPPTCntFundsOnDeposit],
"distributionPPTCntHardship", [DistributionPPTCntHardship],
"distributionPPTCntInstallment", [DistributionPPTCntInstallment], 
"distributionPPTCntLumpsum", [DistributionPPTCntLumpsum], 
"distributionPPTCntNonHardship", [DistributionPPTCntNonHardship], 
"distributionPPTCntRollover", [DistributionPPTCntRollover], 
"totalDistributionAmount", [DistributionAmount], 
"totalDistributionPPTCnt", [ParticipantCount])'

INSERT INTO #tmpResultDist ( 
  planNumber, 
  distributionAmountFundsOnDeposit, 
  distributionAmountHardship, 
  distributionAmountInstallment, 
  distributionAmountLumpsum, 
  distributionAmountNonHardship, 
  distributionAmountRollover,
  distributionPPTCntFundsOnDeposit,
  distributionPPTCntHardship,
  distributionPPTCntInstallment, 
  distributionPPTCntLumpsum, 
  distributionPPTCntNonHardship, 
  distributionPPTCntRollover, 
  totalDistributionAmount, 
  totalDistributionPPTCnt
)
EXEC (@query) AT [Transaction];

/*
SET @query = 
'INSERT INTO #tmpResultDist(planNumber, distributionAmountFundsOnDeposit, distributionAmountHardship, distributionAmountInstallment, distributionAmountLumpsum, distributionAmountNonHardship, distributionAmountRollover,
distributionPPTCntFundsOnDeposit,distributionPPTCntHardship,distributionPPTCntInstallment, distributionPPTCntLumpsum, distributionPPTCntNonHardship, distributionPPTCntRollover, totalDistributionAmount, totalDistributionPPTCnt)
SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)),
"[DistributionAmountFundsOnDeposit]",
"[DistributionAmountHardship]",
"[DistributionAmountInstallment]",
"[DistributionAmountLumpsum]",
"[DistributionAmountNonHardship]",
"[DistributionAmountRollover]",
"[DistributionPPTCntFundsOnDeposit]",
"[DistributionPPTCntHardship]",
"[DistributionPPTCntInstallment]",
"[DistributionPPTCntLumpsum]",
"[DistributionPPTCntNonHardship]",
"[DistributionPPTCntRollover]",
"[DistributionAmount]",
"[ParticipantCount]"
FROM OPENQUERY([Transaction],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"DistributionAmountFundsOnDeposit", [DistributionAmountFundsOnDeposit],
"DistributionAmountHardship", [DistributionAmountHardship],
"DistributionAmountInstallment", [DistributionAmountInstallment],
"DistributionAmountLumpsum", [DistributionAmountLumpsum],
"DistributionAmountNonHardship", [DistributionAmountNonHardship],
"DistributionAmountRollover", [DistributionAmountRollover],
"DistributionPPTCntFundsOnDeposit", [DistributionPPTCntFundsOnDeposit],
"DistributionPPTCntHardship", [DistributionPPTCntHardship],
"DistributionPPTCntInstallment", [DistributionPPTCntInstallment],
"DistributionPPTCntLumpsum", [DistributionPPTCntLumpsum],
"DistributionPPTCntNonHardship", [DistributionPPTCntNonHardship],
"DistributionPPTCntRollover", [DistributionPPTCntRollover],
"DistributionAmount", [DistributionAmount],
"ParticipantCount", [ParticipantCount])''
)';

EXEC(@query);
*/

SELECT planNumber, 
  'Funds On Deposit' AS withdrawalType, 
  distributionAmountFundsOnDeposit AS withdrawalAmount,
  distributionPPTCntFundsOnDeposit AS participantCnt
FROM #tmpResultDist
UNION ALL
SELECT planNumber,
  'Lumpsum' AS withdrawalType, 
  distributionAmountLumpsum AS withdrawalAmount,
  distributionPPTCntLumpsum AS participantCnt
FROM #tmpResultDist
UNION ALL
SELECT planNumber,
  'Rollover' AS withdrawalType, 
  distributionAmountRollover AS withdrawalAmount,
  distributionPPTCntRollover AS participantCnt
FROM #tmpResultDist
UNION ALL
SELECT planNumber,
  'Hardship' AS withdrawalType, 
  distributionAmountHardship AS withdrawalAmount,
  distributionPPTCntHardship AS participantCnt
FROM #tmpResultDist
UNION ALL
SELECT planNumber,
  'Installment' AS withdrawalType, 
  distributionAmountInstallment AS withdrawalAmount,
  distributionPPTCntInstallment AS participantCnt
FROM #tmpResultDist
UNION ALL
SELECT planNumber,
  'Non - Hardship' AS withdrawalType, 
  distributionAmountNonHardship AS withdrawalAmount,
  distributionPPTCntNonHardship AS participantCnt
FROM #tmpResultDist
UNION ALL
SELECT planNumber,
  'Total' AS withdrawalType, 
  totalDistributionAmount AS withdrawalAmount,
  totalDistributionPPTCnt AS participantCnt
FROM #tmpResultDist



GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetTransaction_LoansNewEnroll]    Script Date: 6/17/2021 11:04:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt3_GetTransaction_LoansNewEnroll] @caseNumber = 'JK62276TP 00001', @fromDate = '06/01/2018', @toDate = '10/31/2018' ; 


CREATE     PROCEDURE [ex].[usp_Rpt3_GetTransaction_LoansNewEnroll] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(max) = @divisionCodes;

DECLARE @query VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @dateStr VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]>=DATEVALUE("' + @fDate + '") && ''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END

IF OBJECT_ID('tempdb..#transactionloans') IS NOT NULL      
    DROP TABLE #transactionloans  ;

CREATE TABLE #transactionloans (
  planNumber VARCHAR(20),
  activeLoanBalance MONEY,
  deemedLoanBalance MONEY,
  outstandingLoanBalance MONEY,
  activeLoanCnt INTEGER,
  deemedLoanCnt INTEGER,
  outstandingLoanCnt INTEGER,
  activeLoanEECnt INTEGER,
  deemedLoanEECnt INTEGER,
  outstandingLoanEECnt INTEGER,
  newLoanCnt INTEGER,
  NewEnrollmentCount INTEGER
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"ActiveLoanBalance", [ActiveLoanBalance],
"DeemedLoanBalance", [DeemedLoanBalance],
"OutstandingLoanBalance", [OutstandingLoanBalance],
"ActiveLoanCnt", [ActiveLoanCnt],
"DeemedLoanCnt", [DeemedLoanCnt],
"OutstandingLoanCnt", [OutstandingLoanCnt],
"ActiveLoanEECnt", [ActiveLoanEECnt],
"DeemedLoanEECnt", [DeemedLoanEECnt],
"OutstandingLoanEECnt", [OutstandingLoanEECnt],
"NewLoanCnt", [NewLoanCnt],
"NewEnrollmentCount", [NewEnrollmentCount]),
"planNumber", Plan[caseNumber],
"activeLoanBalance", [ActiveLoanBalance],
"deemedLoanBalance", [DeemedLoanBalance],
"outstandingLoanBalance", [OutstandingLoanBalance],
"activeLoanCnt", [ActiveLoanCnt],
"deemedLoanCnt", [DeemedLoanCnt],
"outstandingLoanCnt", [OutstandingLoanCnt],
"activeLoanEECnt", [ActiveLoanEECnt],
"deemedLoanEECnt", [DeemedLoanEECnt],
"outstandingLoanEECnt", [OutstandingLoanEECnt],
"newLoanCnt", [NewLoanCnt],
"NewEnrollmentCount", [NewEnrollmentCount])'

INSERT INTO #transactionloans (
  planNumber ,
  activeLoanBalance,
  deemedLoanBalance,
  outstandingLoanBalance,
  activeLoanCnt,
  deemedLoanCnt,
  outstandingLoanCnt,
  activeLoanEECnt,
  deemedLoanEECnt,
  outstandingLoanEECnt,
  newLoanCnt,
  NewEnrollmentCount
)
EXEC (@query) AT [Transaction];

SELECT * FROM #transactionloans

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
CAST("[ActiveLoanBalance]" AS MONEY) AS activeLoanBalance,
CAST("[DeemedLoanBalance]" AS MONEY) AS deemedLoanBalance,
CAST("[OutstandingLoanBalance]" AS MONEY) AS outstandingLoanBalance,
"[ActiveLoanCnt]" AS activeLoanCnt,
"[DeemedLoanCnt]" AS deemedLoanCnt,
"[OutstandingLoanCnt]" AS outstandingLoanCnt,
"[ActiveLoanEECnt]" AS activeLoanEECnt,
"[DeemedLoanEECnt]" AS deemedLoanEECnt,
"[OutstandingLoanEECnt]" AS outstandingLoanEECnt,
"[NewLoanCnt]" AS newLoanCnt,
"[NewEnrollmentCount]" AS NewEnrollmentCount
FROM OPENQUERY([Transaction],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"ActiveLoanBalance", [ActiveLoanBalance],
"DeemedLoanBalance", [DeemedLoanBalance],
"OutstandingLoanBalance", [OutstandingLoanBalance],
"ActiveLoanCnt", [ActiveLoanCnt],
"DeemedLoanCnt", [DeemedLoanCnt],
"OutstandingLoanCnt", [OutstandingLoanCnt],
"ActiveLoanEECnt", [ActiveLoanEECnt],
"DeemedLoanEECnt", [DeemedLoanEECnt],
"OutstandingLoanEECnt", [OutstandingLoanEECnt],
"NewLoanCnt", [NewLoanCnt],
"NewEnrollmentCount", [NewEnrollmentCount])''
) '
;

EXEC(@query);
*/


GO
/****** Object:  StoredProcedure [ex].[usp_Rpt3_GetTransactionByDiv_Distribution]    Script Date: 6/17/2021 11:04:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--To test it: 
--EXEC [ex].[usp_Rpt3_GetTransactionByDiv_Distribution] @caseNumber = 'JK62276TP 00001', @fromDate = '2018-10-01', @toDate = '2018-12-31' ;

CREATE     PROCEDURE [ex].[usp_Rpt3_GetTransactionByDiv_Distribution] (
 @caseNumber VARCHAR(20), 
 @fromDate VARCHAR(10) = NULL, 
 @toDate VARCHAR(10) = NULL,
 @divisionCodes VARCHAR(max) = NULL 
)
AS
SET NOCOUNT ON;

DECLARE @thePlan VARCHAR(20) = @caseNumber; 
DECLARE @fDate VARCHAR(10) = @fromDate; 
DECLARE @tDate VARCHAR(10) = @toDate; 
DECLARE @dCodes VARCHAR(max) = @divisionCodes;

DECLARE @query VARCHAR(max);
DECLARE @divStr VARCHAR(max);
DECLARE @dateStr VARCHAR(max);

SET @dateStr = 'FILTER(VALUES(''Date''[DateValue]), (''Date''[DateValue]>=DATEVALUE("' + @fDate + '") && ''Date''[DateValue]<=DATEVALUE("' + @tDate + '") )),';

IF (@dCodes IS NULL) OR (@dCodes = '') 
BEGIN
  SET @divStr = ''
END
ELSE
BEGIN
  SET @divStr = ' FILTER(VALUES(Division[DivisionCode]),(Division[DivisionCode]="' + replace(@dCodes, ',', '") || (Division[DivisionCode]="') + '")),'
END

IF OBJECT_ID('tempdb..#transactionbydivdistribution') IS NOT NULL      
    DROP TABLE #transactionbydivdistribution  ;

CREATE TABLE #transactionbydivdistribution (
  planNumber VARCHAR(20),
  divisionCode VARCHAR(10),
  divisionName VARCHAR(100),
  withdrawalAmount MONEY,
  participantCnt INTEGER
)

SET @query = 'EVALUATE SELECTCOLUMNS(SUMMARIZECOLUMNS(Plan[caseNumber],
Division[DivisionCode],
Division[DivisionName],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"DistributionAmount", [DistributionAmount],
"ParticipantCount", [ParticipantCount]),
"planNumber", Plan[caseNumber],
"divisionCode", Division[DivisionCode],
"divisionName", Division[DivisionName],
"withdrawalAmount", [DistributionAmount],
"participantCnt", [ParticipantCount])'

INSERT INTO #transactionbydivdistribution (
  planNumber,
  divisionCode,
  divisionName,
  withdrawalAmount,
  participantCnt
)
EXEC (@query) AT [Transaction];

SELECT * FROM #transactionbydivdistribution

/*
SET @query = 
'SELECT CAST("Plan[caseNumber]" AS VARCHAR(20)) AS planNumber,
CAST("Division[DivisionCode]" AS VARCHAR(10)) AS divisionCode,
CAST("Division[DivisionName]" AS VARCHAR(100)) AS divisionName,
CAST("[DistributionAmount]" AS MONEY) AS withdrawalAmount,
"[ParticipantCount]" AS participantCnt
FROM OPENQUERY([Transaction],
''EVALUATE SUMMARIZECOLUMNS(Plan[caseNumber],
Division[DivisionCode],
Division[DivisionName],
FILTER( VALUES(Plan[CaseNumber]), (Plan[CaseNumber]="' + @thePlan + '")), ' + @dateStr + @divStr + 
'"DistributionAmount", [DistributionAmount],
"ParticipantCount", [ParticipantCount])''
) ';
;

EXEC(@query);

*/


GO
/****** Object:  StoredProcedure [ex].[usp_Validate_PopulateResultSummary]    Script Date: 6/17/2021 11:04:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [ex].[usp_Validate_PopulateResultSummary]
AS
SET NOCOUNT ON;

INSERT INTO [dbo].[Validate_Result_Summary](
	[TestId] ,
	[TestDomain] ,
	[TestCategory] ,
	[TestName] ,
	[ErrorType] ,
	[CaseNumber] ,
	[ReportDate] ,
	[DimensionName1] ,
	[DimensionValue1] ,
	[DimensionName2] ,
	[DimensionValue2] ,
	[DimensionName3] ,
	[DimensionValue3] ,
	[MeasureName1] ,
	[SourceMeasureValue1] ,
	[TargetMeasureValue1] ,
	[MeasureName2] ,
	[SourceMeasureValue2] ,
	[TargetMeasureValue2] ,
	[MeasureName3] ,
	[SourceMeasureValue3] ,
	[TargetMeasureValue3] ,
	[SourceRunDateTime] ,
	[TargetRunDateTime] 
) 
SELECT COALESCE(s.TestId, t.TestId) AS TestId,
       COALESCE(s.TestDomain, t.TestDomain) AS TestDomain,  
	   COALESCE(s.TestCategory, t.TestCategory) AS TestCategory,
	   COALESCE(s.TestName, t.TestName) AS TestName,
	   CASE WHEN (t.DimensionValue1 <> '' AND s.DimensionValue1 = '') OR 
	             (t.DimensionValue2 <> '' AND s.DimensionValue2 = '') OR
				 (t.DimensionValue3 <> '' AND s.DimensionValue3 = '')  
	        THEN 'Extra dimension record'
			WHEN (s.DimensionValue1 <> '' AND t.DimensionValue1 = '') OR 
	             (s.DimensionValue2 <> '' AND t.DimensionValue2 = '') OR
				 (s.DimensionValue3 <> '' AND t.DimensionValue3 = '') 
	        THEN 'Missing dimension record'
			WHEN s.ReportDate IS NULL 
			THEN 'Extra ReportDate'
			WHEN t.ReportDate IS NULL
			THEN 'Missing ReportDate'
			WHEN (COALESCE(s.MeasureValue1,0) <> COALESCE(t.MeasureValue1,0) OR COALESCE(s.MeasureValue2,0) <> COALESCE(t.MeasureValue2,0) OR COALESCE(s.MeasureValue3,0) <> COALESCE(t.MeasureValue3,0)) 
	        THEN 'Different measure values'
	   END AS ErrorType,
	   COALESCE(s.CaseNumber, t.CaseNumber) AS CaseNumber,
	   COALESCE(s.ReportDate, t.ReportDate) AS ReportDate,
	   COALESCE(s.DimensionName1, t.DimensionName1) AS DimensionName1,
	   COALESCE(s.DimensionValue1, t.DimensionValue1) AS DimensionValue1,
	   COALESCE(s.DimensionName2, t.DimensionName2) AS DimensionName2,
	   COALESCE(s.DimensionValue2, t.DimensionValue2) AS DimensionValue2,
	   COALESCE(s.DimensionName3, t.DimensionName3) AS DimensionName3,
	   COALESCE(s.DimensionValue3, t.DimensionValue3) AS DimensionValue3,
	   COALESCE(s.MeasureName1, t.MeasureName1) AS MeasureName1,
	   s.MeasureValue1 AS SourceMeasureValue1,
	   t.MeasureValue1 AS TargetmeasureValue1,
	   COALESCE(s.MeasureName2, t.MeasureName2) AS MeasureName2,
	   s.MeasureValue2 AS SourceMeasureValue2,
	   t.MeasureValue2 AS TargetmeasureValue2,
	   COALESCE(s.MeasureName3, t.MeasureName3) AS MeasureName3,
	   s.MeasureValue3 AS SourceMeasureValue3,
	   t.MeasureValue3 AS TargetmeasureValue3,
	   s.RunDateTime AS SourceRunDateTime,
	   t.RunDateTime AS TargetRunDateTime
FROM WorkplaceExperience.dbo.Validate_Result_Source s 
  INNER JOIN WorkplaceExperience.dbo.Validate_PlanList p ON s.CaseNumber = p.CaseNumber AND p.Enabled = 1
  FULL OUTER JOIN WorkplaceExperience.dbo.Validate_Result_Target t ON s.TestId = t.TestId AND p.ModifiedCaseNumber = t.CaseNumber AND s.ReportDate = t.ReportDate
     AND COALESCE(s.DimensionValue1, '') = COALESCE(t.DimensionValue1, '') AND COALESCE(s.DimensionValue2, '') = COALESCE(t.DimensionValue2, '') AND COALESCE(s.DimensionValue3, '') = COALESCE(t.DimensionValue3, '')
WHERE ROUND(COALESCE(s.MeasureValue1,0), 0) <> ROUND(COALESCE(t.MeasureValue1,0), 0) OR 
      ROUND(COALESCE(s.MeasureValue2,0), 0) <> ROUND(COALESCE(t.MeasureValue2,0), 0) OR 
	  ROUND(COALESCE(s.MeasureValue3,0), 0) <> ROUND(COALESCE(t.MeasureValue3,0), 0)

GO
/****** Object:  StoredProcedure [wxstg].[usp_Insert_MetricsCaseLevel]    Script Date: 6/17/2021 11:04:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [wxstg].[usp_Insert_MetricsCaseLevel]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
MERGE WorkplaceExperience.ex.MetricsCaseLevel AS target
	USING WorkplaceExperience.wxstg.MetricsCaseLevel AS source ON
(target.PlanNumber = source.PlanNumber AND year(target.ReportDate) = year(source.ReportDate) AND month(target.ReportDate) = month(source.ReportDate))
WHEN MATCHED THEN UPDATE SET
		 target.dimPlanId=source.dimPlanId
		,target.ContractNumber=source.ContractNumber
		,target.AffiliateNumber=source.AffiliateNumber
		,target.CompanyName=source.CompanyName
		,target.PlanName=source.PlanName
		,target.PlanType=source.PlanType
		,target.PlanCategory=source.PlanCategory
		,target.TotalParticipantCount=source.TotalParticipantCount
		,target.ActiveParticipantCount=source.ActiveParticipantCount
		,target.TerminatedParticipantCount=source.TerminatedParticipantCount
		,target.ParticipationRate=source.ParticipationRate
		,target.AvgContributionRate=source.AvgContributionRate
		,target.EligibleEmployeeCount=source.EligibleEmployeeCount
		,target.ContributingEmployeeCount=source.ContributingEmployeeCount
		,target.NonContributingEmployeeCount=source.NonContributingEmployeeCount
		,target.AvgContributionAmount=source.AvgContributionAmount
		,target.ActiveParticipantCoreFunds=source.ActiveParticipantCoreFunds
		,target.TerminatedParticipantCoreFunds=source.TerminatedParticipantCoreFunds
		,target.AvgParticipantCoreFund=source.AvgParticipantCoreFund
		,target.AvgActiveParticipantCoreFund=source.AvgActiveParticipantCoreFund
		,target.AvgTerminatedParticipantCoreFund=source.AvgTerminatedParticipantCoreFund
		,target.PCRA_Allowed_Flag=source.PCRA_Allowed_Flag
		,target.ActiveParticipantPCRA=source.ActiveParticipantPCRA
		,target.TerminatedParticipantPCRA=source.TerminatedParticipantPCRA
		,target.AvgParticipantPCRA=source.AvgParticipantPCRA
		,target.AvgActiveParticipantPCRA=source.AvgActiveParticipantPCRA
		,target.AvgTerminatedParticipantPCRA=source.AvgTerminatedParticipantPCRA
		,target.SDB_Allowed_Flag=source.SDB_Allowed_Flag
		,target.ActiveParticipantSDB=source.ActiveParticipantSDB
		,target.TerminatedParticipantSDB=source.TerminatedParticipantSDB
		,target.AvgParticipantSDB=source.AvgParticipantSDB
		,target.AvgActiveParticipantSDB=source.AvgActiveParticipantSDB
		,target.AvgTerminatedParticipantSDB=source.AvgTerminatedParticipantSDB
		,target.SuspenseBalance=source.SuspenseBalance
		,target.ForefeitureBalance=source.ForefeitureBalance
		,target.ExpenseAccountBalance=source.ExpenseAccountBalance
		,target.AdvancedEmployerBalance=source.AdvancedEmployerBalance
		,target.ActiveParticipantResidentialLoanBalance=source.ActiveParticipantResidentialLoanBalance
		,target.ActiveParticipantsWithResidentialLoanBalance=source.ActiveParticipantsWithResidentialLoanBalance
		,target.ActiveParticipantResidentialHardshipLoanBalance=source.ActiveParticipantResidentialHardshipLoanBalance
		,target.ActiveParticipantsWithResidentialHardshipLoanBalance=source.ActiveParticipantsWithResidentialHardshipLoanBalance
		,target.ActiveParticipantPersonalLoanBalance=source.ActiveParticipantPersonalLoanBalance
		,target.ActiveParticipantsWithPersonalLoanBalance=source.ActiveParticipantsWithPersonalLoanBalance
		,target.ActiveParticipantPersonalHardshipLoanBalance=source.ActiveParticipantPersonalHardshipLoanBalance
		,target.ActiveParticipantsWithPersonalHardshipLoanBalance=source.ActiveParticipantsWithPersonalHardshipLoanBalance
		,target.ActiveParticipantOtherLoanBalance=source.ActiveParticipantOtherLoanBalance
		,target.ActiveParticipantsWithOtherLoanBalance=source.ActiveParticipantsWithOtherLoanBalance
		,target.TerminatedParticipantResidentialLoanBalance=source.TerminatedParticipantResidentialLoanBalance
		,target.TerminatedParticipantsWithResidentialLoanBalance=source.TerminatedParticipantsWithResidentialLoanBalance
		,target.TerminatedParticipantResidentialHardshipLoanBalance=source.TerminatedParticipantResidentialHardshipLoanBalance
		,target.TerminatedParticipantsWithResidentialHardshipLoanBalance=source.TerminatedParticipantsWithResidentialHardshipLoanBalance
		,target.TerminatedParticipantPersonalLoanBalance=source.TerminatedParticipantPersonalLoanBalance
		,target.TerminatedParticipantsWithPersonalLoanBalance=source.TerminatedParticipantsWithPersonalLoanBalance
		,target.TerminatedParticipantPersonalHardshipLoanBalance=source.TerminatedParticipantPersonalHardshipLoanBalance
		,target.TerminatedParticipantsWithPersonalHardshipLoanBalance=source.TerminatedParticipantsWithPersonalHardshipLoanBalance
		,target.TerminatedParticipantOtherLoanBalance=source.TerminatedParticipantOtherLoanBalance
		,target.TerminatedParticipantsWithOtherLoanBalance=source.TerminatedParticipantsWithOtherLoanBalance
		,target.LoanPermittedFlag=source.LoanPermittedFlag
		,target.ParticipantsPastDue=source.ParticipantsPastDue
		,target.ReportDate=source.ReportDate
		,target.LoadDate = GETDATE()
WHEN NOT MATCHED THEN INSERT
( 
	   dimPlanId
      ,PlanNumber
      ,ContractNumber
      ,AffiliateNumber
      ,CompanyName
      ,PlanName
      ,PlanType
      ,PlanCategory
      ,TotalParticipantCount
      ,ActiveParticipantCount
      ,TerminatedParticipantCount
      ,ParticipationRate
      ,AvgContributionRate
      ,EligibleEmployeeCount
      ,ContributingEmployeeCount
      ,NonContributingEmployeeCount
	  ,AvgContributionAmount
      ,ActiveParticipantCoreFunds
      ,TerminatedParticipantCoreFunds
      ,AvgParticipantCoreFund
      ,AvgActiveParticipantCoreFund
      ,AvgTerminatedParticipantCoreFund
      ,PCRA_Allowed_Flag
      ,ActiveParticipantPCRA
      ,TerminatedParticipantPCRA
      ,AvgParticipantPCRA
      ,AvgActiveParticipantPCRA
      ,AvgTerminatedParticipantPCRA
      ,SDB_Allowed_Flag
      ,ActiveParticipantSDB
      ,TerminatedParticipantSDB
      ,AvgParticipantSDB
      ,AvgActiveParticipantSDB
      ,AvgTerminatedParticipantSDB
      ,SuspenseBalance
      ,ForefeitureBalance
      ,ExpenseAccountBalance
      ,AdvancedEmployerBalance
      ,ActiveParticipantResidentialLoanBalance
      ,ActiveParticipantsWithResidentialLoanBalance
      ,ActiveParticipantResidentialHardshipLoanBalance
      ,ActiveParticipantsWithResidentialHardshipLoanBalance
      ,ActiveParticipantPersonalLoanBalance
      ,ActiveParticipantsWithPersonalLoanBalance
      ,ActiveParticipantPersonalHardshipLoanBalance
      ,ActiveParticipantsWithPersonalHardshipLoanBalance
      ,ActiveParticipantOtherLoanBalance
      ,ActiveParticipantsWithOtherLoanBalance
      ,TerminatedParticipantResidentialLoanBalance
      ,TerminatedParticipantsWithResidentialLoanBalance
      ,TerminatedParticipantResidentialHardshipLoanBalance
      ,TerminatedParticipantsWithResidentialHardshipLoanBalance
      ,TerminatedParticipantPersonalLoanBalance
      ,TerminatedParticipantsWithPersonalLoanBalance
      ,TerminatedParticipantPersonalHardshipLoanBalance
      ,TerminatedParticipantsWithPersonalHardshipLoanBalance
      ,TerminatedParticipantOtherLoanBalance
      ,TerminatedParticipantsWithOtherLoanBalance
      ,LoanPermittedFlag
      ,ParticipantsPastDue
      ,ReportDate
      ,LoadDate
)	  
VALUES
(		
	   source.dimPlanId
      ,source.PlanNumber
      ,source.ContractNumber
      ,source.AffiliateNumber
      ,source.CompanyName
      ,source.PlanName
      ,source.PlanType
      ,source.PlanCategory
      ,source.TotalParticipantCount
      ,source.ActiveParticipantCount
      ,source.TerminatedParticipantCount
      ,source.ParticipationRate
      ,source.AvgContributionRate
      ,source.EligibleEmployeeCount
      ,source.ContributingEmployeeCount
      ,source.NonContributingEmployeeCount
	  ,source.AvgContributionAmount
      ,source.ActiveParticipantCoreFunds
      ,source.TerminatedParticipantCoreFunds
      ,source.AvgParticipantCoreFund
      ,source.AvgActiveParticipantCoreFund
      ,source.AvgTerminatedParticipantCoreFund
      ,source.PCRA_Allowed_Flag
      ,source.ActiveParticipantPCRA
      ,source.TerminatedParticipantPCRA
      ,source.AvgParticipantPCRA
      ,source.AvgActiveParticipantPCRA
      ,source.AvgTerminatedParticipantPCRA
      ,source.SDB_Allowed_Flag
      ,source.ActiveParticipantSDB
      ,source.TerminatedParticipantSDB
      ,source.AvgParticipantSDB
      ,source.AvgActiveParticipantSDB
      ,source.AvgTerminatedParticipantSDB
      ,source.SuspenseBalance
      ,source.ForefeitureBalance
      ,source.ExpenseAccountBalance
      ,source.AdvancedEmployerBalance
      ,source.ActiveParticipantResidentialLoanBalance
      ,source.ActiveParticipantsWithResidentialLoanBalance
      ,source.ActiveParticipantResidentialHardshipLoanBalance
      ,source.ActiveParticipantsWithResidentialHardshipLoanBalance
      ,source.ActiveParticipantPersonalLoanBalance
      ,source.ActiveParticipantsWithPersonalLoanBalance
      ,source.ActiveParticipantPersonalHardshipLoanBalance
      ,source.ActiveParticipantsWithPersonalHardshipLoanBalance
      ,source.ActiveParticipantOtherLoanBalance
      ,source.ActiveParticipantsWithOtherLoanBalance
      ,source.TerminatedParticipantResidentialLoanBalance
      ,source.TerminatedParticipantsWithResidentialLoanBalance
      ,source.TerminatedParticipantResidentialHardshipLoanBalance
      ,source.TerminatedParticipantsWithResidentialHardshipLoanBalance
      ,source.TerminatedParticipantPersonalLoanBalance
      ,source.TerminatedParticipantsWithPersonalLoanBalance
      ,source.TerminatedParticipantPersonalHardshipLoanBalance
      ,source.TerminatedParticipantsWithPersonalHardshipLoanBalance
      ,source.TerminatedParticipantOtherLoanBalance
      ,source.TerminatedParticipantsWithOtherLoanBalance
      ,source.LoanPermittedFlag
      ,source.ParticipantsPastDue
      ,source.ReportDate
, GETDATE());

END


GO
/****** Object:  StoredProcedure [wxstg].[usp_Insert_Plans_List]    Script Date: 6/17/2021 11:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [wxstg].[usp_Insert_Plans_List]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
MERGE WorkplaceExperience.ex.plans_list AS target
	USING WorkplaceExperience.wxstg.plans_list AS source ON
(target.plannumber = source.plannumber)
WHEN MATCHED THEN UPDATE SET
		 target.planid=source.planid
WHEN NOT MATCHED THEN INSERT
( 
	   planid
      ,plannumber
)	  
VALUES
(		
	   source.planid
      ,source.plannumber
);

END

GO
/****** Object:  StoredProcedure [wxstg].[usp_Update_MetricsCaseLevel_PlanNumbers]    Script Date: 6/17/2021 11:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [wxstg].[usp_Update_MetricsCaseLevel_PlanNumbers]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE wxstg.MetricsCaseLevel 
SET PlanNumber=PlanNumberEnv
FROM
WorkplaceExperience.wxstg.WXPlansRef b ,
wxstg.MetricsCaseLevel a 
where a.PlanNumber = b.PlanNumber and b.PlanNumber like '%QA%';
END

GO
USE [master]
GO
ALTER DATABASE [WorkplaceExperience] SET  READ_WRITE 
GO

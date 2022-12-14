USE [master]
GO
/****** Object:  Database [Accounting_Adhoc]    Script Date: 6/17/2021 11:09:30 AM ******/
CREATE DATABASE [Accounting_Adhoc]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Accounting_Adhoc', FILENAME = N'K:\MSSQL13.SQL01\MSSQL\Data\AccountingAdhoc\Accounting_Adhoc.mdf' , SIZE = 362496000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10240KB )
 LOG ON 
( NAME = N'Accounting_Adhoc_log', FILENAME = N'K:\MSSQL13.SQL01\MSSQL\Data\AccountingAdhoc\Accounting_Adhoc_log.ldf' , SIZE = 9524800KB , MAXSIZE = 2048GB , FILEGROWTH = 204800KB )
GO
ALTER DATABASE [Accounting_Adhoc] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Accounting_Adhoc].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Accounting_Adhoc] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET ARITHABORT OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Accounting_Adhoc] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Accounting_Adhoc] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Accounting_Adhoc] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Accounting_Adhoc] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Accounting_Adhoc] SET  MULTI_USER 
GO
ALTER DATABASE [Accounting_Adhoc] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Accounting_Adhoc] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Accounting_Adhoc] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Accounting_Adhoc] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Accounting_Adhoc] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Accounting_Adhoc', N'ON'
GO
ALTER DATABASE [Accounting_Adhoc] SET QUERY_STORE = OFF
GO
USE [Accounting_Adhoc]
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
USE [Accounting_Adhoc]
GO
/****** Object:  User [US\ULTCLPBIDEV]    Script Date: 6/17/2021 11:09:31 AM ******/
CREATE USER [US\ULTCLPBIDEV] FOR LOGIN [US\ULTCLPBIDev]
GO
/****** Object:  User [US\ULATRSFinancialFAcct]    Script Date: 6/17/2021 11:09:31 AM ******/
CREATE USER [US\ULATRSFinancialFAcct] FOR LOGIN [US\ULATRSFinancialFAcct]
GO
/****** Object:  User [US\ulaespbiadmindev]    Script Date: 6/17/2021 11:09:31 AM ******/
CREATE USER [US\ulaespbiadmindev] FOR LOGIN [US\ulaespbiadmindev]
GO
/****** Object:  User [US\sptwpctrlm0prd]    Script Date: 6/17/2021 11:09:31 AM ******/
CREATE USER [US\sptwpctrlm0prd] FOR LOGIN [US\sptwpctrlm0prd] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [US\sptbittproxy]    Script Date: 6/17/2021 11:09:31 AM ******/
CREATE USER [US\sptbittproxy] FOR LOGIN [US\sptbittproxy] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [US\evarga]    Script Date: 6/17/2021 11:09:31 AM ******/
CREATE USER [US\evarga] FOR LOGIN [US\evarga] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [role_CONVERTEDCASEEM]    Script Date: 6/17/2021 11:09:32 AM ******/
CREATE ROLE [role_CONVERTEDCASEEM]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\ULTCLPBIDEV]
GO
ALTER ROLE [role_CONVERTEDCASEEM] ADD MEMBER [US\ULATRSFinancialFAcct]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\ulaespbiadmindev]
GO
ALTER ROLE [db_owner] ADD MEMBER [US\sptwpctrlm0prd]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [US\sptwpctrlm0prd]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [US\sptwpctrlm0prd]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [US\sptwpctrlm0prd]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\sptwpctrlm0prd]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [US\sptwpctrlm0prd]
GO
ALTER ROLE [db_owner] ADD MEMBER [US\sptbittproxy]
GO
ALTER ROLE [db_datareader] ADD MEMBER [US\evarga]
GO
/****** Object:  PartitionFunction [DailyFOFSAFDateRange]    Script Date: 6/17/2021 11:09:32 AM ******/
CREATE PARTITION FUNCTION [DailyFOFSAFDateRange](int) AS RANGE RIGHT FOR VALUES (20160101, 20170101, 20180101, 20190101, 20200101, 20210101, 20220101, 20230101, 20240101, 20250101, 20260101, 20270101, 20280101, 20290101, 20300101)
GO
/****** Object:  PartitionFunction [DailyMEBSDateRange]    Script Date: 6/17/2021 11:09:32 AM ******/
CREATE PARTITION FUNCTION [DailyMEBSDateRange](int) AS RANGE RIGHT FOR VALUES (20160101, 20170101, 20180101, 20190101, 20200101, 20210101, 20220101, 20230101, 20240101, 20250101, 20260101, 20270101, 20280101, 20290101, 20300101)
GO
/****** Object:  PartitionScheme [DailyFOFSAFDateRangeScheme]    Script Date: 6/17/2021 11:09:32 AM ******/
CREATE PARTITION SCHEME [DailyFOFSAFDateRangeScheme] AS PARTITION [DailyFOFSAFDateRange] TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY])
GO
/****** Object:  PartitionScheme [DailyMEBSDateRangeScheme]    Script Date: 6/17/2021 11:09:32 AM ******/
CREATE PARTITION SCHEME [DailyMEBSDateRangeScheme] AS PARTITION [DailyMEBSDateRange] TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY])
GO
/****** Object:  Table [dbo].[BusinessBalances_Aggregated]    Script Date: 6/17/2021 11:09:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusinessBalances_Aggregated](
	[Pkg_Id] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Descr_Cd] [char](4) NOT NULL,
	[Reins_Cd] [char](1) NOT NULL,
	[Fund_Cat_Cd] [char](2) NOT NULL,
	[UNITS] [numeric](38, 6) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConvertedCaseCompareForEM]    Script Date: 6/17/2021 11:09:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConvertedCaseCompareForEM](
	[Source] [char](3) NOT NULL,
	[Fund_Desc] [varchar](20) NULL,
	[Num_Units] [float] NULL,
	[Case_No] [varchar](20) NULL,
	[Pegasys_Contract_Id] [varchar](9) NULL,
	[Pegasys_Locator_Id] [varchar](10) NULL,
	[Pegasys_Sub_Id] [varchar](3) NULL,
	[Fund_Id] [int] NULL,
	[Pkg_Id] [char](4) NOT NULL,
	[Reins_Cd] [char](1) NULL,
	[Effective_Date] [date] NOT NULL,
	[Dollar_Amount] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConvertedCaseCompareForEM_ForceError]    Script Date: 6/17/2021 11:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConvertedCaseCompareForEM_ForceError](
	[Source] [char](3) NOT NULL,
	[Fund_Desc] [varchar](20) NULL,
	[Num_Units] [float] NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Pegasys_Contract_Id] [varchar](9) NULL,
	[Pegasys_Locator_Id] [varchar](10) NULL,
	[Pegasys_Sub_Id] [varchar](3) NULL,
	[Fund_Id] [int] NULL,
	[Pkg_Id] [char](4) NOT NULL,
	[Reins_Cd] [char](1) NULL,
	[Effective_Date] [date] NOT NULL,
	[Dollar_Amount] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConvertedCaseCompareForEM_History]    Script Date: 6/17/2021 11:09:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConvertedCaseCompareForEM_History](
	[History_Id] [int] IDENTITY(1,1) NOT NULL,
	[Effective_Date] [date] NOT NULL,
	[Pegasys_Record_Count] [int] NOT NULL,
	[Paris_Record_Count] [int] NOT NULL,
	[Total_Record_Count] [int] NOT NULL,
	[Run_Date_Time] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyFOF_CapstockResults]    Script Date: 6/17/2021 11:09:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyFOF_CapstockResults](
	[Valuation_Dt] [date] NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyFOF_DollarDiscrepancies]    Script Date: 6/17/2021 11:09:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyFOF_DollarDiscrepancies](
	[Valuation_Dt] [date] NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Capstock_Sum_Dollars] [decimal](15, 2) NULL,
	[Portfolio_Sum_Dollars] [decimal](15, 2) NULL,
	[Dollars_Difference] [decimal](15, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyFOF_PortfolioResults]    Script Date: 6/17/2021 11:09:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyFOF_PortfolioResults](
	[Valuation_Dt] [date] NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyFOFCompare]    Script Date: 6/17/2021 11:09:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyFOFCompare](
	[DailyFOFCompare_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Source] [varchar](10) NOT NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL,
	[Partition_DT] [int] NOT NULL
) ON [DailyFOFSAFDateRangeScheme]([Partition_DT])

GO
/****** Object:  Table [dbo].[DailyFOFCompare_2017]    Script Date: 6/17/2021 11:09:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyFOFCompare_2017](
	[DailyFOFCompare_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Source] [varchar](10) NOT NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL,
	[Partition_DT] [int] NOT NULL
) ON [DailyFOFSAFDateRangeScheme]([Partition_DT])

GO
/****** Object:  Table [dbo].[DailyFOFCompare_2018]    Script Date: 6/17/2021 11:09:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyFOFCompare_2018](
	[DailyFOFCompare_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Source] [varchar](10) NOT NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL,
	[Partition_DT] [int] NOT NULL
) ON [DailyFOFSAFDateRangeScheme]([Partition_DT])

GO
/****** Object:  Table [dbo].[DailyFOFCompare_History]    Script Date: 6/17/2021 11:10:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyFOFCompare_History](
	[History_Id] [int] IDENTITY(1,1) NOT NULL,
	[Effective_Date] [date] NOT NULL,
	[Capstock_Record_Count] [int] NOT NULL,
	[Portfolio_Record_Count] [int] NOT NULL,
	[Total_Record_Count] [int] NOT NULL,
	[Run_Date_Time] [datetime] NOT NULL,
 CONSTRAINT [DailyFOFCompare_History_PK] PRIMARY KEY CLUSTERED 
(
	[History_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare]    Script Date: 6/17/2021 11:10:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare](
	[DailyMEBSShare_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Pkg_Id] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Desc_Cd] [char](10) NOT NULL,
	[Reins_Cd] [char](1) NULL,
	[Fd_Cat_Cd] [char](2) NOT NULL,
	[Accounting_Sum_Units] [decimal](15, 3) NULL,
	[Business_Sum_Units] [decimal](15, 3) NULL,
	[Units_Difference] [decimal](15, 3) NULL,
	[Unit_Value] [decimal](13, 4) NULL,
	[Market_Value] [decimal](25, 2) NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Partition_Dt] [int] NOT NULL
) ON [DailyMEBSDateRangeScheme]([Partition_Dt])

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_2017]    Script Date: 6/17/2021 11:10:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_2017](
	[DailyMEBSShare_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Pkg_Id] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Desc_Cd] [char](10) NOT NULL,
	[Reins_Cd] [char](1) NULL,
	[Fd_Cat_Cd] [char](2) NOT NULL,
	[Accounting_Sum_Units] [decimal](15, 3) NULL,
	[Business_Sum_Units] [decimal](15, 3) NULL,
	[Units_Difference] [decimal](15, 3) NULL,
	[Unit_Value] [decimal](13, 4) NULL,
	[Market_Value] [decimal](25, 2) NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Partition_Dt] [int] NOT NULL
) ON [DailyMEBSDateRangeScheme]([Partition_Dt])

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_BusinessBalances]    Script Date: 6/17/2021 11:10:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_BusinessBalances](
	[Source] [varchar](20) NOT NULL,
	[Pkg_Id] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Descr_Cd] [char](4) NOT NULL,
	[Reins_Cd] [char](1) NOT NULL,
	[Unit_Ct] [numeric](15, 6) NOT NULL,
	[Fund_Cat_Cd] [char](2) NOT NULL,
	[Eff_D] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_CaseHoldings]    Script Date: 6/17/2021 11:10:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_CaseHoldings](
	[Source] [varchar](20) NOT NULL,
	[Pkg_Id] [char](4) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Desc_Cd] [char](10) NOT NULL,
	[Reins_Cd] [char](1) NULL,
	[Units] [numeric](15, 6) NULL,
	[Fd_Cat_Cd] [char](2) NULL,
	[Valuation_Dt] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_CleansedCaseHoldings]    Script Date: 6/17/2021 11:10:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_CleansedCaseHoldings](
	[Source] [varchar](20) NOT NULL,
	[Pkg_Id] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Desc_Cd] [char](10) NOT NULL,
	[Reins_Cd] [char](1) NULL,
	[Units] [numeric](15, 6) NULL,
	[Fd_Cat_Cd] [char](2) NULL,
	[Valuation_Dt] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_History]    Script Date: 6/17/2021 11:10:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_History](
	[History_Id] [int] IDENTITY(1,1) NOT NULL,
	[Effective_Date] [date] NOT NULL,
	[Accounting_Record_Count] [int] NOT NULL,
	[Business_Record_Count] [int] NOT NULL,
	[Total_Record_Count] [int] NOT NULL,
	[Run_Date_Time] [datetime] NOT NULL,
 CONSTRAINT [DailyMEBSEquityShareCompare_History_PK] PRIMARY KEY CLUSTERED 
(
	[History_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_History_old]    Script Date: 6/17/2021 11:10:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_History_old](
	[History_Id] [int] NOT NULL,
	[Effective_Date] [date] NOT NULL,
	[Accounting_Record_Count] [int] NOT NULL,
	[Business_Record_Count] [int] NOT NULL,
	[Total_Record_Count] [int] NOT NULL,
	[Run_Date_Time] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_NonParisCases]    Script Date: 6/17/2021 11:10:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_NonParisCases](
	[Adj_Cat_Case_No] [varchar](20) NOT NULL,
	[Pkg_Id] [char](4) NOT NULL,
	[Adj_Cat_Case_Txt] [varchar](30) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_UnitDiscrepancies]    Script Date: 6/17/2021 11:10:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_UnitDiscrepancies](
	[Pkg_Id] [char](5) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Cd] [char](10) NULL,
	[Reins_Cd] [char](1) NULL,
	[Fd_Cat_Cd] [char](2) NULL,
	[Accounting_Sum_Units] [decimal](15, 3) NULL,
	[Business_Sum_Units] [decimal](15, 3) NULL,
	[Units_Difference] [decimal](15, 3) NULL,
	[Unit_Value] [decimal](13, 4) NULL,
	[Market_Value] [decimal](25, 2) NULL,
	[Valuation_Dt] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_UnitValuesByFund]    Script Date: 6/17/2021 11:10:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_UnitValuesByFund](
	[Fd_Descr_Cd] [char](10) NOT NULL,
	[Unit_Value] [numeric](13, 6) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSEquityShareCompare_unpartitioned]    Script Date: 6/17/2021 11:10:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_unpartitioned](
	[DailyMEBSShare_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Pkg_Id] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Desc_Cd] [char](10) NOT NULL,
	[Reins_Cd] [char](1) NULL,
	[Fd_Cat_Cd] [char](2) NOT NULL,
	[Accounting_Sum_Units] [decimal](15, 3) NULL,
	[Business_Sum_Units] [decimal](15, 3) NULL,
	[Units_Difference] [decimal](15, 3) NULL,
	[Unit_Value] [decimal](13, 4) NULL,
	[Market_Value] [decimal](25, 2) NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Partition_Dt] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSFixedCompare]    Script Date: 6/17/2021 11:10:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSFixedCompare](
	[DailyMEBSFixed_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Pkg_Id] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Desc_Cd] [char](10) NOT NULL,
	[Fd_Cat_Cd] [char](2) NULL,
	[Accounting_Sum_Dollars] [decimal](15, 2) NULL,
	[Business_Sum_Dollars] [decimal](15, 2) NULL,
	[Dollars_Difference] [decimal](15, 2) NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Partition_Dt] [int] NOT NULL
) ON [DailyMEBSDateRangeScheme]([Partition_Dt])

GO
/****** Object:  Table [dbo].[DailyMEBSFixedCompare_2017]    Script Date: 6/17/2021 11:10:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSFixedCompare_2017](
	[DailyMEBSFixed_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Pkg_Id] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Desc_Cd] [char](10) NOT NULL,
	[Fd_Cat_Cd] [char](2) NULL,
	[Accounting_Sum_Dollars] [decimal](15, 2) NULL,
	[Business_Sum_Dollars] [decimal](15, 2) NULL,
	[Dollars_Difference] [decimal](15, 2) NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Partition_Dt] [int] NOT NULL
) ON [DailyMEBSDateRangeScheme]([Partition_Dt])

GO
/****** Object:  Table [dbo].[DailyMEBSFixedCompare_2018]    Script Date: 6/17/2021 11:10:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSFixedCompare_2018](
	[DailyMEBSFixed_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Pkg_Id] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Desc_Cd] [char](10) NOT NULL,
	[Fd_Cat_Cd] [char](2) NULL,
	[Accounting_Sum_Dollars] [decimal](15, 2) NULL,
	[Business_Sum_Dollars] [decimal](15, 2) NULL,
	[Dollars_Difference] [decimal](15, 2) NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Partition_Dt] [int] NOT NULL
) ON [DailyMEBSDateRangeScheme]([Partition_Dt])

GO
/****** Object:  Table [dbo].[DailyMEBSFixedCompare_BusinessBalances]    Script Date: 6/17/2021 11:10:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSFixedCompare_BusinessBalances](
	[Source] [varchar](20) NOT NULL,
	[Business_Line] [char](5) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Trfr_Agt_Cd] [char](2) NOT NULL,
	[Fd_Descr_Cd] [char](5) NOT NULL,
	[Fixed_Bus_Amt] [numeric](18, 2) NOT NULL,
	[Eff_D] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSFixedCompare_CaseHoldings]    Script Date: 6/17/2021 11:10:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSFixedCompare_CaseHoldings](
	[Source] [varchar](20) NOT NULL,
	[Pkg_Id] [char](4) NOT NULL,
	[Case_No] [varchar](20) NOT NULL,
	[Fd_Cat_Cd] [char](2) NULL,
	[Fd_Desc_Cd] [char](10) NOT NULL,
	[Tr_Amt] [numeric](13, 2) NULL,
	[Valuation_Dt] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSFixedCompare_DollarDiscrepancies]    Script Date: 6/17/2021 11:10:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSFixedCompare_DollarDiscrepancies](
	[Pkg_Id] [char](5) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Cd] [char](10) NULL,
	[Fd_Cat_Cd] [char](2) NULL,
	[Accounting_Sum_Dollars] [decimal](15, 2) NULL,
	[Business_Sum_Dollars] [decimal](15, 2) NULL,
	[Dollars_Difference] [decimal](15, 2) NULL,
	[Valuation_Dt] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailyMEBSFixedCompare_History]    Script Date: 6/17/2021 11:10:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailyMEBSFixedCompare_History](
	[History_Id] [int] IDENTITY(1,1) NOT NULL,
	[Effective_Date] [date] NOT NULL,
	[Accounting_Record_Count] [int] NOT NULL,
	[Business_Record_Count] [int] NOT NULL,
	[Total_Record_Count] [int] NOT NULL,
	[Run_Date_Time] [datetime] NOT NULL,
 CONSTRAINT [DailyMEBSFixedCompare_History_PK] PRIMARY KEY CLUSTERED 
(
	[History_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailySAF_CapstockResults]    Script Date: 6/17/2021 11:10:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailySAF_CapstockResults](
	[Valuation_Dt] [date] NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailySAF_DollarDiscrepancies]    Script Date: 6/17/2021 11:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailySAF_DollarDiscrepancies](
	[Valuation_Dt] [date] NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Capstock_Sum_Dollars] [decimal](15, 2) NULL,
	[Portfolio_Sum_Dollars] [decimal](15, 2) NULL,
	[Dollars_Difference] [decimal](15, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailySAF_PortfolioResults]    Script Date: 6/17/2021 11:10:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailySAF_PortfolioResults](
	[Valuation_Dt] [date] NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DailySAFCompare]    Script Date: 6/17/2021 11:10:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailySAFCompare](
	[DailySAFCompare_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Source] [varchar](10) NOT NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL,
	[Partition_DT] [int] NOT NULL
) ON [DailyFOFSAFDateRangeScheme]([Partition_DT])

GO
/****** Object:  Table [dbo].[DailySAFCompare_2017]    Script Date: 6/17/2021 11:10:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailySAFCompare_2017](
	[DailySAFCompare_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Source] [varchar](10) NOT NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL,
	[Partition_DT] [int] NOT NULL
) ON [DailyFOFSAFDateRangeScheme]([Partition_DT])

GO
/****** Object:  Table [dbo].[DailySAFCompare_2018]    Script Date: 6/17/2021 11:11:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailySAFCompare_2018](
	[DailySAFCompare_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Source] [varchar](10) NOT NULL,
	[Valuation_Dt] [date] NOT NULL,
	[Tr_Ref_No] [varchar](14) NULL,
	[Case_No] [varchar](20) NULL,
	[Fd_Desc_Expnd_Cd] [varchar](10) NULL,
	[Fd_Cat_Cd] [varchar](2) NULL,
	[Trfr_Fd_Expnd_Cd] [varchar](10) NULL,
	[Trfr_Fd_Cat_Cd] [varchar](2) NULL,
	[Map_Key_Cd] [varchar](4) NULL,
	[Reversal_Cd] [varchar](1) NULL,
	[Tr_No] [varchar](4) NULL,
	[Reins_Cd] [varchar](1) NULL,
	[Client_Eff_Dt] [date] NULL,
	[System_Orig_Cd] [varchar](4) NULL,
	[User_Id] [varchar](10) NULL,
	[Dr_Cr_Cd] [varchar](2) NULL,
	[Tr_Amt] [decimal](13, 2) NULL,
	[Units_Ct] [decimal](15, 6) NULL,
	[Partition_DT] [int] NOT NULL
) ON [DailyFOFSAFDateRangeScheme]([Partition_DT])

GO
/****** Object:  Table [dbo].[DailySAFCompare_History]    Script Date: 6/17/2021 11:11:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailySAFCompare_History](
	[History_Id] [int] IDENTITY(1,1) NOT NULL,
	[Effective_Date] [date] NOT NULL,
	[Capstock_Record_Count] [int] NOT NULL,
	[Portfolio_Record_Count] [int] NOT NULL,
	[Total_Record_Count] [int] NOT NULL,
	[Run_Date_Time] [datetime] NOT NULL,
 CONSTRAINT [DailySAFCompare_History_PK] PRIMARY KEY CLUSTERED 
(
	[History_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSEquityShareCompare_Pkg_Id_ALIGNED]    Script Date: 6/17/2021 11:11:08 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DailyMEBSEquityShareCompare_Pkg_Id_ALIGNED] ON [dbo].[DailyMEBSEquityShareCompare]
(
	[Pkg_Id] ASC,
	[Case_No] ASC,
	[Fd_Desc_Cd] ASC,
	[Reins_Cd] ASC,
	[Fd_Cat_Cd] ASC,
	[Partition_Dt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSEquityShareCompare_Valuation_Dt_ALIGNED]    Script Date: 6/17/2021 11:11:08 AM ******/
CREATE NONCLUSTERED INDEX [IX_DailyMEBSEquityShareCompare_Valuation_Dt_ALIGNED] ON [dbo].[DailyMEBSEquityShareCompare]
(
	[Valuation_Dt] ASC
)
INCLUDE ( 	[DailyMEBSShare_Id],
	[Pkg_Id],
	[Case_No],
	[Fd_Desc_Cd],
	[Reins_Cd],
	[Fd_Cat_Cd],
	[Accounting_Sum_Units],
	[Business_Sum_Units],
	[Units_Difference],
	[Unit_Value],
	[Market_Value],
	[Partition_Dt]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSEquityShareCompare_Pkg_Id_ALIGNED]    Script Date: 6/17/2021 11:11:09 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DailyMEBSEquityShareCompare_Pkg_Id_ALIGNED] ON [dbo].[DailyMEBSEquityShareCompare_2017]
(
	[Pkg_Id] ASC,
	[Case_No] ASC,
	[Fd_Desc_Cd] ASC,
	[Reins_Cd] ASC,
	[Fd_Cat_Cd] ASC,
	[Partition_Dt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSEquityShareCompare_Valuation_Dt_ALIGNED]    Script Date: 6/17/2021 11:11:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_DailyMEBSEquityShareCompare_Valuation_Dt_ALIGNED] ON [dbo].[DailyMEBSEquityShareCompare_2017]
(
	[Valuation_Dt] ASC
)
INCLUDE ( 	[DailyMEBSShare_Id],
	[Pkg_Id],
	[Case_No],
	[Fd_Desc_Cd],
	[Reins_Cd],
	[Fd_Cat_Cd],
	[Accounting_Sum_Units],
	[Business_Sum_Units],
	[Units_Difference],
	[Unit_Value],
	[Market_Value],
	[Partition_Dt]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSEquityShareCompare_Pkg_Id_ALIGNED]    Script Date: 6/17/2021 11:11:09 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DailyMEBSEquityShareCompare_Pkg_Id_ALIGNED] ON [dbo].[DailyMEBSEquityShareCompare_unpartitioned]
(
	[Pkg_Id] ASC,
	[Case_No] ASC,
	[Fd_Desc_Cd] ASC,
	[Reins_Cd] ASC,
	[Fd_Cat_Cd] ASC,
	[Partition_Dt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSEquityShareCompare_Valuation_Dt_ALIGNED]    Script Date: 6/17/2021 11:11:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_DailyMEBSEquityShareCompare_Valuation_Dt_ALIGNED] ON [dbo].[DailyMEBSEquityShareCompare_unpartitioned]
(
	[Valuation_Dt] ASC
)
INCLUDE ( 	[DailyMEBSShare_Id],
	[Pkg_Id],
	[Case_No],
	[Fd_Desc_Cd],
	[Reins_Cd],
	[Fd_Cat_Cd],
	[Accounting_Sum_Units],
	[Business_Sum_Units],
	[Units_Difference],
	[Unit_Value],
	[Market_Value],
	[Partition_Dt]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSFixedCompare_Pkg_Id_ALIGNED]    Script Date: 6/17/2021 11:11:09 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DailyMEBSFixedCompare_Pkg_Id_ALIGNED] ON [dbo].[DailyMEBSFixedCompare]
(
	[Pkg_Id] ASC,
	[Case_No] ASC,
	[Fd_Desc_Cd] ASC,
	[Fd_Cat_Cd] ASC,
	[Partition_Dt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSFixedCompare_Valuation_Dt_ALIGNED]    Script Date: 6/17/2021 11:11:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_DailyMEBSFixedCompare_Valuation_Dt_ALIGNED] ON [dbo].[DailyMEBSFixedCompare]
(
	[Valuation_Dt] ASC
)
INCLUDE ( 	[DailyMEBSFixed_Id],
	[Pkg_Id],
	[Case_No],
	[Fd_Desc_Cd],
	[Fd_Cat_Cd],
	[Accounting_Sum_Dollars],
	[Business_Sum_Dollars],
	[Dollars_Difference],
	[Partition_Dt]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSFixedCompare_Pkg_Id_ALIGNED]    Script Date: 6/17/2021 11:11:09 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DailyMEBSFixedCompare_Pkg_Id_ALIGNED] ON [dbo].[DailyMEBSFixedCompare_2017]
(
	[Pkg_Id] ASC,
	[Case_No] ASC,
	[Fd_Desc_Cd] ASC,
	[Fd_Cat_Cd] ASC,
	[Partition_Dt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSFixedCompare_Valuation_Dt_ALIGNED]    Script Date: 6/17/2021 11:11:09 AM ******/
CREATE NONCLUSTERED INDEX [IX_DailyMEBSFixedCompare_Valuation_Dt_ALIGNED] ON [dbo].[DailyMEBSFixedCompare_2017]
(
	[Valuation_Dt] ASC
)
INCLUDE ( 	[DailyMEBSFixed_Id],
	[Pkg_Id],
	[Case_No],
	[Fd_Desc_Cd],
	[Fd_Cat_Cd],
	[Accounting_Sum_Dollars],
	[Business_Sum_Dollars],
	[Dollars_Difference],
	[Partition_Dt]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSFixedCompare_Pkg_Id_ALIGNED]    Script Date: 6/17/2021 11:11:09 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DailyMEBSFixedCompare_Pkg_Id_ALIGNED] ON [dbo].[DailyMEBSFixedCompare_2018]
(
	[Pkg_Id] ASC,
	[Case_No] ASC,
	[Fd_Desc_Cd] ASC,
	[Fd_Cat_Cd] ASC,
	[Partition_Dt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DailyMEBSFixedCompare_Valuation_Dt_ALIGNED]    Script Date: 6/17/2021 11:11:10 AM ******/
CREATE NONCLUSTERED INDEX [IX_DailyMEBSFixedCompare_Valuation_Dt_ALIGNED] ON [dbo].[DailyMEBSFixedCompare_2018]
(
	[Valuation_Dt] ASC
)
INCLUDE ( 	[DailyMEBSFixed_Id],
	[Pkg_Id],
	[Case_No],
	[Fd_Desc_Cd],
	[Fd_Cat_Cd],
	[Accounting_Sum_Dollars],
	[Business_Sum_Dollars],
	[Dollars_Difference],
	[Partition_Dt]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DailyMEBSDateRangeScheme]([Partition_Dt])
GO
/****** Object:  StoredProcedure [dbo].[usp_DailyConvertedCaseCompare_GetUnitDiscrepanciesByCase]    Script Date: 6/17/2021 11:11:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--CREATE OR 
CREATE PROCEDURE [dbo].[usp_DailyConvertedCaseCompare_GetUnitDiscrepanciesByCase] AS
-----------------------------------------------------------------------------------------------------------------------------------------
-- Update Date     Description of change
-----------------------------------------------------------------------------------------------------------------------------------------
-- 07/02/2019      DDEV-134032 - Modify Converted Case Compare to satisfy audit requirements
--                 There are some queries in an excel spreadsheet which the auditors are taking issue with. All code must
--                 be under change control and unalterable by users to satisfy SOX requirements.
-- 07/08/2019      In QA Test I noticed the zero values are included so removed filter on WHERE clause.
-- 09/12/2019      DDEV-138734 - Only show Units_Difference +/- 1 share
-- 07/30/2020      TTDSR-671: Accounting_Adhoc : Modify Converted Case Compare to add additional filtering logic to pick up Home Office 
--                 and Oriental Pension contracts. The modification for this change is within the paackage but an additional problem was 
--                 noticed while testing that Pegasys Locator Id is only two characters where Paris Affiliate is 5 so had to add some 
--                 logic to force the Pegasys_Locator_Id to be 5 zeroes to match Paris. 
-----------------------------------------------------------------------------------------------------------------------------------------
BEGIN
    SET NOCOUNT ON;
    
    SELECT Effective_Date,
	       Pegasys_Contract_Id, 
           Pegasys_Locator_Id, 
           Fund_Desc,
    	   ROUND(ISNULL([DAS],0),4) AS DAS_Sum_Units, 
    	   ROUND(ISNULL([PEG],0),4) AS PEG_Sum_Units, 
    	   ISNULL([DAS],0)+ISNULL([PEG],0) AS Units_Difference
    FROM 
    (SELECT Source, 
	        Effective_Date, 
			Pegasys_Contract_Id, 
            CASE WHEN Pegasys_Locator_Id = '00' 
		         THEN '00000'
		         ELSE Pegasys_Locator_Id
		    END AS Pegasys_Locator_Id,
			Fund_Desc, 
			Num_Units
    FROM dbo.ConvertedCaseCompareForEM
    WHERE Fund_Desc NOT LIKE 'Q1QL%'
    AND Fund_Desc NOT LIKE 'Q1QM%'
    --AND Fund_Desc NOT LIKE 'N%' -- Accounting Team asked we include these
    --AND Fund_Desc NOT LIKE '2%' -- Accounting Team asked we include BAML funds starting with 2
    --AND Fund_Desc NOT LIKE 'S%'-- Accounting Team asked we include these
    --AND Fund_Desc NOT LIKE 'Y%'-- Accounting Team asked we include these
    --AND Fund_Desc NOT LIKE 'Z%'-- Accounting Team asked we include these
    ) AS SOURCE_TABLE
    PIVOT 
    (SUM(Num_Units) 
     FOR SOURCE IN ([DAS], [PEG]))
     AS PivotTable
    --WHERE [DAS] <> 0
	WHERE ISNULL([DAS],0)+ISNULL([PEG],0) >= 1.00 OR  ISNULL([DAS],0)+ISNULL([PEG],0) <= -1.00 -- DDEV-138734
    ORDER BY Pegasys_Contract_Id, 
             Pegasys_Locator_Id,  
             Fund_Desc
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DailyConvertedCaseCompare_GetUnitDiscrepanciesByFund]    Script Date: 6/17/2021 11:11:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DailyConvertedCaseCompare_GetUnitDiscrepanciesByFund] AS
-----------------------------------------------------------------------------------------------------------------------------------------
-- Update Date     Description of change
-----------------------------------------------------------------------------------------------------------------------------------------
-- 07/02/2019      DDEV-134032 - Modify Converted Case Compare to satisfy audit requirements
--                 There are some queries in an excel spreadsheet which the auditors are taking issue with. All code must
--                 be under change control and unalterable by users to satisfy SOX requirements.
-- 07/08/2019      In QA Test I noticed the zero values are included so removed filter on WHERE clause.
-- 09/12/2019      DDEV-138734 - Only show Units_Difference +/- 1 share
-----------------------------------------------------------------------------------------------------------------------------------------
BEGIN
    SET NOCOUNT ON;
    
    SELECT Effective_Date,
	       Fund_Desc, 
    	   ROUND(ISNULL([DAS],0),4) AS DAS_Sum_Units, 
    	   ROUND(ISNULL([PEG],0),4) AS PEG_Sum_Units, 
    	   ISNULL([DAS],0)+ISNULL([PEG],0) AS Units_Difference
    FROM 
    (SELECT Source, 
	        Effective_Date, 
			Fund_Desc, 
			Num_Units
    FROM dbo.ConvertedCaseCompareForEM
    WHERE Fund_Desc LIKE 'R%'
    OR Fund_Desc LIKE '2%' -- Accounting Team asked we include BAML funds starting with 2
    ) AS SOURCE_TABLE
    PIVOT 
    (SUM(Num_Units) 
     FOR SOURCE IN ([DAS], [PEG]))
     AS PivotTable
     --WHERE [DAS] <> 0
	 WHERE ISNULL([DAS],0)+ISNULL([PEG],0) >= 1.00 OR  ISNULL([DAS],0)+ISNULL([PEG],0) <= -1.00 -- DDEV-138734
     ORDER BY FUND_DESC
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DailyFOF_GetDollarDiscrepancies]    Script Date: 6/17/2021 11:11:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DailyFOF_GetDollarDiscrepancies] AS
BEGIN

    SET NOCOUNT ON

    SELECT 
	   Valuation_Dt,
       Tr_Ref_No,
	   Capstock_Sum_Dollars,
	   Portfolio_Sum_Dollars,
	   Dollars_Difference
     FROM [dbo].[DailyFOF_DollarDiscrepancies]
     ORDER BY Tr_Ref_No
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DailyFOFProcess]    Script Date: 6/17/2021 11:11:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DailyFOFProcess] AS
BEGIN
  BEGIN TRY
  BEGIN TRANSACTION DailyFOFProcess

  SET NOCOUNT ON

  -- Excel Power Pivot has the power to aggregate but Excel has
  -- limits on how much data can be loaded to a worksheet.
  -- This process was developed as an alternative to loading
  -- over a million records to Excel. We are persisting the data
  -- on a table. We will keep two years data on this table and
  -- we can swap out partitions as needed to improve I/O access.

  -- This table is simulating the Power Pivot needed to compare
  -- Capstock to Portfolio. 

  IF OBJECT_ID('tempdb..#CompleteListCapstockPortfolioTrRefNos') IS NOT NULL
  BEGIN
    DROP TABLE #CompleteListCapstockPortfolioTrRefNos
  END
  
  --select * from #CompleteListCapstockPortfolioTrRefNos
  SELECT DISTINCT COALESCE(A.TR_REF_NO, B.TR_REF_NO) AS TR_REF_NO,
  	              CAST(0 AS DECIMAL(15,2)) AS Capstock_Sum_Dollars,
  	              CAST(0 AS DECIMAL(15,2)) AS Portfolio_Sum_Dollars,
  	              CAST(0 AS DECIMAL(15,2)) AS Dollars_Difference,
	              COALESCE(A.Valuation_Dt, B.Valuation_Dt) AS Valuation_Dt
  INTO #CompleteListCapstockPortfolioTrRefNos
  FROM [dbo].[DailyFOF_CapstockResults] A 
  FULL JOIN [dbo].[DailyFOF_PortfolioResults] B
  ON A.TR_REF_NO = B.TR_REF_NO
  ORDER BY TR_REF_NO

  ---------------------------------------------
  -- Rounding requirements:
  ---------------------------------------------
  -- Dollar values rounded to two decimal points
  ----------------------------------------------

  -- Aggregate Capstock for subsequent update
  
  IF OBJECT_ID('tempdb..#Capstock_Aggregated') IS NOT NULL
  BEGIN
    DROP TABLE #Capstock_Aggregated
  END
  
  SELECT Tr_Ref_No,
  	     ROUND(SUM(Tr_Amt),2) AS Capstock_Sum_Dollars
  INTO #Capstock_Aggregated
  FROM [dbo].[DailyFOF_CapstockResults]
  GROUP BY Tr_Ref_No
  ORDER BY Tr_Ref_No

  -- Aggregate Portfolio for subsequent update
    
  IF OBJECT_ID('tempdb..#Portfolio_Aggregated') IS NOT NULL
  BEGIN
    DROP TABLE #Portfolio_Aggregated
  END
  
  SELECT Tr_Ref_No,
  	     ROUND(SUM(Tr_Amt),2) AS Portfolio_Sum_Dollars
  INTO #Portfolio_Aggregated
  FROM [dbo].[DailyFOF_PortfolioResults]
  GROUP BY Tr_Ref_No
  ORDER BY Tr_Ref_No
  
  UPDATE FJ
  SET Capstock_Sum_Dollars = B.Capstock_Sum_Dollars
  FROM #CompleteListCapstockPortfolioTrRefNos FJ JOIN #Capstock_Aggregated B
  ON FJ.Tr_Ref_No = B.Tr_Ref_No
  
  UPDATE FJ
  SET Portfolio_Sum_Dollars = B.Portfolio_Sum_Dollars
  FROM #CompleteListCapstockPortfolioTrRefNos FJ JOIN #Portfolio_Aggregated B
  ON FJ.Tr_Ref_No = B.Tr_Ref_No
   
  -- Find the difference in Dollars to report to Accounting
  UPDATE #CompleteListCapstockPortfolioTrRefNos
  SET Dollars_Difference = Capstock_Sum_Dollars - Portfolio_Sum_Dollars

  IF OBJECT_ID('[dbo].[DailyFOF_DollarDiscrepancies]') IS NOT NULL
  BEGIN
    DROP TABLE [dbo].[DailyFOF_DollarDiscrepancies]
  END

  SELECT Valuation_Dt,
         Tr_Ref_No,
         Capstock_Sum_Dollars,
		 Portfolio_Sum_Dollars,
         Dollars_Difference
  INTO [dbo].[DailyFOF_DollarDiscrepancies]
  FROM #CompleteListCapstockPortfolioTrRefNos
  WHERE Dollars_Difference <> 0
  ORDER BY Tr_Ref_No

  DECLARE @ValuationDt DATE,
          @PartitionDt INT

  SELECT TOP 1 @ValuationDt = Valuation_Dt FROM #CompleteListCapstockPortfolioTrRefNos
  SET @PartitionDt = CAST(CONVERT(VARCHAR,@ValuationDt,112) AS INT)
  --PRINT @ValuationDt
  --PRINT @PartitionDt

  -- If there are no discrepancies we should load a message to 
  -- the results so that the date on the file is
  -- updated and the end user knows that no discrepancies were found

  IF (SELECT COUNT(*) FROM [dbo].[DailyFOF_DollarDiscrepancies]) = 0 
  BEGIN 
     INSERT INTO [dbo].[DailyFOF_DollarDiscrepancies]
	 (
	  Valuation_Dt,
	  Tr_Ref_No,
	  Capstock_Sum_Dollars,
	  Portfolio_Sum_Dollars,
	  Dollars_Difference
	 )
	 SELECT @ValuationDt AS Valuation_Dt,
	        'No mismatches!' AS Tr_Ref_No,
	        0 AS Capstock_Sum_Dollars,
	        0 AS Portfolio_Sum_Dollars,
	        0 AS Dollars_Difference
  END

  DROP TABLE #Capstock_Aggregated
  DROP TABLE #Portfolio_Aggregated

  -- In the event this process is rerun for the same day clean up the old data
  -- that was posted to the history table. 

  DELETE FROM [dbo].[DailyFOFCompare]
  WHERE Valuation_Dt = @ValuationDt

  -- This table is partitioned by year to keep data for 2 years.
  -- At the end of 2 years the Accounting team requested that we 
  -- archive data older than 2 years by swapping out older partitions.

  INSERT INTO [dbo].[DailyFOFCompare]
  (
      Source
     ,Valuation_Dt
     ,Tr_Ref_No
     ,Case_No
     ,Fd_Desc_Expnd_Cd
     ,Fd_Cat_Cd
     ,Trfr_Fd_Expnd_Cd
     ,Trfr_Fd_Cat_Cd
     ,Map_Key_Cd
     ,Reversal_Cd
     ,Tr_No
     ,Reins_Cd
     ,Client_Eff_Dt
     ,System_Orig_Cd
     ,User_Id
     ,Dr_Cr_Cd
     ,Tr_Amt
     ,Units_Ct
     ,Partition_DT
  )
  SELECT       
      'CAPSTOCK' AS Source
     ,Valuation_Dt
     ,Tr_Ref_No
     ,Case_No
     ,Fd_Desc_Expnd_Cd
     ,Fd_Cat_Cd
     ,Trfr_Fd_Expnd_Cd
     ,Trfr_Fd_Cat_Cd
     ,Map_Key_Cd
     ,Reversal_Cd
     ,Tr_No
     ,Reins_Cd
     ,Client_Eff_Dt
     ,System_Orig_Cd
     ,User_Id
     ,Dr_Cr_Cd
     ,Tr_Amt
     ,Units_Ct
     ,@PartitionDt AS Partition_DT
  FROM [dbo].[DailyFOF_CapstockResults]

  UNION ALL 

  SELECT   
     'PORTFOLIO' AS Source
     ,Valuation_Dt
     ,Tr_Ref_No
     ,Case_No
     ,Fd_Desc_Expnd_Cd
     ,Fd_Cat_Cd
     ,Trfr_Fd_Expnd_Cd
     ,Trfr_Fd_Cat_Cd
     ,Map_Key_Cd
     ,Reversal_Cd
     ,Tr_No
     ,Reins_Cd
     ,Client_Eff_Dt
     ,System_Orig_Cd
     ,User_Id
     ,Dr_Cr_Cd
     ,Tr_Amt
     ,Units_Ct
     ,@PartitionDt AS Partition_DT
  FROM [dbo].[DailyFOF_PortfolioResults]

  DROP TABLE #CompleteListCapstockPortfolioTrRefNos

  COMMIT TRANSACTION DailyFOFProcess
  END TRY
BEGIN CATCH
  ROLLBACK;
  THROW;
END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[usp_DailyFOFProcess_UpdateRunHistory]    Script Date: 6/17/2021 11:11:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_DailyFOFProcess_UpdateRunHistory] AS
-----------------------------------------------------------------------------------------------------------------------------------------
-- Update Date     Description of change
-----------------------------------------------------------------------------------------------------------------------------------------
-- 12/06/2018      DDEV-96388: FOF/SAF Capstock to portfolio failed on 12/6/2018 after market close 12/5/2018
--                 Set EffectiveDate to today - 1 day when no data is returned for dbo.DailyFOF_CapstockResults
-----------------------------------------------------------------------------------------------------------------------------------------
BEGIN

    SET NOCOUNT ON;
    
    DECLARE @CapstockRecordCount INT;
    SELECT @CapstockRecordCount = COUNT(*) FROM dbo.DailyFOF_CapstockResults
    
    DECLARE @PortfolioRecordCount INT;
    SELECT @PortfolioRecordCount = COUNT(*) FROM dbo.DailyFOF_PortfolioResults
    
    DECLARE @TotalRecordCount INT;
    SELECT @TotalRecordCount = @CapstockRecordCount + @PortfolioRecordCount;
    
    DECLARE @EffectiveDate DATE;
    SET @EffectiveDate = (SELECT DISTINCT Valuation_Dt FROM dbo.DailyFOF_CapstockResults);
    
	--PRINT @CapstockRecordCount
	--PRINT @PortfolioRecordCount
	--PRINT @TotalRecordCount
	--PRINT @EffectiveDate

    INSERT INTO [dbo].[DailyFOFCompare_History]
    (
      Effective_Date,
      Capstock_Record_Count,
      Portfolio_Record_Count,
      Total_Record_Count,
      Run_Date_Time
    )
    SELECT CASE WHEN @EffectiveDate IS NOT NULL THEN @EffectiveDate ELSE GETDATE() - 1  END AS Effective_Date,
           @CapstockRecordCount AS Capstock_Record_Count,
    	   @PortfolioRecordCount AS Portfolio_Record_Count,
    	   @TotalRecordCount AS Total_Record_Count,
    	   GETDATE() AS Run_Date_Time;
END


GO
/****** Object:  StoredProcedure [dbo].[usp_DailyFOFTableCreation]    Script Date: 6/17/2021 11:11:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DailyFOFTableCreation] AS
BEGIN

   IF OBJECT_ID('dbo.DailyFOF_CapstockResults') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailyFOF_CapstockResults
   END 
   
   CREATE TABLE dbo.DailyFOF_CapstockResults
   (
          Valuation_Dt DATE NULL,
          Tr_Ref_No VARCHAR(14) NULL,
   	      Case_No VARCHAR(20) NULL,
   	      Fd_Desc_Expnd_Cd VARCHAR(10) NULL,
   	      Fd_Cat_Cd VARCHAR(2) NULL,
   	      Trfr_Fd_Expnd_Cd VARCHAR(10) NULL,
   	      Trfr_Fd_Cat_Cd VARCHAR(2) NULL,
   	      Map_Key_Cd VARCHAR(4) NULL,
   	      Reversal_Cd VARCHAR(1) NULL,
   	      Tr_No VARCHAR(4) NULL,
   	      Reins_Cd VARCHAR(1) NULL,
   	      Client_Eff_Dt DATE NULL,
   	      System_Orig_Cd VARCHAR(4) NULL,
   	      [User_Id] VARCHAR(10) NULL,
   	      Dr_Cr_Cd VARCHAR(2) NULL,
   	      Tr_Amt DECIMAL(13,2) NULL,
   	      Units_Ct DECIMAL(15,6) NULL
   )

   IF OBJECT_ID('dbo.DailyFOF_PortfolioResults') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailyFOF_PortfolioResults
   END 
   
   CREATE TABLE dbo.DailyFOF_PortfolioResults
   (
          Valuation_Dt DATE NULL,
          Tr_Ref_No VARCHAR(14) NULL,
   	      Case_No VARCHAR(20) NULL,
   	      Fd_Desc_Expnd_Cd VARCHAR(10) NULL,
   	      Fd_Cat_Cd VARCHAR(2) NULL,
   	      Trfr_Fd_Expnd_Cd VARCHAR(10) NULL,
   	      Trfr_Fd_Cat_Cd VARCHAR(2) NULL,
   	      Map_Key_Cd VARCHAR(4) NULL,
   	      Reversal_Cd VARCHAR(1) NULL,
   	      Tr_No VARCHAR(4) NULL,
   	      Reins_Cd VARCHAR(1) NULL,
   	      Client_Eff_Dt DATE NULL,
   	      System_Orig_Cd VARCHAR(4) NULL,
   	      [User_Id] VARCHAR(10) NULL,
   	      Dr_Cr_Cd VARCHAR(2) NULL,
   	      Tr_Amt DECIMAL(13,2) NULL,
   	      Units_Ct DECIMAL(15,6) NULL
   )
   
END




GO
/****** Object:  StoredProcedure [dbo].[usp_DailyMEBSEquity_CleansedCaseHoldings]    Script Date: 6/17/2021 11:11:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Author: Brenda Olson
-- Creation Date: 02/06/2017
-- Procedure Name: dbo.usp_DailyMEBSEquity_CleansedCaseHoldings
-- Description: This removes Non Paris Cases from Case Holdings to yield
--              a new results set called Cleansed Case Holdings.
-- 
--------------------------------------------------------------------------
--                   Change Activity
--------------------------------------------------------------------------
-- Last Updated     Description of what was changed
--------------------------------------------------------------------------
--
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--EXEC [dbo].[usp_DailyMEBSEquity_CleansedCaseHoldings]

CREATE PROCEDURE [dbo].[usp_DailyMEBSEquity_CleansedCaseHoldings] AS
BEGIN

    SET NOCOUNT ON

    SELECT Source,
            Pkg_Id,
            Case_No,
            Reins_Cd,
            Fd_Desc_Cd,	   
            Units,
            Fd_Cat_Cd,
            Valuation_Dt
    FROM [dbo].[DailyMEBSEquityShareCompare_CaseHoldings] CH
    WHERE NOT EXISTS (SELECT 1 FROM [dbo].[DailyMEBSEquityShareCompare_NonParisCases] NP
                      WHERE CH.Case_No = NP.Adj_Cat_Case_No)
    ORDER BY Source, Pkg_Id, Case_No, Reins_Cd, Fd_Desc_Cd

END
GO
/****** Object:  StoredProcedure [dbo].[usp_DailyMEBSEquity_GetDailyUnitDiscrepancies]    Script Date: 6/17/2021 11:11:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Author: Brenda Olson
-- Creation Date: 02/06/2017
-- Procedure Name: dbo.usp_DailyMEBSEquity_GetDailyUnitDiscrepancies
-- Description: This returns the contents of the table 
--              dbo.DailyMEBSEquityShareCompare_UnitDiscrepancies
-- 
--------------------------------------------------------------------------
--                   Change Activity
--------------------------------------------------------------------------
-- Last Updated     Description of what was changed
--------------------------------------------------------------------------
--
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- EXEC [dbo].[usp_DailyMEBSEquity_GetDailyUnitDiscrepancies]

CREATE PROCEDURE [dbo].[usp_DailyMEBSEquity_GetDailyUnitDiscrepancies] AS
BEGIN

    SET NOCOUNT ON

    SELECT 
	   Valuation_Dt,
	   Pkg_Id, 
       Case_No,
	   Fd_Desc_Cd,
	   Reins_Cd,
	   Fd_Cat_Cd,
	   Accounting_Sum_Units,
	   Business_Sum_Units,
	   Units_Difference,
	   Unit_Value,
	   Market_Value
     FROM [dbo].[DailyMEBSEquityShareCompare_UnitDiscrepancies]
     ORDER BY Pkg_Id, 
              Case_No,
     	      Fd_Desc_Cd

END
GO
/****** Object:  StoredProcedure [dbo].[usp_DailyMEBSEquityProcess]    Script Date: 6/17/2021 11:11:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Author: Brenda Olson
-- Creation Date: 02/06/2017
-- Procedure Name: dbo.usp_DailyMEBSEquityProcess
-- Description: This stored procedure generates results for two tables:
-- 1) dbo.DailyMEBSEquityShareCompare_UnitDiscrepancies - New content 
-- each run based on Valuation_Dt.
-- 2) dbo.DailyMEBSEquityShareCompare - Cumulative content containing 
-- 2 years history.  
-- 
--------------------------------------------------------------------------
--                   Change Activity
--------------------------------------------------------------------------
-- Last Updated     Description of what was changed
--------------------------------------------------------------------------
-- 03/24/2017       Handle the situation where there are no discrepancies.
-- 03/20/2018       On restart occasionally receive aligned index violation.
--                  Found valuation_dt and partition_dt were different
--                  in some cases which I believe is causing this issue.
--                  Added a one line code fix near bottom of this stored
--                  procedure that should prevent this from reoccuring.
--                  Also the maximum EFF_D on this table:
--                   [dbo].[DailyMEBSEquityShareCompare_BusinessBalances]
--                  should match the maximum Valuation_Dt on this table:
--                   [dbo].[DailyMEBSEquityShareCompare_CleansedCaseHoldings]
--                  and if not raise an exception. 
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- EXEC [dbo].[usp_DailyMEBSEquityProcess]

CREATE PROCEDURE [dbo].[usp_DailyMEBSEquityProcess] AS
BEGIN 
  BEGIN TRY
  BEGIN TRANSACTION MEBSEquityProcess

  SET NOCOUNT ON

 -- If these two dates are different then some ODSP processing
  -- on which this program relies did not complete. 
  -- Flag this as an exception and contact Operations.

  DECLARE @CleansedCaseHoldingsDt DATE,
          @BusinessBalancesDt DATE

  SELECT @CleansedCaseHoldingsDt = MAX(VALUATION_DT) FROM [dbo].[DailyMEBSEquityShareCompare_CleansedCaseHoldings]  
  -- 2018-03-19
  SELECT @BusinessBalancesDt = MAX(EFF_D) FROM [dbo].[DailyMEBSEquityShareCompare_BusinessBalances] 
  -- 2018-03-16

  --PRINT @CleansedCaseHoldingsDt
  --PRINT @BusinessBalancesDt

  IF @CleansedCaseHoldingsDt != @BusinessBalancesDt 
  BEGIN
    RAISERROR
    (N'Please confirm MEBS prerequisite jobs have completed as the Business and Case Holdings dates do not match',
    10, 
    1)
  END

  -- Excel Power Pivot has the power to aggregate but Excel has
  -- limits on how much data can be loaded to a worksheet.
  -- This process was developed as an alternative to loading
  -- over a million records to Excel. We are persisting the data
  -- on a table. We will keep two years data on this table and
  -- we can swap out partitions as needed to improve I/O access.

  -- This table is simulating the Power Pivot needed to compare
  -- business to accounting. 

  IF OBJECT_ID('tempdb..#CompleteListAcctBusCases') IS NOT NULL
  BEGIN
    DROP TABLE #CompleteListAcctBusCases
  END
  
  SELECT DISTINCT COALESCE(A.Pkg_Id, B.Pkg_Id) AS Pkg_Id,
         COALESCE (A.Case_No, B.Case_No) AS Case_No,
  	   COALESCE (A.Fd_Desc_Cd, B.Fd_Descr_Cd) AS Fd_Desc_Cd,
  	   COALESCE (A.Reins_Cd, B.Reins_Cd) AS Reins_Cd, 
         COALESCE (A.Fd_Cat_Cd, B.Fund_Cat_Cd) AS Fd_Cat_Cd,
  	   CAST(0 AS DECIMAL(15,3)) AS Accounting_Sum_Units,
  	   CAST(0 AS DECIMAL(15,3)) AS Business_Sum_Units,
  	   CAST(0 AS DECIMAL(15,3)) AS Units_Difference,
	   CAST(0 AS DECIMAL(13,4)) AS Unit_Value,
	   CAST(0 AS DECIMAL(25,2)) AS Market_Value,
	   COALESCE(A.Valuation_Dt,B.EFF_D) AS Valuation_Dt
  INTO #CompleteListAcctBusCases
  FROM [dbo].[DailyMEBSEquityShareCompare_CleansedCaseHoldings] A 
  FULL JOIN [dbo].[DailyMEBSEquityShareCompare_BusinessBalances] B
  ON A.Pkg_Id = B.Pkg_Id
  AND A.Case_No = B.Case_no
  AND A.Fd_Desc_Cd = B.Fd_Descr_Cd
  AND A.Reins_Cd = B.Reins_Cd
  AND A.Fd_Cat_Cd = B.Fund_Cat_Cd
  ORDER BY Pkg_Id, Case_No, Fd_Desc_Cd

  ---------------------------------------------
  -- Rounding requirements:
  ---------------------------------------------
  -- Units round to 3 decimal places
  -- Units Difference round to 3 decimal places
  -- Unit Value round to 4 decimal places
  -- Market Value round to 2 decimal places
  ----------------------------------------------

  -- Aggregate CaseHoldings for subsequent update
  
  IF OBJECT_ID('tempdb..#CaseHoldings_Aggregated') IS NOT NULL
  BEGIN
    DROP TABLE #CaseHoldings_Aggregated
  END
  
  SELECT Pkg_Id,
  	   Case_No,
  	   Fd_Desc_Cd,
  	   Reins_Cd,
  	   Fd_Cat_Cd,
  	   ROUND(SUM(Units),3) AS UNITS
  INTO #CaseHoldings_Aggregated
  FROM [dbo].[DailyMEBSEquityShareCompare_CleansedCaseHoldings]
  GROUP BY Pkg_Id,
           Case_No,
  		   Fd_Desc_Cd,
  		   Reins_Cd,
  		   Fd_Cat_Cd
  ORDER BY Pkg_Id,
           Case_No,
  		   Fd_Desc_Cd,
  		   Reins_Cd,
  		   Fd_Cat_Cd

  -- Aggregate BusinessBalances for subsequent update
    
  IF OBJECT_ID('tempdb..#BusinessBalances_Aggregated') IS NOT NULL
  BEGIN
    DROP TABLE #BusinessBalances_Aggregated
  END
  
  SELECT Pkg_Id,
  	   Case_No,
  	   Fd_Descr_Cd,
  	   Reins_Cd,
  	   Fund_Cat_Cd,
  	   ROUND(SUM(Unit_Ct),3) AS UNITS
  INTO #BusinessBalances_Aggregated
  FROM [dbo].[DailyMEBSEquityShareCompare_BusinessBalances]
  GROUP BY Pkg_Id,
           Case_No,
  		   Fd_Descr_Cd,
  		   Reins_Cd,
  		   Fund_Cat_Cd
  ORDER BY Pkg_Id,
           Case_No,
  		   Fd_Descr_Cd,
  		   Reins_Cd,
  		   Fund_Cat_Cd

  
  UPDATE FJ
  SET Accounting_Sum_Units = B.UNITS
  FROM #CompleteListAcctBusCases FJ JOIN #CaseHoldings_Aggregated B
  ON FJ.Pkg_Id = B.Pkg_Id
  AND FJ.Case_No = B.Case_no
  AND FJ.Fd_Desc_Cd = B.Fd_Desc_Cd
  AND FJ.Reins_Cd = B.Reins_Cd
  AND FJ.Fd_Cat_Cd = B.Fd_Cat_Cd

  
  UPDATE FJ
  SET Business_Sum_Units = B.UNITS
  FROM #CompleteListAcctBusCases FJ JOIN #BusinessBalances_Aggregated B
  ON FJ.Pkg_Id = B.Pkg_Id
  AND FJ.Case_No = B.Case_no
  AND FJ.Fd_Desc_Cd = B.Fd_Descr_Cd
  AND FJ.Reins_Cd = B.Reins_Cd
  AND FJ.Fd_Cat_Cd = B.Fund_Cat_Cd
   
  -- Find the difference in Units to report to Accounting
  UPDATE #CompleteListAcctBusCases
  SET Units_Difference = Accounting_Sum_Units - Business_Sum_Units

  -- Set Unit_Value by Fund
  UPDATE FJ
  SET Unit_Value = ROUND(LUV.Unit_Value,4)
  FROM #CompleteListAcctBusCases FJ JOIN [dbo].[DailyMEBSEquityShareCompare_UnitValuesByFund] LUV
  ON FJ.Fd_Desc_Cd = LUV.FD_Descr_Cd

  -- Find the Market_Value based on Units_Difference * Unit_Value
  UPDATE #CompleteListAcctBusCases
  SET Market_Value = ROUND((Units_Difference * Unit_Value),2)

  IF OBJECT_ID('[dbo].[DailyMEBSEquityShareCompare_UnitDiscrepancies]') IS NOT NULL
  BEGIN
    DROP TABLE [dbo].[DailyMEBSEquityShareCompare_UnitDiscrepancies]
  END

  SELECT Pkg_Id,
         Case_No,
		 Fd_Desc_Cd,
		 Reins_Cd,
		 Fd_Cat_Cd,
		 Accounting_Sum_Units,
		 Business_Sum_Units,
		 Units_Difference,
		 Unit_Value,
		 Market_Value,
		 Valuation_Dt
  INTO [dbo].[DailyMEBSEquityShareCompare_UnitDiscrepancies]
  FROM #CompleteListAcctBusCases
  WHERE UNITS_DIFFERENCE >= 1 OR UNITS_DIFFERENCE <= -1
  ORDER BY Pkg_Id, Case_No, Fd_Desc_Cd

  DECLARE @ValuationDt DATE,
          @PartitionDt INT

  SELECT TOP 1 @ValuationDt = Valuation_Dt FROM #CompleteListAcctBusCases
  --ORDER BY Valuation_Dt Desc

  SET @PartitionDt = CAST(CONVERT(VARCHAR,@ValuationDt,112) AS INT)
  PRINT @ValuationDt
  PRINT @PartitionDt

  -- 03/24/2017 - Handle the situation where there are no discrepancies.
  -- If there are no discrepancies we should load a message to 
  -- the results so that the date on the file is
  -- updated and the end user knows that no discrepancies were found

  IF (SELECT COUNT(*) FROM [dbo].[DailyMEBSEquityShareCompare_UnitDiscrepancies]) = 0 
  BEGIN 
     INSERT INTO [dbo].[DailyMEBSEquityShareCompare_UnitDiscrepancies]
	 (
	  Pkg_Id,
	  Case_No,
	  Fd_Desc_Cd,
	  Reins_Cd,
	  Fd_Cat_Cd,
	  Accounting_Sum_Units,
	  Business_Sum_Units,
	  Units_Difference,
	  Unit_Value,
	  Market_Value,
	  Valuation_Dt
	 )
	 SELECT '' AS Pkg_Id,
	        'No mismatches!' AS Case_No,
	        '' AS Fd_Desc_Cd,
	        '' AS Reins_Cd,
	        '' AS Fd_Cat_Cd,
	        0 AS Accounting_Sum_Units,
	        0 AS Business_Sum_Units,
	        0 AS Units_Difference,
	        0 AS Unit_Value,
	        0 AS Market_Value,
			@ValuationDt AS Valuation_Dt
  END

  DROP TABLE #CaseHoldings_Aggregated
  DROP TABLE #BusinessBalances_Aggregated

  -- In the event this process is rerun for the same day clean up the old data
  -- that was posted to the history table. 

  DELETE FROM [dbo].[DailyMEBSEquityShareCompare]
  WHERE Valuation_Dt = @ValuationDt

  -- This table is partitioned by year to keep data for 2 years.
  -- At the end of 2 years the Accounting team requested that we 
  -- archive data older than 2 years by swapping out older partitions.

  INSERT INTO [dbo].[DailyMEBSEquityShareCompare]
  (
         Pkg_Id,
         Case_No,
		 Fd_Desc_Cd,
		 Reins_Cd,
		 Fd_Cat_Cd,
		 Accounting_Sum_Units,
		 Business_Sum_Units,
		 Units_Difference,
		 Unit_Value,
		 Market_Value,
		 Valuation_Dt,
		 Partition_Dt
  )
  SELECT Pkg_Id,
         Case_No,
		 Fd_Desc_Cd,
		 Reins_Cd,
		 Fd_Cat_Cd,
		 Accounting_Sum_Units,
		 Business_Sum_Units,
		 Units_Difference,
		 Unit_Value,
		 Market_Value,
		 @ValuationDt AS Valuation_Dt, -- 03/20/2018 Prevent Partition align index issues
		 @PartitionDt AS Partition_Dt  
  FROM  #CompleteListAcctBusCases

  DROP TABLE #CompleteListAcctBusCases

  COMMIT TRANSACTION MEBSEquityProcess
  END TRY
BEGIN CATCH
  ROLLBACK;
  THROW;
END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[usp_DailyMEBSEquityProcess_UpdateRunHistory]    Script Date: 6/17/2021 11:11:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Author: Brenda Olson
-- Creation Date: 02/06/2017
-- Procedure Name: dbo.usp_DailyMEBSEquityProcess_UpdateRunHistory
-- Description: This procedure keeps a run history each time the package is 
--              run and how many records are found in Case Holdings and
--              Business Balances. 
-- 
--------------------------------------------------------------------------
--                   Change Activity
--------------------------------------------------------------------------
-- Last Updated     Description of what was changed
--------------------------------------------------------------------------
--
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- EXEC [dbo].[usp_DailyMEBSEquityProcess_UpdateRunHistory] 

CREATE PROCEDURE [dbo].[usp_DailyMEBSEquityProcess_UpdateRunHistory] AS
BEGIN

    SET NOCOUNT ON;
    
    DECLARE @AccountingRecordCount INT;
    SELECT @AccountingRecordCount = COUNT(*) FROM dbo.DailyMEBSEquityShareCompare_CleansedCaseHoldings
    
    DECLARE @BusinessRecordCount INT;
    SELECT @BusinessRecordCount = COUNT(*) FROM dbo.DailyMEBSEquityShareCompare_BusinessBalances
    
    DECLARE @TotalRecordCount INT;
    SELECT @TotalRecordCount = @AccountingRecordCount + @BusinessRecordCount;
    
    DECLARE @EffectiveDate DATE;
    SET @EffectiveDate = (SELECT DISTINCT EFF_D FROM dbo.DailyMEBSEquityShareCompare_BusinessBalances);
    
    INSERT INTO [dbo].[DailyMEBSEquityShareCompare_History]
    (
      Effective_Date,
      Accounting_Record_Count,
      Business_Record_Count,
      Total_Record_Count,
      Run_Date_Time
    )
    SELECT @EffectiveDate AS Effective_Date,
           @AccountingRecordCount AS Accounting_Record_Count,
    	   @BusinessRecordCount AS Business_Record_Count,
    	   @TotalRecordCount AS Total_Record_Count,
    	   GETDATE() AS Run_Date_Time;
    
    END


GO
/****** Object:  StoredProcedure [dbo].[usp_DailyMEBSEquityTableCreation]    Script Date: 6/17/2021 11:11:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Author: Brenda Olson
-- Creation Date: 02/06/2017
-- Procedure Name: dbo.usp_DailyMEBSEquityTableCreation
-- Description: This stored procedure creates tables for each daily run
--              to capture details pertinent to that run only. 
-- 
--------------------------------------------------------------------------
--                   Change Activity
--------------------------------------------------------------------------
-- Last Updated     Description of what was changed
--------------------------------------------------------------------------
--
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--EXEC [dbo].[usp_DailyMEBSEquityTableCreation]

CREATE PROCEDURE [dbo].[usp_DailyMEBSEquityTableCreation] AS
BEGIN

   IF OBJECT_ID('dbo.DailyMEBSEquityShareCompare_CaseHoldings') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailyMEBSEquityShareCompare_CaseHoldings
   END 
   
   CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_CaseHoldings](
   	[Source] [varchar](20) NOT NULL,
   	[Pkg_Id] [char](4) NOT NULL,
   	[Case_No] [varchar](20) NOT NULL,
   	[Fd_Desc_Cd] [char](10) NOT NULL,
   	[Reins_Cd] [char](1) NULL,
   	[Units] [numeric](15, 6) NULL,
   	[Fd_Cat_Cd] [char](2) NULL,
   	[Valuation_Dt] [date] NOT NULL
   ) ON [PRIMARY]

   IF OBJECT_ID('dbo.DailyMEBSEquityShareCompare_BusinessBalances') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailyMEBSEquityShareCompare_BusinessBalances
   END 
   
   CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_BusinessBalances](
   	[Source] [varchar](20) NOT NULL,
   	[Pkg_Id] [char](5) NOT NULL,
   	[Case_No] [varchar](20) NOT NULL,
    [Fd_Descr_Cd] [char](4) NOT NULL,
   	[Reins_Cd] [char](1) NOT NULL,
   	[Unit_Ct] [numeric](15, 6) NOT NULL,
   	[Fund_Cat_Cd] [char](2) NOT NULL,
   	[Eff_D] [date] NOT NULL
   ) ON [PRIMARY]
   
   IF OBJECT_ID('dbo.DailyMEBSEquityShareCompare_NonParisCases') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailyMEBSEquityShareCompare_NonParisCases
   END 
      
   CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_NonParisCases](
   	[Adj_Cat_Case_No] [varchar](20) NOT NULL,
   	[Pkg_Id] [char](4) NOT NULL,
   	[Adj_Cat_Case_Txt] [varchar](30) NOT NULL
   ) ON [PRIMARY]

   IF OBJECT_ID('dbo.DailyMEBSEquityShareCompare_CleansedCaseHoldings') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailyMEBSEquityShareCompare_CleansedCaseHoldings
   END 
   
   CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_CleansedCaseHoldings](
   	[Source] [varchar](20) NOT NULL,
   	[Pkg_Id] [char](5) NOT NULL,
   	[Case_No] [varchar](20) NOT NULL,
   	[Fd_Desc_Cd] [char](10) NOT NULL,
   	[Reins_Cd] [char](1) NULL,
   	[Units] [numeric](15, 6) NULL,
   	[Fd_Cat_Cd] [char](2) NULL,
   	[Valuation_Dt] [date] NOT NULL
   ) ON [PRIMARY]


   IF OBJECT_ID('dbo.DailyMEBSEquityShareCompare_UnitValuesByFund') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailyMEBSEquityShareCompare_UnitValuesByFund
   END 

   CREATE TABLE [dbo].[DailyMEBSEquityShareCompare_UnitValuesByFund](
   	[Fd_Descr_Cd] [char](10) NOT NULL,
   	[Unit_Value] [numeric](13, 6) NULL
   ) ON [PRIMARY]

END


GO
/****** Object:  StoredProcedure [dbo].[usp_DailyMEBSFixed_GetDollarDiscrepancies]    Script Date: 6/17/2021 11:11:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Author: Brenda Olson
-- Creation Date: 02/24/2017
-- Procedure Name: dbo.usp_DailyMEBSFixed_GetDollarDiscrepancies
-- Description: This returns the contents of the table 
--              dbo.DailyMEBSFixedCompare_DollarDiscrepancies
-- 
--------------------------------------------------------------------------
--                   Change Activity
--------------------------------------------------------------------------
-- Last Updated     Description of what was changed
--------------------------------------------------------------------------
--
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- EXEC [dbo].[usp_DailyMEBSFixed_GetDollarDiscrepancies]

CREATE PROCEDURE [dbo].[usp_DailyMEBSFixed_GetDollarDiscrepancies] AS
BEGIN

    SET NOCOUNT ON

    SELECT 
	   Valuation_Dt,
	   Pkg_Id, 
       Case_No,
	   Fd_Desc_Cd,
	   Fd_Cat_Cd,
	   Accounting_Sum_Dollars,
	   Business_Sum_Dollars,
	   Dollars_Difference
     FROM [dbo].[DailyMEBSFixedCompare_DollarDiscrepancies]
     ORDER BY Pkg_Id, 
              Case_No,
     	      Fd_Desc_Cd,
			  Fd_Cat_Cd
END
GO
/****** Object:  StoredProcedure [dbo].[usp_DailyMEBSFixedProcess]    Script Date: 6/17/2021 11:11:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Author: Brenda Olson
-- Creation Date: 02/06/2017
-- Procedure Name: dbo.usp_DailyMEBSFixedProcess
-- Description: This stored procedure generates results for two tables:
-- 1) dbo.DailyMEBSFixedCompare_DollarDiscrepancies - Compare accounting to 
--    business and report any records where dollar amount >= 100.00 or
--    <= -100.00.
-- 2) dbo.DailyMEBSFixedCompare - Cumulative content containing 
--    2 years history.  
-- 
--------------------------------------------------------------------------
--                   Change Activity
--------------------------------------------------------------------------
-- Last Updated     Description of what was changed
--------------------------------------------------------------------------
-- 03/24/2017       Handle the situation where there are no discrepancies.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- EXEC [dbo].[usp_DailyMEBSFixedProcess]

CREATE PROCEDURE [dbo].[usp_DailyMEBSFixedProcess] AS
BEGIN
  BEGIN TRY
  BEGIN TRANSACTION MEBSFixedProcess

  SET NOCOUNT ON

  -- Excel Power Pivot has the power to aggregate but Excel has
  -- limits on how much data can be loaded to a worksheet.
  -- This process was developed as an alternative to loading
  -- over a million records to Excel. We are persisting the data
  -- on a table. We will keep two years data on this table and
  -- we can swap out partitions as needed to improve I/O access.

  -- This table is simulating the Power Pivot needed to compare
  -- business to accounting. 

  IF OBJECT_ID('tempdb..#CompleteListAcctBusCases') IS NOT NULL
  BEGIN
    DROP TABLE #CompleteListAcctBusCases
  END
  
  SELECT DISTINCT COALESCE(A.Pkg_Id, B.Business_Line) AS Pkg_Id,
                  COALESCE(A.Case_No, B.Case_No) AS Case_No,
  	              COALESCE(A.Fd_Desc_Cd, B.Fd_Descr_Cd) AS Fd_Desc_Cd,
                  COALESCE(A.Fd_Cat_Cd, B.Fd_Trfr_Agt_Cd) AS Fd_Cat_Cd,
  	              CAST(0 AS DECIMAL(15,2)) AS Accounting_Sum_Dollars,
  	              CAST(0 AS DECIMAL(15,2)) AS Business_Sum_Dollars,
  	              CAST(0 AS DECIMAL(15,2)) AS Dollars_Difference,
	              COALESCE(A.Valuation_Dt,B.EFF_D) AS Valuation_Dt
  INTO #CompleteListAcctBusCases
  FROM [dbo].[DailyMEBSFixedCompare_CaseHoldings] A 
  FULL JOIN [dbo].[DailyMEBSFixedCompare_BusinessBalances] B
  ON A.Pkg_Id = B.Business_Line
  AND A.Case_No = B.Case_no
  AND A.Fd_Desc_Cd = B.Fd_Descr_Cd
  AND A.Fd_Cat_Cd = B.Fd_Trfr_Agt_Cd
  ORDER BY Pkg_Id, Case_No, Fd_Desc_Cd

  ---------------------------------------------
  -- Rounding requirements:
  ---------------------------------------------
  -- Dollar values rounded to two decimal points
  ----------------------------------------------

  -- Aggregate CaseHoldings for subsequent update
  
  IF OBJECT_ID('tempdb..#CaseHoldings_Aggregated') IS NOT NULL
  BEGIN
    DROP TABLE #CaseHoldings_Aggregated
  END
  
  SELECT Pkg_Id,
  	     Case_No,
  	     Fd_Desc_Cd,
  	     Fd_Cat_Cd,
  	     ROUND(SUM(Tr_Amt),2) AS Accounting_Sum_Dollars
  INTO #CaseHoldings_Aggregated
  FROM [dbo].[DailyMEBSFixedCompare_CaseHoldings]
  GROUP BY Pkg_Id,
           Case_No,
  		   Fd_Desc_Cd,
  		   Fd_Cat_Cd
  ORDER BY Pkg_Id,
           Case_No,
  		   Fd_Desc_Cd,
  		   Fd_Cat_Cd

  -- Aggregate BusinessBalances for subsequent update
    
  IF OBJECT_ID('tempdb..#BusinessBalances_Aggregated') IS NOT NULL
  BEGIN
    DROP TABLE #BusinessBalances_Aggregated
  END
  
  SELECT Business_Line,
  	     Case_No,
  	     Fd_Descr_Cd,
  	     Fd_Trfr_Agt_Cd,
  	     ROUND(SUM(Fixed_Bus_Amt),2) AS Business_Sum_Dollars
  INTO #BusinessBalances_Aggregated
  FROM [dbo].[DailyMEBSFixedCompare_BusinessBalances]
  GROUP BY Business_Line,
           Case_No,
  		   Fd_Descr_Cd,
  		   Fd_Trfr_Agt_Cd
  ORDER BY Business_Line,
           Case_No,
  		   Fd_Descr_Cd,
  		   Fd_Trfr_Agt_Cd

  
  UPDATE FJ
  SET Accounting_Sum_Dollars = B.Accounting_Sum_Dollars
  FROM #CompleteListAcctBusCases FJ JOIN #CaseHoldings_Aggregated B
  ON FJ.Pkg_Id = B.Pkg_Id
  AND FJ.Case_No = B.Case_no
  AND FJ.Fd_Desc_Cd = B.Fd_Desc_Cd
  AND FJ.Fd_Cat_Cd = B.Fd_Cat_Cd

  
  UPDATE FJ
  SET Business_Sum_Dollars = B.Business_Sum_Dollars
  FROM #CompleteListAcctBusCases FJ JOIN #BusinessBalances_Aggregated B
  ON FJ.Pkg_Id = B.Business_Line
  AND FJ.Case_No = B.Case_no
  AND FJ.Fd_Desc_Cd = B.Fd_Descr_Cd
  AND FJ.Fd_Cat_Cd = B.Fd_Trfr_Agt_Cd
   
  -- Find the difference in Units to report to Accounting
  UPDATE #CompleteListAcctBusCases
  SET Dollars_Difference = Accounting_Sum_Dollars - Business_Sum_Dollars

  IF OBJECT_ID('[dbo].[DailyMEBSFixedCompare_DollarDiscrepancies]') IS NOT NULL
  BEGIN
    DROP TABLE [dbo].[DailyMEBSFixedCompare_DollarDiscrepancies]
  END

  SELECT Pkg_Id,
         Case_No,
		 Fd_Desc_Cd,
		 Fd_Cat_Cd,
		 Accounting_Sum_Dollars,
		 Business_Sum_Dollars,
		 Dollars_Difference,
		 Valuation_Dt
  INTO [dbo].[DailyMEBSFixedCompare_DollarDiscrepancies]
  FROM #CompleteListAcctBusCases
  WHERE Dollars_Difference >= 100 OR Dollars_Difference <= -100
  ORDER BY Pkg_Id, Case_No, Fd_Desc_Cd

  DECLARE @ValuationDt DATE,
          @PartitionDt INT

  SELECT TOP 1 @ValuationDt = Valuation_Dt FROM #CompleteListAcctBusCases
  SET @PartitionDt = CAST(CONVERT(VARCHAR,@ValuationDt,112) AS INT)
  --PRINT @ValuationDt
  --PRINT @PartitionDt

  -- 03/24/2017 - Handle the situation where there are no discrepancies.
  -- If there are no discrepancies we should load a message to 
  -- the results so that the date on the file is
  -- updated and the end user knows that no discrepancies were found

  IF (SELECT COUNT(*) FROM [dbo].[DailyMEBSFixedCompare_DollarDiscrepancies]) = 0 
  BEGIN 
     INSERT INTO [dbo].[DailyMEBSFixedCompare_DollarDiscrepancies]
	 (
	  Pkg_Id,
	  Case_No,
	  Fd_Desc_Cd,
	  Fd_Cat_Cd,
	  Accounting_Sum_Dollars,
	  Business_Sum_Dollars,
	  Dollars_Difference,
	  Valuation_Dt
	 )
	 SELECT '' AS Pkg_Id,
	        'No mismatches!' AS Case_No,
	        '' AS Fd_Desc_Cd,
	        '' AS Fd_Cat_Cd,
	        0 AS Accounting_Sum_Dollars,
	        0 AS Business_Sum_Dollars,
	        0 AS Dollars_Difference,
			@ValuationDt AS Valuation_Dt
  END
  
  DROP TABLE #CaseHoldings_Aggregated
  DROP TABLE #BusinessBalances_Aggregated

  -- In the event this process is rerun for the same day clean up the old data
  -- that was posted to the history table. 

  DELETE FROM [dbo].[DailyMEBSFixedCompare]
  WHERE Valuation_Dt = @ValuationDt

  -- This table is partitioned by year to keep data for 2 years.
  -- At the end of 2 years the Accounting team requested that we 
  -- archive data older than 2 years by swapping out older partitions.

  INSERT INTO [dbo].[DailyMEBSFixedCompare]
  (
         Pkg_Id,
         Case_No,
		 Fd_Desc_Cd,
		 Fd_Cat_Cd,
		 Accounting_Sum_Dollars,
		 Business_Sum_Dollars,
		 Dollars_Difference,
		 Valuation_Dt,
		 Partition_Dt
  )
  SELECT Pkg_Id,
         Case_No,
		 Fd_Desc_Cd,
		 Fd_Cat_Cd,
		 Accounting_Sum_Dollars,
		 Business_Sum_Dollars,
		 Dollars_Difference,
		 Valuation_Dt,
		 @PartitionDt AS Partition_Dt  
  FROM  #CompleteListAcctBusCases

  DROP TABLE #CompleteListAcctBusCases

  COMMIT TRANSACTION MEBSFixedProcess
  END TRY
BEGIN CATCH
  ROLLBACK;
  THROW;
END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[usp_DailyMEBSFixedProcess_UpdateRunHistory]    Script Date: 6/17/2021 11:11:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DailyMEBSFixedProcess_UpdateRunHistory] AS
BEGIN

    SET NOCOUNT ON;
    
    DECLARE @AccountingRecordCount INT;
    SELECT @AccountingRecordCount = COUNT(*) FROM dbo.DailyMEBSFixedCompare_CaseHoldings
    
    DECLARE @BusinessRecordCount INT;
    SELECT @BusinessRecordCount = COUNT(*) FROM dbo.DailyMEBSFixedCompare_BusinessBalances
    
    DECLARE @TotalRecordCount INT;
    SELECT @TotalRecordCount = @AccountingRecordCount + @BusinessRecordCount;
    
    DECLARE @EffectiveDate DATE;
    SET @EffectiveDate = (SELECT DISTINCT EFF_D FROM dbo.DailyMEBSFixedCompare_BusinessBalances);
    
    INSERT INTO [dbo].[DailyMEBSFixedCompare_History]
    (
      Effective_Date,
      Accounting_Record_Count,
      Business_Record_Count,
      Total_Record_Count,
      Run_Date_Time
    )
    SELECT @EffectiveDate AS Effective_Date,
           @AccountingRecordCount AS Accounting_Record_Count,
    	   @BusinessRecordCount AS Business_Record_Count,
    	   @TotalRecordCount AS Total_Record_Count,
    	   GETDATE() AS Run_Date_Time;
    
    END


GO
/****** Object:  StoredProcedure [dbo].[usp_DailyMEBSFixedTableCreation]    Script Date: 6/17/2021 11:11:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DailyMEBSFixedTableCreation] AS
BEGIN

   IF OBJECT_ID('dbo.DailyMEBSFixedCompare_CaseHoldings') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailyMEBSFixedCompare_CaseHoldings
   END 
   
   CREATE TABLE [dbo].[DailyMEBSFixedCompare_CaseHoldings](
   	[Source] [varchar](20) NOT NULL,
   	[Pkg_Id] [char](4) NOT NULL,
   	[Case_No] [varchar](20) NOT NULL,
   	[Fd_Cat_Cd] [char](2) NULL,
   	[Fd_Desc_Cd] [char](10) NOT NULL,
   	[Tr_Amt] [numeric](13, 2) NULL,
   	[Valuation_Dt] [date] NOT NULL
   ) ON [PRIMARY]

   IF OBJECT_ID('dbo.DailyMEBSFixedCompare_BusinessBalances') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailyMEBSFixedCompare_BusinessBalances
   END 
   
   CREATE TABLE [dbo].[DailyMEBSFixedCompare_BusinessBalances](
   	[Source] [varchar](20) NOT NULL,
	[Business_Line] [char](5) NOT NULL,
   	[Case_No] [varchar](20) NOT NULL,
	[Fd_Trfr_Agt_Cd] [char](2) NOT NULL,
    [Fd_Descr_Cd] [char](5) NOT NULL,
   	[Fixed_Bus_Amt] [numeric](18, 2) NOT NULL,
   	[Eff_D] [date] NOT NULL
   ) ON [PRIMARY]
   
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DailySAF_GetDollarDiscrepancies]    Script Date: 6/17/2021 11:11:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DailySAF_GetDollarDiscrepancies] AS
BEGIN

    SET NOCOUNT ON

    SELECT 
	   Valuation_Dt,
       Tr_Ref_No,
	   Capstock_Sum_Dollars,
	   Portfolio_Sum_Dollars,
	   Dollars_Difference
     FROM [dbo].[DailySAF_DollarDiscrepancies]
     ORDER BY Tr_Ref_No
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DailySAFProcess]    Script Date: 6/17/2021 11:11:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DailySAFProcess] AS
BEGIN
  BEGIN TRY
  BEGIN TRANSACTION DailySAFProcess

  SET NOCOUNT ON

  -- Excel Power Pivot has the power to aggregate but Excel has
  -- limits on how much data can be loaded to a worksheet.
  -- This process was developed as an alternative to loading
  -- over a million records to Excel. We are persisting the data
  -- on a table. We will keep two years data on this table and
  -- we can swap out partitions as needed to improve I/O access.

  -- This table is simulating the Power Pivot needed to compare
  -- Capstock to Portfolio. 

  IF OBJECT_ID('tempdb..#CompleteListCapstockPortfolioTrRefNos') IS NOT NULL
  BEGIN
    DROP TABLE #CompleteListCapstockPortfolioTrRefNos
  END
  
  --select * from #CompleteListCapstockPortfolioTrRefNos
  SELECT DISTINCT COALESCE(A.TR_REF_NO, B.TR_REF_NO) AS TR_REF_NO,
  	              CAST(0 AS DECIMAL(15,2)) AS Capstock_Sum_Dollars,
  	              CAST(0 AS DECIMAL(15,2)) AS Portfolio_Sum_Dollars,
  	              CAST(0 AS DECIMAL(15,2)) AS Dollars_Difference,
	              COALESCE(A.Valuation_Dt, B.Valuation_Dt) AS Valuation_Dt
  INTO #CompleteListCapstockPortfolioTrRefNos
  FROM [dbo].[DailySAF_CapstockResults] A 
  FULL JOIN [dbo].[DailySAF_PortfolioResults] B
  ON A.TR_REF_NO = B.TR_REF_NO
  ORDER BY TR_REF_NO

  ---------------------------------------------
  -- Rounding requirements:
  ---------------------------------------------
  -- Dollar values rounded to two decimal points
  ----------------------------------------------

  -- Aggregate Capstock for subsequent update
  
  IF OBJECT_ID('tempdb..#Capstock_Aggregated') IS NOT NULL
  BEGIN
    DROP TABLE #Capstock_Aggregated
  END
  
  SELECT Tr_Ref_No,
  	     ROUND(SUM(Tr_Amt),2) AS Capstock_Sum_Dollars
  INTO #Capstock_Aggregated
  FROM [dbo].[DailySAF_CapstockResults]
  GROUP BY Tr_Ref_No
  ORDER BY Tr_Ref_No

  -- Aggregate Portfolio for subsequent update
    
  IF OBJECT_ID('tempdb..#Portfolio_Aggregated') IS NOT NULL
  BEGIN
    DROP TABLE #Portfolio_Aggregated
  END
  
  SELECT Tr_Ref_No,
  	     ROUND(SUM(Tr_Amt),2) AS Portfolio_Sum_Dollars
  INTO #Portfolio_Aggregated
  FROM [dbo].[DailySAF_PortfolioResults]
  GROUP BY Tr_Ref_No
  ORDER BY Tr_Ref_No
  
  UPDATE FJ
  SET Capstock_Sum_Dollars = B.Capstock_Sum_Dollars
  FROM #CompleteListCapstockPortfolioTrRefNos FJ JOIN #Capstock_Aggregated B
  ON FJ.Tr_Ref_No = B.Tr_Ref_No
  
  UPDATE FJ
  SET Portfolio_Sum_Dollars = B.Portfolio_Sum_Dollars
  FROM #CompleteListCapstockPortfolioTrRefNos FJ JOIN #Portfolio_Aggregated B
  ON FJ.Tr_Ref_No = B.Tr_Ref_No
   
  -- Find the difference in Dollars to report to Accounting
  UPDATE #CompleteListCapstockPortfolioTrRefNos
  SET Dollars_Difference = Capstock_Sum_Dollars - Portfolio_Sum_Dollars

  IF OBJECT_ID('[dbo].[DailySAF_DollarDiscrepancies]') IS NOT NULL
  BEGIN
    DROP TABLE [dbo].[DailySAF_DollarDiscrepancies]
  END

  SELECT Valuation_Dt,
         Tr_Ref_No,
         Capstock_Sum_Dollars,
		 Portfolio_Sum_Dollars,
         Dollars_Difference
  INTO [dbo].[DailySAF_DollarDiscrepancies]
  FROM #CompleteListCapstockPortfolioTrRefNos
  WHERE Dollars_Difference <> 0
  ORDER BY Tr_Ref_No

  DECLARE @ValuationDt DATE,
          @PartitionDt INT

  SELECT TOP 1 @ValuationDt = Valuation_Dt FROM #CompleteListCapstockPortfolioTrRefNos
  SET @PartitionDt = CAST(CONVERT(VARCHAR,@ValuationDt,112) AS INT)
  --PRINT @ValuationDt
  --PRINT @PartitionDt

  -- If there are no discrepancies we should load a message to 
  -- the results so that the date on the file is
  -- updated and the end user knows that no discrepancies were found

  IF (SELECT COUNT(*) FROM [dbo].[DailySAF_DollarDiscrepancies]) = 0 
  BEGIN 
     INSERT INTO [dbo].[DailySAF_DollarDiscrepancies]
	 (
	  Valuation_Dt,
	  Tr_Ref_No,
	  Capstock_Sum_Dollars,
	  Portfolio_Sum_Dollars,
	  Dollars_Difference
	 )
	 SELECT @ValuationDt AS Valuation_Dt,
	        'No mismatches!' AS Tr_Ref_No,
	        0 AS Capstock_Sum_Dollars,
	        0 AS Portfolio_Sum_Dollars,
	        0 AS Dollars_Difference
  END

  DROP TABLE #Capstock_Aggregated
  DROP TABLE #Portfolio_Aggregated

  -- In the event this process is rerun for the same day clean up the old data
  -- that was posted to the history table. 

  DELETE FROM [dbo].[DailySAFCompare]
  WHERE Valuation_Dt = @ValuationDt

  -- This table is partitioned by year to keep data for 2 years.
  -- At the end of 2 years the Accounting team requested that we 
  -- archive data older than 2 years by swapping out older partitions.

  INSERT INTO [dbo].[DailySAFCompare]
  (
      Source
     ,Valuation_Dt
     ,Tr_Ref_No
     ,Case_No
     ,Fd_Desc_Expnd_Cd
     ,Fd_Cat_Cd
     ,Trfr_Fd_Expnd_Cd
     ,Trfr_Fd_Cat_Cd
     ,Map_Key_Cd
     ,Reversal_Cd
     ,Tr_No
     ,Reins_Cd
     ,Client_Eff_Dt
     ,System_Orig_Cd
     ,User_Id
     ,Dr_Cr_Cd
     ,Tr_Amt
     ,Units_Ct
     ,Partition_DT
  )
  SELECT       
      'CAPSTOCK' AS Source
     ,Valuation_Dt
     ,Tr_Ref_No
     ,Case_No
     ,Fd_Desc_Expnd_Cd
     ,Fd_Cat_Cd
     ,Trfr_Fd_Expnd_Cd
     ,Trfr_Fd_Cat_Cd
     ,Map_Key_Cd
     ,Reversal_Cd
     ,Tr_No
     ,Reins_Cd
     ,Client_Eff_Dt
     ,System_Orig_Cd
     ,User_Id
     ,Dr_Cr_Cd
     ,Tr_Amt
     ,Units_Ct
     ,@PartitionDt AS Partition_DT
  FROM [dbo].[DailySAF_CapstockResults]

  UNION ALL 

  SELECT   
     'PORTFOLIO' AS Source
     ,Valuation_Dt
     ,Tr_Ref_No
     ,Case_No
     ,Fd_Desc_Expnd_Cd
     ,Fd_Cat_Cd
     ,Trfr_Fd_Expnd_Cd
     ,Trfr_Fd_Cat_Cd
     ,Map_Key_Cd
     ,Reversal_Cd
     ,Tr_No
     ,Reins_Cd
     ,Client_Eff_Dt
     ,System_Orig_Cd
     ,User_Id
     ,Dr_Cr_Cd
     ,Tr_Amt
     ,Units_Ct
     ,@PartitionDt AS Partition_DT
  FROM [dbo].[DailySAF_PortfolioResults]

  DROP TABLE #CompleteListCapstockPortfolioTrRefNos

  COMMIT TRANSACTION DailySAFProcess
END TRY
BEGIN CATCH
  ROLLBACK;
  THROW;
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DailySAFProcess_UpdateRunHistory]    Script Date: 6/17/2021 11:11:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_DailySAFProcess_UpdateRunHistory] AS
-----------------------------------------------------------------------------------------------------------------------------------------
-- Update Date     Description of change
-----------------------------------------------------------------------------------------------------------------------------------------
-- 12/06/2018      DDEV-96388: FOF/SAF Capstock to portfolio failed on 12/6/2018 after market close 12/5/2018
--                 Set EffectiveDate to today - 1 day when no data is returned for dbo.DailySAF_CapstockResults
-----------------------------------------------------------------------------------------------------------------------------------------
BEGIN


    SET NOCOUNT ON;
    
    DECLARE @CapstockRecordCount INT;
    SELECT @CapstockRecordCount = COUNT(*) FROM dbo.DailySAF_CapstockResults
    
    DECLARE @PortfolioRecordCount INT;
    SELECT @PortfolioRecordCount = COUNT(*) FROM dbo.DailySAF_PortfolioResults
    
    DECLARE @TotalRecordCount INT;
    SELECT @TotalRecordCount = @CapstockRecordCount + @PortfolioRecordCount;
    
    DECLARE @EffectiveDate DATE;
    SET @EffectiveDate = (SELECT DISTINCT Valuation_Dt FROM dbo.DailySAF_CapstockResults);
    
	--PRINT @CapstockRecordCount
	--PRINT @PortfolioRecordCount
	--PRINT @TotalRecordCount
	--PRINT @EffectiveDate

    INSERT INTO [dbo].[DailySAFCompare_History]
    (
      Effective_Date,
      Capstock_Record_Count,
      Portfolio_Record_Count,
      Total_Record_Count,
      Run_Date_Time
    )
    SELECT CASE WHEN @EffectiveDate IS NOT NULL THEN @EffectiveDate ELSE GETDATE() - 1  END AS Effective_Date,
           @CapstockRecordCount AS Capstock_Record_Count,
    	   @PortfolioRecordCount AS Portfolio_Record_Count,
    	   @TotalRecordCount AS Total_Record_Count,
    	   GETDATE() AS Run_Date_Time;
END


GO
/****** Object:  StoredProcedure [dbo].[usp_DailySAFTableCreation]    Script Date: 6/17/2021 11:11:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_DailySAFTableCreation] AS
BEGIN

   IF OBJECT_ID('dbo.DailySAF_CapstockResults') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailySAF_CapstockResults
   END 
   
   CREATE TABLE dbo.DailySAF_CapstockResults
   (
          Valuation_Dt DATE NULL,
          Tr_Ref_No VARCHAR(14) NULL,
   	      Case_No VARCHAR(20) NULL,
   	      Fd_Desc_Expnd_Cd VARCHAR(10) NULL,
   	      Fd_Cat_Cd VARCHAR(2) NULL,
   	      Trfr_Fd_Expnd_Cd VARCHAR(10) NULL,
   	      Trfr_Fd_Cat_Cd VARCHAR(2) NULL,
   	      Map_Key_Cd VARCHAR(4) NULL,
   	      Reversal_Cd VARCHAR(1) NULL,
   	      Tr_No VARCHAR(4) NULL,
   	      Reins_Cd VARCHAR(1) NULL,
   	      Client_Eff_Dt DATE NULL,
   	      System_Orig_Cd VARCHAR(4) NULL,
   	      [User_Id] VARCHAR(10) NULL,
   	      Dr_Cr_Cd VARCHAR(2) NULL,
   	      Tr_Amt DECIMAL(13,2) NULL,
   	      Units_Ct DECIMAL(15,6) NULL
   )

   IF OBJECT_ID('dbo.DailySAF_PortfolioResults') IS NOT NULL
   BEGIN
     DROP TABLE dbo.DailySAF_PortfolioResults
   END 
   
   CREATE TABLE dbo.DailySAF_PortfolioResults
   (
          Valuation_Dt DATE NULL,
          Tr_Ref_No VARCHAR(14) NULL,
   	      Case_No VARCHAR(20) NULL,
   	      Fd_Desc_Expnd_Cd VARCHAR(10) NULL,
   	      Fd_Cat_Cd VARCHAR(2) NULL,
   	      Trfr_Fd_Expnd_Cd VARCHAR(10) NULL,
   	      Trfr_Fd_Cat_Cd VARCHAR(2) NULL,
   	      Map_Key_Cd VARCHAR(4) NULL,
   	      Reversal_Cd VARCHAR(1) NULL,
   	      Tr_No VARCHAR(4) NULL,
   	      Reins_Cd VARCHAR(1) NULL,
   	      Client_Eff_Dt DATE NULL,
   	      System_Orig_Cd VARCHAR(4) NULL,
   	      [User_Id] VARCHAR(10) NULL,
   	      Dr_Cr_Cd VARCHAR(2) NULL,
   	      Tr_Amt DECIMAL(13,2) NULL,
   	      Units_Ct DECIMAL(15,6) NULL
   )
   
END



GO
USE [master]
GO
ALTER DATABASE [Accounting_Adhoc] SET  READ_WRITE 
GO

-- this is to get the web site back up when RDM has a failure - original view below


CREATE OR ALTER VIEW [usr].[DwFlagCheck]
 AS
/******************************************************************************************************
Purpose:
        This view is used by the Plan Data Link to determine if it should be available
	   to end users or not.
Inputs:
        None
Result:
	   Returns the SUM of DWFlag for the normal Pension DataWarehouse Run. 
	   If greater than 0 then something happened with the Pension DW and this will prevent
	   Plan Data Link access. If it returns 0 then Plan Data Link is accessible.
	   Plan Data Link should continue to be accessible during Post Processing.
Author(s):
        Brad Lamb - Created 
*******************************************************************************************************/
--------------------------------------------------------------------------------------------------------
-- 09/29/2017 - Added Post Processing Flags to this view so that Plan Data Link is still
--              accessible during post processing. 
-- 03/27/2018 - Added two new rows to dbo.Driver_DW_Flag for two additional tables added to 
--              post processing dbo.Stmt_Fin_Ror and dbo.Stmt_Fin_Ror_Arch
-- 06/22/2018 - DDEV-54189 - Remove the flags that are no longer needed: 'Deployment5','UserAppInitialLoad',
--              'FactFinancial_Int', 'Services Load','TaeTransactDetReload','May2017Deployment',
--              'PPAug2017Deployment'
--------------------------------------------------------------------------------------------------------

 SELECT 0 AS [DWFlag]

GO


------ Original view is below

USE [TRS_BI_Staging]
GO

/****** Object:  View [usr].[DwFlagCheck]    Script Date: 6/16/2020 10:33:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER   VIEW [usr].[DwFlagCheck]
 AS
/******************************************************************************************************
Purpose:
        This view is used by the Plan Data Link to determine if it should be available
	   to end users or not.
Inputs:
        None
Result:
	   Returns the SUM of DWFlag for the normal Pension DataWarehouse Run. 
	   If greater than 0 then something happened with the Pension DW and this will prevent
	   Plan Data Link access. If it returns 0 then Plan Data Link is accessible.
	   Plan Data Link should continue to be accessible during Post Processing.
Author(s):
        Brad Lamb - Created 
*******************************************************************************************************/
-------------------------------------------------------------------------------------------------------------------------------
-- Update Date     Description of change
-------------------------------------------------------------------------------------------------------------------------------
-- 09/29/2017 - Added Post Processing Flags to this view so that Plan Data Link is still accessible during post processing. 
-- 03/27/2018 - Added two new rows to dbo.Driver_DW_Flag for two additional tables added to post processing 
--              dbo.Stmt_Fin_Ror and dbo.Stmt_Fin_Ror_Arch
-- 06/22/2018 - DDEV-54189 - Remove the flags that are no longer needed: 'Deployment5','UserAppInitialLoad',
--              'FactFinancial_Int', 'Services Load','TaeTransactDetReload','May2017Deployment',
--              'PPAug2017Deployment'
-- 10/22/2018 - DDEV-79594 Remove PreStagingDimSource as this was moved from Post Processing to Pension DW Delta   
-- 12/18/2018 - DDEV-90037 Add additional tables for post processing: FpMirrorFund,FpUnitValue,CaseFundData
-------------------------------------------------------------------------------------------------------------------------------

 SELECT CASE WHEN SUM(DWFlag) > 0 THEN 1 ELSE 0 END AS [DWFlag]
 FROM [dbo].[Driver_DW_Flag] WITH (NOLOCK)
 WHERE [DWText] NOT IN ('factParticipntReload', -- Keep this as we usually reload factParticipant each release
 -- These are all post processing - we will add ProjectId to separate PostProcessing (1)
 -- from PensionDataMart (0) from Deployments (2) in a future deployment
 'PodDelivAddr','PodSchd','PodSchdDetails','PodShipOrd','PodShipOrdDetl',
'StmtPlanSchd','StmtSchd','FinActLog','PostProcessing','GuntherLog','refIraHandling',
'dimCaseRelationship','SlaDimPlan','PreStagingDimFund','Notification',
'NotificationDetail','factNotification','refPartNotification','BillRemitDetailDelta',
'WithdrawDetailDelta','PayeeAddressDelta','PreStagingDimPPT','PreStagingDimIntCont',
'PreStagingDimPlan','PreStagingHelper','StmtFinRor','StmtFinRorArch','FpMirrorFund','FpUnitValue','CaseFundData')

GO



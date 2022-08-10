USE master;  
SELECT * FROM sys.resource_governor_resource_pools;  
SELECT * FROM sys.resource_governor_workload_groups;  
GO  

--- Get the classifier function Id and state (enabled).  
SELECT * FROM sys.resource_governor_configuration;  
GO  
--- Get the classifer function name and the name of the schema  
--- that it is bound to.  
SELECT   
      object_schema_name(classifier_function_id) AS [schema_name],  
      object_name(classifier_function_id) AS [function_name]  
FROM sys.dm_resource_governor_configuration;  


CREATE FUNCTION [dbo].[UDFClassifier]()
RETURNS SYSNAME
WITH SCHEMABINDING
AS
BEGIN
  DECLARE @WorkLoadGroup AS SYSNAME

  --
  -- Set group based on login authentication info
  --
  IF (SUSER_NAME() IN ( 'US\svcwinc00084', 'us\svccrdbttbisqlp04','US\svctcmtableau', 'US\sptbittproxy', 'exawsprd','US\svccrdbttbisasp02','InformaticaETL', 'trsbidwprod', 'trsbiwebprd', 'us\svccrdbttbisqlp04', 'US\svccrdbttbisasp03', 'US\svccrdbttbisqlp01', 'US\uttdtengineering', ' US\svcespbisrsprd', 'US\svcespbisasprd', 'US\svcespbisptprd', 'US\svcespbisqlprd', 'US\svcespbisrsprd','sptwxprod') )
    SET @WorkLoadGroup = 'BatchGroup'
  ELSE
    SET @WorkLoadGroup = 'default'

  RETURN @WorkLoadGroup
END


GO
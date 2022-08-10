EXEC xp_logininfo 'domain\useraccount','all';
GO





For the entire instance:
EXECUTE AS LOGIN = ‘US\<NetworkId>’;
SELECT DISTINCT name, type 
FROM sys.login_token 
WHERE principal_id > 0;
REVERT;

For a specific database:
USE DBName;
GO
EXECUTE AS USER = ‘US\<NetworkId>’;
SELECT DISTINCT name, type 
FROM sys.user_token 
WHERE principal_id > 0;
REVERT;

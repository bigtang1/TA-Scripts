
SELECT 
    right(c.path, len(c.path)-51) as ReportPath,
	C.Name as Report_Name, 
	DS.Name AS DatasourceName
FROM 
    dbo.Catalog AS C  INNER JOIN 
     dbo.Users AS CU  ON C.CreatedByID = CU.UserID INNER JOIN 
     dbo.SecData AS SD ON C.PolicyID = SD.PolicyID AND SD.AuthType = 1 INNER JOIN 
     dbo.DataSource AS DS ON C.ItemID = DS.ItemID 
WHERE 
    DS.Name IS NOT NULL and 
	
ORDER BY 
    reportpath, c.name 

	
---


SELECT C.Name 
      ,U.UserName 
      ,R.RoleName 
      ,R.Description 
  FROM Reportserver.dbo.Users U 
  JOIN Reportserver.dbo.PolicyUserRole PUR 
    ON U.UserID = PUR.UserID 
  JOIN Reportserver.dbo.Policies P 
    ON P.PolicyID = PUR.PolicyID 
  JOIN Reportserver.dbo.Roles R 
    ON R.RoleID = PUR.RoleID 
  JOIN Reportserver.dbo.Catalog c 
    ON C.PolicyID = P.PolicyID 
 WHERE c.type = 5
ORDER BY 1


-----




 

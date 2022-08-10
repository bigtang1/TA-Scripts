--[‎3/‎19/‎2020 1:25 PM]  Thompson, Greg:  
--No Title 
CREATE TABLE #tblResults
(  [name]			nvarchar(50),
   [rows]			bigint,
   [reserved]		varchar(50),
   [reserved_int]   bigint default(0),
   [data]			varchar(50),
   [data_int]		bigint default(0),
   [index_size]		varchar(50),
   [index_size_int] bigint default(0),
   [unused]			varchar(50),
   [unused_int]		bigint default(0))
-- Populate the temp table...
EXEC sp_MSforeachtable @command1=
         "INSERT INTO #tblResults
           ([name],[rows],[reserved],[data],[index_size],[unused])
          EXEC sp_spaceused '?'"
-- Strip out the " KB" portion from the fields
UPDATE #tblResults SET
   [reserved_int] = CAST(SUBSTRING([reserved], 1, 
                    CHARINDEX(' ', [reserved])) AS bigint),
   [data_int] = CAST(SUBSTRING([data], 1, 
                     CHARINDEX(' ', [data])) AS bigint),
   [index_size_int] = CAST(SUBSTRING([index_size], 1, 
                     CHARINDEX(' ', [index_size])) AS bigint),
   [unused_int] = CAST(SUBSTRING([unused], 1, 
                     CHARINDEX(' ', [unused])) AS bigint)
-- Return the results...
SELECT * FROM #tblResults order by data_int desc
drop table #tblResults 
 

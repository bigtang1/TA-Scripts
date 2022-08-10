CREATE TABLE #SQLErrorLog
(
LogDate DATETIME
,ProcessInfo NVARCHAR(12)
,LogText NVARCHAR(3999)
)

INSERT INTO #SQLErrorLog
(
LogDate
,ProcessInfo
,LogText
)
EXEC sp_readerrorlog;

select * from #SQLErrorLog
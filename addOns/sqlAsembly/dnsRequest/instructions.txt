--https://sqlsunday.com/2013/03/03/web-requests-using-clr-proc/ 

sp_configure 'clr enabled', 1;
GO
RECONFIGURE;

GO

ALTER DATABASE myDatabase SET TRUSTWORTHY ON;

GO


USE myDatabase
GO

CREATE ASSEMBLY SqlWebRequest
FROM 'D:\vsonline\OPERAHOUSE\addOns\webRequest\webRequest\bin\Debug\webRequest.dll'
WITH PERMISSION_SET=UNSAFE;
GO


CREATE FUNCTION gen.fn_get_webrequest(
     @uri        nvarchar(max),
     @user       nvarchar(255)=NULL,
     @passwd     nvarchar(255)=NULL
)
RETURNS nvarchar(max)
AS
EXTERNAL NAME SqlWebRequest.[webRequest.Functions].GET;

GO

CREATE FUNCTION gen.fn_post_webrequest(
     @uri         nvarchar(max),
     @postdata    nvarchar(max),
     @user        nvarchar(255)=NULL,
     @passwd      nvarchar(255)=NULL
)
RETURNS nvarchar(max)
AS

EXTERNAL NAME SqlWebRequest.[webRequest.Functions].POST;

GO

PRINT dbo.fn_get_webrequest('http://quote.yahoo.com/d/quotes.csv?'+
       's=AAPL+YHOO+GOOG+GE+MSFT&f=snl1t1ghc1', DEFAULT, DEFAULT);

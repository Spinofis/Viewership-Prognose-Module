USE [ViewershipForecastDB]
GO

/****** Object:  StoredProcedure [dbo].[p_grpminute_read]    Script Date: 12.02.2019 19:27:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[p_grpminute_read]
as
begin

if OBJECT_ID('tempdb..#grpminute') is not null
drop table #grpminute

create table #grpminute
(
	AUDI_Start_Date varchar(50),
	SECO_Minute varchar(50),
	CHAN_ID varchar(50),
	TAGR_ID varchar(50),
	AUDI_GRP_Actual varchar(50),
	AUFO_GRP_Forecast varchar(50)
)

--BULK INSERT  #grpminute 
--   FROM 'D:\Inżynierka\grpminute.csv'
--   with (
--	FIELDTERMINATOR = ','    
--   ,ROWTERMINATOR = '\n'   
--   );

insert into #grpminute
SELECT * FROM OPENROWSET( BULK 'D:\Inżynierka\grpminute.csv',   
   FORMATFILE = 'D:\Inżynierka\grpminute format.fmt') AS a;



insert into GRP_source(AUDI_Start_Date,SECO_Minute,CHAN_ID,TAGR_ID,AUDI_GRP_Actual,AUFO_GRP_Forecast)
select *
from #grpminute
end
GO


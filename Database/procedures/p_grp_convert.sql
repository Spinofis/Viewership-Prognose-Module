USE [ViewershipForecastDB]
GO

/****** Object:  StoredProcedure [dbo].[p_grp_convert]    Script Date: 12.02.2019 19:27:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[p_grp_convert]
as
begin

if OBJECT_ID('tempdb..#temp_grp') is not null
	drop table #temp_grp

delete 
  from GRP_source
  where AUDI_Start_Date like '%AUDI%' or
		SECO_Minute like '%AUDI%' or
		CHAN_ID like '%AUDI%' or
		TAGR_ID like '%AUDI%' or
		SECO_Minute like '%AUDI%' or
		AUDI_GRP_Actual like '%AUDI%' or
		AUFO_GRP_Forecast like '%AUDI%' 


select 
datetimefromparts
(
	substring(AUDI_Start_Date,2,4),
	substring(AUDI_Start_Date,6,2),
	substring(AUDI_Start_Date,8,2),
	try_cast(replace(SECO_Minute,'"','') as int)/60,
    try_cast(replace(SECO_Minute,'"','') as int)%60,
	0,
	0
) as [Datetime],
try_cast(replace(CHAN_ID,'"','') as int) AS CHAN_ID,
try_cast(replace(TAGR_ID,'"','') as int) AS TAGR_ID,
try_cast(replace(AUDI_GRP_Actual,'"','') as float) AS AUDI_GRP_Actual,
try_cast(replace(AUFO_GRP_Forecast,'"','') as float) AS AUFO_GRP_Forecast
into #temp_grp
from GRP_source

insert into GRP(
    id_weather,
	date_time,
	time,
	id_chan,
	id_tagr,
	grp_actual,
	aufo_forecast

)
select
    w.id,
	date_time,
	cast(Datetime as time),
	CHAN_ID,
	TAGR_ID,
	AUDI_GRP_Actual,
	AUFO_GRP_Forecast	
from #temp_grp tmp
join Weather_aggregated w on Cast(tmp.Datetime as date)=cast(w.date_time as date)


end
GO


USE [ViewershipForecastDB]
GO

/****** Object:  StoredProcedure [dbo].[p_aggregate_weather]    Script Date: 12.02.2019 19:27:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[p_aggregate_weather]
as 
begin
	insert into Weather_aggregated
	(
	date_time,
	year,
	month,
	day,
	min_temp_cels,
    max_temp_cels,
	avg_daily_temp_cels,
	avg_daily_humidity_percentage,
	avg_daily_wind_speed_ms,
	avg_daily_cloudiness_octet
	)
select 
	date_time,
	year,
	month,
	day,
	min(min_temp_cels),
	max(max_temp_cels),
	avg(avg_daily_temp_cels),
	avg(avg_daily_humidity_percentage),
	avg(avg_daily_wind_speed_ms),
	avg(avg_daily_cloudiness_octet)
from Weather
group by Date_time,
		 Year,
		 Month,
		 Day
order by Date_time
end
GO


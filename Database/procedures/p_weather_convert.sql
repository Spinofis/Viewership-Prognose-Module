USE [ViewershipForecastDB]
GO

/****** Object:  StoredProcedure [dbo].[p_weather_convert]    Script Date: 12.02.2019 19:28:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[p_weather_convert]
as
begin

insert into Weather
(
	station_name,
	date_time,
	year,
	month,
	day,
	avg_daily_temp_cels,
	min_temp_cels,
	max_temp_cels,
	Avg_daily_humidity_percentage,
	Avg_daily_wind_speed_ms,
	Avg_daily_cloudiness_octet,
	snow_cover_cm
)
select 
	REPLACE(station_name,'"',''),
	DATETIMEFROMPARTS(REPLACE(year,'"',''),REPLACE(month,'"',''),REPLACE(day,'"',''),0,0,0,0),
	REPLACE(year,'"',''),
	REPLACE(month,'"',''),
	REPLACE(day,'"',''),
	Cast(Replace(std_temperature,'"','') as float),
	Cast(Replace(min_temperature,'"','') as float),
	Cast(Replace(max_temperature,'"','') as float),
	Cast(Replace([humidity_%],'"','') as float),
	Cast(Replace([wind_speed_m/s],'"','') as float),
	Cast(Replace(cloudiness_octets,'"','') as float),
	Cast(Replace(snow_cover_height_cm,'"','') as float)
from Weather_source


end
GO


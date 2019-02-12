USE [ViewershipForecastDB]
GO

/****** Object:  StoredProcedure [dbo].[p_weather_additional_params_read]    Script Date: 12.02.2019 19:28:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[p_weather_additional_params_read]
as
begin

if OBJECT_ID('tempdb..#files') is not null
	drop table #files

if OBJECT_ID('tempdb..##tmp_weather') is not null
	drop table ##tmp_weather

create table #files(weatherFileName varchar(100))

CREATE TABLE ##tmp_weather(
	station_code [nvarchar](50) NOT NULL,
	station_name [nvarchar](50) NOT NULL,
	[year] [nvarchar](50) NOT NULL,
	[month] [nvarchar](50) NOT NULL,
	[day] [nvarchar](50) NOT NULL,
	[avg_temp] [nvarchar](50) NOT NULL,
	[field1] [nvarchar](50) NOT NULL,
	[humidity] [nvarchar](50) NOT NULL,
	[field2] [nvarchar](50) NOT NULL,
	[wind_speed] [nvarchar](50) NOT NULL,
	[field3] [nvarchar](50) NOT NULL,
	[cloudiness] [nvarchar](50) NOT NULL,
	[field4] [nvarchar](50) NOT NULL
)


declare @weatherFileName varchar(50)
declare @execPart1 varchar(100)='BULK INSERT ##tmp_weather
	FROM   "D:\Inżynierka\2012_weather\Weather 2012 addidtional\'


declare @execPart2 varchar(100)='" WITH
		(
			FIELDTERMINATOR = '','',
			ROWTERMINATOR = ''\n'',
			Firstrow=2
		)'


insert into #files
exec xp_cmdshell 'dir /B "D:\Inżynierka\2012_weather\Weather 2012 addidtional"'



while (select count(1) from #files where weatherFileName is not null) > 0
begin
    set  @weatherFileName=( select top 1 weatherFileName  from #files )


	--print @execPart1
	--print @weatherFileName
	--print @execPart2
	declare @statement nvarchar(max)=(select concat(@execPart1,@weatherFileName,@execPart2))
	exec sp_executesql @statement

	delete #files 
	where weatherFileName=@weatherFileName

end

update Weather_source 
set [humidity_%]=tmp.humidity,
	[wind_speed_m/s]=tmp.wind_speed,
	[cloudiness_octets]=tmp.cloudiness
from Weather_source ws
join ##tmp_weather tmp on ws.station_code=tmp.station_code

end

GO


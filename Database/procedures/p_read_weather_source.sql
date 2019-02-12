USE [ViewershipForecastDB]
GO

/****** Object:  StoredProcedure [dbo].[p_read_weather_source]    Script Date: 12.02.2019 19:28:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[p_read_weather_source]
as
begin
if OBJECT_ID('tempdb..#files') is not null
	drop table #files

if OBJECT_ID('tempdb..##tmp_weather') is not null
	drop table ##tmp_weather

create table #files(weatherFileName varchar(100))

CREATE TABLE ##tmp_weather(
	[station_code] [nvarchar](50) NOT NULL,
	[station_name] [nvarchar](50) NOT NULL,
	[year] [nvarchar](50) NOT NULL,
	[month] [nvarchar](50) NOT NULL,
	[day] [nvarchar](50) NOT NULL,
	[max_temperature] [nvarchar](50) NOT NULL,
	[field1] [nvarchar](50) NOT NULL,
	[min_temperature] [nvarchar](50) NOT NULL,
	[field2] [nvarchar](50) NOT NULL,
	[std_temperature] [nvarchar](50) NOT NULL,
	[field3] [nvarchar](50) NOT NULL,
	[min_temperature_ground] [nvarchar](50) NOT NULL,
	[field4] [nvarchar](50) NOT NULL,
	[percipitation_mm] [nvarchar](50) NOT NULL,
	[field5] [nvarchar](50) NOT NULL,
	[percipitation_type] [nvarchar](50) NOT NULL,
	[snow_cover_height_cm] [varchar](50) NOT NULL,
	[field6] [nvarchar](50) NOT NULL,
)


declare @weatherFileName varchar(50)
declare @execPart1 varchar(100)='BULK INSERT ##tmp_weather
	FROM   "D:\Inżynierka\2012_weather\Weather 2012\'


declare @execPart2 varchar(100)='" WITH
		(
			FIELDTERMINATOR = '','',
			ROWTERMINATOR = ''\n'',
			Firstrow=2
		)'


insert into #files
exec xp_cmdshell 'dir /B "D:\Inżynierka\2012_weather\Weather 2012"'



while (select count(1) from #files where weatherFileName is not null) > 0
begin
    set  @weatherFileName=( select top 1 weatherFileName  from #files )



	declare @statement nvarchar(max)=(select concat(@execPart1,@weatherFileName,@execPart2))
	exec sp_executesql @statement

	insert into Weather_source
	select [station_code]
      ,[station_name]
      ,[year]
      ,[month]
      ,[day]
      ,[max_temperature]
      ,[min_temperature]
      ,[std_temperature]
      ,[min_temperature_ground]
      ,[percipitation_mm]
      ,[percipitation_type]
      ,[snow_cover_height_cm]
	  ,null
	  ,null
	  ,null
	  from ##tmp_weather

	  delete ##tmp_weather

	delete #files 
	where weatherFileName=@weatherFileName

	

end

end
GO


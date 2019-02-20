USE [master]
GO
/****** Object:  Database [ViewershipForecastDB]    Script Date: 20.02.2019 18:42:02 ******/
CREATE DATABASE [ViewershipForecastDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ViewershipForecastDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ViewershipForecastDB.mdf' , SIZE = 5906432KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ViewershipForecastDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ViewershipForecastDB_log.ldf' , SIZE = 53813248KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ViewershipForecastDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ViewershipForecastDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ViewershipForecastDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ViewershipForecastDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ViewershipForecastDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ViewershipForecastDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ViewershipForecastDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ViewershipForecastDB] SET  MULTI_USER 
GO
ALTER DATABASE [ViewershipForecastDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ViewershipForecastDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ViewershipForecastDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ViewershipForecastDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ViewershipForecastDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ViewershipForecastDB', N'ON'
GO
ALTER DATABASE [ViewershipForecastDB] SET QUERY_STORE = OFF
GO
USE [ViewershipForecastDB]
GO
/****** Object:  Table [dbo].[GRP]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRP](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_chan] [int] NULL,
	[id_tagr] [int] NULL,
	[id_weather] [int] NULL,
	[grp_actual] [float] NULL,
	[aufo_forecast] [float] NULL,
	[id_date] [int] NULL,
 CONSTRAINT [PK_GRP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Date]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Date](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date_time] [datetime] NULL,
	[date] [date] NULL,
	[half_hour_in_day] [int] NULL,
	[quarter_in_day] [int] NULL,
	[hour] [int] NULL,
	[minute_in_day] [int] NULL,
 CONSTRAINT [PK_Date] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_grp_hours]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[v_grp_hours]
as
select
	date as Date,
	hour as Hour,
	id_chan as IdChan,
	avg(grp_actual) as Grp_actual,
	avg(aufo_forecast) as Grp_foreacst 
from GRP grp
join Date dt on grp.id_date=dt.id
group by 
	date,
	hour,
	id_chan,
	grp_actual,
	aufo_forecast
GO
/****** Object:  View [dbo].[v_grp_hours_pivot]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_grp_hours_pivot]
as 

select *
from v_grp_hours
GO
/****** Object:  Table [dbo].[GRP_hours]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRP_hours](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_chan] [int] NULL,
	[id_weather] [int] NULL,
	[id_tagr] [int] NULL,
	[id_date] [int] NULL,
	[grp_actual] [float] NULL,
	[aufo_forecast] [float] NULL,
 CONSTRAINT [PK_GRP_hours] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRP_source]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRP_source](
	[AUDI_Start_Date] [varchar](50) NULL,
	[SECO_Minute] [varchar](50) NULL,
	[CHAN_ID] [varchar](50) NULL,
	[TAGR_ID] [varchar](50) NULL,
	[AUDI_GRP_Actual] [varchar](50) NULL,
	[AUFO_GRP_Forecast] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Weather]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Weather](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[station_name] [varchar](50) NULL,
	[date_time] [datetime] NULL,
	[year] [int] NULL,
	[month] [int] NULL,
	[day] [int] NULL,
	[avg_daily_temp_cels] [float] NULL,
	[min_temp_cels] [float] NULL,
	[max_temp_cels] [float] NULL,
	[avg_daily_humidity_percentage] [float] NULL,
	[avg_daily_wind_speed_ms] [float] NULL,
	[avg_daily_cloudiness_octet] [float] NULL,
	[snow_cover_cm] [float] NULL,
 CONSTRAINT [PK_Weather] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Weather_aggregated]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Weather_aggregated](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date_time] [datetime] NULL,
	[year] [int] NULL,
	[month] [int] NULL,
	[day] [int] NULL,
	[avg_daily_temp_cels] [float] NULL,
	[min_temp_cels] [float] NULL,
	[max_temp_cels] [float] NULL,
	[avg_daily_humidity_percentage] [float] NULL,
	[avg_daily_wind_speed_ms] [float] NULL,
	[avg_daily_cloudiness_octet] [float] NULL,
	[avg_snow_cover_cm] [float] NULL,
 CONSTRAINT [PK_Weather_aggregated] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Weather_source]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Weather_source](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[station_code] [nvarchar](50) NOT NULL,
	[station_name] [nvarchar](50) NOT NULL,
	[year] [nvarchar](50) NOT NULL,
	[month] [nvarchar](50) NOT NULL,
	[day] [nvarchar](50) NOT NULL,
	[max_temperature] [nvarchar](50) NOT NULL,
	[min_temperature] [nvarchar](50) NOT NULL,
	[std_temperature] [nvarchar](50) NOT NULL,
	[min_temperature_ground] [nvarchar](50) NOT NULL,
	[percipitation_mm] [nvarchar](50) NOT NULL,
	[percipitation_type] [nvarchar](50) NOT NULL,
	[snow_cover_height_cm] [varchar](50) NOT NULL,
	[humidity_%] [varchar](50) NULL,
	[wind_speed_m/s] [varchar](50) NULL,
	[cloudiness_octets] [varchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GRP]  WITH CHECK ADD  CONSTRAINT [FK_GRP_Date] FOREIGN KEY([id_date])
REFERENCES [dbo].[Date] ([id])
GO
ALTER TABLE [dbo].[GRP] CHECK CONSTRAINT [FK_GRP_Date]
GO
ALTER TABLE [dbo].[GRP]  WITH CHECK ADD  CONSTRAINT [FK_GRP_Weather_aggregated] FOREIGN KEY([id_weather])
REFERENCES [dbo].[Weather_aggregated] ([id])
GO
ALTER TABLE [dbo].[GRP] CHECK CONSTRAINT [FK_GRP_Weather_aggregated]
GO
/****** Object:  StoredProcedure [dbo].[p_aggregate_weather]    Script Date: 20.02.2019 18:42:02 ******/
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
/****** Object:  StoredProcedure [dbo].[p_grp_convert]    Script Date: 20.02.2019 18:42:02 ******/
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


delete GRP
delete Date 


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


insert into Date
(
	date_time,
	date,
	hour,
	quarter_in_day,
	minute_in_day
)
select 
	Datetime,
	CAST(Datetime as date),
	DATEPART(HOUR,Datetime),
	DATEPART(QUARTER,Datetime),
	DATEPART(HOUR,Datetime)*60+DATEPART(MINUTE,Datetime)
from #temp_grp
group by Datetime


insert into GRP(
    id_weather,
	id_date,
	id_chan,
	id_tagr,
	grp_actual,
	aufo_forecast

)
select
    w.id,
	dt.id,
	CHAN_ID,
	TAGR_ID,
	AUDI_GRP_Actual,
	AUFO_GRP_Forecast
from #temp_grp tmp
join Weather_aggregated w on Cast(tmp.Datetime as date)=cast(w.date_time as date)
join Date dt on dt.date_time=tmp.Datetime


end
GO
/****** Object:  StoredProcedure [dbo].[p_grpminute_read]    Script Date: 20.02.2019 18:42:02 ******/
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
/****** Object:  StoredProcedure [dbo].[p_insert_grp_hours]    Script Date: 20.02.2019 18:42:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_insert_grp_hours]
as 
begin

delete GRP_hours

insert into GRP_hours
(
	id_date,
	id_weather,
	id_chan,
	id_tagr,
	grp_actual,
	aufo_forecast
)
select 
	IdDate,
	IdWeather,
	IdChan,
	IdTagr,
	 Grp_actual,
	 Grp_foreacst 	
from v_grp_hours
end
GO
/****** Object:  StoredProcedure [dbo].[p_read_weather_source]    Script Date: 20.02.2019 18:42:02 ******/
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
/****** Object:  StoredProcedure [dbo].[p_weather_additional_params_read]    Script Date: 20.02.2019 18:42:02 ******/
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
/****** Object:  StoredProcedure [dbo].[p_weather_convert]    Script Date: 20.02.2019 18:42:02 ******/
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
USE [master]
GO
ALTER DATABASE [ViewershipForecastDB] SET  READ_WRITE 
GO

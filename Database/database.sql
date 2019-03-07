USE [master]
GO
/****** Object:  Database [ViewershipForecastDB]    Script Date: 07.03.2019 12:18:00 ******/
CREATE DATABASE [ViewershipForecastDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ViewershipForecastDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.BARTEK\MSSQL\DATA\ViewershipForecastDB.mdf' , SIZE = 794624KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ViewershipForecastDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.BARTEK\MSSQL\DATA\ViewershipForecastDB_log.ldf' , SIZE = 2105344KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  UserDefinedFunction [dbo].[f_p_grp_hours_pivot_get]    Script Date: 07.03.2019 12:18:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[f_p_grp_hours_pivot_get]
()
returns @pivot_grp table
(
	[date] date,
	[month] int,
	[hour] int,
	[2] float,
	[3] float,
	[4] float,
	[5] float,
	[6] float,
	[7] float,
	[8] float,
	[9] float,
	[10] float,
	[13] float,
	[14] float,
	[15] float,
	[16] float,
	[17] float,
	[18] float,
	[20] float
)
as
begin
	


insert into @pivot_grp(date,month,hour,[2],[3],[4],[5],[6],[7],[8],[9],[10],[13],[14],[15],[16],[17],[18],[20])
select 
	ch2.date,
	ch2.month,
	ch2.hour,
	ch2.grp_actual as ch2,
	ch3.grp_actual as ch3,
	ch4.grp_actual as ch4,
	ch5.grp_actual as ch5,
	ch6.grp_actual as ch6,
	ch7.grp_actual as ch7,
	ch8.grp_actual as ch8,
	ch9.grp_actual as ch9,
	ch10.grp_actual as ch10,
	ch13.grp_actual as ch13,
	ch14.grp_actual as ch14,
	ch15.grp_actual as ch15,
	ch16.grp_actual as ch16,
	ch17.grp_actual as ch17,
	ch18.grp_actual as ch18,
	ch20.grp_actual as ch20
from v_grp_hours as ch2
--ch3
join
(
	select ch3.date,ch3.hour,ch3.grp_actual
	from v_grp_hours as ch3
	where ch3.id_chan=3
)ch3 on ch3.date=ch2.date and ch3.hour=ch2.hour
--ch4
join
(
	select ch4.date,ch4.hour,ch4.grp_actual
	from v_grp_hours as ch4
	where ch4.id_chan=4
)ch4 on ch4.date=ch2.date and ch4.hour=ch2.hour
--ch5
join
(
	select ch5.date,ch5.hour,ch5.grp_actual
	from v_grp_hours as ch5
	where ch5.id_chan=5
)ch5 on ch5.date=ch2.date and ch5.hour=ch2.hour
--ch6
join
(
	select ch6.date,ch6.hour,ch6.grp_actual
	from v_grp_hours as ch6
	where ch6.id_chan=6
)ch6 on ch6.date=ch2.date and ch6.hour=ch2.hour
--ch7
join
(
	select ch7.date,ch7.hour,ch7.grp_actual
	from v_grp_hours as ch7
	where ch7.id_chan=7
)ch7 on ch7.date=ch2.date and ch7.hour=ch2.hour
--ch8
join
(
	select ch8.date,ch8.hour,ch8.grp_actual
	from v_grp_hours as ch8
	where ch8.id_chan=8
)ch8 on ch8.date=ch2.date and ch8.hour=ch2.hour
--ch9
join
(
	select ch9.date,ch9.hour,ch9.grp_actual
	from v_grp_hours as ch9
	where ch9.id_chan=9
)ch9 on ch9.date=ch2.date and ch9.hour=ch2.hour
--ch10
join
(
	select ch10.date,ch10.hour,ch10.grp_actual
	from v_grp_hours as ch10
	where ch10.id_chan=10
)ch10 on ch10.date=ch2.date and ch10.hour=ch2.hour
--ch13
join
(
	select ch13.date,ch13.hour,ch13.grp_actual
	from v_grp_hours as ch13
	where ch13.id_chan=13
)ch13 on ch13.date=ch2.date and ch13.hour=ch2.hour
--ch14
join
(
	select ch14.date,ch14.hour,ch14.grp_actual
	from v_grp_hours as ch14
	where ch14.id_chan=14
)ch14 on ch14.date=ch2.date and ch14.hour=ch2.hour
--ch15
join
(
	select ch15.date,ch15.hour,ch15.grp_actual
	from v_grp_hours as ch15
	where ch15.id_chan=15
)ch15 on ch15.date=ch2.date and ch15.hour=ch2.hour
--ch16
join
(
	select ch16.date,ch16.hour,ch16.grp_actual
	from v_grp_hours as ch16
	where ch16.id_chan=16
)ch16 on ch16.date=ch2.date and ch16.hour=ch2.hour
--ch17
join
(
	select ch17.date,ch17.hour,ch17.grp_actual
	from v_grp_hours as ch17
	where ch17.id_chan=17
)ch17 on ch17.date=ch2.date and ch17.hour=ch2.hour
--ch18
join
(
	select ch18.date,ch18.hour,ch18.grp_actual
	from v_grp_hours as ch18
	where ch18.id_chan=18
)ch18 on ch18.date=ch2.date and ch18.hour=ch2.hour
--ch20
join
(
	select ch20.date,ch20.hour,ch20.grp_actual
	from v_grp_hours as ch20
	where ch20.id_chan=20
)ch20 on ch20.date=ch2.date and ch20.hour=ch2.hour
where ch2.id_chan=2
order by date,hour



--insert into @pivot_grp
--select *
--from #pivot_grp
--where id_chan=2
--order by date,hour


return
end
GO
/****** Object:  Table [dbo].[GRP]    Script Date: 07.03.2019 12:18:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRP](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_chan] [int] NULL,
	[id_tagr] [int] NULL,
	[id_weather] [int] NULL,
	[date_time] [datetime] NULL,
	[date] [date] NULL,
	[quarter_in_day] [int] NULL,
	[hour_in_day] [int] NULL,
	[minute_in_day] [int] NULL,
	[grp_actual] [float] NULL,
	[aufo_forecast] [float] NULL,
 CONSTRAINT [PK_GRP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_grp_hours]    Script Date: 07.03.2019 12:18:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[v_grp_hours]
as
select 
	date as date,
	month(date) as month,
	hour as hour,
	id_chan as id_chan,
	avg(grp_actual) as grp_actual,
	avg(aufo_forecast) as grp_foreacst 
from GRP grp
join Date dt on grp.id_date=dt.id
group by 
	date,
	month(date),
	hour,
	id_chan
	--grp_actual,
	--aufo_forecast
GO
/****** Object:  Table [dbo].[GRP_Channels]    Script Date: 07.03.2019 12:18:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRP_Channels](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_weather] [int] NULL,
	[2] [float] NULL,
	[3] [float] NULL,
	[4] [float] NULL,
	[5] [float] NULL,
	[6] [float] NULL,
	[7] [float] NULL,
	[8] [float] NULL,
	[9] [float] NULL,
	[10] [float] NULL,
	[13] [float] NULL,
	[14] [float] NULL,
	[15] [float] NULL,
	[16] [float] NULL,
	[17] [float] NULL,
	[18] [float] NULL,
	[20] [float] NULL,
	[date_time] [datetime] NULL,
	[date] [date] NULL,
	[hour_in_day] [int] NULL,
	[quarter_in_day] [int] NULL,
	[minute_in_day] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[f_data_to_learn_get]    Script Date: 07.03.2019 12:18:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[f_data_to_learn_get]
(@months varchar(100))
returns table
as
return
(
	select 
		dateadd(HOUR,hour_in_day,cast(date as datetime)) as date_time,
		sum([2]) as [2],
		sum([3]) as [3],
		sum([4]) as [4],
		sum([5]) as [5],
		sum([6]) as [6],
		sum([7]) as [7],
		sum([8]) as [8],
		sum([9]) as [9],
		sum([10]) as [10],
		sum([13]) as [13],
		sum([14]) as [14],
		sum([15]) as [15],
		sum([16]) as [16],
		sum([17]) as [17],
		sum([18]) as [18],
		sum([20]) as [20]
	from GRP_Channels grp
	--join Date d on grp.id_date=d.id
	where month(date) in (select cast(value as int) from string_split(@months,','))
	group by date,hour_in_day
);
GO
/****** Object:  Table [dbo].[GRP_source]    Script Date: 07.03.2019 12:18:00 ******/
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
/****** Object:  Table [dbo].[Weather]    Script Date: 07.03.2019 12:18:00 ******/
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
/****** Object:  Table [dbo].[Weather_aggregated]    Script Date: 07.03.2019 12:18:00 ******/
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
/****** Object:  Table [dbo].[Weather_source]    Script Date: 07.03.2019 12:18:00 ******/
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
ALTER TABLE [dbo].[GRP]  WITH CHECK ADD  CONSTRAINT [FK_GRP_Weather_aggregated] FOREIGN KEY([id_weather])
REFERENCES [dbo].[Weather_aggregated] ([id])
GO
ALTER TABLE [dbo].[GRP] CHECK CONSTRAINT [FK_GRP_Weather_aggregated]
GO
/****** Object:  StoredProcedure [dbo].[p_aggregate_weather]    Script Date: 07.03.2019 12:18:00 ******/
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
/****** Object:  StoredProcedure [dbo].[p_grp_channels_insert]    Script Date: 07.03.2019 12:18:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_grp_channels_insert]
as
begin

delete GRP_Channels


insert into GRP_Channels(date_time,date,hour_in_day,quarter_in_day,minute_in_day,id_weather,[2])
select date_time,date,hour_in_day,quarter_in_day,minute_in_day,id_weather,grp_actual
from GRP
where id_chan=2


update GRP_Channels 
set GRP_Channels.[3]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=3

update GRP_Channels 
set GRP_Channels.[4]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=4

update GRP_Channels 
set GRP_Channels.[5]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=5

update GRP_Channels 
set GRP_Channels.[6]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=6

update GRP_Channels 
set GRP_Channels.[7]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=7

update GRP_Channels 
set GRP_Channels.[8]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=8

update GRP_Channels 
set GRP_Channels.[9]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=9

update GRP_Channels 
set GRP_Channels.[10]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=10

update GRP_Channels 
set GRP_Channels.[13]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=13

update GRP_Channels 
set GRP_Channels.[14]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=14

update GRP_Channels 
set GRP_Channels.[15]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=15

update GRP_Channels 
set GRP_Channels.[16]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=16

update GRP_Channels 
set GRP_Channels.[17]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=17

update GRP_Channels 
set GRP_Channels.[18]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=18

update GRP_Channels 
set GRP_Channels.[20]=GRP.grp_actual,
	GRP_Channels.date=GRP.date,
	GRP_Channels.hour_in_day=GRP.hour_in_day,
	GRP_Channels.quarter_in_day=GRP.quarter_in_day,
	GRP_Channels.minute_in_day=GRP.minute_in_day
from GRP_Channels 
join GRP on GRP.date_time=GRP_Channels.date_time
where id_chan=20





end





GO
/****** Object:  StoredProcedure [dbo].[p_grp_convert]    Script Date: 07.03.2019 12:18:00 ******/
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
  where AUDI_Start_Date like '%AUDI%' or AUDI_Start_Date like '""' or
		SECO_Minute like '%AUDI%' or SECO_Minute like '""' or
		CHAN_ID like '%AUDI%' or CHAN_ID like '""' or
		TAGR_ID like '%AUDI%' or TAGR_ID like '""' or
		SECO_Minute like '%AUDI%' or SECO_Minute like '""' or
		AUDI_GRP_Actual like '%AUDI%' or AUDI_GRP_Actual like '""' or
		AUFO_GRP_Forecast like '%AUDI%' or  AUFO_GRP_Forecast like '""' 
		 


delete GRP
--delete Date 


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


--insert into Date
--(
--	date_time,
--	date,
--	hour,
--	quarter_in_day,
--	minute_in_day
--)
--select 
--	Datetime,
--	CAST(Datetime as date),
--	DATEPART(HOUR,Datetime),
--	DATEPART(QUARTER,Datetime),
--	DATEPART(HOUR,Datetime)*60+DATEPART(MINUTE,Datetime)
--from #temp_grp
--group by Datetime


insert into GRP(
    id_weather,
	id_chan,
	id_tagr,
	date_time,
	date,
	hour_in_day,
	quarter_in_day,
	minute_in_day,
	grp_actual,
	aufo_forecast

)
select
    w.id,
	CHAN_ID,
	TAGR_ID,
	Datetime,
	CAST(Datetime as date),
	DATEPART(HOUR,Datetime),
	DATEPART(QUARTER,Datetime),
	DATEPART(HOUR,Datetime)*60+DATEPART(MINUTE,Datetime),
	AUDI_GRP_Actual,
	AUFO_GRP_Forecast
from #temp_grp tmp
join Weather_aggregated w on Cast(tmp.Datetime as date)=cast(w.date_time as date)


end
GO
/****** Object:  StoredProcedure [dbo].[p_grpminute_read]    Script Date: 07.03.2019 12:18:00 ******/
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
/****** Object:  StoredProcedure [dbo].[p_read_weather_source]    Script Date: 07.03.2019 12:18:00 ******/
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
/****** Object:  StoredProcedure [dbo].[p_weather_additional_params_read]    Script Date: 07.03.2019 12:18:00 ******/
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
/****** Object:  StoredProcedure [dbo].[p_weather_convert]    Script Date: 07.03.2019 12:18:00 ******/
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

USE [master]
GO
/****** Object:  Database [ViewershipForecastDBRestored]    Script Date: 16.05.2019 21:01:25 ******/
CREATE DATABASE [ViewershipForecastDBRestored]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ViewershipForecastDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.BARTEK\MSSQL\DATA\ViewershipForecastDBRestored.mdf' , SIZE = 925696KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ViewershipForecastDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.BARTEK\MSSQL\DATA\ViewershipForecastDBRestored_log.ldf' , SIZE = 2433024KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ViewershipForecastDBRestored].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET ARITHABORT OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET RECOVERY FULL 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET  MULTI_USER 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ViewershipForecastDBRestored', N'ON'
GO
ALTER DATABASE [ViewershipForecastDBRestored] SET QUERY_STORE = OFF
GO
USE [ViewershipForecastDBRestored]
GO
/****** Object:  Schema [result]    Script Date: 16.05.2019 21:01:25 ******/
CREATE SCHEMA [result]
GO
/****** Object:  Table [dbo].[GRP]    Script Date: 16.05.2019 21:01:25 ******/
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
/****** Object:  View [dbo].[v_grp_hours]    Script Date: 16.05.2019 21:01:25 ******/
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
/****** Object:  Table [dbo].[GRP_Channels]    Script Date: 16.05.2019 21:01:25 ******/
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
/****** Object:  UserDefinedFunction [dbo].[f_data_to_learn_hours_get]    Script Date: 16.05.2019 21:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[f_data_to_learn_hours_get]
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
		sum([20]) as [20],
		datepart(WEEKDAY,date) as week_day,
		hour_in_day as hour
	from GRP_Channels grp
	where month(date) in (select cast(value as int) from string_split(@months,',')) 
	group by date,datepart(WEEKDAY,date),hour_in_day
);
GO
/****** Object:  Table [dbo].[Program_channels]    Script Date: 16.05.2019 21:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program_channels](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date_time] [datetime] NULL,
	[2_prg_id] [int] NULL,
	[3_prg_id] [int] NULL,
	[4_prg_id] [int] NULL,
	[5_prg_id] [int] NULL,
	[6_prg_id] [int] NULL,
	[7_prg_id] [int] NULL,
	[8_prg_id] [int] NULL,
	[9_prg_id] [int] NULL,
	[10_prg_id] [int] NULL,
	[13_prg_id] [int] NULL,
	[14_prg_id] [int] NULL,
	[15_prg_id] [int] NULL,
	[16_prg_id] [int] NULL,
	[17_prg_id] [int] NULL,
	[18_prg_id] [int] NULL,
	[20_prg_id] [int] NULL,
	[2_prg_type_id] [int] NULL,
	[3_prg_type_id] [int] NULL,
	[4_prg_type_id] [int] NULL,
	[5_prg_type_id] [int] NULL,
	[6_prg_type_id] [int] NULL,
	[7_prg_type_id] [int] NULL,
	[8_prg_type_id] [int] NULL,
	[9_prg_type_id] [int] NULL,
	[10_prg_type_id] [int] NULL,
	[13_prg_type_id] [int] NULL,
	[14_prg_type_id] [int] NULL,
	[15_prg_type_id] [int] NULL,
	[16_prg_type_id] [int] NULL,
	[17_prg_type_id] [int] NULL,
	[18_prg_type_id] [int] NULL,
	[20_prg_type_id] [int] NULL,
	[2_prg_base_type_id] [int] NULL,
	[3_prg_base_type_id] [int] NULL,
	[4_prg_base_type_id] [int] NULL,
	[5_prg_base_type_id] [int] NULL,
	[6_prg_base_type_id] [int] NULL,
	[7_prg_base_type_id] [int] NULL,
	[8_prg_base_type_id] [int] NULL,
	[9_prg_base_type_id] [int] NULL,
	[10_prg_base_type_id] [int] NULL,
	[13_prg_base_type_id] [int] NULL,
	[14_prg_base_type_id] [int] NULL,
	[15_prg_base_type_id] [int] NULL,
	[16_prg_base_type_id] [int] NULL,
	[17_prg_base_type_id] [int] NULL,
	[18_prg_base_type_id] [int] NULL,
	[20_prg_base_type_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Weather_aggregated]    Script Date: 16.05.2019 21:01:25 ******/
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
/****** Object:  UserDefinedFunction [dbo].[f_data_to_learn_minute_get]    Script Date: 16.05.2019 21:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[f_data_to_learn_minute_get]
(@months varchar(100))
returns table
as
return
(
		select 
			grp.date_time,
			[2],
			[3],
			[4],
			[5],
			[6],
			[7],
			[8],
			[9],
			[10],
			[13],
			[14],
			[15],
			[16],
			[17],
			[18],
			[20],
			prg_ch.[2_prg_id],
			prg_ch.[3_prg_id],
			prg_ch.[4_prg_id],
			prg_ch.[5_prg_id],
			prg_ch.[6_prg_id],
			prg_ch.[7_prg_id],
			prg_ch.[8_prg_id],
			prg_ch.[9_prg_id],
			prg_ch.[10_prg_id],
			prg_ch.[13_prg_id],
			prg_ch.[14_prg_id],
			prg_ch.[15_prg_id],
			prg_ch.[16_prg_id],
			prg_ch.[17_prg_id],
			prg_ch.[18_prg_id],
			prg_ch.[20_prg_id],
			prg_ch.[2_prg_type_id],
			prg_ch.[3_prg_type_id],
			prg_ch.[4_prg_type_id],
			prg_ch.[5_prg_type_id],
			prg_ch.[6_prg_type_id],
			prg_ch.[7_prg_type_id],
			prg_ch.[8_prg_type_id],
			prg_ch.[9_prg_type_id],
			prg_ch.[10_prg_type_id],
			prg_ch.[13_prg_type_id],
			prg_ch.[14_prg_type_id],
			prg_ch.[15_prg_type_id],
			prg_ch.[16_prg_type_id],
			prg_ch.[17_prg_type_id],
			prg_ch.[18_prg_type_id],
			prg_ch.[20_prg_type_id],
			prg_ch.[2_prg_base_type_id],
			prg_ch.[3_prg_base_type_id],
			prg_ch.[4_prg_base_type_id],
			prg_ch.[5_prg_base_type_id],
			prg_ch.[6_prg_base_type_id],
			prg_ch.[7_prg_base_type_id],
			prg_ch.[8_prg_base_type_id],
			prg_ch.[9_prg_base_type_id],
			prg_ch.[10_prg_base_type_id],
			prg_ch.[13_prg_base_type_id],
			prg_ch.[14_prg_base_type_id],
			prg_ch.[15_prg_base_type_id],
			prg_ch.[16_prg_base_type_id],
			prg_ch.[17_prg_base_type_id],
			prg_ch.[18_prg_base_type_id],
			prg_ch.[20_prg_base_type_id],
			we.max_temp_cels,
			we.min_temp_cels,
			we.avg_daily_cloudiness_octet,
			we.avg_daily_humidity_percentage,
			we.avg_daily_temp_cels,
			we.avg_daily_wind_speed_ms,
			we.avg_snow_cover_cm,
			datepart(WEEKDAY,date) as week_day,
			hour_in_day as hour
		from GRP_Channels grp
		join Weather_aggregated we on grp.date=cast(we.date_time as date)
		join Program_channels prg_ch on grp.date_time=prg_ch.date_time
		where month(date) in (select cast(value as int) from string_split(@months,',')) 
)
GO
/****** Object:  Table [dbo].[Channels]    Script Date: 16.05.2019 21:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Channels](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[name] [varchar](max) NULL,
	[program_url] [varchar](max) NULL,
 CONSTRAINT [PK_Channels] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRP_source]    Script Date: 16.05.2019 21:01:25 ******/
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
/****** Object:  Table [dbo].[Program]    Script Date: 16.05.2019 21:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](max) NULL,
 CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program_tv]    Script Date: 16.05.2019 21:01:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program_tv](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_prg_type] [int] NULL,
	[id_chan] [int] NULL,
	[name] [varchar](max) NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
 CONSTRAINT [PK_ProgramtTv] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program_type]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[id_program_type_base] [int] NULL,
 CONSTRAINT [PK_Program_type] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program_type_base]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program_type_base](
	[id] [int] NOT NULL,
	[name] [varchar](100) NULL,
 CONSTRAINT [PK_Program_type_base] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Weather]    Script Date: 16.05.2019 21:01:26 ******/
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
/****** Object:  Table [dbo].[Weather_source]    Script Date: 16.05.2019 21:01:26 ******/
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
/****** Object:  Table [result].[Granulation]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [result].[Granulation](
	[id] [int] NOT NULL,
	[name] [varchar](50) NULL,
 CONSTRAINT [PK_Granulation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [result].[Method_type]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [result].[Method_type](
	[id] [int] NOT NULL,
	[name] [varchar](50) NULL,
 CONSTRAINT [PK_Method type] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [result].[Result]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [result].[Result](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_method_type] [int] NULL,
	[id_granulation] [int] NULL,
	[id_chan] [int] NULL,
	[rmse] [float] NULL,
	[date_time] [datetime] NULL,
	[month_number] [int] NULL,
 CONSTRAINT [PK_Result] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [result].[Sarima_config]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [result].[Sarima_config](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_granulation] [int] NULL,
	[rmse] [float] NULL,
	[p_trend] [int] NULL,
	[d_trend] [int] NULL,
	[q_trend] [int] NULL,
	[trend] [varchar](2) NULL,
	[P_season] [int] NULL,
	[D_season] [int] NULL,
	[Q_season] [int] NULL,
	[season] [int] NULL,
 CONSTRAINT [PK_Sarima_config] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [result].[Test_stationarity]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [result].[Test_stationarity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[test_statistic] [float] NULL,
	[p-value] [float] NULL,
	[cv1] [float] NULL,
	[cv5] [float] NULL,
	[cv10] [float] NULL,
	[id_chan] [int] NULL,
 CONSTRAINT [PK_Test_stationarity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [result].[Result] ADD  DEFAULT (getdate()) FOR [date_time]
GO
ALTER TABLE [dbo].[GRP]  WITH CHECK ADD  CONSTRAINT [FK_GRP_Weather_aggregated] FOREIGN KEY([id_weather])
REFERENCES [dbo].[Weather_aggregated] ([id])
GO
ALTER TABLE [dbo].[GRP] CHECK CONSTRAINT [FK_GRP_Weather_aggregated]
GO
ALTER TABLE [dbo].[Program_tv]  WITH CHECK ADD  CONSTRAINT [FK_Program_tv_Channels] FOREIGN KEY([id_chan])
REFERENCES [dbo].[Channels] ([id])
GO
ALTER TABLE [dbo].[Program_tv] CHECK CONSTRAINT [FK_Program_tv_Channels]
GO
ALTER TABLE [dbo].[Program_tv]  WITH CHECK ADD  CONSTRAINT [FK_Program_tv_Program_type] FOREIGN KEY([id_prg_type])
REFERENCES [dbo].[Program_type] ([id])
GO
ALTER TABLE [dbo].[Program_tv] CHECK CONSTRAINT [FK_Program_tv_Program_type]
GO
ALTER TABLE [result].[Result]  WITH CHECK ADD  CONSTRAINT [FK_Result_Granulation] FOREIGN KEY([id_granulation])
REFERENCES [result].[Granulation] ([id])
GO
ALTER TABLE [result].[Result] CHECK CONSTRAINT [FK_Result_Granulation]
GO
ALTER TABLE [result].[Result]  WITH CHECK ADD  CONSTRAINT [FK_Result_Method_type] FOREIGN KEY([id_method_type])
REFERENCES [result].[Method_type] ([id])
GO
ALTER TABLE [result].[Result] CHECK CONSTRAINT [FK_Result_Method_type]
GO
ALTER TABLE [result].[Sarima_config]  WITH CHECK ADD  CONSTRAINT [FK_Sarima_config_Granulation] FOREIGN KEY([id_granulation])
REFERENCES [result].[Granulation] ([id])
GO
ALTER TABLE [result].[Sarima_config] CHECK CONSTRAINT [FK_Sarima_config_Granulation]
GO
/****** Object:  StoredProcedure [dbo].[p_aggregate_weather]    Script Date: 16.05.2019 21:01:26 ******/
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
/****** Object:  StoredProcedure [dbo].[p_channel_get]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_channel_get]
as
begin
	select ch.id as id_chan,ch.name
	from Channels ch
	join Grp on Grp.id_chan=ch.id
	group by ch.id,ch.name
	order by ch.id
end
GO
/****** Object:  StoredProcedure [dbo].[p_channels_read]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_channels_read]
as
begin

declare @docHandle int
declare @xml xml

select @xml=BulkColumn
from 
openrowset(bulk 'C:\Bieżące projekty (szkoła nauka)\Viewership-Prognose-Module\channels.xml',single_blob) as t1

exec sp_xml_preparedocument @docHandle output, @xml

delete Channels
dbcc checkident('Channels',reseed,1)

insert into Channels(name)
select [Name] 
from 
openxml(@docHandle,'/document/row',2)
with
(
	[Name] varchar(50)
)

end
GO
/****** Object:  StoredProcedure [dbo].[p_data_to_learn_minute_get]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[p_data_to_learn_minute_get]
(
	@start int,
	@length int
)
as
begin
	if object_id('tempdb..#tmp') is not null
		drop table #tmp

	select 
		row_number() over(order by date_time) as no,
		date_time,
		[2],
		[3],
		[4],
		[5],
		[6],
		[7],
		[8],
		[9],
		[10],
		[13],
		[14],
		[15],
		[16],
		[17],
		[18],
		[20],
		datepart(WEEKDAY,date) as week_day,
		hour_in_day as hour
	into #tmp
	from GRP_Channels grp

	select *
	from #tmp
	where no>=@start and no<@length
	order by no
end
GO
/****** Object:  StoredProcedure [dbo].[p_get_data_to_learn_minute]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[p_get_data_to_learn_minute]
(
	@start int,
	@length int
)
as
begin
	if object_id('tempdb..#sub_result') is not null
		drop table #sub_result

	select 
		row_number() over (order by date_time) as [no],
		date_time as date_time,
		([2]) as [2],
		([3]) as [3],
		([4]) as [4],
		([5]) as [5],
		([6]) as [6],
		([7]) as [7],
		([8]) as [8],
		([9]) as [9],
		([10]) as [10],
		([13]) as [13],
		([14]) as [14],
		([15]) as [15],
		([16]) as [16],
		([17]) as [17],
		([18]) as [18],
		([20]) as [20],
		datepart(WEEKDAY,date) as week_day,
		hour_in_day as hour
	into #sub_result
	from GRP_Channels grp

	select *
	from #sub_result
	where [no]>=@start and [no]<@start+@length
	order by [no]
end
GO
/****** Object:  StoredProcedure [dbo].[p_grp_channels_insert]    Script Date: 16.05.2019 21:01:26 ******/
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
/****** Object:  StoredProcedure [dbo].[p_grp_convert]    Script Date: 16.05.2019 21:01:26 ******/
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
/****** Object:  StoredProcedure [dbo].[p_grpminute_read]    Script Date: 16.05.2019 21:01:26 ******/
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
/****** Object:  StoredProcedure [dbo].[p_program_channels_insert]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_program_channels_insert]
as
begin

insert into Program_channels(date_time,[2_prg_id],[2_prg_type_id],[2_prg_base_type_id])
select grp.date_time,prg.id,prgt.id,prgt.id_program_type_base
from GRP grp
join Program_tv prg_tv on grp.id_chan=prg_tv.id_chan and
		 grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=2

update Program_channels
set [3_prg_id]=prg.id,[3_prg_type_id]=prgt.id,[3_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=3

update Program_channels
set [4_prg_id]=prg.id,[4_prg_type_id]=prgt.id,[4_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=4

update Program_channels
set [5_prg_id]=prg.id,[5_prg_type_id]=prgt.id,[5_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=5

update Program_channels
set [6_prg_id]=prg.id,[6_prg_type_id]=prgt.id,[6_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=6

update Program_channels
set [7_prg_id]=prg.id,[7_prg_type_id]=prgt.id,[7_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=7

update Program_channels
set [8_prg_id]=prg.id,[8_prg_type_id]=prgt.id,[8_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=8

update Program_channels
set [9_prg_id]=prg.id,[9_prg_type_id]=prgt.id,[9_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=9

update Program_channels
set [10_prg_id]=prg.id,[10_prg_type_id]=prgt.id,[10_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=10

update Program_channels
set [13_prg_id]=prg.id,[13_prg_type_id]=prgt.id,[13_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=13

update Program_channels
set [14_prg_id]=prg.id,[14_prg_type_id]=prgt.id,[14_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=14

update Program_channels
set [15_prg_id]=prg.id,[15_prg_type_id]=prgt.id,[15_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=15

update Program_channels
set [16_prg_id]=prg.id,[16_prg_type_id]=prgt.id,[16_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=16

update Program_channels
set [17_prg_id]=prg.id,[17_prg_type_id]=prgt.id,[17_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=17

update Program_channels
set [18_prg_id]=prg.id,[18_prg_type_id]=prgt.id,[18_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=18

update Program_channels
set [20_prg_id]=prg.id,[20_prg_type_id]=prgt.id,[20_prg_base_type_id]=prgt.id_program_type_base
from Program_channels prgch
join GRP grp on grp.date_time=prgch.date_time
join Program_tv prg_tv on prg_tv.id_chan=grp.id_chan and
		grp.date_time between prg_tv.start_date and dateadd(MINUTE,-1,prg_tv.end_date)
join Program_type prgt on prgt.id=prg_tv.id_prg_type
join Program prg on prg.name=prg_tv.name
where grp.id_chan=20

end
GO
/****** Object:  StoredProcedure [dbo].[p_program_insert]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[p_program_insert]
as
begin
	insert into Program(name)
	select distinct name
	from Program_tv
end
GO
/****** Object:  StoredProcedure [dbo].[p_read_weather_source]    Script Date: 16.05.2019 21:01:26 ******/
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
/****** Object:  StoredProcedure [dbo].[p_result_compare_get]    Script Date: 16.05.2019 21:01:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_result_compare_get]
as 
begin

if object_id('tempdb..#week_ago') is not null
	drop table #week_ago

if object_id('tempdb..#sarima') is not null
	drop table #sarima

select id_chan,rmse
into #week_ago
from result.Result
where id_method_type=1

select id_chan,rmse
into #sarima
from result.Result
where id_method_type=4

--select * from #week_ago
--select * from #sarima

select 
	ch.name as channel,
	cast( round((w.rmse-res.rmse)/w.rmse*100,2) as varchar(max))+'%' as difference_week_ago_method,
	cast(round((sar.rmse-res.rmse)/sar.rmse*100,2) as varchar(max))+'%' as difference_sarima_ago_method
from result.Result res
join #week_ago w on w.id_chan=res.id_chan
join #sarima sar on sar.id_chan=res.id_chan
join Channels ch on ch.id=res.id_chan
where id_method_type=7

end
GO
/****** Object:  StoredProcedure [dbo].[p_weather_additional_params_read]    Script Date: 16.05.2019 21:01:26 ******/
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
/****** Object:  StoredProcedure [dbo].[p_weather_convert]    Script Date: 16.05.2019 21:01:26 ******/
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
ALTER DATABASE [ViewershipForecastDBRestored] SET  READ_WRITE 
GO

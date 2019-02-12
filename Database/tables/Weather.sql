USE [ViewershipForecastDB]
GO

/****** Object:  Table [dbo].[Weather]    Script Date: 12.02.2019 19:26:16 ******/
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


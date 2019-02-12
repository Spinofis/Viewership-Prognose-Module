USE [ViewershipForecastDB]
GO

/****** Object:  Table [dbo].[Weather_source]    Script Date: 12.02.2019 19:26:35 ******/
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


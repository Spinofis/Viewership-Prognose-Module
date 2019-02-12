USE [ViewershipForecastDB]
GO

/****** Object:  Table [dbo].[GRP]    Script Date: 12.02.2019 19:26:00 ******/
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
	[time] [time](7) NULL,
	[grp_actual] [float] NULL,
	[aufo_forecast] [float] NULL,
 CONSTRAINT [PK_GRP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[GRP]  WITH CHECK ADD  CONSTRAINT [FK_GRP_Weather_aggregated] FOREIGN KEY([id_weather])
REFERENCES [dbo].[Weather_aggregated] ([id])
GO

ALTER TABLE [dbo].[GRP] CHECK CONSTRAINT [FK_GRP_Weather_aggregated]
GO


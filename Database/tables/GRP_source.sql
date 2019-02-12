USE [ViewershipForecastDB]
GO

/****** Object:  Table [dbo].[GRP_source]    Script Date: 12.02.2019 19:26:08 ******/
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


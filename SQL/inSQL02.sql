USE [tea01]
GO
/****** Object:  Table [dbo].[ItemTopping]    Script Date: 26/11/2020 1:50:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemTopping](
	[ItemId] [int] NOT NULL,
	[ToppingId] [varchar](10) NOT NULL,
	[BillId] [varchar](10) NOT NULL,
	[DrinkId] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC,
	[ToppingId] ASC,
	[BillId] ASC,
	[DrinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ItemTopping]  WITH CHECK ADD FOREIGN KEY([ToppingId])
REFERENCES [dbo].[Toppings] ([ToppingId])
GO
ALTER TABLE [dbo].[ItemTopping]  WITH CHECK ADD FOREIGN KEY([ItemId], [BillId], [DrinkId])
REFERENCES [dbo].[Items] ([ItemId], [BillId], [DrinkId])
GO

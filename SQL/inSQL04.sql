USE [tea01]
GO
/****** Object:  Table [dbo].[ItemTopping]    Script Date: 26/11/2020 1:54:27 PM ******/
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
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (8, N'11', N'231131458', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'10', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'11', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'4', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'5', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'6', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (11, N'11', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (11, N'2', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (11, N'5', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (12, N'10', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (12, N'11', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (12, N'2', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (13, N'1', N'231133324', N'05')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (13, N'10', N'231133324', N'05')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (13, N'4', N'231133324', N'05')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (14, N'10', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (14, N'11', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (14, N'4', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (15, N'10', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (18, N'11', N'23113487', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (18, N'5', N'23113487', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (19, N'2', N'231135316', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (21, N'11', N'24112165', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (22, N'6', N'24112165', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (23, N'4', N'24112165', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (24, N'6', N'241121725', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (25, N'2', N'24113224', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (26, N'1', N'24113458', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (26, N'2', N'24113458', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (27, N'9', N'241132821', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (28, N'5', N'241134047', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (29, N'5', N'241134150', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (30, N'2', N'241134339', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (31, N'5', N'24113480', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (32, N'3', N'241135040', N'05')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (33, N'10', N'241143248', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (34, N'10', N'241143317', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (35, N'11', N'241143317', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (36, N'10', N'241143426', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (37, N'11', N'241143426', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (38, N'5', N'25117221', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (39, N'10', N'261113951', N'04')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (41, N'11', N'261113951', N'6')
ALTER TABLE [dbo].[ItemTopping]  WITH CHECK ADD FOREIGN KEY([ToppingId])
REFERENCES [dbo].[Toppings] ([ToppingId])
GO
ALTER TABLE [dbo].[ItemTopping]  WITH CHECK ADD FOREIGN KEY([ItemId], [BillId], [DrinkId])
REFERENCES [dbo].[Items] ([ItemId], [BillId], [DrinkId])
GO

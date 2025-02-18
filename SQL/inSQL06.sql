USE [master]
GO
/****** Object:  Database [tea01]    Script Date: 26/11/2020 2:58:12 PM ******/
CREATE DATABASE [tea01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tea01', FILENAME = N'G:\MSSQL12.MSSQLSERVER\MSSQL\DATA\tea01.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'tea01_log', FILENAME = N'G:\MSSQL12.MSSQLSERVER\MSSQL\DATA\tea01_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [tea01] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tea01].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [tea01] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tea01] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tea01] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tea01] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tea01] SET ARITHABORT OFF 
GO
ALTER DATABASE [tea01] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [tea01] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tea01] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tea01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tea01] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tea01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tea01] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tea01] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tea01] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tea01] SET  ENABLE_BROKER 
GO
ALTER DATABASE [tea01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tea01] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tea01] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [tea01] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tea01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tea01] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tea01] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [tea01] SET RECOVERY FULL 
GO
ALTER DATABASE [tea01] SET  MULTI_USER 
GO
ALTER DATABASE [tea01] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tea01] SET DB_CHAINING OFF 
GO
ALTER DATABASE [tea01] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tea01] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [tea01] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'tea01', N'ON'
GO
USE [tea01]
GO
/****** Object:  UserDefinedFunction [dbo].[getAmountResourceDrink]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAmountResourceDrink](@idResource varchar(10), @idBill varchar(10)) RETURNS INT AS
BEGIN
	DECLARE @res int
	SELECT @res = ISNULL(Drink_Resource.Amount,0) FROM Bills INNER JOIN Items ON Items.BillId = Bills.BillId INNER JOIN Drink_Resource On Drink_Resource.DrinkId = Items.DrinkId WHERE Items.BillId = @idBill AND Drink_Resource.ResourceId = @idResource
	RETURN @res
END

GO
/****** Object:  UserDefinedFunction [dbo].[getAmountResourceTopping]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAmountResourceTopping](@idResource varchar(10), @idBill varchar(10)) RETURNS INT AS 
BEGIN
	DECLARE @res int
	SELECT @res = ISNULL(Topping_Resource.Amount,0) FROM Items INNER JOIN ItemTopping ON ItemTopping.ItemId = Items.ItemId INNER JOIN Toppings ON Toppings.ToppingId = ItemTopping.ToppingId INNER JOIN Topping_Resource ON Topping_Resource.ToppingId = Toppings.ToppingId INNER JOIN Resources ON Resources.ResourceId = Topping_Resource.ResourceId WHERE Items.BillId = @idBill AND Resources.ResourceId = @idResource
	RETURN @res

END

GO
/****** Object:  Table [dbo].[Bills]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bills](
	[BillId] [varchar](10) NOT NULL,
	[OrderTimeStart] [datetime] NOT NULL CONSTRAINT [DF__Bills__OrderTime__37A5467C]  DEFAULT (NULL),
	[Payments] [varchar](10) NULL CONSTRAINT [DF__Bills__Payments__38996AB5]  DEFAULT (NULL),
	[TableId] [varchar](10) NULL CONSTRAINT [DF__Bills__TableId__398D8EEE]  DEFAULT (NULL),
	[Total] [int] NULL CONSTRAINT [DF__Bills__Total__3A81B327]  DEFAULT (NULL),
	[OrderTimeEnd] [datetime] NULL CONSTRAINT [DF__Bills__OrderTime__3B75D760]  DEFAULT (NULL),
	[UserName] [varchar](50) NULL CONSTRAINT [DF__Bills__UserName__3C69FB99]  DEFAULT (NULL),
	[PhoneNumber] [varchar](10) NULL CONSTRAINT [DF__Bills__PhoneNumb__3D5E1FD2]  DEFAULT (NULL),
	[CodeVoucher] [nvarchar](10) NULL,
 CONSTRAINT [PK__Bills__11F2FC6A51D30A39] PRIMARY KEY CLUSTERED 
(
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[PhoneNumber] [varchar](10) NOT NULL,
	[FullName] [nvarchar](100) NULL CONSTRAINT [DF__Customer__FullNa__2F10007B]  DEFAULT (NULL),
	[Address] [nvarchar](100) NULL CONSTRAINT [DF__Customer__Addres__300424B4]  DEFAULT (NULL),
	[Level] [int] NULL CONSTRAINT [DF__Customer__Level__30F848ED]  DEFAULT (NULL),
 CONSTRAINT [PK__Customer__85FB4E39FEA20E72] PRIMARY KEY CLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Drink_Resource]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Drink_Resource](
	[ResourceId] [varchar](10) NOT NULL,
	[DrinkId] [varchar](10) NOT NULL,
	[Amount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResourceId] ASC,
	[DrinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Drinks]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Drinks](
	[DrinkId] [varchar](10) NOT NULL,
	[DrinkName] [nvarchar](100) NULL CONSTRAINT [DF__Drinks__DrinkNam__4316F928]  DEFAULT (NULL),
	[Price] [int] NULL CONSTRAINT [DF__Drinks__Price__440B1D61]  DEFAULT (NULL),
	[Image] [varchar](100) NULL CONSTRAINT [DF__Drinks__Image__44FF419A]  DEFAULT (NULL),
	[Icon] [varchar](100) NULL CONSTRAINT [DF__Drinks__Icon__45F365D3]  DEFAULT (NULL),
	[DrinkTypeId] [varchar](10) NULL CONSTRAINT [DF__Drinks__DrinkTyp__46E78A0C]  DEFAULT (NULL),
 CONSTRAINT [PK__Drinks__C094D3E854BC2ECC] PRIMARY KEY CLUSTERED 
(
	[DrinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DrinkTypes]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DrinkTypes](
	[DrinkTypeId] [varchar](10) NOT NULL,
	[DrinkTypeName] [nvarchar](100) NULL CONSTRAINT [DF__DrinkType__Drink__108B795B]  DEFAULT (NULL),
 CONSTRAINT [PK__DrinkTyp__F6D6B765393C514E] PRIMARY KEY CLUSTERED 
(
	[DrinkTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Items]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[Amount] [int] NULL DEFAULT (NULL),
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[BillId] [varchar](10) NOT NULL,
	[DrinkId] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC,
	[BillId] ASC,
	[DrinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemTopping]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemTopping](
	[IdItemTopping] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NOT NULL,
	[ToppingId] [varchar](10) NOT NULL,
	[BillId] [varchar](10) NOT NULL,
	[DrinkId] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdItemTopping] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Permision]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Permision](
	[PermisionID] [varchar](10) NOT NULL,
	[PermisionName] [varchar](100) NULL DEFAULT (NULL),
PRIMARY KEY CLUSTERED 
(
	[PermisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PermisionDetail]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PermisionDetail](
	[PermisionDetailId] [varchar](10) NOT NULL,
	[ActionName] [varchar](1) NULL DEFAULT (NULL),
	[PermisionID] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PermisionDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Resources]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Resources](
	[ResourceId] [varchar](10) NOT NULL,
	[ResourceName] [nvarchar](100) NULL CONSTRAINT [DF__Resources__Resou__173876EA]  DEFAULT (NULL),
	[Amount] [int] NULL CONSTRAINT [DF__Resources__Amoun__182C9B23]  DEFAULT (NULL),
 CONSTRAINT [PK__Resource__4ED1816F87F6641C] PRIMARY KEY CLUSTERED 
(
	[ResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Staff](
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](100) NULL CONSTRAINT [DF__Staff__Password__1DE57479]  DEFAULT (NULL),
	[FullName] [nvarchar](100) NULL CONSTRAINT [DF__Staff__FullName__1ED998B2]  DEFAULT (NULL),
	[Age] [datetime] NULL CONSTRAINT [DF__Staff__Age__1FCDBCEB]  DEFAULT (NULL),
	[PhoneNumber] [varchar](10) NULL CONSTRAINT [DF__Staff__PhoneNumb__20C1E124]  DEFAULT (NULL),
	[Address] [nvarchar](100) NULL CONSTRAINT [DF__Staff__Address__21B6055D]  DEFAULT (NULL),
	[Avatar] [varchar](100) NULL CONSTRAINT [DF__Staff__Avatar__22AA2996]  DEFAULT (NULL),
 CONSTRAINT [PK__Staff__C9F28457BFDD93F7] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TableSpace]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TableSpace](
	[TableId] [varchar](10) NOT NULL,
	[TableName] [nvarchar](100) NULL CONSTRAINT [DF__TableSpac__Table__33D4B598]  DEFAULT (NULL),
	[Status] [int] NULL CONSTRAINT [DF__TableSpac__Statu__34C8D9D1]  DEFAULT (NULL),
 CONSTRAINT [PK__TableSpa__7D5F01EE08DB36E2] PRIMARY KEY CLUSTERED 
(
	[TableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Topping_Resource]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Topping_Resource](
	[ResourceId] [varchar](10) NOT NULL,
	[ToppingId] [varchar](10) NOT NULL,
	[Amount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResourceId] ASC,
	[ToppingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Toppings]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Toppings](
	[ToppingId] [varchar](10) NOT NULL,
	[ToppingName] [nvarchar](100) NULL CONSTRAINT [DF__Toppings__Toppin__1367E606]  DEFAULT (NULL),
	[Price] [int] NULL CONSTRAINT [DF__Toppings__Price__145C0A3F]  DEFAULT (NULL),
 CONSTRAINT [PK__Toppings__EE02CC85C092F7CA] PRIMARY KEY CLUSTERED 
(
	[ToppingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserPermision]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserPermision](
	[UserName] [varchar](50) NOT NULL,
	[PermisionID] [varchar](10) NOT NULL,
 CONSTRAINT [pk_user_permistion] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC,
	[PermisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Voucher]    Script Date: 26/11/2020 2:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voucher](
	[Code] [nvarchar](10) NOT NULL,
	[dateStart] [datetime] NULL,
	[dateEnd] [datetime] NULL,
	[ratio] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'221118133', CAST(N'2020-11-22 19:46:30.577' AS DateTime), N'OFFLINE', NULL, 99000, NULL, N'nobita', N'0984402978', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'2211181833', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 105000, NULL, N'nobita', N'0984402978', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'2211184639', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 52000, NULL, N'nobita', N'0984402978', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'221118551', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 20000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'22111880', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 92000, NULL, N'nobita', N'0392301017', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'2211191020', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 27000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'2211191212', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 27000, NULL, N'nobita', N'0984402978', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'2211191356', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 27000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'2211191528', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 27000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'221119256', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 32000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'2211193549', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 27000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'22111945', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 50000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'2211194821', CAST(N'2020-11-22 19:48:22.933' AS DateTime), N'OFFLINE', NULL, 32000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'221119651', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 90000, NULL, N'nobita', N'0984402978', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'221119952', CAST(N'2020-11-22 00:00:00.000' AS DateTime), N'OFFLINE', NULL, 20000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'23110257', CAST(N'2020-11-23 00:25:27.907' AS DateTime), N'OFFLINE', NULL, 57000, NULL, N'nobita', N'0392301017', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'231112756', CAST(N'2020-11-23 01:28:02.780' AS DateTime), N'OFFLINE', NULL, 65000, NULL, N'nobita', N'0123456789', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'23111293', CAST(N'2020-11-23 01:29:05.700' AS DateTime), N'OFFLINE', NULL, 135000, NULL, N'nobita', N'0123456789', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'231116352', CAST(N'2020-11-23 16:03:57.653' AS DateTime), N'OFFLINE', NULL, 25000, NULL, N'nobita', N'0123401234', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'231125310', CAST(N'2020-11-23 02:53:11.457' AS DateTime), N'OFFLINE', NULL, 45000, NULL, N'nobita', N'0123401234', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'23112569', CAST(N'2020-11-23 02:56:11.117' AS DateTime), N'OFFLINE', NULL, 150000, NULL, N'nobita', N'0123401234', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'231131458', CAST(N'2020-11-23 03:14:59.303' AS DateTime), N'OFFLINE', NULL, 32000, NULL, N'nobita', N'0123401234', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'231133324', CAST(N'2020-11-23 03:33:28.223' AS DateTime), N'OFFLINE', NULL, 357000, NULL, N'nobita', N'0123401234', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'231133638', CAST(N'2020-11-23 03:36:39.157' AS DateTime), N'OFFLINE', NULL, 20000, NULL, N'nobita', N'0123401234', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'23113487', CAST(N'2020-11-23 03:48:08.503' AS DateTime), N'OFFLINE', NULL, 87000, NULL, N'nobita', N'0967452219', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'231135316', CAST(N'2020-11-23 03:53:33.207' AS DateTime), N'OFFLINE', NULL, 37000, NULL, N'nobita', N'0967452219', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'24112165', CAST(N'2020-11-24 02:16:37.060' AS DateTime), N'OFFLINE', NULL, 149000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'241121725', CAST(N'2020-11-24 02:17:31.370' AS DateTime), N'OFFLINE', NULL, 22000, NULL, N'nobita', N'0984402978', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'24113224', CAST(N'2020-11-24 03:02:49.380' AS DateTime), N'OFFLINE', N'1', 32000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'241132821', CAST(N'2020-11-24 03:28:29.867' AS DateTime), N'OFFLINE', N'10', 60000, NULL, N'nobita', N'0123401234', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'241134047', CAST(N'2020-11-24 03:40:59.737' AS DateTime), N'OFFLINE', N'1', 35000, CAST(N'2020-11-24 04:24:58.653' AS DateTime), N'nobita', N'0967452219', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'241134150', CAST(N'2020-11-24 03:41:56.363' AS DateTime), N'OFFLINE', N'1', 35000, CAST(N'2020-11-24 04:32:33.280' AS DateTime), N'nobita', N'0123456789', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'241134339', CAST(N'2020-11-24 03:43:44.637' AS DateTime), N'OFFLINE', N'1', 24000, CAST(N'2020-11-24 04:24:26.887' AS DateTime), N'nobita', N'0909090909', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'24113458', CAST(N'2020-11-24 03:05:17.040' AS DateTime), N'OFFLINE', N'1', 42000, NULL, N'nobita', N'0984402978', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'24113480', CAST(N'2020-11-24 03:48:11.493' AS DateTime), N'OFFLINE', N'1', 22000, CAST(N'2020-11-24 04:25:14.513' AS DateTime), N'nobita', N'0979000111', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'241135040', CAST(N'2020-11-24 03:50:52.277' AS DateTime), N'OFFLINE', N'1', 37000, CAST(N'2020-11-24 04:27:47.637' AS DateTime), N'nobita', N'0979000222', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'241143248', CAST(N'2020-11-24 04:33:03.823' AS DateTime), N'OFFLINE', N'1', 22000, CAST(N'2020-11-24 04:33:46.847' AS DateTime), N'nobita', N'0123401234', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'241143317', CAST(N'2020-11-24 04:33:27.710' AS DateTime), N'OFFLINE', N'1', 56000, NULL, N'nobita', N'0979000111', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'241143426', CAST(N'2020-11-24 04:34:36.140' AS DateTime), N'OFFLINE', N'1', 56000, CAST(N'2020-11-26 01:40:03.013' AS DateTime), N'nobita', N'0979000222', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'25117221', CAST(N'2020-11-25 07:02:37.197' AS DateTime), N'OFFLINE', NULL, 30000, NULL, N'nobita', N'0392301017', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'261113951', CAST(N'2020-11-26 01:40:12.233' AS DateTime), N'OFFLINE', N'1', 114000, CAST(N'2020-11-26 14:28:32.660' AS DateTime), N'nobita', N'0973271208', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'2611142756', CAST(N'2020-11-26 14:28:43.477' AS DateTime), N'OFFLINE', N'10', 37000, NULL, N'nobita', N'0984402978', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'261161833', CAST(N'2020-11-26 06:18:35.913' AS DateTime), N'OFFLINE', NULL, 25000, NULL, N'nobita', N'0984402978', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'261162258', CAST(N'2020-11-26 06:23:02.630' AS DateTime), N'OFFLINE', NULL, 25000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'261162422', CAST(N'2020-11-26 06:24:25.097' AS DateTime), N'OFFLINE', NULL, 25000, NULL, N'nobita', N'0979000111', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'261162825', CAST(N'2020-11-26 06:28:44.503' AS DateTime), N'OFFLINE', N'11', 25000, CAST(N'2020-11-26 14:28:20.220' AS DateTime), N'nobita', N'0342484642', N'THUHIEN')
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'26116295', CAST(N'2020-11-26 06:29:11.237' AS DateTime), N'OFFLINE', N'11', 25000, CAST(N'2020-11-26 14:28:10.970' AS DateTime), N'nobita', N'0342484642', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'26118176', CAST(N'2020-11-26 08:17:08.170' AS DateTime), N'OFFLINE', NULL, 12000, NULL, N'nobita', N'0984402978', NULL)
INSERT [dbo].[Bills] ([BillId], [OrderTimeStart], [Payments], [TableId], [Total], [OrderTimeEnd], [UserName], [PhoneNumber], [CodeVoucher]) VALUES (N'261193948', CAST(N'2020-11-26 09:39:49.827' AS DateTime), N'OFFLINE', NULL, 20000, NULL, N'nobita', N'0392301017', NULL)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0123401234', N'Đỗ Xuân Cảnh', N'Nam Định', 1)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0123456789', N'Nguyễn Quỳnh Anh', N'Ninh Bình', 0)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0342484642', N'Nguyễn Văn An', N'Ninh Bình', 0)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0392301017', N'Phạm Thị Thu Hiền', N'Yên Nhân, Yên Mô, Ninh Bình', 1)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0909090909', N'Nguyễn Hạ Trang', N'Hải Phòng', 0)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0967452219', N'Bùi Tiến Bắc', N'Cẩm Giàng, Hải Dương', 0)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0973271208', N'Lê Quang Thọ', N'Hưng Yên', 0)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0979000111', N'Trương Tam Phong', N'Trung Quốc', 0)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0979000222', N'Donald Trump', N'Mỹ Tho', 0)
INSERT [dbo].[Customer] ([PhoneNumber], [FullName], [Address], [Level]) VALUES (N'0984402978', N'Lê Quang Duy', N'Ninh Bình', 1)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'000001', N'01', 3)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'000001', N'03', 1)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'000002', N'01', 1)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'000002', N'04', 1)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'000006', N'03', 2)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'000007', N'6', 1)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'000008', N'6', 1)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'10', N'02', 1)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'10', N'05', 2)
INSERT [dbo].[Drink_Resource] ([ResourceId], [DrinkId], [Amount]) VALUES (N'12', N'02', 2)
INSERT [dbo].[Drinks] ([DrinkId], [DrinkName], [Price], [Image], [Icon], [DrinkTypeId]) VALUES (N'01', N'Trà sữa không đường', 25000, N'D:\TeaManagement\Project\bin\Debug\Images\trasua01.jpg', NULL, N'01')
INSERT [dbo].[Drinks] ([DrinkId], [DrinkName], [Price], [Image], [Icon], [DrinkTypeId]) VALUES (N'02', N'Trà sữa chân trâu', 12000, N'D:\TeaManagement\Project\bin\Debug\Images\trasua02.jpg', NULL, N'02')
INSERT [dbo].[Drinks] ([DrinkId], [DrinkName], [Price], [Image], [Icon], [DrinkTypeId]) VALUES (N'03', N'Trà sữa có đường', 20000, N'D:\TeaManagement\Project\bin\Debug\Images\trasua08.jpg', NULL, N'03')
INSERT [dbo].[Drinks] ([DrinkId], [DrinkName], [Price], [Image], [Icon], [DrinkTypeId]) VALUES (N'04', N'Trà sữa Oreo Cake Cream', 20000, N'D:\TeaManagement\Project\bin\Debug\Images\trasua10.jpg', NULL, N'04')
INSERT [dbo].[Drinks] ([DrinkId], [DrinkName], [Price], [Image], [Icon], [DrinkTypeId]) VALUES (N'05', N'Trà sữa trái cây túi lọc', 30000, N'D:\TeaManagement\Project\bin\Debug\Images\trasua07.jpg', NULL, N'03')
INSERT [dbo].[Drinks] ([DrinkId], [DrinkName], [Price], [Image], [Icon], [DrinkTypeId]) VALUES (N'6', N'Trà mật ong', 50000, N'D:\TeaManagement\Project\bin\Debug\Images\trasua05.jpg', NULL, N'04')
INSERT [dbo].[DrinkTypes] ([DrinkTypeId], [DrinkTypeName]) VALUES (N'01', N'Loại cao cấp')
INSERT [dbo].[DrinkTypes] ([DrinkTypeId], [DrinkTypeName]) VALUES (N'02', N'Loại tầm trung')
INSERT [dbo].[DrinkTypes] ([DrinkTypeId], [DrinkTypeName]) VALUES (N'03', N'Loại tiêu chuẩn')
INSERT [dbo].[DrinkTypes] ([DrinkTypeId], [DrinkTypeName]) VALUES (N'04', N'Loại sinh viên')
SET IDENTITY_INSERT [dbo].[Items] ON 

INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 1, N'231125310', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 2, N'231125310', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 3, N'23112569', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 4, N'23112569', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 5, N'23112569', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 8, N'231131458', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 9, N'231133324', N'02')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 10, N'231133324', N'02')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 11, N'231133324', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 12, N'231133324', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 13, N'231133324', N'05')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 14, N'231133324', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 15, N'231133324', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 16, N'231133638', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 17, N'23113487', N'04')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 18, N'23113487', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 19, N'231135316', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 20, N'231116352', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 21, N'24112165', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 22, N'24112165', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 23, N'24112165', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 24, N'241121725', N'02')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 25, N'24113224', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 26, N'24113458', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 27, N'241132821', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 28, N'241134047', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 29, N'241134150', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 30, N'241134339', N'02')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 31, N'24113480', N'02')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 32, N'241135040', N'05')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 33, N'241143248', N'02')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 34, N'241143317', N'02')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 35, N'241143317', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 36, N'241143426', N'02')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 37, N'241143426', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 38, N'25117221', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 39, N'261113951', N'04')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 40, N'261113951', N'04')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 41, N'261113951', N'6')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 42, N'261161833', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 43, N'261162258', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 44, N'261162422', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 45, N'261162825', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 46, N'26116295', N'01')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 47, N'26118176', N'02')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 48, N'261193948', N'03')
INSERT [dbo].[Items] ([Amount], [ItemId], [BillId], [DrinkId]) VALUES (NULL, 49, N'2611142756', N'01')
SET IDENTITY_INSERT [dbo].[Items] OFF
SET IDENTITY_INSERT [dbo].[ItemTopping] ON 

INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (1, 8, N'11', N'231131458', N'01')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (2, 9, N'10', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (3, 9, N'11', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (4, 9, N'4', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (5, 9, N'5', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (6, 9, N'6', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (7, 11, N'11', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (8, 11, N'2', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, 11, N'5', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (10, 12, N'10', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (11, 12, N'11', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (12, 12, N'2', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (13, 13, N'1', N'231133324', N'05')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (14, 13, N'10', N'231133324', N'05')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (15, 13, N'4', N'231133324', N'05')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (16, 14, N'10', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (17, 14, N'11', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (18, 14, N'4', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (19, 15, N'10', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (20, 18, N'11', N'23113487', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (21, 18, N'5', N'23113487', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (22, 19, N'2', N'231135316', N'01')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (23, 21, N'11', N'24112165', N'01')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (24, 22, N'6', N'24112165', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (25, 23, N'4', N'24112165', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (26, 24, N'6', N'241121725', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (27, 25, N'2', N'24113224', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (28, 26, N'1', N'24113458', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (29, 26, N'2', N'24113458', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (30, 27, N'9', N'241132821', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (31, 28, N'5', N'241134047', N'01')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (32, 29, N'5', N'241134150', N'01')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (33, 30, N'2', N'241134339', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (34, 31, N'5', N'24113480', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (35, 32, N'3', N'241135040', N'05')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (36, 33, N'10', N'241143248', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (37, 34, N'10', N'241143317', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (38, 35, N'11', N'241143317', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (39, 36, N'10', N'241143426', N'02')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (40, 37, N'11', N'241143426', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (41, 38, N'5', N'25117221', N'03')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (42, 39, N'10', N'261113951', N'04')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (43, 41, N'11', N'261113951', N'6')
INSERT [dbo].[ItemTopping] ([IdItemTopping], [ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (44, 49, N'2', N'2611142756', N'01')
SET IDENTITY_INSERT [dbo].[ItemTopping] OFF
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'01', N'Full')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'02', N'Admin')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'03', N'ReadOnly')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'04', N'Edit')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'05', N'Create')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'10', N'Edit')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'11', N'Custom')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'6', N'?')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'7', N'?')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'8', N'?')
INSERT [dbo].[Permision] ([PermisionID], [PermisionName]) VALUES (N'9', N'Create')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'01', N'C', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'02', N'E', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'03', N'D', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'04', N'V', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'05', N'C', N'02')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'06', N'E', N'02')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'07', N'', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'08', N'V', N'02')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'09', N'', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'10', N'', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'11', N'', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'12', N'V', N'03')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'13', N'', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'14', N'E', N'04')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'15', N'', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'16', N'V', N'04')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'17', N'C', N'05')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'18', N'', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'19', N'', N'01')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'20', N'V', N'05')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'21', N'V', N'10')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'22', N'E', N'10')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'23', N'V', N'11')
INSERT [dbo].[PermisionDetail] ([PermisionDetailId], [ActionName], [PermisionID]) VALUES (N'24', N'C', N'11')
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'000001', N'Hong Tra Tan Nam Bac', 86)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'000002', N'Tuyet Yen Van Nam', 93)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'000003', N'Che Duong Nhan', 100)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'000004', N'Tra Dao tui loc Phuc Long', 100)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'000005', N'Hong Tra', 100)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'000006', N'Okinawa', 90)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'000007', N'Hat sen tuoi', 92)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'000008', N'Dua', 100)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'000009', N'Du du', 100)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'10', N'Đường', 95)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'11', N'Thạch', 100)
INSERT [dbo].[Resources] ([ResourceId], [ResourceName], [Amount]) VALUES (N'12', N'Trân châu', 90)
INSERT [dbo].[Staff] ([UserName], [Password], [FullName], [Age], [PhoneNumber], [Address], [Avatar]) VALUES (N'iamdai', N'1Z3auZuoRerM5FhU5xvLwcPwBm29fr1s', N'Nguyen Viet Dai', CAST(N'2020-11-11 01:42:02.803' AS DateTime), N'0123456789', N'Bac Ninh', N'')
INSERT [dbo].[Staff] ([UserName], [Password], [FullName], [Age], [PhoneNumber], [Address], [Avatar]) VALUES (N'nobita', N'1Z3auZuoRerM5FhU5xvLwcPwBm29fr1s', N'Le Quang Duy', CAST(N'2000-03-02 17:19:30.603' AS DateTime), N'0392301017', N'Ninh Binh', N'G:\Screenshot_20201030-153300.jpg')
INSERT [dbo].[Staff] ([UserName], [Password], [FullName], [Age], [PhoneNumber], [Address], [Avatar]) VALUES (N'prochicken007', N'1Z3auZuoRerM5FhU5xvLwcPwBm29fr1s', N'Nguyen Van An', CAST(N'2000-11-09 16:17:05.210' AS DateTime), N'0392301017', N'Nguyen Chi Thanh', N'F:\img2.png')
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'1', N'Bàn 1 Tầng 1', 1)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'10', N'Bàn 3 tầng 4', 1)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'11', N'Bàn 4 tầng 4', 0)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'2', N'Bàn 2 Tầng 1', 1)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'3', N'Bàn 3 Tầng 1', 1)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'4', N'Bàn 1 Tầng 2', 1)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'5', N'Bàn 2 Tầng 2', 1)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'6', N'Bàn 1 Tầng 3', 1)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'7', N'Bàn 2 Tầng 3', 1)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'8', N'Bàn 1 tầng 4', 1)
INSERT [dbo].[TableSpace] ([TableId], [TableName], [Status]) VALUES (N'9', N'Bàn 2 tầng 4', 1)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'000001', N'1', 2)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'000002', N'1', 1)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'000002', N'11', 1)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'000005', N'2', 2)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'000006', N'5', 1)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'000007', N'10', 2)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'000009', N'6', 2)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'11', N'3', 1)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'11', N'4', 2)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'11', N'8', 3)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'12', N'7', 2)
INSERT [dbo].[Topping_Resource] ([ResourceId], [ToppingId], [Amount]) VALUES (N'12', N'9', 3)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'1', N'Chân châu Truyền Thống', 10000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'10', N'Nếp thơm', 10000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'11', N'Gạo tẻ', 7000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'2', N'Chân châu hoàng kim', 12000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'3', N'Thạch rau câu', 7000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'4', N'Thạch phô mai', 7000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'5', N'Pudding', 10000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'6', N'Trân châu long nhãn', 10000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'7', N'Trân châu trắng', 9000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'8', N'Thạch củ năng', 9000)
INSERT [dbo].[Toppings] ([ToppingId], [ToppingName], [Price]) VALUES (N'9', N'Chân châu cao sang', 10000)
INSERT [dbo].[UserPermision] ([UserName], [PermisionID]) VALUES (N'iamdai', N'11')
INSERT [dbo].[UserPermision] ([UserName], [PermisionID]) VALUES (N'nobita', N'01')
INSERT [dbo].[UserPermision] ([UserName], [PermisionID]) VALUES (N'prochicken007', N'10')
INSERT [dbo].[Voucher] ([Code], [dateStart], [dateEnd], [ratio]) VALUES (N'LOVEHIEN', CAST(N'2020-11-12 17:25:39.000' AS DateTime), CAST(N'2020-11-20 17:25:39.000' AS DateTime), 5)
INSERT [dbo].[Voucher] ([Code], [dateStart], [dateEnd], [ratio]) VALUES (N'THUHIEN', CAST(N'2020-11-21 17:25:39.727' AS DateTime), CAST(N'2020-11-28 17:25:39.000' AS DateTime), 5)
ALTER TABLE [dbo].[Bills]  WITH CHECK ADD  CONSTRAINT [FK__Bills__PhoneNumb__3F466844] FOREIGN KEY([PhoneNumber])
REFERENCES [dbo].[Customer] ([PhoneNumber])
GO
ALTER TABLE [dbo].[Bills] CHECK CONSTRAINT [FK__Bills__PhoneNumb__3F466844]
GO
ALTER TABLE [dbo].[Bills]  WITH CHECK ADD  CONSTRAINT [FK__Bills__TableId__403A8C7D] FOREIGN KEY([TableId])
REFERENCES [dbo].[TableSpace] ([TableId])
GO
ALTER TABLE [dbo].[Bills] CHECK CONSTRAINT [FK__Bills__TableId__403A8C7D]
GO
ALTER TABLE [dbo].[Bills]  WITH CHECK ADD  CONSTRAINT [FK__Bills__UserName__3E52440B] FOREIGN KEY([UserName])
REFERENCES [dbo].[Staff] ([UserName])
GO
ALTER TABLE [dbo].[Bills] CHECK CONSTRAINT [FK__Bills__UserName__3E52440B]
GO
ALTER TABLE [dbo].[Bills]  WITH CHECK ADD  CONSTRAINT [fk_codeVoucher] FOREIGN KEY([CodeVoucher])
REFERENCES [dbo].[Voucher] ([Code])
GO
ALTER TABLE [dbo].[Bills] CHECK CONSTRAINT [fk_codeVoucher]
GO
ALTER TABLE [dbo].[Drink_Resource]  WITH CHECK ADD FOREIGN KEY([DrinkId])
REFERENCES [dbo].[Drinks] ([DrinkId])
GO
ALTER TABLE [dbo].[Drink_Resource]  WITH CHECK ADD FOREIGN KEY([ResourceId])
REFERENCES [dbo].[Resources] ([ResourceId])
GO
ALTER TABLE [dbo].[Drinks]  WITH CHECK ADD  CONSTRAINT [FK__Drinks__DrinkTyp__47DBAE45] FOREIGN KEY([DrinkTypeId])
REFERENCES [dbo].[DrinkTypes] ([DrinkTypeId])
GO
ALTER TABLE [dbo].[Drinks] CHECK CONSTRAINT [FK__Drinks__DrinkTyp__47DBAE45]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD FOREIGN KEY([BillId])
REFERENCES [dbo].[Bills] ([BillId])
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD FOREIGN KEY([DrinkId])
REFERENCES [dbo].[Drinks] ([DrinkId])
GO
ALTER TABLE [dbo].[ItemTopping]  WITH CHECK ADD FOREIGN KEY([ToppingId])
REFERENCES [dbo].[Toppings] ([ToppingId])
GO
ALTER TABLE [dbo].[ItemTopping]  WITH CHECK ADD FOREIGN KEY([ItemId], [BillId], [DrinkId])
REFERENCES [dbo].[Items] ([ItemId], [BillId], [DrinkId])
GO
ALTER TABLE [dbo].[PermisionDetail]  WITH CHECK ADD FOREIGN KEY([PermisionID])
REFERENCES [dbo].[Permision] ([PermisionID])
GO
ALTER TABLE [dbo].[Topping_Resource]  WITH CHECK ADD FOREIGN KEY([ResourceId])
REFERENCES [dbo].[Resources] ([ResourceId])
GO
ALTER TABLE [dbo].[Topping_Resource]  WITH CHECK ADD FOREIGN KEY([ToppingId])
REFERENCES [dbo].[Toppings] ([ToppingId])
GO
ALTER TABLE [dbo].[UserPermision]  WITH CHECK ADD FOREIGN KEY([PermisionID])
REFERENCES [dbo].[Permision] ([PermisionID])
GO
ALTER TABLE [dbo].[UserPermision]  WITH CHECK ADD  CONSTRAINT [FK__UserPermi__UserN__276EDEB3] FOREIGN KEY([UserName])
REFERENCES [dbo].[Staff] ([UserName])
GO
ALTER TABLE [dbo].[UserPermision] CHECK CONSTRAINT [FK__UserPermi__UserN__276EDEB3]
GO
USE [master]
GO
ALTER DATABASE [tea01] SET  READ_WRITE 
GO

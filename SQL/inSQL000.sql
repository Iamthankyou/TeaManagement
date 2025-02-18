USE [master]
GO
/****** Object:  Database [tea01]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[getAmountResourceDrink]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[getAmountResourceTopping]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Bills]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Drink_Resource]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Drinks]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[DrinkTypes]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Items]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[ItemTopping]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Permision]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[PermisionDetail]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Resources]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Staff]    Script Date: 26/11/2020 9:24:55 PM ******/
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
	[DayOf] [datetime] NULL,
 CONSTRAINT [PK__Staff__C9F28457BFDD93F7] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TableSpace]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Topping_Resource]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Toppings]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[UserPermision]    Script Date: 26/11/2020 9:24:55 PM ******/
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
/****** Object:  Table [dbo].[Voucher]    Script Date: 26/11/2020 9:24:55 PM ******/
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

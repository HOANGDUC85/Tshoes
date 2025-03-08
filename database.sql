USE [master]
GO
/****** Object:  Database [FCSP_DB]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE DATABASE [FCSP_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FCSP_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\FCSP_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FCSP_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\FCSP_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FCSP_DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FCSP_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FCSP_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FCSP_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FCSP_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FCSP_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FCSP_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [FCSP_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FCSP_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FCSP_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FCSP_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FCSP_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FCSP_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FCSP_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FCSP_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FCSP_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FCSP_DB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FCSP_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FCSP_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FCSP_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FCSP_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FCSP_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FCSP_DB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [FCSP_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FCSP_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [FCSP_DB] SET  MULTI_USER 
GO
ALTER DATABASE [FCSP_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FCSP_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FCSP_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FCSP_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FCSP_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FCSP_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FCSP_DB', N'ON'
GO
ALTER DATABASE [FCSP_DB] SET QUERY_STORE = OFF
GO
USE [FCSP_DB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomShoeDesigns]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomShoeDesigns](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[CustomShoeDesignTemplateId] [bigint] NOT NULL,
	[DesignData] [nvarchar](max) NULL,
	[Size] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[DesignerMarkup] [real] NOT NULL,
	[TotalPrice] [real] NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CustomShoeDesigns] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomShoeDesignTemplates]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomShoeDesignTemplates](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Gender] [nvarchar](max) NULL,
	[Color] [nvarchar](max) NULL,
	[Price] [real] NOT NULL,
	[2DImageUrl] [nvarchar](max) NULL,
	[3DFileUrl] [nvarchar](max) NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CustomShoeDesignTemplates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomShoeDesignTextures]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomShoeDesignTextures](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomShoeDesignId] [bigint] NOT NULL,
	[TextureId] [bigint] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CustomShoeDesignTextures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DesignPreviews]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DesignPreviews](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomShoeDesignId] [bigint] NOT NULL,
	[PreviewImageUrl] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DesignPreviews] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DesignServices]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DesignServices](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DesignId] [bigint] NOT NULL,
	[ServiceId] [bigint] NOT NULL,
	[ServiceId1] [bigint] NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DesignServices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NOT NULL,
	[CustomShoeDesignId] [bigint] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [real] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[VoucherId] [bigint] NULL,
	[ShippingInfoId] [bigint] NOT NULL,
	[TotalPrice] [real] NOT NULL,
	[AmountPaid] [real] NOT NULL,
	[Status] [int] NOT NULL,
	[ShippingStatus] [int] NOT NULL,
	[ShippingInfoId1] [bigint] NULL,
	[VoucherId1] [bigint] NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentGateways]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentGateways](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PaymentMethod] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PaymentGateways] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NOT NULL,
	[Amount] [real] NOT NULL,
	[PaymentMethod] [int] NOT NULL,
	[PaymentStatus] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostsComments]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostsComments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PostsId] [bigint] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_PostsComments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomShoeDesignId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[UserRating] [int] NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Ratings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ServiceName] [nvarchar](max) NOT NULL,
	[ServiceFee] [real] NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Services] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShippingInfos]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingInfos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[StreetAddress] [nvarchar](max) NOT NULL,
	[Ward] [nvarchar](max) NOT NULL,
	[District] [nvarchar](max) NOT NULL,
	[City] [nvarchar](max) NOT NULL,
	[Country] [nvarchar](max) NOT NULL,
	[PhoneNumber] [nvarchar](max) NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ShippingInfos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Textures]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Textures](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[Prompt] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Textures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserActivities]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserActivities](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[ViewedDesignId] [bigint] NOT NULL,
	[ViewAt] [nvarchar](max) NOT NULL,
	[ViewDuration] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_UserActivities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRecommendations]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRecommendations](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[RecommendDesignId] [bigint] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_UserRecommendations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[Dob] [nvarchar](max) NULL,
	[Gender] [nvarchar](max) NULL,
	[UserRole] [int] NOT NULL,
	[Balance] [real] NULL,
	[DefaultAddressId] [bigint] NULL,
	[Status] [int] NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vouchers]    Script Date: 08-Mar-25 11:13:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vouchers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[VoucherName] [nvarchar](max) NULL,
	[VoucherValue] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[ExpirationDate] [datetime2](7) NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Vouchers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomShoeDesigns_CustomShoeDesignTemplateId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomShoeDesigns_CustomShoeDesignTemplateId] ON [dbo].[CustomShoeDesigns]
(
	[CustomShoeDesignTemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomShoeDesigns_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomShoeDesigns_UserId] ON [dbo].[CustomShoeDesigns]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomShoeDesignTemplates_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomShoeDesignTemplates_UserId] ON [dbo].[CustomShoeDesignTemplates]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomShoeDesignTextures_CustomShoeDesignId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomShoeDesignTextures_CustomShoeDesignId] ON [dbo].[CustomShoeDesignTextures]
(
	[CustomShoeDesignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomShoeDesignTextures_TextureId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomShoeDesignTextures_TextureId] ON [dbo].[CustomShoeDesignTextures]
(
	[TextureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DesignPreviews_CustomShoeDesignId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_DesignPreviews_CustomShoeDesignId] ON [dbo].[DesignPreviews]
(
	[CustomShoeDesignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DesignServices_DesignId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_DesignServices_DesignId] ON [dbo].[DesignServices]
(
	[DesignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DesignServices_ServiceId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_DesignServices_ServiceId] ON [dbo].[DesignServices]
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DesignServices_ServiceId1]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_DesignServices_ServiceId1] ON [dbo].[DesignServices]
(
	[ServiceId1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notifications_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_UserId] ON [dbo].[Notifications]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_CustomShoeDesignId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_CustomShoeDesignId] ON [dbo].[OrderDetails]
(
	[CustomShoeDesignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_OrderId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_OrderId] ON [dbo].[OrderDetails]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_ShippingInfoId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_ShippingInfoId] ON [dbo].[Orders]
(
	[ShippingInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_ShippingInfoId1]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_ShippingInfoId1] ON [dbo].[Orders]
(
	[ShippingInfoId1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_UserId] ON [dbo].[Orders]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_VoucherId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_VoucherId] ON [dbo].[Orders]
(
	[VoucherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_VoucherId1]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_VoucherId1] ON [dbo].[Orders]
(
	[VoucherId1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PaymentGateways_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_PaymentGateways_UserId] ON [dbo].[PaymentGateways]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Payments_OrderId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Payments_OrderId] ON [dbo].[Payments]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Posts_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Posts_UserId] ON [dbo].[Posts]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PostsComments_PostsId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_PostsComments_PostsId] ON [dbo].[PostsComments]
(
	[PostsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PostsComments_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_PostsComments_UserId] ON [dbo].[PostsComments]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Ratings_CustomShoeDesignId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Ratings_CustomShoeDesignId] ON [dbo].[Ratings]
(
	[CustomShoeDesignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Ratings_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Ratings_UserId] ON [dbo].[Ratings]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShippingInfos_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShippingInfos_UserId] ON [dbo].[ShippingInfos]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Textures_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Textures_UserId] ON [dbo].[Textures]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserActivities_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserActivities_UserId] ON [dbo].[UserActivities]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserActivities_ViewedDesignId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserActivities_ViewedDesignId] ON [dbo].[UserActivities]
(
	[ViewedDesignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserRecommendations_RecommendDesignId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserRecommendations_RecommendDesignId] ON [dbo].[UserRecommendations]
(
	[RecommendDesignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserRecommendations_UserId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserRecommendations_UserId] ON [dbo].[UserRecommendations]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_DefaultAddressId]    Script Date: 08-Mar-25 11:13:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Users_DefaultAddressId] ON [dbo].[Users]
(
	[DefaultAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomShoeDesigns]  WITH CHECK ADD  CONSTRAINT [FK_CustomShoeDesigns_CustomShoeDesignTemplates_CustomShoeDesignTemplateId] FOREIGN KEY([CustomShoeDesignTemplateId])
REFERENCES [dbo].[CustomShoeDesignTemplates] ([Id])
GO
ALTER TABLE [dbo].[CustomShoeDesigns] CHECK CONSTRAINT [FK_CustomShoeDesigns_CustomShoeDesignTemplates_CustomShoeDesignTemplateId]
GO
ALTER TABLE [dbo].[CustomShoeDesigns]  WITH CHECK ADD  CONSTRAINT [FK_CustomShoeDesigns_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[CustomShoeDesigns] CHECK CONSTRAINT [FK_CustomShoeDesigns_Users_UserId]
GO
ALTER TABLE [dbo].[CustomShoeDesignTemplates]  WITH CHECK ADD  CONSTRAINT [FK_CustomShoeDesignTemplates_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[CustomShoeDesignTemplates] CHECK CONSTRAINT [FK_CustomShoeDesignTemplates_Users_UserId]
GO
ALTER TABLE [dbo].[CustomShoeDesignTextures]  WITH CHECK ADD  CONSTRAINT [FK_CustomShoeDesignTextures_CustomShoeDesigns_CustomShoeDesignId] FOREIGN KEY([CustomShoeDesignId])
REFERENCES [dbo].[CustomShoeDesigns] ([Id])
GO
ALTER TABLE [dbo].[CustomShoeDesignTextures] CHECK CONSTRAINT [FK_CustomShoeDesignTextures_CustomShoeDesigns_CustomShoeDesignId]
GO
ALTER TABLE [dbo].[CustomShoeDesignTextures]  WITH CHECK ADD  CONSTRAINT [FK_CustomShoeDesignTextures_Textures_TextureId] FOREIGN KEY([TextureId])
REFERENCES [dbo].[Textures] ([Id])
GO
ALTER TABLE [dbo].[CustomShoeDesignTextures] CHECK CONSTRAINT [FK_CustomShoeDesignTextures_Textures_TextureId]
GO
ALTER TABLE [dbo].[DesignPreviews]  WITH CHECK ADD  CONSTRAINT [FK_DesignPreviews_CustomShoeDesigns_CustomShoeDesignId] FOREIGN KEY([CustomShoeDesignId])
REFERENCES [dbo].[CustomShoeDesigns] ([Id])
GO
ALTER TABLE [dbo].[DesignPreviews] CHECK CONSTRAINT [FK_DesignPreviews_CustomShoeDesigns_CustomShoeDesignId]
GO
ALTER TABLE [dbo].[DesignServices]  WITH CHECK ADD  CONSTRAINT [FK_DesignServices_CustomShoeDesigns_DesignId] FOREIGN KEY([DesignId])
REFERENCES [dbo].[CustomShoeDesigns] ([Id])
GO
ALTER TABLE [dbo].[DesignServices] CHECK CONSTRAINT [FK_DesignServices_CustomShoeDesigns_DesignId]
GO
ALTER TABLE [dbo].[DesignServices]  WITH CHECK ADD  CONSTRAINT [FK_DesignServices_Services_ServiceId] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Services] ([Id])
GO
ALTER TABLE [dbo].[DesignServices] CHECK CONSTRAINT [FK_DesignServices_Services_ServiceId]
GO
ALTER TABLE [dbo].[DesignServices]  WITH CHECK ADD  CONSTRAINT [FK_DesignServices_Services_ServiceId1] FOREIGN KEY([ServiceId1])
REFERENCES [dbo].[Services] ([Id])
GO
ALTER TABLE [dbo].[DesignServices] CHECK CONSTRAINT [FK_DesignServices_Services_ServiceId1]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Users_UserId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_CustomShoeDesigns_CustomShoeDesignId] FOREIGN KEY([CustomShoeDesignId])
REFERENCES [dbo].[CustomShoeDesigns] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_CustomShoeDesigns_CustomShoeDesignId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders_OrderId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_ShippingInfos_ShippingInfoId] FOREIGN KEY([ShippingInfoId])
REFERENCES [dbo].[ShippingInfos] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_ShippingInfos_ShippingInfoId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_ShippingInfos_ShippingInfoId1] FOREIGN KEY([ShippingInfoId1])
REFERENCES [dbo].[ShippingInfos] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_ShippingInfos_ShippingInfoId1]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users_UserId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Vouchers_VoucherId] FOREIGN KEY([VoucherId])
REFERENCES [dbo].[Vouchers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Vouchers_VoucherId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Vouchers_VoucherId1] FOREIGN KEY([VoucherId1])
REFERENCES [dbo].[Vouchers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Vouchers_VoucherId1]
GO
ALTER TABLE [dbo].[PaymentGateways]  WITH CHECK ADD  CONSTRAINT [FK_PaymentGateways_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[PaymentGateways] CHECK CONSTRAINT [FK_PaymentGateways_Users_UserId]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Orders_OrderId]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_Users_UserId]
GO
ALTER TABLE [dbo].[PostsComments]  WITH CHECK ADD  CONSTRAINT [FK_PostsComments_Posts_PostsId] FOREIGN KEY([PostsId])
REFERENCES [dbo].[Posts] ([Id])
GO
ALTER TABLE [dbo].[PostsComments] CHECK CONSTRAINT [FK_PostsComments_Posts_PostsId]
GO
ALTER TABLE [dbo].[PostsComments]  WITH CHECK ADD  CONSTRAINT [FK_PostsComments_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[PostsComments] CHECK CONSTRAINT [FK_PostsComments_Users_UserId]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD  CONSTRAINT [FK_Ratings_CustomShoeDesigns_CustomShoeDesignId] FOREIGN KEY([CustomShoeDesignId])
REFERENCES [dbo].[CustomShoeDesigns] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ratings] CHECK CONSTRAINT [FK_Ratings_CustomShoeDesigns_CustomShoeDesignId]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD  CONSTRAINT [FK_Ratings_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Ratings] CHECK CONSTRAINT [FK_Ratings_Users_UserId]
GO
ALTER TABLE [dbo].[ShippingInfos]  WITH CHECK ADD  CONSTRAINT [FK_ShippingInfos_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShippingInfos] CHECK CONSTRAINT [FK_ShippingInfos_Users_UserId]
GO
ALTER TABLE [dbo].[Textures]  WITH CHECK ADD  CONSTRAINT [FK_Textures_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Textures] CHECK CONSTRAINT [FK_Textures_Users_UserId]
GO
ALTER TABLE [dbo].[UserActivities]  WITH CHECK ADD  CONSTRAINT [FK_UserActivities_CustomShoeDesigns_ViewedDesignId] FOREIGN KEY([ViewedDesignId])
REFERENCES [dbo].[CustomShoeDesigns] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserActivities] CHECK CONSTRAINT [FK_UserActivities_CustomShoeDesigns_ViewedDesignId]
GO
ALTER TABLE [dbo].[UserActivities]  WITH CHECK ADD  CONSTRAINT [FK_UserActivities_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserActivities] CHECK CONSTRAINT [FK_UserActivities_Users_UserId]
GO
ALTER TABLE [dbo].[UserRecommendations]  WITH CHECK ADD  CONSTRAINT [FK_UserRecommendations_CustomShoeDesigns_RecommendDesignId] FOREIGN KEY([RecommendDesignId])
REFERENCES [dbo].[CustomShoeDesigns] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRecommendations] CHECK CONSTRAINT [FK_UserRecommendations_CustomShoeDesigns_RecommendDesignId]
GO
ALTER TABLE [dbo].[UserRecommendations]  WITH CHECK ADD  CONSTRAINT [FK_UserRecommendations_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserRecommendations] CHECK CONSTRAINT [FK_UserRecommendations_Users_UserId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_ShippingInfos_DefaultAddressId] FOREIGN KEY([DefaultAddressId])
REFERENCES [dbo].[ShippingInfos] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_ShippingInfos_DefaultAddressId]
GO
USE [master]
GO
ALTER DATABASE [FCSP_DB] SET  READ_WRITE 
GO

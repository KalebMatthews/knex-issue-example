USE [master]
GO
/****** Object:  Database [KnexIssueExample]    Script Date: 12/8/2020 1:13:55 PM ******/
CREATE DATABASE [KnexIssueExample]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KnexIssueExample', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\KnexIssueExample.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KnexIssueExample_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\KnexIssueExample_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [KnexIssueExample] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KnexIssueExample].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KnexIssueExample] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KnexIssueExample] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KnexIssueExample] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KnexIssueExample] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KnexIssueExample] SET ARITHABORT OFF 
GO
ALTER DATABASE [KnexIssueExample] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KnexIssueExample] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KnexIssueExample] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KnexIssueExample] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KnexIssueExample] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KnexIssueExample] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KnexIssueExample] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KnexIssueExample] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KnexIssueExample] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KnexIssueExample] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KnexIssueExample] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KnexIssueExample] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KnexIssueExample] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KnexIssueExample] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KnexIssueExample] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KnexIssueExample] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KnexIssueExample] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KnexIssueExample] SET RECOVERY FULL 
GO
ALTER DATABASE [KnexIssueExample] SET  MULTI_USER 
GO
ALTER DATABASE [KnexIssueExample] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KnexIssueExample] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KnexIssueExample] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KnexIssueExample] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KnexIssueExample] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'KnexIssueExample', N'ON'
GO
ALTER DATABASE [KnexIssueExample] SET QUERY_STORE = OFF
GO
USE [KnexIssueExample]
GO
/****** Object:  Table [dbo].[primary_table]    Script Date: 12/8/2020 1:13:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[primary_table](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[data] [nvarchar](50) NOT NULL,
	[foreign_key_link] [int] NULL,
 CONSTRAINT [PK_primary_table] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[secondary_table]    Script Date: 12/8/2020 1:13:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[secondary_table](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[looping_id] [int] NOT NULL,
 CONSTRAINT [PK_secondary_table] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[primary_table]  WITH CHECK ADD  CONSTRAINT [FK_primary_table_primary_table] FOREIGN KEY([foreign_key_link])
REFERENCES [dbo].[secondary_table] ([id])
GO
ALTER TABLE [dbo].[primary_table] CHECK CONSTRAINT [FK_primary_table_primary_table]
GO
ALTER TABLE [dbo].[secondary_table]  WITH CHECK ADD  CONSTRAINT [FK_secondary_table_primary_table] FOREIGN KEY([looping_id])
REFERENCES [dbo].[primary_table] ([id])
GO
ALTER TABLE [dbo].[secondary_table] CHECK CONSTRAINT [FK_secondary_table_primary_table]
GO
USE [KnexIssueExample]
GO
/****** Object:  Trigger [dbo].[tr_knex_fail_insert]    Script Date: 12/9/2020 10:52:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_knex_fail_insert] ON [dbo].[secondary_table]
   AFTER INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN
		update pt
		set pt.foreign_key_link = i.id
		from Inserted as i
			inner join dbo.primary_table as pt
				on pt.id = i.looping_id
	END
END
USE [master]
GO
ALTER DATABASE [KnexIssueExample] SET  READ_WRITE 
GO

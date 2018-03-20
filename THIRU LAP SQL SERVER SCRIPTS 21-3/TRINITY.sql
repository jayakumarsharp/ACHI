USE [Trinity]
GO
/****** Object:  User [trinity]    Script Date: 03/21/2018 00:57:50 ******/
CREATE USER [trinity] FOR LOGIN [trinity] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tbl_venuetype_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_venuetype_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VenueType] [varchar](250) NULL,
	[VenueTypecode] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__tbl_venu__3214EC07587EC50F] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_venuetype_master] ON
INSERT [dbo].[tbl_venuetype_master] ([Id], [VenueType], [VenueTypecode], [IsActive]) VALUES (1, N'1', N'1', 0)
INSERT [dbo].[tbl_venuetype_master] ([Id], [VenueType], [VenueTypecode], [IsActive]) VALUES (2, N'2', N'2', 0)
INSERT [dbo].[tbl_venuetype_master] ([Id], [VenueType], [VenueTypecode], [IsActive]) VALUES (3, N'7', N'1', 0)
SET IDENTITY_INSERT [dbo].[tbl_venuetype_master] OFF
/****** Object:  Table [dbo].[tbl_userregionmapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_userregionmapping](
	[Userid] [varchar](250) NOT NULL,
	[RegionId] [int] NOT NULL,
	[Reserved1] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'Sivakumar', 1, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'Sivakumar', 2, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'dd', 2, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'Sivakumar', 3, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'dd', 1, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'dd', 3, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'tewt', 1, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'tewt', 2, NULL)
/****** Object:  Table [dbo].[tbl_usercountrymapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_usercountrymapping](
	[Userid] [varchar](250) NOT NULL,
	[CountryId] [int] NOT NULL,
	[Reserved1] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'Sivakumar', 1, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'Sivakumar', 2, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'Sivakumar', 3, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'dd', 1, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'Sivakumar', 4, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'Sivakumar', 6, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'Sivakumar', 5, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'dd', 2, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'dd', 4, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'dd', 3, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'dd', 6, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'dd', 5, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'tewt', 1, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'tewt', 2, NULL)
/****** Object:  Table [dbo].[tbl_userbusinesssectormapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_userbusinesssectormapping](
	[Userid] [varchar](250) NOT NULL,
	[BusinessSectorId] [int] NOT NULL,
	[Reserved1] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'Sivakumar', 1, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'dd', 1, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'Sivakumar', 2, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'Sivakumar', 4, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'Sivakumar', 3, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'dd', 2, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'dd', 4, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'dd', 3, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'tewt', 3, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'tewt', 2, NULL)
/****** Object:  Table [dbo].[tbl_user_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_user_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Userid] [varchar](255) NOT NULL,
	[UserName] [varchar](255) NULL,
	[BusinessSectorId] [varchar](255) NULL,
	[RoleId] [varchar](255) NULL,
	[Password] [nvarchar](max) NULL,
	[EmailId] [varchar](255) NULL,
	[MobileNumber] [varchar](255) NULL,
	[CustomData] [varchar](255) NULL,
	[Status] [varchar](255) NULL,
	[UserExpiryDate] [datetime2](0) NULL,
	[PasswordExpiryDate] [datetime2](0) NULL,
	[UserBlockDate] [datetime2](0) NULL,
	[AttemptTries] [int] NULL,
	[LastAuthenticatedDate] [datetime2](0) NULL,
	[LastUsedDate] [datetime2](0) NULL,
	[CreatedDate] [datetime2](0) NULL,
	[CreatedBy] [varchar](255) NULL,
	[ModifiedDate] [datetime2](0) NULL,
	[ModifiedBy] [varchar](255) NULL,
	[ApprovedDate] [datetime2](0) NULL,
	[Approvedby] [varchar](255) NULL,
	[MakerComment] [varchar](255) NULL,
	[CheckerComment] [varchar](255) NULL,
	[IsADUser] [varchar](50) NULL,
	[RegionId] [int] NULL,
	[CountryId] [int] NULL,
	[FirstWorkingDate] [datetime2](0) NULL,
	[LastWorkingDate] [datetime2](0) NULL,
	[LocationId] [int] NULL,
 CONSTRAINT [PK__tbl_user__1797D024CF2B3439] PRIMARY KEY CLUSTERED 
(
	[Userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Id] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_user_master] ON
INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (2, N'dd', N'dd', NULL, N'1', N'MTIz', N'dd@ss.co', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'No', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (1, N'Sivakumar', N'Sivakumar', NULL, N'1', N'd2VsY29tZQ==', N'Sivakumar@coba.com', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Yes', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (3, N'tewt', N'test', NULL, N'3', N'MTIzNDU=', N'test@ss.cok', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'No', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_user_master] OFF
/****** Object:  Table [dbo].[tbl_thirdpartyapplication]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_thirdpartyapplication](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ThirdPartyAppName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_thirdpartyapplication] ON
INSERT [dbo].[tbl_thirdpartyapplication] ([Id], [ThirdPartyAppName]) VALUES (1, N'Yes')
INSERT [dbo].[tbl_thirdpartyapplication] ([Id], [ThirdPartyAppName]) VALUES (2, N'No')
SET IDENTITY_INSERT [dbo].[tbl_thirdpartyapplication] OFF
/****** Object:  Table [dbo].[tbl_systemflowmaster]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_systemflowmaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemFlow] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_strategyversionlog]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_strategyversionlog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RefNumber] [varchar](50) NULL,
	[Version] [varchar](50) NULL,
	[ChangeDesc] [varchar](2000) NULL,
	[FTAShortCode] [varchar](50) NULL,
	[CreatedDate] [datetime2](0) NULL,
	[CreatedBy] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_strategyversionlog] ON
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (1, N'20180307004510747', N'1', N'Version Created', NULL, CAST(0x00970A00F73D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (2, N'20180307004510747', N'2', N' GOLiveDate - 07/03/2018 - Changed to  DecomissionedDate - 07/03/2018 - Changed to ', NULL, CAST(0x003BD700F93D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (3, N'20180307004510747', N'2', N' GOLiveDate - 07/03/2018 - Changed to  DecomissionedDate - 07/03/2018 - Changed to ', NULL, CAST(0x0056D700F93D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (4, N'20180307004510747', N'2', N' GOLiveDate - 07/03/2018 - Changed to  DecomissionedDate - 07/03/2018 - Changed to ', NULL, CAST(0x009BD700F93D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (5, N'20180307004510747', N'2', N' GOLiveDate - 07/03/2018 - Changed to  DecomissionedDate - 07/03/2018 - Changed to ', NULL, CAST(0x0028DA00F93D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (6, N'20180307004510747', N'2', N' GOLiveDate - 07/03/2018 - Changed to  DecomissionedDate - 07/03/2018 - Changed to ', NULL, CAST(0x006ADA00F93D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (7, N'20180312165941523', N'1', N'Version Created', NULL, CAST(0x0010EF00FC3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (8, N'20180312165941523', N'2', N' Attest -  - Changed to True', NULL, CAST(0x00CDF700FC3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (9, N'20180312165941523', N'2', N' Attest -  - Changed to True', NULL, CAST(0x00A5FB00FC3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (10, N'20180312165941523', N'2', N' Attest -  - Changed to True', NULL, CAST(0x0097FC00FC3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (11, N'20180312165941523', N'2', N' Attest -  - Changed to True', NULL, CAST(0x00B6FC00FC3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (12, N'20180312165941523', N'3', N'', NULL, CAST(0x00C30301FC3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (13, N'20180312165941523', N'4', N' Country Name  - india,England,Dubai, - Changed to England,Dubai', NULL, CAST(0x00570601FC3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (14, N'20180312165941523', N'5', N' AdditionalShortCode -  - Changed to 1234', NULL, CAST(0x009E0801FC3D0B0000 AS DateTime2), N'')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (15, N'20180312165941523', N'6', N' Strategytype - 1 - Changed to 2 PriorityScore - 4 - Changed to 11 Priority - 3 - Changed to 1 Capacity - 1 - Changed to 2 Status - Live - Changed to Pipeline', NULL, CAST(0x00180001FD3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (16, N'20180313181616378', N'1', N'Version Created', NULL, CAST(0x00F80001FD3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (17, N'20180313181641723', N'1', N'Version Created', NULL, CAST(0x000C0101FD3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (18, N'20180312165941523', N'7', N' Attest - True - Changed to False', NULL, CAST(0x00521E01FD3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (19, N'20180312165941523', N'8', N' Attest - False - Changed to True', NULL, CAST(0x001D2201FD3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (20, N'20180312165941523', N'9', N' Attest - True - Changed to False', NULL, CAST(0x00942201FD3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (21, N'20180312165941523', N'10', N' Attest - False - Changed to True', NULL, CAST(0x00712301FD3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (22, N'20180312165941523', N'11', N' LTAStrategyOwner - Sivakumar - Changed to dd', NULL, CAST(0x00C4B800FF3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (23, N'20180312165941523', N'12', N' LTAApplicationName - App2 - Changed to aa4 LTAApplicationOwner - Sivakumar - Changed to aaaa', NULL, CAST(0x00AACB00FF3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (24, N'20180312165941523', N'13', N' Country Name  - England,Dubai - Changed to ', NULL, CAST(0x0019D200FF3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (25, N'20180312165941523', N'13', N' Country Name  - England,Dubai - Changed to ', NULL, CAST(0x0063D200FF3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (26, N'20180312165941523', N'14', N' Attest - True - Changed to False', NULL, CAST(0x00CFA300003E0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (27, N'20180312165941523', N'15', N' Country Name  -  - Changed to india,England', NULL, CAST(0x0070D300003E0B0000 AS DateTime2), N'')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (28, N'20180318213214811', N'1', N'Version Created', NULL, CAST(0x00DF2E01023E0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (29, N'20180318213238087', N'1', N'Version Created', NULL, CAST(0x00F62E01023E0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (30, N'20180318213307630', N'1', N'Version Created', NULL, CAST(0x00142F01023E0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (31, N'20180318213307630', N'2', N' Attest - True - Changed to False', NULL, CAST(0x003B2F01023E0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (32, N'20180318213307630', N'3', N' Attest - False - Changed to True', NULL, CAST(0x005F2F01023E0B0000 AS DateTime2), N'Sivakumar')
SET IDENTITY_INSERT [dbo].[tbl_strategyversionlog] OFF
/****** Object:  Table [dbo].[tbl_strategytype_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_strategytype_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StrategyType] [varchar](250) NULL,
	[StrategyTypecode] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__tbl_stra__3214EC07B26A1E90] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_strategytype_master] ON
INSERT [dbo].[tbl_strategytype_master] ([Id], [StrategyType], [StrategyTypecode], [IsActive]) VALUES (1, N'1', N'2', 0)
INSERT [dbo].[tbl_strategytype_master] ([Id], [StrategyType], [StrategyTypecode], [IsActive]) VALUES (2, N'2', N'1', 0)
INSERT [dbo].[tbl_strategytype_master] ([Id], [StrategyType], [StrategyTypecode], [IsActive]) VALUES (3, N'3', N'3', 0)
INSERT [dbo].[tbl_strategytype_master] ([Id], [StrategyType], [StrategyTypecode], [IsActive]) VALUES (4, N'9', N'2', 0)
SET IDENTITY_INSERT [dbo].[tbl_strategytype_master] OFF
/****** Object:  Table [dbo].[tbl_StrategyStatus]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_StrategyStatus](
	[Id] [int] NOT NULL,
	[StatusName] [varchar](50) NULL,
	[Active] [varchar](5) NULL,
 CONSTRAINT [PK_tbl_StrategyStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tbl_StrategyStatus] ([Id], [StatusName], [Active]) VALUES (1, N'Live', N'Y')
INSERT [dbo].[tbl_StrategyStatus] ([Id], [StatusName], [Active]) VALUES (2, N'Pipeline', N'Y')
INSERT [dbo].[tbl_StrategyStatus] ([Id], [StatusName], [Active]) VALUES (3, N'Decommissioned', N'Y')
/****** Object:  Table [dbo].[tbl_strategyapproval]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_strategyapproval](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RefNumber] [varchar](50) NULL,
	[Version] [varchar](50) NULL,
	[Approver] [varchar](50) NULL,
	[Comments] [varchar](50) NULL,
	[ApprovedDate] [datetime2](0) NULL,
	[CreatedDate] [datetime2](0) NULL,
	[Status] [varchar](50) NULL,
	[Uploadedby] [varchar](500) NULL,
	[IsActive] [varchar](50) NULL,
	[IsTransfered] [varchar](50) NULL,
	[IsDelegateAccepted] [varchar](45) NULL,
	[IsViewed] [varchar](50) NULL,
	[IsModified] [varchar](50) NULL,
	[Type] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_strategyapproval] ON
INSERT [dbo].[tbl_strategyapproval] ([Id], [RefNumber], [Version], [Approver], [Comments], [ApprovedDate], [CreatedDate], [Status], [Uploadedby], [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]) VALUES (1, N'20180206193525885', N'2', N'Jayakumar CV.rtf', N'd8f20161-0477-4edf-9a46-74e2b90a46a8.rtf', NULL, CAST(0x00364501DA3D0B0000 AS DateTime2), N'S', N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategyapproval] ([Id], [RefNumber], [Version], [Approver], [Comments], [ApprovedDate], [CreatedDate], [Status], [Uploadedby], [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]) VALUES (2, N'20180206193525885', N'2', N'Jayakumar programmer Resume.doc', N'eb30b415-870d-4cba-ad49-8570350243bb.doc', NULL, CAST(0x00364501DA3D0B0000 AS DateTime2), N'D', N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategyapproval] ([Id], [RefNumber], [Version], [Approver], [Comments], [ApprovedDate], [CreatedDate], [Status], [Uploadedby], [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]) VALUES (3, N'20180312165941523', N'1', N'At2018 (2).xlsx', N'0b2e83be-309f-44ee-a164-25c4283ea070.xlsx', NULL, CAST(0x00FEEE00FC3D0B0000 AS DateTime2), N'S', N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategyapproval] ([Id], [RefNumber], [Version], [Approver], [Comments], [ApprovedDate], [CreatedDate], [Status], [Uploadedby], [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]) VALUES (4, N'20180312165941523', N'1', N'Centre.pdf', N'dcad13b3-6554-4c80-9773-8cbc1e5cb2d7.pdf', NULL, CAST(0x00FEEE00FC3D0B0000 AS DateTime2), N'D', N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_strategyapproval] OFF
/****** Object:  Table [dbo].[tbl_strategy]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_strategy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RefNumber] [varchar](50) NULL,
	[FTAApplicationCodeId] [int] NULL,
	[FTAStrategyCodeId] [int] NULL,
	[DiscretionaryCodeId] [int] NULL,
	[BusinessSuffixId] [int] NULL,
	[FTAShortCodeId] [varchar](50) NULL,
	[ParentId] [int] NULL,
	[ChildId] [int] NULL,
	[BusinessLineId] [int] NULL,
	[RegionId] [int] NULL,
	[FTAApplicationNameId] [int] NULL,
	[CountryIdList] [varchar](100) NULL,
	[CountryNameList] [varchar](500) NULL,
	[FTAApplicationOwnerId] [varchar](50) NULL,
	[AdditionalShortcode] [varchar](250) NULL,
	[FTAStrategyNameId] [int] NULL,
	[FTAStrategyOwnerId] [varchar](50) NULL,
	[ApplicationCategoryId] [int] NULL,
	[Priority] [int] NULL,
	[StrategyTypeId] [int] NULL,
	[PriorityScore] [int] NULL,
	[VenueTypeId] [int] NULL,
	[CapacityId] [int] NULL,
	[GoLiveDate] [date] NULL,
	[ThirdPartyAppId] [int] NULL,
	[BusinessId] [int] NULL,
	[FTAApplicationMappingId] [int] NULL,
	[FTAStrategyMappingId] [int] NULL,
	[BusinessMappingId] [int] NULL,
	[DeComissionedDate] [date] NULL,
	[Description] [varchar](max) NULL,
	[Version] [int] NOT NULL,
	[SeniorManagementFunction] [varchar](1500) NULL,
	[LTALongCode] [varchar](1500) NULL,
	[SignOff] [varchar](10) NULL,
	[SignOffDate] [datetime2](0) NULL,
	[SignoffBy] [varchar](100) NULL,
	[StatusId] [varchar](50) NULL,
	[IsActive] [varchar](1) NULL,
	[CreatedDate] [datetime2](0) NULL,
	[CreatedBy] [varchar](100) NULL,
	[LastModifiedDate] [datetime2](0) NULL,
	[LastModifiedBy] [varchar](100) NULL,
	[Res1] [varchar](250) NULL,
	[Res2] [varchar](250) NULL,
	[Res3] [varchar](250) NULL,
	[Res4] [varchar](250) NULL,
	[Res5] [varchar](250) NULL,
	[Res6] [varchar](250) NULL,
	[Res7] [varchar](250) NULL,
	[Res8] [varchar](250) NULL,
	[Res9] [varchar](250) NULL,
	[Res10] [varchar](250) NULL,
 CONSTRAINT [PK__tbl_stra__3214EC070C9A4464] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_strategy] ON
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (1, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'1', N'india', N'Sivakumar', NULL, 1, N'Sivakumar', 1, 3, 1, 4, 1, 1, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 1, N'1234', N'1234', NULL, NULL, NULL, N'1', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (2, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'1,3,2,', N'india,Dubai,England,', N'Sivakumar', NULL, 1, N'Sivakumar', 1, 3, 1, 4, 1, 1, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 2, N'1234', N'1234', N'True', NULL, NULL, N'1', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (3, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'1,2,3,', N'india,England,Dubai,', N'Sivakumar', NULL, 1, N'Sivakumar', 1, 3, 1, 4, 1, 1, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 3, N'1234', N'1234', N'True', NULL, NULL, N'1', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (4, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'2,3', N'England,Dubai', N'Sivakumar', NULL, 1, N'Sivakumar', 1, 3, 1, 4, 1, 1, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 4, N'1234', N'1234', N'True', NULL, NULL, N'1', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (5, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'2,3', N'England,Dubai', N'Sivakumar', N'1234', 1, N'Sivakumar', 1, 3, 1, 4, 1, 1, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 5, N'1234', N'1234', N'True', NULL, NULL, N'1', N'N', NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (6, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'2,3', N'England,Dubai', N'Sivakumar', N'1234', 1, N'Sivakumar', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 6, N'1234', N'1234', N'True', NULL, NULL, N'2', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (7, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'2,3', N'England,Dubai', N'Sivakumar', N'1234', 1, N'Sivakumar', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 7, N'1234', N'1234', N'False', NULL, NULL, N'2', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (8, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'2,3', N'England,Dubai', N'Sivakumar', N'1234', 1, N'Sivakumar', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 8, N'1234', N'1234', N'True', NULL, NULL, N'2', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (9, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'2,3', N'England,Dubai', N'Sivakumar', N'1234', 1, N'Sivakumar', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 9, N'1234', N'1234', N'False', NULL, NULL, N'2', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (10, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'2,3', N'England,Dubai', N'Sivakumar', N'1234', 1, N'Sivakumar', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 10, N'1234', N'1234', N'True', NULL, NULL, N'2', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (11, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 1, N'2,3', N'England,Dubai', N'Sivakumar', N'1234', 1, N'dd', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 8, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 11, N'1234', N'1234', N'True', NULL, NULL, N'2', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (12, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 3, N'2,3', N'England,Dubai', N'aaaa', N'1234', 1, N'dd', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 9, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 12, N'1234', N'1234', N'True', NULL, NULL, N'2', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (13, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 3, NULL, NULL, N'aaaa', N'1234', 1, N'dd', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 9, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 13, N'1234', N'1234', N'True', NULL, NULL, N'2', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (14, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 3, NULL, NULL, N'aaaa', N'1234', 1, N'dd', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 9, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 14, N'1234', N'1234', N'False', NULL, NULL, N'2', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (15, N'20180312165941523', 1, 1, 1, 1, N'1234512345123455', 1, 1, 1, 1, 3, N'1,2', N'india,England', N'aaaa', N'1234', 1, N'dd', 1, 1, 2, 11, 2, 2, CAST(0xFC3D0B00 AS Date), 1, 1, 9, 1, 1, CAST(0xFC3D0B00 AS Date), N'test', 15, N'1234', N'1234', N'False', NULL, NULL, N'2', N'Y', NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (16, N'20180318213307630', 2, 1, 1, 1, N'123451123455', 1, 2, 3, 1, 2, N'1,2', N'india,England', N'12345', N'55', 1, N'Sivakumar', 3, 3, 2, 4, 2, 1, CAST(0x023E0B00 AS Date), 1, 1, 10, 1, 1, CAST(0x023E0B00 AS Date), N'sddd', 1, N'1', N'11', N'True', NULL, NULL, N'1', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (17, N'20180318213307630', 2, 1, 1, 1, N'123451123455', 1, 2, 3, 1, 2, N'1,2', N'india,England', N'12345', N'55', 1, N'Sivakumar', 3, 3, 2, 4, 2, 1, CAST(0x023E0B00 AS Date), 1, 1, 10, 1, 1, CAST(0x023E0B00 AS Date), N'sddd', 2, N'1', N'11', N'False', NULL, NULL, N'1', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [AdditionalShortcode], [FTAStrategyNameId], [FTAStrategyOwnerId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (18, N'20180318213307630', 2, 1, 1, 1, N'123451123455', 1, 2, 3, 1, 2, N'1,2', N'india,England', N'12345', N'55', 1, N'Sivakumar', 3, 3, 2, 4, 2, 1, CAST(0x023E0B00 AS Date), 1, 1, 10, 1, 1, CAST(0x023E0B00 AS Date), N'sddd', 3, N'1', N'11', N'True', NULL, NULL, N'1', N'Y', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_strategy] OFF
/****** Object:  Table [dbo].[tbl_roleright_mapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_roleright_mapping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[RightID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_roleright_mapping] ON
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (144, 2, 1)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (145, 2, 9)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (146, 2, 6)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (147, 2, 8)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1141, 1, 3)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1142, 1, 4)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1143, 1, 5)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1144, 1, 7)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1145, 1, 8)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1146, 1, 9)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1147, 1, 10)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1148, 1, 11)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1149, 1, 12)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1150, 1, 13)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1151, 1, 6)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1152, 1, 1)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1153, 1, 2)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1154, 1, 14)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (1155, 3, 9)
SET IDENTITY_INSERT [dbo].[tbl_roleright_mapping] OFF
/****** Object:  Table [dbo].[tbl_role_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_role_master](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](255) NULL,
	[CreatedDate] [datetime2](0) NULL,
	[CreatedBy] [varchar](255) NULL,
	[ModifiedDate] [datetime2](0) NULL,
	[ModifiedBy] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_role_master] ON
INSERT [dbo].[tbl_role_master] ([id], [RoleName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'Super Admin', NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_role_master] ([id], [RoleName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'testing', NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_role_master] ([id], [RoleName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (3, N'test', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_role_master] OFF
/****** Object:  Table [dbo].[tbl_right_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_right_master](
	[RightID] [int] NULL,
	[RightName] [varchar](255) NULL,
	[MenuName] [varchar](255) NULL,
	[Path] [varchar](255) NULL,
	[Icon] [varchar](255) NULL,
	[ShowMenu] [varchar](255) NULL,
	[IsActive] [varchar](2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (1, N'Home', N'Home', N'Index', N'fa fa-dashboard', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (2, N'LTA Read Only', N' LTA Strategy Inventory', N'ModelAlgoManagement', N'fa fa-list', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (3, N'LTA Write Access', N' LTA Strategy Inventory', N'ModelAlgoManagement', N'fa fa-list', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (4, N'LTA Strategy Owner', N' LTA Strategy Inventory', N'ModelAlgoManagement', N'fa fa-list', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (6, N'Role Management Read', N'Role Management', N'RoleManagement', N'fa fa-list-alt', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (7, N'Role Management Write', N'Role Management', N'RoleManagement', N'fa fa-list-alt', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (8, N'User Management Read', N'User Management', N'UserManagement', N'fa fa-users', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (9, N'User Management Write', N'User Management', N'UserManagement', N'fa fa-users', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (10, N'Master Page Read', N'Master Page', N'MasterPage', N'fa fa-star', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (11, N'Master Page Write', N'Master Page', N'MasterPage', N'fa fa-star', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (12, N'Mapping Page Read', N'Mapping Page', N'MappingMaster', N'fa fa-star-o', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (13, N'Mapping Page Write', N'Mapping Page', N'MappingMaster', N'fa fa-star-o', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (14, N'Reports', N'Report', N'Reports', N'fa fa-list-alt', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (5, N'LTA Application Inventory', N'LTA Application Inventory', N'ReportApplicationMapping', N'fa fa-archive', N'true', N'Y')
/****** Object:  Table [dbo].[tbl_reportapplicationmapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_reportapplicationmapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FTAApplicationNameId] [int] NOT NULL,
	[FTAApplicationCodeId] [int] NOT NULL,
	[ParentId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[ThirdPartyAppId] [int] NOT NULL,
	[ApplicationCategoryId] [int] NOT NULL,
	[ApplicationOwnerId] [varchar](500) NOT NULL,
	[RegionId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[BusinessLineId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_reportapplicationmapping] ON
INSERT [dbo].[tbl_reportapplicationmapping] ([Id], [FTAApplicationNameId], [FTAApplicationCodeId], [ParentId], [ChildId], [ThirdPartyAppId], [ApplicationCategoryId], [ApplicationOwnerId], [RegionId], [CountryId], [BusinessLineId]) VALUES (8, 1, 1, 1, 1, 1, 1, N'Sivakumar', 1, 0, 1)
SET IDENTITY_INSERT [dbo].[tbl_reportapplicationmapping] OFF
/****** Object:  Table [dbo].[tbl_region_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_region_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RegionName] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_region_master] ON
INSERT [dbo].[tbl_region_master] ([Id], [RegionName]) VALUES (1, N'India1')
INSERT [dbo].[tbl_region_master] ([Id], [RegionName]) VALUES (2, N'234234')
INSERT [dbo].[tbl_region_master] ([Id], [RegionName]) VALUES (3, N'5')
SET IDENTITY_INSERT [dbo].[tbl_region_master] OFF
/****** Object:  Table [dbo].[tbl_priority_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_priority_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Priority] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_parentid_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_parentid_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_parentid_master] ON
INSERT [dbo].[tbl_parentid_master] ([Id], [ParentId], [IsActive]) VALUES (1, N'12334', 0)
INSERT [dbo].[tbl_parentid_master] ([Id], [ParentId], [IsActive]) VALUES (2, N'5', 0)
SET IDENTITY_INSERT [dbo].[tbl_parentid_master] OFF
/****** Object:  Table [dbo].[tbl_ftastrategyowner_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ftastrategyowner_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FTAStrategyOwner] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ftastrategynamemapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ftastrategynamemapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FTAStrategyNameId] [int] NOT NULL,
	[FTAStrategyCodeId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_ftastrategynamemapping] ON
INSERT [dbo].[tbl_ftastrategynamemapping] ([Id], [FTAStrategyNameId], [FTAStrategyCodeId]) VALUES (1, 1, 1)
SET IDENTITY_INSERT [dbo].[tbl_ftastrategynamemapping] OFF
/****** Object:  Table [dbo].[tbl_ftastrategyname_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ftastrategyname_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FTAStrategyName] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_ftastrategyname_master] ON
INSERT [dbo].[tbl_ftastrategyname_master] ([Id], [FTAStrategyName], [IsActive]) VALUES (1, N'1', 0)
INSERT [dbo].[tbl_ftastrategyname_master] ([Id], [FTAStrategyName], [IsActive]) VALUES (2, N'2', 0)
SET IDENTITY_INSERT [dbo].[tbl_ftastrategyname_master] OFF
/****** Object:  Table [dbo].[tbl_ftastrategycode_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ftastrategycode_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FTAStrategyCode] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_ftastrategycode_master] ON
INSERT [dbo].[tbl_ftastrategycode_master] ([Id], [FTAStrategyCode], [IsActive]) VALUES (1, N'12345', 0)
INSERT [dbo].[tbl_ftastrategycode_master] ([Id], [FTAStrategyCode], [IsActive]) VALUES (2, N'5', 0)
SET IDENTITY_INSERT [dbo].[tbl_ftastrategycode_master] OFF
/****** Object:  Table [dbo].[tbl_ftaapplicationowner_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ftaapplicationowner_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FTAApplicationOwner] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ftaapplicationname_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ftaapplicationname_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FTAApplicationName] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationname_master] ON
INSERT [dbo].[tbl_ftaapplicationname_master] ([Id], [FTAApplicationName], [IsActive]) VALUES (1, N'App256', 0)
INSERT [dbo].[tbl_ftaapplicationname_master] ([Id], [FTAApplicationName], [IsActive]) VALUES (2, N'aa', 0)
INSERT [dbo].[tbl_ftaapplicationname_master] ([Id], [FTAApplicationName], [IsActive]) VALUES (3, N'aa4', 0)
INSERT [dbo].[tbl_ftaapplicationname_master] ([Id], [FTAApplicationName], [IsActive]) VALUES (4, N'ee', 0)
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationname_master] OFF
/****** Object:  Table [dbo].[tbl_ftaapplicationmapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ftaapplicationmapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FTAApplicationNameId] [int] NOT NULL,
	[FTAApplicationCodeId] [int] NOT NULL,
	[ChildId] [int] NOT NULL,
	[ThirdPartyAppId] [int] NOT NULL,
	[ParentId] [int] NOT NULL,
	[ApplicationOwnerId] [varchar](500) NOT NULL,
	[ApplicationCategoryId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationmapping] ON
INSERT [dbo].[tbl_ftaapplicationmapping] ([Id], [FTAApplicationNameId], [FTAApplicationCodeId], [ChildId], [ThirdPartyAppId], [ParentId], [ApplicationOwnerId], [ApplicationCategoryId]) VALUES (8, 1, 1, 1, 1, 1, N'kumar', 1)
INSERT [dbo].[tbl_ftaapplicationmapping] ([Id], [FTAApplicationNameId], [FTAApplicationCodeId], [ChildId], [ThirdPartyAppId], [ParentId], [ApplicationOwnerId], [ApplicationCategoryId]) VALUES (9, 3, 1, 1, 1, 1, N'aaaa', 1)
INSERT [dbo].[tbl_ftaapplicationmapping] ([Id], [FTAApplicationNameId], [FTAApplicationCodeId], [ChildId], [ThirdPartyAppId], [ParentId], [ApplicationOwnerId], [ApplicationCategoryId]) VALUES (10, 2, 2, 2, 1, 1, N'12345', 3)
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationmapping] OFF
/****** Object:  Table [dbo].[tbl_ftaapplicationcode_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ftaapplicationcode_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FTAApplicationCode] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationcode_master] ON
INSERT [dbo].[tbl_ftaapplicationcode_master] ([Id], [FTAApplicationCode], [IsActive]) VALUES (1, N'12345', 0)
INSERT [dbo].[tbl_ftaapplicationcode_master] ([Id], [FTAApplicationCode], [IsActive]) VALUES (2, N'1', 0)
INSERT [dbo].[tbl_ftaapplicationcode_master] ([Id], [FTAApplicationCode], [IsActive]) VALUES (3, N'2', 0)
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationcode_master] OFF
/****** Object:  Table [dbo].[tbl_discretionarycode_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_discretionarycode_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Discretionarycode] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_discretionarycode_master] ON
INSERT [dbo].[tbl_discretionarycode_master] ([Id], [Discretionarycode], [IsActive]) VALUES (1, N'12345', 0)
INSERT [dbo].[tbl_discretionarycode_master] ([Id], [Discretionarycode], [IsActive]) VALUES (2, N'6', 0)
SET IDENTITY_INSERT [dbo].[tbl_discretionarycode_master] OFF
/****** Object:  Table [dbo].[tbl_CountryStrategyMapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_CountryStrategyMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StrategyId] [int] NULL,
	[CountryId] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_CountryStrategyMapping] ON
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (1, 1, 1)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (2, 1, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (3, 2, 1)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (4, 2, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (5, 2, 0)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (6, 1, 1)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (7, 2, 1)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (8, 2, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (9, 2, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (10, 2, 0)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (11, 3, 1)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (12, 3, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (13, 3, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (14, 3, 0)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (15, 4, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (16, 4, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (17, 5, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (18, 5, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (19, 6, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (20, 6, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (21, 7, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (22, 7, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (23, 8, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (24, 8, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (25, 9, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (26, 9, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (29, 11, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (30, 11, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (31, 12, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (32, 12, 3)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (33, 15, 1)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (34, 15, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (35, 16, 1)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (36, 16, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (37, 17, 1)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (38, 17, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (39, 18, 1)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (40, 18, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (27, 10, 2)
INSERT [dbo].[tbl_CountryStrategyMapping] ([Id], [StrategyId], [CountryId]) VALUES (28, 10, 3)
SET IDENTITY_INSERT [dbo].[tbl_CountryStrategyMapping] OFF
/****** Object:  Table [dbo].[tbl_CountryReportMapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_CountryReportMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReportId] [int] NULL,
	[CountryId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_country_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_country_master](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_country_master] ON
INSERT [dbo].[tbl_country_master] ([id], [CountryName]) VALUES (1, N'india')
INSERT [dbo].[tbl_country_master] ([id], [CountryName]) VALUES (2, N'England')
INSERT [dbo].[tbl_country_master] ([id], [CountryName]) VALUES (3, N'Dubai')
INSERT [dbo].[tbl_country_master] ([id], [CountryName]) VALUES (4, N'Netherland')
INSERT [dbo].[tbl_country_master] ([id], [CountryName]) VALUES (5, N'Americas')
INSERT [dbo].[tbl_country_master] ([id], [CountryName]) VALUES (6, N'1')
SET IDENTITY_INSERT [dbo].[tbl_country_master] OFF
/****** Object:  Table [dbo].[tbl_childid_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_childid_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChildID] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_childid_master] ON
INSERT [dbo].[tbl_childid_master] ([Id], [ChildID], [IsActive]) VALUES (1, N'1234', 0)
INSERT [dbo].[tbl_childid_master] ([Id], [ChildID], [IsActive]) VALUES (2, N'1', 0)
INSERT [dbo].[tbl_childid_master] ([Id], [ChildID], [IsActive]) VALUES (3, N'2', 0)
SET IDENTITY_INSERT [dbo].[tbl_childid_master] OFF
/****** Object:  Table [dbo].[tbl_capacity_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_capacity_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Capacity] [varchar](250) NULL,
	[Capacitycode] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__tbl_capa__3214EC0702579EAF] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_capacity_master] ON
INSERT [dbo].[tbl_capacity_master] ([Id], [Capacity], [Capacitycode], [IsActive]) VALUES (1, N'1', N'1', 0)
INSERT [dbo].[tbl_capacity_master] ([Id], [Capacity], [Capacitycode], [IsActive]) VALUES (2, N'2', N'8', 0)
SET IDENTITY_INSERT [dbo].[tbl_capacity_master] OFF
/****** Object:  Table [dbo].[tbl_businesssuffix_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_businesssuffix_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BusinessSuffix] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_businesssuffix_master] ON
INSERT [dbo].[tbl_businesssuffix_master] ([Id], [BusinessSuffix], [IsActive]) VALUES (1, N'5', 0)
INSERT [dbo].[tbl_businesssuffix_master] ([Id], [BusinessSuffix], [IsActive]) VALUES (2, N'1', 0)
SET IDENTITY_INSERT [dbo].[tbl_businesssuffix_master] OFF
/****** Object:  Table [dbo].[tbl_businesssector]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_businesssector](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_businessmapping]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_businessmapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BusinessId] [int] NOT NULL,
	[BusinessSuffixId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_businessmapping] ON
INSERT [dbo].[tbl_businessmapping] ([Id], [BusinessId], [BusinessSuffixId]) VALUES (1, 1, 1)
INSERT [dbo].[tbl_businessmapping] ([Id], [BusinessId], [BusinessSuffixId]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [dbo].[tbl_businessmapping] OFF
/****** Object:  Table [dbo].[tbl_businessline_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_businessline_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BusinessLine] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_businessline_master] ON
INSERT [dbo].[tbl_businessline_master] ([Id], [BusinessLine], [IsActive]) VALUES (1, N'5', 0)
INSERT [dbo].[tbl_businessline_master] ([Id], [BusinessLine], [IsActive]) VALUES (2, N'1', 0)
INSERT [dbo].[tbl_businessline_master] ([Id], [BusinessLine], [IsActive]) VALUES (3, N'5', 0)
INSERT [dbo].[tbl_businessline_master] ([Id], [BusinessLine], [IsActive]) VALUES (4, N'1', 0)
SET IDENTITY_INSERT [dbo].[tbl_businessline_master] OFF
/****** Object:  Table [dbo].[tbl_business_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_business_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[business] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_business_master] ON
INSERT [dbo].[tbl_business_master] ([Id], [business], [IsActive]) VALUES (1, N'ss2', 0)
INSERT [dbo].[tbl_business_master] ([Id], [business], [IsActive]) VALUES (2, N'1', 0)
SET IDENTITY_INSERT [dbo].[tbl_business_master] OFF
/****** Object:  Table [dbo].[tbl_applicationcategory_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_applicationcategory_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationCategory] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_applicationcategory_master] ON
INSERT [dbo].[tbl_applicationcategory_master] ([Id], [ApplicationCategory], [IsActive]) VALUES (1, N'ac', 0)
INSERT [dbo].[tbl_applicationcategory_master] ([Id], [ApplicationCategory], [IsActive]) VALUES (2, N'aa', 0)
INSERT [dbo].[tbl_applicationcategory_master] ([Id], [ApplicationCategory], [IsActive]) VALUES (3, N'ac3', 0)
SET IDENTITY_INSERT [dbo].[tbl_applicationcategory_master] OFF
/****** Object:  Table [dbo].[tbl_aduser_master]    Script Date: 03/21/2018 00:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_aduser_master](
	[Userid] [varchar](255) NOT NULL,
	[UserName] [varchar](255) NULL,
	[EmailId] [varchar](255) NULL,
	[MobileNumber] [varchar](255) NULL,
	[st] [varchar](255) NULL,
	[postalCode] [varchar](255) NULL,
	[physicalDeliveryOfficeName] [varchar](255) NULL,
	[telephoneNumber] [varchar](255) NULL,
	[department] [varchar](255) NULL,
	[streetAddress] [varchar](255) NULL,
	[manager] [varchar](255) NULL,
	[homePhone] [varchar](255) NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 03/21/2018 00:57:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]
(    
      @Input NVARCHAR(MAX),
      @Character CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
      BEGIN
            SET @Input = @Input + @Character
      END
 
      WHILE CHARINDEX(@Character, @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(@Character, @Input)
           
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
           
            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
      END
 
      RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_SystemFlow]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_SystemFlow](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_SystemFlow_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_ApplicationMaster]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_ApplicationMaster](
 @i_id INT

)
AS
BEGIN
delete from tbl_ApplicationMaster where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallProduct]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallProduct
CREATE  PROCEDURE [dbo].[sp_getallProduct](
 @i_Id VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

if(@i_Id !='') begin

select * from tbl_ProductTypemaster where Id=@i_id;
end
else begin
select * from tbl_ProductTypemaster;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[SP_StrategyReport]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_StrategyReport](
 @i_business VARCHAR(50)=null,
 @i_businessline VARCHAR(50)=null,
 @i_strategyname VARCHAR(50)=null,
 @i_ltastrategyowner VARCHAR(50)=null,
 @i_region VARCHAR(50)=null,
 @i_ltaapplication VARCHAR(50)=null,
 @i_priority VARCHAR(50)=null,
 @i_status VARCHAR(50)=null,
 @i_userid VARCHAR(250)
)
AS
BEGIN
declare @Sql nvarchar(max);
declare @dynamicsql nvarchar(max);



SET @sql='select S.Id,S.RefNumber,FTAApplicationCodeId,FTAAC.FTAApplicationCode,FTAShortCodeId,FTAStrategyCodeId,FTASC.FTAStrategyCode,DiscretionaryCodeId,
DM.Discretionarycode,BusinessSuffixId,BSFM.BusinessSuffix,FTAStrategyCode,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,
BSL.BusinessLine,RegionId,R.RegionName,FTAApplicationNameId,APN.FTAApplicationName,FTAStrategyOwnerId,ApplicationCategoryId,ACM.ApplicationCategory,
StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,Version,FTAStrategyNameId,FTASN.FTAStrategyName,S.FTAApplicationOwnerId,
S.Priority,S.PriorityScore,case SignOff  WHEN ''True'' THEN ''Attested'' else ''Pending'' end as SignOff
,SignOffDate,SignoffBy,LastModifiedDate ,LastModifiedBy,ThirdPartyAppId,TM.ThirdPartyAppName,
BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,
S.DecomissionedDate,GoLiveDate,
S.StatusId,Ss.StatusName,AdditionalShortCode,
CountryIdList=STUFF  
(  
    (  
      SELECT DISTINCT '', ''+ CAST( C.id AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryStrategyMapping e   
      FOR XMl PATH('''')  
    ),1,1,''''  
)  ,
CountryNameList=STUFF  
(  
    (  
      SELECT DISTINCT '', ''+ CAST( C.CountryName AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryStrategyMapping e   
       FOR XMl PATH('''')  
    ),1,1,''''  
)  ,


SeniorManagementFunction,LTALongCode from tbl_strategy S 
join tbl_ftaapplicationcode_master FTAAC On S.FTAApplicationCodeId = FTAAC.Id 
join tbl_ftastrategycode_master FTASC on S.FTAStrategyCodeId = FTASC.Id 
JOin tbl_discretionarycode_master DM on s.DiscretionaryCodeId = DM.Id 
JOin tbl_businesssuffix_master BSFM on s.BusinessSuffixId = BSFM.Id 
JOIN tbl_parentid_master PM on s.ParentId = PM.Id 
join tbl_childid_master CM on S.ChildId = CM.Id 
JOIn tbl_businessline_master BSL on BusinessLineId = BSL.Id  
JOIN tbl_region_master R on S.RegionId = R.id 
JOIN tbl_ftaapplicationname_master APN on S.FTAApplicationNameId = APN.Id 
JOIN tbl_applicationcategory_master ACM on S.ApplicationCategoryId = ACM.Id 
JOIN tbl_ftastrategyname_master FTASN on S.FTAStrategyNameId = FTASN.Id 
JOIN tbl_strategytype_master STM on S.StrategyTypeId = STM.Id 
JOIN tbl_venuetype_master VTM on S.VenueTypeId = VTM.Id 
JOIN tbl_thirdpartyapplication TM on S.ThirdPartyAppId = TM.Id JOIN tbl_business_master BM on S.BusinessId = BM.Id 
JOIN tbl_capacity_master CPM on S.CapacityId = CPM.Id 
JOIN tbl_StrategyStatus ss on ss.Id=s.StatusId
right JOIN (SELECT  MAX(Id) as Id FROM tbl_strategy GROUP BY REfnumber) t2  ON S.ID = t2.Id where BusinessLineId in( select b.Id from tbl_userBusinessSectormapping bs join tbl_businessLine_master b  on bs.BusinessSectorId =b.Id where Userid='''+@i_userid+''')
 and RegionId in( select r.Id from tbl_userregionmapping rm join tbl_region_master r on rm.RegionId = r.Id where Userid='''+@i_userid+''')
  ';

SET @dynamicsql='';
if (@i_business != '' and @i_business is not null) begin
SET @dynamicsql=@dynamicsql+' and BusinessId in ('+@i_business+')';
end 


if (@i_businessline IS NOT NULL and @i_businessline != '') begin

SET @dynamicsql=@dynamicsql+'  and BusinessLineId in ('+@i_businessline+')';
end 

if (@i_strategyname != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and  FTAStrategyNameId in ('+@i_strategyname+')';
end 


if (@i_ltaapplication != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and FTAApplicationCodeId in ('+@i_ltaapplication +')';
end 



if (@i_ltastrategyowner != '') begin

SET  @dynamicsql=@dynamicsql+' and FTAStrategyOwnerId in ('+@i_ltastrategyowner+')';
end 


if (@i_region IS NOT NULL and @i_region != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and RegionId in ('+@i_region+')';
end 


if (@i_priority != '') begin

	

SET  @dynamicsql=@dynamicsql+'  and priority='+@i_priority;
end 



if (@i_status IS NOT NULL and @i_status != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and Statusid='+@i_status;
end 
	

	SET  @sql=@sql +@dynamicsql;

	
print(@sql)
EXECUTE (@sql);

END;
GO
/****** Object:  Table [dbo].[BusinessSector]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BusinessSector](
	[Id] [varchar](50) NULL,
	[Name] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[BusinessSector] ([Id], [Name]) VALUES (N'1', N'Jay')
INSERT [dbo].[BusinessSector] ([Id], [Name]) VALUES (N'2', N'kumar')
INSERT [dbo].[BusinessSector] ([Id], [Name]) VALUES (N'1', N'Jay')
INSERT [dbo].[BusinessSector] ([Id], [Name]) VALUES (N'2', N'kumar')
/****** Object:  StoredProcedure [dbo].[sp_getallApplicationMaster]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_getallApplicationMaster](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;
if(@i_Id !='') begin

select * from tbl_ApplicationMaster where Id=@i_id;
end
else begin
select * from tbl_ApplicationMaster;
end 
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallSystemFlow]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallSystemFlow
CREATE  PROCEDURE [dbo].[sp_getallSystemFlow](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_SystemFlow_master where Id=@i_id;
end
else begin
select * from tbl_SystemFlow_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallStrategytype]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallStrategytype
CREATE  PROCEDURE [dbo].[sp_getallStrategytype](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_Strategytype_master where Id=@i_id;
end
else begin
select * from tbl_Strategytype_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallStrategyStatus]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallVenuetype
create PROCEDURE [dbo].[sp_getallStrategyStatus](
 @i_Id VARCHAR(50)
)
AS
BEGIN
if(@i_Id !='') begin
select * from tbl_StrategyStatus where Id=@i_id;
end
else begin
select * from tbl_StrategyStatus;
end 
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllStrategybyId]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllStrategybyId](
@i_RefNumber varchar(100)
)
AS
BEGIN

select S.Id,S.RefNumber,FTAApplicationCodeId,FTAAC.FTAApplicationCode,FTAShortCodeId,CountryNameList,FTAStrategyCodeId,FTASC.FTAStrategyCode,DiscretionaryCodeId,DM.Discretionarycode,BusinessSuffixId,BSFM.BusinessSuffix,
FTAStrategyCode,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,BSL.BusinessLine,RegionId,R.RegionName,FTAApplicationNameId,APN.FTAApplicationName,FTAApplicationOwnerId,ApplicationCategoryId,
ACM.ApplicationCategory,StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,Version,FTAStrategyNameId,FTASN.FTAStrategyName,
S.FTAStrategyOwnerId,S.Priority,S.PriorityScore, SignOff,SignOffDate,SignoffBy,LastModifiedDate ,LastModifiedBy,ThirdPartyAppId,TM.ThirdPartyAppName,BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,
S.StatusId,Ss.StatusName,AdditionalShortCode,
CountryIdList=STUFF  
(  
    (  
      SELECT DISTINCT ', '+ CAST( C.id AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryStrategyMapping e   
      WHERE C.iD=e.CountryId and e.StrategyId=s.Id   
      FOR XMl PATH('')  
    ),1,1,''  
)  ,
CountryName=STUFF  
(  
    (  
      SELECT DISTINCT ', '+ CAST( C.CountryName AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryStrategyMapping e   
      WHERE C.iD=e.CountryId and e.StrategyId=s.Id   
      FOR XMl PATH('')  
    ),1,1,''  
)  ,
  
convert(NVARCHAR, S.DecomissionedDate, 103) DecomissionedDate,convert(NVARCHAR, S.GoLiveDate, 103) GoLiveDate,SeniorManagementFunction,LTALongCode from tbl_strategy S join tbl_ftaapplicationcode_master FTAAC On S.FTAApplicationCodeId = FTAAC.Id 
join tbl_ftastrategycode_master FTASC on S.FTAStrategyCodeId = FTASC.Id JOin tbl_discretionarycode_master DM on s.DiscretionaryCodeId = DM.Id JOin tbl_businesssuffix_master BSFM on s.BusinessSuffixId = BSFM.Id 
JOIN tbl_parentid_master PM on s.ParentId = PM.Id join tbl_childid_master CM on S.ChildId = CM.Id JOIn tbl_businessline_master BSL on BusinessLineId = BSL.Id  JOIN tbl_region_master R on S.RegionId = R.id JOIN 
tbl_ftaapplicationname_master APN on S.FTAApplicationNameId = APN.Id JOIN tbl_applicationcategory_master ACM on S.ApplicationCategoryId = ACM.Id JOIN tbl_ftastrategyname_master FTASN on S.FTAStrategyNameId = FTASN.Id JOIN tbl_strategytype_master STM on S.StrategyTypeId = STM.Id JOIN tbl_venuetype_master 
VTM on S.VenueTypeId = VTM.Id JOIN tbl_thirdpartyapplication TM on S.ThirdPartyAppId = TM.Id JOIN tbl_business_master BM on S.BusinessId = BM.Id JOIN tbl_capacity_master CPM on S.CapacityId = CPM.Id 

JOIN tbl_StrategyStatus ss on ss.Id=s.StatusId
right JOIN (SELECT  MAX(Id) as Id FROM tbl_strategy GROUP BY REfnumber) t2  
ON S.ID = t2.Id WHERE s.id is not null and S.Id = @i_RefNumber 
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllStrategy]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_GetAllStrategy]
(
 @i_userid VARCHAR(250)


)
AS
BEGIN
;With CompleteResult as(

select S.Id,S.RefNumber,FTAApplicationCodeId,FTAAC.FTAApplicationCode,FTAShortCodeId,CountryNameList,
CountryIdList=STUFF  
(  
    (  
      SELECT DISTINCT ', '+ CAST( C.id AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryStrategyMapping e   
      WHERE C.iD=e.CountryId and e.StrategyId=s.Id   
      FOR XMl PATH('')  
    ),1,1,''  
)  ,
CountryName=STUFF  
(  
    (  
      SELECT DISTINCT ', '+ CAST( C.CountryName AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryStrategyMapping e   
      WHERE C.iD=e.CountryId and e.StrategyId=s.Id   
      FOR XMl PATH('')  
    ),1,1,''  
)  ,
    
FTAStrategyCodeId,FTASC.FTAStrategyCode,DiscretionaryCodeId,DM.Discretionarycode,BusinessSuffixId,BSFM.BusinessSuffix,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,BSL.BusinessLine,RegionId,R.RegionName,FTAApplicationNameId,APN.FTAApplicationName,FTAApplicationOwnerId,ApplicationCategoryId,
ACM.ApplicationCategory,StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,Version,FTAStrategyNameId,FTASN.FTAStrategyName,
S.FTAStrategyOwnerId,S.Priority,S.PriorityScore, SignOff,SignOffDate,SignoffBy,ThirdPartyAppId,TM.ThirdPartyAppName,BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,
S.StatusId,Ss.StatusName,AdditionalShortCode,
convert(NVARCHAR, S.DecomissionedDate, 103) DecomissionedDate,convert(NVARCHAR, S.GoLiveDate, 103) GoLiveDate,SeniorManagementFunction,LTALongCode from tbl_strategy S join tbl_ftaapplicationcode_master FTAAC On S.FTAApplicationCodeId = FTAAC.Id 
join tbl_ftastrategycode_master FTASC on S.FTAStrategyCodeId = FTASC.Id JOin tbl_discretionarycode_master DM on s.DiscretionaryCodeId = DM.Id JOin tbl_businesssuffix_master BSFM on s.BusinessSuffixId = BSFM.Id 
JOIN tbl_parentid_master PM on s.ParentId = PM.Id join tbl_childid_master CM on S.ChildId = CM.Id JOIn tbl_businessline_master BSL on BusinessLineId = BSL.Id  JOIN tbl_region_master R on S.RegionId = R.id JOIN 
tbl_ftaapplicationname_master APN on S.FTAApplicationNameId = APN.Id JOIN tbl_applicationcategory_master ACM on S.ApplicationCategoryId = ACM.Id JOIN tbl_ftastrategyname_master FTASN on S.FTAStrategyNameId = FTASN.Id JOIN tbl_strategytype_master STM on S.StrategyTypeId = STM.Id JOIN tbl_venuetype_master 
VTM on S.VenueTypeId = VTM.Id JOIN tbl_thirdpartyapplication TM on S.ThirdPartyAppId = TM.Id JOIN tbl_business_master BM on S.BusinessId = BM.Id JOIN tbl_capacity_master CPM on S.CapacityId = CPM.Id 


JOIN tbl_StrategyStatus ss on ss.Id=s.StatusId
right JOIN (SELECT  MAX(Id) as Id FROM tbl_strategy GROUP BY REfnumber) t2  
ON S.ID = t2.Id where  s.id is not null 
)


select * from CompleteResult
 where BusinessLineId in( select b.Id from tbl_userBusinessSectormapping bs join tbl_businessLine_master b  on bs.BusinessSectorId =b.Id where Userid=@i_userid)
 and RegionId in( select r.Id from tbl_userregionmapping rm join tbl_region_master r on rm.RegionId = r.Id where  Userid=@i_userid)
 
 END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallregion]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallregion
CREATE  PROCEDURE [dbo].[sp_getallregion](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

if(@i_Id !='') begin

select * from tbl_region_master where Id=@i_id;
end
else begin
select * from tbl_region_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallApplicationCategory]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_getallApplicationCategory](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') 
begin
select * from tbl_ApplicationCategory_master where Id=@i_id;
end
else begin
select * from tbl_ApplicationCategory_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_strategyVersionLog]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_get_strategyVersionLog
CREATE  PROCEDURE [dbo].[sp_get_strategyVersionLog](
 @i_id VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

select * from tbl_strategyversionlog where RefNumber=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteRole]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteRole](
 @i_id INT
)
AS
BEGIN
SET NOCOUNT ON;

delete from tbl_role_master where id=@i_id;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_deleteReportApplicationMapping]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_deleteFTAApplicationMapping
CREATE  PROCEDURE [dbo].[sp_deleteReportApplicationMapping](
 @i_id VARCHAR(50),
 @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN
SET NOCOUNT ON;

 
delete from tbl_reportapplicationmapping where id =@i_id;
DELETE FROM tbl_CountryReportMapping WHERE ReportId =@i_id;
set @i_OutParam ='success';

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_deleteFTAApplicationMapping]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_deleteFTAApplicationMapping
CREATE  PROCEDURE [dbo].[sp_deleteFTAApplicationMapping](
 @i_id VARCHAR(50),
 @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN
SET NOCOUNT ON;
declare @Shortcode varchar(150);
 IF exists (SELECT FTAShortCodeId FROM tbl_strategy  WHERE FTAApplicationMappingId=@i_id and IsActive='Y') 
 begin
 SELECT @Shortcode=FTAShortCodeId FROM tbl_strategy  WHERE FTAApplicationMappingId=@i_id and IsActive='Y';
 set @i_OutParam ='Mapping associated to strategy FTA short code' +@Shortcode;
 end
 else 
 begin

delete from tbl_FTAapplicationmapping where id =@i_id;
set @i_OutParam ='success';
end;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_Venuetype]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_Venuetype](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_Venuetype_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Venuetype]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_Venuetype](
	@i_Venuetype VARCHAR(50),
	@i_Venuetypecode VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT


)as
BEGIN
if exists (select ID from tbl_venuetype_master where VenueType =@i_Venuetype)
begin
set @i_OutParam ='Venue Type already exists';
end
else
begin
insert into tbl_Venuetype_master (Venuetype,VenueTypecode) values(@i_Venuetype,@i_Venuetypecode);
set @i_OutParam ='success';
END
end
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_userregion]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_userregion](
	@i_userid VARCHAR(250),
	@i_RegionId VARCHAR(250)
)as
BEGIN
insert into tbl_userregionmapping (Userid,RegionId) values(@i_userid,@i_RegionId);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_usercountry]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_usercountry](
	@i_userid VARCHAR(250),
	@i_CountryId VARCHAR(250)
)as
BEGIN
insert into tbl_usercountrymapping (Userid,CountryId) values(@i_userid,@i_CountryId);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_userBusinessSector]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_userBusinessSector](
	@i_userid VARCHAR(250),
	@i_BusinessSectorId VARCHAR(250)
)as
BEGIN
insert into tbl_userBusinessSectormapping (Userid,BusinessSectorId) values(@i_userid,@i_BusinessSectorId);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_strategyVersionLog]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_strategyVersionLog](
	@i_RefNumber VARCHAR(50),
	@i_Version VARCHAR(50),
	@i_ChangeDesc VARCHAR(2000),
	@i_Createdby VARCHAR(500)
)
as
BEGIN

insert into tbl_strategyVersionLog (RefNumber,Version,ChangeDesc,Createdby) values(@i_RefNumber,@i_Version,@i_ChangeDesc,@i_Createdby);

END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Strategytype]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_Strategytype](
	@i_Strategytype VARCHAR(50),
		@i_Strategytypecode VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT

)as
BEGIN


IF exists (SELECT * FROM tbl_Strategytype_master  WHERE Strategytype=@i_Strategytype) 
set @i_OutParam ='Strategy Type already exists';
 else
 begin

insert into tbl_Strategytype_master (Strategytype,StrategyTypecode) values(@i_Strategytype,@i_Strategytypecode);
set @i_OutParam ='success';

end
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_strategy_Approval]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_strategy_Approval](
	@i_RefNumber VARCHAR(50),
	@i_Version VARCHAR(50),
	@i_systemfile VARCHAR(500)
,
	@i_OrignalFile VARCHAR(500),
	@i_status VARCHAR(5)
,
	@I_uploadedby VARCHAR(500)

)
as
BEGIN

INSERT INTO tbl_StrategyApproval (RefNumber, Version,Approver,Comments,Status,Uploadedby) VALUES (@i_RefNumber, @i_Version,@i_systemfile,@i_OrignalFile,@i_status,@I_uploadedby);

END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Strategy]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_Strategy](
 @i_RefNumber VARCHAR(50),
 @i_RegionId VARCHAR(50),
 @i_Description VARCHAR(500)=null,
 @i_FTAApplicationCodeId VARCHAR(50),
 @i_BusinessSuffixId VARCHAR(50),
 @i_ChildID VARCHAR(50),
 @i_FTAStrategyNameId VARCHAR(50),
 @i_StrategytypeId VARCHAR(50)=null,
 @i_GOLiveDate VARCHAR(50)=null,
 @i_FTAStrategyCodeId VARCHAR(50),
 @i_FTAShortCode VARCHAR(50),
 @i_BusinessLineId VARCHAR(50),
 @i_FTAApplicationNameId VARCHAR(50),
 @i_FTAStrategyOwnerId VARCHAR(50),
 @i_ApplicationCategoryId VARCHAR(50),
 @i_DecommissionedDate VARCHAR(50)=null,
 @i_DiscretionaryCodeId VARCHAR(50),
 @i_ParentID VARCHAR(50),
 @i_FTAApplicationOwnerId VARCHAR(50),
 @i_PriorityScore VARCHAR(50),
 @i_Priority VARCHAR(50),
 @i_CapacityId VARCHAR(50),
 @i_VenueTypeId VARCHAR(50),
 @i_Version VARCHAR(50),
 @i_ThirdPartyAppId VARCHAR(50)  ,
 @i_BusinessId VARCHAR(50),
 @i_FTAApplicationMappingId VARCHAR(50)    ,
 @i_FTAStrategyMappingId VARCHAR(50) ,
 @i_BusinessMappingId VARCHAR(50),
 @i_SeniorManagementFunction VARCHAR(1500),
 @i_LTALongCode VARCHAR(1500),
 @i_SignOff VARCHAR(50) =null ,
 @i_CountryIdList VARCHAR(100)=null  ,
 @i_CountryNameList VARCHAR(500)=null,
 @i_StatusId VARCHAR(50),
 @i_CreatedBy VARCHAR(500)=null,
 @i_AdditionalShortCode VARCHAR(500)=null,
 @i_OutParam VARCHAR(500) OUTPUT
)
AS
BEGIN
 IF exists (SELECT Id FROM tbl_strategy  WHERE FTAShortCodeId=@i_FTAShortCode and Version=@i_Version) 
 begin
 set @i_OutParam ='Strategy Short code already exists';
 end
 Else IF exists (SELECT Id FROM tbl_strategy  WHERE FTAShortCodeId=@i_LTALongCode and Version=@i_Version) 
 begin
 set @i_OutParam ='Strategy Long code already exists';
 end
 else begin
 begin
 
 update tbl_strategy set isactive ='N' where FTAShortCodeId =@i_FTAShortCode;
 insert into tbl_strategy(RefNumber, RegionId,  Description,   FTAApplicationCodeId,        BusinessSuffixId,        ChildID,
        FTAStrategyNameId,StrategytypeId,GOLiveDate,FTAStrategyCodeId,FTAShortCodeId,
        BusinessLineId,FTAApplicationNameId,FTAStrategyOwnerId,ApplicationCategoryId,VenuetypeId,
        DeComissionedDate,DiscretionaryCodeId,ParentID,FTAApplicationOwnerId,PriorityScore,Priority,
        CapacityId,CountryIdList,CountryNameList,IsActive,Version,ThirdPartyAppId,BusinessId,FTAApplicationMappingId,
		  FTAStrategyMappingId,BusinessMappingId,SignOff,CreatedBy,LTALongCode,SeniorManagementFunction,StatusId
		  ,AdditionalShortCode) values(@i_RefNumber,
 @i_RegionId,@i_Description,@i_FTAApplicationCodeId,@i_BusinessSuffixId,@i_ChildID,@i_FTAStrategyNameId,@i_StrategytypeId,
@i_GOLiveDate,@i_FTAStrategyCodeId,@i_FTAShortCode,@i_BusinessLineId,@i_FTAApplicationNameId,@i_FTAStrategyOwnerId,
@i_ApplicationCategoryId,@i_VenueTypeId,@i_DecommissionedDate,@i_DiscretionaryCodeId,@i_ParentID,@i_FTAApplicationOwnerId,@i_PriorityScore,
@i_Priority,@i_CapacityId,@i_CountryIdList,@i_CountryNameList, 'Y',@i_Version,@i_ThirdPartyAppId,@i_BusinessId,@i_FTAApplicationMappingId,@i_FTAStrategyMappingId,@i_BusinessMappingId,
@i_SignOff,@i_CreatedBy,@i_LTALongCode,@i_SeniorManagementFunction,@i_StatusId,@i_AdditionalShortCode);


insert into dbo.tbl_CountryStrategyMapping (StrategyId,CountryId) select @@IDENTITY,Item from SplitString(@i_CountryIdList,',') 

set @i_OutParam ='success';
end;
ENd 
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_roleright]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_roleright](
	@i_RoleId INT,
	@i_RightId INT

)as
BEGIN
insert into tbl_roleright_mapping (RoleId,RightId) values(@i_RoleId,@i_RightId);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_role]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_role](
 @i_role VARCHAR(50),
 @param_auto_id INT OUT
)
AS
BEGIN
insert into tbl_role_master (RoleName) values(@i_role);
  set  @param_auto_id = @@IDENTITY ;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Region]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_Region](
 @i_RegionName VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT



)
AS
BEGIN


IF exists (SELECT * FROM tbl_region_master  WHERE regionname=@i_RegionName) 
set @i_OutParam ='Region Name already exists';
 else
 begin


insert into tbl_region_master (regionname) values(@i_RegionName);
set @i_OutParam ='success';
END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_ParentID]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_ParentID](
	@i_ParentID VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT

)
as
BEGIN


IF exists (SELECT * FROM tbl_ParentID_master  WHERE ParentID=@i_ParentID) 
set @i_OutParam ='Parent ID already exists';
 else
 begin


insert into tbl_ParentID_master (ParentID) values(@i_ParentID);
set @i_OutParam ='success';
END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FTAStrategyName]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_FTAStrategyName](
	@i_FTAStrategyName VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT



)
as
BEGIN


IF exists (SELECT * FROM tbl_FTAStrategyName_master  WHERE FTAStrategyName=@i_FTAStrategyName) 
set @i_OutParam ='FTA Strategy Name already exists';
 else
 begin
insert into tbl_FTAStrategyName_master (FTAStrategyName) values(@i_FTAStrategyName);
set @i_OutParam ='success';
end
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FTAStrategyCode]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_FTAStrategyCode](
 @i_FTAStrategyCode VARCHAR(50)

,
  @i_OutParam VARCHAR(50) OUT

)
AS
BEGIN


IF exists (SELECT * FROM tbl_FTAStrategyCode_master  WHERE FTAStrategyCode=@i_FTAStrategyCode) 
set @i_OutParam ='FTA Strategy code already exists';
 else
 begin
insert into tbl_FTAStrategyCode_master (FTAStrategyCode) values(@i_FTAStrategyCode);
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FTAApplicationName]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_insert_FTAApplicationName
CREATE  PROCEDURE [dbo].[sp_insert_FTAApplicationName](
 @i_FTAApplicationName VARCHAR(50)

,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN


IF exists (SELECT * FROM tbl_FTAApplicationName_master  WHERE FTAApplicationName=@i_FTAApplicationName) 
 set @i_OutParam ='FTA Application Name already exists';
 else
 begin
insert into tbl_FTAApplicationName_master (FTAApplicationName) values(@i_FTAApplicationName);
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FTAApplicationCode]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_FTAApplicationCode](
 @i_FTAApplicationCode VARCHAR(50)

,
  @i_OutParam VARCHAR(50) OUT

)
AS
BEGIN

IF exists (SELECT * FROM tbl_FTAApplicationCode_master  WHERE FTAApplicationCode=@i_FTAApplicationCode) 
set @i_OutParam ='FTA Application code already exists';
 else
 begin
insert into tbl_FTAApplicationCode_master (FTAApplicationCode) values(@i_FTAApplicationCode);
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_DiscretionaryCode]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_DiscretionaryCode](
 @i_DiscretionaryCode VARCHAR(50)

,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN
IF exists (SELECT * FROM tbl_DiscretionaryCode_master WHERE DiscretionaryCode=@i_DiscretionaryCode) 
set @i_OutParam ='Discretionary code already exists';
 else
 begin

insert into tbl_DiscretionaryCode_master (DiscretionaryCode) values(@i_DiscretionaryCode);
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Country]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_Country](
	@i_CountryName VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT
)
as
BEGIN

IF exists (SELECT * FROM tbl_country_master WHERE Countryname=@i_CountryName) 
set @i_OutParam ='Country Name already exists';
 else
 begin

insert into tbl_country_master (Countryname) values(@i_CountryName);
set @i_OutParam ='success';
end
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_ChildID]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_ChildID](
 @i_ChildID VARCHAR(50)

,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN
SET NOCOUNT ON;


IF exists (SELECT * FROM tbl_ChildID_master WHERE ChildID=@i_ChildID) 
 set @i_OutParam ='Child ID already exists';
 else
 begin

insert into tbl_ChildID_master (ChildID) values(@i_ChildID);
set @i_OutParam ='success';
END



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Capacity]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_Capacity](
	@i_Capacity VARCHAR(50),
	@i_Capacitycode VARCHAR(50),
	
  @i_OutParam VARCHAR(50) OUT
)as
BEGIN

IF exists (SELECT * FROM tbl_Capacity_master WHERE Capacity=@i_Capacity) 
set @i_OutParam ='Capacity already exists';
 else
 begin
insert into tbl_Capacity_master (Capacity,Capacitycode) values(@i_Capacity,@i_Capacitycode);
set @i_OutParam ='success';
END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_BusinessSuffix]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_BusinessSuffix](
 @i_BusinessSuffix VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT

)
AS
BEGIN


if exists (select ID from tbl_BusinessSuffix_master where BusinessSuffix =@i_BusinessSuffix)
BEGIN 
set @i_OutParam ='Business Suffix already exists';
END
ELSE
BEGIN

insert into tbl_BusinessSuffix_master (BusinessSuffix) values(@i_BusinessSuffix);
set @i_OutParam ='success';
END
end
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_BusinessLine]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_BusinessLine](
 @i_BusinessLine VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT

)
AS
BEGIN

IF exists (SELECT * FROM tbl_BusinessLine_master WHERE BusinessLine=@i_BusinessLine) 
set @i_OutParam ='Business Line already exists';

 else
 begin
insert into tbl_BusinessLine_master (BusinessLine) values(@i_BusinessLine);
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Business]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_Business](
 @i_Business VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_Business_master WHERE Business=@i_Business) 
 set @i_OutParam ='Business already exists';
 else
 begin
insert into tbl_Business_master (Business) values(@i_Business);
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_ApplicationCategory]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_ApplicationCategory](
   @i_ApplicationCategory VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT
)
as
BEGIN
 IF exists (SELECT id FROM tbl_ApplicationCategory_master WHERE ApplicationCategory=@i_ApplicationCategory) 
 set @i_OutParam ='Application Category already exists';
 else
 begin

insert into tbl_ApplicationCategory_master (ApplicationCategory) values(@i_ApplicationCategory);
set @i_OutParam ='success';

end
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getusersbycondition]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getusersbycondition
CREATE  PROCEDURE [dbo].[sp_getusersbycondition](
 @i_regionId VARCHAR(50),
 @i_businesssectorId VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;
select u.Id,u.Userid,u.UserName,u.EmailId,u.RegionId,r.RegionName,u.BusinessSectorId,
b.BusinessLine,u.RoleId,rm.RoleName,u.Status from tbl_user_master u 
Join tbl_userbusinesssectormapping ubu on ubu.userid=u.Userid
Join tbl_userregionmapping ur on ur.userid=u.Userid
join tbl_businessline_master b on ubu.BusinessSectorId=b.Id 
join tbl_region_master r  on ur.RegionId=r.Id join tbl_role_master rm on u.RoleId=rm.Id  
where ur.RegionId=@i_regionId and ubu.BusinessSectorId=@i_businesssectorId and U.userid!='NA';

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getusers]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getusers](
 @i_userid VARCHAR(50)
)
AS
BEGIN
if(@i_userid ='') begin
select u.Id,u.Userid,u.UserName,u.EmailId,u.RoleId,rm.RoleName,u.Status,u.Password,u.IsADUser from tbl_user_master u join tbl_role_master rm on u.RoleId=rm.Id where u.Status !='NA';

end
else if(@i_userid ='NA') begin
select u.Id,u.Userid,u.UserName,u.EmailId,u.RoleId,rm.RoleName,u.Status,u.Password,u.IsADUser from tbl_user_master u join tbl_role_master rm on u.RoleId=rm.Id;
end
else begin
select u.Id,u.Userid,u.UserName,u.EmailId,u.RoleId,rm.RoleName,u.Status,u.Password,u.IsADUser from tbl_user_master u 
join tbl_role_master rm on u.RoleId=rm.Id  where u.userid=@i_userid and u.Status !='NA';
end 


END;
GO
/****** Object:  StoredProcedure [dbo].[SP_Getuserregion]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.SP_Getuserregion
CREATE  PROCEDURE [dbo].[SP_Getuserregion](
 @i_userid VARCHAR(250)
)
AS
BEGIN
SET NOCOUNT ON;
select r.Id,r.RegionName from tbl_userregionmapping rm join tbl_region_master r on rm.RegionId = r.Id where Userid=@i_userid;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_Getusercountry]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.SP_Getusercountry
CREATE  PROCEDURE [dbo].[SP_Getusercountry](
 @i_userid VARCHAR(250)
)
AS
BEGIN
SET NOCOUNT ON;
select c.id,c.CountryName from tbl_usercountrymapping uc join tbl_country_master c on uc.CountryId = c.id where Userid=@i_userid;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetuserBusinessSector]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.SP_GetuserBusinessSector
CREATE  PROCEDURE [dbo].[SP_GetuserBusinessSector](
 @i_userid VARCHAR(250)


)
AS
BEGIN
SET NOCOUNT ON;
select b.Id,b.BusinessLine from tbl_userBusinessSectormapping bs join tbl_businessLine_master b  on bs.BusinessSectorId =b.Id where Userid=@i_userid;
END;
GO
/****** Object:  StoredProcedure [dbo].[Sp_getRolesbyuserassigned]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.Sp_getRolesbyuserassigned
CREATE  PROCEDURE [dbo].[Sp_getRolesbyuserassigned](
 @i_roleid VARCHAR(50)

)
AS
BEGIN
select u.Userid,u.UserName,u.EmailId,u.RegionId,r.RegionName,u.CountryId,c.CountryName,u.BusinessSectorId,b.Name,u.RoleId,rm.RoleName,u.Status from tbl_user_master u join tbl_businesssector b on u.BusinessSectorId=b.Id join tbl_region_master r  on u.RegionId=r.Id join tbl_country_master c  on u.CountryId=c.id join tbl_role_master rm on u.RoleId=rm.Id
where u.RoleId=@i_roleid;

END;
GO
/****** Object:  StoredProcedure [dbo].[Sp_GetRoles]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.Sp_GetRoles
CREATE  PROCEDURE [dbo].[Sp_GetRoles](
 @i_roleId VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

if(@i_roleId !='') begin
select * from tbl_Role_Master where Id=@i_roleId;
end
else begin
select * from tbl_Role_Master ;
End 

END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRoleRights]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.SP_GetRoleRights
CREATE  PROCEDURE [dbo].[SP_GetRoleRights](
 @i_roleId INT
)
AS
BEGIN
SET NOCOUNT ON;
select * from tbl_roleright_mapping where roleId=@i_roleId;
END;
GO
/****** Object:  StoredProcedure [dbo].[Sp_GetRights]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.Sp_GetRights
CREATE  PROCEDURE [dbo].[Sp_GetRights](
 @i_roleid VARCHAR(50)



)
AS
BEGIN
SET NOCOUNT ON;

if(@i_roleid!='') begin
Select * from tbl_right_master where RightId=@i_roleid  and Isactive='Y';
end
else begin
Select * from tbl_right_master where  Isactive='Y';
end 
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRightForUser]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.SP_GetRightForUser
CREATE  PROCEDURE [dbo].[SP_GetRightForUser](
 @i_userid VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

select distinct RightName, Path from TBL_RIGHT_MASTER RM inner join TBL_ROLERIGHT_MAPPING RR on
 RM.RightID=RR.RightID inner join TBL_USER_MASTER UM on RR.RoleID=UM.RoleId where UM.Userid = @i_userid;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getReportApplicationMappingFilter]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getReportApplicationMappingFilter](
	@i_Id VARCHAR(50)=null
)
as
BEGIN
 select FAM.Id, FAM.FTAApplicationNameId,FANM.FTAApplicationName,FAM.FTAApplicationCodeId,
 FACM.FTAApplicationCode,
 FAM.ChildId,CM.ChildID as ChildIDValue, FAM.ThirdPartyAppId,TM.ThirdPartyAppName,
 FAM.ParentID as ParentIDValue,PM.ParentId, FAM.ApplicationOwnerId ,FAM.ApplicationCategoryId,
 AM.ApplicationCategory,
 FAM.BusinessLineId,BM.BusinessLine
 ,FAM.RegionId,R.RegionName,
 --FAM.CountryId,C.CountryName,

 CountryId=STUFF  
(  
    (  
      SELECT DISTINCT ', '+ CAST( C.id AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryReportMapping e   
      WHERE C.iD=e.CountryId and e.ReportId=FAM.Id   
      FOR XMl PATH('')  
    ),1,1,''  
)  ,
CountryName=STUFF  
(  
    (  
      SELECT DISTINCT ', '+ CAST( C.CountryName AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryReportMapping e   
      WHERE C.iD=e.CountryId and e.ReportId=FAM.Id   
      FOR XMl PATH('')  
    ),1,1,''  
)  
  from tbl_reportapplicationmapping FAM 
 join tbl_ftaapplicationname_master FANM on FAM.FTAApplicationNameId=FANM.Id
 join tbl_ftaapplicationcode_master FACM on FAM.FTAApplicationCodeId=FACM.Id
 join tbl_childid_master CM on FAM.ChildId=CM.Id
 join tbl_thirdpartyapplication TM on FAM.ThirdPartyAppId=TM.Id
 join tbl_user_master UM on UM.Userid=FAM.ApplicationOwnerId
 join tbl_parentId_master PM on PM.Id=FAM.ParentId
 join tbl_applicationcategory_Master AM on AM.Id =FAM.ApplicationCategoryId
 join tbl_businessline_master BM on bm.Id=FAM.BusinessLineId
 JOIN tbl_region_master R on R.Id=FAM.RegionId


 where FAM.FTAApplicationNameId=@i_id;
end
GO
/****** Object:  StoredProcedure [dbo].[sp_getReportApplicationMapping]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getReportApplicationMapping](
	@i_Id VARCHAR(50)=null
)
as
BEGIN
if(@i_Id !='') 
 select FAM.Id, FAM.FTAApplicationNameId,FANM.FTAApplicationName,FAM.FTAApplicationCodeId,FACM.FTAApplicationCode,
 FAM.ChildId,CM.ChildID as ChildIDValue, FAM.ThirdPartyAppId,TM.ThirdPartyAppName,
 FAM.ParentID as ParentIDValue,PM.ParentId, FAM.ApplicationOwnerId ,FAM.ApplicationCategoryId,AM.ApplicationCategory 
 ,FAM.BusinessLineId,BM.BusinessLine
  from tbl_reportapplicationmapping FAM 
 join tbl_ftaapplicationname_master FANM on FAM.FTAApplicationNameId=FANM.Id
 join tbl_ftaapplicationcode_master FACM on FAM.FTAApplicationCodeId=FACM.Id
 join tbl_childid_master CM on FAM.ChildId=CM.Id
 join tbl_thirdpartyapplication TM on FAM.ThirdPartyAppId=TM.Id
 join tbl_user_master UM on UM.Userid=FAM.ApplicationOwnerId
 join tbl_parentId_master PM on PM.Id=FAM.ParentId
 join tbl_applicationcategory_Master AM on AM.Id =FAM.ApplicationCategoryId
 join tbl_businessline_master BM on bm.Id=FAM.BusinessLineId
 JOIN tbl_CountryReportMapping CR on CR.ReportId=FAM.Id
 where FAM.Id=@i_id;
else
 select FAM.Id, FAM.FTAApplicationNameId,FANM.FTAApplicationName,FAM.FTAApplicationCodeId,
 FACM.FTAApplicationCode,
 FAM.ChildId,CM.ChildID as ChildIDValue, FAM.ThirdPartyAppId,TM.ThirdPartyAppName,
  FAM.ParentID as ParentIDValue,PM.ParentId, FAM.ApplicationOwnerId ,FAM.ApplicationCategoryId,
  AM.ApplicationCategory,
  FAM.BusinessLineId,BM.BusinessLine
  ,FAM.RegionId,R.RegionName,CountryId=STUFF
  (  
    (  
      SELECT DISTINCT ', '+ CAST( C.iD AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryReportMapping e   
      WHERE C.iD=e.CountryId and e.ReportId=FAM.Id   
      FOR XMl PATH('')  
    ),1,1,''  
)  
  
  ,
  CountryName=STUFF  
(  
    (  
      SELECT DISTINCT ', '+ CAST( C.CountryName AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryReportMapping e   
      WHERE C.iD=e.CountryId and e.ReportId=FAM.Id   
      FOR XMl PATH('')  
    ),1,1,''  
)  
  
  from tbl_reportapplicationmapping FAM
 join tbl_ftaapplicationname_master FANM on FAM.FTAApplicationNameId=FANM.Id
 join tbl_ftaapplicationcode_master FACM on FAM.FTAApplicationCodeId=FACM.Id
 join tbl_childid_master CM on FAM.ChildId=CM.Id
 join tbl_thirdpartyapplication TM on FAM.ThirdPartyAppId=TM.Id
  join tbl_user_master UM on UM.Userid=FAM.ApplicationOwnerId
 join tbl_parentId_master PM on PM.Id=FAM.ParentId
 join tbl_applicationcategory_Master AM on AM.Id =FAM.ApplicationCategoryId
 join tbl_businessline_master BM on bm.Id=FAM.BusinessLineId
 JOIN tbl_region_master R on R.Id=FAM.RegionId

end
GO
/****** Object:  StoredProcedure [dbo].[sp_getmenuforuser]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getmenuforuser
CREATE  PROCEDURE [dbo].[sp_getmenuforuser](
 @i_UserId VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;
select distinct MenuName, Path, RM.RightID, RM.ShowMenu, RM.Icon from TBL_RIGHT_MASTER RM inner join TBL_ROLERIGHT_MAPPING RR on RM.RightID=RR.RightID inner join TBL_USER_MASTER UM on RR.RoleID=UM.RoleId where UM.Userid = @i_UserId and RM.IsActive='Y' order by RM.RightID;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getFTAStrategyMappingbyId]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getFTAStrategyMappingbyId
CREATE  PROCEDURE [dbo].[sp_getFTAStrategyMappingbyId](
 @i_Id INT

)
AS
BEGIN
SET NOCOUNT ON;
select FSM.Id, FSM.FTAStrategyNameId, FSN.FTAStrategyName, FSM.FTAStrategyCodeId,FSC.FTAStrategyCode from tbl_ftastrategynamemapping FSM join tbl_ftastrategyname_master FSN on FSM.FTAStrategyNameId=FSN.Id
JOIN tbl_ftastrategycode_master FSC on  FSM.FTAStrategyCodeId = FSC.Id
 where FSM.FTAStrategyNameId=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getFTAStrategyMapping]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getFTAStrategyMapping
CREATE  PROCEDURE [dbo].[sp_getFTAStrategyMapping](
 @i_id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;
if(@i_Id !='') begin
select FSM.Id, FSM.FTAStrategyNameId, FSN.FTAStrategyName, FSM.FTAStrategyCodeId,FSC.FTAStrategyCode from tbl_ftastrategynamemapping FSM join tbl_ftastrategyname_master FSN on FSM.FTAStrategyNameId=FSN.Id
JOIN tbl_ftastrategycode_master FSC on  FSM.FTAStrategyCodeId = FSC.Id
 where FSM.Id=@i_id;
end
else begin
select FSM.Id, FSM.FTAStrategyNameId, FSN.FTAStrategyName, FSM.FTAStrategyCodeId,FSC.FTAStrategyCode from tbl_ftastrategynamemapping FSM join tbl_ftastrategyname_master FSN on FSM.FTAStrategyNameId=FSN.Id
JOIN tbl_ftastrategycode_master FSC on  FSM.FTAStrategyCodeId = FSC.Id;
end 

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getFTAApplicationMappingbyId]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getFTAApplicationMappingbyId
CREATE  PROCEDURE [dbo].[sp_getFTAApplicationMappingbyId]
(
 @i_Id INT
)
AS
BEGIN
--if(@i_Id =null)

select FAM.Id, FAM.FTAApplicationNameId,FANM.FTAApplicationName,FAM.FTAApplicationCodeId,FACM.FTAApplicationCode,
 FAM.ChildId,CM.ChildID as ChildIDValue, FAM.ThirdPartyAppId,TM.ThirdPartyAppName, FAM.ParentID as ParentIDValue,PM.ParentId,
  FAM.ApplicationOwnerId ,FAM.ApplicationCategoryId,AM.ApplicationCategory 
  from tbl_ftaapplicationmapping FAM 
 join tbl_ftaapplicationname_master FANM on FAM.FTAApplicationNameId=FANM.Id
 join tbl_ftaapplicationcode_master FACM on FAM.FTAApplicationCodeId=FACM.Id
 join tbl_childid_master CM on FAM.ChildId=CM.Id
 join tbl_thirdpartyapplication TM on FAM.ThirdPartyAppId=TM.Id
 --join tbl_user_master UM on UM.Userid=FAM.ApplicationOwnerId
 join tbl_parentId_master PM on PM.Id=FAM.ParentId
 join tbl_applicationcategory_Master AM on AM.Id =FAM.ApplicationCategoryId
 where FAM.FTAApplicationNameId=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getFTAApplicationMapping]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getFTAApplicationMapping](
	@i_Id VARCHAR(50)=null
)
as
BEGIN
if(@i_Id !='') 
 select FAM.Id, FAM.FTAApplicationNameId,FANM.FTAApplicationName,FAM.FTAApplicationCodeId,FACM.FTAApplicationCode,
 FAM.ChildId,CM.ChildID as ChildIDValue, FAM.ThirdPartyAppId,TM.ThirdPartyAppName,
 FAM.ParentID as ParentIDValue,PM.ParentId, FAM.ApplicationOwnerId ,FAM.ApplicationCategoryId,AM.ApplicationCategory 
  from tbl_ftaapplicationmapping FAM 
 join tbl_ftaapplicationname_master FANM on FAM.FTAApplicationNameId=FANM.Id
 join tbl_ftaapplicationcode_master FACM on FAM.FTAApplicationCodeId=FACM.Id
 join tbl_childid_master CM on FAM.ChildId=CM.Id
 join tbl_thirdpartyapplication TM on FAM.ThirdPartyAppId=TM.Id
 --join tbl_user_master UM on UM.Userid=FAM.ApplicationOwnerId
 join tbl_parentId_master PM on PM.Id=FAM.ParentId
 join tbl_applicationcategory_Master AM on AM.Id =FAM.ApplicationCategoryId
 where FAM.Id=@i_id;
else
 select FAM.Id, FAM.FTAApplicationNameId,FANM.FTAApplicationName,FAM.FTAApplicationCodeId,FACM.FTAApplicationCode,
 FAM.ChildId,CM.ChildID as ChildIDValue, FAM.ThirdPartyAppId,TM.ThirdPartyAppName,
  FAM.ParentID as ParentIDValue,PM.ParentId, FAM.ApplicationOwnerId ,FAM.ApplicationCategoryId,AM.ApplicationCategory
  from tbl_ftaapplicationmapping FAM 
 join tbl_ftaapplicationname_master FANM on FAM.FTAApplicationNameId=FANM.Id
 join tbl_ftaapplicationcode_master FACM on FAM.FTAApplicationCodeId=FACM.Id
 join tbl_childid_master CM on FAM.ChildId=CM.Id
 join tbl_thirdpartyapplication TM on FAM.ThirdPartyAppId=TM.Id
  --join tbl_user_master UM on UM.Userid=FAM.ApplicationOwnerId
 join tbl_parentId_master PM on PM.Id=FAM.ParentId
 join tbl_applicationcategory_Master AM on AM.Id =FAM.ApplicationCategoryId;
end
GO
/****** Object:  StoredProcedure [dbo].[sp_getbusinessmappingbyId]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getbusinessmappingbyId
CREATE  PROCEDURE [dbo].[sp_getbusinessmappingbyId](
 @i_Id INT

)
AS
BEGIN
SET NOCOUNT ON;
select bm.Id, bm.BusinessId,b.business,bm.BusinessSuffixId,bs.BusinessSuffix from tbl_businessmapping bm join tbl_business_master b on bm.BusinessId =b.Id
 join tbl_businesssuffix_master bs on bm.BusinessSuffixId =bs.Id
 where bm.BusinessId=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getbusinessmapping]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getbusinessmapping
CREATE  PROCEDURE [dbo].[sp_getbusinessmapping](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;
if(@i_Id !='') begin
 select bm.Id, bm.BusinessId,b.business,bm.BusinessSuffixId,bs.BusinessSuffix from tbl_businessmapping bm join tbl_business_master b on bm.BusinessId =b.Id
 join tbl_businesssuffix_master bs on bm.BusinessSuffixId =bs.Id
 where bm.Id=@i_id;
end
else begin
 select bm.Id, bm.BusinessId,b.business,bm.BusinessSuffixId,bs.BusinessSuffix from tbl_businessmapping bm join tbl_business_master b on bm.BusinessId =b.Id
 join tbl_businesssuffix_master bs on bm.BusinessSuffixId =bs.Id;
end 
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallVenuetype]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallVenuetype
CREATE  PROCEDURE [dbo].[sp_getallVenuetype](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_Venuetype_master where Id=@i_id;
end
else begin
select * from tbl_Venuetype_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getAllThirdPartyAppType]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getAllThirdPartyAppType
CREATE  PROCEDURE [dbo].[sp_getAllThirdPartyAppType](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;
select * from tbl_thirdpartyapplication;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallParentID]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallParentID
CREATE  PROCEDURE [dbo].[sp_getallParentID](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_ParentID_master where Id=@i_id;
end
else begin
select * from tbl_ParentID_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallFTAStrategyOwner]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallFTAStrategyOwner
CREATE  PROCEDURE [dbo].[sp_getallFTAStrategyOwner](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_FTAStrategyOwner_master where Id=@i_id;
end
else begin
select * from tbl_FTAStrategyOwner_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallFTAStrategyName]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallDiscretionaryCode
-- Dumping structure for procedure achiv1.sp_getallFTAApplicationCode

-- Dumping structure for procedure achiv1.sp_getallFTAApplicationName

-- Dumping structure for procedure achiv1.sp_getallFTAApplicationOwner

-- Dumping structure for procedure achiv1.sp_getallFTAStrategyCode
-- Dumping structure for procedure achiv1.sp_getallFTAStrategyName
CREATE  PROCEDURE [dbo].[sp_getallFTAStrategyName](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_FTAStrategyName_master where Id=@i_id;
end
else begin
select * from tbl_FTAStrategyName_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallFTAStrategyCode]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallFTAStrategyCode](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_FTAStrategyCode_master where Id=@i_id;
end
else begin
select * from tbl_FTAStrategyCode_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallFTAApplicationOwner]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallFTAApplicationOwner](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_FTAApplicationOwner_master where Id=@i_id;
end
else begin
select * from tbl_FTAApplicationOwner_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallFTAApplicationName]    Script Date: 03/21/2018 00:57:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallFTAApplicationName](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_FTAApplicationName_master where Id=@i_id;
end
else begin
select * from tbl_FTAApplicationName_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallFTAApplicationCode]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallFTAApplicationCode](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_FTAApplicationCode_master where Id=@i_id;
end
else begin
select * from tbl_FTAApplicationCode_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallDiscretionaryCode]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallDiscretionaryCode](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_DiscretionaryCode_master where Id=@i_id;
end
else begin
select * from tbl_DiscretionaryCode_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallcountry]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_getallcountry
CREATE  PROCEDURE [dbo].[sp_getallcountry](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_country_master where Id=@i_id;
end
else begin
select * from tbl_country_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallChildID]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---- Dumping structure for procedure achiv1.SP_AddRole
--CREATE  PROCEDURE SP_AddRole
--AS
--BEGIN
--SET NOCOUNT ON;

--END;
--GO


-- Dumping structure for procedure achiv1.SP_DeleteRole

-- Dumping structure for procedure achiv1.sp_delete_ApplicationCategory
-- Dumping structure for procedure achiv1.sp_delete_ApplicationMaster

-- Dumping structure for procedure achiv1.sp_delete_Business


-- Dumping structure for procedure achiv1.sp_delete_BusinessLine


-- Dumping structure for procedure achiv1.sp_delete_BusinessMapping

-- Dumping structure for procedure achiv1.sp_delete_BusinessSuffix

-- Dumping structure for procedure achiv1.sp_delete_Capacity

-- Dumping structure for procedure achiv1.sp_delete_ChildID
-- Dumping structure for procedure achiv1.sp_delete_country

-- Dumping structure for procedure achiv1.sp_delete_FTAApplicationName
-- Dumping structure for procedure achiv1.sp_delete_FTAApplicationOwner
-- Dumping structure for procedure achiv1.sp_delete_FTAStrategyMapping

-- Dumping structure for procedure achiv1.sp_delete_FTAStrategyName

-- Dumping structure for procedure achiv1.sp_delete_FTAStrategyOwner

-- Dumping structure for procedure achiv1.sp_delete_ParentID
-- Dumping structure for procedure achiv1.sp_delete_ProductType

-- Dumping structure for procedure achiv1.sp_delete_region
-- Dumping structure for procedure achiv1.sp_delete_Strategytype

-- Dumping structure for procedure achiv1.sp_delete_strategy_Approval

-- Dumping structure for procedure achiv1.sp_delete_SystemFlow

-- Dumping structure for procedure achiv1.sp_delete_Venuetype
-- Dumping structure for procedure achiv1.sp_getallApplicationCategory
-- Dumping structure for procedure achiv1.sp_getallApplicationMaster

-- Dumping structure for procedure achiv1.sp_getallBusiness


-- Dumping structure for procedure achiv1.sp_getallBusinessLine
-- Dumping structure for procedure achiv1.sp_getallBusinessSuffix

-- Dumping structure for procedure achiv1.sp_getallCapacity
-- Dumping structure for procedure achiv1.sp_getallChildID
CREATE  PROCEDURE [dbo].[sp_getallChildID](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_ChildID_master where Id=@i_id;
end
else begin
select * from tbl_ChildID_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallCapacity]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallCapacity](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_Capacity_master where Id=@i_id;
end
else begin
select * from tbl_Capacity_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallBusinessSuffix]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallBusinessSuffix](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_BusinessSuffix_master where Id=@i_id;
end
else begin
select * from tbl_BusinessSuffix_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallBusinessLine]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallBusinessLine](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_BusinessLine_master where Id=@i_id;
end
else begin
select * from tbl_BusinessLine_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallBusiness]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallBusiness](
 @i_Id VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_Business_master where Id=@i_id;
end
else begin
select * from tbl_Business_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_ApplicationCategory]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_ApplicationCategory](
 @i_id INT
)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_ApplicationCategory_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_adduser1]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_adduser1](
 @userid VARCHAR(50),
 @username VARCHAR(50),
 @emailid VARCHAR(50),
 @Roleid VARCHAR(50),
@password NVARCHAR(max),
 @IsADUser VARCHAR(50)
)
AS
BEGIN

insert into tbl_user_master (Userid,UserName,EmailId,RoleId,Status,password,IsADUser) values(@userid,@username,@emailid,@Roleid,'Active',@password,@IsADUser);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_addReportApplicationMapping]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_addReportApplicationMapping](
 @i_FTAApplicationNameId VARCHAR(50),
 @i_FTAApplicationCodeId VARCHAR(50),
 @i_ChildId VARCHAR(50),
 @i_ThirdPartyAppId VARCHAR(50),
 @i_ParentID VARCHAR(50),
 @i_ApplicationOwnerId VARCHAR(500),
 @i_ApplicationCategoryId VARCHAR(50),
 @i_CountryId VARCHAR(50)=null,
 @i_RegionId VARCHAR(50),
 @i_BusinessLineId VARCHAR(50),
 @i_OutParam VARCHAR(50) Output
 )
AS
BEGIN
SET NOCOUNT ON;

 --IF  exists (SELECT * FROM tbl_reportapplicationmapping WHERE FTAApplicationNameId=@i_FTAApplicationNameId and FTAApplicationCodeId=@i_FTAApplicationCodeId and ChildId=@i_ChildId and ThirdPartyAppId=@i_ThirdPartyAppId and ParentID=@i_ParentID and ApplicationOwnerId=@i_ApplicationOwnerId and ApplicationCategoryId=@i_ApplicationCategoryId and RegionId=@i_RegionId and CountryId=@i_CountryId and BusinessLineId=@i_BusinessLineId) 
 --set @i_OutParam ='Report Application Mapping already exists';
 --else 
 --begin

  
insert into tbl_reportapplicationmapping(FTAApplicationNameId,FTAApplicationCodeId,ChildId,ThirdPartyAppId,ParentID,ApplicationOwnerId,ApplicationCategoryId,RegionId,CountryId,BusinessLineId) 
values (@i_FTAApplicationNameId,@i_FTAApplicationCodeId,@i_ChildId,@i_ThirdPartyAppId,@i_ParentID,@i_ApplicationOwnerId,@i_ApplicationCategoryId,@i_RegionId,0 ,@i_BusinessLineId);

insert into tbl_CountryReportMapping (ReportId,CountryId) select @@IDENTITY,Item from SplitString(@i_CountryId,',') 
set @i_OutParam ='success';
--ENd;


END;
GO
/****** Object:  StoredProcedure [dbo].[sp_addFTAStrategyMapping]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_addFTAStrategyMapping
CREATE  PROCEDURE [dbo].[sp_addFTAStrategyMapping](
 @i_FTAStrategyNameId INT,
 @i_FTAStrategyCodeId INT,
 @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

 IF exists(SELECT * FROM tbl_ftastrategynamemapping  WHERE FTAStrategyNameId=@i_FTAStrategyNameId) 
 set @i_OutParam ='Mapping already exists';
 else 
 begin
insert into tbl_ftastrategynamemapping(FTAStrategyNameId,FTAStrategyCodeId) values (@i_FTAStrategyNameId,@i_FTAStrategyCodeId);
set @i_OutParam ='success';
ENd 


END;
GO
/****** Object:  StoredProcedure [dbo].[sp_addFTAApplicationMapping]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_addFTAApplicationMapping
CREATE  PROCEDURE [dbo].[sp_addFTAApplicationMapping](
 @i_FTAApplicationNameId VARCHAR(50),
 @i_FTAApplicationCodeId VARCHAR(50),
 @i_ChildId VARCHAR(50),
 @i_ThirdPartyAppId VARCHAR(50),
 @i_ParentID VARCHAR(50),
 @i_ApplicationOwnerId VARCHAR(500),
 @i_ApplicationCategoryId VARCHAR(50),
 @i_OutParam VARCHAR(50) Output
 )
AS
BEGIN
SET NOCOUNT ON;

 IF  exists (SELECT * FROM tbl_FTAApplicationmapping  WHERE FTAApplicationNameId=@i_FTAApplicationNameId) 
 set @i_OutParam ='FTA Application Mapping already exists';
 else 
 begin
 

insert into tbl_FTAApplicationmapping(FTAApplicationNameId,FTAApplicationCodeId,ChildId,ThirdPartyAppId,ParentID,ApplicationOwnerId,ApplicationCategoryId) 
values (@i_FTAApplicationNameId,@i_FTAApplicationCodeId,@i_ChildId,@i_ThirdPartyAppId,@i_ParentID,@i_ApplicationOwnerId,@i_ApplicationCategoryId);

set @i_OutParam ='success';
ENd;


END;
GO
/****** Object:  StoredProcedure [dbo].[sp_addbusinessmapping]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_addbusinessmapping](
 @i_businesssuffixid INT,
 @i_businessid INT,
 @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

 IF exists (SELECT * FROM tbl_businessmapping  WHERE BusinessId=@i_BusinessId) 
 set @i_OutParam ='Business Mapping already exists';
 else
 begin
insert into tbl_businessmapping(BusinessId,BusinessSuffixId) values (@i_businessid,@i_businesssuffixid);
set @i_OutParam ='success';
end;


END;
GO
/****** Object:  StoredProcedure [dbo].[Get_StrategyApprovalById]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_StrategyApprovalById](
 @i_RefNumber VARCHAR(50),
 @i_Version INT
)
AS
BEGIN
SET NOCOUNT ON;
Select Id,Approver,RefNumber,Version,Comments,Status,ApprovedDate,CreatedDate,Uploadedby from tbl_strategyApproval 
where RefNumber=@i_RefNumber and Version=@i_Version;
/*union
 Select 
Id,Approver,RefNumber,Version,Comments,Status,ApprovedDate,CreatedDate
 from tbl_approvaltransfer  where RefNumber=i_RefNumber and Version=i_Version and IsActive='Y';
*/
END;
GO
/****** Object:  StoredProcedure [dbo].[delete_userregion]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_userregion](
 @i_userid VARCHAR(250)
)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_userregionmapping where Userid=@i_userid;

END;
GO
/****** Object:  StoredProcedure [dbo].[delete_usercountry]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_usercountry](
 @i_userid VARCHAR(250)
)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_usercountrymapping where Userid=@i_userid;

END;
GO
/****** Object:  StoredProcedure [dbo].[delete_userBusinessSector]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_userBusinessSector](
 @i_userid VARCHAR(250)
)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_userBusinessSectormapping where Userid=@i_userid;

END;
GO
/****** Object:  StoredProcedure [dbo].[delete_RoleRight]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_RoleRight](
 @i_roleid INT
)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_roleright_mapping where RoleID=@i_roleid;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_Strategytype]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_Strategytype](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_Strategytype_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_strategy_Approval]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_strategy_Approval](
 @i_RefNumber VARCHAR(50),
 @i_Version VARCHAR(50),
 @i_Approver VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

update tbl_StrategyApproval set IsActive='N' where RefNumber=@i_RefNumber and Version=@i_Version  and Approver=@i_Approver;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_region]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_region](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_region_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_ParentID]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_ParentID](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_ParentID_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAStrategyOwner]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_FTAStrategyOwner](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_FTAStrategyOwner_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAStrategyName]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_FTAStrategyName](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_FTAStrategyName_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAStrategyMapping]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_FTAStrategyMapping](
 @i_id VARCHAR(50)
,
 @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN
declare @Shortcode varchar(150);
 if exists (SELECT count(*) FROM tbl_strategy  WHERE FTAStrategyMappingId=@i_id and IsActive='Y') 
  begin
 SELECT @Shortcode=FTAShortCodeId FROM tbl_strategy  WHERE FTAStrategyMappingId=@i_id and IsActive='Y'
 set @i_OutParam ='Mapping associated to strategy';
 end
 else 
 begin

delete from tbl_ftastrategynamemapping where id =@i_id;
 set @i_OutParam ='success';
end;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAApplicationOwner]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_FTAApplicationOwner](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_FTAApplicationOwner_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAApplicationName]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_FTAApplicationName](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_FTAApplicationName_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_country]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_country](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_country_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_ChildID]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_ChildID](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_ChildID_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_Capacity]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_Capacity](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_Capacity_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_BusinessSuffix]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_BusinessSuffix](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_BusinessSuffix_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_BusinessMapping]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_delete_BusinessMapping](
 @i_id INT
,
 @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN
SET NOCOUNT ON;
declare @Shortcode varchar(150);
 IF exists (SELECT FTAShortCodeId FROM tbl_strategy  WHERE BusinessMappingId=@i_id AND IsActive='Y') 
 begin
 SELECT @Shortcode=FTAShortCodeId FROM tbl_strategy  WHERE BusinessMappingId=@i_id AND IsActive='Y'
 set @i_OutParam ='Mapping associated to strategy';
 end
 else 
 begin
delete from tbl_businessmapping where id =@i_id;
set @i_OutParam ='success';
end;


END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_BusinessLine]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_BusinessLine](
 @i_id INT
)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_BusinessLine_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_Business]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_Business](
 @i_id INT
)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_Business_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_updateuser]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_updateuser
CREATE  PROCEDURE [dbo].[sp_updateuser](
 @i_userid VARCHAR(50),
 @i_username VARCHAR(50),
 @i_emailid VARCHAR(50),
 @i_Roleid VARCHAR(50),
 @i_status VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_user_master set UserName=@i_username,EmailId=@i_emailid,RoleId=@i_Roleid,Status=@i_status 
where Userid=@i_userid;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_updateFTAApplicationMapping]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[sp_updateFTAApplicationMapping](
 @i_ID int,
 @i_FTAApplicationNameId VARCHAR(50),
 @i_FTAApplicationCodeId VARCHAR(50),
 @i_ChildId VARCHAR(50),
 @i_ThirdPartyAppId VARCHAR(50),
 @i_ParentID VARCHAR(50),
 @i_ApplicationOwnerId VARCHAR(500),
 @i_ApplicationCategoryId VARCHAR(50),
 @i_OutParam VARCHAR(50) Output
 )
AS
BEGIN

 update tbl_FTAApplicationmapping  set ApplicationOwnerId=@i_ApplicationOwnerId  where Id=@i_id; 

set @i_OutParam ='success';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_Venuetypemaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_update_Venuetypemaster](
 @i_id INT,
 @i_Venuetype VARCHAR(50),
 @i_Venuetypecode VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT

)
AS
BEGIN
IF exists (SELECT id FROM tbl_Venuetype_master WHERE Venuetype=@i_Venuetype  and Id!=@i_id) 
 set @i_OutParam ='Venue Type already exists'; 
 else
 begin
update tbl_Venuetype_master set Venuetype=@i_Venuetype,VenueTypecode=@i_Venuetypecode  where id=@i_id;
set @i_OutParam ='success';

end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_Strategytypemaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_Strategytypemaster
CREATE  PROCEDURE [dbo].[sp_update_Strategytypemaster](
 @i_id INT,
 @i_Strategytype VARCHAR(50),
 @i_Strategytypecode VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_Strategytype_master WHERE StrategyType=@i_Strategytype and Id!=@i_id) 
 set @i_OutParam ='Strategy Type already exists'; 
 else
 begin
update tbl_Strategytype_master set StrategyType=@i_Strategytype,StrategyTypecode=@i_Strategytypecode where id=@i_id;
set @i_OutParam ='success';

end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_regionmaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_regionmaster
CREATE  PROCEDURE [dbo].[sp_update_regionmaster](
 @i_id INT,
 @i_regionname VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_region_master WHERE regionname=@i_regionname  and Id!=@i_id) 
 set @i_OutParam ='Region Name already exists'; 
 
 else
 begin
update tbl_region_master set regionname=@i_regionname where id=@i_id;
set @i_OutParam ='success';

end

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_ParentIDmaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_ParentIDmaster
CREATE  PROCEDURE [dbo].[sp_update_ParentIDmaster](
 @i_id INT,
 @i_ParentID VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_ParentID_master WHERE ParentID=@i_ParentID and Id!=@i_id) 
 set @i_OutParam ='Parent ID already exists'; 
 
 else
 begin

update tbl_ParentID_master set ParentID =@i_ParentID where id=@i_id;
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAStrategyNamemaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_FTAStrategyNamemaster
CREATE  PROCEDURE [dbo].[sp_update_FTAStrategyNamemaster](
 @i_id INT,
 @i_FTAStrategyName VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_FTAStrategyName_master WHERE FTAStrategyName=@i_FTAStrategyName  and id !=@i_id)
set @i_OutParam ='FTA Strategy Name already exists';
 else
 begin
update tbl_FTAStrategyName_master set FTAStrategyName=@i_FTAStrategyName where id=@i_id;
set @i_OutParam ='success';

end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAStrategyCodemaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_FTAStrategyCodemaster
CREATE  PROCEDURE [dbo].[sp_update_FTAStrategyCodemaster](
 @i_id INT,
 @i_FTAStrategyCode VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_FTAStrategyCode_master WHERE FTAStrategyCode=@i_FTAStrategyCode and id !=@i_id)
set @i_OutParam ='FTA Strategy Code already exists';
 
 else
 begin

update tbl_FTAStrategyCode_master set FTAStrategyCode=@i_FTAStrategyCode where id=@i_id;
set @i_OutParam ='success';

end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAApplicationNamemaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_update_FTAApplicationNamemaster](
 @i_id INT,
 @i_FTAApplicationName VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_FTAApplicationName_master WHERE FTAApplicationName=@i_FTAApplicationName and id !=@i_id)
set @i_OutParam ='FTA Application Name already exists';
 
 else
 begin

update tbl_FTAApplicationName_master set FTAApplicationName=@i_FTAApplicationName where id=@i_id;
set @i_OutParam ='success';

end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAApplicationCodemaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_FTAApplicationCodemaster
CREATE  PROCEDURE [dbo].[sp_update_FTAApplicationCodemaster](
 @i_id INT,
 @i_FTAApplicationCode VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT

)
AS
BEGIN


IF exists (SELECT * FROM tbl_FTAApplicationCode_master WHERE FTAApplicationCode=@i_FTAApplicationCode   and id !=@i_id)
set @i_OutParam ='FTA Application Code already exists';

 else
 begin
update tbl_FTAApplicationCode_master set FTAApplicationCode=@i_FTAApplicationCode where id=@i_id;
set @i_OutParam ='success';

end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_DiscretionaryCodemaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_update_DiscretionaryCodemaster](
 @i_id INT,
 @i_DiscretionaryCode VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT

)
AS
BEGIN


IF exists (SELECT * FROM tbl_DiscretionaryCode_master WHERE DiscretionaryCode=@i_DiscretionaryCode and id !=@i_id)
set @i_OutParam ='Discretionary Code already exists';
 else
 begin
update tbl_DiscretionaryCode_master set DiscretionaryCode=@i_DiscretionaryCode where id=@i_id;
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_countrymaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_update_countrymaster](
 @i_id INT,
 @i_countryname VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_country_master WHERE countryname=@i_countryname and Id!=@i_id) 
 set @i_OutParam ='Country name already exists'; 
 else
 begin
 
update tbl_country_master set countryname=@i_countryname where id=@i_id;
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_ChildIDmaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_ChildIDmaster
CREATE  PROCEDURE [dbo].[sp_update_ChildIDmaster](
 @i_id INT,
 @i_ChildID VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT

)
AS
BEGIN

IF exists (SELECT * FROM tbl_ChildID_master  WHERE ChildID=@i_ChildID and Id!=@i_id) 
 set @i_OutParam ='Child ID already exists';
 else
 begin
update tbl_ChildID_master set ChildID =@i_ChildID where id=@i_id;
set @i_OutParam ='success';
end;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_Capacitymaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_Capacitymaster
CREATE  PROCEDURE [dbo].[sp_update_Capacitymaster](
 @i_id INT,
 @i_Capacity VARCHAR(50),
 @i_Capacitycode VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_Capacity_master  WHERE Capacity=@i_Capacity and Id !=@i_id) 
set @i_OutParam ='Capacity already exists';
 else
 begin

update tbl_Capacity_master set Capacity =@i_Capacity,Capacitycode=@i_Capacitycode  where id=@i_id;
set @i_OutParam ='success';
END;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_BusinessSuffixmaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_BusinessSuffixmaster
CREATE  PROCEDURE [dbo].[sp_update_BusinessSuffixmaster](
 @i_id INT,
 @i_BusinessSuffix VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN



IF exists (SELECT * FROM tbl_BusinessSuffix_master  WHERE BusinessSuffix=@i_BusinessSuffix and Id!=@i_id) 
 set @i_OutParam ='Business Suffix already exists';
 else
 begin
update tbl_BusinessSuffix_master set BusinessSuffix =@i_BusinessSuffix where id=@i_id;
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_BusinessLinemaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_BusinessLinemaster
CREATE  PROCEDURE [dbo].[sp_update_BusinessLinemaster](
 @i_id INT,
 @i_BusinessLine VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN


IF exists (SELECT * FROM tbl_BusinessLine_master  WHERE BusinessLine=@i_BusinessLine and Id!=@i_id)
set @i_OutParam ='Business Line already exists';
 else
 begin

update tbl_BusinessLine_master set BusinessLine=@i_BusinessLine  where id=@i_id;
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_Business]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_Business
CREATE  PROCEDURE [dbo].[sp_update_Business](
 @i_id INT,
 @i_Business VARCHAR(50)

,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN


IF exists (SELECT  id from tbl_Business_master  WHERE Business=@i_Business and Id !=@i_id) 
 set @i_OutParam ='Business already exists';
 else
 begin
update tbl_Business_master set Business =@i_Business  where id=@i_id;
set @i_OutParam ='success';
end;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_ApplicationCategorymaster]    Script Date: 03/21/2018 00:57:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_update_ApplicationCategorymaster](
 @i_id INT,
 @i_ApplicationCategory VARCHAR(50)

,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

if exists(select id from tbl_applicationcategory_master where ApplicationCategory=@i_ApplicationCategory and id !=@i_id)
set @i_OutParam ='Application Category already exists';
else
begin
update tbl_ApplicationCategory_master set ApplicationCategory=@i_ApplicationCategory where id=@i_id;
set @i_OutParam ='success';
end
END;
GO
/****** Object:  Default [DF__tbl_venue__Venue__39237A9A]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_venuetype_master] ADD  CONSTRAINT [DF__tbl_venue__Venue__39237A9A]  DEFAULT ('0') FOR [VenueType]
GO
/****** Object:  Default [DF__tbl_venue__IsAct__3A179ED3]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_venuetype_master] ADD  CONSTRAINT [DF__tbl_venue__IsAct__3A179ED3]  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_userr__Reser__220B0B18]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_userregionmapping] ADD  DEFAULT (NULL) FOR [Reserved1]
GO
/****** Object:  Default [DF__tbl_userc__Reser__2116E6DF]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_usercountrymapping] ADD  DEFAULT (NULL) FOR [Reserved1]
GO
/****** Object:  Default [DF__tbl_userb__Reser__2022C2A6]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_userbusinesssectormapping] ADD  DEFAULT (NULL) FOR [Reserved1]
GO
/****** Object:  Default [DF__tbl_user___UserN__1C873BEC]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___UserN__1C873BEC]  DEFAULT (NULL) FOR [UserName]
GO
/****** Object:  Default [DF__tbl_user___Busin__1D7B6025]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Busin__1D7B6025]  DEFAULT (NULL) FOR [BusinessSectorId]
GO
/****** Object:  Default [DF__tbl_user___RoleI__1E6F845E]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___RoleI__1E6F845E]  DEFAULT (NULL) FOR [RoleId]
GO
/****** Object:  Default [DF__tbl_user___Passw__1F63A897]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Passw__1F63A897]  DEFAULT (NULL) FOR [Password]
GO
/****** Object:  Default [DF__tbl_user___Email__2057CCD0]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Email__2057CCD0]  DEFAULT (NULL) FOR [EmailId]
GO
/****** Object:  Default [DF__tbl_user___Mobil__214BF109]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Mobil__214BF109]  DEFAULT (NULL) FOR [MobileNumber]
GO
/****** Object:  Default [DF__tbl_user___Custo__22401542]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Custo__22401542]  DEFAULT (NULL) FOR [CustomData]
GO
/****** Object:  Default [DF__tbl_user___Statu__2334397B]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Statu__2334397B]  DEFAULT (NULL) FOR [Status]
GO
/****** Object:  Default [DF__tbl_user___UserE__24285DB4]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___UserE__24285DB4]  DEFAULT (NULL) FOR [UserExpiryDate]
GO
/****** Object:  Default [DF__tbl_user___Passw__251C81ED]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Passw__251C81ED]  DEFAULT (NULL) FOR [PasswordExpiryDate]
GO
/****** Object:  Default [DF__tbl_user___UserB__2610A626]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___UserB__2610A626]  DEFAULT (NULL) FOR [UserBlockDate]
GO
/****** Object:  Default [DF__tbl_user___Attem__2704CA5F]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Attem__2704CA5F]  DEFAULT (NULL) FOR [AttemptTries]
GO
/****** Object:  Default [DF__tbl_user___LastA__27F8EE98]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___LastA__27F8EE98]  DEFAULT (NULL) FOR [LastAuthenticatedDate]
GO
/****** Object:  Default [DF__tbl_user___LastU__28ED12D1]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___LastU__28ED12D1]  DEFAULT (NULL) FOR [LastUsedDate]
GO
/****** Object:  Default [DF__tbl_user___Creat__29E1370A]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Creat__29E1370A]  DEFAULT (NULL) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_user___Creat__2AD55B43]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Creat__2AD55B43]  DEFAULT (NULL) FOR [CreatedBy]
GO
/****** Object:  Default [DF__tbl_user___Modif__2BC97F7C]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Modif__2BC97F7C]  DEFAULT (NULL) FOR [ModifiedDate]
GO
/****** Object:  Default [DF__tbl_user___Modif__2CBDA3B5]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Modif__2CBDA3B5]  DEFAULT (NULL) FOR [ModifiedBy]
GO
/****** Object:  Default [DF__tbl_user___Appro__2DB1C7EE]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Appro__2DB1C7EE]  DEFAULT (NULL) FOR [ApprovedDate]
GO
/****** Object:  Default [DF__tbl_user___Appro__2EA5EC27]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Appro__2EA5EC27]  DEFAULT (NULL) FOR [Approvedby]
GO
/****** Object:  Default [DF__tbl_user___Maker__2F9A1060]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Maker__2F9A1060]  DEFAULT (NULL) FOR [MakerComment]
GO
/****** Object:  Default [DF__tbl_user___Check__308E3499]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Check__308E3499]  DEFAULT (NULL) FOR [CheckerComment]
GO
/****** Object:  Default [DF__tbl_user___IsADU__318258D2]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___IsADU__318258D2]  DEFAULT (NULL) FOR [IsADUser]
GO
/****** Object:  Default [DF__tbl_user___Regio__32767D0B]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Regio__32767D0B]  DEFAULT (NULL) FOR [RegionId]
GO
/****** Object:  Default [DF__tbl_user___Count__336AA144]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Count__336AA144]  DEFAULT (NULL) FOR [CountryId]
GO
/****** Object:  Default [DF__tbl_user___First__345EC57D]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___First__345EC57D]  DEFAULT (NULL) FOR [FirstWorkingDate]
GO
/****** Object:  Default [DF__tbl_user___LastW__3552E9B6]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___LastW__3552E9B6]  DEFAULT (NULL) FOR [LastWorkingDate]
GO
/****** Object:  Default [DF__tbl_user___Locat__36470DEF]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Locat__36470DEF]  DEFAULT (NULL) FOR [LocationId]
GO
/****** Object:  Default [DF__tbl_third__Third__047AA831]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_thirdpartyapplication] ADD  DEFAULT ('0') FOR [ThirdPartyAppName]
GO
/****** Object:  Default [DF__tbl_syste__Syste__02925FBF]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_systemflowmaster] ADD  DEFAULT ('0') FOR [SystemFlow]
GO
/****** Object:  Default [DF__tbl_syste__IsAct__038683F8]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_systemflowmaster] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_strat__RefNu__7CD98669]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [RefNumber]
GO
/****** Object:  Default [DF__tbl_strat__Versi__7DCDAAA2]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [Version]
GO
/****** Object:  Default [DF__tbl_strat__Chang__7EC1CEDB]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [ChangeDesc]
GO
/****** Object:  Default [DF__tbl_strat__FTASh__7FB5F314]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [FTAShortCode]
GO
/****** Object:  Default [DF__tbl_strat__Creat__00AA174D]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_strat__Creat__019E3B86]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
/****** Object:  Default [DF__tbl_strat__Strat__03BB8E22]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategytype_master] ADD  CONSTRAINT [DF__tbl_strat__Strat__03BB8E22]  DEFAULT ('0') FOR [StrategyType]
GO
/****** Object:  Default [DF__tbl_strat__IsAct__04AFB25B]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategytype_master] ADD  CONSTRAINT [DF__tbl_strat__IsAct__04AFB25B]  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_strat__RefNu__6D9742D9]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT ('0') FOR [RefNumber]
GO
/****** Object:  Default [DF__tbl_strat__Versi__6E8B6712]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Version]
GO
/****** Object:  Default [DF__tbl_strat__Appro__6F7F8B4B]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Approver]
GO
/****** Object:  Default [DF__tbl_strat__Comme__7073AF84]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Comments]
GO
/****** Object:  Default [DF__tbl_strat__Appro__7167D3BD]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [ApprovedDate]
GO
/****** Object:  Default [DF__tbl_strat__Creat__725BF7F6]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_strat__Statu__73501C2F]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Status]
GO
/****** Object:  Default [DF__tbl_strat__Uploa__74444068]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Uploadedby]
GO
/****** Object:  Default [DF__tbl_strat__IsAct__753864A1]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_strat__IsTra__762C88DA]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsTransfered]
GO
/****** Object:  Default [DF__tbl_strat__IsDel__7720AD13]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsDelegateAccepted]
GO
/****** Object:  Default [DF__tbl_strat__IsVie__7814D14C]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsViewed]
GO
/****** Object:  Default [DF__tbl_strat__IsMod__7908F585]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsModified]
GO
/****** Object:  Default [DF__tbl_strate__Type__79FD19BE]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Type]
GO
/****** Object:  Default [DF__tbl_strat__RefNu__3F115E1A]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__RefNu__3F115E1A]  DEFAULT (NULL) FOR [RefNumber]
GO
/****** Object:  Default [DF__tbl_strat__FTAAp__40058253]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTAAp__40058253]  DEFAULT (NULL) FOR [FTAApplicationCodeId]
GO
/****** Object:  Default [DF__tbl_strat__FTASt__40F9A68C]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASt__40F9A68C]  DEFAULT (NULL) FOR [FTAStrategyCodeId]
GO
/****** Object:  Default [DF__tbl_strat__Discr__41EDCAC5]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Discr__41EDCAC5]  DEFAULT (NULL) FOR [DiscretionaryCodeId]
GO
/****** Object:  Default [DF__tbl_strat__Busin__42E1EEFE]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Busin__42E1EEFE]  DEFAULT (NULL) FOR [BusinessSuffixId]
GO
/****** Object:  Default [DF__tbl_strat__FTASh__43D61337]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASh__43D61337]  DEFAULT (NULL) FOR [FTAShortCodeId]
GO
/****** Object:  Default [DF__tbl_strat__Paren__44CA3770]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Paren__44CA3770]  DEFAULT (NULL) FOR [ParentId]
GO
/****** Object:  Default [DF__tbl_strat__Child__45BE5BA9]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Child__45BE5BA9]  DEFAULT (NULL) FOR [ChildId]
GO
/****** Object:  Default [DF__tbl_strat__Busin__46B27FE2]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Busin__46B27FE2]  DEFAULT (NULL) FOR [BusinessLineId]
GO
/****** Object:  Default [DF__tbl_strat__Regio__47A6A41B]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Regio__47A6A41B]  DEFAULT (NULL) FOR [RegionId]
GO
/****** Object:  Default [DF__tbl_strat__FTAAp__498EEC8D]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTAAp__498EEC8D]  DEFAULT (NULL) FOR [FTAApplicationNameId]
GO
/****** Object:  Default [DF__tbl_strat__Count__4A8310C6]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Count__4A8310C6]  DEFAULT (NULL) FOR [CountryIdList]
GO
/****** Object:  Default [DF__tbl_strat__Count__4B7734FF]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Count__4B7734FF]  DEFAULT (NULL) FOR [CountryNameList]
GO
/****** Object:  Default [DF__tbl_strat__FTAAp__4C6B5938]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTAAp__4C6B5938]  DEFAULT (NULL) FOR [FTAApplicationOwnerId]
GO
/****** Object:  Default [DF__tbl_strat__FTATh__4D5F7D71]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTATh__4D5F7D71]  DEFAULT (NULL) FOR [AdditionalShortcode]
GO
/****** Object:  Default [DF__tbl_strat__FTASt__4E53A1AA]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASt__4E53A1AA]  DEFAULT (NULL) FOR [FTAStrategyNameId]
GO
/****** Object:  Default [DF__tbl_strat__FTASt__4F47C5E3]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASt__4F47C5E3]  DEFAULT (NULL) FOR [FTAStrategyOwnerId]
GO
/****** Object:  Default [DF__tbl_strat__Appli__51300E55]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Appli__51300E55]  DEFAULT (NULL) FOR [ApplicationCategoryId]
GO
/****** Object:  Default [DF__tbl_strat__Prior__5224328E]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Prior__5224328E]  DEFAULT (NULL) FOR [Priority]
GO
/****** Object:  Default [DF__tbl_strat__Strat__531856C7]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Strat__531856C7]  DEFAULT (NULL) FOR [StrategyTypeId]
GO
/****** Object:  Default [DF__tbl_strat__Prior__540C7B00]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Prior__540C7B00]  DEFAULT (NULL) FOR [PriorityScore]
GO
/****** Object:  Default [DF__tbl_strat__Venue__55009F39]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Venue__55009F39]  DEFAULT (NULL) FOR [VenueTypeId]
GO
/****** Object:  Default [DF__tbl_strat__Capac__55F4C372]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Capac__55F4C372]  DEFAULT (NULL) FOR [CapacityId]
GO
/****** Object:  Default [DF__tbl_strat__GoLiv__56E8E7AB]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__GoLiv__56E8E7AB]  DEFAULT (NULL) FOR [GoLiveDate]
GO
/****** Object:  Default [DF__tbl_strat__Third__57DD0BE4]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Third__57DD0BE4]  DEFAULT (NULL) FOR [ThirdPartyAppId]
GO
/****** Object:  Default [DF__tbl_strat__Busin__58D1301D]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Busin__58D1301D]  DEFAULT (NULL) FOR [BusinessId]
GO
/****** Object:  Default [DF__tbl_strat__FTAAp__59C55456]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTAAp__59C55456]  DEFAULT (NULL) FOR [FTAApplicationMappingId]
GO
/****** Object:  Default [DF__tbl_strat__FTASt__5AB9788F]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASt__5AB9788F]  DEFAULT (NULL) FOR [FTAStrategyMappingId]
GO
/****** Object:  Default [DF__tbl_strat__Busin__5BAD9CC8]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Busin__5BAD9CC8]  DEFAULT (NULL) FOR [BusinessMappingId]
GO
/****** Object:  Default [DF__tbl_strat__DeCom__5CA1C101]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__DeCom__5CA1C101]  DEFAULT (NULL) FOR [DeComissionedDate]
GO
/****** Object:  Default [DF__tbl_strat__Versi__607251E5]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Versi__607251E5]  DEFAULT ('1') FOR [Version]
GO
/****** Object:  Default [DF__tbl_strat__SignO__6166761E]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__SignO__6166761E]  DEFAULT (NULL) FOR [SignOff]
GO
/****** Object:  Default [DF__tbl_strat__SignO__625A9A57]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__SignO__625A9A57]  DEFAULT (NULL) FOR [SignOffDate]
GO
/****** Object:  Default [DF__tbl_strat__Signo__634EBE90]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Signo__634EBE90]  DEFAULT (NULL) FOR [SignoffBy]
GO
/****** Object:  Default [DF__tbl_strat__IsAct__6442E2C9]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__IsAct__6442E2C9]  DEFAULT (NULL) FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_strat__Creat__65370702]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Creat__65370702]  DEFAULT (NULL) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_strat__Creat__662B2B3B]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Creat__662B2B3B]  DEFAULT (NULL) FOR [CreatedBy]
GO
/****** Object:  Default [DF__tbl_strat__LastM__671F4F74]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__LastM__671F4F74]  DEFAULT (NULL) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF__tbl_strat__LastM__681373AD]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__LastM__681373AD]  DEFAULT (NULL) FOR [LastModifiedBy]
GO
/****** Object:  Default [DF__tbl_strate__Res1__690797E6]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res1__690797E6]  DEFAULT (NULL) FOR [Res1]
GO
/****** Object:  Default [DF__tbl_strate__Res2__69FBBC1F]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res2__69FBBC1F]  DEFAULT (NULL) FOR [Res2]
GO
/****** Object:  Default [DF__tbl_strate__Res3__6AEFE058]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res3__6AEFE058]  DEFAULT (NULL) FOR [Res3]
GO
/****** Object:  Default [DF__tbl_strate__Res4__6BE40491]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res4__6BE40491]  DEFAULT (NULL) FOR [Res4]
GO
/****** Object:  Default [DF__tbl_strate__Res5__6CD828CA]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res5__6CD828CA]  DEFAULT (NULL) FOR [Res5]
GO
/****** Object:  Default [DF__tbl_strate__Res6__6DCC4D03]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res6__6DCC4D03]  DEFAULT (NULL) FOR [Res6]
GO
/****** Object:  Default [DF__tbl_strate__Res7__6EC0713C]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res7__6EC0713C]  DEFAULT (NULL) FOR [Res7]
GO
/****** Object:  Default [DF__tbl_strate__Res8__6FB49575]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res8__6FB49575]  DEFAULT (NULL) FOR [Res8]
GO
/****** Object:  Default [DF__tbl_strate__Res9__70A8B9AE]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res9__70A8B9AE]  DEFAULT (NULL) FOR [Res9]
GO
/****** Object:  Default [DF__tbl_strat__Res10__719CDDE7]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Res10__719CDDE7]  DEFAULT (NULL) FOR [Res10]
GO
/****** Object:  Default [DF__tbl_roler__RoleI__382F5661]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_roleright_mapping] ADD  DEFAULT (NULL) FOR [RoleID]
GO
/****** Object:  Default [DF__tbl_roler__Right__39237A9A]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_roleright_mapping] ADD  DEFAULT (NULL) FOR [RightID]
GO
/****** Object:  Default [DF__tbl_role___RoleN__336AA144]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [RoleName]
GO
/****** Object:  Default [DF__tbl_role___Creat__345EC57D]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_role___Creat__3552E9B6]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
/****** Object:  Default [DF__tbl_role___Modif__36470DEF]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [ModifiedDate]
GO
/****** Object:  Default [DF__tbl_role___Modif__373B3228]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [ModifiedBy]
GO
/****** Object:  Default [DF__tbl_right__Right__2CBDA3B5]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [RightID]
GO
/****** Object:  Default [DF__tbl_right__Right__2DB1C7EE]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [RightName]
GO
/****** Object:  Default [DF__tbl_right__MenuN__2EA5EC27]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [MenuName]
GO
/****** Object:  Default [DF__tbl_right___Path__2F9A1060]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [Path]
GO
/****** Object:  Default [DF__tbl_right___Icon__308E3499]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [Icon]
GO
/****** Object:  Default [DF__tbl_right__ShowM__318258D2]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [ShowMenu]
GO
/****** Object:  Default [DF__tbl_right__IsAct__32767D0B]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_prior__Prior__29E1370A]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_priority_master] ADD  DEFAULT ('0') FOR [Priority]
GO
/****** Object:  Default [DF__tbl_prior__IsAct__2AD55B43]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_priority_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_paren__Paren__27F8EE98]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_parentid_master] ADD  DEFAULT ('0') FOR [ParentId]
GO
/****** Object:  Default [DF__tbl_paren__IsAct__28ED12D1]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_parentid_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftast__FTASt__2610A626]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftastrategyowner_master] ADD  DEFAULT ('0') FOR [FTAStrategyOwner]
GO
/****** Object:  Default [DF__tbl_ftast__IsAct__2704CA5F]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftastrategyowner_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftast__FTASt__24285DB4]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftastrategyname_master] ADD  DEFAULT ('0') FOR [FTAStrategyName]
GO
/****** Object:  Default [DF__tbl_ftast__IsAct__251C81ED]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftastrategyname_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftast__FTASt__22401542]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftastrategycode_master] ADD  DEFAULT ('0') FOR [FTAStrategyCode]
GO
/****** Object:  Default [DF__tbl_ftast__IsAct__2334397B]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftastrategycode_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftaap__FTAAp__2057CCD0]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationowner_master] ADD  DEFAULT ('0') FOR [FTAApplicationOwner]
GO
/****** Object:  Default [DF__tbl_ftaap__IsAct__214BF109]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationowner_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftaap__FTAAp__1E6F845E]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationname_master] ADD  DEFAULT ('0') FOR [FTAApplicationName]
GO
/****** Object:  Default [DF__tbl_ftaap__IsAct__1F63A897]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationname_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftaap__FTAAp__1A9EF37A]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [FTAApplicationNameId]
GO
/****** Object:  Default [DF__tbl_ftaap__FTAAp__1B9317B3]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [FTAApplicationCodeId]
GO
/****** Object:  Default [DF__tbl_ftaap__Child__1C873BEC]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [ChildId]
GO
/****** Object:  Default [DF__tbl_ftaap__Third__1D7B6025]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [ThirdPartyAppId]
GO
/****** Object:  Default [DF__tbl_ftaap__FTAAp__18B6AB08]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationcode_master] ADD  DEFAULT ('0') FOR [FTAApplicationCode]
GO
/****** Object:  Default [DF__tbl_ftaap__IsAct__19AACF41]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationcode_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_discr__Discr__16CE6296]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_discretionarycode_master] ADD  DEFAULT ('0') FOR [Discretionarycode]
GO
/****** Object:  Default [DF__tbl_discr__IsAct__17C286CF]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_discretionarycode_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_count__Count__15DA3E5D]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_country_master] ADD  DEFAULT (NULL) FOR [CountryName]
GO
/****** Object:  Default [DF__tbl_child__Child__13F1F5EB]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_childid_master] ADD  DEFAULT ('0') FOR [ChildID]
GO
/****** Object:  Default [DF__tbl_child__IsAct__14E61A24]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_childid_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_capac__Capac__73BA3083]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_capacity_master] ADD  CONSTRAINT [DF__tbl_capac__Capac__73BA3083]  DEFAULT ('0') FOR [Capacity]
GO
/****** Object:  Default [DF__tbl_capac__IsAct__74AE54BC]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_capacity_master] ADD  CONSTRAINT [DF__tbl_capac__IsAct__74AE54BC]  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_busin__Busin__10216507]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_businesssuffix_master] ADD  DEFAULT ('0') FOR [BusinessSuffix]
GO
/****** Object:  Default [DF__tbl_busin__IsAct__11158940]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_businesssuffix_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_busine__Name__0F2D40CE]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_businesssector] ADD  DEFAULT ('0') FOR [Name]
GO
/****** Object:  Default [DF__tbl_busin__Busin__0D44F85C]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_businessline_master] ADD  DEFAULT ('0') FOR [BusinessLine]
GO
/****** Object:  Default [DF__tbl_busin__IsAct__0E391C95]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_businessline_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_busin__busin__0B5CAFEA]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_business_master] ADD  DEFAULT ('0') FOR [business]
GO
/****** Object:  Default [DF__tbl_busin__IsAct__0C50D423]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_business_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_appli__Appli__078C1F06]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_applicationcategory_master] ADD  DEFAULT ('0') FOR [ApplicationCategory]
GO
/****** Object:  Default [DF__tbl_appli__IsAct__0880433F]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_applicationcategory_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_aduse__UserN__7C1A6C5A]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [UserName]
GO
/****** Object:  Default [DF__tbl_aduse__Email__7D0E9093]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [EmailId]
GO
/****** Object:  Default [DF__tbl_aduse__Mobil__7E02B4CC]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [MobileNumber]
GO
/****** Object:  Default [DF__tbl_aduser_m__st__7EF6D905]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [st]
GO
/****** Object:  Default [DF__tbl_aduse__posta__7FEAFD3E]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [postalCode]
GO
/****** Object:  Default [DF__tbl_aduse__physi__00DF2177]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [physicalDeliveryOfficeName]
GO
/****** Object:  Default [DF__tbl_aduse__telep__01D345B0]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [telephoneNumber]
GO
/****** Object:  Default [DF__tbl_aduse__depar__02C769E9]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [department]
GO
/****** Object:  Default [DF__tbl_aduse__stree__03BB8E22]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [streetAddress]
GO
/****** Object:  Default [DF__tbl_aduse__manag__04AFB25B]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [manager]
GO
/****** Object:  Default [DF__tbl_aduse__homeP__05A3D694]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [homePhone]
GO
/****** Object:  Default [DF__tbl_aduse__descr__0697FACD]    Script Date: 03/21/2018 00:57:53 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [description]
GO

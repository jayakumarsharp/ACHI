USE [GDPR]
GO
/****** Object:  User [trinity]    Script Date: 03/21/2018 00:56:46 ******/
CREATE USER [trinity] FOR LOGIN [trinity] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tbl_userregionmapping]    Script Date: 03/21/2018 00:56:49 ******/
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
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'qw', 1, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'qw', 2, NULL)
/****** Object:  Table [dbo].[tbl_userDepartmentmapping]    Script Date: 03/21/2018 00:56:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_userDepartmentmapping](
	[Userid] [varchar](250) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[Reserved1] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tbl_userDepartmentmapping] ([Userid], [DepartmentId], [Reserved1]) VALUES (N'Sivakumar', 1, NULL)
INSERT [dbo].[tbl_userDepartmentmapping] ([Userid], [DepartmentId], [Reserved1]) VALUES (N'dd', 1, NULL)
INSERT [dbo].[tbl_userDepartmentmapping] ([Userid], [DepartmentId], [Reserved1]) VALUES (N'qw', 1, NULL)
INSERT [dbo].[tbl_userDepartmentmapping] ([Userid], [DepartmentId], [Reserved1]) VALUES (N'qw', 2, NULL)
/****** Object:  Table [dbo].[tbl_usercountrymapping]    Script Date: 03/21/2018 00:56:49 ******/
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
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'qw', 1, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'qw', 2, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'qw', 3, NULL)
/****** Object:  Table [dbo].[tbl_user_master]    Script Date: 03/21/2018 00:56:49 ******/
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
INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (3, N'kumar', N'kuma', NULL, N'1', N'MTIzNDU=', N'kumar@ss.com', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'No', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (4, N'man1', N'man', NULL, N'1', N'b21zYWt0aGk=', N'man@gmail.com', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'No', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (5, N'qqqq', N'qqq', NULL, N'2', N'MTIzNDU=', N'qq@d.d', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'No', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (6, N'qw', N'sss', NULL, N'1', N'MTIzNDU=', N'ss@s.com', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'No', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (1, N'Sivakumar', N'Sivakumar', NULL, N'1', N'd2VsY29tZQ==', N'Sivakumar@coba.com', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Yes', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_user_master] OFF
/****** Object:  Table [dbo].[tbl_strategyversionlog]    Script Date: 03/21/2018 00:56:49 ******/
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
SET IDENTITY_INSERT [dbo].[tbl_strategyversionlog] OFF
/****** Object:  Table [dbo].[tbl_strategytype_master]    Script Date: 03/21/2018 00:56:49 ******/
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
/****** Object:  Table [dbo].[tbl_StrategyStatus]    Script Date: 03/21/2018 00:56:49 ******/
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
/****** Object:  Table [dbo].[tbl_strategyapproval]    Script Date: 03/21/2018 00:56:49 ******/
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
SET IDENTITY_INSERT [dbo].[tbl_strategyapproval] OFF
/****** Object:  Table [dbo].[tbl_strategy]    Script Date: 03/21/2018 00:56:49 ******/
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
	[CountryId] [varchar](1000) NULL,
	[FTAApplicationNameId] [int] NULL,
	[CountryIdList] [varchar](100) NULL,
	[CountryNameList] [varchar](500) NULL,
	[FTAApplicationOwnerId] [varchar](50) NULL,
	[FTAThirdPartyapp] [varchar](50) NULL,
	[FTAStrategyNameId] [int] NULL,
	[FTAStrategyOwnerId] [varchar](50) NULL,
	[PriorityScoreId] [int] NULL,
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
	[DecomissionedEvidenceDocument] [varchar](100) NULL,
	[SystemFlow] [varchar](100) NULL,
	[NoOfApprover] [int] NULL,
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
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [CountryId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [FTAThirdPartyapp], [FTAStrategyNameId], [FTAStrategyOwnerId], [PriorityScoreId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [DecomissionedEvidenceDocument], [SystemFlow], [NoOfApprover], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (1, N'20180307004510747', 1, 1, 1, 1, N'12345123412345bs2', 1, 1, 1, 1, N'[{"name":"india","id":"1","$$hashKey":"object:197"},{"name":"Dubai","id":"3","$$hashKey":"object:207"}]', 2, N'1,3', N'india,Dubai', N'Sivakumar', NULL, 1, N'Sivakumar', NULL, 1, 3, 1, 4, 1, 1, CAST(0xF73D0B00 AS Date), 1, 1, 7, 1, 1, CAST(0xF73D0B00 AS Date), NULL, NULL, NULL, N'Test', 1, N'123', N'123', N'True', NULL, NULL, N'1', N'N', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [CountryId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [FTAThirdPartyapp], [FTAStrategyNameId], [FTAStrategyOwnerId], [PriorityScoreId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [DecomissionedEvidenceDocument], [SystemFlow], [NoOfApprover], [Description], [Version], [SeniorManagementFunction], [LTALongCode], [SignOff], [SignOffDate], [SignoffBy], [StatusId], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (2, N'20180307004510747', 1, 1, 1, 1, N'12345123412345bs2', 1, 1, 1, 1, N'[{"name":"india","id":"1","$$hashKey":"object:197"},{"name":"Dubai","id":"3","$$hashKey":"object:207"}]', 2, N'1,3,', N'india,Dubai,', N'Sivakumar', NULL, 1, N'Sivakumar', NULL, 1, 3, 1, 4, 1, 1, NULL, 1, 1, 7, 1, 1, NULL, NULL, NULL, NULL, N'Test', 2, N'123', N'123', N'True', NULL, NULL, N'1', N'Y', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_strategy] OFF
/****** Object:  Table [dbo].[tbl_roleright_mapping]    Script Date: 03/21/2018 00:56:49 ******/
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
SET IDENTITY_INSERT [dbo].[tbl_roleright_mapping] OFF
/****** Object:  Table [dbo].[tbl_role_master]    Script Date: 03/21/2018 00:56:49 ******/
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
SET IDENTITY_INSERT [dbo].[tbl_role_master] OFF
/****** Object:  Table [dbo].[tbl_right_master]    Script Date: 03/21/2018 00:56:49 ******/
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
/****** Object:  Table [dbo].[tbl_reportapplicationmapping]    Script Date: 03/21/2018 00:56:49 ******/
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
INSERT [dbo].[tbl_reportapplicationmapping] ([Id], [FTAApplicationNameId], [FTAApplicationCodeId], [ParentId], [ChildId], [ThirdPartyAppId], [ApplicationCategoryId], [ApplicationOwnerId], [RegionId], [CountryId], [BusinessLineId]) VALUES (7, 1, 1, 1, 1, 1, 1, N'Sivakumar', 1, 0, 1)
SET IDENTITY_INSERT [dbo].[tbl_reportapplicationmapping] OFF
/****** Object:  Table [dbo].[tbl_region_master]    Script Date: 03/21/2018 00:56:49 ******/
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
/****** Object:  Table [dbo].[tbl_priority_master]    Script Date: 03/21/2018 00:56:49 ******/
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
/****** Object:  Table [dbo].[tbl_parentid_master]    Script Date: 03/21/2018 00:56:49 ******/
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
/****** Object:  Table [dbo].[tbl_ftastrategyowner_master]    Script Date: 03/21/2018 00:56:49 ******/
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
/****** Object:  Table [dbo].[tbl_ftastrategynamemapping]    Script Date: 03/21/2018 00:56:49 ******/
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
/****** Object:  Table [dbo].[tbl_ftastrategyname_master]    Script Date: 03/21/2018 00:56:49 ******/
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
INSERT [dbo].[tbl_ftastrategyname_master] ([Id], [FTAStrategyName], [IsActive]) VALUES (1, N'ss2', 0)
INSERT [dbo].[tbl_ftastrategyname_master] ([Id], [FTAStrategyName], [IsActive]) VALUES (2, N'ss22', 0)
SET IDENTITY_INSERT [dbo].[tbl_ftastrategyname_master] OFF
/****** Object:  Table [dbo].[tbl_ftastrategycode_master]    Script Date: 03/21/2018 00:56:49 ******/
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
/****** Object:  Table [dbo].[tbl_ftaapplicationmapping]    Script Date: 03/21/2018 00:56:49 ******/
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
INSERT [dbo].[tbl_ftaapplicationmapping] ([Id], [FTAApplicationNameId], [FTAApplicationCodeId], [ChildId], [ThirdPartyAppId], [ParentId], [ApplicationOwnerId], [ApplicationCategoryId]) VALUES (7, 2, 1, 1, 1, 1, N'dd', 1)
INSERT [dbo].[tbl_ftaapplicationmapping] ([Id], [FTAApplicationNameId], [FTAApplicationCodeId], [ChildId], [ThirdPartyAppId], [ParentId], [ApplicationOwnerId], [ApplicationCategoryId]) VALUES (8, 1, 1, 1, 1, 1, N'Sivakumar', 1)
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationmapping] OFF
/****** Object:  Table [dbo].[tbl_ftaapplicationcode_master]    Script Date: 03/21/2018 00:56:50 ******/
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
/****** Object:  Table [dbo].[tbl_discretionarycode_master]    Script Date: 03/21/2018 00:56:50 ******/
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
/****** Object:  Table [dbo].[tbl_Department_master]    Script Date: 03/21/2018 00:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Department_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Department] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Department_master] ON
INSERT [dbo].[tbl_Department_master] ([Id], [Department], [IsActive]) VALUES (1, N'dept1', 0)
INSERT [dbo].[tbl_Department_master] ([Id], [Department], [IsActive]) VALUES (2, N'dept2', 0)
INSERT [dbo].[tbl_Department_master] ([Id], [Department], [IsActive]) VALUES (3, N'dept3', 0)
INSERT [dbo].[tbl_Department_master] ([Id], [Department], [IsActive]) VALUES (4, N'dept4', 0)
INSERT [dbo].[tbl_Department_master] ([Id], [Department], [IsActive]) VALUES (5, N'dept5', 0)
INSERT [dbo].[tbl_Department_master] ([Id], [Department], [IsActive]) VALUES (6, N'a', 0)
SET IDENTITY_INSERT [dbo].[tbl_Department_master] OFF
/****** Object:  Table [dbo].[tbl_CountryStrategyMapping]    Script Date: 03/21/2018 00:56:50 ******/
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
SET IDENTITY_INSERT [dbo].[tbl_CountryStrategyMapping] OFF
/****** Object:  Table [dbo].[tbl_CountryReportMapping]    Script Date: 03/21/2018 00:56:50 ******/
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
SET IDENTITY_INSERT [dbo].[tbl_CountryReportMapping] ON
INSERT [dbo].[tbl_CountryReportMapping] ([Id], [ReportId], [CountryId]) VALUES (4, 7, 1)
INSERT [dbo].[tbl_CountryReportMapping] ([Id], [ReportId], [CountryId]) VALUES (5, 7, 2)
INSERT [dbo].[tbl_CountryReportMapping] ([Id], [ReportId], [CountryId]) VALUES (6, 7, 3)
SET IDENTITY_INSERT [dbo].[tbl_CountryReportMapping] OFF
/****** Object:  Table [dbo].[tbl_country_master]    Script Date: 03/21/2018 00:56:50 ******/
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
/****** Object:  Table [dbo].[tbl_childid_master]    Script Date: 03/21/2018 00:56:50 ******/
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
/****** Object:  Table [dbo].[tbl_category_master]    Script Date: 03/21/2018 00:56:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_category_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_category_master] ON
INSERT [dbo].[tbl_category_master] ([Id], [Category], [IsActive]) VALUES (1, N'App2', 0)
INSERT [dbo].[tbl_category_master] ([Id], [Category], [IsActive]) VALUES (2, N'aa', 0)
INSERT [dbo].[tbl_category_master] ([Id], [Category], [IsActive]) VALUES (3, N'aa4', 0)
SET IDENTITY_INSERT [dbo].[tbl_category_master] OFF
/****** Object:  Table [dbo].[tbl_capacity_master]    Script Date: 03/21/2018 00:56:50 ******/
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
/****** Object:  Table [dbo].[tbl_businesssuffix_master]    Script Date: 03/21/2018 00:56:50 ******/
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
/****** Object:  Table [dbo].[tbl_businesssector]    Script Date: 03/21/2018 00:56:50 ******/
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
/****** Object:  Table [dbo].[tbl_businessmapping]    Script Date: 03/21/2018 00:56:50 ******/
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
/****** Object:  Table [dbo].[tbl_aduser_master]    Script Date: 03/21/2018 00:56:50 ******/
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
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 03/21/2018 00:56:53 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_StrategyDelegatesApprovalByuser]    Script Date: 03/21/2018 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.Get_StrategyDelegatesApprovalByuser
CREATE PROCEDURE [dbo].[Get_StrategyDelegatesApprovalByuser](
 @i_user VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

 Select  [Id], [RefNumber], [Version], [Approver], [OriginalApprover], [Comments], [ApprovedDate],[CreatedDate], [Status], [ActionStatus], [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]
 from tbl_approvaltransfer  where Approver=@i_user and IsActive='Y' and IsDelegateAccepted='P';
 

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallApplicationMaster]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallApplicationCategory]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallVenuetype]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getAllThirdPartyAppType]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallSystemFlow]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetuserBusinessSector]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_StrategyReport]    Script Date: 03/21/2018 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_StrategyReport](
 @i_FTAApplicationCode VARCHAR(50)=null,
 @i_FTAStrategyCode VARCHAR(50)=null,
 @i_BusinessLine VARCHAR(50)=null,
 @i_Region VARCHAR(50)=null,
 @i_Country VARCHAR(50)=null,
 @i_FTAApplicationOwner VARCHAR(50)=null,
 @i_ApplicationCategory VARCHAR(50)=null,
 @i_VenueType VARCHAR(50)=null,
 @i_FTAApplicationNameId VARCHAR(50)=null,
 @i_ParentID VARCHAR(50)=null,
 @i_ChildID VARCHAR(50)=null,
 @i_ThirdPartyAppId VARCHAR(50)=null,
 @i_userid VARCHAR(250)
)
AS
BEGIN
declare @Sql nvarchar(max);
declare @dynamicsql nvarchar(max);
declare @countryfilerSql nvarchar(max);
set @countryfilerSql='';
if(@i_Country !='' and @i_Country is not null )
set @countryfilerSql=' and c.id in ('+@i_Country+')'

SET @sql='select S.Id,S.RefNumber,FTAApplicationCodeId,FTAAC.FTAApplicationCode,FTAShortCodeId,FTAStrategyCodeId,FTASC.FTAStrategyCode,DiscretionaryCodeId,
DM.Discretionarycode,BusinessSuffixId,BSFM.BusinessSuffix,FTAStrategyCode,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,
BSL.BusinessLine,RegionId,R.RegionName,CountryId,FTAApplicationNameId,APN.FTAApplicationName,FTAStrategyOwnerId,ApplicationCategoryId,ACM.ApplicationCategory,
StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,
NoOfApprover,Version,FTAStrategyNameId,FTASN.FTAStrategyName,S.FTAApplicationOwnerId,
S.Priority,S.PriorityScore,case SignOff  WHEN ''True'' THEN ''Attested'' else ''Pending'' end as SignOff
,SignOffDate,SignoffBy,LastModifiedDate ,LastModifiedBy,ThirdPartyAppId,TM.ThirdPartyAppName,
BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,
S.DecomissionedDate,GoLiveDate,
S.StatusId,Ss.StatusName,
CountryIdList=STUFF  
(  
    (  
      SELECT DISTINCT '', ''+ CAST( C.id AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryStrategyMapping e   
      WHERE C.iD=e.CountryId and e.StrategyId=s.Id' +@countryfilerSql+'
      FOR XMl PATH('''')  
    ),1,1,''''  
)  ,
CountryNameList=STUFF  
(  
    (  
      SELECT DISTINCT '', ''+ CAST( C.CountryName AS VARCHAR(MAX))  
      FROM tbl_country_master C,tbl_CountryStrategyMapping e   
      WHERE C.iD=e.CountryId and e.StrategyId=s.Id ' +@countryfilerSql+'
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
 and RegionId in( select r.Id from tbl_userregionmapping rm join tbl_region_master r on rm.RegionId = r.Id where CountryIdList != null and  Userid='''+@i_userid+''')
  ';

SET @dynamicsql='';
if (@i_FTAApplicationCode != '' and @i_FTAApplicationCode is not null) begin
SET @dynamicsql=@dynamicsql+' and FTAApplicationCodeId ='+@i_FTAApplicationCode;
end 


if (@i_FTAStrategyCode IS NOT NULL and @i_FTAStrategyCode != '') begin

SET @dynamicsql=@dynamicsql+'  and FTAStrategyCodeId ='+@i_FTAStrategyCode;
end 

if (@i_BusinessLine != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and BusinessLineId ='+@i_BusinessLine;
end 


if (@i_Region != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and RegionId ='+@i_Region;
end 

--if (@i_Country != '') begin
	
--SET  @dynamicsql=@dynamicsql+'  and CountryIdList Like ''%'+@i_Country+'%''';
--end 


if (@i_FTAApplicationOwner != '') begin

SET  @dynamicsql=@dynamicsql+' and FTAApplicationOwnerId ='''+@i_FTAApplicationOwner+ char(39);
end 


if (@i_ApplicationCategory IS NOT NULL and @i_ApplicationCategory != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and ApplicationCategoryId='+@i_ApplicationCategory;
end 


if (@i_FTAApplicationCode != '') begin

	

SET  @dynamicsql=@dynamicsql+'  and FTAApplicationCodeId='+@i_FTAApplicationCode;
end 



if (@i_FTAApplicationNameId IS NOT NULL and @i_FTAApplicationNameId != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and FTAApplicationNameId='+@i_FTAApplicationNameId;
end 




if (@i_ParentID IS NOT NULL and @i_ParentID != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and PM.ID='+@i_ParentID;
end 



if (@i_ChildID IS NOT NULL and @i_ChildID != '') begin
	
SET  @dynamicsql=@dynamicsql+'  and CM.ID='+@i_ChildID;
end 

if (@i_ThirdPartyAppId IS NOT NULL and @i_ThirdPartyAppId != '') begin

SET  @dynamicsql=@dynamicsql+'  and S.ThirdPartyAppId='+@i_ThirdPartyAppId;
end 


	
if (@i_VenueType != '') begin
	

SET  @dynamicsql=@dynamicsql+'  and VenueTypeId='+@i_VenueType;
end 
	

	SET  @sql=@sql +@dynamicsql;

	
print(@sql)
EXECUTE (@sql);

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_ApplicationMaster]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_ApplicationCategory]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_addReportApplicationMapping]    Script Date: 03/21/2018 00:57:05 ******/
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
 @i_CountryId VARCHAR(50),
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
/****** Object:  StoredProcedure [dbo].[sp_addFTAStrategyMapping]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_addFTAApplicationMapping]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_addbusinessmapping]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_StrategyLatestversionById]    Script Date: 03/21/2018 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.Get_StrategyLatestversionById
CREATE  PROCEDURE [dbo].[Get_StrategyLatestversionById](
 @i_RefNumber VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;
Select Version from tbl_strategy where RefNumber=@i_RefNumber order by Version Desc ;--LIMIT 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_userregion]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_userDepartment]    Script Date: 03/21/2018 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_insert_userDepartment](
	@i_userid VARCHAR(250),
	@i_DepartmentId VARCHAR(250)
)as
BEGIN
insert into dbo.tbl_userDepartmentmapping (Userid,DepartmentId) values(@i_userid,@i_DepartmentId);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_usercountry]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_strategyVersionLog]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_Strategytype]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_strategy_Approval]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_Strategy]    Script Date: 03/21/2018 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_Strategy](
 @i_RefNumber VARCHAR(50),
 @i_CountryId VARCHAR(1000),
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
 @i_CountryIdList VARCHAR(100)  ,
 @i_CountryNameList VARCHAR(500),
 @i_StatusId VARCHAR(50),
 @i_CreatedBy VARCHAR(500)=null,
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
 insert into tbl_strategy(RefNumber,    CountryId, RegionId,  Description,   FTAApplicationCodeId,        BusinessSuffixId,        ChildID,
        FTAStrategyNameId,StrategytypeId,GOLiveDate,FTAStrategyCodeId,FTAShortCodeId,
        BusinessLineId,FTAApplicationNameId,FTAStrategyOwnerId,ApplicationCategoryId,VenuetypeId,
        DeComissionedDate,DiscretionaryCodeId,ParentID,FTAApplicationOwnerId,PriorityScore,Priority,
        CapacityId,CountryIdList,CountryNameList,IsActive,Version,ThirdPartyAppId,BusinessId,FTAApplicationMappingId,
		  FTAStrategyMappingId,BusinessMappingId,SignOff,CreatedBy,LTALongCode,SeniorManagementFunction,StatusId
		  ) values(@i_RefNumber,@i_CountryId,
 @i_RegionId,@i_Description,@i_FTAApplicationCodeId,@i_BusinessSuffixId,@i_ChildID,@i_FTAStrategyNameId,@i_StrategytypeId,
@i_GOLiveDate,@i_FTAStrategyCodeId,@i_FTAShortCode,@i_BusinessLineId,@i_FTAApplicationNameId,@i_FTAStrategyOwnerId,
@i_ApplicationCategoryId,@i_VenueTypeId,@i_DecommissionedDate,@i_DiscretionaryCodeId,@i_ParentID,@i_FTAApplicationOwnerId,@i_PriorityScore,
@i_Priority,@i_CapacityId,@i_CountryIdList,@i_CountryNameList, 'Y',@i_Version,@i_ThirdPartyAppId,@i_BusinessId,@i_FTAApplicationMappingId,@i_FTAStrategyMappingId,@i_BusinessMappingId,
@i_SignOff,@i_CreatedBy,@i_LTALongCode,@i_SeniorManagementFunction,@i_StatusId);


insert into dbo.tbl_CountryStrategyMapping (StrategyId,CountryId) select @@IDENTITY,Item from SplitString(@i_CountryIdList,',') 

set @i_OutParam ='success';
end;
ENd 
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_roleright]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_role]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_Region]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_Department]    Script Date: 03/21/2018 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_Department](
 @i_Department VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT

)
AS
BEGIN

IF exists (SELECT * FROM tbl_Department_master WHERE Department=@i_Department) 
set @i_OutParam ='Business Line already exists';

 else
 begin
insert into tbl_Department_master (Department) values(@i_Department);
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Category]    Script Date: 03/21/2018 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_insert_FTAApplicationName
CREATE  PROCEDURE [dbo].[sp_insert_Category](
 @i_category VARCHAR(50),
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN


IF exists (SELECT * FROM tbl_category_master  WHERE Category=@i_category) 
 set @i_OutParam ='Category already exists';
 else
 begin
insert into tbl_category_master (Category) values(@i_category);
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getusersbycondition]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getusers]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Getuserregion]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetuserDepartment]    Script Date: 03/21/2018 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.SP_GetuserBusinessSector
CREATE  PROCEDURE [dbo].[SP_GetuserDepartment](
 @i_userid VARCHAR(250)


)
AS
BEGIN
SET NOCOUNT ON;
select b.Id,b.Department from tbl_userDepartmentmapping bs join tbl_Department_master b  on bs.DepartmentId =b.Id where Userid=@i_userid;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_Getusercountry]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_getRolesbyuserassigned]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_GetRoles]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetRoleRights]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_GetRights]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetRightForUser]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getReportApplicationMappingFilter]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getReportApplicationMapping]    Script Date: 03/21/2018 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getmenuforuser]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getFTAStrategyMappingbyId]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getFTAStrategyMapping]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getFTAApplicationMappingbyId]    Script Date: 03/21/2018 00:57:06 ******/
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
 join tbl_user_master UM on UM.Userid=FAM.ApplicationOwnerId
 join tbl_parentId_master PM on PM.Id=FAM.ParentId
 join tbl_applicationcategory_Master AM on AM.Id =FAM.ApplicationCategoryId
 where FAM.FTAApplicationNameId=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getFTAApplicationMapping]    Script Date: 03/21/2018 00:57:06 ******/
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
 join tbl_user_master UM on UM.Userid=FAM.ApplicationOwnerId
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
  join tbl_user_master UM on UM.Userid=FAM.ApplicationOwnerId
 join tbl_parentId_master PM on PM.Id=FAM.ParentId
 join tbl_applicationcategory_Master AM on AM.Id =FAM.ApplicationCategoryId;
end
GO
/****** Object:  StoredProcedure [dbo].[sp_getbusinessmappingbyId]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getbusinessmapping]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallStrategytype]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallStrategyStatus]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllStrategybyId]    Script Date: 03/21/2018 00:57:06 ******/
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
FTAStrategyCode,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,BSL.BusinessLine,RegionId,R.RegionName,s.CountryId,FTAApplicationNameId,APN.FTAApplicationName,FTAApplicationOwnerId,ApplicationCategoryId,
ACM.ApplicationCategory,StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,NoOfApprover,Version,FTAStrategyNameId,FTASN.FTAStrategyName,
S.FTAStrategyOwnerId,S.Priority,S.PriorityScore, SignOff,SignOffDate,SignoffBy,LastModifiedDate ,LastModifiedBy,ThirdPartyAppId,TM.ThirdPartyAppName,BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,
S.StatusId,Ss.StatusName,
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllStrategy]    Script Date: 03/21/2018 00:57:06 ******/
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
  
FTAStrategyCodeId,FTASC.FTAStrategyCode,DiscretionaryCodeId,DM.Discretionarycode,BusinessSuffixId,BSFM.BusinessSuffix,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,BSL.BusinessLine,RegionId,R.RegionName,S.CountryId,FTAApplicationNameId,APN.FTAApplicationName,FTAApplicationOwnerId,ApplicationCategoryId,
ACM.ApplicationCategory,StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,NoOfApprover,Version,FTAStrategyNameId,FTASN.FTAStrategyName,
S.FTAStrategyOwnerId,S.Priority,S.PriorityScore, SignOff,SignOffDate,SignoffBy,ThirdPartyAppId,TM.ThirdPartyAppName,BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,
S.StatusId,Ss.StatusName,
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
/****** Object:  StoredProcedure [dbo].[sp_getallregion]    Script Date: 03/21/2018 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[sp_getallregion](
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
/****** Object:  StoredProcedure [dbo].[sp_getallDepartment]    Script Date: 03/21/2018 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_getallDepartment](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_Department_master where Id=@i_id;
end
else begin
select * from tbl_Department_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getallcountry]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallcategory]    Script Date: 03/21/2018 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[sp_getallcategory](
 @i_Id VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;


if(@i_Id !='') begin

select * from tbl_category_master where Id=@i_id;
end
else begin
select * from tbl_category_master;
end 



END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_strategyVersionLog]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeleteRole]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_strategy_Approval]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_region]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_country]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_category]    Script Date: 03/21/2018 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_delete_category](
 @i_id INT

)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_capacity_master where id=@i_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[Get_StrategyApprovalByUser]    Script Date: 03/21/2018 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.Get_StrategyApprovalById

-- Dumping structure for procedure achiv1.Get_StrategyApprovalByUser
CREATE PROCEDURE [dbo].[Get_StrategyApprovalByUser](
 @i_user VARCHAR(50)

)
AS
BEGIN

SELECT [Id], [RefNumber], [Version], [Approver], [OriginalApprover], [Comments], [ApprovedDate],[CreatedDate], [Status], [ActionStatus], [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]
 FROM tbl_approvaltransfer  where approver=@i_user and IsActive='Y' and IsDelegateAccepted='Y'
union
 Select 
 [Id], [RefNumber], [Version], [Approver], '' OriginalApprover, [Comments], [ApprovedDate],[CreatedDate], [Status], [ActionStatus], [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]
 from tbl_strategyapproval  where approver=@i_user and IsActive='Y' and IsTransfered ='N';
 

END;
GO
/****** Object:  StoredProcedure [dbo].[Get_StrategyApprovalById]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_DelegateApprovalByUser]    Script Date: 03/21/2018 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_DelegateApprovalByUser](
 @i_user VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

 Select  [Id], [RefNumber], [Version], [Approver], '' OriginalApprover, [Comments], [CreatedDate],[ApprovedDate], [Status],  [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]
 from tbl_strategyapproval  where Approver=@i_user and IsActive='Y' and IsDelegateAccepted ='N';
 

END;
GO
/****** Object:  StoredProcedure [dbo].[delete_userregion]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_userDepartment]    Script Date: 03/21/2018 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_userDepartment](
 @i_userid VARCHAR(250)
)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_userDepartmentmapping where Userid=@i_userid;

END;
GO
/****** Object:  StoredProcedure [dbo].[delete_usercountry]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_RoleRight]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_updateuser]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_regionmaster]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_Department]    Script Date: 03/21/2018 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_update_BusinessLinemaster
CREATE  PROCEDURE [dbo].[sp_update_Department](
 @i_id INT,
 @i_Department VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN


IF exists (SELECT * FROM tbl_Department_master  WHERE Department=@i_Department and Id!=@i_id)
set @i_OutParam ='Business Line already exists';
 else
 begin

update tbl_Department_master set Department=@i_Department  where id=@i_id;
set @i_OutParam ='success';
end
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_update_countrymaster]    Script Date: 03/21/2018 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_update_category]    Script Date: 03/21/2018 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[sp_update_category](
 @i_id INT,
 @i_category VARCHAR(50)
,
  @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN

IF exists (SELECT * FROM tbl_category_master WHERE Category=@i_category and id !=@i_id)
set @i_OutParam ='Category already exists';
 
 else
 begin

update tbl_category_master set Category=@i_category where id=@i_id;
set @i_OutParam ='success';

end
END;
GO
/****** Object:  Default [DF__tbl_userr__Reser__1699586C]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_userregionmapping] ADD  DEFAULT (NULL) FOR [Reserved1]
GO
/****** Object:  Default [DF__tbl_userb__Reser__14B10FFA]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_userDepartmentmapping] ADD  DEFAULT (NULL) FOR [Reserved1]
GO
/****** Object:  Default [DF__tbl_userc__Reser__15A53433]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_usercountrymapping] ADD  DEFAULT (NULL) FOR [Reserved1]
GO
/****** Object:  Default [DF__tbl_user___UserN__1C873BEC]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___UserN__1C873BEC]  DEFAULT (NULL) FOR [UserName]
GO
/****** Object:  Default [DF__tbl_user___Busin__1D7B6025]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Busin__1D7B6025]  DEFAULT (NULL) FOR [BusinessSectorId]
GO
/****** Object:  Default [DF__tbl_user___RoleI__1E6F845E]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___RoleI__1E6F845E]  DEFAULT (NULL) FOR [RoleId]
GO
/****** Object:  Default [DF__tbl_user___Passw__1F63A897]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Passw__1F63A897]  DEFAULT (NULL) FOR [Password]
GO
/****** Object:  Default [DF__tbl_user___Email__2057CCD0]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Email__2057CCD0]  DEFAULT (NULL) FOR [EmailId]
GO
/****** Object:  Default [DF__tbl_user___Mobil__214BF109]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Mobil__214BF109]  DEFAULT (NULL) FOR [MobileNumber]
GO
/****** Object:  Default [DF__tbl_user___Custo__22401542]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Custo__22401542]  DEFAULT (NULL) FOR [CustomData]
GO
/****** Object:  Default [DF__tbl_user___Statu__2334397B]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Statu__2334397B]  DEFAULT (NULL) FOR [Status]
GO
/****** Object:  Default [DF__tbl_user___UserE__24285DB4]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___UserE__24285DB4]  DEFAULT (NULL) FOR [UserExpiryDate]
GO
/****** Object:  Default [DF__tbl_user___Passw__251C81ED]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Passw__251C81ED]  DEFAULT (NULL) FOR [PasswordExpiryDate]
GO
/****** Object:  Default [DF__tbl_user___UserB__2610A626]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___UserB__2610A626]  DEFAULT (NULL) FOR [UserBlockDate]
GO
/****** Object:  Default [DF__tbl_user___Attem__2704CA5F]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Attem__2704CA5F]  DEFAULT (NULL) FOR [AttemptTries]
GO
/****** Object:  Default [DF__tbl_user___LastA__27F8EE98]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___LastA__27F8EE98]  DEFAULT (NULL) FOR [LastAuthenticatedDate]
GO
/****** Object:  Default [DF__tbl_user___LastU__28ED12D1]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___LastU__28ED12D1]  DEFAULT (NULL) FOR [LastUsedDate]
GO
/****** Object:  Default [DF__tbl_user___Creat__29E1370A]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Creat__29E1370A]  DEFAULT (NULL) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_user___Creat__2AD55B43]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Creat__2AD55B43]  DEFAULT (NULL) FOR [CreatedBy]
GO
/****** Object:  Default [DF__tbl_user___Modif__2BC97F7C]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Modif__2BC97F7C]  DEFAULT (NULL) FOR [ModifiedDate]
GO
/****** Object:  Default [DF__tbl_user___Modif__2CBDA3B5]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Modif__2CBDA3B5]  DEFAULT (NULL) FOR [ModifiedBy]
GO
/****** Object:  Default [DF__tbl_user___Appro__2DB1C7EE]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Appro__2DB1C7EE]  DEFAULT (NULL) FOR [ApprovedDate]
GO
/****** Object:  Default [DF__tbl_user___Appro__2EA5EC27]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Appro__2EA5EC27]  DEFAULT (NULL) FOR [Approvedby]
GO
/****** Object:  Default [DF__tbl_user___Maker__2F9A1060]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Maker__2F9A1060]  DEFAULT (NULL) FOR [MakerComment]
GO
/****** Object:  Default [DF__tbl_user___Check__308E3499]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Check__308E3499]  DEFAULT (NULL) FOR [CheckerComment]
GO
/****** Object:  Default [DF__tbl_user___IsADU__318258D2]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___IsADU__318258D2]  DEFAULT (NULL) FOR [IsADUser]
GO
/****** Object:  Default [DF__tbl_user___Regio__32767D0B]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Regio__32767D0B]  DEFAULT (NULL) FOR [RegionId]
GO
/****** Object:  Default [DF__tbl_user___Count__336AA144]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Count__336AA144]  DEFAULT (NULL) FOR [CountryId]
GO
/****** Object:  Default [DF__tbl_user___First__345EC57D]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___First__345EC57D]  DEFAULT (NULL) FOR [FirstWorkingDate]
GO
/****** Object:  Default [DF__tbl_user___LastW__3552E9B6]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___LastW__3552E9B6]  DEFAULT (NULL) FOR [LastWorkingDate]
GO
/****** Object:  Default [DF__tbl_user___Locat__36470DEF]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Locat__36470DEF]  DEFAULT (NULL) FOR [LocationId]
GO
/****** Object:  Default [DF__tbl_strat__RefNu__7167D3BD]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [RefNumber]
GO
/****** Object:  Default [DF__tbl_strat__Versi__725BF7F6]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [Version]
GO
/****** Object:  Default [DF__tbl_strat__Chang__73501C2F]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [ChangeDesc]
GO
/****** Object:  Default [DF__tbl_strat__FTASh__74444068]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [FTAShortCode]
GO
/****** Object:  Default [DF__tbl_strat__Creat__753864A1]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_strat__Creat__762C88DA]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
/****** Object:  Default [DF__tbl_strat__Strat__03BB8E22]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategytype_master] ADD  CONSTRAINT [DF__tbl_strat__Strat__03BB8E22]  DEFAULT ('0') FOR [StrategyType]
GO
/****** Object:  Default [DF__tbl_strat__IsAct__04AFB25B]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategytype_master] ADD  CONSTRAINT [DF__tbl_strat__IsAct__04AFB25B]  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_strat__RefNu__6225902D]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT ('0') FOR [RefNumber]
GO
/****** Object:  Default [DF__tbl_strat__Versi__6319B466]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Version]
GO
/****** Object:  Default [DF__tbl_strat__Appro__640DD89F]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Approver]
GO
/****** Object:  Default [DF__tbl_strat__Comme__6501FCD8]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Comments]
GO
/****** Object:  Default [DF__tbl_strat__Appro__65F62111]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [ApprovedDate]
GO
/****** Object:  Default [DF__tbl_strat__Creat__66EA454A]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_strat__Statu__67DE6983]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Status]
GO
/****** Object:  Default [DF__tbl_strat__Uploa__68D28DBC]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Uploadedby]
GO
/****** Object:  Default [DF__tbl_strat__IsAct__69C6B1F5]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_strat__IsTra__6ABAD62E]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsTransfered]
GO
/****** Object:  Default [DF__tbl_strat__IsDel__6BAEFA67]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsDelegateAccepted]
GO
/****** Object:  Default [DF__tbl_strat__IsVie__6CA31EA0]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsViewed]
GO
/****** Object:  Default [DF__tbl_strat__IsMod__6D9742D9]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsModified]
GO
/****** Object:  Default [DF__tbl_strate__Type__6E8B6712]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Type]
GO
/****** Object:  Default [DF__tbl_strat__RefNu__3F115E1A]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__RefNu__3F115E1A]  DEFAULT (NULL) FOR [RefNumber]
GO
/****** Object:  Default [DF__tbl_strat__FTAAp__40058253]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTAAp__40058253]  DEFAULT (NULL) FOR [FTAApplicationCodeId]
GO
/****** Object:  Default [DF__tbl_strat__FTASt__40F9A68C]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASt__40F9A68C]  DEFAULT (NULL) FOR [FTAStrategyCodeId]
GO
/****** Object:  Default [DF__tbl_strat__Discr__41EDCAC5]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Discr__41EDCAC5]  DEFAULT (NULL) FOR [DiscretionaryCodeId]
GO
/****** Object:  Default [DF__tbl_strat__Busin__42E1EEFE]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Busin__42E1EEFE]  DEFAULT (NULL) FOR [BusinessSuffixId]
GO
/****** Object:  Default [DF__tbl_strat__FTASh__43D61337]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASh__43D61337]  DEFAULT (NULL) FOR [FTAShortCodeId]
GO
/****** Object:  Default [DF__tbl_strat__Paren__44CA3770]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Paren__44CA3770]  DEFAULT (NULL) FOR [ParentId]
GO
/****** Object:  Default [DF__tbl_strat__Child__45BE5BA9]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Child__45BE5BA9]  DEFAULT (NULL) FOR [ChildId]
GO
/****** Object:  Default [DF__tbl_strat__Busin__46B27FE2]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Busin__46B27FE2]  DEFAULT (NULL) FOR [BusinessLineId]
GO
/****** Object:  Default [DF__tbl_strat__Regio__47A6A41B]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Regio__47A6A41B]  DEFAULT (NULL) FOR [RegionId]
GO
/****** Object:  Default [DF__tbl_strat__Count__489AC854]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Count__489AC854]  DEFAULT (NULL) FOR [CountryId]
GO
/****** Object:  Default [DF__tbl_strat__FTAAp__498EEC8D]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTAAp__498EEC8D]  DEFAULT (NULL) FOR [FTAApplicationNameId]
GO
/****** Object:  Default [DF__tbl_strat__Count__4A8310C6]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Count__4A8310C6]  DEFAULT (NULL) FOR [CountryIdList]
GO
/****** Object:  Default [DF__tbl_strat__Count__4B7734FF]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Count__4B7734FF]  DEFAULT (NULL) FOR [CountryNameList]
GO
/****** Object:  Default [DF__tbl_strat__FTAAp__4C6B5938]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTAAp__4C6B5938]  DEFAULT (NULL) FOR [FTAApplicationOwnerId]
GO
/****** Object:  Default [DF__tbl_strat__FTATh__4D5F7D71]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTATh__4D5F7D71]  DEFAULT (NULL) FOR [FTAThirdPartyapp]
GO
/****** Object:  Default [DF__tbl_strat__FTASt__4E53A1AA]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASt__4E53A1AA]  DEFAULT (NULL) FOR [FTAStrategyNameId]
GO
/****** Object:  Default [DF__tbl_strat__FTASt__4F47C5E3]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASt__4F47C5E3]  DEFAULT (NULL) FOR [FTAStrategyOwnerId]
GO
/****** Object:  Default [DF__tbl_strat__Prior__503BEA1C]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Prior__503BEA1C]  DEFAULT (NULL) FOR [PriorityScoreId]
GO
/****** Object:  Default [DF__tbl_strat__Appli__51300E55]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Appli__51300E55]  DEFAULT (NULL) FOR [ApplicationCategoryId]
GO
/****** Object:  Default [DF__tbl_strat__Prior__5224328E]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Prior__5224328E]  DEFAULT (NULL) FOR [Priority]
GO
/****** Object:  Default [DF__tbl_strat__Strat__531856C7]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Strat__531856C7]  DEFAULT (NULL) FOR [StrategyTypeId]
GO
/****** Object:  Default [DF__tbl_strat__Prior__540C7B00]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Prior__540C7B00]  DEFAULT (NULL) FOR [PriorityScore]
GO
/****** Object:  Default [DF__tbl_strat__Venue__55009F39]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Venue__55009F39]  DEFAULT (NULL) FOR [VenueTypeId]
GO
/****** Object:  Default [DF__tbl_strat__Capac__55F4C372]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Capac__55F4C372]  DEFAULT (NULL) FOR [CapacityId]
GO
/****** Object:  Default [DF__tbl_strat__GoLiv__56E8E7AB]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__GoLiv__56E8E7AB]  DEFAULT (NULL) FOR [GoLiveDate]
GO
/****** Object:  Default [DF__tbl_strat__Third__57DD0BE4]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Third__57DD0BE4]  DEFAULT (NULL) FOR [ThirdPartyAppId]
GO
/****** Object:  Default [DF__tbl_strat__Busin__58D1301D]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Busin__58D1301D]  DEFAULT (NULL) FOR [BusinessId]
GO
/****** Object:  Default [DF__tbl_strat__FTAAp__59C55456]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTAAp__59C55456]  DEFAULT (NULL) FOR [FTAApplicationMappingId]
GO
/****** Object:  Default [DF__tbl_strat__FTASt__5AB9788F]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__FTASt__5AB9788F]  DEFAULT (NULL) FOR [FTAStrategyMappingId]
GO
/****** Object:  Default [DF__tbl_strat__Busin__5BAD9CC8]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Busin__5BAD9CC8]  DEFAULT (NULL) FOR [BusinessMappingId]
GO
/****** Object:  Default [DF__tbl_strat__DeCom__5CA1C101]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__DeCom__5CA1C101]  DEFAULT (NULL) FOR [DeComissionedDate]
GO
/****** Object:  Default [DF__tbl_strat__Decom__5D95E53A]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Decom__5D95E53A]  DEFAULT (NULL) FOR [DecomissionedEvidenceDocument]
GO
/****** Object:  Default [DF__tbl_strat__Syste__5E8A0973]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Syste__5E8A0973]  DEFAULT (NULL) FOR [SystemFlow]
GO
/****** Object:  Default [DF__tbl_strat__NoOfA__5F7E2DAC]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__NoOfA__5F7E2DAC]  DEFAULT (NULL) FOR [NoOfApprover]
GO
/****** Object:  Default [DF__tbl_strat__Versi__607251E5]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Versi__607251E5]  DEFAULT ('1') FOR [Version]
GO
/****** Object:  Default [DF__tbl_strat__SignO__6166761E]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__SignO__6166761E]  DEFAULT (NULL) FOR [SignOff]
GO
/****** Object:  Default [DF__tbl_strat__SignO__625A9A57]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__SignO__625A9A57]  DEFAULT (NULL) FOR [SignOffDate]
GO
/****** Object:  Default [DF__tbl_strat__Signo__634EBE90]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Signo__634EBE90]  DEFAULT (NULL) FOR [SignoffBy]
GO
/****** Object:  Default [DF__tbl_strat__IsAct__6442E2C9]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__IsAct__6442E2C9]  DEFAULT (NULL) FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_strat__Creat__65370702]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Creat__65370702]  DEFAULT (NULL) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_strat__Creat__662B2B3B]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Creat__662B2B3B]  DEFAULT (NULL) FOR [CreatedBy]
GO
/****** Object:  Default [DF__tbl_strat__LastM__671F4F74]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__LastM__671F4F74]  DEFAULT (NULL) FOR [LastModifiedDate]
GO
/****** Object:  Default [DF__tbl_strat__LastM__681373AD]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__LastM__681373AD]  DEFAULT (NULL) FOR [LastModifiedBy]
GO
/****** Object:  Default [DF__tbl_strate__Res1__690797E6]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res1__690797E6]  DEFAULT (NULL) FOR [Res1]
GO
/****** Object:  Default [DF__tbl_strate__Res2__69FBBC1F]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res2__69FBBC1F]  DEFAULT (NULL) FOR [Res2]
GO
/****** Object:  Default [DF__tbl_strate__Res3__6AEFE058]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res3__6AEFE058]  DEFAULT (NULL) FOR [Res3]
GO
/****** Object:  Default [DF__tbl_strate__Res4__6BE40491]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res4__6BE40491]  DEFAULT (NULL) FOR [Res4]
GO
/****** Object:  Default [DF__tbl_strate__Res5__6CD828CA]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res5__6CD828CA]  DEFAULT (NULL) FOR [Res5]
GO
/****** Object:  Default [DF__tbl_strate__Res6__6DCC4D03]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res6__6DCC4D03]  DEFAULT (NULL) FOR [Res6]
GO
/****** Object:  Default [DF__tbl_strate__Res7__6EC0713C]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res7__6EC0713C]  DEFAULT (NULL) FOR [Res7]
GO
/****** Object:  Default [DF__tbl_strate__Res8__6FB49575]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res8__6FB49575]  DEFAULT (NULL) FOR [Res8]
GO
/****** Object:  Default [DF__tbl_strate__Res9__70A8B9AE]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strate__Res9__70A8B9AE]  DEFAULT (NULL) FOR [Res9]
GO
/****** Object:  Default [DF__tbl_strat__Res10__719CDDE7]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_strategy] ADD  CONSTRAINT [DF__tbl_strat__Res10__719CDDE7]  DEFAULT (NULL) FOR [Res10]
GO
/****** Object:  Default [DF__tbl_roler__RoleI__2CBDA3B5]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_roleright_mapping] ADD  DEFAULT (NULL) FOR [RoleID]
GO
/****** Object:  Default [DF__tbl_roler__Right__2DB1C7EE]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_roleright_mapping] ADD  DEFAULT (NULL) FOR [RightID]
GO
/****** Object:  Default [DF__tbl_role___RoleN__27F8EE98]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [RoleName]
GO
/****** Object:  Default [DF__tbl_role___Creat__28ED12D1]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [CreatedDate]
GO
/****** Object:  Default [DF__tbl_role___Creat__29E1370A]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
/****** Object:  Default [DF__tbl_role___Modif__2AD55B43]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [ModifiedDate]
GO
/****** Object:  Default [DF__tbl_role___Modif__2BC97F7C]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [ModifiedBy]
GO
/****** Object:  Default [DF__tbl_right__Right__214BF109]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [RightID]
GO
/****** Object:  Default [DF__tbl_right__Right__22401542]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [RightName]
GO
/****** Object:  Default [DF__tbl_right__MenuN__2334397B]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [MenuName]
GO
/****** Object:  Default [DF__tbl_right___Path__24285DB4]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [Path]
GO
/****** Object:  Default [DF__tbl_right___Icon__251C81ED]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [Icon]
GO
/****** Object:  Default [DF__tbl_right__ShowM__2610A626]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [ShowMenu]
GO
/****** Object:  Default [DF__tbl_right__IsAct__2704CA5F]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_prior__Prior__1F63A897]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_priority_master] ADD  DEFAULT ('0') FOR [Priority]
GO
/****** Object:  Default [DF__tbl_prior__IsAct__2057CCD0]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_priority_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_paren__Paren__1D7B6025]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_parentid_master] ADD  DEFAULT ('0') FOR [ParentId]
GO
/****** Object:  Default [DF__tbl_paren__IsAct__1E6F845E]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_parentid_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftast__FTASt__1B9317B3]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftastrategyowner_master] ADD  DEFAULT ('0') FOR [FTAStrategyOwner]
GO
/****** Object:  Default [DF__tbl_ftast__IsAct__1C873BEC]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftastrategyowner_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftast__FTASt__19AACF41]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftastrategyname_master] ADD  DEFAULT ('0') FOR [FTAStrategyName]
GO
/****** Object:  Default [DF__tbl_ftast__IsAct__1A9EF37A]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftastrategyname_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftast__FTASt__17C286CF]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftastrategycode_master] ADD  DEFAULT ('0') FOR [FTAStrategyCode]
GO
/****** Object:  Default [DF__tbl_ftast__IsAct__18B6AB08]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftastrategycode_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftaap__FTAAp__10216507]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [FTAApplicationNameId]
GO
/****** Object:  Default [DF__tbl_ftaap__FTAAp__11158940]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [FTAApplicationCodeId]
GO
/****** Object:  Default [DF__tbl_ftaap__Child__1209AD79]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [ChildId]
GO
/****** Object:  Default [DF__tbl_ftaap__Third__12FDD1B2]    Script Date: 03/21/2018 00:56:49 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [ThirdPartyAppId]
GO
/****** Object:  Default [DF__tbl_ftaap__FTAAp__0E391C95]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationcode_master] ADD  DEFAULT ('0') FOR [FTAApplicationCode]
GO
/****** Object:  Default [DF__tbl_ftaap__IsAct__0F2D40CE]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_ftaapplicationcode_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_discr__Discr__0C50D423]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_discretionarycode_master] ADD  DEFAULT ('0') FOR [Discretionarycode]
GO
/****** Object:  Default [DF__tbl_discr__IsAct__0D44F85C]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_discretionarycode_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_busin__Busin__02C769E9]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_Department_master] ADD  DEFAULT ('0') FOR [Department]
GO
/****** Object:  Default [DF__tbl_busin__IsAct__03BB8E22]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_Department_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_count__Count__0B5CAFEA]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_country_master] ADD  DEFAULT (NULL) FOR [CountryName]
GO
/****** Object:  Default [DF__tbl_child__Child__09746778]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_childid_master] ADD  DEFAULT ('0') FOR [ChildID]
GO
/****** Object:  Default [DF__tbl_child__IsAct__0A688BB1]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_childid_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_ftaap__FTAAp__13F1F5EB]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_category_master] ADD  DEFAULT ('0') FOR [Category]
GO
/****** Object:  Default [DF__tbl_ftaap__IsAct__14E61A24]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_category_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_capac__Capac__73BA3083]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_capacity_master] ADD  CONSTRAINT [DF__tbl_capac__Capac__73BA3083]  DEFAULT ('0') FOR [Capacity]
GO
/****** Object:  Default [DF__tbl_capac__IsAct__74AE54BC]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_capacity_master] ADD  CONSTRAINT [DF__tbl_capac__IsAct__74AE54BC]  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_busin__Busin__05A3D694]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_businesssuffix_master] ADD  DEFAULT ('0') FOR [BusinessSuffix]
GO
/****** Object:  Default [DF__tbl_busin__IsAct__0697FACD]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_businesssuffix_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
/****** Object:  Default [DF__tbl_busine__Name__04AFB25B]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_businesssector] ADD  DEFAULT ('0') FOR [Name]
GO
/****** Object:  Default [DF__tbl_aduse__UserN__73852659]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [UserName]
GO
/****** Object:  Default [DF__tbl_aduse__Email__74794A92]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [EmailId]
GO
/****** Object:  Default [DF__tbl_aduse__Mobil__756D6ECB]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [MobileNumber]
GO
/****** Object:  Default [DF__tbl_aduser_m__st__76619304]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [st]
GO
/****** Object:  Default [DF__tbl_aduse__posta__7755B73D]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [postalCode]
GO
/****** Object:  Default [DF__tbl_aduse__physi__7849DB76]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [physicalDeliveryOfficeName]
GO
/****** Object:  Default [DF__tbl_aduse__telep__793DFFAF]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [telephoneNumber]
GO
/****** Object:  Default [DF__tbl_aduse__depar__7A3223E8]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [department]
GO
/****** Object:  Default [DF__tbl_aduse__stree__7B264821]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [streetAddress]
GO
/****** Object:  Default [DF__tbl_aduse__manag__7C1A6C5A]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [manager]
GO
/****** Object:  Default [DF__tbl_aduse__homeP__7D0E9093]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [homePhone]
GO
/****** Object:  Default [DF__tbl_aduse__descr__7E02B4CC]    Script Date: 03/21/2018 00:56:50 ******/
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [description]
GO

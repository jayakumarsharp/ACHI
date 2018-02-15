/****** Object:  Database [achiv1]    Script Date: 15-02-2018 08:36:53 ******/
CREATE DATABASE [achiv1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'achiv1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\achiv1.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'achiv1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\achiv1_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [achiv1] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [achiv1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [achiv1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [achiv1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [achiv1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [achiv1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [achiv1] SET ARITHABORT OFF 
GO
ALTER DATABASE [achiv1] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [achiv1] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [achiv1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [achiv1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [achiv1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [achiv1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [achiv1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [achiv1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [achiv1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [achiv1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [achiv1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [achiv1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [achiv1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [achiv1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [achiv1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [achiv1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [achiv1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [achiv1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [achiv1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [achiv1] SET  MULTI_USER 
GO
ALTER DATABASE [achiv1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [achiv1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [achiv1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [achiv1] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
/****** Object:  StoredProcedure [dbo].[delete_RoleRight]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_userBusinessSector]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_usercountry]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_userregion]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_DelegateApprovalByUser]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_StrategyApprovalById]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_StrategyApprovalByUser]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_StrategyDelegatesApprovalByuser]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[Get_StrategyLatestversionById]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_addbusinessmapping]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Dumping structure for procedure achiv1.sp_addbusinessmapping
CREATE  PROCEDURE [dbo].[sp_addbusinessmapping](
 @i_businesssuffixid INT,
 @i_businessid INT,
 @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN
SET NOCOUNT ON;
 IF exists (SELECT * FROM tbl_businessmapping  WHERE BusinessId=@i_BusinessId and BusinessSuffixId=@i_BusinessSuffixId) 
 set @i_OutParam ='Business Mapping already exists';
 else
 begin
insert into tbl_businessmapping(BusinessId,BusinessSuffixId) values (@i_businessid,@i_businesssuffixid);
set @i_OutParam ='success';
end;


END;

GO
/****** Object:  StoredProcedure [dbo].[sp_addFTAApplicationMapping]    Script Date: 15-02-2018 08:36:53 ******/
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

 IF  exists (SELECT * FROM tbl_FTAApplicationmapping  WHERE FTAApplicationNameId=@i_FTAApplicationNameId and FTAApplicationCodeId=@i_FTAApplicationCodeId and ChildId=@i_ChildId and ThirdPartyAppId=@i_ThirdPartyAppId and ParentID=@i_ParentID and ApplicationOwnerId=@i_ApplicationOwnerId and ApplicationCategoryId=@i_ApplicationCategoryId) 
 set @i_OutParam ='FTA Application Mapping already exists';
 else 
 begin
 

insert into tbl_FTAApplicationmapping(FTAApplicationNameId,FTAApplicationCodeId,ChildId,ThirdPartyAppId,ParentID,ApplicationOwnerId,ApplicationCategoryId) 
values (@i_FTAApplicationNameId,@i_FTAApplicationCodeId,@i_ChildId,@i_ThirdPartyAppId,@i_ParentID,@i_ApplicationOwnerId,@i_ApplicationCategoryId);

set @i_OutParam ='success';
ENd;


END;

GO
/****** Object:  StoredProcedure [dbo].[sp_addFTAStrategyMapping]    Script Date: 15-02-2018 08:36:53 ******/
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

 IF exists(SELECT * FROM tbl_ftastrategynamemapping  WHERE FTAStrategyNameId=@i_FTAStrategyNameId and FTAStrategyCodeId=@i_FTAStrategyCodeId) 
 set @i_OutParam ='Mapping already exists';
 else 
 begin
insert into tbl_ftastrategynamemapping(FTAStrategyNameId,FTAStrategyCodeId) values (@i_FTAStrategyNameId,@i_FTAStrategyCodeId);
set @i_OutParam ='success';
ENd 


END;

GO
/****** Object:  StoredProcedure [dbo].[sp_addReportApplicationMapping]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_addFTAApplicationMapping
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

 IF  exists (SELECT * FROM tbl_reportapplicationmapping WHERE FTAApplicationNameId=@i_FTAApplicationNameId and FTAApplicationCodeId=@i_FTAApplicationCodeId and ChildId=@i_ChildId and ThirdPartyAppId=@i_ThirdPartyAppId and ParentID=@i_ParentID and ApplicationOwnerId=@i_ApplicationOwnerId and ApplicationCategoryId=@i_ApplicationCategoryId and RegionId=@i_RegionId and CountryId=@i_CountryId and BusinessLineId=@i_BusinessLineId) 
 set @i_OutParam ='Report Application Mapping already exists';
 else 
 begin
 

insert into tbl_reportapplicationmapping(FTAApplicationNameId,FTAApplicationCodeId,ChildId,ThirdPartyAppId,ParentID,ApplicationOwnerId,ApplicationCategoryId,RegionId,CountryId,BusinessLineId) 
values (@i_FTAApplicationNameId,@i_FTAApplicationCodeId,@i_ChildId,@i_ThirdPartyAppId,@i_ParentID,@i_ApplicationOwnerId,@i_ApplicationCategoryId,@i_RegionId,@i_CountryId ,@i_BusinessLineId);

set @i_OutParam ='success';
ENd;


END;

GO
/****** Object:  StoredProcedure [dbo].[sp_adduser1]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_ApplicationCategory]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_ApplicationMaster]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_Business]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_BusinessLine]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_BusinessMapping]    Script Date: 15-02-2018 08:36:53 ******/
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

 IF exists (SELECT count(*) FROM tbl_strategy  WHERE BusinessMappingId=@i_id) 
 set @i_OutParam ='Mapping associated to strategy';
 
 else 
 begin
delete from tbl_businessmapping where id =@i_id;
set @i_OutParam ='success';
end;


END;

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_BusinessSuffix]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_Capacity]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_ChildID]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_country]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAApplicationName]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAApplicationOwner]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAStrategyMapping]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_delete_FTAStrategyMapping](
 @i_id VARCHAR(50)
,
 @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN
SET NOCOUNT ON;

 if exists (SELECT count(*) FROM tbl_strategy  WHERE FTAStrategyMappingId=@i_id) 
 set @i_OutParam ='Mapping associated to strategy';
 else 
 begin

delete from tbl_ftastrategynamemapping where id =@i_id;
 set @i_OutParam ='success';
end;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAStrategyName]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_FTAStrategyOwner]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_ParentID]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_ProductType]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_ProductType](
 @i_id INT
)
AS
BEGIN
SET NOCOUNT ON;
delete from tbl_ProductTypemaster where id=@i_id;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_region]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_strategy_Approval]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_Strategytype]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_SystemFlow]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_delete_Venuetype]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_deleteFTAApplicationMapping]    Script Date: 15-02-2018 08:36:53 ******/
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

 IF exists (SELECT count(*) FROM tbl_strategy  WHERE FTAApplicationMappingId=@i_id) 
 set @i_OutParam ='Mapping associated to strategy';
 else 
 begin

delete from tbl_FTAapplicationmapping where id =@i_id;
set @i_OutParam ='success';
end;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_deleteReportApplicationMapping]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_deleteFTAApplicationMapping
Create  PROCEDURE [dbo].[sp_deleteReportApplicationMapping](
 @i_id VARCHAR(50),
 @i_OutParam VARCHAR(50) OUT
)
AS
BEGIN
SET NOCOUNT ON;

 
delete from tbl_reportapplicationmapping where id =@i_id;
set @i_OutParam ='success';

END;

GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteRole]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_strategyVersionLog]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallApplicationCategory]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallApplicationMaster]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallBusiness]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallBusinessLine]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallBusinessSuffix]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallCapacity]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallChildID]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallcountry]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallDiscretionaryCode]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallFTAApplicationCode]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallFTAApplicationName]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallFTAApplicationOwner]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallFTAStrategyCode]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallFTAStrategyName]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallFTAStrategyOwner]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallParentID]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallProduct]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallregion]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllStrategy]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_GetAllStrategy]
AS
BEGIN

select S.Id,S.RefNumber,FTAApplicationCodeId,FTAAC.FTAApplicationCode,FTAShortCodeId,CountryIdList,CountryNameList,FTAStrategyCodeId,FTASC.FTAStrategyCode,DiscretionaryCodeId,DM.Discretionarycode,BusinessSuffixId,BSFM.BusinessSuffix,
FTAStrategyCode,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,BSL.BusinessLine,RegionId,R.RegionName,CountryId,FTAApplicationNameId,APN.FTAApplicationName,FTAApplicationOwnerId,ApplicationCategoryId,
ACM.ApplicationCategory,StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,NoOfApprover,Version,FTAStrategyNameId,FTASN.FTAStrategyName,
S.FTAStrategyOwnerId,S.Priority,S.PriorityScore, SignOff,SignOffDate,SignoffBy,LastModifiedDate ,LastModifiedBy,ThirdPartyAppId,TM.ThirdPartyAppName,BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,
convert(NVARCHAR, S.DecomissionedDate, 103) DecomissionedDate,convert(NVARCHAR, S.GoLiveDate, 103) GoLiveDate from tbl_strategy S join tbl_ftaapplicationcode_master FTAAC On S.FTAApplicationCodeId = FTAAC.Id 
join tbl_ftastrategycode_master FTASC on S.FTAStrategyCodeId = FTASC.Id JOin tbl_discretionarycode_master DM on s.DiscretionaryCodeId = DM.Id JOin tbl_businesssuffix_master BSFM on s.BusinessSuffixId = BSFM.Id 
JOIN tbl_parentid_master PM on s.ParentId = PM.Id join tbl_childid_master CM on S.ChildId = CM.Id JOIn tbl_businessline_master BSL on BusinessLineId = BSL.Id  JOIN tbl_region_master R on S.RegionId = R.id JOIN 
tbl_ftaapplicationname_master APN on S.FTAApplicationNameId = APN.Id JOIN tbl_applicationcategory_master ACM on S.ApplicationCategoryId = ACM.Id JOIN tbl_ftastrategyname_master FTASN on S.FTAStrategyNameId = FTASN.Id JOIN tbl_strategytype_master STM on S.StrategyTypeId = STM.Id JOIN tbl_venuetype_master 
VTM on S.VenueTypeId = VTM.Id JOIN tbl_thirdpartyapplication TM on S.ThirdPartyAppId = TM.Id JOIN tbl_business_master BM on S.BusinessId = BM.Id JOIN tbl_capacity_master CPM on S.CapacityId = CPM.Id right JOIN (SELECT  MAX(Id) as Id FROM tbl_strategy GROUP BY REfnumber) t2  
ON S.ID = t2.Id
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllStrategybyId]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetAllStrategybyId](
@i_RefNumber varchar(100)
)
AS
BEGIN

select S.Id,S.RefNumber,FTAApplicationCodeId,FTAAC.FTAApplicationCode,FTAShortCodeId,CountryIdList,CountryNameList,FTAStrategyCodeId,FTASC.FTAStrategyCode,DiscretionaryCodeId,DM.Discretionarycode,BusinessSuffixId,BSFM.BusinessSuffix,
FTAStrategyCode,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,BSL.BusinessLine,RegionId,R.RegionName,CountryId,FTAApplicationNameId,APN.FTAApplicationName,FTAApplicationOwnerId,ApplicationCategoryId,
ACM.ApplicationCategory,StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,NoOfApprover,Version,FTAStrategyNameId,FTASN.FTAStrategyName,
S.FTAStrategyOwnerId,S.Priority,S.PriorityScore, SignOff,SignOffDate,SignoffBy,LastModifiedDate ,LastModifiedBy,ThirdPartyAppId,TM.ThirdPartyAppName,BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,
convert(NVARCHAR, S.DecomissionedDate, 103) DecomissionedDate,convert(NVARCHAR, S.GoLiveDate, 103) GoLiveDate from tbl_strategy S join tbl_ftaapplicationcode_master FTAAC On S.FTAApplicationCodeId = FTAAC.Id 
join tbl_ftastrategycode_master FTASC on S.FTAStrategyCodeId = FTASC.Id JOin tbl_discretionarycode_master DM on s.DiscretionaryCodeId = DM.Id JOin tbl_businesssuffix_master BSFM on s.BusinessSuffixId = BSFM.Id 
JOIN tbl_parentid_master PM on s.ParentId = PM.Id join tbl_childid_master CM on S.ChildId = CM.Id JOIn tbl_businessline_master BSL on BusinessLineId = BSL.Id  JOIN tbl_region_master R on S.RegionId = R.id JOIN 
tbl_ftaapplicationname_master APN on S.FTAApplicationNameId = APN.Id JOIN tbl_applicationcategory_master ACM on S.ApplicationCategoryId = ACM.Id JOIN tbl_ftastrategyname_master FTASN on S.FTAStrategyNameId = FTASN.Id JOIN tbl_strategytype_master STM on S.StrategyTypeId = STM.Id JOIN tbl_venuetype_master 
VTM on S.VenueTypeId = VTM.Id JOIN tbl_thirdpartyapplication TM on S.ThirdPartyAppId = TM.Id JOIN tbl_business_master BM on S.BusinessId = BM.Id JOIN tbl_capacity_master CPM on S.CapacityId = CPM.Id right JOIN (SELECT  MAX(Id) as Id FROM tbl_strategy GROUP BY REfnumber) t2  
ON S.ID = t2.Id WHERE S.Id = @i_RefNumber
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_getallStrategytype]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallSystemFlow]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getAllThirdPartyAppType]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getallVenuetype]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getbusinessmapping]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getbusinessmappingbyId]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getFTAApplicationMapping]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getFTAApplicationMappingbyId]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getFTAStrategyMapping]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getFTAStrategyMappingbyId]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getmenuforuser]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getReportApplicationMapping]    Script Date: 15-02-2018 08:36:53 ******/
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
 where FAM.Id=@i_id;
else
 select FAM.Id, FAM.FTAApplicationNameId,FANM.FTAApplicationName,FAM.FTAApplicationCodeId,FACM.FTAApplicationCode,
 FAM.ChildId,CM.ChildID as ChildIDValue, FAM.ThirdPartyAppId,TM.ThirdPartyAppName,
  FAM.ParentID as ParentIDValue,PM.ParentId, FAM.ApplicationOwnerId ,FAM.ApplicationCategoryId,AM.ApplicationCategory,
  FAM.BusinessLineId,BM.BusinessLine
  ,FAM.RegionId,R.RegionName,FAM.CountryId,C.CountryName
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
 JOIN tbl_country_master C on C.id=FAM.CountryId;
end
GO
/****** Object:  StoredProcedure [dbo].[sp_getReportApplicationMappingFilter]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getReportApplicationMappingFilter](
	@i_Id VARCHAR(50)=null
)
as
BEGIN
 select FAM.Id, FAM.FTAApplicationNameId,FANM.FTAApplicationName,FAM.FTAApplicationCodeId,FACM.FTAApplicationCode,
 FAM.ChildId,CM.ChildID as ChildIDValue, FAM.ThirdPartyAppId,TM.ThirdPartyAppName,
 FAM.ParentID as ParentIDValue,PM.ParentId, FAM.ApplicationOwnerId ,FAM.ApplicationCategoryId,AM.ApplicationCategory,
 FAM.BusinessLineId,BM.BusinessLine
 ,FAM.RegionId,R.RegionName,FAM.CountryId,C.CountryName
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
 JOIN tbl_country_master C on C.id=FAM.CountryId
 where FAM.FTAApplicationNameId=@i_id;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRightForUser]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_GetRights]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetRoleRights]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_GetRoles]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[Sp_getRolesbyuserassigned]    Script Date: 15-02-2018 08:36:53 ******/
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
SET NOCOUNT ON;
select u.Userid,u.UserName,u.EmailId,u.RegionId,r.RegionName,u.CountryId,c.CountryName,u.BusinessSectorId,b.Name,u.RoleId,rm.RoleName,u.Status from tbl_user_master u join tbl_businesssector b on u.BusinessSectorId=b.Id join tbl_region_master r  on u.RegionId=r.Id join tbl_country_master c  on u.CountryId=c.id join tbl_role_master rm on u.RoleId=rm.Id
where u.RoleId=i_roleid;

END;

GO
/****** Object:  StoredProcedure [dbo].[SP_GetStrategyByRefnumber]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.SP_GetStrategyByRefnumber
CREATE  PROCEDURE [dbo].[SP_GetStrategyByRefnumber](
 @i_RefNumber VARCHAR(50)




)
AS
BEGIN
SET NOCOUNT ON;

select S.Id, RefNumber, S.Name, Type, S.ApplicationId,A.ApplicationID as AppId,A.ApplicationName,S.ApplicationId, S.BusinessSector,B.Name  as BusinessSectorName, S.Country , C.CountryName, S.Region,R.RegionName, S.ProductType ,P.ProductType as ProductTypeName, Ranking, Objective, Description, RiskRating, BusinessImpact, ExchangeDetails, DetailsOfChanges, ChangesBusinessImpact, SupportingDocument, DateChangeInitiated, DateChangeImplemented, ChangesCompletionStatus, AdditionalParam1, AdditionalParam2, AdditionalParam3, AdditionalParam4, AdditionalParam5, AdditionalParam6, AdditionalParam7, AdditionalParam8, AdditionalParam9, AdditionalParam10, AdditionalParam11, AdditionalParam12, AdditionalParam13, Attribute1, Attribute2, Attribute3, Attribute4, NoOfApprover, Version,FinalSignOff, SignOffDate, SignoffBy, IsActive, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
from tbl_strategy S join tbl_ApplicationMaster A  On S.ApplicationId=A.Id 
JOin tbl_country_master C on S.Country=C.id 
join tbl_region_master R on S.Region= R.Id
Join tbl_businesssector	B on S.BusinessSector =B.Id
JOIN tbl_producttypemaster P on S.ProductType=P.Id
WHERE RefNumber=i_RefNumber;
END;

GO
/****** Object:  StoredProcedure [dbo].[SP_GetuserBusinessSector]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Getusercountry]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Getuserregion]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getusers]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getusersbycondition]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_ApplicationCategory]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_ApplicationCategory](
	@i_ApplicationCategory VARCHAR(50)


)
as
BEGIN

insert into tbl_ApplicationCategory_master (ApplicationCategory) values(@i_ApplicationCategory);

END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Business]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_Business](
 @i_Business VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

insert into tbl_Business_master (Business) values(@i_Business);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_BusinessLine]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_BusinessLine](
 @i_BusinessLine VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

insert into tbl_BusinessLine_master (BusinessLine) values(@i_BusinessLine);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_BusinessSuffix]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_BusinessSuffix](
 @i_BusinessSuffix VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

insert into tbl_BusinessSuffix_master (BusinessSuffix) values(@i_BusinessSuffix);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Capacity]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_Capacity](
	@i_Capacity VARCHAR(50)


)as
BEGIN

insert into tbl_Capacity_master (Capacity) values(@i_Capacity);

END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_ChildID]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_ChildID](
 @i_ChildID VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

insert into tbl_ChildID_master (ChildID) values(@i_ChildID);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Country]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_Country](
	@i_CountryName VARCHAR(50)

)
as
BEGIN

insert into tbl_country_master (Countryname) values(@i_CountryName);

END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_DiscretionaryCode]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_DiscretionaryCode](
 @i_DiscretionaryCode VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

insert into tbl_DiscretionaryCode_master (DiscretionaryCode) values(@i_DiscretionaryCode);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FTAApplicationCode]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_insert_FTAApplicationCode](
 @i_FTAApplicationCode VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

insert into tbl_FTAApplicationCode_master (FTAApplicationCode) values(@i_FTAApplicationCode);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FTAApplicationName]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Dumping structure for procedure achiv1.sp_insert_FTAApplicationName
CREATE  PROCEDURE [dbo].[sp_insert_FTAApplicationName](
 @i_FTAApplicationName VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

insert into tbl_FTAApplicationName_master (FTAApplicationName) values(@i_FTAApplicationName);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FTAStrategyCode]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_FTAStrategyCode](
 @i_FTAStrategyCode VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

insert into tbl_FTAStrategyCode_master (FTAStrategyCode) values(@i_FTAStrategyCode);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FTAStrategyName]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_FTAStrategyName](
	@i_FTAStrategyName VARCHAR(50)


)
as
BEGIN

insert into tbl_FTAStrategyName_master (FTAStrategyName) values(@i_FTAStrategyName);

END
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_ParentID]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_ParentID](
	@i_ParentID VARCHAR(50)
)
as
BEGIN

insert into tbl_ParentID_master (ParentID) values(@i_ParentID);

END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_Region]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_insert_Region](
 @i_RegionName VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

insert into tbl_region_master (regionname) values(@i_RegionName);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_roleright]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_Strategy]    Script Date: 15-02-2018 08:36:53 ******/
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
 @i_DecommissionedDate VARCHAR(50),
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
 @i_SignOff VARCHAR(50) =null ,
 @i_CountryIdList VARCHAR(100)  ,
 @i_CountryNameList VARCHAR(500),
 @i_CreatedBy VARCHAR(500)=null,
 @i_OutParam VARCHAR(500) OUTPUT




)
AS
BEGIN
SET NOCOUNT ON;	 

 IF exists (SELECT * FROM tbl_strategy  WHERE FTAShortCodeId=@i_FTAShortCode and Version=@i_Version) 
 begin
 set @i_OutParam ='Strategy already exists';
 end
 else begin
 begin
 

insert into tbl_strategy(RefNumber,    CountryId, RegionId,  Description,   FTAApplicationCodeId,        BusinessSuffixId,        ChildID,
        FTAStrategyNameId,StrategytypeId,GOLiveDate,FTAStrategyCodeId,FTAShortCodeId,
        BusinessLineId,FTAApplicationNameId,FTAStrategyOwnerId,ApplicationCategoryId,VenuetypeId,
        DeComissionedDate,DiscretionaryCodeId,ParentID,FTAApplicationOwnerId,PriorityScore,Priority,
        CapacityId,CountryIdList,CountryNameList,IsActive,Version,ThirdPartyAppId,BusinessId,FTAApplicationMappingId,
		  FTAStrategyMappingId,BusinessMappingId,SignOff,CreatedBy
		  ) values(@i_RefNumber,@i_CountryId,
 @i_RegionId,@i_Description,@i_FTAApplicationCodeId,@i_BusinessSuffixId,@i_ChildID,@i_FTAStrategyNameId,@i_StrategytypeId,
@i_GOLiveDate,@i_FTAStrategyCodeId,@i_FTAShortCode,@i_BusinessLineId,@i_FTAApplicationNameId,@i_FTAStrategyOwnerId,
@i_ApplicationCategoryId,@i_VenueTypeId,@i_DecommissionedDate,@i_DiscretionaryCodeId,@i_ParentID,@i_FTAApplicationOwnerId,@i_PriorityScore,
@i_Priority,@i_CapacityId,@i_CountryIdList,@i_CountryNameList, 'Y',@i_Version,@i_ThirdPartyAppId,@i_BusinessId,@i_FTAApplicationMappingId,@i_FTAStrategyMappingId,@i_BusinessMappingId,
@i_SignOff,@i_CreatedBy);
set @i_OutParam ='success';
end;
ENd 



END;

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_strategy_Approval]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_Strategytype]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_Strategytype](
	@i_Strategytype VARCHAR(50)
)as
BEGIN

insert into tbl_Strategytype_master (Strategytype) values(@i_Strategytype);

END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_strategyVersionLog]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_userBusinessSector]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_usercountry]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_userregion]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_insert_Venuetype]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insert_Venuetype](
	@i_Venuetype VARCHAR(50)


)as
BEGIN

insert into tbl_Venuetype_master (Venuetype) values(@i_Venuetype);

END

GO
/****** Object:  StoredProcedure [dbo].[SP_StrategyReport]    Script Date: 15-02-2018 08:36:53 ******/
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
 @i_ThirdPartyAppId VARCHAR(50)=null
)
AS
BEGIN
declare @Sql varchar(max);
declare @dynamicsql varchar(max);
SET @sql='select S.Id,S.RefNumber,CountryNameList,FTAApplicationCodeId,FTAAC.FTAApplicationCode,FTAShortCodeId,CountryIdList,FTAStrategyCodeId,FTASC.FTAStrategyCode,DiscretionaryCodeId,
DM.Discretionarycode,BusinessSuffixId,BSFM.BusinessSuffix,FTAStrategyCode,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,
BSL.BusinessLine,RegionId,R.RegionName,CountryId,FTAApplicationNameId,APN.FTAApplicationName,FTAStrategyOwnerId,ApplicationCategoryId,ACM.ApplicationCategory,
StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,
NoOfApprover,Version,FTAStrategyNameId,FTASN.FTAStrategyName,S.FTAApplicationOwnerId,
S.Priority,S.PriorityScore,SignOff
,SignOffDate,SignoffBy,LastModifiedDate ,LastModifiedBy,ThirdPartyAppId,TM.ThirdPartyAppName,
BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,
S.DecomissionedDate,GoLiveDate from tbl_strategy S 
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
right JOIN (SELECT  MAX(Id) as Id FROM tbl_strategy GROUP BY REfnumber) t2  ON S.ID = t2.Id';

SET @dynamicsql='';
if (@i_FTAApplicationCode != '' and @i_FTAApplicationCode is not null) begin
SET @dynamicsql=CONCAT(@dynamicsql,'FTAApplicationCodeId =',@i_FTAApplicationCode);
end 


if (@i_FTAStrategyCode IS NOT NULL and @i_FTAStrategyCode != '') begin
if (@dynamicsql !='') begin
SET @dynamicsql=CONCAT(@dynamicsql, ' and ');
end 
SET @dynamicsql=CONCAT(@dynamicsql,'FTAStrategyCodeId =',@i_FTAStrategyCode);
end 

if (@i_BusinessLine != '') begin
	if (@dynamicsql !='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
SET  @dynamicsql=CONCAT(@dynamicsql,'BusinessLineId =',@i_BusinessLine);
end 


if (@i_Region != '') begin
	if (@dynamicsql !='') begin
	SET @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
SET  @dynamicsql=CONCAT(@dynamicsql,'RegionId =',@i_Region);
end 

if (@i_Country != '') begin
	if (@dynamicsql !='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 

SET  @dynamicsql=CONCAT(@dynamicsql,'CountryIdList Like ''%',@i_Country,'%''');
end 


if (@i_FTAApplicationOwner != '') begin
	if (@dynamicsql !='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
SET  @dynamicsql=@dynamicsql+'FTAApplicationOwnerId ='''+@i_FTAApplicationOwner+ char(39);
end 


if (@i_ApplicationCategory IS NOT NULL and @i_ApplicationCategory != '') begin
	if (@dynamicsql!='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
SET  @dynamicsql=CONCAT(@dynamicsql,'ApplicationCategoryId=',@i_ApplicationCategory);
end 


if (@i_FTAApplicationCode != '') begin
	if (@dynamicsql!='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
	

SET  @dynamicsql=CONCAT(@dynamicsql,' FTAApplicationCodeId=',@i_FTAApplicationCode);
end 



if (@i_FTAApplicationNameId IS NOT NULL and @i_FTAApplicationNameId != '') begin
	if (@dynamicsql!='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
SET  @dynamicsql=CONCAT(@dynamicsql,'FTAApplicationNameId=',@i_FTAApplicationNameId);
end 




if (@i_ParentID IS NOT NULL and @i_ParentID != '') begin
	if (@dynamicsql!='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
SET  @dynamicsql=CONCAT(@dynamicsql,'PM.ParentID=',@i_ParentID);
end 



if (@i_ChildID IS NOT NULL and @i_ChildID != '') begin
	if (@dynamicsql!='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
SET  @dynamicsql=CONCAT(@dynamicsql,'CM.ChildID=',@i_ChildID);
end 

if (@i_ThirdPartyAppId IS NOT NULL and @i_ThirdPartyAppId != '') begin
	if (@dynamicsql!='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
SET  @dynamicsql=CONCAT(@dynamicsql,'S.ThirdPartyAppId=',@i_ThirdPartyAppId);
end 


	
if (@i_VenueType != '') begin
	if (@dynamicsql!='') begin
	SET  @dynamicsql=CONCAT(@dynamicsql,' and ');
	end 
	

SET  @dynamicsql=CONCAT(@dynamicsql,' VenueTypeId=',@i_VenueType);
end 
	

	SET  @sql=CONCAT(@sql,' where ' ,@dynamicsql);

	
print(@sql)
EXECUTE (@sql);

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_ApplicationCategorymaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_ApplicationCategorymaster
CREATE  PROCEDURE [dbo].[sp_update_ApplicationCategorymaster](
 @i_id INT,
 @i_ApplicationCategory VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_ApplicationCategory_master set ApplicationCategory=@i_ApplicationCategory where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_Applicationmaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_Applicationmaster
CREATE  PROCEDURE [dbo].[sp_update_Applicationmaster](
 @i_id INT,
 @i_ApplicationId VARCHAR(50),
 @i_ApplicationName VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

update tbl_ApplicationMaster set ApplicationName=i_ApplicationName , ApplicationId=i_ApplicationId where id=i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_Business]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_Business
CREATE  PROCEDURE [dbo].[sp_update_Business](
 @i_id INT,
 @i_Business VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

update tbl_Business_master set Business =@i_Business  where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_BusinessLinemaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_BusinessLinemaster
CREATE  PROCEDURE [dbo].[sp_update_BusinessLinemaster](
 @i_id INT,
 @i_BusinessLine VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_BusinessLine_master set BusinessLine=@i_BusinessLine  where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_BusinessSuffixmaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_BusinessSuffixmaster
CREATE  PROCEDURE [dbo].[sp_update_BusinessSuffixmaster](
 @i_id INT,
 @i_BusinessSuffix VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_BusinessSuffix_master set BusinessSuffix =@i_BusinessSuffix where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_Capacitymaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_Capacitymaster
CREATE  PROCEDURE [dbo].[sp_update_Capacitymaster](
 @i_id INT,
 @i_Capacity VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_Capacity_master set Capacity =@i_Capacity  where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_ChildIDmaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_ChildIDmaster
CREATE  PROCEDURE [dbo].[sp_update_ChildIDmaster](
 @i_id INT,
 @i_ChildID VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_ChildID_master set ChildID =@i_ChildID where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_countrymaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_countrymaster
CREATE  PROCEDURE [dbo].[sp_update_countrymaster](
 @i_id INT,
 @i_countryname VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

update tbl_country_master set countryname=@i_countryname where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_DiscretionaryCodemaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_DiscretionaryCodemaster
CREATE  PROCEDURE [dbo].[sp_update_DiscretionaryCodemaster](
 @i_id INT,
 @i_DiscretionaryCode VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

update tbl_DiscretionaryCode_master set DiscretionaryCode=@i_DiscretionaryCode where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAApplicationCodemaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_FTAApplicationCodemaster
CREATE  PROCEDURE [dbo].[sp_update_FTAApplicationCodemaster](
 @i_id INT,
 @i_FTAApplicationCode VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

update tbl_FTAApplicationCode_master set FTAApplicationCode=@i_FTAApplicationCode where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAApplicationNamemaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_FTAApplicationNamemaster
CREATE  PROCEDURE [dbo].[sp_update_FTAApplicationNamemaster](
 @i_id INT,
 @i_FTAApplicationName VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_FTAApplicationName_master set FTAApplicationName=@i_FTAApplicationName where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAApplicationOwnermaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_FTAApplicationOwnermaster
CREATE  PROCEDURE [dbo].[sp_update_FTAApplicationOwnermaster](
 @i_id INT,
 @i_FTAApplicationOwner VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_FTAApplicationOwner_master set FTAApplicationOwner=i_FTAApplicationOwner  where id=i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAStrategyCodemaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_FTAStrategyCodemaster
CREATE  PROCEDURE [dbo].[sp_update_FTAStrategyCodemaster](
 @i_id INT,
 @i_FTAStrategyCode VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_FTAStrategyCode_master set FTAStrategyCode=@i_FTAStrategyCode where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAStrategyNamemaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_FTAStrategyNamemaster
CREATE  PROCEDURE [dbo].[sp_update_FTAStrategyNamemaster](
 @i_id INT,
 @i_FTAStrategyName VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

update tbl_FTAStrategyName_master set FTAStrategyName=@i_FTAStrategyName where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_FTAStrategyOwnermaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_FTAStrategyOwnermaster
CREATE  PROCEDURE [dbo].[sp_update_FTAStrategyOwnermaster](
 @i_id INT,
 @i_FTAStrategyOwner VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_FTAStrategyOwner_master set FTAStrategyOwner =i_FTAStrategyOwner  where id=i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_ParentIDmaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_ParentIDmaster
CREATE  PROCEDURE [dbo].[sp_update_ParentIDmaster](
 @i_id INT,
 @i_ParentID VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_ParentID_master set ParentID =@i_ParentID where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_PriorityScoremaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_PriorityScoremaster
CREATE  PROCEDURE [dbo].[sp_update_PriorityScoremaster](
 @i_id INT,
 @i_PriorityScore VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_PriorityScore_master set PriorityScore =i_PriorityScore  where id=i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_Productmaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_Productmaster
CREATE  PROCEDURE [dbo].[sp_update_Productmaster](
 @i_id INT,
 @i_ProductName VARCHAR(50)


)
AS
BEGIN
SET NOCOUNT ON;

update tbl_ProductTypemaster set ProductType =i_ProductName where id=i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_regionmaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_regionmaster
CREATE  PROCEDURE [dbo].[sp_update_regionmaster](
 @i_id INT,
 @i_regionname VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

update tbl_region_master set regionname=@i_regionname where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[Sp_update_strategy_approval]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.Sp_update_strategy_approval
CREATE  PROCEDURE [dbo].[Sp_update_strategy_approval](
 @i_Comments VARCHAR(50),
 @i_Status VARCHAR(50),
 @i_RefNumber VARCHAR(50),
 @i_Version VARCHAR(50),
 @i_Approver VARCHAR(50),
    @i_Type VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;
if(@i_Type='A') begin
update tbl_StrategyApproval set Comments =@i_Comments,Status=@i_Status,ApprovedDate=getdate() where RefNumber=@i_RefNumber and Version=@i_Version  and Approver=@i_Approver;
end
else begin
update tbl_approvaltransfer set Comments =@i_Comments,Status=@i_Status,ApprovedDate=getdate() where RefNumber=@i_RefNumber and Version=@i_Version  and Approver=@i_Approver;
end 

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_Strategytypemaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_Strategytypemaster
CREATE  PROCEDURE [dbo].[sp_update_Strategytypemaster](
 @i_id INT,
 @i_Strategytype VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

update tbl_Strategytype_master set StrategyType=@i_Strategytype where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_SystemFlowmaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_SystemFlowmaster
CREATE  PROCEDURE [dbo].[sp_update_SystemFlowmaster](
 @i_id INT,
 @i_SystemFlowname VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;

update tbl_SystemFlow_master set SystemFlowname=i_SystemFlowname where id=i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_Venuetypemaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Dumping structure for procedure achiv1.sp_update_Venuetypemaster
CREATE  PROCEDURE [dbo].[sp_update_Venuetypemaster](
 @i_id INT,
 @i_Venuetype VARCHAR(50)

)
AS
BEGIN
SET NOCOUNT ON;

update tbl_Venuetype_master set Venuetype=@i_Venuetype  where id=@i_id;

END;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateuser]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  Table [dbo].[tbl_aduser_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_applicationcategory_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_applicationmaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_applicationmaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [varchar](50) NULL,
	[ApplicationName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_business_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_businessline_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_businessmapping]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_businesssector]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_businesssuffix_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_capacity_master]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_capacity_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Capacity] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_childid_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_country_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_discretionarycode_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ftaapplicationcode_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ftaapplicationmapping]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ftaapplicationname_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ftaapplicationowner_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ftastrategycode_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ftastrategyname_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ftastrategynamemapping]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ftastrategyowner_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_parentid_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_priority_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_producttypemaster]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_producttypemaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductType] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_region_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_reportapplicationmapping]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_right_master]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  Table [dbo].[tbl_role_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_roleright_mapping]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_strategy]    Script Date: 15-02-2018 08:36:53 ******/
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
	[SignOff] [varchar](10) NULL,
	[SignOffDate] [datetime2](0) NULL,
	[SignoffBy] [varchar](100) NULL,
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
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_strategyapproval]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_strategytype_master]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_strategytype_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StrategyType] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_strategyversionlog]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_systemflowmaster]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_thirdpartyapplication]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_user_master]    Script Date: 15-02-2018 08:36:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_userbusinesssectormapping]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  Table [dbo].[tbl_usercountrymapping]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  Table [dbo].[tbl_userregionmapping]    Script Date: 15-02-2018 08:36:53 ******/
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
/****** Object:  Table [dbo].[tbl_venuetype_master]    Script Date: 15-02-2018 08:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_venuetype_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VenueType] [varchar](250) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_applicationcategory_master] ON 

INSERT [dbo].[tbl_applicationcategory_master] ([Id], [ApplicationCategory], [IsActive]) VALUES (1, N'ac', 0)
SET IDENTITY_INSERT [dbo].[tbl_applicationcategory_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_business_master] ON 

INSERT [dbo].[tbl_business_master] ([Id], [business], [IsActive]) VALUES (1, N'ss2', 0)
SET IDENTITY_INSERT [dbo].[tbl_business_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_businessline_master] ON 

INSERT [dbo].[tbl_businessline_master] ([Id], [BusinessLine], [IsActive]) VALUES (1, N'bl1', 0)
SET IDENTITY_INSERT [dbo].[tbl_businessline_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_businessmapping] ON 

INSERT [dbo].[tbl_businessmapping] ([Id], [BusinessId], [BusinessSuffixId]) VALUES (1, 1, 1)
SET IDENTITY_INSERT [dbo].[tbl_businessmapping] OFF
SET IDENTITY_INSERT [dbo].[tbl_businesssuffix_master] ON 

INSERT [dbo].[tbl_businesssuffix_master] ([Id], [BusinessSuffix], [IsActive]) VALUES (1, N'bs2', 0)
SET IDENTITY_INSERT [dbo].[tbl_businesssuffix_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_capacity_master] ON 

INSERT [dbo].[tbl_capacity_master] ([Id], [Capacity], [IsActive]) VALUES (1, N'1', 0)
SET IDENTITY_INSERT [dbo].[tbl_capacity_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_childid_master] ON 

INSERT [dbo].[tbl_childid_master] ([Id], [ChildID], [IsActive]) VALUES (1, N'1234', 0)
SET IDENTITY_INSERT [dbo].[tbl_childid_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_country_master] ON 

INSERT [dbo].[tbl_country_master] ([id], [CountryName]) VALUES (1, N'india')
INSERT [dbo].[tbl_country_master] ([id], [CountryName]) VALUES (2, N'English')
INSERT [dbo].[tbl_country_master] ([id], [CountryName]) VALUES (3, N'Dubai')
SET IDENTITY_INSERT [dbo].[tbl_country_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_discretionarycode_master] ON 

INSERT [dbo].[tbl_discretionarycode_master] ([Id], [Discretionarycode], [IsActive]) VALUES (1, N'12345', 0)
SET IDENTITY_INSERT [dbo].[tbl_discretionarycode_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationcode_master] ON 

INSERT [dbo].[tbl_ftaapplicationcode_master] ([Id], [FTAApplicationCode], [IsActive]) VALUES (1, N'1234', 0)
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationcode_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationmapping] ON 

INSERT [dbo].[tbl_ftaapplicationmapping] ([Id], [FTAApplicationNameId], [FTAApplicationCodeId], [ChildId], [ThirdPartyAppId], [ParentId], [ApplicationOwnerId], [ApplicationCategoryId]) VALUES (4, 1, 1, 1, 1, 1, N'Sivakumar', 1)
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationmapping] OFF
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationname_master] ON 

INSERT [dbo].[tbl_ftaapplicationname_master] ([Id], [FTAApplicationName], [IsActive]) VALUES (1, N'App2', 0)
SET IDENTITY_INSERT [dbo].[tbl_ftaapplicationname_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_ftastrategycode_master] ON 

INSERT [dbo].[tbl_ftastrategycode_master] ([Id], [FTAStrategyCode], [IsActive]) VALUES (1, N'12345', 0)
SET IDENTITY_INSERT [dbo].[tbl_ftastrategycode_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_ftastrategyname_master] ON 

INSERT [dbo].[tbl_ftastrategyname_master] ([Id], [FTAStrategyName], [IsActive]) VALUES (1, N'ss2', 0)
SET IDENTITY_INSERT [dbo].[tbl_ftastrategyname_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_ftastrategynamemapping] ON 

INSERT [dbo].[tbl_ftastrategynamemapping] ([Id], [FTAStrategyNameId], [FTAStrategyCodeId]) VALUES (1, 1, 1)
SET IDENTITY_INSERT [dbo].[tbl_ftastrategynamemapping] OFF
SET IDENTITY_INSERT [dbo].[tbl_parentid_master] ON 

INSERT [dbo].[tbl_parentid_master] ([Id], [ParentId], [IsActive]) VALUES (1, N'12334', 0)
SET IDENTITY_INSERT [dbo].[tbl_parentid_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_region_master] ON 

INSERT [dbo].[tbl_region_master] ([Id], [RegionName]) VALUES (1, N'India1')
INSERT [dbo].[tbl_region_master] ([Id], [RegionName]) VALUES (2, N'234234')
SET IDENTITY_INSERT [dbo].[tbl_region_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_reportapplicationmapping] ON 

INSERT [dbo].[tbl_reportapplicationmapping] ([Id], [FTAApplicationNameId], [FTAApplicationCodeId], [ParentId], [ChildId], [ThirdPartyAppId], [ApplicationCategoryId], [ApplicationOwnerId], [RegionId], [CountryId], [BusinessLineId]) VALUES (2, 1, 1, 1, 1, 1, 1, N'Sivakumar', 1, 1, 1)
SET IDENTITY_INSERT [dbo].[tbl_reportapplicationmapping] OFF
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (1, N'Home', N'Home', N'Index', N'fa fa-dashboard', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (2, N'FTA Read Only', N'Strategy Management', N'ModelAlgoManagement', N'fa fa-list', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (3, N'FTA Write Access', N'Strategy Management', N'ModelAlgoManagement', N'fa fa-list', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (4, N'FTA Strategy Owner', N'Strategy Management', N'ModelAlgoManagement', N'fa fa-list', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (5, N'Role Management Read', N'Role Management', N'RoleManagement', N'fa fa-list-alt', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (6, N'Role Management Write', N'Role Management', N'RoleManagement', N'fa fa-list-alt', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (7, N'User Management Read', N'User Management', N'UserManagement', N'fa fa-users', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (8, N'User Management Write', N'User Management', N'UserManagement', N'fa fa-users', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (9, N'Master Page Read', N'Master Page', N'MasterPage', N'fa fa-star', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (10, N'Master Page Write', N'Master Page', N'MasterPage', N'fa fa-star', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (11, N'Mapping Page Read', N'Mapping Page', N'MappingMaster', N'fa fa-star-o', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (12, N'Mapping Page Write', N'Mapping Page', N'MappingMaster', N'fa fa-star-o', N'true', N'Y')
INSERT [dbo].[tbl_right_master] ([RightID], [RightName], [MenuName], [Path], [Icon], [ShowMenu], [IsActive]) VALUES (13, N'Reports', N'Reports', N'Reports', N'fa fa-list-alt', N'true', N'Y')
SET IDENTITY_INSERT [dbo].[tbl_role_master] ON 

INSERT [dbo].[tbl_role_master] ([id], [RoleName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'Super Admin', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_role_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_roleright_mapping] ON 

INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (128, 1, 3)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (129, 1, 4)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (130, 1, 5)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (131, 1, 7)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (132, 1, 8)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (133, 1, 9)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (134, 1, 10)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (135, 1, 11)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (136, 1, 12)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (137, 1, 13)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (138, 1, 6)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (139, 1, 1)
INSERT [dbo].[tbl_roleright_mapping] ([id], [RoleID], [RightID]) VALUES (140, 1, 2)
SET IDENTITY_INSERT [dbo].[tbl_roleright_mapping] OFF
SET IDENTITY_INSERT [dbo].[tbl_strategy] ON 

INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [CountryId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [FTAThirdPartyapp], [FTAStrategyNameId], [FTAStrategyOwnerId], [PriorityScoreId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [DecomissionedEvidenceDocument], [SystemFlow], [NoOfApprover], [Description], [Version], [SignOff], [SignOffDate], [SignoffBy], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (1, N'20180206193525885', 1, 1, 1, 1, N'12345123412345bs2', 1, 1, 1, 1, N'[{"name":"india","id":"1","$$hashKey":"object:176"}]', 1, N'1,', N'india,', N'Sivakumar', NULL, 1, N'Sivakumar', NULL, 1, 3, 1, 3, 1, 1, CAST(0xDA3D0B00 AS Date), 1, 1, 4, 1, 1, CAST(0xDA3D0B00 AS Date), NULL, NULL, NULL, N'rest', 1, NULL, NULL, NULL, N'Y', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [CountryId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [FTAThirdPartyapp], [FTAStrategyNameId], [FTAStrategyOwnerId], [PriorityScoreId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [DecomissionedEvidenceDocument], [SystemFlow], [NoOfApprover], [Description], [Version], [SignOff], [SignOffDate], [SignoffBy], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (2, N'20180206193525885', 1, 1, 1, 1, N'12345123412345bs2', 1, 1, 1, 1, N'[{"name":"india","id":"1","$$hashKey":"object:176"}]', 1, N'1,', N'india,', N'Sivakumar', NULL, 1, N'Sivakumar', NULL, 1, 3, 1, 3, 1, 1, CAST(0xDA3D0B00 AS Date), 1, 1, 4, 1, 1, CAST(0xDA3D0B00 AS Date), NULL, NULL, NULL, N'rest', 2, N'True', NULL, NULL, N'Y', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategy] ([Id], [RefNumber], [FTAApplicationCodeId], [FTAStrategyCodeId], [DiscretionaryCodeId], [BusinessSuffixId], [FTAShortCodeId], [ParentId], [ChildId], [BusinessLineId], [RegionId], [CountryId], [FTAApplicationNameId], [CountryIdList], [CountryNameList], [FTAApplicationOwnerId], [FTAThirdPartyapp], [FTAStrategyNameId], [FTAStrategyOwnerId], [PriorityScoreId], [ApplicationCategoryId], [Priority], [StrategyTypeId], [PriorityScore], [VenueTypeId], [CapacityId], [GoLiveDate], [ThirdPartyAppId], [BusinessId], [FTAApplicationMappingId], [FTAStrategyMappingId], [BusinessMappingId], [DeComissionedDate], [DecomissionedEvidenceDocument], [SystemFlow], [NoOfApprover], [Description], [Version], [SignOff], [SignOffDate], [SignoffBy], [IsActive], [CreatedDate], [CreatedBy], [LastModifiedDate], [LastModifiedBy], [Res1], [Res2], [Res3], [Res4], [Res5], [Res6], [Res7], [Res8], [Res9], [Res10]) VALUES (3, N'20180206193525885', 1, 1, 1, 1, N'12345123412345bs2', 1, 1, 1, 2, N'[{"name":"india","id":"1","$$hashKey":"object:176"}]', 1, N'1,', N'india,', N'Sivakumar', NULL, 1, N'teas', NULL, 1, 3, 1, 3, 1, 1, CAST(0xDA3D0B00 AS Date), 1, 1, 4, 1, 1, CAST(0xDA3D0B00 AS Date), NULL, NULL, NULL, N'rest', 3, N'True', NULL, NULL, N'Y', NULL, N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_strategy] OFF
SET IDENTITY_INSERT [dbo].[tbl_strategyapproval] ON 

INSERT [dbo].[tbl_strategyapproval] ([Id], [RefNumber], [Version], [Approver], [Comments], [ApprovedDate], [CreatedDate], [Status], [Uploadedby], [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]) VALUES (1, N'20180206193525885', N'2', N'Jayakumar CV.rtf', N'd8f20161-0477-4edf-9a46-74e2b90a46a8.rtf', NULL, CAST(0x00364501DA3D0B0000 AS DateTime2), N'S', N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_strategyapproval] ([Id], [RefNumber], [Version], [Approver], [Comments], [ApprovedDate], [CreatedDate], [Status], [Uploadedby], [IsActive], [IsTransfered], [IsDelegateAccepted], [IsViewed], [IsModified], [Type]) VALUES (2, N'20180206193525885', N'2', N'Jayakumar programmer Resume.doc', N'eb30b415-870d-4cba-ad49-8570350243bb.doc', NULL, CAST(0x00364501DA3D0B0000 AS DateTime2), N'D', N'Sivakumar', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_strategyapproval] OFF
SET IDENTITY_INSERT [dbo].[tbl_strategytype_master] ON 

INSERT [dbo].[tbl_strategytype_master] ([Id], [StrategyType], [IsActive]) VALUES (1, N'1', 0)
SET IDENTITY_INSERT [dbo].[tbl_strategytype_master] OFF
SET IDENTITY_INSERT [dbo].[tbl_strategyversionlog] ON 

INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (1, N'20180206193019134', N'1', N'Version Created', NULL, CAST(0x00ED1201DA3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (2, N'20180206193525885', N'1', N'Version Created', NULL, CAST(0x000F1401DA3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (3, N'20180206193525885', N'2', N' SignOff -  - Changed to True', NULL, CAST(0x00F44301DA3D0B0000 AS DateTime2), N'Sivakumar')
INSERT [dbo].[tbl_strategyversionlog] ([Id], [RefNumber], [Version], [ChangeDesc], [FTAShortCode], [CreatedDate], [CreatedBy]) VALUES (4, N'20180206193525885', N'3', N' Region - 1 - Changed to 2 FTAStrategyOwner - Sivakumar - Changed to teas', NULL, CAST(0x009D3501DB3D0B0000 AS DateTime2), N'Sivakumar')
SET IDENTITY_INSERT [dbo].[tbl_strategyversionlog] OFF
SET IDENTITY_INSERT [dbo].[tbl_thirdpartyapplication] ON 

INSERT [dbo].[tbl_thirdpartyapplication] ([Id], [ThirdPartyAppName]) VALUES (1, N'Yes')
INSERT [dbo].[tbl_thirdpartyapplication] ([Id], [ThirdPartyAppName]) VALUES (2, N'No')
SET IDENTITY_INSERT [dbo].[tbl_thirdpartyapplication] OFF
SET IDENTITY_INSERT [dbo].[tbl_user_master] ON 

INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (1, N'Sivakumar', N'Sivakumar', NULL, N'1', N'd2VsY29tZQ==', N'Sivakumar@coba.com', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Yes', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_user_master] ([Id], [Userid], [UserName], [BusinessSectorId], [RoleId], [Password], [EmailId], [MobileNumber], [CustomData], [Status], [UserExpiryDate], [PasswordExpiryDate], [UserBlockDate], [AttemptTries], [LastAuthenticatedDate], [LastUsedDate], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [ApprovedDate], [Approvedby], [MakerComment], [CheckerComment], [IsADUser], [RegionId], [CountryId], [FirstWorkingDate], [LastWorkingDate], [LocationId]) VALUES (2, N'teas', N'sf', NULL, N'1', N'ZmZzZGY=', N'test@mail.com', NULL, NULL, N'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'No', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_user_master] OFF
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'Sivakumar', 1, NULL)
INSERT [dbo].[tbl_userbusinesssectormapping] ([Userid], [BusinessSectorId], [Reserved1]) VALUES (N'teas', 1, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'Sivakumar', 1, NULL)
INSERT [dbo].[tbl_usercountrymapping] ([Userid], [CountryId], [Reserved1]) VALUES (N'teas', 1, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'Sivakumar', 1, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'Sivakumar', 2, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'teas', 2, NULL)
INSERT [dbo].[tbl_userregionmapping] ([Userid], [RegionId], [Reserved1]) VALUES (N'teas', 1, NULL)
SET IDENTITY_INSERT [dbo].[tbl_venuetype_master] ON 

INSERT [dbo].[tbl_venuetype_master] ([Id], [VenueType], [IsActive]) VALUES (1, N'1', 0)
SET IDENTITY_INSERT [dbo].[tbl_venuetype_master] OFF
/****** Object:  Index [Id]    Script Date: 15-02-2018 08:36:54 ******/
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [Id] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [UserName]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [EmailId]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [MobileNumber]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [st]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [postalCode]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [physicalDeliveryOfficeName]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [telephoneNumber]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [department]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [streetAddress]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [manager]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [homePhone]
GO
ALTER TABLE [dbo].[tbl_aduser_master] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[tbl_applicationcategory_master] ADD  DEFAULT ('0') FOR [ApplicationCategory]
GO
ALTER TABLE [dbo].[tbl_applicationcategory_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_applicationmaster] ADD  DEFAULT (NULL) FOR [ApplicationID]
GO
ALTER TABLE [dbo].[tbl_applicationmaster] ADD  DEFAULT (NULL) FOR [ApplicationName]
GO
ALTER TABLE [dbo].[tbl_business_master] ADD  DEFAULT ('0') FOR [business]
GO
ALTER TABLE [dbo].[tbl_business_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_businessline_master] ADD  DEFAULT ('0') FOR [BusinessLine]
GO
ALTER TABLE [dbo].[tbl_businessline_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_businesssector] ADD  DEFAULT ('0') FOR [Name]
GO
ALTER TABLE [dbo].[tbl_businesssuffix_master] ADD  DEFAULT ('0') FOR [BusinessSuffix]
GO
ALTER TABLE [dbo].[tbl_businesssuffix_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_capacity_master] ADD  DEFAULT ('0') FOR [Capacity]
GO
ALTER TABLE [dbo].[tbl_capacity_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_childid_master] ADD  DEFAULT ('0') FOR [ChildID]
GO
ALTER TABLE [dbo].[tbl_childid_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_country_master] ADD  DEFAULT (NULL) FOR [CountryName]
GO
ALTER TABLE [dbo].[tbl_discretionarycode_master] ADD  DEFAULT ('0') FOR [Discretionarycode]
GO
ALTER TABLE [dbo].[tbl_discretionarycode_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationcode_master] ADD  DEFAULT ('0') FOR [FTAApplicationCode]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationcode_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [FTAApplicationNameId]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [FTAApplicationCodeId]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [ChildId]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationmapping] ADD  DEFAULT ('0') FOR [ThirdPartyAppId]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationname_master] ADD  DEFAULT ('0') FOR [FTAApplicationName]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationname_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationowner_master] ADD  DEFAULT ('0') FOR [FTAApplicationOwner]
GO
ALTER TABLE [dbo].[tbl_ftaapplicationowner_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_ftastrategycode_master] ADD  DEFAULT ('0') FOR [FTAStrategyCode]
GO
ALTER TABLE [dbo].[tbl_ftastrategycode_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_ftastrategyname_master] ADD  DEFAULT ('0') FOR [FTAStrategyName]
GO
ALTER TABLE [dbo].[tbl_ftastrategyname_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_ftastrategyowner_master] ADD  DEFAULT ('0') FOR [FTAStrategyOwner]
GO
ALTER TABLE [dbo].[tbl_ftastrategyowner_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_parentid_master] ADD  DEFAULT ('0') FOR [ParentId]
GO
ALTER TABLE [dbo].[tbl_parentid_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_priority_master] ADD  DEFAULT ('0') FOR [Priority]
GO
ALTER TABLE [dbo].[tbl_priority_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_producttypemaster] ADD  DEFAULT ('0') FOR [ProductType]
GO
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [RightID]
GO
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [RightName]
GO
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [MenuName]
GO
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [Path]
GO
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [Icon]
GO
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [ShowMenu]
GO
ALTER TABLE [dbo].[tbl_right_master] ADD  DEFAULT (NULL) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [RoleName]
GO
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[tbl_role_master] ADD  DEFAULT (NULL) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[tbl_roleright_mapping] ADD  DEFAULT (NULL) FOR [RoleID]
GO
ALTER TABLE [dbo].[tbl_roleright_mapping] ADD  DEFAULT (NULL) FOR [RightID]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [RefNumber]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAApplicationCodeId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAStrategyCodeId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [DiscretionaryCodeId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [BusinessSuffixId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAShortCodeId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [ParentId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [ChildId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [BusinessLineId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [RegionId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [CountryId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAApplicationNameId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [CountryIdList]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [CountryNameList]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAApplicationOwnerId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAThirdPartyapp]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAStrategyNameId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAStrategyOwnerId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [PriorityScoreId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [ApplicationCategoryId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Priority]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [StrategyTypeId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [PriorityScore]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [VenueTypeId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [CapacityId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [GoLiveDate]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [ThirdPartyAppId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [BusinessId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAApplicationMappingId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [FTAStrategyMappingId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [BusinessMappingId]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [DeComissionedDate]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [DecomissionedEvidenceDocument]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [SystemFlow]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [NoOfApprover]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT ('1') FOR [Version]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [SignOff]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [SignOffDate]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [SignoffBy]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [LastModifiedDate]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [LastModifiedBy]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res1]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res2]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res3]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res4]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res5]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res6]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res7]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res8]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res9]
GO
ALTER TABLE [dbo].[tbl_strategy] ADD  DEFAULT (NULL) FOR [Res10]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT ('0') FOR [RefNumber]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Version]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Approver]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Comments]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [ApprovedDate]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Status]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Uploadedby]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsTransfered]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsDelegateAccepted]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsViewed]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [IsModified]
GO
ALTER TABLE [dbo].[tbl_strategyapproval] ADD  DEFAULT (NULL) FOR [Type]
GO
ALTER TABLE [dbo].[tbl_strategytype_master] ADD  DEFAULT ('0') FOR [StrategyType]
GO
ALTER TABLE [dbo].[tbl_strategytype_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [RefNumber]
GO
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [Version]
GO
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [ChangeDesc]
GO
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [FTAShortCode]
GO
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbl_strategyversionlog] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[tbl_systemflowmaster] ADD  DEFAULT ('0') FOR [SystemFlow]
GO
ALTER TABLE [dbo].[tbl_systemflowmaster] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_thirdpartyapplication] ADD  DEFAULT ('0') FOR [ThirdPartyAppName]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___UserN__1C873BEC]  DEFAULT (NULL) FOR [UserName]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Busin__1D7B6025]  DEFAULT (NULL) FOR [BusinessSectorId]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___RoleI__1E6F845E]  DEFAULT (NULL) FOR [RoleId]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Passw__1F63A897]  DEFAULT (NULL) FOR [Password]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Email__2057CCD0]  DEFAULT (NULL) FOR [EmailId]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Mobil__214BF109]  DEFAULT (NULL) FOR [MobileNumber]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Custo__22401542]  DEFAULT (NULL) FOR [CustomData]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Statu__2334397B]  DEFAULT (NULL) FOR [Status]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___UserE__24285DB4]  DEFAULT (NULL) FOR [UserExpiryDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Passw__251C81ED]  DEFAULT (NULL) FOR [PasswordExpiryDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___UserB__2610A626]  DEFAULT (NULL) FOR [UserBlockDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Attem__2704CA5F]  DEFAULT (NULL) FOR [AttemptTries]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___LastA__27F8EE98]  DEFAULT (NULL) FOR [LastAuthenticatedDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___LastU__28ED12D1]  DEFAULT (NULL) FOR [LastUsedDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Creat__29E1370A]  DEFAULT (NULL) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Creat__2AD55B43]  DEFAULT (NULL) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Modif__2BC97F7C]  DEFAULT (NULL) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Modif__2CBDA3B5]  DEFAULT (NULL) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Appro__2DB1C7EE]  DEFAULT (NULL) FOR [ApprovedDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Appro__2EA5EC27]  DEFAULT (NULL) FOR [Approvedby]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Maker__2F9A1060]  DEFAULT (NULL) FOR [MakerComment]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Check__308E3499]  DEFAULT (NULL) FOR [CheckerComment]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___IsADU__318258D2]  DEFAULT (NULL) FOR [IsADUser]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Regio__32767D0B]  DEFAULT (NULL) FOR [RegionId]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Count__336AA144]  DEFAULT (NULL) FOR [CountryId]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___First__345EC57D]  DEFAULT (NULL) FOR [FirstWorkingDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___LastW__3552E9B6]  DEFAULT (NULL) FOR [LastWorkingDate]
GO
ALTER TABLE [dbo].[tbl_user_master] ADD  CONSTRAINT [DF__tbl_user___Locat__36470DEF]  DEFAULT (NULL) FOR [LocationId]
GO
ALTER TABLE [dbo].[tbl_userbusinesssectormapping] ADD  DEFAULT (NULL) FOR [Reserved1]
GO
ALTER TABLE [dbo].[tbl_usercountrymapping] ADD  DEFAULT (NULL) FOR [Reserved1]
GO
ALTER TABLE [dbo].[tbl_userregionmapping] ADD  DEFAULT (NULL) FOR [Reserved1]
GO
ALTER TABLE [dbo].[tbl_venuetype_master] ADD  DEFAULT ('0') FOR [VenueType]
GO
ALTER TABLE [dbo].[tbl_venuetype_master] ADD  DEFAULT ('0') FOR [IsActive]
GO
ALTER DATABASE [achiv1] SET  READ_WRITE 
GO

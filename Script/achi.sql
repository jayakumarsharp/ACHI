-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.56 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for achi
CREATE DATABASE IF NOT EXISTS `achi` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `achi`;

-- Dumping structure for procedure achi.delete_RoleRight
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_RoleRight`(
	IN `i_roleid` INT


)
BEGIN
delete from tbl_roleright_mapping where RoleID=i_roleid;

END//
DELIMITER ;

-- Dumping structure for procedure achi.Get_ApprovaltransferByuser
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_ApprovaltransferByuser`(
	IN `i_user` VARCHAR(50)


)
BEGIN
Select * from tbl_approvaltransfer where Originalapprover=i_user;

END//
DELIMITER ;

-- Dumping structure for procedure achi.Get_Mapped_Mail_Task
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_Mapped_Mail_Task`(
	IN `i_tasktype` VARCHAR(5)




)
BEGIN

select ot.Id,t.RefNumber, ot.UniqueEmailId, ot.EmailId, ot.ClientNumber, ot.EmailSubject, ot.EmailContent, ot.EmailAttachment, ot.IsMappedToTask, 
ot.IsActive, ot.IsProcessed, ot.RefNumber,t.Version, ot.TaskAttachement, ot.TaskComments, ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy,
 ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot left join tbl_strategy t on ot.RefNumber=t.RefNumber and ot.Version=t.Version 
where ot.IsMappedToTask =i_tasktype;

END//
DELIMITER ;

-- Dumping structure for procedure achi.Get_StrategyApprovalById
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_StrategyApprovalById`(
	IN `i_RefNumber` VARCHAR(50),
	IN `i_Version` INT

)
BEGIN
Select * from tbl_strategyApproval where RefNumber=i_RefNumber and Version=i_Version and IsActive='Y';
END//
DELIMITER ;

-- Dumping structure for procedure achi.Get_StrategyApprovalByUser
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_StrategyApprovalByUser`(
	IN `i_user` VARCHAR(50)

)
BEGIN
Select * from tbl_strategyapproval where approver=i_user and IsActive='Y';

END//
DELIMITER ;

-- Dumping structure for procedure achi.Get_StrategyLatestversionById
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_StrategyLatestversionById`(
	IN `i_RefNumber` VARCHAR(50)


)
BEGIN
Select Version from tbl_strategy where RefNumber=i_RefNumber  order by Version Desc LIMIT 1;
END//
DELIMITER ;

-- Dumping structure for procedure achi.Get_Tasks
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_Tasks`()
BEGIN
Select Id,Name,Description,IsSignOff,SignOffDate,SignoffBy,IsActive from tbl_task;
END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_AddRole
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AddRole`()
BEGIN

END//
DELIMITER ;

-- Dumping structure for procedure achi.Sp_AddRoleRightMapping
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_AddRoleRightMapping`()
BEGIN

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_adduser
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_adduser`(
	IN `i_userid` VARCHAR(50),
	IN `i_username` VARCHAR(50),
	IN `i_emailid` VARCHAR(50),
	IN `i_Roleid` VARCHAR(50),
	IN `i_countryid` INT,
	IN `i_regionid` INT,
	IN `i_businesssectorid` INT
,
	IN `i_password` VARCHAR(4000),
	IN `i_IsADUser` VARCHAR(50)

)
BEGIN
if(i_IsADUser ='Yes') then
insert into tbl_user_master (Userid,UserName,EmailId,RoleId,CountryId,RegionId,BusinessSectorId,Status,IsADUser) values(i_userid,i_username,i_emailid,i_Roleid,i_countryid,i_regionid,i_businesssectorid,'Active',i_IsADUser);
else
insert into tbl_user_master (Userid,UserName,EmailId,RoleId,CountryId,RegionId,BusinessSectorId,Status,password,IsADUser) values(i_userid,i_username,i_emailid,i_Roleid,i_countryid,i_regionid,i_businesssectorid,'Active',i_password,i_IsADUser);
end if;
END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_DeleteRole
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DeleteRole`(
	IN `i_id` INT
)
BEGIN

delete from tbl_role_master where id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_delete_ApplicationMaster
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_ApplicationMaster`(
	IN `i_id` INT

)
BEGIN
delete from tbl_ApplicationMaster where id=i_id;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_delete_BusinessSector
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_BusinessSector`(
	IN `i_id` INT

)
BEGIN
delete from tbl_BusinessSector where id=i_id;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_delete_country
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_country`(
	IN `i_id` INT

)
BEGIN
delete from tbl_country_master where id=i_id;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_delete_ProductType
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_ProductType`(
	IN `i_id` INT
)
BEGIN
delete from tbl_ProductTypemaster where id=i_id;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_delete_region
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_region`(
	IN `i_id` INT

)
BEGIN
delete from tbl_region_master where id=i_id;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_delete_strategy_Approval
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_strategy_Approval`(
	IN `i_RefNumber` VARCHAR(50),
	IN `i_Version` VARCHAR(50),
	IN `i_Approver` VARCHAR(50)


)
BEGIN

update tbl_StrategyApproval set IsActive='N' where RefNumber=i_RefNumber and Version=i_Version  and Approver=i_Approver;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_delete_transfersetting
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_transfersetting`(
	IN `i_owner` VARCHAR(50)

)
BEGIN
update tbl_transfersetting set isactive='N' where Owneruser=i_owner;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_getallApplicationMaster
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getallApplicationMaster`(
	IN `i_Id` VARCHAR(50)
)
BEGIN
if(i_Id !='') then

select * from tbl_ApplicationMaster where Id=i_id;
else
select * from tbl_ApplicationMaster;
end if;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_getallBusinessSector
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getallBusinessSector`(
	IN `i_Id` VARCHAR(50)

)
BEGIN

if(i_Id !='') then

select * from tbl_BusinessSector where Id=i_id;
else
select * from tbl_BusinessSector;
end if;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_getallcountry
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getallcountry`(
	IN `i_Id` VARCHAR(50)
)
BEGIN


if(i_Id !='') then

select * from tbl_country_master where Id=i_id;
else
select * from tbl_country_master;
end if;



END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_getallProduct
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getallProduct`(
	IN `i_Id` VARCHAR(50)

)
BEGIN

if(i_Id !='') then

select * from tbl_ProductTypemaster where Id=i_id;
else
select * from tbl_ProductTypemaster;
end if;



END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_getallregion
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getallregion`(
	IN `i_Id` VARCHAR(50)
)
BEGIN

if(i_Id !='') then

select * from tbl_region_master where Id=i_id;
else
select * from tbl_region_master;
end if;



END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_GetMapTask
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetMapTask`()
BEGIN
select ot.Id,t.RefNumber, ot.UniqueEmailId, ot.EmailId, ot.ClientNumber, ot.EmailSubject, ot.EmailContent, ot.EmailAttachment, ot.IsMappedToTask, 
ot.IsActive, ot.IsProcessed, ot.RefNumber,t.Version, ot.TaskAttachement, ot.TaskComments, ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy,
 ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot left join tbl_strategy t on ot.RefNumber=t.RefNumber and ot.Version =t.Version ;


END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_GetMapTaskbyId
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetMapTaskbyId`(
	IN `i_Id` INT




)
BEGIN
select ot.Id,t.RefNumber, ot.UniqueEmailId, ot.EmailId, ot.ClientNumber, ot.EmailSubject, ot.EmailContent, ot.EmailAttachment, ot.IsMappedToTask, 
ot.IsActive, ot.IsProcessed, ot.RefNumber,t.Version, ot.TaskAttachement, ot.TaskComments, ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy,
 ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot left join tbl_strategy t on ot.RefNumber=t.RefNumber and ot.Version =t.Version
where ot.Id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_getmenuforuser
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getmenuforuser`(
	IN `i_UserId` VARCHAR(50)
)
BEGIN
select distinct MenuName, Path, RM.RightID, RM.ShowMenu, RM.Icon from TBL_RIGHT_MASTER RM inner join TBL_ROLERIGHT_MAPPING RR on RM.RightID=RR.RightID inner join TBL_USER_MASTER UM on RR.RoleID=UM.RoleId where UM.Userid = i_UserId order by RM.RightID;
END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_GetOnboardingTask
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetOnboardingTask`()
BEGIN
select ot.Id,t.RefNumber, ot.UniqueEmailId, ot.EmailId, ot.ClientNumber, ot.EmailSubject, ot.EmailContent, ot.EmailAttachment, ot.IsMappedToTask, 
ot.IsActive, ot.IsProcessed,t.Version, ot.TaskAttachement, ot.TaskComments, ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy,
 ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot left join tbl_strategy t on ot.RefNumber=t.RefNumber;

END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_GetOnboardingTaskbyId
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetOnboardingTaskbyId`(
	IN `i_Id` INT




)
BEGIN

select ot.Id,t.RefNumber, ot.UniqueEmailId, ot.EmailId, ot.ClientNumber, ot.EmailSubject, ot.EmailContent, ot.EmailAttachment, ot.IsMappedToTask, 
ot.IsActive, ot.IsProcessed, ot.TaskId,t.Name, ot.TaskAttachement, ot.TaskComments, ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy,
 ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot left join tbl_strategy t on ot.TaskId=t.Id 
Where ot.Id=i_Id;
END//
DELIMITER ;

-- Dumping structure for procedure achi.Sp_GetRights
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_GetRights`(
	IN `i_roleid` VARCHAR(50)

)
BEGIN

if(i_roleid!='') then
Select * from tbl_right_master where RightId=i_roleid;
else
Select * from tbl_right_master;
end if;
END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_GetRoleRights
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRoleRights`(
	IN `i_roleId` INT
)
BEGIN
select * from tbl_roleright_mapping where roleId=i_roleId;
END//
DELIMITER ;

-- Dumping structure for procedure achi.Sp_GetRoles
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_GetRoles`(
	IN `i_roleId` VARCHAR(50)
)
BEGIN

if(i_roleId !='') then
select * from tbl_Role_Master where Id=i_roleId;
else
select * from tbl_Role_Master ;
End if;

END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_GetStrategy
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetStrategy`()
BEGIN

SELECT Id, RefNumber, Name, Type, ApplicationName, ApplicationId, BusinessSector, Country, Region, ProductType, Ranking, Objective, Description, RiskRating, BusinessImpact, ExchangeDetails, DetailsOfChanges, ChangesBusinessImpact, SupportingDocument, DateChangeInitiated, DateChangeImplemented, ChangesCompletionStatus, AdditionalParam1, AdditionalParam2, AdditionalParam3, AdditionalParam4, AdditionalParam5, AdditionalParam6, AdditionalParam7, AdditionalParam8, AdditionalParam9, AdditionalParam10, AdditionalParam11, AdditionalParam12, AdditionalParam13, Attribute1, Attribute2, Attribute3, Attribute4, NoOfApprover, Version,FinalSignOff, SignOffDate, SignoffBy, IsActive, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy FROM (SELECT * FROM tbl_strategy ORDER BY Version DESC) AS t GROUP BY RefNumber;

END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_GetStrategyById
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetStrategyById`(
	IN `i_RefNumber` VARCHAR(250)



)
BEGIN
select Id, RefNumber, Name, Type, ApplicationName, ApplicationId, BusinessSector, Country, Region, ProductType, Ranking, Objective, Description, RiskRating, BusinessImpact, ExchangeDetails, DetailsOfChanges, ChangesBusinessImpact, SupportingDocument, DateChangeInitiated, DateChangeImplemented, ChangesCompletionStatus, AdditionalParam1, AdditionalParam2, AdditionalParam3, AdditionalParam4, AdditionalParam5, AdditionalParam6, AdditionalParam7, AdditionalParam8, AdditionalParam9, AdditionalParam10, AdditionalParam11, AdditionalParam12, AdditionalParam13, Attribute1, Attribute2, Attribute3, Attribute4, NoOfApprover, Version,FinalSignOff, SignOffDate, SignoffBy, IsActive, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
from tbl_strategy WHERE RefNumber=i_RefNumber;
END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_GetStrategyByRefnumber
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetStrategyByRefnumber`(
	IN `i_RefNumber` VARCHAR(50)

)
BEGIN
select Id, RefNumber, Name, Type, ApplicationName, ApplicationId, BusinessSector, Country, Region, ProductType, Ranking, Objective, Description, RiskRating, BusinessImpact, ExchangeDetails, DetailsOfChanges, ChangesBusinessImpact, SupportingDocument, DateChangeInitiated, DateChangeImplemented, ChangesCompletionStatus, AdditionalParam1, AdditionalParam2, AdditionalParam3, AdditionalParam4, AdditionalParam5, AdditionalParam6, AdditionalParam7, AdditionalParam8, AdditionalParam9, AdditionalParam10, AdditionalParam11, AdditionalParam12, AdditionalParam13, Attribute1, Attribute2, Attribute3, Attribute4, NoOfApprover, Version,FinalSignOff, SignOffDate, SignoffBy, IsActive, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy
from tbl_strategy WHERE RefNumber=i_RefNumber;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_gettransfersettingbyuser
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_gettransfersettingbyuser`(
	IN `i_Owner` VARCHAR(50)

)
BEGIN
select * from tbl_transfersetting where Owneruser=i_Owner and IsActive='Y';
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_getusers
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getusers`(
	IN `i_userid` VARCHAR(50)


)
BEGIN

if(i_userid ='') then
select u.Userid,u.UserName,u.EmailId,u.RegionId,r.RegionName,u.CountryId,c.CountryName,u.BusinessSectorId,b.Name,u.RoleId,rm.RoleName,u.Status from tbl_user_master u join tbl_businesssector b on u.BusinessSectorId=b.Id join tbl_region_master r  on u.RegionId=r.Id join tbl_country_master c  on u.CountryId=c.id join tbl_role_master rm on u.RoleId=rm.Id;
else
select u.Userid,u.UserName,u.EmailId,u.RegionId,r.RegionName,u.CountryId,c.CountryName,u.BusinessSectorId,b.Name,u.RoleId,rm.RoleName,u.Status from tbl_user_master u join tbl_businesssector b on u.BusinessSectorId=b.Id join tbl_region_master r  on u.RegionId=r.Id join tbl_country_master c  on u.CountryId=c.id join tbl_role_master rm on u.RoleId=rm.Id  where u.userid=i_userid;
end if;


END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_ApplicationMaster
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_ApplicationMaster`(
	IN `i_ApplicationId` VARCHAR(50)
,
	IN `i_ApplicationName` VARCHAR(50)

)
BEGIN

insert into tbl_ApplicationMaster (ApplicationID,ApplicationName) values(i_ApplicationId,i_ApplicationName);

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_BusinessSector
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_BusinessSector`(
	IN `i_BusinessSectorName` VARCHAR(50)

)
BEGIN

insert into tbl_BusinessSector (Name) values(i_BusinessSectorName);

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_Country
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_Country`(
	IN `i_CountryName` VARCHAR(50)

)
BEGIN

insert into tbl_country_master (Countryname) values(i_CountryName);

END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_insert_OnboardingTask
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_insert_OnboardingTask`(
	IN `i_UniqueEmailID` VARCHAR(400),
	IN `i_EmailID` VARCHAR(500),
	IN `i_ClientNumber` VARCHAR(500),
	IN `i_Subject` VARCHAR(4000),
	IN `i_IsMappedToTask` VARCHAR(5),
	IN `i_EmailAttachment` VARCHAR(4000),
	IN `i_CreatedDate` DATETIME

,
	IN `i_Emailcontent` VARCHAR(4000)
,
	IN `i_CreatedBy` VARCHAR(500),
	IN `i_TaskAssignedDate` DATETIME
)
BEGIN

Insert into tbl_onboarding_task (UniqueEmailID,EmailID,ClientNumber,EmailSubject,EmailContent,IsMappedToTask,EmailAttachment,CreatedDate,IsActive,IsProcessed,CreatedBy,TaskAssignedDate) 
values (i_UniqueEmailID,i_EmailID,i_ClientNumber,i_Subject,i_EmailContent,i_IsMappedToTask,i_EmailAttachment,i_CreatedDate,'Y','N',i_CreatedBy,i_TaskAssignedDate);

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_Product
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_Product`(
	IN `i_ProductName` VARCHAR(50)


)
BEGIN

insert into tbl_ProductTypemaster (ProductType) values(i_ProductName);

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_Region
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_Region`(
	IN `i_RegionName` VARCHAR(50)


)
BEGIN

insert into tbl_region_master (regionname) values(i_RegionName);

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_role
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_role`(
	IN `i_role` VARCHAR(50),
	OUT `param_auto_id` INT
)
BEGIN
insert into tbl_role_master (RoleName) values(i_role);
  set param_auto_id := last_insert_id();
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_roleright
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_roleright`(
	IN `i_RoleId` INT,
	IN `i_RightId` INT

)
BEGIN
insert into tbl_roleright_mapping (RoleId,RightId) values(i_RoleId,i_RightId);
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_Strategy
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_Strategy`(
	IN `i_RefNumber` VARCHAR(50),
	IN `i_Name` VARCHAR(50),
	IN `i_Type` INT,
	IN `i_ApplicationName` VARCHAR(50),
	IN `i_ApplicationId` VARCHAR(50),
	IN `i_BusinessSector` VARCHAR(50),
	IN `i_Country` VARCHAR(50),
	IN `i_Region` VARCHAR(50),
	IN `i_ProductType` VARCHAR(50),
	IN `i_Ranking` VARCHAR(50),
	IN `i_Objective` VARCHAR(50),
	IN `i_Description` VARCHAR(50),
	IN `i_RiskRating` VARCHAR(50),
	IN `i_BusinessImpact` VARCHAR(50),
	IN `i_ExchangeDetails` VARCHAR(50),
	IN `i_AdditionalParam1` VARCHAR(50),
	IN `i_AdditionalParam2` VARCHAR(50),
	IN `i_AdditionalParam3` VARCHAR(50),
	IN `i_AdditionalParam4` VARCHAR(50),
	IN `i_AdditionalParam5` VARCHAR(50),
	IN `i_AdditionalParam6` VARCHAR(50),
	IN `i_AdditionalParam7` VARCHAR(50),
	IN `i_AdditionalParam8` VARCHAR(50),
	IN `i_AdditionalParam9` VARCHAR(50),
	IN `i_AdditionalParam10` VARCHAR(50),
	IN `i_AdditionalParam11` VARCHAR(50),
	IN `i_AdditionalParam12` VARCHAR(50),
	IN `i_AdditionalParam13` VARCHAR(50)
,
	IN `i_Attribute1` VARCHAR(50)
,
	IN `i_Attribute2` VARCHAR(50)
,
	IN `i_Attribute3` VARCHAR(50)
,
	IN `i_Attribute4` VARCHAR(50)

)
BEGIN
insert into tbl_strategy	 (RefNumber, Name, Type, ApplicationName, ApplicationId, BusinessSector, Country, Region, ProductType, Ranking, Objective, Description, RiskRating, BusinessImpact, ExchangeDetails,AdditionalParam1, AdditionalParam2, AdditionalParam3, AdditionalParam4, AdditionalParam5, AdditionalParam6, AdditionalParam7, AdditionalParam8, AdditionalParam9, AdditionalParam10, AdditionalParam11, AdditionalParam12, AdditionalParam13,IsActive,Version) 
values(i_RefNumber, i_Name, i_Type, i_ApplicationName, i_ApplicationId,i_BusinessSector, i_Country, i_Region, i_ProductType, i_Ranking, i_Objective, i_Description, i_RiskRating, i_BusinessImpact, i_ExchangeDetails, i_AdditionalParam1, i_AdditionalParam2, i_AdditionalParam3, i_AdditionalParam4, i_AdditionalParam5, i_AdditionalParam6, i_AdditionalParam7, i_AdditionalParam8, i_AdditionalParam9, i_AdditionalParam10, i_AdditionalParam11, i_AdditionalParam12, i_AdditionalParam13, 'Y',1);
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_strategy_Approval
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_strategy_Approval`(
	IN `i_RefNumber` VARCHAR(50),
	IN `i_Version` VARCHAR(50),
	IN `i_Approver` VARCHAR(50)












)
BEGIN

declare transstatus varchar(50);
declare transto varchar(50);
set transstatus='N';
 IF (SELECT count(*) FROM tbl_transfersetting  WHERE Owneruser=i_Approver and IsActive='Y')>0 THEN
 Begin
 set transstatus='Y';
select TransferTo into transto from tbl_transfersetting  WHERE Owneruser=i_Approver and IsActive='Y';
 INSERT INTO tbl_approvaltransfer(RefNumber, Version,Approver,OriginalApprover,IsActive,IsTransfered,IsViewed,IsModified) VALUES (i_RefNumber, i_Version,transto,i_Approver,'Y','N','N','N');
 end;
  END IF;

 IF (SELECT count(*) FROM tbl_StrategyApproval  WHERE RefNumber=i_RefNumber and  Version=i_Version and Approver=i_Approver and IsActive='Y')<=0 THEN
BEGIN
INSERT INTO tbl_StrategyApproval (RefNumber, Version,Approver,IsActive,IsTransfered,IsViewed,IsModified) VALUES (i_RefNumber, i_Version,i_Approver,'Y',transstatus,'N','N');
END;
ELSE
BEGIN 
	UPDATE tbl_StrategyApproval SET Isviewed='N', IsModified='N',IsTransfered=transstatus  WHERE RefNumber=i_RefNumber and  Version=i_Version and Approver=i_Approver and IsActive='Y';
END;
END IF;
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_Strategy_Version
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_Strategy_Version`(
	IN `i_RefNumber` VARCHAR(50),
	IN `i_Name` VARCHAR(50),
	IN `i_Type` INT,
	IN `i_ApplicationName` VARCHAR(50),
	IN `i_ApplicationId` VARCHAR(50),
	IN `i_BusinessSector` VARCHAR(50),
	IN `i_Country` VARCHAR(50),
	IN `i_Region` VARCHAR(50),
	IN `i_ProductType` VARCHAR(50),
	IN `i_Ranking` VARCHAR(50),
	IN `i_Objective` VARCHAR(50),
	IN `i_Description` VARCHAR(50),
	IN `i_RiskRating` VARCHAR(50),
	IN `i_BusinessImpact` VARCHAR(50),
	IN `i_ExchangeDetails` VARCHAR(50),
	IN `i_AdditionalParam1` VARCHAR(50),
	IN `i_AdditionalParam2` VARCHAR(50),
	IN `i_AdditionalParam3` VARCHAR(50),
	IN `i_AdditionalParam4` VARCHAR(50),
	IN `i_AdditionalParam5` VARCHAR(50),
	IN `i_AdditionalParam6` VARCHAR(50),
	IN `i_AdditionalParam7` VARCHAR(50),
	IN `i_AdditionalParam8` VARCHAR(50),
	IN `i_AdditionalParam9` VARCHAR(50),
	IN `i_AdditionalParam10` VARCHAR(50),
	IN `i_AdditionalParam11` VARCHAR(50),
	IN `i_AdditionalParam12` VARCHAR(50),
	IN `i_AdditionalParam13` VARCHAR(50)
,
	IN `i_Attribute1` VARCHAR(50)
,
	IN `i_Attribute2` VARCHAR(50)
,
	IN `i_Attribute3` VARCHAR(50)
,
	IN `i_Attribute4` VARCHAR(50)

,
	IN `i_Version` INT
)
BEGIN
insert into tbl_strategy(RefNumber, Name, Type, ApplicationName, ApplicationId, BusinessSector, Country, Region, ProductType, Ranking, Objective, Description, RiskRating, BusinessImpact, ExchangeDetails,AdditionalParam1, AdditionalParam2, AdditionalParam3, AdditionalParam4, AdditionalParam5, AdditionalParam6, AdditionalParam7, AdditionalParam8, AdditionalParam9, AdditionalParam10, AdditionalParam11, AdditionalParam12, AdditionalParam13,Attribute1,Attribute2,Attribute3,Attribute4,IsActive,Version) 
values(i_RefNumber, i_Name, i_Type, i_ApplicationName, i_ApplicationId,i_BusinessSector, i_Country, i_Region, i_ProductType, i_Ranking, i_Objective, i_Description, i_RiskRating, i_BusinessImpact, i_ExchangeDetails, i_AdditionalParam1, i_AdditionalParam2, i_AdditionalParam3, i_AdditionalParam4, i_AdditionalParam5, i_AdditionalParam6, i_AdditionalParam7, i_AdditionalParam8, i_AdditionalParam9, i_AdditionalParam10, i_AdditionalParam11, i_AdditionalParam12, i_AdditionalParam13,i_Attribute1,i_Attribute2,i_Attribute3,i_Attribute4, 'Y',i_Version);
END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_task
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_task`(
	IN `i_Name` VARCHAR(50),
	IN `i_IsSignOff` VARCHAR(1)
,
	IN `i_Description` VARCHAR(250)
,
	IN `i_IsActive` VARCHAR(50)

)
BEGIN

insert into tbl_task (Name,Description,IsSignOff,IsActive,CreatedDate,CreatedBy,LastModifiedDate,LastModifiedBy) values (i_Name,i_Description,i_IsSignOff,i_IsActive,CURRENT_DATE,'',CURRENT_DATE,'');

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_insert_transfersetting
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_transfersetting`(
	IN `i_Owneruser` VARCHAR(50),
	IN `i_TransferTo` VARCHAR(50),
	IN `i_DurationFrom` VARCHAR(50),
	IN `i_DurationTo` VARCHAR(50)

)
BEGIN

update tbl_transfersetting set IsActive='N' where Owneruser=i_Owneruser;

insert into tbl_transfersetting(Owneruser,TransferTo,DurationFrom,DurationTo,IsActive)values(i_Owneruser,i_TransferTo,i_DurationFrom,i_DurationTo,'Y');

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_updateuser
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateuser`(
	IN `i_userid` VARCHAR(50),
	IN `i_username` VARCHAR(50),
	IN `i_emailid` VARCHAR(50),
	IN `i_Roleid` VARCHAR(50),
	IN `i_countryid` INT,
	IN `i_regionid` INT,
	IN `i_businesssectorid` INT,
	IN `i_status` VARCHAR(50)
)
BEGIN

update tbl_user_master set UserName=i_username,EmailId=i_emailid,RoleId=i_Roleid,CountryId=i_countryid,RegionId=i_regionid,BusinessSectorId=i_businesssectorid,Status=i_status 
where Userid=i_userid;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_update_Applicationmaster
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_Applicationmaster`(
	IN `i_id` INT,
	IN `i_ApplicationId` VARCHAR(50),
	IN `i_ApplicationName` VARCHAR(50)
)
BEGIN

update tbl_ApplicationMaster set ApplicationName=i_ApplicationName , ApplicationId=i_ApplicationId where id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_update_BusinessSector
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_BusinessSector`(
	IN `i_id` INT,
	IN `i_BusinessSectorname` VARCHAR(50)

)
BEGIN

update tbl_BusinessSector set  name=i_BusinessSectorname where id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_update_countrymaster
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_countrymaster`(
	IN `i_id` INT,
	IN `i_countryname` VARCHAR(50)
)
BEGIN

update tbl_country_master set countryname=i_countryname where id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_update_map_task
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_map_task`(
	IN `i_id` INT,
	IN `i_RefNumber` VARCHAR(50),
	IN `i_Version` INT,
	IN `i_IsMappedToTask` VARCHAR(50)


)
BEGIN
	
	update tbl_onboarding_task set RefNumber=i_RefNumber,Version =i_Version,IsMappedToTask=i_IsMappedToTask where Id=i_id;
	
END//
DELIMITER ;

-- Dumping structure for procedure achi.SP_update_onboardingTask
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_update_onboardingTask`(
	IN `i_id` INT,
	IN `i_TaskAttachment` VARCHAR(500)
,
	IN `i_comments` VARCHAR(500)
)
BEGIN

update tbl_onboarding_task set TaskAttachement=i_TaskAttachment,comments=i_comments where Id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_update_Productmaster
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_Productmaster`(
	IN `i_id` INT,
	IN `i_ProductName` VARCHAR(50)

)
BEGIN

update tbl_ProductTypemaster set ProductType =i_ProductName where id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_update_regionmaster
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_regionmaster`(
	IN `i_id` INT,
	IN `i_regionname` VARCHAR(50)
)
BEGIN

update tbl_region_master set regionname=i_regionname where id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_update_Strategy
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_Strategy`(
	IN `i_RefNumber` VARCHAR(50),
	IN `i_Name` VARCHAR(50),
	IN `i_Type` INT,
	IN `i_ApplicationName` VARCHAR(50),
	IN `i_ApplicationId` VARCHAR(50),
	IN `i_BusinessSector` VARCHAR(50),
	IN `i_Country` VARCHAR(50),
	IN `i_Region` VARCHAR(50),
	IN `i_ProductType` VARCHAR(50),
	IN `i_Ranking` VARCHAR(50),
	IN `i_Objective` VARCHAR(50),
	IN `i_Description` VARCHAR(50),
	IN `i_RiskRating` VARCHAR(50),
	IN `i_BusinessImpact` VARCHAR(50),
	IN `i_ExchangeDetails` VARCHAR(50),
	IN `i_AdditionalParam1` VARCHAR(50),
	IN `i_AdditionalParam2` VARCHAR(50),
	IN `i_AdditionalParam3` VARCHAR(50),
	IN `i_AdditionalParam4` VARCHAR(50),
	IN `i_AdditionalParam5` VARCHAR(50),
	IN `i_AdditionalParam6` VARCHAR(50),
	IN `i_AdditionalParam7` VARCHAR(50),
	IN `i_AdditionalParam8` VARCHAR(50),
	IN `i_AdditionalParam9` VARCHAR(50),
	IN `i_AdditionalParam10` VARCHAR(50),
	IN `i_AdditionalParam11` VARCHAR(50),
	IN `i_AdditionalParam12` VARCHAR(50),
	IN `i_AdditionalParam13` VARCHAR(50)
,
	IN `i_Id` INT
,
	IN `i_Page` VARCHAR(50)
,
	IN `i_Attribute1` VARCHAR(50)
,
	IN `i_Attribute2` VARCHAR(50)
,
	IN `i_Attribute3` VARCHAR(50)
,
	IN `i_Attribute4` VARCHAR(50)
,
	IN `i_DetailsOfChanges` VARCHAR(50)
)
BEGIN
if i_Page = 'C' THEN
update tbl_strategy set RefNumber=i_RefNumber, Name =i_Name,  Type=i_Type, ApplicationName = i_ApplicationName, ApplicationId= i_ApplicationId,BusinessSector=i_BusinessSector, Country=   i_Country, Region=i_Region,  ProductType=i_ProductType,  Ranking=i_Ranking, Objective= i_Objective,Description=i_Description, RiskRating=   i_RiskRating, BusinessImpact=   i_BusinessImpact,ExchangeDetails=i_ExchangeDetails,AdditionalParam1= i_AdditionalParam1,AdditionalParam2=i_AdditionalParam2, AdditionalParam3=    i_AdditionalParam3, AdditionalParam4=i_AdditionalParam4, AdditionalParam5=  i_AdditionalParam5,AdditionalParam6=i_AdditionalParam6, AdditionalParam7=i_AdditionalParam7,  AdditionalParam8=i_AdditionalParam8,  AdditionalParam9=i_AdditionalParam9, AdditionalParam10=i_AdditionalParam10,  AdditionalParam11=i_AdditionalParam11,   AdditionalParam12=i_AdditionalParam12, AdditionalParam13= i_AdditionalParam13,Attribute1=i_Attribute1,Attribute2=i_Attribute2,Attribute3=i_Attribute3,Attribute4=i_Attribute4,DetailsOfChanges=i_DetailsOfChanges where Id=i_id; 
else
update tbl_strategy set RefNumber=i_RefNumber, Name =i_Name,  Type=i_Type, ApplicationName = i_ApplicationName, ApplicationId= i_ApplicationId,BusinessSector=i_BusinessSector, Country=   i_Country, Region=i_Region,  ProductType=i_ProductType,  Ranking=i_Ranking, Objective= i_Objective,Description=i_Description, RiskRating=   i_RiskRating, BusinessImpact=   i_BusinessImpact,ExchangeDetails=i_ExchangeDetails,AdditionalParam1= i_AdditionalParam1,AdditionalParam2=i_AdditionalParam2, AdditionalParam3=    i_AdditionalParam3, AdditionalParam4=i_AdditionalParam4, AdditionalParam5=  i_AdditionalParam5,AdditionalParam6=i_AdditionalParam6, AdditionalParam7=i_AdditionalParam7,  AdditionalParam8=i_AdditionalParam8,  AdditionalParam9=i_AdditionalParam9, AdditionalParam10=i_AdditionalParam10,  AdditionalParam11=i_AdditionalParam11,   AdditionalParam12=i_AdditionalParam12, AdditionalParam13= i_AdditionalParam13 where Id=i_id; 
END IF;


END//
DELIMITER ;

-- Dumping structure for procedure achi.Sp_update_strategy_approval
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_update_strategy_approval`(
	IN `i_Comments` VARCHAR(50),
	IN `i_Status` VARCHAR(50),
	IN `i_RefNumber` VARCHAR(50),
	IN `i_Version` VARCHAR(50),
	IN `i_Approver` VARCHAR(50)

)
BEGIN

update tbl_StrategyApproval set Comments =i_Comments,Status=i_Status where RefNumber=i_RefNumber and Version=i_Version  and Approver=i_Approver;

END//
DELIMITER ;

-- Dumping structure for procedure achi.sp_update_task
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_task`(
	IN `i_Id` INT,
	IN `i_IsSignOff` VARCHAR(50),
	IN `i_IsActive` VARCHAR(50),
	IN `i_Description` VARCHAR(500),
	IN `i_Name` VARCHAR(500)
)
BEGIN

update tbl_task  set Name=i_Name,Description=i_Description,IsSignOff=i_IsSignOff,IsActive=i_IsActive,LastModifiedDate=CURRENT_DATE where Id=i_Id;

END//
DELIMITER ;

-- Dumping structure for table achi.tbl_aduser_master
CREATE TABLE IF NOT EXISTS `tbl_aduser_master` (
  `Userid` varchar(255) CHARACTER SET utf8 NOT NULL,
  `UserName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `EmailId` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `MobileNumber` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `st` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `postalCode` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `physicalDeliveryOfficeName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `telephoneNumber` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `department` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `streetAddress` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `manager` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `homePhone` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`Userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_aduser_master: ~0 rows (approximately)
DELETE FROM `tbl_aduser_master`;
/*!40000 ALTER TABLE `tbl_aduser_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_aduser_master` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_applicationmaster
CREATE TABLE IF NOT EXISTS `tbl_applicationmaster` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationID` varchar(50) DEFAULT NULL,
  `ApplicationName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_applicationmaster: ~4 rows (approximately)
DELETE FROM `tbl_applicationmaster`;
/*!40000 ALTER TABLE `tbl_applicationmaster` DISABLE KEYS */;
INSERT INTO `tbl_applicationmaster` (`Id`, `ApplicationID`, `ApplicationName`) VALUES
	(1, '1001', 'app1'),
	(2, '1002', 'app2'),
	(3, '1003', 'app3'),
	(4, '1004', 'appplicaton 4');
/*!40000 ALTER TABLE `tbl_applicationmaster` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_approvaltransfer
CREATE TABLE IF NOT EXISTS `tbl_approvaltransfer` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `RefNumber` varchar(50) DEFAULT '0',
  `Version` varchar(50) DEFAULT '0',
  `Approver` varchar(50) DEFAULT '0',
  `OriginalApprover` varchar(50) DEFAULT '0',
  `Comments` varchar(50) DEFAULT '0',
  `ApprovedDate` varchar(50) DEFAULT '0',
  `Status` varchar(50) DEFAULT '0',
  `ActionStatus` varchar(50) DEFAULT '0',
  `IsActive` varchar(50) DEFAULT NULL,
  `IsTransfered` varchar(50) DEFAULT NULL,
  `IsViewed` varchar(50) DEFAULT NULL,
  `IsModified` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_approvaltransfer: ~2 rows (approximately)
DELETE FROM `tbl_approvaltransfer`;
/*!40000 ALTER TABLE `tbl_approvaltransfer` DISABLE KEYS */;
INSERT INTO `tbl_approvaltransfer` (`Id`, `RefNumber`, `Version`, `Approver`, `OriginalApprover`, `Comments`, `ApprovedDate`, `Status`, `ActionStatus`, `IsActive`, `IsTransfered`, `IsViewed`, `IsModified`) VALUES
	(75, '1', '1', 'George', 'John', '0', '0', '0', '0', 'Y', 'N', 'N', 'N'),
	(76, '1', '1', 'George', 'John', '0', '0', '0', '0', 'Y', 'N', 'N', 'N');
/*!40000 ALTER TABLE `tbl_approvaltransfer` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_businesssector
CREATE TABLE IF NOT EXISTS `tbl_businesssector` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_businesssector: ~1 rows (approximately)
DELETE FROM `tbl_businesssector`;
/*!40000 ALTER TABLE `tbl_businesssector` DISABLE KEYS */;
INSERT INTO `tbl_businesssector` (`Id`, `Name`) VALUES
	(1, 'sector');
/*!40000 ALTER TABLE `tbl_businesssector` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_client
CREATE TABLE IF NOT EXISTS `tbl_client` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClientNumber` varchar(30) NOT NULL,
  `InvDevLoan` varchar(30) NOT NULL,
  `ObligorName` varchar(500) NOT NULL,
  `StrChartAttchd` varchar(1) NOT NULL,
  `OriginalLender` varchar(500) NOT NULL,
  `LCompanyName` varchar(250) NOT NULL,
  `LRegAddressL1` text NOT NULL,
  `LRegAddressL2` text,
  `LRegAddressL3` text,
  `LRegAddressEmail` varchar(250) NOT NULL,
  `LRegAddressTelNum` varchar(50) NOT NULL,
  `LRegAddressCity` varchar(250) NOT NULL,
  `LRegAddressState` varchar(250) NOT NULL,
  `LRegAddressCountry` varchar(250) NOT NULL,
  `LRegAddressPostCode` varchar(30) NOT NULL,
  `LPriAddressL1` text NOT NULL,
  `LPriAddressL2` text,
  `LPriAddressL3` text,
  `LPriAddressEmail` varchar(250) NOT NULL,
  `LPriAddressTelNum` varchar(50) NOT NULL,
  `LPriAddressCity` varchar(250) NOT NULL,
  `LPriAddressState` varchar(250) NOT NULL,
  `LPriAddressCountry` varchar(250) NOT NULL,
  `LPriAddressPostCode` varchar(30) NOT NULL,
  `LKC1L1` text,
  `LKC1L2` text,
  `LKC1L3` text,
  `LKC1Email` varchar(250) DEFAULT NULL,
  `LKC1TelNum` varchar(50) DEFAULT NULL,
  `LKC1City` varchar(250) DEFAULT NULL,
  `LKC1State` varchar(250) DEFAULT NULL,
  `LKC1Country` varchar(250) DEFAULT NULL,
  `LKC1PostCode` varchar(30) DEFAULT NULL,
  `LKC2L1` text,
  `LKC2L2` text,
  `LKC2L3` text,
  `LKC2Email` varchar(250) DEFAULT NULL,
  `LKC2TelNum` varchar(50) DEFAULT NULL,
  `LKC2City` varchar(250) DEFAULT NULL,
  `LKC2State` varchar(250) DEFAULT NULL,
  `LKC2Country` varchar(250) DEFAULT NULL,
  `LKC2PostCode` varchar(30) DEFAULT NULL,
  `LKC3L1` text,
  `LKC3L2` text,
  `LKC3L3` text,
  `LKC3Email` varchar(250) DEFAULT NULL,
  `LKC3TelNum` varchar(50) DEFAULT NULL,
  `LKC3City` varchar(250) DEFAULT NULL,
  `LKC3State` varchar(250) DEFAULT NULL,
  `LKC3Country` varchar(250) DEFAULT NULL,
  `LKC3PostCode` varchar(30) DEFAULT NULL,
  `LKC4L1` text,
  `LKC4L2` text,
  `LKC4L3` text,
  `LKC4Email` varchar(250) DEFAULT NULL,
  `LKC4TelNum` varchar(50) DEFAULT NULL,
  `LKC4City` varchar(250) DEFAULT NULL,
  `LKC4State` varchar(250) DEFAULT NULL,
  `LKC4Country` varchar(250) DEFAULT NULL,
  `LKC4PostCode` varchar(30) DEFAULT NULL,
  `LKC5L1` text,
  `LKC5L2` text,
  `LKC5L3` text,
  `LKC5Email` varchar(250) DEFAULT NULL,
  `LKC5TelNum` varchar(50) DEFAULT NULL,
  `LKC5City` varchar(250) DEFAULT NULL,
  `LKC5State` varchar(250) DEFAULT NULL,
  `LKC5Country` varchar(250) DEFAULT NULL,
  `LKC5PostCode` varchar(30) DEFAULT NULL,
  `BCompanyName` varchar(250) NOT NULL,
  `BRegAddressL1` text NOT NULL,
  `BRegAddressL2` text,
  `BRegAddressL3` text,
  `BRegAddressEmail` varchar(250) NOT NULL,
  `BRegAddressTelNum` varchar(50) NOT NULL,
  `BRegAddressCity` varchar(250) NOT NULL,
  `BRegAddressState` varchar(250) NOT NULL,
  `BRegAddressCountry` varchar(250) NOT NULL,
  `BRegAddressPostCode` varchar(30) NOT NULL,
  `BPriAddressL1` text NOT NULL,
  `BPriAddressL2` text,
  `BPriAddressL3` text,
  `BPriAddressEmail` varchar(250) NOT NULL,
  `BPriAddressTelNum` varchar(50) NOT NULL,
  `BPriAddressCity` varchar(250) NOT NULL,
  `BPriAddressState` varchar(250) NOT NULL,
  `BPriAddressCountry` varchar(250) NOT NULL,
  `BPriAddressPostCode` varchar(30) NOT NULL,
  `BKC1L1` text,
  `BKC1L2` text,
  `BKC1L3` text,
  `BKC1Email` varchar(250) DEFAULT NULL,
  `BKC1TelNum` varchar(50) DEFAULT NULL,
  `BKC1City` varchar(250) DEFAULT NULL,
  `BKC1State` varchar(250) DEFAULT NULL,
  `BKC1Country` varchar(250) DEFAULT NULL,
  `BKC1PostCode` varchar(30) DEFAULT NULL,
  `BKC2L1` text,
  `BKC2L2` text,
  `BKC2L3` text,
  `BKC2Email` varchar(250) DEFAULT NULL,
  `BKC2TelNum` varchar(50) DEFAULT NULL,
  `BKC2City` varchar(250) DEFAULT NULL,
  `BKC2State` varchar(250) DEFAULT NULL,
  `BKC2Country` varchar(250) DEFAULT NULL,
  `BKC2PostCode` varchar(30) DEFAULT NULL,
  `BKC3L1` text,
  `BKC3L2` text,
  `BKC3L3` text,
  `BKC3Email` varchar(250) DEFAULT NULL,
  `BKC3TelNum` varchar(50) DEFAULT NULL,
  `BKC3City` varchar(250) DEFAULT NULL,
  `BKC3State` varchar(250) DEFAULT NULL,
  `BKC3Country` varchar(250) DEFAULT NULL,
  `BKC3PostCode` varchar(30) DEFAULT NULL,
  `BKC4L1` text,
  `BKC4L2` text,
  `BKC4L3` text,
  `BKC4Email` varchar(250) DEFAULT NULL,
  `BKC4TelNum` varchar(50) DEFAULT NULL,
  `BKC4City` varchar(250) DEFAULT NULL,
  `BKC4State` varchar(250) DEFAULT NULL,
  `BKC4Country` varchar(250) DEFAULT NULL,
  `BKC4PostCode` varchar(30) DEFAULT NULL,
  `BKC5L1` text,
  `BKC5L2` text,
  `BKC5L3` text,
  `BKC5Email` varchar(250) DEFAULT NULL,
  `BKC5TelNum` varchar(50) DEFAULT NULL,
  `BKC5City` varchar(250) DEFAULT NULL,
  `BKC5State` varchar(250) DEFAULT NULL,
  `BKC5Country` varchar(250) DEFAULT NULL,
  `BKC5PostCode` varchar(30) DEFAULT NULL,
  `ProposedDealCommencementDate` date DEFAULT NULL,
  `PropAddress1L1` text,
  `PropAddress1L2` text,
  `PropAddress1L3` text,
  `PropAddress1Email` varchar(250) DEFAULT NULL,
  `PropAddress1TelNum` varchar(50) DEFAULT NULL,
  `PropAddress1City` varchar(250) DEFAULT NULL,
  `PropAddress1State` varchar(250) DEFAULT NULL,
  `PropAddress1Country` varchar(250) DEFAULT NULL,
  `PropAddress1PostCode` varchar(30) DEFAULT NULL,
  `PropAddress2L1` text,
  `PropAddress2L2` text,
  `PropAddress2L3` text,
  `PropAddress2Email` varchar(250) DEFAULT NULL,
  `PropAddress2TelNum` varchar(50) DEFAULT NULL,
  `PropAddress2City` varchar(250) DEFAULT NULL,
  `PropAddress2State` varchar(250) DEFAULT NULL,
  `PropAddress2Country` varchar(250) DEFAULT NULL,
  `PropAddress2PostCode` varchar(30) DEFAULT NULL,
  `PropAddress3L1` text,
  `PropAddress3L2` text,
  `PropAddress3L3` text,
  `PropAddress3Email` varchar(250) DEFAULT NULL,
  `PropAddress3TelNum` varchar(50) DEFAULT NULL,
  `PropAddress3City` varchar(250) DEFAULT NULL,
  `PropAddress3State` varchar(250) DEFAULT NULL,
  `PropAddress3Country` varchar(250) DEFAULT NULL,
  `PropAddress3PostCode` varchar(30) DEFAULT NULL,
  `PropAddress4L1` text,
  `PropAddress4L2` text,
  `PropAddress4L3` text,
  `PropAddress4Email` varchar(250) DEFAULT NULL,
  `PropAddress4TelNum` varchar(50) DEFAULT NULL,
  `PropAddress4City` varchar(250) DEFAULT NULL,
  `PropAddress4State` varchar(250) DEFAULT NULL,
  `PropAddress4Country` varchar(250) DEFAULT NULL,
  `PropAddress4PostCode` varchar(30) DEFAULT NULL,
  `PropAddress5L1` text,
  `PropAddress5L2` text,
  `PropAddress5L3` text,
  `PropAddress5Email` varchar(250) DEFAULT NULL,
  `PropAddress5TelNum` varchar(50) DEFAULT NULL,
  `PropAddress5City` varchar(250) DEFAULT NULL,
  `PropAddress5State` varchar(250) DEFAULT NULL,
  `PropAddress5Country` varchar(250) DEFAULT NULL,
  `PropAddress5PostCode` varchar(30) DEFAULT NULL,
  `LoanDateAggrmnt` date NOT NULL,
  `FirstUtilisationDate` date NOT NULL,
  `AmountAdvancedonFUD` double(16,2) NOT NULL,
  `OriginalCommitmentAmount` double(16,2) NOT NULL,
  `FirstInterestPaymentDate` date DEFAULT NULL,
  `PaymentFrequency` int(11) NOT NULL,
  `IsSignOff` varchar(1) DEFAULT NULL,
  `SignOffDate` datetime DEFAULT NULL,
  `SignoffBy` varchar(100) DEFAULT NULL,
  `IsActive` varchar(1) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `LastModifiedDate` datetime DEFAULT NULL,
  `LastModifiedBy` varchar(100) DEFAULT NULL,
  `Res1` varchar(250) DEFAULT NULL,
  `Res2` varchar(250) DEFAULT NULL,
  `Res3` varchar(250) DEFAULT NULL,
  `Res4` varchar(250) DEFAULT NULL,
  `Res5` varchar(250) DEFAULT NULL,
  `Res6` varchar(250) DEFAULT NULL,
  `Res7` varchar(250) DEFAULT NULL,
  `Res8` varchar(250) DEFAULT NULL,
  `Res9` varchar(250) DEFAULT NULL,
  `Res10` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IDX_ClientNumber` (`ClientNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_client: ~0 rows (approximately)
DELETE FROM `tbl_client`;
/*!40000 ALTER TABLE `tbl_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_client` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_country_master
CREATE TABLE IF NOT EXISTS `tbl_country_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CountryName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_country_master: ~2 rows (approximately)
DELETE FROM `tbl_country_master`;
/*!40000 ALTER TABLE `tbl_country_master` DISABLE KEYS */;
INSERT INTO `tbl_country_master` (`id`, `CountryName`) VALUES
	(1, 'India'),
	(2, 'England');
/*!40000 ALTER TABLE `tbl_country_master` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_onboarding_task
CREATE TABLE IF NOT EXISTS `tbl_onboarding_task` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UniqueEmailId` varchar(100) NOT NULL,
  `EmailId` varchar(200) NOT NULL,
  `ClientNumber` varchar(30) NOT NULL,
  `EmailSubject` varchar(1000) NOT NULL,
  `EmailContent` text,
  `EmailAttachment` text,
  `IsMappedToTask` varchar(1) NOT NULL,
  `IsActive` varchar(1) NOT NULL,
  `IsProcessed` varchar(1) NOT NULL,
  `RefNumber` varchar(30) DEFAULT NULL,
  `Version` varchar(50) DEFAULT NULL,
  `TaskAttachement` text,
  `TaskComments` text,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` varchar(100) NOT NULL,
  `TaskAssignedBy` varchar(100) DEFAULT NULL,
  `TaskAssignedDate` datetime NOT NULL,
  `LastModifiedDate` datetime DEFAULT NULL,
  `LastModifiedBy` varchar(100) DEFAULT NULL,
  `Res1` varchar(250) DEFAULT NULL,
  `Res2` varchar(250) DEFAULT NULL,
  `Res3` varchar(250) DEFAULT NULL,
  `Res4` varchar(250) DEFAULT NULL,
  `Res5` varchar(250) DEFAULT NULL,
  `Res6` varchar(250) DEFAULT NULL,
  `Res7` varchar(250) DEFAULT NULL,
  `Res8` varchar(250) DEFAULT NULL,
  `Res9` varchar(250) DEFAULT NULL,
  `Res10` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IDX_UniqueEmailId` (`UniqueEmailId`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_onboarding_task: ~10 rows (approximately)
DELETE FROM `tbl_onboarding_task`;
/*!40000 ALTER TABLE `tbl_onboarding_task` DISABLE KEYS */;
INSERT INTO `tbl_onboarding_task` (`Id`, `UniqueEmailId`, `EmailId`, `ClientNumber`, `EmailSubject`, `EmailContent`, `EmailAttachment`, `IsMappedToTask`, `IsActive`, `IsProcessed`, `RefNumber`, `Version`, `TaskAttachement`, `TaskComments`, `CreatedDate`, `CreatedBy`, `TaskAssignedBy`, `TaskAssignedDate`, `LastModifiedDate`, `LastModifiedBy`, `Res1`, `Res2`, `Res3`, `Res4`, `Res5`, `Res6`, `Res7`, `Res8`, `Res9`, `Res10`) VALUES
	(23, '<PN1PR01MB01754671E3073D11DDE971C1C48B0@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', '<PN1PR01MB01754671E3073D11DDE971C1C48B0@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', '12453', 'Fw: Test 12453 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color: rgb(0, 0, 0);">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Sunday, August 6, 2017 3:27 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> Test </font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p>testing subjecce</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'new doc 2017-06-06 17.34.40_20170606173456.pdf,', 'Y', 'Y', 'N', '1', '1', 'test desjk.txt', NULL, '2017-08-09 00:00:00', 'savvyjayakumar@outlook.com', NULL, '2017-08-10 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(24, '<PN1PR01MB017552B43CF87F60003D9972C4890@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', 'savvyjayakumar@outlook.com', '34121', 'Fw: Test 34121 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p>testing</p>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'new doc 2017-06-06 17.34.40_20170606173456.pdf,', 'Y', 'Y', 'N', '1', '2', NULL, NULL, '2017-08-11 00:00:00', 'savvyjayakumar@outlook.com', NULL, '2017-08-11 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(26, '<PN1PR01MB01759455E412C6E3B29C926EC4890@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', 'savvyjayakumar@outlook.com', '1234567', '1234567 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p>jay test</p>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'Custom Report Pending point Status till 8 Aug_Customer care Inbound.xlsx,', 'Y', 'Y', 'N', '1', '1', NULL, NULL, '2017-08-11 00:00:00', 'savvyjayakumar@outlook.com', NULL, '2017-08-11 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(27, '<PN1PR01MB017575A87BFFDEC39D2A5F71C4890@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', 'savvyjayakumar@outlook.com', '1234567', 'Fw: 1234567 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color: rgb(0, 0, 0);">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:24 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> 1234567</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p>jay test</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'cobasclientschema.sql,', 'Y', 'Y', 'N', '1', '2', NULL, NULL, '2017-08-11 00:00:00', 'savvyjayakumar@outlook.com', NULL, '2017-08-11 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(28, '<PN1PR01MB017551FBE17EF2BAF90E8B46C4890@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', 'savvyjayakumar@outlook.com', '12345678', 'Fw: 12345678 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color: rgb(0, 0, 0);">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:28 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> Fw: 1234567</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color:rgb(0,0,0)">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:24 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> 1234567</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p>jay test</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'cobasclientschema.sql,', 'Y', 'Y', 'N', '1', '1', NULL, NULL, '2017-08-11 00:00:00', 'savvyjayakumar@outlook.com', NULL, '2017-08-11 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(29, '<PN1PR01MB0175C619E763F9EBC54815C7C4890@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', 'savvyjayakumar@outlook.com', '123456789', 'Fw: 123456789 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color: rgb(0, 0, 0);">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:36 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> Fw: 12345678</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color:rgb(0,0,0)">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:28 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> Fw: 1234567</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color:rgb(0,0,0)">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:24 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> 1234567</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p>jay test</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'cobasclientschema.sql,', 'N', 'Y', 'N', NULL, NULL, NULL, NULL, '2017-08-11 00:00:00', 'savvyjayakumar@outlook.com', NULL, '2017-08-11 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(30, '<CAKzhRk1=T=3ds-A8KLm3xfF814VfqVUHD_qq0auBp9j7cVyKQg@mail.gmail.com>', 'sthirupathikumar@gmail.com', '12131415', '12131415 (Trial Version)', '<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">This is test mail<br clear="all"><div><br></div>-- <br><div class="gmail_signature" data-smartmail="gmail_signature">Regards,<br>Thirupathi<br></div>\r\n</div>\r\n\r\n', 'wr1.doc,', 'N', 'Y', 'N', NULL, NULL, NULL, NULL, '2017-08-15 00:00:00', 'sthirupathikumar@gmail.com', NULL, '2017-08-15 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(31, '<CAE_CuUj7w2h7PNxzOo7xYrqs=6UiZFk1y4vkUONvBJpJABCA6Q@mail.gmail.com>', 'honikeyan@gmail.com', '11111123444', 'Fwd: CLient ID : 11111123444 (Trial Version)', '<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br><div class="gmail_quote">---------- Forwarded message ----------<br>From: <b class="gmail_sendername">Kar A</b> <span dir="ltr">&lt;<a href="mailto:honikeyan@gmail.com">honikeyan@gmail.com</a>&gt;</span><br>Date: Tue, Aug 15, 2017 at 10:46 PM<br>Subject: CLient ID : 11111123444<br>To: <a href="mailto:savvjayakumar@outlook.com">savvjayakumar@outlook.com</a><br><br><br><div dir="ltr"><br></div>\r\n</div><br></div>\r\n\r\n', 'Test mail.pptx,', 'N', 'Y', 'N', NULL, NULL, NULL, NULL, '2017-08-15 00:00:00', 'honikeyan@gmail.com', NULL, '2017-08-15 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(32, '<CAE_CuUiD53MgG40dqChegQgcU-ue56irYQUR_bwFcErCTEwKOw@mail.gmail.com>', 'honikeyan@gmail.com', '11111123444', 'Fwd: CLient ID : 11111123444 (Trial Version)', '<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br><div class="gmail_quote">---------- Forwarded message ----------<br>From: <b class="gmail_sendername">Kar A</b> <span dir="ltr">&lt;<a href="mailto:honikeyan@gmail.com">honikeyan@gmail.com</a>&gt;</span><br>Date: Tue, Aug 15, 2017 at 10:58 PM<br>Subject: CLient ID : 11111123444<br>To: <a href="mailto:savvjayakumar@outlook.com">savvjayakumar@outlook.com</a><br><br><br><div dir="ltr"><br></div>\r\n</div><br></div>\r\n\r\n', 'Test mail_new.pptx,', 'Y', 'Y', 'N', '12', NULL, NULL, NULL, '2017-08-15 00:00:00', 'honikeyan@gmail.com', NULL, '2017-08-15 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(33, '<CAE_CuUi6iNDkHPbd-p4ctE7EYNfvu115b7MYNQeXMgxaxXQDEQ@mail.gmail.com>', 'honikeyan@gmail.com', '11111123444', 'Fwd: CLient ID : 11111123444 (Trial Version)', '<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br><div class="gmail_quote">---------- Forwarded message ----------<br>From: <b class="gmail_sendername">Kar A</b> <span dir="ltr">&lt;<a href="mailto:honikeyan@gmail.com">honikeyan@gmail.com</a>&gt;</span><br>Date: Tue, Aug 15, 2017 at 10:46 PM<br>Subject: CLient ID : 11111123444<br>To: <a href="mailto:savvjayakumar@outlook.com">savvjayakumar@outlook.com</a><br><br><br><div dir="ltr"><br></div>\r\n</div><br></div>\r\n\r\n', 'Test mail.pptx,', 'Y', 'Y', 'N', '5', NULL, NULL, NULL, '2017-08-15 00:00:00', 'honikeyan@gmail.com', NULL, '2017-08-15 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_onboarding_task` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_producttypemaster
CREATE TABLE IF NOT EXISTS `tbl_producttypemaster` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ProductType` varchar(50) DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_producttypemaster: ~2 rows (approximately)
DELETE FROM `tbl_producttypemaster`;
/*!40000 ALTER TABLE `tbl_producttypemaster` DISABLE KEYS */;
INSERT INTO `tbl_producttypemaster` (`Id`, `ProductType`) VALUES
	(1, 'product7'),
	(2, 'product2');
/*!40000 ALTER TABLE `tbl_producttypemaster` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_region_master
CREATE TABLE IF NOT EXISTS `tbl_region_master` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RegionName` varchar(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_region_master: ~2 rows (approximately)
DELETE FROM `tbl_region_master`;
/*!40000 ALTER TABLE `tbl_region_master` DISABLE KEYS */;
INSERT INTO `tbl_region_master` (`Id`, `RegionName`) VALUES
	(1, 'Region2'),
	(2, 'Region1');
/*!40000 ALTER TABLE `tbl_region_master` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_right_master
CREATE TABLE IF NOT EXISTS `tbl_right_master` (
  `id` int(11) DEFAULT NULL,
  `RightID` int(11) DEFAULT NULL,
  `RightName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `MenuName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Path` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Icon` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ShowMenu` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_right_master: ~33 rows (approximately)
DELETE FROM `tbl_right_master`;
/*!40000 ALTER TABLE `tbl_right_master` DISABLE KEYS */;
INSERT INTO `tbl_right_master` (`id`, `RightID`, `RightName`, `MenuName`, `Path`, `Icon`, `ShowMenu`) VALUES
	(1, 1, 'User Management Read', 'User Management', 'UserManagement', 'fa fa-users', 'true'),
	(2, 2, 'User Management Write', 'User Management', 'UserManagement', 'fa fa-users', 'true'),
	(3, 3, 'Role Management Read', 'Role Management', 'RoleManagement', 'fa fa-list-alt', 'true'),
	(4, 4, 'Role Management Write', 'Role Management', 'RoleManagement', 'fa fa-list-alt', 'true'),
	(5, 5, 'Dashboard Read', 'Dashboard', 'Index', 'fa fa-list-alt', 'true'),
	(6, 7, 'Dashboard Write', 'Dashboard', 'Index', 'fa fa-list-alt', 'true'),
	(7, 8, 'Application Read', 'Application Management', 'Strategy', 'fa fa-list-alt', 'true'),
	(8, 9, 'Application Write', 'Application Management', 'Strategy', 'fa fa-list-alt', 'true'),
	(9, 10, 'Map Strategy Read', 'Map Strategy', 'MapTask', 'fa fa-list-alt', 'true'),
	(10, 11, 'Map Strategy  Write', 'Map Strategy', 'MapTask', 'fa fa-list-alt', 'true'),
	(11, 12, 'Change Management Read', 'Change Management', 'Tasks', 'fa fa-list-alt', 'true'),
	(12, 13, 'Change Management Write', 'Change Management', 'Tasks', 'fa fa-list-alt', 'true'),
	(13, 14, 'Approvals Read', 'Approvals Management', 'Approvals', 'fa fa-list-alt', 'true'),
	(14, 15, 'Approvals Write', 'Approvals Management', 'Approvals', 'fa fa-list-alt', 'true'),
	(15, 16, 'Transfer Settings Read', 'Transfer Settings', 'TransferSettings', 'fa fa-list-alt', 'true'),
	(16, 17, 'Transfer Settings Write', 'Transfer Settings', 'TransferSettings', 'fa fa-list-alt', 'true'),
	(17, 18, 'Email Read', 'Email', 'Emails', 'fa fa-list-alt', 'true'),
	(18, 19, 'Email Write', 'Email', 'Emails', 'fa fa-list-alt', 'true'),
	(19, 20, 'Reports', 'Reports', 'Reports', 'fa fa-list-alt', 'true'),
	(20, 21, 'Licensing Read', 'Licensing', 'Licensing', 'fa fa-list-alt', 'true'),
	(21, 22, 'Licensing Write', 'Licensing', 'Licensing', 'fa fa-list-alt', 'true'),
	(22, 23, 'Country Read', 'Country', 'Country', 'fa fa-list-alt', 'true'),
	(23, 24, 'Country Write', 'Country', 'Country', 'fa fa-list-alt', 'true'),
	(24, 25, 'Region Read', 'Region', 'Region', 'fa fa-list-alt', 'true'),
	(25, 26, 'Region Write', 'Region', 'Region', 'fa fa-list-alt', 'true'),
	(26, 27, 'Business Sector Write', 'Business Sector', 'BusinessSector', 'fa fa-list-alt', 'true'),
	(27, 28, 'Business Sector  Write', 'Business Sector', 'BusinessSector', 'fa fa-list-alt', 'true'),
	(28, 29, 'Application Master Write', 'Application Master', 'ApplicationMaster', 'fa fa-list-alt', 'true'),
	(29, 30, 'Application Master Write', 'Application Master', 'ApplicationMaster', 'fa fa-list-alt', 'true'),
	(30, 31, 'Product Type Read', 'Product Type', 'ProductType', 'fa fa-list-alt', 'true'),
	(31, 32, 'Product Type Write', 'Product Type', 'ProductType', 'fa fa-list-alt', 'true'),
	(33, 34, 'Utilities', 'Utilities', 'Utilities', 'fa fa-list-alt', 'true'),
	(32, 33, 'Reports', 'Reports', 'Reports', 'fa fa-list-alt', 'true');
/*!40000 ALTER TABLE `tbl_right_master` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_roleright_mapping
CREATE TABLE IF NOT EXISTS `tbl_roleright_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `RoleID` int(11) DEFAULT NULL,
  `RightID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_roleright_mapping: ~33 rows (approximately)
DELETE FROM `tbl_roleright_mapping`;
/*!40000 ALTER TABLE `tbl_roleright_mapping` DISABLE KEYS */;
INSERT INTO `tbl_roleright_mapping` (`id`, `RoleID`, `RightID`) VALUES
	(17, 2, 17),
	(18, 2, 18),
	(19, 2, 1),
	(20, 2, 3),
	(21, 2, 2),
	(22, 2, 4),
	(23, 2, 5),
	(24, 2, 7),
	(25, 2, 8),
	(26, 2, 9),
	(27, 2, 10),
	(28, 2, 11),
	(29, 2, 12),
	(30, 2, 13),
	(31, 2, 14),
	(32, 2, 15),
	(33, 2, 16),
	(34, 2, 19),
	(35, 2, 20),
	(36, 2, 21),
	(37, 2, 22),
	(38, 2, 23),
	(39, 2, 24),
	(40, 2, 25),
	(41, 2, 26),
	(42, 2, 27),
	(43, 2, 28),
	(44, 2, 29),
	(45, 2, 30),
	(46, 2, 31),
	(47, 2, 32),
	(48, 2, 34),
	(49, 2, 33);
/*!40000 ALTER TABLE `tbl_roleright_mapping` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_role_master
CREATE TABLE IF NOT EXISTS `tbl_role_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `ModifiedBy` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_role_master: ~1 rows (approximately)
DELETE FROM `tbl_role_master`;
/*!40000 ALTER TABLE `tbl_role_master` DISABLE KEYS */;
INSERT INTO `tbl_role_master` (`id`, `RoleName`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`) VALUES
	(2, 'Super User', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_role_master` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_strategy
CREATE TABLE IF NOT EXISTS `tbl_strategy` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RefNumber` varchar(30) NOT NULL,
  `Name` varchar(300) DEFAULT NULL,
  `Type` int(3) NOT NULL,
  `ApplicationName` varchar(250) NOT NULL,
  `ApplicationId` varchar(30) NOT NULL,
  `BusinessSector` varchar(250) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `Region` varchar(50) NOT NULL,
  `ProductType` varchar(50) NOT NULL,
  `Ranking` varchar(50) NOT NULL,
  `Objective` text NOT NULL,
  `Description` text NOT NULL,
  `RiskRating` varchar(250) NOT NULL,
  `BusinessImpact` varchar(250) NOT NULL,
  `ExchangeDetails` varchar(250) NOT NULL,
  `DetailsOfChanges` text,
  `ChangesBusinessImpact` varchar(250) DEFAULT NULL,
  `SupportingDocument` varchar(750) DEFAULT NULL,
  `DateChangeInitiated` datetime DEFAULT NULL,
  `DateChangeImplemented` datetime DEFAULT NULL,
  `ChangesCompletionStatus` int(3) DEFAULT NULL,
  `AdditionalParam1` varchar(100) NOT NULL,
  `AdditionalParam2` varchar(100) NOT NULL,
  `AdditionalParam3` varchar(100) NOT NULL,
  `AdditionalParam4` varchar(100) NOT NULL,
  `AdditionalParam5` varchar(100) NOT NULL,
  `AdditionalParam6` varchar(100) NOT NULL,
  `AdditionalParam7` varchar(100) NOT NULL,
  `AdditionalParam8` varchar(100) NOT NULL,
  `AdditionalParam9` varchar(100) NOT NULL,
  `AdditionalParam10` varchar(100) NOT NULL,
  `AdditionalParam11` varchar(100) NOT NULL,
  `AdditionalParam12` varchar(100) NOT NULL,
  `AdditionalParam13` varchar(100) NOT NULL,
  `Attribute1` varchar(100) DEFAULT NULL,
  `Attribute2` varchar(100) DEFAULT NULL,
  `Attribute3` varchar(100) DEFAULT NULL,
  `Attribute4` varchar(100) DEFAULT NULL,
  `NoOfApprover` int(3) DEFAULT NULL,
  `Version` int(3) NOT NULL,
  `FinalSignOff` varchar(1) DEFAULT NULL,
  `SignOffDate` datetime DEFAULT NULL,
  `SignoffBy` varchar(100) DEFAULT NULL,
  `IsActive` varchar(1) NOT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `LastModifiedDate` datetime DEFAULT NULL,
  `LastModifiedBy` varchar(100) DEFAULT NULL,
  `Res1` varchar(250) DEFAULT NULL,
  `Res2` varchar(250) DEFAULT NULL,
  `Res3` varchar(250) DEFAULT NULL,
  `Res4` varchar(250) DEFAULT NULL,
  `Res5` varchar(250) DEFAULT NULL,
  `Res6` varchar(250) DEFAULT NULL,
  `Res7` varchar(250) DEFAULT NULL,
  `Res8` varchar(250) DEFAULT NULL,
  `Res9` varchar(250) DEFAULT NULL,
  `Res10` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Id`,`RefNumber`,`Version`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_strategy: ~2 rows (approximately)
DELETE FROM `tbl_strategy`;
/*!40000 ALTER TABLE `tbl_strategy` DISABLE KEYS */;
INSERT INTO `tbl_strategy` (`Id`, `RefNumber`, `Name`, `Type`, `ApplicationName`, `ApplicationId`, `BusinessSector`, `Country`, `Region`, `ProductType`, `Ranking`, `Objective`, `Description`, `RiskRating`, `BusinessImpact`, `ExchangeDetails`, `DetailsOfChanges`, `ChangesBusinessImpact`, `SupportingDocument`, `DateChangeInitiated`, `DateChangeImplemented`, `ChangesCompletionStatus`, `AdditionalParam1`, `AdditionalParam2`, `AdditionalParam3`, `AdditionalParam4`, `AdditionalParam5`, `AdditionalParam6`, `AdditionalParam7`, `AdditionalParam8`, `AdditionalParam9`, `AdditionalParam10`, `AdditionalParam11`, `AdditionalParam12`, `AdditionalParam13`, `Attribute1`, `Attribute2`, `Attribute3`, `Attribute4`, `NoOfApprover`, `Version`, `FinalSignOff`, `SignOffDate`, `SignoffBy`, `IsActive`, `CreatedDate`, `CreatedBy`, `LastModifiedDate`, `LastModifiedBy`, `Res1`, `Res2`, `Res3`, `Res4`, `Res5`, `Res6`, `Res7`, `Res8`, `Res9`, `Res10`) VALUES
	(10, '1', 'name', 1, 'app', 'Appid', 'bs', 'country', 'region', 'product', 'sr', 'obj', 'des', 'rr', '11', 'ed', 'detail', NULL, NULL, NULL, NULL, NULL, '1', 'ap1', '1', '1', '1', '1', '11', '11', '1', '11', '1', '1', '1', '1', '3', '2', '4', NULL, 1, NULL, NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(11, '1', 'name', 1, 'app', 'Appid', 'bs', 'country', 'region', 'product', 'sr', 'obj', 'des', 'rr', '11', 'ed', NULL, NULL, NULL, NULL, NULL, NULL, '1', 'ap1', '1', '1', '1', '1', '11', '11', '1', '11', '1', '1', '1', '1', '3', '2', '4', NULL, 2, NULL, NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_strategy` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_strategyapproval
CREATE TABLE IF NOT EXISTS `tbl_strategyapproval` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `RefNumber` varchar(50) DEFAULT '0',
  `Version` varchar(50) DEFAULT '0',
  `Approver` varchar(50) DEFAULT '0',
  `Comments` varchar(50) DEFAULT '0',
  `ApprovedDate` varchar(50) DEFAULT '0',
  `Status` varchar(50) DEFAULT '0',
  `ActionStatus` varchar(50) DEFAULT '0',
  `IsActive` varchar(50) DEFAULT NULL,
  `IsTransfered` varchar(50) DEFAULT NULL,
  `IsViewed` varchar(50) DEFAULT NULL,
  `IsModified` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_strategyapproval: ~11 rows (approximately)
DELETE FROM `tbl_strategyapproval`;
/*!40000 ALTER TABLE `tbl_strategyapproval` DISABLE KEYS */;
INSERT INTO `tbl_strategyapproval` (`Id`, `RefNumber`, `Version`, `Approver`, `Comments`, `ApprovedDate`, `Status`, `ActionStatus`, `IsActive`, `IsTransfered`, `IsViewed`, `IsModified`) VALUES
	(49, '1', '1', 'George', 'Test', '0', 'Y', 'N', 'N', 'N', 'N', NULL),
	(50, '1', '1', 'John', 'Testing', '0', 'N', 'N', 'Y', 'George', 'N', 'N'),
	(51, '1', '1', 'Sivakumar', 'siva testing', '0', 'Y', 'N', 'Y', 'N', 'N', 'N'),
	(52, '1', '1', 'Oliver', '0', '0', '0', 'N', 'Y', 'N', 'N', 'N'),
	(59, '1', '1', 'Daniel', '0', '0', '0', 'N', 'Y', 'N', 'N', 'N'),
	(60, '1', '2', 'John', '0', '0', '0', '0', 'Y', 'N', 'N', NULL),
	(61, '1', '2', 'Sivakumar', '0', '0', '0', '0', 'N', 'N', 'N', NULL),
	(62, '1', '2', 'Oliver', '0', '0', '0', '0', 'Y', 'N', 'N', NULL),
	(63, '1', '2', 'Daniel', '0', '0', '0', '0', 'Y', 'N', 'N', NULL),
	(64, '1', '1', 'George', '0', '0', '0', '0', 'Y', 'N', 'N', 'N'),
	(65, '1', '2', 'George', '0', '0', '0', '0', 'Y', 'N', 'N', NULL);
/*!40000 ALTER TABLE `tbl_strategyapproval` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_task
CREATE TABLE IF NOT EXISTS `tbl_task` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(500) NOT NULL,
  `Description` varchar(3000) DEFAULT NULL,
  `IsSignOff` varchar(1) NOT NULL,
  `SignOffDate` datetime DEFAULT NULL,
  `SignoffBy` varchar(100) DEFAULT NULL,
  `IsActive` varchar(1) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` varchar(100) NOT NULL,
  `LastModifiedDate` datetime NOT NULL,
  `LastModifiedBy` varchar(100) NOT NULL,
  `Res1` varchar(250) DEFAULT NULL,
  `Res2` varchar(250) DEFAULT NULL,
  `Res3` varchar(250) DEFAULT NULL,
  `Res4` varchar(250) DEFAULT NULL,
  `Res5` varchar(250) DEFAULT NULL,
  `Res6` varchar(250) DEFAULT NULL,
  `Res7` varchar(250) DEFAULT NULL,
  `Res8` varchar(250) DEFAULT NULL,
  `Res9` varchar(250) DEFAULT NULL,
  `Res10` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IDX_Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_task: ~0 rows (approximately)
DELETE FROM `tbl_task`;
/*!40000 ALTER TABLE `tbl_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_task` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_transfersetting
CREATE TABLE IF NOT EXISTS `tbl_transfersetting` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Owneruser` varchar(50) DEFAULT NULL,
  `TransferTo` varchar(50) DEFAULT NULL,
  `DurationFrom` varchar(50) DEFAULT NULL,
  `DurationTo` varchar(50) DEFAULT NULL,
  `IsActive` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_transfersetting: ~4 rows (approximately)
DELETE FROM `tbl_transfersetting`;
/*!40000 ALTER TABLE `tbl_transfersetting` DISABLE KEYS */;
INSERT INTO `tbl_transfersetting` (`Id`, `Owneruser`, `TransferTo`, `DurationFrom`, `DurationTo`, `IsActive`) VALUES
	(1, 'John', '09/22/2017', '09/12/2017', '09/22/2017', 'N'),
	(2, 'John', '09/22/2017', '09/12/2017', '09/22/2017', 'N'),
	(3, 'John', 'George', '09/12/2017', '09/22/2017', 'N'),
	(4, 'John', 'Sivakumar', '09/17/2017', '09/29/2017', 'Y');
/*!40000 ALTER TABLE `tbl_transfersetting` ENABLE KEYS */;

-- Dumping structure for table achi.tbl_user_master
CREATE TABLE IF NOT EXISTS `tbl_user_master` (
  `Userid` varchar(255) CHARACTER SET utf8 NOT NULL,
  `UserName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `BusinessSectorId` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `RoleId` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `UserImage` longblob,
  `Password` varchar(4000) CHARACTER SET utf8 DEFAULT NULL,
  `EmailId` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `MobileNumber` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `CustomData` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Status` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `UserExpiryDate` datetime DEFAULT NULL,
  `PasswordExpiryDate` datetime DEFAULT NULL,
  `UserBlockDate` datetime DEFAULT NULL,
  `AttemptTries` int(11) DEFAULT NULL,
  `LastAuthenticatedDate` datetime DEFAULT NULL,
  `LastUsedDate` datetime DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `ModifiedBy` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ApprovedDate` datetime DEFAULT NULL,
  `Approvedby` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `MakerComment` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `CheckerComment` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `IsADUser` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `RegionId` int(11) DEFAULT NULL,
  `CountryId` int(11) DEFAULT NULL,
  `FirstWorkingDate` datetime DEFAULT NULL,
  `LastWorkingDate` datetime DEFAULT NULL,
  `LocationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table achi.tbl_user_master: ~2 rows (approximately)
DELETE FROM `tbl_user_master`;
/*!40000 ALTER TABLE `tbl_user_master` DISABLE KEYS */;
INSERT INTO `tbl_user_master` (`Userid`, `UserName`, `BusinessSectorId`, `RoleId`, `UserImage`, `Password`, `EmailId`, `MobileNumber`, `CustomData`, `Status`, `UserExpiryDate`, `PasswordExpiryDate`, `UserBlockDate`, `AttemptTries`, `LastAuthenticatedDate`, `LastUsedDate`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `ApprovedDate`, `Approvedby`, `MakerComment`, `CheckerComment`, `IsADUser`, `RegionId`, `CountryId`, `FirstWorkingDate`, `LastWorkingDate`, `LocationId`) VALUES
	('Michael', NULL, '1', '2', NULL, 'd2VsY29tZQ==', 'Michael@coba.com', NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 2, 1, NULL, NULL, NULL),
	('Sivakumar', 'SivaKumar', '1', '2', NULL, NULL, 'Sivakumar@coba.com', NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 1, 2, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_user_master` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

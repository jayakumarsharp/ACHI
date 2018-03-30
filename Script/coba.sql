-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.21-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for coba
DROP DATABASE IF EXISTS `coba`;
CREATE DATABASE IF NOT EXISTS `coba` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `coba`;

-- Dumping structure for procedure coba.delete_clientTask
DROP PROCEDURE IF EXISTS `delete_clientTask`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_clientTask`(
	IN `i_id` INT

)
BEGIN
delete from tbl_clienttask_mapping where ClientNumber=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure coba.delete_RoleRight
DROP PROCEDURE IF EXISTS `delete_RoleRight`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_RoleRight`(
	IN `i_roleid` INT


)
BEGIN
delete from tbl_roleright_mapping where RoleID=i_roleid;

END//
DELIMITER ;

-- Dumping structure for procedure coba.delete_userBusinessSector
DROP PROCEDURE IF EXISTS `delete_userBusinessSector`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_userBusinessSector`(
	IN `i_userid` VARCHAR(250)
)
BEGIN
delete from tbl_userBusinessSectormapping where Userid=i_userid;

END//
DELIMITER ;

-- Dumping structure for procedure coba.delete_usercountry
DROP PROCEDURE IF EXISTS `delete_usercountry`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_usercountry`(
	IN `i_userid` VARCHAR(250)
)
BEGIN
delete from tbl_usercountrymapping where Userid=i_userid;

END//
DELIMITER ;

-- Dumping structure for procedure coba.delete_userregion
DROP PROCEDURE IF EXISTS `delete_userregion`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_userregion`(
	IN `i_userid` VARCHAR(250)
)
BEGIN
delete from tbl_userregionmapping where Userid=i_userid;

END//
DELIMITER ;

-- Dumping structure for procedure coba.get_emailtaskmapclient
DROP PROCEDURE IF EXISTS `get_emailtaskmapclient`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emailtaskmapclient`(
	IN `i_type` VARCHAR(50)


)
BEGIN
if(i_type='Y') then
select c.Id,c.ClientNumber,GROUP_CONCAT(t.Name) Name,GROUP_CONCAT(ct.TaskId) taskid from tbl_client c left join tbl_clienttask_mapping ct on c.ClientNumber=ct.ClientNumber
left join tbl_task  t on t.Id=ct.TaskId
where c.IsMappedToTask=i_type
Group by c.ClientNumber ; 
else
select c.Id,c.ClientNumber,GROUP_CONCAT(t.Name) Name,GROUP_CONCAT(ct.TaskId) taskid from tbl_client c left join tbl_clienttask_mapping ct on c.ClientNumber=ct.ClientNumber
left join tbl_task  t on t.Id=ct.TaskId
where c.IsMappedToTask!='Y' or c.IsMappedToTask is null 
Group by c.ClientNumber ; 
end if;
END//
DELIMITER ;

-- Dumping structure for procedure coba.Get_Mapped_Mail_Task
DROP PROCEDURE IF EXISTS `Get_Mapped_Mail_Task`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_Mapped_Mail_Task`(
	IN `i_tasktype` VARCHAR(5)







)
BEGIN

select ot.Id, ot.UniqueEmailId, ot.EmailId, ot.ClientNumber, ot.EmailSubject, ot.EmailContent, ot.EmailAttachment, ot.IsMappedToTask, 
ot.IsActive, ot.IsProcessed, GROUP_CONCAT(t.Name) Name,GROUP_CONCAT(ct.TaskId)TaskId, ot.TaskAttachement, ot.TaskComments, ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy,
 ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot 
  left outer join tbl_clienttask_mapping ct on ot.id=ct.ClientNumber left join  tbl_task t on ot.TaskId=t.Id 
where ot.IsMappedToTask =i_tasktype and ot.`Type`='EMAIL'
Group by ot.ClientNumber,ot.CreatedDate;

END//
DELIMITER ;

-- Dumping structure for procedure coba.Get_Tasks
DROP PROCEDURE IF EXISTS `Get_Tasks`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_Tasks`()
BEGIN
Select Id,Name,Description,IsSignOff,SignOffDate,SignoffBy,IsActive from tbl_task;
END//
DELIMITER ;

-- Dumping structure for procedure coba.Get_TasksById
DROP PROCEDURE IF EXISTS `Get_TasksById`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_TasksById`(
	IN `TaskId` INT
)
BEGIN
Select Id,Name,Description,IsSignOff,SignOffDate,SignoffBy,IsActive from tbl_task where Id=TaskId; 
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_addbusinessmapping
DROP PROCEDURE IF EXISTS `sp_addbusinessmapping`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addbusinessmapping`(
	IN `i_businesssuffixid` INT,
	IN `i_businessid` INT
,
	OUT `i_OutParam` VARCHAR(50)
)
BEGIN


 IF (SELECT count(*) FROM tbl_businessmapping  WHERE BusinessId=i_BusinessId and BusinessSuffixId=i_BusinessSuffixId) then
 set i_OutParam ='Mapping already exists';
 else
 begin

insert into tbl_businessmapping(BusinessId,BusinessSuffixId) values (i_businessid,i_businesssuffixid);
set i_OutParam ='success';
end;
ENd IF;

END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_AddRole
DROP PROCEDURE IF EXISTS `SP_AddRole`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AddRole`()
BEGIN

END//
DELIMITER ;

-- Dumping structure for procedure coba.Sp_AddRoleRightMapping
DROP PROCEDURE IF EXISTS `Sp_AddRoleRightMapping`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_AddRoleRightMapping`()
BEGIN

END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_adduser
DROP PROCEDURE IF EXISTS `sp_adduser`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_adduser`(
	IN `i_userid` VARCHAR(50),
	IN `i_username` VARCHAR(50),
	IN `i_emailid` VARCHAR(50),
	IN `i_Roleid` VARCHAR(50),
	IN `i_password` VARCHAR(4000),
	IN `i_IsADUser` VARCHAR(50)


)
BEGIN
if(i_IsADUser ='Yes') then
insert into tbl_user_master (Userid,UserName,EmailId,RoleId,Status,IsADUser) values(i_userid,i_username,i_emailid,i_Roleid,'Active',i_IsADUser);
else
insert into tbl_user_master (Userid,UserName,EmailId,RoleId,Status,password,IsADUser) values(i_userid,i_username,i_emailid,i_Roleid,'Active',i_password,i_IsADUser);
end if;
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_delete_BusinessLine
DROP PROCEDURE IF EXISTS `sp_delete_BusinessLine`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_BusinessLine`(
	IN `i_id` INT

)
BEGIN
delete from tbl_BusinessLine_master where id=i_id;
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_delete_BusinessMapping
DROP PROCEDURE IF EXISTS `sp_delete_BusinessMapping`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_BusinessMapping`(
	IN `i_id` INT
,
	OUT `i_OutParam` VARCHAR(50)
)
BEGIN

 IF (SELECT count(*) FROM tbl_strategy  WHERE BusinessMappingId=i_id) then
 set i_OutParam ='Mapping associated to strategy';
 else
 begin
delete from tbl_businessmapping where id =i_id;
set i_OutParam ='success';
end;
ENd IF;


END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_getallBusinessLine
DROP PROCEDURE IF EXISTS `sp_getallBusinessLine`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getallBusinessLine`(
	IN `i_Id` VARCHAR(50)
)
BEGIN


if(i_Id !='') then

select * from tbl_BusinessLine_master where Id=i_id;
else
select * from tbl_BusinessLine_master;
end if;



END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_getallcountry
DROP PROCEDURE IF EXISTS `sp_getallcountry`;
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

-- Dumping structure for procedure coba.sp_getallregion
DROP PROCEDURE IF EXISTS `sp_getallregion`;
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

-- Dumping structure for procedure coba.SP_GetClients
DROP PROCEDURE IF EXISTS `SP_GetClients`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetClients`()
BEGIN
SELECT Id, ClientNumber, InvDevLoan, ObligorName, StrChartAttchd, OriginalLender, LCompanyName, LRegAddressL1, LRegAddressL2, LRegAddressL3, LRegAddressEmail, LRegAddressTelNum, LRegAddressCity, LRegAddressState, LRegAddressCountry, LRegAddressPostCode, LPriAddressL1, LPriAddressL2, LPriAddressL3, LPriAddressEmail, LPriAddressTelNum, LPriAddressCity, LPriAddressState, LPriAddressCountry, LPriAddressPostCode, LKC1L1, LKC1L2, LKC1L3, LKC1Email, LKC1TelNum, LKC1City, LKC1State, LKC1Country, LKC1PostCode, LKC2L1, LKC2L2, LKC2L3, LKC2Email, LKC2TelNum, LKC2City, LKC2State, LKC2Country, LKC2PostCode, LKC3L1, LKC3L2, LKC3L3, LKC3Email, LKC3TelNum, LKC3City, LKC3State, LKC3Country, LKC3PostCode, LKC4L1, LKC4L2, LKC4L3, LKC4Email, LKC4TelNum, LKC4City, LKC4State, LKC4Country, LKC4PostCode, LKC5L1, LKC5L2, LKC5L3, LKC5Email, LKC5TelNum, LKC5City, LKC5State, LKC5Country, LKC5PostCode, BCompanyName, BRegAddressL1, BRegAddressL2, BRegAddressL3, BRegAddressEmail, BRegAddressTelNum, BRegAddressCity, BRegAddressState, BRegAddressCountry, BRegAddressPostCode, BPriAddressL1, BPriAddressL2, BPriAddressL3, BPriAddressEmail, BPriAddressTelNum, BPriAddressCity, BPriAddressState, BPriAddressCountry, BPriAddressPostCode, BKC1L1, BKC1L2, BKC1L3, BKC1Email, BKC1TelNum, BKC1City, BKC1State, BKC1Country, BKC1PostCode, BKC2L1, BKC2L2, BKC2L3, BKC2Email, BKC2TelNum, BKC2City, BKC2State, BKC2Country, BKC2PostCode, BKC3L1, BKC3L2, BKC3L3, BKC3Email, BKC3TelNum, BKC3City, BKC3State, BKC3Country, BKC3PostCode, BKC4L1, BKC4L2, BKC4L3, BKC4Email, BKC4TelNum, BKC4City, BKC4State, BKC4Country, BKC4PostCode, BKC5L1, BKC5L2, BKC5L3, BKC5Email, BKC5TelNum, BKC5City, BKC5State, BKC5Country, BKC5PostCode, ProposedDealCommencementDate, PropAddress1L1, PropAddress1L2, PropAddress1L3, PropAddress1Email, PropAddress1TelNum, PropAddress1City, PropAddress1State, PropAddress1Country, PropAddress1PostCode, PropAddress2L1, PropAddress2L2, PropAddress2L3, PropAddress2Email, PropAddress2TelNum, PropAddress2City, PropAddress2State, PropAddress2Country, PropAddress2PostCode, PropAddress3L1, PropAddress3L2, PropAddress3L3, PropAddress3Email, PropAddress3TelNum, PropAddress3City, PropAddress3State, PropAddress3Country, PropAddress3PostCode, PropAddress4L1, PropAddress4L2, PropAddress4L3, PropAddress4Email, PropAddress4TelNum, PropAddress4City, PropAddress4State, PropAddress4Country, PropAddress4PostCode, PropAddress5L1, PropAddress5L2, PropAddress5L3, PropAddress5Email, PropAddress5TelNum, PropAddress5City, PropAddress5State, PropAddress5Country, PropAddress5PostCode, LoanDateAggrmnt, FirstUtilisationDate, AmountAdvancedonFUD, OriginalCommitmentAmount, FirstInterestPaymentDate, PaymentFrequency, IsSignOff, SignOffDate, SignoffBy, IsActive, CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy FROM TBL_CLIENT;
END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_GetClientsById
DROP PROCEDURE IF EXISTS `SP_GetClientsById`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetClientsById`(
	IN `i_ClientNumber` VARCHAR(250)

)
BEGIN
SELECT Id, ClientNumber, InvDevLoan, ObligorName, StrChartAttchd, OriginalLender, LCompanyName, LRegAddressL1, LRegAddressL2, LRegAddressL3, LRegAddressEmail, LRegAddressTelNum, LRegAddressCity, LRegAddressState, LRegAddressCountry, LRegAddressPostCode, LPriAddressL1, LPriAddressL2, LPriAddressL3, LPriAddressEmail, LPriAddressTelNum, LPriAddressCity, LPriAddressState, LPriAddressCountry, LPriAddressPostCode, LKC1L1, LKC1L2, LKC1L3, LKC1Email, LKC1TelNum, LKC1City, LKC1State, LKC1Country, LKC1PostCode, LKC2L1, LKC2L2, LKC2L3, LKC2Email, LKC2TelNum, LKC2City, LKC2State, LKC2Country, LKC2PostCode, LKC3L1, LKC3L2, LKC3L3, LKC3Email, LKC3TelNum, LKC3City, LKC3State, LKC3Country, LKC3PostCode, LKC4L1, LKC4L2, LKC4L3, LKC4Email, LKC4TelNum, LKC4City, LKC4State, LKC4Country, LKC4PostCode, LKC5L1, LKC5L2, LKC5L3, LKC5Email, LKC5TelNum, LKC5City, LKC5State, LKC5Country, LKC5PostCode, BCompanyName, BRegAddressL1, BRegAddressL2, BRegAddressL3, BRegAddressEmail, BRegAddressTelNum, BRegAddressCity, BRegAddressState, BRegAddressCountry, BRegAddressPostCode, BPriAddressL1, BPriAddressL2, BPriAddressL3, BPriAddressEmail, BPriAddressTelNum, BPriAddressCity, BPriAddressState, BPriAddressCountry, BPriAddressPostCode, BKC1L1, BKC1L2, BKC1L3, BKC1Email, BKC1TelNum, BKC1City, BKC1State, BKC1Country, BKC1PostCode, BKC2L1, BKC2L2, BKC2L3, BKC2Email, BKC2TelNum, BKC2City, BKC2State, BKC2Country, BKC2PostCode, BKC3L1, BKC3L2, BKC3L3, BKC3Email, BKC3TelNum, BKC3City, BKC3State, BKC3Country, BKC3PostCode, BKC4L1, BKC4L2, BKC4L3, BKC4Email, BKC4TelNum, BKC4City, BKC4State, BKC4Country, BKC4PostCode, BKC5L1, BKC5L2, BKC5L3, BKC5Email, BKC5TelNum, BKC5City, BKC5State, BKC5Country, BKC5PostCode, ProposedDealCommencementDate, PropAddress1L1, PropAddress1L2, PropAddress1L3, PropAddress1Email, PropAddress1TelNum, PropAddress1City, PropAddress1State, PropAddress1Country, PropAddress1PostCode, PropAddress2L1, PropAddress2L2, PropAddress2L3, PropAddress2Email, PropAddress2TelNum, PropAddress2City, PropAddress2State, PropAddress2Country, PropAddress2PostCode, PropAddress3L1, PropAddress3L2, PropAddress3L3, PropAddress3Email, PropAddress3TelNum, PropAddress3City, PropAddress3State, PropAddress3Country, PropAddress3PostCode, PropAddress4L1, PropAddress4L2, PropAddress4L3, PropAddress4Email, PropAddress4TelNum, PropAddress4City, PropAddress4State, PropAddress4Country, PropAddress4PostCode, PropAddress5L1, PropAddress5L2, PropAddress5L3, PropAddress5Email, PropAddress5TelNum, PropAddress5City, PropAddress5State, PropAddress5Country, PropAddress5PostCode, LoanDateAggrmnt, DATE_FORMAT(FirstUtilisationDate, '%m/%d/%Y') FirstUtilisationDate, AmountAdvancedonFUD, OriginalCommitmentAmount,  DATE_FORMAT(FirstInterestPaymentDate, '%m/%d/%Y')  FirstInterestPaymentDate, PaymentFrequency, IsSignOff, SignOffDate, SignoffBy, IsActive, DATE_FORMAT(CreatedDate, '%m/%d/%Y')CreatedDate, CreatedBy, LastModifiedDate, LastModifiedBy FROM TBL_CLIENT WHERE ClientNumber=i_ClientNumber;
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_getClientTaskMapping
DROP PROCEDURE IF EXISTS `sp_getClientTaskMapping`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getClientTaskMapping`()
BEGIN

select c.Id,c.ClientNumber,GROUP_CONCAT(t.Name) Name,GROUP_CONCAT(ct.TaskId) taskid from tbl_client c 
left outer join tbl_clienttask_mapping ct on c.ClientNumber=ct.ClientNumber
left join tbl_task  t on t.Id=ct.TaskId

Group by c.ClientNumber ; 

END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_GetMapTask
DROP PROCEDURE IF EXISTS `SP_GetMapTask`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetMapTask`()
BEGIN
select ot.Id, ot.UniqueEmailId, ot.EmailId, ot.ClientNumber, ot.EmailSubject, ot.EmailContent, ot.EmailAttachment, ot.IsMappedToTask, 
ot.IsActive, ot.IsProcessed, ot.TaskId,t.Name, ot.TaskAttachement, ot.TaskComments, ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy,
 ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot 
left outer join tbl_clienttask_mapping ct on ot.id=ct.ClientNumber left join tbl_task  t on t.Id=ct.TaskId 
where ot.`Type`='EMAIL'
Group by ot.ClientNumber,ot.CreatedDate;

END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_GetMapTaskbyId
DROP PROCEDURE IF EXISTS `SP_GetMapTaskbyId`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetMapTaskbyId`(
	IN `i_Id` INT




)
BEGIN
select ot.Id, ot.UniqueEmailId, ot.EmailId, ot.ClientNumber, ot.EmailSubject, ot.EmailContent, ot.EmailAttachment, ot.IsMappedToTask, 
ot.IsActive, ot.IsProcessed, Group_concat(ct.TaskId) TaskId,Group_concat(t.Name) Name, ot.TaskAttachement, ot.TaskComments, ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy,
 ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot 
left outer join tbl_clienttask_mapping ct on ot.id=ct.ClientNumber left join tbl_task  t on t.Id=ct.TaskId 
where ot.`Type`='EMAIL' and ot.Id=i_id
Group by ot.ClientNumber,ot.CreatedDate;

END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_getmenuforuser
DROP PROCEDURE IF EXISTS `sp_getmenuforuser`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getmenuforuser`(
	IN `i_UserId` VARCHAR(50)



)
BEGIN
select distinct MenuName, Path, RM.RightID, RM.ShowMenu, RM.Icon from TBL_RIGHT_MASTER RM inner join TBL_ROLERIGHT_MAPPING RR on RM.RightID=RR.RightID inner join TBL_USER_MASTER UM on RR.RoleID=UM.RoleId where UM.Userid = i_UserId and RM.IsActive='Y' order by RM.RightID;
END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_GetOnboardingTask
DROP PROCEDURE IF EXISTS `SP_GetOnboardingTask`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetOnboardingTask`()
BEGIN
select ot.Id, ot.ClientNumber, GROUP_CONCAT(t.Name) Name,GROUP_CONCAT(ot.TaskId)TaskId, (ot.UniqueEmailId)UniqueEmailId, (ot.EmailId)EmailId, (ot.EmailSubject)EmailSubject, (ot.EmailContent)EmailContent, (ot.EmailAttachment), (ot.IsMappedToTask)IsMappedToTask, (ot.IsActive)IsActive, ot.IsProcessed, ot.TaskAttachement, ot.TaskComments, 
ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy, ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot
left outer join tbl_clienttask_mapping ct on ot.id=ct.ClientNumber left join tbl_task  t on t.Id=ct.TaskId 
Group by ot.ClientNumber,ot.CreatedDate;
END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_GetOnboardingTaskbyId
DROP PROCEDURE IF EXISTS `SP_GetOnboardingTaskbyId`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetOnboardingTaskbyId`(
	IN `i_Id` INT


)
BEGIN

select ot.Id, ot.UniqueEmailId, ot.EmailId, ot.ClientNumber, ot.EmailSubject, ot.EmailContent, ot.EmailAttachment, ot.IsMappedToTask, 
ot.IsActive, ot.IsProcessed, ot.TaskId,t.Name, ot.TaskAttachement, ot.TaskComments, ot.CreatedDate, ot.CreatedBy, ot.TaskAssignedBy,
 ot.TaskAssignedDate, ot.LastModifiedDate, ot.LastModifiedBy  from tbl_onboarding_task ot left join tbl_task t on ot.TaskId=t.Id 
Where ot.Id=i_Id;
END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_GetRightForUser
DROP PROCEDURE IF EXISTS `SP_GetRightForUser`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRightForUser`(
	IN `i_userid` VARCHAR(50)
)
BEGIN

select distinct RightName, Path from TBL_RIGHT_MASTER RM inner join TBL_ROLERIGHT_MAPPING RR on RM.RightID=RR.RightID inner join TBL_USER_MASTER UM on RR.RoleID=UM.RoleId where UM.Userid = i_userid;
END//
DELIMITER ;

-- Dumping structure for procedure coba.Sp_GetRights
DROP PROCEDURE IF EXISTS `Sp_GetRights`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_GetRights`(
	IN `i_roleid` VARCHAR(50)



)
BEGIN

if(i_roleid!='') then
Select * from tbl_right_master where RightId=i_roleid  and Isactive='Y';
else
Select * from tbl_right_master where  Isactive='Y';
end if;
END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_GetRoleRights
DROP PROCEDURE IF EXISTS `SP_GetRoleRights`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRoleRights`(
	IN `i_roleId` INT
)
BEGIN
select * from tbl_roleright_mapping where roleId=i_roleId;
END//
DELIMITER ;

-- Dumping structure for procedure coba.Sp_GetRoles
DROP PROCEDURE IF EXISTS `Sp_GetRoles`;
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

-- Dumping structure for procedure coba.Sp_getRolesbyuserassigned
DROP PROCEDURE IF EXISTS `Sp_getRolesbyuserassigned`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_getRolesbyuserassigned`(
	IN `i_roleid` VARCHAR(50)

)
BEGIN
select u.Userid,u.UserName,u.EmailId,u.RegionId,r.RegionName,u.CountryId,c.CountryName,u.BusinessSectorId,b.Name,u.RoleId,rm.RoleName,u.Status from tbl_user_master u join tbl_businesssector b on u.BusinessSectorId=b.Id join tbl_region_master r  on u.RegionId=r.Id join tbl_country_master c  on u.CountryId=c.id join tbl_role_master rm on u.RoleId=rm.Id
where u.RoleId=i_roleid;

END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_GetuserBusinessSector
DROP PROCEDURE IF EXISTS `SP_GetuserBusinessSector`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetuserBusinessSector`(
	IN `i_userid` VARCHAR(250)


)
BEGIN
select b.Id,b.BusinessLine from tbl_userBusinessSectormapping bs join tbl_businessLine_master b  on bs.BusinessSectorId =b.Id where Userid=i_userid;
END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_Getusercountry
DROP PROCEDURE IF EXISTS `SP_Getusercountry`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Getusercountry`(
	IN `i_userid` VARCHAR(250)
)
BEGIN
select c.id,c.CountryName from tbl_usercountrymapping uc join tbl_country_master c on uc.CountryId = c.id where Userid=i_userid;
END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_Getuserregion
DROP PROCEDURE IF EXISTS `SP_Getuserregion`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Getuserregion`(
	IN `i_userid` VARCHAR(250)
)
BEGIN
select r.Id,r.RegionName from tbl_userregionmapping rm join tbl_region_master r on rm.RegionId = r.Id where Userid=i_userid;
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_getusers
DROP PROCEDURE IF EXISTS `sp_getusers`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getusers`(
	IN `i_userid` VARCHAR(50)




)
BEGIN

if(i_userid ='') then
select u.Id,u.Userid,u.UserName,u.EmailId,u.RoleId,rm.RoleName,u.Status,u.Password,u.IsADUser from tbl_user_master u join tbl_role_master rm on u.RoleId=rm.Id;
else
select u.Id,u.Userid,u.UserName,u.EmailId,u.RoleId,rm.RoleName,u.Status,u.Password,u.IsADUser from tbl_user_master u 
join tbl_role_master rm on u.RoleId=rm.Id  where u.userid=i_userid;
end if;


END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_getusersbycondition
DROP PROCEDURE IF EXISTS `sp_getusersbycondition`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getusersbycondition`(
	IN `i_regionId` VARCHAR(50),
	IN `i_businesssectorId` VARCHAR(50)


)
BEGIN
select u.Id,u.Userid,u.UserName,u.EmailId,u.RegionId,r.RegionName,u.BusinessSectorId,
b.BusinessLine,u.RoleId,rm.RoleName,u.Status from tbl_user_master u 
Join tbl_userbusinesssectormapping ubu on ubu.userid=u.Userid
Join tbl_userregionmapping ur on ur.userid=u.Userid
join tbl_businessline_master b on ubu.BusinessSectorId=b.Id 
join tbl_region_master r  on ur.RegionId=r.Id join tbl_role_master rm on u.RoleId=rm.Id  
where ur.RegionId=i_regionId and ubu.BusinessSectorId=i_businesssectorId;
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_insert_BusinessLine
DROP PROCEDURE IF EXISTS `sp_insert_BusinessLine`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_BusinessLine`(
	IN `i_BusinessLine` VARCHAR(50)


)
BEGIN

insert into tbl_BusinessLine_master (BusinessLine) values(i_BusinessLine);

END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_insert_Client
DROP PROCEDURE IF EXISTS `sp_insert_Client`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_Client`(
	IN `i_ClientNumber` VARCHAR(250),
	IN `i_InvDevLoan` VARCHAR(250),
	IN `i_ObligorName` VARCHAR(250),
	IN `i_StrChartAttchd` VARCHAR(250),
	IN `i_OriginalLender` VARCHAR(250),
	IN `i_LCompanyName` VARCHAR(250),
	IN `i_LRegAddressL1` VARCHAR(250),
	IN `i_LRegAddressL2` VARCHAR(250),
	IN `i_LRegAddressL3` VARCHAR(250),
	IN `i_LRegAddressEmail` VARCHAR(250),
	IN `i_LRegAddressTelNum` VARCHAR(250),
	IN `i_LRegAddressCity` VARCHAR(250),
	IN `i_LRegAddressState` VARCHAR(250),
	IN `i_LRegAddressCountry` VARCHAR(250),
	IN `i_LRegAddressPostCode` VARCHAR(250),
	IN `i_LPriAddressL1` VARCHAR(250),
	IN `i_LPriAddressL2` VARCHAR(250),
	IN `i_LPriAddressL3` VARCHAR(250),
	IN `i_LPriAddressEmail` VARCHAR(250),
	IN `i_LPriAddressTelNum` VARCHAR(250),
	IN `i_LPriAddressCity` VARCHAR(250),
	IN `i_LPriAddressState` VARCHAR(250),
	IN `i_LPriAddressCountry` VARCHAR(250),
	IN `i_LPriAddressPostCode` VARCHAR(250),
	IN `i_LKC1L1` VARCHAR(250),
	IN `i_LKC1L2` VARCHAR(250),
	IN `i_LKC1L3` VARCHAR(250),
	IN `i_LKC1Email` VARCHAR(250),
	IN `i_LKC1TelNum` VARCHAR(250),
	IN `i_LKC1City` VARCHAR(250),
	IN `i_LKC1State` VARCHAR(250),
	IN `i_LKC1Country` VARCHAR(250),
	IN `i_LKC1PostCode` VARCHAR(250),
	IN `i_LKC2L1` VARCHAR(250),
	IN `i_LKC2L2` VARCHAR(250),
	IN `i_LKC2L3` VARCHAR(250),
	IN `i_LKC2Email` VARCHAR(250),
	IN `i_LKC2TelNum` VARCHAR(250),
	IN `i_LKC2City` VARCHAR(250),
	IN `i_LKC2State` VARCHAR(250),
	IN `i_LKC2Country` VARCHAR(250),
	IN `i_LKC2PostCode` VARCHAR(250),
	IN `i_LKC3L1` VARCHAR(250),
	IN `i_LKC3L2` VARCHAR(250),
	IN `i_LKC3L3` VARCHAR(250),
	IN `i_LKC3Email` VARCHAR(250),
	IN `i_LKC3TelNum` VARCHAR(250),
	IN `i_LKC3City` VARCHAR(250),
	IN `i_LKC3State` VARCHAR(250),
	IN `i_LKC3Country` VARCHAR(250),
	IN `i_LKC3PostCode` VARCHAR(250),
	IN `i_LKC4L1` VARCHAR(250),
	IN `i_LKC4L2` VARCHAR(250),
	IN `i_LKC4L3` VARCHAR(250),
	IN `i_LKC4Email` VARCHAR(250),
	IN `i_LKC4TelNum` VARCHAR(250),
	IN `i_LKC4City` VARCHAR(250),
	IN `i_LKC4State` VARCHAR(250),
	IN `i_LKC4Country` VARCHAR(250),
	IN `i_LKC4PostCode` VARCHAR(250),
	IN `i_LKC5L1` VARCHAR(250),
	IN `i_LKC5L2` VARCHAR(250),
	IN `i_LKC5L3` VARCHAR(250),
	IN `i_LKC5Email` VARCHAR(250),
	IN `i_LKC5TelNum` VARCHAR(250),
	IN `i_LKC5City` VARCHAR(250),
	IN `i_LKC5State` VARCHAR(250),
	IN `i_LKC5Country` VARCHAR(250),
	IN `i_LKC5PostCode` VARCHAR(250),
	IN `i_BCompanyName` VARCHAR(250),
	IN `i_BRegAddressL1` VARCHAR(250),
	IN `i_BRegAddressL2` VARCHAR(250),
	IN `i_BRegAddressL3` VARCHAR(250),
	IN `i_BRegAddressEmail` VARCHAR(250),
	IN `i_BRegAddressTelNum` VARCHAR(250),
	IN `i_BRegAddressCity` VARCHAR(250),
	IN `i_BRegAddressState` VARCHAR(250),
	IN `i_BRegAddressCountry` VARCHAR(250),
	IN `i_BRegAddressPostCode` VARCHAR(250),
	IN `i_BPriAddressL1` VARCHAR(250),
	IN `i_BPriAddressL2` VARCHAR(250),
	IN `i_BPriAddressL3` VARCHAR(250),
	IN `i_BPriAddressEmail` VARCHAR(250),
	IN `i_BPriAddressTelNum` VARCHAR(250),
	IN `i_BPriAddressCity` VARCHAR(250),
	IN `i_BPriAddressState` VARCHAR(250),
	IN `i_BPriAddressCountry` VARCHAR(250),
	IN `i_BPriAddressPostCode` VARCHAR(250),
	IN `i_BKC1L1` VARCHAR(250),
	IN `i_BKC1L2` VARCHAR(250),
	IN `i_BKC1L3` VARCHAR(250),
	IN `i_BKC1Email` VARCHAR(250),
	IN `i_BKC1TelNum` VARCHAR(250),
	IN `i_BKC1City` VARCHAR(250),
	IN `i_BKC1State` VARCHAR(250),
	IN `i_BKC1Country` VARCHAR(250),
	IN `i_BKC1PostCode` VARCHAR(250),
	IN `i_BKC2L1` VARCHAR(250),
	IN `i_BKC2L2` VARCHAR(250),
	IN `i_BKC2L3` VARCHAR(250),
	IN `i_BKC2Email` VARCHAR(250),
	IN `i_BKC2TelNum` VARCHAR(250),
	IN `i_BKC2City` VARCHAR(250),
	IN `i_BKC2State` VARCHAR(250),
	IN `i_BKC2Country` VARCHAR(250),
	IN `i_BKC2PostCode` VARCHAR(250),
	IN `i_BKC3L1` VARCHAR(250),
	IN `i_BKC3L2` VARCHAR(250),
	IN `i_BKC3L3` VARCHAR(250),
	IN `i_BKC3Email` VARCHAR(250),
	IN `i_BKC3TelNum` VARCHAR(250),
	IN `i_BKC3City` VARCHAR(250),
	IN `i_BKC3State` VARCHAR(250),
	IN `i_BKC3Country` VARCHAR(250),
	IN `i_BKC3PostCode` VARCHAR(250),
	IN `i_BKC4L1` VARCHAR(250),
	IN `i_BKC4L2` VARCHAR(250),
	IN `i_BKC4L3` VARCHAR(250),
	IN `i_BKC4Email` VARCHAR(250),
	IN `i_BKC4TelNum` VARCHAR(250),
	IN `i_BKC4City` VARCHAR(250),
	IN `i_BKC4State` VARCHAR(250),
	IN `i_BKC4Country` VARCHAR(250),
	IN `i_BKC4PostCode` VARCHAR(250),
	IN `i_BKC5L1` VARCHAR(250),
	IN `i_BKC5L2` VARCHAR(250),
	IN `i_BKC5L3` VARCHAR(250),
	IN `i_BKC5Email` VARCHAR(250),
	IN `i_BKC5TelNum` VARCHAR(250),
	IN `i_BKC5City` VARCHAR(250),
	IN `i_BKC5State` VARCHAR(250),
	IN `i_BKC5Country` VARCHAR(250),
	IN `i_BKC5PostCode` VARCHAR(250),
	IN `i_ProposedDealCommencementDate` Date,
	IN `i_PropAddress1L1` VARCHAR(250),
	IN `i_PropAddress1L2` VARCHAR(250),
	IN `i_PropAddress1L3` VARCHAR(250),
	IN `i_PropAddress1Email` VARCHAR(250),
	IN `i_PropAddress1TelNum` VARCHAR(250),
	IN `i_PropAddress1City` VARCHAR(250),
	IN `i_PropAddress1State` VARCHAR(250),
	IN `i_PropAddress1Country` VARCHAR(250),
	IN `i_PropAddress1PostCode` VARCHAR(250),
	IN `i_PropAddress2L1` VARCHAR(250),
	IN `i_PropAddress2L2` VARCHAR(250),
	IN `i_PropAddress2L3` VARCHAR(250),
	IN `i_PropAddress2Email` VARCHAR(250),
	IN `i_PropAddress2TelNum` VARCHAR(250),
	IN `i_PropAddress2City` VARCHAR(250),
	IN `i_PropAddress2State` VARCHAR(250),
	IN `i_PropAddress2Country` VARCHAR(250),
	IN `i_PropAddress2PostCode` VARCHAR(250),
	IN `i_PropAddress3L1` VARCHAR(250),
	IN `i_PropAddress3L2` VARCHAR(250),
	IN `i_PropAddress3L3` VARCHAR(250),
	IN `i_PropAddress3Email` VARCHAR(250),
	IN `i_PropAddress3TelNum` VARCHAR(250),
	IN `i_PropAddress3City` VARCHAR(250),
	IN `i_PropAddress3State` VARCHAR(250),
	IN `i_PropAddress3Country` VARCHAR(250),
	IN `i_PropAddress3PostCode` VARCHAR(250),
	IN `i_PropAddress4L1` VARCHAR(250),
	IN `i_PropAddress4L2` VARCHAR(250),
	IN `i_PropAddress4L3` VARCHAR(250),
	IN `i_PropAddress4Email` VARCHAR(250),
	IN `i_PropAddress4TelNum` VARCHAR(250),
	IN `i_PropAddress4City` VARCHAR(250),
	IN `i_PropAddress4State` VARCHAR(250),
	IN `i_PropAddress4Country` VARCHAR(250),
	IN `i_PropAddress4PostCode` VARCHAR(250),
	IN `i_PropAddress5L1` VARCHAR(250),
	IN `i_PropAddress5L2` VARCHAR(250),
	IN `i_PropAddress5L3` VARCHAR(250),
	IN `i_PropAddress5Email` VARCHAR(250),
	IN `i_PropAddress5TelNum` VARCHAR(250),
	IN `i_PropAddress5City` VARCHAR(250),
	IN `i_PropAddress5State` VARCHAR(250),
	IN `i_PropAddress5Country` VARCHAR(250),
	IN `i_PropAddress5PostCode` VARCHAR(250),
	IN `i_LoanDateAggrmnt` Date,
	IN `i_FirstUtilisationDate` Date,
	IN `i_AmountAdvancedonFUD` Double,
	IN `i_OriginalCommitmentAmount` Double,
	IN `i_FirstInterestPaymentDate` Date,
	IN `i_PaymentFrequency` VARCHAR(100),
	IN `i_SignOffDate` DATETIME,
	IN `i_IsSignOff` VARCHAR(50),
	IN `i_SignoffBy` varchar(250),
	IN `i_IsActive` varchar(10)




)
BEGIN
insert into tbl_client (ClientNumber, InvDevLoan, ObligorName, StrChartAttchd, OriginalLender, LCompanyName, 
LRegAddressL1, LRegAddressL2, LRegAddressL3, LRegAddressEmail, LRegAddressTelNum, LRegAddressCity, LRegAddressState, LRegAddressCountry, LRegAddressPostCode, 
LPriAddressL1, LPriAddressL2, LPriAddressL3, LPriAddressEmail, LPriAddressTelNum, LPriAddressCity, LPriAddressState, LPriAddressCountry, LPriAddressPostCode, 
LKC1L1, LKC1L2, LKC1L3, LKC1Email, LKC1TelNum, LKC1City, LKC1State, LKC1Country, LKC1PostCode, LKC2L1, LKC2L2, LKC2L3, LKC2Email, LKC2TelNum, LKC2City, LKC2State, LKC2Country, LKC2PostCode, LKC3L1, LKC3L2, LKC3L3, LKC3Email, LKC3TelNum, LKC3City, LKC3State, LKC3Country, LKC3PostCode, LKC4L1, LKC4L2, LKC4L3, LKC4Email, LKC4TelNum, LKC4City, LKC4State, LKC4Country, LKC4PostCode, 
LKC5L1, LKC5L2, LKC5L3, LKC5Email, LKC5TelNum, LKC5City, LKC5State, LKC5Country, LKC5PostCode, BCompanyName, BRegAddressL1, BRegAddressL2, BRegAddressL3, BRegAddressEmail, BRegAddressTelNum, BRegAddressCity, BRegAddressState, BRegAddressCountry, BRegAddressPostCode, BPriAddressL1, BPriAddressL2, BPriAddressL3, BPriAddressEmail, BPriAddressTelNum, BPriAddressCity, BPriAddressState, BPriAddressCountry,
 BPriAddressPostCode, BKC1L1, BKC1L2, BKC1L3, BKC1Email, BKC1TelNum, BKC1City, BKC1State, BKC1Country, BKC1PostCode, BKC2L1, BKC2L2, BKC2L3, BKC2Email, BKC2TelNum, BKC2City, BKC2State, BKC2Country, BKC2PostCode, BKC3L1, BKC3L2, BKC3L3, BKC3Email, BKC3TelNum, BKC3City, BKC3State, BKC3Country, BKC3PostCode, BKC4L1, BKC4L2, BKC4L3, BKC4Email, BKC4TelNum, BKC4City, BKC4State, BKC4Country, BKC4PostCode, 
 BKC5L1, BKC5L2, BKC5L3, BKC5Email, BKC5TelNum, BKC5City, BKC5State, BKC5Country, BKC5PostCode, ProposedDealCommencementDate, PropAddress1L1, PropAddress1L2, PropAddress1L3, PropAddress1Email, PropAddress1TelNum, PropAddress1City, PropAddress1State, PropAddress1Country, PropAddress1PostCode, PropAddress2L1, PropAddress2L2, PropAddress2L3, PropAddress2Email, PropAddress2TelNum, PropAddress2City, 
 PropAddress2State, PropAddress2Country, PropAddress2PostCode, PropAddress3L1, PropAddress3L2, PropAddress3L3, PropAddress3Email, PropAddress3TelNum, PropAddress3City, PropAddress3State, PropAddress3Country, PropAddress3PostCode, PropAddress4L1, PropAddress4L2, PropAddress4L3, PropAddress4Email, PropAddress4TelNum, PropAddress4City, PropAddress4State, PropAddress4Country, PropAddress4PostCode,
  PropAddress5L1, PropAddress5L2, PropAddress5L3, PropAddress5Email, PropAddress5TelNum, PropAddress5City, PropAddress5State, PropAddress5Country, PropAddress5PostCode, LoanDateAggrmnt, FirstUtilisationDate, AmountAdvancedonFUD, OriginalCommitmentAmount, FirstInterestPaymentDate, PaymentFrequency, IsSignOff, SignOffDate, SignoffBy, IsActive) 

values(i_ClientNumber, i_InvDevLoan, i_ObligorName, i_StrChartAttchd, i_OriginalLender, i_LCompanyName, 
i_LRegAddressL1, i_LRegAddressL2, i_LRegAddressL3, i_LRegAddressEmail, i_LRegAddressTelNum, i_LRegAddressCity, i_LRegAddressState, i_LRegAddressCountry, i_LRegAddressPostCode, 
i_LPriAddressL1, i_LPriAddressL2, i_LPriAddressL3, i_LPriAddressEmail, i_LPriAddressTelNum, i_LPriAddressCity, i_LPriAddressState, i_LPriAddressCountry, i_LPriAddressPostCode, 
i_LKC1L1, i_LKC1L2, i_LKC1L3, i_LKC1Email, i_LKC1TelNum, i_LKC1City, i_LKC1State, i_LKC1Country, i_LKC1PostCode, i_LKC2L1, i_LKC2L2, i_LKC2L3, i_LKC2Email, i_LKC2TelNum, i_LKC2City, i_LKC2State, i_LKC2Country, i_LKC2PostCode, i_LKC3L1, i_LKC3L2, i_LKC3L3, i_LKC3Email, i_LKC3TelNum, i_LKC3City, i_LKC3State, i_LKC3Country, i_LKC3PostCode, i_LKC4L1, i_LKC4L2, i_LKC4L3, i_LKC4Email, i_LKC4TelNum, i_LKC4City, i_LKC4State, i_LKC4Country, i_LKC4PostCode, 
i_LKC5L1, i_LKC5L2, i_LKC5L3, i_LKC5Email, i_LKC5TelNum, i_LKC5City, i_LKC5State, i_LKC5Country, i_LKC5PostCode, i_BCompanyName, i_BRegAddressL1, i_BRegAddressL2, i_BRegAddressL3, i_BRegAddressEmail, i_BRegAddressTelNum, i_BRegAddressCity, i_BRegAddressState, i_BRegAddressCountry, i_BRegAddressPostCode, i_BPriAddressL1, i_BPriAddressL2, i_BPriAddressL3, i_BPriAddressEmail, i_BPriAddressTelNum, i_BPriAddressCity, i_BPriAddressState, i_BPriAddressCountry,
 i_BPriAddressPostCode, i_BKC1L1, i_BKC1L2, i_BKC1L3, i_BKC1Email, i_BKC1TelNum, i_BKC1City, i_BKC1State, i_BKC1Country, i_BKC1PostCode, i_BKC2L1, i_BKC2L2, i_BKC2L3, i_BKC2Email, i_BKC2TelNum, i_BKC2City, i_BKC2State, i_BKC2Country, i_BKC2PostCode, i_BKC3L1, i_BKC3L2, i_BKC3L3, i_BKC3Email, i_BKC3TelNum, i_BKC3City, i_BKC3State, i_BKC3Country, i_BKC3PostCode, i_BKC4L1, i_BKC4L2, i_BKC4L3, i_BKC4Email, i_BKC4TelNum , i_BKC4City, i_BKC4State, i_BKC4Country, i_BKC4PostCode, 
 i_BKC5L1, i_BKC5L2, i_BKC5L3, i_BKC5Email, i_BKC5TelNum, i_BKC5City, i_BKC5State, i_BKC5Country, i_BKC5PostCode, i_ProposedDealCommencementDate, i_PropAddress1L1, i_PropAddress1L2, i_PropAddress1L3, i_PropAddress1Email, i_PropAddress1TelNum, i_PropAddress1City, i_PropAddress1State, i_PropAddress1Country, i_PropAddress1PostCode, i_PropAddress2L1, i_PropAddress2L2, i_PropAddress2L3, i_PropAddress2Email, i_PropAddress2TelNum, i_PropAddress2City, 
 i_PropAddress2State, i_PropAddress2Country, i_PropAddress2PostCode, i_PropAddress3L1, i_PropAddress3L2, i_PropAddress3L3, i_PropAddress3Email, i_PropAddress3TelNum, i_PropAddress3City, i_PropAddress3State, i_PropAddress3Country, i_PropAddress3PostCode, i_PropAddress4L1, i_PropAddress4L2, i_PropAddress4L3, i_PropAddress4Email, i_PropAddress4TelNum, i_PropAddress4City, i_PropAddress4State, i_PropAddress4Country, i_PropAddress4PostCode, 
 i_PropAddress5L1, i_PropAddress5L2, i_PropAddress5L3, i_PropAddress5Email, i_PropAddress5TelNum, i_PropAddress5City, i_PropAddress5State, i_PropAddress5Country, i_PropAddress5PostCode, i_LoanDateAggrmnt, i_FirstUtilisationDate, i_AmountAdvancedonFUD, i_OriginalCommitmentAmount, i_FirstInterestPaymentDate, i_PaymentFrequency, i_IsSignOff, i_SignOffDate, i_SignoffBy, i_IsActive);



Insert into tbl_onboarding_task (ClientNumber,IsMappedToTask,IsActive,IsProcessed,Type) 
values (i_ClientNumber,'N','Y','N','DIRECT');

END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_insert_clienttaskmapping
DROP PROCEDURE IF EXISTS `sp_insert_clienttaskmapping`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_clienttaskmapping`(
	IN `i_clientid` VARCHAR(250),
	IN `i_taskId` VARCHAR(250)

)
BEGIN
insert into tbl_clienttask_mapping (ClientNumber,TaskId) values(i_clientid,i_taskId);
END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_insert_OnboardingTask
DROP PROCEDURE IF EXISTS `SP_insert_OnboardingTask`;
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

Insert into tbl_onboarding_task (UniqueEmailID,EmailID,ClientNumber,EmailSubject,EmailContent,IsMappedToTask,EmailAttachment,CreatedDate,IsActive,IsProcessed,CreatedBy,TaskAssignedDate,Type) 
values (i_UniqueEmailID,i_EmailID,i_ClientNumber,i_Subject,i_EmailContent,i_IsMappedToTask,i_EmailAttachment,i_CreatedDate,'Y','N',i_CreatedBy,i_TaskAssignedDate,'EMAIL');

END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_insert_role
DROP PROCEDURE IF EXISTS `sp_insert_role`;
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

-- Dumping structure for procedure coba.sp_insert_roleright
DROP PROCEDURE IF EXISTS `sp_insert_roleright`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_roleright`(
	IN `i_RoleId` INT,
	IN `i_RightId` INT

)
BEGIN
insert into tbl_roleright_mapping (RoleId,RightId) values(i_RoleId,i_RightId);
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_insert_task
DROP PROCEDURE IF EXISTS `sp_insert_task`;
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

-- Dumping structure for procedure coba.sp_insert_userBusinessSector
DROP PROCEDURE IF EXISTS `sp_insert_userBusinessSector`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_userBusinessSector`(
	IN `i_userid` VARCHAR(250),
	IN `i_BusinessSectorId` VARCHAR(250)
)
BEGIN
insert into tbl_userBusinessSectormapping (Userid,BusinessSectorId) values(i_userid,i_BusinessSectorId);
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_insert_usercountry
DROP PROCEDURE IF EXISTS `sp_insert_usercountry`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_usercountry`(
	IN `i_userid` VARCHAR(250),
	IN `i_CountryId` VARCHAR(250)
)
BEGIN
insert into tbl_usercountrymapping (Userid,CountryId) values(i_userid,i_CountryId);
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_insert_userregion
DROP PROCEDURE IF EXISTS `sp_insert_userregion`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_userregion`(
	IN `i_userid` VARCHAR(250),
	IN `i_RegionId` VARCHAR(250)
)
BEGIN
insert into tbl_userregionmapping (Userid,RegionId) values(i_userid,i_RegionId);
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_updateuser
DROP PROCEDURE IF EXISTS `sp_updateuser`;
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

-- Dumping structure for procedure coba.sp_update_BusinessLinemaster
DROP PROCEDURE IF EXISTS `sp_update_BusinessLinemaster`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_BusinessLinemaster`(
	IN `i_id` INT,
	IN `i_BusinessLine` VARCHAR(50)

)
BEGIN

update tbl_BusinessLine_master set BusinessLine=i_BusinessLine  where id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_update_Client
DROP PROCEDURE IF EXISTS `sp_update_Client`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_Client`(
		IN `i_ClientNumber` VARCHAR(250),
	IN `i_InvDevLoan` VARCHAR(250),
	IN `i_ObligorName` VARCHAR(250),
	IN `i_StrChartAttchd` VARCHAR(250),
	IN `i_OriginalLender` VARCHAR(250),
	IN `i_LCompanyName` VARCHAR(250),
	IN `i_LRegAddressL1` VARCHAR(250),
	IN `i_LRegAddressL2` VARCHAR(250),
	IN `i_LRegAddressL3` VARCHAR(250),
	IN `i_LRegAddressEmail` VARCHAR(250),
	IN `i_LRegAddressTelNum` VARCHAR(250),
	IN `i_LRegAddressCity` VARCHAR(250),
	IN `i_LRegAddressState` VARCHAR(250),
	IN `i_LRegAddressCountry` VARCHAR(250),
	IN `i_LRegAddressPostCode` VARCHAR(250),
	IN `i_LPriAddressL1` VARCHAR(250),
	IN `i_LPriAddressL2` VARCHAR(250),
	IN `i_LPriAddressL3` VARCHAR(250),
	IN `i_LPriAddressEmail` VARCHAR(250),
	IN `i_LPriAddressTelNum` VARCHAR(250),
	IN `i_LPriAddressCity` VARCHAR(250),
	IN `i_LPriAddressState` VARCHAR(250),
	IN `i_LPriAddressCountry` VARCHAR(250),
	IN `i_LPriAddressPostCode` VARCHAR(250),
	IN `i_LKC1L1` VARCHAR(250),
	IN `i_LKC1L2` VARCHAR(250),
	IN `i_LKC1L3` VARCHAR(250),
	IN `i_LKC1Email` VARCHAR(250),
	IN `i_LKC1TelNum` VARCHAR(250),
	IN `i_LKC1City` VARCHAR(250),
	IN `i_LKC1State` VARCHAR(250),
	IN `i_LKC1Country` VARCHAR(250),
	IN `i_LKC1PostCode` VARCHAR(250),
	IN `i_LKC2L1` VARCHAR(250),
	IN `i_LKC2L2` VARCHAR(250),
	IN `i_LKC2L3` VARCHAR(250),
	IN `i_LKC2Email` VARCHAR(250),
	IN `i_LKC2TelNum` VARCHAR(250),
	IN `i_LKC2City` VARCHAR(250),
	IN `i_LKC2State` VARCHAR(250),
	IN `i_LKC2Country` VARCHAR(250),
	IN `i_LKC2PostCode` VARCHAR(250),
	IN `i_LKC3L1` VARCHAR(250),
	IN `i_LKC3L2` VARCHAR(250),
	IN `i_LKC3L3` VARCHAR(250),
	IN `i_LKC3Email` VARCHAR(250),
	IN `i_LKC3TelNum` VARCHAR(250),
	IN `i_LKC3City` VARCHAR(250),
	IN `i_LKC3State` VARCHAR(250),
	IN `i_LKC3Country` VARCHAR(250),
	IN `i_LKC3PostCode` VARCHAR(250),
	IN `i_LKC4L1` VARCHAR(250),
	IN `i_LKC4L2` VARCHAR(250),
	IN `i_LKC4L3` VARCHAR(250),
	IN `i_LKC4Email` VARCHAR(250),
	IN `i_LKC4TelNum` VARCHAR(250),
	IN `i_LKC4City` VARCHAR(250),
	IN `i_LKC4State` VARCHAR(250),
	IN `i_LKC4Country` VARCHAR(250),
	IN `i_LKC4PostCode` VARCHAR(250),
	IN `i_LKC5L1` VARCHAR(250),
	IN `i_LKC5L2` VARCHAR(250),
	IN `i_LKC5L3` VARCHAR(250),
	IN `i_LKC5Email` VARCHAR(250),
	IN `i_LKC5TelNum` VARCHAR(250),
	IN `i_LKC5City` VARCHAR(250),
	IN `i_LKC5State` VARCHAR(250),
	IN `i_LKC5Country` VARCHAR(250),
	IN `i_LKC5PostCode` VARCHAR(250),
	IN `i_BCompanyName` VARCHAR(250),
	IN `i_BRegAddressL1` VARCHAR(250),
	IN `i_BRegAddressL2` VARCHAR(250),
	IN `i_BRegAddressL3` VARCHAR(250),
	IN `i_BRegAddressEmail` VARCHAR(250),
	IN `i_BRegAddressTelNum` VARCHAR(250),
	IN `i_BRegAddressCity` VARCHAR(250),
	IN `i_BRegAddressState` VARCHAR(250),
	IN `i_BRegAddressCountry` VARCHAR(250),
	IN `i_BRegAddressPostCode` VARCHAR(250),
	IN `i_BPriAddressL1` VARCHAR(250),
	IN `i_BPriAddressL2` VARCHAR(250),
	IN `i_BPriAddressL3` VARCHAR(250),
	IN `i_BPriAddressEmail` VARCHAR(250),
	IN `i_BPriAddressTelNum` VARCHAR(250),
	IN `i_BPriAddressCity` VARCHAR(250),
	IN `i_BPriAddressState` VARCHAR(250),
	IN `i_BPriAddressCountry` VARCHAR(250),
	IN `i_BPriAddressPostCode` VARCHAR(250),
	IN `i_BKC1L1` VARCHAR(250),
	IN `i_BKC1L2` VARCHAR(250),
	IN `i_BKC1L3` VARCHAR(250),
	IN `i_BKC1Email` VARCHAR(250),
	IN `i_BKC1TelNum` VARCHAR(250),
	IN `i_BKC1City` VARCHAR(250),
	IN `i_BKC1State` VARCHAR(250),
	IN `i_BKC1Country` VARCHAR(250),
	IN `i_BKC1PostCode` VARCHAR(250),
	IN `i_BKC2L1` VARCHAR(250),
	IN `i_BKC2L2` VARCHAR(250),
	IN `i_BKC2L3` VARCHAR(250),
	IN `i_BKC2Email` VARCHAR(250),
	IN `i_BKC2TelNum` VARCHAR(250),
	IN `i_BKC2City` VARCHAR(250),
	IN `i_BKC2State` VARCHAR(250),
	IN `i_BKC2Country` VARCHAR(250),
	IN `i_BKC2PostCode` VARCHAR(250),
	IN `i_BKC3L1` VARCHAR(250),
	IN `i_BKC3L2` VARCHAR(250),
	IN `i_BKC3L3` VARCHAR(250),
	IN `i_BKC3Email` VARCHAR(250),
	IN `i_BKC3TelNum` VARCHAR(250),
	IN `i_BKC3City` VARCHAR(250),
	IN `i_BKC3State` VARCHAR(250),
	IN `i_BKC3Country` VARCHAR(250),
	IN `i_BKC3PostCode` VARCHAR(250),
	IN `i_BKC4L1` VARCHAR(250),
	IN `i_BKC4L2` VARCHAR(250),
	IN `i_BKC4L3` VARCHAR(250),
	IN `i_BKC4Email` VARCHAR(250),
	IN `i_BKC4TelNum` VARCHAR(250),
	IN `i_BKC4City` VARCHAR(250),
	IN `i_BKC4State` VARCHAR(250),
	IN `i_BKC4Country` VARCHAR(250),
	IN `i_BKC4PostCode` VARCHAR(250),
	IN `i_BKC5L1` VARCHAR(250),
	IN `i_BKC5L2` VARCHAR(250),
	IN `i_BKC5L3` VARCHAR(250),
	IN `i_BKC5Email` VARCHAR(250),
	IN `i_BKC5TelNum` VARCHAR(250),
	IN `i_BKC5City` VARCHAR(250),
	IN `i_BKC5State` VARCHAR(250),
	IN `i_BKC5Country` VARCHAR(250),
	IN `i_BKC5PostCode` VARCHAR(250),
	IN `i_ProposedDealCommencementDate` Date,
	IN `i_PropAddress1L1` VARCHAR(250),
	IN `i_PropAddress1L2` VARCHAR(250),
	IN `i_PropAddress1L3` VARCHAR(250),
	IN `i_PropAddress1Email` VARCHAR(250),
	IN `i_PropAddress1TelNum` VARCHAR(250),
	IN `i_PropAddress1City` VARCHAR(250),
	IN `i_PropAddress1State` VARCHAR(250),
	IN `i_PropAddress1Country` VARCHAR(250),
	IN `i_PropAddress1PostCode` VARCHAR(250),
	IN `i_PropAddress2L1` VARCHAR(250),
	IN `i_PropAddress2L2` VARCHAR(250),
	IN `i_PropAddress2L3` VARCHAR(250),
	IN `i_PropAddress2Email` VARCHAR(250),
	IN `i_PropAddress2TelNum` VARCHAR(250),
	IN `i_PropAddress2City` VARCHAR(250),
	IN `i_PropAddress2State` VARCHAR(250),
	IN `i_PropAddress2Country` VARCHAR(250),
	IN `i_PropAddress2PostCode` VARCHAR(250),
	IN `i_PropAddress3L1` VARCHAR(250),
	IN `i_PropAddress3L2` VARCHAR(250),
	IN `i_PropAddress3L3` VARCHAR(250),
	IN `i_PropAddress3Email` VARCHAR(250),
	IN `i_PropAddress3TelNum` VARCHAR(250),
	IN `i_PropAddress3City` VARCHAR(250),
	IN `i_PropAddress3State` VARCHAR(250),
	IN `i_PropAddress3Country` VARCHAR(250),
	IN `i_PropAddress3PostCode` VARCHAR(250),
	IN `i_PropAddress4L1` VARCHAR(250),
	IN `i_PropAddress4L2` VARCHAR(250),
	IN `i_PropAddress4L3` VARCHAR(250),
	IN `i_PropAddress4Email` VARCHAR(250),
	IN `i_PropAddress4TelNum` VARCHAR(250),
	IN `i_PropAddress4City` VARCHAR(250),
	IN `i_PropAddress4State` VARCHAR(250),
	IN `i_PropAddress4Country` VARCHAR(250),
	IN `i_PropAddress4PostCode` VARCHAR(250),
	IN `i_PropAddress5L1` VARCHAR(250),
	IN `i_PropAddress5L2` VARCHAR(250),
	IN `i_PropAddress5L3` VARCHAR(250),
	IN `i_PropAddress5Email` VARCHAR(250),
	IN `i_PropAddress5TelNum` VARCHAR(250),
	IN `i_PropAddress5City` VARCHAR(250),
	IN `i_PropAddress5State` VARCHAR(250),
	IN `i_PropAddress5Country` VARCHAR(250),
	IN `i_PropAddress5PostCode` VARCHAR(250),
	IN `i_LoanDateAggrmnt` Date,
	IN `i_FirstUtilisationDate` Date,
	IN `i_AmountAdvancedonFUD` Double,
	IN `i_OriginalCommitmentAmount` Double,
	IN `i_FirstInterestPaymentDate` Date,
	IN `i_PaymentFrequency` VARCHAR(100),
	IN `i_SignOffDate` DATETIME,
	IN `i_IsSignOff` VARCHAR(50),
	IN `i_SignoffBy` varchar(250),
	IN `i_IsActive` varchar(10)


)
BEGIN
update tbl_client  set InvDevLoan=i_InvDevLoan, 
ObligorName=i_ObligorName,
 StrChartAttchd=i_StrChartAttchd, 
 OriginalLender=i_OriginalLender, 
 LCompanyName= i_LCompanyName, 
 LRegAddressL1= i_LRegAddressL1,
  LRegAddressL2=i_LRegAddressL2,
   LRegAddressL3= i_LRegAddressL3,
	 LRegAddressEmail=i_LRegAddressEmail,
	  LRegAddressTelNum=i_LRegAddressTelNum,
	   LRegAddressCity=i_LRegAddressCity,
		 LRegAddressState=i_LRegAddressState,
		  LRegAddressCountry= i_LRegAddressCountry,
		   LRegAddressPostCode=i_LRegAddressPostCode, 
			LPriAddressL1 = i_LPriAddressL1, 
			LPriAddressL2 = i_LPriAddressL2, 
			LPriAddressL3 = i_LPriAddressL3,
			 LPriAddressEmail = i_LPriAddressEmail,
			  LPriAddressTelNum = i_LPriAddressTelNum,
			   LPriAddressCity = i_LPriAddressCity,
				 LPriAddressState = i_LPriAddressState,
				  LPriAddressCountry = i_LPriAddressCountry,
				   LPriAddressPostCode =  i_LPriAddressPostCode,
					 LKC1L1 = i_LKC1L1,
					  LKC1L2 =i_LKC1L2 ,
					   LKC1L3 = i_LKC1L3, 
						LKC1Email = i_LKC1Email,
						 LKC1TelNum = i_LKC1TelNum,
						  LKC1City =  i_LKC1City,
						   LKC1State = i_LKC1State,
							 LKC1Country = i_LKC1Country,
							  LKC1PostCode = i_LKC1PostCode,
							   LKC2L1 = i_LKC2L1,
								 LKC2L2 =i_LKC2L2,
								  LKC2L3 =i_LKC2L3 ,
								   LKC2Email = i_LKC2Email,
									 LKC2TelNum = i_LKC2TelNum,
									  LKC2City = i_LKC2City,
									   LKC2State = i_LKC2State,
										 LKC2Country = i_LKC2Country,
										  LKC2PostCode = i_LKC2PostCode,
										   LKC3L1 = i_LKC3L1,
											 LKC3L2=i_LKC3L2,
											  LKC3L3= i_LKC3L3,
											   LKC3Email=i_LKC3Email,
												 LKC3TelNum=i_LKC3TelNum,
												  LKC3City=i_LKC3City,
												   LKC3State=i_LKC3State,
 LKC3Country=i_LKC3Country,
  LKC3PostCode= i_LKC3PostCode,
   LKC4L1= i_LKC4L1,
	 LKC4L2=i_LKC4L2, 
	 LKC4L3=i_LKC4L3,
	  LKC4Email=i_LKC4Email,
	   LKC4TelNum=i_LKC4TelNum,
		 LKC4City=i_LKC4City,
		  LKC4State=i_LKC4State,
		   LKC4Country=i_LKC4Country,
			 LKC4PostCode=i_LKC4PostCode,
			  LKC5L1=i_LKC5L1,
			   LKC5L2=i_LKC5L2,
				 LKC5L3=i_LKC5L3,
				  LKC5Email=i_LKC5Email,
				   LKC5TelNum=i_LKC5TelNum,
LKC5City=i_LKC5City, LKC5State=i_LKC5State,
 LKC5Country=i_LKC5Country,
  LKC5PostCode=i_LKC5PostCode,
 BCompanyName= i_BCompanyName,
  BRegAddressL1= i_BRegAddressL1,
   BRegAddressL2=i_BRegAddressL2,
 BRegAddressL3=i_BRegAddressL3,
  BRegAddressEmail= i_BRegAddressEmail,
BRegAddressTelNum=i_BRegAddressTelNum,
 BRegAddressCity=i_BRegAddressCity,
  BRegAddressState= i_BRegAddressState,
   BRegAddressCountry=i_BRegAddressCountry,
	 BRegAddressPostCode=i_BRegAddressPostCode,
	  BPriAddressL1=i_BPriAddressL1,
BPriAddressL2=i_BPriAddressL2,
 BPriAddressL3=i_BPriAddressL3,
  BPriAddressEmail=i_BPriAddressEmail,
   BPriAddressTelNum=i_BPriAddressTelNum,
	 BPriAddressCity=i_BPriAddressCity,
	  BPriAddressState= i_BPriAddressState,
	   BPriAddressCountry=i_BPriAddressCountry,
		 BPriAddressPostCode=i_BPriAddressPostCode,
		  BKC1L1=i_BKC1L1,
		   BKC1L2=i_BKC1L2, 
BKC1L3=i_BKC1L3,
 BKC1Email=i_BKC1Email,
  BKC1TelNum=i_BKC1TelNum,
   BKC1City=i_BKC1City,
BKC1State=i_BKC1State,
 BKC1Country=i_BKC1Country, BKC1PostCode=i_BKC1PostCode,
  BKC2L1=i_BKC2L1, BKC2L2=i_BKC2L2,
   BKC2L3=i_BKC2L3, 
	BKC2Email=i_BKC2Email,
	 BKC2TelNum=i_BKC2TelNum,
	  BKC2City=i_BKC2City,
	   BKC2State=i_BKC2State,
		 BKC2Country=i_BKC2Country,
		  BKC2PostCode=i_BKC2PostCode,
 BKC3L1=i_BKC3L1, 
 BKC3L2=i_BKC3L2,
  BKC3L3=i_BKC3L3,
   BKC3Email=i_BKC3Email,
	 BKC3TelNum=i_BKC3TelNum,
	  BKC3City=i_BKC3City,
BKC3State=i_BKC3State,
 BKC3Country=i_BKC3Country,
  BKC3PostCode= i_BKC3PostCode,
   BKC4L1=i_BKC4L1,
BKC4L2=i_BKC4L2,
 BKC4L3=i_BKC4L3, 
 BKC4Email=i_BKC4Email,
  BKC4TelNum=i_BKC4TelNum,
   BKC4City=i_BKC4City,
	 BKC4State=i_BKC4State,
	  BKC4Country=i_BKC4Country,
	   BKC4PostCode=i_BKC4PostCode,
		 BKC5L1=i_BKC5L1,
		  BKC5L2=i_BKC5L2, 
		  BKC5L3=i_BKC5L3,
		   BKC5Email=i_BKC5Email,
			 BKC5TelNum=i_BKC5TelNum,
			  BKC5City=i_BKC5City,
			   BKC5State=i_BKC5State,
				 BKC5Country=i_BKC5Country,
				  BKC5PostCode=i_BKC5PostCode,
				   ProposedDealCommencementDate=i_ProposedDealCommencementDate,
					 PropAddress1L1=i_PropAddress1L1,
					  PropAddress1L2=i_PropAddress1L2,
					   PropAddress1L3=i_PropAddress1L3,
						 PropAddress1Email=i_PropAddress1Email,
						  PropAddress1TelNum=i_PropAddress1TelNum,
						   PropAddress1City=i_PropAddress1City,
							 PropAddress1State=i_PropAddress1State,
							  PropAddress1Country=i_PropAddress1Country,
PropAddress1PostCode=i_PropAddress1PostCode,
 PropAddress2L1=i_PropAddress2L1,
  PropAddress2L2=i_PropAddress2L2,
   PropAddress2L3=i_PropAddress2L3,
	 PropAddress2Email=i_PropAddress2Email,
	  PropAddress2TelNum=i_PropAddress2TelNum,
	   PropAddress2City=i_PropAddress2City,
		 PropAddress2State=i_PropAddress2State,
		  PropAddress2Country=i_PropAddress2Country,
		   PropAddress2PostCode=i_PropAddress2PostCode,
			 PropAddress3L1=i_PropAddress3L1,
			  PropAddress3L2=i_PropAddress3L2,
			   PropAddress3L3=i_PropAddress3L3,
				 PropAddress3Email=i_PropAddress3Email,
				  PropAddress3TelNum=i_PropAddress3TelNum,
				   PropAddress3City=i_PropAddress3City,
					 PropAddress3State=i_PropAddress3State,
					  PropAddress3Country=i_PropAddress3Country,
					   PropAddress3PostCode=i_PropAddress3PostCode,
						 PropAddress4L1=i_PropAddress4L1,
						  PropAddress4L2=i_PropAddress4L2,
PropAddress4L3=i_PropAddress4L3,
 PropAddress4Email=i_PropAddress4Email,
  PropAddress4TelNum=i_PropAddress4TelNum,
   PropAddress4City=i_PropAddress4City,
	 PropAddress4State=i_PropAddress4State,
	  PropAddress4Country=i_PropAddress4Country,
	   PropAddress4PostCode=i_PropAddress4PostCode,
		 PropAddress5L1=i_PropAddress5L1,
		  PropAddress5L2=i_PropAddress5L2,
 PropAddress5L3=i_PropAddress5L3,
  PropAddress5Email=i_PropAddress5Email,
   PropAddress5TelNum=i_PropAddress5TelNum,
 PropAddress5City=i_PropAddress5City,
  PropAddress5State=i_PropAddress5State,
PropAddress5Country=i_PropAddress5Country,
 PropAddress5PostCode=i_PropAddress5PostCode,
  LoanDateAggrmnt=i_LoanDateAggrmnt,
   FirstUtilisationDate=i_FirstUtilisationDate,
	 AmountAdvancedonFUD= i_AmountAdvancedonFUD,
	  OriginalCommitmentAmount=i_OriginalCommitmentAmount,
	   FirstInterestPaymentDate=i_FirstInterestPaymentDate,
		 PaymentFrequency=i_PaymentFrequency,
		  IsSignOff=i_IsSignOff,
		   SignOffDate=i_SignOffDate,
			 SignoffBy=i_SignoffBy,
			  IsActive=i_IsActive 
where ClientNumber= i_ClientNumber;
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_update_client_taskstatus
DROP PROCEDURE IF EXISTS `sp_update_client_taskstatus`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_client_taskstatus`(
	IN `i_clientnumber` VARCHAR(50)

)
BEGIN

update tbl_client set IsMappedToTask='Y' where ClientNumber=i_clientnumber;
END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_update_countrymaster
DROP PROCEDURE IF EXISTS `sp_update_countrymaster`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_countrymaster`(
	IN `i_id` INT,
	IN `i_countryname` VARCHAR(50)
)
BEGIN

update tbl_country_master set countryname=i_countryname where id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_update_map_task
DROP PROCEDURE IF EXISTS `sp_update_map_task`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_map_task`(
	IN `i_id` INT,
	IN `i_taskid` VARCHAR(50),
	IN `i_IsMappedToTask` VARCHAR(50)


)
BEGIN
	delete from tbl_clienttask_mapping where ClientNumber=i_id;
	
	update tbl_onboarding_task set IsMappedToTask=i_IsMappedToTask where Id=i_id;
	
	insert into tbl_clienttask_mapping (ClientNumber,TaskId) values(i_id,i_taskId);
	
END//
DELIMITER ;

-- Dumping structure for procedure coba.SP_update_onboardingTask
DROP PROCEDURE IF EXISTS `SP_update_onboardingTask`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_update_onboardingTask`(
	IN `i_id` INT,
	IN `i_TaskAttachment` VARCHAR(500)
,
	IN `i_comments` VARCHAR(500)

)
BEGIN

update tbl_onboarding_task set TaskAttachement=i_TaskAttachment,TaskComments=i_comments where Id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_update_regionmaster
DROP PROCEDURE IF EXISTS `sp_update_regionmaster`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_regionmaster`(
	IN `i_id` INT,
	IN `i_regionname` VARCHAR(50)
)
BEGIN

update tbl_region_master set regionname=i_regionname where id=i_id;

END//
DELIMITER ;

-- Dumping structure for procedure coba.sp_update_task
DROP PROCEDURE IF EXISTS `sp_update_task`;
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

-- Dumping structure for table coba.tbl_businessline_master
DROP TABLE IF EXISTS `tbl_businessline_master`;
CREATE TABLE IF NOT EXISTS `tbl_businessline_master` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `BusinessLine` varchar(250) DEFAULT '0',
  `IsActive` bit(1) DEFAULT b'0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_businessline_master: ~2 rows (approximately)
DELETE FROM `tbl_businessline_master`;
/*!40000 ALTER TABLE `tbl_businessline_master` DISABLE KEYS */;
INSERT INTO `tbl_businessline_master` (`Id`, `BusinessLine`, `IsActive`) VALUES
	(1, 'Equity - CMA/CS2', b'1'),
	(2, 'Test business', b'1');
/*!40000 ALTER TABLE `tbl_businessline_master` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_businesssector
DROP TABLE IF EXISTS `tbl_businesssector`;
CREATE TABLE IF NOT EXISTS `tbl_businesssector` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_businesssector: ~1 rows (approximately)
DELETE FROM `tbl_businesssector`;
/*!40000 ALTER TABLE `tbl_businesssector` DISABLE KEYS */;
INSERT INTO `tbl_businesssector` (`Id`, `Name`) VALUES
	(1, 'sector1');
/*!40000 ALTER TABLE `tbl_businesssector` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_client
DROP TABLE IF EXISTS `tbl_client`;
CREATE TABLE IF NOT EXISTS `tbl_client` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClientNumber` varchar(30) NOT NULL,
  `InvDevLoan` varchar(30) NOT NULL,
  `ObligorName` varchar(500) NOT NULL,
  `StrChartAttchd` varchar(100) NOT NULL,
  `OriginalLender` varchar(500) DEFAULT NULL,
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
  `LoanDateAggrmnt` date DEFAULT NULL,
  `FirstUtilisationDate` date DEFAULT NULL,
  `AmountAdvancedonFUD` double(16,2) DEFAULT NULL,
  `OriginalCommitmentAmount` double(16,2) DEFAULT NULL,
  `FirstInterestPaymentDate` date DEFAULT NULL,
  `PaymentFrequency` int(11) DEFAULT NULL,
  `IsSignOff` varchar(1) DEFAULT NULL,
  `SignOffDate` datetime DEFAULT NULL,
  `SignoffBy` varchar(100) DEFAULT NULL,
  `IsActive` varchar(1) DEFAULT NULL,
  `CreatedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `LastModifiedDate` datetime DEFAULT NULL,
  `IsMappedToTask` varchar(10) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_client: ~1 rows (approximately)
DELETE FROM `tbl_client`;
/*!40000 ALTER TABLE `tbl_client` DISABLE KEYS */;
INSERT INTO `tbl_client` (`Id`, `ClientNumber`, `InvDevLoan`, `ObligorName`, `StrChartAttchd`, `OriginalLender`, `LCompanyName`, `LRegAddressL1`, `LRegAddressL2`, `LRegAddressL3`, `LRegAddressEmail`, `LRegAddressTelNum`, `LRegAddressCity`, `LRegAddressState`, `LRegAddressCountry`, `LRegAddressPostCode`, `LPriAddressL1`, `LPriAddressL2`, `LPriAddressL3`, `LPriAddressEmail`, `LPriAddressTelNum`, `LPriAddressCity`, `LPriAddressState`, `LPriAddressCountry`, `LPriAddressPostCode`, `LKC1L1`, `LKC1L2`, `LKC1L3`, `LKC1Email`, `LKC1TelNum`, `LKC1City`, `LKC1State`, `LKC1Country`, `LKC1PostCode`, `LKC2L1`, `LKC2L2`, `LKC2L3`, `LKC2Email`, `LKC2TelNum`, `LKC2City`, `LKC2State`, `LKC2Country`, `LKC2PostCode`, `LKC3L1`, `LKC3L2`, `LKC3L3`, `LKC3Email`, `LKC3TelNum`, `LKC3City`, `LKC3State`, `LKC3Country`, `LKC3PostCode`, `LKC4L1`, `LKC4L2`, `LKC4L3`, `LKC4Email`, `LKC4TelNum`, `LKC4City`, `LKC4State`, `LKC4Country`, `LKC4PostCode`, `LKC5L1`, `LKC5L2`, `LKC5L3`, `LKC5Email`, `LKC5TelNum`, `LKC5City`, `LKC5State`, `LKC5Country`, `LKC5PostCode`, `BCompanyName`, `BRegAddressL1`, `BRegAddressL2`, `BRegAddressL3`, `BRegAddressEmail`, `BRegAddressTelNum`, `BRegAddressCity`, `BRegAddressState`, `BRegAddressCountry`, `BRegAddressPostCode`, `BPriAddressL1`, `BPriAddressL2`, `BPriAddressL3`, `BPriAddressEmail`, `BPriAddressTelNum`, `BPriAddressCity`, `BPriAddressState`, `BPriAddressCountry`, `BPriAddressPostCode`, `BKC1L1`, `BKC1L2`, `BKC1L3`, `BKC1Email`, `BKC1TelNum`, `BKC1City`, `BKC1State`, `BKC1Country`, `BKC1PostCode`, `BKC2L1`, `BKC2L2`, `BKC2L3`, `BKC2Email`, `BKC2TelNum`, `BKC2City`, `BKC2State`, `BKC2Country`, `BKC2PostCode`, `BKC3L1`, `BKC3L2`, `BKC3L3`, `BKC3Email`, `BKC3TelNum`, `BKC3City`, `BKC3State`, `BKC3Country`, `BKC3PostCode`, `BKC4L1`, `BKC4L2`, `BKC4L3`, `BKC4Email`, `BKC4TelNum`, `BKC4City`, `BKC4State`, `BKC4Country`, `BKC4PostCode`, `BKC5L1`, `BKC5L2`, `BKC5L3`, `BKC5Email`, `BKC5TelNum`, `BKC5City`, `BKC5State`, `BKC5Country`, `BKC5PostCode`, `ProposedDealCommencementDate`, `PropAddress1L1`, `PropAddress1L2`, `PropAddress1L3`, `PropAddress1Email`, `PropAddress1TelNum`, `PropAddress1City`, `PropAddress1State`, `PropAddress1Country`, `PropAddress1PostCode`, `PropAddress2L1`, `PropAddress2L2`, `PropAddress2L3`, `PropAddress2Email`, `PropAddress2TelNum`, `PropAddress2City`, `PropAddress2State`, `PropAddress2Country`, `PropAddress2PostCode`, `PropAddress3L1`, `PropAddress3L2`, `PropAddress3L3`, `PropAddress3Email`, `PropAddress3TelNum`, `PropAddress3City`, `PropAddress3State`, `PropAddress3Country`, `PropAddress3PostCode`, `PropAddress4L1`, `PropAddress4L2`, `PropAddress4L3`, `PropAddress4Email`, `PropAddress4TelNum`, `PropAddress4City`, `PropAddress4State`, `PropAddress4Country`, `PropAddress4PostCode`, `PropAddress5L1`, `PropAddress5L2`, `PropAddress5L3`, `PropAddress5Email`, `PropAddress5TelNum`, `PropAddress5City`, `PropAddress5State`, `PropAddress5Country`, `PropAddress5PostCode`, `LoanDateAggrmnt`, `FirstUtilisationDate`, `AmountAdvancedonFUD`, `OriginalCommitmentAmount`, `FirstInterestPaymentDate`, `PaymentFrequency`, `IsSignOff`, `SignOffDate`, `SignoffBy`, `IsActive`, `CreatedDate`, `CreatedBy`, `LastModifiedDate`, `IsMappedToTask`, `LastModifiedBy`, `Res1`, `Res2`, `Res3`, `Res4`, `Res5`, `Res6`, `Res7`, `Res8`, `Res9`, `Res10`) VALUES
	(1, '1234', 'Investment Loan', 'sxx', 'Yes', NULL, 'company name', 'add', 'ss', 'ws', 'sa', 'ss', 'ss', 'ss', 'ss', 'qs', '123', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'ddd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-03-21', '2018-03-21', 1.00, 1.00, '2018-03-21', 1, 'Y', '0001-01-01 00:00:00', NULL, 'N', '2018-03-21 16:22:01', NULL, NULL, 'Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_client` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_clienttask_mapping
DROP TABLE IF EXISTS `tbl_clienttask_mapping`;
CREATE TABLE IF NOT EXISTS `tbl_clienttask_mapping` (
  `ClientNumber` varchar(150) DEFAULT NULL,
  `TaskId` varchar(50) DEFAULT NULL,
  `Reserved1` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_clienttask_mapping: ~5 rows (approximately)
DELETE FROM `tbl_clienttask_mapping`;
/*!40000 ALTER TABLE `tbl_clienttask_mapping` DISABLE KEYS */;
INSERT INTO `tbl_clienttask_mapping` (`ClientNumber`, `TaskId`, `Reserved1`) VALUES
	('23', '8', NULL),
	('1234', '1', NULL),
	('1234', '27', NULL),
	('1234', '25', NULL),
	('24', '4', NULL);
/*!40000 ALTER TABLE `tbl_clienttask_mapping` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_country_master
DROP TABLE IF EXISTS `tbl_country_master`;
CREATE TABLE IF NOT EXISTS `tbl_country_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CountryName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_country_master: ~15 rows (approximately)
DELETE FROM `tbl_country_master`;
/*!40000 ALTER TABLE `tbl_country_master` DISABLE KEYS */;
INSERT INTO `tbl_country_master` (`id`, `CountryName`) VALUES
	(1, 'India2'),
	(2, 'England'),
	(3, 'gggfd'),
	(4, 'Tested'),
	(5, 'dfd'),
	(6, 'asd'),
	(7, 'safdasdf'),
	(8, 'sadfasdf'),
	(9, 'asdfasdf'),
	(10, 'asdf'),
	(11, 'asdfasd'),
	(12, 'test'),
	(13, 'Test'),
	(14, 'test'),
	(15, 'test');
/*!40000 ALTER TABLE `tbl_country_master` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_onboarding_task
DROP TABLE IF EXISTS `tbl_onboarding_task`;
CREATE TABLE IF NOT EXISTS `tbl_onboarding_task` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UniqueEmailId` varchar(100) DEFAULT NULL,
  `EmailId` varchar(200) DEFAULT NULL,
  `ClientNumber` varchar(30) DEFAULT NULL,
  `EmailSubject` varchar(1000) DEFAULT NULL,
  `EmailContent` text,
  `EmailAttachment` text,
  `IsMappedToTask` varchar(1) DEFAULT NULL,
  `IsActive` varchar(1) DEFAULT NULL,
  `IsProcessed` varchar(1) DEFAULT NULL,
  `TaskId` varchar(30) DEFAULT NULL,
  `TaskAttachement` text,
  `TaskComments` text,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `TaskAssignedBy` varchar(100) DEFAULT NULL,
  `Type` varchar(100) DEFAULT NULL,
  `TaskAssignedDate` datetime DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_onboarding_task: ~9 rows (approximately)
DELETE FROM `tbl_onboarding_task`;
/*!40000 ALTER TABLE `tbl_onboarding_task` DISABLE KEYS */;
INSERT INTO `tbl_onboarding_task` (`Id`, `UniqueEmailId`, `EmailId`, `ClientNumber`, `EmailSubject`, `EmailContent`, `EmailAttachment`, `IsMappedToTask`, `IsActive`, `IsProcessed`, `TaskId`, `TaskAttachement`, `TaskComments`, `CreatedDate`, `CreatedBy`, `TaskAssignedBy`, `Type`, `TaskAssignedDate`, `LastModifiedDate`, `LastModifiedBy`, `Res1`, `Res2`, `Res3`, `Res4`, `Res5`, `Res6`, `Res7`, `Res8`, `Res9`, `Res10`) VALUES
	(23, '<PN1PR01MB01754671E3073D11DDE971C1C48B0@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', '<PN1PR01MB01754671E3073D11DDE971C1C48B0@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', '12453', 'Fw: Test 12453 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color: rgb(0, 0, 0);">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Sunday, August 6, 2017 3:27 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> Test </font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p>testing subjecce</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'new doc 2017-06-06 17.34.40_20170606173456.pdf,', 'Y', 'Y', 'N', '8', 'test desjk.txt', NULL, '2017-08-09 00:00:00', 'savvyjayakumar@outlook.com', NULL, 'EMAIL', '2017-08-10 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(24, '<PN1PR01MB017552B43CF87F60003D9972C4890@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', 'savvyjayakumar@outlook.com', '34121', 'Fw: Test 34121 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p>testing</p>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'new doc 2017-06-06 17.34.40_20170606173456.pdf,', 'Y', 'Y', 'N', '2', '4334771-4823198161-600041.pdf', 'Test com', '2017-08-11 00:00:00', 'savvyjayakumar@outlook.com', NULL, 'EMAIL', '2017-08-11 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(26, '<PN1PR01MB01759455E412C6E3B29C926EC4890@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', 'savvyjayakumar@outlook.com', '1234567', '1234567 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p>jay test</p>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'Custom Report Pending point Status till 8 Aug_Customer care Inbound.xlsx,', 'N', 'Y', 'N', '17', NULL, NULL, '2017-08-11 00:00:00', 'savvyjayakumar@outlook.com', NULL, 'EMAIL', '2017-08-11 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(28, '<PN1PR01MB017551FBE17EF2BAF90E8B46C4890@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', 'savvyjayakumar@outlook.com', '12345678', 'Fw: 12345678 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color: rgb(0, 0, 0);">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:28 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> Fw: 1234567</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color:rgb(0,0,0)">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:24 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> 1234567</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p>jay test</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'cobasclientschema.sql,', 'N', 'Y', 'N', NULL, NULL, NULL, '2017-08-11 00:00:00', 'savvyjayakumar@outlook.com', NULL, 'EMAIL', '2017-08-11 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(29, '<PN1PR01MB0175C619E763F9EBC54815C7C4890@PN1PR01MB0175.INDPRD01.PROD.OUTLOOK.COM>', 'savvyjayakumar@outlook.com', '123456789', 'Fw: 123456789 (Trial Version)', '<html><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\r\n<style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>\r\n</head>\r\n<body dir="ltr">\r\n<div id="divtagdefaultwrapper" style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;" dir="ltr">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color: rgb(0, 0, 0);">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:36 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> Fw: 12345678</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color:rgb(0,0,0)">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:28 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> Fw: 1234567</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p><br>\r\n</p>\r\n<br>\r\n<br>\r\n<div style="color:rgb(0,0,0)">\r\n<hr tabindex="-1" style="display:inline-block; width:98%">\r\n<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" color="#000000" style="font-size:11pt"><b>From:</b> jayakumar T &lt;savvyjayakumar@outlook.com&gt;<br>\r\n<b>Sent:</b> Friday, August 11, 2017 8:24 PM<br>\r\n<b>To:</b> jayakumar T<br>\r\n<b>Subject:</b> 1234567</font>\r\n<div></div>\r\n</div>\r\n<div>\r\n<div id="divtagdefaultwrapper" dir="ltr" style="font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-serif">\r\n<p>jay test</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</body>\r\n</html>\r\n\r\n', 'cobasclientschema.sql,', 'N', 'Y', 'N', NULL, NULL, NULL, '2017-08-11 00:00:00', 'savvyjayakumar@outlook.com', NULL, 'EMAIL', '2017-08-11 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(30, '<CAKzhRk1=T=3ds-A8KLm3xfF814VfqVUHD_qq0auBp9j7cVyKQg@mail.gmail.com>', 'sthirupathikumar@gmail.com', '12131415', '12131415 (Trial Version)', '<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">This is test mail<br clear="all"><div><br></div>-- <br><div class="gmail_signature" data-smartmail="gmail_signature">Regards,<br>Thirupathi<br></div>\r\n</div>\r\n\r\n', 'wr1.doc,', 'N', 'Y', 'N', '2', NULL, NULL, '2017-08-15 00:00:00', 'sthirupathikumar@gmail.com', NULL, 'EMAIL', '2017-08-15 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(33, '<CAE_CuUi6iNDkHPbd-p4ctE7EYNfvu115b7MYNQeXMgxaxXQDEQ@mail.gmail.com>', 'honikeyan@gmail.com', '11111123444', 'Fwd: CLient ID : 11111123444 (Trial Version)', '<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br><div class="gmail_quote">---------- Forwarded message ----------<br>From: <b class="gmail_sendername">Kar A</b> <span dir="ltr">&lt;<a href="mailto:honikeyan@gmail.com">honikeyan@gmail.com</a>&gt;</span><br>Date: Tue, Aug 15, 2017 at 10:46 PM<br>Subject: CLient ID : 11111123444<br>To: <a href="mailto:savvjayakumar@outlook.com">savvjayakumar@outlook.com</a><br><br><br><div dir="ltr"><br></div>\r\n</div><br></div>\r\n\r\n', 'Test mail.pptx,', 'N', 'Y', 'N', '5', NULL, NULL, '2017-08-15 00:00:00', 'honikeyan@gmail.com', NULL, 'EMAIL', '2017-08-15 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(34, '5Q9F3CQ6K3U4.F6KYOD2MSJQG3@CY1SCH030020339', 'account-security-noreply@accountprotection.microsoft.com', '', 'Microsoft account unusual sign-in activity', '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml" dir="ltr"><head>\r\n<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252"><style type="text/css">\r\n .link:link, .link:active, .link:visited {\r\n       color:#2672ec !important;\r\n       text-decoration:none !important;\r\n }\r\n\r\n .link:hover {\r\n       color:#4284ee !important;\r\n       text-decoration:none !important;\r\n }\r\n</style>\r\n<title></title>\r\n</head>\r\n<body>\r\n<table dir="ltr">\r\n      <tr><td id="i1" style="padding:0; font-family:\'Segoe UI Semibold\', \'Segoe UI Bold\', \'Segoe UI\', \'Helvetica Neue Medium\', Arial, sans-serif; font-size:17px; color:#707070;">Microsoft account</td></tr>\r\n      <tr><td id="i2" style="padding:0; font-family:\'Segoe UI Light\', \'Segoe UI\', \'Helvetica Neue Medium\', Arial, sans-serif; font-size:41px; color:#2672ec;">Verify your account</td></tr>\r\n      <tr><td id="i3" style="padding:0; padding-top:25px; font-family:\'Segoe UI\', Tahoma, Verdana, Arial, sans-serif; font-size:14px; color:#2a2a2a;">We detected something unusual about a recent sign-in for the Microsoft account <a dir="ltr" id="iAccount" class="link" style="color:#2672ec; text-decoration:none" href="mailto:sa*****@outlook.com">sa*****@outlook.com</a>. For example, you might be signing in from a new location, device, or app.</td></tr>\r\n      <tr><td id="i4" style="padding:0; padding-top:25px; font-family:\'Segoe UI\', Tahoma, Verdana, Arial, sans-serif; font-size:14px; color:#2a2a2a;">To help keep you safe, we\'ve blocked access to your inbox, contacts list, and calendar for that sign-in. Please review your recent activity and we\'ll help you take corrective action. To regain access, you\'ll need to confirm that the recent activity was yours.</td></tr>\r\n      <tr><td style="padding:0; padding-top:25px; font-family:\'Segoe UI\', Tahoma, Verdana, Arial, sans-serif; font-size:14px; color:#2a2a2a;">\r\n         <table border="0" cellspacing="0"><tr><td bgcolor="#2672ec" style="background-color:#2672ec; padding-top: 5px; padding-right: 20px; padding-bottom: 5px; padding-left: 20px; min-width:50px;"><a id="i5" style="font-family: \'Segoe UI Semibold\', \'Segoe UI Bold\', \'Segoe UI\', \'Helvetica Neue Medium\', Arial, sans-serif; font-size:14px; text-align:center; text-decoration:none; font-weight:600; letter-spacing:0.02em; color:#fff;" href="https://account.microsoft.com/activity">Review recent activity</a></td></tr></table>\r\n      </td></tr>\r\n      <tr><td id="i6" style="padding:0; padding-top:25px; font-family:\'Segoe UI\', Tahoma, Verdana, Arial, sans-serif; font-size:14px; color:#2a2a2a;">Thanks,</td></tr>\r\n      <tr><td id="i7" style="padding:0; font-family:\'Segoe UI\', Tahoma, Verdana, Arial, sans-serif; font-size:14px; color:#2a2a2a;">The Microsoft account team</td></tr>\r\n</table>\r\n</body>\r\n</html>', NULL, 'N', 'Y', 'N', NULL, NULL, NULL, '2018-02-04 00:00:00', 'account-security-noreply@accountprotection.microsoft.com', NULL, 'EMAIL', '2018-02-04 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(35, NULL, NULL, '1234', NULL, NULL, NULL, 'N', 'Y', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'DIRECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_onboarding_task` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_region_master
DROP TABLE IF EXISTS `tbl_region_master`;
CREATE TABLE IF NOT EXISTS `tbl_region_master` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RegionName` varchar(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_region_master: ~2 rows (approximately)
DELETE FROM `tbl_region_master`;
/*!40000 ALTER TABLE `tbl_region_master` DISABLE KEYS */;
INSERT INTO `tbl_region_master` (`Id`, `RegionName`) VALUES
	(1, 'Region'),
	(2, 'Region1');
/*!40000 ALTER TABLE `tbl_region_master` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_right_master
DROP TABLE IF EXISTS `tbl_right_master`;
CREATE TABLE IF NOT EXISTS `tbl_right_master` (
  `RightID` int(11) DEFAULT NULL,
  `RightName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `MenuName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Path` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Icon` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ShowMenu` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `IsActive` varchar(2) DEFAULT NULL,
  `ordersequence` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_right_master: ~28 rows (approximately)
DELETE FROM `tbl_right_master`;
/*!40000 ALTER TABLE `tbl_right_master` DISABLE KEYS */;
INSERT INTO `tbl_right_master` (`RightID`, `RightName`, `MenuName`, `Path`, `Icon`, `ShowMenu`, `IsActive`, `ordersequence`) VALUES
	(1, 'Dashboard Read', 'Home', 'Index', 'fa fa-dashboard', 'true', 'Y', 1),
	(2, 'Dashboard Write', 'Home', 'Index', 'fa fa-dashboard', 'true', 'N', 2),
	(3, 'Clients Read', 'Client Management', 'Clients', 'fa fa-list', 'true', 'Y', 3),
	(4, 'Clients Write', 'Client Management', 'Clients', 'fa fa-list', 'true', 'Y', 4),
	(5, 'Tasks Read', 'Task Management', 'Tasks', 'fa fa-list-alt', 'true', 'Y', 5),
	(6, 'Tasks Write', 'Task Management', 'Tasks', 'fa fa-list-alt', 'true', 'Y', 6),
	(7, 'Map Email Task  Read', 'Map Email To Task', 'MapTask', 'fa fa-reply-all', 'true', 'Y', NULL),
	(8, 'Map Email Task  Write', 'Map Email To Task', 'MapTask', 'fa fa-reply-all', 'true', 'Y', NULL),
	(12, 'OnBoarding Tasks Read', 'OnBoarding Task', 'OnBoardingTasks', 'fa fa-list-alt', 'true', 'Y', NULL),
	(13, 'OnBoarding Tasks Write', 'OnBoarding Task', 'OnBoardingTasks', 'fa fa-list-alt', 'true', 'Y', NULL),
	(14, 'Email Read', 'Email', 'Emails', 'fa fa-list-alt', 'true', 'Y', NULL),
	(15, 'Email Write', 'Email', 'Emails', 'fa fa-list-alt', 'true', 'Y', NULL),
	(33, 'Reports', 'Reports', 'Reports', 'fa fa-list-alt', 'true', 'Y', NULL),
	(16, 'Licensing Read', 'Licensing', 'Licensing', 'fa fa-list-alt', 'true', 'N', NULL),
	(17, 'Licensing Write', 'Licensing', 'Licensing', 'fa fa-list-alt', 'true', 'N', NULL),
	(18, 'User Management Read', 'User Management', 'UserManagement', 'fa fa-users', 'true', 'Y', NULL),
	(19, 'User Management Write', 'User Management', 'UserManagement', 'fa fa-users', 'true', 'Y', NULL),
	(20, 'Role Management Read', 'Role Management', 'RoleManagement', 'fa fa-list-alt', 'true', 'Y', NULL),
	(21, 'Role Management Write', 'Role Management', 'RoleManagement', 'fa fa-list-alt', 'true', 'Y', NULL),
	(22, 'Country Read', 'Country', 'Country', 'fa fa-globe', 'true', 'Y', NULL),
	(23, 'Country Write', 'Country', 'Country', 'fa fa-globe', 'true', 'Y', NULL),
	(24, 'Region Read', 'Region', 'Region', 'fa fa-crosshairs', 'true', 'Y', NULL),
	(25, 'Region Write', 'Region', 'Region', 'fa fa-crosshairs', 'true', 'Y', NULL),
	(26, 'Business Line Read', 'Business Line ', 'BusinessLine', 'fa fa-handshake-o', 'true', 'Y', NULL),
	(27, 'Business Line Write', 'Business Line ', 'BusinessLine', 'fa fa-handshake-o', 'true', 'Y', NULL),
	(32, 'Utilities', 'Utilities', 'Utilities', 'fa fa-list-alt', 'true', 'N', NULL),
	(10, 'Map Clientl Task  Read', 'Map Client To Task', 'MapClientTask', 'fa fa-reply-all', 'true', 'Y', 7),
	(11, 'Map Client Task  Write', 'Map Client To Task', 'MapClientTask', 'fa fa-reply-all', 'true', 'Y', 8);
/*!40000 ALTER TABLE `tbl_right_master` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_roleright_mapping
DROP TABLE IF EXISTS `tbl_roleright_mapping`;
CREATE TABLE IF NOT EXISTS `tbl_roleright_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `RoleID` int(11) DEFAULT NULL,
  `RightID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_roleright_mapping: ~22 rows (approximately)
DELETE FROM `tbl_roleright_mapping`;
/*!40000 ALTER TABLE `tbl_roleright_mapping` DISABLE KEYS */;
INSERT INTO `tbl_roleright_mapping` (`id`, `RoleID`, `RightID`) VALUES
	(27, 5, 13),
	(28, 5, 5),
	(29, 5, 6),
	(30, 5, 1),
	(31, 5, 3),
	(32, 5, 4),
	(33, 5, 7),
	(34, 5, 8),
	(35, 5, 9),
	(36, 5, 10),
	(37, 5, 18),
	(38, 5, 19),
	(39, 5, 20),
	(40, 5, 21),
	(41, 5, 22),
	(42, 5, 23),
	(43, 5, 24),
	(44, 5, 25),
	(45, 5, 26),
	(46, 5, 27),
	(47, 5, 33),
	(48, 5, 34);
/*!40000 ALTER TABLE `tbl_roleright_mapping` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_role_master
DROP TABLE IF EXISTS `tbl_role_master`;
CREATE TABLE IF NOT EXISTS `tbl_role_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `ModifiedBy` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_role_master: ~1 rows (approximately)
DELETE FROM `tbl_role_master`;
/*!40000 ALTER TABLE `tbl_role_master` DISABLE KEYS */;
INSERT INTO `tbl_role_master` (`id`, `RoleName`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`) VALUES
	(5, 'Super user', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_role_master` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_task
DROP TABLE IF EXISTS `tbl_task`;
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_task: ~27 rows (approximately)
DELETE FROM `tbl_task`;
/*!40000 ALTER TABLE `tbl_task` DISABLE KEYS */;
INSERT INTO `tbl_task` (`Id`, `Name`, `Description`, `IsSignOff`, `SignOffDate`, `SignoffBy`, `IsActive`, `CreatedDate`, `CreatedBy`, `LastModifiedDate`, `LastModifiedBy`, `Res1`, `Res2`, `Res3`, `Res4`, `Res5`, `Res6`, `Res7`, `Res8`, `Res9`, `Res10`) VALUES
	(1, 'Credit/Facility Agreement-executed version/conformed copy', 'Credit/Facility Agreement-executed version/conformed copy', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'Bible of Docs (if unavailable, pls provide a list of all documentation held)', 'Bible of Docs (if unavailable, pls provide a list of all documentation held)', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'Conditions Subsequent Satisfaction Letter (incl. all documentation) as applicable', 'Conditions Subsequent Satisfaction Letter (incl. all documentation) as applicable', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 'Documentation pertaining to the Security Package(i.e. Deed of Charge, Share Pledge(s), etc.)', 'Documentation pertaining to the Security Package(i.e. Deed of Charge, Share Pledge(s), etc.)', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 'Duty of Care re Property Management', 'Duty of Care re Property Management', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 'Report on Title/Certificate on Title/Legal Due Diligence Package', 'Report on Title/Certificate on Title/Legal Due Diligence Package', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(7, 'All Legal Letters/Notices for the life of the Loan(i.e. Consents/Waivers/Reservation o', 'All Legal Letters/Notices for the life of the Loan(i.e. Consents/Waivers/Reservation o', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 'All Release Documentation (i.e. Mortgage/Legal Charge/Security)', 'All Release Documentation (i.e. Mortgage/Legal Charge/Security)', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 'Whole-loan/Unsecuritised Hedging Documentation - as applicable', 'Whole-loan/Unsecuritised Hedging Documentation - as applicable', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 'Control Account Bank Mandates & Signature List', 'Control Account Bank Mandates & Signature List', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 'Other (pls list and provide details in "comments" field)', 'Other (pls list and provide details in "comments" field)', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(12, 'Offering Cricular/Prospectus/Syndication Document', 'Offering Cricular/Prospectus/Syndication Document', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(13, 'All Servicing Agreements (Direct/Indirect/Loan-specific)', 'All Servicing Agreements (Direct/Indirect/Loan-specific)', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(14, 'All relevant Intercreditor Deeds - as applicable', 'All relevant Intercreditor Deeds - as applicable', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(15, 'Deed of Charge', 'Deed of Charge', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(16, 'Cash Management Agreement-as applicable', 'Cash Management Agreement-as applicable', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(17, 'Master Definitions Schedule ("MDS")', 'Master Definitions Schedule ("MDS")', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:24', 'THIRUPATHI', '2017-07-02 13:53:24', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(18, 'All Powers of Attorney in favour of the Special Servicer', 'All Powers of Attorney in favour of the Special Servicer', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:25', 'THIRUPATHI', '2017-07-02 13:53:25', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(19, 'Securitised Loan Hedging Documentation', 'Securitised Loan Hedging Documentation', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:25', 'THIRUPATHI', '2017-07-02 13:53:25', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(20, 'Liquidity Facility Agreement', 'Liquidity Facility Agreement', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:25', 'THIRUPATHI', '2017-07-02 13:53:25', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(21, 'Written Confirmation identifying any Operating Adviser', 'Written Confirmation identifying any Operating Adviser', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:25', 'THIRUPATHI', '2017-07-02 13:53:25', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(22, 'Details of Appraisal Reductions/Control Valuation Events', 'Details of Appraisal Reductions/Control Valuation Events', 'Y', '2017-07-02 00:00:00', 'THIRUPATHI', 'Y', '2017-07-02 13:53:25', 'THIRUPATHI', '2017-07-02 13:53:25', 'THIRUPATHI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(23, 'asd', 'SAD', 'Y', NULL, NULL, 'Y', '2017-08-10 00:00:00', '', '2017-08-10 00:00:00', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(24, 'testing1', '2131', 'N', NULL, NULL, 'N', '2017-08-12 00:00:00', '', '2017-08-17 00:00:00', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(25, 'Teest si', '123', 'N', NULL, NULL, 'Y', '2017-08-15 00:00:00', '', '2017-08-17 00:00:00', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(26, 'asdfa', 'sfgsdf', 'Y', NULL, NULL, 'Y', '2017-08-17 00:00:00', '', '2017-08-17 00:00:00', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(27, 'testjay', 'eee', 'Y', NULL, NULL, 'Y', '2018-01-21 00:00:00', '', '2018-01-21 00:00:00', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_task` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_userbusinesssectormapping
DROP TABLE IF EXISTS `tbl_userbusinesssectormapping`;
CREATE TABLE IF NOT EXISTS `tbl_userbusinesssectormapping` (
  `Userid` varchar(250) NOT NULL,
  `BusinessSectorId` int(11) NOT NULL,
  `Reserved1` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table coba.tbl_userbusinesssectormapping: ~7 rows (approximately)
DELETE FROM `tbl_userbusinesssectormapping`;
/*!40000 ALTER TABLE `tbl_userbusinesssectormapping` DISABLE KEYS */;
INSERT INTO `tbl_userbusinesssectormapping` (`Userid`, `BusinessSectorId`, `Reserved1`) VALUES
	('afsa', 1, NULL),
	('test1234', 1, NULL),
	('new user', 1, NULL),
	('new user', 2, NULL),
	('Jayakumar', 2, NULL),
	('Jayakumar', 1, NULL),
	('Sivakumar', 1, NULL);
/*!40000 ALTER TABLE `tbl_userbusinesssectormapping` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_usercountrymapping
DROP TABLE IF EXISTS `tbl_usercountrymapping`;
CREATE TABLE IF NOT EXISTS `tbl_usercountrymapping` (
  `Userid` varchar(250) NOT NULL,
  `CountryId` int(11) NOT NULL,
  `Reserved1` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table coba.tbl_usercountrymapping: ~5 rows (approximately)
DELETE FROM `tbl_usercountrymapping`;
/*!40000 ALTER TABLE `tbl_usercountrymapping` DISABLE KEYS */;
INSERT INTO `tbl_usercountrymapping` (`Userid`, `CountryId`, `Reserved1`) VALUES
	('afsa', 7, NULL),
	('test1234', 2, NULL),
	('new user', 2, NULL),
	('Jayakumar', 1, NULL),
	('Sivakumar', 1, NULL);
/*!40000 ALTER TABLE `tbl_usercountrymapping` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_userregionmapping
DROP TABLE IF EXISTS `tbl_userregionmapping`;
CREATE TABLE IF NOT EXISTS `tbl_userregionmapping` (
  `Userid` varchar(250) NOT NULL,
  `RegionId` int(11) NOT NULL,
  `Reserved1` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table coba.tbl_userregionmapping: ~7 rows (approximately)
DELETE FROM `tbl_userregionmapping`;
/*!40000 ALTER TABLE `tbl_userregionmapping` DISABLE KEYS */;
INSERT INTO `tbl_userregionmapping` (`Userid`, `RegionId`, `Reserved1`) VALUES
	('afsa', 2, NULL),
	('test1234', 2, NULL),
	('new user', 1, NULL),
	('new user', 2, NULL),
	('Jayakumar', 1, NULL),
	('Jayakumar', 2, NULL),
	('Sivakumar', 2, NULL);
/*!40000 ALTER TABLE `tbl_userregionmapping` ENABLE KEYS */;

-- Dumping structure for table coba.tbl_user_master
DROP TABLE IF EXISTS `tbl_user_master`;
CREATE TABLE IF NOT EXISTS `tbl_user_master` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Userid` varchar(255) CHARACTER SET utf8 NOT NULL,
  `UserName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `BusinessSectorId` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `RoleId` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
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
  PRIMARY KEY (`Userid`),
  UNIQUE KEY `Id` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Dumping data for table coba.tbl_user_master: ~7 rows (approximately)
DELETE FROM `tbl_user_master`;
/*!40000 ALTER TABLE `tbl_user_master` DISABLE KEYS */;
INSERT INTO `tbl_user_master` (`Id`, `Userid`, `UserName`, `BusinessSectorId`, `RoleId`, `Password`, `EmailId`, `MobileNumber`, `CustomData`, `Status`, `UserExpiryDate`, `PasswordExpiryDate`, `UserBlockDate`, `AttemptTries`, `LastAuthenticatedDate`, `LastUsedDate`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`, `ApprovedDate`, `Approvedby`, `MakerComment`, `CheckerComment`, `IsADUser`, `RegionId`, `CountryId`, `FirstWorkingDate`, `LastWorkingDate`, `LocationId`) VALUES
	(8, 'afsa', 'adf', NULL, '5', 'c3NkZnNkZg==', 'dd@dd.co', NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', NULL, NULL, NULL, NULL, NULL),
	(6, 'Jayakumar', 'Jayakumar', NULL, '5', 'd2VsY29tZQ==', 'jayakumar@test.com', NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', NULL, NULL, NULL, NULL, NULL),
	(11, 'new user', 'test', NULL, '5', 'd2VsY29tZQ==', 'test@mail.com', NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', NULL, NULL, NULL, NULL, NULL),
	(5, 'Sivakumar', 'SivaKumar', NULL, '5', NULL, 'Sivakumar@coba.com', NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', NULL, NULL, NULL, NULL, NULL),
	(12, 'test1234', 'test12345', NULL, '5', 'MTIzNDU2', 'testjay@gmail.com', NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', NULL, NULL, NULL, NULL, NULL),
	(10, 'testuser', 'test', NULL, '5', 'd2VsY29tZQ==', 'test@mail.com', NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', NULL, NULL, NULL, NULL, NULL),
	(7, 'Thiru', 'thirupathi', '1', '5', 'd2VsY29tZQ==', 'thirupathi@test.com', NULL, NULL, 'Active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 1, 3, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_user_master` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

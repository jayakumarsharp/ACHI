using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace COBA.Models
{

    public class TaskMaster
    {
        public string Id { get; set; }
        public string Name { get; set; }

    }


    public class CountryMaster
    {
        public string Id { get; set; }
        public string CountryName { get; set; }

    }

    public class RegionMaster
    {
        public string Id { get; set; }
        public string RegionName { get; set; }

    }


    public class BusinessSector
    {
        public string Id { get; set; }
        public string BusinessSectorName { get; set; }

    }
    public class Emails
    {
        public string IsMappedToTask { get; set; }
        public string IsActive { get; set; }
        public string IsProcessed { get; set; }
        public string TaskId { get; set; }
        public string TaskAttachement { get; set; }
        public string TaskComments { get; set; }
        public string CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public string TaskAssignedBy { get; set; }
        public string TaskAssignedDate { get; set; }
        public string LastModifiedDate { get; set; }
        public string LastModifiedBy { get; set; }
        public int Id { get; set; }
        public string UniqueEmailId { get; set; }
        public string EmailId { get; set; }
        public string ClientNumber { get; set; }
        public string EmailSubject { get; set; }
        public string EmailContent { get; set; }
        public string EmailAttachment { get; set; }

    }



    public class MapTasks
    {
        public string IsMappedToTask { get; set; }
        public string IsActive { get; set; }
        public string IsProcessed { get; set; }
        public string TaskId { get; set; }
        public string TaskName { get; set; }
        public string TaskAttachement { get; set; }
        public string TaskComments { get; set; }
        public string CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public string TaskAssignedBy { get; set; }
        public string TaskAssignedDate { get; set; }
        public string LastModifiedDate { get; set; }
        public string LastModifiedBy { get; set; }
        public int Id { get; set; }
        public string UniqueEmailId { get; set; }
        public string EmailId { get; set; }
        public string ClientNumber { get; set; }
        public string EmailSubject { get; set; }
        public string EmailContent { get; set; }
        public string EmailAttachment { get; set; }
        public List<TaskMaster> TaskmasterList { get; set; }
    }





    public class OnboardingTasks
    {

        public string filename { get; set; }
        public string IsMappedToTask { get; set; }
        public string IsActive { get; set; }
        public string IsProcessed { get; set; }
        public string TaskId { get; set; }
        public string TaskName { get; set; }
        public string TaskAttachement { get; set; }
        public string TaskComments { get; set; }
        public string CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public string TaskAssignedBy { get; set; }
        public string TaskAssignedDate { get; set; }
        public string LastModifiedDate { get; set; }
        public string LastModifiedBy { get; set; }
        public int Id { get; set; }
        public string UniqueEmailId { get; set; }
        public string EmailId { get; set; }
        public string ClientNumber { get; set; }
        public string EmailSubject { get; set; }
        public string EmailContent { get; set; }
        public string EmailAttachment { get; set; }

        public HttpPostedFileBase Attachment { get; set; }
    }


    public class Tasks
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string IsSignOff { get; set; }
        public string SignOffDate { get; set; }
        public string SignoffBy { get; set; }
        public string IsActive { get; set; }

    }


    public class Client
    {
        public string ClientNumber { get; set; }
        public string InvDevLoan { get; set; }
        public string ObligorName { get; set; }
        public string StrChartAttchd { get; set; }
        public string OriginalLender { get; set; }
        public string LCompanyName { get; set; }
        public string LRegAddressL1 { get; set; }
        public string LRegAddressL2 { get; set; }
        public string LRegAddressL3 { get; set; }
        public string LRegAddressCity { get; set; }
        public string LRegAddressEmail { get; set; }
        public string LRegAddressTelNum { get; set; }
        public string LRegAddressState { get; set; }
        public string LRegAddressCountry { get; set; }
        public string LRegAddressPostCode { get; set; }
        public string LPriAddressL1 { get; set; }
        public string LPriAddressL2 { get; set; }
        public string LPriAddressL3 { get; set; }
        public string LPriAddressEmail { get; set; }
        public string LPriAddressTelNum { get; set; }
        public string LPriAddressCity { get; set; }
        public string LPriAddressState { get; set; }
        public string LPriAddressCountry { get; set; }
        public string LPriAddressPostCode { get; set; }
        public string LRegAddress { get; set; }
        public string LPrimaryAddress { get; set; }
        public string LKC1L1 { get; set; }
        public string LKC1L2 { get; set; }
        public string LKC1L3 { get; set; }
        public string LKC1City { get; set; }
        public string LKC1State { get; set; }
        public string LKC1Country { get; set; }
        public string LKC1PostCode { get; set; }
        public string LKC1Email { get; set; }
        public string LKC1TelNum { get; set; }
        public string LKC2L1 { get; set; }
        public string LKC2L2 { get; set; }
        public string LKC2L3 { get; set; }
        public string LKC2City { get; set; }
        public string LKC2State { get; set; }
        public string LKC2Country { get; set; }
        public string LKC2PostCode { get; set; }
        public string LKC2Email { get; set; }
        public string LKC2TelNum { get; set; }
        public string LKC3L1 { get; set; }
        public string LKC3L2 { get; set; }
        public string LKC3L3 { get; set; }
        public string LKC3City { get; set; }
        public string LKC3State { get; set; }
        public string LKC3Country { get; set; }
        public string LKC3PostCode { get; set; }
        public string LKC3Email { get; set; }
        public string LKC3TelNum { get; set; }
        public string LKC4L1 { get; set; }
        public string LKC4L2 { get; set; }
        public string LKC4L3 { get; set; }
        public string LKC4City { get; set; }
        public string LKC4State { get; set; }
        public string LKC4Country { get; set; }
        public string LKC4PostCode { get; set; }
        public string LKC4Email { get; set; }
        public string LKC4TelNum { get; set; }
        public string LKC5L1 { get; set; }
        public string LKC5L2 { get; set; }
        public string LKC5L3 { get; set; }
        public string LKC5City { get; set; }
        public string LKC5State { get; set; }
        public string LKC5Country { get; set; }
        public string LKC5PostCode { get; set; }
        public string LKC5Email { get; set; }
        public string LKC5TelNum { get; set; }
        public string BCompanyName { get; set; }
        public string BRegAddressL1 { get; set; }
        public string BRegAddressL2 { get; set; }
        public string BRegAddressL3 { get; set; }
        public string BRegAddressCity { get; set; }
        public string BRegAddressEmail { get; set; }
        public string BRegAddressTelNum { get; set; }
        public string BRegAddressState { get; set; }
        public string BRegAddressCountry { get; set; }
        public string BRegAddressPostCode { get; set; }
        public string BPriAddressL1 { get; set; }
        public string BPriAddressL2 { get; set; }
        public string BPriAddressL3 { get; set; }
        public string BPriAddressEmail { get; set; }
        public string BPriAddressTelNum { get; set; }
        public string BPriAddressCity { get; set; }
        public string BPriAddressState { get; set; }
        public string BPriAddressCountry { get; set; }
        public string BPriAddressPostCode { get; set; }
        public string BRegAddress { get; set; }
        public string BPrimaryAddress { get; set; }
        public string BKC1L1 { get; set; }
        public string BKC1L2 { get; set; }
        public string BKC1L3 { get; set; }
        public string BKC1City { get; set; }
        public string BKC1State { get; set; }
        public string BKC1Country { get; set; }
        public string BKC1PostCode { get; set; }
        public string BKC1Email { get; set; }
        public string BKC1TelNum { get; set; }
        public string BKC2L1 { get; set; }
        public string BKC2L2 { get; set; }
        public string BKC2L3 { get; set; }
        public string BKC2City { get; set; }
        public string BKC2State { get; set; }
        public string BKC2Country { get; set; }
        public string BKC2PostCode { get; set; }
        public string BKC2Email { get; set; }
        public string BKC2TelNum { get; set; }
        public string BKC3L1 { get; set; }
        public string BKC3L2 { get; set; }
        public string BKC3L3 { get; set; }
        public string BKC3City { get; set; }
        public string BKC3State { get; set; }
        public string BKC3Country { get; set; }
        public string BKC3PostCode { get; set; }
        public string BKC3Email { get; set; }
        public string BKC3TelNum { get; set; }
        public string BKC4L1 { get; set; }
        public string BKC4L2 { get; set; }
        public string BKC4L3 { get; set; }
        public string BKC4City { get; set; }
        public string BKC4State { get; set; }
        public string BKC4Country { get; set; }
        public string BKC4PostCode { get; set; }
        public string BKC4Email { get; set; }
        public string BKC4TelNum { get; set; }
        public string BKC5L1 { get; set; }
        public string BKC5L2 { get; set; }
        public string BKC5L3 { get; set; }
        public string BKC5City { get; set; }
        public string BKC5State { get; set; }
        public string BKC5Country { get; set; }
        public string BKC5PostCode { get; set; }
        public string BKC5Email { get; set; }
        public string BKC5TelNum { get; set; }
        public string PropAddress1L1 { get; set; }
        public string PropAddress1L2 { get; set; }
        public string PropAddress1L3 { get; set; }
        public string PropAddress1City { get; set; }
        public string PropAddress1State { get; set; }
        public string PropAddress1Country { get; set; }
        public string PropAddress1PostCode { get; set; }
        public string PropAddress1Email { get; set; }
        public string PropAddress1TelNum { get; set; }
        public string PropAddress2L1 { get; set; }
        public string PropAddress2L2 { get; set; }
        public string PropAddress2L3 { get; set; }
        public string PropAddress2City { get; set; }
        public string PropAddress2State { get; set; }
        public string PropAddress2Country { get; set; }
        public string PropAddress2PostCode { get; set; }
        public string PropAddress2Email { get; set; }
        public string PropAddress2TelNum { get; set; }
        public string PropAddress3L1 { get; set; }
        public string PropAddress3L2 { get; set; }
        public string PropAddress3L3 { get; set; }
        public string PropAddress3City { get; set; }
        public string PropAddress3State { get; set; }
        public string PropAddress3Country { get; set; }
        public string PropAddress3PostCode { get; set; }
        public string PropAddress3Email { get; set; }
        public string PropAddress3TelNum { get; set; }
        public string PropAddress4L1 { get; set; }
        public string PropAddress4L2 { get; set; }
        public string PropAddress4L3 { get; set; }
        public string PropAddress4City { get; set; }
        public string PropAddress4State { get; set; }
        public string PropAddress4Country { get; set; }
        public string PropAddress4PostCode { get; set; }
        public string PropAddress4Email { get; set; }
        public string PropAddress4TelNum { get; set; }
        public string PropAddress5L1 { get; set; }
        public string PropAddress5L2 { get; set; }
        public string PropAddress5L3 { get; set; }
        public string PropAddress5City { get; set; }
        public string PropAddress5State { get; set; }
        public string PropAddress5Country { get; set; }
        public string PropAddress5PostCode { get; set; }
        public string PropAddress5Email { get; set; }
        public string PropAddress5TelNum { get; set; }
        public string ProposedDealCommencementDate { get; set; }
        public string LoanDateAggrmnt { get; set; }
        public string FirstUtilisationDate { get; set; }
        public string AmountAdvancedonFUD { get; set; }
        public string OriginalCommitmentAmount { get; set; }
        public string FirstInterestPaymentDate { get; set; }
        public string PaymentFrequency { get; set; }
        public string IsSignOff { get; set; }
        public DateTime SignOffDate { get; set; }
        public string SignoffBy { get; set; }
        public string IsActive { get; set; }
        public int Id { get; set; }

    }



    public class ADUserMaster
    {
        public string Userid { get; set; }
        public string UserName { get; set; }
        public string EmailId { get; set; }
    }
    public class UserMaster
    {
        public string ApprovedDate { get; set; }
        public string Approvedby { get; set; }
        public int AttemptedTries { get; set; }
        public string BusinessSectorId { get; set; }
        public string BusinessSector { get; set; }
        public string RegionId { get; set; }
        public string RegionName { get; set; }
        public string CountryId { get; set; }
        public string CountryName { get; set; }
        public string RoleId { get; set; }
        public string RoleName { get; set; }
        public string CheckerComment { get; set; }
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public string CustomData { get; set; }
        public string EmailId { get; set; }
        public string FirstWorkingDate { get; set; }
        public string IsADUser { get; set; }
        public string LastAuthenticatedDate { get; set; }
        public string LastUsedDate { get; set; }
        public string LastWorkingDate { get; set; }
        public int LocationId { get; set; }
        public string MakerComment { get; set; }
        public string MobileNumber { get; set; }
        public string ModifiedBy { get; set; }
        public string ModifiedDate { get; set; }
        public string Password { get; set; }
        public string PasswordExpiryDate { get; set; }
        public string Status { get; set; }
        public string UserBlockDate { get; set; }
        public string UserExpiryDate { get; set; }
        public string UserImage { get; set; }
        public string UserName { get; set; }
        public string userId { get; set; }
        public string Id { get; set; }



        public List<CountryMaster> CountryList { get; set; }
        public List<RegionMaster> RegionList { get; set; }
        public List<BusinessSector> BusinessSectorList { get; set; }

    }

    public class Roles
    {
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public string ModifiedDate { get; set; }
        public string RoleName { get; set; }
        public string id { get; set; }
    }



    public class RoleRightMapping
    {
        public string id { get; set; }
        public string RoleID { get; set; }
        public string RightID { get; set; }
        public string selectedRole { get; set; }
        public List<RightMaster> Rights { get; set; }
    }

    public class RightMaster
    {
        public string Icon { get; set; }
        public string MenuName { get; set; }
        public string Path { get; set; }
        public string RightID { get; set; }
        public string RightName { get; set; }
        public string ShowMenu { get; set; }
        public string id { get; set; }

    }



    public class BusinessLineMaster
    {
        public string Id { get; set; }
        public string BusinessLine { get; set; }

    }


}
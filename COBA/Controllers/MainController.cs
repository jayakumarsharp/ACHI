using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace CRMManagement.Controllers
{
    public class MainController : Controller
    {
        private DbOperations _dbOperations = new DbOperations();

        //
        // GET: /Main/

        [SessionTimeout]
        public ActionResult Country()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult BusinessSector()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult RoleManagement()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult UserManagement()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult Region()
        {
            return View();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Clients()
        {
            return View();
        }

        public ActionResult Tasks()
        {
            return View();
        }

        public ActionResult OnBoardingTasks()
        {
            return View();
        }

        public ActionResult MapTask()
        {
            return View();
        }

        public ActionResult Emails()
        {
            return View();
        }

        public ActionResult Reports()
        {
            return View();
        }

        public ActionResult Licensing()
        {
            return View();
        }


        public ActionResult Logout()
        {
            return RedirectToAction("LoginDisplay", "Home");
        }

        #region Client

        public JsonResult GetData()
        {
            List<Client> lst = _dbOperations.GetClientData();
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetDatabyId(string clientnumber)
        {
            List<Client> lst = _dbOperations.GetClientDatabyId(clientnumber);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult InsertClient(Client client)
        {
            if (client.FirstInterestPaymentDate != "" && client.FirstInterestPaymentDate != null)
            {
                DateTime FirstInterestPaymentDate = DateTime.ParseExact(client.FirstInterestPaymentDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                client.FirstInterestPaymentDate = FirstInterestPaymentDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            }

            if (client.FirstUtilisationDate != "" && client.FirstUtilisationDate != null)
            {
                DateTime FirstUtilisationDate = DateTime.ParseExact(client.FirstUtilisationDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                client.FirstUtilisationDate = FirstUtilisationDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            }
            if (client.LoanDateAggrmnt != "" && client.LoanDateAggrmnt != null)
            {
                DateTime LoanDateAggrmnt = DateTime.ParseExact(client.LoanDateAggrmnt, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                client.LoanDateAggrmnt = LoanDateAggrmnt.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            }
            if (client.ProposedDealCommencementDate != "" && client.ProposedDealCommencementDate != null)
            {
                DateTime ProposedDealCommencementDate = DateTime.ParseExact(client.ProposedDealCommencementDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                client.ProposedDealCommencementDate = ProposedDealCommencementDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            }

            string errordesc = "";
            int errorcode = 0;
            _dbOperations.InsertClientdata(client, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        public void UpdateClient(Client client)
        {

        }

        #endregion Client

        #region Task

        public JsonResult GetTaskData()
        {
            List<Tasks> lst = _dbOperations.GetTaskData();
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetTaskbyId(int Id)
        {
            List<Tasks> lst = _dbOperations.GetTaskDatabyId(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult InsertTask(Tasks task)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.Inserttaskdata(task, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);

        }

        public JsonResult UpdateTask(Tasks task)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.Updatetaskdata(task, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion Task

        #region OnboardingTask

        public JsonResult GetOnboardingTaskData()
        {
            List<OnboardingTasks> lst = _dbOperations.GetOnboardingTaskData();
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetOnboardingTaskbyId(int Id)
        {
            List<OnboardingTasks> lst = _dbOperations.GetOnboardingTaskDatabyId(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateOnboardingTask(string Id, string TaskComments, string ClientNumber, string ExisitingFiles)
        {
            string mailbox = @"D:/EMail/inbox";
            string filepath = mailbox + "/" + ClientNumber + "/";

            bool exists = System.IO.Directory.Exists(@filepath);
            if (!exists)
                System.IO.Directory.CreateDirectory(@filepath);
            if (Request.Files.Count > 0)
            {
                foreach (string file in Request.Files)
                {
                    var fileContent = Request.Files[file];
                    if (fileContent != null && fileContent.ContentLength > 0)
                    {
                        filepath = filepath + fileContent.FileName;
                        if (!System.IO.File.Exists(filepath))
                        {
                            FileStream fileStream = System.IO.File.Create(filepath, (int)fileContent.InputStream.Length);
                            byte[] bytesInStream = new byte[fileContent.InputStream.Length];
                            fileContent.InputStream.Read(bytesInStream, 0, bytesInStream.Length);
                            fileStream.Write(bytesInStream, 0, bytesInStream.Length);
                            fileStream.Close();
                            if (ExisitingFiles != null)
                                ExisitingFiles += "," + fileContent.FileName;
                            else
                                ExisitingFiles = fileContent.FileName;
                        }
                        else
                            return Json("File already exists", JsonRequestBehavior.AllowGet);
                    }
                }

                string errordesc = "success";
                int errocode = 0;
                _dbOperations.UpdateOnboardingTaskdata(Id, ExisitingFiles, TaskComments, out errocode, out errordesc);

                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json("success", JsonRequestBehavior.AllowGet);
            }
        }

        #endregion OnboardingTask


        #region MapTask


        public JsonResult Get_Mapped_Mail_Task(string type)
        {
            List<MapTasks> lst = _dbOperations.Get_Mapped_Mail_Task(type);

            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetMapTaskData()
        {
            List<MapTasks> lst = _dbOperations.GetMapTaskData();
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMapTaskbyId(int Id)
        {
            List<MapTasks> lst = _dbOperations.GetMapTaskDatabyId(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateMapTask(MapTasks task)
        {
            string errordesc = "";
            int errorcode = 0;
            _dbOperations.UpdateMapTaskdata(task, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion MapTask


        #region Email

        public JsonResult GetEmailData()
        {
            List<Emails> lst = _dbOperations.GetEmailData();
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetEmailbyId(int Id)
        {
            List<Emails> lst = _dbOperations.GetEmailDatabyId(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }



        public void UpdateEmail(Emails task)
        {

        }

        #endregion Email

        public string getloggedusername()
        {
            return Convert.ToString(Session["UserName"]);
        }

        #region Roles

        public JsonResult GetUserRoles(string userId)
        {
            if (userId != "")
            {
                if (Session["MenuList"] != null)
                {
                    List<RightMaster> ls = Session["MenuList"] as List<RightMaster>;
                    return Json(ls, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    List<RightMaster> lst = _dbOperations.GetMenuList(userId);
                    Session["MenuList"] = lst;
                    return Json(lst, JsonRequestBehavior.AllowGet);
                }
            }
            else
                return null;
        }
        public JsonResult GetUsersByRoles(string Roleid)
        {
            List<UserMaster> lst = _dbOperations.GetUsersByRoles(Roleid);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetUserRights(string userId)
        {
            List<RightMaster> lst = _dbOperations.GetRightsList(userId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetRoleRightMappings(string roleId)
        {
            _dbOperations.GetRoleRightMapping(roleId);
            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetRoleRightMapping(string roleId)
        {
            List<RoleRightMapping> lst = _dbOperations.GetRoleRightMapping(roleId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }
        public JsonResult roles(string roleId)
        {
            List<Roles> lst = _dbOperations.GetRoles(roleId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetRights(string right)
        {
            List<RightMaster> lst = _dbOperations.GetRights(right);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        public JsonResult AddRole(RoleRightMapping obj)
        {
            string errordesc = "";
            int errocode = 0;
            int id = _dbOperations.AddRole(obj.selectedRole, out errocode, out errordesc);
            return Json(id, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddRoleRightMapping([FromBody]RoleRightMapping obj)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddRoleRightMapping(obj, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyRoleRight([FromBody]RoleRightMapping obj)
        {
            _dbOperations.ModifyRoleRight(obj);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteRole(RoleRightMapping obj)
        {

            _dbOperations.DeleteRole(obj.id);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion Roles

        #region User

        public JsonResult getusers(string userid)
        {
            List<UserMaster> lst = _dbOperations.GetUser(userid);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult profile(string userId)
        {
            _dbOperations.GetUserProfile(userId);
            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetUserSessionInfo(string createdOn)
        {
            _dbOperations.GetUserSessionInfo(createdOn);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetInactiveUsers()
        {
            _dbOperations.GetInactiveUsers();
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetUserbyFilter(string RegionId, string BusinessLineId)
        {
            List<UserMaster> lst = _dbOperations.GetUserbyFilter(RegionId, BusinessLineId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        public JsonResult email()
        {
            _dbOperations.GetAllEmail();
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult CreateUser(UserMaster user)
        {

            string errordesc = "";
            int errocode = 0;
            _dbOperations.CreateUser(user, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }



        public JsonResult CreateTempUser(UserMaster user)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.CreateTempUser(user, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyUser(UserMaster user)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyUser(user, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteUser(string user)
        {

            _dbOperations.DeleteUser(user);
            return Json("", JsonRequestBehavior.AllowGet);
        }
        #endregion User



        #region Country

        public JsonResult GetAllCountry(string CountryId)
        {
            List<CountryMaster> lst = _dbOperations.GetCountryList(CountryId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddCountry(CountryMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddCountry(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyCountry(CountryMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyCountry(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteCountry(string CountryId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteCountry(CountryId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion Country


        #region Region

        public JsonResult GetAllRegion(string RegionId)
        {
            List<RegionMaster> lst = _dbOperations.GetRegionList(RegionId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddRegion(RegionMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddRegion(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyRegion(RegionMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyRegion(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteRegion(string RegionId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteRegion(RegionId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion Region
        


        #region BusinessSector

        public JsonResult GetAllBusinessSector(string BusinessSectorId)
        {
            List<BusinessSector> lst = _dbOperations.GetBusinessSectorList(BusinessSectorId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddBusinessSector(BusinessSector taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddBusinessSector(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyBusinessSector(BusinessSector opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyBusinessSector(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteBusinessSector(string BusinessSectorId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteBusinessSector(BusinessSectorId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion BusinessSector



        public JsonResult getADuser()
        {
            List<UserMaster> ls = new List<UserMaster>();
            ls.Add(new UserMaster { userId = "John", EmailId = "John@coba.com", UserName = "John Albert" });
            ls.Add(new UserMaster { userId = "Daniel", EmailId = "Daniel@coba.com", UserName = "Daniel" });
            ls.Add(new UserMaster { userId = "Sivakumar", EmailId = "Sivakumar@coba.com", UserName = "SivaKumar" });
            ls.Add(new UserMaster { userId = "George", EmailId = "George@coba.com", UserName = "George" });
            ls.Add(new UserMaster { userId = "Oliver", EmailId = "Oliver@coba.com", UserName = "Oliver" });


            List<UserMaster> lst = _dbOperations.GetUser("");

            foreach (UserMaster u in lst)
            {
                List<UserMaster> um = ls.Where(le => le.userId == u.userId).ToList();
                if (um.Count > 0)
                    ls.Remove(um[0]);
            }

            return Json(ls, JsonRequestBehavior.AllowGet);
        }

    }
}
public static class Utilities
{
    public static string IsActive(this HtmlHelper html,
                                  string control,
                                  string action)
    {
        var routeData = html.ViewContext.RouteData;

        var routeAction = (string)routeData.Values["action"];
        var routeControl = (string)routeData.Values["controller"];

        // both must match
        var returnActive = control == routeControl &&
                           action == routeAction;

        return returnActive ? "menu - dropdown classic - menu - dropdown active" : "menu - dropdown classic - menu - dropdown";
    }
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


public class SessionTimeoutAttribute : ActionFilterAttribute
{
    public override void OnActionExecuting(ActionExecutingContext filterContext)
    {
        HttpContext ctx = HttpContext.Current;
        if (HttpContext.Current.Session["UserName"] == null)
        {
            filterContext.Result = new RedirectResult("~/Home/LoginDisplay");
            return;
        }
        base.OnActionExecuting(filterContext);
    }
}

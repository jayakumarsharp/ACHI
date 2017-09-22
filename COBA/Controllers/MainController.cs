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

        public ActionResult ShowApplicationDetails()
        {
            return PartialView();
        }
        public ActionResult ViewApprovals()
        {
            return PartialView();
        }
        public ActionResult ShowApprovalDetails()
        {
            return PartialView();
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult TransferSettings()
        {
            return View();
        }

        public ActionResult Country()
        {
            return View();
        }
        public ActionResult BusinessSector()
        {
            return View();
        }
        public ActionResult ProductType()
        {
            return View();
        }
        public ActionResult RoleManagement()
        {
            return View();
        }

        public ActionResult UserManagement()
        {
            return View();
        }

        public ActionResult ApplicationMaster()
        {
            return View();
        }



        public ActionResult Region()
        {
            return View();
        }


        public ActionResult Strategy()
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

        public ActionResult Approvals()
        {
            return View();
        }



        public ActionResult Logout()
        {
            return RedirectToAction("LoginDisplay", "Home");
        }


        #region TransferSetting
        public JsonResult Get_ApprovaltransferByuser()
        {
            List<StrategyApprover> lst = _dbOperations.Get_ApprovaltransferByuser(Convert.ToString(Session["UserName"]));
            return Json(lst, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetTransferSettingByuser()
        {
            List<TransferSetting> lst = _dbOperations.GetTransfersettingIDbyuser(Convert.ToString(Session["UserName"]));
            return Json(lst, JsonRequestBehavior.AllowGet);
        }
        public JsonResult InsertTransferSetting(TransferSetting strategy)
        {
            string errordesc = "";
            int errorcode = 0;
            if (Convert.ToString(Session["UserName"]) != "")
            {
                strategy.OwnerUser = Convert.ToString(Session["UserName"]);
                _dbOperations.InsertTransferSetting(strategy, out errorcode, out errordesc);
            }
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DeleteTransferSetting()
        {
            //if (Strategy.FirstInterestPaymentDate != "" && Strategy.FirstInterestPaymentDate != null)
            //{
            //    DateTime FirstInterestPaymentDate = DateTime.ParseExact(Strategy.FirstInterestPaymentDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            //    Strategy.FirstInterestPaymentDate = FirstInterestPaymentDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            //}
            string errordesc = "";
            int errorcode = 0;

            _dbOperations.DeleteTransferSetting(Convert.ToString(Session["UserName"]), out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion TransferSetting




        #region Strategy

        public JsonResult GetData()
        {
            List<Strategy> lst = _dbOperations.GetStrategyData();
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetDatabyId(string Strategynumber)
        {
            List<Strategy> lst = _dbOperations.GetStrategyDatabyId(Strategynumber);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetStrategyDatabyStrategyId(string Strategynumber)
        {
            List<Strategy> lst = _dbOperations.GetStrategyDatabyStrategyId(Strategynumber);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }



        public JsonResult GetStrategyApprovalByuser()
        {
            List<StrategyApprover> lst = _dbOperations.Get_StrategyApprovalByuser(Convert.ToString(Session["UserName"]));
            return Json(lst, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetStrategyApprovalById(string Strategynumber, string Version)
        {
            List<StrategyApprover> lst = _dbOperations.Get_StrategyApprovalById(Strategynumber, Version);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult InsertStrategy(Strategy strategy)
        {
            string errordesc = "";
            int errorcode = 0;
            _dbOperations.InsertStrategydata(strategy, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveNewversionStrategy(Strategy strategy)
        {
            string errordesc = "";
            int errorcode = 0;
            _dbOperations.UpdateStrategyVersiondata(strategy, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }



        public JsonResult InsertStrategyApprover(List<StrategyApprover> strategy)
        {
            //if (Strategy.FirstInterestPaymentDate != "" && Strategy.FirstInterestPaymentDate != null)
            //{
            //    DateTime FirstInterestPaymentDate = DateTime.ParseExact(Strategy.FirstInterestPaymentDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            //    Strategy.FirstInterestPaymentDate = FirstInterestPaymentDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            //}
            string errordesc = "";
            int errorcode = 0;
            if (strategy.Count > 0)
                _dbOperations.InsertStrategyApprover(strategy, strategy[0].RefNumber, strategy[0].Version, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyStrategyApprover(List<StrategyApprover> strategy)
        {
            //if (Strategy.FirstInterestPaymentDate != "" && Strategy.FirstInterestPaymentDate != null)
            //{
            //    DateTime FirstInterestPaymentDate = DateTime.ParseExact(Strategy.FirstInterestPaymentDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            //    Strategy.FirstInterestPaymentDate = FirstInterestPaymentDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            //}
            string errordesc = "";
            int errorcode = 0;
            if (strategy.Count > 0)
                _dbOperations.InsertStrategyApprover(strategy, strategy[0].RefNumber, strategy[0].Version, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        //public JsonResult DeleteStrategyApprover(List<StrategyApprover> strategy)
        //{
        //    //if (Strategy.FirstInterestPaymentDate != "" && Strategy.FirstInterestPaymentDate != null)
        //    //{
        //    //    DateTime FirstInterestPaymentDate = DateTime.ParseExact(Strategy.FirstInterestPaymentDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
        //    //    Strategy.FirstInterestPaymentDate = FirstInterestPaymentDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
        //    //}
        //    string errordesc = "";
        //    int errorcode = 0;
        //    if (strategy != null && strategy.Count > 0)
        //        _dbOperations.DeleteStrategyApprover(strategy, strategy[0].RefNumber, out errorcode, out errordesc);
        //    return Json(errordesc, JsonRequestBehavior.AllowGet);
        //}

        public JsonResult UpdateStrategyApprover(StrategyApprover strategy)
        {
            //if (Strategy.FirstInterestPaymentDate != "" && Strategy.FirstInterestPaymentDate != null)
            //{
            //    DateTime FirstInterestPaymentDate = DateTime.ParseExact(Strategy.FirstInterestPaymentDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            //    Strategy.FirstInterestPaymentDate = FirstInterestPaymentDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            //}
            string errordesc = "";
            int errorcode = 0;
            _dbOperations.UpdateStrategyApprover(strategy, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }


        public JsonResult UpdateStrategy(Strategy Strategy)
        {
            string errordesc = "";
            int errorcode = 0;
            _dbOperations.UpdateStrategydata(Strategy, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion Strategy

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

        public JsonResult UpdateOnboardingTask(string Id, string TaskComments, string StrategyNumber, string ExisitingFiles)
        {
            string mailbox = @"C:/EMail/inbox";
            string filepath = mailbox + "/" + StrategyNumber + "/";

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


        #region Roles

        public JsonResult GetUserRoles(string roleid)
        {
            _dbOperations.GetUserRoles(roleid);
            return Json("", JsonRequestBehavior.AllowGet);
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
            _dbOperations.GetUser(userid);
            return Json("", JsonRequestBehavior.AllowGet);
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

        public JsonResult UserSBU(string user)
        {
            _dbOperations.GetUserSBU(user);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult AllUserSBU(string user)
        {
            _dbOperations.GetUserSBU(user);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult UserBillingSBU(string userId)
        {
            _dbOperations.GetUserBillingSBU(userId);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult AllUserBillingSBU(string user)
        {
            _dbOperations.GetUserBillingSBU(user);
            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult sbu()
        {

            _dbOperations.GetAllSBU();
            return Json("", JsonRequestBehavior.AllowGet);
        }
        public JsonResult email()
        {
            _dbOperations.GetAllEmail();
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult CreateUser(string user)
        {

            //console.log(req);      
            _dbOperations.CreateUser(user);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetUsersByTypes(string types)
        {

            _dbOperations.GetUsersByTypes(types);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult CreateTempUser(string user)
        {

            _dbOperations.CreateTempUser(user);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyUser(string user)
        {

            _dbOperations.ModifyUser(user);
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
          List<CountryMaster> lst=  _dbOperations.GetCountryList(CountryId);
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


        #region ProductType

        public JsonResult GetAllProductType(string ProductTypeId)
        {
            List<ProductMaster> lst = _dbOperations.GetProductList(ProductTypeId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddProductType(ProductMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddProduct(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyProductType(ProductMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyProduct(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteProductType(string ProductTypeId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteProduct(ProductTypeId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion ProductType




        #region Application

        public JsonResult GetAllApplication(string ApplicationId)
        {
            List<ApplicationMaster> lst = _dbOperations.GetApplicationList(ApplicationId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddApplication(ApplicationMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddApplication(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyApplication(ApplicationMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyApplication(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteApplication(string ApplicationId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteApplication(ApplicationId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion Application



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

        return returnActive ? "active" : "";
    }
}



public class TransferSetting
{
    public string Id { get; set; }
    public string OwnerUser { get; set; }
    public string Transferuser { get; set; }
    public string TransferFrom { get; set; }
    public string TransferTo { get; set; }
    public string IsActive { get; set; }
}


public class StrategyDetails
{
    public Strategy Strategy { get; set; }
    public List<StrategyApprover> lst { get; set; }
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
    public string StrategyNumber { get; set; }
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
    public string RefNumber { get; set; }
    public string Version { get; set; }
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
    public string RefNumber { get; set; }
    public string Version { get; set; }
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

public class StrategyApprover
{

    public string Id { get; set; }
    public string RefNumber { get; set; }
    public string Version { get; set; }
    public string Approver { get; set; }
    public string Comments { get; set; }
    public string ApprovedDate { get; set; }
    public string Status { get; set; }
    public string OriginalApprover { get; set; }
}



public class Strategy
{
    public int Id { get; set; }
    public string RefNumber { get; set; }
    public string Name { get; set; }
    public string Type { get; set; }
    public string ApplicationName { get; set; }
    public string ApplicationId { get; set; }
    public string BusinessSector { get; set; }
    public string Country { get; set; }
    public string Region { get; set; }
    public string ProductType { get; set; }
    public string Ranking { get; set; }
    public string Objective { get; set; }
    public string Description { get; set; }
    public string RiskRating { get; set; }
    public string BusinessImpact { get; set; }
    public string ExchangeDetails { get; set; }
    public string DetailsOfChanges { get; set; }
    public string ChangesBusinessImpact { get; set; }
    public string SupportingDocument { get; set; }
    public string DateChangeInitiated { get; set; }
    public string DateChangeImplemented { get; set; }
    public string ChangesCompletionStatus { get; set; }
    public string AdditionalParam1 { get; set; }
    public string AdditionalParam2 { get; set; }
    public string AdditionalParam3 { get; set; }
    public string AdditionalParam4 { get; set; }
    public string AdditionalParam5 { get; set; }
    public string AdditionalParam6 { get; set; }
    public string AdditionalParam7 { get; set; }
    public string AdditionalParam8 { get; set; }
    public string AdditionalParam9 { get; set; }
    public string AdditionalParam10 { get; set; }
    public string AdditionalParam11 { get; set; }
    public string AdditionalParam12 { get; set; }
    public string AdditionalParam13 { get; set; }
    public string Attribute1 { get; set; }
    public string Attribute2 { get; set; }
    public string Attribute3 { get; set; }
    public string Attribute4 { get; set; }
    public string NoOfApprover { get; set; }
    public string Version { get; set; }

    public string FinalSignOff { get; set; }
    public string SignOffDate { get; set; }
    public string SignoffBy { get; set; }
    public string IsActive { get; set; }
    public string CreatedDate { get; set; }
    public string CreatedBy { get; set; }
    public string LastModifiedDate { get; set; }
    public string LastModifiedBy { get; set; }
    public string Page { get; set; }
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

public class UserMaster
{
    public string ApprovedDate { get; set; }
    public string Approvedby { get; set; }
    public int AttemptedTries { get; set; }
    public int BaseSkillId { get; set; }
    public int BillingId { get; set; }
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
    public string RoleId { get; set; }
    public string Status { get; set; }
    public string TypeId { get; set; }
    public string UserBlockDate { get; set; }
    public string UserExpiryDate { get; set; }
    public string UserImage { get; set; }
    public string UserName { get; set; }
    public string userId { get; set; }
}

public class Roles
{
    public string CreatedBy { get; set; }
    public string CreatedDate { get; set; }
    public string ModifiedBy { get; set; }
    public string ModifiedDate { get; set; }
    public string RoleName { get; set; }
    public int id { get; set; }
}


public class ApplicationMaster
{
    public string Id { get; set; }
    public string ApplicationId { get; set; }
    public string ApplicationName { get; set; }

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

public class ProductMaster
{
    public string Id { get; set; }
    public string ProductName { get; set; }

}


public class BusinessSector
{
    public string Id { get; set; }
    public string BusinessSectorName { get; set; }

}


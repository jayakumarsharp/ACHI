using COBA.Models;
using log4net;
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
    [NoCache]
    public class MainController : Controller
    {
        private DbOperations _dbOperations = new DbOperations();
        private static readonly ILog log = LogManager.GetLogger(typeof(MainController));

        //
        // GET: /Main/

        #region page Load

        [SessionTimeout]
        public ActionResult BusinessLine()
        {
            return View();
        }


        [SessionTimeout]
        public ActionResult Country()
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

        [SessionTimeout]

        public ActionResult Index()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult Clients()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult Tasks()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult OnBoardingTasks()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult MapTask()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult Emails()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult Reports()
        {
            return View();
        }

        public ActionResult Licensing()
        {
            return View();
        }

        public ActionResult MapClientTask()
        {
            return View();
        }
        #endregion page Load

        #region Client

        public JsonResult GetData()
        {
            try
            {
                log.Info("Get Client data");
                List<Client> lst = _dbOperations.GetClientData();
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }
        }

        public JsonResult GetDatabyId(string clientnumber)
        {
            try
            {
                List<Client> lst = _dbOperations.GetClientDatabyId(clientnumber);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult InsertClient(Client client)
        {
            try
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
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult UpdateClient(Client client)
        {
            try
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
                _dbOperations.Updateclientdata(client, out errorcode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        #endregion Client

        #region Task

        public JsonResult GetTaskData()
        {
            try
            {
                List<Tasks> lst = _dbOperations.GetTaskData();
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult GetTaskbyId(int Id)
        {
            try
            {
                List<Tasks> lst = _dbOperations.GetTaskDatabyId(Id);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult InsertTask(Tasks task)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.Inserttaskdata(task, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult UpdateTask(Tasks task)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.Updatetaskdata(task, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        #endregion Task

        #region OnboardingTask

        public JsonResult GetOnboardingTaskData()
        {
            try
            {
                List<OnboardingTasks> lst = _dbOperations.GetOnboardingTaskData();
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult GetOnboardingTaskbyId(int Id)
        {
            try
            {
                List<OnboardingTasks> lst = _dbOperations.GetOnboardingTaskDatabyId(Id);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult UpdateOnboardingTask(string Id, string TaskComments, string ClientNumber, string ExisitingFiles)
        {
            try
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
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        #endregion OnboardingTask


        #region MapTask


        public JsonResult GetAllClientTask()
        {
            try
            {
                List<MapTasks> lst = _dbOperations.GetClientMapTaskData();
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }
        }


        public JsonResult GetClientMappedTask(string type)
        {
            try
            {

                List<MapTasks> lst = _dbOperations.GetClientMappedTask(type);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult Get_Mapped_Mail_Task(string type)
        {
            try
            {
                List<MapTasks> lst = _dbOperations.Get_Mapped_Mail_Task(type);

                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }


        public JsonResult GetMapTaskData()
        {
            try
            {
                List<MapTasks> lst = _dbOperations.GetMapTaskData();
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult GetMapTaskbyId(int Id)
        {
            try
            {
                List<MapTasks> lst = _dbOperations.GetMapTaskDatabyId(Id);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult UpdateMapTask(MapTasks task)
        {
            try
            {
                string errordesc = "";
                int errorcode = 0;
                _dbOperations.UpdateMapTaskdata(task, out errorcode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult UpdateClientMapTask(MapTasks task)
        {
            try
            {
                string errordesc = "";
                int errorcode = 0;
                _dbOperations.UpdateclientMapTaskdata(task, out errorcode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        #endregion MapTask


        #region Email

        public JsonResult GetEmailData()
        {
            try
            {

                List<Emails> lst = _dbOperations.GetEmailData();
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult GetEmailbyId(int Id)
        {
            try
            {

                List<Emails> lst = _dbOperations.GetEmailDatabyId(Id);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }




        #endregion Email

        public ActionResult ConfirmModal()
        {
            return PartialView();
        }

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
            try
            {

                _dbOperations.GetAllEmail();
                return Json("", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult CreateUser(UserMaster user)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.CreateUser(user, out errocode, out errordesc);
                return Json("", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }



        public JsonResult CreateTempUser(UserMaster user)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.CreateTempUser(user, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult ModifyUser(UserMaster user)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.ModifyUser(user, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return null;
            }

        }

        public JsonResult DeleteUser(string user)
        {
            _dbOperations.DeleteUser(user);
            return Json("", JsonRequestBehavior.AllowGet);
        }



        #endregion User

        #region BusinessLine

        public JsonResult GetAllBusinessLine(string BusinessLineId)
        {
            List<BusinessLineMaster> lst = _dbOperations.GetBusinessLineList(BusinessLineId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddBusinessLine(BusinessLineMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddBusinessLine(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyBusinessLine(BusinessLineMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyBusinessLine(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteBusinessLine(string BusinessLineId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteBusinessLine(BusinessLineId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion BusinessLine

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



        public JsonResult GetusercountryMapping(string userId)
        {
            List<CountryMaster> lst = _dbOperations.GetusercountryMapping(userId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetuserRegionMapping(string userId)
        {
            List<RegionMaster> lst = _dbOperations.GetuserregionMapping(userId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetBusinessMapping(string userId)
        {
            List<BusinessLineMaster> lst = _dbOperations.GetuserbusinessMapping(userId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

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



[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
public sealed class NoCacheAttribute : ActionFilterAttribute
{
    public override void OnResultExecuting(ResultExecutingContext filterContext)
    {
        filterContext.HttpContext.Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));
        filterContext.HttpContext.Response.Cache.SetValidUntilExpires(false);
        filterContext.HttpContext.Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
        filterContext.HttpContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        filterContext.HttpContext.Response.Cache.SetNoStore();

        base.OnResultExecuting(filterContext);
    }
}


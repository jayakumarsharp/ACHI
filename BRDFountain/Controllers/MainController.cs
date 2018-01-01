using log4net;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace BRDFountain.Controllers
{
    public class MainController : Controller
    {
        private DbOperations _dbOperations = new DbOperations();
        private static readonly ILog log = LogManager.GetLogger(typeof(MainController));
        //
        // GET: /Main/
        //[SessionTimeout]

        #region PArtial Views
        public ActionResult ShowApplicationDetails()
        {
            return PartialView();
        }

        public ActionResult ConfirmModal()
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

        #endregion PArtial Views

        #region View displays

        [SessionTimeout]
        public ActionResult Index()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult TransferSettings()
        {
            return View();
        }

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
        public ActionResult ProductType()
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
        public ActionResult ApplicationMaster()
        {
            return View();
        }


        [SessionTimeout]
        public ActionResult Region()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult ModelAlgoManagement()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult ChangeManagement()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult Approvals()
        {
            return View();
        }


        [SessionTimeout]
        public ActionResult FTAApplicationCode()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult FTAStrategyCode()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult DiscretionaryCode()
        {
            return View();
        }


        [SessionTimeout]
        public ActionResult BusinessSuffix()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult Business()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult MappingMaster()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult FTAApplicationMapping()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult FTAStrategyMapping()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult BusinessMapping()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult ParentID()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult ChildID()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult BusinessLine()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult FTAApplicationName()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult FTAApplicationOwner()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult FTAStrategyName()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult FTAStrategyOwner()
        {
            return View();
        }
        [SessionTimeout]
        public ActionResult SystemFlow()
        {
            return View();
        }


        [SessionTimeout]
        public ActionResult ApplicationCategory()
        {
            return View();
        }


        [SessionTimeout]
        public ActionResult Strategytype()
        {
            return View();
        }


        [SessionTimeout]
        public ActionResult Venuetype()
        {
            return View();
        }


        [SessionTimeout]
        public ActionResult Capacity()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult PriorityScore()
        {
            return View();
        }


        [SessionTimeout]
        public ActionResult MasterPage()
        {
            return View();
        }


        #endregion View displays


        public string getloggedusername()
        {
            return Convert.ToString(Session["UserName"]);
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



        public JsonResult GetStrategyApprovalByuser()
        {
            List<StrategyApprover> lst = _dbOperations.Get_StrategyApprovalByuser(Convert.ToString(Session["UserName"]));
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetStrategyDelegatesApprovalByuser()
        {
            List<StrategyApprover> lst = _dbOperations.GetStrategyDelegatesApprovalByuser(Convert.ToString(Session["UserName"]));
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetDelegatedApprovalByuser()
        {
            List<StrategyApprover> lst = _dbOperations.Get_DelegatedApprovalByuser(Convert.ToString(Session["UserName"]));
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetStrategyApprovalById(string Strategynumber, string Version)
        {
            List<StrategyApprover> lst = _dbOperations.Get_StrategyApprovalById(Strategynumber, Version);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult InsertStrategy(Strategy strategy)
        {
            try
            {
                string mailbox = @"D:/Docs/";
                string filepath = mailbox + "/" + strategy.RefNumber + "/";
                string errordesc = "";
                int errorcode = 0;
                strategy.Version = 1;
                strategy.RefNumber = DateTime.Now.ToString("yyyyMMddHHmmssfff");
                List<StrategyApprover> lstfiles = new List<StrategyApprover>();
                bool exists = System.IO.Directory.Exists(@filepath);
                if (!exists)
                    System.IO.Directory.CreateDirectory(@filepath);
                if (Request.Files.Count > 0)
                {
                    StrategyApprover files = null;
                    foreach (string file in Request.Files)
                    {
                        files = new StrategyApprover();
                        var fileContent = Request.Files[file];
                        if (Request.Files.AllKeys[0].Contains("Systemflowfilelist"))
                        {
                            files.Status = "S";
                            if (strategy.ExistingSystemflowfile != null)
                                strategy.ExistingSystemflowfile += "," + fileContent.FileName;
                            else
                                strategy.ExistingSystemflowfile = fileContent.FileName;
                        }
                        else
                        {
                            files.Status = "D";
                            if (strategy.ExistingDecommissionedfile != null)
                                strategy.ExistingDecommissionedfile += "," + fileContent.FileName;
                            else
                                strategy.ExistingDecommissionedfile = fileContent.FileName;
                        }
                        if (fileContent != null && fileContent.ContentLength > 0)
                        {
                            files.Comments = Convert.ToString(Guid.NewGuid()) + "." + Path.GetExtension(fileContent.FileName).Substring(1);
                            files.Approver = fileContent.FileName;
                            files.Version = strategy.Version.ToString();
                            files.RefNumber = strategy.RefNumber;
                            filepath = filepath + files.Comments;
                            if (!System.IO.File.Exists(filepath))
                            {
                                FileStream fileStream = System.IO.File.Create(filepath, (int)fileContent.InputStream.Length);
                                byte[] bytesInStream = new byte[fileContent.InputStream.Length];
                                fileContent.InputStream.Read(bytesInStream, 0, bytesInStream.Length);
                                fileStream.Write(bytesInStream, 0, bytesInStream.Length);
                                fileStream.Close();

                            }
                            else
                                return Json("File already exists", JsonRequestBehavior.AllowGet);
                        }
                        lstfiles.Add(files);
                    }
                    _dbOperations.InsertStrategyApprover(lstfiles, lstfiles[0].RefNumber, lstfiles[0].Version, out errorcode, out errordesc);
                }
                _dbOperations.InsertStrategydata(strategy, out errorcode, out errordesc);
                _dbOperations.insertStrategyVersionChange(strategy.RefNumber, 1, "Version Created");
                return Json(errordesc, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }


        public FileResult DownLoadFile(string FileName, string RefNumber, string Version)
        {
            try
            {
                log.InfoFormat("Called DownLoadFile method with param FileName {0}", FileName);
                string mailbox = @"D:/Docs/";
                string filepath = mailbox + "/" + RefNumber + "/";
                string filePath1 = filepath + FileName;

                if (!System.IO.File.Exists(filePath1))
                {
                    throw new Exception();
                }

                byte[] fileBytes = System.IO.File.ReadAllBytes(filePath1);
                return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, filePath1);

            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DownLoadFile {0}", ex);
                return null;
            }
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

        public JsonResult DeleteStrategyApprover(List<StrategyApprover> strategy)
        {
            //if (Strategy.FirstInterestPaymentDate != "" && Strategy.FirstInterestPaymentDate != null)
            //{
            //    DateTime FirstInterestPaymentDate = DateTime.ParseExact(Strategy.FirstInterestPaymentDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            //    Strategy.FirstInterestPaymentDate = FirstInterestPaymentDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            //}
            string errordesc = "";
            int errorcode = 0;
            if (strategy != null && strategy.Count > 0)
                _dbOperations.DeleteStrategyApprover(strategy, strategy[0].RefNumber, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

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

        public JsonResult updatedelegateAcceptance(StrategyApprover strategy)
        {
            string errordesc = "";
            int errorcode = 0;
            _dbOperations.updatedelegateAcceptance(strategy, out errorcode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }


        public JsonResult UpdateStrategy(List<Strategy> Strategy)
        {
            string errordesc = "";
            int errorcode = 0;

            var diffs = SimpleComparer.Differences(Strategy[0], Strategy[1]);

            var data = diffs.FindAll(x => x.Item1.Equals("CountryName") || x.Item1.Equals("Region") || x.Item1.Equals("BusinessSuffix") || x.Item1.Equals("FTAApplicationCode") || x.Item1.Equals("ChildIDValue")
            || x.Item1.Equals("FTAStrategyName") || x.Item1.Equals("Strategytype") || x.Item1.Equals("GOLiveDate") || x.Item1.Equals("FTAStrategyCode") || x.Item1.Equals("FTAShortCode") || x.Item1.Equals("BusinessLine") || x.Item1.Equals("FTAApplicationName") || x.Item1.Equals("FTAStrategyOwner") || x.Item1.Equals("ApplicationCategory") || x.Item1.Equals("Venuetype") || x.Item1.Equals("DecomissionedDate") || x.Item1.Equals("DiscretionaryCode")
            || x.Item1.Equals("ParentIDValue") || x.Item1.Equals("FTAApplicationOwner") || x.Item1.Equals("PriorityScore") || x.Item1.Equals("Priority") || x.Item1.Equals("Capacity")
            || x.Item1.Equals("Description") || x.Item1.Equals("SignOff"));
            string Changedata = "";
            if (data.Count() > 0)
            {
                foreach (var diff in data)
                {
                    Changedata += " " + diff.Item1 + " - " + diff.Item3 + " - Changed to " + diff.Item2;
                }

                Strategy[0].RefNumber = Strategy[1].RefNumber;
                Strategy[0].Version = Strategy[1].Version + 1;
                _dbOperations.InsertStrategydata(Strategy[0], out errorcode, out errordesc);
                _dbOperations.insertStrategyVersionChange(Strategy[0].RefNumber, Strategy[0].Version, Changedata);
            }

            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateStrategyFile(Strategy strategy)
        {
            try
            {
                string mailbox = @"D:/Docs/";
                string filepath = mailbox + "/" + strategy.RefNumber + "/";
                string errordesc = "";
                int errorcode = 0;
                List<StrategyApprover> lstfiles = new List<StrategyApprover>();
                bool exists = System.IO.Directory.Exists(@filepath);
                if (!exists)
                    System.IO.Directory.CreateDirectory(@filepath);
                if (Request.Files.Count > 0)
                {
                    StrategyApprover files = null;
                    foreach (string file in Request.Files)
                    {
                        files = new StrategyApprover();
                        var fileContent = Request.Files[file];
                        if (Request.Files.AllKeys[0].Contains("Systemflowfilelist"))
                        {
                            files.Status = "S";
                            if (strategy.ExistingSystemflowfile != null)
                                strategy.ExistingSystemflowfile += "," + fileContent.FileName;
                            else
                                strategy.ExistingSystemflowfile = fileContent.FileName;
                        }
                        else
                        {
                            files.Status = "D";
                            if (strategy.ExistingDecommissionedfile != null)
                                strategy.ExistingDecommissionedfile += "," + fileContent.FileName;
                            else
                                strategy.ExistingDecommissionedfile = fileContent.FileName;
                        }
                        if (fileContent != null && fileContent.ContentLength > 0)
                        {
                            files.Comments = Convert.ToString(Guid.NewGuid()) + "." + Path.GetExtension(fileContent.FileName).Substring(1);
                            files.Approver = fileContent.FileName;
                            files.Version = strategy.Version.ToString();
                            files.RefNumber = strategy.RefNumber;
                            filepath = filepath + files.Comments;
                            if (!System.IO.File.Exists(filepath))
                            {
                                FileStream fileStream = System.IO.File.Create(filepath, (int)fileContent.InputStream.Length);
                                byte[] bytesInStream = new byte[fileContent.InputStream.Length];
                                fileContent.InputStream.Read(bytesInStream, 0, bytesInStream.Length);
                                fileStream.Write(bytesInStream, 0, bytesInStream.Length);
                                fileStream.Close();

                            }
                            else
                                return Json("File already exists", JsonRequestBehavior.AllowGet);
                        }
                        lstfiles.Add(files);
                    }
                    _dbOperations.InsertStrategyApprover(lstfiles, lstfiles[0].RefNumber, lstfiles[0].Version, out errorcode, out errordesc);
                }
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }

        #endregion Strategy

        #region OnboardingTask


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
                // _dbOperations.UpdateOnboardingTaskdata(Id, ExisitingFiles, TaskComments, out errocode, out errordesc);

                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json("success", JsonRequestBehavior.AllowGet);
            }
        }

        #endregion OnboardingTask

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



        #region FTAApplicationCode

        public JsonResult GetAllFTAApplicationCode(string FTAApplicationCodeId)
        {
            List<FTAApplicationCodeMaster> lst = _dbOperations.GetFTAApplicationCodeList(FTAApplicationCodeId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddFTAApplicationCode(FTAApplicationCodeMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddFTAApplicationCode(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyFTAApplicationCode(FTAApplicationCodeMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyFTAApplicationCode(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteFTAApplicationCode(string FTAApplicationCodeId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteFTAApplicationCode(FTAApplicationCodeId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion FTAApplicationCode


        #region FTAStrategyCode

        public JsonResult GetAllFTAStrategyCode(string FTAStrategyCodeId)
        {
            List<FTAStrategyCodeMaster> lst = _dbOperations.GetFTAStrategyCodeList(FTAStrategyCodeId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddFTAStrategyCode(FTAStrategyCodeMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddFTAStrategyCode(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyFTAStrategyCode(FTAStrategyCodeMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyFTAStrategyCode(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteFTAStrategyCode(string FTAStrategyCodeId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteFTAStrategyCode(FTAStrategyCodeId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion FTAStrategyCode

        #region FTAStrategyOwner

        public JsonResult GetAllFTAStrategyOwner(string FTAStrategyOwnerId)
        {
            List<FTAStrategyOwnerMaster> lst = _dbOperations.GetFTAStrategyOwnerList(FTAStrategyOwnerId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddFTAStrategyOwner(FTAStrategyOwnerMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddFTAStrategyOwner(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyFTAStrategyOwner(FTAStrategyOwnerMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyFTAStrategyOwner(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteFTAStrategyOwner(string FTAStrategyOwnerId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteFTAStrategyOwner(FTAStrategyOwnerId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion FTAStrategyOwner

        #region DiscretionaryCode

        public JsonResult GetAllDiscretionaryCode(string DiscretionaryCodeId)
        {
            List<DiscretionaryCodeMaster> lst = _dbOperations.GetDiscretionaryCodeList(DiscretionaryCodeId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddDiscretionaryCode(DiscretionaryCodeMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddDiscretionaryCode(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyDiscretionaryCode(DiscretionaryCodeMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyDiscretionaryCode(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteDiscretionaryCode(string DiscretionaryCodeId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteDiscretionaryCode(DiscretionaryCodeId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion DiscretionaryCode

        #region BusinessSuffix

        public JsonResult GetAllBusinessSuffix(string BusinessSuffixId)
        {
            List<BusinessSuffixMaster> lst = _dbOperations.GetBusinessSuffixList(BusinessSuffixId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddBusinessSuffix(BusinessSuffixMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddBusinessSuffix(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyBusinessSuffix(BusinessSuffixMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyBusinessSuffix(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteBusinessSuffix(string BusinessSuffixId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteBusinessSuffix(BusinessSuffixId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion BusinessSuffix

        #region Business

        public JsonResult GetAllBusiness(string BusinessId)
        {
            List<BusinessMaster> lst = _dbOperations.GetBusinessList(BusinessId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddBusiness(BusinessMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddBusiness(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyBusiness(BusinessMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyBusiness(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteBusiness(string BusinessId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteBusiness(BusinessId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion Business

        #region ParentID

        public JsonResult GetAllParentID(string ParentIDId)
        {
            List<ParentIDMaster> lst = _dbOperations.GetParentIDList(ParentIDId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddParentID(ParentIDMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddParentID(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyParentID(ParentIDMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyParentID(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteParentID(string ParentIDId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteParentID(ParentIDId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion ParentID

        #region ChildID

        public JsonResult GetAllChildID(string ChildIDId)
        {
            List<ChildIDMaster> lst = _dbOperations.GetChildIDList(ChildIDId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddChildID(ChildIDMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddChildID(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyChildID(ChildIDMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyChildID(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteChildID(string ChildIDId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteChildID(ChildIDId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion ChildID

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

        #region FTAApplicationName

        public JsonResult GetAllFTAApplicationName(string FTAApplicationNameId)
        {
            List<FTAApplicationNameMaster> lst = _dbOperations.GetFTAApplicationNameList(FTAApplicationNameId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddFTAApplicationName(FTAApplicationNameMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddFTAApplicationName(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyFTAApplicationName(FTAApplicationNameMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyFTAApplicationName(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteFTAApplicationName(string FTAApplicationNameId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteFTAApplicationName(FTAApplicationNameId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion FTAApplicationName

        #region FTAApplicationOwner

        public JsonResult GetAllFTAApplicationOwner(string FTAApplicationOwnerId)
        {
            List<FTAApplicationOwnerMaster> lst = _dbOperations.GetFTAApplicationOwnerList(FTAApplicationOwnerId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddFTAApplicationOwner(FTAApplicationOwnerMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddFTAApplicationOwner(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyFTAApplicationOwner(FTAApplicationOwnerMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyFTAApplicationOwner(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteFTAApplicationOwner(string FTAApplicationOwnerId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteFTAApplicationOwner(FTAApplicationOwnerId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion FTAApplicationOwner

        #region FTAStrategyName

        public JsonResult GetAllFTAStrategyName(string FTAStrategyNameId)
        {
            List<FTAStrategyNameMaster> lst = _dbOperations.GetFTAStrategyNameList(FTAStrategyNameId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddFTAStrategyName(FTAStrategyNameMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddFTAStrategyName(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyFTAStrategyName(FTAStrategyNameMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyFTAStrategyName(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteFTAStrategyName(string FTAStrategyNameId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteFTAStrategyName(FTAStrategyNameId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion FTAStrategyName

        #region ApplicationCategory

        public JsonResult GetAllApplicationCategory(string ApplicationCategoryId)
        {
            List<ApplicationCategoryMaster> lst = _dbOperations.GetApplicationCategoryList(ApplicationCategoryId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddApplicationCategory(ApplicationCategoryMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddApplicationCategory(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyApplicationCategory(ApplicationCategoryMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyApplicationCategory(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteApplicationCategory(string ApplicationCategoryId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteApplicationCategory(ApplicationCategoryId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion ApplicationCategory

        #region Strategytype

        public JsonResult GetAllStrategytype(string StrategytypeId)
        {
            List<StrategytypeMaster> lst = _dbOperations.GetStrategytypeList(StrategytypeId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddStrategytype(StrategytypeMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddStrategytype(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyStrategytype(StrategytypeMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyStrategytype(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteStrategytype(string StrategytypeId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteStrategytype(StrategytypeId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion Strategytype

        #region Venuetype

        public JsonResult GetAllVenuetype(string VenuetypeId)
        {
            List<VenuetypeMaster> lst = _dbOperations.GetVenuetypeList(VenuetypeId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddVenuetype(VenuetypeMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddVenuetype(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyVenuetype(VenuetypeMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyVenuetype(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteVenuetype(string VenuetypeId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteVenuetype(VenuetypeId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion Venuetype

        #region Capacity

        public JsonResult GetAllCapacity(string CapacityId)
        {
            List<CapacityMaster> lst = _dbOperations.GetCapacityList(CapacityId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddCapacity(CapacityMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddCapacity(taskInfo, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult ModifyCapacity(CapacityMaster opp)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.ModifyCapacity(opp, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteCapacity(string CapacityId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteCapacity(CapacityId, out errocode, out errordesc);
            return Json("", JsonRequestBehavior.AllowGet);
        }

        #endregion Capacity

        public JsonResult GetAllThirdPartyAppList(string Id)
        {
            List<ThirdPartyApp> lst = _dbOperations.GetThirdPartyAppList(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetAllBusinessMappingbyId(string Id)
        {
            List<BusinessMappingMaster> lst = _dbOperations.GetBusinessMappingListbyId(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllFTAStrategyMappingbyId(string Id)
        {
            List<FTAStrategyMappingMaster> lst = _dbOperations.GetFTAStrategyMappingListbyId(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllFTAApplicationMappingbyId(string Id)
        {
            List<FTAApplicationMappingMaster> lst = _dbOperations.GetFTAApplicationMappingListbyId(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        #region BusinessMapping

        public JsonResult GetAllBusinessMapping(string BusinessId)
        {
            List<BusinessMappingMaster> lst = _dbOperations.GetBusinessMappingList(BusinessId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddBusinessMapping(BusinessMappingMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddBusinessMapping(taskInfo, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        //public JsonResult ModifyBusiness(BusinessMaster opp)
        //{
        //    string errordesc = "";
        //    int errocode = 0;
        //    _dbOperations.ModifyBusiness(opp, out errocode, out errordesc);
        //    return Json("", JsonRequestBehavior.AllowGet);
        //}

        public JsonResult DeleteBusinessMapping(string BusinessId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteBusinessMapping(BusinessId, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion BusinessMapping


        #region FTAStrategyMapping


        public JsonResult GetStrategyVersionLog(string Id)
        {
            List<StrategyVersionLog> lst = _dbOperations.GetStrategyVersionLog(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetAllFTAStrategyMapping(string FTAStrategyId)
        {
            List<FTAStrategyMappingMaster> lst = _dbOperations.GetFTAStrategyMappingList(FTAStrategyId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddFTAStrategyMapping(FTAStrategyMappingMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddFTAStrategyMapping(taskInfo, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        //public JsonResult ModifyBusiness(BusinessMaster opp)
        //{
        //    string errordesc = "";
        //    int errocode = 0;
        //    _dbOperations.ModifyBusiness(opp, out errocode, out errordesc);
        //    return Json("", JsonRequestBehavior.AllowGet);
        //}

        public JsonResult DeleteFTAStrategyMapping(string Id)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteFTAStrategyMapping(Id, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion FTAStrategyMapping



        #region FTAApplicationMapping

        public JsonResult GetAllFTAApplicationMapping(string BusinessId)
        {
            List<FTAApplicationMappingMaster> lst = _dbOperations.GetFTAApplicationMappingList(BusinessId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddFTAApplicationMapping(FTAApplicationMappingMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddFTAApplicationMapping(taskInfo, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        //public JsonResult ModifyBusiness(BusinessMaster opp)
        //{
        //    string errordesc = "";
        //    int errocode = 0;
        //    _dbOperations.ModifyBusiness(opp, out errocode, out errordesc);
        //    return Json("", JsonRequestBehavior.AllowGet);
        //}

        public JsonResult DeleteFTAApplicationMapping(string Id)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteFTAApplicationMapping(Id, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion FTAApplicationMapping


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


public class StrategyVersionLog
{
    public int Id { get; set; }
    public string RefNumber { get; set; }
    public string Version { get; set; }
    public string ChangeDesc { get; set; }
    public string FTAShortCode { get; set; }
    public string CreatedDateTime { get; set; }

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
    public string CreatedDate { get; set; }

    public string Status { get; set; }
    public string OriginalApprover { get; set; }
    public string Type { get; set; }
}


public class Strategy
{
    public int Id { get; set; }
    public string RefNumber { get; set; }
    public string Country { get; set; }
    public string CountryName { get; set; }
    public string Region { get; set; }
    public string RegionName { get; set; }
    public string Description { get; set; }

    public string NoOfApprover { get; set; }
    public int Version { get; set; }
    public string SignOff { get; set; }
    public string SignOffDate { get; set; }
    public string SignoffBy { get; set; }
    public string IsActive { get; set; }
    public string CreatedDate { get; set; }
    public string CreatedBy { get; set; }
    public string LastModifiedDate { get; set; }
    public string LastModifiedBy { get; set; }
    public string Page { get; set; }
    public int FTAApplicationCodeId { get; set; }
    public string FTAApplicationCode { get; set; }
    public int BusinessSuffixId { get; set; }
    public string BusinessSuffix { get; set; }
    public int ChildIDValue { get; set; }
    public string ChildID { get; set; }
    public int FTAStrategyNameId { get; set; }
    public string FTAStrategyName { get; set; }
    public int StrategytypeId { get; set; }
    public string Strategytype { get; set; }
    public string GOLiveDate { get; set; }
    public int FTAStrategyCodeId { get; set; }
    public string FTAStrategyCode { get; set; }
    public int FTAShortCodeId { get; set; }
    public string FTAShortCode { get; set; }
    public int BusinessLineId { get; set; }
    public string BusinessLine { get; set; }
    public int FTAApplicationNameId { get; set; }
    public string FTAApplicationName { get; set; }
    public string FTAStrategyOwnerId { get; set; }
    public string FTAStrategyOwner { get; set; }
    public int ApplicationCategoryId { get; set; }
    public string ApplicationCategory { get; set; }
    public string DecomissionedDate { get; set; }
    public int DiscretionaryCodeId { get; set; }
    public string DiscretionaryCode { get; set; }
    public int ParentIDValue { get; set; }
    public string ParentID { get; set; }
    public string FTAApplicationOwnerId { get; set; }
    public string FTAApplicationOwner { get; set; }
    public string PriorityScore { get; set; }
    public string Priority { get; set; }
    public int CapacityId { get; set; }
    public string Capacity { get; set; }
    public int VenueTypeId { get; set; }
    public string VenueType { get; set; }

    public int ThirdPartyAppId { get; set; }
    public string ThirdPartyValue { get; set; }
    public int BusinessId { get; set; }
    public string Business { get; set; }
    public string FTAApplicationMappingId { get; set; }
    public string FTAStrategyMappingId { get; set; }
    public string BusinessMappingId { get; set; }
    public string Systemflowfile { get; set; }
    public string Decommissionedfile { get; set; }

    public string ExistingSystemflowfile { get; set; }
    public string ExistingDecommissionedfile { get; set; }

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



public class FTAStrategyCodeMaster
{
    public string Id { get; set; }
    public string FTAStrategyCode { get; set; }

}
public class DiscretionaryCodeMaster
{
    public string Id { get; set; }
    public string DiscretionaryCode { get; set; }

}

public class BusinessSuffixMaster
{
    public string Id { get; set; }
    public string BusinessSuffix { get; set; }

}
public class BusinessMaster
{
    public string Id { get; set; }
    public string Business { get; set; }

}

public class ParentIDMaster
{
    public string Id { get; set; }
    public string ParentID { get; set; }

}
public class ChildIDMaster
{
    public string Id { get; set; }
    public string ChildID { get; set; }

}
public class BusinessLineMaster
{
    public string Id { get; set; }
    public string BusinessLine { get; set; }

}



public class FTAApplicationNameMaster
{
    public string Id { get; set; }
    public string FTAApplicationName { get; set; }

}
public class FTAApplicationOwnerMaster
{
    public string Id { get; set; }
    public string FTAApplicationOwner { get; set; }

}
public class FTAStrategyNameMaster
{
    public string Id { get; set; }
    public string FTAStrategyName { get; set; }

}
public class FTAStrategyOwnerMaster
{
    public string Id { get; set; }
    public string FTAStrategyOwner { get; set; }

}
public class SystemFlowMaster
{
    public string Id { get; set; }
    public string SystemFlow { get; set; }

}

public class ApplicationCategoryMaster
{
    public string Id { get; set; }
    public string ApplicationCategory { get; set; }

}
public class StrategytypeMaster
{
    public string Id { get; set; }
    public string Strategytype { get; set; }

}
public class VenuetypeMaster
{
    public string Id { get; set; }
    public string Venuetype { get; set; }

}
public class CapacityMaster
{
    public string Id { get; set; }
    public string Capacity { get; set; }

}
public class PriorityScoreMaster
{
    public string Id { get; set; }
    public string PriorityScore { get; set; }

}
public class FTAApplicationCodeMaster
{
    public string Id { get; set; }
    public string FTAApplicationCode { get; set; }

}

public class ThirdPartyApp
{
    public string Id { get; set; }
    public string Value { get; set; }

}


public class BusinessMappingMaster
{
    public string Id { get; set; }
    public string BusinessId { get; set; }
    public string Business { get; set; }
    public string BusinessSuffixId { get; set; }
    public string BusinessSuffix { get; set; }

}

public class FTAStrategyMappingMaster
{
    public string Id { get; set; }
    public string FTAStrategyNameId { get; set; }
    public string FTAStrategyName { get; set; }
    public string FTAStrategyCodeId { get; set; }
    public string FTAStrategyCode { get; set; }

}

public class FTAApplicationMappingMaster
{
    public string Id { get; set; }
    public string ThirdPartyAppId { get; set; }
    public string ThirdPartyAppName { get; set; }
    public string ChildId { get; set; }
    public string ChildIdValue { get; set; }
    public string FTAApplicationCodeId { get; set; }
    public string FTAApplicationCode { get; set; }
    public string FTAApplicationNameId { get; set; }
    public string FTAApplicationName { get; set; }
}
public static class SimpleComparer
{
    // Item1: property name, Item2 current, Item3 original
    public static List<Tuple<string, object, object>> Differences<T>(T current, T original)
    {
        var diffs = new List<Tuple<string, object, object>>();

        MethodInfo areEqualMethod = typeof(SimpleComparer).GetMethod("AreEqual", BindingFlags.Static | BindingFlags.NonPublic);

        foreach (PropertyInfo prop in typeof(T).GetProperties(BindingFlags.Instance | BindingFlags.Public))
        {
            object x = prop.GetValue(current);
            object y = prop.GetValue(original);
            bool areEqual = (bool)areEqualMethod.MakeGenericMethod(prop.PropertyType).Invoke(null, new object[] { x, y });

            if (!areEqual)
            {
                diffs.Add(Tuple.Create(prop.Name, x, y));
            }
        }

        return diffs;
    }

    private static bool AreEqual<T>(T x, T y)
    {
        return EqualityComparer<T>.Default.Equals(x, y);
    }
}
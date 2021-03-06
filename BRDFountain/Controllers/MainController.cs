﻿using BRDFountain.Models;
using log4net;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace BRDFountain.Controllers
{
    [NoCache]
    public class MainController : Controller
    {
        private DbOperations _dbOperations = new DbOperations();
        private static readonly ILog log = LogManager.GetLogger(typeof(MainController));

        /// <summary>
        /// Partial views rendering code
        /// </summary>
        /// <returns></returns>

        #region Partial Views
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

        /// <summary>
        /// Main pages views rendering code
        /// </summary>
        /// <returns></returns>

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
        public ActionResult Region()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult Reports()
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
        public ActionResult LTAApplicationCode()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult LTAStrategyCode()
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
        public ActionResult LTAApplicationMapping()
        {
            return View();
        }

        public ActionResult ReportApplicationMapping()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult LTAStrategyMapping()
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
        public ActionResult LTAApplicationName()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult LTAApplicationOwner()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult LTAStrategyName()
        {
            return View();
        }

        [SessionTimeout]
        public ActionResult LTAStrategyOwner()
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
            try
            {
                return Convert.ToString(Session["UserName"]);
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy insert {0}", e);
                return "";
            }
        }

        #region FileList
        public JsonResult Get_ApprovaltransferByuser()
        {
            List<StrategyApprover> lst = _dbOperations.Get_ApprovaltransferByuser(Convert.ToString(Session["UserName"]));
            return Json(lst, JsonRequestBehavior.AllowGet);
        }


        #endregion TransferSetting

        #region Strategy

        public JsonResult GetData()
        {
            try
            {
                List<Strategy> lst = _dbOperations.GetStrategyData(getloggedusername());
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy GetAll {0}", e);
                return Json("error", JsonRequestBehavior.AllowGet);
            }

        }

        public JsonResult GetDatabyId(string Strategynumber)
        {
            try
            {

                List<Strategy> lst = _dbOperations.GetStrategyDatabyId(Strategynumber);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy GetbyID {0}", e);
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetStrategyReport(StrategyReportFilter filter)
        {
            try
            {
                filter.userid = getloggedusername();
                List<Strategy> lst = _dbOperations.GetStrategyReport(filter);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy Report {0}", e);
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }



        public JsonResult GetApplicationReport(StrategyReportFilter filter)
        {
            try
            {
                filter.userid = getloggedusername();
                List<ReportAppMapping> lst = _dbOperations.GetApplicationReport(filter);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy Report {0}", e);
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }


        public string ExportReport(StrategyReportFilter filter)
        {
            try
            {
                filter.userid = getloggedusername();


                List<Strategy> lst = _dbOperations.GetStrategyReport(filter);
                if (lst.Count > 0)
                {
                    string[] columns = { "RegionName", "LTAApplicationCode", "LTAStrategyCode", "LTAApplicationName", "Discretionarycode", "BusinessSuffix", "ParentIdValue", "ChildIdValue", "BusinessLine", "CountryNameList", "LTAApplicationOwnerId", "ApplicationCategory", "LTAStrategyOwnerId", "LTAStrategyName", "StrategyType", "VenueType", "Capacity", "SignOff", "Priority", "PriorityScore", "business", "ThirdPartyAppName", "DecomissionedDate", "GoLiveDate" };
                    byte[] filecontent = ExcelExportHelper.ExportExcel(lst, "LTA Strategy Inventory Report", true, columns);
                    //return File(, System.Net.Mime.MediaTypeNames.Application.Octet, "Report.xlsx");
                    string mailbox = ConfigurationManager.AppSettings["FilePath"];
                    string filepath = mailbox + "/Report/";
                    bool exists = System.IO.Directory.Exists(@filepath);
                    if (!exists)
                        System.IO.Directory.CreateDirectory(@filepath);
                    string filename = Convert.ToString(Guid.NewGuid()) + ".xlsx";
                    if (!System.IO.File.Exists(filepath))
                    {
                        FileStream fileStream = System.IO.File.Create(filepath + filename, filecontent.Length);
                        fileStream.Write(filecontent, 0, filecontent.Length);
                        fileStream.Close();

                    }
                    return filename;
                }
                else
                    return "No Records";
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy Export Report {0}", e);
                return "error";
            }
        }

        public string ExportStrategyReport()
        {
            try
            {
                List<Strategy> lst = _dbOperations.GetStrategyData(getloggedusername());
                if (lst.Count > 0)
                {
                    string[] columns = { "RegionName", "LTAApplicationCode", "LTAStrategyCode", "LTAApplicationName", "Discretionarycode", "BusinessSuffix", "ParentIdValue", "ChildIdValue", "BusinessLine", "CountryNameList", "LTAApplicationOwnerId", "ApplicationCategory", "LTAStrategyOwnerId", "LTAStrategyName", "StrategyType", "VenueType", "Capacity", "SignOff", "Priority", "PriorityScore", "business", "ThirdPartyAppName", "DecomissionedDate", "GoLiveDate" };
                    byte[] filecontent = ExcelExportHelper.ExportExcel(lst, "LTA Strategy Inventory Report", true, columns);
                    //return File(, System.Net.Mime.MediaTypeNames.Application.Octet, "Report.xlsx");
                    string mailbox = ConfigurationManager.AppSettings["FilePath"];
                    string filepath = mailbox + "/Report/";
                    bool exists = System.IO.Directory.Exists(@filepath);
                    if (!exists)
                        System.IO.Directory.CreateDirectory(@filepath);
                    string filename = Convert.ToString(Guid.NewGuid()) + ".xlsx";
                    if (!System.IO.File.Exists(filepath))
                    {
                        FileStream fileStream = System.IO.File.Create(filepath + filename, filecontent.Length);
                        fileStream.Write(filecontent, 0, filecontent.Length);
                        fileStream.Close();

                    }
                    return filename;
                }
                else
                    return "No Records";
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy Export Report {0}", e);
                return "error";
            }
        }

        public string ExportReportFilter(StrategyReportFilter filter)
        {
            try
            {
                List<ReportAppMapping> lst = new List<ReportAppMapping>();
                if (filter.ISREPORTPAGE == "Y")
                    lst = _dbOperations.GetApplicationReport(filter);
                else
                    lst = _dbOperations.GetReportApplicationMappingList("");
                if (lst.Count > 0)
                {
                    string[] columns = { "LTAApplicationName", "LTAApplicationCode", "ChildId", "ThirdPartyAppName", "ParentID", "ApplicationOwner", "ApplicationCategory", "BusinessLine", "CountryName", "RegionName", "Attest" };
                    byte[] filecontent = ExcelExportHelper.ExportExcel(lst, "LTA Application Inventory", true, columns);
                    //return File(, System.Net.Mime.MediaTypeNames.Application.Octet, "Report.xlsx");
                    string mailbox = ConfigurationManager.AppSettings["FilePath"];
                    string filepath = mailbox + "/Report/";
                    bool exists = System.IO.Directory.Exists(@filepath);
                    if (!exists)
                        System.IO.Directory.CreateDirectory(@filepath);
                    string filename = Convert.ToString(Guid.NewGuid()) + ".xlsx";
                    if (!System.IO.File.Exists(filepath))
                    {
                        FileStream fileStream = System.IO.File.Create(filepath + filename, filecontent.Length);
                        fileStream.Write(filecontent, 0, filecontent.Length);
                        fileStream.Close();
                    }
                    return filename;
                }
                else
                    return "No Records";
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy ExportReportFilter {0}", e);
                return "error";
            }

        }

        public JsonResult GetStrategyApprovalByuser()
        {
            try
            {
                List<StrategyApprover> lst = _dbOperations.Get_StrategyApprovalByuser(Convert.ToString(Session["UserName"]));
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy GetStrategyApprovalByuser {0}", e);
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetStrategyDelegatesApprovalByuser()
        {
            try
            {
                List<StrategyApprover> lst = _dbOperations.GetStrategyDelegatesApprovalByuser(Convert.ToString(Session["UserName"]));
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy GetStrategyDelegatesApprovalByuser {0}", e);
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetDelegatedApprovalByuser()
        {
            try
            {
                List<StrategyApprover> lst = _dbOperations.Get_DelegatedApprovalByuser(Convert.ToString(Session["UserName"]));
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy GetDelegatedApprovalByuser {0}", e);
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetStrategyApprovalById(string Strategynumber, string Version)
        {
            try
            {
                List<StrategyApprover> lst = _dbOperations.Get_StrategyApprovalById(Strategynumber, Version);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy GetStrategyApprovalById {0}", e);
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult InsertStrategy(Strategy strategy)
        {
            try
            {
                log.Info("inside method");
                strategy.Version = 1;
                strategy.RefNumber = DateTime.Now.ToString("yyyyMMddHHmmssfff");
                string mailbox = ConfigurationManager.AppSettings["FilePath"];
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
                        files.Uploadedby = getloggedusername();
                        var fileContent = Request.Files[file];
                        if (file.Contains("Systemflowfilelist"))
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
                    log.Info("insert approver");
                    _dbOperations.InsertStrategyApprover(lstfiles, lstfiles[0].RefNumber, lstfiles[0].Version, out errorcode, out errordesc);
                }
                strategy.CreatedBy = getloggedusername();
                log.Info("insert strategy");
                _dbOperations.InsertStrategydata(strategy, out errorcode, out errordesc);
                log.Info("insert strategy completed");
                _dbOperations.insertStrategyVersionChange(strategy.RefNumber, 1, "Version Created", getloggedusername());
                return Json(errordesc, JsonRequestBehavior.AllowGet);

            }
            catch (Exception e)
            {
                log.ErrorFormat("Error in strategy insert {0}", e);
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }

        public FileResult DownLoadFile(string FileName, string RefNumber, string Version)
        {
            try
            {
                log.InfoFormat("Called DownLoadFile method with param FileName {0}", FileName);
                string mailbox = ConfigurationManager.AppSettings["FilePath"];
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

        public FileResult DownLoadReportFile(string FileName, string Page)
        {
            try
            {
                log.InfoFormat("Called DownLoadFile method with param FileName {0}", FileName);
                string mailbox = ConfigurationManager.AppSettings["FilePath"];
                string filepath = mailbox + "/Report/";
                string filePath1 = filepath + FileName;

                if (!System.IO.File.Exists(filePath1))
                {
                    throw new Exception();
                }

                byte[] fileBytes = System.IO.File.ReadAllBytes(filePath1);

                string name = "LTAStrategyReport.xlsx";
                if (Page == "Mapping")
                    name = "LTAStrategyInventoryReport.xlsx";
                else if (Page == "StrategyReport")
                    name = "LTAStrategyinventory-" + DateTime.Now.ToString("yyyyMMddHHmm") + ".xlsx";
                else
                    name = "LTAStrategyReport-" + DateTime.Now.ToString("yyyyMMddHHmm") + ".xlsx";
                return File(fileBytes, ExcelExportHelper.ExcelContentType, name);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DownLoadFile {0}", ex);
                return null;
            }
        }

        public JsonResult InsertStrategyApprover(List<StrategyApprover> strategy)
        {
            try
            {
                string errordesc = "";
                int errorcode = 0;
                if (strategy.Count > 0)
                    _dbOperations.InsertStrategyApprover(strategy, strategy[0].RefNumber, strategy[0].Version, out errorcode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in InsertStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult ModifyStrategyApprover(List<StrategyApprover> strategy)
        {
            try
            {
                string errordesc = "";
                int errorcode = 0;
                if (strategy.Count > 0)
                    _dbOperations.InsertStrategyApprover(strategy, strategy[0].RefNumber, strategy[0].Version, out errorcode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in ModifyStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult DeleteStrategyApprover(List<StrategyApprover> strategy)
        {
            try
            {
                string errordesc = "";
                int errorcode = 0;
                if (strategy != null && strategy.Count > 0)
                    _dbOperations.DeleteStrategyApprover(strategy, strategy[0].RefNumber, out errorcode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult UpdateStrategyApprover(StrategyApprover strategy)
        {
            try
            {
                string errordesc = "";
                int errorcode = 0;
                _dbOperations.UpdateStrategyApprover(strategy, out errorcode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult updatedelegateAcceptance(StrategyApprover strategy)
        {
            try
            {
                string errordesc = "";
                int errorcode = 0;
                _dbOperations.updatedelegateAcceptance(strategy, out errorcode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult UpdateStrategy(List<Strategy> Strategy)
        {
            try
            {
                string errordesc = "";
                int errorcode = 0;

                var diffs = SimpleComparer.Differences(Strategy[0], Strategy[1]);

                var data = diffs.FindAll(x => x.Item1.Equals("Region") || x.Item1.Equals("BusinessSuffix") || x.Item1.Equals("LTAApplicationCode") || x.Item1.Equals("ChildIDValue")
                || x.Item1.Equals("LTAStrategyName") || x.Item1.Equals("Strategytype") || x.Item1.Equals("GOLiveDate") || x.Item1.Equals("LTAStrategyCode") || x.Item1.Equals("LTAShortCode") || x.Item1.Equals("BusinessLine") || x.Item1.Equals("LTAApplicationName") || x.Item1.Equals("LTAStrategyOwner") || x.Item1.Equals("ApplicationCategory") || x.Item1.Equals("Venuetype") || x.Item1.Equals("DecomissionedDate") || x.Item1.Equals("DiscretionaryCode")
                || x.Item1.Equals("ParentIDValue") || x.Item1.Equals("LTAApplicationOwner") || x.Item1.Equals("PriorityScore") || x.Item1.Equals("Priority") || x.Item1.Equals("Capacity")
                || x.Item1.Equals("Description") || x.Item1.Equals("Attest") || x.Item1.Equals("LTALongCode") || x.Item1.Equals("AdditionalShortCode") ||
                x.Item1.Equals("SeniorManagementFunction") || x.Item1.Equals("Status"));
                string Changedata = "";

                var set1 = new HashSet<string>();
                if (Strategy[0].CountryId != null)
                    set1 = new HashSet<string>(Strategy[0].CountryId.Split(',').Select(t => t.Trim()));

                bool setsEqual = true;
                if (Strategy[1].CountryId != null)
                    setsEqual = set1.SetEquals(Strategy[1].CountryId.Split(',').Select(t => t.Trim()));
                else
                {
                    if (Strategy[0].CountryId != null)
                        setsEqual = false;
                }

                if (data.Count() > 0 || !setsEqual)
                {
                    //x.Item1.Equals("CountryName") ||
                    foreach (var diff in data)
                    {
                        Changedata += " " + diff.Item1 + " - " + diff.Item3 + " - Changed to " + diff.Item2 + " \n";
                    }
                    if (!setsEqual)
                        Changedata += " Country Name  - " + Strategy[1].CountryNameList + " - Changed to " + Strategy[0].CountryNameList + " \n";

                    Strategy[0].RefNumber = Strategy[1].RefNumber;
                    Strategy[0].Version = Strategy[1].Version + 1;
                    Strategy[0].CreatedBy = Convert.ToString(Session["UserName"]);
                    _dbOperations.InsertStrategydata(Strategy[0], out errorcode, out errordesc);
                    _dbOperations.insertStrategyVersionChange(Strategy[0].RefNumber, Strategy[0].Version, Changedata, Convert.ToString(Session["UserName"]));
                }

                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in UpdateStrategy {0}", ex);
                return null;
            }
        }

        public JsonResult UpdateStrategyFile(Strategy strategy)
        {
            try
            {
                string mailbox = ConfigurationManager.AppSettings["FilePath"];
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
                        files.Uploadedby = getloggedusername();
                        var fileContent = Request.Files[file];
                        if (file.Contains("Systemflowfilelist"))
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

        #region Roles

        public JsonResult GetUserRoles(string userId)
        {
            try
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
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult GetUsersByRoles(string Roleid)
        {
            try
            {
                List<UserMaster> lst = _dbOperations.GetUsersByRoles(Roleid);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult GetUserRights(string userId)
        {
            try
            {

                List<RightMaster> lst = _dbOperations.GetRightsList(userId);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult GetRoleRightMapping(string roleId)
        {
            try
            {
                List<RoleRightMapping> lst = _dbOperations.GetRoleRightMapping(roleId);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult roles(string roleId)
        {
            try
            {
                List<Roles> lst = _dbOperations.GetRoles(roleId);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult GetRights(string right)
        {
            try
            {
                List<RightMaster> lst = _dbOperations.GetRights(right);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult AddRole(RoleRightMapping obj)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                int id = _dbOperations.AddRole(obj.selectedRole, out errocode, out errordesc);
                return Json(id, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult AddRoleRightMapping([FromBody]RoleRightMapping obj)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddRoleRightMapping(obj, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyRoleRight([FromBody]RoleRightMapping obj)
        {
            try
            {
                string errordesc = "";
                _dbOperations.ModifyRoleRight(obj);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteRole(RoleRightMapping obj)
        {
            try
            {
                string errordesc = "";
                _dbOperations.DeleteRole(obj.id);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        #endregion Roles

        #region User

        public JsonResult getusers(string userid)
        {
            try
            {
                List<UserMaster> lst = _dbOperations.GetUser(userid);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult profile(string userId)
        {
            try
            {
                string errordesc = "";
                _dbOperations.GetUserProfile(userId);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult GetUserSessionInfo(string createdOn)
        {
            try
            {
                string errordesc = "";

                _dbOperations.GetUserSessionInfo(createdOn);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult GetUserbyFilter(string RegionId, string BusinessLineId)
        {
            try
            {
                List<UserMaster> lst = _dbOperations.GetUserbyFilter(RegionId, BusinessLineId);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
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
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult CreateTempUser(UserMaster user)
        {
            try
            {
                string username = ConfigurationManager.AppSettings["DefaultPassword"];
                user.Password = username;
                string errordesc = "";
                int errocode = 0;
                _dbOperations.CreateTempUser(user, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public string ResetPasswordReq(UserMaster user)
        {
            string errordesc = "";
            int errocode = 0;

            user.Password = ConfigurationManager.AppSettings["DefaultPassword"];
            user.IsPasswordReset = true;
            _dbOperations.resetuser(user, out errocode, out errordesc);
            return "success";

        }


        //public JsonResult GetusercountryMapping(string userId)
        //{
        //    try
        //    {
        //        List<CountryMaster> lst = _dbOperations.GetusercountryMapping(userId);
        //        return Json(lst, JsonRequestBehavior.AllowGet);
        //    }
        //    catch (Exception ex)
        //    {
        //        log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
        //        return null;
        //    }
        //}

        public JsonResult GetuserRegionMapping(string userId)
        {
            try
            {
                List<RegionMaster> lst = _dbOperations.GetuserregionMapping(userId);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
                return null;
            }
        }

        public JsonResult GetBusinessMapping(string userId)
        {
            try
            {
                List<BusinessLineMaster> lst = _dbOperations.GetuserbusinessMapping(userId);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error in DeleteStrategyApprover {0}", ex);
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
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteUser(string user)
        {
            try
            {
                string errordesc = "";

                _dbOperations.DeleteUser(user);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }
        #endregion User

        #region Country

        public JsonResult GetAllCountry(string CountryId)
        {
            try
            {

                List<CountryMaster> lst = _dbOperations.GetCountryList(CountryId);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return null;
            }
        }

        public JsonResult AddCountry(CountryMaster taskInfo)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddCountry(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyCountry(CountryMaster opp)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.ModifyCountry(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteCountry(string CountryId)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.DeleteCountry(CountryId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
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
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddRegion(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyRegion(RegionMaster opp)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.ModifyRegion(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteRegion(string RegionId)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.DeleteRegion(RegionId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        #endregion Region

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

        #region LTAApplicationCode

        public JsonResult GetAllLTAApplicationCode(string LTAApplicationCodeId)
        {
            try
            {
                log.Info("Get All LTA Application - Begin ");
                List<LTAApplicationCodeMaster> lst = _dbOperations.getFTAApplicationCodeList(LTAApplicationCodeId);
                log.Info("Get All LTA Application Called - End");
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.Error(e);
                return null;
            }
        }

        public JsonResult AddLTAApplicationCode(LTAApplicationCodeMaster taskInfo)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddLTAApplicationCode(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.Error(e);
                return null;
            }
        }

        public JsonResult ModifyLTAApplicationCode(LTAApplicationCodeMaster opp)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.ModifyLTAApplicationCode(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.Error(e);
                return null;
            }
        }

        public JsonResult DeleteLTAApplicationCode(string LTAApplicationCodeId)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.DeleteLTAApplicationCode(LTAApplicationCodeId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.Error(e);
                return null;
            }
        }

        #endregion LTAApplicationCode

        #region LTAStrategyCode

        public JsonResult GetAllLTAStrategyCode(string LTAStrategyCodeId)
        {
            try
            {
                List<LTAStrategyCodeMaster> lst = _dbOperations.getFTAStrategyCodeList(LTAStrategyCodeId);
                return Json(lst, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.Error(e);
                return null;
            }

        }

        public JsonResult AddLTAStrategyCode(LTAStrategyCodeMaster taskInfo)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddLTAStrategyCode(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.Error(e);
                return null;
            }
        }

        public JsonResult ModifyLTAStrategyCode(LTAStrategyCodeMaster opp)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.ModifyLTAStrategyCode(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.Error(e);
                return null;
            }
        }

        public JsonResult DeleteLTAStrategyCode(string LTAStrategyCodeId)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.DeleteLTAStrategyCode(LTAStrategyCodeId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.Error(e);
                return null;
            }
        }

        #endregion LTAStrategyCode


        #region DiscretionaryCode

        public JsonResult GetAllDiscretionaryCode(string DiscretionaryCodeId)
        {
            List<DiscretionaryCodeMaster> lst = _dbOperations.GetDiscretionaryCodeList(DiscretionaryCodeId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddDiscretionaryCode(DiscretionaryCodeMaster taskInfo)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddDiscretionaryCode(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyDiscretionaryCode(DiscretionaryCodeMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyDiscretionaryCode(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteDiscretionaryCode(string DiscretionaryCodeId)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.DeleteDiscretionaryCode(DiscretionaryCodeId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
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
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddBusinessSuffix(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyBusinessSuffix(BusinessSuffixMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyBusinessSuffix(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteBusinessSuffix(string BusinessSuffixId)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.DeleteBusinessSuffix(BusinessSuffixId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
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
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddBusiness(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyBusiness(BusinessMaster opp)
        {

            try
            {
                string errordesc = ""; int errocode = 0;
                _dbOperations.ModifyBusiness(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteBusiness(string BusinessId)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.DeleteBusiness(BusinessId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
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
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddParentID(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyParentID(ParentIDMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyParentID(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteParentID(string ParentIDId)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.DeleteParentID(ParentIDId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
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
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddChildID(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyChildID(ChildIDMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyChildID(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteChildID(string ChildIDId)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.DeleteChildID(ChildIDId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
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
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddBusinessLine(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyBusinessLine(BusinessLineMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyBusinessLine(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteBusinessLine(string BusinessLineId)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.DeleteBusinessLine(BusinessLineId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        #endregion BusinessLine

        #region LTAApplicationName

        public JsonResult GetAllLTAApplicationName(string LTAApplicationNameId)
        {
            List<LTAApplicationNameMaster> lst = _dbOperations.getFTAApplicationNameList(LTAApplicationNameId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddLTAApplicationName(LTAApplicationNameMaster taskInfo)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddLTAApplicationName(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyLTAApplicationName(LTAApplicationNameMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyLTAApplicationName(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteLTAApplicationName(string LTAApplicationNameId)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.DeleteLTAApplicationName(LTAApplicationNameId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        #endregion LTAApplicationName

        #region LTAApplicationOwner

        public JsonResult GetAllLTAApplicationOwner(string LTAApplicationOwnerId)
        {
            List<LTAApplicationOwnerMaster> lst = _dbOperations.getFTAApplicationOwnerList(LTAApplicationOwnerId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddLTAApplicationOwner(LTAApplicationOwnerMaster taskInfo)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddLTAApplicationOwner(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyLTAApplicationOwner(LTAApplicationOwnerMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyLTAApplicationOwner(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteLTAApplicationOwner(string LTAApplicationOwnerId)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.DeleteLTAApplicationOwner(LTAApplicationOwnerId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        #endregion LTAApplicationOwner

        #region LTAStrategyName

        public JsonResult GetAllLTAStrategyName(string LTAStrategyNameId)
        {
            List<LTAStrategyNameMaster> lst = _dbOperations.getFTAStrategyNameList(LTAStrategyNameId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddLTAStrategyName(LTAStrategyNameMaster taskInfo)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddLTAStrategyName(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyLTAStrategyName(LTAStrategyNameMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyLTAStrategyName(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteLTAStrategyName(string LTAStrategyNameId)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.DeleteLTAStrategyName(LTAStrategyNameId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        #endregion LTAStrategyName

        #region ApplicationCategory

        public JsonResult GetAllApplicationCategory(string ApplicationCategoryId)
        {
            List<ApplicationCategoryMaster> lst = _dbOperations.GetApplicationCategoryList(ApplicationCategoryId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddApplicationCategory(ApplicationCategoryMaster taskInfo)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddApplicationCategory(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyApplicationCategory(ApplicationCategoryMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyApplicationCategory(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteApplicationCategory(string ApplicationCategoryId)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.DeleteApplicationCategory(ApplicationCategoryId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
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
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddStrategytype(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyStrategytype(StrategytypeMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyStrategytype(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteStrategytype(string StrategytypeId)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.DeleteStrategytype(StrategytypeId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
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
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.AddVenuetype(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyVenuetype(VenuetypeMaster opp)
        {
            try
            {
                string errordesc = "";

                int errocode = 0;
                _dbOperations.ModifyVenuetype(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteVenuetype(string VenuetypeId)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.DeleteVenuetype(VenuetypeId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
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
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddCapacity(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult ModifyCapacity(CapacityMaster opp)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.ModifyCapacity(opp, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e) { log.Error(e); return null; }
        }

        public JsonResult DeleteCapacity(string CapacityId)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.DeleteCapacity(CapacityId, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                log.Error(e);
                return null;
            }
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

        public JsonResult GetAllLTAStrategyMappingbyId(string Id)
        {
            List<LTAStrategyMappingMaster> lst = _dbOperations.getFTAStrategyMappingListbyId(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllLTAApplicationMappingbyId(string Id)
        {
            List<LTAApplicationMappingMaster> lst = _dbOperations.getFTAApplicationMappingListbyId(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllStatusType(string Id)
        {
            List<StatusMaster> lst = _dbOperations.GetAllStatusType(Id);
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

        public JsonResult DeleteBusinessMapping(string BusinessId)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteBusinessMapping(BusinessId, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion BusinessMapping

        #region LTAStrategyMapping

        public JsonResult GetStrategyVersionLog(string Id)
        {
            List<StrategyVersionLog> lst = _dbOperations.GetStrategyVersionLog(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetAllLTAStrategyMapping(string LTAStrategyId)
        {
            List<LTAStrategyMappingMaster> lst = _dbOperations.getFTAStrategyMappingList(LTAStrategyId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddLTAStrategyMapping(LTAStrategyMappingMaster taskInfo)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.AddLTAStrategyMapping(taskInfo, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteLTAStrategyMapping(string Id)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteLTAStrategyMapping(Id, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion LTAStrategyMapping

        #region LTAApplicationMapping

        public JsonResult GetAllLTAApplicationMapping(string BusinessId)
        {
            List<LTAApplicationMappingMaster> lst = _dbOperations.getFTAApplicationMappingList(BusinessId);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateLTAApplicationMapping(LTAApplicationMappingMaster taskInfo)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.UpdateLTAApplicationMapping(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return null;
            }
        }
        public JsonResult AddLTAApplicationMapping(LTAApplicationMappingMaster taskInfo)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddLTAApplicationMapping(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public JsonResult DeleteLTAApplicationMapping(string Id)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteLTAApplicationMapping(Id, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        #endregion LTAApplicationMapping


        #region ReportApplicationMapping

        public JsonResult GetAllReportApplicationMapping(string Id)
        {
            List<ReportAppMapping> lst = _dbOperations.GetReportApplicationMappingList(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddReportMapping(ReportAppMapping taskInfo)
        {
            try
            {
                string errordesc = "";
                int errocode = 0;
                _dbOperations.AddReportApplicationMapping(taskInfo, out errocode, out errordesc);
                return Json(errordesc, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public JsonResult DeleteReportApplicationMapping(string Id)
        {
            string errordesc = "";
            int errocode = 0;
            _dbOperations.DeleteReportApplicationMapping(Id, out errocode, out errordesc);
            return Json(errordesc, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllReportApplicationAutofill(string Id)
        {
            List<ReportAppMapping> lst = _dbOperations.GetReportApplicationfilter(Id);
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        #endregion ReportApplicationMapping
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


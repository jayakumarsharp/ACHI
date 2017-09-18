using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CRMManagement.Controllers
{
    public class MainController : Controller
    {
        private DbOperations _dbOperations = new DbOperations();

        //
        // GET: /Main/

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
                _dbOperations.UpdateOnboardingTaskdata(Id, ExisitingFiles,TaskComments, out errocode, out errordesc);

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
    public int Id{ get; set; }

}
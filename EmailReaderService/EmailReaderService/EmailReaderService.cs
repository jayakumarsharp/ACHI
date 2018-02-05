using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.IO;
using System.Net.Mail;
using log4net;
using System.Configuration;
using Exception = System.Exception;
using System.Text.RegularExpressions;
using System.Collections;
using System.Xml.Serialization;
using System.Xml;
using MySql.Data.MySqlClient;
using System.Globalization;
using OpenPop.Pop3;
using OpenPop.Mime;

namespace EmailReaderService
{
    public partial class EmailReader : ServiceBase
    {
        private readonly ILog log = LogManager.GetLogger(typeof(EmailReader));
        string emailCountFile = AppDomain.CurrentDomain.BaseDirectory + "\\emailCountFile.txt";
        private string connString = string.Empty;
        private MySqlConnection connection;
        private bool isStopped = false;

        string strTimeSec = ConfigurationManager.AppSettings["TimeSec"];
        ArrayList messageList = new ArrayList();
        string mailbox = "";
        Pop3Client client = new Pop3Client();

        //SqlDatabase dbconnection;
        System.Threading.Thread thread;
        public EmailReader()
        {
            try
            {
                log.Info("Begin Constructor");
                InitializeComponent();
                OnStart(null);
            }
            catch (Exception e)
            {
                log.Error(e.InnerException);
            }
        }
        protected override void OnStart(string[] args)
        {
            try
            {
                log.Info("Service started");
                mailbox = @"C:/EMail/inbox";
                log.Info("End Constructor");
                //client.Connect(ConfigurationManager.AppSettings["HostName"], 993, true);
                client.Connect("pop3.live.com", 995, true);
                connString = ConfigurationManager.ConnectionStrings["CRMConn"].ConnectionString.ToString();
                connection = new MySqlConnection(connString);
                // client.Authenticate(ConfigurationManager.AppSettings["MailID"], ConfigurationManager.AppSettings["Password"]);
                //client.Authenticate("jayakumar.t@servion.com", "boomathi@1992");
                client.Authenticate("savvyjayakumar@outlook.com", "Welcome@123");
                log.Info("Thread begin");
                thread = new System.Threading.Thread(ReadMails);
                thread.Start();
                log.Info("Thread started");
            }
            catch (Exception e)
            {
                log.Info("Error in connect mail");
                log.Error(e.InnerException);
            }
        }
        protected override void OnStop()
        {
            isStopped = true;
            thread.Abort();
        }
        public void ReadMails()
        {
            while (true)
            {
                try
                {


                    System.Threading.Thread.Sleep(60000);
                    if (isStopped)
                    {
                        log.Info("Service is stopped");
                        thread.Abort();
                        break;
                    }

                    int MessageCount = client.GetMessageCount();

                    /// MailInfo[] infos = oClient.GetMailInfos();
                    List<Message> allMessages = new List<Message>(MessageCount);
                    if (MessageCount > 0)
                    {
                        Message lastMessage = client.GetMessage(MessageCount);
                        if (lastMessage != null)
                        {
                            var mailReceivedDate = Convert.ToDateTime(lastMessage.Headers.Date);
                            System.TimeSpan diff = DateTime.Now.Subtract(mailReceivedDate);
                            if (diff.TotalMinutes > 60)
                            {
                                log.Info("Clearing Array List");
                                messageList.Clear();
                            }
                        }
                        for (int i = MessageCount; i > 0; i--)
                        {
                            EmailData objmaildata = new EmailData();
                            log.InfoFormat("MsgCount: {0}  ", i);
                            Message CurrentMessage = client.GetMessage(i);
                            //  Mail CurrentMessage = oClient.GetMail(info);
                            var mailReceivedDate = Convert.ToDateTime(CurrentMessage.Headers.Date);
                            System.TimeSpan diff = DateTime.Now.Subtract(mailReceivedDate);
                            if (diff.TotalMinutes > 60)
                            {
                                log.Info("No Emails in last 60 min");
                                break;
                            }

                            string messageId = CurrentMessage.Headers.MessageId;
                            if (!messageList.Contains(messageId))
                            {
                                string a = CurrentMessage.Headers.Subject;
                                objmaildata.ClientNumber = "";
                                objmaildata.UniqueEmailID = messageId;

                                for (int j = 0; j < a.Length; j++)
                                {
                                    if (Char.IsDigit(a[j]))
                                        objmaildata.ClientNumber += a[j];
                                }

                                messageList.Add(messageId);

                                string fromEmailID = CurrentMessage.Headers.From.Address;
                                objmaildata.CreatedBy = fromEmailID;
                                objmaildata.EmailID = fromEmailID;
                                // string fileDataHtml = CurrentMessage.MessagePart.GetBodyAsText();
                                string xml = "";


                                MessagePart html = CurrentMessage.FindFirstHtmlVersion();
                                if (html != null)
                                {
                                    xml = html.GetBodyAsText();
                                }

                                //fileDataHtml = Regex.Replace(fileDataHtml, "&nbsp;", String.Empty);
                                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                                doc.LoadHtml(xml.ToString());

                                string str = xml.ToString();
                                string clientmail = fromEmailID.Split('@')[0];
                                string filepath = mailbox + "/" + objmaildata.ClientNumber + "/";
                                bool exists = System.IO.Directory.Exists(@filepath);
                                if (!exists)
                                    System.IO.Directory.CreateDirectory(@filepath);
                                foreach (MessagePart attachment in CurrentMessage.FindAllAttachments())
                                {
                                    FileInfo file = new FileInfo(@filepath + attachment.ContentDescription);
                                    attachment.Save(file);
                                    objmaildata.EmailAttachment = attachment.ContentDescription + ",";
                                }
                                objmaildata.CreatedDate = CurrentMessage.Headers.DateSent;
                                objmaildata.IsMappedToTask = "N";
                                objmaildata.content = str;
                                objmaildata.Subject = CurrentMessage.Headers.Subject;

                                Inserttaskdata(objmaildata);
                                //oClient.Move(LastMailinfo, destFolder);
                            }
                        }
                    }

                }
                catch (Exception ex)
                {
                    log.ErrorFormat("Error occured ReadMails : {0}", ex);
                    System.Threading.Thread.Sleep(Convert.ToInt32(strTimeSec));
                    //SendErrorEmail(fromEmailID, null);
                }
            }
            return;
        }


        public string Beautify(XmlDocument doc)
        {
            StringBuilder sb = new StringBuilder();
            XmlWriterSettings settings = new XmlWriterSettings
            {
                Indent = true,
                IndentChars = "  ",
                NewLineChars = "\r\n",
                NewLineHandling = NewLineHandling.Replace
            };
            using (XmlWriter writer = XmlWriter.Create(sb, settings))
            {
                doc.Save(writer);
            }
            return sb.ToString();
        }
        public static string StripHTML(string input)
        {
            string temp = string.Empty;
            temp = Regex.Replace(input, "<.*?>", String.Empty);
            temp = Regex.Replace(temp, "\n", String.Empty);
            temp = Regex.Replace(temp, "\r", String.Empty);
            temp = Regex.Replace(temp, "\n", String.Empty);
            return temp;
        }
        public void Inserttaskdata(EmailData _taskInfo)
        {
            try
            {
                using (MySqlCommand cmd = new MySqlCommand("SP_insert_OnboardingTask", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new MySqlParameter("i_UniqueEmailID", _taskInfo.UniqueEmailID));
                    cmd.Parameters.Add(new MySqlParameter("i_EmailID", _taskInfo.EmailID));
                    cmd.Parameters.Add(new MySqlParameter("i_ClientNumber", _taskInfo.ClientNumber));
                    cmd.Parameters.Add(new MySqlParameter("i_Subject", _taskInfo.Subject));
                    cmd.Parameters.Add(new MySqlParameter("i_EmailContent", _taskInfo.content));
                    cmd.Parameters.Add(new MySqlParameter("i_IsMappedToTask", _taskInfo.IsMappedToTask));
                    cmd.Parameters.Add(new MySqlParameter("i_EmailAttachment", _taskInfo.EmailAttachment));
                    cmd.Parameters.Add(new MySqlParameter("i_CreatedDate", _taskInfo.CreatedDate.ToString("yyyy-MM-dd")));
                    cmd.Parameters.Add(new MySqlParameter("i_CreatedBy", _taskInfo.CreatedBy));
                    cmd.Parameters.Add(new MySqlParameter("i_TaskAssignedDate", DateTime.Now.ToString("yyyy-MM-dd")));


                    if (this.OpenConnection() == true)
                    {
                        cmd.ExecuteNonQuery();
                        this.CloseConnection();
                    }
                }
            }
            catch (MySqlException e)
            {
                this.CloseConnection();
                throw e;
            }
            catch (Exception e)
            {
                this.CloseConnection();
                throw e;
            }
        }
        private bool OpenConnection()
        {
            try
            {
                connection.Open();
                return true;
            }
            catch (MySqlException ex)
            {
                //When handling errors, you can your application's response based on the error number.
                //The two most common error numbers when connecting are as follows:
                //0: Cannot connect to server.
                //1045: Invalid user name and/or password.
                switch (ex.Number)
                {
                    case 0:
                        log.Error("Cannot connect to server.  Contact administrator");
                        break;

                    case 1045:
                        log.Error("Invalid username/password, please try again");
                        break;
                }
                return false;
            }
        }
        private bool CloseConnection()
        {
            try
            {
                connection.Close();
                return true;
            }
            catch (MySqlException ex)
            {
                connection.Close();
                log.Error(ex.Message);
                return false;
            }
        }


    }

    public class EmailData
    {
        public string UniqueEmailID { get; set; }
        public string EmailID { get; set; }
        public string ClientNumber { get; set; }
        public string Subject { get; set; }
        public string content { get; set; }
        public string EmailAttachment { get; set; }
        public string IsMappedToTask { get; set; }
        public DateTime CreatedDate { get; set; }

        public string CreatedBy { get; set; }
    }
}

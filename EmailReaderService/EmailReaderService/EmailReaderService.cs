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
using EAGetMail;
using MySql.Data.MySqlClient;
using System.Globalization;

namespace EmailReaderService
{
    public partial class OppertunityReaderService : ServiceBase
    {
        private readonly ILog log = LogManager.GetLogger(typeof(OppertunityReaderService));
        string emailCountFile = AppDomain.CurrentDomain.BaseDirectory + "\\emailCountFile.txt";
        private string connString = string.Empty;
        private MySqlConnection connection;
        private string server;
        private string database;
        private string uid;
        private string password;

        string strTimeSec = ConfigurationManager.AppSettings["TimeSec"];
        ArrayList messageList = new ArrayList();
        string mailbox = "";

        MailServer oServer = new MailServer(ConfigurationManager.AppSettings["HostName"],
          ConfigurationManager.AppSettings["MailID"], ConfigurationManager.AppSettings["Password"], ServerProtocol.Imap4);
        MailClient oClient = new MailClient("TryIt");

        //SqlDatabase dbconnection;
        System.Threading.Thread thread;
        public OppertunityReaderService()
        {
            server = "localhost";
            database = "coba";
            uid = "root";
            password = "Servion@123";
            string connectionString;
            connectionString = "SERVER=" + server + ";" + "DATABASE=" + database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";

            connection = new MySqlConnection(connectionString);

            log.Info("Begin Constructor");
            InitializeComponent();
            mailbox = @"D:/EMail/inbox";
            log.Info("End Constructor");
            OnStart(null);
        }
        protected override void OnStart(string[] args)
        {
            log.Info("Service strarted");
            thread = new System.Threading.Thread(ReadMails);
            thread.Start();
        }
        protected override void OnStop()
        {
            thread.Abort();
        }
        public void ReadMails()
        {
            oServer.SSLConnection = true;
            oServer.Port = 993;
            while (true)
            {
                try
                {
                    oClient.Connect(oServer);
                    Imap4Folder destFolder = getfoldercount();

                    int MessageCount = oClient.GetMailCount();
                    int TotalMessageCount = MessageCount - 1;
                    MailInfo[] infos = oClient.GetMailInfos();

                    if (MessageCount > 0)
                    {
                        MailInfo LastMailinfo = infos[TotalMessageCount];
                        Mail lastMessage = oClient.GetMail(LastMailinfo);
                        if (lastMessage != null)
                        {
                            var mailReceivedDate = Convert.ToDateTime(lastMessage.ReceivedDate);
                            System.TimeSpan diff = DateTime.Now.Subtract(mailReceivedDate);
                            if (diff.TotalMinutes > 60)
                            {
                                log.Info("Clearing Array List");
                                messageList.Clear();
                            }
                        }
                        for (int i = TotalMessageCount; i >= 0; i--)
                        {
                            EmailData objmaildata = new EmailData();
                            log.InfoFormat("MsgCount: {0}  ", i);
                            MailInfo info = infos[i];
                            Mail CurrentMessage = oClient.GetMail(info);
                            var mailReceivedDate = Convert.ToDateTime(CurrentMessage.ReceivedDate);
                            System.TimeSpan diff = DateTime.Now.Subtract(mailReceivedDate);
                            if (diff.TotalMinutes > 60)
                            {
                                log.Info("No Emails in last 60 min");
                                break;
                            }

                            string messageId = CurrentMessage.Headers.GetValueOfKey("Message-ID");
                            if (!messageList.Contains(messageId))
                            {
                                string a = CurrentMessage.Subject;
                                objmaildata.ClientNumber = "";
                                objmaildata.UniqueEmailID = messageId;


                                for (int j = 0; j < a.Length; j++)
                                {
                                    if (Char.IsDigit(a[j]))
                                        objmaildata.ClientNumber += a[j];
                                }

                                messageList.Add(messageId);

                                string fromEmailID = CurrentMessage.From.Address;
                                objmaildata.CreatedBy = fromEmailID;
                                objmaildata.EmailID = fromEmailID;
                                string fileDataHtml = CurrentMessage.HtmlBody;
                                fileDataHtml = Regex.Replace(fileDataHtml, "&nbsp;", String.Empty);
                                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                                doc.LoadHtml(fileDataHtml);

                                string str = fileDataHtml;
                                string clientmail = fromEmailID.Split('@')[0];
                                string filepath = mailbox + "/" + objmaildata.ClientNumber + "/";
                                bool exists = System.IO.Directory.Exists(@filepath);
                                if (!exists)
                                    System.IO.Directory.CreateDirectory(@filepath);
                                foreach (EAGetMail.Attachment attachment in CurrentMessage.Attachments)
                                {
                                    attachment.SaveAs(@filepath + attachment.Name, true);
                                    objmaildata.EmailAttachment = attachment.Name + ",";
                                }

                                objmaildata.CreatedDate = CurrentMessage.ReceivedDate;
                                objmaildata.IsMappedToTask = "N";
                                objmaildata.content = str;
                                objmaildata.Subject = lastMessage.Subject;

                                Inserttaskdata(objmaildata);
                                oClient.Move(LastMailinfo, destFolder);
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
        }


        public Imap4Folder getfoldercount()
        {
            Imap4Folder Folder = null;
            Imap4Folder[] folders = oClient.Imap4Folders;
            int count = folders.Length;

            for (int i = 0; i < count; i++)
            {
                Imap4Folder folder = folders[i];
                if (String.Compare("Archeive", folder.Name, true) == 0)
                {
                    //find "Deleted Items" folder
                    Folder = folder;
                    break;
                }
            }
            return Folder;
        }
        private void SendErrorEmail(string senderID)
        {
            try
            {
                //string adminEmail = ConfigurationManager.AppSettings["adminEmail"];
                //string errorMessage = ConfigurationManager.AppSettings["EmailMessage"];
                //var xDoc = new XmlDocument();
                //xDoc.LoadXml(GetOpportunityData(data));
                //string emailData = Beautify(xDoc);
                //MailMessage mail = new MailMessage();
                //SmtpClient SmtpServer = new SmtpClient(HostName);

                //mail.From = new MailAddress(strFromMailId);
                //mail.To.Add(senderID);
                //mail.To.Add(adminEmail);
                //mail.Subject = "Unable to create opportunity";
                //mail.Body = errorMessage + "\n" + "Data posted by user" + "\n" + emailData;
                //mail.IsBodyHtml = false;
                //SmtpServer.Port = 587;
                //SmtpServer.Credentials = new System.Net.NetworkCredential(strMailID, strPassword);
                //SmtpServer.EnableSsl = true;

                //SmtpServer.Send(mail);

            }
            catch (Exception ex)
            {
                log.ErrorFormat("Error occured SendErrorEmail : {0}", ex);
            }
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

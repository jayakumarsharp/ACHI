﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using log4net;
using CRUserManagement.Models;
using System.ComponentModel;
using System.Globalization;
using System.Text;
using CRUserManagement.CommonClass;
using MySql.Data.MySqlClient;
using System.Data;

public static class StaticClass
{

    public static string Adduser = "spsvn_Adduser";
    public static string updateuser = "spsvn_updateuser";
    public static string ChangePwd = "spsvn_ChangePwd";

    public static string DeleteUser = "spsvn_deleteuser";

    public static string GetAllFCCLocations = "SPSVN_GetAllFCCLocations";

    public static string GetUserProfile = "spsvn_GetAllusers";
    public static string GetMenuItems = "SPSVN_GetMenuItems";
    public static string GetRoles = "spsvn_GetAllRoles";
    public static string AddRightsForRoles = "SPSVN_RoleMenuMap";
    public static string Checkuserlogin = "spsvn_validateLogin";
    public static string GetExtensionwisecallReport = "SPSVN_ExtensionwiseCallDetail";

    public static string GetAllManagers = "spsvn_GetAllManagers";
    public static string GetAllTeams = "spsvn_GetAllTeams";
    public static string GetAllusersById = "spsvn_GetAllusersById";
    public static string GetManagerByEmpcode = "spsvn_GetManagerByEmpcode";
    public static string GetHodByEmpcode = "spsvn_GetHodByEmpcode";

    public static string updateManagerByEmpcode = "spsvn_ManagerHierachy";
    public static string updateHodByEmpcode = "spsvn_hodHierachy";
    public static string UpdatePwd = "spsvn_UpdatePwd";

}



public class DbOperations
{

    #region Private Variable Declaration
    private MySqlConnection connection;
    private string server;
    private string database;
    private string uid;
    private string password;


    private static readonly log4net.ILog log = LogManager.GetLogger(typeof(DbOperations));
    private string connString = string.Empty;


    private int commandTimeout = 0;
    #endregion

    #region Default Constructor

    public DbOperations()
    {
        try
        {
            connString = ConfigurationManager.ConnectionStrings["CRMConn"].ConnectionString.ToString();
            server = "localhost";
            database = "coba";
            uid = "root";
            password = "Servion@123";
            string connectionString;
            connectionString = "SERVER=" + server + ";" + "DATABASE=" + database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";

            connection = new MySqlConnection(connectionString);


        }
        catch (Exception ex)
        {
            log.ErrorFormat("Exception Occured :{0}", ex.ToString());
            log.ErrorFormat("Exception Trace Message :{0}", ex.StackTrace);
        }
    }

    #endregion


    #region Client
    public List<Client> GetClientData()
    {
        List<Client> lst = new List<Client>();

        string query = "SP_GetClients";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new Client
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   AmountAdvancedonFUD = Convert.ToString(row["AmountAdvancedonFUD"]),
                                   BCompanyName = Convert.ToString(row["BCompanyName"]),
                                   BKC1City = Convert.ToString(row["BKC1City"]),
                                   BKC1Country = Convert.ToString(row["BKC1Country"]),
                                   BKC1Email = Convert.ToString(row["BKC1Email"]),
                                   BKC1L1 = Convert.ToString(row["BKC1L1"]),
                                   BKC1L2 = Convert.ToString(row["BKC1L2"]),
                                   BKC1L3 = Convert.ToString(row["BKC1L3"]),
                                   BKC1PostCode = row["BKC1PostCode"].ToString(),
                                   BKC1State = row["BKC1State"].ToString(),
                                   BKC1TelNum = row["BKC1TelNum"].ToString(),
                                   BKC2City = row["BKC2City"].ToString(),
                                   BKC2Country = row["BKC2Country"].ToString(),
                                   BKC2Email = row["BKC2Email"].ToString(),
                                   BKC2L1 = row["BKC2L1"].ToString(),
                                   BKC2L2 = row["BKC2L2"].ToString(),
                                   BKC2L3 = row["BKC2L3"].ToString(),
                                   BKC2PostCode = row["BKC2PostCode"].ToString(),
                                   BKC2State = row["BKC2State"].ToString(),
                                   BKC2TelNum = row["BKC2TelNum"].ToString(),
                                   BKC3City = row["BKC3City"].ToString(),
                                   BKC3Country = row["BKC3Country"].ToString(),
                                   BKC3Email = row["BKC3Email"].ToString(),
                                   BKC3L1 = row["BKC3L1"].ToString(),
                                   BKC3L2 = row["BKC3L2"].ToString(),
                                   BKC3L3 = row["BKC3L3"].ToString(),
                                   BKC3PostCode = row["BKC3PostCode"].ToString(),
                                   BKC3State = row["BKC3State"].ToString(),
                                   BKC3TelNum = row["BKC3TelNum"].ToString(),
                                   BKC4City = row["BKC4City"].ToString(),
                                   BKC4Country = row["BKC4Country"].ToString(),
                                   BKC4Email = row["BKC4Email"].ToString(),
                                   BKC4L1 = row["BKC4L1"].ToString(),
                                   BKC4L2 = row["BKC4L2"].ToString(),
                                   BKC4L3 = row["BKC4L3"].ToString(),
                                   BKC4PostCode = row["BKC4PostCode"].ToString(),
                                   BKC4State = row["BKC4State"].ToString(),
                                   BKC4TelNum = row["BKC4TelNum"].ToString(),
                                   BKC5City = row["BKC5City"].ToString(),
                                   BKC5Country = row["BKC5Country"].ToString(),
                                   BKC5Email = row["BKC5Email"].ToString(),
                                   BKC5L1 = row["BKC5L1"].ToString(),
                                   BKC5L2 = row["BKC5L2"].ToString(),
                                   BKC5L3 = row["BKC5L3"].ToString(),
                                   BKC5PostCode = row["BKC5PostCode"].ToString(),
                                   BKC5State = row["BKC5State"].ToString(),
                                   BKC5TelNum = row["BKC5TelNum"].ToString(),
                                   BPriAddressCity = row["BPriAddressCity"].ToString(),
                                   BPriAddressCountry = row["BPriAddressCountry"].ToString(),
                                   BPriAddressEmail = row["BPriAddressEmail"].ToString(),
                                   BPriAddressL1 = row["BPriAddressL1"].ToString(),
                                   BPriAddressL2 = row["BPriAddressL2"].ToString(),
                                   BPriAddressL3 = row["BPriAddressL3"].ToString(),
                                   BPriAddressPostCode = row["BPriAddressPostCode"].ToString(),
                                   BPriAddressState = row["BPriAddressState"].ToString(),
                                   BPriAddressTelNum = row["BPriAddressTelNum"].ToString(),
                                   //BPrimaryAddress = row["BPrimaryAddress"].ToString(),
                                   //BRegAddress = row["BRegAddress"].ToString(),
                                   BRegAddressCity = row["BRegAddressCity"].ToString(),
                                   BRegAddressCountry = row["BRegAddressCountry"].ToString(),
                                   BRegAddressEmail = row["BRegAddressEmail"].ToString(),
                                   BRegAddressL1 = row["BRegAddressL1"].ToString(),
                                   BRegAddressL2 = row["BRegAddressL2"].ToString(),
                                   BRegAddressL3 = row["BRegAddressL3"].ToString(),
                                   BRegAddressPostCode = row["BRegAddressPostCode"].ToString(),
                                   BRegAddressState = row["BRegAddressState"].ToString(),
                                   BRegAddressTelNum = row["BRegAddressTelNum"].ToString(),
                                   ClientNumber = row["ClientNumber"].ToString(),
                                   FirstInterestPaymentDate = row["FirstInterestPaymentDate"].ToString(),
                                   FirstUtilisationDate = row["FirstUtilisationDate"].ToString(),
                                   InvDevLoan = row["InvDevLoan"].ToString(),
                                   IsActive = row["IsActive"].ToString(),
                                   IsSignOff = row["IsSignOff"].ToString(),
                                   LCompanyName = row["LCompanyName"].ToString(),
                                   LKC1City = row["LKC1City"].ToString(),
                                   LKC1Country = row["LKC1Country"].ToString(),
                                   LKC1Email = row["LKC1Email"].ToString(),
                                   LKC1L1 = row["LKC1L1"].ToString(),
                                   LKC1L2 = row["LKC1L2"].ToString(),
                                   LKC1L3 = row["LKC1L3"].ToString(),
                                   LKC1PostCode = row["LKC1PostCode"].ToString(),
                                   LKC1State = row["LKC1State"].ToString(),
                                   LKC1TelNum = row["LKC1TelNum"].ToString(),
                                   LKC2City = row["LKC2City"].ToString(),
                                   LKC2Country = row["LKC2Country"].ToString(),
                                   LKC2Email = row["LKC2Email"].ToString(),
                                   LKC2L1 = row["LKC2L1"].ToString(),
                                   LKC2L2 = row["LKC2L2"].ToString(),
                                   LKC2L3 = row["LKC2L3"].ToString(),
                                   LKC2PostCode = row["LKC2PostCode"].ToString(),
                                   LKC2State = row["LKC2State"].ToString(),
                                   LKC2TelNum = row["LKC2TelNum"].ToString(),
                                   LKC3City = row["LKC3City"].ToString(),
                                   LKC3Country = row["LKC3Country"].ToString(),
                                   LKC3Email = row["LKC3Email"].ToString(),
                                   LKC3L1 = row["LKC3L1"].ToString(),
                                   LKC3L2 = row["LKC3L2"].ToString(),
                                   LKC3L3 = row["LKC3L3"].ToString(),
                                   LKC3PostCode = row["LKC3PostCode"].ToString(),
                                   LKC3State = row["LKC3State"].ToString(),
                                   LKC3TelNum = row["LKC3TelNum"].ToString(),
                                   LKC4City = row["LKC4City"].ToString(),
                                   LKC4Country = row["LKC4Country"].ToString(),
                                   LKC4Email = row["LKC4Email"].ToString(),
                                   LKC4L1 = row["LKC4L1"].ToString(),
                                   LKC4L2 = row["LKC4L2"].ToString(),
                                   LKC4L3 = row["LKC4L3"].ToString(),
                                   LKC4PostCode = row["LKC4PostCode"].ToString(),
                                   LKC4State = row["LKC4State"].ToString(),
                                   LKC4TelNum = row["LKC4TelNum"].ToString(),
                                   LKC5City = row["LKC5City"].ToString(),
                                   LKC5Country = row["LKC5Country"].ToString(),
                                   LKC5Email = row["LKC5Email"].ToString(),
                                   LKC5L1 = row["LKC5L1"].ToString(),
                                   LKC5L2 = row["LKC5L2"].ToString(),
                                   LKC5L3 = row["LKC5L3"].ToString(),
                                   LKC5PostCode = row["LKC5PostCode"].ToString(),
                                   LKC5State = row["LKC5State"].ToString(),
                                   LKC5TelNum = row["LKC5TelNum"].ToString(),
                                   LoanDateAggrmnt = row["LoanDateAggrmnt"].ToString(),
                                   LPriAddressCity = row["LPriAddressCity"].ToString(),
                                   LPriAddressCountry = row["LPriAddressCountry"].ToString(),
                                   LPriAddressEmail = row["LPriAddressEmail"].ToString(),
                                   LPriAddressL1 = row["LPriAddressL1"].ToString(),
                                   LPriAddressL2 = row["LPriAddressL2"].ToString(),
                                   LPriAddressL3 = row["LPriAddressL3"].ToString(),
                                   LPriAddressPostCode = row["LPriAddressPostCode"].ToString(),
                                   LPriAddressState = row["LPriAddressState"].ToString(),
                                   LPriAddressTelNum = row["LPriAddressTelNum"].ToString(),
                                   //LPrimaryAddress = row["LPrimaryAddress"].ToString(),
                                   //LRegAddress = row["LRegAddress"].ToString(),
                                   LRegAddressCity = row["LRegAddressCity"].ToString(),
                                   LRegAddressCountry = row["LRegAddressCountry"].ToString(),
                                   LRegAddressEmail = row["LRegAddressEmail"].ToString(),
                                   LRegAddressL1 = row["LRegAddressL1"].ToString(),
                                   LRegAddressL2 = row["LRegAddressL2"].ToString(),
                                   LRegAddressL3 = row["LRegAddressL3"].ToString(),
                                   LRegAddressPostCode = row["LRegAddressPostCode"].ToString(),
                                   LRegAddressState = row["LRegAddressState"].ToString(),
                                   LRegAddressTelNum = row["LRegAddressTelNum"].ToString(),
                                   ObligorName = row["ObligorName"].ToString(),
                                   OriginalCommitmentAmount = row["OriginalCommitmentAmount"].ToString(),
                                   OriginalLender = row["OriginalLender"].ToString(),
                                   PaymentFrequency = row["PaymentFrequency"].ToString(),
                                   PropAddress1City = row["PropAddress1City"].ToString(),
                                   PropAddress1Country = row["PropAddress1Country"].ToString(),
                                   PropAddress1Email = row["PropAddress1Email"].ToString(),
                                   PropAddress1L1 = row["PropAddress1L1"].ToString(),
                                   PropAddress1L2 = row["PropAddress1L2"].ToString(),
                                   PropAddress1L3 = row["PropAddress1L3"].ToString(),
                                   PropAddress1PostCode = row["PropAddress1PostCode"].ToString(),
                                   PropAddress1State = row["PropAddress1State"].ToString(),
                                   PropAddress1TelNum = row["PropAddress1TelNum"].ToString(),
                                   PropAddress2City = row["PropAddress2City"].ToString(),
                                   PropAddress2Country = row["PropAddress2Country"].ToString(),
                                   PropAddress2Email = row["PropAddress2Email"].ToString(),
                                   PropAddress2L1 = row["PropAddress2L1"].ToString(),
                                   PropAddress2L2 = row["PropAddress2L2"].ToString(),
                                   PropAddress2L3 = row["PropAddress2L3"].ToString(),
                                   PropAddress2PostCode = row["PropAddress2PostCode"].ToString(),
                                   PropAddress2State = row["PropAddress2State"].ToString(),
                                   PropAddress2TelNum = row["PropAddress2TelNum"].ToString(),
                                   PropAddress3City = row["PropAddress3City"].ToString(),
                                   PropAddress3Country = row["PropAddress3Country"].ToString(),
                                   PropAddress3Email = row["PropAddress3Email"].ToString(),
                                   PropAddress3L1 = row["PropAddress3L1"].ToString(),
                                   PropAddress3L2 = row["PropAddress3L2"].ToString(),
                                   PropAddress3L3 = row["PropAddress3L3"].ToString(),
                                   PropAddress3PostCode = row["PropAddress3PostCode"].ToString(),
                                   PropAddress3State = row["PropAddress3State"].ToString(),
                                   PropAddress3TelNum = row["PropAddress3TelNum"].ToString(),
                                   PropAddress4City = row["PropAddress4City"].ToString(),
                                   PropAddress4Country = row["PropAddress4Country"].ToString(),
                                   PropAddress4Email = row["PropAddress4Email"].ToString(),
                                   PropAddress4L1 = row["PropAddress4L1"].ToString(),
                                   PropAddress4L2 = row["PropAddress4L2"].ToString(),
                                   PropAddress4L3 = row["PropAddress4L3"].ToString(),
                                   PropAddress4PostCode = row["PropAddress4PostCode"].ToString(),
                                   PropAddress4State = row["PropAddress4State"].ToString(),
                                   PropAddress4TelNum = row["PropAddress4TelNum"].ToString(),
                                   PropAddress5City = row["PropAddress5City"].ToString(),
                                   PropAddress5Country = row["PropAddress5Country"].ToString(),
                                   PropAddress5Email = row["PropAddress5Email"].ToString(),
                                   PropAddress5L1 = row["PropAddress5L1"].ToString(),
                                   PropAddress5L2 = row["PropAddress5L2"].ToString(),
                                   PropAddress5L3 = row["PropAddress5L3"].ToString(),
                                   PropAddress5PostCode = row["PropAddress5PostCode"].ToString(),
                                   PropAddress5State = row["PropAddress5State"].ToString(),
                                   PropAddress5TelNum = row["PropAddress5TelNum"].ToString(),
                                   ProposedDealCommencementDate = row["ProposedDealCommencementDate"].ToString(),
                                   SignoffBy = row["SignoffBy"].ToString(),
                                   SignOffDate = Convert.ToDateTime(row["SignOffDate"]),
                                   StrChartAttchd = row["StrChartAttchd"].ToString(),

                               }).ToList();

                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public List<Client> GetClientDatabyId(string clientNumber)
    {
        List<Client> lst = new List<Client>();

        string query = "SP_GetClientsById";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_ClientNumber", clientNumber));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new Client
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   AmountAdvancedonFUD = Convert.ToString(row["AmountAdvancedonFUD"]),
                                   BCompanyName = Convert.ToString(row["BCompanyName"]),
                                   BKC1City = Convert.ToString(row["BKC1City"]),
                                   BKC1Country = Convert.ToString(row["BKC1Country"]),
                                   BKC1Email = Convert.ToString(row["BKC1Email"]),
                                   BKC1L1 = Convert.ToString(row["BKC1L1"]),
                                   BKC1L2 = Convert.ToString(row["BKC1L2"]),
                                   BKC1L3 = Convert.ToString(row["BKC1L3"]),
                                   BKC1PostCode = row["BKC1PostCode"].ToString(),
                                   BKC1State = row["BKC1State"].ToString(),
                                   BKC1TelNum = row["BKC1TelNum"].ToString(),
                                   BKC2City = row["BKC2City"].ToString(),
                                   BKC2Country = row["BKC2Country"].ToString(),
                                   BKC2Email = row["BKC2Email"].ToString(),
                                   BKC2L1 = row["BKC2L1"].ToString(),
                                   BKC2L2 = row["BKC2L2"].ToString(),
                                   BKC2L3 = row["BKC2L3"].ToString(),
                                   BKC2PostCode = row["BKC2PostCode"].ToString(),
                                   BKC2State = row["BKC2State"].ToString(),
                                   BKC2TelNum = row["BKC2TelNum"].ToString(),
                                   BKC3City = row["BKC3City"].ToString(),
                                   BKC3Country = row["BKC3Country"].ToString(),
                                   BKC3Email = row["BKC3Email"].ToString(),
                                   BKC3L1 = row["BKC3L1"].ToString(),
                                   BKC3L2 = row["BKC3L2"].ToString(),
                                   BKC3L3 = row["BKC3L3"].ToString(),
                                   BKC3PostCode = row["BKC3PostCode"].ToString(),
                                   BKC3State = row["BKC3State"].ToString(),
                                   BKC3TelNum = row["BKC3TelNum"].ToString(),
                                   BKC4City = row["BKC4City"].ToString(),
                                   BKC4Country = row["BKC4Country"].ToString(),
                                   BKC4Email = row["BKC4Email"].ToString(),
                                   BKC4L1 = row["BKC4L1"].ToString(),
                                   BKC4L2 = row["BKC4L2"].ToString(),
                                   BKC4L3 = row["BKC4L3"].ToString(),
                                   BKC4PostCode = row["BKC4PostCode"].ToString(),
                                   BKC4State = row["BKC4State"].ToString(),
                                   BKC4TelNum = row["BKC4TelNum"].ToString(),
                                   BKC5City = row["BKC5City"].ToString(),
                                   BKC5Country = row["BKC5Country"].ToString(),
                                   BKC5Email = row["BKC5Email"].ToString(),
                                   BKC5L1 = row["BKC5L1"].ToString(),
                                   BKC5L2 = row["BKC5L2"].ToString(),
                                   BKC5L3 = row["BKC5L3"].ToString(),
                                   BKC5PostCode = row["BKC5PostCode"].ToString(),
                                   BKC5State = row["BKC5State"].ToString(),
                                   BKC5TelNum = row["BKC5TelNum"].ToString(),
                                   BPriAddressCity = row["BPriAddressCity"].ToString(),
                                   BPriAddressCountry = row["BPriAddressCountry"].ToString(),
                                   BPriAddressEmail = row["BPriAddressEmail"].ToString(),
                                   BPriAddressL1 = row["BPriAddressL1"].ToString(),
                                   BPriAddressL2 = row["BPriAddressL2"].ToString(),
                                   BPriAddressL3 = row["BPriAddressL3"].ToString(),
                                   BPriAddressPostCode = row["BPriAddressPostCode"].ToString(),
                                   BPriAddressState = row["BPriAddressState"].ToString(),
                                   BPriAddressTelNum = row["BPriAddressTelNum"].ToString(),
                                   //BPrimaryAddress = row["BPrimaryAddress"].ToString(),
                                   //BRegAddress = row["BRegAddress"].ToString(),
                                   BRegAddressCity = row["BRegAddressCity"].ToString(),
                                   BRegAddressCountry = row["BRegAddressCountry"].ToString(),
                                   BRegAddressEmail = row["BRegAddressEmail"].ToString(),
                                   BRegAddressL1 = row["BRegAddressL1"].ToString(),
                                   BRegAddressL2 = row["BRegAddressL2"].ToString(),
                                   BRegAddressL3 = row["BRegAddressL3"].ToString(),
                                   BRegAddressPostCode = row["BRegAddressPostCode"].ToString(),
                                   BRegAddressState = row["BRegAddressState"].ToString(),
                                   BRegAddressTelNum = row["BRegAddressTelNum"].ToString(),
                                   ClientNumber = row["ClientNumber"].ToString(),
                                   FirstInterestPaymentDate = row["FirstInterestPaymentDate"].ToString(),
                                   FirstUtilisationDate = row["FirstUtilisationDate"].ToString(),
                                   InvDevLoan = row["InvDevLoan"].ToString(),
                                   IsActive = row["IsActive"].ToString(),
                                   IsSignOff = row["IsSignOff"].ToString(),
                                   LCompanyName = row["LCompanyName"].ToString(),
                                   LKC1City = row["LKC1City"].ToString(),
                                   LKC1Country = row["LKC1Country"].ToString(),
                                   LKC1Email = row["LKC1Email"].ToString(),
                                   LKC1L1 = row["LKC1L1"].ToString(),
                                   LKC1L2 = row["LKC1L2"].ToString(),
                                   LKC1L3 = row["LKC1L3"].ToString(),
                                   LKC1PostCode = row["LKC1PostCode"].ToString(),
                                   LKC1State = row["LKC1State"].ToString(),
                                   LKC1TelNum = row["LKC1TelNum"].ToString(),
                                   LKC2City = row["LKC2City"].ToString(),
                                   LKC2Country = row["LKC2Country"].ToString(),
                                   LKC2Email = row["LKC2Email"].ToString(),
                                   LKC2L1 = row["LKC2L1"].ToString(),
                                   LKC2L2 = row["LKC2L2"].ToString(),
                                   LKC2L3 = row["LKC2L3"].ToString(),
                                   LKC2PostCode = row["LKC2PostCode"].ToString(),
                                   LKC2State = row["LKC2State"].ToString(),
                                   LKC2TelNum = row["LKC2TelNum"].ToString(),
                                   LKC3City = row["LKC3City"].ToString(),
                                   LKC3Country = row["LKC3Country"].ToString(),
                                   LKC3Email = row["LKC3Email"].ToString(),
                                   LKC3L1 = row["LKC3L1"].ToString(),
                                   LKC3L2 = row["LKC3L2"].ToString(),
                                   LKC3L3 = row["LKC3L3"].ToString(),
                                   LKC3PostCode = row["LKC3PostCode"].ToString(),
                                   LKC3State = row["LKC3State"].ToString(),
                                   LKC3TelNum = row["LKC3TelNum"].ToString(),
                                   LKC4City = row["LKC4City"].ToString(),
                                   LKC4Country = row["LKC4Country"].ToString(),
                                   LKC4Email = row["LKC4Email"].ToString(),
                                   LKC4L1 = row["LKC4L1"].ToString(),
                                   LKC4L2 = row["LKC4L2"].ToString(),
                                   LKC4L3 = row["LKC4L3"].ToString(),
                                   LKC4PostCode = row["LKC4PostCode"].ToString(),
                                   LKC4State = row["LKC4State"].ToString(),
                                   LKC4TelNum = row["LKC4TelNum"].ToString(),
                                   LKC5City = row["LKC5City"].ToString(),
                                   LKC5Country = row["LKC5Country"].ToString(),
                                   LKC5Email = row["LKC5Email"].ToString(),
                                   LKC5L1 = row["LKC5L1"].ToString(),
                                   LKC5L2 = row["LKC5L2"].ToString(),
                                   LKC5L3 = row["LKC5L3"].ToString(),
                                   LKC5PostCode = row["LKC5PostCode"].ToString(),
                                   LKC5State = row["LKC5State"].ToString(),
                                   LKC5TelNum = row["LKC5TelNum"].ToString(),
                                   LoanDateAggrmnt = row["LoanDateAggrmnt"].ToString(),
                                   LPriAddressCity = row["LPriAddressCity"].ToString(),
                                   LPriAddressCountry = row["LPriAddressCountry"].ToString(),
                                   LPriAddressEmail = row["LPriAddressEmail"].ToString(),
                                   LPriAddressL1 = row["LPriAddressL1"].ToString(),
                                   LPriAddressL2 = row["LPriAddressL2"].ToString(),
                                   LPriAddressL3 = row["LPriAddressL3"].ToString(),
                                   LPriAddressPostCode = row["LPriAddressPostCode"].ToString(),
                                   LPriAddressState = row["LPriAddressState"].ToString(),
                                   LPriAddressTelNum = row["LPriAddressTelNum"].ToString(),
                                   //LPrimaryAddress = row["LPrimaryAddress"].ToString(),
                                   //LRegAddress = row["LRegAddress"].ToString(),
                                   LRegAddressCity = row["LRegAddressCity"].ToString(),
                                   LRegAddressCountry = row["LRegAddressCountry"].ToString(),
                                   LRegAddressEmail = row["LRegAddressEmail"].ToString(),
                                   LRegAddressL1 = row["LRegAddressL1"].ToString(),
                                   LRegAddressL2 = row["LRegAddressL2"].ToString(),
                                   LRegAddressL3 = row["LRegAddressL3"].ToString(),
                                   LRegAddressPostCode = row["LRegAddressPostCode"].ToString(),
                                   LRegAddressState = row["LRegAddressState"].ToString(),
                                   LRegAddressTelNum = row["LRegAddressTelNum"].ToString(),
                                   ObligorName = row["ObligorName"].ToString(),
                                   OriginalCommitmentAmount = row["OriginalCommitmentAmount"].ToString(),
                                   OriginalLender = row["OriginalLender"].ToString(),
                                   PaymentFrequency = row["PaymentFrequency"].ToString(),
                                   PropAddress1City = row["PropAddress1City"].ToString(),
                                   PropAddress1Country = row["PropAddress1Country"].ToString(),
                                   PropAddress1Email = row["PropAddress1Email"].ToString(),
                                   PropAddress1L1 = row["PropAddress1L1"].ToString(),
                                   PropAddress1L2 = row["PropAddress1L2"].ToString(),
                                   PropAddress1L3 = row["PropAddress1L3"].ToString(),
                                   PropAddress1PostCode = row["PropAddress1PostCode"].ToString(),
                                   PropAddress1State = row["PropAddress1State"].ToString(),
                                   PropAddress1TelNum = row["PropAddress1TelNum"].ToString(),
                                   PropAddress2City = row["PropAddress2City"].ToString(),
                                   PropAddress2Country = row["PropAddress2Country"].ToString(),
                                   PropAddress2Email = row["PropAddress2Email"].ToString(),
                                   PropAddress2L1 = row["PropAddress2L1"].ToString(),
                                   PropAddress2L2 = row["PropAddress2L2"].ToString(),
                                   PropAddress2L3 = row["PropAddress2L3"].ToString(),
                                   PropAddress2PostCode = row["PropAddress2PostCode"].ToString(),
                                   PropAddress2State = row["PropAddress2State"].ToString(),
                                   PropAddress2TelNum = row["PropAddress2TelNum"].ToString(),
                                   PropAddress3City = row["PropAddress3City"].ToString(),
                                   PropAddress3Country = row["PropAddress3Country"].ToString(),
                                   PropAddress3Email = row["PropAddress3Email"].ToString(),
                                   PropAddress3L1 = row["PropAddress3L1"].ToString(),
                                   PropAddress3L2 = row["PropAddress3L2"].ToString(),
                                   PropAddress3L3 = row["PropAddress3L3"].ToString(),
                                   PropAddress3PostCode = row["PropAddress3PostCode"].ToString(),
                                   PropAddress3State = row["PropAddress3State"].ToString(),
                                   PropAddress3TelNum = row["PropAddress3TelNum"].ToString(),
                                   PropAddress4City = row["PropAddress4City"].ToString(),
                                   PropAddress4Country = row["PropAddress4Country"].ToString(),
                                   PropAddress4Email = row["PropAddress4Email"].ToString(),
                                   PropAddress4L1 = row["PropAddress4L1"].ToString(),
                                   PropAddress4L2 = row["PropAddress4L2"].ToString(),
                                   PropAddress4L3 = row["PropAddress4L3"].ToString(),
                                   PropAddress4PostCode = row["PropAddress4PostCode"].ToString(),
                                   PropAddress4State = row["PropAddress4State"].ToString(),
                                   PropAddress4TelNum = row["PropAddress4TelNum"].ToString(),
                                   PropAddress5City = row["PropAddress5City"].ToString(),
                                   PropAddress5Country = row["PropAddress5Country"].ToString(),
                                   PropAddress5Email = row["PropAddress5Email"].ToString(),
                                   PropAddress5L1 = row["PropAddress5L1"].ToString(),
                                   PropAddress5L2 = row["PropAddress5L2"].ToString(),
                                   PropAddress5L3 = row["PropAddress5L3"].ToString(),
                                   PropAddress5PostCode = row["PropAddress5PostCode"].ToString(),
                                   PropAddress5State = row["PropAddress5State"].ToString(),
                                   PropAddress5TelNum = row["PropAddress5TelNum"].ToString(),
                                   ProposedDealCommencementDate = row["ProposedDealCommencementDate"].ToString(),
                                   SignoffBy = row["SignoffBy"].ToString(),
                                   SignOffDate = Convert.ToDateTime(row["SignOffDate"]),
                                   StrChartAttchd = row["StrChartAttchd"].ToString(),

                               }).ToList();

                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }


    public void InsertClientdata(Client _clientInfo, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_Client", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_ClientNumber", _clientInfo.ClientNumber));
                cmd.Parameters.Add(new MySqlParameter("i_InvDevLoan", _clientInfo.InvDevLoan));
                cmd.Parameters.Add(new MySqlParameter("i_ObligorName", _clientInfo.ObligorName));
                cmd.Parameters.Add(new MySqlParameter("i_StrChartAttchd", _clientInfo.StrChartAttchd));
                cmd.Parameters.Add(new MySqlParameter("i_OriginalLender", _clientInfo.OriginalLender));
                cmd.Parameters.Add(new MySqlParameter("i_LCompanyName", _clientInfo.LCompanyName));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressL1", _clientInfo.LRegAddressL1));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressL2", _clientInfo.LRegAddressL2));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressL3", _clientInfo.LRegAddressL3));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressEmail", _clientInfo.LRegAddressEmail));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressTelNum", _clientInfo.LRegAddressTelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressCity", _clientInfo.LRegAddressCity));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressState", _clientInfo.LRegAddressState));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressCountry", _clientInfo.LRegAddressCountry));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressPostCode", _clientInfo.LRegAddressPostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressL1", _clientInfo.LPriAddressL1));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressL2", _clientInfo.LPriAddressL2));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressL3", _clientInfo.LPriAddressL3));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressEmail", _clientInfo.LPriAddressEmail));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressTelNum", _clientInfo.LPriAddressTelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressCity", _clientInfo.LPriAddressCity));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressState", _clientInfo.LPriAddressState));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressCountry", _clientInfo.LPriAddressCountry));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressPostCode", _clientInfo.LPriAddressPostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1L1", _clientInfo.LKC1L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1L2", _clientInfo.LKC1L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1L3", _clientInfo.LKC1L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1Email", _clientInfo.LKC1Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1TelNum", _clientInfo.LKC1TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1City", _clientInfo.LKC1City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1State", _clientInfo.LKC1State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1Country", _clientInfo.LKC1Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1PostCode", _clientInfo.LKC1PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2L1", _clientInfo.LKC2L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2L2", _clientInfo.LKC2L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2L3", _clientInfo.LKC2L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2Email", _clientInfo.LKC2Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2TelNum", _clientInfo.LKC2TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2City", _clientInfo.LKC2City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2State", _clientInfo.LKC2State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2Country", _clientInfo.LKC2Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2PostCode", _clientInfo.LKC2PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3L1", _clientInfo.LKC3L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3L2", _clientInfo.LKC3L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3L3", _clientInfo.LKC3L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3Email", _clientInfo.LKC3Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3TelNum", _clientInfo.LKC3TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3City", _clientInfo.LKC3City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3State", _clientInfo.LKC3State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3Country", _clientInfo.LKC3Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3PostCode", _clientInfo.LKC3PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4L1", _clientInfo.LKC4L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4L2", _clientInfo.LKC4L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4L3", _clientInfo.LKC4L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4Email", _clientInfo.LKC4Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4TelNum", _clientInfo.LKC4TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4City", _clientInfo.LKC4City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4State", _clientInfo.LKC4State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4Country", _clientInfo.LKC4Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4PostCode", _clientInfo.LKC4PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5L1", _clientInfo.LKC5L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5L2", _clientInfo.LKC5L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5L3", _clientInfo.LKC5L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5Email", _clientInfo.LKC5Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5TelNum", _clientInfo.LKC5TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5City", _clientInfo.LKC5City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5State", _clientInfo.LKC5State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5Country", _clientInfo.LKC5Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5PostCode", _clientInfo.LKC5PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BCompanyName", _clientInfo.BCompanyName));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressL1", _clientInfo.BRegAddressL1));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressL2", _clientInfo.BRegAddressL2));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressL3", _clientInfo.BRegAddressL3));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressEmail", _clientInfo.BRegAddressEmail));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressTelNum", _clientInfo.BRegAddressTelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressCity", _clientInfo.BRegAddressCity));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressState", _clientInfo.BRegAddressState));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressCountry", _clientInfo.BRegAddressCountry));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressPostCode", _clientInfo.BRegAddressPostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressL1", _clientInfo.BPriAddressL1));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressL2", _clientInfo.BPriAddressL2));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressL3", _clientInfo.BPriAddressL3));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressEmail", _clientInfo.BPriAddressEmail));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressTelNum", _clientInfo.BPriAddressTelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressCity", _clientInfo.BPriAddressCity));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressState", _clientInfo.BPriAddressState));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressCountry", _clientInfo.BPriAddressCountry));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressPostCode", _clientInfo.BPriAddressPostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1L1", _clientInfo.BKC1L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1L2", _clientInfo.BKC1L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1L3", _clientInfo.BKC1L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1Email", _clientInfo.BKC1Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1TelNum", _clientInfo.BKC1TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1City", _clientInfo.BKC1City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1State", _clientInfo.BKC1State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1Country", _clientInfo.BKC1Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1PostCode", _clientInfo.BKC1PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2L1", _clientInfo.BKC2L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2L2", _clientInfo.BKC2L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2L3", _clientInfo.BKC2L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2Email", _clientInfo.BKC2Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2TelNum", _clientInfo.BKC2TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2City", _clientInfo.BKC2City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2State", _clientInfo.BKC2State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2Country", _clientInfo.BKC2Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2PostCode", _clientInfo.BKC2PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3L1", _clientInfo.BKC3L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3L2", _clientInfo.BKC3L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3L3", _clientInfo.BKC3L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3Email", _clientInfo.BKC3Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3TelNum", _clientInfo.BKC3TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3City", _clientInfo.BKC3City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3State", _clientInfo.BKC3State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3PostCode", _clientInfo.BKC3PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3Country", _clientInfo.BKC3Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4L1", _clientInfo.BKC4L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4L2", _clientInfo.BKC4L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4L3", _clientInfo.BKC4L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4Email", _clientInfo.BKC4Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4TelNum", _clientInfo.BKC4TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4City", _clientInfo.BKC4City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4State", _clientInfo.BKC4State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4Country", _clientInfo.BKC4Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4PostCode", _clientInfo.BKC4PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5L1", _clientInfo.BKC5L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5L2", _clientInfo.BKC5L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5L3", _clientInfo.BKC5L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5Email", _clientInfo.BKC5Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5TelNum", _clientInfo.BKC5TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5City", _clientInfo.BKC5City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5State", _clientInfo.BKC5State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5Country", _clientInfo.BKC5Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5PostCode", _clientInfo.BKC5PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_ProposedDealCommencementDate", _clientInfo.ProposedDealCommencementDate));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1L1", _clientInfo.PropAddress1L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1L2", _clientInfo.PropAddress1L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1L3", _clientInfo.PropAddress1L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1Email", _clientInfo.PropAddress1Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1TelNum", _clientInfo.PropAddress1TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1City", _clientInfo.PropAddress1City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1State", _clientInfo.PropAddress1State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1Country", _clientInfo.PropAddress1Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1PostCode", _clientInfo.PropAddress1PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2L1", _clientInfo.PropAddress2L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2L2", _clientInfo.PropAddress2L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2L3", _clientInfo.PropAddress2L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2Email", _clientInfo.PropAddress2Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2TelNum", _clientInfo.PropAddress2TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2City", _clientInfo.PropAddress2City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2State", _clientInfo.PropAddress2State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2Country", _clientInfo.PropAddress2Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2PostCode", _clientInfo.PropAddress2PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3L1", _clientInfo.PropAddress3L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3L2", _clientInfo.PropAddress3L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3L3", _clientInfo.PropAddress3L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3Email", _clientInfo.PropAddress3Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3TelNum", _clientInfo.PropAddress3TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3City", _clientInfo.PropAddress3City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3State", _clientInfo.PropAddress3State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3Country", _clientInfo.PropAddress3Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3PostCode", _clientInfo.PropAddress3PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4L1", _clientInfo.PropAddress4L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4L2", _clientInfo.PropAddress4L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4L3", _clientInfo.PropAddress4L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4Email", _clientInfo.PropAddress4Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4TelNum", _clientInfo.PropAddress4TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4City", _clientInfo.PropAddress4City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4State", _clientInfo.PropAddress4State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4Country", _clientInfo.PropAddress4Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4PostCode", _clientInfo.PropAddress4PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5L1", _clientInfo.PropAddress5L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5L2", _clientInfo.PropAddress5L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5L3", _clientInfo.PropAddress5L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5Email", _clientInfo.PropAddress5Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5TelNum", _clientInfo.PropAddress5TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5City", _clientInfo.PropAddress5City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5State", _clientInfo.PropAddress5State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5Country", _clientInfo.PropAddress5Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5PostCode", _clientInfo.PropAddress5PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LoanDateAggrmnt", _clientInfo.LoanDateAggrmnt));
                cmd.Parameters.Add(new MySqlParameter("i_FirstUtilisationDate", _clientInfo.FirstUtilisationDate));
                cmd.Parameters.Add(new MySqlParameter("i_AmountAdvancedonFUD", _clientInfo.AmountAdvancedonFUD));
                cmd.Parameters.Add(new MySqlParameter("i_OriginalCommitmentAmount", _clientInfo.OriginalCommitmentAmount));
                cmd.Parameters.Add(new MySqlParameter("i_FirstInterestPaymentDate", _clientInfo.FirstInterestPaymentDate));
                cmd.Parameters.Add(new MySqlParameter("i_PaymentFrequency", _clientInfo.PaymentFrequency));
                cmd.Parameters.Add(new MySqlParameter("i_IsSignOff", _clientInfo.IsSignOff));
                cmd.Parameters.Add(new MySqlParameter("i_SignOffDate", _clientInfo.SignOffDate));
                cmd.Parameters.Add(new MySqlParameter("i_SignoffBy", _clientInfo.SignoffBy));
                cmd.Parameters.Add(new MySqlParameter("i_IsActive", _clientInfo.IsActive));

                if (this.OpenConnection() == true)
                {
                    //Execute command
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //close connection
            }
        }
        catch (MySqlException e)
        {
            errorcode = e.ErrorCode;
            errordesc = e.Message;
            this.CloseConnection();
            
        }
        catch (Exception e)
        {
            errorcode = -1;
            errordesc = e.Message;
            this.CloseConnection();
            
        }
    }

    public void Updateclientdata(Client _clientInfo, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_Client", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_ClientNumber", _clientInfo.ClientNumber));
                cmd.Parameters.Add(new MySqlParameter("i_InvDevLoan", _clientInfo.InvDevLoan));
                cmd.Parameters.Add(new MySqlParameter("i_ObligorName", _clientInfo.ObligorName));
                cmd.Parameters.Add(new MySqlParameter("i_StrChartAttchd", _clientInfo.StrChartAttchd));
                cmd.Parameters.Add(new MySqlParameter("i_OriginalLender", _clientInfo.OriginalLender));
                cmd.Parameters.Add(new MySqlParameter("i_LCompanyName", _clientInfo.LCompanyName));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressL1", _clientInfo.LRegAddressL1));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressL2", _clientInfo.LRegAddressL2));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressL3", _clientInfo.LRegAddressL3));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressEmail", _clientInfo.LRegAddressEmail));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressTelNum", _clientInfo.LRegAddressTelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressCity", _clientInfo.LRegAddressCity));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressState", _clientInfo.LRegAddressState));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressCountry", _clientInfo.LRegAddressCountry));
                cmd.Parameters.Add(new MySqlParameter("i_LRegAddressPostCode", _clientInfo.LRegAddressPostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressL1", _clientInfo.LPriAddressL1));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressL2", _clientInfo.LPriAddressL2));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressL3", _clientInfo.LPriAddressL3));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressEmail", _clientInfo.LPriAddressEmail));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressTelNum", _clientInfo.LPriAddressTelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressCity", _clientInfo.LPriAddressCity));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressState", _clientInfo.LPriAddressState));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressCountry", _clientInfo.LPriAddressCountry));
                cmd.Parameters.Add(new MySqlParameter("i_LPriAddressPostCode", _clientInfo.LPriAddressPostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1L1", _clientInfo.LKC1L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1L2", _clientInfo.LKC1L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1L3", _clientInfo.LKC1L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1Email", _clientInfo.LKC1Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1TelNum", _clientInfo.LKC1TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1City", _clientInfo.LKC1City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1State", _clientInfo.LKC1State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1Country", _clientInfo.LKC1Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC1PostCode", _clientInfo.LKC1PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2L1", _clientInfo.LKC2L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2L2", _clientInfo.LKC2L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2L3", _clientInfo.LKC2L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2Email", _clientInfo.LKC2Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2TelNum", _clientInfo.LKC2TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2City", _clientInfo.LKC2City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2State", _clientInfo.LKC2State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2Country", _clientInfo.LKC2Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC2PostCode", _clientInfo.LKC2PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3L1", _clientInfo.LKC3L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3L2", _clientInfo.LKC3L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3L3", _clientInfo.LKC3L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3Email", _clientInfo.LKC3Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3TelNum", _clientInfo.LKC3TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3City", _clientInfo.LKC3City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3State", _clientInfo.LKC3State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3Country", _clientInfo.LKC3Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC3PostCode", _clientInfo.LKC3PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4L1", _clientInfo.LKC4L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4L2", _clientInfo.LKC4L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4L3", _clientInfo.LKC4L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4Email", _clientInfo.LKC4Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4TelNum", _clientInfo.LKC4TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4City", _clientInfo.LKC4City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4State", _clientInfo.LKC4State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4Country", _clientInfo.LKC4Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC4PostCode", _clientInfo.LKC4PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5L1", _clientInfo.LKC5L1));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5L2", _clientInfo.LKC5L2));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5L3", _clientInfo.LKC5L3));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5Email", _clientInfo.LKC5Email));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5TelNum", _clientInfo.LKC5TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5City", _clientInfo.LKC5City));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5State", _clientInfo.LKC5State));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5Country", _clientInfo.LKC5Country));
                cmd.Parameters.Add(new MySqlParameter("i_LKC5PostCode", _clientInfo.LKC5PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BCompanyName", _clientInfo.BCompanyName));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressL1", _clientInfo.BRegAddressL1));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressL2", _clientInfo.BRegAddressL2));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressL3", _clientInfo.BRegAddressL3));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressEmail", _clientInfo.BRegAddressEmail));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressTelNum", _clientInfo.BRegAddressTelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressCity", _clientInfo.BRegAddressCity));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressState", _clientInfo.BRegAddressState));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressCountry", _clientInfo.BRegAddressCountry));
                cmd.Parameters.Add(new MySqlParameter("i_BRegAddressPostCode", _clientInfo.BRegAddressPostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressL1", _clientInfo.BPriAddressL1));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressL2", _clientInfo.BPriAddressL2));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressL3", _clientInfo.BPriAddressL3));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressEmail", _clientInfo.BPriAddressEmail));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressTelNum", _clientInfo.BPriAddressTelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressCity", _clientInfo.BPriAddressCity));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressState", _clientInfo.BPriAddressState));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressCountry", _clientInfo.BPriAddressCountry));
                cmd.Parameters.Add(new MySqlParameter("i_BPriAddressPostCode", _clientInfo.BPriAddressPostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1L1", _clientInfo.BKC1L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1L2", _clientInfo.BKC1L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1L3", _clientInfo.BKC1L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1Email", _clientInfo.BKC1Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1TelNum", _clientInfo.BKC1TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1City", _clientInfo.BKC1City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1State", _clientInfo.BKC1State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1Country", _clientInfo.BKC1Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC1PostCode", _clientInfo.BKC1PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2L1", _clientInfo.BKC2L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2L2", _clientInfo.BKC2L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2L3", _clientInfo.BKC2L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2Email", _clientInfo.BKC2Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2TelNum", _clientInfo.BKC2TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2City", _clientInfo.BKC2City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2State", _clientInfo.BKC2State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2Country", _clientInfo.BKC2Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC2PostCode", _clientInfo.BKC2PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3L1", _clientInfo.BKC3L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3L2", _clientInfo.BKC3L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3L3", _clientInfo.BKC3L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3Email", _clientInfo.BKC3Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3TelNum", _clientInfo.BKC3TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3City", _clientInfo.BKC3City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3State", _clientInfo.BKC3State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3PostCode", _clientInfo.BKC3PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC3Country", _clientInfo.BKC3Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4L1", _clientInfo.BKC4L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4L2", _clientInfo.BKC4L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4L3", _clientInfo.BKC4L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4Email", _clientInfo.BKC4Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4TelNum", _clientInfo.BKC4TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4City", _clientInfo.BKC4City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4State", _clientInfo.BKC4State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4Country", _clientInfo.BKC4Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC4PostCode", _clientInfo.BKC4PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5L1", _clientInfo.BKC5L1));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5L2", _clientInfo.BKC5L2));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5L3", _clientInfo.BKC5L3));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5Email", _clientInfo.BKC5Email));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5TelNum", _clientInfo.BKC5TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5City", _clientInfo.BKC5City));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5State", _clientInfo.BKC5State));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5Country", _clientInfo.BKC5Country));
                cmd.Parameters.Add(new MySqlParameter("i_BKC5PostCode", _clientInfo.BKC5PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_ProposedDealCommencementDate", _clientInfo.ProposedDealCommencementDate));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1L1", _clientInfo.PropAddress1L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1L2", _clientInfo.PropAddress1L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1L3", _clientInfo.PropAddress1L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1Email", _clientInfo.PropAddress1Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1TelNum", _clientInfo.PropAddress1TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1City", _clientInfo.PropAddress1City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1State", _clientInfo.PropAddress1State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1Country", _clientInfo.PropAddress1Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress1PostCode", _clientInfo.PropAddress1PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2L1", _clientInfo.PropAddress2L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2L2", _clientInfo.PropAddress2L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2L3", _clientInfo.PropAddress2L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2Email", _clientInfo.PropAddress2Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2TelNum", _clientInfo.PropAddress2TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2City", _clientInfo.PropAddress2City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2State", _clientInfo.PropAddress2State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2Country", _clientInfo.PropAddress2Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress2PostCode", _clientInfo.PropAddress2PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3L1", _clientInfo.PropAddress3L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3L2", _clientInfo.PropAddress3L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3L3", _clientInfo.PropAddress3L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3Email", _clientInfo.PropAddress3Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3TelNum", _clientInfo.PropAddress3TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3City", _clientInfo.PropAddress3City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3State", _clientInfo.PropAddress3State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3Country", _clientInfo.PropAddress3Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress3PostCode", _clientInfo.PropAddress3PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4L1", _clientInfo.PropAddress4L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4L2", _clientInfo.PropAddress4L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4L3", _clientInfo.PropAddress4L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4Email", _clientInfo.PropAddress4Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4TelNum", _clientInfo.PropAddress4TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4City", _clientInfo.PropAddress4City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4State", _clientInfo.PropAddress4State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4Country", _clientInfo.PropAddress4Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress4PostCode", _clientInfo.PropAddress4PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5L1", _clientInfo.PropAddress5L1));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5L2", _clientInfo.PropAddress5L2));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5L3", _clientInfo.PropAddress5L3));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5Email", _clientInfo.PropAddress5Email));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5TelNum", _clientInfo.PropAddress5TelNum));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5City", _clientInfo.PropAddress5City));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5State", _clientInfo.PropAddress5State));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5Country", _clientInfo.PropAddress5Country));
                cmd.Parameters.Add(new MySqlParameter("i_PropAddress5PostCode", _clientInfo.PropAddress5PostCode));
                cmd.Parameters.Add(new MySqlParameter("i_LoanDateAggrmnt", _clientInfo.LoanDateAggrmnt));
                cmd.Parameters.Add(new MySqlParameter("i_FirstUtilisationDate", _clientInfo.FirstUtilisationDate));
                cmd.Parameters.Add(new MySqlParameter("i_AmountAdvancedonFUD", _clientInfo.AmountAdvancedonFUD));
                cmd.Parameters.Add(new MySqlParameter("i_OriginalCommitmentAmount", _clientInfo.OriginalCommitmentAmount));
                cmd.Parameters.Add(new MySqlParameter("i_FirstInterestPaymentDate", _clientInfo.FirstInterestPaymentDate));
                cmd.Parameters.Add(new MySqlParameter("i_PaymentFrequency", _clientInfo.PaymentFrequency));
                cmd.Parameters.Add(new MySqlParameter("i_IsSignOff", _clientInfo.IsSignOff));
                cmd.Parameters.Add(new MySqlParameter("i_SignOffDate", _clientInfo.SignOffDate));
                cmd.Parameters.Add(new MySqlParameter("i_SignoffBy", _clientInfo.SignoffBy));
                cmd.Parameters.Add(new MySqlParameter("i_IsActive", _clientInfo.IsActive));

                if (this.OpenConnection() == true)
                {
                    //Execute command
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //close connection
            }
        }
        catch (MySqlException e)
        {
            errorcode = e.ErrorCode;
            errordesc = e.Message;
            this.CloseConnection();
            
        }
        catch (Exception e)
        {
            errorcode = -1;
            errordesc = e.Message;
            this.CloseConnection();
            
        }
    }


    #endregion Client

    #region Task

    public List<Tasks> GetTaskData()
    {
        List<Tasks> lst = new List<Tasks>();

        string query = "Get_Tasks";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new Tasks
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   Name = Convert.ToString(row["Name"]),
                                   Description = row["Description"].ToString(),
                                   IsSignOff = row["IsSignOff"].ToString(),
                                   SignoffBy = row["SignoffBy"].ToString(),
                                   SignOffDate = Convert.ToString(row["SignOffDate"]),
                                   IsActive = Convert.ToString(row["IsActive"])

                               }).ToList();
                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public List<Tasks> GetTaskDatabyId(int taskid)
    {
        List<Tasks> lst = new List<Tasks>();

        string query = "Get_TasksById";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("TaskId", taskid));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new Tasks
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   Name = Convert.ToString(row["Name"]),
                                   Description = row["Description"].ToString(),
                                   IsSignOff = row["IsSignOff"].ToString(),
                                   SignoffBy = row["SignoffBy"].ToString(),
                                   SignOffDate = Convert.ToString(row["SignOffDate"]),
                                   IsActive = Convert.ToString(row["IsActive"])

                               }).ToList();

                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public void Inserttaskdata(Tasks _taskInfo, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_task", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new MySqlParameter("i_Name", _taskInfo.Name));
                cmd.Parameters.Add(new MySqlParameter("i_Description", _taskInfo.Description));
                cmd.Parameters.Add(new MySqlParameter("i_IsSignOff", _taskInfo.IsSignOff));
                //cmd.Parameters.Add(new MySqlParameter("i_SignOffDate", _taskInfo.SignOffDate));
                cmd.Parameters.Add(new MySqlParameter("i_SignoffBy", _taskInfo.SignoffBy));
                cmd.Parameters.Add(new MySqlParameter("i_IsActive", _taskInfo.IsActive));
                if (this.OpenConnection() == true)
                {
                    //Execute command
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //close connection
            }
        }
        catch (MySqlException e)
        {
            errorcode = e.ErrorCode;
            errordesc = e.Message;
            this.CloseConnection();
            
        }
        catch (Exception e)
        {
            errorcode = -1;
            errordesc = e.Message;
            this.CloseConnection();
            
        }
    }

    public void Updatetaskdata(Tasks _taskInfo, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_update_task", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", _taskInfo.Id));
                cmd.Parameters.Add(new MySqlParameter("i_Name", _taskInfo.Name));
                cmd.Parameters.Add(new MySqlParameter("i_Description", _taskInfo.Description));
                cmd.Parameters.Add(new MySqlParameter("i_IsSignOff", _taskInfo.IsSignOff));
                //cmd.Parameters.Add(new MySqlParameter("i_SignOffDate", _taskInfo.SignOffDate));
                cmd.Parameters.Add(new MySqlParameter("i_SignoffBy", _taskInfo.SignoffBy));
                cmd.Parameters.Add(new MySqlParameter("i_IsActive", _taskInfo.IsActive));
                if (this.OpenConnection() == true)
                {
                    //Execute command
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //close connection
            }
        }
        catch (MySqlException e)
        {
            errorcode = e.ErrorCode;
            errordesc = e.Message;
            this.CloseConnection();

        }
        catch (Exception e)
        {
            errorcode = -1;
            errordesc = e.Message;
            this.CloseConnection();

        }
    }

    #endregion Task

    #region OnboardingTask

    public List<OnboardingTasks> GetOnboardingTaskData()
    {
        List<OnboardingTasks> lst = new List<OnboardingTasks>();

        string query = "SP_GetOnboardingTask";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new OnboardingTasks
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   TaskName = Convert.ToString(row["Name"]),
                                   ClientNumber = Convert.ToString(row["ClientNumber"]),
                                   CreatedBy = row["CreatedBy"].ToString(),
                                   CreatedDate = row["CreatedDate"].ToString(),
                                   EmailAttachment = row["EmailAttachment"].ToString(),
                                   EmailContent = Convert.ToString(row["EmailContent"]),
                                   EmailId = Convert.ToString(row["EmailId"]),
                                   EmailSubject = Convert.ToString(row["EmailSubject"]),
                                   IsMappedToTask = Convert.ToString(row["IsMappedToTask"]),
                                   IsProcessed = Convert.ToString(row["IsProcessed"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   TaskAssignedBy = Convert.ToString(row["TaskAssignedBy"]),
                                   TaskAssignedDate = Convert.ToString(row["TaskAssignedDate"]),
                                   TaskAttachement = Convert.ToString(row["TaskAttachement"]),
                                   TaskComments = Convert.ToString(row["TaskComments"]),
                                   TaskId = Convert.ToString(row["TaskId"]),
                                   UniqueEmailId = Convert.ToString(row["UniqueEmailId"]),
                                   IsActive = Convert.ToString(row["IsActive"])

                               }).ToList();
                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public List<OnboardingTasks> GetOnboardingTaskDatabyId(int taskid)
    {
        List<OnboardingTasks> lst = new List<OnboardingTasks>();

        string query = "SP_GetOnboardingTaskbyId";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", taskid));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new OnboardingTasks
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   ClientNumber = Convert.ToString(row["ClientNumber"]),
                                   CreatedBy = row["CreatedBy"].ToString(),
                                   CreatedDate = row["CreatedDate"].ToString(),
                                   EmailAttachment = row["EmailAttachment"].ToString(),
                                   EmailContent = Convert.ToString(row["EmailContent"]),
                                   EmailId = Convert.ToString(row["EmailId"]),
                                   EmailSubject = Convert.ToString(row["EmailSubject"]),
                                   IsMappedToTask = Convert.ToString(row["IsMappedToTask"]),
                                   IsProcessed = Convert.ToString(row["IsProcessed"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   TaskAssignedBy = Convert.ToString(row["TaskAssignedBy"]),
                                   TaskAssignedDate = Convert.ToString(row["TaskAssignedDate"]),
                                   TaskAttachement = Convert.ToString(row["TaskAttachement"]),
                                   TaskComments = Convert.ToString(row["TaskComments"]),
                                   TaskId = Convert.ToString(row["TaskId"]),
                                   UniqueEmailId = Convert.ToString(row["UniqueEmailId"]),
                                   IsActive = Convert.ToString(row["IsActive"]),
                                   TaskName = Convert.ToString(row["Name"])
                               }).ToList();

                    }
                }
                //Execute command
            //    cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    

    public void UpdateOnboardingTaskdata(string Id,string emailattachment,string comments, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("SP_update_onboardingTask", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new MySqlParameter("i_id", Id));
                cmd.Parameters.Add(new MySqlParameter("i_TaskAttachment", emailattachment));
                cmd.Parameters.Add(new MySqlParameter("i_comments", comments));
                
                if (this.OpenConnection() == true)
                {
                    //Execute command
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //close connection
            }
        }
        catch (MySqlException e)
        {
            errorcode = e.ErrorCode;
            errordesc = e.Message;
            this.CloseConnection();

        }
        catch (Exception e)
        {
            errorcode = -1;
            errordesc = e.Message;
            this.CloseConnection();

        }
    }

    #endregion OnboardingTask

    #region Email

    public List<Emails> GetEmailData()
    {
        List<Emails> lst = new List<Emails>();

        string query = "SP_GetEmail";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new Emails
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   ClientNumber = Convert.ToString(row["ClientNumber"]),
                                   CreatedBy = row["CreatedBy"].ToString(),
                                   CreatedDate = row["CreatedDate"].ToString(),
                                   EmailAttachment = row["EmailAttachment"].ToString(),
                                   EmailContent = Convert.ToString(row["EmailContent"]),
                                   EmailId = Convert.ToString(row["EmailId"]),
                                   EmailSubject = Convert.ToString(row["EmailSubject"]),
                                   IsMappedToTask = Convert.ToString(row["IsMappedToTask"]),
                                   IsProcessed = Convert.ToString(row["IsProcessed"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   TaskAssignedBy = Convert.ToString(row["TaskAssignedBy"]),
                                   TaskAssignedDate = Convert.ToString(row["TaskAssignedDate"]),
                                   TaskAttachement = Convert.ToString(row["TaskAttachement"]),
                                   TaskComments = Convert.ToString(row["TaskComments"]),
                                   TaskId = Convert.ToString(row["TaskId"]),
                                   UniqueEmailId = Convert.ToString(row["UniqueEmailId"]),
                                   IsActive = Convert.ToString(row["IsActive"])

                               }).ToList();
                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public List<Emails> GetEmailDatabyId(int taskid)
    {
        List<Emails> lst = new List<Emails>();

        string query = "SP_GetEmailbyId";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", taskid));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new Emails
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   ClientNumber = Convert.ToString(row["ClientNumber"]),
                                   CreatedBy = row["CreatedBy"].ToString(),
                                   CreatedDate = row["CreatedDate"].ToString(),
                                   EmailAttachment = row["EmailAttachment"].ToString(),
                                   EmailContent = Convert.ToString(row["EmailContent"]),
                                   EmailId = Convert.ToString(row["EmailId"]),
                                   EmailSubject = Convert.ToString(row["EmailSubject"]),
                                   IsMappedToTask = Convert.ToString(row["IsMappedToTask"]),
                                   IsProcessed = Convert.ToString(row["IsProcessed"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   TaskAssignedBy = Convert.ToString(row["TaskAssignedBy"]),
                                   TaskAssignedDate = Convert.ToString(row["TaskAssignedDate"]),
                                   TaskAttachement = Convert.ToString(row["TaskAttachement"]),
                                   TaskComments = Convert.ToString(row["TaskComments"]),
                                   TaskId = Convert.ToString(row["TaskId"]),
                                   UniqueEmailId = Convert.ToString(row["UniqueEmailId"]),
                                   IsActive = Convert.ToString(row["IsActive"])

                               }).ToList();

                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public void UpdateEmaildata()
    {

    }

    #endregion Email

    #region MapTask

    public List<MapTasks> GetMapTaskData()
    {
        List<MapTasks> lst = new List<MapTasks>();

        string query = "SP_GetMapTask";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new MapTasks
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   TaskName = Convert.ToString(row["Name"]),
                                   ClientNumber = Convert.ToString(row["ClientNumber"]),
                                   CreatedBy = row["CreatedBy"].ToString(),
                                   CreatedDate = row["CreatedDate"].ToString(),
                                   EmailAttachment = row["EmailAttachment"].ToString(),
                                   EmailContent = Convert.ToString(row["EmailContent"]),
                                   EmailId = Convert.ToString(row["EmailId"]),
                                   EmailSubject = Convert.ToString(row["EmailSubject"]),
                                   IsMappedToTask = Convert.ToString(row["IsMappedToTask"]),
                                   IsProcessed = Convert.ToString(row["IsProcessed"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   TaskAssignedBy = Convert.ToString(row["TaskAssignedBy"]),
                                   TaskAssignedDate = Convert.ToString(row["TaskAssignedDate"]),
                                   TaskAttachement = Convert.ToString(row["TaskAttachement"]),
                                   TaskComments = Convert.ToString(row["TaskComments"]),
                                   TaskId = Convert.ToString(row["TaskId"]),
                                   UniqueEmailId = Convert.ToString(row["UniqueEmailId"]),
                                   IsActive = Convert.ToString(row["IsActive"])

                               }).ToList();
                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }



    public List<MapTasks> Get_Mapped_Mail_Task(string type)
    {
        List<MapTasks> lst = new List<MapTasks>();

        string query = "Get_Mapped_Mail_Task";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_tasktype", type));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new MapTasks
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   ClientNumber = Convert.ToString(row["ClientNumber"]),
                                   TaskName = Convert.ToString(row["Name"]),
                                   CreatedBy = row["CreatedBy"].ToString(),
                                   CreatedDate = row["CreatedDate"].ToString(),
                                   EmailAttachment = row["EmailAttachment"].ToString(),
                                   EmailContent = Convert.ToString(row["EmailContent"]),
                                   EmailId = Convert.ToString(row["EmailId"]),
                                   EmailSubject = Convert.ToString(row["EmailSubject"]),
                                   IsMappedToTask = Convert.ToString(row["IsMappedToTask"]),
                                   IsProcessed = Convert.ToString(row["IsProcessed"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   TaskAssignedBy = Convert.ToString(row["TaskAssignedBy"]),
                                   TaskAssignedDate = Convert.ToString(row["TaskAssignedDate"]),
                                   TaskAttachement = Convert.ToString(row["TaskAttachement"]),
                                   TaskComments = Convert.ToString(row["TaskComments"]),
                                   TaskId = Convert.ToString(row["TaskId"]),
                                   UniqueEmailId = Convert.ToString(row["UniqueEmailId"]),
                                   IsActive = Convert.ToString(row["IsActive"])

                               }).ToList();

                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public List<MapTasks> GetMapTaskDatabyId(int taskid)
    {
        List<MapTasks> lst = new List<MapTasks>();

        string query = "SP_GetMapTaskbyId";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", taskid));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new MapTasks
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   ClientNumber = Convert.ToString(row["ClientNumber"]),
                                   TaskName = Convert.ToString(row["Name"]),
                                   CreatedBy = row["CreatedBy"].ToString(),
                                   CreatedDate = row["CreatedDate"].ToString(),
                                   EmailAttachment = row["EmailAttachment"].ToString(),
                                   EmailContent = Convert.ToString(row["EmailContent"]),
                                   EmailId = Convert.ToString(row["EmailId"]),
                                   EmailSubject = Convert.ToString(row["EmailSubject"]),
                                   IsMappedToTask = Convert.ToString(row["IsMappedToTask"]),
                                   IsProcessed = Convert.ToString(row["IsProcessed"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   TaskAssignedBy = Convert.ToString(row["TaskAssignedBy"]),
                                   TaskAssignedDate = Convert.ToString(row["TaskAssignedDate"]),
                                   TaskAttachement = Convert.ToString(row["TaskAttachement"]),
                                   TaskComments = Convert.ToString(row["TaskComments"]),
                                   TaskId = Convert.ToString(row["TaskId"]),
                                   UniqueEmailId = Convert.ToString(row["UniqueEmailId"]),
                                   IsActive = Convert.ToString(row["IsActive"])

                               }).ToList();

                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public void UpdateMapTaskdata(MapTasks objMaptask, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";

            using (MySqlCommand cmd = new MySqlCommand("sp_update_map_task", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new MySqlParameter("i_Id", objMaptask.Id));
                cmd.Parameters.Add(new MySqlParameter("i_TaskId", objMaptask.TaskId));
                cmd.Parameters.Add(new MySqlParameter("i_IsMappedToTask", objMaptask.IsMappedToTask));
                if (this.OpenConnection() == true)
                {
                    //Execute command
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //close connection
            }
        }
        catch (MySqlException e)
        {
            errorcode = e.ErrorCode;
            errordesc = e.Message;
            this.CloseConnection();
            
        }
        catch (Exception e)
        {
            errorcode = -1;
            errordesc = e.Message;
            this.CloseConnection();
            
        }
    }

    #endregion MapTask

    public void AddRightsForRoles(string roleName, string menuRights, out int errorCode, out string errorDesc)
    {

        errorDesc = "";
        errorCode = 0;
        string query = "INSERT INTO tableinfo (name, age) VALUES('John Smith', '33')";

        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            MySqlCommand cmd = new MySqlCommand(query, connection);

            //Execute command
            cmd.ExecuteNonQuery();

            //close connection
            this.CloseConnection();
        }
    }

    //public string GetRightsForRole(string roleName, out int errorCode, out string errorDesc, out int executeStatus)
    //{
    //    object[] outParamList = new object[0];
    //    List<SqlParameter> paramList = new List<SqlParameter>();
    //    paramList.Add(_sqlDb.CreateParameter("@i_RoleName", SqlDbType.VarChar, 50, ParameterDirection.Input, roleName));
    //    paramList.Add(_sqlDb.CreateParameter("@o_ErrorCode", SqlDbType.Int, ParameterDirection.Output));
    //    paramList.Add(_sqlDb.CreateParameter("@o_ErrorDescription", SqlDbType.VarChar, 200, ParameterDirection.Output));
    //    paramList.Add(_sqlDb.CreateParameter("@o_MenusList", SqlDbType.VarChar, 200, ParameterDirection.Output));
    //    executeStatus = _sqlDb.ExecuteNonQuery(StaticClass.GetRightsForRole, CommandType.StoredProcedure, paramList, out outParamList);
    //    errorCode = Convert.ToInt32(Convert.ToString(outParamList[0]));
    //    errorDesc = Convert.ToString(outParamList[1]);
    //    string menuRights = Convert.ToString(outParamList[2]);
    //    return menuRights;
    //}

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

    //Close connection
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



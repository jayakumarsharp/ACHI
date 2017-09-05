using System;
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
            database = "achi";
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

    #region Strategy

    public void InsertStrategyApprover(List<StrategyApprover> lst, string RefNumber, string version, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_strategy_Approval", connection))
            {
                foreach (StrategyApprover s in lst)
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new MySqlParameter("i_RefNumber", RefNumber));
                    cmd.Parameters.Add(new MySqlParameter("i_Version", version));
                    cmd.Parameters.Add(new MySqlParameter("i_Approver", s.Approver));

                    if (this.OpenConnection() == true)
                    {
                        //Execute command
                        cmd.ExecuteNonQuery();
                        this.CloseConnection();
                    }

                }
                //StringBuilder sCommand = new StringBuilder("INSERT INTO tbl_StrategyApproval (RefNumber, Version,Approver) VALUES ");
                //List<string> Rows = new List<string>();
                //for (int i = 0; i < lst.Count; i++)
                //{
                //    Rows.Add(string.Format("('{0}','{1}','{2}')", MySqlHelper.EscapeString(RefNumber), MySqlHelper.EscapeString("1"), MySqlHelper.EscapeString(lst[i].Approver)));
                //}
                //sCommand.Append(string.Join(",", Rows));
                //sCommand.Append(";");
                //connection.Open();

                //using (MySqlCommand myCmd = new MySqlCommand(sCommand.ToString(), connection))
                //{
                //    myCmd.CommandType = CommandType.Text;
                //    myCmd.ExecuteNonQuery();
                //    this.CloseConnection();
                //}
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

    public void DeleteStrategyApprover(List<StrategyApprover> lst, string RefNumber, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_delete_strategy_Approval", connection))
            {
                foreach (StrategyApprover s in lst)
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new MySqlParameter("i_RefNumber", s.RefNumber));
                    cmd.Parameters.Add(new MySqlParameter("i_Version", s.Version));
                    cmd.Parameters.Add(new MySqlParameter("i_Approver", s.Approver));

                    if (this.OpenConnection() == true)
                    {
                        //Execute command
                        cmd.ExecuteNonQuery();
                        this.CloseConnection();
                    }

                }
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


    public void UpdateStrategyApprover(StrategyApprover s, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("Sp_update_strategy_approval", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", s.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Version", s.Version));
                cmd.Parameters.Add(new MySqlParameter("i_Approver", s.Approver));
                cmd.Parameters.Add(new MySqlParameter("i_Comments", s.Comments));
                cmd.Parameters.Add(new MySqlParameter("i_Status", s.Status));
                //cmd.Parameters.Add(new MySqlParameter("i_Approver", s.ApprovedDate));
                if (this.OpenConnection() == true)
                {
                    //Execute command
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }

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

    public int GetStrategyLatestVersionIDbyId(string RefNumber)
    {
        int Version = 0;
        string query = "Get_StrategyLatestversionById";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", RefNumber));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        Version = Convert.ToInt32(dt.Rows[0]["Version"]);
                    }
                }
                //Execute command
                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return Version;

    }

    public List<StrategyApprover> Get_StrategyApprovalByuser(string userid)
    {
        List<StrategyApprover> lst = new List<StrategyApprover>();

        string query = "Get_StrategyApprovalByUser";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_user", userid));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new StrategyApprover
                               {
                                   Approver = Convert.ToString(row["Approver"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Version = Convert.ToString(row["Version"]),
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

    public List<StrategyApprover> Get_StrategyApprovalById(string StrategyNumber, string Version)
    {
        List<StrategyApprover> lst = new List<StrategyApprover>();

        string query = "Get_StrategyApprovalById";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", StrategyNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Version", Version));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new StrategyApprover
                               {
                                   Approver = Convert.ToString(row["Approver"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Version = Convert.ToString(row["Version"]),
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

    public List<Strategy> GetStrategyData()
    {
        List<Strategy> lst = new List<Strategy>();

        string query = "SP_GetStrategy";
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

                               select new Strategy
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   AdditionalParam1 = Convert.ToString(row["AdditionalParam1"]),
                                   AdditionalParam10 = Convert.ToString(row["AdditionalParam10"]),
                                   AdditionalParam11 = Convert.ToString(row["AdditionalParam11"]),
                                   AdditionalParam12 = Convert.ToString(row["AdditionalParam12"]),
                                   AdditionalParam13 = Convert.ToString(row["AdditionalParam13"]),
                                   AdditionalParam2 = Convert.ToString(row["AdditionalParam2"]),
                                   AdditionalParam3 = Convert.ToString(row["AdditionalParam3"]),
                                   AdditionalParam4 = Convert.ToString(row["AdditionalParam4"]),
                                   AdditionalParam5 = Convert.ToString(row["AdditionalParam5"]),
                                   AdditionalParam6 = Convert.ToString(row["AdditionalParam6"]),
                                   AdditionalParam7 = Convert.ToString(row["AdditionalParam7"]),
                                   AdditionalParam8 = Convert.ToString(row["AdditionalParam8"]),
                                   AdditionalParam9 = Convert.ToString(row["AdditionalParam9"]),

                                   ApplicationId = Convert.ToString(row["ApplicationId"]),
                                   ApplicationName = Convert.ToString(row["ApplicationName"]),

                                   Attribute1 = Convert.ToString(row["Attribute1"]),
                                   Attribute2 = Convert.ToString(row["Attribute2"]),
                                   Attribute3 = Convert.ToString(row["Attribute3"]),
                                   Attribute4 = Convert.ToString(row["Attribute4"]),
                                   BusinessImpact = Convert.ToString(row["BusinessImpact"]),
                                   BusinessSector = Convert.ToString(row["BusinessSector"]),
                                   ChangesBusinessImpact = Convert.ToString(row["ChangesBusinessImpact"]),
                                   ChangesCompletionStatus = Convert.ToString(row["ChangesCompletionStatus"]),
                                   Country = Convert.ToString(row["Country"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   DateChangeInitiated = Convert.ToString(row["DateChangeInitiated"]),
                                   DateChangeImplemented = Convert.ToString(row["DateChangeImplemented"]),
                                   Description = Convert.ToString(row["Description"]),
                                   DetailsOfChanges = Convert.ToString(row["DetailsOfChanges"]),
                                   ExchangeDetails = Convert.ToString(row["ExchangeDetails"]),
                                   FinalSignOff = Convert.ToString(row["FinalSignOff"]),
                                   IsActive = Convert.ToString(row["IsActive"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   Name = Convert.ToString(row["Name"]),
                                   NoOfApprover = Convert.ToString(row["NoOfApprover"]),
                                   Objective = Convert.ToString(row["Objective"]),
                                   ProductType = Convert.ToString(row["ProductType"]),
                                   Ranking = Convert.ToString(row["Ranking"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Region = Convert.ToString(row["Region"]),
                                   RiskRating = Convert.ToString(row["RiskRating"]),
                                   SupportingDocument = Convert.ToString(row["SupportingDocument"]),
                                   Type = Convert.ToString(row["Type"]),
                                   Version = Convert.ToString(row["Version"]),

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

    public List<Strategy> GetStrategyDatabyStrategyId(string StrategyNumber)
    {
        List<Strategy> lst = new List<Strategy>();

        string query = "SP_GetStrategyByRefnumber";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", StrategyNumber));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new Strategy
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   AdditionalParam1 = Convert.ToString(row["AdditionalParam1"]),
                                   AdditionalParam10 = Convert.ToString(row["AdditionalParam10"]),
                                   AdditionalParam11 = Convert.ToString(row["AdditionalParam11"]),
                                   AdditionalParam12 = Convert.ToString(row["AdditionalParam12"]),
                                   AdditionalParam13 = Convert.ToString(row["AdditionalParam13"]),
                                   AdditionalParam2 = Convert.ToString(row["AdditionalParam2"]),
                                   AdditionalParam3 = Convert.ToString(row["AdditionalParam3"]),
                                   AdditionalParam4 = Convert.ToString(row["AdditionalParam4"]),
                                   AdditionalParam5 = Convert.ToString(row["AdditionalParam5"]),
                                   AdditionalParam6 = Convert.ToString(row["AdditionalParam6"]),
                                   AdditionalParam7 = Convert.ToString(row["AdditionalParam7"]),
                                   AdditionalParam8 = Convert.ToString(row["AdditionalParam8"]),
                                   AdditionalParam9 = Convert.ToString(row["AdditionalParam9"]),

                                   ApplicationId = Convert.ToString(row["ApplicationId"]),
                                   ApplicationName = Convert.ToString(row["ApplicationName"]),

                                   Attribute1 = Convert.ToString(row["Attribute1"]),
                                   Attribute2 = Convert.ToString(row["Attribute2"]),
                                   Attribute3 = Convert.ToString(row["Attribute3"]),
                                   Attribute4 = Convert.ToString(row["Attribute4"]),
                                   BusinessImpact = Convert.ToString(row["BusinessImpact"]),
                                   BusinessSector = Convert.ToString(row["BusinessSector"]),
                                   ChangesBusinessImpact = Convert.ToString(row["ChangesBusinessImpact"]),
                                   ChangesCompletionStatus = Convert.ToString(row["ChangesCompletionStatus"]),
                                   Country = Convert.ToString(row["Country"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   DateChangeInitiated = Convert.ToString(row["DateChangeInitiated"]),
                                   DateChangeImplemented = Convert.ToString(row["DateChangeImplemented"]),
                                   Description = Convert.ToString(row["Description"]),
                                   DetailsOfChanges = Convert.ToString(row["DetailsOfChanges"]),
                                   ExchangeDetails = Convert.ToString(row["ExchangeDetails"]),
                                   FinalSignOff = Convert.ToString(row["FinalSignOff"]),
                                   IsActive = Convert.ToString(row["IsActive"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   Name = Convert.ToString(row["Name"]),
                                   NoOfApprover = Convert.ToString(row["NoOfApprover"]),
                                   Objective = Convert.ToString(row["Objective"]),
                                   ProductType = Convert.ToString(row["ProductType"]),
                                   Ranking = Convert.ToString(row["Ranking"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Region = Convert.ToString(row["Region"]),
                                   RiskRating = Convert.ToString(row["RiskRating"]),
                                   SupportingDocument = Convert.ToString(row["SupportingDocument"]),
                                   Type = Convert.ToString(row["Type"]),
                                   Version = Convert.ToString(row["Version"]),
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

    public List<Strategy> GetStrategyDatabyId(string StrategyNumber)
    {
        List<Strategy> lst = new List<Strategy>();

        string query = "SP_GetStrategyById";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", StrategyNumber));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new Strategy
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   AdditionalParam1 = Convert.ToString(row["AdditionalParam1"]),
                                   AdditionalParam10 = Convert.ToString(row["AdditionalParam10"]),
                                   AdditionalParam11 = Convert.ToString(row["AdditionalParam11"]),
                                   AdditionalParam12 = Convert.ToString(row["AdditionalParam12"]),
                                   AdditionalParam13 = Convert.ToString(row["AdditionalParam13"]),
                                   AdditionalParam2 = Convert.ToString(row["AdditionalParam2"]),
                                   AdditionalParam3 = Convert.ToString(row["AdditionalParam3"]),
                                   AdditionalParam4 = Convert.ToString(row["AdditionalParam4"]),
                                   AdditionalParam5 = Convert.ToString(row["AdditionalParam5"]),
                                   AdditionalParam6 = Convert.ToString(row["AdditionalParam6"]),
                                   AdditionalParam7 = Convert.ToString(row["AdditionalParam7"]),
                                   AdditionalParam8 = Convert.ToString(row["AdditionalParam8"]),
                                   AdditionalParam9 = Convert.ToString(row["AdditionalParam9"]),
                                   ApplicationId = Convert.ToString(row["ApplicationId"]),
                                   ApplicationName = Convert.ToString(row["ApplicationName"]),
                                   Attribute1 = Convert.ToString(row["Attribute1"]),
                                   Attribute2 = Convert.ToString(row["Attribute2"]),
                                   Attribute3 = Convert.ToString(row["Attribute3"]),
                                   Attribute4 = Convert.ToString(row["Attribute4"]),
                                   BusinessImpact = Convert.ToString(row["BusinessImpact"]),
                                   BusinessSector = Convert.ToString(row["BusinessSector"]),
                                   ChangesBusinessImpact = Convert.ToString(row["ChangesBusinessImpact"]),
                                   ChangesCompletionStatus = Convert.ToString(row["ChangesCompletionStatus"]),
                                   Country = Convert.ToString(row["Country"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   DateChangeInitiated = Convert.ToString(row["DateChangeInitiated"]),
                                   DateChangeImplemented = Convert.ToString(row["DateChangeImplemented"]),
                                   Description = Convert.ToString(row["Description"]),
                                   DetailsOfChanges = Convert.ToString(row["DetailsOfChanges"]),
                                   ExchangeDetails = Convert.ToString(row["ExchangeDetails"]),
                                   FinalSignOff = Convert.ToString(row["FinalSignOff"]),
                                   IsActive = Convert.ToString(row["IsActive"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   Name = Convert.ToString(row["Name"]),
                                   NoOfApprover = Convert.ToString(row["NoOfApprover"]),
                                   Objective = Convert.ToString(row["Objective"]),
                                   ProductType = Convert.ToString(row["ProductType"]),
                                   Ranking = Convert.ToString(row["Ranking"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Region = Convert.ToString(row["Region"]),
                                   RiskRating = Convert.ToString(row["RiskRating"]),
                                   SupportingDocument = Convert.ToString(row["SupportingDocument"]),
                                   Type = Convert.ToString(row["Type"]),
                                   Version = Convert.ToString(row["Version"]),
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

    public List<Strategy> GetStrategyLatestDatabyId(string StrategyNumber)
    {
        List<Strategy> lst = new List<Strategy>();

        string query = "SP_GetStrategyById";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_StrategyNumber", StrategyNumber));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows

                               select new Strategy
                               {
                                   Id = Convert.ToInt32(row["Id"]),
                                   AdditionalParam1 = Convert.ToString(row["AdditionalParam1"]),
                                   AdditionalParam10 = Convert.ToString(row["AdditionalParam10"]),
                                   AdditionalParam11 = Convert.ToString(row["AdditionalParam11"]),
                                   AdditionalParam12 = Convert.ToString(row["AdditionalParam12"]),
                                   AdditionalParam13 = Convert.ToString(row["AdditionalParam13"]),
                                   AdditionalParam2 = Convert.ToString(row["AdditionalParam2"]),
                                   AdditionalParam3 = Convert.ToString(row["AdditionalParam3"]),
                                   AdditionalParam4 = Convert.ToString(row["AdditionalParam4"]),
                                   AdditionalParam5 = Convert.ToString(row["AdditionalParam5"]),
                                   AdditionalParam6 = Convert.ToString(row["AdditionalParam6"]),
                                   AdditionalParam7 = Convert.ToString(row["AdditionalParam7"]),
                                   AdditionalParam8 = Convert.ToString(row["AdditionalParam8"]),
                                   AdditionalParam9 = Convert.ToString(row["AdditionalParam9"]),
                                   ApplicationId = Convert.ToString(row["ApplicationId"]),
                                   ApplicationName = Convert.ToString(row["ApplicationName"]),
                                   Attribute1 = Convert.ToString(row["Attribute1"]),
                                   Attribute2 = Convert.ToString(row["Attribute2"]),
                                   Attribute3 = Convert.ToString(row["Attribute3"]),
                                   Attribute4 = Convert.ToString(row["Attribute4"]),
                                   BusinessImpact = Convert.ToString(row["BusinessImpact"]),
                                   BusinessSector = Convert.ToString(row["BusinessSector"]),
                                   ChangesBusinessImpact = Convert.ToString(row["ChangesBusinessImpact"]),
                                   ChangesCompletionStatus = Convert.ToString(row["ChangesCompletionStatus"]),
                                   Country = Convert.ToString(row["Country"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   DateChangeInitiated = Convert.ToString(row["DateChangeInitiated"]),
                                   DateChangeImplemented = Convert.ToString(row["DateChangeImplemented"]),
                                   Description = Convert.ToString(row["Description"]),
                                   DetailsOfChanges = Convert.ToString(row["DetailsOfChanges"]),
                                   ExchangeDetails = Convert.ToString(row["ExchangeDetails"]),
                                   FinalSignOff = Convert.ToString(row["FinalSignOff"]),
                                   IsActive = Convert.ToString(row["IsActive"]),
                                   LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                   LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                   Name = Convert.ToString(row["Name"]),
                                   NoOfApprover = Convert.ToString(row["NoOfApprover"]),
                                   Objective = Convert.ToString(row["Objective"]),
                                   ProductType = Convert.ToString(row["ProductType"]),
                                   Ranking = Convert.ToString(row["Ranking"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Region = Convert.ToString(row["Region"]),
                                   RiskRating = Convert.ToString(row["RiskRating"]),
                                   SupportingDocument = Convert.ToString(row["SupportingDocument"]),
                                   Type = Convert.ToString(row["Type"]),
                                   Version = Convert.ToString(row["Version"]),
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

    public void InsertStrategydata(Strategy _StrategyInfo, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_Strategy", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", _StrategyInfo.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Name", _StrategyInfo.Name));
                cmd.Parameters.Add(new MySqlParameter("i_Type", _StrategyInfo.Type));
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationName", _StrategyInfo.ApplicationName));
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationId", _StrategyInfo.ApplicationId));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessSector", _StrategyInfo.BusinessSector));
                cmd.Parameters.Add(new MySqlParameter("i_Country", _StrategyInfo.Country));
                cmd.Parameters.Add(new MySqlParameter("i_Region", _StrategyInfo.Region));
                cmd.Parameters.Add(new MySqlParameter("i_ProductType", _StrategyInfo.ProductType));
                cmd.Parameters.Add(new MySqlParameter("i_Ranking", _StrategyInfo.Ranking));
                cmd.Parameters.Add(new MySqlParameter("i_Objective", _StrategyInfo.Objective));
                cmd.Parameters.Add(new MySqlParameter("i_Description", _StrategyInfo.Description));
                cmd.Parameters.Add(new MySqlParameter("i_RiskRating", _StrategyInfo.RiskRating));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessImpact", _StrategyInfo.BusinessImpact));
                cmd.Parameters.Add(new MySqlParameter("i_ExchangeDetails", _StrategyInfo.ExchangeDetails));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam1", _StrategyInfo.AdditionalParam1));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam2", _StrategyInfo.AdditionalParam2));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam3", _StrategyInfo.AdditionalParam3));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam4", _StrategyInfo.AdditionalParam4));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam5", _StrategyInfo.AdditionalParam5));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam6", _StrategyInfo.AdditionalParam6));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam7", _StrategyInfo.AdditionalParam7));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam8", _StrategyInfo.AdditionalParam8));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam9", _StrategyInfo.AdditionalParam9));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam10", _StrategyInfo.AdditionalParam10));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam11", _StrategyInfo.AdditionalParam11));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam12", _StrategyInfo.AdditionalParam12));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam13", _StrategyInfo.AdditionalParam13));

                cmd.Parameters.Add(new MySqlParameter("i_Attribute1", _StrategyInfo.Attribute1));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute2", _StrategyInfo.Attribute2));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute3", _StrategyInfo.Attribute3));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute4", _StrategyInfo.Attribute4));
                //cmd.Parameters.Add(new MySqlParameter("i_IsActive", _StrategyInfo.IsActive));

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

    public void UpdateStrategydata(Strategy _StrategyInfo, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand("sp_update_Strategy", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_id", _StrategyInfo.Id));
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", _StrategyInfo.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Name", _StrategyInfo.Name));
                cmd.Parameters.Add(new MySqlParameter("i_Type", _StrategyInfo.Type));
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationName", _StrategyInfo.ApplicationName));
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationId", _StrategyInfo.ApplicationId));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessSector", _StrategyInfo.BusinessSector));
                cmd.Parameters.Add(new MySqlParameter("i_Country", _StrategyInfo.Country));
                cmd.Parameters.Add(new MySqlParameter("i_Region", _StrategyInfo.Region));
                cmd.Parameters.Add(new MySqlParameter("i_ProductType", _StrategyInfo.ProductType));
                cmd.Parameters.Add(new MySqlParameter("i_Ranking", _StrategyInfo.Ranking));
                cmd.Parameters.Add(new MySqlParameter("i_Objective", _StrategyInfo.Objective));
                cmd.Parameters.Add(new MySqlParameter("i_Description", _StrategyInfo.Description));
                cmd.Parameters.Add(new MySqlParameter("i_RiskRating", _StrategyInfo.RiskRating));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessImpact", _StrategyInfo.BusinessImpact));
                cmd.Parameters.Add(new MySqlParameter("i_ExchangeDetails", _StrategyInfo.ExchangeDetails));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam1", _StrategyInfo.AdditionalParam1));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam2", _StrategyInfo.AdditionalParam2));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam3", _StrategyInfo.AdditionalParam3));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam4", _StrategyInfo.AdditionalParam4));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam5", _StrategyInfo.AdditionalParam5));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam6", _StrategyInfo.AdditionalParam6));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam7", _StrategyInfo.AdditionalParam7));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam8", _StrategyInfo.AdditionalParam8));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam9", _StrategyInfo.AdditionalParam9));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam10", _StrategyInfo.AdditionalParam10));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam11", _StrategyInfo.AdditionalParam11));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam12", _StrategyInfo.AdditionalParam12));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam13", _StrategyInfo.AdditionalParam13));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute1", _StrategyInfo.Attribute1));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute2", _StrategyInfo.Attribute2));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute3", _StrategyInfo.Attribute3));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute4", _StrategyInfo.Attribute4));
                cmd.Parameters.Add(new MySqlParameter("i_Page", _StrategyInfo.Page));
                cmd.Parameters.Add(new MySqlParameter("i_DetailsOfChanges", _StrategyInfo.DetailsOfChanges));
                cmd.Parameters.Add(new MySqlParameter("i_SignOffDate", _StrategyInfo.SignOffDate));
                cmd.Parameters.Add(new MySqlParameter("i_SignoffBy", _StrategyInfo.SignoffBy));
                cmd.Parameters.Add(new MySqlParameter("i_IsActive", _StrategyInfo.IsActive));

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

    public void UpdateStrategyVersiondata(Strategy _StrategyInfo, out int errorcode, out string errordesc)
    {
        try
        {
            int version = GetStrategyLatestVersionIDbyId(_StrategyInfo.RefNumber) + 1;
            //Get_StrategyLatestversionById
            errorcode = 0;
            errordesc = "success";
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_Strategy_Version", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", _StrategyInfo.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Name", _StrategyInfo.Name));
                cmd.Parameters.Add(new MySqlParameter("i_Type", _StrategyInfo.Type));
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationName", _StrategyInfo.ApplicationName));
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationId", _StrategyInfo.ApplicationId));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessSector", _StrategyInfo.BusinessSector));
                cmd.Parameters.Add(new MySqlParameter("i_Country", _StrategyInfo.Country));
                cmd.Parameters.Add(new MySqlParameter("i_Region", _StrategyInfo.Region));
                cmd.Parameters.Add(new MySqlParameter("i_ProductType", _StrategyInfo.ProductType));
                cmd.Parameters.Add(new MySqlParameter("i_Ranking", _StrategyInfo.Ranking));
                cmd.Parameters.Add(new MySqlParameter("i_Objective", _StrategyInfo.Objective));
                cmd.Parameters.Add(new MySqlParameter("i_Description", _StrategyInfo.Description));
                cmd.Parameters.Add(new MySqlParameter("i_RiskRating", _StrategyInfo.RiskRating));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessImpact", _StrategyInfo.BusinessImpact));
                cmd.Parameters.Add(new MySqlParameter("i_ExchangeDetails", _StrategyInfo.ExchangeDetails));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam1", _StrategyInfo.AdditionalParam1));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam2", _StrategyInfo.AdditionalParam2));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam3", _StrategyInfo.AdditionalParam3));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam4", _StrategyInfo.AdditionalParam4));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam5", _StrategyInfo.AdditionalParam5));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam6", _StrategyInfo.AdditionalParam6));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam7", _StrategyInfo.AdditionalParam7));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam8", _StrategyInfo.AdditionalParam8));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam9", _StrategyInfo.AdditionalParam9));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam10", _StrategyInfo.AdditionalParam10));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam11", _StrategyInfo.AdditionalParam11));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam12", _StrategyInfo.AdditionalParam12));
                cmd.Parameters.Add(new MySqlParameter("i_AdditionalParam13", _StrategyInfo.AdditionalParam13));
                cmd.Parameters.Add(new MySqlParameter("i_Version", version));

                // cmd.Parameters.Add(new MySqlParameter("i_DateChangeImplemented", _StrategyInfo.DateChangeImplemented));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute1", _StrategyInfo.Attribute1));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute2", _StrategyInfo.Attribute2));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute3", _StrategyInfo.Attribute3));
                cmd.Parameters.Add(new MySqlParameter("i_Attribute4", _StrategyInfo.Attribute4));

                //Date change Initiated
                //Date change implemented
                cmd.Parameters.Add(new MySqlParameter("i_DetailsOfChanges", _StrategyInfo.DetailsOfChanges));
                cmd.Parameters.Add(new MySqlParameter("i_SignOffDate", _StrategyInfo.SignOffDate));
                cmd.Parameters.Add(new MySqlParameter("i_SignoffBy", _StrategyInfo.SignoffBy));
                cmd.Parameters.Add(new MySqlParameter("i_IsActive", _StrategyInfo.IsActive));

                if (this.OpenConnection() == true)
                {
                    //Execute command
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                    errordesc = "success|" + Convert.ToString(version);
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

    #endregion Strategy

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
                                   Description = Convert.ToString(row["Description"]),
                                   IsSignOff = Convert.ToString(row["IsSignOff"]),
                                   SignoffBy = Convert.ToString(row["SignoffBy"]),
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
                                   Description = Convert.ToString(row["Description"]),
                                   IsSignOff = Convert.ToString(row["IsSignOff"]),
                                   SignoffBy = Convert.ToString(row["SignoffBy"]),
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
                                   Version = Convert.ToString(row["Version"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   EmailAttachment = Convert.ToString(row["EmailAttachment"]),
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
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   EmailAttachment = Convert.ToString(row["EmailAttachment"]),
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



    public void UpdateOnboardingTaskdata(string Id, string emailattachment, string comments, out int errorcode, out string errordesc)
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
                                   StrategyNumber = Convert.ToString(row["StrategyNumber"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   EmailAttachment = Convert.ToString(row["EmailAttachment"]),
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
                                   StrategyNumber = Convert.ToString(row["StrategyNumber"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   EmailAttachment = Convert.ToString(row["EmailAttachment"]),
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
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   EmailAttachment = Convert.ToString(row["EmailAttachment"]),
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
                                   Version = Convert.ToString(row["Version"]),
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
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Version = Convert.ToString(row["Version"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   EmailAttachment = Convert.ToString(row["EmailAttachment"]),
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
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Version= Convert.ToString(row["Version"]),
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   EmailAttachment = Convert.ToString(row["EmailAttachment"]),
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
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", objMaptask.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Version", objMaptask.Version));
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




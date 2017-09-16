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
            connection = new MySqlConnection(connString);
        }
        catch (Exception ex)
        {
            log.ErrorFormat("Exception Occured :{0}", ex.ToString());
            log.ErrorFormat("Exception Trace Message :{0}", ex.StackTrace);
        }
    }

    #endregion


    #region TransferSetting

    public void InsertTransferSetting(TransferSetting objTransferSetting, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_transfersetting", connection))
            {

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_Owneruser", objTransferSetting.OwnerUser));
                cmd.Parameters.Add(new MySqlParameter("i_TransferTo", objTransferSetting.Transferuser));
                cmd.Parameters.Add(new MySqlParameter("i_DurationFrom", objTransferSetting.TransferFrom));
                cmd.Parameters.Add(new MySqlParameter("i_DurationTo", objTransferSetting.TransferTo));

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

    public void DeleteTransferSetting(string OwnerUser, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_delete_transfersetting", connection))
            {

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_owner", OwnerUser));
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

    public List<TransferSetting> GetTransfersettingIDbyuser(string username)
    {
        List<TransferSetting> lst = new List<TransferSetting>();
        string query = "sp_gettransfersettingbyuser";
        //open connection
        if (this.OpenConnection() == true)
        {
            //create command and assign the query and connection from the constructor
            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Owner", username));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new TransferSetting
                               {
                                   TransferFrom = Convert.ToString(row["DurationFrom"]),
                                   TransferTo = Convert.ToString(row["DurationFrom"]),
                                   OwnerUser = Convert.ToString(row["Owneruser"]),
                                   Transferuser = Convert.ToString(row["TransferTo"]),
                                   IsActive = Convert.ToString(row["IsActive"]),
                                   Id = Convert.ToString(row["Id"])

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
    

    #endregion TransferSetting

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
                                   Comments = Convert.ToString(row["Comments"]),
                                   Status = Convert.ToString(row["Status"]),
                                   ApprovedDate = Convert.ToString(row["ApprovedDate"])

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
                                   Comments = Convert.ToString(row["Comments"]),
                                   Status = Convert.ToString(row["Status"]),
                                   ApprovedDate = Convert.ToString(row["ApprovedDate"])
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


    #region Role

    #endregion Role

    #region User    

    #endregion User    

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



    #region Roles

    public void GetRoles(string roleId)
    {
        try
        {
            if (roleId != null)
            {
                //models.Role.findAll({ where: { id: roleId } })
                //   .then(function(roles) { deferred.resolve(roles); })
                //   .catch (function (err) { deferred.reject(err) });
            }
            else
            {
                //console.log('Inside get all roles');
                //models.Role.findAll().then(function(roles) {
                //    deferred.resolve(roles);
                //}).catch (function (err) {
                //console.log('Error' + err);
                //deferred.reject(err)
                //});
            }
        }
        catch (Exception e)
        {
        }
    }
    public void GetUserRoles(string roleId)
    {

        try
        {
            //models.User.findAll({ where: { RoleId: roleId } })
            //   .then(function(userroles) { deferred.resolve(userroles); })
            //   .catch (function (err) { deferred.reject(err) });
        }
        catch (Exception e)
        {
        }
    }
    public void GetRights(string roleId)
    {
        try
        {
            if (roleId != null && roleId != "")
            {
                //models.Right.findAll({ where: { RightID: roleId } })
                // .then(function(right) { deferred.resolve(right); })
                // .catch (function (err) { deferred.reject(err) });
            }
            else
            {
                //models.Right.findAll().then(function(rights) {
                //    deferred.resolve(rights);
                //}).catch (function (err) { deferred.reject(err) });
            }
        }
        catch (Exception e)
        {
        }
    }

    public void AddRole(string role)
    {
        try
        {

            //models.Role.create({
            //    RoleName: role.selectedRole
            //}).then(function(role) {
            //    console.log('Added role to master table')
            //    deferred.resolve(role);
            //})

        }
        catch (Exception e)
        {
        }
    }

    public void ModifyRoleRight(string roleright)
    {
        try
        {
            //var dbdate = new Date();
            //var createdDate = moment(dbdate).add(30, 'days').format('L LT');
            //    console.log(JSON.stringify(roleright));
            //    models.RoleRight.destroy({ where: { RoleID: roleright.id }, truncate: false })
            //                   .then(function() {
            //        for (var i = 0; i < roleright.Rights.length; i++)
            //        {
            //            console.log('Mapping Right ' + roleright.Rights[i].RightID + ' to Role ' + roleright.id);
            //            models.RoleRight.create({
            //                RoleID: roleright.id,
            //                               RightID: roleright.Rights[i].RightID
            //                           }).then(function(role) {
            //            console.log('Added role-right to mapping table')
            //                               deferred.resolve(role);
            //        }).catch (function (err) {
            //    console.log('Error: ' + err); deferred.reject(err);
            //})

        }
        catch (Exception e)
        {

        }
    }

    public void AddRoleRightMapping(string roleright)
    {
        try
        {
            //var dbdate = new Date();
            //var createdDate = moment(dbdate).add(30, 'days').format('L LT');
            //    for (var i = 0; i < roleright.Rights.length; i++)
            //    {
            //        console.log('Mapping Right ' + roleright.Rights[i].RightID + ' to Role ' + roleright.RoleID);
            //        models.RoleRight.create({
            //            RoleID: roleright.RoleID,
            //            RightID: roleright.Rights[i].RightID
            //            }).then(function(role) {
            //        console.log('Added role-right to mapping table')
            //            deferred.resolve(role);
            //    })
            //                        .catch (function (err) {
            //    console.log('Error: ' + err); deferred.reject(err);
            //})
            //    }
        }
        catch (Exception e)
        {
        }
    }

    public void DeleteRole(string roleright)
    {
        try
        {
            //    console.log('Deleting role-right mapping');
            //    models.RoleRight.destroy({ where: { RoleID: roleright.id }, truncate: false })
            //                       .then(function() {
            //        console.log('Deleting Role from Role master');
            //        models.Role.destroy({ where: { id: roleright.id }, truncate: false });
            //    }).then(function(data) {
            //        console.log('Deleted role and role-right map successfully');
            //        deferred.resolve(data);
            //    }).catch (function (error) {
            //    console.log('Error occurred when deleting role');
            //    deferred.reject(data);
            //});
        }
        catch (Exception e)
        {
        }
    }
    public void GetRoleRightMapping(string roleId)
    {
        try
        {
            //    if (roleId != null && roleId != undefined)
            //    {
            //        console.log('Inside get GetRoleRightMapping for Role ' + roleId);
            //        models.RoleRight.findAll({ where: { RoleID: roleId } })
            //        .then(function(roleright) { deferred.resolve(roleright); })
            //        .catch (function (err) { console.log('GetRoleRightMapping: ' + err); deferred.reject(err) });
            //}
            //    else {
            //    console.log('Inside get all GetRoleRightMapping');
            //    models.RoleRight.findAll().then(function(rolerights) {
            //        deferred.resolve(rolerights);
            //    }).catch (function (err) { deferred.reject(err) });
            //    }
        }
        catch (Exception e)
        {
        }
    }

    #endregion Roles


    #region Users


    public void GetAllEmail()
    {
        try
        {
            //sequelize.query('Select EmailId from TBL_USER_MASTER',
            //    {
            //    type: sequelize.QueryTypes.SELECT
            //    }).then(function(response) {
            //    logger.info('success');
            //    logger.info('response: ' + JSON.stringify(response));
            //    deferred.resolve(response);
            //}).error(function(err) {
            //    logger.info('failure: ' + err);
            //    deferred.reject(err)
            //    });
        }
        catch (Exception ex)
        {
        }
    }
    public void GetUserProfile(string userId)
    {
        try
        {
            //logger.info('Inside get User profile');
            //models.ADUser.findOne({ where: { userId: userId } })
            //    .then(function(aduser) { deferred.resolve(aduser); })
            //    .catch (function (err) { deferred.reject(err) });
        }
        catch (Exception e)
        {
        }
    }
    public void GetAllSBU()
    {

        try
        {
            //logger.info('Inside get all SBUs');
            //models.SBU.findAll({
            //    where: { 'SBU': { $ne: 'All' } },
            //    order: [
            //        ['SBU', 'ASC']]
            //}).then(function(sbus) {
            //    sbus.push({ 'id': 6, 'SBU': 'All' });
            //    logger.info(JSON.stringify(sbus));
            //    deferred.resolve(sbus);
            //}).catch (function (err) { deferred.reject(err) });
        }
        catch (Exception e)
        {
        }
    }
    public void GetUserSBU(string userId)
    {

        try
        {

            //    if (userId != null && userId != undefined)
            //    {
            //        logger.info('Inside get user SBU for user:  ' + userId);
            //        models.UserSBU.findAll({ where: { UserID: userId } })
            //            .then(function(sbus) { deferred.resolve(sbus); })
            //            .catch (function (err) { logger.info('GetUserSBU ' + err); deferred.reject(err) });
            //}
            //    else {
            //    logger.info('Inside get all users');
            //    models.UserSBU.findAll().then(function(users) {
            //        deferred.resolve(users);
            //    }).catch (function (err) { deferred.reject(err) });
            //    }
        }
        catch (Exception e)
        {
        }
    }
    public void GetUserBillingSBU(string userId)
    {
        try
        {

            //    if (userId != null && userId != undefined)
            //    {
            //        logger.info('Inside get user Billing SBU for user:  ' + userId);
            //        models.UserBillingSBU.findAll({ where: { UserID: userId } })
            //            .then(function(sbus) { deferred.resolve(sbus); })
            //            .catch (function (err) { logger.info('GetUserBillingSBU ' + err); deferred.reject(err) });
            //}
            //    else {
            //    logger.info('Inside get all user sbu billings');
            //    models.UserBillingSBU.findAll().then(function(users) {
            //        deferred.resolve(users);
            //    }).catch (function (err) { deferred.reject(err) });
            //    }
        }
        catch (Exception e)
        {
        }
    }
    public void GetUser(string userId)
    {
        try
        {
            //    if (userId != null && userId != undefined)
            //    {
            //        logger.info('Inside get all users ' + userId);
            //        models.User.findOne({ where: { userId: userId } })
            //            .then(function(user) { deferred.resolve(user); })
            //            .catch (function (err) { logger.info('GetUser ' + err); deferred.reject(err) });
            //}
            //    else {
            //    logger.info('Inside get all users');
            //    models.User.findAll().then(function(users) {
            //        deferred.resolve(users);
            //    }).catch (function (err) { deferred.reject(err) });
            //    }
        }
        catch (Exception e)
        {
        }
    }
    public void GetUsersByTypes(string typeids)
    {
        try
        {
            //var typearray = '';

            //for (var i = 0; i < typeids.length; i++)
            //{
            //    typearray = typearray + typeids[i].TypeId;
            //    if (i != typeids.length - 1)
            //    {
            //        typearray = typearray + ',';
            //    }
            //}

            //sequelize.query('select Userid as userId, UserName,EmailId,BillingId,LastWorkingDate, FirstWorkingDate, LocationId from TBL_USER_MASTER where TypeId in (' + typearray + ') and Userid != \'OTHER\'',

            //    {
            //    type: sequelize.QueryTypes.SELECT
            //    }).then(function(response) {
            //    logger.info('Retrieved users successfully');
            //    deferred.resolve(response);
            //}).error(function(err) {
            //    logger.info('Failed to retrieve users: ' + err);
            //    deferred.reject(err);
            //});
        }
        catch (Exception e)
        {
        }
    }
    public void CreateTempUser(string user)
    {
        try
        {
            //var dbdate = new Date();
            //var createdDate = moment(dbdate).add(30, 'days').format('L LT');
            ////var hash_parts = Utility.UtilityModel.create_password(user.password);
            ////var hashedpwd = hash_parts.method + "$" + hash_parts.salt + "$" + hash_parts.hash;
            //var encryptedPwd = Utility.UtilityModel.encryptStringWithRsaPublicKey(user.password);
            //models.sequelize.transaction().then(function(t) {
            //    if (t != null && t != undefined)
            //    {
            //        var userExpiryDate = moment(dbdate).add(30, 'days').format('L LT');
            //        var passwordExpiryDate = moment(dbdate).add(30, 'days').format('L LT');
            //        var userBlockDate = moment(dbdate).add(30, 'days').format('L LT');
            //        logger.info('Type: ' + JSON.stringify(user.selectedType));
            //        logger.info('Role: ' + JSON.stringify(user.Role));
            //        logger.info('Creating temp user: \nUserId: ' + user.userId + '\nUserType: ' + user.selectedType.TypeID + '\nUserRole:' + user.Role.id);
            //        models.User.create({
            //            userId: user.userId, UserName: user.userId, TypeId: user.selectedType.TypeID, RoleId: user.Role.id, Password: encryptedPwd, EmailId: user.emailId,
            //            CustomData: 'NA', Status: 'Active', UserExpiryDate: userExpiryDate, IsADUser: 'No',
            //            PasswordExpiryDate: passwordExpiryDate, UserBlockDate: userBlockDate, AttemptedTries: 0,
            //            LastUsedDate: createdDate, CreatedDate: createdDate, CreatedBy: '', ModifiedDate: createdDate,
            //            ModifiedBy: '', ApprovedDate: createdDate, Approvedby: '', MakerComment: '',
            //            CheckerComment: ''
            //        }, { transaction: t })
            //            .then(function(usercreate) {
            //            models.UserPasswordHistory.create({
            //                SessionTokenId: uuid.v1(), UserId: user.userId,
            //                    Password: encryptedPwd, CreatedDate: createdDate
            //                })
            //                    .then(function(usercreated) {
            //                logger.info('temp user created successfully');
            //                logger.info('SBUs:\n' + JSON.stringify(user.SBU));

            //                var tempArr = [];
            //                for (var i = 0; i < user.SBU.length; i++)
            //                {
            //                    tempArr.push({ 'UserID': user.userId, 'SBUID': user.SBU[i] });
            //            }
            //            models.UserSBU.bulkCreate(tempArr, { omitNull: true }).then(function(sbu) {
            //                logger.info('Added SBUs');
            //                models.UserBillingSBU.destroy({ where: { userId: user.userId }, truncate: false }, { transaction: t })
            //                                .then(function(usersbus) {
            //                    var tempArr2 = [];
            //                    for (var i = 0; i < user.BillingSBU.length; i++)
            //                    {
            //                        tempArr2.push({ 'UserID': user.userId, 'SBUID': user.BillingSBU[i].id });
            //                }
            //                logger.info('SBUs:\n' + JSON.stringify(user.SBU));
            //                models.UserBillingSBU.bulkCreate(tempArr2, { omitNull: true }).then(function(billsbu) {
            //                    logger.info('Added Billing SBUs');
            //                    t.commit();
            //                    deferred.resolve(billsbu);
        }
        catch (Exception e)
        {
        }
    }
    public void CreateUser(string user)
    {
        try
        {
            //    var dbdate = new Date();
            //    var createdDate = moment(dbdate).add(30, 'days').format('L LT');
            //    var hash_parts = Utility.UtilityModel.create_password(user.password);
            //    var hashedpwd = hash_parts.method + "$" + hash_parts.salt + "$" + hash_parts.hash;
            //    this.GetUser(user.userId)
            //        .then(function(userdtl) {
            //        models.sequelize.transaction().then(function(t) {
            //            if (t != null && t != undefined)
            //            {
            //                var userExpiryDate = moment(dbdate).add(30, 'days').format('L LT');
            //                var passwordExpiryDate = moment(dbdate).add(30, 'days').format('L LT');
            //                var userBlockDate = moment(dbdate).add(30, 'days').format('L LT');

            //                var fwd = moment.utc(user.FirstWorkingDate).toDate();
            //                user.FirstWorkingDate = moment(fwd).format('YYYY-MM-DD HH:mm:ss');

            //                if (user.LastWorkingDate != null)
            //                {
            //                    var lwd = moment.utc(user.LastWorkingDate).toDate();
            //                    user.LastWorkingDate = moment(lwd).format('YYYY-MM-DD HH:mm:ss');
            //                }
            //                logger.info('Creating user: \nUserId: ' + user.userId + '\nUserName: ' + user.UserName + '\nUserType: ' + user.selectedType + '\nUSerSBU: ' + user.SBU + '\nUserRole:' + user.Role +
            //                    '\nBillingId: ' + (user.Billing == undefined ? null : user.Billing) + '\nBaseSkillId: ' + (user.BaseSkill == undefined ? null : user.BaseSkill) + '\nLocationId: ' + (user.Location == undefined ? null : user.Location) + '\nFWD: ' + user.FirstWorkingDate + '\nLastWorkingDate: ' + user.LastWorkingDate);
            //                models.User.create({
            //                    userId: user.userId, UserName: user.UserName, TypeId: user.selectedType, RoleId: user.Role, Password: hashedpwd, EmailId: user.EmailId,
            //                            BillingId: (user.Billing == undefined ? null : user.Billing), BaseSkillId: (user.BaseSkill == undefined ? null : user.BaseSkill), LocationId: (user.Location == undefined ? null : user.Location), FirstWorkingDate: user.FirstWorkingDate, LastWorkingDate: user.LastWorkingDate,
            //                            MobileNumber: user.mobileNumber, CustomData: 'NA', Status: 'Active', UserExpiryDate: userExpiryDate, IsADUser: 'Yes',
            //                            PasswordExpiryDate: passwordExpiryDate, UserBlockDate: userBlockDate, AttemptedTries: 0,
            //                            LastUsedDate: createdDate, CreatedDate: createdDate, CreatedBy: '', ModifiedDate: createdDate,
            //                            ModifiedBy: '', ApprovedDate: createdDate, Approvedby: '', MakerComment: '',
            //                            CheckerComment: ''
            //                        }, { transaction: t })
            //                            .then(function(usercreate) {
            //                    models.UserPasswordHistory.create({
            //                        SessionTokenId: uuid.v1(), UserId: user.userId,
            //                                    Password: hashedpwd, CreatedDate: createdDate
            //                                })
            //                                    .then(function(usercreated) {
            //                        logger.info('user created successfully');

            //                        var tempArr = [];
            //                        for (var i = 0; i < user.SBU.length; i++)
            //                        {
            //                            tempArr.push({ 'UserID': user.userId, 'SBUID': user.SBU[i].id });
            //                    }
            //                    logger.info('SBUs:\n' + JSON.stringify(user.SBU));
            //                    models.UserSBU.bulkCreate(tempArr, { omitNull: true }).then(function(sbu) {
            //                        logger.info('Added SBUs');
            //                        if (user.BillingSBU != undefined)
            //                        {
            //                            models.UserBillingSBU.destroy({ where: { userId: user.userId }, truncate: false }, { transaction: t })
            //                                                    .then(function(usersbus) {
            //                                var tempArr2 = [];
            //                                for (var i = 0; i < user.BillingSBU.length; i++)
            //                                {
            //                                    tempArr2.push({ 'UserID': user.userId, 'SBUID': user.BillingSBU[i].id });
            //                            }
            //                            logger.info('Billing SBUs:\n' + JSON.stringify(user.BillingSBU));
            //                            models.UserBillingSBU.bulkCreate(tempArr2, { omitNull: true }).then(function(billsbu) {
            //                                logger.info('Added Billing SBUs');
            //                                t.commit();
            //                                deferred.resolve(billsbu);
            //                            }).catch (function (temperr) {
            //    logger.info('Billing SBU Error: ' + temperr); t.rollback(); deferred.reject(temperr);
            //})
            //                                                    }).catch (function (usersbuEDestroy) { logger.info(usersbuEDestroy); t.rollback(); deferred.reject(usersbuEDestroy); })
            //                                            }
            //                                            else {
            //    t.commit();
            //    logger.info('No Billing SBUs');

        }
        catch (Exception e)
        {
        }
    }
    public void ModifyUser(string user)
    {
        try
        {
            //    var dbdate = new Date();
            //    //var hash_parts = Utility.UtilityModel.create_password(user.password);
            //    //var hashedpwd = hash_parts.method + "$" + hash_parts.salt + "$" + hash_parts.hash;
            //    var createdDate = moment(dbdate).add(30, 'days').format('L LT');
            //    this.GetUser(user.userId)
            //        .then(function(userdtl) {
            //        models.sequelize.transaction().then(function(t) {
            //            if (t != null && t != undefined)
            //            {
            //                var userExpiryDate = moment(dbdate).add(30, 'days').format('L LT');
            //                var passwordExpiryDate = moment(dbdate).add(30, 'days').format('L LT');
            //                var userBlockDate = moment(dbdate).add(30, 'days').format('L LT');
            //                //logger.info(JSON.stringify(user));
            //                var fwd = moment.utc(user.FirstWorkingDate).toDate();
            //                user.FirstWorkingDate = moment(fwd).format('YYYY-MM-DD HH:mm:ss');

            //                if (user.LastWorkingDate != null)
            //                {
            //                    var lwd = moment.utc(user.LastWorkingDate).toDate();
            //                    user.LastWorkingDate = moment(lwd).format('YYYY-MM-DD HH:mm:ss');
            //                }
            //                logger.info('Modifying user: \n' + user.userId + '\n' + user.userName + '\n' + user.selectedType.TypeID + '\n' + user.SBU + '\nStatus: ' + user.selectedStatus +
            //                    '\nBillingId: ' + (user.selectedBilling == undefined ? null : user.selectedBilling.Id) +
            //                    '\nBaseSkillId: ' + (user.selectedBaseSkill == undefined ? null : user.selectedBaseSkill.Id) +
            //                    '\nLocationId: ' + (user.selectedLocation == undefined ? null : user.selectedLocation.Id) + '\nFWD: ' + user.FirstWorkingDate + '\nLastWorkingDate: ' + user.LastWorkingDate);

            //                models.User.update({
            //                    UserName: user.userName, TypeId: user.selectedType.TypeID, RoleId: user.Role.id, EmailId: user.emailId,
            //                            BillingId: (user.selectedBilling == undefined ? null : user.selectedBilling.Id), BaseSkillId: (user.selectedBaseSkill == undefined ? null : user.selectedBaseSkill.Id), LocationId: (user.selectedLocation == undefined ? null : user.selectedLocation.Id), FirstWorkingDate: user.FirstWorkingDate, LastWorkingDate: user.LastWorkingDate,
            //                            MobileNumber: user.mobileNumber, CustomData: 'NA', Status: user.selectedStatus, UserExpiryDate: userExpiryDate,
            //                            PasswordExpiryDate: passwordExpiryDate, UserBlockDate: userBlockDate, AttemptedTries: 0,
            //                            LastUsedDate: createdDate, CreatedDate: createdDate, CreatedBy: '', ModifiedDate: createdDate,
            //                            ModifiedBy: '', ApprovedDate: createdDate, Approvedby: '', MakerComment: '',
            //                            CheckerComment: ''
            //                        }, { where: { userId: user.userId } }, { transaction: t })
            //                            .then(function(user) {
            //                    deferred.resolve(user);
            //                })
            //                            .then(function(userdtl) {
            //                    models.UserSBU.destroy({ where: { userId: user.userId }, truncate: false }, { transaction: t })
            //                                    .then(function(usersbus) {
            //                        var tempArr = [];
            //                        for (var i = 0; i < user.SBU.length; i++)
            //                        {
            //                            tempArr.push({ 'UserID': user.userId, 'SBUID': user.SBU[i] });
            //                    }
            //                    logger.info('SBUs:\n' + JSON.stringify(user.SBU));
            //                    models.UserSBU.bulkCreate(tempArr, { omitNull: true }).then(function(sbu) {
            //                        logger.info('Added SBUs');
            //                        if (user.BillingSBU != undefined)
            //                        {
            //                            models.UserBillingSBU.destroy({ where: { userId: user.userId }, truncate: false }, { transaction: t })
            //                                                    .then(function(usersbus) {
            //                                var tempArr2 = [];
            //                                for (var i = 0; i < user.BillingSBU.length; i++)
            //                                {
            //                                    tempArr2.push({ 'UserID': user.userId, 'SBUID': user.BillingSBU[i] });
            //                            }
            //                            logger.info('Billing SBUs:\n' + JSON.stringify(user.BillingSBU));
            //                            models.UserBillingSBU.bulkCreate(tempArr2, { omitNull: true }).then(function(billsbu) {
            //                                logger.info('Added Billing SBUs');
            //                                t.commit();
            //                                deferred.resolve(billsbu);
            //                            }).catch (function (temperr) {
            //    logger.info('Billing SBU Error: ' + temperr); t.rollback(); deferred.reject(temperr);
            //})
            //                                                    }).catch (function (usersbuEDestroy) { logger.info(usersbuEDestroy); t.rollback(); deferred.reject(usersbuEDestroy); })
            //                                            }
            //                                            else {
            //    logger.info('No Billing SBUs');
            //    deferred.resolve(sbu);
            //}
        }
        catch (Exception e)
        {
        }
    }
    public void DeleteUser(string user)
    {
        try
        {
            //    logger.info('Deleting user ' + user.userId);
            //    this.GetUser(user.userId)
            //        .then(function(userdtl) {
            //        models.sequelize.transaction().then(function(t) {
            //            if (t != null && t != undefined)
            //            {
            //                // models.UserRoles.destroy({ where: { userId: user.userId }, truncate: false },{transaction:t})
            //                //    .then(function(userrole){
            //                logger.info('Deleting user 123');
            //                models.User.destroy({ where: { userId: user.userId }, truncate: false }, { transaction: t })
            //                            .then(function(user) {
            //                    t.commit(); deferred.resolve(user);
            //                })
            //                            .catch (function (destroyError) {
            //    logger.info('destroy ' + destroyError)
            //                                 t.rollback(); deferred.reject(destroyError);
            //})
            //                        // })
            //                        // .catch(function(userRoleError){
            //                        // logger.info('userRoleError ' + userRoleError)
            //                        // t.rollback(); deferred.reject(userRoleError);
            //                        // });            
            //                    }
        }
        catch (Exception e)
        {
        }
    }
    public void ChangePassword(string user)
    {
        try
        {
            //var dbdate = new Date();
            //var createdDate = moment(dbdate).add(30, 'days').format('L LT');
            //var hash_parts = Utility.UtilityModel.create_password(user.newpassword);
            //var hashedpwd = hash_parts.method + "$" + hash_parts.salt + "$" + hash_parts.hash;

            //this.GetUser(user.userId)
            //    .then(function(userdtl) {
            //    var currenthashedpwd = userdtl.Password;

            //    var checkStatus = Utility.UtilityModel.check_password(currenthashedpwd, user.oldPassword);
            //    if (checkStatus.status === true)
            //    {
            //        logger.info('password matched for user ' + user.userId);
            //        models.UserPasswordHistory.findAll({ where: { userId: user.userId }, limit: 5, order: 'CreatedDate DESC' })
            //                .then(function(userPasswords) {
            //            logger.info(userPasswords);
            //            for (var i = 0; i > userPasswords.length; i++)
            //            {
            //                var verifyPassword = Utility.UtilityModel.check_password(userPasswords[i].Password, user.newpassword);
            //                if (verifyPassword.status === true)
            //                {
            //                    deferred.reject({ error: 1001, errorMsg: 'last 5 Password can not be used' });
            //        }
            //    }

            //    models.sequelize.transaction().then(function(t) {
            //        if (t != null && t != undefined)
            //        {
            //            var userExpiryDate = moment(dbdate).add(30, 'days').format('L LT');
            //            var passwordExpiryDate = moment(dbdate).add(30, 'days').format('L LT');
            //            var userBlockDate = moment(dbdate).add(30, 'days').format('L LT');

            //            models.User.update({
            //                Password: hashedpwd, UserExpiryDate: userExpiryDate,
            //                                PasswordExpiryDate: passwordExpiryDate, UserBlockDate: userBlockDate, AttemptedTries: 0,
            //                                ModifiedDate: createdDate, ModifiedBy: '', ApprovedDate: createdDate, Approvedby: '',
            //                                MakerComment: '', CheckerComment: ''
            //                                }, { where: { userId: user.userId } }, { transaction: t })
            //                                .then(function(userupdatedtl) {
            //                models.UserPasswordHistory.create({
            //                    SessionTokenId: user.sessionId, UserId: user.userId,
            //                                        Password: hashedpwd, CreatedDate: createdDate
            //                                        }, { transaction: t })
            //                                        .then(function(pass) { t.commit(); deferred.resolve(userdtl); })
            //                                        .catch (function (passError) {
        }
        catch (Exception e)
        {
        }
    }
    public void UserLogin(string user)
    {
        try
        {

            //var curentdate = moment().format("YYYY-MM-DD HH:mm:ss");
            //var createdDate = moment.utc(curentdate).toDate();
            //createdDate = moment(createdDate).format('YYYY-MM-DD HH:mm:ss');
            //// var dbdate = new Date();
            //// var createdDate = moment(dbdate).format('L LT');

            //this.GetUser(user.userId)
            //    .then(function(userdtl) {
            //    if (userdtl != null && userdtl != undefined)
            //    {
            //        if (userdtl.Status != 'Inactive')
            //        {
            //            var currenthashedpwd = userdtl.Password;
            //            // var verifyPwd = Utility.UtilityModel.check_password(currenthashedpwd,user.password);
            //            Utility.UtilityModel.Authenticate(user.userId, user.password).then(function(data) {
            //                logger.info('check ' + data);
            //                if (data === true)
            //                {
            //                    logger.info('password matched for user ' + user.userId);
            //                    var expireAt = moment().add(90000, 'seconds').format('L LT');
            //                    var token = Utility.UtilityModel.generateToken(user, 90000);
            //                    logger.info(token.length);
            //                    models.sequelize.transaction().then(function(t) {
            //                        if (t != null && t != undefined)
            //                        {
            //                            models.UserSession.create({
            //                                SessionTokenId: token, UserId: user.userId, Tokendetail: token,
            //                                    CreatedDate: createdDate, ExpiredDate: expireAt, RequestIPAddress: user.requestIPAddress
            //                                    }, { transaction: t })
            //                                    .then(function(userSession) {
            //                                models.User.update({ LastAuthenticatedDate: createdDate }, { where: { userId: user.userId } }, { transaction: t })
            //                                            .then(function(userupdate) {
            //                                    t.commit();
            //                                    deferred.resolve({
            //                                        token: token, expires: expireAt, user:
            //                                        {
            //                                            userId: userdtl.userId,
            //                                                        UserName: userdtl.UserName, EmailId: userdtl.EmailId, MobileNumber: userdtl.MobileNumber,
            //                                                        CustomData: userdtl.CustomData, Status: userdtl.Status, UserExpiryDate: userdtl.UserExpiryDate,
            //                                                        PasswordExpiryDate: userdtl.PasswordExpiryDate, UserBlockDate: userdtl.UserBlockDate,
            //                                                        AttemptedTries: userdtl.AttemptedTries, LastUsedDate: userdtl.LastUsedDate,
            //                                                        CreatedDate: userdtl.CreatedDate, CreatedBy: userdtl.CreatedBy,
            //                                                        ModifiedDate: userdtl.ModifiedDate, ModifiedBy: userdtl.ModifiedBy, ApprovedDate: userdtl.ModifiedBy,
            //                                                        Approvedby: userdtl.Approvedby, MakerComment: userdtl.MakerComment,
            //                                                        CheckerComment: userdtl.CheckerComment
            //                                                        }
        }
        catch (Exception e)
        {
        }
    }
    public void UserLogout(string user)
    {
        try
        {
            //var dbdate = new Date();
            //var createdDate = moment(dbdate).add(30, 'day').format('L LT');
            //this.GetUser(user.userId)
            //    .then(function(userdtl) {
            //    models.sequelize.transaction().then(function(t) {
            //        if (t != null && t != undefined)
            //        {
            //            models.UserSession.update({ LogoutDate: createdDate },
            //                        { where: { userId: user.userId, SessionTokenId: user.token, LogoutDate: null } }, { transaction: t })
            //                        .then(function(userSession) {
            //                models.User.update({ LastUsedDate: createdDate }, { where: { userId: user.userId } }, { transaction: t })
            //                                .then(function(userupdate) {
            //                    t.commit();
        }
        catch (Exception e)
        {
        }
    }

    public void GetMenuList(string userId)
    {
        try
        {
            //sequelize.query('select distinct MenuName, Path, RM.RightID, RM.ShowMenu, RM.Icon from TBL_RIGHT_MASTER RM inner join TBL_ROLERIGHT_MAPPING RR on RM.RightID=RR.RightID inner join TBL_USER_MASTER UM on RR.RoleID=UM.RoleId where UM.Userid = :UserId order by RM.RightID',
            //        {
            //    replacements: { UserId: userId },
            //        type: sequelize.QueryTypes.SELECT
            //    }).then(function(response) {
            //    logger.info('success');
            //    logger.info('response: ' + response);
            //    deferred.resolve(response);
            //}).error(function(err) {
            //    logger.info('failure: ' + err);
            //    deferred.reject(err);
            //});

        }
        catch (Exception e)
        {
        }
    }

    public void GetRightsList(string userId)
    {
        try
        {
            //logger.info('query' + userId);
            //sequelize.query('select distinct RightName, Path from TBL_RIGHT_MASTER RM inner join TBL_ROLERIGHT_MAPPING RR on RM.RightID=RR.RightID inner join TBL_USER_MASTER UM on RR.RoleID=UM.RoleId where UM.Userid = :UserId',
            //        {
            //    replacements: { UserId: userId },
            //        type: sequelize.QueryTypes.SELECT
            //    }).then(function(response) {
            //    logger.info('success');
            //    logger.info('response: ' + response);
            //    deferred.resolve(response);
            //}).error(function(err) {
            //    logger.info('failure: ' + err);
            //    deferred.reject(err);
            //});

        }
        catch (Exception e)
        {
        }
    }

    public void GetUserSessionInfo(string createdDate)
    {
        try
        {
            //sequelize.query('Select UserId, CreatedDate from TBL_USER_SESSION where CONVERT(date, CreatedDate) = :CreatedOn',
            //        {
            //    replacements: { CreatedOn: createdDate },
            //        type: sequelize.QueryTypes.SELECT
            //    }).then(function(response) {
            //    logger.info('success');
            //    logger.info('response: ' + response);
            //    deferred.resolve(response);
            //}).error(function(err) {
            //    logger.info('failure: ' + err);
            //    deferred.reject(err);
            //});
        }
        catch (Exception e)
        {
        }
    }


    public void GetBillingOptions(string userId)
    {
        try
        {
            //    if (userId != null && userId != undefined)
            //    {
            //        logger.info('Inside get billing for user ' + userId);
            //        models.Billing.findOne({ where: { Id: userId } })
            //            .then(function(bill) { deferred.resolve(bill); })
            //            .catch (function (err) { logger.info('GetBillingOptions error: ' + err); deferred.reject(err) });
            //}
            //    else {
            //    logger.info('Inside get all billing');
            //    models.Billing.findAll().then(function(bill) {
            //        deferred.resolve(bill);
            //    }).catch (function (err) { logger.info('GetAllBillingOptions error: ' + err); deferred.reject(err) });
            //    }
        }
        catch (Exception e)
        {
        }
    }
    public void GetLocation(string userId)
    {
        try
        {
            //    if (userId != null && userId != undefined)
            //    {
            //        logger.info('Inside get Location for user ' + userId);
            //        models.Location.findOne({ where: { Id: userId } })
            //            .then(function(loc) { deferred.resolve(loc); })
            //            .catch (function (err) { logger.info('GetLocation error: ' + err); deferred.reject(err) });
            //}
            //    else {
            //    logger.info('Inside get all billing');
            //    models.Location.findAll().then(function(locs) {
            //        deferred.resolve(locs);
            //    }).catch (function (err) { logger.info('GetAllLocations error: ' + err); deferred.reject(err) });
            //    }
        }
        catch (Exception e)
        {
        }
    }

    public void GetInactiveUsers()
    {
        try
        {
            //models.User.findAll({ where: { Status: 'Inactive' } }).then(function(users) {
            //    deferred.resolve(users);
            //}).catch (function (err) { logger.info('GetInactiveUsers error: ' + err); deferred.reject(err) });
        }
        catch (Exception)
        {
        }
    }

    public void ADFSUserLogin(string email)
    {
        try
        {

            //var curentdate = moment().format("YYYY-MM-DD HH:mm:ss");
            //var createdDate = moment.utc(curentdate).toDate();
            //createdDate = moment(createdDate).format('YYYY-MM-DD HH:mm:ss');
            //// var dbdate = new Date();
            //// var createdDate = moment(dbdate).format('L LT');

            //models.User.findOne({ where: { EmailId: email } })
            //    .then(function(user) {
            //    if (user != null && user != undefined)
            //    {
            //        if (user.Status != 'Inactive')
            //        {

            //            var expireAt = moment().add(90000, 'seconds').format('L LT');
            //            var token = Utility.UtilityModel.generateToken(user, 90000);
            //            logger.info(token.length);
            //            models.sequelize.transaction().then(function(t) {
            //                if (t != null && t != undefined)
            //                {
            //                    models.UserSession.create({
            //                        SessionTokenId: token, UserId: user.userId, Tokendetail: token,
            //                            CreatedDate: createdDate, ExpiredDate: expireAt, RequestIPAddress: user.requestIPAddress
            //                            }, { transaction: t })
            //                            .then(function(userSession) {
            //                        models.User.update({ LastAuthenticatedDate: createdDate }, { where: { userId: user.userId } }, { transaction: t })
            //                                    .then(function(userupdate) {
            //                            t.commit();
            //                            deferred.resolve({
            //                                token: token, expires: expireAt, user:
            //                                {
            //                                    userId: user.userId,
            //                                                UserName: user.UserName, EmailId: user.EmailId, MobileNumber: user.MobileNumber,
            //                                                CustomData: user.CustomData, Status: user.Status, UserExpiryDate: user.UserExpiryDate,
            //                                                PasswordExpiryDate: user.PasswordExpiryDate, UserBlockDate: user.UserBlockDate,
            //                                                AttemptedTries: user.AttemptedTries, LastUsedDate: user.LastUsedDate,
            //                                                CreatedDate: user.CreatedDate, CreatedBy: user.CreatedBy,
            //                                                ModifiedDate: user.ModifiedDate, ModifiedBy: user.ModifiedBy, ApprovedDate: user.ModifiedBy,
            //                                                Approvedby: user.Approvedby, MakerComment: user.MakerComment,
            //                                                CheckerComment: user.CheckerComment
            //                                                }
            //                            });
            //                        })
            //                                    .catch (function (userupdateerror) {
            //t.rollback();
            //logger.info(userupdateerror);
        }
        catch (Exception)
        {
        }
    }


    #endregion Users


    #region Country

    public void GetCountryList(string TaskTypeId)
    {
        try
        {
            if (TaskTypeId != null && TaskTypeId != "")
            {
                //    models.TaskType.findAll({ where: { TaskTypeId: TaskTypeId} }).then(function(roles){
                //        deferred.resolve(roles);
                //    }).catch (function(err){
                //console.log('Error' + err);
                //deferred.reject(err)
                //     });
            }
            else
            {
                //models.TaskType.findAll().then(function(roles){
                //    deferred.resolve(roles);
                //}).catch (function(err){
                //    console.log('Error' + err);
                //    deferred.reject(err)
                //    });
            }
        }
        catch (Exception e)
        {
        }
    }

    public void AddCountry(string opp)
    {
        try
        {
            //    models.TaskType.findAndCountAll({ where: { TaskName: opp.TaskName} }).then(function(result){
            //        if (result.count > 0)
            //        {
            //            var data = { Error:''};
            //        data.Error = "TaskType already exists";
            //        deferred.reject(data);
            //    }
            //        else{
            //        models.TaskType.create({
            //            TaskName: opp.TaskName
            //            }).then(function(user){
            //            deferred.resolve(user);
            //        }).catch (function(err){
            //    console.log('AddTaskType' + err);
            //    deferred.reject(err);
            //});
        }

        catch (Exception e)
        {
        }
    }

    public void ModifyCountry(string Opp)
    {
        try
        {
            //models.TaskType.update({ TaskName: Opp.TaskName},{ where: { TaskTypeId: Opp.TaskTypeId} }).then(function(user){
            //    console.log('Update success TaskTypeList')
            //        deferred.resolve(user);

            //}).catch (function(err){
            //console.log('Modify TaskType' + err);
            //deferred.reject(err);
            //});
        }
        catch (Exception e)
        {
        }
    }

    public void DeleteCountry(string TaskTypeId)
    {
        try
        {
            //    console.log("Deleting TaskType");
            //    models.TaskType.destroy({ where: { TaskTypeId: TaskTypeId},truncate: false}).then(function(user){
            //        deferred.resolve(user);
            //        console.log("deleting TaskType success");
            //    }).catch (function(Error){
            //    console.log("Error occured when deleting the tasktype");
            //    deferred.reject(Error);
            //});
        }
        catch (Exception e)
        {
        }
    }

    #endregion Country

}





using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using log4net;
using System.ComponentModel;
using System.Globalization;
using System.Text;
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
                DateTime FromDate = new DateTime();
                DateTime Todate = new DateTime();
                if (objTransferSetting.TransferFrom != "")
                {
                    FromDate = DateTime.ParseExact(objTransferSetting.TransferFrom, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                    Todate = DateTime.ParseExact(objTransferSetting.TransferTo, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                }

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_Owneruser", objTransferSetting.OwnerUser));
                cmd.Parameters.Add(new MySqlParameter("i_TransferTo", objTransferSetting.Transferuser));
                cmd.Parameters.Add(new MySqlParameter("i_DurationFrom", FromDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture)));
                cmd.Parameters.Add(new MySqlParameter("i_DurationTo", Todate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture)));
                if (this.OpenConnection() == true)
                {
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
        string query = "sp_getdelegatesettingbyuser";
        try
        {
            if (this.OpenConnection() == true)
            {

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
                                       TransferTo = Convert.ToString(row["DurationTo"]),
                                       OwnerUser = Convert.ToString(row["Owneruser"]),
                                       Transferuser = Convert.ToString(row["TransferTo"]),
                                       IsActive = Convert.ToString(row["IsActive"]),
                                       Id = Convert.ToString(row["Id"])

                                   }).ToList();

                        }
                    }

                    cmd.ExecuteNonQuery();
                }
                //close connection
                this.CloseConnection();
            }

            return lst;
        }
        catch (Exception e)
        {
            return null;
        }

    }


    public List<StrategyApprover> Get_ApprovaltransferByuser(string userid)
    {
        List<StrategyApprover> lst = new List<StrategyApprover>();

        string query = "Get_ApprovaltransferByuser";

        if (this.OpenConnection() == true)
        {

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
                                   ApprovedDate = Convert.ToString(row["ApprovedDate"]),
                                   OriginalApprover = Convert.ToString(row["OriginalApprover"])
                               }).ToList();

                    }
                }

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
                cmd.Parameters.Add(new MySqlParameter("i_Type", s.Type));

                //cmd.Parameters.Add(new MySqlParameter("i_Approver", s.ApprovedDate));
                if (this.OpenConnection() == true)
                {

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

        if (this.OpenConnection() == true)
        {

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

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return Version;

    }

    //checking waiting request of approval
    public List<StrategyApprover> GetStrategyDelegatesApprovalByuser(string userid)
    {
        List<StrategyApprover> lst = new List<StrategyApprover>();

        string query = "Get_StrategyDelegatesApprovalByuser";

        if (this.OpenConnection() == true)
        {

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
                                   Id = Convert.ToString(row["Id"]),
                                   Approver = Convert.ToString(row["Approver"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Version = Convert.ToString(row["Version"]),
                                   Comments = Convert.ToString(row["Comments"]),
                                   Status = Convert.ToString(row["Status"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   ApprovedDate = Convert.ToString(row["ApprovedDate"]),
                                   OriginalApprover = Convert.ToString(row["OriginalApprover"])
                               }).ToList();

                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public List<StrategyApprover> Get_StrategyApprovalByuser(string userid)
    {
        List<StrategyApprover> lst = new List<StrategyApprover>();

        string query = "Get_StrategyApprovalByUser";

        if (this.OpenConnection() == true)
        {

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
                                   Id = Convert.ToString(row["Id"]),
                                   Approver = Convert.ToString(row["Approver"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Version = Convert.ToString(row["Version"]),
                                   Comments = Convert.ToString(row["Comments"]),
                                   Status = Convert.ToString(row["Status"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   ApprovedDate = Convert.ToString(row["ApprovedDate"]),
                                   Type = Convert.ToString(row["Type"])
                               }).ToList();

                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public List<StrategyApprover> Get_DelegatedApprovalByuser(string userid)
    {
        List<StrategyApprover> lst = new List<StrategyApprover>();

        string query = "Get_DelegateApprovalByUser";

        if (this.OpenConnection() == true)
        {

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
                                   Id = Convert.ToString(row["Id"]),
                                   Approver = Convert.ToString(row["Approver"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Version = Convert.ToString(row["Version"]),
                                   Comments = Convert.ToString(row["Comments"]),
                                   Status = Convert.ToString(row["Status"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   ApprovedDate = Convert.ToString(row["ApprovedDate"])

                               }).ToList();

                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    //selected user for particular strategy
    public List<StrategyApprover> Get_StrategyApprovalById(string StrategyNumber, string Version)
    {
        List<StrategyApprover> lst = new List<StrategyApprover>();

        string query = "Get_StrategyApprovalById";

        if (this.OpenConnection() == true)
        {

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

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;

    }

    public void updatedelegateAcceptance(StrategyApprover s, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_update_delegate_Acceptance", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", s.Id));
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", s.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Version", s.Version));
                cmd.Parameters.Add(new MySqlParameter("i_Approver", s.Approver));
                cmd.Parameters.Add(new MySqlParameter("i_Status", s.Status));
                if (this.OpenConnection() == true)
                {
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

    public List<Strategy> GetStrategyData()
    {
        List<Strategy> lst = new List<Strategy>();

        string query = "select S.Id,S.RefNumber,FTAApplicationCodeId,FTAAC.FTAApplicationCode,FTAShortCodeId,FTAStrategyCodeId,FTASC.FTAStrategyCode,DiscretionaryCodeId,DM.Discretionarycode,BusinessSuffixId,BSFM.BusinessSuffix,FTAStrategyCode,S.ParentId,PM.ParentId as ParentIdValue,S.ChildId,cM.ChildID as ChildIdValue,BusinessLineId,BSL.BusinessLine,RegionId,R.RegionName,CountryId,C.CountryName,FTAApplicationNameId,APN.FTAApplicationName,FTAApplicationOwnerId,ApplicationCategoryId,ACM.ApplicationCategory,StrategyTypeId,STM.StrategyType,VenueTypeId,VTM.VenueType,CapacityId,CPM.Capacity,CreatedBy,CreatedDate,Description,S.IsActive,LastModifiedBy,LastModifiedDate,NoOfApprover,Version,FTAStrategyNameId,FTASN.FTAStrategyName,S.FTAStrategyOwnerId,S.Priority,S.PriorityScore, SignOff,SignOffDate,SignoffBy,LastModifiedDate ,LastModifiedBy,ThirdPartyAppId,TM.ThirdPartyAppName,BusinessId,BM.business,FTAApplicationMappingId,FTAStrategyMappingId,BusinessMappingId,DATE_FORMAT(S.DecomissionedDate, '%m/%d/%Y') DecomissionedDate,DATE_FORMAT(S.GoLiveDate, '%m/%d/%Y') GoLiveDate from tbl_strategy S join tbl_ftaapplicationcode_master FTAAC On S.FTAApplicationCodeId = FTAAC.Id join tbl_ftastrategycode_master FTASC on S.FTAStrategyCodeId = FTASC.Id JOin tbl_discretionarycode_master DM on s.DiscretionaryCodeId = DM.Id JOin tbl_businesssuffix_master BSFM on s.BusinessSuffixId = BSFM.Id JOIN tbl_parentid_master PM on s.ParentId = PM.Id join tbl_childid_master CM on S.ChildId = CM.Id JOIn tbl_businessline_master BSL on BusinessLineId = BSL.Id  JOIN tbl_region_master R on S.RegionId = R.id JOIN tbl_country_master C on S.CountryId = C.id JOIN tbl_ftaapplicationname_master APN on S.FTAApplicationNameId = APN.Id JOIN tbl_applicationcategory_master ACM on S.ApplicationCategoryId = ACM.Id JOIN tbl_ftastrategyname_master FTASN on S.FTAStrategyNameId = FTASN.Id JOIN tbl_strategytype_master STM on S.StrategyTypeId = STM.Id JOIN tbl_venuetype_master VTM on S.VenueTypeId = VTM.Id JOIN tbl_thirdpartyapplication TM on S.ThirdPartyAppId = TM.Id JOIN tbl_business_master BM on S.BusinessId = BM.Id JOIN tbl_capacity_master CPM on S.CapacityId = CPM.Id right JOIN (SELECT  MAX(Id) as Id FROM tbl_strategy GROUP BY REfnumber) t2  ON S.ID = t2.Id";
        try
        {
            if (this.OpenConnection() == true)
            {

                using (MySqlCommand cmd = new MySqlCommand(query, connection))
                {
                    cmd.CommandType = CommandType.TableDirect;
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
                                       RefNumber = Convert.ToString(row["RefNumber"]),
                                       FTAShortCode = Convert.ToString(row["FTAShortCodeId"]),
                                       FTAApplicationCodeId = Convert.ToInt32(row["FTAApplicationCodeId"]),
                                       FTAApplicationCode = Convert.ToString(row["FTAApplicationCode"]),
                                       FTAStrategyCodeId = Convert.ToInt32(row["FTAStrategyCodeId"]),
                                       FTAStrategyCode = Convert.ToString(row["FTAStrategyCode"]),
                                       DiscretionaryCodeId = Convert.ToInt32(row["DiscretionaryCodeId"]),
                                       DiscretionaryCode = Convert.ToString(row["Discretionarycode"]),
                                       BusinessSuffixId = Convert.ToInt32(row["BusinessSuffixId"]),
                                       BusinessSuffix = Convert.ToString(row["BusinessSuffix"]),
                                       ParentID = Convert.ToString(row["ParentId"]),
                                       ParentIDValue = Convert.ToInt32(row["ParentIdValue"]),
                                       ChildID = Convert.ToString(row["ChildId"]),
                                       ChildIDValue = Convert.ToInt32(row["ChildIdValue"]),
                                       BusinessLineId = Convert.ToInt32(row["BusinessLineId"]),
                                       BusinessLine = Convert.ToString(row["BusinessLine"]),
                                       FTAApplicationNameId = Convert.ToInt32(row["FTAApplicationNameId"]),
                                       FTAApplicationName = Convert.ToString(row["FTAApplicationName"]),
                                       FTAApplicationOwnerId = Convert.ToString(row["FTAApplicationOwnerId"]),
                                       FTAApplicationOwner = Convert.ToString(row["FTAApplicationOwnerId"]),
                                       ApplicationCategoryId = Convert.ToInt32(row["ApplicationCategoryId"]),
                                       ApplicationCategory = Convert.ToString(row["ApplicationCategory"]),
                                       FTAStrategyOwnerId = Convert.ToString(row["FTAStrategyOwnerId"]),
                                       FTAStrategyOwner = Convert.ToString(row["FTAStrategyOwnerId"]),
                                       FTAStrategyNameId = Convert.ToInt32(row["FTAStrategyNameId"]),
                                       FTAStrategyName = Convert.ToString(row["FTAStrategyName"]),
                                       StrategytypeId = Convert.ToInt32(row["StrategyTypeId"]),
                                       Strategytype = Convert.ToString(row["StrategyType"]),
                                       VenueTypeId = Convert.ToInt32(row["VenueTypeId"]),
                                       VenueType = Convert.ToString(row["VenueType"]),
                                       Capacity = Convert.ToString(row["Capacity"]),
                                       CapacityId = Convert.ToInt32(row["CapacityId"]),
                                       Country = Convert.ToString(row["CountryId"]),
                                       CountryName = Convert.ToString(row["CountryName"]),
                                       CreatedBy = Convert.ToString(row["CreatedBy"]),
                                       CreatedDate = Convert.ToString(row["CreatedDate"]),
                                       Description = Convert.ToString(row["Description"]),
                                       SignOff = Convert.ToString(row["SignOff"]),
                                       IsActive = Convert.ToString(row["IsActive"]),
                                       LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                       LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                       NoOfApprover = Convert.ToString(row["NoOfApprover"]),
                                       Region = Convert.ToString(row["RegionId"]),
                                       RegionName = Convert.ToString(row["RegionName"]),
                                       Version = Convert.ToInt32(row["Version"]),
                                       Priority = Convert.ToString(row["Priority"]),
                                       PriorityScore = Convert.ToString(row["PriorityScore"]),
                                       DecomissionedDate = Convert.ToString(row["DecomissionedDate"]),
                                       GOLiveDate = Convert.ToString(row["GoLiveDate"]),
                                       BusinessId = Convert.ToInt32(row["BusinessId"]),
                                       Business = Convert.ToString(row["business"]),
                                       FTAApplicationMappingId = Convert.ToString(row["FTAApplicationMappingId"]),
                                       FTAStrategyMappingId = Convert.ToString(row["FTAStrategyMappingId"]),
                                       BusinessMappingId = Convert.ToString(row["BusinessMappingId"]),
                                       ThirdPartyAppId = Convert.ToInt32(row["ThirdPartyAppId"]),
                                       ThirdPartyValue = Convert.ToString(row["ThirdPartyAppName"]),


                                   }).ToList();
                        }
                    }

                }
                //close connection
                this.CloseConnection();
            }

            return lst;
        }
        catch (MySqlException ex)
        {
            log.ErrorFormat("Exception Occured :{0}", ex.ToString());
            log.ErrorFormat("Exception Trace Message :{0}", ex.StackTrace);
            this.CloseConnection();
            return null;
        }
        catch (Exception ex)
        {
            log.ErrorFormat("Exception Occured :{0}", ex.ToString());
            log.ErrorFormat("Exception Trace Message :{0}", ex.StackTrace);
            this.CloseConnection();
            return null;
        }
    }

    public List<Strategy> GetStrategyDatabyId(string StrategyNumber)
    {
        List<Strategy> lst = new List<Strategy>();
        try
        {
            string query = "SP_GetStrategyById";

            if (this.OpenConnection() == true)
            {
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
                                       RefNumber = Convert.ToString(row["RefNumber"]),
                                       FTAShortCode = Convert.ToString(row["FTAShortCodeId"]),
                                       FTAApplicationCodeId = Convert.ToInt32(row["FTAApplicationCodeId"]),
                                       FTAApplicationCode = Convert.ToString(row["FTAApplicationCode"]),
                                       FTAStrategyCodeId = Convert.ToInt32(row["FTAStrategyCodeId"]),
                                       FTAStrategyCode = Convert.ToString(row["FTAStrategyCode"]),
                                       DiscretionaryCodeId = Convert.ToInt32(row["DiscretionaryCodeId"]),
                                       DiscretionaryCode = Convert.ToString(row["Discretionarycode"]),
                                       BusinessSuffixId = Convert.ToInt32(row["BusinessSuffixId"]),
                                       BusinessSuffix = Convert.ToString(row["BusinessSuffix"]),
                                       ParentID = Convert.ToString(row["ParentId"]),
                                       ParentIDValue = Convert.ToInt32(row["ParentIdValue"]),
                                       ChildID = Convert.ToString(row["ChildId"]),
                                       ChildIDValue = Convert.ToInt32(row["ChildIdValue"]),
                                       BusinessLineId = Convert.ToInt32(row["BusinessLineId"]),
                                       BusinessLine = Convert.ToString(row["BusinessLine"]),
                                       FTAApplicationNameId = Convert.ToInt32(row["FTAApplicationNameId"]),
                                       FTAApplicationName = Convert.ToString(row["FTAApplicationName"]),
                                       FTAApplicationOwnerId = Convert.ToString(row["FTAApplicationOwnerId"]),
                                       FTAApplicationOwner = Convert.ToString(row["FTAApplicationOwnerId"]),
                                       ApplicationCategoryId = Convert.ToInt32(row["ApplicationCategoryId"]),
                                       ApplicationCategory = Convert.ToString(row["ApplicationCategory"]),
                                       FTAStrategyOwnerId = Convert.ToString(row["FTAStrategyOwnerId"]),
                                       FTAStrategyOwner = Convert.ToString(row["FTAStrategyOwnerId"]),
                                       FTAStrategyNameId = Convert.ToInt32(row["FTAStrategyNameId"]),
                                       FTAStrategyName = Convert.ToString(row["FTAStrategyName"]),
                                       StrategytypeId = Convert.ToInt32(row["StrategyTypeId"]),
                                       Strategytype = Convert.ToString(row["StrategyType"]),
                                       VenueTypeId = Convert.ToInt32(row["VenueTypeId"]),
                                       VenueType = Convert.ToString(row["VenueType"]),
                                       Capacity = Convert.ToString(row["Capacity"]),
                                       CapacityId = Convert.ToInt32(row["CapacityId"]),
                                       Country = Convert.ToString(row["CountryId"]),
                                       CountryName = Convert.ToString(row["CountryName"]),
                                       CreatedBy = Convert.ToString(row["CreatedBy"]),
                                       CreatedDate = Convert.ToString(row["CreatedDate"]),
                                       Description = Convert.ToString(row["Description"]),
                                       SignOff = Convert.ToString(row["SignOff"]),
                                       IsActive = Convert.ToString(row["IsActive"]),
                                       LastModifiedBy = Convert.ToString(row["LastModifiedBy"]),
                                       LastModifiedDate = Convert.ToString(row["LastModifiedDate"]),
                                       NoOfApprover = Convert.ToString(row["NoOfApprover"]),
                                       Region = Convert.ToString(row["RegionId"]),
                                       RegionName = Convert.ToString(row["RegionName"]),
                                       Version = Convert.ToInt32(row["Version"]),
                                       Priority = Convert.ToString(row["Priority"]),
                                       PriorityScore = Convert.ToString(row["PriorityScore"]),
                                       DecomissionedDate = Convert.ToString(row["DecomissionedDate1"]),
                                       GOLiveDate = Convert.ToString(row["GoLiveDate1"]),
                                       BusinessId = Convert.ToInt32(row["BusinessId"]),
                                       Business = Convert.ToString(row["business"]),
                                       FTAApplicationMappingId = Convert.ToString(row["FTAApplicationMappingId"]),
                                       FTAStrategyMappingId = Convert.ToString(row["FTAStrategyMappingId"]),
                                       BusinessMappingId = Convert.ToString(row["BusinessMappingId"]),
                                       ThirdPartyAppId = Convert.ToInt32(row["ThirdPartyAppId"]),
                                       ThirdPartyValue = Convert.ToString(row["ThirdPartyAppName"]),
                                   }).ToList();
                        }
                    }

                    cmd.ExecuteNonQuery();
                }
                //close connection
                this.CloseConnection();
            }

            return lst;
        }
        catch (MySqlException ex)
        {
            log.ErrorFormat("Exception Occured :{0}", ex.ToString());
            log.ErrorFormat("Exception Trace Message :{0}", ex.StackTrace);
            this.CloseConnection();
            return null;
        }
        catch (Exception ex)
        {
            log.ErrorFormat("Exception Occured :{0}", ex.ToString());
            log.ErrorFormat("Exception Trace Message :{0}", ex.StackTrace);
            this.CloseConnection();
            return null;
        }
    }

    public void InsertStrategydata(Strategy _StrategyInfo, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";

            DateTime GOLiveDate = DateTime.ParseExact(_StrategyInfo.GOLiveDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            DateTime DecomissionedDate = DateTime.ParseExact(_StrategyInfo.DecomissionedDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);


            using (MySqlCommand cmd = new MySqlCommand("sp_insert_Strategy", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", _StrategyInfo.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_CountryId", _StrategyInfo.Country));
                cmd.Parameters.Add(new MySqlParameter("i_RegionId", _StrategyInfo.Region));
                cmd.Parameters.Add(new MySqlParameter("i_Description", _StrategyInfo.Description));
                cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationCodeId", _StrategyInfo.FTAApplicationCodeId));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessSuffixId", _StrategyInfo.BusinessSuffixId));
                cmd.Parameters.Add(new MySqlParameter("i_ChildID", _StrategyInfo.ChildID));
                cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyNameId", _StrategyInfo.FTAStrategyNameId));
                cmd.Parameters.Add(new MySqlParameter("i_StrategytypeId", _StrategyInfo.StrategytypeId));
                cmd.Parameters.Add(new MySqlParameter("i_GOLiveDate", GOLiveDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture)));
                cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyCodeId", _StrategyInfo.FTAStrategyCodeId));
                cmd.Parameters.Add(new MySqlParameter("i_FTAShortCode", _StrategyInfo.FTAShortCode));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessLineId", _StrategyInfo.BusinessLineId));
                cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationNameId", _StrategyInfo.FTAApplicationNameId));
                cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyOwnerId", _StrategyInfo.FTAStrategyOwnerId));
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationCategoryId", _StrategyInfo.ApplicationCategoryId));
                cmd.Parameters.Add(new MySqlParameter("i_DecommissionedDate", DecomissionedDate.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture)));
                cmd.Parameters.Add(new MySqlParameter("i_DiscretionaryCodeId", _StrategyInfo.DiscretionaryCodeId));
                cmd.Parameters.Add(new MySqlParameter("i_ParentID", _StrategyInfo.ParentID));
                cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationOwnerId", _StrategyInfo.FTAApplicationOwnerId));
                cmd.Parameters.Add(new MySqlParameter("i_PriorityScore", _StrategyInfo.PriorityScore));
                cmd.Parameters.Add(new MySqlParameter("i_Priority", _StrategyInfo.Priority));
                cmd.Parameters.Add(new MySqlParameter("i_CapacityId", _StrategyInfo.CapacityId));
                cmd.Parameters.Add(new MySqlParameter("i_VenueTypeId", _StrategyInfo.VenueTypeId));
                cmd.Parameters.Add(new MySqlParameter("i_Version", _StrategyInfo.Version));
                cmd.Parameters.Add(new MySqlParameter("i_SignOff", _StrategyInfo.SignOff));

                cmd.Parameters.Add(new MySqlParameter("i_ThirdPartyAppId", _StrategyInfo.ThirdPartyAppId));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessId", _StrategyInfo.BusinessId));
                cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationMappingId", _StrategyInfo.FTAApplicationMappingId));
                cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyMappingId", _StrategyInfo.FTAStrategyMappingId));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessMappingId", _StrategyInfo.BusinessMappingId));

                cmd.Parameters.Add(new MySqlParameter("i_OutParam", MySqlDbType.String));
                cmd.Parameters["i_OutParam"].Direction = ParameterDirection.Output;
                if (this.OpenConnection() == true)
                {
                    cmd.ExecuteNonQuery();
                    errordesc = Convert.ToString(cmd.Parameters["i_OutParam"].Value);
                    this.CloseConnection();
                }
                //if (errordesc == "success")
                //    errordesc = "success-" + _StrategyInfo.RefNumber + "|" + _StrategyInfo.Version;
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
    public void insertStrategyVersionChange(string RefNumber, int Version, string Changedesc)
    {
        try
        {

            using (MySqlCommand cmd = new MySqlCommand("sp_insert_strategyVersionLog", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Version", Version));
                cmd.Parameters.Add(new MySqlParameter("i_ChangeDesc", Changedesc));


                if (this.OpenConnection() == true)
                {

                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //close connection
            }
        }
        catch (MySqlException e)
        {
            this.CloseConnection();

        }
        catch (Exception e)
        {
            this.CloseConnection();

        }
    }


    public List<StrategyVersionLog> GetStrategyVersionLog(string id)
    {
        List<StrategyVersionLog> lst = new List<StrategyVersionLog>();

        string query = "sp_get_strategyVersionLog";
        try
        {
            if (this.OpenConnection() == true)
            {

                using (MySqlCommand cmd = new MySqlCommand(query, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new MySqlParameter("i_Id", id));
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        IEnumerable<DataRow> sequence = dt.AsEnumerable();
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            lst = (from DataRow row in dt.Rows

                                   select new StrategyVersionLog
                                   {
                                       Id = Convert.ToInt32(row["Id"]),
                                       RefNumber = Convert.ToString(row["RefNumber"]),
                                       ChangeDesc = Convert.ToString(row["ChangeDesc"]),
                                       FTAShortCode = Convert.ToString(row["FTAShortCode"]),
                                       Version = Convert.ToString(row["Version"]),
                                       CreatedDateTime= Convert.ToString(row["CreatedDate"])
                                   }).ToList();
                        }
                    }

                }
                //close connection
                this.CloseConnection();
            }

            return lst;
        }
        catch (MySqlException ex)
        {
            log.ErrorFormat("Exception Occured :{0}", ex.ToString());
            log.ErrorFormat("Exception Trace Message :{0}", ex.StackTrace);
            this.CloseConnection();
            return null;
        }
        catch (Exception ex)
        {
            log.ErrorFormat("Exception Occured :{0}", ex.ToString());
            log.ErrorFormat("Exception Trace Message :{0}", ex.StackTrace);
            this.CloseConnection();
            return null;
        }
    }

   
    #endregion Strategy


    #region Role

    #endregion Role

    #region User    

    #endregion User    

    public void AddRightsForRoles(string roleName, string menuRights, out int errorCode, out string errorDesc)
    {

        errorDesc = "";
        errorCode = 0;
        string query = "INSERT INTO tableinfo (name, age) VALUES('John Smith', '33')";


        if (this.OpenConnection() == true)
        {

            MySqlCommand cmd = new MySqlCommand(query, connection);


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

    public List<Roles> GetRoles(string roleId)
    {
        List<Roles> lst = new List<Roles>();
        string query = "Sp_GetRoles";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_roleId", roleId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new Roles
                               {
                                   CreatedBy = Convert.ToString(row["CreatedBy"]),
                                   id = Convert.ToString(row["id"]),
                                   ModifiedBy = Convert.ToString(row["ModifiedBy"]),
                                   CreatedDate = Convert.ToString(row["CreatedDate"]),
                                   ModifiedDate = Convert.ToString(row["ModifiedDate"]),
                                   RoleName = Convert.ToString(row["RoleName"])
                               }).ToList();

                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }
    public void GetUserRoles(string roleId)
    {

        try
        {
            List<Roles> lst = new List<Roles>();
            string query = "Sp_GetRoles";

            if (this.OpenConnection() == true)
            {

                using (MySqlCommand cmd = new MySqlCommand(query, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new MySqlParameter("i_roleId", roleId));
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        IEnumerable<DataRow> sequence = dt.AsEnumerable();
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            lst = (from DataRow row in dt.Rows
                                   select new Roles
                                   {
                                       CreatedBy = Convert.ToString(row["CreatedBy"]),
                                       id = Convert.ToString(row["id"]),
                                       ModifiedBy = Convert.ToString(row["ModifiedBy"]),
                                       CreatedDate = Convert.ToString(row["CreatedDate"]),
                                       ModifiedDate = Convert.ToString(row["ModifiedDate"]),
                                       RoleName = Convert.ToString(row["RoleName"])
                                   }).ToList();

                        }
                    }

                    cmd.ExecuteNonQuery();
                }
                //close connection
                this.CloseConnection();
            }

            //return lst;
            //models.User.findAll({ where: { RoleId: roleId } })
            //   .then(function(userroles) { deferred.resolve(userroles); })
            //   .catch (function (err) { deferred.reject(err) });
        }
        catch (Exception e)
        {
        }
    }

    public List<RightMaster> GetRights(string roleId)
    {
        List<RightMaster> lst = new List<RightMaster>();
        string query = "Sp_GetRights";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_roleId", roleId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new RightMaster
                               {
                                   Icon = Convert.ToString(row["Icon"]),
                                   MenuName = Convert.ToString(row["MenuName"]),
                                   Path = Convert.ToString(row["Path"]),
                                   RightID = Convert.ToString(row["RightID"]),
                                   RightName = Convert.ToString(row["RightName"]),
                                   ShowMenu = Convert.ToString(row["ShowMenu"])
                               }).ToList();

                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;


    }

    public int AddRole(string role, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_role", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_role", role));

            if (this.OpenConnection() == true)
            {
                cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    //done
    public void ModifyRoleRight(RoleRightMapping roleright)
    {
        try
        {
            using (MySqlCommand cmd = new MySqlCommand("delete_RoleRight", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_roleid", roleright.id));

                if (this.OpenConnection() == true)
                {
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
            }

            using (MySqlCommand cmd = new MySqlCommand("sp_insert_roleright", connection))
            {
                foreach (RightMaster s in roleright.Rights)
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new MySqlParameter("i_RightId", s.RightID));
                    cmd.Parameters.Add(new MySqlParameter("i_RoleId", roleright.id));
                    if (this.OpenConnection() == true)
                    {

                        cmd.ExecuteNonQuery();
                        this.CloseConnection();
                    }
                }
            }
        }
        catch (Exception e)
        {
            this.CloseConnection();
        }
    }

    //done
    public void AddRoleRightMapping(RoleRightMapping roleright, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_roleright", connection))
            {
                foreach (RightMaster s in roleright.Rights)
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new MySqlParameter("i_RightId", s.RightID));
                    cmd.Parameters.Add(new MySqlParameter("i_RoleId", roleright.RoleID));
                    if (this.OpenConnection() == true)
                    {

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

    public void DeleteRole(string roleright)
    {
        try
        {
            using (MySqlCommand cmd = new MySqlCommand("delete_RoleRight", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_roleid", roleright));

                if (this.OpenConnection() == true)
                {
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
            }

            using (MySqlCommand cmd = new MySqlCommand("SP_DeleteRole", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_id", roleright));

                if (this.OpenConnection() == true)
                {
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
            }

        }
        catch (Exception e)
        {
            this.CloseConnection();
        }
    }
    public List<RoleRightMapping> GetRoleRightMapping(string roleId)
    {
        List<RoleRightMapping> lst = new List<RoleRightMapping>();
        try
        {
            string query = "SP_GetRoleRights";
            if (this.OpenConnection() == true)
            {
                using (MySqlCommand cmd = new MySqlCommand(query, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new MySqlParameter("i_roleId", roleId));
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        IEnumerable<DataRow> sequence = dt.AsEnumerable();
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            lst = (from DataRow row in dt.Rows
                                   select new RoleRightMapping
                                   {
                                       RightID = Convert.ToString(row["RightID"]),
                                       RoleID = Convert.ToString(row["RoleID"]),
                                   }).ToList();
                        }
                    }
                    cmd.ExecuteNonQuery();
                }
                this.CloseConnection();
            }

            return lst;
        }
        catch (Exception e)
        {
            return null;
        }
    }

    #endregion Roles


    #region Users


    public void GetAllEmail()
    {
        try
        {

        }
        catch (Exception ex)
        {
        }
    }
    public void GetUserProfile(string userId)
    {
        try
        {
            List<Roles> lst = new List<Roles>();
            string query = "Sp_GetRoles";

            if (this.OpenConnection() == true)
            {

                using (MySqlCommand cmd = new MySqlCommand(query, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    //cmd.Parameters.Add(new MySqlParameter("i_roleId", roleId));
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        IEnumerable<DataRow> sequence = dt.AsEnumerable();
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            lst = (from DataRow row in dt.Rows
                                   select new Roles
                                   {
                                       CreatedBy = Convert.ToString(row["CreatedBy"]),
                                       id = Convert.ToString(row["id"]),
                                       ModifiedBy = Convert.ToString(row["ModifiedBy"]),
                                       CreatedDate = Convert.ToString(row["CreatedDate"]),
                                       ModifiedDate = Convert.ToString(row["ModifiedDate"]),
                                       RoleName = Convert.ToString(row["RoleName"])
                                   }).ToList();

                        }
                    }

                    cmd.ExecuteNonQuery();
                }
                //close connection
                this.CloseConnection();
            }


        }
        catch (Exception e)
        {
        }
    }
    public List<UserMaster> GetUserbyFilter(string RegionId, string BusinessSectorId)
    {

        try
        {
            List<UserMaster> lst = new List<UserMaster>();
            string query = "sp_getusersbycondition";

            if (this.OpenConnection() == true)
            {

                using (MySqlCommand cmd = new MySqlCommand(query, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new MySqlParameter("i_regionId", RegionId));
                    cmd.Parameters.Add(new MySqlParameter("i_businesssectorId", BusinessSectorId));
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        IEnumerable<DataRow> sequence = dt.AsEnumerable();
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            lst = (from DataRow row in dt.Rows
                                   select new UserMaster
                                   {
                                       Id = Convert.ToString(row["Id"]),
                                       userId = Convert.ToString(row["Userid"]),
                                       UserName = Convert.ToString(row["username"]),
                                       EmailId = Convert.ToString(row["EmailId"]),
                                       RoleId = Convert.ToString(row["RoleId"]),
                                       RoleName = Convert.ToString(row["RoleName"]),
                                       RegionName = Convert.ToString(row["RegionName"]),
                                       BusinessSector = Convert.ToString(row["BusinessLine"]),
                                       BusinessSectorId = Convert.ToString(row["BusinessSectorId"]),
                                       RegionId = Convert.ToString(row["RegionId"]),
                                       Status = Convert.ToString(row["Status"]),


                                   }).ToList();

                        }
                    }

                    cmd.ExecuteNonQuery();
                }
                //close connection
                this.CloseConnection();
            }
            return lst;
        }
        catch (Exception e)
        {
            return null;
        }
    }


    public List<UserMaster> GetUser(string userId)
    {
        List<UserMaster> lst = new List<UserMaster>();
        string query = "sp_getusers";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_userId", userId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new UserMaster
                               {
                                   Id = Convert.ToString(row["Id"]),
                                   userId = Convert.ToString(row["Userid"]),
                                   UserName = Convert.ToString(row["username"]),
                                   EmailId = Convert.ToString(row["EmailId"]),
                                   RoleId = Convert.ToString(row["RoleId"]),
                                   RoleName = Convert.ToString(row["RoleName"]),
                                   RegionName = Convert.ToString(row["RegionName"]),
                                   CountryName = Convert.ToString(row["CountryName"]),
                                   BusinessSector = Convert.ToString(row["BusinessLine"]),
                                   BusinessSectorId = Convert.ToString(row["BusinessSectorId"]),
                                   CountryId = Convert.ToString(row["CountryId"]),
                                   RegionId = Convert.ToString(row["RegionId"]),
                                   Status = Convert.ToString(row["Status"]),
                                   Password = Convert.ToString(row["Password"]),
                                   IsADUser = Convert.ToString(row["IsADUser"]),

                               }).ToList();

                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }
        return lst;
    }
    public List<UserMaster> GetUsersByRoles(string Roleid)
    {
        try
        {
            List<UserMaster> lst = new List<UserMaster>();
            string query = "Sp_getRolesbyuserassigned";

            if (this.OpenConnection() == true)
            {

                using (MySqlCommand cmd = new MySqlCommand(query, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new MySqlParameter("i_roleid", Roleid));
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        IEnumerable<DataRow> sequence = dt.AsEnumerable();
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            lst = (from DataRow row in dt.Rows
                                   select new UserMaster
                                   {
                                       userId = Convert.ToString(row["Userid"]),
                                       UserName = Convert.ToString(row["username"]),
                                       EmailId = Convert.ToString(row["EmailId"]),
                                       RoleId = Convert.ToString(row["RoleId"]),
                                       RoleName = Convert.ToString(row["RoleName"]),
                                       RegionName = Convert.ToString(row["RegionName"]),
                                       CountryName = Convert.ToString(row["CountryName"]),
                                       BusinessSector = Convert.ToString(row["BusinessLine"]),
                                       BusinessSectorId = Convert.ToString(row["BusinessSectorId"]),
                                       CountryId = Convert.ToString(row["CountryId"]),
                                       RegionId = Convert.ToString(row["RegionId"]),
                                       Status = Convert.ToString(row["Status"]),


                                   }).ToList();

                        }
                    }

                    cmd.ExecuteNonQuery();
                }
                //close connection
                this.CloseConnection();
            }
            return lst;

        }
        catch (MySqlException e)
        {

            this.CloseConnection();
            return null;
        }
    }
    public void CreateTempUser(UserMaster user, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_adduser", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_userid", user.userId));
                cmd.Parameters.Add(new MySqlParameter("i_username", user.UserName));
                cmd.Parameters.Add(new MySqlParameter("i_password", EncryptLib.EncodePasswordToBase64(user.Password)));
                cmd.Parameters.Add(new MySqlParameter("i_emailid", user.EmailId));
                cmd.Parameters.Add(new MySqlParameter("i_Roleid", user.RoleId));
                cmd.Parameters.Add(new MySqlParameter("i_countryid", user.CountryId));
                cmd.Parameters.Add(new MySqlParameter("i_regionid", user.RegionId));
                cmd.Parameters.Add(new MySqlParameter("i_businesssectorid", user.BusinessSectorId));
                cmd.Parameters.Add(new MySqlParameter("i_IsADUser", "No"));

                if (this.OpenConnection() == true)
                {

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
    public void CreateUser(UserMaster user, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_adduser", connection))
            {

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_userid", user.userId));
                cmd.Parameters.Add(new MySqlParameter("i_username", user.UserName));
                cmd.Parameters.Add(new MySqlParameter("i_emailid", user.EmailId));
                cmd.Parameters.Add(new MySqlParameter("i_Roleid", user.RoleId));
                cmd.Parameters.Add(new MySqlParameter("i_countryid", user.CountryId));
                cmd.Parameters.Add(new MySqlParameter("i_regionid", user.RegionId));
                cmd.Parameters.Add(new MySqlParameter("i_businesssectorid", user.BusinessSectorId));
                cmd.Parameters.Add(new MySqlParameter("i_IsADUser", "Yes"));
                cmd.Parameters.Add(new MySqlParameter("i_password", ""));
                if (this.OpenConnection() == true)
                {

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
    public void ModifyUser(UserMaster user, out int errorcode, out string errordesc)
    {

        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_updateuser", connection))
            {

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_userid", user.userId));
                cmd.Parameters.Add(new MySqlParameter("i_username", user.UserName));
                cmd.Parameters.Add(new MySqlParameter("i_emailid", user.EmailId));
                cmd.Parameters.Add(new MySqlParameter("i_Roleid", user.RoleId));
                cmd.Parameters.Add(new MySqlParameter("i_countryid", user.CountryId));
                cmd.Parameters.Add(new MySqlParameter("i_regionid", user.RegionId));
                cmd.Parameters.Add(new MySqlParameter("i_businesssectorid", user.BusinessSectorId));
                cmd.Parameters.Add(new MySqlParameter("i_status", user.Status));

                if (this.OpenConnection() == true)
                {

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

    public List<RightMaster> GetMenuList(string userId)
    {
        try
        {

            List<RightMaster> lst = new List<RightMaster>();
            string query = "sp_getmenuforuser";

            if (this.OpenConnection() == true)
            {

                using (MySqlCommand cmd = new MySqlCommand(query, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new MySqlParameter("i_userId", userId));
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        IEnumerable<DataRow> sequence = dt.AsEnumerable();
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            lst = (from DataRow row in dt.Rows
                                   select new RightMaster
                                   {
                                       Icon = Convert.ToString(row["Icon"]),
                                       MenuName = Convert.ToString(row["MenuName"]),
                                       Path = Convert.ToString(row["Path"]),
                                       RightID = Convert.ToString(row["RightID"]),
                                       ShowMenu = Convert.ToString(row["ShowMenu"])

                                   }).ToList();

                        }
                    }

                    cmd.ExecuteNonQuery();
                }
                //close connection
                this.CloseConnection();
            }
            return lst;

        }
        catch (Exception e)
        {
            return null;
        }
    }

    public List<RightMaster> GetRightsList(string userId)
    {
        try
        {

            List<RightMaster> lst = new List<RightMaster>();
            string query = "SP_GetRightForUser";

            if (this.OpenConnection() == true)
            {

                using (MySqlCommand cmd = new MySqlCommand(query, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new MySqlParameter("i_userId", userId));
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        IEnumerable<DataRow> sequence = dt.AsEnumerable();
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            lst = (from DataRow row in dt.Rows
                                   select new RightMaster
                                   {
                                       RightName = Convert.ToString(row["RightName"]),
                                       Path = Convert.ToString(row["Path"]),
                                   }).ToList();
                        }
                    }

                    cmd.ExecuteNonQuery();
                }
                //close connection
                this.CloseConnection();
            }
            return lst;

        }
        catch (Exception e)
        {
            return null;
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

    public List<CountryMaster> GetCountryList(string TaskTypeId)
    {
        List<CountryMaster> lst = new List<CountryMaster>();
        string query = "sp_getallcountry";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new CountryMaster
                               {
                                   CountryName = Convert.ToString(row["CountryName"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddCountry(CountryMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_Country", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_CountryName", opp.CountryName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyCountry(CountryMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_countrymaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_CountryName", Opp.CountryName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteCountry(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_country", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion Country


    #region Region

    public List<RegionMaster> GetRegionList(string TaskTypeId)
    {
        List<RegionMaster> lst = new List<RegionMaster>();
        string query = "sp_getallRegion";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new RegionMaster
                               {
                                   RegionName = Convert.ToString(row["RegionName"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddRegion(RegionMaster opp, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_Region", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_RegionName", opp.RegionName));
                if (this.OpenConnection() == true)
                {
                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
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

    public void ModifyRegion(RegionMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_Regionmaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_RegionName", Opp.RegionName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteRegion(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_Region", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion Region


    #region BusinessSector

    public List<BusinessSector> GetBusinessSectorList(string TaskTypeId)
    {
        List<BusinessSector> lst = new List<BusinessSector>();
        string query = "sp_getallBusinessSector";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new BusinessSector
                               {
                                   BusinessSectorName = Convert.ToString(row["Name"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddBusinessSector(BusinessSector opp, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_BusinessSector", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_BusinessSectorName", opp.BusinessSectorName));

                if (this.OpenConnection() == true)
                {
                    // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                    //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
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

    public void ModifyBusinessSector(BusinessSector Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_BusinessSector", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_BusinessSectorName", Opp.BusinessSectorName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteBusinessSector(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_BusinessSector", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion BusinessSector


    #region ProductType

    public List<ProductMaster> GetProductList(string TaskTypeId)
    {
        List<ProductMaster> lst = new List<ProductMaster>();
        string query = "sp_getallProduct";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new ProductMaster
                               {
                                   ProductName = Convert.ToString(row["ProductType"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddProduct(ProductMaster opp, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_Product", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_ProductName", opp.ProductName));

                if (this.OpenConnection() == true)
                {
                    // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                    //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
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

    public void ModifyProduct(ProductMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_Productmaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_ProductName", Opp.ProductName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteProduct(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_Product", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }
    #endregion ProductType


    #region Application


    public List<ApplicationMaster> GetApplicationList(string TaskTypeId)
    {
        List<ApplicationMaster> lst = new List<ApplicationMaster>();
        string query = "sp_getallApplicationMaster";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new ApplicationMaster
                               {
                                   ApplicationName = Convert.ToString(row["ApplicationName"]),
                                   ApplicationId = Convert.ToString(row["ApplicationId"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddApplication(ApplicationMaster opp, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";
            using (MySqlCommand cmd = new MySqlCommand("sp_insert_ApplicationMaster", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationId", opp.ApplicationId));
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationName", opp.ApplicationName));

                if (this.OpenConnection() == true)
                {
                    // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                    //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                }
                //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
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

    public void ModifyApplication(ApplicationMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_Applicationmaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_ApplicationId", Opp.ApplicationId));
            cmd.Parameters.Add(new MySqlParameter("i_ApplicationName", Opp.ApplicationName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteApplication(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_ApplicationMaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }
    #endregion Application

    //new code start here

    #region FTAApplicationCode

    public List<FTAApplicationCodeMaster> GetFTAApplicationCodeList(string TaskTypeId)
    {
        List<FTAApplicationCodeMaster> lst = new List<FTAApplicationCodeMaster>();
        string query = "sp_getallFTAApplicationCode";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAApplicationCodeMaster
                               {
                                   FTAApplicationCode = Convert.ToString(row["FTAApplicationCode"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddFTAApplicationCode(FTAApplicationCodeMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_FTAApplicationCode", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationCode", opp.FTAApplicationCode));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyFTAApplicationCode(FTAApplicationCodeMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_FTAApplicationCodemaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationCode", Opp.FTAApplicationCode));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteFTAApplicationCode(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_FTAApplicationCode", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion FTAApplicationCode

    #region FTAStrategyCode

    public List<FTAStrategyCodeMaster> GetFTAStrategyCodeList(string TaskTypeId)
    {
        List<FTAStrategyCodeMaster> lst = new List<FTAStrategyCodeMaster>();
        string query = "sp_getallFTAStrategyCode";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAStrategyCodeMaster
                               {
                                   FTAStrategyCode = Convert.ToString(row["FTAStrategyCode"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddFTAStrategyCode(FTAStrategyCodeMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_FTAStrategyCode", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyCode", opp.FTAStrategyCode));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyFTAStrategyCode(FTAStrategyCodeMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_FTAStrategyCodemaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyCode", Opp.FTAStrategyCode));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteFTAStrategyCode(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_FTAStrategyCode", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion FTAStrategyCode

    #region DiscretionaryCode

    public List<DiscretionaryCodeMaster> GetDiscretionaryCodeList(string TaskTypeId)
    {
        List<DiscretionaryCodeMaster> lst = new List<DiscretionaryCodeMaster>();
        string query = "sp_getallDiscretionaryCode";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new DiscretionaryCodeMaster
                               {
                                   DiscretionaryCode = Convert.ToString(row["DiscretionaryCode"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddDiscretionaryCode(DiscretionaryCodeMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_DiscretionaryCode", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_DiscretionaryCode", opp.DiscretionaryCode));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyDiscretionaryCode(DiscretionaryCodeMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_DiscretionaryCodemaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_DiscretionaryCode", Opp.DiscretionaryCode));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteDiscretionaryCode(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_DiscretionaryCode", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion DiscretionaryCode

    #region BusinessSuffix

    public List<BusinessSuffixMaster> GetBusinessSuffixList(string TaskTypeId)
    {
        List<BusinessSuffixMaster> lst = new List<BusinessSuffixMaster>();
        string query = "sp_getallBusinessSuffix";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new BusinessSuffixMaster
                               {
                                   BusinessSuffix = Convert.ToString(row["BusinessSuffix"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddBusinessSuffix(BusinessSuffixMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_BusinessSuffix", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_BusinessSuffix", opp.BusinessSuffix));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyBusinessSuffix(BusinessSuffixMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_BusinessSuffixmaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_BusinessSuffix", Opp.BusinessSuffix));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteBusinessSuffix(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_BusinessSuffix", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion BusinessSuffix

    #region Business

    public List<BusinessMaster> GetBusinessList(string TaskTypeId)
    {
        List<BusinessMaster> lst = new List<BusinessMaster>();
        string query = "sp_getallBusiness";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new BusinessMaster
                               {
                                   Business = Convert.ToString(row["Business"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddBusiness(BusinessMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_Business", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_Business", opp.Business));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyBusiness(BusinessMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_Business", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_Business", Opp.Business));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteBusiness(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_Business", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion Business

    #region ParentID

    public List<ParentIDMaster> GetParentIDList(string TaskTypeId)
    {
        List<ParentIDMaster> lst = new List<ParentIDMaster>();
        string query = "sp_getallParentID";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new ParentIDMaster
                               {
                                   ParentID = Convert.ToString(row["ParentID"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddParentID(ParentIDMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_ParentID", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_ParentID", opp.ParentID));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyParentID(ParentIDMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_ParentIDmaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_ParentID", Opp.ParentID));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteParentID(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_ParentID", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion ParentID

    #region ChildID

    public List<ChildIDMaster> GetChildIDList(string TaskTypeId)
    {
        List<ChildIDMaster> lst = new List<ChildIDMaster>();
        string query = "sp_getallChildID";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new ChildIDMaster
                               {
                                   ChildID = Convert.ToString(row["ChildID"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddChildID(ChildIDMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_ChildID", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_ChildID", opp.ChildID));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyChildID(ChildIDMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_ChildIDmaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_ChildID", Opp.ChildID));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteChildID(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_ChildID", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion ChildID

    #region BusinessLine

    public List<BusinessLineMaster> GetBusinessLineList(string TaskTypeId)
    {
        List<BusinessLineMaster> lst = new List<BusinessLineMaster>();
        string query = "sp_getallBusinessLine";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new BusinessLineMaster
                               {
                                   BusinessLine = Convert.ToString(row["BusinessLine"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddBusinessLine(BusinessLineMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_BusinessLine", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_BusinessLine", opp.BusinessLine));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyBusinessLine(BusinessLineMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_BusinessLinemaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_BusinessLine", Opp.BusinessLine));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteBusinessLine(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_BusinessLine", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion BusinessLine

    #region FTAApplicationName

    public List<FTAApplicationNameMaster> GetFTAApplicationNameList(string TaskTypeId)
    {
        List<FTAApplicationNameMaster> lst = new List<FTAApplicationNameMaster>();
        string query = "sp_getallFTAApplicationName";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAApplicationNameMaster
                               {
                                   FTAApplicationName = Convert.ToString(row["FTAApplicationName"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddFTAApplicationName(FTAApplicationNameMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_FTAApplicationName", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationName", opp.FTAApplicationName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyFTAApplicationName(FTAApplicationNameMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_FTAApplicationNamemaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationName", Opp.FTAApplicationName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteFTAApplicationName(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_FTAApplicationName", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion FTAApplicationName

    #region FTAApplicationOwner

    public List<FTAApplicationOwnerMaster> GetFTAApplicationOwnerList(string TaskTypeId)
    {
        List<FTAApplicationOwnerMaster> lst = new List<FTAApplicationOwnerMaster>();
        string query = "sp_getallFTAApplicationOwner";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAApplicationOwnerMaster
                               {
                                   FTAApplicationOwner = Convert.ToString(row["FTAApplicationOwner"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddFTAApplicationOwner(FTAApplicationOwnerMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_FTAApplicationOwner", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationOwner", opp.FTAApplicationOwner));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyFTAApplicationOwner(FTAApplicationOwnerMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_FTAApplicationOwnermaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationOwner", Opp.FTAApplicationOwner));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteFTAApplicationOwner(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_FTAApplicationOwner", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion FTAApplicationOwner

    #region FTAStrategyName

    public List<FTAStrategyNameMaster> GetFTAStrategyNameList(string TaskTypeId)
    {
        List<FTAStrategyNameMaster> lst = new List<FTAStrategyNameMaster>();
        string query = "sp_getallFTAStrategyName";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAStrategyNameMaster
                               {
                                   FTAStrategyName = Convert.ToString(row["FTAStrategyName"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddFTAStrategyName(FTAStrategyNameMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_FTAStrategyName", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyName", opp.FTAStrategyName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyFTAStrategyName(FTAStrategyNameMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_FTAStrategyNamemaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyName", Opp.FTAStrategyName));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteFTAStrategyName(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_FTAStrategyName", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion FTAStrategyName

    #region FTAStrategyOwner

    public List<FTAStrategyOwnerMaster> GetFTAStrategyOwnerList(string TaskTypeId)
    {
        List<FTAStrategyOwnerMaster> lst = new List<FTAStrategyOwnerMaster>();
        string query = "sp_getallFTAStrategyOwner";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAStrategyOwnerMaster
                               {
                                   FTAStrategyOwner = Convert.ToString(row["FTAStrategyOwner"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddFTAStrategyOwner(FTAStrategyOwnerMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_FTAStrategyOwner", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyOwner", opp.FTAStrategyOwner));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyFTAStrategyOwner(FTAStrategyOwnerMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_FTAStrategyOwnermaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyOwner", Opp.FTAStrategyOwner));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteFTAStrategyOwner(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_FTAStrategyOwner", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion FTAStrategyOwner

    #region SystemFlow

    public List<SystemFlowMaster> GetSystemFlowList(string TaskTypeId)
    {
        List<SystemFlowMaster> lst = new List<SystemFlowMaster>();
        string query = "sp_getallSystemFlow";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new SystemFlowMaster
                               {
                                   SystemFlow = Convert.ToString(row["SystemFlow"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddSystemFlow(SystemFlowMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_SystemFlow", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_SystemFlow", opp.SystemFlow));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifySystemFlow(SystemFlowMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_SystemFlowmaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_SystemFlow", Opp.SystemFlow));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteSystemFlow(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_SystemFlow", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion SystemFlow

    #region ApplicationCategory

    public List<ApplicationCategoryMaster> GetApplicationCategoryList(string TaskTypeId)
    {
        List<ApplicationCategoryMaster> lst = new List<ApplicationCategoryMaster>();
        string query = "sp_getallApplicationCategory";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new ApplicationCategoryMaster
                               {
                                   ApplicationCategory = Convert.ToString(row["ApplicationCategory"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddApplicationCategory(ApplicationCategoryMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_ApplicationCategory", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_ApplicationCategory", opp.ApplicationCategory));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyApplicationCategory(ApplicationCategoryMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_ApplicationCategorymaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_ApplicationCategory", Opp.ApplicationCategory));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteApplicationCategory(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_ApplicationCategory", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion ApplicationCategory

    #region Strategytype

    public List<StrategytypeMaster> GetStrategytypeList(string TaskTypeId)
    {
        List<StrategytypeMaster> lst = new List<StrategytypeMaster>();
        string query = "sp_getallStrategytype";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new StrategytypeMaster
                               {
                                   Strategytype = Convert.ToString(row["Strategytype"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddStrategytype(StrategytypeMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_Strategytype", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_Strategytype", opp.Strategytype));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyStrategytype(StrategytypeMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_Strategytypemaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_Strategytype", Opp.Strategytype));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteStrategytype(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_Strategytype", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion Strategytype

    #region Venuetype

    public List<VenuetypeMaster> GetVenuetypeList(string TaskTypeId)
    {
        List<VenuetypeMaster> lst = new List<VenuetypeMaster>();
        string query = "sp_getallVenuetype";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new VenuetypeMaster
                               {
                                   Venuetype = Convert.ToString(row["Venuetype"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddVenuetype(VenuetypeMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_Venuetype", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_Venuetype", opp.Venuetype));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyVenuetype(VenuetypeMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_Venuetypemaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_Venuetype", Opp.Venuetype));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteVenuetype(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_Venuetype", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion Venuetype

    #region Capacity

    public List<CapacityMaster> GetCapacityList(string TaskTypeId)
    {
        List<CapacityMaster> lst = new List<CapacityMaster>();
        string query = "sp_getallCapacity";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new CapacityMaster
                               {
                                   Capacity = Convert.ToString(row["Capacity"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddCapacity(CapacityMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_Capacity", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_Capacity", opp.Capacity));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyCapacity(CapacityMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_Capacitymaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_Capacity", Opp.Capacity));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeleteCapacity(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_Capacity", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion Capacity

    #region PriorityScore

    public List<PriorityScoreMaster> GetPriorityScoreList(string TaskTypeId)
    {
        List<PriorityScoreMaster> lst = new List<PriorityScoreMaster>();
        string query = "sp_getallPriorityScore";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new PriorityScoreMaster
                               {
                                   PriorityScore = Convert.ToString(row["PriorityScore"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddPriorityScore(PriorityScoreMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_insert_PriorityScore", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_PriorityScore", opp.PriorityScore));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void ModifyPriorityScore(PriorityScoreMaster Opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_update_PriorityScoremaster", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
            cmd.Parameters.Add(new MySqlParameter("i_PriorityScore", Opp.PriorityScore));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    public void DeletePriorityScore(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_PriorityScore", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));

            if (this.OpenConnection() == true)
            {
                // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
                //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
            //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
        }

    }

    #endregion PriorityScore


    #region BusinessMapping

    public List<BusinessMappingMaster> GetBusinessMappingList(string TaskTypeId)
    {
        List<BusinessMappingMaster> lst = new List<BusinessMappingMaster>();
        string query = "sp_getbusinessmapping";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new BusinessMappingMaster
                               {
                                   Business = Convert.ToString(row["Business"]),
                                   BusinessId = Convert.ToString(row["BusinessId"]),
                                   BusinessSuffix = Convert.ToString(row["BusinessSuffix"]),
                                   BusinessSuffixId = Convert.ToString(row["BusinessSuffixId"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddBusinessMapping(BusinessMappingMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_addbusinessmapping", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_businesssuffixid", opp.BusinessSuffixId));
            cmd.Parameters.Add(new MySqlParameter("i_businessid", opp.BusinessId));

            cmd.Parameters.Add(new MySqlParameter("i_OutParam", MySqlDbType.String));
            cmd.Parameters["i_OutParam"].Direction = ParameterDirection.Output;
            if (this.OpenConnection() == true)
            {
                cmd.ExecuteNonQuery();
                errordesc = Convert.ToString(cmd.Parameters["i_OutParam"].Value);

                this.CloseConnection();
            }

        }

    }

    //public void ModifyBusinessMapping(BusinessMaster Opp, out int errorcode, out string errordesc)
    //{
    //    errorcode = 0;
    //    errordesc = "success";
    //    using (MySqlCommand cmd = new MySqlCommand("sp_update_Business", connection))
    //    {
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.Clear();
    //        cmd.Parameters.Add(new MySqlParameter("i_id", Opp.Id));
    //        cmd.Parameters.Add(new MySqlParameter("i_Business", Opp.Business));

    //        if (this.OpenConnection() == true)
    //        {
    //            // cmd.Parameters.AddWithValue("param_auto_id", MySqlDbType.Int32);
    //            //   cmd.Parameters["param_auto_id"].Direction = ParameterDirection.Output;

    //            cmd.ExecuteNonQuery();
    //            this.CloseConnection();
    //        }
    //        //    return Convert.ToInt32(cmd.Parameters["param_auto_id"].Value.ToString());
    //    }

    //}

    public void DeleteBusinessMapping(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_BusinessMapping", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));
            cmd.Parameters.Add(new MySqlParameter("i_OutParam", MySqlDbType.String));
            cmd.Parameters["i_OutParam"].Direction = ParameterDirection.Output;
            if (this.OpenConnection() == true)
            {
                cmd.ExecuteNonQuery();
                errordesc = Convert.ToString(cmd.Parameters["i_OutParam"].Value);

                this.CloseConnection();
            }
        }

    }

    #endregion BusinessMapping

    #region FTAApplicationMapping

    public List<FTAApplicationMappingMaster> GetFTAApplicationMappingList(string TaskTypeId)
    {
        List<FTAApplicationMappingMaster> lst = new List<FTAApplicationMappingMaster>();
        string query = "sp_getFTAApplicationMapping";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAApplicationMappingMaster
                               {
                                   ThirdPartyAppId = Convert.ToString(row["ThirdPartyAppId"]),
                                   ThirdPartyAppName = Convert.ToString(row["ThirdPartyAppName"]),
                                   ChildId = Convert.ToString(row["ChildId"]),
                                   ChildIdValue = Convert.ToString(row["ChildIdValue"]),
                                   FTAApplicationCodeId = Convert.ToString(row["FTAApplicationCodeId"]),
                                   FTAApplicationCode = Convert.ToString(row["FTAApplicationCode"]),
                                   FTAApplicationNameId = Convert.ToString(row["FTAApplicationNameId"]),
                                   FTAApplicationName = Convert.ToString(row["FTAApplicationName"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddFTAApplicationMapping(FTAApplicationMappingMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_addFTAApplicationMapping", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationNameId", opp.FTAApplicationNameId));
            cmd.Parameters.Add(new MySqlParameter("i_FTAApplicationCodeId", opp.FTAApplicationCodeId));
            cmd.Parameters.Add(new MySqlParameter("i_ChildId", opp.ChildId));
            cmd.Parameters.Add(new MySqlParameter("i_ThirdPartyAppId", opp.ThirdPartyAppId));
            cmd.Parameters.Add(new MySqlParameter("i_OutParam", MySqlDbType.String));
            cmd.Parameters["i_OutParam"].Direction = ParameterDirection.Output;
            if (this.OpenConnection() == true)
            {
                cmd.ExecuteNonQuery();
                errordesc = Convert.ToString(cmd.Parameters["i_OutParam"].Value);
                this.CloseConnection();
            }
        }

    }



    public void DeleteFTAApplicationMapping(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_deleteFTAApplicationMapping", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));
            cmd.Parameters.Add(new MySqlParameter("i_OutParam", MySqlDbType.String));
            cmd.Parameters["i_OutParam"].Direction = ParameterDirection.Output;
            if (this.OpenConnection() == true)
            {
                cmd.ExecuteNonQuery();
                errordesc = Convert.ToString(cmd.Parameters["i_OutParam"].Value);
                this.CloseConnection();
            }
        }

    }

    #endregion FTAApplicationMapping

    #region FTAStrategyMapping

    public List<FTAStrategyMappingMaster> GetFTAStrategyMappingList(string TaskTypeId)
    {
        List<FTAStrategyMappingMaster> lst = new List<FTAStrategyMappingMaster>();
        string query = "sp_getFTAStrategyMapping";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAStrategyMappingMaster
                               {
                                   FTAStrategyName = Convert.ToString(row["FTAStrategyName"]),
                                   FTAStrategyNameId = Convert.ToString(row["FTAStrategyNameId"]),
                                   FTAStrategyCode = Convert.ToString(row["FTAStrategyCode"]),
                                   FTAStrategyCodeId = Convert.ToString(row["FTAStrategyCodeId"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public void AddFTAStrategyMapping(FTAStrategyMappingMaster opp, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_addFTAStrategyMapping", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyNameId", opp.FTAStrategyNameId));
            cmd.Parameters.Add(new MySqlParameter("i_FTAStrategyCodeId", opp.FTAStrategyCodeId));
            cmd.Parameters.Add(new MySqlParameter("i_OutParam", MySqlDbType.String));
            cmd.Parameters["i_OutParam"].Direction = ParameterDirection.Output;
            if (this.OpenConnection() == true)
            {
                cmd.ExecuteNonQuery();
                errordesc = Convert.ToString(cmd.Parameters["i_OutParam"].Value);
                this.CloseConnection();
            }
        }

    }



    public void DeleteFTAStrategyMapping(string TaskTypeId, out int errorcode, out string errordesc)
    {
        errorcode = 0;
        errordesc = "success";
        using (MySqlCommand cmd = new MySqlCommand("sp_delete_FTAStrategyMapping", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.Add(new MySqlParameter("i_id", TaskTypeId));
            cmd.Parameters.Add(new MySqlParameter("i_OutParam", MySqlDbType.String));
            cmd.Parameters["i_OutParam"].Direction = ParameterDirection.Output;
            if (this.OpenConnection() == true)
            {
                cmd.ExecuteNonQuery();
                errordesc = Convert.ToString(cmd.Parameters["i_OutParam"].Value);
                this.CloseConnection();
            }
        }

    }

    #endregion FTAStrategyMapping




    public List<ThirdPartyApp> GetThirdPartyAppList(string TaskTypeId)
    {
        List<ThirdPartyApp> lst = new List<ThirdPartyApp>();
        string query = "sp_getAllThirdPartyAppType";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", TaskTypeId));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new ThirdPartyApp
                               {
                                   Value = Convert.ToString(row["ThirdPartyAppName"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public List<BusinessMappingMaster> GetBusinessMappingListbyId(string Id)
    {
        List<BusinessMappingMaster> lst = new List<BusinessMappingMaster>();
        string query = "sp_getbusinessmappingbyId";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", Id));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new BusinessMappingMaster
                               {
                                   Business = Convert.ToString(row["Business"]),
                                   BusinessId = Convert.ToString(row["BusinessId"]),
                                   BusinessSuffix = Convert.ToString(row["BusinessSuffix"]),
                                   BusinessSuffixId = Convert.ToString(row["BusinessSuffixId"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public List<FTAApplicationMappingMaster> GetFTAApplicationMappingListbyId(string Id)
    {
        List<FTAApplicationMappingMaster> lst = new List<FTAApplicationMappingMaster>();
        string query = "sp_getFTAApplicationMappingbyId";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", Id));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAApplicationMappingMaster
                               {
                                   ThirdPartyAppId = Convert.ToString(row["ThirdPartyAppId"]),
                                   ThirdPartyAppName = Convert.ToString(row["ThirdPartyAppName"]),
                                   ChildId = Convert.ToString(row["ChildId"]),
                                   ChildIdValue = Convert.ToString(row["ChildIdValue"]),
                                   FTAApplicationCodeId = Convert.ToString(row["FTAApplicationCodeId"]),
                                   FTAApplicationCode = Convert.ToString(row["FTAApplicationCode"]),
                                   FTAApplicationNameId = Convert.ToString(row["FTAApplicationNameId"]),
                                   FTAApplicationName = Convert.ToString(row["FTAApplicationName"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

    public List<FTAStrategyMappingMaster> GetFTAStrategyMappingListbyId(string Id)
    {
        List<FTAStrategyMappingMaster> lst = new List<FTAStrategyMappingMaster>();
        string query = "sp_getFTAStrategyMappingbyId";

        if (this.OpenConnection() == true)
        {

            using (MySqlCommand cmd = new MySqlCommand(query, connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_Id", Id));
                using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    IEnumerable<DataRow> sequence = dt.AsEnumerable();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        lst = (from DataRow row in dt.Rows
                               select new FTAStrategyMappingMaster
                               {
                                   FTAStrategyName = Convert.ToString(row["FTAStrategyName"]),
                                   FTAStrategyNameId = Convert.ToString(row["FTAStrategyNameId"]),
                                   FTAStrategyCode = Convert.ToString(row["FTAStrategyCode"]),
                                   FTAStrategyCodeId = Convert.ToString(row["FTAStrategyCodeId"]),
                                   Id = Convert.ToString(row["Id"]),
                               }).ToList();
                    }
                }

                cmd.ExecuteNonQuery();
            }
            //close connection
            this.CloseConnection();
        }

        return lst;
    }

}





public static class EncryptLib
{

    public static string EncodePasswordToBase64(string password)
    {
        try
        {
            byte[] encData_byte = new byte[password.Length];
            encData_byte = System.Text.Encoding.UTF8.GetBytes(password);
            string encodedData = Convert.ToBase64String(encData_byte);
            return encodedData;
        }
        catch (Exception ex)
        {
            throw new Exception("Error in base64Encode" + ex.Message);
        }
    } //this function Convert to Decord your Password
    public static string DecodeFrom64(string encodedData)
    {
        System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
        System.Text.Decoder utf8Decode = encoder.GetDecoder();
        byte[] todecode_byte = Convert.FromBase64String(encodedData);
        int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
        char[] decoded_char = new char[charCount];
        utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
        string result = new String(decoded_char);
        return result;
    }
}
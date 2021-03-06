﻿using System;
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
public class DbOperations
{

    #region Private Variable Declaration
    private MySqlConnection connection;
    private static readonly log4net.ILog log = LogManager.GetLogger(typeof(DbOperations));
    private string connString = string.Empty;
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
        string query = "sp_gettransfersettingbyuser";

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
            }

            this.CloseConnection();
        }
        return lst;
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
            }
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
            }

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
            }

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
            }

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
            }
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
            }

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

        string query = "SP_GetStrategy";

        if (this.OpenConnection() == true)
        {

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
                                   AppId = Convert.ToString(row["AppId"]),
                                   AppName = Convert.ToString(row["ApplicationName"]),
                                   Attribute1 = Convert.ToString(row["Attribute1"]),
                                   Attribute2 = Convert.ToString(row["Attribute2"]),
                                   Attribute3 = Convert.ToString(row["Attribute3"]),
                                   Attribute4 = Convert.ToString(row["Attribute4"]),
                                   BusinessImpact = Convert.ToString(row["BusinessImpact"]),
                                   BusinessSector = Convert.ToString(row["BusinessSector"]),
                                   BusinessSectorName = Convert.ToString(row["BusinessSectorName"]),
                                   ChangesBusinessImpact = Convert.ToString(row["ChangesBusinessImpact"]),
                                   ChangesCompletionStatus = Convert.ToString(row["ChangesCompletionStatus"]),
                                   Country = Convert.ToString(row["Country"]),
                                   CountryName = Convert.ToString(row["CountryName"]),
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
                                   ProductTypeName = Convert.ToString(row["ProductTypeName"]),
                                   Ranking = Convert.ToString(row["Ranking"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Region = Convert.ToString(row["Region"]),
                                   RegionName = Convert.ToString(row["RegionName"]),
                                   RiskRating = Convert.ToString(row["RiskRating"]),
                                   SupportingDocument = Convert.ToString(row["SupportingDocument"]),
                                   Type = Convert.ToString(row["Type"]),
                                   Version = Convert.ToString(row["Version"]),
                               }).ToList();

                    }
                }
            }
            this.CloseConnection();
        }

        return lst;

    }

    public List<Strategy> GetStrategyDatabyStrategyId(string StrategyNumber)
    {
        List<Strategy> lst = new List<Strategy>();

        string query = "SP_GetStrategyByRefnumber";

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
                                   AppId = Convert.ToString(row["AppId"]),
                                   AppName = Convert.ToString(row["ApplicationName"]),
                                   Attribute1 = Convert.ToString(row["Attribute1"]),
                                   Attribute2 = Convert.ToString(row["Attribute2"]),
                                   Attribute3 = Convert.ToString(row["Attribute3"]),
                                   Attribute4 = Convert.ToString(row["Attribute4"]),
                                   BusinessImpact = Convert.ToString(row["BusinessImpact"]),
                                   BusinessSector = Convert.ToString(row["BusinessSector"]),
                                   BusinessSectorName = Convert.ToString(row["BusinessSectorName"]),
                                   ChangesBusinessImpact = Convert.ToString(row["ChangesBusinessImpact"]),
                                   ChangesCompletionStatus = Convert.ToString(row["ChangesCompletionStatus"]),
                                   Country = Convert.ToString(row["Country"]),
                                   CountryName = Convert.ToString(row["CountryName"]),
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
                                   ProductTypeName = Convert.ToString(row["ProductTypeName"]),
                                   Ranking = Convert.ToString(row["Ranking"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Region = Convert.ToString(row["Region"]),
                                   RegionName = Convert.ToString(row["RegionName"]),
                                   RiskRating = Convert.ToString(row["RiskRating"]),
                                   SupportingDocument = Convert.ToString(row["SupportingDocument"]),
                                   Type = Convert.ToString(row["Type"]),
                                   Version = Convert.ToString(row["Version"]),
                               }).ToList();
                    }
                }
            }

            this.CloseConnection();
        }

        return lst;

    }

    public List<Strategy> GetStrategyDatabyId(string StrategyNumber)
    {
        List<Strategy> lst = new List<Strategy>();

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
                                   AppId = Convert.ToString(row["AppId"]),
                                   AppName = Convert.ToString(row["ApplicationName"]),
                                   Attribute1 = Convert.ToString(row["Attribute1"]),
                                   Attribute2 = Convert.ToString(row["Attribute2"]),
                                   Attribute3 = Convert.ToString(row["Attribute3"]),
                                   Attribute4 = Convert.ToString(row["Attribute4"]),
                                   BusinessImpact = Convert.ToString(row["BusinessImpact"]),
                                   BusinessSector = Convert.ToString(row["BusinessSector"]),
                                   BusinessSectorName = Convert.ToString(row["BusinessSectorName"]),
                                   ChangesBusinessImpact = Convert.ToString(row["ChangesBusinessImpact"]),
                                   ChangesCompletionStatus = Convert.ToString(row["ChangesCompletionStatus"]),
                                   Country = Convert.ToString(row["Country"]),
                                   CountryName = Convert.ToString(row["CountryName"]),
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
                                   ProductTypeName = Convert.ToString(row["ProductTypeName"]),
                                   Ranking = Convert.ToString(row["Ranking"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Region = Convert.ToString(row["Region"]),
                                   RegionName = Convert.ToString(row["RegionName"]),
                                   RiskRating = Convert.ToString(row["RiskRating"]),
                                   SupportingDocument = Convert.ToString(row["SupportingDocument"]),
                                   Type = Convert.ToString(row["Type"]),
                                   Version = Convert.ToString(row["Version"]),
                               }).ToList();
                    }
                }
            }

            this.CloseConnection();
        }

        return lst;

    }

    public List<Strategy> GetStrategyLatestDatabyId(string StrategyNumber)
    {
        List<Strategy> lst = new List<Strategy>();

        string query = "SP_GetStrategyById";

        if (this.OpenConnection() == true)
        {

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
                                   AppId = Convert.ToString(row["AppId"]),
                                   AppName = Convert.ToString(row["ApplicationName"]),
                                   Attribute1 = Convert.ToString(row["Attribute1"]),
                                   Attribute2 = Convert.ToString(row["Attribute2"]),
                                   Attribute3 = Convert.ToString(row["Attribute3"]),
                                   Attribute4 = Convert.ToString(row["Attribute4"]),
                                   BusinessImpact = Convert.ToString(row["BusinessImpact"]),
                                   BusinessSector = Convert.ToString(row["BusinessSector"]),
                                   BusinessSectorName = Convert.ToString(row["BusinessSectorName"]),
                                   ChangesBusinessImpact = Convert.ToString(row["ChangesBusinessImpact"]),
                                   ChangesCompletionStatus = Convert.ToString(row["ChangesCompletionStatus"]),
                                   Country = Convert.ToString(row["Country"]),
                                   CountryName = Convert.ToString(row["CountryName"]),
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
                                   ProductTypeName = Convert.ToString(row["ProductTypeName"]),
                                   Ranking = Convert.ToString(row["Ranking"]),
                                   RefNumber = Convert.ToString(row["RefNumber"]),
                                   Region = Convert.ToString(row["Region"]),
                                   RegionName = Convert.ToString(row["RegionName"]),
                                   RiskRating = Convert.ToString(row["RiskRating"]),
                                   SupportingDocument = Convert.ToString(row["SupportingDocument"]),
                                   Type = Convert.ToString(row["Type"]),
                                   Version = Convert.ToString(row["Version"]),
                               }).ToList();
                    }
                }
            }

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

            using (MySqlCommand cmd = new MySqlCommand("sp_insert_Strategy", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", _StrategyInfo.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Name", _StrategyInfo.Name));
                cmd.Parameters.Add(new MySqlParameter("i_Type", _StrategyInfo.Type));
                cmd.Parameters.Add(new MySqlParameter("i_ApplicationId", _StrategyInfo.ApplicationId));
                cmd.Parameters.Add(new MySqlParameter("i_BusinessSectorId", _StrategyInfo.BusinessSector));
                cmd.Parameters.Add(new MySqlParameter("i_CountryId", _StrategyInfo.Country));
                cmd.Parameters.Add(new MySqlParameter("i_RegionId", _StrategyInfo.Region));
                cmd.Parameters.Add(new MySqlParameter("i_ProductTypeId", _StrategyInfo.ProductType));
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

    public void UpdateStrategydata(Strategy _StrategyInfo, out int errorcode, out string errordesc)
    {
        try
        {
            errorcode = 0;
            errordesc = "success";

            using (MySqlCommand cmd = new MySqlCommand("sp_update_Strategy", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_id", _StrategyInfo.Id));
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", _StrategyInfo.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Name", _StrategyInfo.Name));
                cmd.Parameters.Add(new MySqlParameter("i_Type", _StrategyInfo.Type));
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

    public void UpdateStrategyVersiondata(Strategy _StrategyInfo, out int errorcode, out string errordesc)
    {
        try
        {
            int version = GetStrategyLatestVersionIDbyId(_StrategyInfo.RefNumber) + 1;
            //Get_StrategyLatestversionById
            errorcode = 0;
            errordesc = "success";

            using (MySqlCommand cmd = new MySqlCommand("sp_insert_Strategy_Version", connection))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new MySqlParameter("i_RefNumber", _StrategyInfo.RefNumber));
                cmd.Parameters.Add(new MySqlParameter("i_Name", _StrategyInfo.Name));
                cmd.Parameters.Add(new MySqlParameter("i_Type", _StrategyInfo.Type));
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

                    cmd.ExecuteNonQuery();
                    this.CloseConnection();
                    errordesc = "success|" + Convert.ToString(version);
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

    #endregion Strategy

    #region MapTask

    public List<MapTasks> GetMapTaskData()
    {
        List<MapTasks> lst = new List<MapTasks>();

        string query = "SP_GetMapTask";

        if (this.OpenConnection() == true)
        {

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
            }

            this.CloseConnection();
        }

        return lst;

    }

    public List<MapTasks> Get_Mapped_Mail_Task(string type)
    {
        List<MapTasks> lst = new List<MapTasks>();

        string query = "Get_Mapped_Mail_Task";

        if (this.OpenConnection() == true)
        {

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
            }

            this.CloseConnection();
        }

        return lst;

    }

    public List<MapTasks> GetMapTaskDatabyId(int taskid)
    {
        List<MapTasks> lst = new List<MapTasks>();

        string query = "SP_GetMapTaskbyId";

        if (this.OpenConnection() == true)
        {

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
            }

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

    #endregion MapTask

    #region Role

    #endregion Role

    #region User    

    #endregion User    

    public void AddRightsForRoles(string roleName, string menuRights, out int errorCode, out string errorDesc)
    {
        try
        {
            errorDesc = "";
            errorCode = 0;
            string query = "INSERT INTO tableinfo (name, age) VALUES('John Smith', '33')";
            if (this.OpenConnection() == true)
            {

                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
                this.CloseConnection();
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

    #region Roles

    public List<Roles> GetRoles(string roleId)
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
                }
                this.CloseConnection();
            }

            return lst;
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
                }

                this.CloseConnection();
            }
        }
        catch (Exception e)
        {
            throw e;
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
            }
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
                }
                this.CloseConnection();
            }


        }
        catch (Exception e)
        {
        }
    }
    public List<UserMaster> GetUserbyFilter(string CountryId, string RegionId, string BusinessSectorId)
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
                    cmd.Parameters.Add(new MySqlParameter("i_countryId", CountryId));
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
                                       CountryName = Convert.ToString(row["CountryName"]),
                                       BusinessSector = Convert.ToString(row["Name"]),
                                       BusinessSectorId = Convert.ToString(row["BusinessSectorId"]),
                                       CountryId = Convert.ToString(row["CountryId"]),
                                       RegionId = Convert.ToString(row["RegionId"]),
                                       Status = Convert.ToString(row["Status"]),
                                   }).ToList();
                        }
                    }
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
                                   BusinessSector = Convert.ToString(row["Name"]),
                                   BusinessSectorId = Convert.ToString(row["BusinessSectorId"]),
                                   CountryId = Convert.ToString(row["CountryId"]),
                                   RegionId = Convert.ToString(row["RegionId"]),
                                   Status = Convert.ToString(row["Status"]),
                                   Password = Convert.ToString(row["Password"]),
                                   IsADUser = Convert.ToString(row["IsADUser"]),
                               }).ToList();
                    }
                }
            }
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
                                       BusinessSector = Convert.ToString(row["Name"]),
                                       BusinessSectorId = Convert.ToString(row["BusinessSectorId"]),
                                       CountryId = Convert.ToString(row["CountryId"]),
                                       RegionId = Convert.ToString(row["RegionId"]),
                                       Status = Convert.ToString(row["Status"]),


                                   }).ToList();

                        }
                    }

                    cmd.ExecuteNonQuery();
                }

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
            }

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
            }

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
            }

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
            }

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
            }

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
    }

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
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Text.RegularExpressions;
using ACHI.Filters;
using ACHI.Models;
using System.Configuration;
using ACHI.CommonClass;
using MvcPaging;

namespace ACHI.Controllers
{
    [SessionState(System.Web.SessionState.SessionStateBehavior.Default)]
    public class UserManagementController : Controller
    {
        //
        // GET: /User/

        #region Private Variables
        private const int defaultPageSize = 10;
        private static readonly ILog log = LogManager.GetLogger(typeof(HomeController));
        private DbOperations _dbOperations = new DbOperations();
        private string connString = string.Empty;
        private int commandTimeout = 0;

        private int errorCode = 0;
        private string errorDesc = string.Empty;
        int ExecuteStatus = 0;
        GeneralClasses generalClassObj = new GeneralClasses();
        private MenuItemModel menuItemObj = new MenuItemModel();
        #endregion

        public ActionResult Index(string user_name, int? page)
        {

            if (Request.IsAuthenticated)
            {
                try
                {
                    //var currentUserName = WebSecurity.CurrentUserName;
                    bool haspagination = false;

                    if (string.IsNullOrEmpty(user_name) && page == null)
                    {
                        if (Session["GlobalSearch"] != null)
                        {
                            Session["GlobalSearch"] = null;
                        }
                    }
                    else if (!string.IsNullOrEmpty(user_name) && page == null)
                    {
                        if (!string.IsNullOrEmpty(user_name))
                        {
                            Session["GlobalSearch"] = user_name;
                        }
                    }
                    if (Session["GlobalSearch"] != null)
                    {
                        user_name = Convert.ToString(Session["GlobalSearch"]);
                        haspagination = true;
                    }


                    //List<UserDetails> users = _dbOperations.GetUserProfile(out  errorCode, out errorDesc);

                    IPagedList<UserDetails> pagedList = null;
                    int currentPageIndex = page.HasValue ? page.Value : 1;

                    //if (string.IsNullOrWhiteSpace(user_name) && !haspagination)
                    //{
                    //    pagedList = users.ToPagedList(currentPageIndex, defaultPageSize);
                    //}
                    //else
                    //{
                    //    pagedList = users.Where(p => p.EmpName.ToLower().Contains(user_name.ToLower())).ToPagedList(currentPageIndex, defaultPageSize);
                    //}

                    return View(pagedList);//);
                }
                catch (Exception ex)
                {
                    log.Error("Error in UserManagement - Index " + ex.Message);
                    return View();
                }
            }
            else
            {
                return RedirectToAction("LoginDisplay", "Home");
            }
        }

        /// <summary>
        /// creating new user
        /// </summary>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <param name="role"></param>
        /// <param name="checkResp"></param>
        /// <returns></returns>
        [HttpPost]
        public string CreateUser(UserDetails userinfo)
        {

            try
            {
                int execstatus;
                //_dbOperations.AddUser(userinfo, out  errorCode, out errorDesc, out execstatus);
                log.Info("User created successfully > EmpId" + userinfo.EmpCode);
                return errorDesc;
            }
            catch (MembershipCreateUserException ex)
            {
                return ex.Message.ToString();
            }

            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        /// <summary>
        /// Editing the user information
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="role"></param>
        /// <param name="status"></param>
        /// <returns></returns>
        [HttpPost]
        public string EditUser(UserDetails userinfo)
        {

            try
            {
                int execstatus;
                //_dbOperations.EditUser(userinfo, out  errorCode, out errorDesc, out execstatus);
                log.Info("User edited successfully > EmpId" + userinfo.EmpCode);
                return errorDesc;
            }
            catch (MembershipCreateUserException ex)
            {
                return ex.Message.ToString();
            }

            catch (Exception ex)
            {
                return ex.Message.ToString();
            }

        }


        /// <summary>
        /// for reset password
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        [HttpPost]
        public string ResetPassword(string username)
        {
            try
            {
                MembershipUser user = System.Web.Security.Membership.GetUser(username);
                string newPassword = user.ResetPassword();
                return "Password reset successfully to " + newPassword;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        /// <summary>
        /// deleting the user
        /// </summary>
        /// <param name="Username"></param>
        /// <returns></returns>
        [HttpPost]
        public string DeleteUser(int Id)
        {
            try
            {
//                _dbOperations.DeleteUser(Id, out errorCode, out errorDesc, out ExecuteStatus);
                return errorDesc;
            }
            catch (Exception ex)
            {
                log.Error("Error in <deleteuser> " + ex.Message);
                return "Unable to delete user ";
            }
        }

        
        /// <summary>
        /// for changing current user password
        /// </summary>
        /// <param name="curpwd"></param>
        /// <param name="newpwd"></param>
        /// <param name="confirmpwd"></param>
        /// <returns></returns>
        //[HttpPost]
        //public string ChangePassword(string curpwd, string newpwd, string confirmpwd)
        //{
        //    try
        //    {
        //        if (string.IsNullOrEmpty(curpwd))
        //        {
        //            return "Please enter the current password";
        //        }
        //        else if (string.IsNullOrEmpty(newpwd))
        //        {
        //            return "Please enter the new password";
        //        }
        //        else if (string.IsNullOrEmpty(confirmpwd))
        //        {
        //            return "Please enter the confirm the new password";
        //        }
        //        else if (newpwd.Length < 6)
        //        {
        //            return "Password length minimum 6 characters";
        //        }
        //        else
        //        {
        //            if (curpwd != newpwd)
        //            {
        //                if (newpwd == confirmpwd)
        //                {
        //                    string userid = Convert.ToString(Session["UserName"]);
        //                    _dbOperations.ChangePwd(userid, curpwd, newpwd, out  errorCode, out errorDesc);
        //                    if (errorCode == 0)
        //                        return "Password changed successfully";
        //                    else
        //                        return "Please check the current password";
        //                }
        //                else
        //                {
        //                    return "New and confirm passwords did not match";
        //                }
        //            }
        //            else
        //            {
        //                return "Current and new password cannot be same";
        //            }
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        log.Error(ex);
        //        return "Error occured..";
        //    }
        //}


        //[HttpPost]
        //public string UpdatePassword(int id, string newpwd, string confirmpwd)
        //{
        //    try
        //    {
        //        if (string.IsNullOrEmpty(newpwd))
        //        {
        //            return "Please enter the new password";
        //        }
        //        else if (string.IsNullOrEmpty(confirmpwd))
        //        {
        //            return "Please enter the confirm the new password";
        //        }
        //        else if (newpwd.Length < 6)
        //        {
        //            return "Password length minimum 6 characters";
        //        }
        //        else
        //        {
        //            if (newpwd == confirmpwd)
        //            {

        //                _dbOperations.UpdatePwd(id, newpwd, out  errorCode, out errorDesc);
        //                if (errorCode == 0)
        //                    return "success";
        //                else
        //                    return "Error occured";
        //            }
        //            else
        //            {
        //                return "New and confirm passwords did not match";
        //            }

        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        log.Error(ex);
        //        return "Error occured..";
        //    }
        //}


        
    }
}


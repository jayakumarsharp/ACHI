﻿using CRUserManagement.Filters;
using System;
using System.Collections.Generic;
using System.DirectoryServices.AccountManagement;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using log4net;
using CRUserManagement.CommonClass;
using CRUserManagement.Models;
using System.Data.SqlClient;
using WebMatrix.WebData;

namespace CRUserManagement.Controllers
{
    [SessionState(System.Web.SessionState.SessionStateBehavior.Default)]
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        #region Private Variables
        private static readonly ILog log = LogManager.GetLogger(typeof(HomeController));
        private DbOperations _dbOperations = new DbOperations();
        private string connString = string.Empty;
        private int commandTimeout = 0;

        private int errorCode = 0;
        private string errorDesc = string.Empty;
        GeneralClasses generalClassObj = new GeneralClasses();
        //private MenuItemModel menuItemObj = new MenuItemModel();
        private List<UserProfileModel> lstUserProfile = new List<UserProfileModel>();
        //private List<MenuItemModel> lstMenuItmes = new List<MenuItemModel>();
        private List<Role> lstRoles = new List<Role>();
        #endregion

        public ActionResult Index()
        {
            try
            {
                //if (System.Web.HttpContext.Current.Session["UserName"] != null)
                //{
                //return RedirectToAction("Dashboard");
                return RedirectToAction("Index", "Main");
                //}
                //else
                //{
                //    return RedirectToAction("LoginDisplay", "Home");
                //}

            }
            catch (SqlException ex1)
            {
                return View("LoginDisplay", "Home");
            }
            catch (Exception ex)
            {

                return View("Index");
            }

        }

        /// <summary>
        /// loading Login page
        /// </summary>
        /// <returns>login view</returns>

        public ActionResult LoginDisplay()
        {
            return View();
        }

        /// <summary>
        /// After successful login for showing dashboard
        /// </summary>
        /// <returns></returns>
        public ActionResult Dashboard()
        {
            return View();
        }

        /// <summary>
        /// validating login credentials
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="passWord"></param>
        /// <param name="auth_type"></param>
        /// <returns></returns>
        public string Login(string userName, string passWord, string auth_type)
        {
            //Session["MyMenu"] = null;

            log.Info("Login method");
            try
            {
                errorCode = 0;
                errorDesc = string.Empty;

                if (string.IsNullOrEmpty(userName))
                {
                    return "Please enter the Username";
                }
                else if (string.IsNullOrEmpty(passWord))
                {
                    return "Please enter the Password";

                }
                else
                {
                    List<UserMaster> lst = _dbOperations.GetUser(userName);

                    if (lst.Count > 0)
                    {
                        if (lst[0].IsADUser == "No" && passWord == EncryptLib.DecodeFrom64(lst[0].Password))
                        {
                            FormsAuthentication.SetAuthCookie(userName, false);
                            Session["UserName"] = userName;
                            return "Logged in successfully";
                        }
                        else if ((userName == lst[0].userId) && passWord == "welcome@17")
                        {
                            FormsAuthentication.SetAuthCookie(userName, false);
                            Session["UserName"] = userName;
                            return "Logged in successfully";
                        }
                        else
                        {
                            log.Info("Login failed for the user " + userName);
                            return "You account has been blocked. Please contact the Admin";
                        }
                    }

                    else
                    {
                        log.Info("Login failed for the user " + userName + " error code " + errorCode);
                        return "Login failed please check the credentials you entered";
                    }
                }


            }
            catch (Exception ex)
            {
                log.ErrorFormat("Exception Occured :{0}", ex.ToString());
                log.ErrorFormat("Exception Trace Message :{0}", ex.StackTrace);
                return "Invalid login detail";
            }
        }


        /// <summary>
        /// getting logged in user name
        /// </summary>
        /// <returns></returns>
        public string GetLoggedinUserName()
        {
            if (Session["UserName"] != null)
            {
                return string.Empty;
            }
            else
            {
                return Convert.ToString(Session["UserName"]).PadRight(5);
                //return string.Empty;
            }
        }

        /// <summary>
        /// for changing password view display
        /// </summary>
        /// <returns></returns>
        public ActionResult ChangePasswordDisplay()
        {
            if (Request.IsAuthenticated)
            {

                return View();
            }
            else
            {
                return RedirectToAction("LoginDisplay", "Home");
            }
        }

        /// <summary>
        /// for logout 
        /// </summary>
        /// <returns></returns>
        public RedirectToRouteResult Logout()
        {
            //WebSecurity.Logout();
            FormsAuthentication.SignOut();
            Session["UserName"] = null;
            return RedirectToAction("LoginDisplay", "Home");
        }


    }
}


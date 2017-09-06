using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ACHI.Models;


namespace ACHI.CommonClass
{
    public class GeneralClasses
    {
        public List<MenuItemModel> MenuItems { get; set; }
        public List<Role> Roles { get; set; }

        //public List<MenuItemModel> MenuItems = new List<MenuItemModel>();
        //public List<Role> Roles = new List<Role>();

    }

    public class RoleViewModel
    {
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public List<MenuItem> MenuItems { get; set; }
     //   public List<ReportName> ReportNames { get; set; }
    }

    public class MenuItem
    {
        public MenuItem()
        {
            Roles = new List<Role>();
        }

        public int MenuItemId { get; set; }
        public string Name { get; set; }
        public string ActionName { get; set; }
        public string ControllerName { get; set; }
        public string Url { get; set; }

        public MenuItem ParentMenu { get; set; }
        public List<Role> Roles { get; set; }
    }

    

    public class UserProfile
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public bool Status { get; set; }
    }

    public class MenuItemModel
    {

        public int MenuItemId { get; set; }
        public string Name { get; set; }
        public string ActionName { get; set; }
        public string ControllerName { get; set; }
        public string Url { get; set; }
        public int ParentMenuId { get; set; }
        public string RoleName { get; set; }
        //  public MenuItemModel ParentMenu { get; set; }
        //public List<Role> Roles { get; set; }


        public MenuItemModel()
        {
            // Roles = new List<Role>();
        }
        public MenuItemModel(int menuItemId, string name, string actionName, string controllerName, string url, int parentMenuId, string roleName)
        {
            MenuItemId = menuItemId;
            Name = name;
            ActionName = actionName;
            ControllerName = controllerName;
            Url = url;
            ParentMenuId = parentMenuId;
            RoleName = roleName;
        }
    }

 
}
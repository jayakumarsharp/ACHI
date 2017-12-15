using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class UserViewModel
{
    public int UserId { get; set; }
    public string UserName { get; set; }
    public string RoleName { get; set; }
    public string FccLocations { get; set; }
    //public string CircleName { get; set; }
    //public string LanguageName { get; set; }
    public bool Status { get; set; }
    //public string HubIdName { get; set; }
    //public string CircleIdName { get; set; }
    //public string LangIdName { get; set; }


    public UserViewModel()
    {
    }
    //public UserViewModel(int userId, string userName, string roleName, string hubName, string circles, string languages, bool status, string hubIdName, string circleIdName, string langIdName)
    public UserViewModel(int userId, string userName, string roleName,string Fcc, bool status)
    {
        UserId = userId;
        UserName = userName;
        RoleName = roleName;
        FccLocations = Fcc;
        Status = status;
    }



}
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace CRUserManagement.Models
{
    

    public class UserProfileModel
    {
        public UserProfileModel()
        {

        }
        public int UserId { get; set; }
        public string UserName { get; set; }
        public bool Status { get; set; }
    
        public UserProfileModel(int userid, string username, bool status)
        {
            UserId = userid;
            UserName = username;
            Status = status;
        }
    }

    public class ReportName
    {
        public ReportName()
        {
            Roles = new List<Role>();
        }
        public int ReporNameId { get; set; }
        public string Name { get; set; }
        public string Remarks { get; set; }
        public List<Role> Roles { get; set; }
    }

    
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace CRUserManagement.Models
{

    public class UserDetails
    {
        public int ID { get; set; }
        public int EmpCode { get; set; }
        public string EmpName { get; set; }
        public string Password { get; set; }
        public int ManagerId { get; set; }
        public string ManagerName { get; set; }
        public int HODID { get; set; }
        public string HODname { get; set; }
        public string UserType { get; set; }
        public string Email { get; set; }
        public string ContactNo { get; set; }
        public int RoleId { get; set; }
        public string Rolename { get; set; }
        public int TeamId { get; set; }
        public string Teamname { get; set; }
        public int Status { get; set; }

        public UserDetails()
        {
        }
        public UserDetails(int id, int empcode, string empname, string password, int managerid, string managername, int hodid, string hodname,
        string usertype, string email, string contactno, int roleid, string rolename, int teamid,string teamname , int status)
        {
            Teamname = teamname;
            ID = id;
            Email = email;
            EmpCode = empcode;
            EmpName = empname;
            Password = password;
            ManagerId = managerid;
            UserType = usertype;
            HODID = hodid;
            ContactNo = contactno;
            TeamId = teamid;
            Status = status;
            RoleId = roleid;
            Rolename = rolename;
            HODname = hodname;
            ManagerName = managername;

        }




    }


    public class Membership
    {
        public Membership()
        {
            Roles = new List<Role>();
        }

        [Key, DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int UserId { get; set; }
        public DateTime? CreateDate { get; set; }
        [StringLength(130)]
        public string ConfirmationToken { get; set; }
        public bool? IsConfirmed { get; set; }
        public DateTime? LastPasswordFailureDate { get; set; }
        public int PasswordFailuresSinceLastSuccess { get; set; }
        [Required, StringLength(128)]
        public string Password { get; set; }
        public DateTime? PasswordChangedDate { get; set; }
        [Required, StringLength(128)]
        public string PasswordSalt { get; set; }
        [StringLength(128)]
        public string PasswordVerificationToken { get; set; }
        public DateTime? PasswordVerificationTokenExpirationDate { get; set; }

        public ICollection<Role> Roles { get; set; }

    }


    public class Role
    {
        [Key]
        public int RoleId { get; set; }
        public string RoleName { get; set; }

        public Role(int roleId, string roleName)
        {
            RoleId = roleId;
            RoleName = roleName;
        }
    }


    public class RoleMapping
    {
        [Key]
        public int RoleId { get; set; }
        public int MenuItemId { get; set; }
    }



    public class Managers
    {
        public int UserId { get; set; }
        public string ManagerName { get; set; }

        public Managers(int id, string name)
        {
            UserId = id;
            ManagerName = name;
        }
    }

    public class Hods
    {
        public int UserId { get; set; }
        public string HodName { get; set; }

        public Hods(int id, string name)
        {
            UserId = id;
            HodName = name;
        }
    }


    public class Teams
    {
        public int UserId { get; set; }
        public string TeamName { get; set; }

        public Teams(int id, string name)
        {
            UserId = id;
            TeamName = name;
        }
    }


    public class UserType
    {
        public int Id { get; set; }
        public string Usertype { get; set; }

        public UserType(int id, string name)
        {
            Id = id;
            Usertype = name;
        }
    }

    public class UserList
    {
        public int Id { get; set; }
        public string UserName { get; set; }

        public UserList(int id, string name)
        {
            Id = id;
            UserName = name;
        }

    }

}
using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


public partial class LoginStatus : System.Web.UI.UserControl
{
    protected void logoutButton_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/");
    }

    protected void LogInButton_Click(object sender, EventArgs e)
    {
        FormsAuthentication.RedirectToLoginPage();
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        IIdentity currentIdentity = this.Page.User.Identity;
        bool loggedIn = currentIdentity.IsAuthenticated;

        string userName = loggedIn ?
            currentIdentity.Name:
            "(not logged in)";

        this.logInButton.Visible = !loggedIn;
        this.logOutButton.Visible = loggedIn;
        this.LoggedInAsLiteral.Text = userName; 
    }
}

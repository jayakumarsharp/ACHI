using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Specialized;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    protected void LoginButton_Click(object sender, EventArgs e)
    {
        string username = "";
        string password = "";

        if (this.Authenticate(username, password))
        {
            FormsAuthentication.RedirectFromLoginPage(username, false);
        }
        else
        {
            this.errorLabel.Visible = true;
        }
    }

    private bool Authenticate(string username, string password)
    {
        bool authenticated = false;

        using (Client client = new Client())
        {
            try
            {
                // Connect to the directory as the user who is trying to 
                // authenticate. If this fails we know the username
                // and/or password is incorrect.
                LdapConnectionConfigurationSection config = LdapConnectionConfigurationSection.Current;
                client.Connect(config.Server, config.Port,
                    username, password);

                // Force a re-fetch of the user's role information.
                LdapRoleCache.Current.Remove(username);
                
                authenticated = true;
            }
            catch (LdapException)
            {
                authenticated = false;
            }
        }

        return authenticated;
    }
}

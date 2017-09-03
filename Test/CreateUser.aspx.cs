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

using LdapServices.Ldap;

public partial class CreateUser : System.Web.UI.Page
{
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        if (rolesCheckBoxList.Items.Count == 0)
        {
            LdapConnectionConfigurationSection config = LdapConnectionConfigurationSection.Current;
            using (Client client = new Client())
            {
                client.Connect(config.Server, config.Port, config.User, config.Password);

                EntryCollection groups = client.Search(
                    config.BaseDn, "objectClass=group");

                foreach (Entry group in groups)
                {
                    rolesCheckBoxList.Items.Add(new ListItem(
                        group.Attributes["cn"].Values[0].StringValue,
                        group.DN));
                }
            }
        }
    }

    protected void createButton_Click(object sender, EventArgs e)
    {
        try
        {
            LdapConnectionConfigurationSection config = LdapConnectionConfigurationSection.Current;
            using (Client client = new Client())
            {
                client.Connect(config.Server, config.Port, config.User, config.Password);

                // Create the user.
                NameValueCollection attributes = new NameValueCollection();
                attributes.Add("objectClass", "user");
                string userDn = "cn=" + cnTextBox.Text + "," + config.NewUsersContainerDn;
                Entry newUser = client.AddNewEntry(userDn, attributes);

                newUser.Attributes.Add("userPassword", passwordTextBox.Text);

                // Add the user to each specified role.
                foreach (ListItem roleListItem in rolesCheckBoxList.Items)
                {
                    if (roleListItem.Selected)
                    {
                        AddUserToRole(client, config.BaseDn, roleListItem.Value, userDn);
                    }
                }
            }
            
            this.cnTextBox.Text = String.Empty;
            this.rolesCheckBoxList.Items.Clear();
            this.messageLabel.Text = "User created.";
            this.messageLabel.Visible = true;
        }
        catch (LdapException ex)
        {
            this.messageLabel.Text = ex.ToString();
            this.messageLabel.Visible = true;
        }
    }

    private void AddUserToRole(Client client, string baseDn, string roleDn, string userDn)
    {
        EntryCollection roles = client.Search(baseDn, "distinguishedName=" + roleDn);
        LdapServices.Ldap.AttributeCollection roleAttributes = roles[0].Attributes;
        LdapServices.Ldap.Attribute memberAttribute = roleAttributes["member"];
        if (memberAttribute != null)
        {
            memberAttribute.Values.Add(userDn);
        }
        else
        {
            roleAttributes.Add("member", userDn);
        }
    }
}

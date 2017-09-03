<%@ Application Language="C#" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="LdapServices.Ldap" %>

<script runat="server">
    
    protected void Application_AuthenticateRequest(object sender, EventArgs e)
    {
        // The AuthenticateRequest event will fire even on the login page, when
        // we don't actually have a "current user".
        if (HttpContext.Current.User != null)
        {
            UpdateCurrentUserRoles();
        }
    }

    private void UpdateCurrentUserRoles()
    {
        // This event handler gets called after authentication is complete but
        // before authorization has started. That is, at this point we know who
        // the user is, and we also know that the user logged in via 
        // Login.aspx and that their role information has been stored in the 
        // LdapRoleCache object.
        //
        // In order to for ASP.Net to know to which roles this user belongs we
        // must tell it by updating the current principal with one that 
        // has these roles associated with it.

        // Create the new principal which has the authenticated identity and 
        // the roles which we just retrieved.
        GenericPrincipal ldapPrincipal = new GenericPrincipal(
            HttpContext.Current.User.Identity,
            GetRolesForUser(HttpContext.Current.User.Identity.Name));

        // Update the current user with this information so that when ASP.Net
        // performs authorization it will see the roles which we retrieved from
        // the LDAP server and compare them against the role names stored in
        // web.config.
        HttpContext.Current.User = ldapPrincipal;
    }

    private string[] GetRolesForUser(string username)
    {
        string[] roles = LdapRoleCache.Current[username];

        if (roles == null)
        {
            // Use the LDAP connection information defined in web.config to 
            // retrieve the role membership information for this user.
            using (Client client = new Client())
            {
                LdapConnectionConfigurationSection config = LdapConnectionConfigurationSection.Current;
                client.Connect(config.Server, config.Port, config.User, config.Password);
                    
                EntryCollection userEntries = client.Search(
                    config.BaseDn, "distinguishedName=" + username);

                if (userEntries.Count == 1)
                {
                    // Now retrieve the roles to which this user belongs and 
                    // store them in the Application object.

                    // We treat the memberof attribute as the collection of
                    // roles to which this user belongs.
                    LdapServices.Ldap.Attribute memberOf = userEntries[0].Attributes["memberof"];

                    // Copy the values from the memberof attribute into a string
                    // array.
                    roles = new string[memberOf.Values.Count];
                    for (int i = 0; i < memberOf.Values.Count; i++)
                    {
                        string adamGroupName = memberOf.Values[i].StringValue;

                        // Roles cannot contain commas in ASP.Net, so we are 
                        // mapping commas to periods. The cache contains the 
                        // original role names so we need to transform them 
                        // before handing them off to ASP.Net.
                        roles[i] = adamGroupName.Replace(',', '.');
                    }

                    // Save the user's roles in our cache. We will access this
                    // cache later during the Application-level 
                    // AuthenticateRequest event.
                    LdapRoleCache.Current[username] = roles;
                }
            }
        }

        // If we could not retrieve the roles for this user then return an 
        // empty array, indicating that the user is not a member of any roles.
        if (roles == null)
        {
            roles = new string[] { };
        }

        return roles;
    }
    
</script>

using System;
using System.Data;
using System.Configuration;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using UserRoleMapping = System.Collections.Generic.Dictionary<string, string[]>;

/// <summary>
/// Summary description for RoleCache
/// </summary>
public class LdapRoleCache
{
    private const string AppRoleCacheKey = "LdapRoleCache";
    private UserRoleMapping _mapping = new UserRoleMapping();
    ReaderWriterLock _lock = new ReaderWriterLock();

    public static LdapRoleCache Current
    {
        get
        {
            HttpApplicationState appState = HttpContext.Current.Application;

            if (appState[AppRoleCacheKey] == null)
            {
                lock (appState)
                {
                    if (appState[AppRoleCacheKey] == null)
                    {
                        appState[AppRoleCacheKey] = new LdapRoleCache();
                    }
                }
            }

            return (LdapRoleCache)appState[AppRoleCacheKey];
        }
    }

    /// <remarks>
    /// Returns null if the cache does not contain an entry for that user.
    /// </remarks>
    /// <param name="userName"></param>
    /// <returns></returns>
    public string[] this[string userName]
    {
        get
        {
            string[] roles = null;
            try
            {
                this._lock.AcquireReaderLock(-1);
                this._mapping.TryGetValue(userName, out roles);
            }
            finally
            {
                this._lock.ReleaseReaderLock();
            }

            return roles;
        }

        set
        {
            try
            {
                this._lock.AcquireWriterLock(-1);
                this._mapping[userName] = value;
            }
            finally
            {
                this._lock.ReleaseWriterLock();
            }
        }
    }

    public void Remove(string userName)
    {
        this._lock.AcquireWriterLock(-1);
        try
        {
            this._mapping.Remove(userName);
        }
        finally
        {
            this._lock.ReleaseWriterLock();
        }
    }
}

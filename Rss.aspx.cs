using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Rss : System.Web.UI.Page {

    private string siteName;

    protected string SiteName {
     
        get {
            if (siteName == null) {
                siteName = "http://" + Request.Url.Host + ":" + Request.Url.Port;
            }

            return siteName;
        }   
    }

    protected void Page_Load(object sender, EventArgs e) {

        ListsTableAdapters.ListsTableAdapter lists = new ListsTableAdapters.ListsTableAdapter();

        MyLists.DataSource = lists.GetLists(false);
        MyLists.DataBind();
    }

    protected object GetItems(int listId) {

        ListsTableAdapters.ItemsTableAdapter items = new ListsTableAdapters.ItemsTableAdapter();
        return items.GetDataByListIdAndCompleteStatus(listId, false);
    }
}

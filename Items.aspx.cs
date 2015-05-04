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

public partial class Items : System.Web.UI.Page {

    protected void Page_Load(object sender, EventArgs e) {

        ListsTableAdapters.ListsTableAdapter listData = new ListsTableAdapters.ListsTableAdapter();

        int listId = Int32.Parse(Request.QueryString["ListId"]);
        ListTitle.Text = "> " + listData.GetListNameByListId(listId);
    }

    protected void AddItemBtn_Click(object sender, EventArgs e) {

        ListsTableAdapters.ItemsTableAdapter items = new ListsTableAdapters.ItemsTableAdapter();
        items.Insert(Int32.Parse(Request.QueryString["ListId"]), Server.HtmlEncode(AddBtnTxt.Text), false);

        AddBtnTxt.Text = "";
    }

    protected string FormatDone(bool isDone) {
        return isDone == true ? "Yes" : "No";
    }
}

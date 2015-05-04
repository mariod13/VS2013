using System;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class MyLists : System.Web.UI.Page {

    protected void AddListBtn_Click(object sender, EventArgs e) {

        ListsTableAdapters.ListsTableAdapter lists = new ListsTableAdapters.ListsTableAdapter();
        lists.Insert(Server.HtmlEncode(AddItemTxt.Text), 1, false, DateTime.Now);

        AddItemTxt.Text = "";
        ListGrid.DataBind();
    }

    protected string FormatPriority(int priority) {

        switch (priority) {
            case 1:
                return "Low";
            case 2:
                return "Medium";
            default:
                return "High";
        }
    }

    protected string FormatDone(bool isDone) {
        return isDone == true ? "Yes" : "No";
    }

    protected bool IsDeleteBtnVisible(int itemCount) {
        return itemCount == 0 ? true : false;
    }
}

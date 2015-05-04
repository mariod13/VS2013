<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Items.aspx.cs" Inherits="Items" Title="Items" %>

<asp:Content ID="Content1" ContentPlaceHolderID="c1" Runat="Server">

    <div class="header">
                        
        <a href="MyLists.aspx" class="title">My Lists</a>                
        <asp:Label ID="ListTitle" CssClass="title" runat="server" />
        
        <hr id="separator" />
    
    </div>
         
    <div id="list">
    
        <atlas:UpdatePanel ID="up1" runat="server">
           
            <ContentTemplate>
                                              
                    <asp:GridView ID="ItemGrid" BorderWidth="0" runat="server" AutoGenerateColumns="False" DataKeyNames="ItemId" DataSourceID="ObjectDataSource1" AllowPaging="True" AllowSorting="True" EnableViewState="False" GridLines="None">
                        
                        <Columns>
                            <asp:CommandField HeaderStyle-CssClass="commands" ShowDeleteButton="True" ShowEditButton="True" ControlStyle-CssClass="buttons" />
                            <asp:BoundField DataField="Name" itemstyle-CssClass="name" headerstyle-CssClass="name" ControlStyle-CssClass="name" HeaderText="Item" SortExpression="Name" />
                            
                            <asp:TemplateField HeaderText="Done" SortExpression="IsComplete">
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsComplete") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Done" Text='<%# FormatDone((bool) Eval("IsComplete")) %>' runat="server" />
                                </ItemTemplate>
                                <ItemStyle CssClass="iscomplete" />
                                <HeaderStyle CssClass="iscomplete" />                                
                            </asp:TemplateField>
 
                        </Columns>
                        
                        <EmptyDataTemplate>
                            <span id="Empty">There are no items in this list</span>                          
                        </EmptyDataTemplate>
                        
                    </asp:GridView>                      
                          
            </ContentTemplate>     
            
        </atlas:UpdatePanel>
        
    </div>
    
    <div id="AddNew">
        
       <atlas:UpdatePanel ID="AddPanel" Mode="Conditional" runat="server">
        
            <ContentTemplate>
        
                <span>Add New Item:</span> <asp:TextBox ID="AddBtnTxt" cssclass="newitem" MaxLength="50" runat="server"></asp:TextBox>
                <asp:Button ID="AddItemBtn" runat="server" OnClick="AddItemBtn_Click" Text="Add" />
        
            </ContentTemplate>
        
            <Triggers>
                <atlas:ControlEventTrigger ControlID="AddItemBtn" EventName="Click" />
            </Triggers>  
        
        </atlas:UpdatePanel>    
        
    </div>

    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                          TypeName="ListsTableAdapters.ItemsTableAdapter"
                          SelectMethod="GetItemsByListId" UpdateMethod="Update" DeleteMethod="Delete">
        <SelectParameters>
            <asp:QueryStringParameter Name="ListId" Type="Int32" QueryStringField="ListId" />
        </SelectParameters>                    
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Original_ItemId" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_ItemId" Type="Int32" />
        </DeleteParameters>
    </asp:ObjectDataSource>  

  <%-- Add a hidden LinkButton below to workaround a Atlas bug in the current preview where the eventtarget infrastructure 
       isn't wired up on first page load, and subsequently has problems in IE (not FireFox) when the columns are 
       added with the GridView --%>
  <asp:LinkButton ID="LinkButton1" CommandArgument="false"  runat="server" />


</asp:Content>


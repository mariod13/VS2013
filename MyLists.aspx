<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyLists.aspx.cs" Inherits="MyLists" Title="My Todo List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="c1" Runat="Server">

    <div class="header">
    
        <span class="title">My Lists</span> 
        <span id="filter">
            Current List Filter: 
            <asp:DropDownList ID="FilterBtn" cssclass="filterdropdown" AutoPostBack="true" runat="server">
                <asp:ListItem Text="Active" Value="False" />
                <asp:ListItem Text="Done" Value="true" />
            </asp:DropDownList>
        </span>
        
        <hr id="separator" />
        
    </div>
                  
    <div id="list">
    
        <atlas:UpdatePanel ID="up1" runat="server">
           
            <ContentTemplate>
                       
                    <asp:GridView ID="ListGrid" BorderWidth="0px" runat="server" AutoGenerateColumns="False" DataKeyNames="ListId" DataSourceID="ListDataSource" AllowPaging="True" AllowSorting="True" EnableViewState="False" GridLines="None">
                        
                        <Columns>
                        
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                    <asp:LinkButton ID="DeleteBtn" Visible='<%# IsDeleteBtnVisible( (int) Eval("ItemCount")) %>' runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                                <ControlStyle CssClass="buttons" />
                                <HeaderStyle CssClass="commands" />
                            </asp:TemplateField>
                            
                            <asp:BoundField DataField="Name"  HeaderText="List" SortExpression="Name" >
                                <ControlStyle CssClass="name_edit" />
                                <ItemStyle CssClass="name" />
                                <HeaderStyle CssClass="name" />
                            </asp:BoundField>
                           
                            <asp:TemplateField HeaderText="Pri" SortExpression="Priority">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" Width="75" SelectedValue='<%# Bind("Priority") %>' runat="server">
                                        <asp:ListItem Text="High" Value="3" />
                                        <asp:ListItem Text="Medium" Value="2" />
                                        <asp:ListItem Text="Low" Value="1" />
                                    </asp:DropDownList>                                
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="pri" Text='<%# FormatPriority((int) Eval("Priority")) %>' runat="server" />
                                </ItemTemplate>
                                <ItemStyle CssClass="priority" />
                                <HeaderStyle CssClass="priority" />
                            </asp:TemplateField>
                            
                            <asp:BoundField DataField="DateCreated" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="False" HeaderText="Started" ReadOnly="True" SortExpression="DateCreated" >
                                <ItemStyle CssClass="started" />
                                <HeaderStyle CssClass="started" />
                            </asp:BoundField>
                            
                            <asp:TemplateField HeaderText="Done" SortExpression="IsComplete">
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsComplete") %>' />
                                </EditItemTemplate>
                                <ItemStyle CssClass="iscomplete" />
                                <HeaderStyle CssClass="iscomplete" />
                                <ItemTemplate>
                                    <asp:Label ID="Done" Text='<%# FormatDone((bool) Eval("IsComplete")) %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:HyperLinkField DataTextField="ItemCount" DataTextFormatString="{0} active items" DataNavigateUrlFields="ListId" DataNavigateUrlFormatString="Items.aspx?ListId={0}" >
                                <ItemStyle CssClass="viewitems" />
                            </asp:HyperLinkField>
                            
                        </Columns>
                        
                        <EmptyDataTemplate>
                            <span id="Empty">No lists</span>
                        </EmptyDataTemplate>
                        
                    </asp:GridView>              
                          
            </ContentTemplate>     
            
        </atlas:UpdatePanel>
        
    </div>
    
    <div id="AddNew">
        
       <atlas:UpdatePanel ID="AddPanel" Mode="Conditional" runat="server">
        
            <ContentTemplate>
        
                <span>Add New List:</span> <asp:TextBox ID="AddItemTxt" cssclass="newitem" runat="server"></asp:TextBox>
                <asp:Button ID="AddListBtn" runat="server" OnClick="AddListBtn_Click" Text="Add" />
        
            </ContentTemplate>
        
            <Triggers>
                <atlas:ControlEventTrigger ControlID="AddListBtn" EventName="Click" />
            </Triggers>  
        
        </atlas:UpdatePanel>    
        
    </div>

    <div id="rss">
        <h5>RSS Enabled</h5>
        <a href="Rss.aspx">Click to subscribe to your lists</a>
        <a href="Rss.aspx"><img alt="RSS" src="images/xml.gif" /></a>   
    </div>

    <asp:ObjectDataSource ID="ListDataSource" runat="server" 
                          TypeName="ListsTableAdapters.ListsTableAdapter" 
                          SelectMethod="GetLists" 
                          UpdateMethod="Update" 
                          DeleteMethod="Delete"
                          OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:ControlParameter Name="IsComplete" Type="Boolean" ControlID="FilterBtn" PropertyName="SelectedValue" />
        </SelectParameters>                    
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="IsComplete" Type="Boolean" />
            <asp:Parameter Name="Priority" Type="Int32" />
            <asp:Parameter Name="Original_ListId" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_ListId" Type="Int32" />
        </DeleteParameters>
    </asp:ObjectDataSource>  

</asp:Content>


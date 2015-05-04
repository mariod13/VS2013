<%@ Page Language="C#" AutoEventWireup="true" ContentType="text/xml" CodeFile="Rss.aspx.cs" Inherits="Rss" %><?xml version="1.0" encoding="UTF-8" ?> 

 <rss version="2.0" xmlns:dc="http://purl.org/dc/elements/1.1/">
 <channel>
  <title>My Lists</title> 
  <link><%=this.SiteName + Request.ApplicationPath%>/MyLists.aspx</link> 
  <description>My Active Lists</description> 
  <language>en-us</language> 
  <ttl>50</ttl> 
  
  <asp:repeater id="MyLists" runat="server">
  
    <itemtemplate>
       <item>
          <title><%#Eval("Name") %></title> 
          <description>You have <%#Eval("ItemCount")%> open items in this list
          
            <asp:repeater id="MyItem" DataSource='<%# GetItems((int) DataBinder.Eval(Container.DataItem, "ListId")) %>' runat="server">
            
                <headertemplate>
                    <ul>
                </headertemplate>
                
                <ItemTemplate>
                    <li><%#Eval("Name") %></li>
                </ItemTemplate>
            
                <footertemplate>
                    </ul>
                </footertemplate>
            
            </asp:repeater>
         
          </description> 
               
          <pubDate><%#DateTime.Now %></pubDate> 
          <guid><%=this.SiteName + Request.ApplicationPath%>/Items.aspx?listid=<%#Eval("ListId") %></guid> 
          <link><%=this.SiteName + Request.ApplicationPath%>/Items.aspx?listid=<%#Eval("ListId") %></link> 
       </item>
    </itemtemplate>
  
  </asp:repeater>
  
</channel>
</rss>
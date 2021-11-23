<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/default.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="SupremeArt.Buyer.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="content" runat="server">
   

 <%@Register TagPrefix="UserControl" TagName="Membership" Src="HomeControl.ascx" %>
    
            <UserControl:Membership runat="server" />
 


    
</asp:Content>

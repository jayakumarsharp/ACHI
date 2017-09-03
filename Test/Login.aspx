<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" MasterPageFile="~/masterPage.master"%>

<asp:Content runat="server" ContentPlaceHolderID="TitlePlaceHolder">
Create a user
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="BodyPlaceHolder">
    <div style="text-align: center">
        <asp:Label runat="server" Text="Invalid username or password" ForeColor="Red" Visible="false" ID="errorLabel"/><br />
        Username:&nbsp;<asp:TextBox ID="UsernameTextBox" runat="server" /><br />
        Password:&nbsp;<asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password"/>
        <br />
        <asp:Button ID="LoginButton" runat="server" Text="Log In" OnClick="LoginButton_Click" /></div>
</asp:Content>
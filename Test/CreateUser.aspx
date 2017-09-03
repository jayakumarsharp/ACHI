<%@ Page Language="C#" MasterPageFile="~/ContentPage.master" AutoEventWireup="true" CodeFile="CreateUser.aspx.cs" Inherits="CreateUser" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitlePlaceHolder" Runat="Server">Create a user</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    New User Details:<br />
    <table>
        <tr>
            <td style="width: 100px">
    cn:
            </td>
            <td style="width: 100px">
    <asp:TextBox ID="cnTextBox" runat="server" /></td>
    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please provide a cn (common name)" ControlToValidate="cnTextBox" Display="dynamic"/></td>
        </tr>
        <tr>
            <td style="width: 100px">
    password:</td>
            <td style="width: 100px">
    <asp:TextBox ID="passwordTextBox" runat="server" TextMode="Password" autocomplete="off" /></td>
    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please provide a password" ControlToValidate="passwordTextBox" Display="dynamic"/></td>
        </tr>
        <tr>
            <td style="width: 100px">
    roles:</td>
            <td style="width: 100px" colspan="2">
                <asp:CheckBoxList ID="rolesCheckBoxList" runat="server">
    </asp:CheckBoxList></td>
        </tr>
    </table>
    
    &nbsp;<asp:Button ID="createButton" runat="server" Text="Create" OnClick="createButton_Click" />
    <br />
    <asp:Label ID="messageLabel" runat="server" Visible="false" ForeColor="Red"/>
</asp:Content>


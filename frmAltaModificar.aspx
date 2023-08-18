<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmAltaModificar.aspx.cs" Inherits="FichaTecnica.frmAltaModificar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <asp:Label ID="lblId" runat="server" Text="Introduzca ID del empleado:"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            </div>
            <div>
                <div>
                    <asp:Label ID="lblNombre" runat="server" Text="Nombre:"></asp:Label>
                    <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="lblApellido" runat="server" Text="Apellido:"></asp:Label>
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="lblSalario" runat="server" Text="Salario:"></asp:Label>
                    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" />
            </div>

        </div>
    </form>
</body>
</html>

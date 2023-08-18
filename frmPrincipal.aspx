<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="frmPrincipal.aspx.cs" Inherits="FichaTecnica.frmPrincipal" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="container">
        <div class="row espaciado centrar">
            <div class="col margen"><h1>GESTION DE EMPLEADOS</h1></div>
        </div>
        <div class="row">
            <div class="col align-self-end">
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnCrear" runat="server" Text="Crear" CssClass="btn btn-success button form-control" OnClick="btnCrear_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="col-md-4 align-self-start">
                <asp:TextBox ID="txtBusqueda" CssClass="ml-auto form-control" runat="server"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnBusqueda" CssClass="btn btn-secondary" runat="server" Text="Buscar" OnClick="btnBusqueda_Click" />
            </div>
        </div>
        <div class="row espaciado">
            <div class="table small">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table>
                            <asp:Repeater ID="rptDatos" runat="server">
                                <HeaderTemplate>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Apellido</th>
                                        <th>Email</th>
                                        <th>Salario</th>
                                        <th>Acciones</th>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr class="separador">
                                        <td><%# Eval("id") %></td>
                                        <td><%# Eval("nombre") %></td>
                                        <td><%# Eval("apellido") %></td>
                                        <td><%# Eval("email") %></td>
                                        <td><%# Eval("salario") %></td>
                                        <td>

                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                <ContentTemplate>
                                                    <asp:LinkButton ID="btnEditar" CommandName="Update" CommandArgument='<%# Eval ("id") %>' OnCommand="btnEditar_Command" runat="server" CssClass="btn btn-sm brn-primary">
                                                         <i class="fas fa-edit"></i>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnEliminar" OnClientClick="return confirm('¿Desea eliminar el empleado?');" CommandName="Delete" CommandArgument='<%# Eval ("id") %>' OnCommand="btnEliminar_Command" runat="server" CssClass="btn btn-sm brn-danger">
                                                        <i class="far fa-trash-alt"></i>
                                                    </asp:LinkButton>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="btnEditar" EventName="click" />
                                                    <asp:AsyncPostBackTrigger ControlID="btnEliminar" EventName="click" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                            
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="modal fade" id="mymodal" data-bakcdrop="false" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Crear - Modificar Empleado</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div>
                                    <asp:Label ID="lblNombre" runat="server" Text="Nombre"></asp:Label>
                                    <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
                                    
                                </div>
                                <div>
                                    <asp:Label ID="lblApellido" runat="server" Text="Apellido"></asp:Label>
                                    <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div>
                                    <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div>
                                    <asp:Label ID="lblSalario" runat="server" Text="Salario"></asp:Label>
                                    <asp:TextBox ID="txtSalario" CssClass="form-control" runat="server"></asp:TextBox>
                                   
                                </div>
                                <asp:HiddenField ID="hid" runat="server" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnGuardar" runat="server" class="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" OnClientClick="return validarControles();"/> 
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnGuardar" EventName="click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                 
                            </div>
                        </div>
                    </div>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

    </main>
    <script type="text/javascript">
        function openModal() {
            $('#mymodal').modal('show');
        }
        function hideModal() {
            $('#mymodal').modal('hide');
        }
        //function confirmDelete() {
        //    Swal.fire({
        //        title: '¿Desea eliminar este empleado?',
        //        icon: 'warning',
        //        showCancelButton: true,
        //        confirmButtonColor: '#3085d6',
        //        cancelButtonColor: '#d33',
        //        confirmButtonText: 'Sí, eliminar'
        //    }).then((result) => {
        //        return true;
        //        if (result.isConfirmed) {
                    
        //            Toastify({
        //                className: "notificacion",
        //                text: "Se ha eliminado el registro",
        //                duration: 2000
        //            }).showToast();
        //        }
                
        //    }) 
        //    return false;
        //}
        

        function soloLetras(cadena) {
            var soloLetras = /^[A-Za-z]+$/;
            return soloLetras.test(cadena);
        }
        function validarControles() {
            var txtNombre = document.getElementById('<%=txtNombre.ClientID%>').value;
            var txtApellido = document.getElementById('<%=txtApellido.ClientID%>').value;
            var txtEmail = document.getElementById('<%=txtEmail.ClientID%>').value;
            var txtSalario = document.getElementById('<%=txtSalario.ClientID%>').value;

            var formatoEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            var formatoDecimal = /^\d+(,\d+)?$/;


            if (txtNombre.trim() === "" && txtApellido.trim() === "" && txtEmail.trim() === "" && txtSalario.trim() === "") {
                alertRequeridos()
                return false; 
            }
            if (!formatoEmail.test(txtEmail)) {
                alertEmail();
                return false;
            }
            if (!formatoDecimal.test(txtSalario)) {
                alertSalario();
                return false;
            }
            if (!soloLetras(txtNombre) || !soloLetras(txtApellido)) {
                alertSoloLetras();
                return false;
            }
            return true; 
        }
        function alertRequeridos() {
            Toastify({
                text: "Todos los campos son obligatorios",
                duration: 2000
            }).showToast();
        }
        function alertEmail() {
            Toastify({
                text: "Formato de email no valido",
                duration: 2000
            }).showToast();
        }
        function alertSalario() {
            Toastify({
                text: "Debe introducir solo numeros decimales(,) en el salario",
                duration: 2000
            }).showToast();
        }
        function alertSoloLetras() {
            Toastify({
                text: "Debe introducir solo letras en Nombre y Apellido",
                duration: 2000
            }).showToast();
        }

        function Error() {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Algo falló, intente de nuevo más tarde'
            })
        }
    </script>
</asp:Content>

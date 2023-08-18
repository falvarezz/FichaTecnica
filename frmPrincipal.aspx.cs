using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace FichaTecnica
{
    public partial class frmPrincipal : System.Web.UI.Page
    {
        Empleados empleado = new Empleados();
        Empleados emp = new Empleados();
        DataTable tEmpleados = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            ActualizarGrilla();
        }

        protected void btnEliminar_Command(object sender, CommandEventArgs e)
        {
            //obtener id del registro 
            string id = e.CommandArgument.ToString();
            emp = new Empleados(); 
            emp.Eliminar(id);
            ActualizarGrilla();
        }
        private void ActualizarGrilla()
        {
            tEmpleados = emp.GetEmpleados();
            rptDatos.DataSource = tEmpleados;
            rptDatos.DataBind();
        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {

            hid.Value = "";
            LimpiarControles();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "openModal", "openModal();", true);

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "hideModal", "hideModal()", true);
                    //Empleados emp = new Empleados();
                    //emp = new Empleados();

                    emp.Nombre = txtNombre.Text;
                    emp.Apellido = txtApellido.Text;
                    emp.Email = txtEmail.Text;
                    emp.Salario = Convert.ToDecimal(txtSalario.Text);

                    if (!string.IsNullOrEmpty(hid.Value))
                    {
                        string id = hid.Value;
                        emp.Modificar(id);
                    }
                    else
                    {
                        emp.Crear();
                    }

                    hid.Value = "";
                    LimpiarControles();
                    ActualizarGrilla();
                    Response.Redirect(Request.Url.ToString());
                
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "abrirError", "Error();", true);
            }
        }
        private void LimpiarControles()
        {
            txtApellido.Text = "";
            txtNombre.Text = "";
            txtEmail.Text = "";
            txtSalario.Text = "";
        }

        protected void btnEditar_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            hid.Value = id;
            try
            {
                emp.BuscarEmpleado(id);
                //asignacion de valores del registro a los campos de la ventana modal
                txtNombre.Text = emp.Nombre;
                txtApellido.Text = emp.Apellido;
                txtEmail.Text = emp.Email; 
                txtSalario.Text = emp.Salario.ToString();

                //abrir ventana modal
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "openModal", "openModal();", true);
                
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "abrirError", "Error();", true);
            }
        }
        protected void txtBusqueda_TextChanged(object sender, EventArgs e)
        {
            Busqueda();
        }
        protected void btnBusqueda_Click(object sender, EventArgs e)
        {
            Busqueda();
        }
        //Funcion de busqueda con LINQ
        private void Busqueda()
        {
            if (!string.IsNullOrEmpty(txtBusqueda.Text))
            {
                string valor = txtBusqueda.Text;
                tEmpleados = empleado.GetEmpleados();
                EnumerableRowCollection<DataRow> query = from empleados in tEmpleados.AsEnumerable()
                                                         where string.Equals(empleados.Field<string>("nombre"), valor, StringComparison.OrdinalIgnoreCase)
                                                         select empleados;

                DataView view = query.AsDataView();
                rptDatos.DataSource = view;
                rptDatos.DataBind();
            }
            else
            {
                ActualizarGrilla();
            }
        }

    }
}
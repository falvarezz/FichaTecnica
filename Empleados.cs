using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;


namespace FichaTecnica
{
    public class Empleados
    {
        //objetos de conexion
        private SqlConnection conector;
        private SqlCommand comando;
        private SqlDataReader dr;
        private string sql;
        private DataTable tEmpleados;
        private SqlDataReader tReader; 

        //atributos y propiedades
        private decimal salario;
        private string nombre, apellido, email;

        public string Nombre
        {
            get => nombre; set => nombre = value;
        }
        public string Apellido
        {
            get => apellido; set => apellido = value;
        }
        public string Email
        {
            get => email; set => email = value;
        }
        public decimal Salario
        {
            get => salario; set => salario = value;
        }
        //constructor, inicializo los objetos de conexion 
        public Empleados()
        {
            conector = new SqlConnection(ConfigurationManager.ConnectionStrings["EmpresaConnectionString"].ConnectionString);
            comando = new SqlCommand();
            tEmpleados = new DataTable();
            sql = "";
            comando.Connection = conector;
            comando.CommandType = CommandType.Text;
        }

        //listar empleados
        public DataTable GetEmpleados()
        {
            sql = "SELECT * FROM Empleados";
            comando.CommandText = sql;
            conector.Open();

            dr = comando.ExecuteReader();
            tEmpleados.Load(dr);
            conector.Close();
            return tEmpleados;
        }
        public void Crear()
        {
            sql = "INSERT INTO Empleados VALUES(@nombre, @apellido, @email, @salario)";
            comando.CommandText = sql;
            conector.Open();
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@nombre", nombre);
            comando.Parameters.AddWithValue("@apellido", apellido);
            comando.Parameters.AddWithValue("@email", email);
            comando.Parameters.AddWithValue("@salario", salario);

            comando.ExecuteNonQuery();
            conector.Close();
        }
        public void Modificar(string id)
        {
            sql = "UPDATE Empleados SET nombre=@nombre, apellido=@apellido, email=@email, " +
                  "salario=@salario  WHERE id=@id";
            comando.CommandText = sql;
            conector.Open();
            comando.Parameters.Clear();

            comando.Parameters.AddWithValue("@id", id);
            comando.Parameters.AddWithValue("@nombre", nombre);
            comando.Parameters.AddWithValue("@apellido", apellido);
            comando.Parameters.AddWithValue("@email", email);
            comando.Parameters.AddWithValue("@salario", salario);

            comando.ExecuteNonQuery();
            conector.Close();
        }
        public void BuscarEmpleado(string id)
        {
            sql = "SELECT * FROM Empleados WHERE id=@id";
            comando.CommandText = sql;
            conector.Open();
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@id", id);

            SqlDataReader dr = comando.ExecuteReader();
            if (dr.HasRows == true)
            {
                dr.Read();
                nombre = dr["nombre"].ToString();
                apellido = dr["apellido"].ToString();
                email = dr["email"].ToString();
                salario = Convert.ToDecimal(dr["salario"]);
            }
            dr.Close();
            conector.Close();
        }
        public void Eliminar(string id)
        {
            sql = "DELETE FROM Empleados WHERE id=@id";
            comando.CommandText = sql;
            conector.Open();
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@id", id);
            comando.ExecuteNonQuery();
            conector.Close();
        }
    }
}
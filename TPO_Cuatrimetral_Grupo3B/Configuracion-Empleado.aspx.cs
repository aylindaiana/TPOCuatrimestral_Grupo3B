using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Manager;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class Configuracion_Empleado : System.Web.UI.Page
    {
        public List<Empleado> listaEmpleados;
        List<Empleado> listaEmpleadosFiltrada;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarLista();
            }
        }

        protected void btnBuscarLegajo_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnBuscarDni_Click(object sender, EventArgs e)
        {

        }

        protected void btnBuscarApellido_Click(object sender, EventArgs e)
        {

        }

        protected void btnNuevoEmpleado_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarEmpleado.aspx",false);
        }

        protected void btnEditarEmpleado_Click(object sender,EventArgs e) 
        {
            EmpleadoManager manager = new EmpleadoManager();
            Button btnEditar = (Button)sender;
            string legajo = btnEditar.CommandArgument;
            string dni = manager.ObtenerDNI(legajo);
            
            Response.Redirect("ModificarEmpleado.aspx?dni=" + dni, false);

        }

        protected void btnBajaEmpleado_Click(object sender, EventArgs e)
        {
            Button btnEditar = (Button)sender;
            string legajo = btnEditar.CommandArgument;

            EmpleadoManager manager = new EmpleadoManager();

            manager.Baja(legajo);

            Response.Write("<script>alert('Empleado Eliminado Correctamente...." + "');</script>");

            CargarLista();

        }

        //Funciones

        private void CargarLista()
        { 
            EmpleadoManager empleados = new EmpleadoManager();
            listaEmpleados = empleados.ObtenerTodos();
            repeaterEmpleados.DataSource = listaEmpleados;
            repeaterEmpleados.DataBind();

        }
    }
}
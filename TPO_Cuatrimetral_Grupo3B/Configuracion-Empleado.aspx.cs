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

        protected void btnEditarEmpleado_Click(object sender,EventArgs e) 
        {
            Button btnEditar = (Button)sender;
            string legajo = btnEditar.CommandArgument;

            Response.Redirect("ModificarUsuario.aspx?id=" + legajo, false);
        }

        protected void btnBajaEmpleado_Click(object sender, EventArgs e)
        {

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
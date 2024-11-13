using Dominio;
using Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class AgregarPaciente : System.Web.UI.Page
    {
        List<Planes> listaPlanes;
        string numAfiliado;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                CargarDatosPlanes();
                ObtenerNumeroAfiliado();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            //guardar datos
        }

        protected void btnCacelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracion-Paciente.aspx",false);
        }

        //Funciones

        private void CargarDatosPlanes()
        {
            PlanesManager planes = new PlanesManager();
            listaPlanes = planes.ObtenerTodos();

            ddlPlanes.DataSource = listaPlanes;
            ddlPlanes.DataTextField = "Nombre_Plan";
            ddlPlanes.DataValueField = "Id_Plan";
            ddlPlanes.DataBind();
        }

        private void ObtenerNumeroAfiliado()
        {
            PacienteManager pacientes = new PacienteManager();
            numAfiliado = pacientes.ObtenerNuevoNumAfiliado();

            txtNroAfiliado.Text = numAfiliado;
            txtNroAfiliado.ReadOnly = true;
        }
    }
}
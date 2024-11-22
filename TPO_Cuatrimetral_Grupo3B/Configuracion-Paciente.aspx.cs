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
    public partial class Configuracion_Paciente : System.Web.UI.Page
    {
        public List<Paciente> listaPacientes = new List<Paciente>();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CargarLista();
            }

        }

        protected void btnBuscarAfiliado_Click(object sender, EventArgs e)
        {

        }

        protected void btnBuscarDni_Click(object sender, EventArgs e)
        {

        }

        protected void btnBuscarApellido_Click(object sender, EventArgs e)
        {

        }

        protected void btnEditarPaciente_Click(object sender, EventArgs e)
        {
            PacienteManager manager = new PacienteManager();
            Button btnEditar = (Button)sender;
            string nroAfiliado = btnEditar.CommandArgument;
            string dni = manager.ObtenerDNI(nroAfiliado);

            Response.Redirect("ModificarPaciente.aspx?dni=" + dni, false);

        }

        protected void btnBajaPaciente_Click(object sender, EventArgs e)
        {
            Button btnEditar = (Button)sender;
            string nroAfiliado = btnEditar.CommandArgument;

            PacienteManager manager = new PacienteManager();

            manager.Baja(nroAfiliado);

            Response.Write("<script>alert('Empleado Eliminado Correctamente...." + "');</script>");

            CargarLista();
        }

        protected void btnNuevoPaciente_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarPaciente.aspx");
        }

        //Funciones auxiliares

        private void CargarLista()
        {
            PacienteManager pacientes = new PacienteManager();
            listaPacientes = pacientes.ObtenerTodos();
            repeaterPacientes.DataSource = listaPacientes;
            repeaterPacientes.DataBind();
        }
    }
}
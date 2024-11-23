using Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Manager;
using Dominio;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class Configuracion_Especialidades : System.Web.UI.Page
    {
        public List<Especialidades> listaEspecialidades;

        protected void Page_Load(object sender, EventArgs e)
        {
            lblMensaje.Text = string.Empty;
            if (!IsPostBack)
            {
                CargarEspecialidades();

            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            EspecialiadadesManager manager = new EspecialiadadesManager();
            Especialidades especialidad = new Especialidades();
            lblMensaje.Text = string.Empty;
            string nuevaEspecialidad = txtNuevaEspecialidad.Value;

            if (string.IsNullOrWhiteSpace(nuevaEspecialidad))
            {
                lblMensaje.Text = "El nombre de la especialidad no puede estar vacio";
                return;
            }
            try
            { 
                especialidad.Nombre = txtNuevaEspecialidad.Value.ToString();
                manager.AgregarNuevaEspecialidad(especialidad);
                CargarEspecialidades();
                txtNuevaEspecialidad.Value = string.Empty;
                lblMensaje.Text = "Especialidad agregada correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error al agregar la especialidad. Intenta nuevamente.";
            }
        }

        protected void btnEliminar_Click(Object sender, EventArgs e)
        {
            lblMensaje.Text = string.Empty;
            Button btnEliminar = (Button)sender;
            int idEspecialidad = int.Parse(btnEliminar.CommandArgument);

            try
            {
                EspecialiadadesManager manager = new EspecialiadadesManager();
                Especialidades esp = new Especialidades { Id = idEspecialidad };
                int resultado;
                manager.EliminarEspecialidad(esp, out resultado);
                if (resultado == 1)
                {
                    lblMensaje.Text = "Especialidad eliminada correctamente.";
                }
                else if (resultado == 0)
                {
                    lblMensaje.Text = "No se puede eliminar la especialidad porque está asignada a un médico.";
                }
                else
                {
                    lblMensaje.Text = "Ocurrió un error inesperado al eliminar la especialidad.";
                }
                CargarEspecialidades();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //Funciones:

        private void CargarEspecialidades()
        {
            EspecialiadadesManager especialidades = new EspecialiadadesManager();
            List<Especialidades> listaEspecialidades = especialidades.ObtenerTodos();
            rptEspecialidades.DataSource = listaEspecialidades;
            rptEspecialidades.DataBind();
        }
    }
}
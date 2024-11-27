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
                

                if (Session["User"] != null)
                {
                    Usuario usuario = (Usuario)Session["User"];

                    if (usuario.Tipo == UserType.ADMIN)
                    {
                        CargarEspecialidades();
                    }
                    else if (usuario.Tipo == UserType.RECEPCIONISTA)
                    {
                        CargarEspecialidades();
                    }
                    else if (usuario.Tipo == UserType.MEDICO)
                    {
                        Response.Redirect("DenegarPermiso.aspx", false);
                    }

                    else if (usuario.Tipo == UserType.PACIENTE)
                    {
                        Response.Redirect("DenegarPermiso.aspx", false);
                    }

                }
                else
                {
                    Session.Add("error", "Usted no tiene permiso para acceder");
                    Response.Redirect("DenegarPermiso.aspx", false);
                }
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
        protected void btnDesactivar_Click(Object sender, EventArgs e)
        {
            lblMensaje.Text = string.Empty;

            Button btnDesactivar= (Button)sender;
            int idEspecialidad = int.Parse(btnDesactivar.CommandArgument);

            try
            {
                EspecialiadadesManager manager = new EspecialiadadesManager();
                Especialidades esp = new Especialidades();

                esp.Id = idEspecialidad;
                esp.Estado = false;

                manager.BajaAltaEsp(esp);

                lblMensaje.Text = "La especialidad fue desactivada correctamente.";
                CargarEspecialidades();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error al intentar desactivar la especialidad: " + ex.Message;
            }
        }


        protected void btnReactivar_Click(Object sender, EventArgs e)
        {
            lblMensaje.Text = string.Empty;

            Button btnReactivar = (Button)sender;
            int idEspecialidad = int.Parse(btnReactivar.CommandArgument);

            try
            {
                EspecialiadadesManager manager = new EspecialiadadesManager();
                Especialidades esp = new Especialidades();

                esp.Id = idEspecialidad;
                esp.Estado = true;
                       
                manager.BajaAltaEsp(esp);

                lblMensaje.Text = "La especialidad fue reactivada correctamente.";

                CargarEspecialidades();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error al intentar reactivar la especialidad: " + ex.Message;
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
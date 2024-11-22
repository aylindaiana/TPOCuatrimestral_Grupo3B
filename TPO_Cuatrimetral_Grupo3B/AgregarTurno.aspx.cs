using Dominio;
using Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebSockets;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class AgregarTurno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                EspecialiadadesManager especialiadades = new EspecialiadadesManager();
                List<Especialidades> listaEspecialidades = especialiadades.ObtenerTodos();

                especialidadSelect.DataSource = listaEspecialidades;
                especialidadSelect.DataTextField = "Especialidad";
                especialidadSelect.DataValueField = "Id";
                especialidadSelect.DataBind();

            }
        }
        protected void btnVerEspecialistas_Click(object sender, EventArgs e)
        {

            pnlInfoEspecialista.Visible = true;
        }
    }
}
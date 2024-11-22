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
    public partial class Configuracion_Sanatorios : System.Web.UI.Page
    {
        public List<Planes> listaPlanes = new List<Planes>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarLista();
            }
        }

        protected void btnNuevoPlan_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarPlan.aspx",false);
        }

        protected void btnEditarPlan_Click(object sender, EventArgs e)
        {
            Button btnEditar = (Button)sender;
            int id = int.Parse(btnEditar.CommandArgument);
            Response.Redirect("ModificarPlan.aspx?id="+id, false);
        }

        protected void btnBajaPlan_Click(object sender, EventArgs e)
        {

        }

        private void CargarLista()
        {
            PlanesManager pacientes = new PlanesManager();
            listaPlanes = pacientes.ObtenerTodos();
            repeaterPlanes.DataSource = listaPlanes;
            repeaterPlanes.DataBind();
        }
    }
}
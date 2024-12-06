using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.sesionActiva(Session["User"])) 
            {
                Response.Redirect("Login.aspx",false);
            }
            if (!IsPostBack)
            {
                Usuario usuario = (Usuario)Session["User"];
                if (usuario != null && usuario.Tipo == UserType.PACIENTE)
                {
                    liInfoPlan.Visible = false;
                    liDivider1.Visible = false;
                    liConfigTurnos.Visible = false;
                    liDivider2.Visible = false;
                    liConfigPacientes.Visible = false;
                    liConfigEmpleados.Visible = false;
                    liConfigEspecialidades.Visible = false;
                    liAgregarPlanes.Visible = false;
                }
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx", false);
        }
    }
}
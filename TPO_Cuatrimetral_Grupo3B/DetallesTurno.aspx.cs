using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class DetallesTurno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnReprogramar_Click(object sender, EventArgs e)
        {
            // reprogramar el turno- update.
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // guardar los cambios realizados en las observaciones del medico.
            string observaciones = txtObsMedico.Text;
            // guardar observaciones en la base de datos.
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // cancelar el turno.
            Response.Redirect("Home.aspx");
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarTurno.aspx");
        }

    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class Configuracion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnBuscarLegajo_Click(object sender, EventArgs e)
        {
            string legajo = txtLegajo.Text;
        }

        protected void btnBuscarDni_Click(object sender, EventArgs e)
        {
            string dni = txtDni.Text;
        }

        protected void btnBuscarApellido_Click(object sender, EventArgs e)
        {
            string apellido = txtApellido.Text;
        }
    }
}
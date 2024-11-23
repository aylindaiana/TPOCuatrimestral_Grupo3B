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
    public partial class CambioContraseña : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCambiar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtengo el usuario autenticado de la sesion
                var usuarioAutenticado = (Usuario)Session["User"];

                // Obtengo las contraseñas ingresadas
                string contraseñaVieja = ContraseñaVieja.Text;
                string contraseñaNueva = ContraseñaNueva.Text;

                UsuarioManager usuarioM = new UsuarioManager();

                // Llamo al metodo para cambiar la contraseña
                usuarioM.CambiarPass(usuarioAutenticado.User, contraseñaNueva);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error al cambiar la contraseña: {ex.Message}');", true);
            }
        }
    }
}

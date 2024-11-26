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
                EmailService emailService = new EmailService();

                var usuarioAutenticado = (Usuario)Session["User"];

                string contraseñaVieja = ContraseñaVieja.Text;
                string contraseñaNueva = ContraseñaNueva.Text;

                UsuarioManager usuarioM = new UsuarioManager();

                string mail= usuarioM.BuscarGmail(usuarioAutenticado.User);

                usuarioM.CambiarPass(usuarioAutenticado.User, contraseñaNueva);

                //lblMensajeExito.Text = mail;   
                emailService.ArmarCorreo(mail);
                emailService.enviarmail();

                Response.Redirect("Exito.aspx");
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error al cambiar la contraseña: {ex.Message}');", true);
            }
        }
    }
}

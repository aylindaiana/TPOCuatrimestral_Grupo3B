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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnValidate_Click(object sender, EventArgs e)
        {
            UsuarioManager usuarioManager = new UsuarioManager();
            Usuario nuevoUsuario = usuarioManager.Login(txtUsuario.Text,txtPassword.Text);

            if (!nuevoUsuario.Estado)
            {
                txtUsuario.CssClass += " is-invalid";
                userErrorMsg.Style["display"] = "block";
                txtPassword.CssClass += " is-invalid";
                errorMessage.Style["display"] = "block";
                
            }
            else
            {
                txtUsuario.CssClass = txtUsuario.CssClass.Replace(" is-invalid", "");
                userErrorMsg.Style["display"] = "none";
                txtPassword.CssClass = txtPassword.CssClass.Replace(" is-invalid", "");
                errorMessage.Style["display"] = "none";

                //guardar datos de usuario en sesion

                Response.Redirect("Home.aspx");
                //Response.Write("<script>alert('Bienvenido al sistema!');</script>");
            }
        
        }
    }
}
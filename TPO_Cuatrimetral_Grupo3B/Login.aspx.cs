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
        Usuario nuevoUsuario;

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnValidate_Click(object sender, EventArgs e)
        {
            UsuarioManager usuarioManager = new UsuarioManager();

            try
            {
                nuevoUsuario = usuarioManager.Login(txtUsuario.Text, txtPassword.Text);

                if (nuevoUsuario.Estado)
                {
                    ObtenerDatosUsuario();
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    InputError();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }


        }

        private void InputError()
        {
            txtUsuario.CssClass += " is-invalid";
            userErrorMsg.Style["display"] = "block";
            txtPassword.CssClass += " is-invalid";
            errorMessage.Style["display"] = "block";
        }

        private void ObtenerDatosUsuario() 
        {
            Session.Add("User", nuevoUsuario);

            if (nuevoUsuario.Tipo != UserType.PACIENTE)
            {
                EmpleadoManager empleado = new EmpleadoManager();
                Session.Add("Empleado",empleado.Obtener(nuevoUsuario.User));
            }
            else
            {
                PacienteManager paciente = new PacienteManager();
                Session.Add("Paciente",paciente.Obtener(nuevoUsuario.User));
            }
        }
    }
}
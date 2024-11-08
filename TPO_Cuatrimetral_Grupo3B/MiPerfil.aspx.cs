using Dominio;
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
    public partial class MiPerfil : System.Web.UI.Page
    {
        Persona persona;
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Seguridad.NivelAcceso(Session["User"]) == UserType.PACIENTE)
            {
                persona = (Persona)Session["Paciente"];
            }
            else
            {
                persona = (Persona)Session["Empleado"];
            }

            if (persona != null)
            {
                txtNombre.Text = persona.Nombre;
                txtApellido.Text = persona.Apellido;
                txtDNI.Text = persona.Dni;
                txtFechaNac.Text = persona.Fecha_Nac.ToString("yyyy-MM-dd");
                txtCalle.Text = persona.Direccion.ToString();
                
            }
        }
    }
}
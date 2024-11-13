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
                Paciente pac = (Paciente)persona;
                if(persona != null)txtLegajo.Text = pac.Numero_afiliado;
                LblLegajo.Text = "Numero Afiliado";
            }
            else
            {
                persona = (Persona)Session["Empleado"];
                Empleado emp = (Empleado)persona;
                if (persona != null) txtLegajo.Text = emp.Legajo.ToString();
                LblLegajo.Text = "Legajo";
            }

            if (persona != null)
            {
                txtNombre.Text = persona.Nombre;
                txtApellido.Text = persona.Apellido;
                txtDNI.Text = persona.Dni;
                txtFechaNac.Text = persona.Fecha_Nac.ToString("yyyy-MM-dd");
                txtCalle.Text = persona.Direccion.Calle;
                txtNumero.Text = persona.Direccion.Numero;
                txtLocalidad.Text = persona.Direccion.Localidad;
                txtCodPostal.Text = persona.Direccion.CodigoPostal;
                txtTelefono.Text = persona.Telefono;
                txtEmail.Text = persona.Email;
                
            }
        }
    }
}
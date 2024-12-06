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

            if (!IsPostBack)
            {
                if (Seguridad.NivelAcceso() == UserType.PACIENTE)
                {
                    persona = (Persona)Session["Paciente"];
                    Paciente pac = (Paciente)persona;
                    if (persona != null) txtLegajo.Text = pac.Numero_afiliado;
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

                    DeshabilitarCampos();
                }
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            txtNombre.Enabled = true;
            txtApellido.Enabled = true;
            txtLegajo.Enabled = false; 
            txtDNI.Enabled = true;
            txtFechaNac.Enabled = true;
            txtCalle.Enabled = true;
            txtNumero.Enabled = true;
            txtLocalidad.Enabled = true;
            txtCodPostal.Enabled = true;
            txtTelefono.Enabled = true;
            txtEmail.Enabled = true;

            btnGuardar.Enabled = true;
            btnCancelar.Enabled = true;
            btnEditar.Enabled = false;
        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Persona persona = new Persona
            {
                Direccion = new Direccion() 
            };
            if (persona == null)
            {
                Response.Redirect("Login.aspx");
            }
            persona.Nombre = txtNombre.Text;
            persona.Apellido = txtApellido.Text;
            persona.Dni= txtDNI.Text;
            persona.Fecha_Nac = DateTime.Parse(txtFechaNac.Text);
            persona.Direccion = new Direccion
            {
                Calle = txtCalle.Text,
                Numero = txtNumero.Text,
                Localidad = txtLocalidad.Text,
                CodigoPostal = txtCodPostal.Text
            };
            persona.Telefono = txtTelefono.Text;
            persona.Email = txtEmail.Text;

            PersonaManager personaManager = new PersonaManager();
            personaManager.ActualizarPersona(persona);

            DeshabilitarCampos();
            Response.Redirect("Exito.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            if (Seguridad.NivelAcceso() == UserType.PACIENTE)
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
                txtCalle.Text = persona.Direccion.Calle;
                txtNumero.Text = persona.Direccion.Numero;
                txtLocalidad.Text = persona.Direccion.Localidad;
                txtCodPostal.Text = persona.Direccion.CodigoPostal;
                txtTelefono.Text = persona.Telefono;
                txtEmail.Text = persona.Email;
            }

            DeshabilitarCampos();
        }

        // Funciones:

        private void DeshabilitarCampos()
        {
            txtNombre.Enabled = false;
            txtApellido.Enabled = false;
            txtLegajo.Enabled = false;
            txtDNI.Enabled = false;
            txtFechaNac.Enabled = false;
            txtCalle.Enabled = false;
            txtNumero.Enabled = false;
            txtLocalidad.Enabled = false;
            txtCodPostal.Enabled = false;
            txtTelefono.Enabled = false;
            txtEmail.Enabled = false;

            btnGuardar.Enabled = false;
            btnCancelar.Enabled = false;
            btnEditar.Enabled = true;
        }


    }
}
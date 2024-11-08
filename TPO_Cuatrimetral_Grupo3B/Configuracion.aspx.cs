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
    public partial class Configuracion : System.Web.UI.Page
    {
        Persona persona;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
                EspecialiadadesManager especialidades = new EspecialiadadesManager();
                List<string> lista_especialidades = especialidades.ObtenerTodos();

                lsbxEspecialidades.DataSource = lista_especialidades;
                lsbxEspecialidades.DataBind();
            }
        }


        /*---------------BOTONES FILTROS---------------*/
        protected void btnBuscarDni_Click(object sender, EventArgs e)
        {
            
            if (!string.IsNullOrEmpty(txtDniFiltro.Text))
            {
                BuscarDatosUsuario(txtDniFiltro.Text);
                MostrarDatos();

            }

        }
        protected void btnBuscarLegajo_Click(object sender, EventArgs e) 
        {
            if (!string.IsNullOrEmpty(txtLegajoFiltro.Text))
            {
                int legajo = Convert.ToInt32(txtLegajoFiltro.Text);

                string dni = ObtenerDni(legajo);
                BuscarDatosUsuario(dni);
                MostrarDatos();

            }
        }
        protected void btnBuscarApellido_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtApellidoFiltro.Text))
            {
                string dni = ObtenerDni(txtApellidoFiltro.Text);
                BuscarDatosUsuario(dni);
                MostrarDatos();
            }
        }
        /*---------------FIN BOTONES FILTROS---------------*/


        private string ObtenerDni(string Apellido) 
        {
            PersonaManager aux = new PersonaManager();
            return aux.ObtenerDNI(Apellido);
        }

        private string ObtenerDni(int Legajo)
        {
            EmpleadoManager aux = new EmpleadoManager();
            return aux.ObtenerDNI(Legajo);
        }

        private void BuscarDatosUsuario(string dni)
        {
            PersonaManager personamanager = new PersonaManager();
            
            try
            {
                persona = personamanager.BuscarPorDNI(dni);

                if (persona.Nivel_Acceso == UserType.PACIENTE)
                {
                    PacienteManager paciente = new PacienteManager();
                    persona = paciente.Obtener(dni);
                }
                else
                {
                    EmpleadoManager empleado = new EmpleadoManager();
                    persona = empleado.Obtener(dni);
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            

        }

        private void MostrarDatos() 
        {
            txtNombre.Text = persona.Nombre;
            txtApellido.Text = persona.Apellido;
            txtDni.Text = persona.Dni;
            txtFechaNacimiento.Text = persona.Fecha_Nac.ToString("yyyy-MM-dd");
            txtCalle.Text = persona.Direccion.Calle;
            txtNumero.Text = persona.Direccion.Numero;
            txtLocalidad.Text = persona.Direccion.Localidad;
            txtCodigoPostal.Text = persona.Direccion.CodigoPostal;
            txtTelefono.Text = persona.Telefono;
            txtEmail.Text = persona.Email;


            if (persona.Nivel_Acceso == UserType.PACIENTE)
            {
                MostrarDatosPaciente((Paciente)persona);
            }
            else
            {
                MostrarDatosEmpleado((Empleado)persona);
            }
        }

        private void MostrarDatosPaciente(Paciente pac)
        {
            lbl_legajo.Text = "Numero Afiliado";
            txtLegajo.Text = pac.Numero_afiliado;
            //agregar plan
        }

        private void MostrarDatosEmpleado(Empleado emp)
        {

            lbl_legajo.Text = "Legajo";
            txtLegajo.Text = emp.Legajo.ToString();
            //especialidades y turnos
        }

    }

}

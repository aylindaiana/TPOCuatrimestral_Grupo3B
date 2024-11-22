using Dominio;
using Manager;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class ModificarPaciente : System.Web.UI.Page
    {
        List<Planes> listaPlanes = new List<Planes>();
        static int id_direccion;
        string titulo = "Modificar Paciente ";
        string dni;



        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack && Request.QueryString["dni"] != null)
            {
                dni = Request.QueryString["dni"];
                titulo += dni;

                CargarDatos();
                HabilitarEdicion(false);
            }

            LblID.Text = titulo;

        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            PacienteManager manager = new PacienteManager();
            Paciente pacModificado;

            try
            {
                pacModificado = ObtenerNuevosDatos();
                manager.Modificar(pacModificado);

            }
            catch (Exception)
            {
                throw;
            }

            dni = pacModificado.Dni;

            CargarDatos();
            HabilitarEdicion(false);
        }


        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracion-Paciente.aspx", false);
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            HabilitarEdicion(true);
        }

        protected void btnRestrablecerPass_Click(object sender, EventArgs e)
        {
            UsuarioManager manager = new UsuarioManager();

            try
            {
                manager.RestablecerPass(txtDni.Text);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            WindowsMessege("Contraseña Restablecida Exitosamente!");

        }


        //Funciones

        private void HabilitarEdicion(bool estado)
        {
            txtNombre.Enabled = estado;
            txtApellido.Enabled = estado;
            txtAfiliado.Enabled = false;
            txtDni.Enabled = false;
            txtFechaNacimiento.Enabled = estado;
            txtCalle.Enabled = estado;
            txtNumero.Enabled = estado;
            txtLocalidad.Enabled = estado;
            txtTelefono.Enabled = estado;
            txtEmail.Enabled = estado;
            txtCodigoPostal.Enabled = estado;
            ddlPlanes.Enabled = estado;
            btnGuardar.Enabled = estado;
            btnGuardar.Visible = estado;
        }

        private void CargarDatos()
        {
            PacienteManager manager = new PacienteManager();
            Paciente paciente = new Paciente();

            try
            {
                paciente = manager.Obtener(dni);

                txtNombre.Text = paciente.Nombre;
                txtApellido.Text = paciente.Apellido;
                txtDni.Text = paciente.Dni;
                txtFechaNacimiento.Text = paciente.Fecha_Nac.ToString("yyyy-MM-dd");
                id_direccion = paciente.Direccion.Id_direccion;
                txtCalle.Text = paciente.Direccion.Calle;
                txtNumero.Text = paciente.Direccion.Numero;
                txtLocalidad.Text = paciente.Direccion.Localidad;
                txtCodigoPostal.Text = paciente.Direccion.CodigoPostal;
                txtTelefono.Text = paciente.Telefono;
                txtEmail.Text = paciente.Email;
                txtAfiliado.Text = paciente.Numero_afiliado;

                CargarPlanes();

                ddlPlanes.SelectedValue = paciente.Plan.Id_Plan.ToString();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

        }


        private Paciente ObtenerNuevosDatos()
        {
            Paciente paciente = new Paciente();
            int id_plan = int.Parse(ddlPlanes.SelectedValue);

            paciente.Numero_afiliado = txtAfiliado.Text;
            paciente.Dni = txtDni.Text;
            paciente.Nombre = txtNombre.Text;
            paciente.Apellido = txtApellido.Text;
            paciente.Fecha_Nac = DateTime.Parse(txtFechaNacimiento.Text);
            paciente.Direccion.Id_direccion = id_direccion;
            paciente.Direccion.Calle = txtCalle.Text;
            paciente.Direccion.Numero = txtNumero.Text;
            paciente.Direccion.Localidad = txtLocalidad.Text;
            paciente.Direccion.CodigoPostal = txtCodigoPostal.Text;
            paciente.Telefono = txtTelefono.Text;
            paciente.Email = txtEmail.Text;
            paciente.Plan.Id_Plan = id_plan;
            paciente.Nivel_Acceso = UserType.PACIENTE;

            return paciente;
        }


        private void CargarPlanes() 
        {
            PlanesManager manager = new PlanesManager();

            try
            {
                listaPlanes = manager.ObtenerTodos();
                ddlPlanes.DataSource = listaPlanes;
                ddlPlanes.DataTextField = "Nombre_Plan";
                ddlPlanes.DataValueField = "Id_Plan";
                ddlPlanes.DataBind();
            }
            catch (Exception)
            {
                throw;
            }
        
        }

        private void WindowsMessege(string msg)
        {
            Response.Write("<script>alert('" + msg + "');</script>");
        }

    }
}
using Dominio;
using Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class AgregarPaciente : System.Web.UI.Page
    {
        List<Planes> listaPlanes;
        string numAfiliado;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                CargarDatosPlanes();
                ObtenerNumeroAfiliado();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            PacienteManager manager = new PacienteManager();
            Paciente nuevoPaciente = new Paciente();
            int id_plan;

            try
            {
                int.TryParse(ddlPlanes.SelectedValue, out id_plan);

                nuevoPaciente.Nombre = txtNombre.Text;
                nuevoPaciente.Apellido = txtApellido.Text;
                nuevoPaciente.Numero_afiliado = numAfiliado;
                nuevoPaciente.Dni = txtDni.Text;
                nuevoPaciente.Fecha_Nac = DateTime.Parse(txtFechaNacimiento.Text);
                nuevoPaciente.Direccion.Calle = txtCalle.Text;
                nuevoPaciente.Direccion.Numero = txtNumero.Text;
                nuevoPaciente.Direccion.Localidad = txtLocalidad.Text;
                nuevoPaciente.Direccion.CodigoPostal = txtCodigoPostal.Text;
                nuevoPaciente.Telefono = txtTelefono.Text;
                nuevoPaciente.Email = txtEmail.Text;
                nuevoPaciente.Plan.Id_Plan = id_plan;

                manager.Agregar(nuevoPaciente);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

        }

        protected void btnCacelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracion-Paciente.aspx",false);
        }

        //Funciones

        private void CargarDatosPlanes()
        {
            PlanesManager planes = new PlanesManager();

            try
            {
                listaPlanes = planes.ObtenerTodos();

            }
            catch (Exception ex)
            {

                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            ddlPlanes.DataSource = listaPlanes;
            ddlPlanes.DataTextField = "Nombre_Plan";
            ddlPlanes.DataValueField = "Id_Plan";
            ddlPlanes.DataBind();
        }

        private void ObtenerNumeroAfiliado()
        {
            PacienteManager pacientes = new PacienteManager();

            try
            {
                numAfiliado = pacientes.ObtenerNuevoNumAfiliado();

            }
            catch (Exception ex)
            {

                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            txtNroAfiliado.Text = numAfiliado;
            txtNroAfiliado.ReadOnly = true;
        }

    }
}
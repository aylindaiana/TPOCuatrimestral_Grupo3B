using Dominio;
using Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
            string errores = ValidarFormulario();

            if (!string.IsNullOrEmpty(errores))
            {
                lblErrores.Text = errores;
                lblErrores.Visible = true;
                return;
            }

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
                lblErrores.Text = "Paciente agregado exitosamente.";
                lblErrores.CssClass = "text-success";
                lblErrores.Visible = true;
            }
            catch (Exception ex)
            {
                lblErrores.Text = "Error: " + ex.Message;
                lblErrores.Visible = true;
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

        private string ValidarFormulario()
        {
            StringBuilder errores = new StringBuilder();

            if (string.IsNullOrWhiteSpace(txtNombre.Text))
            {
                errores.AppendLine("El nombre es obligatorio.<br/>");
            }
            if (string.IsNullOrWhiteSpace(txtApellido.Text))
            {
                errores.AppendLine("El apellido es obligatorio.<br/>");
            }
            if (string.IsNullOrWhiteSpace(txtDni.Text) || txtDni.Text.Length != 8 || !txtDni.Text.All(char.IsDigit))
            {
                errores.AppendLine("El DNI debe ser un número de 8 dígitos.<br/>");
            }
            if (string.IsNullOrWhiteSpace(txtFechaNacimiento.Text) ||
                !DateTime.TryParse(txtFechaNacimiento.Text, out DateTime fechaNacimiento) ||
                fechaNacimiento > DateTime.Now)
            {
                errores.AppendLine("La fecha de nacimiento no es válida o es una fecha futura.<br/>");
            }
            if (string.IsNullOrWhiteSpace(txtEmail.Text) || !txtEmail.Text.Contains("@"))
            { 
                errores.AppendLine("El email no tiene un formato válido.<br/>");
            }
            if (ddlPlanes.SelectedValue == "0")
            {
                errores.AppendLine("Debe seleccionar un plan válido.<br/>");
            }

            return errores.ToString();
            
        }
    }
}
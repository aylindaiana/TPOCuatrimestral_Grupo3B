using Dominio;
using Manager;
using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Drawing;
using System.Linq;
using System.Security.Permissions;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class AgregarEmpleado : System.Web.UI.Page
    {
        public List<Especialidades> listaEspecialidades = new List<Especialidades>();
        public List<Horarios> listaHorarios = new List<Horarios>();
        string legajo;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EmpleadoManager manager = new EmpleadoManager();
                legajo = manager.ObtenerNuevoLegajo();

                CargarDatos();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            lblErrores.Visible = false; // Ocultar errores previos
            lblErrores.Text = "";       // Limpiar texto previo

            string mensajeError;
            if (!ValidarCampos(out mensajeError))
            {
                lblErrores.Text = mensajeError;
                lblErrores.Visible = true; // Mostrar el mensaje de error
                return;
            }

            EmpleadoManager manager = new EmpleadoManager();
            Empleado nuevoEmpleado = new Empleado();

            int Acceso = int.Parse(ddlPuestoTrabajo.SelectedValue);

            try
            {
                if (manager.DniRegistrado(txtDni.Text) != 0)
                {
                    Response.Write("<script>alert('Error: DNI YA REGISTRADO......VERIFIQUE LOS DATOS" + "');</script>");
                    return;
                }

                nuevoEmpleado.Dni = txtDni.Text;
                nuevoEmpleado.Nombre = txtNombre.Text;
                nuevoEmpleado.Apellido = txtApellido.Text;
                nuevoEmpleado.Fecha_Nac = DateTime.Parse(txtFechaNacimiento.Text);
                nuevoEmpleado.Telefono = txtTelefono.Text;
                nuevoEmpleado.Email = txtEmail.Text;
                nuevoEmpleado.Direccion.Calle = txtCalle.Text;
                nuevoEmpleado.Direccion.Numero = txtNumero.Text;
                nuevoEmpleado.Direccion.Localidad = txtLocalidad.Text;
                nuevoEmpleado.Direccion.CodigoPostal = txtCodigoPostal.Text;
                nuevoEmpleado.Nivel_Acceso = (UserType)Acceso;

                manager.Agregar(nuevoEmpleado);

                if (nuevoEmpleado.Nivel_Acceso == UserType.MEDICO)
                    AgregarHorarios();

                LimpiarTextBox();

                lblErrores.Text = "Empleado registrado correctamente.";
                lblErrores.CssClass = "text-success"; 
                lblErrores.Visible = true;

            }
            catch (Exception ex)
            {
                lblErrores.Text = "Error: " + ex.Message;
                lblErrores.CssClass = "text-danger"; 
                lblErrores.Visible = true;
            }

            WindowsMessege("Empleado Registrado Correctaemnte!!");
        }


        protected void btnCacelar_Click(object sender, EventArgs e)
        {
            Session["ListaEsp"] = null;
            Session["ListaHor"] = null;
            Response.Redirect("Configuracion-Empleado.aspx");
        }

        protected void btnGuardarHorarios_Click(object sender, EventArgs e)
        {
            if(!lunes.Checked && !martes.Checked && !miercoles.Checked && !jueves.Checked && !viernes.Checked && !sabado.Checked && !domingo.Checked )
                Response.Write("<script>alert('Error: Debe seleccionar algun dia de la semana"  + "');</script>");

            if(ddlHoraInicio.SelectedIndex == 0 || ddlHoraFinlizacion.SelectedIndex == 0 )
                Response.Write("<script>alert('Error: Seleccione una Hora" + "');</script>");


            VerificarChkList();
        }

        protected void btnEliminarHor_Click(object sender, EventArgs e)
        {
            listaHorarios = (List<Horarios>)Session["ListaHor"];
            Button btn = (Button)sender;
            int index = int.Parse(btn.CommandArgument);

            ActualizarChkList(listaHorarios[index]);
            listaHorarios.RemoveAt(index);

            Session["ListaHor"] = listaHorarios;
            repeaterHorarios.DataSource = listaHorarios;
            repeaterHorarios.DataBind();
        }

        protected void ddlPuestoTrabajo_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Se puede agregar a otra tabla
            LimpiarTextBox();
        }


        //Funciones

        private void CargarDatos()
        {
            EspecialiadadesManager manager = new EspecialiadadesManager();

            try
            {
                listaEspecialidades = manager.ObtenerTodos();
                ddlEspecialidad.DataSource = listaEspecialidades;
                ddlEspecialidad.DataTextField = "Nombre";
                ddlEspecialidad.DataValueField = "Id";
                ddlEspecialidad.DataBind();

                List<TimeSpan> horas = ObtenerHorasDelDia();

                foreach (TimeSpan hora in horas)
                {
                    ddlHoraInicio.Items.Add(new ListItem(hora.ToString(@"hh\:mm"), hora.ToString()));
                    ddlHoraFinlizacion.Items.Add(new ListItem(hora.ToString(@"hh\:mm"), hora.ToString()));
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            txtLegajo.Text = legajo;
            txtLegajo.Enabled = false;

            Session["ListaEsp"] = listaEspecialidades;
            Session["ListaHor"] = listaHorarios;

        }

        public List<TimeSpan> ObtenerHorasDelDia()
        {
            List<TimeSpan> horas = new List<TimeSpan>();

            for (int i = 0; i < 24; i++)
            {
                horas.Add(new TimeSpan(i, 0, 0)); // Hora, minuto, segundo
            }

            return horas;
        }

        private void VerificarChkList() 
        {
            TimeSpan HoraInicio = TimeSpan.Parse(ddlHoraInicio.SelectedValue);
            TimeSpan HoraFinalizacion = TimeSpan.Parse(ddlHoraFinlizacion.SelectedValue);
            int IdEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);
            listaEspecialidades = (List<Especialidades>)Session["ListaEsp"];
            listaHorarios = (List<Horarios>)Session["ListaHor"];

            Especialidades EspSeleccionada = listaEspecialidades.FirstOrDefault(e => e.Id == IdEspecialidad);

            if (lunes.Checked) 
            {
                lunes.Disabled = true;
                lunes.Checked = false;
                listaHorarios.Add(new Horarios(HoraInicio,HoraFinalizacion,"lunes",EspSeleccionada));
            }

            if (martes.Checked)
            {
                martes.Disabled = true;
                martes.Checked = false;
                listaHorarios.Add(new Horarios(HoraInicio, HoraFinalizacion, "martes", EspSeleccionada));
            }

            if (miercoles.Checked)
            {
                miercoles.Disabled = true;
                miercoles.Checked = false;
                listaHorarios.Add(new Horarios(HoraInicio, HoraFinalizacion, "miercoles", EspSeleccionada));
            }

            if (jueves.Checked)
            {
                jueves.Disabled = true;
                jueves.Checked = false;
                listaHorarios.Add(new Horarios(HoraInicio, HoraFinalizacion, "jueves", EspSeleccionada));
            }

            if (viernes.Checked)
            {
                viernes.Disabled = true;
                viernes.Checked = false;
                listaHorarios.Add(new Horarios(HoraInicio, HoraFinalizacion, "viernes", EspSeleccionada));
            }

            if (sabado.Checked)
            {
                sabado.Disabled = true;
                sabado.Checked = false;
                listaHorarios.Add(new Horarios(HoraInicio, HoraFinalizacion, "sabado", EspSeleccionada));
            }

            if (domingo.Checked)
            {
                domingo.Disabled = true;
                domingo.Checked = false;
                listaHorarios.Add(new Horarios(HoraInicio, HoraFinalizacion, "domingo", EspSeleccionada));
            }

            Session["ListaHor"] = listaHorarios;
            repeaterHorarios.DataSource = listaHorarios;
            repeaterHorarios.DataBind();

        }

        private void ActualizarChkList(Horarios aux) 
        {
            if (aux.Dia == "lunes")
            {
                lunes.Disabled = false;
                lunes.Checked = false;
            }

            if (aux.Dia == "martes")
            {
                martes.Disabled = false;
                martes.Checked = false;
            }

            if (aux.Dia == "miercoles")
            {
                miercoles.Disabled = false;
                miercoles.Checked = false;
            }

            if (aux.Dia == "jueves")
            {
                jueves.Disabled = false;
                jueves.Checked = false;
            }

            if (aux.Dia == "viernes")
            {
                viernes.Disabled = false;
                viernes.Checked = false;
            }

            if (aux.Dia == "sabado")
            {
                sabado.Disabled = false;
                sabado.Checked = false;
            }

            if (aux.Dia == "domingo")
            {
                domingo.Disabled = false;
                domingo.Checked = false;
            }
        }

        private void LimpiarTextBox() 
        {
            EmpleadoManager manager = new EmpleadoManager();
            legajo = manager.ObtenerNuevoLegajo();

            txtDni.Text = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtFechaNacimiento.Text = "";
            txtTelefono.Text = "";
            txtEmail.Text = "";
            txtCalle.Text = "";
            txtNumero.Text = "";
            txtLocalidad.Text = "";
            txtCodigoPostal.Text = "";
            txtLegajo.Text = legajo;

            lunes.Disabled = false;
            martes.Disabled = false;
            miercoles.Disabled = false;
            jueves.Disabled = false;
            viernes.Disabled = false;

            listaHorarios = new List<Horarios>();
            Session["ListaHor"] = listaHorarios;
            repeaterHorarios.DataSource = listaHorarios;
            repeaterHorarios.DataBind();
        }

        private void AgregarHorarios() 
        {
            HorariosManager managerHor = new HorariosManager();
            EspecialiadadesManager managerEsp = new EspecialiadadesManager();

            listaHorarios = (List<Horarios>)Session["ListaHor"];
            legajo = txtLegajo.Text;

            foreach (Horarios item in listaHorarios)
            {
                managerEsp.Agregar(item.Especialidad, legajo);
                managerHor.Agregar(item, legajo);
            }
        }

        private void WindowsMessege(string msg)
        {
            Response.Write("<script>alert('" + msg + "');</script>");
        }

        private bool ValidarCampos(out string mensajeError)
        {
            StringBuilder errores = new StringBuilder();

            DateTime fechaNacimiento;
            if (!DateTime.TryParse(txtFechaNacimiento.Text, out fechaNacimiento) || fechaNacimiento > DateTime.Now)
            {
                errores.AppendLine("• La fecha de nacimiento es inválida o está en el futuro.");
            }

            if (string.IsNullOrWhiteSpace(txtNombre.Text) || string.IsNullOrWhiteSpace(txtApellido.Text))
            {
                errores.AppendLine("• El nombre y el apellido son obligatorios.");
            }

            if (txtDni.Text.Length != 8 || !txtDni.Text.All(char.IsDigit))
            {
                errores.AppendLine("• El DNI debe contener 8 dígitos.");
            }

            if (string.IsNullOrWhiteSpace(txtTelefono.Text) || !txtTelefono.Text.All(char.IsDigit))
            {
                errores.AppendLine("• El teléfono debe contener solo números.");
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text) || !txtEmail.Text.Contains("@"))
            {
                errores.AppendLine("• El email ingresado no es válido.");
            }

            if (string.IsNullOrWhiteSpace(txtCalle.Text) || string.IsNullOrWhiteSpace(txtNumero.Text) ||
                string.IsNullOrWhiteSpace(txtLocalidad.Text) || string.IsNullOrWhiteSpace(txtCodigoPostal.Text))
            {
                errores.AppendLine("• Todos los campos de dirección son obligatorios.");
            }

            mensajeError = errores.ToString();
            return string.IsNullOrEmpty(mensajeError);
        }

    }
}
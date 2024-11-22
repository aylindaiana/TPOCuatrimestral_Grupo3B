using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using System.Web;
using System.Web.Compilation;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Manager;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class Configuracion : System.Web.UI.Page
    {
        public List<Especialidades> listaEspecialidades = new List<Especialidades>();
        public List<Horarios> listaHorarios = new List<Horarios>();
        static int id_direccion;
        string titulo = "Modificar Empleado ";
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
            EmpleadoManager manager = new EmpleadoManager();
            Empleado empModificado;

            try
            {
                empModificado = ObtenerNuevosDatos();
                manager.Modificar(empModificado);

                if(empModificado.Nivel_Acceso == UserType.MEDICO)
                    ModificarHorarios(empModificado.Legajo);
            }
            catch (Exception)
            {
                throw;
            }

            dni = empModificado.Dni;
            
            CargarDatos();
            HabilitarEdicion(false);
        }


        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracion-Empleado.aspx", false);
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

        protected void ddlPuestoTrabajo_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ver que se hace
        }

        protected void btnGuardarHorarios_Click(object sender, EventArgs e)
        {
            if (!lunes.Checked && !martes.Checked && !miercoles.Checked && !jueves.Checked && !viernes.Checked && !sabado.Checked && !domingo.Checked)
                WindowsMessege("Error: Debe seleccionar algun dia de la semana");

            if (ddlHoraInicio.SelectedIndex == 0 || ddlHoraFinlizacion.SelectedIndex == 0)
                WindowsMessege("Error: Seleccione una Hora");


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


        //Funciones

        private void HabilitarEdicion(bool estado)
        { 
            txtNombre.Enabled = estado;
            txtApellido.Enabled = estado;
            txtLegajo.Enabled = false;
            txtDni.Enabled = false;
            txtFechaNacimiento.Enabled = estado;
            txtCalle.Enabled = estado;
            txtNumero.Enabled = estado;
            txtLocalidad.Enabled = estado;
            txtTelefono.Enabled = estado;
            txtEmail.Enabled = estado;
            txtCodigoPostal.Enabled = estado;
            ddlPuestoTrabajo.Enabled = estado;
            btnGuardar.Enabled = estado;
            btnGuardar.Visible = estado;
            btnGuardarHorarios.Enabled = estado;
        }

        private void CargarDatos() 
        {
            EmpleadoManager manager = new EmpleadoManager();
            Empleado empleado = new Empleado();
            int acceso;

            try
            {
                empleado = manager.Obtener(dni);
                acceso = (int)empleado.Nivel_Acceso;

                txtNombre.Text = empleado.Nombre;
                txtApellido.Text = empleado.Apellido;
                txtDni.Text = empleado.Dni;
                txtFechaNacimiento.Text = empleado.Fecha_Nac.ToString("yyyy-MM-dd");
                id_direccion = empleado.Direccion.Id_direccion;
                txtCalle.Text = empleado.Direccion.Calle;
                txtNumero.Text = empleado.Direccion.Numero;
                txtLocalidad.Text = empleado.Direccion.Localidad;
                txtCodigoPostal.Text = empleado.Direccion.CodigoPostal;
                txtTelefono.Text = empleado.Telefono;
                txtEmail.Text = empleado.Email;
                ddlPuestoTrabajo.SelectedValue = acceso.ToString();
                txtLegajo.Text = empleado.Legajo;
                lblLegajo.Text = "Legajo";

                if (empleado.Nivel_Acceso == UserType.MEDICO)
                    CargarHorarioMedicos(empleado.Legajo);
                else
                    Session["ListaHor"] = new List<Horarios>();

                CargarEspecialidades();
                CargarHoras();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

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

        private void CargarHoras()
        {
            List<TimeSpan> horas = ObtenerHorasDelDia();

            foreach (TimeSpan hora in horas)
            {
                ddlHoraInicio.Items.Add(new ListItem(hora.ToString(@"hh\:mm"), hora.ToString()));
                ddlHoraFinlizacion.Items.Add(new ListItem(hora.ToString(@"hh\:mm"), hora.ToString()));
            }
        }

        private void CargarEspecialidades() 
        {
            EspecialiadadesManager manager = new EspecialiadadesManager(); 

            try
            {
                listaEspecialidades = manager.ObtenerTodos();
                ddlEspecialidad.DataSource = listaEspecialidades;
                ddlEspecialidad.DataTextField = "Nombre";
                ddlEspecialidad.DataValueField = "Id";
                ddlEspecialidad.DataBind();
            }
            catch (Exception)
            {
                throw;
            }

            Session["ListaEsp"] = listaEspecialidades;
        }

        private void CargarHorarioMedicos(string legajo) 
        {
            HorariosManager managerHor = new HorariosManager();
            
            try
            {
                listaHorarios = managerHor.ObtenerTodos(legajo);
                repeaterHorarios.DataSource = listaHorarios;
                repeaterHorarios.DataBind();
            }
            catch (Exception)
            {

                throw;
            }

            Session["ListaHor"] = listaHorarios;

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
                listaHorarios.Add(new Horarios(HoraInicio, HoraFinalizacion, "lunes", EspSeleccionada));
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

        private Empleado ObtenerNuevosDatos() 
        { 
            Empleado empleado = new Empleado();
            int Acceso = int.Parse(ddlPuestoTrabajo.SelectedValue);

            empleado.Legajo = txtLegajo.Text;
            empleado.Dni = txtDni.Text;
            empleado.Nombre = txtNombre.Text;
            empleado.Apellido = txtApellido.Text;
            empleado.Fecha_Nac = DateTime.Parse(txtFechaNacimiento.Text);
            empleado.Direccion.Id_direccion = id_direccion;
            empleado.Direccion.Calle = txtCalle.Text;
            empleado.Direccion.Numero = txtNumero.Text;
            empleado.Direccion.Localidad = txtLocalidad.Text;
            empleado.Direccion.CodigoPostal = txtCodigoPostal.Text;
            empleado.Telefono = txtTelefono.Text;
            empleado.Email = txtEmail.Text;
            empleado.Nivel_Acceso = (UserType)Acceso;

            return empleado;
        }

        private void ModificarHorarios(string legajo) 
        {
            EspecialiadadesManager managerEsp = new EspecialiadadesManager();
            HorariosManager managerHor = new HorariosManager();
            listaHorarios = (List<Horarios>)Session["ListaHor"];

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
    }

}

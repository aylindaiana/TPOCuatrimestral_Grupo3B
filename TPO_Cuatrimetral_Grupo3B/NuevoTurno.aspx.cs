using Dominio;
using Manager;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class NuevoTurno : System.Web.UI.Page
    {
        List<Especialidades> listaEspecialidades = new List<Especialidades> ();
        List<Sanatorios> listaSanatorios = new List<Sanatorios> ();
        List<Empleado> listaMedicos = new List<Empleado>();
        List<Horarios> listaHorarios = new List<Horarios> ();
        static string legajo;
        static int id_sanatorio;

        Paciente paciente;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                if (Seguridad.NivelAcceso() == UserType.PACIENTE)
                {
                    CargarDatosPaciente();
                    CargarSanatorios();
                    CargarEspecialidades();
                }
                else 
                {
                    txtAfiliado.Enabled = true;
                    txtApellido.Enabled = false;
                    txtNombre.Enabled = false;
                }

            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();
            TurnoMedico turno = new TurnoMedico();

            turno.NumAfiliado = txtAfiliado.Text;
            turno.Legajo = ddlMedicos.SelectedValue;
            turno.Id_Especialidad = int.Parse(ddlEspecialidad.SelectedValue);
            turno.Motivo = txtMotivo.Text;
            turno.Id = int.Parse(ddlHorarios.SelectedValue);
            turno.Id_Sanatorio = id_sanatorio;

            try
            {
                manager.AsignarTurno(turno);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            Response.Redirect("Exito.aspx");

            ddlDias.Items.Clear();
            ddlFechas.Items.Clear();
            ddlHorarios.Items.Clear();
            txtMotivo.Text = "";
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx",false);
        }

        protected void ddlSanatorio_SelectedIndexChanged(object sender, EventArgs e)
        {
            id_sanatorio = int.Parse(ddlSanatorio.SelectedValue);
        }

        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = int.Parse(ddlEspecialidad.SelectedValue);

            if(id != 0)
                CargarMedicosAsignados(id);

            ddlDias.Items.Clear();
            ddlFechas.Items.Clear();
            ddlHorarios.Items.Clear();
        }

        protected void ddlMedicos_SelectedIndexChanged(object sender, EventArgs e)
        {
            legajo = ddlMedicos.SelectedValue;

            if (string.Compare(legajo, "0") != 0)
                CargarDiasDisponibles(legajo);

            ddlFechas.Items.Clear();
            ddlHorarios.Items.Clear();
        }

        protected void ddlDias_SelectedIndexChanged(object sender, EventArgs e)
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();
            List<string> listaFechas = new List<string>();

            string dia = ddlDias.SelectedValue;

            try
            {
                listaFechas = manager.ObtenerFechas(legajo, dia).Select(f => f.ToString("dd-MM-yyyy")).ToList();
                ddlFechas.DataSource = listaFechas;
                ddlFechas.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            ddlHorarios.Items.Clear();
        }

        protected void ddlFechasSelectedIndexChanged(object sender, EventArgs e)
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();
            List<TurnoMedico> listaHorarios = new List<TurnoMedico>();

            string legajo = ddlMedicos.SelectedValue;
            DateTime fecha = DateTime.Parse(ddlFechas.SelectedValue);

            try
            {
                listaHorarios = manager.ObtenerHorarios(fecha,legajo);
                ddlHorarios.DataSource = listaHorarios;
                ddlHorarios.DataTextField = "Hora";
                ddlHorarios.DataValueField = "Id";
                ddlHorarios.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }


        //Funciones:

        private void CargarDatosPaciente() 
        {
            try
            {
                paciente = (Paciente)Session["Paciente"];
                txtAfiliado.Text = paciente.Numero_afiliado;
                txtNombre.Text = paciente.Nombre;
                txtApellido.Text = paciente.Apellido;
            }
            catch (Exception)
            {

                throw;
            }

            txtApellido.Enabled = false;
            txtNombre.Enabled = false;
            txtAfiliado.Enabled = false;

        }

        private void CargarEspecialidades() 
        {
            EspecialiadadesManager manager = new EspecialiadadesManager();
            Especialidades aux = new Especialidades();
            aux.Nombre = "Seleccione una opccion";
            aux.Id = 0;
            listaEspecialidades.Add(aux);
            
            try
            {
                listaEspecialidades.AddRange(manager.ObtenerTodos());
                ddlEspecialidad.DataSource = listaEspecialidades;
                ddlEspecialidad.DataTextField = "Nombre";
                ddlEspecialidad.DataValueField = "Id";
                ddlEspecialidad.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            Session["ListaEsp"] = listaEspecialidades;

        }

        private void CargarSanatorios() 
        {
            SanatorioManager manager = new SanatorioManager();
            Sanatorios aux = new Sanatorios();
            aux.Nombre = "Seleccione una opccion";
            aux.Id_Sanatorio = 0;
            listaSanatorios.Add(aux);

            try
            {
                listaSanatorios.AddRange(manager.ObtenerTodos(paciente.Plan.Id_Plan));
                ddlSanatorio.DataSource = listaSanatorios;
                ddlSanatorio.DataTextField = "Nombre";
                ddlSanatorio.DataValueField = "Id_Sanatorio";
                ddlSanatorio.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            Session["ListaSan"]= listaSanatorios;
        }

        private void CargarMedicosAsignados(int id_esp) 
        {   
            EmpleadoManager manager = new EmpleadoManager();
            Empleado aux = new Empleado();
            aux.Legajo = "0";
            aux.Nombre = "Seleccione una opccion";
            listaMedicos.Add(aux);

            try
            {
                listaMedicos.AddRange(manager.listaMedicos(id_esp));
                ddlMedicos.DataSource = listaMedicos;
                ddlMedicos.DataTextField = "NombreCompleto";
                ddlMedicos.DataValueField = "Legajo";
                ddlMedicos.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            Session["ListaMed"] = listaMedicos;
        }

        private void CargarDiasDisponibles(string legajo) 
        {
            HorariosManager manager = new HorariosManager();

            try
            {
                listaHorarios = manager.ObtenerTodos(legajo);
                ddlDias.DataSource = listaHorarios;
                ddlDias.DataTextField = "Dia";
                ddlDias.DataValueField = "Dia";
                ddlDias.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        protected void txtAfiliado_TextChanged(object sender, EventArgs e)
        {
            PacienteManager manager = new PacienteManager();
            Paciente aux = new Paciente();
            string dni;

            try
            {
                dni = manager.ObtenerDNI(txtAfiliado.Text);
                aux = manager.Obtener(dni);

                if(aux.Estado != false)
                {
                    txtAfiliado.Text = aux.Numero_afiliado;
                    txtNombre.Text = aux.Nombre;
                    txtApellido.Text = aux.Apellido;

                    txtNombre.Enabled = false;
                    txtApellido.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");

            }
        }
    }
}
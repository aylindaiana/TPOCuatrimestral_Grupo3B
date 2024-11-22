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

            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {

        }

        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = int.Parse(ddlEspecialidad.SelectedValue);

            if(id != 0)
                CargarMedicosAsignados(id);
        }

        protected void ddlMedicos_SelectedIndexChanged(object sender, EventArgs e)
        {
            string legajo = ddlMedicos.SelectedValue;

            if (string.Compare(legajo, "0") != 0)
                CargarDiasDisponibles(legajo);
                
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

    }
}
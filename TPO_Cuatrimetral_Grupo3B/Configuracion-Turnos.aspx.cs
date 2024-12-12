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
    public partial class Configuracion_Turnos : System.Web.UI.Page
    {
        private EmpleadoManager empleadoManager = new EmpleadoManager();
        private EspecialiadadesManager especialidadesManager = new EspecialiadadesManager();
        private HorariosManager horariosManager = new HorariosManager();
        List<Horarios> listaHorarios = new List<Horarios>();
        static string legajo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProfesionales();
                CargarEspecialidades();
                CargarHorariosDropDown();
                CargarDias();
            }
        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlProfesionales.SelectedIndex == 0 || ddlEspecialidades.SelectedIndex == 0 ||
                    ddlHorarioInicio.SelectedIndex == 0 || ddlHorarioFin.SelectedIndex == 0)
                {
                    lblMensaje.Text = "Debe seleccionar un profesional, una especialidad y los horarios.";
                    lblMensaje.Visible = true;
                    return;
                }

                TimeSpan horarioInicio = TimeSpan.Parse(ddlHorarioInicio.SelectedValue);
                TimeSpan horarioFin = TimeSpan.Parse(ddlHorarioFin.SelectedValue);

                if (horarioInicio >= horarioFin)
                {
                    lblMensaje.Text = "El horario de inicio debe ser anterior al horario de fin.";
                    lblMensaje.CssClass = "error-message";
                    lblMensaje.Visible = true;
                    return;
                }

                Horarios nuevoHorario = new Horarios(
                    horarioInicio,
                    horarioFin,
                    string.Join(",", chkDias.Items.Cast<ListItem>().Where(li => li.Selected).Select(li => li.Value)),
                    new Especialidades
                    {
                        Id = int.Parse(ddlEspecialidades.SelectedValue),
                        Nombre = ddlEspecialidades.SelectedItem.Text
                    }
                );

                horariosManager.Agregar(nuevoHorario, ddlProfesionales.SelectedValue);

                lblMensaje.Text = "Configuración guardada exitosamente.";
                lblMensaje.CssClass = "success-message";
                lblMensaje.Visible = true;

                CargarHorarios();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error: " + ex.Message;
                lblMensaje.CssClass = "error-message";
                lblMensaje.Visible = true;
            }
        }
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            ddlProfesionales.SelectedIndex = 0;
            ddlEspecialidades.SelectedIndex = 0;
            ddlHorarioInicio.SelectedIndex = 0;
            ddlHorarioFin.SelectedIndex = 0;

            foreach (ListItem item in chkDias.Items)
            {
                item.Selected = false;
            }
            txtDuracionTurno.Text = "";

            lblMensaje.Text = "";
            lblMensaje.Visible = false;
        }

        protected void gvConfiguraciones_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
            }
            else if (e.CommandName == "Editar")
            {
            }
        }
        protected void ddlSanatorio_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlProfesionales_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        //Funciones:
        private void CargarProfesionales()
        {
            var listaProfesionales = empleadoManager.ObtenerTodos(); // Método en EmpleadoManager
            ddlProfesionales.DataSource = listaProfesionales;
            ddlProfesionales.DataTextField = "NombreCompleto"; // Propiedad a mostrar
            ddlProfesionales.DataValueField = "Legajo"; // Valor seleccionado
            ddlProfesionales.DataBind();
            ddlProfesionales.Items.Insert(0, new ListItem("Seleccione un profesional", "0"));
        }
        private void CargarHorarios()
        {
            var horarios = horariosManager.ObtenerTodos(ddlProfesionales.SelectedValue);
            gvConfiguraciones.DataSource = horarios;
            gvConfiguraciones.DataBind();
        }

        private void CargarEspecialidades()
        {
            var listaEspecialidades = especialidadesManager.ObtenerTodos();
            ddlEspecialidades.DataSource = listaEspecialidades;
            ddlEspecialidades.DataTextField = "Nombre"; // Propiedad a mostrar
            ddlEspecialidades.DataValueField = "Id"; // Valor seleccionado
            ddlEspecialidades.DataBind();
            ddlEspecialidades.Items.Insert(0, new ListItem("Seleccione una especialidad", "0"));
        }
        private void CargarHorariosDropDown()
        {
            List<string> horarios = Enumerable.Range(0, 24)
                .Select(h => TimeSpan.FromHours(h).ToString(@"hh\:mm"))
                .ToList();

            ddlHorarioInicio.DataSource = horarios;
            ddlHorarioInicio.DataBind();
            ddlHorarioInicio.Items.Insert(0, new ListItem("Seleccione un horario", "0"));

            ddlHorarioFin.DataSource = horarios;
            ddlHorarioFin.DataBind();
            ddlHorarioFin.Items.Insert(0, new ListItem("Seleccione un horario", "0"));
        }

        private void CargarDias()
        {
            List<string> diasSemana = new List<string>
            {
                "Lunes",
                "Martes",
                "Miércoles",
                "Jueves",
                "Viernes",
                "Sábado",
                "Domingo"
            };
           // horariosManager.ObtenerTodos(legajo);
                
            chkDias.DataSource = diasSemana;
            chkDias.DataBind();
        }

    }
}
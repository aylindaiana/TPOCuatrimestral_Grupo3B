﻿using Dominio;
using Manager;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class EditarTurnos : System.Web.UI.Page
    {
        static int id_turno;
        static string legajo;
        private TurnoMedico turno;
        List<Especialidades> listaEspecialidades = new List<Especialidades>();
        List<Sanatorios> listaSanatorios = new List<Sanatorios>();
        List<Empleado> listaMedicos = new List<Empleado>();
        
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if ( Request.QueryString["id_turno"] != null)
                {
                    id_turno = int.Parse(Request.QueryString["id_turno"]);
                    lblTitulo.Text = "Turno: " + id_turno.ToString();
                    CargarTurno(id_turno);
                    CargarSanatorios();
                    CargarEspecialidades();
                }
                else
                {
                    Response.Redirect("DenegarPermiso.aspx");
                }
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

                if (aux.Estado != false)
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

        protected void ddlSanatorio_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);
            CargarMedicosAsignados(idEspecialidad);
        }

        protected void ddlMedicos_SelectedIndexChanged(object sender, EventArgs e)
        {
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

        protected void ddlFechas_SelectedIndexChanged(object sender, EventArgs e)
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();
            List<TurnoMedico> listaHorarios = new List<TurnoMedico>();

            string legajo = ddlMedicos.SelectedValue;
            DateTime fecha = DateTime.Parse(ddlFechas.SelectedValue);

            try
            {
                listaHorarios = manager.ObtenerHorarios(fecha, legajo);
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (id_turno == 0)
                {
                    throw new Exception("El ID del turno no es válido.");
                }

                TurnoMedico turno = new TurnoMedico();
                turno.Id = id_turno;
                turno.Legajo = ddlMedicos.SelectedValue;
                turno.NumAfiliado = txtAfiliado.Text;
                turno.Motivo = txtMotivo.Text;
                turno.Observaciones = txtObservaciones.Text;
                turno.Id_Sanatorio = int.Parse(ddlSanatorio.SelectedValue);
                turno.Id_Especialidad = int.Parse(ddlEspecialidad.SelectedValue);
                turno.Fecha = DateTime.Parse(ddlFechas.SelectedValue);
                turno.dia = ddlDias.SelectedValue;
                turno.Hora = TimeSpan.Parse(ddlHorarios.SelectedValue);
                turno.estado = "Pendiente";

                TurnoMedicoManager manager = new TurnoMedicoManager();
                manager.ModificarTurno(turno);

                Response.Write("<script>alert('Turno modificado exitosamente.');</script>");
                Response.Redirect("MisTurnos.aspx", false);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al guardar el turno: " + ex.ToString() + "');</script>");
            }
        }


        protected void btnCacelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("MisTurnos.aspx", false);
        }

        //funciones


        
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

        }
        private void CargarSanatorios()
        {
            SanatorioManager manager = new SanatorioManager();
            Sanatorios aux = new Sanatorios { Nombre = "Seleccione una opción", Id_Sanatorio = 0 };
            listaSanatorios.Add(aux);

            try
            {
                listaSanatorios.AddRange(manager.ObtenerTodos());
                ddlSanatorio.DataSource = listaSanatorios;
                ddlSanatorio.DataTextField = "Nombre";
                ddlSanatorio.DataValueField = "Id_Sanatorio";
                ddlSanatorio.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar sanatorios: " + ex.Message + "');</script>");
            }
        }

        private void CargarMedicosAsignados(int idEspecialidad)
        {
            EmpleadoManager manager = new EmpleadoManager();
            listaMedicos = manager.listaMedicos(idEspecialidad);
            ddlMedicos.DataSource = listaMedicos;
            ddlMedicos.DataTextField = "NombreCompleto";
            ddlMedicos.DataValueField = "Legajo";
            ddlMedicos.DataBind();
        }

       
        private void CargarTurno(int idTurno)
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();
            turno = manager.ObtenerTurnoPorId(idTurno);

            if (turno != null)
            {
                try
                {
                    txtAfiliado.Text = turno.NumAfiliado;
                    txtMotivo.Text = turno.Motivo;
                    txtObservaciones.Text = turno.Observaciones;

                    txtAfiliado.Enabled = false;
                    //txtObservaciones.Enabled = false;

                    ddlSanatorio.SelectedValue = turno.Id_Sanatorio.ToString();
                    ddlEspecialidad.SelectedValue = turno.Id_Especialidad.ToString();

                    CargarMedicosAsignados(turno.Id_Especialidad);
                    ddlMedicos.SelectedValue = turno.Legajo;

                    // Cargar Datos del Paciente
                    CargarDatosAfiliado(turno.NumAfiliado);

                    CargarDiasDisponibles(turno.Legajo);
                    ddlDias.SelectedValue = turno.dia;

                    CargarFechas(turno.Legajo, turno.dia);
                    ddlFechas.SelectedValue = turno.Fecha.ToString("yyyy-MM-dd");

                    CargarHorarios(turno.Fecha, turno.Legajo);
                    ddlHorarios.SelectedValue = turno.Hora.ToString(@"hh\:mm");

                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error al cargar los datos del turno: " + ex.Message + "');</script>");
                }
            }
            else
            {
                Response.Redirect("DenegarPermiso.aspx");
            }
        }
        private void CargarDatosAfiliado(string numAfiliado)
        {
            PacienteManager manager = new PacienteManager();
            Paciente paciente = manager.ObtenerPorNumeroAfiliado(numAfiliado);

            if (paciente != null)
            {
                txtNombre.Text = paciente.Nombre;
                txtApellido.Text = paciente.Apellido;

                txtNombre.Enabled = false;
                txtApellido.Enabled = false;
            }
            else
            {
                Response.Write("<script>alert('No se encontró el paciente.');</script>");
            }
        }


        private void CargarDiasDisponibles(string legajo)
        {
            HorariosManager manager = new HorariosManager();
            List<Horarios> listaHorarios;
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
        private void CargarHorarios(DateTime fecha, string legajo)
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();
            List<TurnoMedico> listaHorarios;

            try
            {
                listaHorarios = manager.ObtenerHorarios(fecha, legajo);
                ddlHorarios.DataSource = listaHorarios;
                ddlHorarios.DataTextField = "Hora";
                ddlHorarios.DataValueField = "Hora";
                ddlHorarios.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar horarios: " + ex.Message + "');</script>");
            }
        }
        private void CargarFechas(string legajo, string dia)
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();
            List<string> listaFechas;

            try
            {
                listaFechas = manager.ObtenerFechas(legajo, dia).Select(f => f.ToString("yyyy-MM-dd")).ToList();
                ddlFechas.DataSource = listaFechas;
                ddlFechas.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar fechas: " + ex.Message + "');</script>");
            }
        }


    }
}
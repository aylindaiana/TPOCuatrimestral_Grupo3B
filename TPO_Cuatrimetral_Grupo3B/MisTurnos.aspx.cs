using Dominio;
using Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class MisTurnos : System.Web.UI.Page
    {
        List<TurnoMedico> listaTurnos = new List<TurnoMedico>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               // CargarLista();
                if (Session["User"] != null)
                {
                    Usuario usuario = (Usuario)Session["User"];

                    if (usuario.Tipo == UserType.ADMIN)
                    {

                        CargarLista();
                    }
                    else if (usuario.Tipo == UserType.RECEPCIONISTA)
                    {
                        CargarLista();
                    }
                    else if (usuario.Tipo == UserType.MEDICO)
                    {
                        CargarLista();
                    }

                    else if (usuario.Tipo == UserType.PACIENTE)
                    {
                        CargarListaPaciente();
                    }

                }
                else
                {
                    Session.Add("error", "Usted no tiene permiso para acceder");
                    Response.Redirect("DenegarPermiso.aspx", false);
                }
            }
        }

        protected void btnEditarTurno_Click(object sender, EventArgs e)
        {
            Button btnEditar = (Button)sender;
            int id_turno = int.Parse(btnEditar.CommandArgument);

            Response.Redirect("EditarTurnos.aspx?id_turno="+ id_turno,false);
        }

        protected void btnBuscarId_Click(object sender, EventArgs e)
        {

            List<TurnoMedico> lista = (List<TurnoMedico>)Session["listarTurnos"];
            List<TurnoMedico> listaFiltroAfiliado = lista.FindAll(x => x.NumAfiliado.ToUpper().Contains(txtIdFiltro.Text.ToUpper()));
            repeaterTurnos.DataSource = listaFiltroAfiliado;
            repeaterTurnos.DataBind();
            txtIdFiltro.Text = string.Empty;
        }

        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id_esp = int.Parse(ddlEspecialidad.SelectedValue);
            listaTurnos = (List<TurnoMedico>)Session["ListaTur"]; 
            List<TurnoMedico> aux = new List<TurnoMedico>();

            if (id_esp == 0)
            {
                repeaterTurnos.DataSource = listaTurnos;
            }
            else
            {
                aux = listaTurnos.Where(t => t.Id_Especialidad == id_esp).ToList();
                repeaterTurnos.DataSource = aux;
            }

            repeaterTurnos.DataBind();
        }

        protected void ddlEstadoTurno_SelectedIndexChanged(object sender, EventArgs e)
        {
            string opc = ddlEstadoTurno.SelectedItem.Text;
            listaTurnos = (List<TurnoMedico>)Session["ListaTur"];
            List<TurnoMedico> aux = new List<TurnoMedico>();

            if (int.Parse(ddlEstadoTurno.SelectedValue) == 0)
            {
                repeaterTurnos.DataSource = listaTurnos;
            }
            else
            {
                aux = listaTurnos.Where(t => string.Compare(t.estado, opc) == 0).ToList();
                repeaterTurnos.DataSource= aux;
            }

            repeaterTurnos.DataBind();

        }

        protected void btnNuevoEmpleado_Click(object sender, EventArgs e)
        {
            Response.Redirect("NuevoTurno.aspx",false);
        }

        //funciones
        private void CargarLista() 
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();

            try
            {
                listaTurnos = manager.ObtenerTodos();
                repeaterTurnos.DataSource = listaTurnos;
                repeaterTurnos.DataBind();

                CargarEspecialidades();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error " + ex.Message + "');</script>");
            }

            Session["ListaTur"] = listaTurnos;

        }
        private void CargarListaPaciente()
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();
            Paciente paciente;

            try
            {
                if (Session["Paciente"] == null)
                {
                    Response.Redirect("Login.aspx"); 
                    return;
                }

                paciente = (Paciente)Session["Paciente"];

                listaTurnos = manager.ObtenerTurnosPorAfiliado(paciente.Numero_afiliado);

                repeaterTurnos.DataSource = listaTurnos;
                repeaterTurnos.DataBind();

                CargarEspecialidades();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error " + ex.Message + "');</script>");
            }

            Session["ListaTur"] = listaTurnos;
        }


        private void CargarEspecialidades() 
        {
            EspecialiadadesManager manager = new EspecialiadadesManager();
            List<Especialidades> listaEspecialidades = new List<Especialidades>();
            Especialidades aux = new Especialidades();
            aux.Nombre = "Selecciones una Especialidad";
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
                Response.Write("<script>alert('Error "+ ex.Message + "');</script>");
            }
        }

    }   
}
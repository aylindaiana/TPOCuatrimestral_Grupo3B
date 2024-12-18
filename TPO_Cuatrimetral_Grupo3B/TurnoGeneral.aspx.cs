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
    public partial class TurnoGeneral : System.Web.UI.Page
    {
        TurnoMedicoManager turnosManager = new TurnoMedicoManager();
        List<TurnoMedico> listaTurnos = new List<TurnoMedico>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTurnos();
            }
        }


        protected void gvTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idTurno;
            if (int.TryParse(e.CommandArgument.ToString(), out idTurno))
            {
                if (e.CommandName == "Editar")
                {
                    Response.Redirect($"EditarTurno.aspx?id={idTurno}");
                }
                else if (e.CommandName == "Eliminar")
                {
                    try
                    {
                        TurnoMedico turnoCancelado = turnosManager.BuscarTurno(idTurno);
                        turnoCancelado.estado = "Cancelado";
                        turnoCancelado.Observaciones = "Turno cancelado por el administrador.";

                        turnosManager.ModificarTurno(turnoCancelado);

                        // Recargar la lista de turnos
                        CargarTurnos();
                    }
                    catch (Exception ex)
                    {
                        // Manejar el error y mostrar un mensaje al usuario
                        // (por ejemplo, mostrar un mensaje en la página)
                        Response.Write($"<script>alert('Error al eliminar el turno: {ex.Message}');</script>");
                    }
                }
            }
        }
        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlEstado = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddlEstado.NamingContainer;

            int idTurno = Convert.ToInt32(gvTurnos.DataKeys[row.RowIndex].Value); // Obtiene el ID del turno
            string nuevoEstado = ddlEstado.SelectedValue;

            // Actualiza el estado del turno en la base de datos
            //turnosManager.ActaulizarTurno(idTurno, nuevoEstado);

            // Opción: mostrar un mensaje de éxito o recargar la lista de turnos
            CargarTurnos();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            if (!string.IsNullOrEmpty(filtro))
            {
                listaTurnos = turnosManager.ObtenerTodos(filtro); 
            }
            else
            {
                listaTurnos = turnosManager.ObtenerTodos(); 
            }

            gvTurnos.DataSource = listaTurnos;
            gvTurnos.DataBind();
        }
        // Funciones: 
        private void CargarTurnos()
        {
            
            listaTurnos = turnosManager.ObtenerTodos();
            gvTurnos.DataSource = listaTurnos;
            gvTurnos.DataBind();
            
        }
    }
}
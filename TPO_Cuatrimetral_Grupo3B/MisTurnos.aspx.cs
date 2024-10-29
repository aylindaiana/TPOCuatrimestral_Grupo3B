using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class MisTurnos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //Funcionalidad para cargar turnos a la GridView
        protected void ContenidoFiltros(object sender, EventArgs e)
        {
            var button = (System.Web.UI.WebControls.Button)sender;
            string turnoSuperior = button.CommandArgument;

            tituloContenido.Text = turnoSuperior;
            contenido.Text = $"Este es el filtro numero {turnoSuperior.ToLower()}.";
        }
        protected void ContenidoTurnos(object sender, EventArgs e)
        {
            var button = (System.Web.UI.WebControls.Button)sender;
            string turno = button.CommandArgument;

            tituloContenido.Text = turno;
            contenido.Text = $"Contenido del turno para {turno.ToLower()}.";
        }
        protected void gvTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
            {
                //Crear objeto y llamar al id del turno
                int turnoId = Convert.ToInt32(e.CommandArgument); //ejemplo 
                Response.Redirect($"DetalleTurno.aspx?turnoId={turnoId}");
            }
        }

    }
}
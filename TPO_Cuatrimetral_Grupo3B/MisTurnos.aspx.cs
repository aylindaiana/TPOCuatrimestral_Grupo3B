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
    }
}
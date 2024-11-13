using System;
using System.Collections.Generic;
using System.Linq;
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
        string titulo = "Modificar Usuario ";
        string id;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] !=  null) 
            { 
                id = Request.QueryString["id"];
                titulo += id;
            }

            LblTitulo.Text = titulo;
        }

    }

}

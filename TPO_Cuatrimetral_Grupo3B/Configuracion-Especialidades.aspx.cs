using Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Manager;
using Dominio;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class Configuracion_Especialidades : System.Web.UI.Page
    {
        public List<Especialidades> listaEspecialidades;

        protected void Page_Load(object sender, EventArgs e)
        {
            CargarLista();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            
        }

        //Funciones:

        private void CargarLista()
        {
            EspecialiadadesManager especialidades = new EspecialiadadesManager();
            listaEspecialidades = especialidades.ObtenerTodos();
        }
    }
}
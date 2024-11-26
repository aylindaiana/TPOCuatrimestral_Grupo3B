using Dominio;
using Manager;
using System;
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                if (!IsPostBack && Request.QueryString["id_turno"] != null)
                {
                    id_turno = int.Parse(Request.QueryString["id_turno"]);
                    lblTitulo.Text = "Turno: " + id_turno.ToString();
                }
            }
                
        }

        protected void txtAfiliado_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlSanatorio_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlMedicos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlDias_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlFechas_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

        }

        protected void btnCacelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("MisTurnos.aspx",false);
        }

        //funciones

        private void CargarDatos() 
        {
            TurnoMedicoManager manager = new TurnoMedicoManager();
            //TurnoMedico aux = new TurnoMedico();

            try
            {
                List<TurnoMedico> lista = manager.ObtenerTodos();
                ddlMedicos.DataSource = lista;
                ddlMedicos.DataBind();


            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
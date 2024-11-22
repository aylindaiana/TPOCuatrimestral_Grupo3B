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
    public partial class AgregarPlan : System.Web.UI.Page
    {
        public List<Sanatorios> listaSanatorios = new List<Sanatorios>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDatos();
            }
        }

        protected void btnAgregarSanatorio_Click(object sender, EventArgs e)
        {
            SanatorioManager manager = new SanatorioManager();
            int id = int.Parse(ddlSanatorios.SelectedValue);
            listaSanatorios = (List<Sanatorios>)Session["ListaSan"];

            if (id == 0) 
            {
                WindowsMessege("Seleccione un sanatorio para agregarlo");
                return;
            }

            try
            {
                listaSanatorios.Add(manager.Obtener(id));
                repeaterSanatorios.DataSource = listaSanatorios;
                repeaterSanatorios.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }


            Session["ListaSan"] = listaSanatorios;
            DeshabilitarOpcDdl();
        }

        protected void btnEliminarSanatorio_Click(object sender, EventArgs e)
        {
            listaSanatorios = (List<Sanatorios>)Session["ListaSan"];
            Button btn = (Button)sender;
            int index = int.Parse(btn.CommandArgument);

            HabilitarOpcDdl(listaSanatorios[index]);
            listaSanatorios.RemoveAt(index);

            Session["ListaSan"] = listaSanatorios;
            repeaterSanatorios.DataSource = listaSanatorios;
            repeaterSanatorios.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            PlanesManager manager = new PlanesManager();
            Planes plan;

            if (txtNompre.Text == string.Empty) 
            {
                WindowsMessege("Complete todos los campos");
                return;
            }

            try
            {
                plan = ObtenerDatosPlan();
                manager.Agregar(plan);
                AsignarSanatorios(plan.Id_Plan);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            ReiniciarDdl();

            WindowsMessege("Plan generado exitosamente!");

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracion-Planes.aspx",false);
        }

        //Funciones

        private void CargarDatos() 
        {
            SanatorioManager manager = new SanatorioManager();
            PlanesManager managerPl = new PlanesManager();
            Sanatorios aux = new Sanatorios();
            aux.Id_Sanatorio = 0;
            aux.Nombre = "Seleccione un Sanatorio";
            int id;
            
            listaSanatorios.Add(aux);



            try
            {
                listaSanatorios.AddRange(manager.ObtenerTodos());
                id = managerPl.nuevoID();

                txtIdPlan.Text = id.ToString();
                ddlSanatorios.DataSource = listaSanatorios;
                ddlSanatorios.DataTextField = "Nombre";
                ddlSanatorios.DataValueField = "Id_Sanatorio";
                ddlSanatorios.DataBind();

                repeaterSanatorios.DataSource= new List<Sanatorios>();
                repeaterSanatorios.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            txtNompre.Text = "";

            foreach (ListItem item in ddlSanatorios.Items)
            {
                item.Enabled = true;
            }

            Session["ListaSan"] = new List<Sanatorios>();
            txtIdPlan.Enabled = false;

        }

        private void DeshabilitarOpcDdl()
        {
            string valorSeleccionado = ddlSanatorios.SelectedValue;

            // Buscar el elemento correspondiente y deshabilitarlo
            foreach (ListItem item in ddlSanatorios.Items)
            {
                if (item.Value == valorSeleccionado)
                {
                    item.Enabled = false; // Deshabilitar la opción seleccionada
                    break;
                }
            }

            ddlSanatorios.SelectedIndex = 0;
        }

        private void HabilitarOpcDdl(Sanatorios aux) 
        {
            foreach (ListItem item in ddlSanatorios.Items) 
            {
                if (item.Value == aux.Id_Sanatorio.ToString()) 
                {
                    item.Enabled = true;
                    break;
                }
            }
        }

        private Planes ObtenerDatosPlan()
        {
            Planes plan = new Planes();

            plan.Id_Plan = int.Parse(txtIdPlan.Text); 
            plan.Nombre_Plan = txtNompre.Text;

            return plan;
        }

        private void AsignarSanatorios(int id_plan) 
        {
            SanatorioManager manager = new SanatorioManager();
            listaSanatorios = (List<Sanatorios>)Session["ListaSan"];

            try
            {
                foreach (var item in listaSanatorios)
                {
                    manager.AsignarPlan(item.Id_Sanatorio, id_plan);
                }
            }
            catch (Exception)
            {
                throw;
            }

        }

        private void WindowsMessege(string msg)
        {
            Response.Write("<script>alert('" + msg + "');</script>");
        }

        private void ReiniciarDdl() 
        {
            PlanesManager manager = new PlanesManager();
            listaSanatorios = (List<Sanatorios>)Session["ListaSan"];

            foreach (Sanatorios item in listaSanatorios)
            {
                HabilitarOpcDdl(item);
            }

            txtNompre.Text = string.Empty;
            txtIdPlan.Text = manager.nuevoID().ToString();

            listaSanatorios = new List<Sanatorios>();
            Session["ListaSan"] = listaSanatorios;
            repeaterSanatorios.DataSource = listaSanatorios;
            repeaterSanatorios.DataBind();
        }
    }
}
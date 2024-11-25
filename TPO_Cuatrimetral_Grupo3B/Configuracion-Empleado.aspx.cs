using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Manager;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class Configuracion_Empleado : System.Web.UI.Page
    {
        public List<Empleado> listaEmpleados;
        List<Empleado> listaEmpleadosFiltrada;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["User"] != null)
                {
                    Usuario usuario = (Usuario)Session["User"];

                    if (usuario.Tipo == UserType.ADMIN)
                    {
                        EmpleadoManager empleados = new EmpleadoManager();
                        Session.Add("listarEmpleados", empleados.ObtenerTodos());
                        //listaEmpleados = empleados.ObtenerTodos();
                        repeaterEmpleados.DataSource = Session["listarEmpleados"];
                        repeaterEmpleados.DataBind();
                    }
                    else if (usuario.Tipo == UserType.RECEPCIONISTA)
                    {
                        EmpleadoManager empleados = new EmpleadoManager();
                        Session.Add("listarEmpleados", empleados.ObtenerTodos());
                        //listaEmpleados = empleados.ObtenerTodos();
                        repeaterEmpleados.DataSource = Session["listarEmpleados"];
                        repeaterEmpleados.DataBind();
                    }
                    else if (usuario.Tipo == UserType.MEDICO)
                    {
                        EmpleadoManager empleados = new EmpleadoManager();
                        Session.Add("listarEmpleados", empleados.ObtenerTodos());
                        //listaEmpleados = empleados.ObtenerTodos();
                        repeaterEmpleados.DataSource = Session["listarEmpleados"];
                        repeaterEmpleados.DataBind();
                    }

                    else if (usuario.Tipo == UserType.PACIENTE)
                    {
                        Response.Redirect("DenegarPermiso.aspx", false);
                    }

                }
                else
                {
                    Session.Add("error", "Usted no tiene permiso para acceder");
                    Response.Redirect("DenegarPermiso.aspx", false);
                }

            }
        }

        protected void btnBuscarLegajo_Click(object sender, EventArgs e)
        {
            List<Empleado> lista = (List<Empleado>)Session["listarEmpleados"];
            List<Empleado> listarFiltroLegajo = lista.FindAll(x => x.Legajo.ToUpper().Contains(txtLegajoFiltro.Text.ToUpper()));
            repeaterEmpleados.DataSource = listarFiltroLegajo;
            repeaterEmpleados.DataBind();

            txtLegajoFiltro.Text = string.Empty;
        }

        protected void btnBuscarDni_Click(object sender, EventArgs e)
        {
            List<Empleado> lista = (List<Empleado>)Session["listarEmpleados"];
            List<Empleado> listarFiltroDNI = lista.FindAll(x => x.Dni.ToUpper().Contains(txtDniFiltro.Text.ToUpper()));
            repeaterEmpleados.DataSource = listarFiltroDNI;
            repeaterEmpleados.DataBind();

            txtDniFiltro.Text = string.Empty;
        }

        protected void btnBuscarApellido_Click(object sender, EventArgs e)
        {
            List<Empleado> lista = (List<Empleado>)Session["listarEmpleados"];
            List<Empleado> listarFiltroApellido = lista.FindAll(x => x.Apellido.ToUpper().Contains(txtApellidoFiltro.Text.ToUpper()));
            repeaterEmpleados.DataSource = listarFiltroApellido;
            repeaterEmpleados.DataBind();

            txtApellidoFiltro.Text = string.Empty;
        }

        protected void btnNuevoEmpleado_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarEmpleado.aspx", false);
        }

        protected void btnEditarEmpleado_Click(object sender, EventArgs e)
        {
            EmpleadoManager manager = new EmpleadoManager();
            Button btnEditar = (Button)sender;
            string legajo = btnEditar.CommandArgument;
            string dni = manager.ObtenerDNI(legajo);

            Response.Redirect("ModificarEmpleado.aspx?dni=" + dni, false);

        }

        protected void btnBajaEmpleado_Click(object sender, EventArgs e)
        {
            Button btnEditar = (Button)sender;
            string legajo = btnEditar.CommandArgument;

            EmpleadoManager manager = new EmpleadoManager();

            manager.Baja(legajo);

            Response.Write("<script>alert('Empleado Eliminado Correctamente...." + "');</script>");

            CargarLista();

        }

        //Funciones

        private void CargarLista()
        {
            EmpleadoManager empleados = new EmpleadoManager();
            listaEmpleados = empleados.ObtenerTodos();
            repeaterEmpleados.DataSource = listaEmpleados;
            repeaterEmpleados.DataBind();

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Manager;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class Configuracion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /*
        [System.Web.Services.WebMethod]
        public static string[] GetDnis(string prefixText)
        {
            EmpleadoManager empleadoManager = new EmpleadoManager();
            var dnis = empleadoManager.BuscarDnis(prefixText); 
            return dnis;
        }

        // Método para obtener los apellidos para el autocompletar
        [System.Web.Services.WebMethod]
        public static string[] GetApellidos(string prefixText)
        {
            EmpleadoManager empleadoManager = new EmpleadoManager();
            var apellidos = empleadoManager.BuscarApellidos(prefixText); 
            return apellidos;
        }
        [System.Web.Services.WebMethod]
        public static string[] GetLegajos(string prefixText)
        {
            EmpleadoManager empleadoManager = new EmpleadoManager();
            var legajos = empleadoManager.BuscarLegajosPorPrefijo(prefixText);  
            return legajos;
        }

        protected void btnBuscarLegajo_Click(object sender, EventArgs e)
        {
            string legajoStr = txtLegajo.Text;
            if (string.IsNullOrEmpty(legajoStr))
            {
                Response.Write("Por favor ingresa un legajo.");
            }
            else
            {
                int legajo = int.Parse(legajoStr); 
                mostrarUsuarioPorLegajo(legajo);   
            }
        }

        private void mostrarUsuarioPorLegajo(string legajo)
        {
            EmpleadoManager empleadoManager = new EmpleadoManager();
            string trabajador = empleadoManager.BuscarLegajos(legajo);
            if (trabajador != null)
            {
                txtNombre.Text = trabajador.Nombre;
                txtApellidoUsuario.Text = trabajador.Apellido;
                txtLegajoUsuario.Text = trabajador.Legajo.ToString();
                txtEmail.Text = trabajador.Email;
            }
            else
            {
                Response.Write("No se encontró un trabajador con ese legajo.");
            }
        }

        private void mostrarUsuarioPorDni(string dni)
        {
            EmpleadoManager empleadoManager = new EmpleadoManager();
            var usuario = empleadoManager.ObtenerPorDni(dni);
            if (usuario != null)
            {
                txtNombre.Text = usuario.Nombre;
                txtApellidoUsuario.Text = usuario.Apellido;
                txtLegajoUsuario.Text = usuario.Numero_afiliado;
                txtEmail.Text = usuario.Email;
            }
        }

        private void mostrarUsuarioPorApellido(string apellido)
        {
            EmpleadoManager empleadoManager = new EmpleadoManager();
            var usuario = empleadoManager.ObtenerPorApellido(apellido);
            if (usuario != null)
            {
                txtNombre.Text = usuario.Nombre;
                txtLegajoUsuario.Text = usuario.Numero_afiliado;
                txtDniUsuario.Text = usuario.Dni;
                txtEmail.Text = usuario.Email;
            }
        }


        */
        protected void btnBuscarDni_Click(object sender, EventArgs e)
        {
            EmpleadoManager empleadoManager2 = new EmpleadoManager();
            string dni = txtDni.Text;
            if (string.IsNullOrEmpty(dni))
            {
                // Mostrar un mensaje de error o tomar alguna acción si el campo está vacío
                Response.Write("Por favor ingresa un legajo.");
            }
            else
            {
                // Procede con la lógica de búsqueda o lo que sea necesario
                Empleado empleado = empleadoManager2.Obtener(dni);


                txtDniUsuario.Text = empleado.Dni;

            }
        }
        protected void btnBuscarLegajo_Click(object sender, EventArgs e) {
            EmpleadoManager empleadoManager1 = new EmpleadoManager();
            string legajo = txtLegajo.Text;
            if (string.IsNullOrEmpty(legajo))
            {
                // Mostrar un mensaje de error o tomar alguna acción si el campo está vacío
                Response.Write("Por favor ingresa un legajo.");
            }
            else
            {
                // Procede con la lógica de búsqueda o lo que sea necesario
                Response.Write("Legajo ingresado: " + legajo);
            }
        }
        protected void btnBuscarApellido_Click(object sender, EventArgs e)
        {
            string apellido = txtApellido.Text;
            if (string.IsNullOrEmpty(apellido))
            {
                Response.Write("Por favor ingresa un apellido.");
            }
            else
            {
                // mostrarUsuarioPorApellido(apellido);
            }
        }



        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
        
        protected void btnMoverIzquierda_Click(object sender, EventArgs e)
        {
            // Mover elementos seleccionados de lstEspecialidadesAsignadas a lstEspecialidadesDisponibles
            foreach (ListItem item in lstEspecialidadesAsignadas.Items)
            {
                if (item.Selected)
                {
                    lstEspecialidadesDisponibles.Items.Add(item);
                    lstEspecialidadesAsignadas.Items.Remove(item);
                }
            }
        }
        protected void btnMoverDerecha_Click(object sender, EventArgs e)
        {
            // Mover elementos seleccionados de lstEspecialidadesDisponibles a lstEspecialidadesAsignadas
            foreach (ListItem item in lstEspecialidadesDisponibles.Items)
            {
                if (item.Selected)
                {
                    lstEspecialidadesAsignadas.Items.Add(item);
                    lstEspecialidadesDisponibles.Items.Remove(item);
                }
            }
        }

        protected void Especialidad_Click(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                // Obtener el nombre de la especialidad seleccionada
                string especialidadSeleccionada = e.CommandArgument.ToString();

                // Actualizar el label con el detalle de la especialidad
                lblDetalleEspecialidad.Text = "Detalles de " + especialidadSeleccionada;
            }
        }
    }

}

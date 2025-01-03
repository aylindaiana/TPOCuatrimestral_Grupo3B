﻿using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPO_Cuatrimetral_Grupo3B
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                Persona persona;
                Usuario usuario = (Usuario)Session["User"];

                if (Seguridad.NivelAcceso() == UserType.PACIENTE)
                {
                    persona = (Persona)Session["Paciente"];
                }
                else 
                {
                    persona = (Persona)Session["Empleado"];
                }
                if (Session["User"] != null)
                {
                    Session["TipoUsuario"] = usuario.Tipo; // Supongamos que "Tipo" es un atributo de Usuario.
                }


                if (persona != null)
                {
                    LblPlan.Text = persona.Nombre + " " + persona.Apellido;
                }
            }
        }
    }
}
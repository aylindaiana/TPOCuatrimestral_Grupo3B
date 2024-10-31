using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Empleado: Persona
    {
        private int legajo;
        private string turno;
        private bool estado;

        public int Legajo { get; }
        public string Turno { get; }
        public bool Estado { get; }

        public Empleado(int legajo, string dni, string nombre, string apellido, DateTime fecha_nac, string telefono, string email, int id_direccion, string turno, int nivel_acceso, bool estado) 
        { 
            this.legajo = legajo;
            this.turno = turno;
            this.estado = estado;
            
            Dni = dni;
            Nombre = nombre;
            Apellido = apellido;
            Fecha_Nac = fecha_nac;
            Telefono = telefono;
            Email = email;
            Id_Direccion = id_direccion;
            Nivel_Acceso = nivel_acceso;
        }

    }
}

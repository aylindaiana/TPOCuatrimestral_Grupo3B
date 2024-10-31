using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Cliente: Persona
    {
        private int numero_afiliado;
        private string plan;
        private bool estado;

        public int Numero_afiliado { get; }
        public string Plan { get; set; }
        public bool Estado { get; }

        public Cliente(int numero_afiliado, string dni, string nombre, string apellido, DateTime fecha_nac, string telefono, string email, int id_direccion, string plan, int nivel_acceso, bool estado)
        {
            this.numero_afiliado = numero_afiliado;
            this.plan = plan;
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

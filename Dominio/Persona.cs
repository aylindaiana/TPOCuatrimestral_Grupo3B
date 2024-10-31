using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public abstract class Persona
    {
        private string dni;
        private string nombre;
        private string apellido;
        private DateTime fecha_nacimiento;
        private string telefonol;
        private string email;
        private int id_direccion;
        private int nivel_acceso;

        public string Dni { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public DateTime Fecha_Nac { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public int Id_Direccion { get; set; }
        public int Nivel_Acceso { get; set; }

    }
}

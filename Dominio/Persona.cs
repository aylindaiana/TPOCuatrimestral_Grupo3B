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

        public string Dni { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public DateTime Fecha_Nac { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public Direccion Direccion { get; set; }
        public UserType Nivel_Acceso { get; set; }

    }
}

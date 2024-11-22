using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Sanatorios
    {

        public int Id_Sanatorio { get; set; }
        public string Nombre { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public Direccion Direccion { get; set; }
        public bool Estado { get; set; }

        public Sanatorios() 
        {
            Direccion = new Direccion();
        }

    }
}

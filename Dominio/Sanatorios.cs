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
        private int id_sanatorio;
        private string nombre;
        private string telefono;
        private string email;
        private bool estado;

        public int Id_Sanatorio { get; set; }
        public string Nombre { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public bool Estado { get; }

    }
}

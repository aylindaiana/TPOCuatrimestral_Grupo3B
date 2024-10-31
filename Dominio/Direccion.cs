using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Direccion
    {
        private int id_direccion;
        private string calle;
        private int numero;
        private string localidad;
        private string codigo_postal;

        public int Id_direccion { get; }
        public string  Calle { get; set; }
        public int Numero { get; set; }
        public string Localidad { get; set;}
        public string CodigoPostal { get; set; }
    }
}

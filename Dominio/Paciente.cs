using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Paciente: Persona
    {

        public string Numero_afiliado { get; set; }
        public string Plan { get; set; }
        public bool Estado { get; set; }



    }
}

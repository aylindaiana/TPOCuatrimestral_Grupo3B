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
        public Planes Plan { get; set; }
        public DateTime FechaAlta { get; set; }
        public bool Estado { get; set; }


        public Paciente() 
        { 
            Plan = new Planes();
        }

    }
}

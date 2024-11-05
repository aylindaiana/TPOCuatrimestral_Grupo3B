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

        public int Legajo { get; set; }
        public string Turno { get; set; }
        public bool Estado { get; set; }
        

    }
}

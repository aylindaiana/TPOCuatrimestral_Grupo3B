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

        public string Legajo { get; set; }

        public DateTime Fecha_Alta { get; set; }
        public bool Estado { get; set; }
        

    }
}

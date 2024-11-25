using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class TurnoMedico
    {
        public int Id { get; set; }
        public string Legajo { get; set; }
        public string NumAfiliado { get; set; }
        public string dia { get; set; }
        public int Id_Especialidad { get; set; }
        public int Id_Sanatorio { get; set; }
        public DateTime Fecha { get; set; }
        public TimeSpan Hora { get; set; }
        public string Motivo { get; set; }
        public string Observaciones { get; set; }
        public string estado { get; set; }

        public string Medico { get; set; }
        public string Especialidad { get; set; }
    }
}

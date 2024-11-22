using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{

    public class Horarios
    {
        public TimeSpan HoraInicio { get; set; }
        public TimeSpan HoraFin { get; set; }
        public Especialidades Especialidad { get; set; }
        public string Dia { get; set; }

        public Horarios(TimeSpan HoraInicio, TimeSpan HoraFin,string Dia, Especialidades esp)
        {
            this.HoraInicio = HoraInicio;
            this.HoraFin = HoraFin;
            this.Dia = Dia;
            Especialidad = esp;
        }
    }
}

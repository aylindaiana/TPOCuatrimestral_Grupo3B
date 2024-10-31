using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Turno
    {
        private int id_turno;
        private int id_cliente;
        private int id_medico;
        //private Especialidad especialidad;
        private DateTime fecha_hora;
        private string motivo;
        private string observaciones;
        private bool estado;
    }
}

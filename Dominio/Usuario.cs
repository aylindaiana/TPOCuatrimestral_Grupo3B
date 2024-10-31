using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public enum UserType
    {
        PACIENTE = 0,
        RECEPCIONISTA = 1,
        MEDICO = 2,
        ADMIN = 3
    }

    public class Usuario
    {
        public string User { get; set; }
        public string Password { get; set; }
        public UserType TipoAcceso { get; set; }
    
    }
}

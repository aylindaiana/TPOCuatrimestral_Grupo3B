using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public enum UserType
    {
        PACIENTE = 1,
        RECEPCIONISTA = 2,
        MEDICO = 3,
        ADMIN = 4
    }

    public class Usuario
    {
        public string User { get; set; }
        public string Password { get; set; }
        public UserType TipoAcceso { get; set; }
        public bool Estado { get; set; }

        public Usuario(string User, string Password, UserType TipoAcceso, bool Estado) 
        { 
            this.User = User;
            this.Password = Password;
            this.TipoAcceso = TipoAcceso;
            this.Estado = Estado;
        }

        public Usuario() 
        {
            this.User = "null";
            this.Password = "null";
            this.TipoAcceso = UserType.PACIENTE;
            this.Estado = false;
        }

    }
}

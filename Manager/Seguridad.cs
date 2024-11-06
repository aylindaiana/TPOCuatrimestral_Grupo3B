using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public static class Seguridad
    {
        public static bool sesionActiva(object user) 
        {
            Usuario usuario = user != null ? (Usuario)user : new Usuario();
            return usuario.Estado;
        }

        public static UserType NivelAcceso(object user)
        {
            Usuario usuario = user != null ? (Usuario)user : new Usuario();
            return usuario.Tipo;
        }

    }
}

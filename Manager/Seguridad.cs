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
        private static UserType Acceso;

        public static bool sesionActiva(object user) 
        {
            Usuario usuario = user != null ? (Usuario)user : new Usuario();
            Acceso = usuario.Tipo;
            return usuario.Estado;
        }

        public static UserType NivelAcceso()
        {
            return Acceso;
        }

    }
}

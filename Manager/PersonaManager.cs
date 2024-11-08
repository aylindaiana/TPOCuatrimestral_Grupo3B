using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Manager
{
    public class PersonaManager
    {
        public string ObtenerDNI(string apellido)
        {
            AccesoDatos datos = new AccesoDatos();
            string dni="";
            try
            {
                datos.SetearConsulta("SELECT dni FROM Personas WHERE apellido = @Apellido");
                datos.SetearParametro("@Apellido", apellido);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    dni = (string)datos.Lector["dni"];
                }

                return dni;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.CerrarConeccion();
            }
        }

        public Persona BuscarPorDNI(string DNI)
        {
            AccesoDatos datos = new AccesoDatos();
            Persona persona = new Persona();
            try
            {
                datos.SetearConsulta("SELECT dni,id_acceso FROM Personas WHERE dni = @DNI");
                datos.SetearParametro("@DNI", DNI);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    persona.Dni = (string)datos.Lector["dni"];
                    persona.Nivel_Acceso = (UserType)datos.Lector["id_acceso"];
                }

                return persona;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.CerrarConeccion();
            }
        }

    }
}

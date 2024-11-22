using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;
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
                datos.SetearConsulta("SELECT nombre,apellido,dni,fecha_nac,id_direccion,calle,numero,localidad,codigo_postal,telefono,email,id_acceso FROM dbo.Obtener_Persona(@DNI);");
                datos.SetearParametro("@DNI", DNI);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    persona.Dni = (string)datos.Lector["dni"];
                    persona.Nombre = (string)datos.Lector["nombre"];
                    persona.Apellido = (string)datos.Lector["apellido"];
                    persona.Dni = (string)datos.Lector["dni"];
                    persona.Fecha_Nac = (DateTime)datos.Lector["fecha_nac"];
                    persona.Direccion.Id_direccion = (int)datos.Lector["id_direccion"];
                    persona.Direccion.Calle = (string)datos.Lector["calle"];
                    persona.Direccion.Numero = (string)datos.Lector["numero"];
                    persona.Direccion.Localidad = (string)datos.Lector["localidad"];
                    persona.Direccion.CodigoPostal = (string)datos.Lector["codigo_postal"];
                    persona.Telefono = (string)datos.Lector["telefono"];
                    persona.Email = (string)datos.Lector["email"];
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

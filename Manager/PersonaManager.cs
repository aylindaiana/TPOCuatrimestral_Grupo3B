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

        public void ActualizarPersona(Persona persona)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                if (string.IsNullOrEmpty(persona.Dni))
                {
                    throw new ArgumentException("El DNI no puede ser nulo o vacío.");
                }
                datos.SetearConsulta("EXEC sp_Actualizar_Persona @dni, @nombre, @apellido, @fecha_nac, @telefono, @email, @calle, @numero, @localidad, @codigo_postal"); 
                datos.SetearParametro("@dni", persona.Dni);
                datos.SetearParametro("@nombre", persona.Nombre);
                datos.SetearParametro("@apellido", persona.Apellido);
                datos.SetearParametro("@fecha_nac", persona.Fecha_Nac);
                datos.SetearParametro("@telefono", persona.Telefono);
                datos.SetearParametro("@email", persona.Email);
                if (persona.Direccion != null)
                {
                    datos.SetearParametro("@calle", persona.Direccion.Calle ?? string.Empty);
                    datos.SetearParametro("@numero", persona.Direccion.Numero ?? string.Empty);
                    datos.SetearParametro("@localidad", persona.Direccion.Localidad ?? string.Empty);
                    datos.SetearParametro("@codigo_postal", persona.Direccion.CodigoPostal ?? string.Empty);
                }
                else
                {
                    datos.SetearParametro("@calle", string.Empty);
                    datos.SetearParametro("@numero", string.Empty);
                    datos.SetearParametro("@localidad", string.Empty);
                    datos.SetearParametro("@codigo_postal", string.Empty);
                }

                datos.ejecutarAccion(); 
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

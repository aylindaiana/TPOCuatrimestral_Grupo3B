using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Manager
{
    public class PacienteManager
    {
        public Paciente Obtener(string DNI)
        {
            AccesoDatos datos = new AccesoDatos();
            Paciente paciente = new Paciente();
            try
            {
                datos.SetearConsulta("SELECT dni,nombre,apellido,fecha_nac,telefono,email,numero_afiliado,id_direccion,calle,numero,localidad,codigo_postal,id_acceso,estado FROM dbo.Obtener_Paciente(@dni);");
                datos.SetearParametro("@DNI", DNI);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    paciente.Dni = (string)datos.Lector["dni"];
                    paciente.Nombre = (string)datos.Lector["nombre"];
                    paciente.Apellido = (string)datos.Lector["apellido"];
                    paciente.Fecha_Nac = (DateTime)datos.Lector["fecha_nac"];
                    paciente.Telefono = (string)datos.Lector["telefono"];
                    paciente.Email = (string)datos.Lector["email"];
                    paciente.Numero_afiliado = (string)datos.Lector["numero_afiliado"];
                    paciente.Direccion.Id_direccion = (int)datos.Lector["id_direccion"];
                    paciente.Direccion.Calle = (string)datos.Lector["calle"];
                    paciente.Direccion.Numero = (string)datos.Lector["numero"];
                    paciente.Direccion.Localidad = (string)datos.Lector["localidad"];
                    paciente.Direccion.CodigoPostal = (string)datos.Lector["codigo_postal"];
                    paciente.Nivel_Acceso = (UserType)datos.Lector["id_acceso"];
                    paciente.Estado = (bool)datos.Lector["estado"];

                }

                return paciente;
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

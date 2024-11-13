using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
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
                datos.SetearConsulta("SELECT dni,nombre,apellido,fecha_nac,telefono,email,numero_afiliado,plan_pac,id_direccion,calle,numero,localidad,codigo_postal,fecha_alta,id_acceso,estado FROM dbo.Obtener_Paciente(@dni);");
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
                    paciente.Plan = (string)datos.Lector["plan_pac"];
                    paciente.Direccion.Id_direccion = (int)datos.Lector["id_direccion"];
                    paciente.Direccion.Calle = (string)datos.Lector["calle"];
                    paciente.Direccion.Numero = (string)datos.Lector["numero"];
                    paciente.Direccion.Localidad = (string)datos.Lector["localidad"];
                    paciente.Direccion.CodigoPostal = (string)datos.Lector["codigo_postal"];
                    paciente.FechaAlta = (DateTime)datos.Lector["fecha_alta"];
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



        public List<Paciente> ObtenerTodos()
        {
            AccesoDatos datos = new AccesoDatos();
            List<Paciente> listaPacientes = new List<Paciente>();
            
            try
            {
                datos.SetearConsulta("SELECT numero_afiliado,dni,nombre,apellido,fecha_nac,telefono,email,plan_pac,fecha_alta,id_direccion,calle,numero,localidad,codigo_postal,id_acceso FROM vw_Lista_Pacientes");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Paciente paciente = new Paciente();

                    paciente.Numero_afiliado = (string)datos.Lector["numero_afiliado"];
                    paciente.Dni = (string)datos.Lector["dni"];
                    paciente.Nombre = (string)datos.Lector["nombre"];
                    paciente.Apellido = (string)datos.Lector["apellido"];
                    paciente.Fecha_Nac = (DateTime)datos.Lector["fecha_nac"];
                    paciente.Telefono = (string)datos.Lector["telefono"];
                    paciente.Email = (string)datos.Lector["email"];
                    paciente.Plan = (string)datos.Lector["plan_pac"];
                    paciente.FechaAlta = (DateTime)datos.Lector["fecha_alta"];
                    paciente.Direccion.Id_direccion = (int)datos.Lector["id_direccion"];
                    paciente.Direccion.Calle = (string)datos.Lector["calle"];
                    paciente.Direccion.Numero = (string)datos.Lector["numero"];
                    paciente.Direccion.Localidad = (string)datos.Lector["localidad"];
                    paciente.Direccion.CodigoPostal = (string)datos.Lector["codigo_postal"];
                    paciente.Nivel_Acceso = (UserType)datos.Lector["id_acceso"];
                    paciente.Estado = true;


                    listaPacientes.Add(paciente);
                }

                return listaPacientes;
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


        public string ObtenerNuevoNumAfiliado()
        {
            AccesoDatos datos = new AccesoDatos();
            string numAfiliado = "";

            try
            {
                datos.SetearConsulta("SELECT  dbo.ObtenerNuevoNumeroAfiliado() AS afiliado;");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    numAfiliado = (string)datos.Lector["afiliado"];
                }

                return numAfiliado;
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

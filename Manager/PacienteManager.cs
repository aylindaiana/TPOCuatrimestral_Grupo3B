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
                datos.SetearConsulta("SELECT dni,nombre,apellido,fecha_nac,telefono,email,numero_afiliado,id_plan,plan_pac,id_direccion,calle,numero,localidad,codigo_postal,fecha_alta,id_acceso,estado FROM dbo.Obtener_Paciente(@dni);");
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
                    paciente.Plan.Id_Plan = (int)datos.Lector["id_plan"];
                    paciente.Plan.Nombre_Plan = (string)datos.Lector["plan_pac"];
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
                datos.SetearConsulta("SELECT numero_afiliado,dni,nombre,apellido,fecha_nac,telefono,email,id_plan,plan_pac,fecha_alta,id_direccion,calle,numero,localidad,codigo_postal,id_acceso FROM vw_Lista_Pacientes");
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
                    paciente.Plan.Id_Plan = (int)datos.Lector["id_plan"];
                    paciente.Plan.Nombre_Plan = (string)datos.Lector["plan_pac"];
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

        public void Agregar(Paciente nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("EXEC sp_Crear_Paciente @DNI,@NOMBRE,@APELLIDO,@FECHA_NAC,@TELEFONO,@EMAIL,@CALLE,@NUMERO,@LOCALIDAD,@COD_POSTAL,@ID_PLAN");
                datos.SetearParametro("@DNI", nuevo.Dni);
                datos.SetearParametro("@NOMBRE", nuevo.Nombre);
                datos.SetearParametro("@APELLIDO", nuevo.Apellido);
                datos.SetearParametro("@FECHA_NAC", nuevo.Fecha_Nac);
                datos.SetearParametro("@TELEFONO", nuevo.Telefono);
                datos.SetearParametro("@EMAIL", nuevo.Email);
                datos.SetearParametro("@CALLE", nuevo.Direccion.Calle);
                datos.SetearParametro("@NUMERO", nuevo.Direccion.Numero);
                datos.SetearParametro("@LOCALIDAD", nuevo.Direccion.Localidad);
                datos.SetearParametro("@COD_POSTAL", nuevo.Direccion.CodigoPostal);
                datos.SetearParametro("@ID_PLAN", nuevo.Plan.Id_Plan);
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

        public string ObtenerDNI(string NroAfiliado)
        {
            AccesoDatos datos = new AccesoDatos();
            string dni = "";
            try
            {
                datos.SetearConsulta("SELECT dni FROM Pacientes WHERE numero_afiliado = @DATO");
                datos.SetearParametro("@DATO", NroAfiliado);
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

        public void Baja(string NroAfiliado)
        {
            string dni = ObtenerDNI(NroAfiliado);
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("EXEC sp_Baja_Paciente @DNI");
                datos.SetearParametro("@DNI", dni);
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

        public void Modificar(Paciente paciente)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("EXEC sp_Actualizar_Persona @DNI,@NOMBRE,@APELLIDO,@FECHA_NAC,@TELEFONO,@EMAIL,@ID_DIRECCION,@CALLE,@NUMERO,@LOCALIDAD,@COD_POSTAL,@ID_PLAN");
                datos.SetearParametro("@DNI", paciente.Dni);
                datos.SetearParametro("@NOMBRE", paciente.Nombre);
                datos.SetearParametro("@APELLIDO", paciente.Apellido);
                datos.SetearParametro("@FECHA_NAC", paciente.Fecha_Nac);
                datos.SetearParametro("@TELEFONO", paciente.Telefono);
                datos.SetearParametro("@EMAIL", paciente.Email);
                datos.SetearParametro("@ID_DIRECCION", paciente.Direccion.Id_direccion);
                datos.SetearParametro("@CALLE", paciente.Direccion.Calle);
                datos.SetearParametro("@NUMERO", paciente.Direccion.Numero);
                datos.SetearParametro("@LOCALIDAD", paciente.Direccion.Localidad);
                datos.SetearParametro("@COD_POSTAL", paciente.Direccion.CodigoPostal);
                datos.SetearParametro("@ID_PLAN", paciente.Plan.Id_Plan);
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

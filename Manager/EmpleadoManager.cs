using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace Manager
{
    public class EmpleadoManager
    {
        public Empleado Obtener(string DNI)
        {
            AccesoDatos datos = new AccesoDatos();
            Empleado empleado= new Empleado();
            try
            {
                datos.SetearConsulta("SELECT dni,nombre,apellido,fecha_nac,telefono,email,legajo,fecha_ing,id_direccion,calle,numero,localidad,codigo_postal,id_acceso,estado FROM dbo.Obtener_Empleado (@DNI);");
                datos.SetearParametro("@DNI", DNI);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    empleado.Legajo = (string)datos.Lector["legajo"];
                    empleado.Dni = (string)datos.Lector["dni"];
                    empleado.Nombre = (string)datos.Lector["nombre"];
                    empleado.Apellido = (string)datos.Lector["apellido"];
                    empleado.Fecha_Nac = (DateTime)datos.Lector["fecha_nac"];
                    empleado.Telefono = (string)datos.Lector["telefono"];
                    empleado.Email = (string)datos.Lector["email"];
                    empleado.Fecha_Alta = (DateTime)datos.Lector["fecha_ing"];
                    empleado.Direccion.Id_direccion = (int)datos.Lector["id_direccion"];
                    empleado.Direccion.Calle = (string)datos.Lector["calle"];
                    empleado.Direccion.Numero = (string)datos.Lector["numero"];
                    empleado.Direccion.Localidad = (string)datos.Lector["localidad"];
                    empleado.Direccion.CodigoPostal = (string)datos.Lector["codigo_postal"];
                    empleado.Nivel_Acceso = (UserType)datos.Lector["id_acceso"];
                    empleado.Estado = (bool)datos.Lector["estado"];

                }

                return empleado;
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

        //Busqueda por Legajo
        public string ObtenerDNI(string Legajo)
        {
            AccesoDatos datos = new AccesoDatos();
            string dni = "";
            try
            {
                datos.SetearConsulta("SELECT dni FROM TRABAJADORES WHERE LEGAJO = @DATO");
                datos.SetearParametro("@DATO", Legajo);
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



        public List<Empleado> ObtenerTodos()
        {
            List<Empleado> lista = new List<Empleado>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT legajo,dni,nombre,apellido,fecha_nac,telefono,email,fecha_ing,id_direccion,calle,numero,localidad,codigo_postal,id_acceso FROM vw_Lista_Empleados");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Empleado empleado = new Empleado();
                    {
                        empleado.Legajo = (string)datos.Lector["legajo"];
                        empleado.Dni = (string)datos.Lector["dni"];
                        empleado.Nombre = (string)datos.Lector["nombre"];
                        empleado.Apellido = (string)datos.Lector["apellido"];
                        empleado.Fecha_Nac = (DateTime)datos.Lector["fecha_nac"];
                        empleado.Telefono = (string)datos.Lector["telefono"];
                        empleado.Email = (string)datos.Lector["email"];
                        empleado.Fecha_Alta = (DateTime)datos.Lector["fecha_ing"];
                        empleado.Direccion.Id_direccion = (int)datos.Lector["id_direccion"];
                        empleado.Direccion.Calle = (string)datos.Lector["calle"];
                        empleado.Direccion.Numero = (string)datos.Lector["numero"];
                        empleado.Direccion.Localidad = (string)datos.Lector["localidad"];
                        empleado.Direccion.CodigoPostal = (string)datos.Lector["codigo_postal"];
                        empleado.Nivel_Acceso = (UserType)datos.Lector["id_acceso"];
                        empleado.Estado = true;
                    };

                    lista.Add(empleado);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConeccion();
            }

            return lista;
        }

        public string ObtenerNuevoLegajo()
        {
            AccesoDatos datos = new AccesoDatos();
            string legajo = "";

            try
            {
                datos.SetearConsulta("SELECT dbo.ObtenerNuevoLegajo() AS legajo;");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    legajo = (string)datos.Lector["legajo"];
                }

                return legajo;
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

        public void Agregar(Empleado nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("EXEC sp_Crear_Empleado @DNI,@NOMBRE,@APELLIDO,@FECHA_NAC,@TELEFONO,@EMAIL,@CALLE,@NUMERO,@LOCALIDAD,@COD_POSTAL,@ID_ACCESO");
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
                datos.SetearParametro("@ID_ACCESO", (int)nuevo.Nivel_Acceso);
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

        public int DniRegistrado(string dni)
        { 
            AccesoDatos datos = new AccesoDatos();
            int cantidad = 0;
            try
            {
                datos.SetearConsulta("SELECT COUNT(*) AS CANTIDAD FROM Trabajadores WHERE dni = @DNI AND estado = '1'");
                datos.SetearParametro("@DNI",dni);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    cantidad = (int)datos.Lector["CANTIDAD"];
                }

                return cantidad;
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

        public void Baja(string legajo)
        {
            string dni = ObtenerDNI(legajo);
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("EXEC sp_Baja_Trabajador @DNI");
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

        public void Modificar(Empleado empleado)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("EXEC sp_MOdificar_Empleado @LEGAJO,@DNI,@NOMBRE,@APELLIDO,@FECHA_NAC,@TELEFONO,@EMAIL,@ID_DIRECCION,@CALLE,@NUMERO,@LOCALIDAD,@COD_POSTAL,@ID_ACCESO");
                datos.SetearParametro("@LEGAJO", empleado.Legajo);
                datos.SetearParametro("@DNI", empleado.Dni);
                datos.SetearParametro("@NOMBRE", empleado.Nombre);
                datos.SetearParametro("@APELLIDO", empleado.Apellido);
                datos.SetearParametro("@FECHA_NAC", empleado.Fecha_Nac);
                datos.SetearParametro("@TELEFONO", empleado.Telefono);
                datos.SetearParametro("@EMAIL", empleado.Email);
                datos.SetearParametro("@ID_DIRECCION", empleado.Direccion.Id_direccion);
                datos.SetearParametro("@CALLE", empleado.Direccion.Calle);
                datos.SetearParametro("@NUMERO", empleado.Direccion.Numero);
                datos.SetearParametro("@LOCALIDAD", empleado.Direccion.Localidad);
                datos.SetearParametro("@COD_POSTAL", empleado.Direccion.CodigoPostal);
                datos.SetearParametro("@ID_ACCESO", (int)empleado.Nivel_Acceso);
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

        public List<Empleado> listaMedicos(int id_esp)
        {
            AccesoDatos datos = new AccesoDatos();
            List<Empleado> lista = new List<Empleado>();
            try
            {
                datos.SetearConsulta("SELECT legajo,dni,nombre,apellido FROM dbo.Buscar_Medicos(@ID_ESP);");
                datos.SetearParametro("@ID_ESP", id_esp);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Empleado empleado = new Empleado();

                    empleado.Legajo = (string)datos.Lector["legajo"];
                    empleado.Dni = (string)datos.Lector["dni"];
                    empleado.Nombre = (string)datos.Lector["nombre"];
                    empleado.Apellido = (string)datos.Lector["apellido"];
                    empleado.Estado = true;

                    lista.Add(empleado);
                }

                return lista;
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

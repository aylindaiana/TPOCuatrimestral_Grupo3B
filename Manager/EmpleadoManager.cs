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
        public string ObtenerDNI(int Legajo)
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
    }
}

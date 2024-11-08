using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
                datos.SetearConsulta("SELECT dni,nombre,apellido,fecha_nac,telefono,email,legajo,turno,id_direccion,calle,numero,localidad,codigo_postal,id_acceso,estado FROM dbo.Obtener_Empleado (@DNI);");
                datos.SetearParametro("@DNI", DNI);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    empleado.Dni = (string)datos.Lector["dni"];
                    empleado.Nombre = (string)datos.Lector["nombre"];
                    empleado.Apellido = (string)datos.Lector["apellido"];
                    empleado.Fecha_Nac = (DateTime)datos.Lector["fecha_nac"];
                    empleado.Telefono = (string)datos.Lector["telefono"];
                    empleado.Email = (string)datos.Lector["email"];
                    empleado.Legajo = (int)datos.Lector["legajo"];
                    empleado.Turno = (string)datos.Lector["turno"];
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



        public List<Empleado> filtrar(string campo, string filtro)
        {
            List<Empleado> lista = new List<Empleado>();
            AccesoDatos datos = new AccesoDatos();

            string consulta = "SELECT P.dni, P.nombre, P.apellido, P.fecha_nac, P.telefono, P.email, T.legajo, T.turno, D.calle, D.numero, D.localidad, D.codigo_postal " +
                              "FROM Trabajadores T " +
                              "INNER JOIN Personas P ON P.dni = T.dni " +
                              "INNER JOIN Direcciones D ON D.id_direccion = P.id_direccion";

            if (!string.IsNullOrEmpty(campo) && !string.IsNullOrEmpty(filtro))
            {
                if (campo.ToLower() == "legajo")
                {
                    consulta += " WHERE T.legajo = @filtro";
                }
                else if (campo.ToLower() == "dni")
                {
                    consulta += " WHERE P.dni = @filtro";
                }
                else if (campo.ToLower() == "apellido")
                {
                    consulta += " WHERE P.apellido LIKE @filtro";
                    filtro = "%" + filtro + "%";
                }
            }
            try
            {
                datos.SetearConsulta(consulta);
                datos.SetearParametro("@filtro", filtro);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Empleado empleado = new Empleado();
                    {
                        empleado.Dni = datos.Lector["dni"].ToString();
                        empleado.Nombre = datos.Lector["nombre"].ToString();
                        empleado.Apellido = datos.Lector["apellido"].ToString();
                        empleado.Legajo = int.Parse(datos.Lector["legajo"].ToString());
                        empleado.Email = datos.Lector["email"].ToString();
                        empleado.Telefono = datos.Lector["telefono"].ToString();
                        empleado.Direccion.Calle = datos.Lector["calle"].ToString();
                        empleado.Direccion.Numero = datos.Lector["numero"].ToString();
                        empleado.Direccion.Localidad = datos.Lector["localidad"].ToString();
                        empleado.Direccion.CodigoPostal = datos.Lector["codigo_postal"].ToString();
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

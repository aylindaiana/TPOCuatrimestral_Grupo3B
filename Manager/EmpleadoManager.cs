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
        public Empleado ObtenerEmpleado(string DNI)
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
                    empleado.Direccion.Numero = (int)datos.Lector["numero"];
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
    }
}

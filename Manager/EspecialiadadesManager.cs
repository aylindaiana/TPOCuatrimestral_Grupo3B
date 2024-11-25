using Dominio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace Manager
{
    public class EspecialiadadesManager
    {
        public List<Especialidades> ObtenerTodos()
        {
            List<Especialidades> lista = new List<Especialidades>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT id_especialidad,especialidad FROM Especialidades");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Especialidades aux = new Especialidades();

                    aux.Id = (int)datos.Lector["id_especialidad"];
                    aux.Nombre = datos.Lector["especialidad"].ToString();

                    lista.Add(aux);
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

        public void Agregar(Especialidades esp, string legajo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("EXEC sp_Asignar_Especialidades @LEGAJO,@ID_ESPECIALIDAD");
                datos.SetearParametro("@LEGAJO", legajo);
                datos.SetearParametro("@ID_ESPECIALIDAD", esp.Id);
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

        public void AgregarNuevaEspecialidad(Especialidades esp)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("EXEC sp_crear_especialidad @NOMBRE_ESPECIALIDAD");
                datos.SetearParametro("@NOMBRE_ESPECIALIDAD", esp.Nombre);
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

        public void EliminarEspecialidad(Especialidades esp, out int resultado)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("EXEC sp_eliminar_especialidad @ID_ESPECIALIDAD, @pResultado OUTPUT");
                datos.SetearParametro("@ID_ESPECIALIDAD", esp.Id);
                SqlParameter pResultado = new SqlParameter("@pResultado", SqlDbType.Int)
                {
                    Direction = ParameterDirection.Output
                };
                datos.Comando.Parameters.Add(pResultado);
                datos.ejecutarAccion();
                resultado = (int)pResultado.Value;
            }
            catch (Exception ex)
            {
                resultado = -1;
                throw ex;
            }
            finally
            {
                datos.CerrarConeccion();
            }
        }
    }
}

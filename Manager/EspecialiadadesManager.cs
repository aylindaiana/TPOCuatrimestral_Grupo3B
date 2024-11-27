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
                datos.SetearConsulta("SELECT id_especialidad, especialidad, estado FROM Especialidades");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Especialidades aux = new Especialidades();

                    aux.Id = (int)datos.Lector["id_especialidad"];
                    aux.Nombre = datos.Lector["especialidad"].ToString();
                    aux.Estado = (bool)datos.Lector["estado"];

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

        public void BajaAltaEsp(Especialidades aux)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {

                datos.SetearConsulta("EXEC sp_baja_alta_especialidad @ID_ESPECIALIDAD, @ESTADOS_ACTUAL");
                datos.SetearParametro("@ID_ESPECIALIDAD", aux.Id);
                datos.SetearParametro("@ESTADOS_ACTUAL", aux.Estado);
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

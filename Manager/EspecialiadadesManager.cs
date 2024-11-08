using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace Manager
{
    public class EspecialiadadesManager
    {
        public List<string> ObtenerTodos()
        {
            List<string> lista = new List<string>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT especialidad FROM Especialidades");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add((string)datos.Lector["especialidad"]);
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

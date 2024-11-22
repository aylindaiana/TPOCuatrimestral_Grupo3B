using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Manager
{
    public class PlanesManager
    {
        public List<Planes> ObtenerTodos()
        {
            List<Planes> lista = new List<Planes>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT id_plan,nombre FROM Planes");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Planes plan = new Planes();

                    plan.Id_Plan = (int)datos.Lector["id_plan"];
                    plan.Nombre_Plan = (string)datos.Lector["nombre"];

                    lista.Add(plan);
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

        public void Agregar(Planes plan)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("INSERT Planes (nombre) VALUES (@NOMBRE)");
                datos.SetearParametro("@NOMBRE", plan.Nombre_Plan);
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

        public int nuevoID()
        {
            AccesoDatos datos = new AccesoDatos();
            int id = -1;
            try
            {
                datos.SetearConsulta("SELECT dbo.ObtenerNuevoIdPlan() AS ID");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    id = (int)datos.Lector["ID"];
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

            return id;
        }

    }
}

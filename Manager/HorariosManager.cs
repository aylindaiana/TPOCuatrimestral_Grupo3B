using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Manager
{
    public class HorariosManager
    {
        public List<Horarios> ObtenerTodos(string Legajo)
        {
            List<Horarios> lista = new List<Horarios>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT hora_inicio,hora_fin,dia,id_especialidad,especialidad FROM dbo.Obtener_Horarios(@LEGAJO);");
                datos.SetearParametro("@LEGAJO",Legajo);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Especialidades aux = new Especialidades();

                    TimeSpan hora_inicio = (TimeSpan)datos.Lector["hora_inicio"];
                    TimeSpan hora_fin = (TimeSpan)datos.Lector["hora_fin"];
                    string dia = (string)datos.Lector["dia"];
                    aux.Id = (int)datos.Lector["id_especialidad"];
                    aux.Nombre = (string)datos.Lector["especialidad"];

                    lista.Add(new Horarios(hora_inicio,hora_fin,dia,aux));
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

        public void Agregar(Horarios nuevo, string legajo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("EXEC SP_Agregar_Horario_Trabajador @LEGAJO,@DIA,@HORA_INICIO,@HORA_FIN,@ID_ESPECIALIDAD");
                datos.SetearParametro("@LEGAJO", legajo);
                datos.SetearParametro("@DIA", nuevo.Dia);
                datos.SetearParametro("@HORA_INICIO", nuevo.HoraInicio);
                datos.SetearParametro("@HORA_FIN", nuevo.HoraFin);
                datos.SetearParametro("@ID_ESPECIALIDAD", nuevo.Especialidad.Id);
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

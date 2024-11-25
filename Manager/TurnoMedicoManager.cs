using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Manager
{
    public class TurnoMedicoManager
    {
        public List<DateTime> ObtenerFechas(string legajo, string dia)
        {
            AccesoDatos datos = new AccesoDatos();
            List<DateTime> lista = new List<DateTime>();
            try
            {
                datos.SetearConsulta("SELECT Fecha FROM obtenerFechasDisponibles (@LEGAJO,@DIA);");
                datos.SetearParametro("@LEGAJO", legajo);
                datos.SetearParametro("@DIA",dia);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    DateTime aux = new DateTime();
                    aux = (DateTime)datos.Lector["Fecha"];

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


        public List<TurnoMedico> ObtenerHorarios(DateTime fecha, string legajo)
        {
            AccesoDatos datos = new AccesoDatos();
            List<TurnoMedico> lista = new List<TurnoMedico>();
            try
            {
                datos.SetearConsulta("select id_turno,hora from obtenerHorariosDisponibles(@FECHA,@LEGAJO);");
                datos.SetearParametro("@FECHA", fecha);
                datos.SetearParametro("@LEGAJO", legajo);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    TurnoMedico aux = new TurnoMedico();
                    aux.Id = (int)datos.Lector["id_turno"];
                    aux.Hora = (TimeSpan)datos.Lector["hora"];

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

        public void AsignarTurno(TurnoMedico turno)
        {
            AccesoDatos datos = new AccesoDatos();
            List<TurnoMedico> lista = new List<TurnoMedico>();
            try
            {
                datos.SetearConsulta("EXEC asignarTurno @ID_TURNO,@NUM_AFIL,@MOTIVO,@ID_SANATORIO");
                datos.SetearParametro("@ID_TURNO", turno.Id);
                datos.SetearParametro("@NUM_AFIL", turno.NumAfiliado);
                datos.SetearParametro("@MOTIVO",turno.Motivo);
                datos.SetearParametro("@ID_SANATORIO", turno.Id_Sanatorio);
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

        public void ActaulizarTurno(TurnoMedico turno)
        {
            AccesoDatos datos = new AccesoDatos();
            List<TurnoMedico> lista = new List<TurnoMedico>();
            try
            {
                datos.SetearConsulta("exec actualizarTurno @ID_TURNO,@OBS,@ESTADO");
                datos.SetearParametro("@ID_TURNO", turno.Id);
                datos.SetearParametro("@OBS", turno.Observaciones);
                datos.SetearParametro("@ESTADO", turno.estado);
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

        public List<TurnoMedico> ObtenerTodos()
        {
            AccesoDatos datos = new AccesoDatos();
            List<TurnoMedico> lista = new List<TurnoMedico>();
            try
            {
                datos.SetearConsulta("SELECT id_turno,num_afiliado,apellido,id_especialidad,especialidad,Fecha,hora,estado FROM vwTodosTurnos");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    TurnoMedico aux = new TurnoMedico();

                    aux.Id = (int)datos.Lector["id_turno"];
                    aux.NumAfiliado = !(datos.Lector["num_afiliado"] is DBNull) ? (string)datos.Lector["num_afiliado"] : "";
                    aux.Medico = (string)datos.Lector["apellido"];
                    aux.Especialidad = (string)datos.Lector["especialidad"];
                    aux.Id_Especialidad = (int)datos.Lector["id_especialidad"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.Hora = (TimeSpan)datos.Lector["hora"];
                    aux.estado = (string)datos.Lector["estado"];


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

        public List<TurnoMedico> ObtenerTodos(string numAfiliado)
        {
            AccesoDatos datos = new AccesoDatos();
            List<TurnoMedico> lista = new List<TurnoMedico>();
            try
            {
                datos.SetearConsulta("select id_turno,legajo,num_afiliado,dia,Fecha,hora,motivo,observaciones,estado from Turnos where num_afiliado = @NUM_AFIL");
                datos.SetearParametro("@NUM_AFIL", numAfiliado);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    TurnoMedico aux = new TurnoMedico();

                    aux.Id = (int)datos.Lector["id_turno"];
                    aux.Legajo = (string)datos.Lector["legajo"];
                    aux.dia = (string)datos.Lector["dia"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.Hora = (TimeSpan)datos.Lector["hora"];
                    aux.estado = (string)datos.Lector["estado"];

                    aux.NumAfiliado = !(datos.Lector["num_afiliado"] is DBNull) ? (string)datos.Lector["num_afiliado"] : "";

                    aux.Motivo = !(datos.Lector["motivo"] is DBNull) ? (string)datos.Lector["motivo"] : "";

                    aux.Observaciones = !(datos.Lector["observaciones"] is DBNull) ? (string)datos.Lector["observaciones"] : "";


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


        public TurnoMedico BuscarTurno(int id_turno)
        {
            AccesoDatos datos = new AccesoDatos();
            TurnoMedico aux = new TurnoMedico();

            try
            {
                datos.SetearConsulta("select id_turno,legajo,num_afiliado,dia,Fecha,hora,motivo,observaciones,estado from Turnos where num_afiliado = @NUM_AFIL");
                datos.SetearParametro("@ID_TUR", id_turno);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    aux.Id = (int)datos.Lector["id_turno"];
                    aux.Legajo = (string)datos.Lector["legajo"];
                    aux.dia = (string)datos.Lector["dia"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.Hora = (TimeSpan)datos.Lector["hora"];
                    aux.estado = (string)datos.Lector["estado"];

                    aux.NumAfiliado = !(datos.Lector["num_afiliado"] is DBNull) ? (string)datos.Lector["num_afiliado"] : "";

                    aux.Motivo = !(datos.Lector["motivo"] is DBNull) ? (string)datos.Lector["motivo"] : "";

                    aux.Observaciones = !(datos.Lector["observaciones"] is DBNull) ? (string)datos.Lector["observaciones"] : "";

                }

                return aux;
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

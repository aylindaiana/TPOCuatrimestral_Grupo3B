using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Manager
{
    public class SanatorioManager
    {
        public List<Sanatorios> ObtenerTodos()
        {
            List<Sanatorios> lista = new List<Sanatorios>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT id_sanatorio,nombre,telefono,email,id_direccion,calle,numero,localidad,codigo_postal FROM vw_Lista_Sanatorios");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Sanatorios aux = new Sanatorios();

                    aux.Id_Sanatorio = (int)datos.Lector["id_sanatorio"];
                    aux.Nombre = (string)datos.Lector["nombre"];
                    aux.Telefono= (string)datos.Lector["telefono"];
                    aux.Email= (string)datos.Lector["email"];
                    aux.Direccion.Id_direccion = (int)datos.Lector["id_direccion"];
                    aux.Direccion.Calle = (string)datos.Lector["calle"];
                    aux.Direccion.Numero = (string)datos.Lector["numero"];
                    aux.Direccion.Localidad = (string)datos.Lector["localidad"];
                    aux.Direccion.CodigoPostal = (string)datos.Lector["codigo_postal"];
                    aux.Estado = true;

                    lista.Add(aux);
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


        public Sanatorios Obtener(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            Sanatorios aux = new Sanatorios();

            try
            {
                datos.SetearConsulta("SELECT id_sanatorio,nombre,telefono,email,id_direccion,calle,numero,localidad,codigo_postal FROM BuscarSanatorio(@DATO);");
                datos.SetearParametro("@DATO",id);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    aux.Id_Sanatorio = (int)datos.Lector["id_sanatorio"];
                    aux.Nombre = (string)datos.Lector["nombre"];
                    aux.Telefono = (string)datos.Lector["telefono"];
                    aux.Email = (string)datos.Lector["email"];
                    aux.Direccion.Id_direccion = (int)datos.Lector["id_direccion"];
                    aux.Direccion.Calle = (string)datos.Lector["calle"];
                    aux.Direccion.Numero = (string)datos.Lector["numero"];
                    aux.Direccion.Localidad = (string)datos.Lector["localidad"];
                    aux.Direccion.CodigoPostal = (string)datos.Lector["codigo_postal"];
                    aux.Estado = true;
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

            return aux;
        }

        public void Agregar(Sanatorios sanatorio)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("EXEC sp_Agregar_Sanatorio @NOMBRE, @CALLE, @NUMERO, @LOCALIDAD,@COD_POSTAL,@TELEFONO,@EMAIL;");
                datos.SetearParametro("@NOMBRE", sanatorio.Nombre);
                datos.SetearParametro("@CALLE", sanatorio.Direccion.Calle);
                datos.SetearParametro("@NUMERO", sanatorio.Direccion.Numero);
                datos.SetearParametro("@LOCALIDAD", sanatorio.Direccion.Localidad);
                datos.SetearParametro("@COD_POSTAL", sanatorio.Direccion.CodigoPostal);
                datos.SetearParametro("@TELEFONO", sanatorio.Telefono);
                datos.SetearParametro("@EMAIL", sanatorio.Email);
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
            int id= -1;
            try
            {
                datos.SetearConsulta("SELECT dbo.ObtenerNuevoIdSanatorio() AS ID");
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

        public void AsignarPlan(int id_sanatorio,int id_plan)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("INSERT Sanatorios_x_planes(id_sanatorio, id_plan) VALUES(@ID_SANATORIO, @ID_PLAN)");
                datos.SetearParametro("@ID_SANATORIO", id_sanatorio);
                datos.SetearParametro("@ID_PLAN", id_plan);
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

        public List<Sanatorios> ObtenerTodos(int IdPlan)
        {
            List<Sanatorios> lista = new List<Sanatorios>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT id_sanatorio,nombre,telefono,email,id_direccion,calle,numero,localidad,codigo_postal FROM dbo.Sanatorios_por_Plan(@ID_PLAN);");
                datos.SetearParametro("@ID_PLAN", IdPlan);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Sanatorios aux = new Sanatorios();

                    aux.Id_Sanatorio = (int)datos.Lector["id_sanatorio"];
                    aux.Nombre = (string)datos.Lector["nombre"];
                    aux.Telefono = (string)datos.Lector["telefono"];
                    aux.Email = (string)datos.Lector["email"];
                    aux.Direccion.Id_direccion = (int)datos.Lector["id_direccion"];
                    aux.Direccion.Calle = (string)datos.Lector["calle"];
                    aux.Direccion.Numero = (string)datos.Lector["numero"];
                    aux.Direccion.Localidad = (string)datos.Lector["localidad"];
                    aux.Direccion.CodigoPostal = (string)datos.Lector["codigo_postal"];
                    aux.Estado = true;

                    lista.Add(aux);
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

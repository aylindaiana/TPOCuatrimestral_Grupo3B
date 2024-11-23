using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Dominio;

namespace Manager
{
    public class UsuarioManager
    {
        public Usuario Login(string user, string pass)
        {
            AccesoDatos datos = new AccesoDatos();
            Usuario usuario = new Usuario();
            try
            {
                datos.SetearConsulta("SELECT Usuario,Pass,id_acceso,estado FROM Usuarios WHERE Usuario = @Usuario AND Pass = @Pass AND estado = '1'");
                datos.SetearParametro("@Usuario", user);
                datos.SetearParametro("@Pass", pass);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    usuario.User = (string)datos.Lector["Usuario"];
                    usuario.Password = (string)datos.Lector["Pass"];
                    usuario.Tipo = (UserType)datos.Lector["id_acceso"];
                    usuario.Estado = (bool)datos.Lector["estado"];
                }

                return usuario;
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

        public void RestablecerPass(string dni)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("EXEC sp_Restablecer_Pass @DNI");
                datos.SetearParametro("@DNI", dni);
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

        public void CambiarPass(string usuario, string nuevaContrasena)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Cambio la consulta para pasar ambos parametros (usuario y nueva contraseña)
                datos.SetearConsulta("EXEC sp_Cambiar_Contrasena @Usuario, @NuevaContrasena");

                // Seteo los parametros para la consulta
                datos.SetearParametro("@Usuario", usuario);
                datos.SetearParametro("@NuevaContrasena", nuevaContrasena);

               
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {               
                throw new Exception("Error al cambiar la contraseña", ex);
            }
            finally
            {       
                datos.CerrarConeccion();
            }
        }
    }
}

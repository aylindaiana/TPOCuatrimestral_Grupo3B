using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Manager
{
    public class EmailService
    {
        private MailMessage email;
        private SmtpClient server;

        public EmailService()
        {
            server = new SmtpClient();
            server.Credentials = new NetworkCredential("sofireynoso555@gmail.com", "Programacion3");
            server.EnableSsl = true;
            server.Port = 587;
            server.Host = "smtp.gmail.com";
        }
        public void ArmarCorreo(string emailDestino, string asunto, string cuerpo)
        {
            if (string.IsNullOrEmpty(emailDestino))
            {
                throw new Exception("El correo electrónico del destinatario no es válido.");
            }

            email = new MailMessage();

            email.From = new MailAddress("sofireynoso555@gmail.com");
            email.Subject = asunto;
            email.IsBodyHtml = true;
            email.Body = cuerpo;
            
            email.To.Add(emailDestino);
        }

        public void EnviarCorreoCambioContraseña(string emailDestino)
        {
            string asunto = "Notificación de Cambio de Contraseña Exitoso";
            string cuerpo = "<p>Estimado usuario,</p>" +
                            "<p>Le informamos que su contraseña ha sido cambiada exitosamente. Si no fue usted, por favor contacte con soporte inmediatamente.</p>" +
                            "<p>Saludos,<br>El equipo de soporte.</p>";

            try
            {
                ArmarCorreo(emailDestino, asunto, cuerpo);
                server.Send(email);
            }
            catch (SmtpException smtpEx)
            {
                throw new Exception("Error con el servidor SMTP: " + smtpEx.Message, smtpEx);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al enviar el correo: " + ex.Message, ex);
            }
        }

    }
}

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CambioContraseña.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.CambioContraseña" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- estilo -->
    <style>
        /*ancho de los campos */
        .form-control.short-field {
            max-width: 300px; 
        }

         /* Contenedor centrado */
        .content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
    </style>

     <!-- contenido -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="mb-4">Cambio de contraseña</h1>
    <form>
        <fieldset>
            <div class="mb-3">
               <asp:TextBox ID="ContraseñaVieja" runat="server" TextMode="Password" CssClass="form-control short-field" Placeholder="Ingresa tu contraseña vieja" />
            </div>
            <div class="mb-3">
              <asp:TextBox ID="ContraseñaNueva" runat="server" TextMode="Password" CssClass="form-control short-field" Placeholder="Ingresa tu nueva contraseña" />
            </div>
            <asp:Button ID="btnCambiar" runat="server" CssClass="btn btn-primary" Text="Cambiar" OnClick="btnCambiar_Click" />
        </fieldset>
    </form>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarTurno.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.AgregarTurno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Contenedor Principal -->
    <div class="ContenedorPrincipal mx-4">

        <!-- Contenedor encabesado -->
       <div class="titulos" style="padding-bottom: 25px;">
            <h1>Tomar un Nuevo Turno</h1>
            <h5>Recuerde cancelar el turno si no puede asistir. Lo puede hacer desde el sistema Web ingresando en "Mis Turnos". Gracias</h5>
            <hr />
        </div>

        <!-- contenedor del combobox -->
        <h3>Seleccione una especialidad:</h3>
        <div class="ComboBox d-flex" style="max-width:80vh" >
            <asp:DropDownList ID="especialidadSelect" runat="server" CssClass="form-control">
                <asp:ListItem Text="Seleccione una opción" Value="" />
                <asp:ListItem Text="Especialidad 1" Value="1" />
                <asp:ListItem Text="Especialidad 2" Value="2" />
                <asp:ListItem Text="Especialidad 3" Value="3" />
            </asp:DropDownList>
             <asp:Button ID="btnVerEspecialistas" runat="server" Text="Ver Especialistas" CssClass="btn btn-primary" style="margin-left: 10px;" /> 
        </div>
    </div> 
</asp:Content>




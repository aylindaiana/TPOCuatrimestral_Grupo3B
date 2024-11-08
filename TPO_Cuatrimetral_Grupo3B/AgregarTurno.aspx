<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarTurno.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.AgregarTurno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style>
        .info-panel {
    display: block; /* Asegúrate de que sea visible cuando se activa */
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="ContenedorPrincipal mx-4">
        <div class="titulos" style="padding-bottom: 25px;">
            <h1>Tomar un Nuevo Turno</h1>
            <h5>Recuerde cancelar el turno si no puede asistir. <br />
                Lo puede hacer desde el sistema Web ingresando en "Mis Turnos". <br />
                Gracias</h5>
            <hr />
        </div>

        <div class="row">
            <div class="col-md-6">
                <h3>Seleccione una especialidad:</h3>
                <div class="ComboBox d-flex" style="max-width:80vh">
                    <asp:DropDownList ID="especialidadSelect" runat="server" CssClass="form-control"></asp:DropDownList>
<asp:Button ID="btnVerEspecialistas" runat="server" Text="Ver Especialistas" CssClass="btn btn-primary" style="margin-left: 10px;" OnClick="btnVerEspecialistas_Click" />                </div>
            </div>

            <div class="col-md-6">
                <h4>Información del Paciente:</h4>
                <div class="form-group">
                    <label for="nombrePaciente">Nombre Paciente</label>
                    <asp:TextBox ID="lblNombre" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="apellidoPaciente">Apellido Paciente</label>
                    <asp:TextBox ID="lblApellido" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="dniPaciente">DNI</label>
                    <asp:TextBox ID="lblDNI" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="legajoPaciente">Legajo</label>
                    <asp:TextBox ID="lblLegajo" runat="server" CssClass="form-control" />
                </div>
                 <div class="form-group">
                    <label for="horaTurno">Hora del Turno</label>
                    <asp:DropDownList ID="ddlHoraTurno" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Seleccione una hora" Value="" />
                        <asp:ListItem Text="08:00" Value="08:00" />
                        <asp:ListItem Text="09:00" Value="09:00" />
                        <asp:ListItem Text="10:00" Value="10:00" />
                        <asp:ListItem Text="11:00" Value="11:00" />
                        <asp:ListItem Text="12:00" Value="12:00" />
                        <asp:ListItem Text="13:00" Value="13:00" />
                        <asp:ListItem Text="14:00" Value="14:00" />
                        <asp:ListItem Text="15:00" Value="15:00" />
                        <asp:ListItem Text="16:00" Value="16:00" />
                        <asp:ListItem Text="17:00" Value="17:00" />
                        <asp:ListItem Text="18:00" Value="18:00" />
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <!--Para el filtro-->
        <asp:Panel ID="pnlInfoEspecialista" runat="server" Visible="false">
            <div class="col-md-6">
            <h4>Información del Médico:</h4>
            <div class="form-group">
                <label for="nombreMedico">Nombre del Medico</label>
                <asp:TextBox ID="lblNombreMedico" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label for="apellidoMedico">Apellido del Medico</label>
                <asp:TextBox ID="lblApellidoMedico" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label for="dniMedico">DNI</label>
                <asp:TextBox ID="lblDNIMedico" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label for="legajoMedico">Legajo</label>
                <asp:TextBox ID="lblLegajoMedico" runat="server" CssClass="form-control" />
            </div>
                </div>
        </asp:Panel>

        <asp:GridView ID="gvPaciente" runat="server" AutoGenerateColumns="False" CssClass="table table-striped mt-4">
            <Columns>
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                <asp:BoundField DataField="DNI" HeaderText="DNI" />
                <asp:BoundField DataField="Legajo" HeaderText="Legajo" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

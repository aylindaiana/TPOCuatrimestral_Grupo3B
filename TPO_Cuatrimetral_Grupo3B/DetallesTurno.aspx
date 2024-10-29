<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetallesTurno.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.DetallesTurno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="ContenedorPrincipal mx-4">

        <div class="row">
            <div class="col-md-8">                
                <div class="card mb-3">
                    <div class="card-body">
                        <h3 class="card-title">Detalles</h3>
                        <div class="form-group">
                            <asp:Label ID="lblDetalles" runat="server" CssClass="form-control" Text="Información del turno..."></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <h4 class="card-title">Observaciones - Médico</h4>
                        <asp:TextBox ID="txtObsMedico" runat="server" CssClass="form-control flex-grow-1" TextMode="MultiLine" style="resize: none;" Rows="4"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="col-md-4 d-flex flex-column align-items-center justify-content-center">
                <asp:Button ID="btnReprogramar" runat="server" Text="Reprogramar" CssClass="btn btn-secondary mb-2" OnClick="btnReprogramar_Click" />
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success mb-2" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-danger mb-2" OnClick="btnCancelar_Click" />
                <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btn-light" OnClick="btnVolver_Click" />

            </div>
                        <div class="col-md-6">
                <h4>Información del Paciente:</h4>
                <div class="form-group">
                    <label for="nombrePaciente">Nombre Paciente</label>
                    <asp:Label ID="lblNombre" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="apellidoPaciente">Apellido Paciente</label>
                    <asp:Label ID="lblApellido" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="dniPaciente">DNI</label>
                    <asp:Label ID="lblDNI" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="legajoPaciente">Legajo</label>
                    <asp:Label ID="lblLegajo" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="fechaPaciente">Fecha</label>
                    <asp:Label ID="lblFecha" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="horarioPaciente">Horario</label>
                    <asp:Label ID="lblHorario" runat="server" CssClass="form-control" />
                </div>
            </div>
        </div>

    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Configuracion-Turnos.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Configuracion_Turnos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
        <h2 class="mb-4">Configuración de Turnos</h2>

        <div class="row">
            <div class="col-md-4">
                <label for="ddlProfesionales" class="form-label">Profesional:</label>
                <asp:DropDownList ID="ddlProfesionales" runat="server" CssClass="form-select" AutoPostBack="true" 
                    OnSelectedIndexChanged="ddlProfesionales_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <div class="col-md-4">
                <label for="ddlEspecialidades" class="form-label">Especialidad:</label>
                <asp:DropDownList ID="ddlEspecialidades" runat="server" CssClass="form-select" 
                    AutoPostBack="true" OnSelectedIndexChanged="ddlEspecialidad_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <div class="col-md-4">
                <label for="chkDias" class="form-label">Días disponibles:</label>
                <asp:CheckBoxList ID="chkDias" runat="server" CssClass="form-check">
                </asp:CheckBoxList>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-md-4">
                <label for="ddlHorarioInicio" class="form-label">Horario Inicio:</label>
                <asp:DropDownList ID="ddlHorarioInicio" runat="server" CssClass="form-select">
                </asp:DropDownList>
            </div>


            <div class="col-md-4">
                <label for="ddlHorarioFin" class="form-label">Horario Fin:</label>
                <asp:DropDownList ID="ddlHorarioFin" runat="server" CssClass="form-select">
                </asp:DropDownList>
            </div>
            <div class="col-md-4">
                <label for="ddlEstado" class="form-label">Estado del Turno:</label>
                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Confirmado" Value="Confirmado"></asp:ListItem>
                    <asp:ListItem Text="Cancelado" Value="Cancelado"></asp:ListItem>
                </asp:DropDownList>
            </div>

        </div>

        <div class="row mt-4">
            <div class="col-md-6 d-grid gap-2">
                <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar Configuración" OnClick="btnGuardar_Click" />
            </div>
            <div class="col-md-6 d-grid gap-2">
                <asp:Button ID="btnLimpiar" runat="server" CssClass="btn btn-secondary" Text="Limpiar" OnClick="btnLimpiar_Click" />
            </div>
        </div>

        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger mt-3" Text="" Visible="false"></asp:Label>

    </div>
</asp:Content>

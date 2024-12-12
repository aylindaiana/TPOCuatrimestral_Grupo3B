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
                <label for="txtDuracionTurno" class="form-label">Duración del Turno (HORAS REDONDEADAS):</label>
                <asp:TextBox ID="txtDuracionTurno" runat="server" CssClass="form-control" placeholder="Duración"></asp:TextBox>
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

        <div class="table-responsive mt-5">
            <asp:GridView ID="gvConfiguraciones" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="false" 
                OnRowCommand="gvConfiguraciones_RowCommand">
                <Columns>
                    <asp:BoundField DataField="NombreProfesional" HeaderText="Profesional" />
                    <asp:BoundField DataField="Especialidad" HeaderText="Especialidad" />
                    <asp:BoundField DataField="DiasDisponibles" HeaderText="Días" />
                    <asp:BoundField DataField="Horario" HeaderText="Horario" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnEditar" runat="server" CssClass="btn btn-sm btn-warning" Text="Editar" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-sm btn-danger" Text="Eliminar" CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

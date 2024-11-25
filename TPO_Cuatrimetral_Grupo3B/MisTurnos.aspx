<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisTurnos.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.MisTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <<div class="container">

        <div class="row justify-content-center" style="padding-top: 30px">
            <div class="container-fluid">
                <div class="row button-row mb-5 text-center">
                    <!-- Filtro por ID -->
                    <div class="col-4">
                        <div class="input-group mb-3">
                            <asp:TextBox ID="txtIdFiltro" CssClass="form-control" runat="server" Placeholder="ID TURNO"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button ID="btnBuscarId" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarId_Click" />
                            </div>
                        </div>
                    </div>

                    <!-- Filtro especialidad -->
                    <div class="col-3">
                        <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlEspecialidad_SelectedIndexChanged">
                            <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!--Filtro Estado-->
                    <div class="col-3">
                        <asp:DropDownList ID="ddlEstadoTurno" runat="server" CssClass="form-select"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlEstadoTurno_SelectedIndexChanged">
                            <asp:ListItem Text="Seleccione una opccion" Value="0" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="sin asignar" Value="1" Selected="false"></asp:ListItem>
                            <asp:ListItem Text="pendiente" Value="2" Selected="false"></asp:ListItem>
                            <asp:ListItem Text="cancelado" Value="3" Selected="false"></asp:ListItem>
                            <asp:ListItem Text="realizado" Value="4" Selected="false"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-3">
                        <div class="button" style="margin-bottom: 20px;">
                            <asp:Button ID="btnNuevoEmpleado" class="btn btn-primary btn-sm" Text="+ Nuevo Turno" runat="server" OnClick="btnNuevoEmpleado_Click" />
                        </div>
                    </div>
                    <!--Inicio Tabla-->

                    <asp:Repeater ID="repeaterTurnos" runat="server">
                        <HeaderTemplate>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">NRO TURNO</th>
                                        <th scope="col">NRO AFILI</th>
                                        <th scope="col">MEDICO</th>
                                        <th scope="col">ESPECIALIDAD</th>
                                        <th scope="col">FECHA</th>
                                        <th scope="col">HORA</th>
                                        <th scope="col">Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Id") %></td>
                                <td><%# Eval("NumAfiliado") %></td>
                                <td><%# Eval("Medico") %></td>
                                <td><%# Eval("Especialidad") %></td>
                                <td><%# Eval("Fecha", "{0:dd/MM/yyyy}") %></td>
                                <td><%# string.Format("{0:hh\\:mm}", Eval("Hora")) %></td>
                                <td>
                                    <asp:Button ID="btnEditarTurno" class="btn btn-primary btn-sm" Text="Editar" runat="server"
                                        CommandArgument='<%# Eval("Id") %>' OnClick="btnEditarTurno_Click" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
    </table>
   
                        </FooterTemplate>
                    </asp:Repeater>


                    <!--Fin tabla-->


                </div>
            </div>
        </div>
    </div>

</asp:Content>

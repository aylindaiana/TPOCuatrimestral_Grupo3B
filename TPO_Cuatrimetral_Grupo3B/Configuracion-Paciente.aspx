<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Configuracion-Paciente.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Configuracion_Paciente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Configuracion paciente</h1>

    <div class="container">

        <div class="row justify-content-center" style="padding-top: 30px">
            <div class="container-fluid">
                <div class="row button-row mb-5 text-center">
                    <!-- Filtro por Legajo -->
                    <div class="col-4">
                        <div class="input-group mb-3">
                            <asp:TextBox ID="txtLegajoFiltro" CssClass="form-control" runat="server" Placeholder="Nro Afiliado"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button ID="btnBuscarNroAfiliado" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarAfiliado_Click" />
                            </div>
                        </div>
                    </div>

                    <!-- Filtro por DNI -->
                    <div class="col-4">
                        <div class="input-group mb-3">
                            <asp:TextBox ID="txtDniFiltro" CssClass="form-control" runat="server" Placeholder="DNI"></asp:TextBox>

                            <div class="input-group-append">
                                <asp:Button ID="btnBuscarDni" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarDni_Click" />
                            </div>
                        </div>
                    </div>

                    <!-- Filtro por Apellido -->
                    <div class="col-4">
                        <div class="input-group mb-3">
                            <asp:TextBox ID="txtApellidoFiltro" CssClass="form-control" runat="server" Placeholder="Apellido"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button ID="btnBuscarApellido" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarApellido_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <!--Boton de Alta Paciente-->
                <div class="button" style="margin-bottom: 20px;">
                    <asp:Button ID="btnNuevoPaciente" class="btn btn-primary btn-sm" Text="+ Nuevo Paciente" runat="server" OnClick="btnNuevoPaciente_Click" />
                </div>

                <!--Inicio Tabla-->

                <asp:Repeater ID="repeaterPacientes" runat="server">
                    <HeaderTemplate>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Nro Afiliado</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Apellido</th>
                                    <th scope="col">DNI</th>
                                    <th scope="col">Fecha Nacimiento</th>
                                    <th scope="col">Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Numero_afiliado") %></td>
                            <td><%# Eval("Nombre") %></td>
                            <td><%# Eval("Apellido") %></td>
                            <td><%# Eval("Dni") %></td>
                            <td><%# Eval("Fecha_Nac", "{0:dd/MM/yyyy}") %></td>
                            <td>
                                <asp:Button ID="btnEditarPaciente" class="btn btn-primary btn-sm" Text="Editar" runat="server"
                                    CommandArgument='<%# Eval("Numero_afiliado") %>' OnClick="btnEditarPaciente_Click" />
                                <asp:Button ID="btnBajaPaciente" class="btn btn-danger btn-sm" Text="Eliminar" runat="server"
                                    CommandArgument='<%# Eval("Numero_afiliado") %>' OnClick="btnBajaPaciente_Click" />
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

</asp:Content>

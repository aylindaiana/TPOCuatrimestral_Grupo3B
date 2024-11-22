<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Configuracion-Empleado.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Configuracion_Empleado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Configuracion Empleado</h1>

    <div class="container">

        <div class="row justify-content-center" style="padding-top: 30px">
            <div class="container-fluid">
                <div class="row button-row mb-5 text-center">
                    <!-- Filtro por Legajo -->
                    <div class="col-4">
                        <div class="input-group mb-3">
                            <asp:TextBox ID="txtLegajoFiltro" CssClass="form-control" runat="server" Placeholder="Legajo"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button ID="btnBuscarLegajo" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarLegajo_Click" />
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

                <!--Boton de Alta Empleado-->
                <div class="button" style="margin-bottom:20px;">
                    <asp:Button ID="btnNuevoEmpleado" class="btn btn-primary btn-sm" Text="+ Nuevo Empleado" runat="server" OnClick="btnNuevoEmpleado_Click" />
                </div>

                <!--Inicio Tabla-->

                <asp:Repeater ID="repeaterEmpleados" runat="server">
                    <HeaderTemplate>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Legajo</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Apellido</th>
                                    <th scope="col">DNI</th>
                                    <th scope="col">Fecha Nacimiento</th>
                                    <th scope="col">Cargo</th>
                                    <th scope="col">Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Legajo") %></td>
                            <td><%# Eval("Nombre") %></td>
                            <td><%# Eval("Apellido") %></td>
                            <td><%# Eval("Dni") %></td>
                            <td><%# Eval("Fecha_Nac", "{0:dd/MM/yyyy}") %></td>
                            <td><%# Eval("Nivel_Acceso") %></td>
                            <td>
                                <asp:Button ID="btnEditarEmpleado" class="btn btn-primary btn-sm" Text="Editar" runat="server"
                                    CommandArgument='<%# Eval("Legajo") %>' OnClick="btnEditarEmpleado_Click" />
                                <asp:Button ID="btnBajaEmpleado" class="btn btn-danger btn-sm" Text="Eliminar" runat="server"
                                    CommandArgument='<%# Eval("Legajo") %>' OnClick="btnBajaEmpleado_Click" />
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

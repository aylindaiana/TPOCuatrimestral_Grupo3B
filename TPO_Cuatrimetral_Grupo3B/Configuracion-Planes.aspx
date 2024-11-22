<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Configuracion-Planes.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Configuracion_Sanatorios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>PLANES</h1>

    <div class="container">

        <div class="row" style="padding-top: 30px">

            <!--Inicio Tabla-->
            <div class="col-9">
                <asp:Repeater ID="repeaterPlanes" runat="server">
                    <HeaderTemplate>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Id_Plan") %></td>
                            <td><%# Eval("Nombre_Plan") %></td>
                            <td>
                                <asp:Button ID="btnEditarPaciente" class="btn btn-primary btn-sm" Text="Editar" runat="server"
                                    CommandArgument='<%# Eval("Id_Plan") %>' OnClick="btnEditarPlan_Click" />
                                <asp:Button ID="btnBajaPaciente" class="btn btn-danger btn-sm" Text="Eliminar" runat="server"
                                    CommandArgument='<%# Eval("Id_Plan") %>' OnClick="btnBajaPlan_Click" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                    </table>
   
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <div class="col-3">
                <!--Boton de Alta Plan-->
                <div class="button" style="margin-bottom: 20px; margin-left: 20px">
                    <asp:Button ID="btnNuevoPlan" class="btn btn-primary btn-lg" Text="+ Agregar Plan" runat="server" OnClick="btnNuevoPlan_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>

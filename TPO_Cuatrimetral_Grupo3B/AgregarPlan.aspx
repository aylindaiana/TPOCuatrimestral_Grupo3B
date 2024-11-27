<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarPlan.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.AgregarPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <h2>Agregar Plan:</h2>
         <asp:Label ID="lblErrores" runat="server" CssClass="text-danger" Visible="false"></asp:Label>

        <!-- Información usuario -->

        <div class="row">
            <div class="col-10">

                <div class="form-row" style="margin-top: 40px;">
                    <div class="row">
                        <div class="form-group col-md-3">
                            <!--ID-->
                            <label>ID</label>
                            <asp:TextBox ID="txtIdPlan" CssClass="form-control" runat="server" Placeholder="ID"></asp:TextBox>
                        </div>

                        <div class="form-group col-md-4">
                            <!--Nombre-->
                            <label>Nombre Plan</label>
                            <asp:TextBox ID="txtNompre" CssClass="form-control" runat="server" Placeholder="Nombre"></asp:TextBox>
                        </div>
                        
                        <div class="form-group col-md-5">
                            <!--Sanatorios-->
                            <label>Sanatorios</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlSanatorios" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                <asp:Button ID="btnAgregarSanatorio" class="btn btn-primary flex-fill mb-3" runat="server" Text="Agregar" 
                                    OnClick="btnAgregarSanatorio_Click"/>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <!--Botones especiales-->
            <div class="col-2" style="margin-top: 40px;">
                <div class="d-flex flex-column">
                    <asp:Button ID="btnGuardar" class="btn btn-primary flex-fill mb-3" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnCacelar" class="btn btn-danger flex-fill mb-3" runat="server" Text="Cancelar" OnClick="btnCancelar_Click" />
                </div>
            </div>

            <h2 style="margin-bottom:20px">Sanatorios Asignados</h2>

            <asp:Repeater ID="repeaterSanatorios" runat="server">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Telefono</th>
                                <th scope="col">Email</th>
                                <th scope="col">Opciones</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("Id_Sanatorio") %></td>
                        <td><%# Eval("Nombre") %></td>
                        <td><%# Eval("Telefono") %></td>
                        <td><%# Eval("Email") %></td>
                        <td>
                            <asp:Button ID="btnEliminarSanatorio" runat="server" CommandArgument='<%# Container.ItemIndex %>'
                                CssClass="btn btn-danger" Text="Eliminar" OnClick="btnEliminarSanatorio_Click" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
        </table>
   
                </FooterTemplate>
            </asp:Repeater>


        </div>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ModificarUsuario.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Configuracion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <asp:Label ID="LblTitulo" CssClass="display-5" runat="server" Text=""></asp:Label>

        <!-- Información usuario -->

        <div class="row">
            <div class="col-9">

                <div class="form-row" style="margin-top: 40px;">
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label>Nombre</label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" Placeholder="Nombre"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-4">
                            <label>Apellido</label>
                            <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server" Placeholder="Apellido"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-4">
                            <asp:Label ID="lbl_legajo" runat="server" Text="Legajo"></asp:Label>
                            <asp:TextBox ID="txtLegajo" CssClass="form-control" runat="server" Placeholder="Legajo"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="form-group col-md-6">
                            <label>Numero de Documento</label>
                            <asp:TextBox ID="txtDni" CssClass="form-control" runat="server" Placeholder="DNI"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <label>Fecha de Nacimiento</label>
                            <asp:TextBox ID="txtFechaNacimiento" CssClass="form-control" runat="server" Placeholder="Fecha de Nacimiento"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="form-group col-md-5">
                            <label>Calle</label>
                            <asp:TextBox ID="txtCalle" CssClass="form-control" runat="server" Placeholder="Calle"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-2">
                            <label>Numero</label>
                            <asp:TextBox ID="txtNumero" CssClass="form-control" runat="server" Placeholder="Número"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-3">
                            <label>Localidad</label>
                            <asp:TextBox ID="txtLocalidad" CssClass="form-control" runat="server" Placeholder="Localidad"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-2">
                            <label>CP</label>
                            <asp:TextBox ID="txtCodigoPostal" CssClass="form-control" runat="server" Placeholder="Código Postal"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="form-group col-md-6">
                            <label>Telefono</label>
                            <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server" Placeholder="Telefono"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <label>Email</label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" Placeholder="Email"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>


            <!--Botones especiales-->
            <div class="col-3" style="margin-top: 40px;">
                <div class="d-flex flex-column">
                    <button class="btn btn-danger flex-fill mb-3">Dar de Baja</button>
                    <button class="btn btn-warning flex-fill mb-3">Restablecer Contraseña</button>
                    <button class="btn btn-primary flex-fill">Modificar</button>
                </div>
            </div>
        </div>


    </div>


</asp:Content>

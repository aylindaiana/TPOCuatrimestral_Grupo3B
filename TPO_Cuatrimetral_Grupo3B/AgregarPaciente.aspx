<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarPaciente.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.AgregarPaciente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <h2>Agregar Paciente:</h2>

        <asp:Label ID="lblErrores" runat="server" CssClass="text-danger" Visible="false"></asp:Label>


    <!-- Información usuario -->

    <div class="row">
        <div class="col-10">

            <div class="form-row" style="margin-top: 40px;">
                <div class="row">
                    <div class="form-group col-md-4">
                        <!--nombre-->
                        <label>Nombre</label>
                        <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" Placeholder="Nombre"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-4">
                        <!--apellido-->
                        <label>Apellido</label>
                        <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server" Placeholder="Apellido"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-4">
                        <!--afiliado-->
                        <label>Numero Afiliado</label>
                        <asp:TextBox ID="txtNroAfiliado" CssClass="form-control" runat="server" Placeholder="Numero Afiliado"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="row">
                    <div class="form-group col-md-6">
                        <!--dni-->
                        <label>Numero de Documento</label>
                        <asp:TextBox ID="txtDni" CssClass="form-control" runat="server" Placeholder="DNI" inputmode="numeric" pattern="[0-9]*"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-6">
                        <!--fecha nac-->
                        <label>Fecha de Nacimiento</label>
                        <asp:TextBox ID="txtFechaNacimiento" CssClass="form-control" runat="server" Placeholder="Fecha de Nacimiento" type="date"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="row">
                    <div class="form-group col-md-5">
                        <!--calle-->
                        <label>Calle</label>
                        <asp:TextBox ID="txtCalle" CssClass="form-control" runat="server" Placeholder="Calle"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-2">
                        <!--numero-->
                        <label>Numero</label>
                        <asp:TextBox ID="txtNumero" CssClass="form-control" runat="server" Placeholder="Número" inputmode="numeric" pattern="[0-9]*"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-3">
                        <!--localidad-->
                        <label>Localidad</label>
                        <asp:TextBox ID="txtLocalidad" CssClass="form-control" runat="server" Placeholder="Localidad"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-2">
                        <!--codigo postal-->
                        <label>CP</label>
                        <asp:TextBox ID="txtCodigoPostal" CssClass="form-control" runat="server" Placeholder="Código Postal"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="row">
                    <div class="form-group col-md-6">
                        <!--telefono-->
                        <label>Telefono</label>
                        <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server" Placeholder="Telefono" inputmode="numeric" pattern="[0-9]*"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-3">
                        <!--email-->
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" Placeholder="Email" TextMode="Email"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-3">
                        <!--plan -->
                        <label>Plan</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlPlanes" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                    </div>
                </div>
            </div>
        </div>


        <!--Botones especiales-->
        <div class="col-2" style="margin-top: 40px;">
            <div class="d-flex flex-column">
                <asp:Button ID="btnGuardar" class="btn btn-primary flex-fill mb-3" runat="server" Text="Guardar" OnClick="btnGuardar_Click"/>
                <asp:Button ID="btnCacelar" class="btn btn-danger flex-fill mb-3" runat="server" Text="Cancelar" OnClick="btnCacelar_Click" />
            </div>
        </div>
    </div>


</div>
</asp:Content>

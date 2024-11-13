<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MiPerfil.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.MiPerfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .info-box {
            background-color: #ffffff;
            border: 2px solid #a4c8e1;
            color: #a4c8e1;
        }

        button.btn-info {
            background-color: #a4c8e1;
            border-color: #d0e7f9;
            color: #ffffff;
        }

        button.btn-danger {
            background-color: #f08080;
            border-color: #f08080;
            color: #ffffff;
        }

        button.button-row .btn {
            background-color: #0a9396;
            color: white;
            font-size: 15px;
            padding: 10px;
        }

        .button-row .btn:hover {
            background-color: #94d2bd;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">


        <div class="row">
            <div class="col">
                <form>
                    <div class="form-row">
                        <div class="row">
                            <div class="form-group col-md-4">
                                <label>Nombre</label>
                                <!--Nombre-->
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombre"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-4">
                                <label>Apellido</label>
                                <!--Apellido-->
                                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Apellido"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-4">
                                <asp:Label ID="LblLegajo" runat="server" Text="Legajo"></asp:Label>
                                <!--Afiliado o Legajo-->
                                <asp:TextBox ID="txtLegajo" runat="server" CssClass="form-control" placeholder="Legajo"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="form-group">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label>Numero de Documento</label>
                                <!--DNI -->
                               <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" placeholder="DNI"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-6">
                                <label>Fecha de Nacimiento</label>
                                <!--Fecha de Nacimiento-->
                                 <asp:TextBox ID="txtFechaNac" runat="server" CssClass="form-control" TextMode="Date" placeholder="Fecha de nacimiento"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="form-group">
                        <div class="row">
                            <div class="form-group col-md-5">
                                <label>Calle</label>
                                <!--Calle -->
                                 <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control" placeholder="Calle"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-2">
                                <label>Numero</label>
                                <!--Numero-->
                                <asp:TextBox ID="txtNumero" runat="server" CssClass="form-control" placeholder="Numero"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-3">
                                <label>Localidad</label>
                                <!--Localidad-->
                                <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control" placeholder="Localidad"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-2">
                                <label>CP</label>
                                <!--Codigo Postal-->
                                <asp:TextBox ID="txtCodPostal" runat="server" CssClass="form-control" placeholder="Codigo postal"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="form-group">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label>Telefono</label>
                                <!--Telefono -->
                                 <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Telefono"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-6">
                                <label>Email</label>
                                <!--Email-->
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                </form>
            </div>

            <div class="col-md-2 d-flex flex-column align-items-end"">
                <button class="btn btn-success mb-2">Guardar</button>
                <button class="btn btn-secondary mb-2">Cancelar</button>
            </div>
        </div>

    </div>

</asp:Content>

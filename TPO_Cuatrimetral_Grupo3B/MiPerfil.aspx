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
                                <input type="text" class="form-control" placeholder="Nombre">
                            </div>
                            <div class="form-group col-md-4">
                                <label>Apellido</label>
                                <!--Apellido-->
                                <input type="text" class="form-control" placeholder="Apellido">
                            </div>
                            <div class="form-group col-md-4">
                                <label>Legajo</label>
                                <!--Afiliado o Legajo-->
                                <input type="text" class="form-control" placeholder="Legajo">
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="form-group">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label>Numero de Documento</label>
                                <!--DNI -->
                                <input type="text" class="form-control" placeholder="DNI">
                            </div>
                            <div class="form-group col-md-6">
                                <label>Fecha de Nacimiento</label>
                                <!--Fecha de Nacimiento-->
                                <input type="text" class="form-control" placeholder="Fecha de nacimiento">
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="form-group">
                        <div class="row">
                            <div class="form-group col-md-5">
                                <label>Calle</label>
                                <!--Calle -->
                                <input type="text" class="form-control" placeholder="Calle">
                            </div>
                            <div class="form-group col-md-2">
                                <label>Numero</label>
                                <!--Numero-->
                                <input type="text" class="form-control" placeholder="Numero">
                            </div>
                            <div class="form-group col-md-3">
                                <label>Localidad</label>
                                <!--Localidad-->
                                <input type="text" class="form-control" placeholder="Localidad">
                            </div>
                            <div class="form-group col-md-2">
                                <label>CP</label>
                                <!--Codigo Postal-->
                                <input type="text" class="form-control" placeholder="CP">
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="form-group">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label>Telefono</label>
                                <!--Telefono -->
                                <input type="text" class="form-control" placeholder="Telefono">
                            </div>
                            <div class="form-group col-md-6">
                                <label>Email</label>
                                <!--Email-->
                                <input type="text" class="form-control" placeholder="Email">
                            </div>
                        </div>
                    </div>

                </form>
            </div>

            <div class="col-md-2 d-flex flex-column align-items-end" style="background-color: white;">
                <button class="btn btn-success mb-2">Guardar</button>
                <button class="btn btn-secondary mb-2">Cancelar</button>
            </div>
        </div>

    </div>

</asp:Content>

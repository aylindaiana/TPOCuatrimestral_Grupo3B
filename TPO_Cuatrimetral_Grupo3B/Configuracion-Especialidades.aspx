<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Configuracion-Especialidades.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Configuracion_Especialidades" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="conteiner">

        <h1>Configuracion Especialidades</h1>

        <br/>
        <br/>

        <div class="form-group"">
            <div class="row">
                <div class="form-group col-5" >
                    <!--Lista de especialidades cargadas-->
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Especialidades Cargadas</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>

                        <% foreach (Dominio.Especialidades item in listaEspecialidades)
                            {  %>

                        <tr>
                            <td><%= item.Nombre%></td>
                            <td>
                                <asp:Button class="btn btn-danger btn-sm" Text="Eliminar" runat="server" />
                            </td>
                        </tr>

                        <%} %>
                    </tbody>
                </table>
                </div>

                <div class="col">
                    <label style="font-weight: bold" >Nueva especialidad</label>
                    <input type="text" class="form-control" style="margin-bottom:20px;"/>

                    <asp:Button ID="bntAgregar" CssClass="btn btn-primary" runat="server" Text="Agregar" OnClick="btnAgregar_Click" />
                </div>
            </div>
        </div>

    </div>

</asp:Content>

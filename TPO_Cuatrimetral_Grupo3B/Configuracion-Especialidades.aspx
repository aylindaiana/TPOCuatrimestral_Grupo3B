<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Configuracion-Especialidades.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Configuracion_Especialidades" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <h1>Configuración Especialidades</h1>

        <br/>
        <br/>

        <div class="form-group">
            <div class="row">
                <div class="form-group col-5">
                    <asp:UpdatePanel ID="updListaEspecialidades" runat="server">
                        <ContentTemplate>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Especialidades Cargadas</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                    <asp:Repeater ID="rptEspecialidades" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("Nombre") %></td>
                                                <td>
                                                    <asp:Button CssClass="btn btn-danger btn-sm" Text="Desactivar" CommandArgument='<%# Eval("Id") %>' OnClick="btnDesactivar_Click" runat="server" Visible='<%# (bool)Eval("Estado") %>' />
                
                                                    <asp:Button CssClass="btn btn-success btn-sm" Text="Reactivar" CommandArgument='<%# Eval("Id") %>' OnClick="btnReactivar_Click" runat="server" Visible='<%# !(bool)Eval("Estado") %>' />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>

                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col">
                    <label style="font-weight: bold">Nueva especialidad</label>
                        <ContentTemplate>

                            <input type="text" id="txtNuevaEspecialidad" class="form-control" style="margin-bottom:20px;" runat="server" />
                            <asp:Label ID="lblMensaje" CssClass="text-danger" runat="server"></asp:Label>
                            <asp:Button ID="btnAgregar" CssClass="btn btn-primary" runat="server" Text="Agregar" OnClick="btnAgregar_Click" />

                        </ContentTemplate>
                   
                </div>
            </div>
        </div>
    </div>
</asp:Content>

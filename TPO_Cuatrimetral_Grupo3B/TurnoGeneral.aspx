<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TurnoGeneral.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.TurnoGeneral" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <div>
            <h1>Gestión de Turnos</h1>


            <asp:TextBox ID="txtBuscar" runat="server" CssClass="search-box" placeholder="Buscar turno..." />
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" CssClass="search-button" />

            <asp:GridView ID="gvTurnos" runat="server" AutoGenerateColumns="False" CssClass="grid-view" OnRowCommand="gvTurnos_RowCommand">
                <Columns>

                    <asp:BoundField DataField="Id" HeaderText="ID Turno" />
                    <asp:BoundField DataField="NumAfiliado" HeaderText="Paciente" />
                    <asp:BoundField DataField="Id_Sanatorio" HeaderText="Sanatorio" />
                    <asp:BoundField DataField="Especialidad" HeaderText="Especialidad" />
                    <asp:BoundField DataField="Medico" HeaderText="Médico" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Hora" HeaderText="Hora" DataFormatString="{0:HH:mm}" />

                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlEstado" runat="server">
                                <asp:ListItem Text="Pendiente" Value="pendiente" />
                                <asp:ListItem Text="Confirmado" Value="confirmado" />
                                <asp:ListItem Text="Cancelado" Value="cancelado" />
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar" CommandArgument='<%# Eval("Id") %>' CssClass="delete-button" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
</asp:Content>

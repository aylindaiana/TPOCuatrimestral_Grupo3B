<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditarTurnos.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.EditarTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <asp:Label ID="lblTitulo" runat="server" Text=""></asp:Label>

        <!-- Información usuario -->

        <div class="row">
            <div class="col-10">

                <div class="form-row" style="margin-top: 40px;">
                    <div class="row">
                        <div class="form-group col-md-4">
                            <!--Afiliado-->
                            <label>Numero Afiliado</label>
                            <asp:TextBox ID="txtAfiliado" CssClass="form-control" runat="server" Placeholder="Afiliado"
                                AutoPostBack="true" OnTextChanged="txtAfiliado_TextChanged"></asp:TextBox>
                        </div>
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
                    </div>
                </div>


                <div class="form-group">
                    <div class="row" style="margin-top: 20px;">

                        <div class="form-group col-md-3">
                            <!--Sanatorio-->
                            <label>Sanatorio</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlSanatorio" runat="server" CssClass="form-select"
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlSanatorio_SelectedIndexChanged">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group col-md-3">
                            <!--Especialidad-->
                            <label>Especialidad</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select"
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlEspecialidad_SelectedIndexChanged">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group col-md-3">
                            <!--Medicos-->
                            <label>Medicos</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlMedicos" runat="server" CssClass="form-select"
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlMedicos_SelectedIndexChanged">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group col-md-2">
                            <!--dias disponibles-->
                            <label>Dias</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlDias" runat="server" CssClass="form-select"
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlDias_SelectedIndexChanged">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group col-md-2">
                            <!--Fechas disponibles-->
                            <label>Fechas</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlFechas" runat="server" CssClass="form-select"
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlFechas_SelectedIndexChanged">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True" TextMode="Time"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group col-md-2">
                            <!--Horarios disponibles-->
                            <label>Horarios</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlHorarios" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True" TextMode="Time"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <!--Motivo de Turno-->

                        <div class="input-group">
                            <span class="input-group-text">Motivo</span>
                            <asp:TextBox ID="txtMotivo" class="form-control" aria-label="Motivo" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </div>

                        <!--Observaciones-->

                        <div class="input-group">
                            <span class="input-group-text">Observaciones</span>
                            <asp:TextBox ID="txtObservaciones" class="form-control" aria-label="Observaciones" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </div>

                    </div>
                </div>
            </div>


            <!--Botones especiales-->
            <div class="col-2" style="margin-top: 40px;">
                <div class="d-flex flex-column">
                    <asp:Button ID="btnGuardar" class="btn btn-primary flex-fill mb-3" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnCacelar" class="btn btn-danger flex-fill mb-3" runat="server" Text="Volver" OnClick="btnCacelar_Click" />
                </div>
            </div>
        </div>


    </div>

</asp:Content>

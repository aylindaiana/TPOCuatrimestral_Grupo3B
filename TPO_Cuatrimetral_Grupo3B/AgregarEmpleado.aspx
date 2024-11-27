<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarEmpleado.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.AgregarEmpleado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <h2>Agregar Empleado:</h2>

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
                            <!--Legajo-->
                            <label>Legajo</label>
                            <asp:TextBox ID="txtLegajo" CssClass="form-control" runat="server" Placeholder="Legajo"></asp:TextBox>
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
                            <!--Nivel acceso -->
                            <label>Puesto de Trabajo</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlPuestoTrabajo" runat="server" CssClass="form-select" 
                                                  AutoPostBack="True" OnSelectedIndexChanged="ddlPuestoTrabajo_SelectedIndexChanged">
                                    <asp:ListItem Text="RECEPCIONISTA" Value="2" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="MEDICO" Value="3" Selected="False"></asp:ListItem>
                                    <asp:ListItem Text="ADMIN" Value="4" Selected="False"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>

                <%if (int.Parse(ddlPuestoTrabajo.SelectedValue) == 3)
                    { %>
                <div class="form-group">
                    <h2>Horarios</h2>
                    <div class="row" style="margin-top: 30px;">

                        <div class="form-group col-md-3">
                            <!--Dias de la Semana-->
                            <label>Día de la semana</label>
                            <div class="dropdown w-100">
                                <button class="btn btn-secondary dropdown-toggle w-100" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                    Seleccione días
                                </button>
                                <div class="dropdown-menu w-100" aria-labelledby="dropdownMenuButton" style="padding: 10px">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="lunes" name="dias" value="Lunes" runat="server">
                                        <label class="form-check-label" for="lunes">Lunes</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="martes" name="dias" value="Martes" runat="server">
                                        <label class="form-check-label" for="martes">Martes</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="miercoles" name="dias" value="Miércoles" runat="server">
                                        <label class="form-check-label" for="miercoles">Miércoles</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="jueves" name="dias" value="Jueves" runat="server">
                                        <label class="form-check-label" for="jueves">Jueves</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="viernes" name="dias" value="Viernes" runat="server">
                                        <label class="form-check-label" for="viernes">Viernes</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="sabado" name="dias" value="Sabado" runat="server">
                                        <label class="form-check-label" for="sabado">Sabado</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="domingo" name="dias" value="Domingo" runat="server">
                                        <label class="form-check-label" for="domingo">Domingo</label>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <asp:HiddenField ID="hiddenSeleccionados" runat="server" />

                        <div class="form-group col-md-3">
                            <!--Especialidad-->
                            <label>Especialidad</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group col-md-2">
                            <!--Hora Inicio -->
                            <label>Hora Inicio</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlHoraInicio" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True" TextMode="Time"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group col-md-2">
                            <!--Hora Finalizacion-->
                            <label>Hora Finalizacion</label>
                            <div class="mb-3">
                                <asp:DropDownList ID="ddlHoraFinlizacion" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Seleccione una opción" Value="0" Selected="True" TextMode="Time"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group col-md-2">
                            <!--Agregar horario-->
                            <div class="mb-3" style="margin-top: 30px">
                                <asp:Button ID="btnGuardarHorarios" runat="server" CssClass="btn btn-primary" OnClientClick="obtenerSeleccionados();"
                                    OnClick="btnGuardarHorarios_Click" Text="Agregar" />
                            </div>
                        </div>

                    </div>
                </div>
                <%}%>
            </div>


            <!--Botones especiales-->
            <div class="col-2" style="margin-top: 40px;">
                <div class="d-flex flex-column">
                    <asp:Button ID="btnGuardar" class="btn btn-primary flex-fill mb-3" runat="server" Text="Guardar" OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnCacelar" class="btn btn-danger flex-fill mb-3" runat="server" Text="Volver" OnClick="btnCacelar_Click" />
                </div>
            </div>
        </div>

        <!--Horarios Cargados-->
        <%if(int.Parse(ddlPuestoTrabajo.SelectedValue) == 3) { %>
        <asp:Repeater ID="repeaterHorarios" runat="server">
            <HeaderTemplate>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Dia</th>
                            <th scope="col">Especialidad</th>
                            <th scope="col">Hora Inicio</th>
                            <th scope="col">Hora Fin</th>
                            <th scope="col">Opciones</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Dia") %></td>
                    <td><%# Eval("Especialidad.Nombre") %></td>
                    <td><%# ((TimeSpan)Eval("HoraInicio")).ToString(@"hh\:mm") %></td>
                    <td><%# ((TimeSpan)Eval("HoraFin")).ToString(@"hh\:mm") %></td>
                    <td>
                        <asp:Button ID="btnEliminarHor" runat="server" CommandArgument='<%# Container.ItemIndex %>'
                            CssClass="btn btn-danger" Text="Eliminar" OnClick="btnEliminarHor_Click" />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
        </table>
   
            </FooterTemplate>
        </asp:Repeater>
        <%}%>


        <!--------------------->

    </div>




</asp:Content>

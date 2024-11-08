<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Configuracion.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Configuracion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <h1>Configuraciones</h1>

        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#Usuarios" type="button" role="tab" aria-controls="Usuarios" aria-selected="true">Usuarios</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#Especialidades" type="button" role="tab" aria-controls="Especialidades" aria-selected="false">Especialidades</button>
            </li>
        </ul>

             <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="Usuarios" role="tabpanel" aria-labelledby="home-tab">
                    <!-- Configuración de Usuarios -->

                <div class="row justify-content-center" style="padding-top: 30px">
                    <div class="container-fluid">
                        <div class="row button-row mb-5 text-center">
                            <!-- Filtro por Legajo -->
                            <div class="col-4">
                                <div class="input-group mb-3">
                                    <asp:TextBox ID="txtLegajoFiltro" CssClass="form-control" runat="server" Placeholder="Legajo"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:Button ID="btnBuscarLegajo" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarLegajo_Click" />
                                    </div>
                                </div>
                            </div>
            
                            <!-- Filtro por DNI -->
                            <div class="col-4">
                                <div class="input-group mb-3">
                                    <asp:TextBox ID="txtDniFiltro" CssClass="form-control" runat="server" Placeholder="DNI"></asp:TextBox>

                                    <div class="input-group-append">
                                        <asp:Button ID="btnBuscarDni" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarDni_Click" />
                                    </div>
                                </div>
                            </div>
            
                            <!-- Filtro por Apellido -->
                            <div class="col-4">
                                <div class="input-group mb-3">
                                    <asp:TextBox ID="txtApellidoFiltro" CssClass="form-control" runat="server" Placeholder="Apellido"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:Button ID="btnBuscarApellido" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarApellido_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>


                        </div>
                    </div>

                    <!-- Información usuario -->
                    
                        <div class="form-row">
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
                                    <!--Alinear texto-->
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
                    </form>

                    <br />
                    <br />
                    <div class="form-group">
                        <div class="row">
                            <!-- Especialidades Asignadas -->
                            <div class="form-group col-5">
                                <label>Especialidades Asignadas</label>
                                <asp:ListBox ID="lstEspecialidadesAsignadas" runat="server" CssClass="form-control" SelectionMode="Multiple" Size="6">
                                    <asp:ListItem Text="Especialidad 1" Value="1" />
                                    <asp:ListItem Text="Especialidad 2" Value="2" />
                                    <asp:ListItem Text="Especialidad 3" Value="3" />
                                </asp:ListBox>
                            </div>

                            <!-- Botones para mover entre las listas -->
                            <div class="form-group col-1 d-flex flex-column justify-content-center">
                                <div class="row mb-3">
                                    <asp:Button ID="btnMoverIzquierda" runat="server" Text="<-" CssClass="btn btn-primary" />
                                </div>
                                <div class="row">
                                    <asp:Button ID="btnMoverDerecha" runat="server" Text="->" CssClass="btn btn-primary"  />
                                </div>
                            </div>

                            <!-- Especialidades Disponibles -->
                            <div class="form-group col-5">
                                <label>Especialidades Disponibles</label>
                                <asp:ListBox ID="lstEspecialidadesDisponibles" runat="server" CssClass="form-control" SelectionMode="Multiple" Size="6">
                                    <asp:ListItem Text="Especialidad 4" Value="4" />
                                    <asp:ListItem Text="Especialidad 5" Value="5" />
                                    <asp:ListItem Text="Especialidad 6" Value="6" />
                                </asp:ListBox>
                            </div>
                        </div>
                    </div>
                    <br />
                    <br />

                    <div class="form-group"">
                        <div class="row">
                            <div class="form-group col-5" >
                                <label>Turnos Asignadas</label>
                                <ul class="list-group">
                                    <li class="list-group-item list-group-item-action">Turno Mañana</li>
                                </ul>
                            </div>

                            <div class="form-group col-1 d-flex flex-column justify-content-center">
                                <div class="row mb-3">
                                    <button type="button" class="btn btn-primary"><-</button>
                                </div>
                                <div class="row">
                                    <button type="button" class="btn btn-primary">-></button>
                                </div>
                            </div>

                            <div class="form-group col-5" >
                                <label>Turnos Disponibles</label>
                                <ul class="list-group">
                                    <li class="list-group-item list-group-item-action">Turno Mañana</li>
                                    <li class="list-group-item list-group-item-action">Turno Tarde</li>
                                    <li class="list-group-item list-group-item-action">Turno Noche</li>
                                    <li class="list-group-item list-group-item-action">Turno Guardia</li>
                                </ul>
                            </div>

                        </div>
                    </div>

                    <br />
                    <br />
                    <br />

                    <!--Botones especiales-->
                    <div class="form-group">
                        <div class="row justify-content-center">
                            <div class="form-group col-3 d-flex flex-column justify-content-center">
                                <button type="button" class="btn btn-danger">Dar de baja</button>
                            </div>
                            <div class="form-group col-3 d-flex flex-column justify-content-center">
                                <button type="button" class="btn btn-warning">Restablecer contraseña</button>
                            </div>
                            <div class="form-group col-3 d-flex flex-column justify-content-center">
                                <button type="button" class="btn btn-primary">Modificar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    

           <!--Configuracion de Especialidades-->
            <div class="tab-pane fade" id="Especialidades" role="tabpanel" aria-labelledby="profile-tab">       
                
                <br />
                <br />

                <div class="form-group"">
                    <div class="row">
                        <div class="form-group col-5" >
                            <label>Especialidades cargadas</label>
                            <!--Lista de especialidades cargadas-->
                            <ul class="list-group">
                                <asp:ListBox ID="lsbxEspecialidades" class="list-group-item list-group-item" runat="server"></asp:ListBox>
                            </ul>
                        </div>

                        <div class="col">
                            <label>Nueva especialidad</label>
                            <input type="text" class="form-control"/>
                                  
                            <button type="button" class="btn btn-primary mt-3">Agregar</button>
                        </div>
                    </div>
                </div>
                
            </div>
        
    </div>
    
    </asp:Content>
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
                <!--Configuracion de Usuarios-->

            <!-- Filtros -->
            <div class="row justify-content-center" style="padding-top: 30px">
                <div class="container-fluid">
                    <div class="row button-row mb-5 text-center">
                
                        <!-- Filtro por Legajo -->
                        <div class="col-4">
                            <div class="input-group mb-3">
                                <asp:TextBox ID="txtLegajo" CssClass="form-control" runat="server" Placeholder="Legajo"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="btnBuscarLegajo" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarLegajo_Click" />
                                </div>
                            </div>
                        </div>
                
                        <!-- Filtro por DNI -->
                        <div class="col-4">
                            <div class="input-group mb-3">
                                <asp:TextBox ID="txtDni" CssClass="form-control" runat="server" Placeholder="DNI"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="btnBuscarDni" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarDni_Click" />
                                </div>
                            </div>
                        </div>
                
                        <!-- Filtro por Apellido -->
                        <div class="col-4">
                            <div class="input-group mb-3">
                                <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server" Placeholder="Apellido"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="btnBuscarApellido" CssClass="btn btn-outline-secondary" runat="server" Text="Buscar" OnClick="btnBuscarApellido_Click" />
                                </div>
                            </div>
                        </div>
              
                    </div>
                </div>
            </div>
                <!--Informacion usuario-->

                <form>
                    <div class="form-row">
                        <div class="row">
                            <div class="form-group col-md-4">
                                <label>Nombre</label>
                                <!--Nombre-->
                                <input type="text" class="form-control">
                            </div>
                            <div class="form-group col-md-4">
                                <label>Apellido</label>
                                <!--Apellido-->
                                <input type="text" class="form-control">
                            </div>
                            <div class="form-group col-md-4">
                                <label>Legajo</label>
                                <!--Afiliado o Legajo-->
                                <input type="text" class="form-control">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label>Numero de Documento</label>
                                <!--DNI--> 
                                <input type="text" class="form-control">
                            </div>
                            <div class="form-group col-md-6">
                                <label>Fecha de Nacimiento</label>
                                <!--Fecha de Nacimiento-->
                                <input type="text" class="form-control">
                            </div>
                        </div>
                    </div>

                    
                    <div class="form-group">
                        <div class="row">
                            <div class="form-group col-md-5">
                                <label>Calle</label>
                                <!--Calle--> 
                                <input type="text" class="form-control">
                            </div>
                            <div class="form-group col-md-2">
                                <label>Numero</label>
                                <!--Numero-->
                                <input type="text" class="form-control">
                            </div>
                            <div class="form-group col-md-3">
                                <label>Localidad</label>
                                <!--Localidad-->
                                <input type="text" class="form-control">
                            </div>
                            <div class="form-group col-md-2">
                                <label>CP</label>
                                <!--Codigo Postal-->
                                <input type="text" class="form-control">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label>Telefono</label>
                                <!--Telefono--> 
                                <input type="text" class="form-control">
                            </div>
                            <div class="form-group col-md-6">
                                <label>Email</label>
                                <!--Email-->
                                <input type="text" class="form-control">
                            </div>
                        </div>
                    </div>

                    <br />
                    <br />
                    <!--Limitar visibilidad por tipo de usuario cargado-->
                    <div class="form-group"">
                        <div class="row">
                            <div class="form-group col-5" >
                                <label>Especialidades Asignadas</label>
                                <ul class="list-group">
                                    <li class="list-group-item list-group-item-action">Especialidad 1</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 2</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 3</li>
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
                                <label>Especialidades Disponibles</label>
                                <ul class="list-group">
                                    <li class="list-group-item list-group-item-action">Especialidad 1</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 2</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 3</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 4</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 5</li>
                                </ul>
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
                        </div>
                    </div>


                </form>
            </div>

             <!--Configuracion de Especialidades-->
                <div class="tab-pane fade" id="Especialidades" role="tabpanel" aria-labelledby="profile-tab">       
                
                    <br />
                    <br />

                    <div class="form-group"">
                        <div class="row">
                            <div class="form-group col-5" >
                                <label>Especialidades cargadas</label>
                                <ul class="list-group">
                                    <li class="list-group-item list-group-item-action">Especialidad 1</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 2</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 3</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 4</li>
                                    <li class="list-group-item list-group-item-action">Especialidad 5</li>
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
        </div>
    </asp:Content>
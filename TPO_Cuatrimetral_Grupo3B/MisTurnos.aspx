﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisTurnos.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.MisTurnos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

 <style>
     body {
      
      background-image: url('https://img.freepik.com/vector-gratis/mynt-done_53876-119946.jpg?t=st=1730160926~exp=1730164526~hmac=8eba43850caf1a44b54a42cf32a1feceb1d4c0627a964c09f5234f1c25e0d7b4&w=360');
      background-position: center;
     }
    .side-menu {
      background-color: #005f73; 
      height: 100%;
    }
    .side-menu ul {
      list-style-type: none;
      padding-left: 0;
    }
    .side-menu li {
      margin: 10px 0;
      text-align: center;
    }
    .side-menu .btn {
      background-color: #0a9396; 
      color: white;
      border-radius: 10px;
      width: 40px;
      height: 40px;
      font-size: 1.2em;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .content-area {
      background-color: white;
      padding: 20px;
      border: 1px solid #ced4da;
      border-radius: 10px;
      height: 200px;
      text-align: center;
      box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }
    .button-row .btn {
      background-color: #0a9396; 
      color: white;
      border-radius: 20px;
      font-size: 25px;
      padding: 10px;
    }
    .button-row .btn:hover {
      background-color: #94d2bd; 
    }
    .col-4 {
      margin-bottom: 20px; /* los botones de filtar*/
    }

    .gvTurnos{
        height: 400px; /* Puedes ajustar este valor a la altura que prefieras */
    overflow-y: scroll; 
    }

  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     
  <div class="container-fluid">
    <div class="row button-row mb-3 text-center">
      <div class="col-4">
        <asp:Button ID="btnSuperior1" runat="server" CssClass="btn w-100" Text="Filtrar por turno" OnClick="ContenidoFiltros" CommandArgument="Superior 1" />
      </div>
      <div class="col-4">
        <asp:Button ID="btnSuperior2" runat="server" CssClass="btn w-100" Text="Buscar por Estado" OnClick="ContenidoFiltros" CommandArgument="Superior 2" />
      </div>
      <div class="col-4">
        <asp:Button ID="btnSuperior3" runat="server" CssClass="btn w-100" Text="Buscar por Especialidad" OnClick="ContenidoFiltros" CommandArgument="Superior 3" />
      </div>
      <div class="col-4">
        <asp:Button ID="btnSuperior4" runat="server" CssClass="btn w-100" Text="Buscar por Paciente" OnClick="ContenidoFiltros" CommandArgument="Superior 4" />
      </div>
      <div class="col-4">
        <asp:Button ID="btnSuperior5" runat="server" CssClass="btn w-100" Text="Buscar por Médico" OnClick="ContenidoFiltros" CommandArgument="Superior 5" />
      </div>
    </div>
  </div>

  <div class="container-fluid">
    <div class="row">
      <div class="col-1 side-menu">
        <ul>
          <li><asp:Button ID="btnTurno1" runat="server" CssClass="btn" Text="1" OnClick="ContenidoTurnos" CommandArgument="Turno 1" /></li>
          <li><asp:Button ID="btnTurno2" runat="server" CssClass="btn" Text="2" OnClick="ContenidoTurnos" CommandArgument="Turno 2" /></li>
          <li><asp:Button ID="btnTurno3" runat="server" CssClass="btn" Text="3" OnClick="ContenidoTurnos" CommandArgument="Turno 3" /></li>
          <li><asp:Button ID="btnTurno4" runat="server" CssClass="btn" Text="4" OnClick="ContenidoTurnos" CommandArgument="Turno 4" /></li>
        </ul>
      </div>

 
      <div class="col-11">
                <div class="content-area">
                    <asp:Label ID="tituloContenido" runat="server" CssClass="h5">Turnos</asp:Label>
                    <asp:GridView ID="gvTurnos" runat="server" AutoGenerateColumns="False" OnRowCommand="gvTurnos_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="TurnoId" HeaderText="ID" />
                            <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
                            <asp:BoundField DataField="Especialidad" HeaderText="Especialidad" />
                            <asp:ButtonField ButtonType="Button" CommandName="VerDetalle" Text="Ver Detalle" />
                        </Columns>
                    </asp:GridView>
                    <asp:Label ID="contenido" runat="server">Estos son todos tus turnos!</asp:Label>
                </div>
            <div>
        </div>
    </div>

</asp:Content>

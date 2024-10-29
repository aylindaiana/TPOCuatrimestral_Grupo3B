<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisTurnos.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.MisTurnos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

 <style>
     body {
      background-color: #e0f7fa; 
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
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     
  <div class="container-fluid">
    <div class="row button-row mb-3 text-center">
      <div class="col-2">
        <asp:Button ID="btnSuperior1" runat="server" CssClass="btn w-100" Text="1" OnClick="ContenidoFiltros" CommandArgument="Superior 1" />
      </div>
      <div class="col-2">
        <asp:Button ID="btnSuperior2" runat="server" CssClass="btn w-100" Text="2" OnClick="ContenidoFiltros" CommandArgument="Superior 2" />
      </div>
      <div class="col-2">
        <asp:Button ID="btnSuperior3" runat="server" CssClass="btn w-100" Text="3" OnClick="ContenidoFiltros" CommandArgument="Superior 3" />
      </div>
      <div class="col-2">
        <asp:Button ID="btnSuperior4" runat="server" CssClass="btn w-100" Text="4" OnClick="ContenidoFiltros" CommandArgument="Superior 4" />
      </div>
      <div class="col-2">
        <asp:Button ID="btnSuperior5" runat="server" CssClass="btn w-100" Text="5" OnClick="ContenidoFiltros" CommandArgument="Superior 5" />
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
        
        <asp:Label ID="contenido" runat="server">Estos son todos tus turnos!</asp:Label>
        </div>
      </div>
    </div>
  </div>

</asp:Content>

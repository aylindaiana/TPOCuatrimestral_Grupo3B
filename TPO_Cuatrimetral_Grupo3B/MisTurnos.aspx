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
        <button class="btn w-100">1</button>
      </div>
      <div class="col-2">
        <button class="btn w-100">2</button>
      </div>
      <div class="col-2">
        <button class="btn w-100">3</button>
      </div>
       <div class="col-2">
        <button class="btn w-100">4</button>
       </div>
       <div class="col-2">
        <button class="btn w-100">5</button>
       </div>
    </div>
  </div>


  <div class="container-fluid">
    <div class="row">

      <div class="col-1 side-menu">
        <ul>
          <li><button class="btn" onclick="cambiarContenido('Turno 1')">1</button></li>
          <li><button class="btn" onclick="cambiarContenido('Turno 2')">2</button></li>
          <li><button class="btn" onclick="cambiarContenido('Turno 3')">3</button></li>
          <li><button class="btn" onclick="cambiarContenido('Turno 4')">4</button></li>
        </ul>
      </div>

      <div class="col-11">
        <div class="content-area">
          <h5 id="titulo-contenido">Turnos</h5>
          <p id="contenido">Estos son todos tus turnos!</p>
        </div>
      </div>
    </div>
  </div>

</asp:Content>

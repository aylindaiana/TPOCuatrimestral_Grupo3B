<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    .info-plan, .act-reciente, .nuevo-turno {
      border: 1px solid #ced4da;
      padding: 50px;
      text-align: center;
      height: 150px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container">
    <div class="main-content">
      <div class="info-plan">
        <p>Plan actual de contribuyente</p>
      </div>
      <div class="act-reciente">
        <p>Actividades Recientes</p>
        <div>
          <button class="btn btn-primary m-1">PERFIL</button>
          <button class="btn btn-primary m-1">FOTO</button>
        </div>
      </div>
      <div class="nuevo-turno">
        <button class="btn btn-success">+ Nuevo Turno</button>
      </div>
    </div>
  </div>


</asp:Content>

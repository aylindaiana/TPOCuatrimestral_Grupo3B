<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisTurnos.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.MisTurnos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

 <style>

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
    .btn-nuevo {
        background-color: #00b4d8; 
        color: white;
        border-radius: 50%;
        width: 85px;
        height: 60px;
        font-size: 0.80em;
        position: absolute;
        right: 20px;
        bottom: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        transition: background-color 0.3s;
    }
    .btn-nuevo:hover {
        background-color: #0096c7; 
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

                    <asp:Button ID="btnNuevo" runat="server" CssClass="btn-nuevo" Text="Nuevo Turno" OnClick="NuevoTurno_Click" />

                </div>
            <div>
        </div>
    </div>

</asp:Content>

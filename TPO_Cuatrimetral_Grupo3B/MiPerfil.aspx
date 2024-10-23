<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MiPerfil.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.MiPerfil" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .info-box {
          background-color:  #ffffff;
          border: 2px solid #a4c8e1;
          color:#a4c8e1;
        }

        .btn-info {
          background-color: #a4c8e1;
          border-color: #d0e7f9;
          color: #ffffff;
        }

        .btn-danger {
          background-color: #f08080;
          border-color: #f08080;
          color: #ffffff;
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
     <div class="container mt-5">
        <div class="row justify-content-center">
          <div class="container-fluid">
            <div class="row button-row mb-3 text-center">
              <div class="col-4">
                <button class="btn w-100">Búsqueda por Legajo</button>
              </div>
             <div class="col-4">
                 <button class="btn w-100">Búsqueda por DNI</button>
             </div>
            <div class="col-4">
              <button class="btn w-100">Búsqueda por Apellido</button>
            </div>

         </div>
      </div>
      <div class="col-10">
        <div class="row">
          <div class="col-md-8 mb-4">
            <textarea class="form-control info-box" rows="8" placeholder="Mucha Informacion"></textarea>
          </div>

          <div class="col-md-4 d-flex flex-column align-items-end">
            <button class="btn btn-success mb-2">Guardar</button>
            <button class="btn btn-info mb-2">Agregar Especialidad</button>
             <button class="btn btn-secondary mb-2">Cancelar</button>
            <button class="btn btn-danger">Dar Baja</button>
          </div>
        </div>
      </div>

      <div class="col-12 text-center mt-4">
        <p>Otras Opciones: </p>
        <div class="btn-group">
          <button class="btn btn-outline-primary">Opcion 1</button>
          <button class="btn btn-outline-primary">Opcion 2</button>
          <button class="btn btn-outline-primary">Opcion 3</button>
        </div>
      </div>
    </div>
    </div>

</asp:Content>

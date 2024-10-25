<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

        .main-content{
            text-align: center;
            display: flex;
            align-items: center;
            justify-content:flex-start; 
        }

        .contenedor{
            border: 1px solid #ced4da;
            padding: 50px;
            text-align: center;
            display: flex;  /* habilita la distribucion dinamica dentro del contenedor (horizontal o vertical)*/
            border-radius:30px;
        }

        .contenedor.resumen 
        {
            height: 250px;  /* Altura del contenedor*/
            width: 70vw;
            align-items: center;
            justify-content:flex-start; 
            background-color:honeydew;
        }

        .configuracion 
        {
            margin:20px;
        }

        .info-plan {
            height:15vw;
            width:30vw;
        }

        .ultima-actividad 
        {
            margin-left:10px;
            padding:10px;
        }

        .resumen-turnos 
        {
            padding: 50px;
            display: flex;  
            align-items: center;
            justify-content:flex-start; 
            margin-top:30px;
            height:50px;
            width:100%;
        }

        .btn-custom-turnos 
        {
            margin:10px;
            width:120px;
            height:100px;
        }

        .btn-atajos
        {
            margin:10px;
            width:140px;
            height:60px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container">
        <h1>Plan Actual del contribuyente:</h1>
        <div class="main-content">      <!-- clase al pedo -->
            <div class="contenedor resumen">
                
                <div style="background-color:lightblue" class="contenedor info-plan">
                    <h2> Detalles plan Actual</h2>
                </div>
                
                <div class="info-plan ultima-actividad">
                    <h2>Historial de Turnos</h2>
                    <div class="resumen-turnos"> 
                        <button type="button" class="btn btn-outline-primary btn-custom-turnos">Pendientes</button>
                        <button type="button" class="btn btn-outline-success btn-custom-turnos">Asistidos</button>
                    </div>
                </div>

            </div>

            <div class="contenedor resumen configuracion">
                <div>
                    <button style="border-radius:30px" type="button" class="btn btn-outline-danger btn-atajos">Nuevo turno</button>
                    <button style="border-radius:30px" type="button" class="btn btn-outline-primary btn-atajos">Configuracion</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

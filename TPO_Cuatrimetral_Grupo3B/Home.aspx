<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Catamaran:wght@400;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            background-image: url('https://img.freepik.com/vector-gratis/mynt-done_53876-119946.jpg?t=st=1730160926~exp=1730164526~hmac=8eba43850caf1a44b54a42cf32a1feceb1d4c0627a964c09f5234f1c25e0d7b4&w=360');
            background-position: center;
        }
        .main-content {
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            max-width: 100%;
            width: 100%;
            height: auto;
            padding: 2%;
        }
        .pantalla-resumen {
            border: 1px solid #ced4da;
            background-color: #ecfcff;
            max-width: 80%;
            width: 70%;
            height: auto;
            margin: 30px;
            padding: 30px;
            border-radius: 30px;
        }
        .pantalla-opcciones {
            border: 1px solid #ced4da;
            background-color: #ecfcff;
            max-width: 20%;
            width: 20%;
            height: auto;
            margin: 10px;
            padding: 30px;
            border-radius: 30px;
        }
        #texto-info {
            min-width: 100px;
            min-height: 100px;
        }
        .btn-custom-turnos {
            margin: 10px;
            width: 120px;
            height: 100px;
        }
        a.btn-atajos {
            margin: 10px 10px;
            max-width: 100%;
            max-height: auto;
            width: 200px;
            height: 60px;
            border-radius: 30px;
            align-items: center;
        }
        h1, p {
            text-align: center;
            font-family: 'Catamaran', sans-serif;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-content">
        <div class="pantalla-resumen">      
            <div class="row">
                <div class="col" style="background-color:lightblue; border-radius:30px;">
                    <h1>Detalle plan Actual</h1>
                    <p id="texto-info">
                        <!--Modificar dependiendo quien esta logueado-->
                    </p>
                </div>
            </div>
        </div>
        <div class="pantalla-opcciones">
            <div class="row justify-content-center">
                <a href="AgregarTurno.aspx" class="btn btn-outline-danger btn-atajos">Nuevo turno</a>
                <a href="Configuracion.aspx" class="btn btn-outline-primary btn-atajos">Configuración</a>
            </div>
        </div>
    </div>
</asp:Content>

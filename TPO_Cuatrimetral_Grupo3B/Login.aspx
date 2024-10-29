<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPO_Cuatrimetral_Grupo3B.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <!-- link de Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

     <style>
    body{
      height: 100%;
      margin: 0;
      font-family: Arial, sans-serif;
    }
    .background {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: url('https://www.hospitalitaliano.org.ar/images/centros/central.jpg'); 
      background-size: cover;
      background-position: center;
      opacity: 0.7; 
      z-index: -1; 
    }
   .login-container {
      max-width: 400px;
      margin: 100px auto;
      background-color: rgba(255, 255, 255, 0.9); 
      border-radius: 10px;
      box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
      padding: 20px;
    }

    .login-title {
      color: #007bff;
      font-weight: bold;
      margin-bottom: 20px;
      font-style: italic;
    }

    .form-label {
      color: #555;
    }

    .btn-hospital {
      background-color: #007bff;
      border: none;
    }

    .btn-hospital:hover {
      background-color:#00BFFF;
    }

    .forgot-password {
      color: #007bff;
    }

    .forgot-password:hover {
      text-decoration: underline;
    }
    
    .footer {
      background-color: #f8f9fa;
      text-align: center;
      padding: 10px 0;
    }
  </style>
</head>
 
<body>
    <form id="form1" runat="server">
        <div class="background"></div>
        <div class="container">
            <div class="login-container">
              <h2 class="text-center login-title"> General Hospital Springfield</h2>
              <form>
                <div class="mb-3">
                  <label for="usuario" class="form-label">Usuario</label>
                  <input type="text" class="form-control" id="usuario" placeholder="Ingrese su usuario" required>
                </div>
                <div class="mb-3">
                  <label for="password" class="form-label">Contraseña</label>
                  <input type="password" class="form-control" id="password" placeholder="Ingrese su contraseña" required>
                </div>
                <div class="mb-3 form-check">
                  <input type="checkbox" class="form-check-input" id="rememberMe">
                  <label class="form-check-label" for="rememberMe">Recordarme</label>
                </div>
                <button type="submit" class="btn btn-hospital w-100">Iniciar sesión</button>
              </form>
              <div class="mt-3 text-center">
                <a href="#" class="forgot-password">¿Olvide mi contraseña?</a>
              </div>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <footer class="footer">
    <p>@CopyRight Equipo 3B - 2024</p>
</footer>
</body>
</html>

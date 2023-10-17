<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<title>Alta Usuario</title>
</head>
<body>   
<jsp:include page="/WEB-INF/templates/header.jsp" />
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">                
                <form onsubmit="return validateForm()" action="Alta-Usuario" method="post" >                     
                    <div>
                    <h5 class="tituloVentana">Alta Usuario</h5>
                    </div>
					 <% 
					    String mensajeError = (String) session.getAttribute("mensajeError"); 
					    if(mensajeError != null) {
					%>
					    <div class="alert alert-danger">
					        <%= mensajeError %>
					    </div>
					<%
					    session.removeAttribute("mensajeError");
					}
					    String mensajeExito = (String) session.getAttribute("mensajeExito"); 
					    if(mensajeExito != null) {
					    %>
					        <div class="alert alert-success">
					            <%= mensajeExito %>
					        </div>
					    <%
					        session.removeAttribute("mensajeExito");
					    }
					    %>
					
                    <div class="row mb-1">
                        <label for="inputUsuarioNick" class="col-sm-2 col-form-label">NickName</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioNick" name="inputUsuarioNick">
                        </div>
                    </div>                   
                    <div class="row mb-1">
                        <label for="inputUsuarioNombre" class="col-sm-2 col-form-label">Nombre</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioNombre" name="inputUsuarioNombre">
                        </div>
                    </div>
                    <div class="row mb-1">
                        <label for="inputUsuarioApellido" class="col-sm-2 col-form-label">Apellido</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioApellido" name="inputUsuarioApellido">
                        </div>
                    </div>                    
                    <div class="row mb-1">
                        <label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="inputPassword" name="inputPassword">
                        </div>
                    </div>                
                    <div class="row mb-1">
                        <label for="inputRePassword" class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="inputRePassword" name="inputRePassword">
                        </div>
                    </div>
                    <div class="row mb-1">
                        <label for="inputUsuarioEmail" class="col-sm-2 col-form-label">E mail</label>
                        <div class="col-sm-8">
                            <input type="email" class="form-control" id="inputUsuarioEmail" name="inputUsuarioEmail"> 
                        </div>
                    </div>
                    <div class="row mb-1">
                        <label for="inputUsuarioFNac" class="col-sm-2 col-form-label">FechaNac</label>
                        <div class="col-sm-8">
                            <input type="date" class="form-control" id="inputUsuarioFNac" name="inputUsuarioFNac">
                        </div>
                    </div>
                     <div class="row mb-1">
                        <label for="inputUsuarioNacion" class="col-sm-2 col-form-label">Nacionalidad</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioNacion" name="inputUsuarioNacion">
                        </div>
                    </div>
                    <div class="row mb-1">
                        <label for="inputUsuarioImage" class="col-sm-2 col-form-label">Foto_link</label>
                        <div class="col-sm-8">
                            <input type="file" class="form-control" id="inputUsuarioImage" name="inputUsuarioImage">
                        </div>
                    </div>
                    <div class="row mb-1">
                        <div class="col-lg-8 offset-lg-7">
                            <button type="submit" class="btn btn-primary offset-sm-1" >Aceptar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
       function validateForm() {
            var nick = document.getElementById("inputUsuarioNick").value;
            if (nick == "") {
                alert("El Nick no puede estar vacío.");
                return false;
            }
            var descriptionN = document.getElementById("inputUsuarioNombre").value;
            if (descriptionN == "") {
                alert("El Nombre de Usuario no puede estar vacía.");
                return false;
            }            
            var descriptionA = document.getElementById("inputUsuarioApellido").value;
            if (descriptionA == "") {
                alert("El Apellido de Usuario no puede estar vacía.");
                return false;
            }
            var password = document.getElementById("inputPassword").value;
            var repassword = document.getElementById("inputRePassword").value;            
            if (password =="" || repassword ==""){
                alert("El password no puede estar vacio.");
                return false;
            }
            if (password != repassword){
            	alert("Los password no coinciden.");
                return false;
            }          
            var email = document.getElementById("inputUsuarioEmail").value;
            if (email == "") {
                alert("El E-Mail no puede estar vacio.");
                return false;
            }
            var fn = document.getElementById("inputUsuarioFNac").value;
            if (fn == "") {
                alert("La fecha de nacimiento no puede estar vacia.");
                return false;
            }
            return true;
        }
    </script>  

    <!-- Contenido de la página -->
    <div class="container">
        <!-- Contenido de la página -->
    </div>

</body>
</html>

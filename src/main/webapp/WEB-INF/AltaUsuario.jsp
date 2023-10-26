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
    <div class="container mt-5">
    <h3 class="titulo">Alta Usuario</h3>
        <div class="row justify-content-center fondoTransparente">
            <div class="col-lg-10">                
                <form onsubmit="return validateForm()" action="Alta-Usuario" method="post" >                     
                    
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
                     <label for="userType" class="col-sm-2 col-form-label" style="margin-right: 30px;">Tipo</label>
                     <div class="col-sm-8">
                            <select class="form-control" id="userType" name="userType">
                                <option for="userType" value="proveedor">Proveedor</option>
                                <option for="userType" value="turista">Turista</option>
                            </select>
                        </div>
                    </div>					
                    <div class="row mb-1">
                        <label for="inputUsuarioNick" class="col-sm-2 col-form-label" style="margin-right: 30px;">NickName</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioNick" name="inputUsuarioNick">
                        </div>
                    </div>                   
                    <div class="row mb-1">
                        <label for="inputUsuarioNombre" class="col-sm-2 col-form-label" style="margin-right: 30px;">Nombre</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioNombre" name="inputUsuarioNombre">
                        </div>
                    </div>
                    <div class="row mb-1">
                        <label for="inputUsuarioApellido" class="col-sm-2 col-form-label" style="margin-right: 30px;">Apellido</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioApellido" name="inputUsuarioApellido">
                        </div>
                    </div>                    
                    <div class="row mb-1">
                        <label for="inputPassword" class="col-sm-2 col-form-label" style="margin-right: 30px;">Password</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="inputPassword" name="inputPassword">
                        </div>
                    </div>                
                    <div class="row mb-1">
                        <label for="inputRePassword" class="col-sm-2 col-form-label" style="margin-right: 30px;">Password</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="inputRePassword" name="inputRePassword">
                        </div>
                    </div>
                    <div class="row mb-1">
                        <label for="inputUsuarioEmail" class="col-sm-2 col-form-label" style="margin-right: 30px;">Email</label>
                        <div class="col-sm-8">
                            <input type="email" class="form-control" id="inputUsuarioEmail" name="inputUsuarioEmail"> 
                        </div>
                    </div>
                    <div class="row mb-1">
                        <label for="inputUsuarioFNac" class="col-sm-2 col-form-label" style="margin-right: 30px;">FechaNac</label>
                        <div class="col-sm-8">
                            <input type="date" class="form-control" id="inputUsuarioFNac" name="inputUsuarioFNac">
                        </div>
                    </div>                     
                     <div class="row mb-1" id="campoTurista">
                        <label for="inputUsuarioNacion" class="col-sm-2 col-form-label" style="margin-right: 30px;">Nacionalidad</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioNacion" name="inputUsuarioNacion">
                        </div>
                    </div>
                     <div class="row mb-1" id="campoProveedor">
                        <label for="inputUsuarioDesc" class="col-sm-2 col-form-label" style="margin-right: 30px;">Descripcion</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioDesc" name="inputUsuarioDesc">
                        </div>
                    </div>
                     <div class="row mb-1" id="campoProveedor2">
                        <label for="inputUsuarioLinkW" class="col-sm-2 col-form-label" style="margin-right: 30px;">LinkWeb</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputUsuarioLinkW" name="inputUsuarioLinkW">
                        </div>
                    </div>                  
                    <div class="row mb-1">
                        <label for="inputUsuarioImage" class="col-sm-2 col-form-label" style="margin-right: 30px;">Foto_link</label>
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
    	   var type = document.getElementById("userType").value;
           if (type == "") {
               alert("Debe seleccionar tipo.");
               return false;
           }
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
            var desc = document.getElementById("inputUsuarioDesc").value;
            if (desc == "" && type == "proveedor") {
                alert("La descripcion no puede estar vacia.");
                return false;
            }          
            var nacion = document.getElementById("inputUsuarioNacion").value;
            if (nacion == "" && type == "turista") {
                alert("La descripcion no puede estar vacia.");
                return false;
            }
            return true;
        }
    </script>  
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	$(document).ready(function() {
	    // Ocultar campos al inicio
	    //$('#campoProveedor').hide();
	    //$('#campoProveedor2').hide();
	    $('#campoTurista').hide();
	
	    // Detectar cambio en el dropdown
	    $('#userType').change(function() {
	        if ($(this).val() == 'proveedor') {
	            $('#campoProveedor').show();
	            $('#campoProveedor2').show();
	            $('#campoTurista').hide();
	        } else if ($(this).val() == 'turista') {
	            $('#campoProveedor').hide();
	            $('#campoProveedor2').hide();
	            $('#campoTurista').show();
	        }
	        // Ocultar campos al inicio en función del valor preseleccionado
	     	handleVisibility();

	        // Detectar cambio en el dropdown
	        $('#userType').change(handleVisibility);
	    });
	});
	</script>
	
    <!-- Contenido de la página -->
    <div class="container">
        <!-- Contenido de la página -->
    </div>

</body>
</html>

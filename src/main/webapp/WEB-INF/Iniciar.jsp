<%@page import="com.labo2.model.EstadoSesion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/templates/header.jsp" />
    <div class="container mt-5">
		<h3 class="titulo">Iniciar Sesion</h3>
        <div class="row justify-content-center fondoTransparente">
            <div class="col-lg-6">
                <form action="iniciar-sesion">
					
                    
                    	<%
        					EstadoSesion estadoSesion = (EstadoSesion) session.getAttribute("estado_sesion");
                        	if(estadoSesion != null && estadoSesion.equals(EstadoSesion.LOGIN_INCORRECTO)) {
        						
    					%>
    						<div class="alert alert-danger" role="alert">
    							Login incorrecto. Intentelo nuevamente! <br>
    						</div>
						<%
						    }
						%>
					<div class="row mb-3">
                        <label for="userType" class="col-sm-2 col-form-label">Tipo</label>
                        <div class="col-sm-10">
                            <select class="form-control" id="userType" name="userType" style="margin-left: 40px;">
                                <option for="userType" value="proveedor">Proveedor</option>
                                <option for="userType" value="turista">Turista</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="inputUsuario" class="col-sm-2 col-form-label">Usuario</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="inputUsuario" name="inputUsuario" style="margin-left: 40px;"> <!-- rutea por name -->
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="inputPassword" name="inputPassword" style="margin-left: 40px;">
                        </div>
                    </div>                
                 
                    <div class="row mb-4">
                        <div class="col-lg-10 offset-lg-9">
                            <button type="submit" class="btn btn-primary offset-sm-1" >Aceptar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
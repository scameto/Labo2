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
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <form action="iniciar-sesion">
					<div>
                    <h1 class="tituloVentana">Iniciar Sesion</h1>
                    </div>
                    <div class="row mb-3">
                        <label for="userType" class="col-sm-2 col-form-label">Tipo</label>
                        <div class="col-sm-10">
                            <select class="form-control" id="userType" name="userType">
                                <option for="userType" value="proveedor">Proveedor</option>
                                <option for="userType" value="turista">Turista</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="inputUsuario" class="col-sm-2 col-form-label">Usuario</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="inputUsuario" name="inputUsuario"> <!-- rutea por name -->
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="inputPassword" name="inputPassword">
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
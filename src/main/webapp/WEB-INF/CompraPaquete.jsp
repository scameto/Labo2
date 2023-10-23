<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<title>Compra de Paquete</title>
</head>
<body>
<jsp:include page="/WEB-INF/templates/header.jsp" />
<!-- Contenido de la página -->
    <div class="container mt-5">
        <div class="titulo"><h3>Compra de Paquete</h3></div>
        <div class="row justify-content-center fondoTransparente">
            <div class="col-12">
                <form>
                    <div class="form-group">
                        <label for="paquetes">Paquetes:</label>
                        <select class="form-control" id="cbPaquetes">
                            <option value="opcion1">Opción 1</option>
                            <option value="opcion2">Opción 2</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="actividades">Actividades del paquete:</label>
                        <select class="form-control" id="cbActividades">
                            <option value="opcion1">Opción 1</option>
                            <option value="opcion2">Opción 2</option>
                        </select>
                    </div>
                    <div class="col-6 otrosCampos">
                        <div class="form-group">
                            <label for="campoLectura">Costo ($ Uy):</label>
                            <input type="text" class="form-control" id="soloLectura" readonly>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Comprar</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
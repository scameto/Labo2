<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<title>Consulta de Paquete</title>
</head>
<body>
<jsp:include page="/WEB-INF/templates/header.jsp" />
<!-- Contenido de la página -->
    <div class="container mt-5">
        <div class="titulo"><h3>Consulta de Paquete</h3></div>
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
                        <label for="actividades">Actividades del paquete seleccionado:</label>
                        <select class="form-control" id="cbActividades">
                            <option value="opcion1">Opción 1</option>
                            <option value="opcion2">Opción 2</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="categorias">Categoria/s del paquete seleccionado:</label>
                        <select class="form-control" id="cbCategorias">
                            <option value="opcion1">Opción 1</option>
                            <option value="opcion2">Opción 2</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlTextarea1 campoLectura">Descripción:</label>
                        <textarea class="form-control" id="soloLectura" rows="3" readonly></textarea>
                    </div>
                    <div class="form-group col-5 foto">
                        Foto<!--Foto Aqui iria la foto ascociada al paquete  -->
                    </div>
                    <div class="col-6 otrosCampos">
                        <div class="form-group">
                            <label for="campoLectura">Validez (días):</label>
                            <input type="text" class="form-control" id="soloLectura" readonly>
                        </div>
                        <div class="form-group">
                            <label for="campoLectura">Descuento (%):</label>
                            <input type="text" class="form-control" id="soloLectura" readonly>
                        </div>
                        </div>
                    <button type="submit" class="btn btn-primary">Aceptar</button>
                    <button type="submit" class="btn btn-light">Ver info. Actividad</button> <!--Para ir a la info de la act. seleccionada  -->
                </form>
            </div>
        </div>
    </div>
</body>
</html>
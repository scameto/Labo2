<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<title>Consulta de Salida Turistica</title>
</head>
<body>
<jsp:include page="/WEB-INF/templates/header.jsp" />
<!-- Contenido de la página -->
    <div class="container mt-5">
        <div class="titulo"><h3>Consulta de Salida Turística</h3></div>
        <div class="row justify-content-center fondoTransparente">
            <div class="col-12">
                <form>
                    <div class="form-group">
                        <label for="departamentos">Departamento:</label>
                        <select class="form-control" id="cbDepartamentos">
                            <option value="opcion1">Opción 1</option>
                            <option value="opcion2">Opción 2</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="categorias">Categoría:</label>
                        <select class="form-control" id="cbCategorias">
                            <option value="opcion1">Opción 1</option>
                            <option value="opcion2">Opción 2</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="actividades">Actividad:</label>
                        <select class="form-control" id="cbActividades">
                            <option value="opcion1">Opción 1</option>
                            <option value="opcion2">Opción 2</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="salidas">Salidas asociadas a la actividad:</label>
                        <select class="form-control" id="cbSalidas">
                            <option value="opcion1">Opción 1</option>
                            <option value="opcion2">Opción 2</option>
                        </select>
                    </div>
                    <div class="form-group foto col-5">
                        Foto<!-- Aqui iria la foto que se muestra al seleccionar la actividad-->   
                    </div>
                    <div class="col-6 otrosCampos">
                        <div class="form-group">
                            <label for="campoLectura">Fecha:</label>
                            <input type="text" class="form-control" id="soloLectura" readonly>
                        </div>
                        <div class="form-group">
                            <label for="campoLectura">Hora:</label>
                            <input type="text" class="form-control" id="soloLectura" readonly>
                        </div>
                        <div class="form-group">
                            <label for="campoLectura">Lugar:</label>
                            <input type="text" class="form-control" id="soloLectura" readonly>
                        </div>
                        <div class="form-group">
                            <label for="campoLectura">Cant. max. turístas:</label>
                            <input type="text" class="form-control" id="soloLectura" readonly>
                        </div>   
                    </div>
                    <button type="submit" class="btn btn-primary">Aceptar</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
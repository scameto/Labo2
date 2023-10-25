<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<title>Inscripción a Salida Turística</title>
</head>
<body>
<jsp:include page="/WEB-INF/templates/header.jsp" />
<!-- Contenido de la página -->
    <div class="container mt-5">
        <div class="titulo"><h3>Inscripción a Salida Turística</h3></div>
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
                        <label for="actividad">Actividad:</label>
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
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="campoLectura">Fecha de salida:</label>
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
                        <div class="col-6">
                            <div class="form-group">
                                <label for="cantTuristasInsc">Cant. de turistas a inscribir:</label>
                                <input type="text" class="form-control">
                            </div>    
                            <div class="form-group">
                                <label for="formaDePago">Forma de pago:</label>
                                <select class="form-control" id="cbFormaDePago">
                                    <option value="opcion1">Opción 1</option>
                                    <option value="opcion2">Opción 2</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="paquetes">Paquetes:</label>
                        <select class="form-control" id="cbPaquetes">
                            <option value="opcion1">Si tiene paquetes comprados y vigentes, los lista aca</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Enviar</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
<%@ page import="java.util.List" %>
<%@page import="logica.modelos.Departamento"%>
<%@page import="logica.datatypes.DataDepartamento"%>
<%@page import="logica.modelos.Paquete"%>
<%@page import="logica.datatypes.DataPaquete"%>
<%@ page import="com.google.gson.Gson" %>
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
						<select class="form-control" id="paqueteSelect" name="paqueteSelect" onchange="actualizarDatos(this)">
						    <%
						    List<DataPaquete> paquetes = (List<DataPaquete>)request.getAttribute("paquetes");
						    if (paquetes != null) {
						        for (DataPaquete paquete : paquetes) {
						    %>
						        <option value="<%= paquete.getNombre() %>"><%= paquete.getNombre() %></option>
						    <%
						        }
						    }
						    %>
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
					    <textarea class="form-control" id="descripcion" rows="3" readonly></textarea>
					</div>
					<div class="form-group col-5 foto">
					    Foto<!--Foto Aquí iría la foto asociada al paquete  -->
					</div>
					<div class="col-6 otrosCampos">
					    <div class="form-group">
					        <label for="campoLectura">Validez (días):</label>
					        <input type="text" class="form-control" id="validez" readonly>
					    </div>
					    <div class="form-group">
					        <label for "campoLectura">Descuento (%):</label>
					        <input type="text" class="form-control" id="descuento" readonly>
					    </div>
					</div>
                    <button type="submit" class="btn btn-primary">Aceptar</button>
                    <button type="submit" class="btn btn-light">Ver info. Actividad</button> <!--Para ir a la info de la act. seleccionada  -->
                </form>
            </div>
        </div>
    </div>
    <script>
        function actualizarDatos(select) {
            console.log("Script ejecutado"); // para ver si entraba al script
            var paquetes = <%= new Gson().toJson(paquetes) %>;
            var selectedValue = select.value;
            
            for (var i = 0; i < paquetes.length; i++) {
                if (paquetes[i].nombre === selectedValue) {
                    document.getElementById("descripcion").value = paquetes[i].descripcion;
                    document.getElementById("validez").value = paquetes[i].validez;
                    document.getElementById("descuento").value = paquetes[i].descuento;
                    break;
                }
            }
        }
    </script>
</body>
</html>
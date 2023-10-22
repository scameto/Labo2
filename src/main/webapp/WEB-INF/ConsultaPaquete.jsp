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
                        
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="categorias">Categoria/s del paquete seleccionado:</label>
                        <select class="form-control" id="cbCategorias">
                            
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
			console.log("entro al script");
		    var paquetes = <%= new Gson().toJson(paquetes) %>;
		    var selectedValue = select.value;
		    var actividadesSelect = document.getElementById("cbActividades");
	
		    actividadesSelect.innerHTML = ''; // Limpiar las opciones actuales
	
		    for (var i = 0; i < paquetes.length; i++) {
		        if (paquetes[i].nombre === selectedValue) {
		        	
		            var paquete = paquetes[i];
		            console.log("Nombre: " + paquete.nombre);
		            console.log("Descripción: " + paquete.descripcion);
		            console.log("Validez: " + paquete.validez);
		            console.log("Descuento: " + paquete.descuento);

		            document.getElementById("descripcion").value = paquetes[i].descripcion;
		            document.getElementById("validez").value = paquetes[i].validez;
		            document.getElementById("descuento").value = paquetes[i].descuento;
		            
		            

		            // Carga actividades asociadas al paquete
		            var actividades = paquetes[i].actividades;
		            if (actividades && actividades.length > 0) {
		                actividades.forEach(function (actividad) {
		                    var option = document.createElement("option");
		                    option.value = actividad.id;
		                    option.textContent = actividad.nombre;
		                    actividadesSelect.appendChild(option);
		                    paquete.actividades.forEach(function(actividad) {
		                        console.log("ID: " + actividad.id);
		                        console.log("Nombre: " + actividad.nombre);
		                    });
		                });
		            } else {
		                // Si no hay actividades asociadas, muestra un mensaje predeterminado
		                var option = document.createElement("option");
		                option.value = '';
		                option.textContent = 'No hay actividades asociadas';
		                actividadesSelect.appendChild(option);
		            }
		            break;
		        }
		    }
		}
	</script>
		
</body>
</html>
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
						<select class="form-control" id="paqueteSelect" name="paqueteSelect">
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
                        <select class="form-control" id="cbCategorias" name="categoriasSelect">
                        
                        </select>
                    </div>
                    <div class="form-group">
					    <label for="exampleFormControlTextarea1 campoLectura">Descripción:</label>
					    <textarea class="form-control" id="descripcion" rows="3" readonly></textarea>
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
                    <button type="submit" class="btn btn-primary">Consultar</button>
					<button type="button" class="btn btn-light" onclick="verInfoActividad()">Ver info. Actividad</button>
                </form>
            </div>
        </div>
    </div>
	<script>
	
	document.addEventListener("DOMContentLoaded", function() {
	    var consultarBtn = document.querySelector(".btn-primary");
	    consultarBtn.addEventListener("click", function(event) {
	        event.preventDefault();
	        actualizarDatos(event); // Pasar el evento como argumento
	    });
	});
	
	//----------------------------------------------------------------
	
	//function verInfoActividad() {
    //var actividadSeleccionada = document.getElementById("cbActividades").value;
    //if (actividadSeleccionada) {
        // Redirigir a la página de consulta de actividad con el ID de la actividad como parámetro
     //   window.location.href = "consultaActividad?actividadId=" + actividadSeleccionada;
     //   console.log("actividad que tengo seleccionada: " + actividadSeleccionada);
   // } else {
   //     alert("Por favor, selecciona una actividad.");
   // }
	//}
	
	 function verInfoActividad() {
	        var actividadSeleccionada = document.getElementById("cbActividades").value;
	        
	        // Obtener los datos de la actividad seleccionada
	        var actividades = <%= new Gson().toJson(paquetes) %>;
	        var actividadSeleccionadaData = actividades.find(function(actividad) {
	            return actividad.id == actividadSeleccionada;
	        });
	        
	        // Almacenar los datos de la actividad en variables JavaScript
	        var nombreActividad = actividadSeleccionadaData.nomAct;
	        var descripcionActividad = actividadSeleccionadaData.descripcion;
	        // Y otros datos relevantes

	        // Redirigir a la página de consulta de actividad con datos de actividad en la URL
	        window.location.href = "consultaActividad.jsp?nombre=" + nombreActividad + "&descripcion=" + descripcionActividad;
	    }
	
	
	
	
	
	
	//----------------------------------------------------------------

	function actualizarDatos(event) {
	    var paquetes = <%= new Gson().toJson(paquetes) %>;
	    var selectedValue = event.target.form.paqueteSelect.value; // Obtener el valor seleccionado
	    var actividadesSelect = document.getElementById("cbActividades");
	    var categoriasSelect = document.getElementById("cbCategorias");

	    actividadesSelect.innerHTML = '';
	    categoriasSelect.innerHTML = '';

	    var idPaquete;
	    for (var i = 0; i < paquetes.length; i++) {
	        if (paquetes[i].nombre === selectedValue) {
	            var paquete = paquetes[i];
	            idPaquete = paquete.id;
	            actualizarCategorias(idPaquete);
	            console.log("Paquete seleccionado: ", paquete);
// 	            console.log("-----------------------------");
// 	            console.log("Nombre: " + paquete.nombre);
// 	            console.log("Descripción: " + paquete.descripcion);
// 	            console.log("Validez: " + paquete.validez);
// 	            console.log("Descuento: " + paquete.descuento);
// 	            console.log("-----------------------------");

	            document.getElementById("descripcion").value = paquetes[i].descripcion;
	            document.getElementById("validez").value = paquetes[i].validez;
	            document.getElementById("descuento").value = paquetes[i].descuento;

	            var actividades = paquetes[i].actividades;
	            actividadesSelect.innerHTML = '';

	            if (actividades && actividades.length > 0) {
	                for (var j = 0; j < actividades.length; j++) {
	                    console.log("Actividad ID: " + actividades[j].id);
	                    console.log("Actividad Nombre: " + actividades[j].nomAct);
	                    var option = document.createElement("option");
	                    option.value = actividades[j].id;
	                    option.textContent = actividades[j].nomAct;
	                    actividadesSelect.appendChild(option);
	                }
	            } else {
	                var option = document.createElement("option");
	                option.value = '';
	                option.textContent = 'No hay actividades asociadas';
	                actividadesSelect.appendChild(option);
	            }
	        }
	    }
	}

	function actualizarCategorias(idPaquete){
	    var xhr = new XMLHttpRequest();
	    xhr.open("POST", "http://localhost:8080/Labo2/ConsultaPaquete", true);
	    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	    var categoriasSelect = document.getElementById("cbCategorias");
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState == 4 && xhr.status == 200) {
	            if (JSON.parse(xhr.responseText) != null) {
	                var categorias = JSON.parse(xhr.responseText);
	                if(categorias.length == 0){
	                	var optionCat2 = document.createElement("option");
		                optionCat2.value = '';
		                optionCat2.textContent = 'Este paquete no contiene ninguna categoria.';
		                categoriasSelect.appendChild(optionCat2);
	                    return;
	                }
	                categoriasSelect = document.getElementById("cbCategorias");
	                categoriasSelect.innerHTML = ''; // Limpiar las opciones actuales
	                categorias.forEach(function(categoria) {
	                    var optionCat = document.createElement("option");
	                    optionCat.value = categoria.id;
	                    optionCat.textContent = categoria.nombre;
	                    categoriasSelect.appendChild(optionCat);
	                });
	            }
	        }
	    };
	    xhr.send("idPaquete=" + idPaquete);
	}

	</script>
	
	
	
	
		
</body>
</html>
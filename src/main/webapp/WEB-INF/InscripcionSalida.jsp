<%@page import="logica.datatypes.DataCategoria"%>
<%@page import="logica.datatypes.DataDepartamento"%>
<%@page import="java.util.List"%>
<%@page import="logica.datatypes.DataTurista"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<title>Consultar Usuario</title>
</head>
<body>
	<jsp:include page="/WEB-INF/templates/header.jsp" />
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-3">
			
				<div>
					<h1 class="tituloVentana">Inscripcion Salida</h1>
					<div id="cajaDepartamentos">
						<div id="listaActividades">
							<label for="departamentos">Departamentos:</label>
							<ul class="list-group">
								<%
								List<DataDepartamento> deptos = (List<DataDepartamento>) request.getAttribute("deptos");
								if (deptos != null) {
									for (DataDepartamento username : deptos) {
								%>
								<li class="list-group-item"
									onclick="seleccionarDepartamento('<%=username.getId()%>')"><%=username.getNombre()%></li>
								<%
								}
								}
								%>
							</ul>
						</div>

					</div>

					<div class="select">
						<label for="categorias">Categorías:</label>
						<ul class="list-group">
						
<!-- 						<ul id="categorias" name="categoria"> -->

							<%
							List<DataCategoria> categorias = (List<DataCategoria>)request.getAttribute("categoria");
							if (categorias != null) {
								for (DataCategoria cat : categorias) {
							%>
							<li class="list-group-item"
								onclick="seleccionarCategoria('<%=cat.getId()%>')"><%=cat.getNombre()%></li>
							<%
							}
							}
							%>
							<!-- Aquí vendría el código JSP para llenar las categorías -->
						</ul>
					</div>

				</div>
			</div>

			<style>
#cajaDepartamentos, #cajaCategorias {
	max-height: 40vh;
	overflow-y: auto;
	width: 100%;
	max-width:250px;
}



#cardActividades {
	overflow-y: auto;
	max-height: 30vh;
	
}


#cardSalidas {
	overflow-y: auto;
	max-height: 30vh;
}
#div.card.mb-0{
	margin-top: 30px;
	overflow-y: auto;
	max-height: 30vh;
	width:100%;	
}
</style>
			<div class="col-lg-9">
				<section style="background-color: rgba(238, 238, 238, 0.5); margin-top: 10vh;"
					id="datosTurista">
					<div class="container py-5">
						<div class="row">

							<div class="col-md-6">
								<div class="card mb-0">
									<label for="formaDePago">Actividades Disponibles:</label>				
									<div class="card-body" id="cardActividades"></div>
							</div>
							</div>
								<div class="col-md-6"  style="display: none;" id="contenedorSalidas">
										<div class="card mb-0">
											<label for="formaDePago">Salidas Disponibles:</label>											
											<div class="card-body" id="cardSalidas"></div>
										</div>
									</div>
									
									<div class="col-md-12" style="display: none; margin-top: 30px" id="contenedorInscripcion">
										<div class="card row-md-8">
											 <div class="form-group">
				                                <label for="cantTuristasInsc">Cant. de turistas a inscribir:</label>
				                                <input type="text" class="form-control">
				                            </div>    
				                            <div class="form-group">
				                                <label for="formaDePago">Forma de pago:</label>
				                                <select class="form-control" id="cbFormaDePago">
				                                    <option value="opcion1">General</option>
				                                    <option value="opcion2">Por Paquete</option>				                                
				                                </select>
				                                <label for="formaDePago">Paquetes disponibles:</label>				                                
				                                 <Select id="actividadSelect" name="actividadSelect" class="form-control">							
												</Select>
				                            </div>	
				                        </div>

									<div class="col-md-6"  style="display: none;" id="contenedorSalidas">
										<div class="card mb-0">
											<div class="card-body" id="cardSalidas"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>

	<script>
function seleccionarDepartamento(idDepartamento) {
	// Crear un objeto XMLHttpRequest
	var xhr = new XMLHttpRequest();	
	document.getElementById("contenedorInscripcion").style.display = "none";
	document.getElementById("contenedorSalidas").style.display = "none";
	
	console.log("llegue no se q ...");
	// Configurar la solicitud
	xhr.open('POST', 'http://localhost:8080/Labo2/consultaActividad?idDepto=' // esto es una queryparam
			+ idDepartamento, true);
	xhr.setRequestHeader('Content-Type', 'application/json');
// 	document.getElementById("cardPaquetes".style.display) = "none";
	// Definir el comportamiento al cambio de estado
	xhr.onreadystatechange = function() {
		// Verificar si la solicitud se completó exitosamente
		if (xhr.readyState == 4 && xhr.status == 200) {
			if (JSON.parse(xhr.responseText) != null) {
				var actividades = JSON.parse(xhr.responseText);
				var actividadesHtml = "";

				// Construir el contenido HTML de las actividades
				if (actividades.length != 0) {
					actividades
							.forEach(function(actividad) {
								
									actividadesHtml += "<div class='actividad' onclick='buscarSalidas(" 
							            + actividad.id 
							            + "); buscarPaquetes(" 
							            + actividad.id 
							            + ")'>";
							        
							        actividadesHtml += "<h4 style='cursor: pointer;'>" + actividad.nomAct + "</h4>";
							        actividadesHtml += "<hr>";
							        
							        actividadesHtml += "<p>Descripcion: " + actividad.descripcion + "</p>";
							        actividadesHtml += "<p>Duración: " + actividad.duracion + " horas</p>";
							        actividadesHtml += "<p>Costo: $" + actividad.costo + "</p>";
							        actividadesHtml += "<p>Ciudad: " + actividad.ciudad + "</p>";
							        var nombresCategorias = actividad.categorias.map(function(categoria) {
							            return categoria.nombre;
							        }).join(', ');

							        actividadesHtml += "<p>Categorias: " + nombresCategorias + "<p>";
							});
				} else {
					actividadesHtml += "<div class='actividad'>"
							+ "<p>"
							+ "Este Departamento no tiene actividades confirmadas a mostrar."
							+ "</p>" + "</div>";
				}

				document.getElementById("cardActividades").innerHTML = actividadesHtml;
			}
		}
	};
	// Enviar la solicitud
	xhr.send();
}

// 		<script>
function seleccionarCategoria(idCategoria) {	
	// Crear un objeto XMLHttpRequest
	var xhr = new XMLHttpRequest();
	
	document.getElementById("contenedorInscripcion").style.display = "none";
	document.getElementById("contenedorSalidas").style.display = "none";
	console.log("llegue no se q ...");
	// Configurar la solicitud
	xhr.open('POST', 'http://localhost:8080/Labo2/consultaActividad?idCateg=' // esto es una queryparam
			+ idCategoria, true);
	xhr.setRequestHeader('Content-Type', 'application/json');

	// Definir el comportamiento al cambio de estado
	xhr.onreadystatechange = function() {
		// Verificar si la solicitud se completó exitosamente
		if (xhr.readyState == 4 && xhr.status == 200) {
			if (JSON.parse(xhr.responseText) != null) {
				var actividades = JSON.parse(xhr.responseText);
				var actividadesHtml = "";

				// Construir el contenido HTML de las actividades
				if (actividades.length != 0) {
					actividades
							.forEach(function(actividad) {
								
									actividadesHtml += "<div class='actividad' onclick='buscarSalidas(" 
							            + actividad.id 
							            + "); buscarPaquetes(" 
 							            + actividad.id 
							            + ")'>";
							        
							        actividadesHtml += "<h4 style='cursor: pointer;'>" + actividad.nomAct + "</h4>";
							        actividadesHtml += "<hr>";
							        
							        actividadesHtml += "<p>Descripcion: " + actividad.descripcion + "</p>";
							        actividadesHtml += "<p>Duración: " + actividad.duracion + " horas</p>";
							        actividadesHtml += "<p>Costo: $" + actividad.costo + "</p>";
							        actividadesHtml += "<p>Ciudad: " + actividad.ciudad + "</p>";
							        var nombresCategorias = actividad.categorias.map(function(categoria) {
							            return categoria.nombre;
							        }).join(', ');

							        actividadesHtml += "<p>Categorias: " + nombresCategorias + "<p>";
							});
				} else {
					actividadesHtml += "<div class='actividad'>"
							+ "<p>"
							+ "Esta Categoria no tiene actividades confirmadas a mostrar."
							+ "</p>" + "</div>";
				}

				document.getElementById("cardActividades").innerHTML = actividadesHtml;

			}
		}
	};
	// Enviar la solicitud
	xhr.send();
}
function buscarPaquetes(idSalida) { // esta funcion muesta las salidas asociadas a una actividad
	document.getElementById("contenedorInscripcion").style.display = "block";
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "http://localhost:8080/Labo2/consultaActividad?idPaquet=" + idActividad,
			true);
	xhr.setRequestHeader("Content-Type",
			"application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				var paquetes = JSON.parse(xhr.responseText);
				// Construir el contenido HTML de las salidas
				var paquetesHtml = "";
				if (paquetes.length > 0) {
					paquetes
							.forEach(function(paquete) {
								paquetesHtml += "<div class='paquete'>";
								paquetesHtml += "<h4>" + paquete.nombre
										+ "</h4>";
										paquetesHtml += "<hr>";
										paquetesHtml += "<p>Descripcion: "	+ paquete.descripcion + "</p>";
										paquetesHtml += "<p>Validez: "	+ paquete.validez + "</p>";
										paquetesHtml += "<p>Descuento: " + paquete.descuento + "</p>";
										paquetesHtml += "<p>Fecha Alta: " + paquete.fechaAlta + "</p>";										
										paquetesHtml += "</div>";
							});
				} else {
					paquetesHtml += "<p>No hay Paquetes disponibles para esta Actividad.</p>";
				}
				// Agregar el contenido al elemento con id cardSalidas
				document.getElementById("cardPaquetes").innerHTML = paquetesHtml;
			} else {
				// Manejar errores si es necesario
				console.error("Error al obtener Paquetes de la actividad.");
			}
		}
	};
	// Enviar el ID de la actividad al servidor
	xhr.send("idActividad=" + idActividad);
}
function buscarSalidas(idActividad) { // esta funcion muesta las salidas asociadas a una actividad
	document.getElementById("contenedorSalidas").style.display = "block";
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "http://localhost:8080/Labo2/consultaActividad?idActiv=" + idActividad, true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				var salidas = JSON.parse(xhr.responseText);
				// Construir el contenido HTML de las salidas
				var salidasHtml = "";
				if (salidas.length > 0) {
					salidas.forEach(function(salida) {
								salidasHtml += "<div class='salida'>";						
								
								salidasHtml += "<h4>" + salida.nombre
										+ "</h4>";
								salidasHtml += "<hr>";
								salidasHtml += "<p>Cant Máxima: "
										+ salida.cantMax + "</p>";
								salidasHtml += "<p>Cant Actual: "
										+ salida.cantActual + "</p>";
								salidasHtml += "<p>Fecha Alta: "
										+ salida.fechaAlta + "</p>";
								salidasHtml += "<p>Fecha Salida: "
										+ salida.fechaSalida + "</p>";
								salidasHtml += "<p>Hora Salida: "
										+ salida.horaSalida + "</p>";
								salidasHtml += "<p>Lugar Salida: "
										+ salida.lugarSalida + "</p>";
								salidasHtml += "</div>";
							});
				} else {
					salidasHtml += "<p>No hay salidas disponibles para esta actividad.</p>";                 
				}
				// Agregar el contenido al elemento con id cardSalidas
				document.getElementById("cardSalidas").innerHTML = salidasHtml;
			} else {
				// Manejar errores si es necesario
				console
						.error("Error al obtener salidas de la actividad.");
			}
		}
	};
	// Enviar el ID de la actividad al servidor
	xhr.send("idActividad=" + idActividad);
}



</script>
</body>
</html>

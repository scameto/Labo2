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
					<h1 class="tituloVentana">Consulta Actividades</h1>
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
						<ul id="categorias" name="categoria">

							<%
							List<DataCategoria> categorias = (List<DataCategoria>)request.getAttribute("categoria");
							if (categorias != null) {
								for (DataCategoria cat : categorias) {
							%>
							<li class="list-group-item"
								onclick="seleccionarCategoria('<%=cat%>')"><%=cat%></li>
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
#cajaDepartamentos {
	max-height: 40vh;
	overflow-y: auto;
}

#cajaCategorias {
	max-height: 40vh;
	overflow-y: auto;
}

#cardActividades {
	overflow-y: auto;
	max-height: 30vh;
}

#cardSalidas {
	overflow-y: auto;
	max-height: 30vh;
}
</style>
			<div class="col-lg-9">
				<section
					style="background-color: rgba(238, 238, 238, 0.5); margin-top: 10vh;"
					id="datosTurista">
					<div class="container py-5">
						<div class="row">
							<div class="col-lg-4">
								<div class="card mb-4">
									<div class="card-body text-center">
										<img
											src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp"
											alt="avatar" class="rounded-circle img-fluid"
											style="width: 150px;">
										<h5 class="my-3" id="usernameUsuarioTitle"></h5>
										<p class="text-muted mb-4" id="divTipoUsuario">...</p>
										<div class="d-flex justify-content-center mb-2">
											<button type="button" class="btn btn-primary">Follow</button>
											<button type="button" class="btn btn-outline-primary ms-1">Message</button>
										</div>
									</div>
								</div>
								<div class="card mb-4 mb-lg-0">
									<div class="card-body p-0">
										<ul class="list-group list-group-flush rounded-3">
											<li
												class="list-group-item d-flex justify-content-between align-items-center p-3">
												<p class="mb-0">https://mdbootstrap.com</p>
											</li>
											<li
												class="list-group-item d-flex justify-content-between align-items-center p-3">
												<p class="mb-0">mdbootstrap</p>
											</li>
											<li
												class="list-group-item d-flex justify-content-between align-items-center p-3">
												<p class="mb-0">@mdbootstrap</p>
											</li>
											<li
												class="list-group-item d-flex justify-content-between align-items-center p-3">
												<p class="mb-0">mdbootstrap</p>
											</li>
											<li
												class="list-group-item d-flex justify-content-between align-items-center p-3">
												<p class="mb-0">mdbootstrap</p>
											</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="col-lg-8">
								<div class="card mb-4">
									<div class="card-body">
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Nombre del Turista</p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="nombreUsuario"></p>
											</div>

										</div>
										<hr>
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Email</p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="emailUsuario"></p>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Fecha de Nacimiento</p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="fechaNacUsuario"></p>
											</div>
										</div>
										<hr style="display: none;" id="hrNacionalidad">
										<div class="row" style="display: none;"
											id="nacionalidadTuristaRow">
											<div class="col-sm-3">
												<p class="mb-0">Nacionalidad</p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="nacionalidadUsuario"></p>
											</div>
										</div>
										<hr style="display: none;" id="descProveedorHr">
										<div class="row" style="display: none;" id="descProveedorRow">

											<div class="col-sm-3">
												<p class="mb-0">Descripcion</p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="descProveedor"></p>
											</div>
										</div>
										<hr style="display: none;" id="linkWebProveedorHr">
										<div class="row" style="display: none;"
											id="linkWebProveedorRow">

											<div class="col-sm-3">
												<p class="mb-0">Link a la web</p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="linkWebProveedor"></p>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="card mb-4 mb-md-0">
											<div class="card-body" id="cardActividades"></div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="card mb-4 mb-md-0">
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
			console.log("llegue no se q ...");
			// Configurar la solicitud
			xhr.open('POST', 'http://localhost:8080/Labo2/consultaActividad?idDepto=' // esto es una queryparam
					+ idDepartamento, true);
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
												+ ")'>"
												+ "<h4 style='cursor: pointer;'>"
												+ actividad.nomAct
												+ "</h4>"
												+ "<hr>"
												+ "<p>"
												+ actividad.descripcion
												+ "</p>"
												+ "<hr>"
												+ "<p>"
												+ actividad.duracion
												+ " horas</p>"
												+ "<hr>"
												+ "<p>$"
												+ actividad.costo
												+ "</p>" + "<hr>" + "</div>";
									});
						} else {
							actividadesHtml += "<div class='actividad'>"
									+ "<p>"
									+ "Este proveedor no tiene actividades activas."
									+ "</p>" + "</div>";
						}

						document.getElementById("cardActividades").innerHTML = actividadesHtml;
					}
				}
			};
			// Enviar la solicitud
			xhr.send();
		}

		function seleccionarUsuario(username) {
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/consultaActividad2", true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					// Analizar la respuesta JSON del servidor
					if (JSON.parse(xhr.responseText) != null) {
						var usuario = JSON.parse(xhr.responseText);
						if (usuario != null) {
							document.getElementById("nombreUsuario").textContent = usuario.nombre;
							document.getElementById("emailUsuario").textContent = usuario.email;
							document.getElementById("fechaNacUsuario").textContent = usuario.fechaNac;
							if (usuario.nacionalidad != null) {
								//Ocultar lo de proveedores
								document.getElementById("descProveedorHr").style.display = "none";
								document.getElementById("descProveedorRow").style.display = "none";
								document.getElementById("linkWebProveedorHr").style.display = "none";
								document.getElementById("linkWebProveedorRow").style.display = "none";
								document.getElementById("divTipoUsuario").textContent = "Turista";
								document.getElementById("nacionalidadUsuario").textContent = usuario.nacionalidad
								document.getElementById("hrNacionalidad").style.display = "block";
								document
										.getElementById("nacionalidadTuristaRow").style.display = "flex";

							} else {
								//Ocultar lo de turista
								document.getElementById("hrNacionalidad").style.display = "none";
								document
										.getElementById("nacionalidadTuristaRow").style.display = "none";
								document.getElementById("divTipoUsuario").textContent = "Proveedor";
								document.getElementById("descProveedorHr").style.display = "block";
								document.getElementById("descProveedorRow").style.display = "flex";
								document.getElementById("linkWebProveedorHr").style.display = "block";
								document.getElementById("linkWebProveedorRow").style.display = "flex";
								document.querySelector('.container').classList
										.add('mostrarProveedor');
								document.getElementById("descProveedor").textContent = usuario.desc;
								document.getElementById("linkWebProveedor").textContent = usuario.linkWeb;
								consultarActividadesProveedor(username);
								//consultarActividadesProveedor(username);
							}
							document.getElementById("usernameUsuarioTitle").textContent = usuario.username;
						}
					}
				}
			};
			xhr.send("username=" + username);
		}//funcion de prueba------------------------------------------------------------------------------------------
		/*
// 		function seleccionarCategorias() {
// 			var categorias =
<%-- 			<%=request.getAttribute("categoria")%> --%>
// 		; // Obtener las categorías del backend
// 			var selectCategoria = document.getElementById("selectCategoria");

// 			// Llenar el select con las categorías
// 			categorias.forEach(function(categoria) {
// 				var option = document.createElement("option");
// 				option.value = categoria.id; // Suponiendo que tu objeto DataCategoria tiene un campo 'id'
// 				option.textContent = categoria.nombre; // Suponiendo que tu objeto DataCategoria tiene un campo 'nombre'
// 				selectCategoria.appendChild(option);
// 			});
// 		}

// 		window.onload = function() {
// 			cargarCategorias();
// 		}*/
		//----------------------------------------------------------------------------------------------------------------
		function consultarActividadesProveedor(usernameProv) {
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/consultaActividad",
					true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					// Analizar la respuesta JSON del servidor
					if (JSON.parse(xhr.responseText) != null) {
						var actividades = JSON.parse(xhr.responseText);
						var actividadesHtml = "";

						// Construir el contenido HTML de las actividades
						if (actividades.length != 0) {
							actividades
									.forEach(function(actividad) {
										actividadesHtml += "<div class='actividad' onclick='buscarSalidas("
												+ actividad.id
												+ ")'>"
												+ "<h4 style='cursor: pointer;'>"
												+ actividad.nomAct
												+ "</h4>"
												+ "<hr>"
												+ "<p>"
												+ actividad.descripcion
												+ "</p>"
												+ "<hr>"
												+ "<p>"
												+ actividad.duracion
												+ " horas</p>"
												+ "<hr>"
												+ "<p>$"
												+ actividad.costo
												+ "</p>" + "<hr>" + "</div>";
									});
						} else {
							actividadesHtml += "<div class='actividad'>"
									+ "<p>"
									+ "Este proveedor no tiene actividades activas."
									+ "</p>" + "</div>";
						}

						document.getElementById("cardActividades").innerHTML = actividadesHtml;
					}
				}
			};
			xhr.send("usernameProv=" + usernameProv);
		}

		function buscarSalidas(actividadId) {
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/consultaActividad",
					true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						var salidas = JSON.parse(xhr.responseText);
						// Construir el contenido HTML de las salidas
						var salidasHtml = "";
						if (salidas.length > 0) {
							salidas
									.forEach(function(salida) {
										salidasHtml += "<div class='salida'>";
										salidasHtml += "<h4>" + salida.nombre
												+ "</h4>";
										salidasHtml += "<hr>";
										salidasHtml += "<p>Cantidad Máxima: "
												+ salida.cantMax + "</p>";
										salidasHtml += "<p>Cantidad Actual: "
												+ salida.cantActual + "</p>";
										salidasHtml += "<p>Fecha de Alta: "
												+ salida.fechaAlta + "</p>";
										salidasHtml += "<p>Fecha de Salida: "
												+ salida.fechaSalida + "</p>";
										salidasHtml += "<p>Hora de Salida: "
												+ salida.horaSalida + "</p>";
										salidasHtml += "<p>Lugar de Salida: "
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
			xhr.send("idActividad=" + actividadId);
		}
	</script>
</body>
</html>

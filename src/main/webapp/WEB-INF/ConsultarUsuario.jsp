<%@page import="java.util.List"%>
<%@page import="logica.datatypes.DataTurista"%>
<%@page import="logica.datatypes.DataProveedor"%>
<%@page import="com.labo2.model.EstadoSesion"%>

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
					<h1 class="tituloVentana">Consultar Usuarios</h1>
					<div id="tuvieja">
						<h2>Turistas:</h2>
						<div id="listaUsuarios">
							<ul class="list-group">
								<%
								List<String> usernames = (List<String>) request.getAttribute("usernames");
								if (usernames != null) {
									for (String username : usernames) {
								%>
								<li class="list-group-item"
									onclick="seleccionarUsuario('<%=username%>')"><%=username%></li>
								<%
								}
								}
								%>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<style>
#tuvieja {
	max-height: 80vh;
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

#cardPaquetes {
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
										<div class="d-flex justify-content-center mb-2"
											style="display: none";>
											<button type="button" class="btn btn-primary" id="btneditarPerfil"
												data-toggle="modal" data-target="#miModal"
												style="display: none;">Editar Perfil</button>



										</div>
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
												<p class="mb-0">Apellido</p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="apellidoUsuario"></p>
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

										<div class="card mb-4 mb-lg-0" id="contenedorPaquetesUsuario"
											style="display: none;">
											<div class="card-body" id="cardPaquetes"></div>
										</div>

										<div class="card mb-4 mb-md-0" id="contenedorActividades"
											style="display: none;">
											<div class="card-body" id="cardActividades"></div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="card mb-4 mb-md-0" id="contenedorSalidas"
											style="display: none;">
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

	<div class="modal fade" id="miModal" tabindex="-1" role="dialog"
		aria-labelledby="miModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="miModalLabel">Título del Modal</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="miModalForm">
					<div class="mb-3">
							<label for="campo0" class="form-label">Username</label> <input
								type="text" class="form-control" id="username"
								placeholder="Username" readonly> 
						</div>
						<div class="mb-3">
							<label for="campo1" class="form-label">Nombre</label> <input
								type="text" class="form-control" id="nombre"
								placeholder="Nombre">
						</div>
						<div class="mb-3">
							<label for="campo2" class="form-label">Apellido</label> <input
								type="text" class="form-control" id="apellido"
								placeholder="Apellido">
						</div>
						<div class="mb-3">
							<label for="fechaNacimiento" class="form-label">Fecha de
								Nacimiento</label> <input type="date" class="form-control"
								id="fechaNacimiento">
						</div>
						<div class="mb-3">
							<label for="email" class="form-label">Email</label> <input
								type="email" class="form-control" id="email"
								placeholder="Correo electrónico" readonly>
						</div>
						<div class="mb-3">
							<label for="nacionalidad" class="form-label">Nacionalidad</label>
							<input type="text" class="form-control" id="nacionalidad"
								placeholder="Nacionalidad">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cerrar</button>
					<button type="button" class="btn btn-primary" onclick="editar()">Guardar
						Cambios</button>
				</div>
			</div>
		</div>
	</div>

	<script>

	function cargarModal() {
	    // Obtener los valores de los campos del usuario seleccionado
	    var username = document.getElementById("usernameUsuarioTitle").textContent;
	    var nombre = document.getElementById("nombreUsuario").textContent;
	    var apellido = document.getElementById("apellidoUsuario").textContent; // Agrega un ID a tu elemento de apellido
	    var fechaNacimiento = document.getElementById("fechaNacUsuario").textContent;
	    var email = document.getElementById("emailUsuario").textContent;

	    // Asignar los valores a los elementos del formulario modal
	    document.getElementById("username").value = username;
	    document.getElementById("nombre").value = "test";
	    document.getElementById("apellido").value = apellido;
	    document.getElementById("fechaNacimiento").value = fechaNacimiento;
	    document.getElementById("email").value = email;
	}

	
function editar() {
	//Rellenar los campos
	
	
	//Tomar los valores
	var username = document.getElementById("usernameUsuarioTitle").textContent;
    var nombre = document.getElementById("nombre").value;
    var apellido = document.getElementById("apellido").value;
    var fechaNacimiento = document.getElementById("fechaNacimiento").value;
    var email = document.getElementById("emailUsuario").textContent;
    
    <%
    DataTurista turista = (DataTurista) session.getAttribute("usuario_logueado");
    String password = turista.getPassword();
    %>
    
    var password = "<%= password %>";
    var nacionalidad = document.getElementById("nacionalidad").value;

    var datos = {
    	username: username,
        nombre: nombre,
        apellido: apellido,
        password: password,
        nacionalidad: nacionalidad,
        fechaNacimiento: fechaNacimiento,
        email: email
    };

    var datosJSON = JSON.stringify(datos);
	
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/ConsultarUsuario",
					true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					// Analizar la respuesta JSON del servidor
					if (JSON.parse(xhr.responseText) != null) {
					}
				}
			};
			console.log(datosJSON);
			xhr.send("editarXD=" + "Turista" + "&datos=" + datosJSON);
		}

		function seleccionarUsuario(username) {
			document.getElementById("contenedorSalidas").style.display = "none";
			document.getElementById("contenedorPaquetesUsuario").style.display = "none";
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/ConsultarUsuario",true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					// Analizar la respuesta JSON del servidor
					if (JSON.parse(xhr.responseText) != null) {
						var usuario = JSON.parse(xhr.responseText);
						if (usuario != null) {
							document.getElementById("usernameUsuarioTitle").textContent = username;
							document.getElementById("nombreUsuario").textContent = usuario.nombre;
							document.getElementById("emailUsuario").textContent = usuario.email;
							document.getElementById("fechaNacUsuario").textContent = usuario.fechaNac;
							document.getElementById("apellidoUsuario").textContent = usuario.apellido;
							
							if (usuario.nacionalidad != null) {
								//Aca es turista
								document
										.getElementById("contenedorActividades").style.display = "none";
								buscarSalidasTurista(username);

								document.getElementById("descProveedorHr").style.display = "none";
								document.getElementById("descProveedorRow").style.display = "none";
								document.getElementById("linkWebProveedorHr").style.display = "none";
								document.getElementById("linkWebProveedorRow").style.display = "none";
								document.getElementById("contenedorPaquetesUsuario").style.display = "none";
								document.getElementById("divTipoUsuario").textContent = "Turista";
								document.getElementById("nacionalidadUsuario").textContent = usuario.nacionalidad
								document.getElementById("hrNacionalidad").style.display = "block";
								document
										.getElementById("nacionalidadTuristaRow").style.display = "flex";
								
								var estadoSesion = obtenerEstadoSesion();
								var usuarioLogueado = getUsuarioActual();
								if(estadoSesion.includes("LOGIN") && usuarioLogueado.includes(username)){
									traerPaquetesComprados(username);
									document.getElementById("btneditarPerfil").style.display = "block"
									cargarModal();
								}
				
							} else {
								//Aca es proveedor
								document
										.getElementById("contenedorActividades").style.display = "block";
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
								
								var estadoSesion = obtenerEstadoSesion();
								var usuarioLogueado = getUsuarioActual();
								if(estadoSesion.includes("LOGIN") && usuarioLogueado.includes(username)){
									consultarActividadesProveedorTodas(username);
									console.log("ando aca");
								}else{
									consultarActividadesProveedor(username);
								}
								
								
							}
						}
					}
				}
			};
			xhr.send("username=" + username);
		}
		
		function soyYo(username){
			var estadoSesion = obtenerEstadoSesion();
			var usuarioLogueado = getUsuarioActual();
			
			console.log(usuarioLogueado);
		    if (estadoSesion.includes("LOGIN") && usuarioLogueado.includes(username)) {
		        return true;
		    }
		    return false;
		}
		
		function obtenerEstadoSesion() {
		    var estadoSesion = "<%=(EstadoSesion) session.getAttribute("estado_sesion")%>";
		    return estadoSesion;
		}

		function getUsuarioActual() {
		    <%EstadoSesion estadoSesion = (EstadoSesion) session.getAttribute("estado_sesion");
Object usuarioLogueado = session.getAttribute("usuario_logueado");
if (usuarioLogueado instanceof DataTurista) {%>
		    var turistaActual = "<%=(DataTurista) session.getAttribute("usuario_logueado")%>";
		    return turistaActual;
		    <%} else if (usuarioLogueado instanceof DataProveedor) {%>
		    var proveedorActual = "<%=(DataProveedor) session.getAttribute("usuario_logueado")%>
		";
			return proveedorActual;
	<%} else {%>
		console.log("Sos un invitado");
			return null;
	<%}%>
		}

		// Llama a la función cuando la página se carga
		window.onload = function() {
			getUsuarioActual();
		};

		function consultarActividadesProveedor(usernameProv) {
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/ConsultarUsuario",
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

		function consultarActividadesProveedorTodas(username) {
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/ConsultarUsuario",
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
												+ actividad.estado
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
			xhr.send("usernameProvTodo=" + username);
		}

		function buscarSalidasTurista(username) {
			document.getElementById("contenedorSalidas").style.display = "block";
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/ConsultarUsuario",
					true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					if (JSON.parse(xhr.responseText) != null) {
						var salidasTurista = JSON.parse(xhr.responseText);
						var salidasHtml = "";

						if (salidasTurista.length > 0) {
							salidasTurista
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
							salidasHtml += "<div class='actividad'>"
									+ "<p>"
									+ "Este turista no se ha inscripto a ninguna salida, Que tacaño!."
									+ "</p>" + "</div>";
						}
						document.getElementById("cardSalidas").innerHTML = salidasHtml;

					}
				}
			};
			xhr.send("usernameTuristaSalidas=" + username);

		}

		function traerPaquetesComprados(username) {
			document.getElementById("contenedorPaquetesUsuario").style.display = "flex";
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/ConsultarUsuario",
					true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					if (JSON.parse(xhr.responseText) != null) {
						var paquetes = JSON.parse(xhr.responseText);
						var paquetesHtml = "";

						// Construir el contenido HTML de los paquetes
						if (paquetes.length != 0) {
							paquetes.forEach(function(paquete) {
								paquetesHtml += "<div class='paquete'>";
								paquetesHtml += "<h4>" + paquete.nombre
										+ "</h4>";
								paquetesHtml += "<hr>";
								paquetesHtml += "<p>Descripción: "
										+ paquete.descripcion + "</p>";
								paquetesHtml += "<p>Validez: "
										+ paquete.validez + " días</p>";
								paquetesHtml += "<p>Descuento: "
										+ paquete.descuento + "%</p>";
								paquetesHtml += "<p>Fecha de Alta: "
										+ paquete.fechaAlta + "</p>";
								paquetesHtml += "</div>";
							});
						} else {
							paquetesHtml += "<p>No hay paquetes comprados por este turista.</p>";
						}

						// Agregar el contenido al elemento con id cardPaquetes
						document.getElementById("cardPaquetes").innerHTML = paquetesHtml;
					}
				}
			};
			// Enviar el nombre de usuario al servidor para obtener los paquetes
			xhr.send("usernamePaquetes=" + username);
		}

		function buscarSalidas(actividadId) {
			document.getElementById("contenedorSalidas").style.display = "block";
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "http://localhost:8080/Labo2/ConsultarUsuario",
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

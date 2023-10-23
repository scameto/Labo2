<%@page import="java.util.List"%>
<%@page import="logica.datatypes.DataTurista"%>
<%@page import="logica.datatypes.DataProveedor"%>
<%@page import="logica.datatypes.DataPaquete"%>
<%@page import="com.labo2.model.EstadoSesion"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<style>
#listaPaquetes {
	max-height: 80vh;
	overflow-y: auto;
}

</style>
<title>Comprar paquetes</title>
</head>
<body>
	<jsp:include page="/WEB-INF/templates/header.jsp" />
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-3">
				<div>
					<h1 class="tituloVentana">Comprar Paquetess</h1>
						<div id="listaPaquetes" style="max-height: 70vh; overflow-y: auto;">
   							 <h2>Paquetes:</h2>
    							<div id="listaPaquetesDisponibles">

   						 		</div>
							</div>
				</div>
			</div>
			<div class="col-lg-9">
			
				<section
					style="background-color: rgba(238, 238, 238, 0.5); margin-top: 10vh;"
					id="datosTurista">
					<div class="container py-5">
						<div class="row">
							<div class="col-lg-12">
								<div class="card mb-4">
									<div class="card-body">
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Nombre del Paquete: </p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="nombrePaquete"></p>
											</div>

										</div>
										<hr>
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Descripcion: </p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="descPaquete"></p>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Validez: </p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="validezPaquete"></p>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Fecha de alta: </p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="fechaAltaPaquete"></p>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="card mb-4 mb-md-0" id="contenedorActividades"
											style="display: none;">
											<div class="card-body" id="cardActividades"></div>
										</div>
									</div>
								</div>
							</div>
							<button></button>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>
	<script>
	
	function listarPaquetes() {
	    var xhr = new XMLHttpRequest();
	    xhr.open("POST", "http://localhost:8080/Labo2/CompraPaquete");
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState == 4 && xhr.status == 200) {
	            var paquetes = JSON.parse(xhr.responseText);
	            var listaPaquetesDisponibles = document.getElementById("listaPaquetesDisponibles");

	            // Limpiar la lista antes de agregar nuevos elementos
	            listaPaquetesDisponibles.innerHTML = '';

	            paquetes.forEach(function(paquete) {
	                var card = document.createElement("div");
	                card.classList.add("card", "mb-4");
	                card.style.cursor = "pointer";
	                card.addEventListener("click", function() {
	                    mostrarDetallesPaquete(paquete);
	                });

	                var cardBody = document.createElement("div");
	                cardBody.classList.add("card-body");

	                var cardTitle = document.createElement("h5");
	                cardTitle.classList.add("card-title");
	                cardTitle.textContent = paquete.nombre;

	                cardBody.appendChild(cardTitle);
	                card.appendChild(cardBody);
	                listaPaquetesDisponibles.appendChild(card);
	            });
	        }
	    };
	    xhr.send();
	}


	function mostrarDetallesPaquete(paquete) {
	    // Lógica para mostrar los detalles del paquete seleccionado en la sección correspondiente
	    var nombrePaquete = document.getElementById("nombrePaquete");
	    var descPaquete = document.getElementById("descPaquete");
	    var validezPaquete = document.getElementById("validezPaquete");
	    var fechaAltaPaquete = document.getElementById("fechaAltaPaquete");
	    var contenedorActividades = document.getElementById("contenedorActividades");
	    var cardActividades = document.getElementById("cardActividades");

	    nombrePaquete.textContent = paquete.nombre;
	    descPaquete.textContent = paquete.descripcion;
	    validezPaquete.textContent = paquete.validez;
	    fechaAltaPaquete.textContent = paquete.fechaAlta;

	    // Lógica para mostrar actividades asociadas al paquete si las hay
	    if (paquete.actividades.length > 0) {
	        contenedorActividades.style.display = "block";
	        cardActividades.innerHTML = ''; // Limpiar las actividades anteriores

	        paquete.actividades.forEach(function(actividad) {
	            var actividadElement = document.createElement("div");
	            actividadElement.textContent = actividad.nomAct;
	            cardActividades.appendChild(actividadElement);
	        });
	    } else {
	        // Si no hay actividades, ocultar la sección de actividades
	        contenedorActividades.style.display = "none";
	    }
	}

	window.onload = function() {
	    listarPaquetes();
	};

	
	</script>
</body>
</html>

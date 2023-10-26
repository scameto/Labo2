<%@page import="java.util.List"%>
<%@page import="logica.datatypes.DataTurista"%>
<%@page import="logica.datatypes.DataProveedor"%>
<%@page import="logica.datatypes.DataPaquete"%>
<%@page import="logica.datatypes.DataActividad"%>
<%@page import="com.labo2.model.EstadoSesion"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<%
			HttpSession sesion = request.getSession();
			EstadoSesion estado = (EstadoSesion) sesion.getAttribute("estado_sesion");
			Object usuarioLogueado = sesion.getAttribute("usuario_logueado");

			if(!(estado != null && usuarioLogueado instanceof DataTurista)){
				response.sendRedirect(request.getContextPath()+ "/iniciar");
				return;
			}

	        String username = ((DataTurista)usuarioLogueado).getUsername();
	        %> 

<% List<DataActividad> actividades; %>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<style>
#listaPaquetes {
	max-height: 80vh;
	overflow-y: auto;
}

#rowTotal {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
}

#contenedorPrecio {
    text-align: left; 
}

#contenedorBoton {
    text-align: right; /
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
								<div class="card mb-8">
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
												<p class="text-muted mb-0" id="descripcionPaquete"></p>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Validez en dias: </p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="validezPaquete"></p>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Fecha de alta (mm/dd/aaaa): </p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="fechaAltaPaquete"></p>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-sm-3">
												<p class="mb-0">Porcentaje de descuento: </p>
											</div>
											<div class="col-sm-9">
												<p class="text-muted mb-0" id="descuentoPaquete"></p>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-sm-6">
												<input type="number" style= "width: 60%;" id="numeroInput" placeholder="Numero de inscripciones">
												<button onclick="consultarPrecio()">Consultar</button>
											</div>
										</div>
										<hr>
<div class="row" id="rowTotal" style="display: none;">
    <div class="col-sm-6" id="contenedorPrecio">
        <p>Precio Final: <span id="precioFinal">0</span></p>
    </div>
    <div class="col-sm-6" id="contenedorBoton">
        <button id="btnComprar" onclick="confirmarCompra()">Comprar</button>
    </div>
</div>

									</div>
								</div>
								<div class="row">
									<div class="col-md-6" id="contenedorActividades"
											style="display: none;">
									<h4>Actividades del paquete:</h4>
										<div class="card mb-4 mb-md-0">
											
											<div class="card-body" id="cardActividades"></div>
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
	
	var actividadesPaq;
	var idPaquete;
	var costoTotal;
	var cantTuristas;
	
	function listarPaquetes() {
	    var xhr = new XMLHttpRequest();
	    xhr.open("POST", "http://localhost:8080/Labo2/CompraPaquete");
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState == 4 && xhr.status == 200) {
	            var paquetes = JSON.parse(xhr.responseText);
	            var listaPaquetesDisponibles = document.getElementById("listaPaquetesDisponibles");
				console.log(paquetes);
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
		
	    document.getElementById("rowTotal").style.display = "none";
	    document.getElementById("numeroInput").value = "";
		
	    var nombrePaquete = document.getElementById("nombrePaquete");
	    var descripcionPaquete = document.getElementById("descripcionPaquete");
	    var validezPaquete = document.getElementById("validezPaquete");
	    var fechaAltaPaquete = document.getElementById("fechaAltaPaquete");
	    var descuentoPaquete = document.getElementById("descuentoPaquete");
	    var contenedorActividades = document.getElementById("contenedorActividades");
	    var cardActividades = document.getElementById("cardActividades");
		
	    var fechaAlta = new Date(paquete.fechaAlta);
	    var fechaAltaFormateada = fechaAlta.toLocaleDateString();
	    
	    nombrePaquete.textContent = paquete.nombre;
	    descripcionPaquete.textContent = paquete.descripcion;
	    validezPaquete.textContent = paquete.validez;
	    fechaAltaPaquete.textContent = fechaAltaFormateada;
	    descuentoPaquete.textContent = paquete.descuento + " %";
	    
		console.log(paquete.actividades);
	    contenedorActividades.style.display = "block";
	    cardActividades.innerHTML = ''; 
	    paquete.actividades.forEach(function(actividad) {
            var actividadElement = document.createElement("div");
            actividadElement.textContent = actividad.nomAct;
            cardActividades.appendChild(actividadElement);
        });
	    actividadesPaq = paquete.actividades;
	    idPaquete = paquete.id;
	}

	window.onload = function() {
	    listarPaquetes();
	};

	function consultarPrecio() {
	    var numero = parseInt(document.getElementById("numeroInput").value);
	    if (!isNaN(numero)) {
	        document.getElementById("rowTotal").style.display = "flex";
	        document.getElementById("precioFinal").textContent = precioFinal;
	        calcularPrecioTotal(numero);
	    } else {
	        alert("Por favor, ingrese un número válido.");
	    }
	}

	function calcularPrecioTotal(numeroInscripciones) {
	    var total = 0;
	    var actividades = actividadesPaq;
	    cantTuristas = numeroInscripciones;
	    actividades.forEach(function(actividad) {
	        total += numeroInscripciones * actividad.costo;
	        console.log(total);
	    });
	    var descuento = parseInt(document.getElementById("descuentoPaquete").textContent);
	    var descuentoDecimal = descuento / 100;
	    var totalConDescuento = total * (1 - descuentoDecimal);
	    costoTotal = totalConDescuento;
	    document.getElementById("rowTotal").style.display = "flex";
	    document.getElementById("precioFinal").textContent = totalConDescuento + " $";
	}

	function confirmarCompra() {
		 
		var idPaq = idPaquete
		cantTuristas = cantTuristas;
		var username = "<%= username %>"
		 
		console.log(idPaquete);
		console.log(cantTuristas);
		console.log(costoTotal);
		console.log(username);

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "http://localhost:8080/Labo2/CompraPaquete", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
            	alert("¡Compra confirmada! Gracias por tu compra.");
            	window.location.reload();
            }
        };
        xhr.send("idPaquete=" + idPaq + "&username=" + username + "&cantTuristas=" + cantTuristas + "&costoTotal=" + costoTotal);
	}

	</script>
</body>
</html>

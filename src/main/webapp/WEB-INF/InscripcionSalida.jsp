<%@page import="com.labo2.model.EstadoSesion"%>
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
					<!--                     ACA CHEQUEAMOS QUE EL USUARIO ESTE LOGUEADO PARA PERMITIR EL ACCESO -->
					<%
					    HttpSession sesion = request.getSession();
					    EstadoSesion estadoSesion = (EstadoSesion) sesion.getAttribute("estado_sesion");
					    Object usuarioLogueado = sesion.getAttribute("usuario_logueado");
					
					    if (!(estadoSesion != null && usuarioLogueado instanceof DataTurista)) {
					        response.sendRedirect(request.getContextPath() + "/iniciar");  
					        return;
					    }
					%>
<!--                     ------------------------------------------------------------------------------- -->
                    
                    
                    <% 
					    String mensajeError = (String) session.getAttribute("mensajeError"); 
					    if(mensajeError != null) {
					%>
					    <div class="alert alert-danger">
					        <%= mensajeError %>
					    </div>
					<%
					    session.removeAttribute("mensajeError");
					}
					    String mensajeExito = (String) session.getAttribute("mensajeExito"); 
					    if(mensajeExito != null) {
					    %>
					        <div class="alert alert-success">
					            <%= mensajeExito %>
					        </div>
					    <%
					        session.removeAttribute("mensajeExito");
					    }
					%>
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
<!-- 									<form action="InscripcionSalida" method="post"> -->
										<div class="card row-md-8">
											 <div class="form-group">
				                                <label for="cantTuristasInsc">Cant. de turistas a inscribir:</label>
				                                <input type="number" class="form-control" id="cantTur">
				                            </div>    
				                            <div class="form-group">
				                                <label for="formaDePago">Forma de pago:</label>
				                                <select class="form-control" id="cbFormaDePago" onchange="mostraOcultarPaquetes(this.value)">
				                                    <option value="general">General</option>
				                                    <option value="porPaquete">Por Paquete</option>
				                                    				                                
				                                </select>
				                                <div id="contenedorPaquete" style="display: none">
				                                <label for="formaDePago">Paquetes disponibles:</label>				                                
				                                 <Select id="paquetesSelect" name="paquetesSelect" class="form-control">							
												</Select>
												</div>
												<hr>
												<div id="contenedorSalidaSeleccionada" style="display: none">
				                                <label for="formaDePago">Salida seleccionada:</label>
				                             	<p id="salidaSeleccionadaText"></p>                   
												</div>
												<div class="col-lg-12 offset-lg-9">
						                            <button onclick="Inscribir()" value="Inscribir" class="btn btn-primary offset-sm-1" >Inscribir</button>
						                        </div>
				                            </div>	
				                        </div>
<!-- 									</form> -->
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
	var actividadSelected;
	var salidaSelected;
function seleccionarDepartamento(idDepartamento) {
	var xhr = new XMLHttpRequest();	
	document.getElementById("contenedorInscripcion").style.display = "none";
	document.getElementById("contenedorSalidas").style.display = "none";
	
	console.log("llegue no se q ...");
	xhr.open('POST', 'http://localhost:8080/Labo2/consultaActividad?idDepto=' // esto es una queryparam
			+ idDepartamento, true);
	xhr.setRequestHeader('Content-Type', 'application/json');
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			if (JSON.parse(xhr.responseText) != null) {
				var actividades = JSON.parse(xhr.responseText);
				var actividadesHtml = "";
				if (actividades.length != 0) {
					actividades
							.forEach(function(actividad) {
								
									actividadesHtml += "<div class='actividad' onclick='buscarSalidas(" 
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
							        actividadesHtml += "</div>";
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
	var xhr = new XMLHttpRequest();
	document.getElementById("contenedorInscripcion").style.display = "none";
	document.getElementById("contenedorSalidas").style.display = "none";
	console.log("llegue no se q ...");
	xhr.open('POST', 'http://localhost:8080/Labo2/consultaActividad?idCateg=' // esto es una queryparam
			+ idCategoria, true);
	xhr.setRequestHeader('Content-Type', 'application/json');

	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			if (JSON.parse(xhr.responseText) != null) {
				var actividades = JSON.parse(xhr.responseText);
				var actividadesHtml = "";

				if (actividades.length != 0) {
					actividades
							.forEach(function(actividad) {
								
									actividadesHtml += "<div class='actividad' onclick='buscarSalidas(" 
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
							        actividadesHtml += "</div>";
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
	xhr.send();
}
function buscarPaquetes(idActividad, cantTur) { // esta funcion muesta las salidas asociadas a una actividad
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "http://localhost:8080/Labo2/ListarPaquetesDisponiblesTurista?idActiv=" 
			+ idActividad + "&cantTur=" + cantTur,	true);
	xhr.setRequestHeader("Content-Type",
			"application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				var paquetes = JSON.parse(xhr.responseText);
				console.log(paquetes);
				var paquetesHtml = "";
				if (paquetes.length > 0) {
					paquetes.forEach(function(paquete) {
								paquetesHtml += "<option value='" + paquete.id + "'>";
								paquetesHtml += "<h4>" + paquete.nombre
										+ "</h4>";
										paquetesHtml += "</option>";									
							});
				} else {
					paquetesHtml += "<option disabled> No hay Paquetes disponibles para esta Actividad y cantidad de Turistas.</option>";
				}
				document.getElementById("paquetesSelect").innerHTML = paquetesHtml;
			} else {
				console.error("Error al obtener Paquetes de la actividad.");
			}
		}
	};
	xhr.send("idActividad=" + idActividad);
}
function buscarSalidas(idActividad) { // esta funcion muesta las salidas asociadas a una actividad
	actividadSelected = idActividad;
	salidaSelected = undefined;
	document.getElementById("contenedorSalidas").style.display = "block";
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "http://localhost:8080/Labo2/consultaActividad?idActiv=" + idActividad, true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				var salidas = JSON.parse(xhr.responseText);
				var salidasHtml = "";
				if (salidas.length > 0) {
					salidas.forEach(function(salida) {
						
						//document.getElementById("contenedorSalidaSeleccionada").style.display = "none";
// 						onclick='buscarSalidas(
								salidasHtml += "<div class='salida' onclick=\"setearSalida('" + salida.nombre + "')\">";					
								
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
				document.getElementById("cardSalidas").innerHTML = salidasHtml;
			} else {
				console.error("Error al obtener salidas de la actividad.");
			}
		}
	};
	xhr.send("idActividad=" + idActividad);
	document.getElementById("contenedorInscripcion").style.display = "block";
}

function setearSalida(nombreSalida){
	salidaSelected = nombreSalida;
	document.getElementById("contenedorSalidaSeleccionada").style.display = "block";
	document.getElementById("salidaSeleccionadaText").textContent = nombreSalida;
}

function mostraOcultarPaquetes(formaDePago){
	if(formaDePago == "general"){
		document.getElementById("contenedorPaquete").style.display = "none";		
	}else{
		document.getElementById("contenedorPaquete").style.display = "block";
		buscarPaquetes(actividadSelected, parseInt(document.getElementById("cantTur").value));
	}	
}
function Inscribir(){	
	console.log("toy aca en inscribir");
	var cantTur = document.getElementById("cantTur").value;
	var formaPago = document.getElementById("cbFormaDePago").value;
	var paqueteSeleccionado = document.getElementById("paquetesSelect").value;	
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "http://localhost:8080/Labo2/InscripcionSalida?cantTur=" + cantTur + "&formaPago=" + formaPago + "&paquete=" + paqueteSeleccionado + "&salida=" + salidaSelected , true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				document.open();
				document.write(xhr.responseText);
				document.close();
			}			
		}	
	}
	xhr.send();

}
</script>
</body>
</html>

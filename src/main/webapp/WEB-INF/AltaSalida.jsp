<%@page import="logica.datatypes.DataActividad"%>
<%@page import="logica.datatypes.DataCategoria"%>
<%@page import="java.util.List"%>
<%@page import="logica.modelos.Departamento"%>
<%@page import="logica.datatypes.DataDepartamento"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/templates/head.jsp" />
<title>Alta Salida</title>
</head>
<body>
<jsp:include page="/WEB-INF/templates/header.jsp" />
<div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">                
				<form onsubmit="return validateForm()" action="AltaSalida" method="post">           				
					<div>
                    <h1 class="tituloVentana">Alta Salida</h1>
                    </div>
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
                  	
					<div class="row mb-2">	
					<label for="inputNombreAct" class="col-sm-2 col-form-label">Departamento</label>									
					 <Select id="departamentoSelect" name="departamentoSelect" class="form-control col-sm-8" onchange="seleccionarDepartamento(this.value)" >
								<option value=""></option>
								<% List<DataDepartamento> departamentos=(List<DataDepartamento>)request.getAttribute("deptos");
								if(departamentos!=null)
								for(DataDepartamento departamento: departamentos){%>
								<option 
								value="<%=departamento.getId()%>" 
								><%=departamento.getNombre()%></option>
								<%} %>
					</Select>	
					</div>			
<!-- 					<div class="row mb-2"> -->
<!-- 					    <label for="inputNombreAct" class="col-sm-2 col-form-label">Actividad</label>						 -->
<!-- 						<div class="card col-sm-8"> -->
<!-- 							<div class="card-body" class="form-control" id="cardActividades" name="inputActividad"></div> -->
<!-- 						</div> -->
<!-- 					</div>					 -->
					<div class="row mb-2">	
					<label for="inputNombreAct" class="col-sm-2 col-form-label">Actividad</label>									
					 <Select id="actividadSelect" name="actividadSelect" class="form-control col-sm-8"  >
							
					</Select>	
					</div>

                    <div class="row mb-2">
                        <label for="inputNombreSal" class="col-sm-2 col-form-label">NombreSal</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputNombreSal" name="inputNombreSal">
                        </div>
                    </div>                   
                    <div class="row mb-2">
                        <label for="inputFechaSal" class="col-sm-2 col-form-label">FechaSalida</label>
                        <div class="col-sm-8">
                            <input type="date" class="form-control" id="inputFechaSal" name="inputFechaSal">
                        </div>
                    </div>
                    <div class="row mb-2">
                        <label for="inputHoraSal" class="col-sm-2 col-form-label">HoraSalida</label>
                        <div class="col-sm-8">
                            <input type="time" class="form-control" id="inputHoraSal" name="inputHoraSal">
                        </div>
                    </div>                    
                    <div class="row mb-2">
                        <label for="inputCantMaxSal" class="col-sm-2 col-form-label">CantMaxTuristas</label>
                        <div class="col-sm-8">
                            <input type="number" class="form-control" id="inputCantMaxSal" name="inputCantMaxSal">
                        </div>
                    </div>                
                    <div class="row mb-2">
                        <label for="inputLugarSal" class="col-sm-2 col-form-label">LugarSalida</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputLugarSal" name="inputLugarSal">
                        </div>
                    </div>
                 
                    <div class="row mb-2">
                        <label for="inputImageAct" class="col-sm-2 col-form-label">Foto_link</label>
                        <div class="col-sm-8">
                            <input type="file" class="form-control" id="inputImageAct" name="inputImageAct">
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-lg-8 offset-lg-7">
                            <button type="submit" class="btn btn-primary offset-sm-1" >Aceptar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
<style>
#cajaDepartamentos {
	max-height: 20vh;
	overflow-y: auto;
}   
.card-body {
	padding: 6px 12px;
	max-height: 18vh;
	overflow-y: auto;
}
.card col-sm-8{}
	padding: 0px 0px;
	max-height: 18vh;
	overflow-y: auto;
}
</style>

</body>
<script> 
function seleccionarDepartamento(idDepartamento) {
	// Crear un objeto XMLHttpRequest
	var xhr = new XMLHttpRequest();
	console.log("llegue no se q ...");
	// Configurar la solicitud
	xhr.open('POST', 'http://localhost:8080/Labo2/ListarActividades?idDepto=' // esto es una queryparam
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
								actividadesHtml += "<option value='"+actividad.id+"' > "+actividad.nomAct+" </option>"
// 										+ actividad.id 										
// 										+ ")'>"
// 										+ "<h6 style='cursor: pointer;'>"
// 										+ actividad.nomAct
// 										+ "</h6>"										
// 										+ "</p>" + "<hr>" + "</div>";
							});
				} else {
					actividadesHtml += "<div class='actividad'>"
							+ "<p>"
							+ "Este Departamento no tiene actividades confirmadas a mostrar."
							+ "</p>" + "</div>";
				}

				document.getElementById("actividadSelect").innerHTML = actividadesHtml;
			}
		}
	};
	// Enviar la solicitud
	xhr.send();
}
</script>
</html>
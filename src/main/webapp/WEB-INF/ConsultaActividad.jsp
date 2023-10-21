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
<title> Consulta Actividad</title>
</head>
<body>
<jsp:include page="/WEB-INF/templates/header.jsp" />
<div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">                
				<form onsubmit="return validateForm()" action="ConsultaActividad" method="get">           				
					<div>
                    <h1 class="tituloVentana">Consulta Actividad</h1>
                    </div> <!-- ----------------------------------MENSAJES A USUARIO ----------------------------------------------- -->
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
					    %> <!-- ----------------------------------MENSAJES A USUARIO ----------------------------------------------- -->
                   
                    <div class="containerDepto">
	                    <div class="row mb-2 ">                    
	                    <label for="inputNombreDpto" class="col-sm-4 col-form-label">Depto</label>   
	                    	<div class="col-sm-8">                 
			                   <Select id="departamentoSelect" name="departamentoSelect" class="form-control">
								<% List<DataDepartamento> departamentos=(List<DataDepartamento>)request.getAttribute("departamentos");
								if(departamentos!=null)
								for(DataDepartamento departamento: departamentos){%>
								<option value="<%=departamento.getNombre()%>"><%=departamento.getNombre()%></option>
								<%} %>
								</Select>
							</div>	
										
						</div>
					</div>
					<div class="containerCat">
						<div class="row mb-2">
	                    <label for="inputCategoriaAct" class="col-sm-4 col-form-label">Categoria</label>
	                        <div class="col-sm-8">
	                        	 <select id="categoriaSelect" name="categoriaSelect" class="form-control">
								<% List<DataCategoria> categorias =(List<DataCategoria>)request.getAttribute("categorias");
								if(categorias!=null)
								for(DataCategoria cat: categorias){%>
								<option value="<%=cat.getNombre()%>"><%=cat.getNombre()%></option>
								<%} %>
								</select>                            
	                        </div>
	                    </div>
	                </div>	                   
                    <div class="row mb-2">
                    <label for="inputCategoriaAct" class="col-sm-4 col-form-label">Actividad</label>
                        <div class="col-sm-8">
                        	 <select id="actividadSelect" name="actividadSelect" class="form-control">
							<% List<DataActividad> actividades =(List<DataActividad>)request.getAttribute("actividades");
							if(actividades!=null)
							for(DataActividad act: actividades){%>
							<option value="<%=act.getNomAct()%>"><%=act.getNomAct()%></option>
							<%} %>
							</select>                            
                        </div>
                    </div>                                   
                    <div class="row mb-2">
                        <label for="readDescAct" class="col-sm-4 col-form-label">Descripcion</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="readDescAct" name="readDescAct" value="${readDescAct}" readonly>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <label for="readDuracionAct" class="col-sm-4 col-form-label">Duracion(hs)</label>
                        <div class="col-sm-8">
                            <input type="number" class="form-control" id="readDuracionAct" name="readDuracionAct" value="${readDuracionAct}" readonly>
                        </div>
                    </div>                    
                    <div class="row mb-2">
                        <label for="readCostoAct" class="col-sm-4 col-form-label">Costo($uy)</label>
                        <div class="col-sm-8">
                            <input type="number" class="form-control" id="readCostoAct" name="readCostoAct" value="${readCostoAct}" readonly>
                        </div>
                    </div>                
                    <div class="row mb-2">
                        <label for="readCiudadAct" class="col-sm-4 col-form-label">Ciudad</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="readCiudadAct" name="readCiudadAct" value="${readCiudadAct}" readonly>
                        </div>
                    </div>
                 
                    <div class="row mb-2">
                        <label for="readImageAct" class="col-sm-4 col-form-label">Foto_link</label>
                        <div class="col-sm-8">
                            <input type="file" class="form-control" id="readImageAct" name="readImageAct">
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
</body>
 <script>
       function validateForm() {
            var name = document.getElementById("inputNombreAct").value;
            if (name == "") {
                alert("El nombre de la actividad no puede estar vacío.");
                return false;
            }
            var description = document.getElementById("inputDescAct").value;
            if (description == "") {
                alert("La descripción no puede estar vacía.");
                return false;
            }
            var duration = document.getElementById("inputDuracionAct").value;
            if (isNaN(duration) || duration <= 0) {
                alert("Introduce una duración válida.");
                return false;
            }
            var cost = document.getElementById("inputCostoAct").value;
            if (isNaN(cost) || cost < 0) {
                alert("Introduce un costo válido.");
                return false;
            }
            var city = document.getElementById("inputCiudadAct").value;
            if (city == "") {
                alert("La ciudad no puede estar vacía.");
                return false;
            }
            var category = document.getElementById("inputCategoriaAct").value;
            if (category == "") {
                alert("La categoría no puede estar vacía.");
                return false;
            }
            return true;
        }
    </script>



</html>
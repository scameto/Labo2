<%@page import="logica.datatypes.DataProveedor"%>
<%@page import="com.labo2.model.EstadoSesion"%>
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
<title>Alta Actividad</title>
</head>
<body>
<jsp:include page="/WEB-INF/templates/header.jsp" />
<div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">                
				<form onsubmit="return validateForm()" action="AltaActividad" method="post">           				
					<div>
                    <h1 class="tituloVentana">Alta Actividad</h1>
                    </div>
                    <!--         ACA CHEQUEAMOS QUE EL USUARIO ESTE LOGUEADO PARA PERMITIR EL ACCESO -->
					<%
					    HttpSession sesion = request.getSession();
					    EstadoSesion estadoSesion = (EstadoSesion) sesion.getAttribute("estado_sesion");
					    Object usuarioLogueado = sesion.getAttribute("usuario_logueado");
					
					    if (!(estadoSesion != null && usuarioLogueado instanceof DataProveedor)) {
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
                    <div class="row mb-2">
                    <label for="inputNombreDpto" class="col-sm-2 col-form-label">Depto</label>   
                    	<div class="col-sm-8">                 
		                   <select id="departamentoSelect" name="departamentoSelect" class="form-control">
							<% List<DataDepartamento> departamentos=(List<DataDepartamento>)request.getAttribute("departamentos");
							if(departamentos!=null)
							for(DataDepartamento departamento: departamentos){%>
							<option value="<%=departamento.getNombre()%>"><%=departamento.getNombre()%></option>
							<%} %>
							</select>	
						</div>				
					</div>
                    <div class="row mb-2">
                        <label for="inputNombreAct" class="col-sm-2 col-form-label">NombreAct</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputNombreAct" name="inputNombreAct">
                        </div>
                    </div>                   
                    <div class="row mb-2">
                        <label for="inputDescAct" class="col-sm-2 col-form-label">Descripcion</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputDescAct" name="inputDescAct">
                        </div>
                    </div>
                    <div class="row mb-2">
                        <label for="inputDuracionAct" class="col-sm-2 col-form-label">Duracion(hs)</label>
                        <div class="col-sm-8">
                            <input type="number" class="form-control" id="inputDuracionAct" name="inputDuracionAct">
                        </div>
                    </div>                    
                    <div class="row mb-2">
                        <label for="inputCostoAct" class="col-sm-2 col-form-label">Costo($uy)</label>
                        <div class="col-sm-8">
                            <input type="number" class="form-control" id="inputCostoAct" name="inputCostoAct">
                        </div>
                    </div>                
                    <div class="row mb-2">
                        <label for="inputCiudadAct" class="col-sm-2 col-form-label">Ciudad</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="inputCiudadAct" name="inputCiudadAct">
                        </div>
                    </div>
                    <div class="row mb-2">
                        <label for="inputCategoriaAct" class="col-sm-2 col-form-label">Categoria</label>
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
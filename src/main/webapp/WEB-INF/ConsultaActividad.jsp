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
			<div class="col-lg-6">
				<div>
					<h1 class="tituloVentana">Consultar Usuarios</h1>
					<div>
						<h2>Turistas:</h2>
						<div id="listaUsuarios">
							<ul class="list-group">
								<%
                    List<String> usernames = (List<String>)request.getAttribute("usernames");
                    if (usernames != null) {
                        for (String username : usernames) {
                %>
								<li class="list-group-item"
									onclick="seleccionarUsuario('<%= username %>')"><%= username %></li>
								<%
                        }
                    }
                %>
							</ul>
						</div>
					</div>
					
					    <p>Usuario seleccionado: <span id="usuarioSeleccionado"></span></p>
					
					
				</div>
			</div>
		</div>
		
		
<section style="background-color: rgba(238, 238, 238, 0.5);"  id="datosTurista">
  <div class="container py-5">
    <div class="row">
      <div class="col-lg-4">
        <div class="card mb-4">
          <div class="card-body text-center">
            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp" alt="avatar"
              class="rounded-circle img-fluid" style="width: 150px;">
            <h5 class="my-3">John Smith</h5> <!-- TODO poner nombre y apellido --> 
            <p class="text-muted mb-4">Bay Area, San Francisco, CA</p>  <!-- TODO poner turista o prov -->
            <div class="d-flex justify-content-center mb-2">
              <button type="button" class="btn btn-primary">Follow</button>
              <button type="button" class="btn btn-outline-primary ms-1">Message</button>
            </div>
          </div>
        </div>
        <div class="card mb-4 mb-lg-0">
          <div class="card-body p-0">
            <ul class="list-group list-group-flush rounded-3">
              <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                <p class="mb-0">https://mdbootstrap.com</p>
              </li>
              <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                <p class="mb-0">mdbootstrap</p>
              </li>
              <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                <p class="mb-0">@mdbootstrap</p>
              </li>
              <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                <p class="mb-0">mdbootstrap</p>
              </li>
              <li class="list-group-item d-flex justify-content-between align-items-center p-3">
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
                <p class="mb-0">Nombre completo</p>
              </div>
              <div class="col-sm-9">
                <p class="text-muted mb-0">Johnatan Smith</p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Email</p>
              </div>
              <div class="col-sm-9">
                <p class="text-muted mb-0">example@example.com</p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Fecha de Nacimiento</p>
              </div>
              <div class="col-sm-9">
                <p class="text-muted mb-0">(097) 234-5678</p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Nacionalidad</p>
              </div>
              <div class="col-sm-9">
                <p class="text-muted mb-0">(098) 765-4321</p>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="card mb-4 mb-md-0">
              <div class="card-body">

              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card mb-4 mb-md-0">
              <div class="card-body">

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

	</div>
</body>

 <script>
        function seleccionarUsuario(username) {
            // Oculta la lista de usernames
            document.getElementById("listaUsuarios").style.display = "none";
            document.getElementById("datosTurista").style.display = "none";
            document.getElementById("usuarioSeleccionado").textContent = username;
            
            // Envia el nombre de usuario al servidor usando AJAX
         
        }
    </script>

</html>

<%@page import="logica.datatypes.DataTurista"%>
<%@page import="com.labo2.model.EstadoSesion"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
	<a class="navbar-brand" href="Index.jsp">TurismoUy</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarNav" aria-controls="navbarNav"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	 <% 
        EstadoSesion estadoSesion = (EstadoSesion) session.getAttribute("estado_sesion");
        Object usuarioLogueado = session.getAttribute("usuario_logueado");
    %>
	
	<div class="collapse navbar-collapse" id="navbarNav">
		<div class="dropdown">
			<button class="dropdown-toggle" type="button" id="dropdownMenuButton"
				data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fa fa-bars"></i>
			</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<% if(usuarioLogueado instanceof logica.datatypes.DataTurista) {%>  <!-- Opciones para turistas -->
				<a class="dropdown-item usr-item" href="#">Usuarios</a>
				<div class="dropdown-submenu-usuario"
					aria-labelledby="submenu-usuarios">
					<a class="dropdown-item usr-item" href="consultaUsuariosServlet">Consultar Usuarios</a>
					</div>
				<%} else if(usuarioLogueado instanceof logica.datatypes.DataProveedor) {%>
				<a class="dropdown-item usr-item" href="#">Usuarios</a>
				<div class="dropdown-submenu-usuario"
					aria-labelledby="submenu-usuarios">
					<a class="dropdown-item usr-item" href="consultaUsuariosServlet">Consultar Usuarios</a>
					<a class="dropdown-item usr-item" href="#">Modificar Usuarios</a>
				</div>
				<% } %> <!-- ******************************************************************************* -->
				<% if(usuarioLogueado instanceof logica.datatypes.DataProveedor) {%>
				<a class="dropdown-item act-item" href="#">Actividades</a>
				<div class="dropdown-submenu-actividades"
					aria-labelledby="submenu-actividades">
					<a class="dropdown-item act-item" href="AltaActividad">Alta	Actividad Turistica</a> 
					<a class="dropdown-item act-item" href="#">Consulta	Actividad Turistica</a>
				</div>
				<%} else {%>
				<a class="dropdown-item act-item" href="#">Actividades</a>
				<div class="dropdown-submenu-actividades"
					aria-labelledby="submenu-actividades">					
					<a class="dropdown-item act-item" href="#">Consulta	Actividad Turistica</a>
				</div>
				<% } %>	<!-- ******************************************************************************* -->			
				<a class="dropdown-item paq-item" href="#">Paquetes</a>
				<div class="dropdown-submenu-paquetes"
					aria-labelledby="submenu-paquetes">
					<a class="dropdown-item paq-item" href="#">Compra Paquete</a> <a
						class="dropdown-item paq-item" href="#">Consulta Paquete</a>
				</div>
				<a class="dropdown-item sal-item" href="#">Salidas</a>
				<div class="dropdown-submenu-salidas"
					aria-labelledby="submenu-salidas">
					<a class="dropdown-item sal-item" href="#">Alta Salida</a> 
					<a class="dropdown-item sal-item" href="#">Inscripcion Salida</a> 
					<a class="dropdown-item sal-item" href="#">Consulta Salida</a>
				</div>
			</div>
		</div>
	</div>
	<ul class="navbar-nav ml-auto">

		
		<% if(estadoSesion == EstadoSesion.LOGIN_TURISTA || estadoSesion == EstadoSesion.LOGIN_PROVEEDOR) { %>
			<li class="nav-item"><span class="nav-link">Hola, <%= ((usuarioLogueado instanceof logica.datatypes.DataTurista)
																	? ((DataTurista) usuarioLogueado).getNombre()
																	: ((logica.datatypes.DataProveedor) usuarioLogueado).getNombre()) %></span></li>
            <li class="nav-item"><a class="nav-link" href="logoutServlet">Cerrar sesión</a></li>
        <% } else { %>
            <li class="nav-item"><a class="nav-link" href="iniciar">Iniciar sesión</a></li>
            <li class="nav-item"><a class="nav-link" href="AltaUsuario.html">Registrarse</a></li>
        <% } %>
<!-- 
	</ul>
	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link" href="#"
			id="search-icon"><i class="fas fa-search"></i></a></li>
		<li class="nav-item"><input type="text" id="search-input"
			class="form-control" placeholder="Buscar"></li>  -->
	</ul>
	</div>
</nav>

<!-- mostrar u ocultar boton busqueda -->
<script>
        $(document).ready(function() {
            $("#search-icon").click(function() {
                $("#search-input").toggle("fast");
            });
        });
    </script>
<script> //comportamiento submenu usuarios
        $(document).ready(function() {             
            $(".dropdown-submenu-usuario").hide();           

            $(".usr-item").mouseenter(function() {
                $(".dropdown-submenu-usuario").stop().show("fast");
            });
        });
        $(document).ready(function() {
            $(".usr-item").mouseleave(function() {
                $(".dropdown-submenu-usuario").stop().hide("fast");
            });
            
        });
    </script>
<script> //comportamiento submenu actividades
        $(document).ready(function() {             
            $(".dropdown-submenu-actividades").hide();           

            $(".act-item").mouseenter(function() {
                $(".dropdown-submenu-actividades").stop().show("fast");
            });
        });
        $(document).ready(function() {
            $(".act-item").mouseleave(function() {
                $(".dropdown-submenu-actividades").stop().hide("fast");
            });
            
        });
    </script>
<script> //comportamiento submenu actividades
        $(document).ready(function() {             
            $(".dropdown-submenu-paquetes").hide();           

            $(".paq-item").mouseenter(function() {
                $(".dropdown-submenu-paquetes").stop().show("fast");
            });
        });
        $(document).ready(function() {
            $(".paq-item").mouseleave(function() {
                $(".dropdown-submenu-paquetes").stop().hide("fast");
            });
            
        });
    </script>
<script> //comportamiento submenu actividades
        $(document).ready(function() {             
            $(".dropdown-submenu-salidas").hide();           

            $(".sal-item").mouseenter(function() {
                $(".dropdown-submenu-salidas").stop().show("fast");
            });
        });
        $(document).ready(function() {
            $(".sal-item").mouseleave(function() {
                $(".dropdown-submenu-salidas").stop().hide("fast");
            });
            
        });
    </script>
<!-- Importar jQuery desde la CDN de Google -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Enlace al archivo JavaScript de Bootstrap (CDN) -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

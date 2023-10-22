package com.labo2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.json.JSONObject;

import com.google.gson.Gson;

import logica.Fabrica;
import logica.ISistema;
import logica.datatypes.DataProveedor;
import logica.datatypes.DataPaquete;
import logica.datatypes.DataSalida;
import logica.datatypes.DataTurista;
import logica.datatypes.DataActividad;

public class ConsultarUsuarios extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ISistema sistema;
	private Gson gson;

	@Override
	public void init() throws ServletException {
		super.init();
		sistema = Fabrica.getInstance().getISistema();
		gson = new Gson();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession objSesion = request.getSession();

		if (request.getParameter("username") == null) {
			List<String> usernames = sistema.obtenerNombresTuristasYProveedores();

			if (usernames == null || usernames.isEmpty()) {
				objSesion.setAttribute("mensaje", "No hay usuarios para mostrar.");
			} else {
				request.setAttribute("usernames", usernames);
			}
			request.getRequestDispatcher("/WEB-INF/ConsultarUsuario.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String idAct = request.getParameter("idActividad");

		if (username != null) {
			DataTurista turista = sistema.findTurista(username);
			if (turista != null) {
				String turistaJson = gson.toJson(turista);
				response.setContentType("application/json");
				response.getWriter().write(turistaJson);
			} else {
				DataProveedor prov = sistema.findProveedor(username);
				String proveedorJson = gson.toJson(prov);
				response.setContentType("application/json");
				response.getWriter().write(proveedorJson);
			}
		} else if (idAct != null) {
			Long idActividad = Long.parseLong(idAct);
			List<DataSalida> salidas = sistema.getSalidasData(idActividad);
			String salidasJson = gson.toJson(salidas);
			response.setContentType("application/json");
			response.getWriter().write(salidasJson);
		}
		if (request.getParameter("usernameTuristaSalidas") != null) {
			List<DataSalida> salidas = sistema.listarSalidasInscritas(request.getParameter("usernameTuristaSalidas"));
			String salidasJson = gson.toJson(salidas);
			response.setContentType("application/json");
			response.getWriter().write(salidasJson);
		}
		if (request.getParameter("usernamePaquetes") != null) {
			String usernamePaq = request.getParameter("usernamePaquetes");
			List<DataPaquete> paquetes = sistema.getPaquetesCompradosTurista(usernamePaq);
			String paquetesjson = gson.toJson(paquetes);
			response.setContentType("application/json");
			response.getWriter().write(paquetesjson);
		}
		if (request.getParameter("usernameProv") != null) {

			String usernameProv = (String) request.getParameter("usernameProv");
			List<DataActividad> actividades = (List<DataActividad>) sistema
					.getActividadesProveedorConfirmadas(usernameProv);
			String actividadesJson = gson.toJson(actividades);
			response.setContentType("application/json");
			response.getWriter().write(actividadesJson);
		}
		if (request.getParameter("usernameProvTodo") != null) {

			String usernameProvTodo = (String) request.getParameter("usernameProvTodo");
			List<DataActividad> actividadesTodo = (List<DataActividad>) sistema
					.getActividadesProveedor(usernameProvTodo);
			String actividadesJsonTodo = gson.toJson(actividadesTodo);
			response.setContentType("application/json");
			response.getWriter().write(actividadesJsonTodo);
		}
		
		if (request.getParameter("editarXD") != null) {
		    if(request.getParameter("editarXD") == "Turista") {
		    	String jsonPayload = request.getParameter("datos");
			    JSONObject jsonObject = new JSONObject(jsonPayload);
			    String nombre = jsonObject.getString("nombre");
			    String apellido = jsonObject.getString("apellido");
			    String nacionalidad = jsonObject.getString("nacionalidad");
			    String fechaNacimiento = jsonObject.getString("fechaNacimiento");
			    Date fechaNac = parsearFecha(fechaNacimiento);
			    String email = jsonObject.getString("email");
			    String tusername = jsonObject.getString("username");
			    String password = jsonObject.getString("password");
			    DataTurista turista = new DataTurista(tusername,nombre,apellido,email,password,fechaNac,nacionalidad);
			    sistema.actualizarTurista(turista);

			    System.out.println("Turista deserializado: " + turista);
		    }else {
		    	
		    }
			
			
		}
	}
	
	public Date parsearFecha(String fecha) {
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return formato.parse(fecha);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
}

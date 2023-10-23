package com.labo2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logica.Fabrica;
import logica.ISistema;
import logica.datatypes.DataPaquete;
import logica.datatypes.DataSalida;
import logica.datatypes.DataTurista;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.labo2.model.EstadoSesion;

public class CompraPaquete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ISistema sistema;
	private Gson gson;

	@Override
	public void init() throws ServletException {
		super.init();
		sistema = Fabrica.getInstance().getISistema();
		gson = new Gson();
	}
	
    public CompraPaquete() { super() ;}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/CompraPaquete.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		EstadoSesion estadoSesion = (EstadoSesion) session.getAttribute("estado_sesion");
		Object usuarioLogueado = session.getAttribute("usuario_logueado");
		
		if(usuarioLogueado instanceof DataTurista) {
			String username = ((DataTurista)usuarioLogueado).getUsername();
			List<DataPaquete> paquetes = sistema.getPaquetesNoCompradosTurista(username);
			System.out.println("Consulta de paquetes: " + paquetes);
			String paquetesJson = gson.toJson(paquetes);
			response.setContentType("application/json");
			response.getWriter().write(paquetesJson);
		}
	}

}

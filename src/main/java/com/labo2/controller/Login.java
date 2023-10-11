package com.labo2.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.labo2.exceptions.UsuarioNoEncontrado;
import com.labo2.model.EstadoSesion;
import com.labo2.model.GestorUsuario;
import com.labo2.model.Usuario;

/**
 * Servlet implementation class Login
 */
@WebServlet("/iniciar-sesion")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 * 
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession objSesion = request.getSession();
		String tipo = request.getParameter("tipo");
		String login = request.getParameter("inputUsuario");
		String password = request.getParameter("inputPassword");
		
		EstadoSesion nuevoEstado;

		// chequea contraseña
		try {
			Usuario usr = GestorUsuario.getInstance().buscarUsuario(login);
			if (!usr.getPassword().equals(password))
				nuevoEstado = EstadoSesion.LOGIN_INCORRECTO;
			else {
				nuevoEstado = EstadoSesion.LOGIN_CORRECTO;
				// setea el usuario logueado
				request.getSession().setAttribute("usuario_logueado", usr);
			}
		} catch (UsuarioNoEncontrado ex) {
			nuevoEstado = EstadoSesion.LOGIN_INCORRECTO;
		}

		objSesion.setAttribute("estado_sesion", nuevoEstado);

		// redirige a la página principal para que luego rediriga a la página
		// que corresponde
		RequestDispatcher dispatcher = request.getRequestDispatcher("/home");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

}

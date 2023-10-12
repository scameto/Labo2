package com.labo2.controller;

import java.io.IOException;
import java.util.Collection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.labo2.exceptions.UsuarioNoEncontrado;
import com.labo2.model.GestorUsuario;
import com.labo2.model.Usuario;

/**
 * Servlet implementation class Usuarios
 */
@WebServlet ("/usuarios")
public class Usuarios extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Usuarios() {
        super();
        // TODO Auto-generated constructor stub
    }

	/** 
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String usuario = request.getParameter("usuario");
			
		if(usuario == null) {
			// no se seteó el usuario (lista todos los usuarios)
			Collection<Usuario> usrs = GestorUsuario.getInstance().getUsuarios();
			request.setAttribute("usuarios", usrs);
			
			request.getRequestDispatcher("/WEB-INF/usuarios/listar.jsp").
					forward(request, response);
				
		} else {
			// ve el perfil de un solo usuario
			Usuario usr;
			try {
				usr = GestorUsuario.getInstance().buscarUsuario(usuario);
			} catch(UsuarioNoEncontrado ex){
				response.sendError(404); // el usuario no existe
				request.getRequestDispatcher("/WEB-INF/errorPages/404.jsp").
						include(request, response);
				return;
			}
			
			// setea el usuario
			request.setAttribute("usuario", usr);
			
			request.getRequestDispatcher("/WEB-INF/usuarios/perfil.jsp").
					forward(request, response);
		}
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}

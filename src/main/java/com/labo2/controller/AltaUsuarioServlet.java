package com.labo2.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import logica.Fabrica;
import logica.ISistema;
import logica.datatypes.DataTurista;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.swing.JOptionPane;

/**
 * Servlet implementation class AltaUsuarioServlet
 */
	public class AltaUsuarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private ISistema sistema = Fabrica.getInstance().getISistema();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AltaUsuarioServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//HttpSession objSesion = request.getSession();
		String userNick = request.getParameter("inputUsuarioNick");
		String userNomb = request.getParameter("inputUsuarioNombre");
		String userApe = request.getParameter("inputUsuarioApellido");
		String userPass = request.getParameter("inputPassword");
		String userEmail = request.getParameter("inputUsuarioEmail");
		String userNacion = request.getParameter("inputUsuarioNacion");		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date userFN = null;		
		try {
			userFN = sdf.parse(request.getParameter("inputUsuarioFNac"));
		} catch (Exception e) {
			request.getSession().setAttribute("mensajeError", "Formato de fecha inválido. Por favor, inténtalo de nuevo.");
		    response.sendRedirect("AltaUsuario.jsp");
		    System.out.println("estamos en el catch");
		}
		String userImage = request.getParameter("inputUsuarioImage");		
		DataTurista newUser = tomarDatos(userNick, userNomb, userApe, userPass, userEmail, userNacion, userFN);		
		if (sistema.checkUsernameRepetido("userNick")) { 
			request.getSession().setAttribute("mensajeError", "El nombre de usuario ya existe. Por favor elige otro.");
		    response.sendRedirect("AltaUsuario.jsp");
	        return;
	    } 
	    if (sistema.checkEmailRepetido(userEmail)) { 
	    	 request.getSession().setAttribute("mensajeError", "El email ya está registrado.");
	    	 response.sendRedirect("AltaUsuario.jsp");
	        return;
	    }   
	    System.out.println("estamos antes del registro");

	    if (newUser != null && sistema.registrarUsuario(newUser)) {
	    	 request.getSession().setAttribute("mensajeError", "El usuario fue registrado.");
	    	 response.sendRedirect("AltaUsuario.jsp");
	    	 
	    }
	    System.out.println("estamos despues del registro");
	    
	}
		
		
	private DataTurista tomarDatos(String userNick, String userNomb, String userApe, String userPass, String userEmail, String userNacion, Date userFN) {
	    DataTurista newUser = new DataTurista();	    
	    newUser.setUsername(userNick);
	    newUser.setNombre(userNomb);
	    newUser.setApellido(userApe);
	    newUser.setEmail(userEmail);
	    newUser.setPassword(userPass);
	    newUser.setNacionalidad(userNacion);
	    newUser.setFechaNac(userFN);
	    
	    return newUser;
	}
	

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        processRequest(request, response);
	}

}

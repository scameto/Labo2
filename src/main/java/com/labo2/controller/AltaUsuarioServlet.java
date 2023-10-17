package com.labo2.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logica.Fabrica;
import logica.ISistema;
import logica.datatypes.DataTurista;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.swing.JOptionPane;

/**
 * Servlet implementation class AltaUsuarioServlet
 */
	@WebServlet("/Alta-Usuario")
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
		HttpSession objSesion = request.getSession();//lo usamos para mostrar mensajes en la sesion
		String userNick = request.getParameter("inputUsuarioNick");
		String userNomb = request.getParameter("inputUsuarioNombre");
		String userApe = request.getParameter("inputUsuarioApellido");
		String userPass = request.getParameter("inputPassword");
		String userEmail = request.getParameter("inputUsuarioEmail");
		String userNacion = request.getParameter("inputUsuarioNacion");
		String userFNString = request.getParameter("inputUsuarioFNac");

	    System.out.println("estamos en el procesRequest antes del SimpleDateFormat   " + userFNString);	 
	    System.out.println("estamos en el procesRequest antes del SimpleDateFormat   " + userNick);	
	    System.out.println("estamos en el procesRequest antes del SimpleDateFormat   " + userApe);	
	    System.out.println("estamos en el procesRequest antes del SimpleDateFormat   " + userEmail);	
	    
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		Date userFN = null;		
		try {
			System.out.println("fecha antes del parse" );
			userFN = sdf.parse(userFNString);
			System.out.println("fecha convertida " + userFN );
		} catch (ParseException e) {		   
			objSesion.setAttribute("mensajeError", "Error al parsear la fecha: " + e.getMessage());
			response.sendRedirect("AltaUsuario");		    
		    return;
		}
		String userImage = request.getParameter("inputUsuarioImage");		
		DataTurista newUser = tomarDatos(userNick, userNomb, userApe, userPass, userEmail, userNacion, userFN);		
		if (sistema.checkUsernameRepetido(userNick)) { 
			objSesion.setAttribute("mensajeError", "El nombre de usuario ya existe. Por favor elige otro.");
		    response.sendRedirect("AltaUsuario");
	        return;
	    } 
	    if (sistema.checkEmailRepetido(userEmail)) { 
	    	 objSesion.setAttribute("mensajeError", "El email ya está registrado.");
	    	 response.sendRedirect("AltaUsuario");
	        return;
	    }   
	    System.out.println("estamos antes del registro");

	    if (newUser != null && sistema.registrarUsuario(newUser)) {
	    	 objSesion.setAttribute("mensajeExito", "El usuario fue registrado.");
	    	 response.sendRedirect("AltaUsuario");	    	 
	    } else {
	    	objSesion.setAttribute("mensajeError", "Hubo un problema en el registro del usuario.");
	    	 response.sendRedirect("AltaUsuario");
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
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        processRequest(request, response);
	}

}

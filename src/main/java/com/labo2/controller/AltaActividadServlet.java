package com.labo2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logica.Fabrica;
import logica.ISistema;
import logica.datatypes.DataDepartamento;
import logica.modelos.Departamento;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Servlet implementation class AltaActividadServlet
 */
@WebServlet("/Alta-Actividad")
public class AltaActividadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ISistema sistema = Fabrica.getInstance().getISistema();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AltaActividadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
    	
    	
		HttpSession objSesion = request.getSession();//lo usamos para mostrar mensajes en la sesion
		/*
		List<DataDepartamento> departamentos = sistema.getDepartamentosData();
		request.setAttribute("departamentos", departamentos);
		for (DataDepartamento departamento : departamentos) {
		    System.out.println(departamento);
		}*/
		/*
		String userNick = request.getParameter("inputUsuarioNick");
		String userNomb = request.getParameter("inputUsuarioNombre");
		String userApe = request.getParameter("inputUsuarioApellido");
		String userPass = request.getParameter("inputPassword");
		String userEmail = request.getParameter("inputUsuarioEmail");
		String userNacion = request.getParameter("inputUsuarioNacion"); //campo de Turista
		String userFNString = request.getParameter("inputUsuarioFNac");
		String userDesc = request.getParameter("inputUsuarioDesc"); // campo de Proveedor
		String userLinkW = request.getParameter("inputUsuarioLinkW"); // campo de Proveedor
		String userType = request.getParameter("userType");
		String departamento = request.getParameter("departamentoSelect");
		
		
	    System.out.println("estamos en el procesRequest antes del SimpleDateFormat   " + userFNString);	 
	    System.out.println("estamos en el procesRequest antes del SimpleDateFormat   " + userNick);	
	    System.out.println("estamos en el procesRequest antes del SimpleDateFormat   " + userApe);	
	    System.out.println("estamos en el procesRequest antes del SimpleDateFormat   " + userEmail);	
	    System.out.println("estamos en el procesRequest antes del SimpleDateFormat   " + departamento);
	    
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
		String userImage = request.getParameter("inputUsuarioImage");*/
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<DataDepartamento> departamentos = sistema.getDepartamentosData();
        request.setAttribute("departamentos", departamentos);        
        // mandar el formulario al usuario
        request.getRequestDispatcher("/WEB-INF/AltaActividad.jsp").forward(request, response);
      
		
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

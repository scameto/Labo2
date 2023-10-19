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
import logica.modelos.Paquete;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


@WebServlet("/ConsultaPaquete")
public class ConsultaPaqueteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ISistema sistema = Fabrica.getInstance().getISistema();
       
    
    public ConsultaPaqueteServlet() {
        super();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
    	
    	
		HttpSession objSesion = request.getSession();//lo usamos para mostrar mensajes en la sesion
	}
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Paquete> paquetes = sistema.getPaquetes();
        request.setAttribute("paquetes", paquetes);        
        // mandar el formulario al usuario
        request.getRequestDispatcher("/WEB-INF/ConsultaPaquete.jsp").forward(request, response);
        
        
      
		
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

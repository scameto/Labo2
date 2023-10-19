package com.labo2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logica.Fabrica;
import logica.ISistema;
import logica.datatypes.DataActividad;
import logica.datatypes.DataDepartamento;
import logica.datatypes.DataProveedor;
import logica.modelos.Departamento;
import logica.modelos.Proveedor;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Servlet implementation class AltaActividadServlet
 */
@WebServlet("/AltaActividad")
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
		
		String actNomb = request.getParameter("inputNombreAct");
		String actDesc = request.getParameter("inputDescAct");
		String actDur = request.getParameter("inputDuracionAct");
		String actCosto = request.getParameter("inputCostoAct");
		String actCiudad = request.getParameter("inputCiudadAct");
		String actCateg = request.getParameter("inputCategoriaAct"); 
		String departamento = request.getParameter("departamentoSelect"); //aca es que obtenemos el departamento seleccionado
		/*
		DataProveedor yo = (DataProveedor) objSesion.getAttribute("usuario_logueado");
		Proveedor miPro // get proveedor por id...
		Date fechaHoy = new Date();
		Integer.parseInt(actCosto);
		
		
		
	    
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		Date userFN = ;	
		
		try {
			System.out.println("fecha antes del parse" );
			userFN = sdf.parse(fechaHoy);
			System.out.println("fecha convertida " + userFN );
		} catch (ParseException e) {		   
			objSesion.setAttribute("mensajeError", "Error al parsear la fecha: " + e.getMessage());
			response.sendRedirect("AltaUsuario");		    
		    return;
		}
		String actImage = request.getParameter("inputImageAct");
		*/
    }
	private DataActividad tomarDatos(String nomAct, Proveedor prov, Departamento dept, String descripcion, int duracion, float costo, String ciudad, Date fechaAlta) {
		DataActividad newActividad = new DataActividad();		
		newActividad.setCiudad(ciudad);
		newActividad.setNomAct(nomAct);
		newActividad.setDescripcion(descripcion);
		newActividad.setDuracion(duracion);
		newActividad.setCosto(costo);
		Proveedor prov2 = (Proveedor) prov;
		Departamento dept2 = (Departamento) dept;
		newActividad.setProv(prov2);
		newActividad.setDept(dept2);
		newActividad.setFechaAlta(new Date());
		
		return newActividad;
	}
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<DataDepartamento> listdepartamentos = sistema.getDepartamentosData();
        request.setAttribute("departamentos", listdepartamentos);        
        // mandar el formulario al usuario
        request.getRequestDispatcher("/WEB-INF/AltaActividad.jsp").forward(request, response);
        // me esta listando los departamentos cargados
		
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    // procesa y manda a la BD los datos recolectados
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response); // procesa lo
	}

}

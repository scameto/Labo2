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
import logica.datatypes.DataCategoria;
import logica.datatypes.DataDepartamento;
import logica.datatypes.DataProveedor;
import logica.datatypes.DataSalida;
import logica.datatypes.DataTurista;
import logica.modelos.Departamento;
import logica.modelos.Proveedor;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.swing.JOptionPane;

import com.google.gson.Gson;

/**
 * Servlet implementation class AltaActividadServlet
 */
@WebServlet("/AltaSalida")
public class AltaSalidaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ISistema sistema;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        super.init();
        sistema = Fabrica.getInstance().getISistema();
        gson = new Gson();
    }

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AltaSalidaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {  
		
        HttpSession objSesion = request.getSession();

	    if (request.getParameter("deptos") == null) {
	        List<DataDepartamento> departamentos = (List<DataDepartamento>) sistema.getDepartamentosData();
	        if (departamentos == null || departamentos.isEmpty()) {
	            objSesion.setAttribute("mensaje", "No hay departamentos para mostrar.");
	        } else {
	            request.setAttribute("deptos", departamentos);
	        }
	    }	    
        request.getRequestDispatcher("/WEB-INF/AltaSalida.jsp").forward(request, response);
	}
    // Recupera las actividades basadas en el departamento
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession objSesion = request.getSession();//lo usamos para mostrar mensajes en la sesion
		
		String departamento = request.getParameter("departamentoSelect"); //aca es que obtenemos el departamento seleccionado
		String actividad = request.getParameter("actividadSelect"); //aca es que obtenemos el departamento seleccionado

		String salNomb = request.getParameter("inputNombreSal");
		String salFecha = request.getParameter("inputFechaSal");
		String salHora = request.getParameter("inputHoraSal");
		String salCantMax = request.getParameter("inputCantMaxSal");
		String salLugar = request.getParameter("inputLugarSal");		
		Integer cantMaxi, cantActual;
		System.out.println(departamento);
		System.out.println(actividad + "nombre actividad");
	
		DataDepartamento deseado = null;
		List<DataDepartamento> depa = sistema.getDepartamentosData();
		for(DataDepartamento depar: depa) {
			if(depar.getId().equals(Long.parseLong(departamento))) {
				deseado = depar;
				break;
			}
		}		
		
		DataActividad buscada = null;
		List<DataActividad> dact = sistema.getActividadesData(deseado.getId());
		for(DataActividad da : dact) {
			if(da.getId().equals(Long.parseLong(actividad))) {
				buscada = da;
				break;
			}
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");			
		try {
			cantMaxi = cantActual = Integer.parseInt(salCantMax);					
		} catch (NumberFormatException e) {		   
			objSesion.setAttribute("mensajeError", "Error al parsear Cantidad Maxima de Turistas: " + e.getMessage());
			response.sendRedirect("AltaSalida");		    
		    return;
		}
		
		Date fechaParsed = null;
		try {
			fechaParsed = sdf.parse(salFecha);
		} catch (ParseException e) {
		    objSesion.setAttribute("mensajeError", "Error al parsear la Fecha de Salida: " + e.getMessage());
		    response.sendRedirect("AltaSalida");
		    return;
		}
		
		Date horaParsed = null;
		try {
		    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");  
		    horaParsed = timeFormat.parse(salHora);
		} catch (ParseException e) {
		    objSesion.setAttribute("mensajeError", "Error al parsear la Hora de Salida: " + e.getMessage());
		    response.sendRedirect("AltaSalida");
		    return;
		}
		
		String actImage = request.getParameter("inputImageAct");
		
		
		DataSalida newSal = tomarDatos(fechaParsed, salLugar, salNomb, cantMaxi, buscada);	
		if (sistema.existeSalida(salNomb)) { 
			objSesion.setAttribute("mensajeError", "El nombre de Salida ya existe. Por favor elige otro.");
		    response.sendRedirect("AltaSalida");
	        return;
	    } 
	    
	    if (newSal != null && sistema.registrarSalida(newSal)) {
	    	 objSesion.setAttribute("mensajeExito", "Salida registrada exitosamente!.");
	    	 response.sendRedirect("AltaSalida");	    	 
	    } else {
	    	objSesion.setAttribute("mensajeError", "Hubo un problema en el registro de la Salida.");
	    	 response.sendRedirect("AltaSalida");
	    }
		
	}
	private DataSalida tomarDatos(Date fechaSal, String lugar, String nombreSal, Integer cantMax, DataActividad act) {
		DataSalida newSalida = new DataSalida();		
		newSalida.setFechaSalida(fechaSal);
		newSalida.setFechaAlta(new Date());
		newSalida.setLugarSalida(lugar);
		newSalida.setNombre(nombreSal);
		newSalida.setCantMax(cantMax);
		newSalida.setCantActual(cantMax);
		newSalida.setActividad(act);
		return newSalida;		
		
	}
}
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
import logica.datatypes.DataTurista;
import logica.modelos.Departamento;
import logica.modelos.Proveedor;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Servlet implementation class AltaActividadServlet
 */
@WebServlet("/ConsultaActividad")
public class ConsultaActividadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ISistema sistema = Fabrica.getInstance().getISistema();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConsultaActividadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
    	
		DataDepartamento deseado = null;
		
		HttpSession objSesion = request.getSession();//lo usamos para mostrar mensajes en la sesion
		String actividad = request.getParameter("actividadSelect");
		String actCateg = request.getParameter("categoriaSelect"); 
		String departamento = request.getParameter("departamentoSelect"); //aca es que obtenemos el departamento seleccionado
		
		DataProveedor yo = (DataProveedor) objSesion.getAttribute("usuario_logueado");
		List<DataDepartamento> depa = sistema.getDepartamentosData();
		for(DataDepartamento depar: depa) {
			if(depar.getNombre().equals(departamento)) {
				deseado = depar;
				break;
			}
		}
		List<DataCategoria> listaCategorias = new ArrayList();
		DataCategoria buscada = null;
		List<DataCategoria> cate = sistema.getCategoriasData();
		for(DataCategoria dc : cate) {
			if(dc.getNombre().equals(actCateg)) {
				listaCategorias.add(dc);
				break;
			}
		}
		DataActividad elegida = null;
		List<DataActividad> actividades = sistema.getActividadesConfirmadas(deseado.getId());
		for(DataActividad dact: actividades) {
			System.out.println(dact.getNomAct());
			if(dact.getNomAct().equals(actividad)) {
				elegida = dact;				
			}
			if(elegida == null) {
				objSesion.setAttribute("mensajeError", "Error al traer la Actividad, intente nuevamente.");
			    response.sendRedirect("ConsultaActividad");
			}
		}/*
		String desc = elegida.getDescripcion();
		request.setAttribute("readDescAct", desc);
		Integer dur = elegida.getDuracion();
		request.setAttribute("readDuracionAct", dur.toString());
		Float costo = elegida.getCosto();
		request.setAttribute("readCostoAct", costo.toString());
		String ciudad = elegida.getCiudad();
		request.setAttribute("readCiudadAct", ciudad);
			*/	
	}
			
		
		/*
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");			
		try {
			costo = Float.parseFloat(actCosto);
			duracion = Integer.parseInt(actDur);			
			System.out.println("integer convertido" + costo + duracion );
		} catch (NumberFormatException e) {		   
			objSesion.setAttribute("mensajeError", "Error al parsear Costo o Duracion: " + e.getMessage());
			response.sendRedirect("AltaActividad");		    
		    return;
		}
		String actImage = request.getParameter("inputImageAct");
		
		
		DataActividad newAct = tomarDatos(actNomb, yo, deseado, actDesc, duracion, costo, actCiudad, listaCategorias );		
		if (sistema.existeActividad(actNomb)) { 
			objSesion.setAttribute("mensajeError", "El nombre de Actividad ya existe. Por favor elige otro.");
		    response.sendRedirect("AltaActividad");
	        return;
	    } 
	    
	    if (newAct != null && sistema.registrarActividad(newAct)) {
	    	 objSesion.setAttribute("mensajeExito", "Actividad registrada exitosamente!.");
	    	 response.sendRedirect("AltaActividad");	    	 
	    } else {
	    	objSesion.setAttribute("mensajeError", "Hubo un problema en el registro de la Actividad.");
	    	 response.sendRedirect("AltaActividad");
	    }
		*/

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {        
        List<DataDepartamento> listdepartamentos = sistema.getDepartamentosData();
        request.setAttribute("departamentos", listdepartamentos);        
        // mandar el formulario al usuario
        // me esta listando los departamentos cargados		
        List<DataCategoria> listCategoorias = sistema.getCategoriasData();
        request.setAttribute("categorias", listCategoorias); 
        String departamentoSeleccionado = request.getParameter("departamentoSelect");
        request.setAttribute("departamentoSeleccionado", departamentoSeleccionado);
        DataDepartamento deseado = null;
        for(DataDepartamento depar: listdepartamentos) {
            if(depar.getNombre().equals(departamentoSeleccionado)) {
                deseado = depar;
                break;
            }
        }
        List<DataActividad> listaActividades = null;
        if (deseado != null) {
             listaActividades = sistema.getActividadesConfirmadas(deseado.getId());
            request.setAttribute("actividades", listaActividades);
        }
        String actividadSeleccionada = request.getParameter("actividadSelect");
        DataActividad ele = null;
        if(listaActividades!=null) {
        	for(DataActividad act: listaActividades) {
        		if(act.getNomAct().equals(actividadSeleccionada)) {
        			ele = act;
        		}
        	}  	      	
        	if(ele != null) {
        	   
        		request.setAttribute("readDescAct", ele.getDescripcion());
        		Integer dur = ele.getDuracion();
        		request.setAttribute("readDuracionAct", dur.toString());
        		Float costo = ele.getCosto();
        		request.setAttribute("readCostoAct", costo.toString());
        		request.setAttribute("readCiudadAct", ele.getCiudad());
        	    
        	}
        }   
        
        
        
        
        // mandar el formulario al usuario
        request.getRequestDispatcher("/WEB-INF/ConsultaActividad.jsp").forward(request, response);
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

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
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
		
		String actNomb = request.getParameter("inputNombreAct");
		String actDesc = request.getParameter("inputDescAct");
		String actDur = request.getParameter("inputDuracionAct");
		String actCosto = request.getParameter("inputCostoAct");
		String actCiudad = request.getParameter("inputCiudadAct");
		String actCateg = request.getParameter("categoriaSelect"); 
		String departamento = request.getParameter("departamentoSelect"); //aca es que obtenemos el departamento seleccionado
		Integer duracion;
		Float costo;
		//DataProveedor buscado = null;
		DataProveedor yo = (DataProveedor) objSesion.getAttribute("usuario_logueado");
		System.out.println(yo.getNombre());
		DataDepartamento deseado = null;
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
		
    }
	private DataActividad tomarDatos(String nomAct, DataProveedor prov, DataDepartamento dept, String descripcion, int duracion, float costo, String ciudad, List<DataCategoria> cat) {
		DataActividad newActividad = new DataActividad();		
		newActividad.setCiudad(ciudad);
		newActividad.setNomAct(nomAct);
		newActividad.setDescripcion(descripcion);
		newActividad.setDuracion(duracion);
		newActividad.setCosto(costo);		
		newActividad.setProv(prov);
		newActividad.setDept(dept);
		newActividad.setCategorias(cat);
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
        // me esta listando los departamentos cargados		
        List<DataCategoria> listCategoorias = sistema.getCategoriasData();
        request.setAttribute("categorias", listCategoorias);        
        // mandar el formulario al usuario
        request.getRequestDispatcher("/WEB-INF/AltaActividad.jsp").forward(request, response);
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

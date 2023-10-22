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
    	if(request.getParameter("idDepto") != null) {
        	String idD = request.getParameter("idDepto");
        	Long idDepartamento = Long.parseLong(idD);
        	List<DataActividad> actividades = sistema.getActividadesConfirmadas(idDepartamento);
        	String actividadesJson = gson.toJson(actividades);
            response.setContentType("application/json");
            response.getWriter().write(actividadesJson);
        }
	}
}


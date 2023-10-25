package com.labo2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logica.Fabrica;
import logica.ISistema;
import logica.Sistema;
import logica.datatypes.DataActividad;
import logica.datatypes.DataProveedor;
import logica.datatypes.DataTurista;
import logica.datatypes.DataPaqueteComprado;


import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;

/**
 * Servlet implementation class ListarActividadesServlet
 */
@WebServlet("/ListarPaquetesDisponiblesTurista")

public class ListaPaqueteDisponiblesTurista extends HttpServlet {	
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
    public ListaPaqueteDisponiblesTurista() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession objSesion = request.getSession();//lo usamos para mostrar mensajes en la sesion
		
		
		
		if(request.getParameter("cantTur") != null && request.getParameter("idActiv")!=null ) {
        	String idD = request.getParameter("idDepto");
        	Long idDepartamento = Long.parseLong(idD);
    		DataTurista yo = (DataTurista) objSesion.getAttribute("usuario_logueado");
    		
    		String idA = request.getParameter("idActiv");
    		String cant = request.getParameter("cantTur");
    		
        	List<DataPaqueteComprado> paquetes = sistema.listarPaqutesDisponiblesTurista(Integer.parseInt(cant),yo.getId(), Long.parseLong(idA)); // List<DataPaqueteComprado> listarPaqutesDisponiblesTurista(Integer cantTur, Long idTur, Long idAct)
        	String paquetesJson = gson.toJson(paquetes);
            response.setContentType("application/json");
            response.getWriter().write(paquetesJson);
        }else {
        	  response.setContentType("application/json");
              response.getWriter().write("[]");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

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

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;

/**
 * Servlet implementation class ListarActividadesServlet
 */
@WebServlet("/ListarActividades")

public class ListarActividadesServlet extends HttpServlet {	
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
    public ListarActividadesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession objSesion = request.getSession();//lo usamos para mostrar mensajes en la sesion

		
		if(request.getParameter("idDepto") != null) {
        	String idD = request.getParameter("idDepto");
        	Long idDepartamento = Long.parseLong(idD);
    		DataProveedor yo = (DataProveedor) objSesion.getAttribute("usuario_logueado");

        	List<DataActividad> actividades = sistema.getActividadesConfirmadasPorProveedor(idDepartamento, yo.getId());
        	String actividadesJson = gson.toJson(actividades);
            response.setContentType("application/json");
            response.getWriter().write(actividadesJson);
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

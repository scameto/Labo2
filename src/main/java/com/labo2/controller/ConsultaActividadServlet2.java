package com.labo2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;

import logica.Fabrica;
import logica.ISistema;
import logica.datatypes.DataProveedor;
import logica.datatypes.DataSalida;
import logica.datatypes.DataTurista;
import logica.datatypes.DataActividad;

@WebServlet("/consultaActividad")
public class ConsultaActividadServlet2 extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ISistema sistema;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        super.init();
        sistema = Fabrica.getInstance().getISistema();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession objSesion = request.getSession();
        
        if (request.getParameter("username") == null) {
            List<String> usernames = sistema.obtenerNombresTuristasYProveedores();

            if (usernames == null || usernames.isEmpty()) {
                objSesion.setAttribute("mensaje", "No hay usuarios para mostrar.");
            } else {
                request.setAttribute("usernames", usernames);
            }
            request.getRequestDispatcher("/WEB-INF/ConsultaActividad2.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String idAct = request.getParameter("idActividad");
        if (username != null) {
            DataTurista turista = sistema.findTurista(username);
            if(turista!= null) {
                String turistaJson = gson.toJson(turista);
                response.setContentType("application/json");
                response.getWriter().write(turistaJson);
            }else {
            	DataProveedor prov = sistema.findProveedor(username);
                String proveedorJson = gson.toJson(prov);
                response.setContentType("application/json");
                response.getWriter().write(proveedorJson);
            } 
        }else if(idAct != null) {
        	Long idActividad = Long.parseLong(idAct);
        	System.out.println(idActividad);
        	List<DataSalida> salidas = sistema.getSalidasData(idActividad);
        	request.setAttribute("salidas", salidas);
            String salidasJson = gson.toJson(salidas);
            response.setContentType("application/json");
            response.getWriter().write(salidasJson);
        } 
        else {
        	String usernameProv = (String)request.getParameter("usernameProv");
            List<DataActividad> actividades = (List<DataActividad>) sistema.getActividadesProveedorConfirmadas(usernameProv);
            System.out.println("actis " + actividades);
            request.setAttribute("listaActividades", actividades);
            String actividadesJson = gson.toJson(actividades);
            response.setContentType("application/json");
            response.getWriter().write(actividadesJson);
        }
    }
}

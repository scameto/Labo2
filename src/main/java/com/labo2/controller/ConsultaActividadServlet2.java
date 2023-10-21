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
import logica.datatypes.DataCategoria;
import logica.datatypes.DataDepartamento;

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
        
       
        if (request.getParameter("deptos") == null) {
            List<DataDepartamento> departamentos = (List<DataDepartamento>) sistema.getDepartamentosData();
            if (departamentos == null || departamentos.isEmpty()) {
                objSesion.setAttribute("mensaje", "No hay departamentos para mostrar.");
            } else {
                request.setAttribute("deptos", departamentos);
            }
        }
        if (request.getParameter("categoria") == null) {
            List<DataCategoria> categorias = (List<DataCategoria>) sistema.getCategoriasData();
            if (categorias == null || categorias.isEmpty()) {
                objSesion.setAttribute("mensaje", "No hay categorias para mostrar.");
            } else {
                request.setAttribute("categoria", categorias);
            }            
            request.getRequestDispatcher("/WEB-INF/ConsultaActividad2.jsp").forward(request, response);
        }
       
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	 if(request.getParameter("idDepto") != null) {
         	String idD = request.getParameter("idDepto");
         	Long idDepartamento = Long.parseLong(idD);
         	List<DataActividad> actividades = sistema.getActividadesConfirmadas(idDepartamento);
         	System.out.println( " asdsa" + actividades);
         	String actividadesJson = gson.toJson(actividades);
             response.setContentType("application/json");
             response.getWriter().write(actividadesJson);
         }
//        String username = request.getParameter("username");
//        String idAct = request.getParameter("idActividad");
//        DataDepartamento elegido = null;
//        if (username != null) {
//            List<DataDepartamento> dep = sistema.getDepartamentosData();
//            for(DataDepartamento de: dep) {
//            	if(de.getNombre().equals(username)) {
//            		elegido = de;
//            		break;
//            	}
//            }
//            if(elegido!= null) {
//                String departamentoJson = gson.toJson(elegido);
//                response.setContentType("application/json");
//                response.getWriter().write(departamentoJson);
//            
//            } 
//        }else if(idAct != null) {
//        	Long idActividad = Long.parseLong(idAct);
//        	System.out.println(idActividad);
//        	List<DataSalida> salidas = sistema.getSalidasData(idActividad);
//        	request.setAttribute("salidas", salidas);
//            String salidasJson = gson.toJson(salidas);
//            response.setContentType("application/json");
//            response.getWriter().write(salidasJson);
//        } 
//        else {
//        	String usernameProv = (String)request.getParameter("usernameProv");
//            List<DataActividad> actividades = (List<DataActividad>) sistema.getActividadesProveedorConfirmadas(usernameProv);
//            System.out.println("actis " + actividades);
//            request.setAttribute("listaActividades", actividades);
//            String actividadesJson = gson.toJson(actividades);
//            response.setContentType("application/json");
//            response.getWriter().write(actividadesJson);
//        }
    }
}

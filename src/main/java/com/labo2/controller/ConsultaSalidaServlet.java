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
import com.labo2.model.EstadoSesion;

import logica.Fabrica;
import logica.ISistema;
import logica.datatypes.DataProveedor;
import logica.datatypes.DataSalida;
import logica.datatypes.DataTurista;
import logica.datatypes.DataActividad;
import logica.datatypes.DataCategoria;
import logica.datatypes.DataDepartamento;
import logica.datatypes.DataPaquete;

@WebServlet("/consultaSalida")
public class ConsultaSalidaServlet extends HttpServlet {
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
            request.getRequestDispatcher("/WEB-INF/ConsultaSalida.jsp").forward(request, response);
        }       
    }    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	//cargamso las actividades confirmadas por departamento 
    	 if(request.getParameter("idDepto") != null) {
         	String idD = request.getParameter("idDepto");
         	Long idDepartamento = Long.parseLong(idD);
         	List<DataActividad> actividades = sistema.getActividadesConfirmadas(idDepartamento);
         	System.out.println( " asdsa" + actividades);
         	String actividadesJson = gson.toJson(actividades);
            response.setContentType("application/json");
            response.getWriter().write(actividadesJson);
         }
    	//cargamso las actividades confirmadas por categoria 
    	 if(request.getParameter("idCateg") != null) {
         	String idC = request.getParameter("idCateg");
         	Long logidC = Long.parseLong(idC);
         	DataCategoria cate = null;
         	List<DataCategoria> listaCat = (List<DataCategoria>) sistema.getCategoriasData();
         	for(DataCategoria cat: listaCat) {
         		if(cat.getId().equals(logidC)) {
         			cate = cat;
         			break;
         		}
         	}
	       if(cate !=null) {
	         	String nomCategoria = cate.getNombre();
	         	List<DataActividad> actividades = sistema.getActividadesPorCategoria(nomCategoria);
	         	String actividadesJson = gson.toJson(actividades);
	            response.setContentType("application/json");
	            response.getWriter().write(actividadesJson);
	        }else {
	            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	            response.getWriter().write("Categoria no encontrada");
	        }
         }
    	//cargando las salidas por actividad seleccionada
    	 if(request.getParameter("idPaquet") != null) {
          	String idP = request.getParameter("idPaquet");
          	Long idPaquete = Long.parseLong(idP);
          	List<DataPaquete> paquetes = sistema.getPaquetesPorActividadData(idPaquete);
          	System.out.println( " asdsa" + paquetes);
            String paquetesJson = (paquetes != null && !paquetes.isEmpty()) ? gson.toJson(paquetes) : "[]";
          	//String paquetesJson = gson.toJson(paquetes);
            response.setContentType("application/json");
            response.getWriter().write(paquetesJson);
          }
    	//cargando los Paquetes por actividad seleccionada
    	 if(request.getParameter("idActiv") != null) {
          	String idA = request.getParameter("idActiv");
          	Long idActividad = Long.parseLong(idA);
          	List<DataSalida> salidas = sistema.getSalidasData(idActividad);          	
          	System.out.println( " asdsa" + salidas);
          	String salidasJson = null;
          	if(salidas!=null && !salidas.isEmpty()) {
              	salidasJson = gson.toJson(salidas);
          	}else {
          		salidasJson = "[]";
          	}          	
            response.setContentType("application/json");
            response.getWriter().write(salidasJson);
          }    
    }
}

package com.labo2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logica.Fabrica;
import logica.ISistema;
import logica.datatypes.DataPaquete;

import java.io.IOException;
import java.util.List;

@WebServlet("/ConsultaPaqueteServlet")
public class ConsultaPaqueteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ISistema sistema;

    @Override
    public void init() throws ServletException {
        super.init();
        sistema = Fabrica.getInstance().getISistema();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession objSesion = request.getSession();

        List<DataPaquete> paquetes = sistema.getPaquetesData();
        System.out.println("Paquetes: " + paquetes);


        // Accedo al primer paquete de la lista
        DataPaquete primerPaquete = paquetes.get(0);

        // imprimo datos del primer paquete de la lista
        System.out.println("Nombre del primer paquete: " + primerPaquete.getNombre());
        System.out.println("Descripción del primer paquete: " + primerPaquete.getDescripcion());
        System.out.println("Validez del primer paquete: " + primerPaquete.getValidez());
        System.out.println("Descuento del primer paquete: " + primerPaquete.getDescuento());
        System.out.println("Actividades del paquete: " + primerPaquete.getActividades());

        
        if (paquetes == null || paquetes.isEmpty()) {
            objSesion.setAttribute("mensaje", "No hay paquetes para mostrar.");
        } else {
            request.setAttribute("paquetes", paquetes);
        }
        request.getRequestDispatcher("/WEB-INF/ConsultaPaquete.jsp").forward(request, response);
    }
    
  

    
    
}

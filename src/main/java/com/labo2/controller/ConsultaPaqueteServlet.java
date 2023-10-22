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


        if (paquetes == null || paquetes.isEmpty()) {
            objSesion.setAttribute("mensaje", "No hay paquetes para mostrar.");
        } else {
            request.setAttribute("paquetes", paquetes);
        }
        request.getRequestDispatcher("/WEB-INF/ConsultaPaquete.jsp").forward(request, response);
    }
    
  

    
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.model.Employees;
import com.model.Working;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author luisbonilla
 */
public class workingDetalleControllerE extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Working wop = new Working();
        Employees emp = new Employees();
        String msj = "";
        double total = 0;
        String type = "success";
        String available = "";
        try {
            wop.setId(Integer.parseInt(request.getParameter("txtId")));
            wop.setProject_id(Integer.parseInt(request.getParameter("slctProId")));
            wop.setEmployee_id(Integer.parseInt(request.getParameter("slctEmpId")));
            wop.setIn_pro_from(request.getParameter("datFrom"));
            wop.setIn_pro_to(request.getParameter("datTo"));
            wop.setNum_days((int)(wop.daysIn(request.getParameter("datFrom"), request.getParameter("datTo"))));
            wop.setCost(Double.parseDouble(request.getParameter("numCost")));
            total = (wop.daysIn(request.getParameter("datFrom"), request.getParameter("datTo"))) * (Double.parseDouble(request.getParameter("numCost")) / 30);
            wop.setTotal_cost(total);
            if (request.getParameter("btnCreate") != null) {
                    wop.setEmployee_id(Integer.parseInt(request.getParameter("slctEmpId")));
                    msj = wop.createWorking(wop);
            } else if (request.getParameter("btnUpdate") != null) {
                    wop.setEmployee_id(Integer.parseInt(request.getParameter("slctEmpId2")));
                    msj = wop.updateWorking(wop);
            } else {
                msj = wop.deleteWorking(wop);
            }
            request.getSession().setAttribute("msj", msj);
            request.getSession().setAttribute("type", type);
            request.getSession().setAttribute("conta", 1);
            response.sendRedirect("Employee/workingDetalle.jsp");
        } catch (Exception e) {
            request.getSession().setAttribute("error", e.toString());
            response.sendRedirect("error.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

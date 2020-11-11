package com.controller;

import com.model.Employees;
import com.model.Working;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
* Nombre del servlet: WorkingDetalleController
* Fecha: 23-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Ismael Castillo
 */
public class workingDetalleController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Working wop = new Working();
        Employees emp = new Employees();
        String msj = "";
        String type = "success";
        String available = "";
        try {
            wop.setId(Integer.parseInt(request.getParameter("txtId")));
            wop.setProject_id(Integer.parseInt(request.getParameter("slctProId")));
            wop.setEmployee_id(Integer.parseInt(request.getParameter("slctEmpId")));
            wop.setIn_pro_from(request.getParameter("datFrom"));
            wop.setIn_pro_to(request.getParameter("datTo"));
            wop.setCost(Double.parseDouble(request.getParameter("numCost")));
            available = emp.getEmp(wop.getEmployee_id()).getStatus();

            if (request.getParameter("btnCreate") != null) {
                if (available.equals("Available")) {
                    emp.changeStatus(wop, "Create");
                    msj = wop.createWorking(wop);
                } else {
                    msj = "No se pudo insertar el registro, el empleado seleccionado no está disponible";
                    type = "error";

                }

            } else if (request.getParameter("btnUpdate") != null) {
                if (available.equals("Available")) {
                    msj = wop.updateWorking(wop);

                }else {
                    msj = "No se pudo insertar el registro, el empleado seleccionado no está disponible "+ available;
                    type = "error";

                }

            } else {
                emp.changeStatus(wop, "Delete");
                msj = wop.deleteWorking(wop);
            }
            
            request.getSession().setAttribute("msj", msj);
            request.getSession().setAttribute("type", type);
            request.getSession().setAttribute("conta", 1);
            response.sendRedirect("workingDetalle.jsp");
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

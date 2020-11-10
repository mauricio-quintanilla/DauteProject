/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.model.Equipment;
import com.model.InUse;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author abc
 */
public class InUseDetController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        InUse inu = new InUse();
        Equipment equ = new Equipment();
        String msj = "";
        String type = "success";
        int stocker = 5;
        try {
            inu.setId(Integer.parseInt(request.getParameter("txtId")));
            inu.setEquipment_id(Integer.parseInt(request.getParameter("slctEqId")));
            inu.setProject_id(Integer.parseInt(request.getParameter("slctProId")));
            inu.setIn_pro_from(request.getParameter("datFrom"));
            inu.setIn_pro_to(request.getParameter("datTo"));
            inu.setEquipment_quantity(Integer.parseInt(request.getParameter("numEqQu")));
            inu.setCost(Double.parseDouble(request.getParameter("numCost")));

            //Integer.parseInt(request.getParameter("numEqQu")) >= equ.getEqu(inu.getId()).getStock()
            stocker = equ.getEqu(inu.getEquipment_id()).getStock();
            
            int cambio = inu.getEquipment_quantity();
            if (request.getParameter("btnCreate") != null) {
                if (cambio<=stocker) {
                    equ.updateStock(inu, 1);
                    msj = inu.createInUse(inu);
                }else {

                    msj = "No se pudo hacer la inserción, no hay stock sufiente. (Stock " + stocker + ")";
                    type = "error";
                }
            } else if (request.getParameter("btnUpdate") != null) {
                int cantEqu = Integer.parseInt(request.getParameter("vliStock"));
                if ((stocker + cantEqu - cambio) >= 0) {
                    equ.updateStock(inu, 1);
                    msj = inu.updateInUse(inu);
                } else {

                    msj = "No se pudo hacer la Modificación, no hay stock sufiente. (Stock " + stocker + ")";
                    type = "error";
                }

            } else {
                equ.updateStock(inu, 2);
                msj = inu.deleteInUse(inu);
            }

            request.getSession().setAttribute("conta", 1);
            request.getSession().setAttribute("msj", msj);
            request.getSession().setAttribute("type", type);
            response.sendRedirect("inUseDetalle.jsp");
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

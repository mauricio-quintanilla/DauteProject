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
import javax.servlet.http.HttpSession;

/**
 *
 * @author abc
 */
public class InUseDetController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
            HttpSession session = request.getSession();
            int usrId=0;
        InUse inu = new InUse();
        InUse pc = new InUse();
        Equipment equ = new Equipment();
        String msj = "";
        double totalM = 0.0;
        String type = "success";
        try {
            int idInp=Integer.parseInt(request.getParameter("txtId"));
            inu.setId(idInp);
            inu.setProject_id(Integer.parseInt(request.getParameter("slctProId")));
            inu.setIn_pro_from(request.getParameter("datFrom"));
            inu.setIn_pro_to(request.getParameter("datTo"));
            inu.setNum_days((int) inu.daysInUse(request.getParameter("datFrom"), request.getParameter("datTo")));
            inu.setEquipment_quantity(Integer.parseInt(request.getParameter("numEqQu")));
            inu.setCost(Double.parseDouble(request.getParameter("numCost")));
            totalM = (inu.daysInUse(request.getParameter("datFrom"), request.getParameter("datTo"))) * (Double.parseDouble(request.getParameter("numCost")) * Integer.parseInt(request.getParameter("numEqQu")));
            inu.setTotal_cost(totalM);
            usrId=Integer.parseInt(session.getAttribute("usrId").toString());
            if (request.getParameter("btnCreate") != null) {
                inu.setEquipment_id(Integer.parseInt(request.getParameter("slctEqIdA")));
                msj=inu.createInUse(inu);
                inu.trkLogC(usrId, inu);
            } else if (request.getParameter("btnUpdate") != null) {
                inu.setEquipment_id(Integer.parseInt(request.getParameter("slctEqIdU")));
                pc = pc.getInUse(idInp);
                msj=inu.updateInUse(inu);
                inu.trkLogU(usrId, inu, pc);
            } else {
                pc = pc.getInUse(idInp);
                msj=inu.deleteInUse(inu);
                inu.trkLogU(usrId, inu, pc);
            }
            
            HttpSession sesion = request.getSession();
            int rol = (Integer) sesion.getAttribute("rol");
            
            request.getSession().setAttribute("conta", 1);
            request.getSession().setAttribute("msj", msj);
            request.getSession().setAttribute("type", type);
            
            if (rol == 3) {
                response.sendRedirect("Employee/inUseDetalle.jsp");
            }
            else if (rol == 2) {
                response.sendRedirect("Management/inUseDetalle.jsp");
            }
            else{
                response.sendRedirect("inUseDetalle.jsp");
            }
            
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

package com.controller;

import com.model.Employees;
import com.model.Working;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        HttpSession session = request.getSession();
        int usrId=0;
        Working wop = new Working();
        Working pc = new Working();
        Employees emp = new Employees();
        String msj = "";
        double total = 0;
        String type = "success";
        String available = "";
        try {
            int idInp=Integer.parseInt(request.getParameter("txtId"));
            wop.setId(idInp);
            wop.setProject_id(Integer.parseInt(request.getParameter("slctProId")));
            wop.setEmployee_id(Integer.parseInt(request.getParameter("slctEmpId")));
            wop.setIn_pro_from(request.getParameter("datFrom"));
            wop.setIn_pro_to(request.getParameter("datTo"));
            wop.setNum_days((int)(wop.daysIn(request.getParameter("datFrom"), request.getParameter("datTo"))));
            wop.setCost(Double.parseDouble(request.getParameter("numCost")));
            usrId=Integer.parseInt(session.getAttribute("usrId").toString());
            total = (wop.daysIn(request.getParameter("datFrom"), request.getParameter("datTo"))) * (Double.parseDouble(request.getParameter("numCost")) / 30);
            wop.setTotal_cost(total);
            if (request.getParameter("btnCreate") != null) {
                wop.setEmployee_id(Integer.parseInt(request.getParameter("slctEmpId")));
                msj = wop.createWorking(wop);
                wop.trkLogC(usrId, wop);
            } else if (request.getParameter("btnUpdate") != null) {
                wop.setEmployee_id(Integer.parseInt(request.getParameter("slctEmpId2")));
                pc = pc.getWorking(idInp);
                msj=wop.updateWorking(wop);
                wop.trkLogU(usrId, wop, pc);
            } else {
                pc = pc.getWorking(idInp);
                msj=wop.deleteWorking(wop);
                wop.trkLogU(usrId, wop, pc);
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

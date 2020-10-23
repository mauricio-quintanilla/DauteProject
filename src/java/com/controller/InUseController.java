
package com.controller;

import com.model.InUse;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
* Nombre del servlet: InUseController
* Fecha: 22-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class InUseController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        InUse inu = new InUse();
        String msj="";
        try {
            inu.setId(Integer.parseInt(request.getParameter("txtId")));
            inu.setEquipment_id(Integer.parseInt(request.getParameter("slctEqId")));
            inu.setProject_id(Integer.parseInt(request.getParameter("slctProId")));
            inu.setEquipment_quantity(Integer.parseInt(request.getParameter("numEqQu")));
            if(request.getParameter("btnCreate")!=null){
                msj=inu.createInUse(inu);
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=inu.updateInUse(inu);
            }else{
                msj=inu.deleteInUse(inu);
            }
            response.sendRedirect("inuse.jsp");
            request.getSession().setAttribute("msj",msj);
        } catch (Exception e) {
            request.getSession().setAttribute("error",e.toString());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
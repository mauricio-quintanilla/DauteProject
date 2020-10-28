
package com.controller;

import com.model.Actions;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
* Nombre del servlet: ActionsController
* Fecha: 21-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class ActionsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Actions axn = new Actions();
        String msj="";
        try {
            axn.setId(Integer.parseInt(request.getParameter("txtAxnId")));
            axn.setName(request.getParameter("txtAxnName"));
            if(request.getParameter("btnCreate")!=null){
                msj=axn.createAction(axn);
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=axn.updateAction(axn);
            }else{
                msj=axn.deleteAtion(axn);
            }
            response.sendRedirect("actions.jsp");
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
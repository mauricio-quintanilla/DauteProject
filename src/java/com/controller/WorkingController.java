
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
* Nombre del servlet: WorkingController
* Fecha: 23-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class WorkingController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Working wop = new Working();
        Employees emp = new Employees();
        String msj="";
        try {
            wop.setId(Integer.parseInt(request.getParameter("txtId")));
            wop.setProject_id(Integer.parseInt(request.getParameter("slctProId")));
            wop.setEmployee_id(Integer.parseInt(request.getParameter("slctEmpId")));
            if(request.getParameter("btnCreate")!=null){
                emp.changeStatus(wop, "Create");
                msj=wop.createWorking(wop);
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=wop.updateWorking(wop);
            }else{
                emp.changeStatus(wop, "Delete");
                msj=wop.deleteWorking(wop);
            }
            response.sendRedirect("working.jsp");
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

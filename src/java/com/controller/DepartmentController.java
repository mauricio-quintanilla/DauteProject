
package com.controller;

import com.model.Department;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
* Nombre del servlet: DepartmentController
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
@WebServlet(name = "DepartmentController", urlPatterns = {"/departmentController"})
public class DepartmentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Department dpt = new Department();
        String msj="";
        HttpSession session = request.getSession();
        try {
            if (session.getAttribute("rolName") == null) {
                response.sendRedirect("login.jsp");
            }
            dpt.setId(Integer.parseInt(request.getParameter("txtDeptId")));
            dpt.setName(request.getParameter("txtDeptName"));
            if(request.getParameter("btnCreate")!=null){
                msj=dpt.createDept(dpt);
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=dpt.updateDept(dpt);
            }else{
                msj=dpt.deleteDept(dpt);
            }
            response.sendRedirect("department.jsp");
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
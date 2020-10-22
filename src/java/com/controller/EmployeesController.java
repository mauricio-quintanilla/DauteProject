
package com.controller;

import com.model.Employees;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
* Nombre del servlet: UsersController
* Fecha: 22-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class EmployeesController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Employees emp = new Employees();
        String msj="";
        try {
            emp.setId(Integer.parseInt(request.getParameter("txtId")));
            emp.setFirst_name(request.getParameter("txtName"));
            emp.setLast_name(request.getParameter("txtLast"));
            emp.setDob(request.getParameter("dapDob"));
            emp.setAddress(request.getParameter("txtAddress"));
            emp.setPhone_number(request.getParameter("txtPhone"));
            emp.setDui(request.getParameter("txtDui"));
            emp.setNit(request.getParameter("txtNit"));
            emp.setSalary(Double.parseDouble(request.getParameter("numSalary")));
            emp.setPosition_id(Integer.parseInt(request.getParameter("slctPos")));
            emp.setUser_id(Integer.parseInt(request.getParameter("slctUser")));
            emp.setImage(request.getParameter("image"));
            if(request.getParameter("btnCreate")!=null){
                msj=emp.createEmp(emp);
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=emp.updateEmp(emp);
            }else{
                msj=emp.deleteEmp(emp);
            }
            response.sendRedirect("employees.jsp");
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
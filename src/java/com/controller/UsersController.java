
package com.controller;

import com.model.Users;
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
public class UsersController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Users usr = new Users();
        String msj="";
        try {
            usr.setId(Integer.parseInt(request.getParameter("txtUsrId")));
            usr.setUser_name(request.getParameter("txtUsrName"));
            usr.setEmail(request.getParameter("txtUsrEmail"));
            usr.setPassword(request.getParameter("pwdPassword"));
            usr.setRole_id(Integer.parseInt(request.getParameter("slctRol")));
            usr.setPasswordV(request.getParameter("pwdPasswordHidden"));
            if(request.getParameter("btnCreate")!=null){
                msj=usr.createUser(usr);
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=usr.updateUser(usr);
            }else{
                msj=usr.deleteUser(usr);
            }
            response.sendRedirect("users.jsp");
            request.getSession().setAttribute("msj",msj);
            request.getSession().setAttribute("conta",1);
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
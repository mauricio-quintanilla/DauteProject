
package com.controller;

import com.model.Role;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
* Nombre del servlet: RoleController
* Fecha: 21-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class RoleController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Role rol = new Role();
        Role rc = new Role();
        String msj="";
        int usrId=0;
        try {
            int idr = Integer.parseInt(request.getParameter("txtRoleId"));
            rol.setId(idr);
            rol.setName(request.getParameter("txtRoleName"));
            usrId=Integer.parseInt(session.getAttribute("usrId").toString());
            if(request.getParameter("btnCreate")!=null){
                msj=rol.createRole(rol);
                rol.trkLogC(usrId, rol);
            }
            else if(request.getParameter("btnUpdate")!=null){
                rc = rol.getRole(idr);
                msj=rol.updateRole(rol);
                rol.trkLogU(usrId, rol, rc);
            }else{
                rc = rol.getRole(idr);
                msj=rol.deleteRole(rol);
                rol.trkLogD(usrId, rc);
            }
            response.sendRedirect("role.jsp");
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
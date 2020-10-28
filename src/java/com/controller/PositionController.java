
package com.controller;

import com.model.Position;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
* Nombre del servlet: PositionController
* Fecha: 21-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class PositionController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Position pos = new Position();
        String msj="";
        try {
            pos.setId(Integer.parseInt(request.getParameter("txtPosId")));
            pos.setName(request.getParameter("txtPosName"));
            int axnCode=0; //esta variable da el codigo de accion para historial de logs
            pos.setDepartment_id(Integer.parseInt(request.getParameter("slctDept")));
            if(request.getParameter("btnCreate")!=null){
                msj=pos.createPos(pos);
                axnCode=1;
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=pos.updatePos(pos);
                axnCode=2;
            }else{
                msj=pos.deletePos(pos);
                axnCode=3;
            }
            response.sendRedirect("position.jsp");
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

package com.controller;

import com.model.Position;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        HttpSession session = request.getSession();
        Position pos = new Position();
        Position pc = new Position();
        String msj="";
        int usrId=0;
        try {
            int idInp=Integer.parseInt(request.getParameter("txtPosId"));
            pos.setId(idInp);
            pos.setName(request.getParameter("txtPosName"));
            pos.setDepartment_id(Integer.parseInt(request.getParameter("slctDept")));
            usrId=Integer.parseInt(session.getAttribute("usrId").toString());
            if(request.getParameter("btnCreate")!=null){
                msj=pos.createPos(pos);
                pos.trkLogC(usrId, pos);
            }
            else if(request.getParameter("btnUpdate")!=null){
                pc = pos.getPos(idInp);
                msj=pos.updatePos(pos);
                pos.trkLogU(usrId, pos, pc);
            }else{
                pc = pos.getPos(idInp);
                msj=pos.deletePos(pos);
                pos.trkLogD(usrId, pc);
            }
            response.sendRedirect("position.jsp");
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
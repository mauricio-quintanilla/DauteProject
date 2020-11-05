
package com.controller;

import com.model.Project;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
* Nombre del servlet: ProjectController
* Fecha: 23-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class ProjectController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Project prj = new Project();
        String msj="";
        try {
            if(request.getParameter("btnMaquinaria")==null){
                prj.setId(Integer.parseInt(request.getParameter("txtId")));
                prj.setName(request.getParameter("txtName"));
                prj.setDescription(request.getParameter("txtDesc"));
                prj.setStarted_date(request.getParameter("dapStart"));
                prj.setFinish_date(request.getParameter("dapFinish"));
                prj.setAddress(request.getParameter("txtAddress"));
                prj.setLat(request.getParameter("my_lat"));
                prj.setLng(request.getParameter("my_lng"));
                prj.setClient_id(Integer.parseInt(request.getParameter("slctClient")));
            }
            
            if(request.getParameter("btnCreate")!=null){
                msj=prj.createPrj(prj);
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=prj.updatePrj(prj);
            }else{
                msj=prj.deletePrj(prj);
            }
            
            if(request.getParameter("btnMaquinaria")!=null){
                request.getSession().setAttribute("id_attr",Integer.parseInt(request.getParameter("idHidden")));
                request.getSession().setAttribute("name_attr",request.getParameter("nameHidden"));
                response.sendRedirect("proyectMachineryInUse.jsp");
                
            }else{
                response.sendRedirect("project.jsp");
                request.getSession().setAttribute("msj",msj);
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("error",e.toString());
            response.sendRedirect("error.jsp");
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
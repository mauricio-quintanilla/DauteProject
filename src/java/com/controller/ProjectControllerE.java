/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controller;

import com.model.Project;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author luisbonilla
 */
public class ProjectControllerE extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Project prj = new Project();
        String msj="";
        String status="";
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
                prj.setStatus("no-iniciado");
                msj=prj.createPrj(prj);
            }
            else if(request.getParameter("btnUpdate")!=null){
                prj.setStatus(prj.setProStatus(prj.getId()));
                msj=prj.updatePrj(prj);
            }else{
                msj=prj.deletePrj(prj);
            }
            
            if(request.getParameter("btnMaquinaria")!=null){
                request.getSession().setAttribute("id_attr",Integer.parseInt(request.getParameter("idHidden")));
                request.getSession().setAttribute("name_attr",request.getParameter("nameHidden"));
                request.getSession().setAttribute("status_attr",request.getParameter("statusHidden"));
                request.getSession().setAttribute("dIni",request.getParameter("dsHidden"));
                request.getSession().setAttribute("dFin",request.getParameter("dfHidden"));
                response.sendRedirect("Employee/proyectAdd.jsp");
                
            }else{
                response.sendRedirect("Employee/project.jsp");
                request.getSession().setAttribute("msj",msj);
                request.getSession().setAttribute("conta",1);
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("error",e.toString());
            response.sendRedirect("error.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

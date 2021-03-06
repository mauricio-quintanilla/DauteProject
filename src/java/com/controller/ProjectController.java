package com.controller;

import com.model.Project;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        HttpSession session = request.getSession();
        int usrId=0;
        PrintWriter out = response.getWriter();
        Project prj = new Project();
        Project pc = new Project();
        String msj = "";
        String status = "";
        try {
            if (request.getParameter("btnMaquinaria") == null) {
                usrId=Integer.parseInt(session.getAttribute("usrId").toString());
                int idInp=Integer.parseInt(request.getParameter("txtId"));
                prj.setId(idInp);
                prj.setName(request.getParameter("txtName"));
                prj.setDescription(request.getParameter("txtDesc"));
                prj.setStarted_date(request.getParameter("dapStart"));
                prj.setFinish_date(request.getParameter("dapFinish"));
                prj.setAddress(request.getParameter("txtAddress"));
                prj.setLat(request.getParameter("my_lat"));
                prj.setLng(request.getParameter("my_lng"));
                prj.setClient_id(Integer.parseInt(request.getParameter("slctClient")));
                if (request.getParameter("btnCreate") != null) {
                    prj.setStatus("no-iniciado");
                    msj = prj.createPrj(prj);
                    prj.trkLogC(usrId, prj);
                } else if (request.getParameter("btnUpdate") != null) {

                    prj.setId(idInp);
                    prj.setStatus(prj.setProStatus(prj.getId()));
                    pc = pc.getProyect(idInp);
                    msj = prj.updatePrj(prj);
                    prj.trkLogU(usrId, prj, pc);
                } else {

                    prj.setId(idInp);
                    pc = pc.getProyect(idInp);
                    msj = prj.deletePrj(prj);
                    prj.trkLogD(usrId, pc);
                }
            }
            
            if (msj.contains("error")) {
                    request.getSession().setAttribute("type", "error");
                } else {
                    request.getSession().setAttribute("type", "success");
                }
            
            HttpSession sesion = request.getSession();
            int rol = (Integer) sesion.getAttribute("rol");

            if (request.getParameter("btnMaquinaria") != null) {
                request.getSession().setAttribute("id_attr", Integer.parseInt(request.getParameter("idHidden")));
                request.getSession().setAttribute("name_attr", request.getParameter("nameHidden"));
                request.getSession().setAttribute("status_attr", request.getParameter("statusHidden"));
                request.getSession().setAttribute("dIni", request.getParameter("dsHidden"));
                request.getSession().setAttribute("dFin", request.getParameter("dfHidden"));
                
                if (rol == 3) {
                    response.sendRedirect("Employee/proyectAdd.jsp");
                }
                else if (rol == 2) {
                    response.sendRedirect("Management/proyectAdd.jsp");
                }
                else{
                    response.sendRedirect("proyectAdd.jsp");
                }
                

            } else {
                if (rol == 3) {
                    response.sendRedirect("Employee/project.jsp");
                }
                else if (rol == 2) {
                    response.sendRedirect("Management/project.jsp");
                }
                else{
                    response.sendRedirect("project.jsp");
                }
                
                request.getSession().setAttribute("msj", msj);
                request.getSession().setAttribute("conta", 1);
            }

        } catch (Exception e) {
            request.getSession().setAttribute("error", e.toString());
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

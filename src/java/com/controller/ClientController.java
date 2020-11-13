package com.controller;

import com.model.Client;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

/*
* Nombre del servlet: ClientController
* Fecha: 22-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
 */
public class ClientController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int usrId = 0;
        Client cli = new Client();
        Client pc = new Client();
        String msj = "";
        try {
            int idInp = Integer.parseInt(request.getParameter("txtId"));
            cli.setId(idInp);
            cli.setName(request.getParameter("txtName"));
            cli.setEmail(request.getParameter("txtEmail"));
            cli.setPhone_number(request.getParameter("txtPhone"));
            cli.setNit(request.getParameter("txtNit"));
            cli.setCompany_name(request.getParameter("txtComName"));
            cli.setCompany_address(request.getParameter("txtComAdd"));
            cli.setUser_id(Integer.parseInt(request.getParameter("slctUser")));
            usrId = Integer.parseInt(session.getAttribute("usrId").toString());
            if (request.getParameter("btnCreate") != null) {
                msj = cli.createClient(cli);
                cli.trkLogC(usrId, cli);
            } else if (request.getParameter("btnUpdate") != null) {
                pc = pc.getClientPjct(idInp);
                msj = cli.updateClient(cli);
                cli.trkLogU(usrId, cli, pc);
            } else {
                pc = pc.getClientPjct(idInp);
                msj = cli.deleteClient(cli);
                cli.trkLogD(usrId, pc);
            }

            if (msj.contains("error")) {
                request.getSession().setAttribute("type", "error");
            } else {
                request.getSession().setAttribute("type", "success");
            }
            
            HttpSession sesion = request.getSession();
            int rol = (Integer) sesion.getAttribute("rol");
            
            request.getSession().setAttribute("msj", msj);
            request.getSession().setAttribute("conta", 1);
            
            if (rol == 3) {
                response.sendRedirect("Employee/client.jsp");
            }
            else if (rol == 2) {
                response.sendRedirect("Management/client.jsp");
            }
            else{
                response.sendRedirect("client.jsp");
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", e.toString());
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

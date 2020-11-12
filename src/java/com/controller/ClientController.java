
package com.controller;

import com.model.Client;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        Client cli = new Client();
        String msj="";
        try {
            cli.setId(Integer.parseInt(request.getParameter("txtId")));
            cli.setName(request.getParameter("txtName"));
            cli.setEmail(request.getParameter("txtEmail"));
            cli.setPhone_number(request.getParameter("txtPhone"));
            cli.setNit(request.getParameter("txtNit"));
            cli.setCompany_name(request.getParameter("txtComName"));
            cli.setCompany_address(request.getParameter("txtComAdd"));
            cli.setUser_id(Integer.parseInt(request.getParameter("slctUser")));
            if(request.getParameter("btnCreate")!=null){
                msj=cli.createClient(cli);
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=cli.updateClient(cli);
            }else{
                msj=cli.deleteClient(cli);
            }
            
            if("Error dato unico repetido".equals(msj)){
                request.getSession().setAttribute("type","error");
            }else{
                request.getSession().setAttribute("type","success");
            }
            
            response.sendRedirect("client.jsp");
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
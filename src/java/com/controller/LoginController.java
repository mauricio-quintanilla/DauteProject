
package com.controller;

import com.model.Employees;
import com.model.Role;
import com.model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;


/*
* Nombre del servlet: LoginController
* Fecha: 27-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
 */
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        try {
            int level=0;
            if(request.getParameter("btnLogIn")!=null){
                Users usr = new Users();
                Role rol = new Role();
                Employees emp = new Employees();
                String usrImp= request.getParameter("txtUser");
                String passw= request.getParameter("pwdPwd");
                usr=usr.validateUser(usrImp, passw);
                level=usr.getRole_id();
                if(level>0){
                    String usrOnSess =emp.getEmpSes(usr.getId()).getFirst_name()+" "+emp.getEmpSes(usr.getId()).getLast_name();
                    String rolName = rol.getRole(usr.getRole_id()).getName();
                    String profPic = emp.getEmpSes(usr.getId()).getImage();
                    session.setAttribute("usrOnSess",usrOnSess);
                    session.setAttribute("usrId",usr.getId());
                    session.setAttribute("rolName",rolName);
                    session.setAttribute("profPic",profPic);
                    response.sendRedirect("index.jsp");
                }
                else{
                    JOptionPane.showMessageDialog(null, "invalid user or pwd" + level);
                    response.sendRedirect("login.jsp");
                }
            }
            if(request.getParameter("logout")!=null){
                session.invalidate();
                JOptionPane.showMessageDialog(null, "successfuly logged out");
                response.sendRedirect("login.jsp?logout");
            }
            if(request.getParameter("nosession")!=null){
                session.invalidate();
                JOptionPane.showMessageDialog(null, "log in is needed");
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("Error", e.toString());
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

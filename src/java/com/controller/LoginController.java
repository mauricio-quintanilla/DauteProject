
package com.controller;

import com.model.Client;
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

/*
* Nombre del servlet: LoginController
* Fecha: 27-10-2020
* CopyRight: OpenSource
* Version: 2.0
* @author Quintanilla Bernabe, ismael
 */
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String vali = "";
        try {
            int level=0;
            
            if(request.getParameter("btnLogIn")!=null){
                Users usr = new Users();
                Role rol = new Role();
                Client cli = new Client();
                Employees emp = new Employees();
                String usrImp= request.getParameter("txtUser");
                String passw= request.getParameter("pwdPwd");
                usr=usr.validateUser(usrImp, passw);
                level=usr.getRole_id();
                String profPic;
                String usrOnSess;
                if(level>0){
                    
                    if(level!=4){
                        usrOnSess =emp.getEmpSes(usr.getId()).getFirst_name()+" "+emp.getEmpSes(usr.getId()).getLast_name();         
                        profPic = emp.getEmpSes(usr.getId()).getImage();
                        session.setAttribute("profPic",profPic);
                        session.setAttribute("Id",emp.getEmp(usr.getId()).getId());
                    }else{
                        usrOnSess = cli.getClient(usr.getId()).getName();
                        session.setAttribute("Id",cli.getClient(usr.getId()).getId());//I del Cliente
                        
                    }
                    String rolName = rol.getRole(usr.getRole_id()).getName();
                    session.setAttribute("usrId",usr.getId());//id del user
                    session.setAttribute("rolName",rolName);
                    session.setAttribute("rol",level);
                    session.setAttribute("usrOnSess",usrOnSess);//name del user
                    session.setAttribute("bandera2",1);
                    
                    if(level==1){
                        response.sendRedirect("index.jsp");
                    }else if(level==2){
                        response.sendRedirect("index.jsp");
                    }else if(level==3){
                        response.sendRedirect("project.jsp");
                    }else if(level==4){
                        response.sendRedirect("Client/clientMenu.jsp");
                    }
                        
                    
                }
                else{
                    //aqui una alerta de invalid user or password
                    //JOptionPane.showMessageDialog(null, "invalid user or pwd" + level);
                     vali = "Usuario o contraseña invalido";
                    session.setAttribute("vl",vali);
                    session.setAttribute("bandera",1);//valida que no aparezca el mensaje más de una vez al recargar la pagina
                    response.sendRedirect("login.jsp");
                }
            }
            if(request.getParameter("logout")!=null){
                session.invalidate();
                
                response.sendRedirect("login.jsp?logout");
            }
            if(request.getParameter("nosession")!=null){
                
                vali = "Necesita iniciar sesion para entrar al Constru SV";
                session.setAttribute("vl",vali);//---Mensaje
                session.setAttribute("bandera",1);
                session.invalidate();
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

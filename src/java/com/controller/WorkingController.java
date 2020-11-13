
package com.controller;

import com.model.Employees;
import com.model.Working;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
* Nombre del servlet: WorkingController
* Fecha: 23-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class WorkingController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int usrId=0;
        Working wop = new Working();
        Working pc = new Working();
        Employees emp = new Employees();
        String msj="";
        double total = 0;
        try {
            int idInp=Integer.parseInt(request.getParameter("txtId"));
            wop.setId(idInp);
            wop.setProject_id(Integer.parseInt(request.getParameter("slctProId")));
            wop.setEmployee_id(Integer.parseInt(request.getParameter("slctEmpId")));
            wop.setIn_pro_from(request.getParameter("datFrom"));
            wop.setIn_pro_to(request.getParameter("datTo"));
            wop.setIn_pro_to(request.getParameter("datTo"));
            wop.setNum_days((int)(wop.daysIn(request.getParameter("datFrom"), request.getParameter("datTo"))));
            wop.setCost(Double.parseDouble(request.getParameter("numCost")));
            usrId=Integer.parseInt(session.getAttribute("usrId").toString());
            total = (wop.daysIn(request.getParameter("datFrom"), request.getParameter("datTo"))) * (Double.parseDouble(request.getParameter("numCost")));
            wop.setTotal_cost(total);
            if(request.getParameter("btnCreate")!=null){
                msj=wop.createWorking(wop);
                wop.trkLogC(usrId, wop);
            }
            else if(request.getParameter("btnUpdate")!=null){
                pc = pc.getWorking(idInp);
                msj=wop.updateWorking(wop);
                wop.trkLogU(usrId, wop, pc);
            }else{
                pc = pc.getWorking(idInp);
                msj=wop.deleteWorking(wop);
                wop.trkLogU(usrId, wop, pc);
            }
            HttpSession sesion = request.getSession();
            int rol = (Integer) sesion.getAttribute("rol");
            
            if (rol == 3) {
                response.sendRedirect("Employee/working.jsp");
            }else{
                response.sendRedirect("working.jsp");
            }
            
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

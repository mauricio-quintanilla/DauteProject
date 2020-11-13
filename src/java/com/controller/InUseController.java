    
package com.controller;

import com.model.Equipment;
import com.model.InUse;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
* Nombre del servlet: InUseController
* Fecha: 22-10-2020, 7-11-2020
* CopyRight: OpenSource
* Version: 2.0
* @author Quintanilla Bernabe, Ismael
*/
public class InUseController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int usrId=0;
        InUse inu = new InUse();
        InUse pc = new InUse();
        Equipment equ= new Equipment();
        double totalM = 0.0;
        String msj="";
        try {
            int idInp=Integer.parseInt(request.getParameter("txtId"));
            inu.setId(idInp);
            inu.setEquipment_id(Integer.parseInt(request.getParameter("slctEqId")));
            inu.setProject_id(Integer.parseInt(request.getParameter("slctProId")));
            inu.setIn_pro_from(request.getParameter("datFrom"));
            inu.setIn_pro_to(request.getParameter("datTo"));
            inu.setNum_days((int) inu.daysInUse(request.getParameter("datFrom"), request.getParameter("datTo")));
            inu.setEquipment_quantity(Integer.parseInt(request.getParameter("numEqQu")));
            inu.setCost(Double.parseDouble(request.getParameter("numCost")));
            totalM = (inu.daysInUse(request.getParameter("datFrom"), request.getParameter("datTo"))) * (Double.parseDouble(request.getParameter("numCost")) * Integer.parseInt(request.getParameter("numEqQu")));
            inu.setTotal_cost(totalM);
            usrId=Integer.parseInt(session.getAttribute("usrId").toString());
            if(request.getParameter("btnCreate")!=null){
                msj=inu.createInUse(inu);
                inu.trkLogC(usrId, inu);
            }
            else if(request.getParameter("btnUpdate")!=null){
                pc = pc.getInUse(idInp);
                msj=inu.updateInUse(inu);
                inu.trkLogU(usrId, inu, pc);
            }else{
                pc = pc.getInUse(idInp);
                msj=inu.deleteInUse(inu);
                inu.trkLogU(usrId, inu, pc);
            }
            response.sendRedirect("inuse.jsp");
            request.getSession().setAttribute("msj",msj);
            request.getSession().setAttribute("conta",1);
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
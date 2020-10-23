
package com.controller;

import com.model.Equipment;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
* Nombre del servlet: EquipmentController
* Fecha: 22-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class EquipmentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
        Equipment equ = new Equipment();
        String msj="";
        try {
            equ.setId(Integer.parseInt(request.getParameter("txtId")));
            equ.setName(request.getParameter("txtName"));
            equ.setModel(request.getParameter("txtModel"));
            equ.setDescription(request.getParameter("txtDesc"));
            equ.setBrand(request.getParameter("txtBrand"));
            equ.setStock(Integer.parseInt(request.getParameter("numStock")));
            equ.setInventory(Integer.parseInt(request.getParameter("numInv")));
            equ.setType(Integer.parseInt(request.getParameter("numType")));
            equ.setFuel_rate(Double.parseDouble(request.getParameter("numFuel")));
            equ.setImage(request.getParameter("fileImg"));
            if(request.getParameter("btnCreate")!=null){
                msj=equ.createEqu(equ);
            }
            else if(request.getParameter("btnUpdate")!=null){
                msj=equ.updateEqu(equ);
            }else{
                msj=equ.deleteEqu(equ);
            }
            response.sendRedirect("equipment.jsp");
            request.getSession().setAttribute("msj",msj);
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
package com.controller;

import com.model.Equipment;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/*
* Nombre del servlet: EquipmentController
* Fecha: 22-10-2020
* CopyRight: OpenSource
* Version: 2.0
* @author Quintanilla Bernabe, Ismael Castillo
 */
public class EquipmentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        Equipment equ = new Equipment();
        String img="";
        String msj = "";
        try {
                FileItemFactory file = new DiskFileItemFactory();
                ServletFileUpload fileUpload = new ServletFileUpload(file);
                List items = fileUpload.parseRequest(request);
            if (request.getParameter("btnDelete") != null) {
                for (int i = 0; i < items.size(); i++) {
                    FileItem fileItem = (FileItem) items.get(i);
                    if (fileItem.isFormField()) {
                        if (fileItem.getFieldName().equals("txtId")) {
                            equ.setId(Integer.parseInt(fileItem.getString()));
                        }
                    }
                }
                msj = equ.deleteEqu(equ);
            }else{
                ArrayList<String> lista = new ArrayList<>();
                for (int i = 0; i < items.size(); i++) {
                    FileItem fileItem = (FileItem) items.get(i);
                    if (!fileItem.isFormField()) {
                        if(fileItem.getName()!=""){
                            File f = new File("C:\\Users\\demon\\Documents\\NetBeansProjects\\DauteProject\\web\\imgs\\" + fileItem.getName());
                            fileItem.write(f);
                            equ.setImage(fileItem.getName());
                        }else
                            img="noproject.png";
                    } else {
                        lista.add(fileItem.getString());
                    }
                }
                equ.setId(Integer.parseInt(lista.get(0)));
                equ.setName(lista.get(1));
                equ.setModel(lista.get(2));
                equ.setDescription(lista.get(3));
                equ.setBrand(lista.get(4));
                equ.setStock(Integer.parseInt(lista.get(5)));
                equ.setInventory(Integer.parseInt(lista.get(6)));
                equ.setType(Integer.parseInt(lista.get(7)));
                equ.setRentalPrice(Double.parseDouble(lista.get(8)));
                if(request.getParameter("btnCreate")!=null){
                    if(img!="")
                        equ.setImage(img);
                    msj=equ.createEqu(equ);
                }
                if(request.getParameter("btnUpdate")!=null){
                    if(img!="")
                        equ.setImage(lista.get(9));
                    msj=equ.updateEqu(equ);
                }
            }
            request.getSession().setAttribute("msj",msj);
            response.sendRedirect("equipment.jsp");
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

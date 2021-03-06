package com.controller;

import com.model.Employees;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/*
* Nombre del servlet: UsersController
* Fecha: 22-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
 */
public class EmployeesController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int usrId=0;
        Employees emp = new Employees();
        Employees pc = new Employees();
        String msj = "";
        String img = "";
        int idInp = 0;
        try {
            FileItemFactory file = new DiskFileItemFactory();
            ServletFileUpload fileUpload = new ServletFileUpload(file);
            List items = fileUpload.parseRequest(request);
            usrId=Integer.parseInt(session.getAttribute("usrId").toString());
            if (request.getParameter("btnDelete") != null) {
                for (int i = 0; i < items.size(); i++) {
                    FileItem fileItem = (FileItem) items.get(i);
                    if (fileItem.isFormField()) {
                        if (fileItem.getFieldName().equals("txtId")) {
                            idInp=Integer.parseInt(fileItem.getString());
                            emp.setId(idInp);
                        }
                    }
                }
                pc = pc.getEmp(idInp);
                msj = emp.deleteEmp(emp);
                emp.trkLogD(usrId, emp);
            } else {
                ArrayList<String> lista = new ArrayList<>();
                for (int i = 0; i < items.size(); i++) {
                    FileItem fileItem = (FileItem) items.get(i);
                    if (!fileItem.isFormField()) {
                        if(fileItem.getName()!=""){
                            File f = new File("C:\\Users\\demon\\Documents\\NetBeansProjects\\DauteProject\\web\\imgs\\" + fileItem.getName());
                            fileItem.write(f);
                            emp.setImage(fileItem.getName());
                        }else
                            img="nopic.png";
                    } else {
                        lista.add(fileItem.getString());
                    }
                }
                idInp=Integer.parseInt(lista.get(0));
                emp.setId(idInp);
                emp.setFirst_name(lista.get(1));
                emp.setLast_name(lista.get(2));
                emp.setDob(lista.get(3));
                emp.setAddress(lista.get(4));
                emp.setPhone_number(lista.get(5));
                emp.setDui(lista.get(6));
                emp.setNit(lista.get(7));
                emp.setSalary(Double.parseDouble(lista.get(8)));
                emp.setPosition_id(Integer.parseInt(lista.get(9)));
                emp.setUser_id(Integer.parseInt(lista.get(10)));
                if (request.getParameter("btnCreate") != null) {
                    if(img!="")
                        emp.setImage(img);
                    pc = pc.getEmp(idInp);
                    msj = emp.createEmp(emp);
                    emp.trkLogC(usrId, emp);
                }
                if (request.getParameter("btnUpdate") != null) {
                    if(img!="")
                        emp.setImage(lista.get(11));
                    pc = pc.getEmp(idInp);
                    msj = emp.updateEmp(emp);
                    emp.trkLogU(usrId, emp, pc);
                }
            }
            if (msj.contains("error")) {
                request.getSession().setAttribute("type", "error");
            } else {
                request.getSession().setAttribute("type", "success");
            }
            
            
            HttpSession sesion = request.getSession();
            int rol = (Integer) sesion.getAttribute("rol");
        
            if (rol == 2) {
                response.sendRedirect("Management/employees.jsp");
            }
            else{
                response.sendRedirect("employees.jsp");
            }
            
            request.getSession().setAttribute("msj", msj);
            request.getSession().setAttribute("conta",1);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.toString());
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

package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Working
* Fecha: 19-10-2020, 7-11-2020
* CopyRight: OpenSource
* Version: 2.0
* @author Quintanilla Bernabe, ismael
 */
public class Working extends Conexion {

    private int id;
    private int project_id;
    private int employee_id;
    private String in_pro_from;
    private String in_pro_to;
    private int num_days;
    private double cost;
    private double total_cost;
    public Working() {
    }

    public Working(int id, int project_id, int employee_id, String in_pro_from, String in_pro_to, int num_days, double cost, double total_cost) {
        this.id = id;
        this.project_id = project_id;
        this.employee_id = employee_id;
        this.in_pro_from = in_pro_from;
        this.in_pro_to = in_pro_to;
        this.num_days = num_days;
        this.total_cost = total_cost;
    }

    //<editor-fold defaultstate="collapsed" desc="getters y setters">
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getProject_id() {
        return project_id;
    }
    
    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }
    
    public int getEmployee_id() {
        return employee_id;
    }
    
    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }
    
    public String getIn_pro_from() {
        return in_pro_from;
    }
    
    public void setIn_pro_from(String in_pro_from) {
        this.in_pro_from = in_pro_from;
    }
    
    public String getIn_pro_to() {
        return in_pro_to;
    }
    
    public void setIn_pro_to(String in_pro_to) {
        this.in_pro_to = in_pro_to;
    }

    public int getNum_days() {
        return num_days;
    }

    public void setNum_days(int num_days) {
        this.num_days = num_days;
    }
    
    public double getCost() {
        return cost;
    }
    
    public void setCost(double cost) {
        this.cost = cost;
    }

    public double getTotal_cost() {
        return total_cost;
    }

    public void setTotal_cost(double total_cost) {
        this.total_cost = total_cost;
    }
    
    
//</editor-fold>

    public String createWorking(Working wop) {
        try {
            this.conectar();
            String sql = "INSERT INTO working_on_project VALUES(?,?,?,?,?,?,?,?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setInt(2, wop.getProject_id());
            pre.setInt(3, wop.getEmployee_id());
            pre.setString(4, wop.getIn_pro_from());
            pre.setString(5, wop.getIn_pro_to());
            pre.setInt(6, wop.getNum_days());
            pre.setDouble(7, wop.getCost());
            pre.setDouble(8, wop.getTotal_cost());
            pre.executeUpdate();
            return "Employee successfuly added to project";
        } catch (Exception e) {
            return "error " + e.getMessage();
        } finally {
            this.desconectar();
        }
    }

    public String updateWorking(Working wop) {
        try {
            this.conectar();
            String sql = "UPDATE working_on_project SET project_id=?, employee_id=?, in_pro_from=?, in_pro_to=?, num_days=?, cost=?, total_cost=? WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, wop.getProject_id());
            pre.setInt(2, wop.getEmployee_id());
            pre.setString(3, wop.getIn_pro_from());
            pre.setString(4, wop.getIn_pro_to());
            pre.setInt(5, wop.getNum_days());
            pre.setDouble(6, wop.getCost());
            pre.setDouble(7, wop.getTotal_cost());
            pre.setInt(8, wop.getId());
            
            pre.executeUpdate();
            return "Employee on project successfuly updated";
        } catch (Exception e) {
            return "error " + e.getMessage();
        } finally {
            this.desconectar();
        }
    }

    public String deleteWorking(Working wop) {
        try {
            this.conectar();
            String sql = "DELETE FROM working_on_project WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, wop.getId());
            pre.executeUpdate();
            return "Employee successfuly removed from project";
        } catch (Exception e) {
            return "error " + e.getMessage();
        } finally {
            this.desconectar();
        }
    }

    public List<Working> showWorking() {
        List<Working> listaWop = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql = "SELECT * from working_on_project";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            res = pre.executeQuery();
            while (res.next()) {
                Working wop = new Working();
                wop.setId(res.getInt("id"));
                wop.setProject_id(res.getInt("project_id"));
                wop.setEmployee_id(res.getInt("employee_id"));
                wop.setIn_pro_from(res.getString("in_pro_from"));
                wop.setIn_pro_to(res.getString("in_pro_to"));
                wop.setNum_days(res.getInt("num_days"));
                wop.setCost(res.getDouble("cost"));
                listaWop.add(wop);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listaWop;
    }

    public List<Working> showWorkingByPro(int id) {
        List<Working> listaWop = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql = "SELECT * from working_on_project WHERE project_id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, id);
            res = pre.executeQuery();
            while (res.next()) {
                Working wop = new Working();
                wop.setId(res.getInt("id"));
                wop.setProject_id(res.getInt("project_id"));
                wop.setEmployee_id(res.getInt("employee_id"));
                wop.setIn_pro_from(res.getString("in_pro_from"));
                wop.setIn_pro_to(res.getString("in_pro_to"));
                wop.setNum_days(res.getInt("num_days"));
                wop.setCost(res.getDouble("cost"));
                listaWop.add(wop);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listaWop;
    }
    public Working getWorking(int id){
        Working wop = new Working();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="SELECT * FROM working_on_project WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while (res.next()) {
                wop.setId(res.getInt("id"));
                wop.setProject_id(res.getInt("project_id"));
                wop.setEmployee_id(res.getInt("employee_id"));
                wop.setIn_pro_from(res.getString("in_pro_from"));
                wop.setIn_pro_to(res.getString("in_pro_to"));
                wop.setNum_days(res.getInt("num_days"));
                wop.setCost(res.getDouble("cost"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return wop;
    }

    public double daysIn(String dateStarts, String dateEnds) {
        LocalDate dateBefore = LocalDate.parse(dateStarts);
        LocalDate dateAfter = LocalDate.parse(dateEnds);
        double nod = (ChronoUnit.DAYS.between(dateBefore, dateAfter))+1;
        return nod;
    }
    public void trkLogC(int usrId, Working di) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Working in proj");
        lgs.setAction_id("created");
        lgs.setDescription(" -project id: " + di.getProject_id()+ " -employee id: " + di.getEmployee_id()+ 
                " -from: " + di.getIn_pro_from()+ 
                " -to: "+ di.getIn_pro_to()+
                " -num of days: " +di.getNum_days()+
                " -Cost: " +di.getCost());
        lgs.createLogs(lgs);
    }
    public void trkLogU(int usrId, Working di, Working dc) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Working in proj"); 
        lgs.setAction_id("updated");
        if (di.getProject_id()!= (dc.getProject_id())) {
            lgs.setDescription("project id from: " + dc.getProject_id()+ " to " + di.getProject_id() + "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (di.getEmployee_id()!= (dc.getEmployee_id())) {
            lgs.setDescription("employee id from: " + dc.getEmployee_id()+ " to " + di.getEmployee_id()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (!di.getIn_pro_from().equals(dc.getIn_pro_from())) {
            lgs.setDescription("in_project_from from: " + dc.getIn_pro_from()+ " to " + di.getIn_pro_from()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (!di.getIn_pro_to().equals(dc.getIn_pro_to())) {
            lgs.setDescription("in_project_to from: " + dc.getIn_pro_to()+ " to " + di.getIn_pro_to()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (di.getNum_days()!= (dc.getNum_days())) {
            lgs.setDescription("num of days from: " + dc.getNum_days()+ " to " + di.getNum_days()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (di.getCost()!= (dc.getCost())) {
            lgs.setDescription("Cost from: $" + dc.getCost()+ " to $" + di.getCost()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
    }
    public void trkLogD(int usrId, Working di) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Working in proj");
        lgs.setAction_id("deleted");
        lgs.setDescription(" -project id: " + di.getProject_id()+ " -employee id: " + di.getEmployee_id()+ 
                " -from: " + di.getIn_pro_from()+ 
                " -to: "+ di.getIn_pro_to()+
                " -num of days: " +di.getNum_days()+
                " -Cost: " +di.getCost());
        lgs.createLogs(lgs);
    }  
}

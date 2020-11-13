
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
* Nombre de la clase: InUse
* Fecha: 19-10-2020, 7-11-2020
* CopyRight: OpenSource
* Version: 2.0
* @author Quintanilla Bernabe, Ismael Castillo
*/
public class InUse extends Conexion{
    private int id;
    private int equipment_id;
    private int project_id;
    private String in_pro_from;
    private String in_pro_to;
    private int num_days;
    private int equipment_quantity;
    private double cost;
    private double total_cost;

    public InUse() {
    }

    public InUse(int id, int equipment_id, int project_id, String in_pro_from, String in_pro_to, int num_days, int equipment_quantity, double cost, double total_cost) {
        this.id = id;
        this.equipment_id = equipment_id;
        this.project_id = project_id;
        this.in_pro_from = in_pro_from;
        this.in_pro_to = in_pro_to;
        this.num_days = num_days;
        this.equipment_quantity = equipment_quantity;
        this.cost = cost;
        this.total_cost = total_cost;
    }

    

    //<editor-fold defaultstate="collapsed" desc="getters and setters">
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getEquipment_id() {
        return equipment_id;
    }
    
    public void setEquipment_id(int equipment_id) {
        this.equipment_id = equipment_id;
    }
    
    public int getProject_id() {
        return project_id;
    }
    
    public void setProject_id(int project_id) {
        this.project_id = project_id;
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
    
    public int getEquipment_quantity() {
        return equipment_quantity;
    }
    
    public void setEquipment_quantity(int equipment_quantity) {
        this.equipment_quantity = equipment_quantity;
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
    
    public String createInUse(InUse inu){
        try {
            this.conectar();
            String sql="INSERT INTO in_use VALUES(?,?,?,?,?,?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setInt(2, inu.getEquipment_id());
            pre.setInt(3, inu.getProject_id());
            pre.setString(4, inu.getIn_pro_from());
            pre.setString(5, inu.getIn_pro_to());
            pre.setInt(6, inu.getNum_days());
            pre.setInt(7, inu.getEquipment_quantity());
            pre.setDouble(8, inu.getCost());
            pre.setDouble(9, inu.getTotal_cost());
            pre.executeUpdate();
            return "Equ in use successfuly created";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String updateInUse(InUse inu){
        try {
            this.conectar();
            String sql="UPDATE in_use SET equipment_id=?, project_id=?, in_pro_from=?, in_pro_to=?, num_days=?, equipment_quantity=?, cost=?, total_cost=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, inu.getEquipment_id());
            pre.setInt(2, inu.getProject_id());
            pre.setString(3, inu.getIn_pro_from());
            pre.setString(4, inu.getIn_pro_to());
            pre.setInt(5, inu.getNum_days());
            pre.setInt(6, inu.getEquipment_quantity());
            pre.setDouble(7, inu.getCost());
            pre.setDouble(8, inu.getTotal_cost());
            pre.setInt(9, inu.getId());
            pre.executeUpdate();
            return "Equ in use successfuly updated";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    
    public String deleteInUse(InUse inu){
        try {
            this.conectar();
            String sql="DELETE FROM in_use WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, inu.getId());
            pre.executeUpdate();
            return "Equipment in use successfuly deleted";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    
    public List<InUse> showInUse(){
        List<InUse>listaInu=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from in_use";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                InUse inu = new InUse();
                inu.setId(res.getInt("id"));
                inu.setEquipment_id(res.getInt("equipment_id"));
                inu.setProject_id(res.getInt("project_id"));
                inu.setIn_pro_from(res.getString("in_pro_from"));
                inu.setIn_pro_to(res.getString("in_pro_to"));
                inu.setNum_days(res.getInt("num_days"));
                inu.setEquipment_quantity(res.getInt("equipment_quantity"));
                inu.setCost(res.getDouble("cost"));
                listaInu.add(inu);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaInu;
    }
    
    public List<InUse> showInUse4Proyect(int id){//it shows the machinery in use for a single proyect
        List<InUse>listaInu4Proyect=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from in_use where project_id=? ";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                InUse inu = new InUse();
                inu.setId(res.getInt("id"));
                inu.setEquipment_id(res.getInt("equipment_id"));
                inu.setProject_id(res.getInt("project_id"));
                //isma he modificado esta tabla agregando dos campos de fecha 
                //en caso que tengas que modificar tu vista agregas estos dos campos a ella
                inu.setIn_pro_from(res.getString("in_pro_from"));
                inu.setIn_pro_to(res.getString("in_pro_to"));
                inu.setNum_days(res.getInt("num_days"));
                inu.setEquipment_quantity(res.getInt("equipment_quantity"));
                inu.setCost(res.getDouble("cost"));
                listaInu4Proyect.add(inu);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaInu4Proyect;
    }
    
    
    public InUse getInUse(int id){
        InUse inu = new InUse();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select * from in_use WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                inu.setId(res.getInt("id"));
                inu.setEquipment_id(res.getInt("equipment_id"));
                inu.setProject_id(res.getInt("project_id"));
                inu.setIn_pro_from(res.getString("in_pro_from"));
                inu.setIn_pro_to(res.getString("in_pro_to"));
                inu.setNum_days(res.getInt("num_days"));
                inu.setEquipment_quantity(res.getInt("equipment_quantity"));
                inu.setCost(res.getDouble("cost"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return inu;
    }
    public List<InUse> showInUsebyPro(int id){
        List<InUse>listaInu=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from in_use where project_id=? ";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                InUse inu = new InUse();
                inu.setId(res.getInt("id"));
                inu.setEquipment_id(res.getInt("equipment_id"));
                inu.setProject_id(res.getInt("project_id"));
                inu.setIn_pro_from(res.getString("in_pro_from"));
                inu.setIn_pro_to(res.getString("in_pro_to"));
                inu.setNum_days(res.getInt("num_days"));
                inu.setEquipment_quantity(res.getInt("equipment_quantity"));
                inu.setCost(res.getDouble("cost"));
                listaInu.add(inu);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaInu;
    }
    
    public double daysInUse(String dateStarts, String dateEnds) {
        LocalDate dateBefore = LocalDate.parse(dateStarts);
        LocalDate dateAfter = LocalDate.parse(dateEnds);
        double nod = (ChronoUnit.DAYS.between(dateBefore, dateAfter))+1;
        return nod;
    }
    public InUse getQuantInPro(int idEq, int idPro ){
        InUse inu = new InUse();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select equipment_quantity from in_use WHERE project_id=? AND equipment_id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,idPro);
            pre.setInt(2,idEq);
            res=pre.executeQuery();
            while(res.next()){
                inu.setEquipment_quantity(res.getInt("equipment_quantity"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return inu;
    }
    public void trkLogC(int usrId, InUse di) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Eq in use");
        lgs.setAction_id("created");
        lgs.setDescription("-eq id: " + di.getEquipment_id()+ " -project id " + di.getProject_id()+
                " -from: " + di.getIn_pro_from()+ 
                " -to: "+ di.getIn_pro_to()+
                " -eq quantity: " +di.getEquipment_quantity()+
                " -Cost: " +di.getCost());
        lgs.createLogs(lgs);
    }
    public void trkLogU(int usrId, InUse di, InUse dc) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Eq in use"); 
        lgs.setAction_id("updated");
        if (di.getEquipment_id()!= (dc.getEquipment_id())) {
            lgs.setDescription("eq id from: " + dc.getEquipment_id()+ " to " + di.getEquipment_id());
            lgs.createLogs(lgs);
        }
        if (di.getProject_id()!= (dc.getProject_id())) {
            lgs.setDescription("project id from: " + dc.getProject_id()+ " to " + di.getProject_id());
            lgs.createLogs(lgs);
        }
        if (!di.getIn_pro_from().equals(dc.getIn_pro_from())) {
            lgs.setDescription("in_project_from from: " + dc.getIn_pro_from()+ " to " + di.getIn_pro_from());
            lgs.createLogs(lgs);
        }
        if (!di.getIn_pro_to().equals(dc.getIn_pro_to())) {
            lgs.setDescription("in_project_to from: " + dc.getIn_pro_to()+ " to " + di.getIn_pro_to());
            lgs.createLogs(lgs);
        }
        if (di.getNum_days()!= (dc.getNum_days())) {
            lgs.setDescription("num of days from: " + dc.getNum_days()+ " to " + di.getNum_days());
            lgs.createLogs(lgs);
        }
        if (di.getEquipment_quantity()!= (dc.getEquipment_quantity())) {
            lgs.setDescription("eq quantity from: " + dc.getEquipment_quantity()+ " to " + di.getEquipment_quantity());
            lgs.createLogs(lgs);
        }
        if (di.getCost()!= (dc.getCost())) {
            lgs.setDescription("Cost from: $" + dc.getCost()+ " to $" + di.getCost());
            lgs.createLogs(lgs);
        }
    }
    public void trkLogD(int usrId, InUse di) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Eq in use");
        lgs.setAction_id("deleted");
        lgs.setDescription("-eq id: " + di.getEquipment_id()+ " -project id " + di.getProject_id()+
                " -from: " + di.getIn_pro_from()+ 
                " -to: "+ di.getIn_pro_to()+
                " -eq quantity: " +di.getEquipment_quantity()+
                " -Cost: " +di.getCost());
        lgs.createLogs(lgs);
    }
    
}
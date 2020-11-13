
package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Project
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Project extends Conexion{
    private int id;
    private String name;
    private String description;
    private String started_date;
    private String finish_date;
    private String address;
    private String lat;
    private String lng;
    private int client_id;
    private String status;

    public Project() {
    }

    public Project(int id, String name, String description, String started_date,
            String finish_date, String address, String lat, String lng,
            int client_id, String status) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.started_date = started_date;
        this.finish_date = finish_date;
        this.address = address;
        this.lat = lat;
        this.lng = lng;
        this.client_id = client_id;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStarted_date() {
        return started_date;
    }

    public void setStarted_date(String started_date) {
        this.started_date = started_date;
    }

    public String getFinish_date() {
        return finish_date;
    }

    public void setFinish_date(String finish_date) {
        this.finish_date = finish_date;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng;
    }

    public int getClient_id() {
        return client_id;
    }

    public void setClient_id(int client_id) {
        this.client_id = client_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
       
    public String createPrj(Project prj){
        try {
            this.conectar();
            String sql="INSERT INTO project VALUES(null,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            //pre.setInt(1, 0);
            pre.setString(1, prj.getName());
            pre.setString(2, prj.getDescription());
            pre.setString(3, prj.getStarted_date());
            pre.setString(4, prj.getFinish_date());
            pre.setString(5, prj.getAddress());
            pre.setString(6, prj.getLat());
            pre.setString(7, prj.getLng());
            pre.setInt(8, prj.getClient_id());
            pre.setString(9, prj.getStatus());
            pre.executeUpdate();
            return "Project successfuly created";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String updatePrj(Project prj){
        try {
            this.conectar();
            String sql="UPDATE project SET name=?, description=?, started_date=?, finish_date=?, address=?, lat=?, lng=?, client_id=?, status=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, prj.getName());
            pre.setString(2, prj.getDescription());
            pre.setString(3, prj.getStarted_date());
            pre.setString(4, prj.getFinish_date());
            pre.setString(5, prj.getAddress());
            pre.setString(6, prj.getLat());
            pre.setString(7, prj.getLng());
            pre.setInt(8, prj.getClient_id());
            pre.setString(9, prj.getStatus());
            pre.setInt(10, prj.getId());
            pre.executeUpdate();
            return "Project successfuly updated";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String deletePrj(Project prj){
        try {
            this.conectar();
            String sql="DELETE FROM project WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, prj.getId());
            pre.executeUpdate();
            return "Project successfuly deleted";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public List<Project> showPrj(){
        List<Project>listaPrj=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from project";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Project prj = new Project();
                prj.setId(res.getInt("id"));
                prj.setName(res.getString("name"));
                prj.setDescription(res.getString("description"));
                prj.setStarted_date(res.getString("started_date"));
                prj.setFinish_date(res.getString("finish_date"));
                prj.setAddress(res.getString("address"));
                prj.setLat(res.getString("lat"));
                prj.setLng(res.getString("lng"));
                prj.setClient_id(res.getInt("client_id"));
                prj.setStatus(setProStatus(res.getInt("id")));
                listaPrj.add(prj);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaPrj;
    }
    public List<Project> showPrjByCli(int cli_id){
        List<Project>listaPrj=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from project where client_id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,cli_id);
            res=pre.executeQuery();
            while(res.next()){
                Project prj = new Project();
                prj.setId(res.getInt("id"));
                prj.setName(res.getString("name"));
                prj.setDescription(res.getString("description"));
                prj.setStarted_date(res.getString("started_date"));
                prj.setFinish_date(res.getString("finish_date"));
                prj.setAddress(res.getString("address"));
                prj.setLat(res.getString("lat"));
                prj.setLng(res.getString("lng"));
                prj.setClient_id(res.getInt("client_id"));
                prj.setStatus(setProStatus(res.getInt("id")));
                listaPrj.add(prj);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaPrj;
    }
    public Project getProyect(int id){
        Project prj = new Project();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select * from project where id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                prj.setId(res.getInt("id"));
                prj.setName(res.getString("name"));
                prj.setDescription(res.getString("description"));
                prj.setStarted_date(res.getString("started_date"));
                prj.setFinish_date(res.getString("finish_date"));
                prj.setAddress(res.getString("address"));
                prj.setLat(res.getString("lat"));
                prj.setLng(res.getString("lng"));
                prj.setClient_id(res.getInt("client_id"));
                prj.setStatus(setProStatus(res.getInt("id")));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return prj;
    }
    public String setProStatus(int id){
        String status="";
        ResultSet res=null;
        ZoneId zonedId = ZoneId.of( "America/El_Salvador" );
        LocalDate today = LocalDate.now( zonedId );
        LocalDate ini = null;
        LocalDate fin = null;
        try {
            this.conectar();
            String sql="SELECT started_date, finish_date from project where id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                ini = LocalDate.parse(res.getString("started_date"));
                fin = LocalDate.parse(res.getString("finish_date"));
            }
            if(today.isBefore(ini)){
                status = "no-iniciado";
            }
            else if(today.isAfter(fin)){
                status = "finalizado";
            }
//            else if((ini.isAfter(today) || ini.equals(today)) && (fin.equals(today) || today.isBefore(fin))){
            else
                status = "activo";
            updateStatus(id, status);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return status;
    }
    public void updateStatus(int proId, String status){
        try {
            this.conectar();
            String sql="UPDATE project SET status=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, status);
            pre.setInt(2, proId);
            pre.executeUpdate();
        } catch (Exception e) {
            e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public double prcntCalc(String dateStarts, String dateEnds) {
        ZoneId zonedId = ZoneId.of( "America/El_Salvador" );
        LocalDate today = LocalDate.now( zonedId );
        LocalDate dateBefore = LocalDate.parse(dateStarts);
        LocalDate dateAfter = LocalDate.parse(dateEnds);
        double prcnt = 0.001; 
        double nod = (ChronoUnit.DAYS.between(dateBefore, dateAfter));
        double ti = (ChronoUnit.DAYS.between(dateBefore, today));
        if(today.isAfter(dateBefore) && today.isBefore(dateAfter))
            prcnt=ti/nod;
        else if (today.isAfter(dateAfter))
            prcnt=1;
        return prcnt;
    }
    public void updateStockProStatus(Project prj, Equipment eqId){
         
     }
     
    public void trkLogC(int usrId, Project di) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Project");
        lgs.setAction_id("created");
        lgs.setDescription("Project name: " + di.getName()+ " -description: " + di.getDescription()+
                " -from: " + di.getStarted_date()+ 
                " -to: "+ di.getFinish_date()+
                " -address: " +di.getAddress()+
                " -lat: " +di.getLat()+
                " -long: " +di.getLng()+
                " -client: " +di.getClient_id()+
                " -status: " +di.getStatus());
        lgs.createLogs(lgs);
    }
    public void trkLogU(int usrId, Project di, Project dc) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Project"); 
        lgs.setAction_id("updated");
        if (!di.getName().equals(dc.getName())) {
            lgs.setDescription("name from: " + dc.getName() + " to " + di.getName());
            lgs.createLogs(lgs);
        }
        if (!di.getDescription().equals(dc.getDescription())) {
            lgs.setDescription("description from: " + dc.getDescription()+ " to " + di.getDescription()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (!di.getStarted_date().equals(dc.getStarted_date())) {
            lgs.setDescription("started_from from: " + dc.getStarted_date()+ " to " + di.getStarted_date()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (!di.getFinish_date().equals(dc.getFinish_date())) {
            lgs.setDescription("finished from: " + dc.getFinish_date()+ " to " + di.getFinish_date()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (!di.getAddress().equals(dc.getAddress())) {
            lgs.setDescription("address from: " + dc.getAddress()+ " to " + di.getAddress()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (!di.getLat().equals(dc.getLat())) {
            lgs.setDescription("latitud from: " + dc.getLat()+ " to " + di.getLat()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (!di.getLng().equals(dc.getLng())) {
            lgs.setDescription("Longitude from: " + dc.getLng()+ " to " + di.getLng()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (!di.getStatus().equals(dc.getStatus())) {
            lgs.setDescription("status from: " + dc.getStatus()+ " to " + di.getStatus()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (di.getClient_id()!=(dc.getClient_id())) {
            lgs.setDescription("Client id from: " + dc.getClient_id()+ " to " + di.getClient_id()+ "(in id:"+ dc.getId()+")");
            lgs.createLogs(lgs);
        }
    }
    public void trkLogD(int usrId, Project di) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Project");
        lgs.setAction_id("deleted");
        lgs.setDescription("Project id: " + di.getId()+ "Project name: " + di.getName()+ " -description: " + di.getDescription()+
                " -from: " + di.getStarted_date()+ 
                " -to: "+ di.getFinish_date()+
                " -address: " +di.getAddress()+
                " -lat: " +di.getLat()+
                " -long: " +di.getLng()+
                " -client: " +di.getClient_id()+
                " -status: " +di.getStatus());
        lgs.createLogs(lgs);
    }
}
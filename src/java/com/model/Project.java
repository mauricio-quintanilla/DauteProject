
package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
    private String started_date;
    private String finish_date;
    private String address;
    private String location;
    private int client_id;

    public Project() {
    }

    public Project(int id, String name, String started_date, String finish_date, String address, String location, int client_id) {
        this.id = id;
        this.name = name;
        this.started_date = started_date;
        this.finish_date = finish_date;
        this.address = address;
        this.location = location;
        this.client_id = client_id;
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
    
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getClient_id() {
        return client_id;
    }

    public void setClient_id(int client_id) {
        this.client_id = client_id;
    }
    public String createPrj(Project prj){
        try {
            this.conectar();
            String sql="INSERT INTO project VALUES(?,?,?,?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, prj.getName());
            pre.setString(3, prj.getStarted_date());
            pre.setString(4, prj.getFinish_date());
            pre.setString(5, prj.getAddress());
            pre.setString(6, prj.getLocation());
            pre.setInt(7, prj.getClient_id());
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
            String sql="UPDATE project SET name=?, started_date=?, finish_date=?, address=?, location=?, client_id=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, prj.getName());
            pre.setString(2, prj.getStarted_date());
            pre.setString(3, prj.getFinish_date());
            pre.setString(4, prj.getAddress());
            pre.setString(5, prj.getLocation());
            pre.setInt(6, prj.getClient_id());
            pre.setInt(7, prj.getId());
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
                prj.setStarted_date(res.getString("started_date"));
                prj.setFinish_date(res.getString("finish_date"));
                prj.setAddress(res.getString("address"));
                prj.setLocation(res.getString("location"));
                prj.setClient_id(res.getInt("client_id"));
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
    
}
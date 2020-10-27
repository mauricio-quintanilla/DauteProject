
package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;

/*
* Nombre de la clase: Logs
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Logs extends Conexion {
    private int id;
    private int user_id;
    private String action_id;
    private String on_field;
    private String date;
    private String description;

    public Logs() {
    }

    public Logs(int id, int user_id, String action_id, String on_field, String date, String description) {
        this.id = id;
        this.user_id = user_id;
        this.action_id = action_id;
        this.on_field = on_field;
        this.date = date;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getAction_id() {
        return action_id;
    }

    public void setAction_id(String action_id) {
        this.action_id = action_id;
    }

    public String getOn_field() {
        return on_field;
    }

    public void setOn_field(String on_field) {
        this.on_field = on_field;
    }
    
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    public String createLogs(Logs lgs){
        try {
            this.conectar();
            String sql="INSERT INTO logs VALUES(?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setInt(2, lgs.getUser_id());
            pre.setString(3, lgs.getAction_id());
            pre.setString(4, lgs.getOn_field());
            pre.setString(5, lgs.getDate());
            pre.setString(6, lgs.getDescription());
            pre.executeUpdate();
            return "Record successfuly generated";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    
    public String storeLogs(String user_name, Object myClass,int axnCode){
        String logs="";
        if(axnCode==1){
            
        }
        if(axnCode==2){
            
        }
        if(axnCode==3){
            
        }
        return logs;
    }   
}
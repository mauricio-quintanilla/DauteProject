package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.swing.JOptionPane;

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

    public String createLogs(Logs lgs) {
        try {
            this.conectar();
            String sql = "INSERT INTO logs VALUES(?,?,?,?,?,?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setInt(2, lgs.getUser_id());
            pre.setString(3, lgs.getAction_id());
            pre.setString(4, lgs.getOn_field());
            pre.setString(5, lgs.getDate());
            pre.setString(6, lgs.getDescription());
            pre.executeUpdate();
            
            return "Record successfuly generated";
        } catch (Exception e) {
            return "error " + e.getMessage();
            
        } finally {
            this.desconectar();
        }
    }

    public void storeLogs(int userId, String axnCode) {
        try {
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
            String date = df.format(cal.getTime());
            Logs lgs = new Logs();
            lgs.setId(0);
            lgs.setUser_id(userId);
            lgs.setAction_id(axnCode);
            lgs.setOn_field("to be determined");
            lgs.setDate(date);
            lgs.setDescription(axnCode);
            createLogs(lgs);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        }
        /*    int id=equ.getId();
        List  newRec = (List) equ.getEqu(id);
        List actual = (List) crntEq.getEqu(id);
        for (int i = 0; i < actual.size(); i++) {
            if(actual.get(i)!=newRec.get(i)){
                lgs.setDescription("table Equipment changed from "+ actual.get(i) +" to " + newRec.get(i).toString());
                allLogs.add(lgs);
            }
        }
        String logs="";
        if(axnCode==1){
            
        }
        if(axnCode==2){
            
        }
        if(axnCode==3){
            
        }*/
    }
    
    public List<Logs> showLogs() {
        List<Logs> listaL = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql = "SELECT * from logs order by id DESC";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            res = pre.executeQuery();
            while (res.next()) {
                Logs log = new Logs();
                log.setId(res.getInt("id"));
                log.setUser_id(res.getInt("user_id"));
                log.setAction_id(res.getString("action_id"));
                log.setOn_field(res.getString("on_field"));
                log.setDate(res.getString("date"));
                log.setDescription(res.getString("description"));
                listaL.add(log);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listaL;
    }
}

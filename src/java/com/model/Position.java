
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
* Nombre de la clase: Position
* Fecha: 18-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Position extends Conexion{
    private int id;
    private String name;
    private int department_id;

    public Position() {
    }

    public Position(int id, String name, int department_id) {
        this.id = id;
        this.name = name;
        this.department_id = department_id;
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

    public int getDepartment_id() {
        return department_id;
    }

    public void setDepartment_id(int department_id) {
        this.department_id = department_id;
    }
    
    public String createPos(Position pos){
        try {
            this.conectar();
            String sql="INSERT INTO position VALUES(?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, pos.getName());
            pre.setInt(3, pos.getDepartment_id());
            pre.executeUpdate();
            return "Posición creada correctamente";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String updatePos(Position pos){
        try {
            this.conectar();
            String sql="UPDATE position SET name=?, department_id=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, pos.getName());
            pre.setInt(2, pos.getDepartment_id());
            pre.setInt(3, pos.getId());
            pre.executeUpdate();
            return "Posición Actualizada Correctamente";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String deletePos(Position pos){
        try {
            this.conectar();
            String sql="DELETE FROM position WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, pos.getId());
            pre.executeUpdate();
            return "Posición Eliminada Correctamente";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public List<Position> showPos(){
        List<Position>listaPos=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from position";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Position pos = new Position();
                pos.setId(res.getInt("id"));
                pos.setName(res.getString("name"));
                pos.setDepartment_id(res.getInt("department_id"));
                listaPos.add(pos);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaPos;
    }
    public Position getPos(int id){
        Position pos = new Position();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select * from position where id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                pos.setId(res.getInt("id"));
                pos.setName(res.getString("name"));
                pos.setDepartment_id(res.getInt("department_id"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return pos;
    }
    public void trkLogC(int usrId, Position pi) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Position");
        lgs.setAction_id("created");
        lgs.setDescription("position name: " + pi.getName()+ "dpt id: " +pi.getDepartment_id());
        lgs.createLogs(lgs);
    }
    public void trkLogU(int usrId, Position pi, Position pc) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Position"); 
        lgs.setAction_id("updated");
        if (!pi.getName().equals(pc.getName())) {
            lgs.setDescription("name from: " + pc.getName() + " to " + pi.getName()+ "(in id:"+ pc.getId()+")");
            lgs.createLogs(lgs);
        }
        if (pi.getDepartment_id()!=(pc.getDepartment_id())) {
            lgs.setDescription("id from: " + pc.getDepartment_id() + " to " + pi.getDepartment_id()+ "(in id:"+ pc.getId()+")");
            lgs.createLogs(lgs);
        }
    }
    public void trkLogD(int usrId, Position pi) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Position");
        lgs.setAction_id("deleted");
        lgs.setDescription("position id "+pi.getId()+" position name: " + pi.getName()+ "dpt id: " +pi.getDepartment_id());
        lgs.createLogs(lgs);
    }
}

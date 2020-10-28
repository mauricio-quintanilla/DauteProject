
package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Actions
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Actions extends Conexion{
    private int id;
    private String name;

    public Actions() {
    }

    public Actions(int id, String name) {
        this.id = id;
        this.name = name;
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
    public String createAction(Actions axn){
        try {
            this.conectar();
            String sql="INSERT INTO actions VALUES(?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, axn.getName());
            pre.executeUpdate();
            return "Action successfuly created";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String updateAction(Actions axn){
        try {
            this.conectar();
            String sql="UPDATE actions SET name=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, axn.getName());
            pre.setInt(2, axn.getId());
            pre.executeUpdate();
            return "Action successfuly updated";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String deleteAtion(Actions axn){
        try {
            this.conectar();
            String sql="DELETE FROM actions WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, axn.getId());
            pre.executeUpdate();
            return "Action successfuly deleted";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public List<Actions> showActions(){
        List<Actions>listaAxn = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from actions";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Actions axn = new Actions();
                axn.setId(res.getInt("id"));
                axn.setName(res.getString("name"));
                listaAxn.add(axn);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaAxn;
    }
    public Actions getAction(int id){
        Actions axn = new Actions();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select * from actions where id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                axn.setId(res.getInt("id"));
                axn.setName(res.getString("name"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return axn;
    }
}
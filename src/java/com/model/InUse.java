
package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: InUse
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class InUse extends Conexion{
    private int id;
    private int equipment_id;
    private int project_id;
    private int equipment_quantity;

    public InUse() {
    }

    public InUse(int id, int equipment_id, int project_id, int equipment_quantity) {
        this.id = id;
        this.equipment_id = equipment_id;
        this.project_id = project_id;
        this.equipment_quantity = equipment_quantity;
    }

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

    public int getEquipment_quantity() {
        return equipment_quantity;
    }

    public void setEquipment_quantity(int equipment_quantity) {
        this.equipment_quantity = equipment_quantity;
    }
    public String createInUse(InUse inu){
        try {
            this.conectar();
            String sql="INSERT INTO in_use VALUES(?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setInt(2, inu.getEquipment_id());
            pre.setInt(3, inu.getProject_id());
            pre.setInt(4, inu.getEquipment_quantity());
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
            String sql="UPDATE in_use SET equipment_id=?, project_id=?, equipment_quantity=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, inu.getEquipment_id());
            pre.setInt(2, inu.getProject_id());
            pre.setInt(3, inu.getEquipment_quantity());
            pre.setInt(4, inu.getId());
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
            return "Equ in use successfuly deleted";
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
                inu.setEquipment_quantity(res.getInt("equipment_quantity"));
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
}
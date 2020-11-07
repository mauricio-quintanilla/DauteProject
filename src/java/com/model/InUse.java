
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
    private String in_pro_from;
    private String in_pro_to;
    private int equipment_quantity;

    public InUse() {
    }

    public InUse(int id, int equipment_id, int project_id, String in_pro_from, String in_pro_to, int equipment_quantity) {
        this.id = id;
        this.equipment_id = equipment_id;
        this.project_id = project_id;
        this.in_pro_from = in_pro_from;
        this.in_pro_to = in_pro_to;
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

    public int getEquipment_quantity() {
        return equipment_quantity;
    }

    public void setEquipment_quantity(int equipment_quantity) {
        this.equipment_quantity = equipment_quantity;
    }
    
    public String createInUse(InUse inu){
        try {
            this.conectar();
            String sql="INSERT INTO in_use VALUES(?,?,?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setInt(2, inu.getEquipment_id());
            pre.setInt(3, inu.getProject_id());
            pre.setString(4, inu.getIn_pro_from());
            pre.setString(5, inu.getIn_pro_to());
            pre.setInt(6, inu.getEquipment_quantity());
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
            String sql="UPDATE in_use SET equipment_id=?, project_id=?, in_pro_from=?, in_pro_to=?, equipment_quantity=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, inu.getEquipment_id());
            pre.setInt(2, inu.getProject_id());
            pre.setString(3, inu.getIn_pro_from());
            pre.setString(4, inu.getIn_pro_to());
            pre.setInt(5, inu.getEquipment_quantity());
            pre.setInt(6, inu.getId());
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
                inu.setIn_pro_from(res.getString("in_pro_from"));
                inu.setIn_pro_to(res.getString("in_pro_to"));
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
/*                inu.setIn_pro_from(res.getString("in_pro_from"));
                inu.setIn_pro_to(res.getString("in_pro_to"));
                inu.setEquipment_quantity(res.getInt("equipment_quantity"));*/
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
}

package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Equipment
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Equipment extends Conexion{
    private int id;
    private String name;
    private String model;
    private String description;
    private String brand;
    private int inventory;
    private int type;
    private double rentalPrice;
    private String image;

    public Equipment() {
    }

    public Equipment(int id, String name, String model, String description, String brand, int inventory, int type, double rentalPrice, String image) {
        this.id = id;
        this.name = name;
        this.model = model;
        this.description = description;
        this.brand = brand;
        this.inventory = inventory;
        this.type = type;
        this.rentalPrice = rentalPrice;
        this.image = image;
    }

//<editor-fold defaultstate="collapsed" desc="getters y setters">
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
    
    public String getModel() {
        return model;
    }
    
    public void setModel(String model) {
        this.model = model;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getBrand() {
        return brand;
    }
    
    public void setBrand(String brand) {
        this.brand = brand;
    }
        
    public int getInventory() {
        return inventory;
    }
    
    public void setInventory(int inventory) {
        this.inventory = inventory;
    }
    
    public int getType() {
        return type;
    }
    
    public void setType(int type) {
        this.type = type;
    }
    
    public double getRentalPrice() {
        return rentalPrice;
    }
    
    public void setRentalPrice(double rentalPrice) {
        this.rentalPrice = rentalPrice;
    }
    
    public String getImage() {
        return image;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
//</editor-fold>
    public String createEqu(Equipment equ){
        try {
            this.conectar();
            String sql="INSERT INTO equipment VALUES(?,?,?,?,?,?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, equ.getName());
            pre.setString(3, equ.getModel());
            pre.setString(4, equ.getDescription());
            pre.setString(5, equ.getBrand());
            pre.setInt(6, equ.getInventory());
            pre.setInt(7, equ.getType());
            pre.setDouble(8, equ.getRentalPrice());
            pre.setString(9, equ.getImage());
            pre.executeUpdate();
            return "Equipment successfuly created";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String updateEqu(Equipment equ){
        try {
            this.conectar();
            String sql="UPDATE equipment SET name=?, model=?, description=?, brand=?, inventory=?, type=?, rental_price=?, image=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, equ.getName());
            pre.setString(2, equ.getModel());
            pre.setString(3, equ.getDescription());
            pre.setString(4, equ.getBrand());
            pre.setInt(5, equ.getInventory());
            pre.setInt(6, equ.getType());
            pre.setDouble(7, equ.getRentalPrice());
            pre.setString(8, equ.getImage());
            pre.setInt(9, equ.getId());
            pre.executeUpdate();
            return "Equipment successfuly updated";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String deleteEqu(Equipment equ){
        try {
            this.conectar();
            String sql="DELETE FROM equipment WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, equ.getId());
            pre.executeUpdate();
            return "Equipment successfuly deleted";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public List<Equipment> showEqu(){
        List<Equipment>listaEqu = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from equipment";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Equipment equ = new Equipment();
                equ.setId(res.getInt("id"));
                equ.setName(res.getString("name"));
                equ.setModel(res.getString("model"));
                equ.setDescription(res.getString("description"));
                equ.setBrand(res.getString("brand"));
                equ.setInventory(res.getInt("inventory"));
                equ.setType(res.getInt("type"));
                equ.setRentalPrice(res.getDouble("rental_price"));
                equ.setImage(res.getString("image"));
                listaEqu.add(equ);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaEqu;
    }
    public Equipment getEqu(int id){
        Equipment equ = new Equipment();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select * from equipment WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                equ.setId(res.getInt("id"));
                equ.setName(res.getString("name"));
                equ.setModel(res.getString("model"));
                equ.setDescription(res.getString("description"));
                equ.setBrand(res.getString("brand"));
                equ.setInventory(res.getInt("inventory"));
                equ.setType(res.getInt("type"));
                equ.setRentalPrice(res.getDouble("rental_price"));
                equ.setImage(res.getString("image"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
          
        }
        finally{
            this.desconectar();
        }
        
        return equ;
    }

    public List<Equipment> showEquAvaila(String ini, String fin){
        List<Equipment>listaEqu = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * FROM equipment WHERE id NOT IN (SELECT equipment_id from in_use WHERE in_pro_from>=? AND in_pro_to<=?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, ini);
            pre.setString(2, fin);
            res=pre.executeQuery();
            while(res.next()){
                Equipment equ = new Equipment();
                equ.setId(res.getInt("id"));
                equ.setName(res.getString("name"));
                equ.setModel(res.getString("model"));
                equ.setDescription(res.getString("description"));
                equ.setBrand(res.getString("brand"));
                equ.setInventory(res.getInt("inventory"));
                equ.setType(res.getInt("type"));
                equ.setRentalPrice(res.getDouble("rental_price"));
                equ.setImage(res.getString("image"));
                listaEqu.add(equ);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaEqu;
    }

}
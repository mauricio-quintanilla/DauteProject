
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
    private int stock;
    private int inventory;
    private int type;
    private double fuel_rate;
    private String image;

    public Equipment() {
    }

    public Equipment(int id, String name, String model, String description, String brand, int stock, int inventory, int type, double fuel_rate, String image) {
        this.id = id;
        this.name = name;
        this.model = model;
        this.description = description;
        this.brand = brand;
        this.stock = stock;
        this.inventory = inventory;
        this.type = type;
        this.fuel_rate = fuel_rate;
        this.image = image;
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

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
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

    public double getFuel_rate() {
        return fuel_rate;
    }

    public void setFuel_rate(double fuel_rate) {
        this.fuel_rate = fuel_rate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    public String createEqu(Equipment equ){
        try {
            this.conectar();
            String sql="INSERT INTO equipment VALUES(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, equ.getName());
            pre.setString(3, equ.getModel());
            pre.setString(4, equ.getDescription());
            pre.setString(5, equ.getBrand());
            pre.setInt(6, equ.getStock());
            pre.setInt(7, equ.getInventory());
            pre.setInt(8, equ.getType());
            pre.setDouble(9, equ.getFuel_rate());
            pre.setString(10, equ.getImage());
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
            String sql="UPDATE equipment SET name=?, model=?, description=?, brand=?, stock=?, inventory=?, type=?, fuel_rate=?, image=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, equ.getName());
            pre.setString(2, equ.getModel());
            pre.setString(3, equ.getDescription());
            pre.setString(4, equ.getBrand());
            pre.setInt(5, equ.getStock());
            pre.setInt(6, equ.getInventory());
            pre.setInt(7, equ.getType());
            pre.setDouble(8, equ.getFuel_rate());
            pre.setString(9, equ.getImage());
            pre.setInt(10, equ.getId());
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
                equ.setStock(res.getInt("stock"));
                equ.setInventory(res.getInt("inventory"));
                equ.setType(res.getInt("type"));
                equ.setFuel_rate(res.getDouble("fuel_rate"));
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
                equ.setStock(res.getInt("stock"));
                equ.setInventory(res.getInt("inventory"));
                equ.setType(res.getInt("type"));
                equ.setFuel_rate(res.getDouble("fuel_rate"));
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
    public void updateStock(InUse inu, int axn){
        InUse crntInUse = new InUse();
        int eqId = inu.getEquipment_id();//id de equipo que esta siendo creado, modif o eliminado
        int crntQuant = crntInUse.getInUse(inu.getId()).getEquipment_quantity();//la cantidad actual que esta siendo usada en proyeto
        int actualStk = getEqu(eqId).getStock(); //las unidades de este equ que estan actualmente en stock
        int unitRqst = inu.getEquipment_quantity();// las unidades que se han pedido en el POST
        int newStk= actualStk;//la cantidad de unidades que quedan en stock//by default in case request is same as original
        if(axn==1){//si btn es crear o update
            if(unitRqst<crntQuant)//si las unidades pedidas son menores que la cantidad en uso actual entonces la dif se suma al actual stock
                newStk = actualStk + (crntQuant - unitRqst);
            if(unitRqst>crntQuant)//si las unidades pedidas son mayores que la cantidad en uso actual entonces la dif se resta al actual stock
                newStk = actualStk - (unitRqst- crntQuant);
        }
        if(axn==2)//si btn es eliminar
            newStk = actualStk + (crntQuant); //las unidades en uso son sumadas al stock
        try{
            this.conectar();
            String sql="UPDATE equipment SET stock=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,newStk);
            pre.setInt(2, eqId);
            pre.executeUpdate();
        } catch (Exception e) {
            System.out.println("error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
    }
}
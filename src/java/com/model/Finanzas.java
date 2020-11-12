
package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Finanzas
* Fecha: 12-11-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Finanzas extends Conexion{
    private int id;
    private String name;
    private double inv_per;
    private double inv_maq;
    private double costo_per;
    private double costo_maq;
    private double profit;

    public Finanzas() {
    }

    public Finanzas(int id, String name, double inv_per, double costo_per, double costo_maq, double profit) {
        this.id = id;
        this.name = name;
        this.inv_per = inv_per;
        this.costo_per = costo_per;
        this.costo_maq = costo_maq;
        this.profit = profit;
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

    public double getInv_per() {
        return inv_per;
    }

    public void setInv_per(double inv_per) {
        this.inv_per = inv_per;
    }

    public double getInv_maq() {
        return inv_maq;
    }

    public void setInv_maq(double inv_maq) {
        this.inv_maq = inv_maq;
    }

    public double getCosto_per() {
        return costo_per;
    }

    public void setCosto_per(double costo_per) {
        this.costo_per = costo_per;
    }

    public double getCosto_maq() {
        return costo_maq;
    }

    public void setCosto_maq(double costo_maq) {
        this.costo_maq = costo_maq;
    }

    public double getProfit() {
        return profit;
    }

    public void setProfit(double profit) {
        this.profit = profit;
    }
    
    public List<Finanzas> showFnzCost(){
        List<Finanzas>listaFnz=new ArrayList();
        ResultSet res;
        double profit;
        try {
            this.conectar();
            String sql="SELECT P.id, P.name AS name, \n" +
                        "             SUM(W.total_cost) AS costo_per,\n" +
                        "             SUM(I.total_cost) AS costo_maq\n" +
                        "FROM project P\n" +
                        "INNER JOIN in_use I ON P.id = I.project_id \n" +
                        "INNER JOIN working_on_project W ON P.id = W.project_id \n" +
                        "GROUP BY p.id";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Finanzas fnz = new Finanzas();
                fnz.setId(res.getInt("id"));
                fnz.setName(res.getString("name"));
                fnz.setCosto_per(res.getDouble("costo_per"));
                fnz.setCosto_maq(res.getDouble("costo_maq"));
                fnz.setInv_per(fnz.getInvPer(res.getInt("id")).getInv_per());
                fnz.setInv_maq(fnz.getInvMaq(res.getInt("id")).getInv_maq());
                profit = (res.getDouble("costo_per")+ res.getDouble("costo_maq")) - (fnz.getInvPer(res.getInt("id")).getInv_per()+fnz.getInvMaq(res.getInt("id")).getInv_maq());
                fnz.setProfit(profit);
                listaFnz.add(fnz);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error in show prj"+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaFnz;
    }
    public Finanzas getInvPer(int id){
        Finanzas fnz = new Finanzas();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="SELECT sum((W.num_days) * (E.salary)) as inv_per \n" +
                        "FROM project P \n" +
                        "INNER JOIN working_on_project W ON P.id = W.project_id  \n" +
                        "INNER JOIN employees E ON W.employee_id = E.id\n" +
                        "where P.id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                fnz.setInv_per(res.getDouble("inv_per"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error getInvPer "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return fnz;
    }
    public Finanzas getInvMaq(int id){
        Finanzas fnz = new Finanzas();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="SELECT sum((I.equipment_quantity)*(I.num_days) * (E.rental_price)) as inv_maq\n" +
                        "FROM project P \n" +
                        "INNER JOIN in_use I ON P.id = I.project_id  \n" +
                        "INNER JOIN equipment E ON I.equipment_id = E.id\n" +
                        "WHERE p.id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                fnz.setInv_maq(res.getDouble("inv_maq"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error getInvPer "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return fnz;
    }
}

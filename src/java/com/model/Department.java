
package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Department
* Fecha: 18-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Department extends Conexion{
    private int id;
    private String name;

    public Department() {
    }

    public Department(int id, String name) {
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
    
    public String createDept(Department dept){
        try {
            this.conectar();
            String sql="INSERT INTO department VALUES(?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, dept.getName());
            pre.executeUpdate();
            return "Department successfuly created";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String updateDept(Department dept){
        try {
            this.conectar();
            String sql="UPDATE department SET name=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, dept.getName());
            pre.setInt(2, dept.getId());
            pre.executeUpdate();
            return "Department successfuly updated";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String deleteDept(Department dept){
        try {
            this.conectar();
            String sql="DELETE FROM department WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, dept.getId());
            pre.executeUpdate();
            return "Department successfuly deleted";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public List<Department> showDept(){
        List<Department>listaDept=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from department";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Department dept=new Department();
                dept.setId(res.getInt("id"));
                dept.setName(res.getString("name"));
                listaDept.add(dept);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaDept;
    }
    public Department getDept(int id){
        Department dpt = new Department();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select * from department where id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                dpt.setId(res.getInt("id"));
                dpt.setName(res.getString("name"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return dpt;
    }
}
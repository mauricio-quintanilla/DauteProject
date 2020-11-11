package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Employees
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe, Ismael Castillo
 */
public class Employees extends Conexion {

    private int id;
    private String first_name;
    private String last_name;
    private String dob;
    private String address;
    private String phone_number;
    private String dui;
    private String nit;
    private double salary;
    private int position_id;
    private int user_id;
    private String image;

    public Employees() {
    }

    public Employees(int id, String first_name, String last_name, String dob,
            String address, String phone_number, String dui, String nit,
            double salary, int position_id, int user_id, String image) {
        this.id = id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.dob = dob;
        this.address = address;
        this.phone_number = phone_number;
        this.dui = dui;
        this.nit = nit;
        this.salary = salary;
        this.position_id = position_id;
        this.user_id = user_id;
        this.image = image;
    }

    //<editor-fold defaultstate="collapsed" desc="getters y setters">
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getFirst_name() {
        return first_name;
    }
    
    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }
    
    public String getLast_name() {
        return last_name;
    }
    
    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }
    
    public String getDob() {
        return dob;
    }
    
    public void setDob(String dob) {
        this.dob = dob;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getPhone_number() {
        return phone_number;
    }
    
    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }
    
    public String getDui() {
        return dui;
    }
    
    public void setDui(String dui) {
        this.dui = dui;
    }
    
    public String getNit() {
        return nit;
    }
    
    public void setNit(String nit) {
        this.nit = nit;
    }
    
    public double getSalary() {
        return salary;
    }
    
    public void setSalary(double salary) {
        this.salary = salary;
    }
    
    public int getPosition_id() {
        return position_id;
    }
    
    public void setPosition_id(int position_id) {
        this.position_id = position_id;
    }
    
    public int getUser_id() {
        return user_id;
    }
    
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
        
    public String getImage() {
        return image;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="create employee">
    public String createEmp(Employees emp) {
        try {
            this.conectar();
            String sql = "INSERT INTO employees VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, emp.getFirst_name());
            pre.setString(3, emp.getLast_name());
            pre.setString(4, emp.getDob());
            pre.setString(5, emp.getAddress());
            pre.setString(6, emp.getPhone_number());
            pre.setString(7, emp.getDui());
            pre.setString(8, emp.getNit());
            pre.setDouble(9, emp.getSalary());
            pre.setInt(10, emp.getPosition_id());
            pre.setInt(11, emp.getUser_id());
            pre.setString(12, emp.getImage());
            pre.executeUpdate();
            return "Employee successfuly created";
        } catch (Exception e) {
            return "error " + e.getMessage();
        } finally {
            this.desconectar();
        }
    }
//</editor-fold>
    public String updateEmp(Employees emp) {
        try {
            this.conectar();
            String sql = "UPDATE employees SET first_name=?, last_name=?, dob=?, address=?, phone_number=?, DUI=?, NIT=?, salary=?, position_id=?, user_id=?, image=? WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, emp.getFirst_name());
            pre.setString(2, emp.getLast_name());
            pre.setString(3, emp.getDob());
            pre.setString(4, emp.getAddress());
            pre.setString(5, emp.getPhone_number());
            pre.setString(6, emp.getDui());
            pre.setString(7, emp.getNit());
            pre.setDouble(8, emp.getSalary());
            pre.setInt(9, emp.getPosition_id());
            pre.setInt(10, emp.getUser_id());
            pre.setString(11, emp.getImage());
            pre.setInt(12, emp.getId());
            pre.executeUpdate();
            return "Employee successfuly updated";
        } catch (Exception e) {
            return "error " + e.getMessage();
        } finally {
            this.desconectar();
        }
    }

    public String deleteEmp(Employees emp) {
        try {
            this.conectar();
            String sql = "DELETE FROM employees WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, emp.getId());
            pre.executeUpdate();
            return "Employee successfuly deleted";
        } catch (Exception e) {
            return "error " + e.getMessage();
        } finally {
            this.desconectar();
        }
    }

    public List<Employees> showEmp() {
        List<Employees> listaEmp = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql = "SELECT * from employees";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            res = pre.executeQuery();
            while (res.next()) {
                Employees emp = new Employees();
                emp.setId(res.getInt("id"));
                emp.setFirst_name(res.getString("first_name"));
                emp.setLast_name(res.getString("last_name"));
                emp.setDob(res.getString("dob"));
                emp.setAddress(res.getString("address"));
                emp.setPhone_number(res.getString("phone_number"));
                emp.setDui(res.getString("DUI"));
                emp.setNit(res.getString("NIT"));
                emp.setSalary(res.getDouble("salary"));
                emp.setPosition_id(res.getInt("position_id"));
                emp.setUser_id(res.getInt("user_id"));
                emp.setImage(res.getString("image"));
                listaEmp.add(emp);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listaEmp;
    }

    public List<Employees> showEmpAvaila(Project prj) {
        List<Employees> listaEmp = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql = "SELECT * from employees";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            res = pre.executeQuery();
            while (res.next()) {
                Employees emp = new Employees();
                emp.setId(res.getInt("id"));
                emp.setFirst_name(res.getString("first_name"));
                emp.setLast_name(res.getString("last_name"));
                emp.setDob(res.getString("dob"));
                emp.setAddress(res.getString("address"));
                emp.setPhone_number(res.getString("phone_number"));
                emp.setDui(res.getString("DUI"));
                emp.setNit(res.getString("NIT"));
                emp.setSalary(res.getDouble("salary"));
                emp.setPosition_id(res.getInt("position_id"));
                emp.setUser_id(res.getInt("user_id"));
                emp.setImage(res.getString("image"));
                listaEmp.add(emp);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listaEmp;
    }

    public Employees getEmp(int id) {
        Employees emp = new Employees();
        ResultSet res = null;
        try {
            this.conectar();
            String sql = "select * from employees where id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, id);
            res = pre.executeQuery();
            while (res.next()) {
                emp.setId(res.getInt("id"));
                emp.setFirst_name(res.getString("first_name"));
                emp.setLast_name(res.getString("last_name"));
                emp.setDob(res.getString("dob"));
                emp.setAddress(res.getString("address"));
                emp.setPhone_number(res.getString("phone_number"));
                emp.setDui(res.getString("DUI"));
                emp.setNit(res.getString("NIT"));
                emp.setSalary(res.getDouble("salary"));
                emp.setPosition_id(res.getInt("position_id"));
                emp.setUser_id(res.getInt("user_id"));
                emp.setImage(res.getString("image"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return emp;
    }

    public Employees getEmpSes(int id) {//this fuction is used to get personal data from user logged in session 
        Employees emp = new Employees();
        ResultSet res = null;
        try {
            this.conectar();
            String sql = "select * from employees where user_id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, id);
            res = pre.executeQuery();
            while (res.next()) {
                emp.setFirst_name(res.getString("first_name"));
                emp.setLast_name(res.getString("last_name"));
                emp.setImage(res.getString("image"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return emp;
    }

    
    public List<Employees> showAvailaByDate(String ini, String fin) {
        List<Employees> listaEmp = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql = "SELECT * from employees WHERE id NOT IN (SELECT employee_id from working_on_project WHERE in_pro_from>=? AND in_pro_to<=?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, ini);
            pre.setString(2, fin);
            res = pre.executeQuery();
            while (res.next()) {
                Employees emp = new Employees();
                emp.setId(res.getInt("id"));
                emp.setFirst_name(res.getString("first_name"));
                emp.setLast_name(res.getString("last_name"));
                emp.setDob(res.getString("dob"));
                emp.setAddress(res.getString("address"));
                emp.setPhone_number(res.getString("phone_number"));
                emp.setDui(res.getString("DUI"));
                emp.setNit(res.getString("NIT"));
                emp.setSalary(res.getDouble("salary"));
                emp.setPosition_id(res.getInt("position_id"));
                emp.setUser_id(res.getInt("user_id"));
                emp.setImage(res.getString("image"));
                listaEmp.add(emp);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listaEmp;
    }
}

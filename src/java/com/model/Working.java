package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Working
* Fecha: 19-10-2020, 7-11-2020
* CopyRight: OpenSource
* Version: 2.0
* @author Quintanilla Bernabe, ismael
 */
public class Working extends Conexion {

    private int id;
    private int project_id;
    private int employee_id;
    private String in_pro_from;
    private String in_pro_to;
    private double cost;

    public Working() {
    }

    public Working(int id, int project_id, int employee_id, String in_pro_from, String in_pro_to, double cost) {
        this.id = id;
        this.project_id = project_id;
        this.employee_id = employee_id;
        this.in_pro_from = in_pro_from;
        this.in_pro_to = in_pro_to;
        this.cost = cost;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProject_id() {
        return project_id;
    }

    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
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

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public String createWorking(Working wop) {
        try {
            this.conectar();
            String sql = "INSERT INTO working_on_project VALUES(?,?,?,?,?,?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setInt(2, wop.getProject_id());
            pre.setInt(3, wop.getEmployee_id());
            pre.setString(4, wop.getIn_pro_from());
            pre.setString(5, wop.getIn_pro_to());
            pre.setDouble(6, wop.getCost());
            pre.executeUpdate();
            return "Employee successfuly added to project";
        } catch (Exception e) {
            return "error " + e.getMessage();
        } finally {
            this.desconectar();
        }
    }

    public String updateWorking(Working wop) {
        try {
            this.conectar();
            String sql = "UPDATE working_on_project SET project_id=?, employee_id=?, in_pro_from=?, in_pro_to=?, cost=? WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, wop.getProject_id());
            pre.setInt(2, wop.getEmployee_id());
            pre.setString(3, wop.getIn_pro_from());
            pre.setString(4, wop.getIn_pro_to());
            pre.setDouble(5, wop.getCost());
            pre.setInt(6, wop.getId());
            pre.executeUpdate();
            return "Employee on project successfuly updated";
        } catch (Exception e) {
            return "error " + e.getMessage();
        } finally {
            this.desconectar();
        }
    }

    public String deleteWorking(Working wop) {
        try {
            this.conectar();
            String sql = "DELETE FROM working_on_project WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, wop.getId());
            pre.executeUpdate();
            return "Employee successfuly removed from project";
        } catch (Exception e) {
            return "error " + e.getMessage();
        } finally {
            this.desconectar();
        }
    }

    public List<Working> showWorking() {
        List<Working> listaWop = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql = "SELECT * from working_on_project";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            res = pre.executeQuery();
            while (res.next()) {
                Working wop = new Working();
                wop.setId(res.getInt("id"));
                wop.setProject_id(res.getInt("project_id"));
                wop.setEmployee_id(res.getInt("employee_id"));
                wop.setIn_pro_from(res.getString("in_pro_from"));
                wop.setIn_pro_to(res.getString("in_pro_to"));
                wop.setCost(res.getDouble("cost"));
                listaWop.add(wop);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listaWop;
    }

    public List<Working> showWorkingByPro(int id) {
        List<Working> listaWop = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql = "SELECT * from working_on_project WHERE project_id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, id);
            res = pre.executeQuery();
            while (res.next()) {
                Working wop = new Working();
                wop.setId(res.getInt("id"));
                wop.setProject_id(res.getInt("project_id"));
                wop.setEmployee_id(res.getInt("employee_id"));
                wop.setIn_pro_from(res.getString("in_pro_from"));
                wop.setIn_pro_to(res.getString("in_pro_to"));
                wop.setCost(res.getDouble("cost"));
                listaWop.add(wop);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listaWop;
    }

    public double daysIn(String dateStarts, String dateEnds) {
        LocalDate dateBefore = LocalDate.parse(dateStarts);
        LocalDate dateAfter = LocalDate.parse(dateEnds);
        double nod = (ChronoUnit.DAYS.between(dateBefore, dateAfter))+1;
        return nod;
    }
}

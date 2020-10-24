
package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Working
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Working extends Conexion{
    private int id;
    private int project_id;
    private int employee_id;

    public Working() {
    }

    public Working(int id, int project_id, int employee_id) {
        this.id = id;
        this.project_id = project_id;
        this.employee_id = employee_id;
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
    public String createWorking(Working wop){
        try {
            this.conectar();
            String sql="INSERT INTO working_on_project VALUES(?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setInt(2, wop.getProject_id());
            pre.setInt(3, wop.getEmployee_id());
            pre.executeUpdate();
            return "Employee successfuly added to project";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String updateWorking(Working wop){
        try {
            this.conectar();
            String sql="UPDATE working_on_project SET project_id=?, employee_id=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, wop.getProject_id());
            pre.setInt(2, wop.getEmployee_id());
            pre.setInt(3, wop.getId());
            pre.executeUpdate();
            return "Employee on project successfuly updated";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String deleteWorking(Working wop){
        try {
            this.conectar();
            String sql="DELETE FROM working_on_project WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, wop.getId());
            pre.executeUpdate();
            return "Employee successfuly removed from project";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public List<Working> showWorking(){
        List<Working>listaWop=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from working_on_project";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Working wop = new Working();
                wop.setId(res.getInt("id"));
                wop.setProject_id(res.getInt("project_id"));
                wop.setEmployee_id(res.getInt("employee_id"));
                listaWop.add(wop);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaWop;
    }
}

package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Role
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Role extends Conexion{
    private int id;
    private String name;

    public Role() {
    }

    public Role(int id, String name) {
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
    
    public String createRole(Role rol){
        try {
            this.conectar();
            String sql="INSERT INTO role VALUES(?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, rol.getName());
            pre.executeUpdate();
            return "Role successfuly created";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String updateRole(Role rol){
        try {
            this.conectar();
            String sql="UPDATE role SET name=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, rol.getName());
            pre.setInt(2, rol.getId());
            pre.executeUpdate();
            return "Role successfuly updated";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String deleteRole(Role rol){
        try {
            this.conectar();
            String sql="DELETE FROM role WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, rol.getId());
            pre.executeUpdate();
            return "Role successfuly deleted";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public List<Role> showRole(){
        List<Role>listaRol=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from role";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Role rol = new Role();
                rol.setId(res.getInt("id"));
                rol.setName(res.getString("name"));
                listaRol.add(rol);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaRol;
    }
    public Role getRole(int id){
        Role rol = new Role();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select * from role where id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                rol.setId(res.getInt("id"));
                rol.setName(res.getString("name"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return rol;
    }
}

package com.model;

import com.conexion.Conexion;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Users
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Users extends Conexion {
    private int id;
    private String user_name;
    private String email;
    private String password;
    private int role_id;

    public Users() {
    }

    public Users(int id, String user_name, String email, String password, int role_id) {
        this.id = id;
        this.user_name = user_name;
        this.email = email;
        this.password = password;
        this.role_id = role_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }
    public String createUser(Users usr){
        String crypto="";
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-1");
            digest.reset();
            digest.update(usr.getPassword().getBytes("utf8"));
            crypto = String.format("%040x", new BigInteger(1, digest.digest()));
            
            
            this.conectar();
            String sql="INSERT INTO users VALUES(?,?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, usr.getUser_name());
            pre.setString(3, usr.getEmail());
            pre.setString(4, crypto);
            pre.setInt(5, usr.getRole_id());
            pre.executeUpdate();
            return "User successfuly created";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String updateUser(Users usr){
        String crypto="";
        String pass;
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-1");
            digest.reset();
            digest.update(usr.getPassword().getBytes("utf8"));
            crypto = String.format("%040x", new BigInteger(1, digest.digest()));
            
            pass=this.getUsers(usr.getId()).getPassword();
            
            this.conectar();
            String sql="UPDATE users SET user_name=?, email=?, password=?, role_id=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, usr.getUser_name());
            pre.setString(2, usr.getEmail());  
            pre.setString(3, crypto);
            pre.setInt(4, usr.getRole_id());
            pre.setInt(5, usr.getId());
            pre.executeUpdate();
            return "User successfuly updated";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public String deleteUser(Users usr){
        try {
            this.conectar();
            String sql="DELETE FROM users WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, usr.getId());
            pre.executeUpdate();
            return "User successfuly deleted";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public List<Users> showUsers(){
        List<Users>listaUsr=new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * FROM users";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Users usr = new Users();
                usr.setId(res.getInt("id"));
                usr.setUser_name(res.getString("user_name"));
                usr.setEmail(res.getString("email"));
                usr.setPassword(res.getString("password"));
                usr.setRole_id(res.getInt("role_id"));
                listaUsr.add(usr);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaUsr;
    }
    public Users getUsers(int id){
        Users usr = new Users();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="SELECT * FROM users WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                usr.setId(res.getInt("id"));
                usr.setUser_name(res.getString("user_name"));
                usr.setEmail(res.getString("email"));
                usr.setPassword(res.getString("password"));
                usr.setRole_id(res.getInt("role_id"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return usr;
    }
    public Users validateUser(String user, String pwd){
        Users usr = new Users();
        ResultSet res=null;
        String crypto="";
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-1");
            digest.reset();
            digest.update(pwd.getBytes("utf8"));
            crypto = String.format("%040x", new BigInteger(1, digest.digest()));
            
            this.conectar();
            String sql="SELECT id, role_id FROM users WHERE user_name=? AND password=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1,user);
            pre.setString(2,crypto);
            res=pre.executeQuery();
            while(res.next()){
                usr.setId(res.getInt("id"));
                usr.setRole_id(res.getInt("role_id"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error in validateUser "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return usr;
    }
}
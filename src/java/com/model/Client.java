
package com.model;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Client
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Client extends Conexion{
    private int id;
    private String name;
    private String email;
    private String phone_number;
    private String nit;
    private String company_name;
    private String company_address;
    private int user_id;
    
    public Client() {
    }

    public Client(int id, String name, String email, String phone_number, String nit, String company_name, String company_address, int user_id) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone_number = phone_number;
        this.nit = nit;
        this.company_name = company_name;
        this.company_address = company_address;
        this.user_id = user_id;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getCompany_name() {
        return company_name;
    }

    public void setCompany_name(String company_name) {
        this.company_name = company_name;
    }

    public String getCompany_address() {
        return company_address;
    }

    public void setCompany_address(String company_address) {
        this.company_address = company_address;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
    
    
    public String createClient(Client cli){
        try {
            this.conectar();
            String sql="INSERT INTO client VALUES(?,?,?,?,?,?,?,?)";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, 0);
            pre.setString(2, cli.getName());
            pre.setString(3, cli.getEmail());
            pre.setString(4, cli.getPhone_number());
            pre.setString(5, cli.getNit());
            pre.setString(6, cli.getCompany_name());
            pre.setString(7, cli.getCompany_address());
            pre.setInt(8, cli.getUser_id());
            pre.executeUpdate();
            return "Client successfuly created";
        } catch (Exception e) {
            String err=e.getMessage();
            return "Error dato unico repetido";
        }
        finally{
            this.desconectar();
        }
    }
    public String updateClient(Client cli){
        try {
            this.conectar();
            String sql="UPDATE client SET name=?, email=?, phone_number=?, NIT=?, company_name=?, company_address=?, user_id=? WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setString(1, cli.getName());
            pre.setString(2, cli.getEmail());
            pre.setString(3, cli.getPhone_number());
            pre.setString(4, cli.getNit());
            pre.setString(5, cli.getCompany_name());
            pre.setString(6, cli.getCompany_address());
            pre.setInt(7, cli.getUser_id());
            pre.setInt(8, cli.getId());
            pre.executeUpdate();
            return "Client successfuly updated";
        } catch (Exception e) {
            return "error";
        }
        finally{
            this.desconectar();
        }
    }
    public String deleteClient(Client cli){
        try {
            this.conectar();
            String sql="DELETE FROM client WHERE id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1, cli.getId());
            pre.executeUpdate();
            return "Client successfuly deleted";
        } catch (Exception e) {
            return "error "+e.getMessage();
        }
        finally{
            this.desconectar();
        }
    }
    public List<Client> showClient(){
        List<Client>listaCli = new ArrayList();
        ResultSet res;
        try {
            this.conectar();
            String sql="SELECT * from client";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            res=pre.executeQuery();
            while(res.next()){
                Client cli = new Client();
                cli.setId(res.getInt("id"));
                cli.setName(res.getString("name"));
                cli.setEmail(res.getString("email"));
                cli.setPhone_number(res.getString("phone_number"));
                cli.setNit(res.getString("NIT"));
                cli.setCompany_name(res.getString("company_name"));
                cli.setCompany_address(res.getString("company_address"));
                cli.setUser_id(res.getInt("user_id"));
                listaCli.add(cli);
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return listaCli;
    }
    
    public Client getClient(int id){
        Client cli = new Client();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select * from client where user_id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                cli.setId(res.getInt("id"));
                cli.setName(res.getString("name"));
                cli.setEmail(res.getString("email"));
                cli.setPhone_number(res.getString("phone_number"));
                cli.setNit(res.getString("NIT"));
                cli.setCompany_name(res.getString("company_name"));
                cli.setCompany_address(res.getString("company_address"));
                cli.setUser_id(res.getInt("user_id"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return cli;
    }
    
    public Client getClientPjct(int id){
        Client cli = new Client();
        ResultSet res=null;
        try {
            this.conectar();
            String sql="select * from client where id=?";
            PreparedStatement pre=this.getCon().prepareStatement(sql);
            pre.setInt(1,id);
            res=pre.executeQuery();
            while(res.next()){
                cli.setId(res.getInt("id"));
                cli.setName(res.getString("name"));
                cli.setEmail(res.getString("email"));
                cli.setPhone_number(res.getString("phone_number"));
                cli.setNit(res.getString("NIT"));
                cli.setCompany_name(res.getString("company_name"));
                cli.setCompany_address(res.getString("company_address"));
                cli.setUser_id(res.getInt("user_id"));
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error "+e.getMessage());
        }
        finally{
            this.desconectar();
        }
        return cli;
    }
    public void trkLogC(int usrId, Client di) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Client");
        lgs.setAction_id("created");
        lgs.setDescription("client name: " + di.getName() + " Correo " + di.getEmail()+
                " phone #: " + di.getPhone_number() + 
                " Nit: "+ di.getNit()+
                " Comapny name: " +di.getCompany_name()+
                " Comapny address: " +di.getCompany_address());
        lgs.createLogs(lgs);
    }
    public void trkLogU(int usrId, Client di, Client dc) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Client"); 
        lgs.setAction_id("updated");
        if (!di.getName().equals(dc.getName())) {
            lgs.setDescription("name from: " + dc.getName() + " to " + di.getName());
            lgs.createLogs(lgs);
        }
        if (!di.getName().equals(dc.getName())) {
            lgs.setDescription("email from: " + dc.getEmail() + " to " + di.getEmail());
            lgs.createLogs(lgs);
        }
        if (!di.getName().equals(dc.getName())) {
            lgs.setDescription("phone # from: " + dc.getPhone_number() + " to " + di.getPhone_number());
            lgs.createLogs(lgs);
        }
        if (!di.getName().equals(dc.getName())) {
            lgs.setDescription("NIT from: " + dc.getNit()+ " to " + di.getNit());
            lgs.createLogs(lgs);
        }
        if (!di.getName().equals(dc.getName())) {
            lgs.setDescription("Company name from: " + dc.getCompany_name() + " to " + di.getCompany_name());
            lgs.createLogs(lgs);
        }
        if (!di.getName().equals(dc.getName())) {
            lgs.setDescription("Company address from: " + dc.getCompany_name() + " to " + di.getCompany_address());
            lgs.createLogs(lgs);
        }
    }
    public void trkLogD(int usrId, Client di) {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss");
        String date = df.format(cal.getTime());
        Logs lgs = new Logs();
        lgs.setId(0);
        lgs.setUser_id(usrId);
        lgs.setDate(date);
        lgs.setOn_field("Client");
        lgs.setAction_id("deleted");
        lgs.setDescription("client name: " + di.getName() + " Correo " + di.getEmail()+
                " phone #: " + di.getPhone_number() + 
                " Nit: "+ di.getNit()+
                " Comapny name: " +di.getCompany_name()+
                " Comapny address: " +di.getCompany_address());
        lgs.createLogs(lgs);
    }
}


package com.conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/*
* Nombre de la clase: Conexion
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Conexion {
    private Connection con;

    public Connection getCon() {
        return con;
    }
    public boolean conectar(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dautedb","root","");
            return true;
        } catch (SQLException | ClassNotFoundException e) {
            JOptionPane.showMessageDialog(null, "Conx error: "+e.getMessage());
            return false;
        }
    }
    public boolean desconectar(){
        try {
            if(con!=null){
                if(con.isClosed()==false)
                    con.close();
            }
            return true;
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Conx error: "+e.getMessage());
            return false;
        }       
    }
}

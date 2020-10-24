
package com.model;

/*
* Nombre de la clase: Logs
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Logs {
    private int id;
    private int user_id;
    private int action_id;
    private String on_field;
    private String date;

    public Logs() {
    }

    public Logs(int id, int user_id, int action_id, String on_field, String date) {
        this.id = id;
        this.user_id = user_id;
        this.action_id = action_id;
        this.on_field = on_field;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getAction_id() {
        return action_id;
    }

    public void setAction_id(int action_id) {
        this.action_id = action_id;
    }

    public String getOn_field() {
        return on_field;
    }

    public void setOn_field(String on_field) {
        this.on_field = on_field;
    }
    
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    public String storeLogs(String user_name, Object myClass,int axnCode){
        String logs="";
        if(axnCode==1){
            
        }
        if(axnCode==2){
            
        }
        if(axnCode==3){
            
        }
        return logs;
    }   
}
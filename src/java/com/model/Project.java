
package com.model;

/*
* Nombre de la clase: Project
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Project {
    private int id;
    private String name;
    private String started_date;
    private String finish_date;
    private String location;
    private int client_id;

    public Project() {
    }

    public Project(int id, String name, String started_date, String finish_date, String location, int client_id) {
        this.id = id;
        this.name = name;
        this.started_date = started_date;
        this.finish_date = finish_date;
        this.location = location;
        this.client_id = client_id;
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

    public String getStarted_date() {
        return started_date;
    }

    public void setStarted_date(String started_date) {
        this.started_date = started_date;
    }

    public String getFinish_date() {
        return finish_date;
    }

    public void setFinish_date(String finish_date) {
        this.finish_date = finish_date;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getClient_id() {
        return client_id;
    }

    public void setClient_id(int client_id) {
        this.client_id = client_id;
    }
}
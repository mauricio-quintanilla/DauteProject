
package com.model;

/*
* Nombre de la clase: Position
* Fecha: 18-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Position {
    private int id;
    private String name;
    private int department_id;

    public Position() {
    }

    public Position(int id, String name, int department_id) {
        this.id = id;
        this.name = name;
        this.department_id = department_id;
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

    public int getDepartment_id() {
        return department_id;
    }

    public void setDepartment_id(int department_id) {
        this.department_id = department_id;
    }
}


package com.model;

/*
* Nombre de la clase: Working
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Working {
    private int id;
    private int project_id;
    private int employee_id;
    private double salary;

    public Working() {
    }

    public Working(int id, int project_id, int employee_id, double salary) {
        this.id = id;
        this.project_id = project_id;
        this.employee_id = employee_id;
        this.salary = salary;
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

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }
}

package com.model;

/*
* Nombre de la clase: InUse
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class InUse {
    private int id;
    private int equipment_id;
    private int project_id;
    private int equipment_quantity;

    public InUse() {
    }

    public InUse(int id, int equipment_id, int project_id, int equipment_quantity) {
        this.id = id;
        this.equipment_id = equipment_id;
        this.project_id = project_id;
        this.equipment_quantity = equipment_quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEquipment_id() {
        return equipment_id;
    }

    public void setEquipment_id(int equipment_id) {
        this.equipment_id = equipment_id;
    }

    public int getProject_id() {
        return project_id;
    }

    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }

    public int getEquipment_quantity() {
        return equipment_quantity;
    }

    public void setEquipment_quantity(int equipment_quantity) {
        this.equipment_quantity = equipment_quantity;
    }
}
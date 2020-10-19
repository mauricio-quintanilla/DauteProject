
package com.model;

/*
* Nombre de la clase: Equipment
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Equipment {
    private int id;
    private String name;
    private String model;
    private String description;
    private String brand;
    private int stock;
    private int inventory;
    private int type;
    private double fuel_rate;
    private String image;

    public Equipment() {
    }

    public Equipment(int id, String name, String model, String description, String brand, int stock, int inventory, int type, double fuel_rate, String image) {
        this.id = id;
        this.name = name;
        this.model = model;
        this.description = description;
        this.brand = brand;
        this.stock = stock;
        this.inventory = inventory;
        this.type = type;
        this.fuel_rate = fuel_rate;
        this.image = image;
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

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getInventory() {
        return inventory;
    }

    public void setInventory(int inventory) {
        this.inventory = inventory;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public double getFuel_rate() {
        return fuel_rate;
    }

    public void setFuel_rate(double fuel_rate) {
        this.fuel_rate = fuel_rate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
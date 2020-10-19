
package com.model;

/*
* Nombre de la clase: Client
* Fecha: 19-10-2020
* CopyRight: OpenSource
* Version: 1.0
* @author Quintanilla Bernabe
*/
public class Client {
    private int id;
    private String name;
    private String email;
    private String phone_number;
    private String nit;
    private String company_name;
    private String company_address;

    public Client() {
    }

    public Client(int id, String name, String email, String phone_number, String nit, String company_name, String company_address) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone_number = phone_number;
        this.nit = nit;
        this.company_name = company_name;
        this.company_address = company_address;
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
}
package com.example.management.Model;

import androidx.annotation.NonNull;

public class DetailStudent {
    private String name;
    private String id;
    private String className;
    private String phone;
    private String info;
    public DetailStudent() {

    }

    public DetailStudent(String name, String id, String className, String phone, String info) {
        this.name = name;
        this.id = id;
        this.className = className;
        this.phone = phone;
        this.info = info;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}

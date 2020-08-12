package org.js.bean;

import java.sql.Timestamp;


public class Category {
    private Long id;
    private String cateName;
    private Long uid;
    private Timestamp date;

    public Category() {
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }
}

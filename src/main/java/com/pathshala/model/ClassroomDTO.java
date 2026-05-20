package com.pathshala.model;

import java.util.List;

public class ClassroomDTO {
    private int id;
    private String className;
    private double price;
    private int totalStudents;
    private List<String> subjects;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getTotalStudents() { return totalStudents; }
    public void setTotalStudents(int totalStudents) { this.totalStudents = totalStudents; }

    public List<String> getSubjects() { return subjects; }
    public void setSubjects(List<String> subjects) { this.subjects = subjects; }
}
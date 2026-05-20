package com.pathshala.model;

public class ClassroomModel {
    private int classId;
    private String className;
    private double price;
    private boolean enrolled;

    public ClassroomModel() {}

    public ClassroomModel(int classId, String className) {
        this.classId = classId;
        this.className = className;
    }

    public ClassroomModel(int classId, String className, double price, boolean enrolled) {
        this.classId = classId;
        this.className = className;
        this.price = price;
        this.enrolled = enrolled;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isEnrolled() {
        return enrolled;
    }

    public void setEnrolled(boolean enrolled) {
        this.enrolled = enrolled;
    }
}
package com.pathshala.model;

public class ClassroomReportDTO {
    private String className;
    private int totalStudents;
    private double totalRevenue;

    public ClassroomReportDTO(String className, int totalStudents, double totalRevenue) {
        this.className = className;
        this.totalStudents = totalStudents;
        this.totalRevenue = totalRevenue;
    }

    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }

    public int getTotalStudents() { return totalStudents; }
    public void setTotalStudents(int totalStudents) { this.totalStudents = totalStudents; }

    public double getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }
}
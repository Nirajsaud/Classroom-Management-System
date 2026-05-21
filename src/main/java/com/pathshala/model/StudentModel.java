package com.pathshala.model;

public class StudentModel extends UserModel {
    private int studentId; // int, not String — matches DB

    // No-arg constructor — needed when building from ResultSet
    public StudentModel() {
        super();
    }

    public StudentModel(String fullName, String email, String phoneNumber, String passwordHash) {
        super(fullName, email, phoneNumber, passwordHash, "student");
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
}
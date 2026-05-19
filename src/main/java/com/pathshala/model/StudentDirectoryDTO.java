package com.pathshala.model;

public class StudentDirectoryDTO {
    private int studentId;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String className;
    private String registeredDate;

    public StudentDirectoryDTO() {}

    public StudentDirectoryDTO(int studentId, String fullName, String email, String phoneNumber, String className, String registeredDate) {
        this.studentId = studentId;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.className = className;
        this.registeredDate = registeredDate;
    }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }

    public String getRegisteredDate() { return registeredDate; }
    public void setRegisteredDate(String registeredDate) { this.registeredDate = registeredDate; }
}
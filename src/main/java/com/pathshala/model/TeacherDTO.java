package com.pathshala.model;

public class TeacherDTO {
    private int teacherId;
    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String subject; // We will use GROUP_CONCAT in SQL to fetch this

    public TeacherDTO(int teacherId, int userId, String fullName, String email, String phone, String subject) {
        this.teacherId = teacherId;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.subject = subject;
    }

    public int getTeacherId() { return teacherId; }
    public int getUserId() { return userId; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getSubject() { return subject; }
}
package com.pathshala.model;

public class StudentModel extends UserModel {
	private String studentId;

	public StudentModel(String fullName, String email, String phoneNumber, String passwordHash) {
		super(fullName, email, phoneNumber, passwordHash, "student");
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

}

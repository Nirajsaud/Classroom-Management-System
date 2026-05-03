package com.pathshala.model;

public class TeacherModel extends UserModel {
	private String teacherId;

	public TeacherModel(int userId, String fullName, String email, String phoneNumber, String passwordHash, String role, String teacherId) {
		super(userId, fullName, email, phoneNumber, passwordHash, role);
		this.teacherId = teacherId;
	}

	public String getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

}

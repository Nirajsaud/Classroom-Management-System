package com.pathshala.model;

public class TeacherModel extends UserModel {
	private String teacherId;

	public TeacherModel(String fullName, String email, String phoneNumber, String passwordHash) {
		super(fullName, email, phoneNumber, passwordHash, "teacher");
	}

	public String getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

}

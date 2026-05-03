package com.pathshala.model;

public class AdminModel extends UserModel {
	private String adminId;

	public AdminModel(int userId, String fullName, String email, String phoneNumber, String passwordHash, String role, String adminId) {
		super(userId, fullName, email, phoneNumber, passwordHash, role);
		this.adminId = adminId;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

}

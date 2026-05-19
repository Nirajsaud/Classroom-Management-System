package com.pathshala.model;

public class AdminModel extends UserModel {
	private String adminId;

	public AdminModel(String fullName, String email, String phoneNumber, String passwordHash) {
		super(fullName, email, phoneNumber, passwordHash, "admin");
		
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

}

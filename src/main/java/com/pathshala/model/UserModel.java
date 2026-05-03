package com.pathshala.model;

public class UserModel {
	private int userId;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String passwordHash;
    private String role;
    private boolean isApproved;
    
    public UserModel() {
		
	}

	public UserModel( String fullName, String email, String phoneNumber, String passwordHash, String role) {
		this.fullName = fullName;
		this.email = email;
		this.phoneNumber=phoneNumber;
		this.passwordHash = passwordHash;
		this.role = role;
		
	}
	
	public int getUserId() {
		return userId;
	}
	
	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public boolean isApproved() {
		return isApproved;
	}
	
	public void setApproved(boolean isApproved) {
		this.isApproved = isApproved;
	}
	

}

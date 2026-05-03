package com.pathshala.service;

import com.pathshala.dao.StudentDAO;
import com.pathshala.utils.PasswordUtil;

public class SignupService {
	StudentDAO stdDAO = new StudentDAO();
	
	public void addStudent(String fullName, String email, String phoneNumber, String passwordHash) {
		passwordHash = PasswordUtil.getHashPassword(passwordHash);
		
		stdDAO.registerStudent(new com.pathshala.model.StudentModel(fullName, email, phoneNumber, passwordHash));
	}
	

}

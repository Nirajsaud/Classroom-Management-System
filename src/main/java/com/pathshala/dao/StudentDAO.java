package com.pathshala.dao;

import com.pathshala.model.StudentModel;
import com.pathshala.utils.DBconfig;
import java.sql.*;

public class StudentDAO {

    public boolean registerStudent(StudentModel student) {
        String userQuery = "INSERT INTO users (full_name, email, phone_number, password_hash, role, is_approved) VALUES (?, ?, ?, ?, 'student', 0)";
        String studentQuery = "INSERT INTO students (user_id) VALUES (?)";
        
        Connection conn = null;
        try {
            conn = DBconfig.getConnection();
            conn.setAutoCommit(false);  //start transaction, allow multiple queries to be executed as a single unit

            // 1. Insert into Users table
            PreparedStatement userSt = conn.prepareStatement(userQuery, Statement.RETURN_GENERATED_KEYS);
            userSt.setString(1, student.getFullName());
            userSt.setString(2, student.getEmail());
            userSt.setString(3, student.getPhoneNumber());
            userSt.setString(4, student.getPasswordHash());
            
            int affectedRows = userSt.executeUpdate();
            
            if (affectedRows == 0) throw new SQLException("User creation failed.");

            // 2. Get the new User ID
            ResultSet generatedKeys = userSt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int newUserId = generatedKeys.getInt(1);
                
                // 3. Insert into Students table
                PreparedStatement studentSt = conn.prepareStatement(studentQuery);
                studentSt.setInt(1, newUserId);
                studentSt.executeUpdate();
                studentSt.close();
            }

            conn.commit(); // SAVE EVERYTHING
            userSt.close();
            conn.close();
            return true;
            
        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        }
    }
}
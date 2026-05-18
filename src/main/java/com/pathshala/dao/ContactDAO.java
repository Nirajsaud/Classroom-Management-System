package com.pathshala.dao;

import com.pathshala.model.ContactModel;
import com.pathshala.utils.DBconfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {

    // Method to save inquiries submitted by visitors
    public boolean saveMessage(ContactModel contact) {
        String query = "INSERT INTO contact_queries (name, email, phone, subject, message) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            
            pst.setString(1, contact.getName());
            pst.setString(2, contact.getEmail());
            pst.setString(3, contact.getPhone());
            pst.setString(4, contact.getSubject());
            pst.setString(5, contact.getMessage());
            
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
            
        
        } catch (SQLException e) {
            e.printStackTrace();
            
            return false;
        }
    }

    // Method for Admin Dashboard to read inquiries
    public List<ContactModel> getAllMessages() {
        List<ContactModel> messages = new ArrayList<>();
        String query = "SELECT * FROM contact_queries ORDER BY created_at DESC";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {
            
            while (rs.next()) {
                ContactModel contact = new ContactModel();
                contact.setId(rs.getInt("id"));
                contact.setName(rs.getString("name"));
                contact.setEmail(rs.getString("email"));
                contact.setPhone(rs.getString("phone"));
                contact.setSubject(rs.getString("subject"));
                contact.setMessage(rs.getString("message"));
                contact.setCreatedAt(rs.getTimestamp("created_at"));
                messages.add(contact);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }
}
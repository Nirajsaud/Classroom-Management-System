package com.pathshala.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.pathshala.utils.DBconfig;

public class DashboardDAO {

    public int getTotalStudents() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM students";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching total student count");
            e.printStackTrace();
        }
        return count;
    }

    public int getTotalTeachers() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM teachers";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching total teacher count");
            e.printStackTrace();
        }
        return count;
    }

    public double getTotalRevenue() {
        double total = 0.0;
        String sql = "SELECT SUM(amount_paid) FROM payments";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching total revenue calculation");
            e.printStackTrace();
        }
        return total;
    }
}
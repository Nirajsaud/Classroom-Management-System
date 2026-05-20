package com.pathshala.dao;

import com.pathshala.utils.DBconfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AdminDAO {
    public static int updateAdmin(int userId, String fullName, String phone) throws SQLException {
        // Adjust column names to match your exact users table
        String query = "UPDATE users SET full_name = ?, phone_number = ? WHERE user_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setInt(3, userId);
            return ps.executeUpdate();
        }
    }
}
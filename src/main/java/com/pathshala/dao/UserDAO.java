package com.pathshala.dao;

import com.pathshala.model.UserModel;
import com.pathshala.model.PendingApprovalDTO;
import com.pathshala.utils.DBconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    /**
     * Fetches a user record by their unique email address to manage authentication workflows.
     */
    public UserModel getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            
            pst.setString(1, email);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    UserModel user = new UserModel();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPasswordHash(rs.getString("password_hash"));
                    user.setRole(rs.getString("role"));
                    user.setApproved(rs.getBoolean("is_approved"));
                    
                    // Removed explicit manual .close() invocations here 
                    // as try-with-resources manages the safe teardown automatically.
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Retrieves all pending registration accounts that require administrator validation.
     * Computes real-time duration details directly through SQL.
     */
    public List<PendingApprovalDTO> getPendingApprovals() {
        List<PendingApprovalDTO> pendingList = new ArrayList<>();
        String sql = "SELECT user_id, full_name, role, " +
                     "TIMESTAMPDIFF(MINUTE, created_at, NOW()) AS minutes_ago " +
                     "FROM users WHERE is_approved = 0 ORDER BY created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                int mins = rs.getInt("minutes_ago");
                String timeString;
                
                if (mins <= 0) {
                    timeString = "Just now";
                } else if (mins < 60) {
                    timeString = mins + " minutes ago";
                } else {
                    int hours = mins / 60;
                    timeString = (hours == 1) ? "1 hour ago" : hours + " hours ago";
                }

                String rawRole = rs.getString("role");
                String formattedRole = (rawRole != null && !rawRole.isEmpty()) 
                    ? rawRole.substring(0, 1).toUpperCase() + rawRole.substring(1).toLowerCase() 
                    : "User";

                pendingList.add(new PendingApprovalDTO(
                    rs.getInt("user_id"),
                    rs.getString("full_name"),
                    formattedRole,
                    timeString
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pendingList;
    }

    /**
     * Activates a pending account enabling authentication across login services.
     */
    /**
     * Activates a pending account and ensures the user profile is safely provisioned 
     * into its corresponding role table (students/teachers/admins) dynamically.
     */
    public boolean approveUser(int userId) {
        String getRoleSql = "SELECT role FROM users WHERE user_id = ?";
        String updateStatusSql = "UPDATE users SET is_approved = 1 WHERE user_id = ?";
        
        try (Connection conn = DBconfig.getConnection()) {
            // Start transaction block
            conn.setAutoCommit(false);
            
            String role = null;
            // Step A: Find out the user's intended role
            try (PreparedStatement psRole = conn.prepareStatement(getRoleSql)) {
                psRole.setInt(1, userId);
                try (ResultSet rs = psRole.executeQuery()) {
                    if (rs.next()) {
                        role = rs.getString("role");
                    }
                }
            }
            
            if (role == null) {
                conn.rollback();
                return false;
            }
            
            // Step B: Update user status to approved
            try (PreparedStatement psUpdate = conn.prepareStatement(updateStatusSql)) {
                psUpdate.setInt(1, userId);
                psUpdate.executeUpdate();
            }
            
            // Step C: Seamlessly bridge role assignments to matching sub-tables
            String checkSubTable = "";
            String insertSubTable = "";
            
            if ("teacher".equalsIgnoreCase(role)) {
                checkSubTable = "SELECT 1 FROM teachers WHERE user_id = ?";
                insertSubTable = "INSERT INTO teachers (user_id) VALUES (?)";
            } else if ("student".equalsIgnoreCase(role)) {
                checkSubTable = "SELECT 1 FROM students WHERE user_id = ?";
                insertSubTable = "INSERT INTO students (user_id) VALUES (?)";
            } else if ("admin".equalsIgnoreCase(role)) {
                checkSubTable = "SELECT 1 FROM admins WHERE user_id = ?";
                insertSubTable = "INSERT INTO admins (user_id) VALUES (?)";
            }
            
            if (!checkSubTable.isEmpty()) {
                boolean alreadyExists = false;
                try (PreparedStatement psCheck = conn.prepareStatement(checkSubTable)) {
                    psCheck.setInt(1, userId);
                    try (ResultSet rs = psCheck.executeQuery()) {
                        if (rs.next()) alreadyExists = true;
                    }
                }
                
                if (!alreadyExists) {
                    try (PreparedStatement psInsert = conn.prepareStatement(insertSubTable)) {
                        psInsert.setInt(1, userId);
                        psInsert.executeUpdate();
                    }
                }
            }
            
            // Commit changes if all operations succeed
            conn.commit();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Rejects and permanently wipes an unapproved registration attempt.
     * Relational tables cascade delete cleanly due to ON DELETE CASCADE constraints.
     */
    public boolean rejectUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ? AND is_approved = 0";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
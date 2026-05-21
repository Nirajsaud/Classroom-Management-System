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
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.setPasswordHash(rs.getString("password_hash"));
                    user.setRole(rs.getString("role"));
                    user.setApproved(rs.getBoolean("is_approved"));
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
     * Activates a pending account and provisions it into the correct role table.
     */
    public boolean approveUser(int userId) {
        String getRoleSql = "SELECT role FROM users WHERE user_id = ?";
        String updateStatusSql = "UPDATE users SET is_approved = 1 WHERE user_id = ?";

        try (Connection conn = DBconfig.getConnection()) {
            conn.setAutoCommit(false);

            String role = null;
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

            try (PreparedStatement psUpdate = conn.prepareStatement(updateStatusSql)) {
                psUpdate.setInt(1, userId);
                psUpdate.executeUpdate();
            }

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
                        if (rs.next()) {
                            alreadyExists = true;
                        }
                    }
                }

                if (!alreadyExists) {
                    try (PreparedStatement psInsert = conn.prepareStatement(insertSubTable)) {
                        psInsert.setInt(1, userId);
                        psInsert.executeUpdate();
                    }
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Rejects and permanently deletes an unapproved registration attempt.
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

    /**
     * Fetches all contact inquiries from contact_queries.
     */
    public List<com.pathshala.model.ContactQueryDTO> getAllContactQueries() {
        List<com.pathshala.model.ContactQueryDTO> list = new ArrayList<>();
        String sql = "SELECT query_id, name, email, phone, subject, message, " +
                     "DATE_FORMAT(created_at, '%Y-%m-%d') as query_date, " +
                     "DATE_FORMAT(created_at, '%h:%i %p') as query_time " +
                     "FROM contact_queries ORDER BY created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                String fullMsg = rs.getString("message");
                String snippet = (fullMsg != null && fullMsg.length() > 45)
                        ? fullMsg.substring(0, 42) + "..."
                        : fullMsg;

                list.add(new com.pathshala.model.ContactQueryDTO(
                        rs.getInt("query_id"),
                        rs.getString("query_date"),
                        rs.getString("query_time"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("subject"),
                        snippet,
                        fullMsg
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Permanently deletes a contact query.
     */
    public boolean deleteContactQuery(int queryId) {
        String sql = "DELETE FROM contact_queries WHERE query_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, queryId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates common user profile fields.
     */
    public boolean updateUserProfile(int userId, String fullName, String phoneNumber) {
        String sql = "UPDATE users SET full_name = ?, phone_number = ? WHERE user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, fullName);
            stmt.setString(2, phoneNumber);
            stmt.setInt(3, userId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}

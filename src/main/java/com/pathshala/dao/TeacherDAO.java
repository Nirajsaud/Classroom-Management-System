package com.pathshala.dao;

import com.pathshala.model.TeacherDTO;
import com.pathshala.utils.DBconfig;
import com.pathshala.utils.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {

    // 1. Fetch all teachers for the directory
    public List<TeacherDTO> getAllTeachers() {
        List<TeacherDTO> list = new ArrayList<>();
        
        // This query joins 5 tables to figure out exactly what subject(s) a teacher is allocated to!
        String sql = "SELECT t.teacher_id, u.user_id, u.full_name, u.email, u.phone_number, " +
                     "COALESCE(GROUP_CONCAT(DISTINCT s.subject_name SEPARATOR ', '), 'Unassigned') as subject_names " +
                     "FROM teachers t " +
                     "JOIN users u ON t.user_id = u.user_id " +
                     "LEFT JOIN teacher_allocations ta ON t.teacher_id = ta.teacher_id " +
                     "LEFT JOIN class_subjects cs ON ta.class_subject_id = cs.class_subject_id " +
                     "LEFT JOIN subjects s ON cs.subject_id = s.subject_id " +
                     "WHERE u.role = 'teacher' " +
                     "GROUP BY t.teacher_id, u.user_id, u.full_name, u.email, u.phone_number";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(new TeacherDTO(
                    rs.getInt("teacher_id"),
                    rs.getInt("user_id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("phone_number"),
                    rs.getString("subject_names")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Add a new teacher (Multi-table transaction)
    public boolean addTeacher(String fullName, String email, String phone, String plainPassword, String subjectName, String[] grades) {
        String insertUser = "INSERT INTO users (full_name, email, phone_number, password_hash, role, is_approved) VALUES (?, ?, ?, ?, 'teacher', 1)";
        String insertTeacher = "INSERT INTO teachers (user_id) VALUES (?)";
        // Query to find the specific ID mapping for a Class + Subject combo
        String findClassSubjectId = "SELECT cs.class_subject_id FROM class_subjects cs " +
                                    "JOIN subjects s ON cs.subject_id = s.subject_id " +
                                    "JOIN class_packages cp ON cs.class_id = cp.class_id " +
                                    "WHERE s.subject_name = ? AND cp.class_name LIKE ?";
        String insertAllocation = "INSERT INTO teacher_allocations (teacher_id, class_subject_id) VALUES (?, ?)";

        Connection conn = null;
        try {
            conn = DBconfig.getConnection();
            conn.setAutoCommit(false); // Start Transaction

            // Step A: Insert into users
            int newUserId = 0;
            try (PreparedStatement psUser = conn.prepareStatement(insertUser, Statement.RETURN_GENERATED_KEYS)) {
                psUser.setString(1, fullName);
                psUser.setString(2, email);
                psUser.setString(3, phone);
                psUser.setString(4, PasswordUtil.getHashPassword(plainPassword)); // Hash it!
                psUser.executeUpdate();
                
                try (ResultSet rs = psUser.getGeneratedKeys()) {
                    if (rs.next()) newUserId = rs.getInt(1);
                }
            }

            if (newUserId == 0) throw new SQLException("User creation failed.");

            // Step B: Insert into teachers
            int newTeacherId = 0;
            try (PreparedStatement psTeacher = conn.prepareStatement(insertTeacher, Statement.RETURN_GENERATED_KEYS)) {
                psTeacher.setInt(1, newUserId);
                psTeacher.executeUpdate();
                
                try (ResultSet rs = psTeacher.getGeneratedKeys()) {
                    if (rs.next()) newTeacherId = rs.getInt(1);
                }
            }

            // Step C: Link them to their classes via allocations
            if (grades != null && grades.length > 0 && subjectName != null && !subjectName.isEmpty()) {
                try (PreparedStatement psFindCS = conn.prepareStatement(findClassSubjectId);
                     PreparedStatement psAlloc = conn.prepareStatement(insertAllocation)) {
                    
                    for (String grade : grades) {
                        psFindCS.setString(1, subjectName);
                        psFindCS.setString(2, "%" + grade + "%"); // e.g., matches "Class 4"
                        
                        try (ResultSet rs = psFindCS.executeQuery()) {
                            if (rs.next()) {
                                int classSubjectId = rs.getInt("class_subject_id");
                                psAlloc.setInt(1, newTeacherId);
                                psAlloc.setInt(2, classSubjectId);
                                psAlloc.addBatch(); // Batch execution is faster
                            }
                        }
                    }
                    psAlloc.executeBatch();
                }
            }

            conn.commit(); // Save everything
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            return false;
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    
 // 3. Fetch a single teacher profile record for editing
    public TeacherDTO getTeacherById(int teacherId) {
        String sql = "SELECT t.teacher_id, u.user_id, u.full_name, u.email, u.phone_number, " +
                     "COALESCE(GROUP_CONCAT(DISTINCT s.subject_name SEPARATOR ', '), '') as subject_name " +
                     "FROM teachers t " +
                     "JOIN users u ON t.user_id = u.user_id " +
                     "LEFT JOIN teacher_allocations ta ON t.teacher_id = ta.teacher_id " +
                     "LEFT JOIN class_subjects cs ON ta.class_subject_id = cs.class_subject_id " +
                     "LEFT JOIN subjects s ON cs.subject_id = s.subject_id " +
                     "WHERE t.teacher_id = ? " +
                     "GROUP BY t.teacher_id, u.user_id, u.full_name, u.email, u.phone_number";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, teacherId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new TeacherDTO(
                        rs.getInt("teacher_id"),
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("subject_name")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. Look up specific active grade sequence strings allocated to a teacher
    public List<String> getAssignedGradesByTeacher(int teacherId) {
        List<String> grades = new ArrayList<>();
        String sql = "SELECT cp.class_name FROM teacher_allocations ta " +
                     "JOIN class_subjects cs ON ta.class_subject_id = cs.class_subject_id " +
                     "JOIN class_packages cp ON cs.class_id = cp.class_id " +
                     "WHERE ta.teacher_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, teacherId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String className = rs.getString("class_name");
                    String digits = className.replaceAll("\\D+", ""); // Pull numbers out e.g. "4"
                    if (!digits.isEmpty()) {
                        grades.add(digits);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }

    // 5. Update teacher details across transactional profiles
    public boolean updateTeacher(int teacherId, int userId, String fullName, String email, String phone, String subjectName, String[] grades) {
        String updateUser = "UPDATE users SET full_name = ?, email = ?, phone_number = ? WHERE user_id = ?";
        String deleteAllocations = "DELETE FROM teacher_allocations WHERE teacher_id = ?";
        String findClassSubjectId = "SELECT cs.class_subject_id FROM class_subjects cs " +
                                    "JOIN subjects s ON cs.subject_id = s.subject_id " +
                                    "JOIN class_packages cp ON cs.class_id = cp.class_id " +
                                    "WHERE s.subject_name = ? AND cp.class_name LIKE ?";
        String insertAllocation = "INSERT INTO teacher_allocations (teacher_id, class_subject_id) VALUES (?, ?)";

        Connection conn = null;
        try {
            conn = DBconfig.getConnection();
            conn.setAutoCommit(false);

            // Step A: Update basic user fields
            try (PreparedStatement psUser = conn.prepareStatement(updateUser)) {
                psUser.setString(1, fullName);
                psUser.setString(2, email);
                psUser.setString(3, phone);
                psUser.setInt(4, userId);
                psUser.executeUpdate();
            }

            // Step B: Flush out old classroom allocations cleanly
            try (PreparedStatement psDel = conn.prepareStatement(deleteAllocations)) {
                psDel.setInt(1, teacherId);
                psDel.executeUpdate();
            }

            // Step C: Link newly assigned classroom rows
            if (grades != null && grades.length > 0 && subjectName != null && !subjectName.isEmpty()) {
                try (PreparedStatement psFindCS = conn.prepareStatement(findClassSubjectId);
                     PreparedStatement psAlloc = conn.prepareStatement(insertAllocation)) {
                    
                    for (String grade : grades) {
                        psFindCS.setString(1, subjectName);
                        psFindCS.setString(2, "%" + grade + "%");
                        
                        try (ResultSet rs = psFindCS.executeQuery()) {
                            if (rs.next()) {
                                int classSubjectId = rs.getInt("class_subject_id");
                                psAlloc.setInt(1, teacherId);
                                psAlloc.setInt(2, classSubjectId);
                                psAlloc.addBatch();
                            }
                        }
                    }
                    psAlloc.executeBatch();
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            return false;
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    
    public static int updateTeacherProfile(int userId, String fullName, String phone) throws SQLException {
        String query = "UPDATE users SET full_name = ?, phone_number = ? WHERE user_id = ? AND role = 'teacher'";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setInt(3, userId);
            
            return ps.executeUpdate();
        }
    }
}
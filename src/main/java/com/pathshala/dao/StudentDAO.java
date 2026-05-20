package com.pathshala.dao;

import com.pathshala.model.StudentModel;
import com.pathshala.model.ClassroomModel;
import com.pathshala.model.StudentDirectoryDTO;
import com.pathshala.utils.DBconfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    public boolean registerStudent(StudentModel student) {
        String userQuery = "INSERT INTO users (full_name, email, phone_number, password_hash, role, is_approved) VALUES (?, ?, ?, ?, 'student', 0)";
        String studentQuery = "INSERT INTO students (user_id) VALUES (?)";
        
        Connection conn = null;
        try {
            conn = DBconfig.getConnection();
            conn.setAutoCommit(false);

            PreparedStatement userSt = conn.prepareStatement(userQuery, Statement.RETURN_GENERATED_KEYS);
            userSt.setString(1, student.getFullName());
            userSt.setString(2, student.getEmail());
            userSt.setString(3, student.getPhoneNumber());
            userSt.setString(4, student.getPasswordHash());
            
            int affectedRows = userSt.executeUpdate();
            if (affectedRows == 0) throw new SQLException("User creation failed.");

            ResultSet generatedKeys = userSt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int newUserId = generatedKeys.getInt(1);
                
                PreparedStatement studentSt = conn.prepareStatement(studentQuery);
                studentSt.setInt(1, newUserId);
                studentSt.executeUpdate();
                studentSt.close();
            }

            conn.commit();
            userSt.close();
            conn.close();
            return true;
            
        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        }
    }

    // Fetch all classes for the Admin dropdown selector
    public List<ClassroomModel> getAllClassrooms() {
        List<ClassroomModel> list = new ArrayList<>();
        String sql = "SELECT class_id, class_name FROM class_packages ORDER BY class_name ASC";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new ClassroomModel(rs.getInt("class_id"), rs.getString("class_name"), false));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Fetch only classrooms explicitly assigned to a specific teacher
    public List<ClassroomModel> getClassroomsByTeacher(int userId) {
        List<ClassroomModel> list = new ArrayList<>();
        String sql = "SELECT DISTINCT cp.class_id, cp.class_name " +
                     "FROM class_packages cp " +
                     "JOIN class_subjects cs ON cp.class_id = cs.class_id " +
                     "JOIN teacher_allocations ta ON cs.class_subject_id = ta.class_subject_id " +
                     "JOIN teachers t ON ta.teacher_id = t.teacher_id " +
                     "WHERE t.user_id = ? ORDER BY cp.class_name ASC";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new ClassroomModel(rs.getInt("class_id"), rs.getString("class_name")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Fetch dynamic directories for Admin (Aggregates multiple class names per student if applicable)
    public List<StudentDirectoryDTO> getStudentsForAdmin(int classId) {
        List<StudentDirectoryDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT s.student_id, u.full_name, u.email, u.phone_number, u.created_at, " +
            "COALESCE(GROUP_CONCAT(cp.class_name SEPARATOR ', '), 'Unassigned') AS enrolled_classes " +
            "FROM students s " +
            "JOIN users u ON s.user_id = u.user_id " +
            "LEFT JOIN enrollments e ON s.student_id = e.student_id " +
            "LEFT JOIN class_packages cp ON e.class_id = cp.class_id "
        );

        if (classId > 0) {
            sql.append("WHERE s.student_id IN (SELECT student_id FROM enrollments WHERE class_id = ?) ");
        }
        sql.append("GROUP BY s.student_id, u.full_name, u.email, u.phone_number, u.created_at ORDER BY u.full_name ASC");

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            if (classId > 0) {
                stmt.setInt(1, classId);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new StudentDirectoryDTO(
                        rs.getInt("student_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("enrolled_classes"),
                        rs.getTimestamp("created_at").toString()
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Fetch dynamic directories scoped to a teacher's allocated class packages
    public List<StudentDirectoryDTO> getStudentsForTeacher(int teacherUserId, int classId) {
        List<StudentDirectoryDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT s.student_id, u.full_name, u.email, u.phone_number, cp.class_name, u.created_at " +
            "FROM students s " +
            "JOIN users u ON s.user_id = u.user_id " +
            "JOIN enrollments e ON s.student_id = e.student_id " +
            "JOIN class_packages cp ON e.class_id = cp.class_id " +
            "WHERE cp.class_id IN ( " +
            "    SELECT DISTINCT cs.class_id FROM teacher_allocations ta " +
            "    JOIN teachers t ON ta.teacher_id = t.teacher_id " +
            "    JOIN class_subjects cs ON ta.class_subject_id = cs.class_subject_id " +
            "    WHERE t.user_id = ? " +
            ") "
        );

        if (classId > 0) {
            sql.append("AND cp.class_id = ? ");
        }
        sql.append("ORDER BY u.full_name ASC");

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            stmt.setInt(1, teacherUserId);
            if (classId > 0) {
                stmt.setInt(2, classId);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new StudentDirectoryDTO(
                        rs.getInt("student_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("class_name"),
                        rs.getTimestamp("created_at").toString()
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Retrieve full information profile for a single student via ID
    public StudentDirectoryDTO getStudentById(int studentId) {
        String sql = "SELECT s.student_id, u.full_name, u.email, u.phone_number, u.created_at, " +
                     "COALESCE(GROUP_CONCAT(cp.class_name SEPARATOR ', '), 'Unassigned') AS enrolled_classes " +
                     "FROM students s " +
                     "JOIN users u ON s.user_id = u.user_id " +
                     "LEFT JOIN enrollments e ON s.student_id = e.student_id " +
                     "LEFT JOIN class_packages cp ON e.class_id = cp.class_id " +
                     "WHERE s.student_id = ? GROUP BY s.student_id, u.full_name, u.email, u.phone_number, u.created_at";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new StudentDirectoryDTO(
                        rs.getInt("student_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("enrolled_classes"),
                        rs.getTimestamp("created_at").toString()
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public int getStudentIdByUserId(int userId) {
        String sql = "SELECT student_id FROM students WHERE user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("student_id");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<ClassroomModel> getClassroomsForStudent(int userId, String keyword, String sort) {
        List<ClassroomModel> list = new ArrayList<>();

        int studentId = getStudentIdByUserId(userId);

        StringBuilder sql = new StringBuilder(
            "SELECT cp.class_id, cp.class_name, cp.price, " +
            "CASE WHEN e.enrollment_id IS NULL THEN 0 ELSE 1 END AS enrolled " +
            "FROM class_packages cp " +
            "LEFT JOIN enrollments e ON cp.class_id = e.class_id AND e.student_id = ? "
        );

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("WHERE cp.class_name LIKE ? ");
        }

        if ("low".equalsIgnoreCase(sort)) {
            sql.append("ORDER BY cp.price ASC");
        } else if ("high".equalsIgnoreCase(sort)) {
            sql.append("ORDER BY cp.price DESC");
        } else {
            sql.append("ORDER BY cp.class_id ASC");
        }

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            stmt.setInt(1, studentId);

            if (keyword != null && !keyword.trim().isEmpty()) {
                stmt.setString(2, "%" + keyword + "%");
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ClassroomModel classroom = new ClassroomModel();
                    classroom.setClassId(rs.getInt("class_id"));
                    classroom.setClassName(rs.getString("class_name"));
                    classroom.setPrice(rs.getDouble("price"));
                    classroom.setEnrolled(rs.getBoolean("enrolled"));
                    list.add(classroom);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
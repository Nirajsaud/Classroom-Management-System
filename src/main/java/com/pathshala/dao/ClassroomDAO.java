package com.pathshala.dao;

import com.pathshala.model.ClassroomDTO;
import com.pathshala.utils.DBconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassroomDAO {

    // 1. Fetch all classrooms for the directory table
    public List<ClassroomDTO> getAllClassroomsWithCounts() {
        List<ClassroomDTO> list = new ArrayList<>();
        String sql = "SELECT cp.class_id, cp.class_name, cp.price, COUNT(e.student_id) as total_students " +
                     "FROM class_packages cp " +
                     "LEFT JOIN enrollments e ON cp.class_id = e.class_id AND e.status = 'active' " +
                     "GROUP BY cp.class_id";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ClassroomDTO dto = new ClassroomDTO();
                dto.setId(rs.getInt("class_id"));
                dto.setClassName(rs.getString("class_name"));
                dto.setPrice(rs.getDouble("price"));
                dto.setTotalStudents(rs.getInt("total_students"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Fetch specific details for the Manage page
    public ClassroomDTO getClassroomDetails(int classId) {
        ClassroomDTO dto = null;
        String sqlClass = "SELECT cp.class_id, cp.class_name, cp.price, COUNT(e.student_id) as total_students " +
                          "FROM class_packages cp " +
                          "LEFT JOIN enrollments e ON cp.class_id = e.class_id AND e.status = 'active' " +
                          "WHERE cp.class_id = ? GROUP BY cp.class_id";
                          
        String sqlSubjects = "SELECT s.subject_name FROM class_subjects cs " +
                             "JOIN subjects s ON cs.subject_id = s.subject_id WHERE cs.class_id = ?";

        try (Connection conn = DBconfig.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(sqlClass)) {
                ps.setInt(1, classId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        dto = new ClassroomDTO();
                        dto.setId(rs.getInt("class_id"));
                        dto.setClassName(rs.getString("class_name"));
                        dto.setPrice(rs.getDouble("price"));
                        dto.setTotalStudents(rs.getInt("total_students"));
                    }
                }
            }

            if (dto != null) {
                List<String> subjects = new ArrayList<>();
                try (PreparedStatement ps = conn.prepareStatement(sqlSubjects)) {
                    ps.setInt(1, classId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            subjects.add(rs.getString("subject_name"));
                        }
                    }
                }
                dto.setSubjects(subjects);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dto;
    }

    // 3. Update the package price
    public boolean updatePrice(int classId, double newPrice) {
        String sql = "UPDATE class_packages SET price = ? WHERE class_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, newPrice);
            ps.setInt(2, classId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 4. Safely add a subject (creates it if it doesn't exist)
    public boolean addSubjectToClass(int classId, String subjectName) {
        Connection conn = null;
        try {
            conn = DBconfig.getConnection();
            conn.setAutoCommit(false);
            
            int subjectId = 0;
            String checkSub = "SELECT subject_id FROM subjects WHERE LOWER(subject_name) = LOWER(?)";
            try (PreparedStatement ps = conn.prepareStatement(checkSub)) {
                ps.setString(1, subjectName);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) subjectId = rs.getInt("subject_id");
                }
            }
            
            if (subjectId == 0) {
                String insertSub = "INSERT INTO subjects (subject_name) VALUES (?)";
                try (PreparedStatement ps = conn.prepareStatement(insertSub, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, subjectName);
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) subjectId = rs.getInt(1);
                    }
                }
            }
            
            boolean exists = false;
            String checkMap = "SELECT 1 FROM class_subjects WHERE class_id = ? AND subject_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(checkMap)) {
                ps.setInt(1, classId);
                ps.setInt(2, subjectId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) exists = true;
                }
            }
            
            if (!exists) {
                String insertMap = "INSERT INTO class_subjects (class_id, subject_id) VALUES (?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(insertMap)) {
                    ps.setInt(1, classId);
                    ps.setInt(2, subjectId);
                    ps.executeUpdate();
                }
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            return false;
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ex) {}
        }
    }

    // 5. Remove a subject mapping
    public boolean removeSubjectFromClass(int classId, String subjectName) {
        String sql = "DELETE cs FROM class_subjects cs " +
                     "JOIN subjects s ON cs.subject_id = s.subject_id " +
                     "WHERE cs.class_id = ? AND s.subject_name = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, classId);
            ps.setString(2, subjectName);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
package com.pathshala.dao;

import com.pathshala.model.NoticeModel;
import com.pathshala.utils.DBconfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.pathshala.model.ClassroomModel;
import com.pathshala.model.MaterialModel;

public class TeacherDAO {

    public int getTeacherIdByUserId(int userId) {
        String sql = "SELECT teacher_id FROM teachers WHERE user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("teacher_id");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getAssignedClassCount(int userId) {
        String sql = "SELECT COUNT(DISTINCT cs.class_id) FROM teacher_allocations ta JOIN teachers t ON ta.teacher_id = t.teacher_id JOIN class_subjects cs ON ta.class_subject_id = cs.class_subject_id WHERE t.user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getStudentCount(int userId) {
        String sql = "SELECT COUNT(DISTINCT e.student_id) FROM enrollments e JOIN class_packages cp ON e.class_id = cp.class_id WHERE cp.class_id IN (SELECT DISTINCT cs.class_id FROM teacher_allocations ta JOIN teachers t ON ta.teacher_id = t.teacher_id JOIN class_subjects cs ON ta.class_subject_id = cs.class_subject_id WHERE t.user_id = ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getMaterialCount(int userId) {
        String sql = "SELECT COUNT(*) FROM materials m JOIN teachers t ON m.teacher_id = t.teacher_id WHERE t.user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<NoticeModel> getTeacherNotifications(int userId) {
        List<NoticeModel> list = new ArrayList<>();

        String sql = "SELECT n.notice_id, n.title, n.content, n.created_at " +
                     "FROM notices n " +
                     "JOIN teachers t ON n.teacher_id = t.teacher_id " +
                     "WHERE t.user_id = ? " +
                     "ORDER BY n.created_at DESC LIMIT 10";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    NoticeModel notice = new NoticeModel();
                    notice.setNoticeId(rs.getInt("notice_id"));
                    notice.setTitle(rs.getString("title"));
                    notice.setContent(rs.getString("content"));
                    notice.setCreatedAt(rs.getString("created_at"));
                    list.add(notice);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<NoticeModel> getRecentTeacherNotices(int userId) {
        return getTeacherNotifications(userId);
    }
    public List<ClassroomModel> getTeacherClasses(int userId) {
        List<ClassroomModel> list = new ArrayList<>();

        String sql = "SELECT DISTINCT cp.class_id, cp.class_name " +
                     "FROM class_packages cp " +
                     "JOIN class_subjects cs ON cp.class_id = cs.class_id " +
                     "JOIN teacher_allocations ta ON cs.class_subject_id = ta.class_subject_id " +
                     "JOIN teachers t ON ta.teacher_id = t.teacher_id " +
                     "WHERE t.user_id = ? " +
                     "ORDER BY cp.class_name ASC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new ClassroomModel(
                        rs.getInt("class_id"),
                        rs.getString("class_name")
                    ));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<MaterialModel> getTeacherMaterials(int userId, int classId) {
        List<MaterialModel> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT m.material_id, m.class_id, m.teacher_id, m.title, m.file_path, m.uploaded_at " +
            "FROM materials m " +
            "JOIN teachers t ON m.teacher_id = t.teacher_id " +
            "WHERE t.user_id = ? "
        );

        if (classId > 0) {
            sql.append("AND m.class_id = ? ");
        }

        sql.append("ORDER BY m.uploaded_at DESC");

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            stmt.setInt(1, userId);

            if (classId > 0) {
                stmt.setInt(2, classId);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    MaterialModel material = new MaterialModel();
                    material.setMaterialId(rs.getInt("material_id"));
                    material.setClassId(rs.getInt("class_id"));
                    material.setTeacherId(rs.getInt("teacher_id"));
                    material.setTitle(rs.getString("title"));
                    material.setFilePath(rs.getString("file_path"));
                    material.setUploadedAt(rs.getString("uploaded_at"));
                    list.add(material);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    public boolean addMaterial(int classId, int teacherId, String title, String filePath) {
        String sql = "INSERT INTO materials (class_id, teacher_id, title, file_path) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, classId);
            stmt.setInt(2, teacherId);
            stmt.setString(3, title);
            stmt.setString(4, filePath);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    public boolean deleteMaterial(int materialId, int userId) {
        String sql = "DELETE m FROM materials m " +
                     "JOIN teachers t ON m.teacher_id = t.teacher_id " +
                     "WHERE m.material_id = ? AND t.user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, materialId);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    public boolean addNotice(int classId, int teacherId, String title, String content) {
        String sql = "INSERT INTO notices (class_id, teacher_id, title, content) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, classId);
            stmt.setInt(2, teacherId);
            stmt.setString(3, title);
            stmt.setString(4, content);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
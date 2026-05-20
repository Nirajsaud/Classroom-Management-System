package com.pathshala.dao;

import com.pathshala.model.TeacherDTO;
import com.pathshala.model.NoticeModel;
import com.pathshala.model.ClassroomModel;
import com.pathshala.model.MaterialModel;
import com.pathshala.utils.DBconfig;
import com.pathshala.utils.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {

    public List<TeacherDTO> getAllTeachers() {
        List<TeacherDTO> list = new ArrayList<>();

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

    public boolean addTeacher(String fullName, String email, String phone, String plainPassword, String subjectName, String[] grades) {
        String insertUser = "INSERT INTO users (full_name, email, phone_number, password_hash, role, is_approved) VALUES (?, ?, ?, ?, 'teacher', 1)";
        String insertTeacher = "INSERT INTO teachers (user_id) VALUES (?)";
        String findClassSubjectId = "SELECT cs.class_subject_id FROM class_subjects cs " +
                                    "JOIN subjects s ON cs.subject_id = s.subject_id " +
                                    "JOIN class_packages cp ON cs.class_id = cp.class_id " +
                                    "WHERE s.subject_name = ? AND cp.class_name LIKE ?";
        String insertAllocation = "INSERT INTO teacher_allocations (teacher_id, class_subject_id) VALUES (?, ?)";

        Connection conn = null;
        try {
            conn = DBconfig.getConnection();
            conn.setAutoCommit(false);

            int newUserId = 0;
            try (PreparedStatement psUser = conn.prepareStatement(insertUser, Statement.RETURN_GENERATED_KEYS)) {
                psUser.setString(1, fullName);
                psUser.setString(2, email);
                psUser.setString(3, phone);
                psUser.setString(4, PasswordUtil.getHashPassword(plainPassword));
                psUser.executeUpdate();

                try (ResultSet rs = psUser.getGeneratedKeys()) {
                    if (rs.next()) newUserId = rs.getInt(1);
                }
            }

            if (newUserId == 0) throw new SQLException("User creation failed.");

            int newTeacherId = 0;
            try (PreparedStatement psTeacher = conn.prepareStatement(insertTeacher, Statement.RETURN_GENERATED_KEYS)) {
                psTeacher.setInt(1, newUserId);
                psTeacher.executeUpdate();

                try (ResultSet rs = psTeacher.getGeneratedKeys()) {
                    if (rs.next()) newTeacherId = rs.getInt(1);
                }
            }

            if (grades != null && grades.length > 0 && subjectName != null && !subjectName.isEmpty()) {
                try (PreparedStatement psFindCS = conn.prepareStatement(findClassSubjectId);
                     PreparedStatement psAlloc = conn.prepareStatement(insertAllocation)) {

                    for (String grade : grades) {
                        psFindCS.setString(1, subjectName);
                        psFindCS.setString(2, "%" + grade + "%");

                        try (ResultSet rs = psFindCS.executeQuery()) {
                            if (rs.next()) {
                                int classSubjectId = rs.getInt("class_subject_id");
                                psAlloc.setInt(1, newTeacherId);
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
                    String digits = className.replaceAll("\\D+", "");
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

            try (PreparedStatement psUser = conn.prepareStatement(updateUser)) {
                psUser.setString(1, fullName);
                psUser.setString(2, email);
                psUser.setString(3, phone);
                psUser.setInt(4, userId);
                psUser.executeUpdate();
            }

            try (PreparedStatement psDel = conn.prepareStatement(deleteAllocations)) {
                psDel.setInt(1, teacherId);
                psDel.executeUpdate();
            }

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
        String sql = "SELECT COUNT(DISTINCT cs.class_id) " +
                     "FROM teacher_allocations ta " +
                     "JOIN teachers t ON ta.teacher_id = t.teacher_id " +
                     "JOIN class_subjects cs ON ta.class_subject_id = cs.class_subject_id " +
                     "WHERE t.user_id = ?";

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
        String sql = "SELECT COUNT(DISTINCT e.student_id) " +
                     "FROM enrollments e " +
                     "JOIN class_packages cp ON e.class_id = cp.class_id " +
                     "WHERE cp.class_id IN ( " +
                     "    SELECT DISTINCT cs.class_id FROM teacher_allocations ta " +
                     "    JOIN teachers t ON ta.teacher_id = t.teacher_id " +
                     "    JOIN class_subjects cs ON ta.class_subject_id = cs.class_subject_id " +
                     "    WHERE t.user_id = ? " +
                     ")";

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

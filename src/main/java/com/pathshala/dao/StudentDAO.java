package com.pathshala.dao;

import com.pathshala.model.StudentModel;
import com.pathshala.model.MaterialModel;
import com.pathshala.model.PaymentModel;
import com.pathshala.model.SubjectModel;
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

    public List<ClassroomModel> getAllClassrooms() {
        List<ClassroomModel> list = new ArrayList<>();
        String sql = "SELECT class_id, class_name FROM class_packages ORDER BY class_name ASC";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new ClassroomModel(rs.getInt("class_id"), rs.getString("class_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

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

    public static int updateStudentProfile(int userId, String fullName, String phone) throws SQLException {
        String query = "UPDATE users SET full_name = ?, phone_number = ? WHERE user_id = ? AND role = 'student'";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setInt(3, userId);

            return ps.executeUpdate();
        }
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

    public ClassroomModel getClassroomById(int classId) {
        String sql = "SELECT class_id, class_name, price FROM class_packages WHERE class_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, classId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ClassroomModel classroom = new ClassroomModel();
                    classroom.setClassId(rs.getInt("class_id"));
                    classroom.setClassName(rs.getString("class_name"));
                    classroom.setPrice(rs.getDouble("price"));
                    return classroom;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int createEnrollmentAndPayment(int userId, int classId, double amountPaid, String paymentMethod) {
        int studentId = getStudentIdByUserId(userId);

        String checkSql = "SELECT enrollment_id FROM enrollments WHERE student_id = ? AND class_id = ?";
        String enrollSql = "INSERT INTO enrollments (student_id, class_id, status) VALUES (?, ?, 'active')";
        String paySql = "INSERT INTO payments (enrollment_id, amount_paid, payment_method) VALUES (?, ?, ?)";

        try (Connection conn = DBconfig.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, studentId);
                checkStmt.setInt(2, classId);

                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        conn.rollback();
                        return rs.getInt("enrollment_id");
                    }
                }
            }

            int enrollmentId = 0;

            try (PreparedStatement enrollStmt = conn.prepareStatement(enrollSql, Statement.RETURN_GENERATED_KEYS)) {
                enrollStmt.setInt(1, studentId);
                enrollStmt.setInt(2, classId);
                enrollStmt.executeUpdate();

                try (ResultSet keys = enrollStmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        enrollmentId = keys.getInt(1);
                    }
                }
            }

            try (PreparedStatement payStmt = conn.prepareStatement(paySql)) {
                payStmt.setInt(1, enrollmentId);
                payStmt.setDouble(2, amountPaid);
                payStmt.setString(3, paymentMethod);
                payStmt.executeUpdate();
            }

            conn.commit();
            return enrollmentId;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<ClassroomModel> getEnrolledClasses(int userId) {
        List<ClassroomModel> list = new ArrayList<>();

        String sql = "SELECT DISTINCT cp.class_id, cp.class_name " +
                     "FROM enrollments e " +
                     "JOIN students s ON e.student_id = s.student_id " +
                     "JOIN class_packages cp ON e.class_id = cp.class_id " +
                     "WHERE s.user_id = ? " +
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

    public List<SubjectModel> getSubjectsByClass(int classId) {
        List<SubjectModel> list = new ArrayList<>();

        String sql = "SELECT s.subject_id, s.subject_name " +
                     "FROM class_subjects cs " +
                     "JOIN subjects s ON cs.subject_id = s.subject_id " +
                     "WHERE cs.class_id = ? " +
                     "ORDER BY s.subject_name ASC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, classId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new SubjectModel(
                            rs.getInt("subject_id"),
                            rs.getString("subject_name")
                    ));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<MaterialModel> getResourcesForStudent(int classId) {
        List<MaterialModel> list = new ArrayList<>();

        String sql = "SELECT material_id, class_id, teacher_id, title, file_path, uploaded_at " +
                     "FROM materials " +
                     "WHERE class_id = ? " +
                     "ORDER BY uploaded_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, classId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    MaterialModel material = new MaterialModel();
                    material.setMaterialId(rs.getInt("material_id"));
                    material.setClassId(rs.getInt("class_id"));
                    material.setTeacherId(rs.getInt("teacher_id"));
                    material.setTitle(rs.getString("title"));
                    material.setFilePath(rs.getString("file_path"));
                    material.setUploadedAt(rs.getTimestamp("uploaded_at").toString());
                    list.add(material);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public double getTotalPaid(int userId) {
        String sql = "SELECT COALESCE(SUM(p.amount_paid), 0) AS total_paid " +
                     "FROM payments p " +
                     "JOIN enrollments e ON p.enrollment_id = e.enrollment_id " +
                     "JOIN students s ON e.student_id = s.student_id " +
                     "WHERE s.user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_paid");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getActiveClassCount(int userId) {
        String sql = "SELECT COUNT(DISTINCT e.class_id) AS active_count " +
                     "FROM enrollments e " +
                     "JOIN students s ON e.student_id = s.student_id " +
                     "WHERE s.user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("active_count");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<PaymentModel> getPaymentHistory(int userId) {
        List<PaymentModel> list = new ArrayList<>();

        String sql = "SELECT cp.class_name, p.amount_paid, p.payment_method, p.payment_date " +
                     "FROM payments p " +
                     "JOIN enrollments e ON p.enrollment_id = e.enrollment_id " +
                     "JOIN students s ON e.student_id = s.student_id " +
                     "JOIN class_packages cp ON e.class_id = cp.class_id " +
                     "WHERE s.user_id = ? " +
                     "ORDER BY p.payment_date DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    PaymentModel payment = new PaymentModel();
                    payment.setClassName(rs.getString("class_name"));
                    payment.setAmountPaid(rs.getDouble("amount_paid"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setPaymentDate(rs.getString("payment_date"));
                    list.add(payment);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}

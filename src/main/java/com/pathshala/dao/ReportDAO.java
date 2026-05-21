package com.pathshala.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.pathshala.model.ClassroomReportDTO;
import com.pathshala.utils.DBconfig;

public class ReportDAO {

    public int getTotalStudents() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM students";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    public int getTotalTeachers() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM teachers";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    public double getTotalRevenue() {
        double total = 0;
        String query = "SELECT COALESCE(SUM(amount_paid), 0) FROM payments";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) total = rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return total;
    }

    public int getEnrollmentCountByStatus(String status) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM enrollments WHERE status = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) count = rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    public List<ClassroomReportDTO> getClassroomReports() {
        List<ClassroomReportDTO> list = new ArrayList<>();
        String query = "SELECT cp.class_name, COUNT(DISTINCT e.student_id) AS total_students, " +
                       "COALESCE(SUM(p.amount_paid), 0) AS total_revenue " +
                       "FROM class_packages cp " +
                       "LEFT JOIN enrollments e ON cp.class_id = e.class_id AND e.status = 'active' " +
                       "LEFT JOIN payments p ON e.enrollment_id = p.enrollment_id " +
                       "GROUP BY cp.class_id, cp.class_name";
                       
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ClassroomReportDTO(
                    rs.getString("class_name"),
                    rs.getInt("total_students"),
                    rs.getDouble("total_revenue")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
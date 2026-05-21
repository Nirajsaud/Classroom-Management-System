package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.pathshala.dao.ReportDAO;
import com.pathshala.model.ClassroomReportDTO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/report" })
public class ReportsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ReportDAO reportDAO = new ReportDAO();

    public ReportsServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        
        // Basic Guard Check
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard?error=unauthorized");
            return;
        }

        String action = request.getParameter("action");

        // --- Handle CSV Download ---
        if ("download".equals(action)) {
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"pathshala_classroom_report.csv\"");
            
            List<ClassroomReportDTO> reports = reportDAO.getClassroomReports();
            
            try (PrintWriter writer = response.getWriter()) {
                // Write CSV Headers
                writer.println("Classroom,Total Active Students,Total Revenue (Rs.)");
                
                // Write Data Rows
                for (ClassroomReportDTO row : reports) {
                    writer.println(row.getClassName() + "," + row.getTotalStudents() + "," + row.getTotalRevenue());
                }
                writer.flush();
            }
            return; // Stop execution so it doesn't forward to the JSP
        }

        // --- Handle Standard Page Load ---
        request.setAttribute("totalStudents", reportDAO.getTotalStudents());
        request.setAttribute("totalTeachers", reportDAO.getTotalTeachers());
        request.setAttribute("totalRevenue", reportDAO.getTotalRevenue());
        request.setAttribute("activeEnrollments", reportDAO.getEnrollmentCountByStatus("active"));
        request.setAttribute("pendingEnrollments", reportDAO.getEnrollmentCountByStatus("pending"));
        request.setAttribute("classroomReports", reportDAO.getClassroomReports());

        request.getRequestDispatcher("WEB-INF/views/admin/Admin_Report.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
package com.pathshala.controller;

import com.pathshala.dao.DashboardDAO;
import com.pathshala.dao.StudentDAO;
import com.pathshala.dao.TeacherDAO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DashboardDAO dashboardDAO;
    private TeacherDAO teacherDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        dashboardDAO = new DashboardDAO();
        teacherDAO = new TeacherDAO();
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = user.getRole().toLowerCase();

        if ("admin".equals(role)) {
            request.setAttribute("totalStudents", dashboardDAO.getTotalStudents());
            request.setAttribute("totalTeachers", dashboardDAO.getTotalTeachers());
            request.setAttribute("totalRevenue", dashboardDAO.getTotalRevenue());
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
            return;
        }

        if ("teacher".equals(role)) {
            request.setAttribute("assignedClassCount", teacherDAO.getAssignedClassCount(user.getUserId()));
            request.setAttribute("studentCount", teacherDAO.getStudentCount(user.getUserId()));
            request.setAttribute("materialCount", teacherDAO.getMaterialCount(user.getUserId()));
            request.setAttribute("noticeList", teacherDAO.getTeacherNotifications(user.getUserId()));
            request.getRequestDispatcher("/WEB-INF/views/teacher/dashboard.jsp").forward(request, response);
            return;
        }

        if ("student".equals(role)) {
        	request.setAttribute("noticeList", studentDAO.getStudentNotices(user.getUserId()));
            request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/login?error=invalid_role");
    }
}
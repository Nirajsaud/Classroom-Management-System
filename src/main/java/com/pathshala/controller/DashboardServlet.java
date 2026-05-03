package com.pathshala.controller;

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the user from your SessionUtil
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Route to the correct JSP based on role
        String role = user.getRole().toLowerCase();
        
        switch (role) {
            case "admin":
                request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
                break;
            case "teacher":
                request.getRequestDispatcher("/WEB-INF/views/teacher/dashboard.jsp").forward(request, response);
                break;
            case "student":
                request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(request, response);
                break;
            default:
                // Fallback if role is messed up in the database
                response.sendRedirect(request.getContextPath() + "/login?error=invalid_role");
        }
    }
}
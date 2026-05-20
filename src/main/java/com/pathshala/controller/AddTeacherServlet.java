package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathshala.dao.TeacherDAO;

@WebServlet("/addteacher")
public class AddTeacherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/Admin_Teacher_Add.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // This will come from our Javascript logic on the frontend
        String assignedClassesRaw = request.getParameter("assignedClasses"); 
        
        if (password != null && password.equals(confirmPassword)) {
            String[] gradesArray = null;
            if (assignedClassesRaw != null && !assignedClassesRaw.isEmpty()) {
                gradesArray = assignedClassesRaw.split(",");
            }

            TeacherDAO teacherDAO = new TeacherDAO();
            boolean success = teacherDAO.addTeacher(fullName, email, phone, password, subject, gradesArray);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/teachers?status=success");
                return;
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/addteacher?status=error");
    }
}
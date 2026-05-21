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

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final String PHONE_REGEX = "^[0-9]{10}$";
    private static final String NAME_REGEX = "^[A-Za-z ]{3,50}$";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/Admin_Teacher_Add.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String assignedClassesRaw = request.getParameter("assignedClasses");

        if (isEmpty(fullName) || isEmpty(email) || isEmpty(subject) || isEmpty(phone)
                || isEmpty(password) || isEmpty(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/addteacher?status=missing");
            return;
        }

        if (!fullName.matches(NAME_REGEX)) {
            response.sendRedirect(request.getContextPath() + "/addteacher?status=invalid_name");
            return;
        }

        if (!email.matches(EMAIL_REGEX)) {
            response.sendRedirect(request.getContextPath() + "/addteacher?status=invalid_email");
            return;
        }

        if (!phone.matches(PHONE_REGEX)) {
            response.sendRedirect(request.getContextPath() + "/addteacher?status=invalid_phone");
            return;
        }

        if (password.length() < 6) {
            response.sendRedirect(request.getContextPath() + "/addteacher?status=weak_password");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/addteacher?status=password_mismatch");
            return;
        }

        if (!isValidSubject(subject)) {
            response.sendRedirect(request.getContextPath() + "/addteacher?status=invalid_subject");
            return;
        }

        String[] gradesArray = null;
        if (!isEmpty(assignedClassesRaw)) {
            gradesArray = assignedClassesRaw.split(",");

            for (String grade : gradesArray) {
                if (!grade.matches("^[4-9]|10$")) {
                    response.sendRedirect(request.getContextPath() + "/addteacher?status=invalid_class");
                    return;
                }
            }
        }

        TeacherDAO teacherDAO = new TeacherDAO();
        boolean success = teacherDAO.addTeacher(fullName.trim(), email.trim(), phone.trim(), password, subject, gradesArray);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/teachers?status=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/addteacher?status=error");
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isValidSubject(String subject) {
        return subject.equals("Nepali") || subject.equals("English")
                || subject.equals("Science") || subject.equals("Math");
    }
}
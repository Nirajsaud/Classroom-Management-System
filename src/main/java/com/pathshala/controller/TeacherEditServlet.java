package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.pathshala.dao.TeacherDAO;
import com.pathshala.model.TeacherDTO;

@WebServlet("/teachers/edit")
public class TeacherEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final String PHONE_REGEX = "^[0-9]{10}$";
    private static final String NAME_REGEX = "^[A-Za-z ]{3,50}$";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (isEmpty(idParam) || !idParam.matches("\\d+")) {
            response.sendRedirect(request.getContextPath() + "/teachers");
            return;
        }

        int teacherId = Integer.parseInt(idParam);
        TeacherDAO teacherDAO = new TeacherDAO();
        TeacherDTO teacher = teacherDAO.getTeacherById(teacherId);

        if (teacher == null) {
            response.sendRedirect(request.getContextPath() + "/teachers");
            return;
        }

        List<String> assignedGrades = teacherDAO.getAssignedGradesByTeacher(teacherId);
        String assignedGradesStr = String.join(",", assignedGrades);

        request.setAttribute("teacher", teacher);
        request.setAttribute("assignedGradesStr", assignedGradesStr);
        request.getRequestDispatcher("/WEB-INF/views/admin/Admin_Teacher_Edit.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String teacherIdParam = request.getParameter("teacherId");
        String userIdParam = request.getParameter("userId");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String phone = request.getParameter("phone");
        String assignedClassesRaw = request.getParameter("assignedClasses");

        if (isEmpty(teacherIdParam) || isEmpty(userIdParam)
                || !teacherIdParam.matches("\\d+") || !userIdParam.matches("\\d+")) {
            response.sendRedirect(request.getContextPath() + "/teachers?status=invalid_id");
            return;
        }

        int teacherId = Integer.parseInt(teacherIdParam);
        int userId = Integer.parseInt(userIdParam);

        if (isEmpty(fullName) || isEmpty(email) || isEmpty(subject) || isEmpty(phone)) {
            response.sendRedirect(request.getContextPath() + "/teachers/edit?id=" + teacherId + "&status=missing");
            return;
        }

        if (!fullName.matches(NAME_REGEX)) {
            response.sendRedirect(request.getContextPath() + "/teachers/edit?id=" + teacherId + "&status=invalid_name");
            return;
        }

        if (!email.matches(EMAIL_REGEX)) {
            response.sendRedirect(request.getContextPath() + "/teachers/edit?id=" + teacherId + "&status=invalid_email");
            return;
        }

        if (!phone.matches(PHONE_REGEX)) {
            response.sendRedirect(request.getContextPath() + "/teachers/edit?id=" + teacherId + "&status=invalid_phone");
            return;
        }

        if (!isValidSubject(subject)) {
            response.sendRedirect(request.getContextPath() + "/teachers/edit?id=" + teacherId + "&status=invalid_subject");
            return;
        }

        String[] gradesArray = null;
        if (!isEmpty(assignedClassesRaw)) {
            gradesArray = assignedClassesRaw.split(",");

            for (String grade : gradesArray) {
                if (!grade.matches("^[4-9]|10$")) {
                    response.sendRedirect(request.getContextPath() + "/teachers/edit?id=" + teacherId + "&status=invalid_class");
                    return;
                }
            }
        }

        TeacherDAO teacherDAO = new TeacherDAO();
        boolean success = teacherDAO.updateTeacher(
                teacherId,
                userId,
                fullName.trim(),
                email.trim(),
                phone.trim(),
                subject,
                gradesArray
        );

        if (success) {
            response.sendRedirect(request.getContextPath() + "/teachers?status=updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/teachers/edit?id=" + teacherId + "&status=error");
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
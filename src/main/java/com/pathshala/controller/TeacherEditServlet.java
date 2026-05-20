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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String phone = request.getParameter("phone");
        String assignedClassesRaw = request.getParameter("assignedClasses");

        String[] gradesArray = null;
        if (assignedClassesRaw != null && !assignedClassesRaw.isEmpty()) {
            gradesArray = assignedClassesRaw.split(",");
        }

        TeacherDAO teacherDAO = new TeacherDAO();
        boolean success = teacherDAO.updateTeacher(teacherId, userId, fullName, email, phone, subject, gradesArray);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/teachers?status=updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/teachers/edit?id=" + teacherId + "&status=error");
        }
    }
}
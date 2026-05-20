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

@WebServlet("/teachers")
public class TeachersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TeacherDAO teacherDAO = new TeacherDAO();
        List<TeacherDTO> teachers = teacherDAO.getAllTeachers();
        
        request.setAttribute("teachers", teachers);
        request.setAttribute("totalTeachers", teachers.size());
        
        request.getRequestDispatcher("WEB-INF/views/admin/Admin_Teacher.jsp").forward(request, response);
    }
}
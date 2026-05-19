package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathshala.dao.StudentDAO;
import com.pathshala.model.StudentDirectoryDTO;

@WebServlet("/students/view")
public class StudentViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        this.studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/students?error=missing_id");
            return;
        }

        try {
            int studentId = Integer.parseInt(idParam);
            StudentDirectoryDTO student = studentDAO.getStudentById(studentId);
            
            if (student == null) {
                response.sendRedirect(request.getContextPath() + "/students?error=not_found");
                return;
            }

            // Split the comma-separated classes back into an array for rendering
            String[] classroomArr = student.getClassName().split(", ");

            request.setAttribute("studentDetail", student);
            request.setAttribute("classroomArr", classroomArr);

            request.getRequestDispatcher("/WEB-INF/views/admin/Admin_Student_View.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/students?error=invalid_id");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
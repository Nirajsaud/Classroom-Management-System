package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.pathshala.dao.StudentDAO;
import com.pathshala.model.ClassroomModel;
import com.pathshala.model.StudentDirectoryDTO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

@WebServlet("/students")
public class StudentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        this.studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        String role = user.getRole().toUpperCase();

        // Parse class filters if supplied
        int classId = 0;
        String classParam = request.getParameter("classId");
        if (classParam != null && !classParam.trim().isEmpty()) {
            try {
                classId = Integer.parseInt(classParam);
            } catch (NumberFormatException e) {
                classId = 0;
            }
        }
        request.setAttribute("selectedClassId", classId);

        // Process data based on role context
        if ("ADMIN".equals(role)) {
            List<ClassroomModel> allClassrooms = studentDAO.getAllClassrooms();
            List<StudentDirectoryDTO> studentList = studentDAO.getStudentsForAdmin(classId);
            List<StudentDirectoryDTO> baseTotalCount = studentDAO.getStudentsForAdmin(0);

            request.setAttribute("classList", allClassrooms);
            request.setAttribute("studentList", studentList);
            request.setAttribute("totalStudents", baseTotalCount.size());

            request.getRequestDispatcher("/WEB-INF/views/admin/Admin_Students.jsp").forward(request, response);

        } else if ("TEACHER".equals(role)) {
            List<ClassroomModel> teacherClasses = studentDAO.getClassroomsByTeacher(user.getUserId());
            List<StudentDirectoryDTO> studentList = studentDAO.getStudentsForTeacher(user.getUserId(), classId);
            List<StudentDirectoryDTO> baseTotalCount = studentDAO.getStudentsForTeacher(user.getUserId(), 0);

            request.setAttribute("teacherClasses", teacherClasses);
            request.setAttribute("studentList", studentList);
            request.setAttribute("totalStudents", baseTotalCount.size());

            request.getRequestDispatcher("/WEB-INF/views/teacher/teacherStudents.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
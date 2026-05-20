package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.pathshala.dao.ClassroomDAO;
import com.pathshala.model.ClassroomDTO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/classrooms" })
public class ClassroomsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ClassroomDAO classroomDAO = new ClassroomDAO();

    public ClassroomsServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = user.getRole().toLowerCase();
        
        switch (role) {
            case "admin":
                List<ClassroomDTO> classrooms = classroomDAO.getAllClassroomsWithCounts();
                request.setAttribute("classrooms", classrooms);
                request.getRequestDispatcher("WEB-INF/views/admin/Admin_Classroom.jsp").forward(request, response);
                break;
            case "teacher":
                request.getRequestDispatcher("WEB-INF/views/teacher/teacherClassroom.jsp").forward(request, response);
                break;
            case "student":
                request.getRequestDispatcher("WEB-INF/views/student/studentClassroom.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/login?error=invalid_role");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
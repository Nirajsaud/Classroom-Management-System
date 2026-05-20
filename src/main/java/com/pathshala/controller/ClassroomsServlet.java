package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.pathshala.dao.ClassroomDAO;
import com.pathshala.dao.StudentDAO;
import com.pathshala.dao.TeacherDAO;
import com.pathshala.model.ClassroomDTO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/classrooms" })
public class ClassroomsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ClassroomDAO classroomDAO = new ClassroomDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
                int classId = 0;
                String classParam = request.getParameter("classId");

                if (classParam != null && !classParam.trim().isEmpty()) {
                    try {
                        classId = Integer.parseInt(classParam);
                    } catch (NumberFormatException e) {
                        classId = 0;
                    }
                }

                TeacherDAO teacherDAO = new TeacherDAO();

                request.setAttribute("teacherClasses", teacherDAO.getTeacherClasses(user.getUserId()));
                request.setAttribute("studyResources", teacherDAO.getTeacherMaterials(user.getUserId(), classId));
                request.setAttribute("selectedClassId", classId);
                request.setAttribute("noticeList", teacherDAO.getTeacherNotifications(user.getUserId()));

                request.getRequestDispatcher("WEB-INF/views/teacher/teacherClassroom.jsp").forward(request, response);
                break;

            case "student":
                String keyword = request.getParameter("keyword");
                String sort = request.getParameter("sort");

                if (sort == null || sort.trim().isEmpty()) {
                    sort = "default";
                }

                StudentDAO studentDAO = new StudentDAO();

                request.setAttribute("classroomList", studentDAO.getClassroomsForStudent(user.getUserId(), keyword, sort));
                request.setAttribute("keyword", keyword);
                request.setAttribute("sort", sort);

                request.getRequestDispatcher("WEB-INF/views/student/studentClassroom.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/login?error=invalid_role");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathshala.dao.ClassroomDAO;
import com.pathshala.model.ClassroomDTO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

@WebServlet("/classrooms/manage")
public class ClassroomManageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ClassroomDAO classroomDAO = new ClassroomDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String classIdStr = request.getParameter("classId");
        if (classIdStr == null || classIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/classrooms");
            return;
        }

        int classId = Integer.parseInt(classIdStr);
        ClassroomDTO classroom = classroomDAO.getClassroomDetails(classId);

        if (classroom == null) {
            response.sendRedirect(request.getContextPath() + "/classrooms");
            return;
        }

        request.setAttribute("classroom", classroom);
        request.setAttribute("className", classroom.getClassName());
        request.setAttribute("totalStudents", classroom.getTotalStudents());
        request.setAttribute("price", classroom.getPrice());
        request.setAttribute("subjects", classroom.getSubjects());

        request.getRequestDispatcher("/WEB-INF/views/admin/Admin_Classroom_Manage.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        String classIdStr = request.getParameter("classId");

        if (classIdStr != null && !classIdStr.isEmpty()) {
            int classId = Integer.parseInt(classIdStr);

            if ("updatePrice".equals(action)) {
                double newPrice = Double.parseDouble(request.getParameter("newPrice"));
                classroomDAO.updatePrice(classId, newPrice);
            } else if ("addSubject".equals(action)) {
                String subjectName = request.getParameter("subjectName");
                if (subjectName != null && !subjectName.trim().isEmpty()) {
                    classroomDAO.addSubjectToClass(classId, subjectName.trim());
                }
            } else if ("deleteSubject".equals(action)) {
                String subjectName = request.getParameter("subjectName");
                if (subjectName != null && !subjectName.trim().isEmpty()) {
                    classroomDAO.removeSubjectFromClass(classId, subjectName.trim());
                }
            }
            // PRG Pattern: Redirect back to GET so user doesn't accidentally re-submit the form
            response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId);
        } else {
            response.sendRedirect(request.getContextPath() + "/classrooms");
        }
    }
}
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

    private static final String SUBJECT_REGEX = "^[A-Za-z ]{2,50}$";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String classIdStr = request.getParameter("classId");

        if (isEmpty(classIdStr) || !classIdStr.matches("\\d+")) {
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        String classIdStr = request.getParameter("classId");

        if (isEmpty(classIdStr) || !classIdStr.matches("\\d+")) {
            response.sendRedirect(request.getContextPath() + "/classrooms");
            return;
        }

        int classId = Integer.parseInt(classIdStr);

        if (isEmpty(action)) {
            response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=missing_action");
            return;
        }

        if ("updatePrice".equals(action)) {
            String newPriceStr = request.getParameter("newPrice");

            if (isEmpty(newPriceStr)) {
                response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=missing_price");
                return;
            }

            double newPrice;

            try {
                newPrice = Double.parseDouble(newPriceStr);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=invalid_price");
                return;
            }

            if (newPrice < 0) {
                response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=negative_price");
                return;
            }

            classroomDAO.updatePrice(classId, newPrice);
            response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=price_updated");
            return;
        }

        if ("addSubject".equals(action)) {
            String subjectName = request.getParameter("subjectName");

            if (isEmpty(subjectName)) {
                response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=missing_subject");
                return;
            }

            subjectName = subjectName.trim();

            if (!subjectName.matches(SUBJECT_REGEX)) {
                response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=invalid_subject");
                return;
            }

            classroomDAO.addSubjectToClass(classId, subjectName);
            response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=subject_added");
            return;
        }

        if ("deleteSubject".equals(action)) {
            String subjectName = request.getParameter("subjectName");

            if (isEmpty(subjectName)) {
                response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=missing_subject");
                return;
            }

            subjectName = subjectName.trim();

            if (!subjectName.matches(SUBJECT_REGEX)) {
                response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=invalid_subject");
                return;
            }

            classroomDAO.removeSubjectFromClass(classId, subjectName);
            response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=subject_deleted");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/classrooms/manage?classId=" + classId + "&status=invalid_action");
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
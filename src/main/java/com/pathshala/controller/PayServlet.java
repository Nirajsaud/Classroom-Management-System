package com.pathshala.controller;

import com.pathshala.dao.StudentDAO;
import com.pathshala.model.ClassroomModel;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/pay")
public class PayServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null || !"student".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int classId = Integer.parseInt(request.getParameter("classId"));
        ClassroomModel selectedClass = studentDAO.getClassroomById(classId);

        if (selectedClass == null) {
            response.sendRedirect(request.getContextPath() + "/classrooms");
            return;
        }

        request.setAttribute("selectedClass", selectedClass);
        request.setAttribute("currentDate", LocalDate.now().toString());

        request.getRequestDispatcher("/WEB-INF/views/student/payment.jsp").forward(request, response);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

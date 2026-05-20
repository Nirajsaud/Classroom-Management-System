package com.pathshala.controller;

import com.pathshala.dao.TeacherDAO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/delete-material")
public class DeleteMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TeacherDAO teacherDAO;

    @Override
    public void init() throws ServletException {
        teacherDAO = new TeacherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/classrooms");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null || !"teacher".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int materialId = Integer.parseInt(request.getParameter("materialId"));

        teacherDAO.deleteMaterial(materialId, user.getUserId());

        response.sendRedirect(request.getContextPath() + "/classrooms");
    }
}
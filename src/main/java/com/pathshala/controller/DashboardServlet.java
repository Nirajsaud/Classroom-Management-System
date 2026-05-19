package com.pathshala.controller;

import com.pathshala.dao.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DashboardDAO dashboardDAO;

    @Override
    public void init() throws ServletException {
        this.dashboardDAO = new DashboardDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Fetch active dynamic management statistics from your DAO layer
        int totalStudents = dashboardDAO.getTotalStudents();
        int totalTeachers = dashboardDAO.getTotalTeachers();
        double totalRevenue = dashboardDAO.getTotalRevenue();
        
        // Bind calculated metrics variables safely to the request scope
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("totalTeachers", totalTeachers);
        request.setAttribute("totalRevenue", totalRevenue);
        
        // Route control over to the Admin layout view
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.pathshala.dao.UserDAO;
import com.pathshala.model.PendingApprovalDTO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

@WebServlet("/approvals")
public class ApprovalsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO(); // Added DAO reference

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        
        // Guard check for admin access
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard?error=unauthorized");
            return;
        }

        // Fetch live database records dynamically right here
        List<PendingApprovalDTO> pendingApprovals = userDAO.getPendingApprovals();
        
        // Pass objects explicitly onto the request context for the JSP
        request.setAttribute("pendingApprovals", pendingApprovals);
        request.setAttribute("pendingCount", pendingApprovals.size());

        // Forward to the view layer
        request.getRequestDispatcher("/WEB-INF/views/admin/Admin_Approvals.jsp").forward(request, response);
    }
}
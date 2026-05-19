package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathshala.dao.UserDAO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

@WebServlet("/admin/approval")
public class UserApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Guard check: Ensure only an authenticated ADMIN can perform actions
        UserModel currentUser = (UserModel) SessionUtil.getAttribute(request, "user");
        if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized action.");
            return;
        }

        // 2. Extract form parameters from the JSP
        String userIdStr = request.getParameter("userId");
        String action = request.getParameter("action");

        if (userIdStr == null || action == null) {
            response.sendRedirect(request.getContextPath() + "/approvals?msg=invalid_params");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            boolean success = false;

            // 3. Dispatch execution to the DAO based on button action
            if ("approve".equalsIgnoreCase(action)) {
                success = userDAO.approveUser(userId);
            } else if ("reject".equalsIgnoreCase(action)) {
                success = userDAO.rejectUser(userId);
            }

            // 4. Redirect back to the approvals view with status query strings
            if (success) {
                response.sendRedirect(request.getContextPath() + "/approvals?status=success&action=" + action);
            } else {
                response.sendRedirect(request.getContextPath() + "/approvals?status=failed");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/approvals?status=error");
        }
    }
}
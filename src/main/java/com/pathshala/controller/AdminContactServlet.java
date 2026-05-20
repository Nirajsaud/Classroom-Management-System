package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.pathshala.dao.UserDAO;
import com.pathshala.model.ContactQueryDTO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

@WebServlet("/admincontact")
public class AdminContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Safety Guard: Verify structural authorization roles
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard?error=unauthorized");
            return;
        }

        // Extract submissions list directly through database layer
        List<ContactQueryDTO> submissions = userDAO.getAllContactQueries();
        
        // Inject data back into the request stream under the handle targeting your JSP
        request.setAttribute("submissions", submissions);
        
        // Forward back out to the presentation layer view
        request.getRequestDispatcher("WEB-INF/views/admin/Admin_Contact.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        String idStr = request.getParameter("queryId");

        if ("delete".equalsIgnoreCase(action) && idStr != null) {
            try {
                int queryId = Integer.parseInt(idStr);
                userDAO.deleteContactQuery(queryId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // Clean Post-Redirect-Get pattern to avoid duplication popups
        response.sendRedirect(request.getContextPath() + "/admincontact");
    }
}
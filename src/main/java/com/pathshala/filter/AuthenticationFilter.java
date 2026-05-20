package com.pathshala.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.pathshala.model.UserModel;
import com.pathshala.model.PendingApprovalDTO;
import com.pathshala.dao.UserDAO;
import com.pathshala.utils.SessionUtil;

@WebFilter(urlPatterns = {
    "/dashboard", "/profile", "/teachers", 
    "/students", "/students/view", "/classrooms", 
    "/report", "/admincontact", "/approvals"
})
public class AuthenticationFilter extends HttpFilter {
       
    private static final long serialVersionUID = 1L;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 1. Enforce Authentication
        UserModel user = (UserModel) SessionUtil.getAttribute(httpRequest, "user");
        boolean isLoggedIn = (user != null);

        if (!isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=please_login");
            return;
        }

        // Prevent browser back-button caching for secure sessions
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);

        String currentURI = httpRequest.getRequestURI();
        String role = user.getRole().toUpperCase();

        // 2. Centralized Real-time Admin Notifications Injection
        if ("ADMIN".equals(role)) {
            UserDAO userDAO = new UserDAO();
            List<PendingApprovalDTO> pendingApprovals = userDAO.getPendingApprovals();
            httpRequest.setAttribute("pendingApprovals", pendingApprovals);
            httpRequest.setAttribute("pendingCount", pendingApprovals.size());
        }

        // 3. Handle Shared Route Routing (/dashboard)
        if (currentURI.contains("/dashboard")) {
            switch (role) {
                case "ADMIN":
                    chain.doFilter(request, response);
                    break;
                case "TEACHER":
                    httpRequest.getRequestDispatcher("/WEB-INF/views/teacher/dashboard.jsp").forward(request, response);
                    break;
                case "STUDENT":
                    httpRequest.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(request, response);
                    break;
                default:
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=invalid_role");
            }
            return;
        }
        
        // NOTE: The /profile routing block was removed from here. 
        // It will safely pass through to the ProfileServlet below.

        // 4. Centralized Authorization Guard Rules
        if (currentURI.contains("/teachers") || currentURI.contains("/report") || 
            currentURI.contains("/admincontact") || currentURI.contains("/addteacher") || 
            currentURI.contains("/students/view") || currentURI.contains("/approvals")) {
            
            if (!role.equals("ADMIN")) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        }

        if (currentURI.contains("/students")) {
            if (role.equals("STUDENT")) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        }

        // Allowed to proceed to requested resource servlet paths (like ProfileServlet)
        chain.doFilter(request, response);
    }
}
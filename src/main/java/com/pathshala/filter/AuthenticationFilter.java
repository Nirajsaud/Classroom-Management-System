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
import java.util.Arrays;
import java.util.List;

import com.pathshala.dao.UserDAO;
import com.pathshala.model.PendingApprovalDTO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

@WebFilter(urlPatterns = {
        "/dashboard",
        "/profile",

        "/classrooms",
        "/classrooms/manage",
        "/subjects",
        "/payment",

        "/teachers",
        "/teachers/edit",
        "/addteacher",

        "/students",
        "/students/view",

        "/report",
        "/approvals",
        "/admincontact"
})
public class AuthenticationFilter extends HttpFilter {

    private static final long serialVersionUID = 1L;

    private static final List<String> STUDENT_ALLOWED = Arrays.asList(
            "/dashboard",
            "/classrooms",
            "/subjects",
            "/payment",
            "/profile"
    );

    private static final List<String> TEACHER_ALLOWED = Arrays.asList(
            "/dashboard",
            "/classrooms",
            "/students",
            "/profile"
    );

    private static final List<String> ADMIN_ALLOWED = Arrays.asList(
            "/dashboard",
            "/teachers",
            "/teachers/edit",
            "/addteacher",
            "/students",
            "/students/view",
            "/classrooms",
            "/classrooms/manage",
            "/report",
            "/profile",
            "/approvals",
            "/admincontact"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        UserModel user = (UserModel) SessionUtil.getAttribute(httpRequest, "user");

        if (user == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=please_login");
            return;
        }

        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        String role = user.getRole().toUpperCase();

        boolean allowed = false;

        switch (role) {
            case "STUDENT":
                allowed = STUDENT_ALLOWED.contains(path);
                break;

            case "TEACHER":
                allowed = TEACHER_ALLOWED.contains(path);
                break;

            case "ADMIN":
                allowed = ADMIN_ALLOWED.contains(path);

                if (allowed) {
                    UserDAO userDAO = new UserDAO();
                    List<PendingApprovalDTO> pendingApprovals = userDAO.getPendingApprovals();
                    httpRequest.setAttribute("pendingApprovals", pendingApprovals);
                    httpRequest.setAttribute("pendingCount", pendingApprovals.size());
                }
                break;

            default:
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=invalid_role");
                return;
        }

        if (!allowed) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        chain.doFilter(request, response);
    }
}
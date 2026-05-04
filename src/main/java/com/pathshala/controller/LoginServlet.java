package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.pathshala.model.UserModel;
import com.pathshala.service.LoginService;
import com.pathshala.utils.CookieUtil;
import com.pathshala.utils.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        LoginService loginService = new LoginService();
        
        // Ensure this matches the string returned by your service (usually all caps "SUCCESS")
        String status = loginService.authenticate(email, password);
        
        System.out.println("DEBUG LOGIN STATUS: " + status);
        
        if ("SUCCESS".equalsIgnoreCase(status)) {
            try {
                UserModel user = loginService.getUserDetails(email);
                
                // Store user in session
                SessionUtil.setAttribute(request, "user", user, 3600);
                
                // Cookie for last login
                String loginTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd_HH:mm:ss"));
                CookieUtil.addCookie(response, "last_login", loginTime, 3600);
                
                // Point everyone to the same URL; the Filter/Servlet will handle the rest
                response.sendRedirect(request.getContextPath() + "/dashboard");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/login?error=server_error");
            }
        } else {
            request.setAttribute("error", status);
            request.setAttribute("typedUser", email); 
            // Fixed path to be consistent with doGet
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
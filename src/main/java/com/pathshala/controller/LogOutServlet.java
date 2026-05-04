
package com.pathshala.controller;

import java.io.IOException;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; 
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pathshala.utils.SessionUtil;

/**
 * Servlet implementation class LogOutServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/logout-user" })
public class LogOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LogOutServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Used SessionUtil to invalidate session
        SessionUtil.invalidateSession(request);

        // Redirect the user to the login page
        response.sendRedirect(request.getContextPath() + "/login");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
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

import com.pathshala.utils.SessionUtil;

/**
 * Prevents logged-in users from seeing login/register pages.
 */
@WebFilter(urlPatterns = {"/login", "/signup", "/"})
public class GuestFilter extends HttpFilter {
    
    private static final long serialVersionUID = 1L;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Check if the session attribute "user" exists
        boolean isLoggedIn = SessionUtil.getAttribute(httpRequest, "user") != null;

        if (isLoggedIn) {
            // Logged-in users shouldn't see signup/login; send them to dashboard
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/dashboard");
        } else {
            // Guests are free to visit these pages
            chain.doFilter(request, response);
        }
    }
}
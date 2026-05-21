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

@WebFilter(urlPatterns = {
        "/",
        "/home",
        "/about",
        "/contact",
        "/login",
        "/signup"
})
public class GuestFilter extends HttpFilter {

    private static final long serialVersionUID = 1L;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        boolean isLoggedIn = SessionUtil.getAttribute(httpRequest, "user") != null;

        if (isLoggedIn && (path.equals("/login") || path.equals("/signup") || path.equals("/"))) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }
}
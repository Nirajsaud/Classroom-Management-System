package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

/**
 * Servlet implementation class StudentsServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/students" })
public class StudentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		// 1. Get the user from your SessionUtil
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Route to the correct JSP based on role
        String role = user.getRole().toLowerCase();
        
        switch (role) {
            case "admin":
                request.getRequestDispatcher("/WEB-INF/views/admin/Admin_Students.jsp").forward(request, response);
                break;
            case "teacher":
                request.getRequestDispatcher("/WEB-INF/views/teacher/dashboard.jsp").forward(request, response);
                break;
            default:
                // Fallback if role is messed up in the database
                response.sendRedirect(request.getContextPath() + "/login?error=invalid_role");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

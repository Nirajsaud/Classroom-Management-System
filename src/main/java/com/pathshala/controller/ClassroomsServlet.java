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
 * Servlet implementation class ClassroomsServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/classrooms" })
public class ClassroomsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClassroomsServlet() {
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
            	request.getRequestDispatcher("WEB-INF/views/admin/Admin_Classroom.jsp").forward(request, response);
                break;
            case "teacher":
                int classId = 0;
                String classParam = request.getParameter("classId");

                if (classParam != null && !classParam.trim().isEmpty()) {
                    try {
                        classId = Integer.parseInt(classParam);
                    } catch (NumberFormatException e) {
                        classId = 0;
                    }
                }

                com.pathshala.dao.TeacherDAO teacherDAO = new com.pathshala.dao.TeacherDAO();

                request.setAttribute("teacherClasses", teacherDAO.getTeacherClasses(user.getUserId()));
                request.setAttribute("studyResources", teacherDAO.getTeacherMaterials(user.getUserId(), classId));
                request.setAttribute("selectedClassId", classId);
                request.setAttribute("noticeList", teacherDAO.getTeacherNotifications(user.getUserId()));

                request.getRequestDispatcher("WEB-INF/views/teacher/teacherClassroom.jsp").forward(request, response);
                break;
            case "student":
                String keyword = request.getParameter("keyword");
                String sort = request.getParameter("sort");

                if (sort == null || sort.trim().isEmpty()) {
                    sort = "default";
                }

                com.pathshala.dao.StudentDAO studentDAO = new com.pathshala.dao.StudentDAO();

                request.setAttribute("classroomList", studentDAO.getClassroomsForStudent(user.getUserId(), keyword, sort));
                request.setAttribute("keyword", keyword);
                request.setAttribute("sort", sort);
                

                request.getRequestDispatcher("WEB-INF/views/student/studentClassroom.jsp").forward(request, response);
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

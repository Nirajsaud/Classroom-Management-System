package com.pathshala.controller;

import com.pathshala.dao.TeacherDAO;
import com.pathshala.dao.UserDAO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.FileUploadUtil;
import com.pathshala.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/profile" })
@MultipartConfig
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;
    private TeacherDAO teacherDAO;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
        super();
    }

    /**
     * Initializes DAO objects once when the servlet loads.
     */
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        teacherDAO = new TeacherDAO();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     *
     * Loads the profile page based on the logged-in user's role.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = user.getRole().toLowerCase();

        switch (role) {
            case "admin":
                request.getRequestDispatcher("/WEB-INF/views/admin/Admin_Profile.jsp").forward(request, response);
                break;

            case "teacher":
                request.setAttribute("noticeList", teacherDAO.getTeacherNotifications(user.getUserId()));
                request.getRequestDispatcher("/WEB-INF/views/teacher/teacherProfile.jsp").forward(request, response);
                break;

            case "student":
                request.getRequestDispatcher("/WEB-INF/views/student/studentProfile.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/login?error=invalid_role");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     *
     * Updates profile details and saves profile image if uploaded.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");

        boolean updated = userDAO.updateUserProfile(user.getUserId(), fullName, phoneNumber);

        Part imagePart = request.getPart("profileImage");

        if (imagePart != null && imagePart.getSize() > 0) {
            if (FileUploadUtil.isImage(imagePart)) {
                String extension = FileUploadUtil.getFileExtension(imagePart.getSubmittedFileName());
                String fileName = user.getEmail() + extension;
                String uploadPath = getServletContext().getRealPath("/profile-images");

                FileUploadUtil.saveFile(imagePart, uploadPath, fileName);
            }
        }

        if (updated) {
            user.setFullName(fullName);
            user.setPhoneNumber(phoneNumber);
            SessionUtil.setAttribute(request, "user", user, 30 * 60);
        }

        response.sendRedirect(request.getContextPath() + "/profile?success=updated");
    }
}
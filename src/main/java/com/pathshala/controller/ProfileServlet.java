package com.pathshala.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;

import com.pathshala.model.UserModel;
import com.pathshala.dao.AdminDAO;
import com.pathshala.dao.StudentDAO;
import com.pathshala.dao.TeacherDAO;
import com.pathshala.utils.FileUploadUtil;
import com.pathshala.utils.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/profile" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10)
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Permanent uploads folder that survives server resets and workspace cleans
    private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "pathshala_uploads";

    // --- GET: Display the correct profile page based on role ---
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                request.getRequestDispatcher("/WEB-INF/views/teacher/teacherProfile.jsp").forward(request, response);
                break;
            case "student":
                request.getRequestDispatcher("/WEB-INF/views/student/studentProfile.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/login?error=invalid_role");
        }
    }

    // --- POST: Handle profile updates dynamically based on role ---
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = user.getRole().toLowerCase();
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");

        try {
            int rowsUpdated = 0;

            // 1. Database Update specific to the role
            switch (role) {
                case "admin":
                    rowsUpdated = AdminDAO.updateAdmin(user.getUserId(), fullName, phoneNumber);
                    break;
                case "teacher":
                    rowsUpdated = TeacherDAO.updateTeacherProfile(user.getUserId(), fullName, phoneNumber);
                    break;
                case "student":
                    rowsUpdated = StudentDAO.updateStudentProfile(user.getUserId(), fullName, phoneNumber);
                    break;
            }

            // 2. Update core session data if DB was successful
            if (rowsUpdated > 0) {
                user.setFullName(fullName);
                user.setPhoneNumber(phoneNumber);
                SessionUtil.setAttribute(request, "user", user, 3600);
            }

            // 3. Handle File Upload (Universal for all roles)
            Part filePart = request.getPart("profilePhoto"); 
            if (filePart != null && filePart.getSize() > 0 && FileUploadUtil.isImage(filePart)) {
                String extension = FileUploadUtil.getFileExtension(filePart.getSubmittedFileName());
                
                // Bind the image on-disk directly to the unique user's email so ImageServlet can find it easily
                String fileName = user.getEmail() + extension; 
                
                FileUploadUtil.saveFile(filePart, UPLOAD_DIR, fileName);
                
                // Note: We no longer store the path in the Session. 
                // The ImageServlet handles fetching the image perfectly without relying on volatile sessions!
            }

            SessionUtil.setAttribute(request, "message", "Profile updated successfully!", 60);
        } catch (Exception e) {
            e.printStackTrace();
            SessionUtil.setAttribute(request, "error", "Update failed: " + e.getMessage(), 60);
        }
        
        // Redirect back to the universal GET handler
        response.sendRedirect(request.getContextPath() + "/profile");
    }
}
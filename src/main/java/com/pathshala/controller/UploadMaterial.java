package com.pathshala.controller;

import com.pathshala.dao.TeacherDAO;
import com.pathshala.model.UserModel;
import com.pathshala.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/upload-material")
@MultipartConfig
public class UploadMaterial extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TeacherDAO teacherDAO;

    @Override
    public void init() throws ServletException {
        teacherDAO = new TeacherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/classrooms");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null || !"teacher".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int classId = Integer.parseInt(request.getParameter("classId"));
        String title = request.getParameter("title");

        int teacherId = teacherDAO.getTeacherIdByUserId(user.getUserId());

        Part filePart = request.getPart("materialFile");
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

        File uploadFolder = new File(uploadPath);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        String savedFileName = System.currentTimeMillis() + "_" + originalFileName;
        String fullFilePath = uploadPath + File.separator + savedFileName;

        filePart.write(fullFilePath);

        String dbFilePath = "uploads/" + savedFileName;

        boolean uploaded = teacherDAO.addMaterial(classId, teacherId, title, dbFilePath);

        if (uploaded) {
            response.sendRedirect(request.getContextPath() + "/classrooms?classId=" + classId + "&success=uploaded");
        } else {
            response.sendRedirect(request.getContextPath() + "/classrooms?classId=" + classId + "&error=upload_failed");
        }
        
    }
    
}
